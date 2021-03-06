USE [AAD]
GO

/****** Object:  StoredProcedure [dbo].[usp_ww_disp_transaction_log_NDN]    Script Date: 6/13/2014 12:32:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[usp_ww_disp_transaction_log_history_NDN]
	@in_item_number		NVARCHAR(30)
	,@in_location_id	NVARCHAR(50)
	,@in_hu_id			NVARCHAR(22)
	,@in_order_number	NVARCHAR(30)
	,@in_employee		NVARCHAR(30)
	,@in_po_number		NVARCHAR(30)
	,@in_receiver		NVARCHAR(30)
	,@in_tran_type		NVARCHAR(3)
	,@in_use_date		NVARCHAR(1)
	,@in_start_date		DATETIME
	,@in_end_date		DATETIME

AS
/*********************************************************************************************
RNK Created 06/13/214

Displays the Transactions Log History  WW Report


*********************************************************************************************/

SET NOCOUNT ON

IF OBJECT_ID('tempdb..#tran_temp') IS NOT NULL
BEGIN
	DROP TABLE #tran_temp
END

CREATE TABLE #tran_temp
	(rank_num			INT
	,tran_log_id		INT
	,item_number		NVARCHAR(30)
	,uom_prompt			NVARCHAR(20)
	--,conversion_factor	FLOAT
	,tran_qty			FLOAT
	,location_id		NVARCHAR(50)
	,hu_id				NVARCHAR(22)
	,start_datetime		DATETIME
	,end_datetime		DATETIME
	,src_location_id	NVARCHAR(50)
	,dest_location_id	NVARCHAR(50)
	,employee_name		NVARCHAR(30)
	,tran_description	NVARCHAR(50)
	,control_number		NVARCHAR(30)	--receiver_id	
	,control_number_2	NVARCHAR(30)	--po_number
	,order_number		NVARCHAR(30)
	,item_description	NVARCHAR(60)
	,tran_type			NVARCHAR(3)
	)

INSERT INTO #tran_temp
	(rank_num
	,tran_log_id		--INT
	,item_number		--NVARCHAR(30)
	,uom_prompt			--NVARCHAR(20)
	--,conversion_factor	--FLOAT
	,tran_qty			--FLOAT
	,location_id		--NVARCHAR(50)
	,hu_id				--NVARCHAR(22)
	,start_datetime		--NVARCHAR(22)
	,end_datetime		--NVARCHAR(22)
	,src_location_id	--NVARCHAR(50)
	,dest_location_id	--NVARCHAR(50)
	,employee_name		--NVARCHAR(30)
	,tran_description	--NVARCHAR(50)
	,control_number		--NVARCHAR(30)	
	,control_number_2	--NVARCHAR(30)
	,order_number
	,item_description	--NVARCHAR(60)
	,tran_type			--NVARCHAR(3)
	)
SELECT TOP 1000
	RANK() OVER (PARTITION BY itu.item_number, itu.wh_id, itu.pattern ORDER BY itu.conversion_factor DESC) as rank_num
	,trn.tran_log_id
	,trn.item_number
	,itu.uom_prompt
	--,itu.conversion_factor
	,trn.tran_qty / itu.conversion_factor				-- MAMT 02.11.2014: MAKE QTY IN THE UOM OF THE UOM_PROMPT
	,ISNULL(trn.location_id_2,trn.location_id) --If dest loc is not p[opulated, default to src loc
	,trn.hu_id
	,CONVERT(NVARCHAR(10),trn.start_tran_date,110) + ' ' + CONVERT(NVARCHAR(12),trn.start_tran_time,114) AS start_datetime
	,CONVERT(NVARCHAR(10),trn.end_tran_date,110) + ' ' + CONVERT(NVARCHAR(12),trn.end_tran_time,114) AS end_datetime
	,trn.location_id AS src_location_id
	,trn.location_id_2 AS dest_location_id
	,emp.name AS employee_name
	--,trn.employee_id AS employee_name
	,trn.description AS tran_description
	,trn.control_number			--receiver_id
	,trn.control_number_2		--po_number
	,trn.order_number_NDN
	,itm.description AS item_description
	,trn.tran_type				--tran type
FROM t_tran_log_history trn WITH(NOLOCK)
LEFT OUTER JOIN t_item_master itm WITH(NOLOCK)
	ON trn.wh_id = itm.wh_id
	AND trn.item_number = itm.item_number
LEFT OUTER JOIN t_employee emp WITH(NOLOCK)
	ON trn.employee_id = emp.id
	--AND trn.wh_id = emp.wh_id --Commented out because wh_id is not a PK for t_employee
LEFT OUTER JOIN t_item_uom itu WITH (NOLOCK)
	ON trn.item_number = itu.item_number
	AND trn.wh_id = itu.wh_id
	AND trn.uom_pattern_NDN = itu.pattern
	AND itu.status = 'ACTIVE'
WHERE ISNULL(trn.item_number,'') LIKE @in_item_number
AND (ISNULL(trn.location_id,'') LIKE @in_location_id
     OR ISNULL(trn.location_id_2, '') LIKE @in_location_id)
AND ISNULL(trn.hu_id,'') LIKE @in_hu_id
AND ISNULL(trn.order_number_NDN,'') LIKE @in_order_number
AND ISNULL(trn.control_number_2,'') LIKE @in_po_number 
AND (UPPER(ISNULL(trn.employee_id,'')) LIKE UPPER(@in_employee)
	OR UPPER(ISNULL(emp.name,'')) LIKE UPPER(@in_employee))
AND ISNULL(trn.control_number,'') LIKE @in_receiver
AND ISNULL(trn.tran_type,'') LIKE @in_tran_type
AND CONVERT(NVARCHAR(10),trn.start_tran_date,110) >= CASE WHEN @in_use_date = 'Y'
														  THEN CONVERT(NVARCHAR(10),@in_start_date,110)
														  ELSE CONVERT(NVARCHAR(10),trn.start_tran_date,110)
														  END
AND CONVERT(NVARCHAR(10),trn.end_tran_date,110) <= CASE WHEN @in_use_date = 'Y'
														  THEN CONVERT(NVARCHAR(10),@in_end_date,110)
														  ELSE CONVERT(NVARCHAR(10),trn.end_tran_date,110)
														  END
ORDER BY 
	tran_log_id DESC

SELECT
	--rank_num,
	tran_log_id		--INT
	,item_number		--NVARCHAR(30)
	,uom_prompt			--NVARCHAR(20)
	--,conversion_factor	--FLOAT
	,tran_qty			--FLOAT
	,location_id		--NVARCHAR(50)
	,hu_id				--NVARCHAR(22)
	,start_datetime		--NVARCHAR(22)
	,end_datetime		--NVARCHAR(22)
	,src_location_id
	,dest_location_id	--NVARCHAR(50)
	,employee_name		--NVARCHAR(30)
	,tran_description	--NVARCHAR(50)
	,control_number		--NVARCHAR(30)	
	,control_number_2	--NVARCHAR(30)
	,order_number
	,item_description	--NVARCHAR(60)
	,tran_type			--NVARCHAR(3)
FROM #tran_temp
WHERE rank_num = 1
ORDER BY 
	tran_log_id DESC



IF OBJECT_ID('tempdb..#tran_temp') IS NOT NULL
BEGIN
	DROP TABLE #tran_temp
END


GO

