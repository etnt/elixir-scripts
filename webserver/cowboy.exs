Mix.install([:plug, :plug_cowboy])

defmodule MyPlug do
  import Plug.Conn

  def init(options) do
    # initialize options
    options
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world")
  end
end

require Logger
webserver = {Plug.Cowboy, plug: MyPlug, scheme: :http, options: [port: 4000]}
{:ok, _} = Supervisor.start_link([webserver], strategy: :one_for_one)
Logger.info("Plug now running on localhost:4000")
Process.sleep(:infinity)
