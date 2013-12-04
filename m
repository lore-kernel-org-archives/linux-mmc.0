From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Avoid HARDIRQ-unsafe lock
Date: Tue, 3 Dec 2013 18:26:39 -0800
Message-ID: <CACUGKYMBxs4CRWzh00SNXU-kKau3R2CQLE1WN5Z=eru54OkiSA@mail.gmail.com>
References: <1385599648-3044-1-git-send-email-festevam@gmail.com>
	<CACUGKYN98KFtHPQXAxSFCkB9qB6xdcKC9FMrSw84wuSX3Od5xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53454 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab3LDC0k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2013 21:26:40 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so15513863obb.31
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2013 18:26:39 -0800 (PST)
In-Reply-To: <CACUGKYN98KFtHPQXAxSFCkB9qB6xdcKC9FMrSw84wuSX3Od5xw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Markus.Niebel@tqs.de, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

Let me correct myself. The patches is working correctly.

Regards,

John

On Wed, Nov 27, 2013 at 6:26 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Fabio,
>
> I was using linux-3.13-rc1, applied the said patch and I am still
> getting the said errors on iMX6SL eval board.
>
> Regards,
>
> john
>
> On Wed, Nov 27, 2013 at 4:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Remove the locking inside sdhci_do_set_ios() to avoid the following warning:
>>
>> ======================================================
>> [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
>> fec 2188000.ethernet eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_)
>> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> 3.12.0-next-20131112+ #446 Not tainted
>> ------------------------------------------------------
>> kworker/u8:1/29 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>>  (prepare_lock){+.+.+.}, at: [<80476cdc>] clk_prepare_lock+0x78/0xec
>>
>> and this task is already holding:
>>  (&(&host->lock)->rlock#2){-.-...}, at: [<80457e5c>] sdhci_do_set_ios+0x20/0x708
>> which would create a new lock dependency:
>>  (&(&host->lock)->rlock#2){-.-...} -> (prepare_lock){+.+.+.}
>>
>> but this new dependency connects a HARDIRQ-irq-safe lock:
>>  (&(&host->lock)->rlock#2){-.-...}
>> ... which became HARDIRQ-irq-safe at:
>>   [<8005e3e4>] mark_lock+0x140/0x6a8
>>   [<8005f410>] __lock_acquire+0xac4/0x1c1c
>>   [<80060a34>] lock_acquire+0x68/0x7c
>>   [<8060a988>] _raw_spin_lock+0x30/0x40
>>   [<80456e00>] sdhci_irq+0x24/0xa10
>>   [<8006a204>] handle_irq_event_percpu+0x54/0x1a4
>>   [<8006a398>] handle_irq_event+0x44/0x64
>>   [<8006d4c0>] handle_fasteoi_irq+0xa0/0x160
>>   [<80069b78>] generic_handle_irq+0x28/0x38
>>   [<8000f358>] handle_IRQ+0x54/0xb8
>>   [<80008640>] gic_handle_irq+0x30/0x64
>>   [<800130a4>] __irq_svc+0x44/0x5c
>>   [<806026e0>] printk+0x38/0x40
>>   [<80458e24>] sdhci_add_host+0x844/0xbd0
>>   [<8045ab48>] sdhci_esdhc_imx_probe+0x31c/0x5dc
>>   [<80325dc4>] platform_drv_probe+0x20/0x50
>>   [<803247b4>] driver_probe_device+0x118/0x234
>>   [<8032496c>] __driver_attach+0x9c/0xa0
>>   [<80322d78>] bus_for_each_dev+0x5c/0x90
>>   [<803242b0>] driver_attach+0x20/0x28
>>   [<80323eac>] bus_add_driver+0xdc/0x1dc
>>   [<80325024>] driver_register+0x80/0xfc
>>   [<80325ce4>] __platform_driver_register+0x50/0x64
>>   [<8083a6b0>] sdhci_esdhc_imx_driver_init+0x18/0x20
>>   [<80008974>] do_one_initcall+0xfc/0x160
>>   [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>   [<805ff7e0>] kernel_init+0x10/0x120
>>   [<8000eae8>] ret_from_fork+0x14/0x2c
>>
>> to a HARDIRQ-irq-unsafe lock:
>>  (prepare_lock){+.+.+.}
>> ... which became HARDIRQ-irq-unsafe at:
>> ...  [<8005e3e4>] mark_lock+0x140/0x6a8
>>   [<800611f0>] mark_held_locks+0x64/0x130
>>   [<8006136c>] trace_hardirqs_on_caller+0xb0/0x1cc
>>   [<8006149c>] trace_hardirqs_on+0x14/0x18
>>   [<806078f8>] mutex_trylock+0x178/0x200
>>   [<80476c78>] clk_prepare_lock+0x14/0xec
>>   [<80477818>] clk_notifier_register+0x28/0xf4
>>   [<8001537c>] twd_clk_init+0x50/0x68
>>   [<80008974>] do_one_initcall+0xfc/0x160
>>   [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>   [<805ff7e0>] kernel_init+0x10/0x120
>>   [<8000eae8>] ret_from_fork+0x14/0x2c
>>
>> other info that might help us debug this:
>>
>>  Possible interrupt unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(prepare_lock);
>>                                local_irq_disable();
>>                                lock(&(&host->lock)->rlock#2);
>>                                lock(prepare_lock);
>>   <Interrupt>
>>     lock(&(&host->lock)->rlock#2);
>>
>>  *** DEADLOCK ***
>>
>> 3 locks held by kworker/u8:1/29:
>>  #0:  (kmmcd){.+.+..}, at: [<8003d0e8>] process_one_work+0x130/0x450
>>  #1:  ((&(&host->detect)->work)){+.+...}, at: [<8003d0e8>] process_one_work+0x10
>>  #2:  (&(&host->lock)->rlock#2){-.-...}, at: [<80457e5c>] sdhci_do_set_ios+0x208
>>
>> the dependencies between HARDIRQ-irq-safe lock and the holding lock:
>> -> (&(&host->lock)->rlock#2){-.-...} ops: 930 {
>>    IN-HARDIRQ-W at:
>>                     [<8005e3e4>] mark_lock+0x140/0x6a8
>>                     [<8005f410>] __lock_acquire+0xac4/0x1c1c
>>                     [<80060a34>] lock_acquire+0x68/0x7c
>>                     [<8060a988>] _raw_spin_lock+0x30/0x40
>>                     [<80456e00>] sdhci_irq+0x24/0xa10
>>                     [<8006a204>] handle_irq_event_percpu+0x54/0x1a4
>>                     [<8006a398>] handle_irq_event+0x44/0x64
>>                     [<8006d4c0>] handle_fasteoi_irq+0xa0/0x160
>>                     [<80069b78>] generic_handle_irq+0x28/0x38
>>                     [<8000f358>] handle_IRQ+0x54/0xb8
>>                     [<80008640>] gic_handle_irq+0x30/0x64
>>                     [<800130a4>] __irq_svc+0x44/0x5c
>>                     [<806026e0>] printk+0x38/0x40
>>                     [<80458e24>] sdhci_add_host+0x844/0xbd0
>>                     [<8045ab48>] sdhci_esdhc_imx_probe+0x31c/0x5dc
>>                     [<80325dc4>] platform_drv_probe+0x20/0x50
>>                     [<803247b4>] driver_probe_device+0x118/0x234
>>                     [<8032496c>] __driver_attach+0x9c/0xa0
>>                     [<80322d78>] bus_for_each_dev+0x5c/0x90
>>                     [<803242b0>] driver_attach+0x20/0x28
>>                     [<80323eac>] bus_add_driver+0xdc/0x1dc
>>                     [<80325024>] driver_register+0x80/0xfc
>>                     [<80325ce4>] __platform_driver_register+0x50/0x64
>>                     [<8083a6b0>] sdhci_esdhc_imx_driver_init+0x18/0x20
>>                     [<80008974>] do_one_initcall+0xfc/0x160
>>                     [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                     [<805ff7e0>] kernel_init+0x10/0x120
>>                     [<8000eae8>] ret_from_fork+0x14/0x2c
>>    IN-SOFTIRQ-W at:
>>                     [<8005e3e4>] mark_lock+0x140/0x6a8
>>                     [<8005ee1c>] __lock_acquire+0x4d0/0x1c1c
>>                     [<80060a34>] lock_acquire+0x68/0x7c
>>                     [<8060aa5c>] _raw_spin_lock_irqsave+0x40/0x54
>>                     [<80454b20>] sdhci_tasklet_finish+0x1c/0x11c
>>                     [<8002ad64>] tasklet_action+0x90/0x148
>>                     [<8002b2c8>] __do_softirq+0x100/0x25c
>>                     [<8002b800>] irq_exit+0xb0/0x104
>>                     [<8000f35c>] handle_IRQ+0x58/0xb8
>>                     [<80008640>] gic_handle_irq+0x30/0x64
>>                     [<800130a4>] __irq_svc+0x44/0x5c
>>                     [<806026e0>] printk+0x38/0x40
>>                     [<80458e24>] sdhci_add_host+0x844/0xbd0
>>                     [<8045ab48>] sdhci_esdhc_imx_probe+0x31c/0x5dc
>>                     [<80325dc4>] platform_drv_probe+0x20/0x50
>>                     [<803247b4>] driver_probe_device+0x118/0x234
>>                     [<8032496c>] __driver_attach+0x9c/0xa0
>>                     [<80322d78>] bus_for_each_dev+0x5c/0x90
>>                     [<803242b0>] driver_attach+0x20/0x28
>>                     [<80323eac>] bus_add_driver+0xdc/0x1dc
>>                     [<80325024>] driver_register+0x80/0xfc
>>                     [<80325ce4>] __platform_driver_register+0x50/0x64
>>                     [<8083a6b0>] sdhci_esdhc_imx_driver_init+0x18/0x20
>>                     [<80008974>] do_one_initcall+0xfc/0x160
>>                     [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                     [<805ff7e0>] kernel_init+0x10/0x120
>>                     [<8000eae8>] ret_from_fork+0x14/0x2c
>>    INITIAL USE at:
>>                    [<8005e3e4>] mark_lock+0x140/0x6a8
>>                    [<8005ec14>] __lock_acquire+0x2c8/0x1c1c
>>                    [<80060a34>] lock_acquire+0x68/0x7c
>>                    [<8060aa5c>] _raw_spin_lock_irqsave+0x40/0x54
>>                    [<80457e5c>] sdhci_do_set_ios+0x20/0x708
>>                    [<8045856c>] sdhci_set_ios+0x28/0x34
>>                    [<80443990>] mmc_power_up+0x6c/0xd0
>>                    [<804446d4>] mmc_start_host+0x40/0x64
>>                    [<80445704>] mmc_add_host+0x60/0x88
>>                    [<80458dd8>] sdhci_add_host+0x7f8/0xbd0
>>                    [<8045ab48>] sdhci_esdhc_imx_probe+0x31c/0x5dc
>>                    [<80325dc4>] platform_drv_probe+0x20/0x50
>>                    [<803247b4>] driver_probe_device+0x118/0x234
>>                    [<8032496c>] __driver_attach+0x9c/0xa0
>>                    [<80322d78>] bus_for_each_dev+0x5c/0x90
>>                    [<803242b0>] driver_attach+0x20/0x28
>>                    [<80323eac>] bus_add_driver+0xdc/0x1dc
>>                    [<80325024>] driver_register+0x80/0xfc
>>                    [<80325ce4>] __platform_driver_register+0x50/0x64
>>                    [<8083a6b0>] sdhci_esdhc_imx_driver_init+0x18/0x20
>>                    [<80008974>] do_one_initcall+0xfc/0x160
>>                    [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                    [<805ff7e0>] kernel_init+0x10/0x120
>>                    [<8000eae8>] ret_from_fork+0x14/0x2c
>>  }
>>  ... key      at: [<80df3da4>] __key.27058+0x0/0x8
>>  ... acquired at:
>>    [<8005df14>] check_usage+0x3c8/0x5b8
>>    [<8005e160>] check_irq_usage+0x5c/0xb8
>>    [<8005f794>] __lock_acquire+0xe48/0x1c1c
>>    [<80060a34>] lock_acquire+0x68/0x7c
>>    [<806093bc>] mutex_lock_nested+0x54/0x3ac
>>    [<80476cdc>] clk_prepare_lock+0x78/0xec
>>    [<80477920>] clk_get_rate+0x14/0x64
>>    [<80459edc>] esdhc_pltfm_set_clock+0x20/0x294
>>    [<80454754>] sdhci_set_clock+0x4c/0x3fc
>>    [<80457f28>] sdhci_do_set_ios+0xec/0x708
>>    [<8045856c>] sdhci_set_ios+0x28/0x34
>>    [<80442d24>] __mmc_set_clock+0x44/0x60
>>    [<8044383c>] mmc_set_clock+0x10/0x14
>>    [<8044b56c>] mmc_sdio_init_card+0x4a8/0xa70
>>    [<8044c004>] mmc_attach_sdio+0x88/0x370
>>    [<80444604>] mmc_rescan+0x230/0x2c0
>>    [<8003d164>] process_one_work+0x1ac/0x450
>>    [<8003d808>] worker_thread+0x124/0x398
>>    [<80044684>] kthread+0xcc/0xe8
>>    [<8000eae8>] ret_from_fork+0x14/0x2c
>>
>>
>> the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
>> -> (prepare_lock){+.+.+.} ops: 380 {
>>    HARDIRQ-ON-W at:
>>                     [<8005e3e4>] mark_lock+0x140/0x6a8
>>                     [<800611f0>] mark_held_locks+0x64/0x130
>>                     [<8006136c>] trace_hardirqs_on_caller+0xb0/0x1cc
>>                     [<8006149c>] trace_hardirqs_on+0x14/0x18
>>                     [<806078f8>] mutex_trylock+0x178/0x200
>>                     [<80476c78>] clk_prepare_lock+0x14/0xec
>>                     [<80477818>] clk_notifier_register+0x28/0xf4
>>                     [<8001537c>] twd_clk_init+0x50/0x68
>>                     [<80008974>] do_one_initcall+0xfc/0x160
>>                     [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                     [<805ff7e0>] kernel_init+0x10/0x120
>>                     [<8000eae8>] ret_from_fork+0x14/0x2c
>>    SOFTIRQ-ON-W at:
>>                     [<8005e3e4>] mark_lock+0x140/0x6a8
>>                     [<800611f0>] mark_held_locks+0x64/0x130
>>                     [<800613b0>] trace_hardirqs_on_caller+0xf4/0x1cc
>>                     [<8006149c>] trace_hardirqs_on+0x14/0x18
>>                     [<806078f8>] mutex_trylock+0x178/0x200
>>                     [<80476c78>] clk_prepare_lock+0x14/0xec
>>                     [<80477818>] clk_notifier_register+0x28/0xf4
>>                     [<8001537c>] twd_clk_init+0x50/0x68
>>                     [<80008974>] do_one_initcall+0xfc/0x160
>>                     [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                     [<805ff7e0>] kernel_init+0x10/0x120
>>                     [<8000eae8>] ret_from_fork+0x14/0x2c
>>    RECLAIM_FS-ON-W at:
>>                        [<8005e3e4>] mark_lock+0x140/0x6a8
>>                        [<800611f0>] mark_held_locks+0x64/0x130
>>                        [<80061a2c>] lockdep_trace_alloc+0x90/0x100
>>                        [<800a6408>] __alloc_pages_nodemask+0x7c/0x818
>>                        [<800d5054>] new_slab+0x6c/0x270
>>                        [<80603564>] __slab_alloc.isra.56.constprop.58+0x1bc/0x54
>>                        [<800d56c0>] kmem_cache_alloc+0xf4/0x124
>>                        [<800f0a8c>] __d_alloc+0x24/0x184
>>                        [<800f0df8>] d_alloc+0x18/0x68
>>                        [<800e3e90>] lookup_dcache+0x8c/0xac
>>                        [<800e3ed0>] __lookup_hash+0x20/0x4c
>>                        [<800e8708>] lookup_one_len+0xcc/0x120
>>                        [<802531f8>] __create_file+0x70/0x1dc
>>                        [<80253438>] debugfs_create_file+0x30/0x38
>>                        [<802541e4>] debugfs_create_u32+0x44/0x54
>>                        [<80477c60>] clk_debug_create_subtree+0xb0/0x118
>>                        [<8083bc78>] clk_debug_init+0xb0/0x140
>>                        [<80008974>] do_one_initcall+0xfc/0x160
>>                        [<8080bc9c>] kernel_init_freeable+0x104/0x1d4
>>                        [<805ff7e0>] kernel_init+0x10/0x120
>>                        [<8000eae8>] ret_from_fork+0x14/0x2c
>>    INITIAL USE at:
>>                    [<8005e3e4>] mark_lock+0x140/0x6a8
>>                    [<8005ec14>] __lock_acquire+0x2c8/0x1c1c
>>                    [<80060a34>] lock_acquire+0x68/0x7c
>>                    [<80607890>] mutex_trylock+0x110/0x200
>>                    [<80476c78>] clk_prepare_lock+0x14/0xec
>>                    [<80478bd8>] __clk_init+0x1c/0x45c
>>                    [<804790e8>] _clk_register+0xd0/0x168
>>                    [<80479230>] clk_register+0x3c/0x84
>>                    [<80479bd4>] clk_register_fixed_rate+0x88/0xd4
>>                    [<80479c88>] of_fixed_clk_setup+0x68/0x90
>>                    [<8083bd4c>] of_clk_init+0x44/0x6c
>>                    [<8080f2e4>] time_init+0x2c/0x38
>>                    [<8080ba10>] start_kernel+0x1dc/0x364
>>                    [<10008074>] 0x10008074
>>  }
>>  ... key      at: [<8089f47c>] prepare_lock+0x38/0x48
>>  ... acquired at:
>>    [<8005df48>] check_usage+0x3fc/0x5b8
>>    [<8005e160>] check_irq_usage+0x5c/0xb8
>>    [<8005f794>] __lock_acquire+0xe48/0x1c1c
>>    [<80060a34>] lock_acquire+0x68/0x7c
>>    [<806093bc>] mutex_lock_nested+0x54/0x3ac
>>    [<80476cdc>] clk_prepare_lock+0x78/0xec
>>    [<80477920>] clk_get_rate+0x14/0x64
>>    [<80459edc>] esdhc_pltfm_set_clock+0x20/0x294
>>    [<80454754>] sdhci_set_clock+0x4c/0x3fc
>>    [<80457f28>] sdhci_do_set_ios+0xec/0x708
>>    [<8045856c>] sdhci_set_ios+0x28/0x34
>>    [<80442d24>] __mmc_set_clock+0x44/0x60
>>    [<8044383c>] mmc_set_clock+0x10/0x14
>>    [<8044b56c>] mmc_sdio_init_card+0x4a8/0xa70
>>    [<8044c004>] mmc_attach_sdio+0x88/0x370
>>    [<80444604>] mmc_rescan+0x230/0x2c0
>>    [<8003d164>] process_one_work+0x1ac/0x450
>>    [<8003d808>] worker_thread+0x124/0x398
>>    [<80044684>] kthread+0xcc/0xe8
>>    [<8000eae8>] ret_from_fork+0x14/0x2c
>>
>>
>> stack backtrace:
>> CPU: 1 PID: 29 Comm: kworker/u8:1 Not tainted 3.12.0-next-20131112+ #446
>> Workqueue: kmmcd mmc_rescan
>> Backtrace:
>> [<8001233c>] (dump_backtrace+0x0/0x10c) from [<800124d8>] (show_stack+0x18/0x1c)
>>  r6:00000000 r5:80967f70 r4:00000000 r3:ef1d9b00
>> [<800124c0>] (show_stack+0x0/0x1c) from [<80604564>] (dump_stack+0x80/0x9c)
>> [<806044e4>] (dump_stack+0x0/0x9c) from [<8005df68>] (check_usage+0x41c/0x5b8)
>>  r4:ef215b2c r3:ef1d9b00
>> [<8005db4c>] (check_usage+0x0/0x5b8) from [<8005e160>] (check_irq_usage+0x5c/0x)
>> [<8005e104>] (check_irq_usage+0x0/0xb8) from [<8005f794>] (__lock_acquire+0xe48)
>>  r8:80de9504 r7:00000003 r6:80d9f334 r5:80950a80 r4:ef1d9ed0
>> [<8005e94c>] (__lock_acquire+0x0/0x1c1c) from [<80060a34>] (lock_acquire+0x68/0)
>> [<800609cc>] (lock_acquire+0x0/0x7c) from [<806093bc>] (mutex_lock_nested+0x54/)
>>  r7:ef1d9b00 r6:80d9f334 r5:00000000 r4:80476cdc
>> [<80609368>] (mutex_lock_nested+0x0/0x3ac) from [<80476cdc>] (clk_prepare_lock+)
>> [<80476c64>] (clk_prepare_lock+0x0/0xec) from [<80477920>] (clk_get_rate+0x14/0)
>>  r6:02faf080 r5:ee9192a8 r4:ef027300 r3:8089d6cc
>> [<8047790c>] (clk_get_rate+0x0/0x64) from [<80459edc>] (esdhc_pltfm_set_clock+0)
>>  r5:ee9192a8 r4:ee919440
>> [<80459ebc>] (esdhc_pltfm_set_clock+0x0/0x294) from [<80454754>] (sdhci_set_clo)
>> [<80454708>] (sdhci_set_clock+0x0/0x3fc) from [<80457f28>] (sdhci_do_set_ios+0x)
>> [<80457e3c>] (sdhci_do_set_ios+0x0/0x708) from [<8045856c>] (sdhci_set_ios+0x28)
>> [<80458544>] (sdhci_set_ios+0x0/0x34) from [<80442d24>] (__mmc_set_clock+0x44/0)
>>  r5:02faf080 r4:ee919000
>> [<80442ce0>] (__mmc_set_clock+0x0/0x60) from [<8044383c>] (mmc_set_clock+0x10/0)
>>  r5:ef278800 r4:ee919000
>> [<8044382c>] (mmc_set_clock+0x0/0x14) from [<8044b56c>] (mmc_sdio_init_card+0x4)
>> [<8044b0c4>] (mmc_sdio_init_card+0x0/0xa70) from [<8044c004>] (mmc_attach_sdio+)
>> [<8044bf7c>] (mmc_attach_sdio+0x0/0x370) from [<80444604>] (mmc_rescan+0x230/0x)
>> [<804443d4>] (mmc_rescan+0x0/0x2c0) from [<8003d164>] (process_one_work+0x1ac/0)
>>  r8:00000000 r7:ef215ea8 r6:ef00dc00 r5:ee9192f8 r4:ef1ea980
>> r3:804443d4
>> [<8003cfb8>] (process_one_work+0x0/0x450) from [<8003d808>] (worker_thread+0x12)
>> [<8003d6e4>] (worker_thread+0x0/0x398) from [<80044684>] (kthread+0xcc/0xe8)
>> [<800445b8>] (kthread+0x0/0xe8) from [<8000eae8>] (ret_from_fork+0x14/0x2c)
>>  r7:00000000 r6:00000000 r5:800445b8 r4:ef1eca80
>>
>> Tested-by: Markus Niebel <Markus.Niebel@tqs.de>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> This warning does not happen during all boots. It happens in around 20% of the
>> boots.
>>
>> Searching on other set_ios implementations, I see that they do not hold
>> spin lock.
>>
>>  drivers/mmc/host/sdhci.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index bd8a098..ba6f630 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1412,14 +1412,10 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>
>>  static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>  {
>> -       unsigned long flags;
>>         int vdd_bit = -1;
>>         u8 ctrl;
>>
>> -       spin_lock_irqsave(&host->lock, flags);
>> -
>>         if (host->flags & SDHCI_DEVICE_DEAD) {
>> -               spin_unlock_irqrestore(&host->lock, flags);
>>                 if (host->vmmc && ios->power_mode == MMC_POWER_OFF)
>>                         mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
>>                 return;
>> @@ -1446,11 +1442,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>         else
>>                 vdd_bit = sdhci_set_power(host, ios->vdd);
>>
>> -       if (host->vmmc && vdd_bit != -1) {
>> -               spin_unlock_irqrestore(&host->lock, flags);
>> +       if (host->vmmc && vdd_bit != -1)
>>                 mmc_regulator_set_ocr(host->mmc, host->vmmc, vdd_bit);
>> -               spin_lock_irqsave(&host->lock, flags);
>> -       }
>>
>>         if (host->ops->platform_send_init_74_clocks)
>>                 host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>> @@ -1584,9 +1577,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>          */
>>         if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
>>                 sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>> -
>> -       mmiowb();
>> -       spin_unlock_irqrestore(&host->lock, flags);
>>  }
>>
>>  static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> --
>> 1.8.1.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
