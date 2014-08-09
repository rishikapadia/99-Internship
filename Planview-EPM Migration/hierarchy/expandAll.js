function exp(i) {
  var q = i;
  try {
    for (q = i; i < 1000; i++) {
      top.Expand(i);
    }
  } catch (err) {
    exp(q+1);
  }
}
exp(0);

