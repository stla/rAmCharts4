export const toDate = function(string) {
  let ymd = string.split("-");
  return new Date(ymd[0], ymd[1]-1, ymd[2]);
};
