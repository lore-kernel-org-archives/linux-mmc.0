From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Shutdown regression due to mmc workqueue/locking changes
Date: Wed, 30 Oct 2013 15:05:32 -0600
Message-ID: <5271749C.2000206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

When I run "shutdown -h now" in next-20131030, I get a hung task.

git bisect shows that the first problem that shows up is due to 35a8fca
"mmc: sdhci: Turn tuning timeout timer into delayed work", which yields
the following crash immediately that poweroff happens:

> [  76.314514] BUG: scheduling while atomic: halt/1367/0x00000002
> [  76.320614] Modules linked in:
> [  76.323802] CPU: 2 PID: 1367 Comm: halt Not tainted 3.12.0-rc2-00141-g35a8fca #147
> [  76.331682] [<c00158f0>] (unwind_backtrace+0x0/0xf8) from [<c00117a8>] (show_stack+0x10/0x14)
> [  76.340501] [<c00117a8>] (show_stack+0x10/0x14) from [<c053a6a4>] (dump_stack+0x80/0xc4)
> [  76.348860] [<c053a6a4>] (dump_stack+0x80/0xc4) from [<c0539034>] (__schedule_bug+0x48/0x60)
> [  76.357559] [<c0539034>] (__schedule_bug+0x48/0x60) from [<c053eb8c>] (__schedule+0x64c/0x6d0)
> [  76.366404] [<c053eb8c>] (__schedule+0x64c/0x6d0) from [<c053bb54>] (schedule_timeout+0x174/0x1ec)
> [  76.375552] [<c053bb54>] (schedule_timeout+0x174/0x1ec) from [<c053e2d8>] (wait_for_common+0xb8/0x14c)
> [  76.385074] [<c053e2d8>] (wait_for_common+0xb8/0x14c) from [<c0037ed4>] (__flush_work+0xa4/0x12c)
> [  76.394078] [<c0037ed4>] (__flush_work+0xa4/0x12c) from [<c038677c>] (sdhci_do_set_ios+0x90/0x6fc)
> [  76.403220] [<c038677c>] (sdhci_do_set_ios+0x90/0x6fc) from [<c0386e08>] (sdhci_set_ios+0x20/0x2c)
> [  76.412380] [<c0386e08>] (sdhci_set_ios+0x20/0x2c) from [<c0374610>] (mmc_power_off+0x70/0x90)
> [  76.421212] [<c0374610>] (mmc_power_off+0x70/0x90) from [<c03763a0>] (_mmc_suspend+0xb4/0x274)
> [  76.430037] [<c03763a0>] (_mmc_suspend+0xb4/0x274) from [<c0375450>] (mmc_bus_shutdown+0x40/0x68)
> [  76.439129] [<c0375450>] (mmc_bus_shutdown+0x40/0x68) from [<c029f324>] (device_shutdown+0x34/0x188)
> [  76.448478] [<c029f324>] (device_shutdown+0x34/0x188) from [<c0044fcc>] (kernel_power_off+0x2c/0x70)
> [  76.457814] [<c0044fcc>] (kernel_power_off+0x2c/0x70) from [<c00452b8>] (SyS_reboot+0x108/0x1d4)
> [  76.466812] [<c00452b8>] (SyS_reboot+0x108/0x1d4) from [<c000e5e0>] (ret_fast_syscall+0x0/0x30) 

A few commits later, 769303b "mmc: sdhci: Turn host->lock into a mutex"
changes this to a hang, followed by a hung task being detected:

