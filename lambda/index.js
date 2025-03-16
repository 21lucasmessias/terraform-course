exports.handler = async (event) => {
  console.log("Evento recebido:", JSON.stringify(event));

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: "Teste 2",
      event: event,
    }),
  };

  return response;
};