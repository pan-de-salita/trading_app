document.addEventListener("DOMContentLoaded", function () {
  const priceField = document.querySelector("#transaction_share_price");
  const qtyField = document.querySelector("#transaction_share_qty");
  const totalField = document.querySelector("#transaction_amount");

  qtyField.addEventListener("input", function () {
    console.log(priceField.value);
    // Assuming the discount is calculated as 10% of the price
    const Value = (priceField.value * qtyField.value).toFixed(2);
    totalField.value = Value;
  });
});
