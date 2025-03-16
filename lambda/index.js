exports.handler = async (event) => {
  console.log("Evento recebido:", JSON.stringify(event));

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: "Olá do Node.js 18 na Lambda!",
      event: event,
    }),
  };

  return response;
};