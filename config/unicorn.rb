#サーバ上でのアプリケーションコードが設置されているディレクトリを変数に入れておく
app_path = File.expand_path('../../', __FILE__)

#アプリケーションサーバの性能を決定する
# workerとはプロセスを分離させて働きをもつもの(リクエストに対応するレスポンスを高速にする)
# worker_processes= リクエストを受け付けレスポンスを生成するworker(ワーカー)の数を決めます。
worker_processes 1

#アプリケーションの設置されているディレクトリを指定
# working_directory= UnicornがRailsのコードを動かす際、ルーティングなど実際に参照するファイルを探すディレクトリを指定します。
working_directory app_path

#Unicornの起動に必要なファイルの設置場所を指定
# Unicornは、起動する際にプロセスidが書かれたファイルを生成します。その場所を指定します。
pid "#{app_path}/tmp/pids/unicorn.pid"

#ポート番号を指定
# どのポート番号のリクエストを受け付けることにするかを決定します。今回は、3000番ポートを指定しています。
listen "#{app_path}/tmp/sockets/unicorn.sock"

#エラーのログを記録するファイルを指定
stderr_path "#{app_path}/log/unicorn.stderr.log"

#通常のログを記録するファイルを指定
stdout_path "#{app_path}/log/unicorn.stdout.log"

#Railsアプリケーションの応答を待つ上限時間を設定
timeout 60

#以下は応用的な設定なので説明は割愛

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
