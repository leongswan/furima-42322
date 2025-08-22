const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const pkTag = document.querySelector('meta[name="payjp-public-key"]');
  const publicKey = pkTag && pkTag.content;
  if (!publicKey || !window.Payjp) return;

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  const expElement = elements.create('cardExpiry');
  expElement.mount('#expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const { id, error } = await payjp.createToken(numberElement);
    if (error) {
      alert(error.message);
      return;
    }
    const tokenField = document.getElementById('token');
    if (tokenField) tokenField.value = id;
    form.submit();
  });
};

window.addEventListener('turbo:load', pay);
window.addEventListener('turbo:render', pay);