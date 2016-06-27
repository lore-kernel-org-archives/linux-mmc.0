From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: linux-next - lockdep whine in MMC/SDHC code
Date: Mon, 27 Jun 2016 13:44:28 -0400
Message-ID: <12095.1467049468@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1467049468_6830P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43264 "EHLO
	omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751638AbcF0Rol (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 13:44:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

--==_Exmh_1467049468_6830P
Content-Type: text/plain; charset=us-ascii

This may be indicative of an actual problem, as I've had at least one
time that subsequently mounting and then trying to access files on the
partition caused kernel BUGs.

Seen in next-0614 and next-0627.  Google reports similar issues, but from
the 2013/2014 timeframe....

[    2.610725] NET: Registered protocol family 10

[    2.623472] ======================================================
[    2.623548] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
[    2.623638] 4.7.0-rc4-next-20160627-dirty #303 Not tainted
[    2.623733] ------------------------------------------------------
[    2.623817] kworker/2:1/49 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[    2.623883]  (pcpu_alloc_mutex){+.+.+.}, at: [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    2.623986]
               and this task is already holding:
[    2.624044]  (&(&host->lock)->rlock#3){-.-...}, at: [<ffffffffa1b19676>] sdhci_request+0x56/0x200
[    2.624153] which would create a new lock dependency:
[    2.624203]  (&(&host->lock)->rlock#3){-.-...} -> (pcpu_alloc_mutex){+.+.+.}
[    2.624305]
               but this new dependency connects a HARDIRQ-irq-safe lock:
[    2.624381]  (&(&host->lock)->rlock#3){-.-...}
               ... which became HARDIRQ-irq-safe at:
[    2.624473]   [<ffffffffa114df5d>] __lock_acquire+0x6cd/0x1d60
[    2.624553]   [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.624661]   [<ffffffffa20aba6b>] _raw_spin_lock+0x3b/0x50
[    2.624769]   [<ffffffffa1b1c41b>] sdhci_irq+0x3b/0xc20
[    2.624869]   [<ffffffffa1161627>] __handle_irq_event_percpu+0x127/0x690
[    2.624993]   [<ffffffffa1161bc4>] handle_irq_event_percpu+0x34/0xb0
[    2.625110]   [<ffffffffa1161c8b>] handle_irq_event+0x4b/0xc0
[    2.625218]   [<ffffffffa11675df>] handle_fasteoi_irq+0x14f/0x310
[    2.625347]   [<ffffffffa1037e66>] handle_irq+0xa6/0x2c0
[    2.625462]   [<ffffffffa20aec28>] do_IRQ+0x88/0x1b0
[    2.625571]   [<ffffffffa20ad1c9>] ret_from_intr+0x0/0x19
[    2.625683]   [<ffffffffa1aef227>] cpuidle_enter+0x17/0x20
[    2.625786]   [<ffffffffa113b88e>] cpu_startup_entry+0x54e/0x720
[    2.625910]   [<ffffffffa106dc41>] start_secondary+0x1a1/0x250
[    2.626035]
               to a HARDIRQ-irq-unsafe lock:
[    2.626129]  (pcpu_alloc_mutex){+.+.+.}
               ... which became HARDIRQ-irq-unsafe at:
[    2.626283] ...  [<ffffffffa114dfdc>] __lock_acquire+0x74c/0x1d60
[    2.626403]   [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.626522]   [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    2.626648]   [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    2.626764]   [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    2.626883]   [<ffffffffa134eee1>] alloc_kmem_cache_cpus.isra.38+0x31/0x140
[    2.627029]   [<ffffffffa1353fcd>] __do_tune_cpucache+0x3d/0x220
[    2.627145]   [<ffffffffa135422f>] enable_cpucache+0x7f/0x160
[    2.627251]   [<ffffffffa33d43e2>] kmem_cache_init_late+0x85/0x100
[    2.627379]   [<ffffffffa3369349>] start_kernel+0x4b0/0x78f
[    2.627499]   [<ffffffffa33673c5>] x86_64_start_reservations+0x5a/0x7b
[    2.627637]   [<ffffffffa3367729>] x86_64_start_kernel+0x343/0x38a
[    2.627765]
               other info that might help us debug this:

[    2.627898]  Possible interrupt unsafe locking scenario:

[    2.628031]        CPU0                    CPU1
[    2.628123]        ----                    ----
[    2.628213]   lock(pcpu_alloc_mutex);
[    2.628293]                                local_irq_disable();
[    2.628394]                                lock(&(&host->lock)->rlock#3);
[    2.628531]                                lock(pcpu_alloc_mutex);
[    2.628666]   <Interrupt>
[    2.628714]     lock(&(&host->lock)->rlock#3);
[    2.628823]
                *** DEADLOCK ***

[    2.628924] 3 locks held by kworker/2:1/49:
[    2.628998]  #0:  ("events_freezable"){.+.+.+}, at: [<ffffffffa10e7c19>] process_one_work+0x329/0xd70
[    2.629196]  #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<ffffffffa10e7c19>] process_one_work+0x329/0xd70
[    2.634773]  #2:  (&(&host->lock)->rlock#3){-.-...}, at: [<ffffffffa1b19676>] sdhci_request+0x56/0x200
[    2.639936]
               the dependencies between HARDIRQ-irq-safe lock and the holding lock:
[    2.650257] -> (&(&host->lock)->rlock#3){-.-...} ops: 205 {
[    2.655394]    IN-HARDIRQ-W at:
[    2.660399]                     [<ffffffffa114df5d>] __lock_acquire+0x6cd/0x1d60
[    2.665557]                     [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.670735]                     [<ffffffffa20aba6b>] _raw_spin_lock+0x3b/0x50
[    2.675778]                     [<ffffffffa1b1c41b>] sdhci_irq+0x3b/0xc20
[    2.680851]                     [<ffffffffa1161627>] __handle_irq_event_percpu+0x127/0x690
[    2.685873]                     [<ffffffffa1161bc4>] handle_irq_event_percpu+0x34/0xb0
[    2.690836]                     [<ffffffffa1161c8b>] handle_irq_event+0x4b/0xc0
[    2.695814]                     [<ffffffffa11675df>] handle_fasteoi_irq+0x14f/0x310
[    2.700717]                     [<ffffffffa1037e66>] handle_irq+0xa6/0x2c0
[    2.705614]                     [<ffffffffa20aec28>] do_IRQ+0x88/0x1b0
[    2.710373]                     [<ffffffffa20ad1c9>] ret_from_intr+0x0/0x19
[    2.715092]                     [<ffffffffa1aef227>] cpuidle_enter+0x17/0x20
[    2.719768]                     [<ffffffffa113b88e>] cpu_startup_entry+0x54e/0x720
[    2.724428]                     [<ffffffffa106dc41>] start_secondary+0x1a1/0x250
[    2.729005]    IN-SOFTIRQ-W at:
[    2.733482]                     [<ffffffffa114dfa6>] __lock_acquire+0x716/0x1d60
[    2.738058]                     [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.742639]                     [<ffffffffa20abc86>] _raw_spin_lock_irqsave+0x46/0x60
[    2.747245]                     [<ffffffffa1b18078>] sdhci_tasklet_finish+0x28/0x2e0
[    2.751781]                     [<ffffffffa10bbf18>] tasklet_action+0x1e8/0x650
[    2.756349]                     [<ffffffffa20af38c>] __do_softirq+0x12c/0xa3c
[    2.760820]                     [<ffffffffa10bc5cf>] irq_exit+0xff/0x160
[    2.765330]                     [<ffffffffa20aec31>] do_IRQ+0x91/0x1b0
[    2.769785]                     [<ffffffffa20ad1c9>] ret_from_intr+0x0/0x19
[    2.774219]                     [<ffffffffa1aef227>] cpuidle_enter+0x17/0x20
[    2.778665]                     [<ffffffffa113b88e>] cpu_startup_entry+0x54e/0x720
[    2.783189]                     [<ffffffffa106dc41>] start_secondary+0x1a1/0x250
[    2.787680]    INITIAL USE at:
[    2.792207]                    [<ffffffffa114da92>] __lock_acquire+0x202/0x1d60
[    2.796776]                    [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.801394]                    [<ffffffffa20abc86>] _raw_spin_lock_irqsave+0x46/0x60
[    2.805970]                    [<ffffffffa1b174b2>] sdhci_set_ios+0x32/0x820
[    2.810602]                    [<ffffffffa1af7777>] mmc_set_initial_state+0x77/0xe0
[    2.815221]                    [<ffffffffa1af7e1d>] mmc_power_off+0x3d/0x60
[    2.819795]                    [<ffffffffa1af9217>] mmc_start_host+0x87/0xa0
[    2.824415]                    [<ffffffffa1afa1ce>] mmc_add_host+0x9e/0x160
[    2.828986]                    [<ffffffffa1b1afdd>] sdhci_add_host+0x6ad/0x1ab0
[    2.833530]                    [<ffffffffa1b1f470>] sdhci_pci_probe+0x670/0xaf0
[    2.838192]                    [<ffffffffa1740afc>] pci_device_probe+0xdc/0x180
[    2.842688]                    [<ffffffffa1890bb1>] driver_probe_device+0x131/0x3c0
[    2.847209]                    [<ffffffffa1890ef9>] __driver_attach+0xb9/0x100
[    2.851720]                    [<ffffffffa188d9aa>] bus_for_each_dev+0x8a/0xf0
[    2.856239]                    [<ffffffffa18900d7>] driver_attach+0x27/0x50
[    2.860754]                    [<ffffffffa188f9b6>] bus_add_driver+0x116/0x2b0
[    2.865306]                    [<ffffffffa189170f>] driver_register+0x9f/0x160
[    2.869760]                    [<ffffffffa173f94f>] __pci_register_driver+0x8f/0xe0
[    2.874304]                    [<ffffffffa342452c>] sdhci_driver_init+0x21/0x45
[    2.874582] tsc: Refined TSC clocksource calibration: 2691.248 MHz
[    2.874586] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26caf29c8ab, max_idle_ns: 440795203557 ns
[    2.887854]                    [<ffffffffa100044f>] do_one_initcall+0x5f/0x220
[    2.892589]                    [<ffffffffa3369b26>] kernel_init_freeable+0x4fe/0x62c
[    2.897323]                    [<ffffffffa209e61f>] kernel_init+0xf/0x120
[    2.901997]                    [<ffffffffa20aca7f>] ret_from_fork+0x1f/0x40
[    2.906703]  }
[    2.911234]  ... key      at: [<ffffffffa441bc38>] __key.34922+0x0/0x8
[    2.915907]  ... acquired at:
[    2.920618]    [<ffffffffa114c1ae>] check_irq_usage+0x7e/0x230
[    2.925482]    [<ffffffffa114f03c>] __lock_acquire+0x17ac/0x1d60
[    2.930247]    [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    2.934992]    [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    2.939794]    [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    2.944667]    [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    2.949526]    [<ffffffffa186e950>] init_iova_domain+0xe0/0x2f0
[    2.954284]    [<ffffffffa187cbc7>] get_domain_for_dev.constprop.32+0xd7/0x620
[    2.959128]    [<ffffffffa187d12e>] __get_valid_domain_for_dev+0x1e/0x320
[    2.963972]    [<ffffffffa187dbd1>] intel_map_sg+0x281/0x3b0
[    2.968893]    [<ffffffffa1b18415>] sdhci_pre_dma_transfer+0xe5/0x1c0
[    2.973867]    [<ffffffffa1b187a3>] sdhci_prepare_data+0x223/0xa40
[    2.978671]    [<ffffffffa1b1929d>] sdhci_send_command+0x17d/0x500
[    2.983484]    [<ffffffffa1b19755>] sdhci_request+0x135/0x200
[    2.988136]    [<ffffffffa1af56cf>] __mmc_start_request+0x8f/0x420
[    2.992768]    [<ffffffffa1af5c73>] mmc_start_request+0x213/0x360
[    2.997307]    [<ffffffffa1af5e1b>] __mmc_start_req+0x5b/0xd0
[    3.001814]    [<ffffffffa1af6917>] mmc_wait_for_req+0x17/0x30
[    3.006328]    [<ffffffffa1b050e7>] mmc_app_send_scr+0x1a7/0x250
[    3.010813]    [<ffffffffa1b03022>] mmc_sd_setup_card+0x32/0x810
[    3.015264]    [<ffffffffa1b0398c>] mmc_sd_init_card+0x18c/0xad0
[    3.019711]    [<ffffffffa1b0467d>] mmc_attach_sd+0xfd/0x210
[    3.024160]    [<ffffffffa1af8fa8>] mmc_rescan+0x328/0x510
[    3.028608]    [<ffffffffa10e7cab>] process_one_work+0x3bb/0xd70
[    3.032999]    [<ffffffffa10e89b1>] worker_thread+0x351/0xad0
[    3.037384]    [<ffffffffa10f1982>] kthread+0x142/0x1b0
[    3.041807]    [<ffffffffa20aca7f>] ret_from_fork+0x1f/0x40

[    3.050650]
               the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
[    3.059609] -> (pcpu_alloc_mutex){+.+.+.} ops: 619 {
[    3.064119]    HARDIRQ-ON-W at:
[    3.068639]                     [<ffffffffa114dfdc>] __lock_acquire+0x74c/0x1d60
[    3.073249]                     [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    3.077760]                     [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    3.082253]                     [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    3.086737]                     [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.091270]                     [<ffffffffa134eee1>] alloc_kmem_cache_cpus.isra.38+0x31/0x140
[    3.095772]                     [<ffffffffa1353fcd>] __do_tune_cpucache+0x3d/0x220
[    3.100352]                     [<ffffffffa135422f>] enable_cpucache+0x7f/0x160
[    3.104864]                     [<ffffffffa33d43e2>] kmem_cache_init_late+0x85/0x100
[    3.109433]                     [<ffffffffa3369349>] start_kernel+0x4b0/0x78f
[    3.113981]                     [<ffffffffa33673c5>] x86_64_start_reservations+0x5a/0x7b
[    3.118520]                     [<ffffffffa3367729>] x86_64_start_kernel+0x343/0x38a
[    3.123069]    SOFTIRQ-ON-W at:
[    3.127629]                     [<ffffffffa114e015>] __lock_acquire+0x785/0x1d60
[    3.132296]                     [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    3.136854]                     [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    3.141453]                     [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    3.145994]                     [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.150480]                     [<ffffffffa134eee1>] alloc_kmem_cache_cpus.isra.38+0x31/0x140
[    3.155045]                     [<ffffffffa1353fcd>] __do_tune_cpucache+0x3d/0x220
[    3.159641]                     [<ffffffffa135422f>] enable_cpucache+0x7f/0x160
[    3.164284]                     [<ffffffffa33d43e2>] kmem_cache_init_late+0x85/0x100
[    3.168856]                     [<ffffffffa3369349>] start_kernel+0x4b0/0x78f
[    3.173482]                     [<ffffffffa33673c5>] x86_64_start_reservations+0x5a/0x7b
[    3.178110]                     [<ffffffffa3367729>] x86_64_start_kernel+0x343/0x38a
[    3.182712]    RECLAIM_FS-ON-W at:
[    3.187278]                        [<ffffffffa114d14d>] mark_held_locks+0x8d/0x150
[    3.191954]                        [<ffffffffa115077b>] lockdep_trace_alloc+0xcb/0x150
[    3.196718]                        [<ffffffffa1351f57>] __kmalloc+0x97/0x4b0
[    3.201472]                        [<ffffffffa12f7376>] pcpu_mem_zalloc+0xe6/0x140
[    3.206170]                        [<ffffffffa12f753f>] pcpu_create_chunk+0x2f/0x1a0
[    3.210907]                        [<ffffffffa12f82f0>] pcpu_alloc+0x270/0x890
[    3.215647]                        [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.220404]                        [<ffffffffa134eee1>] alloc_kmem_cache_cpus.isra.38+0x31/0x140
[    3.225091]                        [<ffffffffa1353fcd>] __do_tune_cpucache+0x3d/0x220
[    3.229719]                        [<ffffffffa135422f>] enable_cpucache+0x7f/0x160
[    3.234310]                        [<ffffffffa20a0292>] setup_cpu_cache+0x1a2/0x270
[    3.238822]                        [<ffffffffa13545c7>] __kmem_cache_create+0x247/0x300
[    3.243394]                        [<ffffffffa12fbf2b>] kmem_cache_create+0x11b/0x230
[    3.247946]                        [<ffffffffa33ac4ac>] init_workqueues+0xc1/0xe53
[    3.252501]                        [<ffffffffa100044f>] do_one_initcall+0x5f/0x220
[    3.256971]                        [<ffffffffa336985b>] kernel_init_freeable+0x233/0x62c
[    3.261471]                        [<ffffffffa209e61f>] kernel_init+0xf/0x120
[    3.265885]                        [<ffffffffa20aca7f>] ret_from_fork+0x1f/0x40
[    3.270377]    INITIAL USE at:
[    3.274761]                    [<ffffffffa114da92>] __lock_acquire+0x202/0x1d60
[    3.279317]                    [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    3.283845]                    [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    3.288413]                    [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    3.292894]                    [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.297326]                    [<ffffffffa134eee1>] alloc_kmem_cache_cpus.isra.38+0x31/0x140
[    3.301818]                    [<ffffffffa20a0123>] setup_cpu_cache+0x33/0x270
[    3.306352]                    [<ffffffffa13545c7>] __kmem_cache_create+0x247/0x300
[    3.310848]                    [<ffffffffa33cbff4>] create_boot_cache+0xe5/0x12e
[    3.315393]                    [<ffffffffa33d4255>] kmem_cache_init+0x10f/0x217
[    3.319912]                    [<ffffffffa33691b9>] start_kernel+0x320/0x78f
[    3.324483]                    [<ffffffffa33673c5>] x86_64_start_reservations+0x5a/0x7b
[    3.329007]                    [<ffffffffa3367729>] x86_64_start_kernel+0x343/0x38a
[    3.333542]  }
[    3.337975]  ... key      at: [<ffffffffa2867c40>] pcpu_alloc_mutex+0x60/0x80
[    3.342589]  ... acquired at:
[    3.347105]    [<ffffffffa114c1ae>] check_irq_usage+0x7e/0x230
[    3.351719]    [<ffffffffa114f03c>] __lock_acquire+0x17ac/0x1d60
[    3.356432]    [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    3.361108]    [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    3.365787]    [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    3.370513]    [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.375157]    [<ffffffffa186e950>] init_iova_domain+0xe0/0x2f0
[    3.379852]    [<ffffffffa187cbc7>] get_domain_for_dev.constprop.32+0xd7/0x620
[    3.384633]    [<ffffffffa187d12e>] __get_valid_domain_for_dev+0x1e/0x320
[    3.389409]    [<ffffffffa187dbd1>] intel_map_sg+0x281/0x3b0
[    3.394172]    [<ffffffffa1b18415>] sdhci_pre_dma_transfer+0xe5/0x1c0
[    3.398905]    [<ffffffffa1b187a3>] sdhci_prepare_data+0x223/0xa40
[    3.403619]    [<ffffffffa1b1929d>] sdhci_send_command+0x17d/0x500
[    3.408322]    [<ffffffffa1b19755>] sdhci_request+0x135/0x200
[    3.412905]    [<ffffffffa1af56cf>] __mmc_start_request+0x8f/0x420
[    3.417563]    [<ffffffffa1af5c73>] mmc_start_request+0x213/0x360
[    3.422143]    [<ffffffffa1af5e1b>] __mmc_start_req+0x5b/0xd0
[    3.426748]    [<ffffffffa1af6917>] mmc_wait_for_req+0x17/0x30
[    3.431414]    [<ffffffffa1b050e7>] mmc_app_send_scr+0x1a7/0x250
[    3.435959]    [<ffffffffa1b03022>] mmc_sd_setup_card+0x32/0x810
[    3.440524]    [<ffffffffa1b0398c>] mmc_sd_init_card+0x18c/0xad0
[    3.445025]    [<ffffffffa1b0467d>] mmc_attach_sd+0xfd/0x210
[    3.449502]    [<ffffffffa1af8fa8>] mmc_rescan+0x328/0x510
[    3.453955]    [<ffffffffa10e7cab>] process_one_work+0x3bb/0xd70
[    3.458483]    [<ffffffffa10e89b1>] worker_thread+0x351/0xad0
[    3.462973]    [<ffffffffa10f1982>] kthread+0x142/0x1b0
[    3.467374]    [<ffffffffa20aca7f>] ret_from_fork+0x1f/0x40

[    3.476160]
               stack backtrace:
[    3.484669] CPU: 2 PID: 49 Comm: kworker/2:1 Not tainted 4.7.0-rc4-next-20160627-dirty #303
[    3.489073] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    3.493558] Workqueue: events_freezable mmc_rescan
[    3.498110]  0000000000000000 00000000347c66ec ffff8800c6dbb2c8 ffffffffa16afa6a
[    3.502690]  0000000000000000 00000000347c66ec ffffffffa3c5e4d0 ffff8800c6db5580
[    3.507305]  ffff8800c6dbb3e0 ffffffffa114c0a5 0000000000000000 ffff880000000000
[    3.511858] Call Trace:
[    3.516441]  [<ffffffffa16afa6a>] dump_stack+0x7b/0xd1
[    3.520993]  [<ffffffffa114c0a5>] check_usage+0x4f5/0x580
[    3.525466]  [<ffffffffa16dd9f8>] ? find_next_bit+0x18/0x20
[    3.529918]  [<ffffffffa16af6fc>] ? cpumask_next_and+0x3c/0x70
[    3.534456]  [<ffffffffa114c1ae>] check_irq_usage+0x7e/0x230
[    3.538912]  [<ffffffffa114f03c>] __lock_acquire+0x17ac/0x1d60
[    3.543346]  [<ffffffffa16f3e89>] ? __list_add_rcu+0xa9/0x190
[    3.547827]  [<ffffffffa114fbc9>] lock_acquire+0x119/0x2d0
[    3.552298]  [<ffffffffa12f8565>] ? pcpu_alloc+0x4e5/0x890
[    3.556776]  [<ffffffffa12f8565>] ? pcpu_alloc+0x4e5/0x890
[    3.561152]  [<ffffffffa20a5b87>] mutex_lock_nested+0x77/0x620
[    3.565593]  [<ffffffffa12f8565>] ? pcpu_alloc+0x4e5/0x890
[    3.569960]  [<ffffffffa12f8565>] pcpu_alloc+0x4e5/0x890
[    3.574348]  [<ffffffffa114d76b>] ? debug_check_no_locks_freed+0xdb/0x200
[    3.578788]  [<ffffffffa12f8945>] __alloc_percpu+0x15/0x20
[    3.583172]  [<ffffffffa186e950>] init_iova_domain+0xe0/0x2f0
[    3.587614]  [<ffffffffa187cbc7>] get_domain_for_dev.constprop.32+0xd7/0x620
[    3.592043]  [<ffffffffa187d12e>] __get_valid_domain_for_dev+0x1e/0x320
[    3.596481]  [<ffffffffa187dbd1>] intel_map_sg+0x281/0x3b0
[    3.600945]  [<ffffffffa1b18415>] sdhci_pre_dma_transfer+0xe5/0x1c0
[    3.605486]  [<ffffffffa11559a7>] ? do_raw_spin_unlock+0xe7/0x1b0
[    3.609959]  [<ffffffffa1b187a3>] sdhci_prepare_data+0x223/0xa40
[    3.614382]  [<ffffffffa1188fee>] ? mod_timer+0x21e/0x5b0
[    3.618826]  [<ffffffffa1b19676>] ? sdhci_request+0x56/0x200
[    3.623219]  [<ffffffffa1b1929d>] sdhci_send_command+0x17d/0x500
[    3.627636]  [<ffffffffa1b19755>] sdhci_request+0x135/0x200
[    3.632157]  [<ffffffffa1af56cf>] __mmc_start_request+0x8f/0x420
[    3.636613]  [<ffffffffa1b2239f>] ? led_trigger_event+0x6f/0x90
[    3.640997]  [<ffffffffa1af5c73>] mmc_start_request+0x213/0x360
[    3.645356]  [<ffffffffa1af5e1b>] __mmc_start_req+0x5b/0xd0
[    3.649694]  [<ffffffffa1af6917>] mmc_wait_for_req+0x17/0x30
[    3.654018]  [<ffffffffa1b050e7>] mmc_app_send_scr+0x1a7/0x250
[    3.658412]  [<ffffffffa1af2350>] ? mmc_align_data_size+0x20/0x20
[    3.662768]  [<ffffffffa1b03022>] mmc_sd_setup_card+0x32/0x810
[    3.667115]  [<ffffffffa1b0398c>] mmc_sd_init_card+0x18c/0xad0
[    3.671479]  [<ffffffffa10fe31a>] ? preempt_count_sub+0x4a/0x90
[    3.675777]  [<ffffffffa1af862e>] ? mmc_attach_bus+0x12e/0x170
[    3.680108]  [<ffffffffa1b0467d>] mmc_attach_sd+0xfd/0x210
[    3.684322]  [<ffffffffa1af8fa8>] mmc_rescan+0x328/0x510
[    3.688560]  [<ffffffffa10e7cab>] process_one_work+0x3bb/0xd70
[    3.692788]  [<ffffffffa10e7c19>] ? process_one_work+0x329/0xd70
[    3.697110]  [<ffffffffa10e89b1>] worker_thread+0x351/0xad0
[    3.701317]  [<ffffffffa10e8660>] ? process_one_work+0xd70/0xd70
[    3.705564]  [<ffffffffa10f1982>] kthread+0x142/0x1b0
[    3.709793]  [<ffffffffa20aca7f>] ret_from_fork+0x1f/0x40
[    3.714004]  [<ffffffffa10f1840>] ? kthread_create_on_node+0x280/0x280
[    3.718730] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    3.721580] mmc0: new high speed SDHC card at address aaaa


--==_Exmh_1467049468_6830P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBV3Fl/AdmEQWDXROgAQIkaQ/+IEctc8CcnVpAJLfNQ3EttUeMiDXCVYt/
Err0O6KE3VxS/N6T2JuUtS2wx8rqIh7ZdgiaqJ86voBfc0yGfbCrTDhfGNFX0Tqc
GMbuCvCa8EqifsJloHAe7qiSLIckolCq/FjvBZD8uV5kTxzV87OGSVvWC8xIm0uE
oKOacVOeJK/1BrA7l0ggIx4rUK5mZMWou6rKjM2XrDbdrg5bDfFRnWc5WmgQV9j5
H+ls6+Z95/KTB9LB82jpOAt6kuOcnJYQgJ05S1kIfLSB188j2rUNx7j54HTfyGw9
YmfO6kdsxib2kU1v9wCHz5rCL4wgQNNmHTGkkYkygoAnPGg+T/vq70Bsq9i6SYAJ
mrv1ledIuxBH5AKVFFzudVhVekcdSs9OVAzr7mJ4dVbLE904178v57jl9xlqAuQj
OV1zv5IN0iydWCT3HY7IcF3z3faAaLh1ybrsV8ZDPDRYpAr8KxS464IFeyMYGByY
D4EiogZ3orJjcQCg5/6U6Pa6JAtPka1USwYR72Qj3ojN6sOQjNJFX3+cXyE5v7ZG
iPV7+rCDIRFJZijFGYuE2JhA+OlxnIOQhFRm03f0z/IrelXXqbkTuZgfsVpoYidg
B2kBl8ZDyZkagmduXmeG3NOU40zgMi0At9Nhzqdyv8k6az7V7eD6Q/AKJ31MED36
P355jYUIBF0=
=2B7/
-----END PGP SIGNATURE-----

--==_Exmh_1467049468_6830P--
