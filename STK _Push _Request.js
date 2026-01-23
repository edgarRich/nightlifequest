await axios.post(
  'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
  {
    BusinessShortCode,
    Password,
    Timestamp,
    TransactionType: 'CustomerPayBillOnline',
    Amount,
    PartyA: phone,
    PartyB: BusinessShortCode,
    PhoneNumber: phone,
    CallBackURL,
    AccountReference: 'NightlifeQuest',
    TransactionDesc: 'Subscription Payment'
  },
  { headers: { Authorization: `Bearer ${token}` } }
);