> [ 240.870402] INFO: task kworker/1:1:70 blocked for more than 120 seconds.
> [ 240.877203]      Not tainted 3.12.0-rc7-next-20131030 #133
> [ 240.882886] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 240.890824] kworker/1:1    D c0554ec0    0   70     2 0x00000000
> [ 240.897345] Workqueue: events sdhci_tuning_timeout_work
> [ 240.902734] [<c0554ec0>] (__schedule+0x300/0x674) from [<c0555614>] (schedule_preempt_disabled+0x24/0x34)
> [ 240.912461] [<c0555614>] (schedule_preempt_disabled+0x24/0x34) from [<c0554034>] (__mutex_lock_slowpath+0x17c/0x374)
> [ 240.923146] [<c0554034>] (__mutex_lock_slowpath+0x17c/0x374) from [<c0554238>] (mutex_lock+0xc/0x24)
> [ 240.932430] [<c0554238>] (mutex_lock+0xc/0x24) from [<c0393614>] (sdhci_tuning_timeout_work+0x14/0x2c)
> [ 240.941890] [<c0393614>] (sdhci_tuning_timeout_work+0x14/0x2c) from [<c00398b4>] (process_one_work+0xfc/0x34c)
> [ 240.952033] [<c00398b4>] (process_one_work+0xfc/0x34c) from [<c0039b28>] (process_scheduled_works+0x24/0x34)
> [ 240.961998] [<c0039b28>] (process_scheduled_works+0x24/0x34) from [<c0039ff4>] (worker_thread+0x228/0x384)
> [ 240.971787] [<c0039ff4>] (worker_thread+0x228/0x384) from [<c003f748>] (kthread+0xc4/0xe0)
> [ 240.980160] [<c003f748>] (kthread+0xc4/0xe0) from [<c000e6f8>] (ret_from_fork+0x14/0x3c)
> [ 240.988366] INFO: task halt:1272 blocked for more than 120 seconds.
> [ 240.994724]      Not tainted 3.12.0-rc7-next-20131030 #133
> [ 241.000373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 241.008273] halt           D c0554ec0    0 1272  1270 0x00000000
> [ 241.014820] [<c0554ec0>] (__schedule+0x300/0x674) from [<c05521e4>] (schedule_timeout+0x174/0x1ec)
> [ 241.023919] [<c05521e4>] (schedule_timeout+0x174/0x1ec) from [<c0554958>] (wait_for_common+0xb8/0x14c)
> [ 241.033359] [<c0554958>] (wait_for_common+0xb8/0x14c) from [<c003839c>] (__flush_work+0xa4/0x12c)
> [ 241.042362] [<c003839c>] (__flush_work+0xa4/0x12c) from [<c0396c4c>] (sdhci_do_set_ios+0x8c/0x6e8)
> [ 241.051448] [<c0396c4c>] (sdhci_do_set_ios+0x8c/0x6e8) from [<c03972c8>] (sdhci_set_ios+0x20/0x2c)
> [ 241.060553] [<c03972c8>] (sdhci_set_ios+0x20/0x2c) from [<c03846c0>] (mmc_power_off+0x5c/0x7c)
> [ 241.069275] [<c03846c0>] (mmc_power_off+0x5c/0x7c) from [<c0386634>] (_mmc_suspend+0x194/0x2a0)
> [ 241.078110] [<c0386634>] (_mmc_suspend+0x194/0x2a0) from [<c03855e8>] (mmc_bus_shutdown+0x40/0x68)
> [ 241.087339] [<c03855e8>] (mmc_bus_shutdown+0x40/0x68) from [<c02acd38>] (device_shutdown+0x34/0x188)
> [ 241.096627] [<c02acd38>] (device_shutdown+0x34/0x188) from [<c0044e94>] (kernel_power_off+0x2c/0x70)
> [ 241.105893] [<c0044e94>] (kernel_power_off+0x2c/0x70) from [<c0045180>] (SyS_reboot+0x108/0x1d4)
> [ 241.114814] [<c0045180>] (SyS_reboot+0x108/0x1d4) from [<c000e660>] (ret_fast_syscall+0x0/0x30)

This is on the Tegra114 Dalmore board, which is an ARM system. Looking
at the backtraces, I'd guess that all Tegra devices are affected, but
haven't tested that. I haven't looked at the commits to see if there's
anything obviously wrong, but perhaps you can suggest something to try?
