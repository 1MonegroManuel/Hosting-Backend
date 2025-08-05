var builder = WebApplication.CreateBuilder(args);

builder.WebHost.UseUrls("http://localhost:5090");

builder.Services.AddControllers();

builder.Services.AddCors(options =>
{
    options.AddPolicy("PermitirTodo", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

app.UseCors("PermitirTodo");

app.MapControllers();

app.Run();
