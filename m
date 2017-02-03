From: valdis.kletnieks@vt.edu
Subject: linux-next 20170130 - BUG mmc driver 'sleeping function called from invalid context'
Date: Fri, 03 Feb 2017 12:27:36 -0500
Message-ID: <8252.1486142856@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1486142856_2881P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38262 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751235AbdBCR1r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 12:27:47 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id v13HRkcs027710
        for <linux-mmc@vger.kernel.org>; Fri, 3 Feb 2017 12:27:46 -0500
Received: from mail-qt0-f200.google.com (mail-qt0-f200.google.com [209.85.216.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id v13HRdl2024409
        for <linux-mmc@vger.kernel.org>; Fri, 3 Feb 2017 12:27:44 -0500
Received: by mail-qt0-f200.google.com with SMTP id w20so32959484qtb.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 09:27:44 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

--==_Exmh_1486142856_2881P
Content-Type: text/plain; charset=us-ascii

Booted next-20170130 with a flash memory card forgotten in the reader slot,
and it produced a truly impressive amount of splattage - managing to trigger
both a BUG for sleeping in an invalid context *and* a lockdep whinge.  I can't
tell if it's 2 mmc bugs, or if lockdep got confused due to the BUG happening
at an unexpected time...

No idea how long it's been broken, it's been a few months since I last offloaded
the storage cards in my camera to external media...

(kernel is -dirty due to an unrelated local fix for an IPv6 VPN issue)

[    3.338722] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:748
[    3.338841] in_atomic(): 1, irqs_disabled(): 1, pid: 34, name: kworker/1:1
[    3.338929] 3 locks held by kworker/1:1/34:
[    3.338932]  #0:  ("events_freezable"){.+.+.+}, at: [<ffffffff910f3ea3>] process_one_work+0x2f3/0xf40
[    3.338952]  #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<ffffffff910f3ea3>] process_one_work+0x2f3/0xf40
[    3.338967]  #2:  (&(&host->lock)->rlock#3){-.-...}, at: [<ffffffff91c2b6c5>] sdhci_request+0x55/0x220
[    3.338986] irq event stamp: 8446
[    3.338992] hardirqs last  enabled at (8445): [<ffffffff9221a726>] _raw_spin_unlock_irqrestore+0x86/0xa0
[    3.338996] hardirqs last disabled at (8446): [<ffffffff9221a30e>] _raw_spin_lock_irqsave+0x1e/0x90
[    3.339002] softirqs last  enabled at (7472): [<ffffffff92221025>] __do_softirq+0x585/0xa7d
[    3.339007] softirqs last disabled at (7463): [<ffffffff910c59bb>] irq_exit+0x10b/0x170
[    3.339012] CPU: 1 PID: 34 Comm: kworker/1:1 Not tainted 4.10.0-rc6-next-20170130-dirty #379
[    3.339016] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A18 10/13/2016
[    3.339022] Workqueue: events_freezable mmc_rescan
[    3.339028] Call Trace:
[    3.339036]  dump_stack+0x7b/0xc8
[    3.339043]  ___might_sleep+0x194/0x300
[    3.339050]  __might_sleep+0x6e/0x220
[    3.339056]  ? pcpu_alloc+0x4d6/0x900
[    3.339061]  __mutex_lock+0x59/0x17c0
[    3.339068]  ? __alloc_pages_nodemask+0x36c/0x540
[    3.339072]  ? pcpu_alloc+0x4d6/0x900
[    3.339077]  ? do_raw_spin_unlock+0xdd/0x1d0
[    3.339084]  ? _raw_spin_unlock+0x69/0x80
[    3.339089]  ? cache_alloc_refill+0x90b/0x1310
[    3.339096]  mutex_lock_nested+0x1b/0x20
[    3.339100]  pcpu_alloc+0x4d6/0x900
[    3.339105]  ? debug_check_no_locks_freed+0xe1/0x200
[    3.339114]  __alloc_percpu+0x15/0x20
[    3.339119]  init_iova_domain+0xec/0x300
[    3.339127]  find_or_alloc_domain.constprop.34+0x8c/0x4f0
[    3.339133]  ? _raw_spin_lock_irqsave+0x78/0x90
[    3.339140]  __get_valid_domain_for_dev+0x51/0x380
[    3.339145]  ? do_raw_spin_unlock+0xdd/0x1d0
[    3.339152]  intel_map_sg+0x28d/0x3a0
[    3.339157]  ? mod_timer+0x2a7/0xb30
[    3.339165]  sdhci_pre_dma_transfer+0xf2/0x1c0
[    3.339173]  sdhci_send_command+0x55a/0x10d0
[    3.339178]  ? sdhci_request+0x55/0x220
[    3.339187]  sdhci_request+0xe6/0x220
[    3.339194]  __mmc_start_request+0xab/0x4a0
[    3.339198]  ? led_trigger_event+0x6f/0x90
[    3.339204]  mmc_start_request+0x1a5/0x2b0
[    3.339210]  mmc_wait_for_req+0xc7/0x1e0
[    3.339216]  mmc_app_send_scr+0x14c/0x200
[    3.339239]  ? mmc_align_data_size+0x20/0x20
[    3.339247]  mmc_sd_setup_card+0x32/0x7f0
[    3.339254]  mmc_sd_init_card+0x179/0xab0
[    3.339260]  ? _raw_spin_unlock_irqrestore+0x78/0xa0
[    3.339268]  mmc_attach_sd+0xea/0x200
[    3.339274]  mmc_rescan+0x336/0x550
[    3.339282]  process_one_work+0x38a/0xf40
[    3.339286]  ? process_one_work+0x2f3/0xf40
[    3.339298]  worker_thread+0x315/0xc70
[    3.339309]  kthread+0x176/0x250
[    3.339314]  ? process_one_work+0xf40/0xf40
[    3.339318]  ? kthread_create_on_node+0x60/0x60
[    3.339324]  ret_from_fork+0x2e/0x40

[    3.339355] ======================================================
[    3.339499] 4.10.0-rc6-next-20170130-dirty #379 Tainted: G        W
[    3.339560] ------------------------------------------------------
[    3.339618] kworker/1:1/34 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[    3.339678]  (pcpu_alloc_mutex){+.+.+.}, at: [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
               and this task is already holding:
[    3.339805]  (&(&host->lock)->rlock#3){-.-...}, at: [<ffffffff91c2b6c5>] sdhci_request+0x55/0x220
[    3.339890] which would create a new lock dependency:
[    3.339937]  (&(&host->lock)->rlock#3){-.-...} -> (pcpu_alloc_mutex){+.+.+.}
               but this new dependency connects a HARDIRQ-irq-safe lock:
[    3.340077]  (&(&host->lock)->rlock#3){-.-...}
               ... which became HARDIRQ-irq-safe at:
[    3.340180] [<ffffffff91164956>] __lock_acquire+0x636/0x18b0
[    3.340251] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.340320] [<ffffffff9221a0b1>] _raw_spin_lock+0x41/0x80
[    3.340390] [<ffffffff91c2c37c>] sdhci_irq+0x2c/0xed0
[    3.340471] [<ffffffff91179281>] __handle_irq_event_percpu+0x61/0x6a0
[    3.340549] [<ffffffff911798f4>] handle_irq_event_percpu+0x34/0xb0
[    3.340625] [<ffffffff911799bb>] handle_irq_event+0x4b/0xc0
[    3.340694] [<ffffffff9117f7b8>] handle_fasteoi_irq+0xb8/0x330
[    3.340767] [<ffffffff91039e31>] handle_irq+0xa1/0x370
[    3.340835] [<ffffffff9221d6f3>] do_IRQ+0x83/0x1b0
[    3.340898] [<ffffffff9221bad0>] ret_from_intr+0x0/0x19
[    3.340967] [<ffffffff91c01564>] cpuidle_enter_state+0xe4/0x690
[    3.341041] [<ffffffff91c01b67>] cpuidle_enter+0x17/0x20
[    3.341109] [<ffffffff9114eef3>] do_idle+0x223/0x420
[    3.341175] [<ffffffff9114f96c>] cpu_startup_entry+0x7c/0x90
[    3.341248] [<ffffffff9220834c>] rest_init+0x15c/0x170
[    3.341315] [<ffffffff938a974c>] start_kernel+0x74e/0x78f
[    3.341383] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.341474] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.341549] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
               to a HARDIRQ-irq-unsafe lock:
[    3.341664]  (pcpu_alloc_mutex){+.+.+.}
               ... which became HARDIRQ-irq-unsafe at:
[    3.341758] ...
[    3.341780] [<ffffffff911649aa>] __lock_acquire+0x68a/0x18b0
[    3.341851] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.341919] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.345428] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.352339] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.358156] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.363931] [<ffffffff913bcd61>] alloc_kmem_cache_cpus.isra.33+0x31/0x140
[    3.370189] [<ffffffff913c2c9d>] __do_tune_cpucache+0x3d/0x220
[    3.375726] [<ffffffff913c2eaa>] do_tune_cpucache+0x2a/0x180
[    3.381049] [<ffffffff913c3099>] enable_cpucache+0x99/0x210
[    3.386394] [<ffffffff93918a9b>] kmem_cache_init_late+0x85/0xf4
[    3.391317] [<ffffffff938a94bb>] start_kernel+0x4bd/0x78f
[    3.394909] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.398076] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.401271] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
               other info that might help us debug this:

[    3.409256]  Possible interrupt unsafe locking scenario:

[    3.412429]        CPU0                    CPU1
[    3.414005]        ----                    ----
[    3.415578]   lock(pcpu_alloc_mutex);
[    3.417127]                                local_irq_disable();
[    3.418690]                                lock(&(&host->lock)->rlock#3);
[    3.420240]                                lock(pcpu_alloc_mutex);
[    3.421784]   <Interrupt>
[    3.423300]     lock(&(&host->lock)->rlock#3);
                *** DEADLOCK ***

[    3.429283] 3 locks held by kworker/1:1/34:
[    3.430771]  #0:  ("events_freezable"){.+.+.+}, at: [<ffffffff910f3ea3>] process_one_work+0x2f3/0xf40
[    3.433863]  #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<ffffffff910f3ea3>] process_one_work+0x2f3/0xf40
[    3.435446]  #2:  (&(&host->lock)->rlock#3){-.-...}, at: [<ffffffff91c2b6c5>] sdhci_request+0x55/0x220
               the dependencies between HARDIRQ-irq-safe lock and the holding lock:
[    3.441767] -> (&(&host->lock)->rlock#3){-.-...} ops: 242 {
[    3.443374]    IN-HARDIRQ-W at:
[    3.444974] [<ffffffff91164956>] __lock_acquire+0x636/0x18b0
[    3.448165] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.451356] [<ffffffff9221a0b1>] _raw_spin_lock+0x41/0x80
[    3.454560] [<ffffffff91c2c37c>] sdhci_irq+0x2c/0xed0
[    3.457745] [<ffffffff91179281>] __handle_irq_event_percpu+0x61/0x6a0
[    3.460929] [<ffffffff911798f4>] handle_irq_event_percpu+0x34/0xb0
[    3.464118] [<ffffffff911799bb>] handle_irq_event+0x4b/0xc0
[    3.467334] [<ffffffff9117f7b8>] handle_fasteoi_irq+0xb8/0x330
[    3.470594] [<ffffffff91039e31>] handle_irq+0xa1/0x370
[    3.473848] [<ffffffff9221d6f3>] do_IRQ+0x83/0x1b0
[    3.477151] [<ffffffff9221bad0>] ret_from_intr+0x0/0x19
[    3.480444] [<ffffffff91c01564>] cpuidle_enter_state+0xe4/0x690
[    3.483807] [<ffffffff91c01b67>] cpuidle_enter+0x17/0x20
[    3.487099] [<ffffffff9114eef3>] do_idle+0x223/0x420
[    3.490385] [<ffffffff9114f96c>] cpu_startup_entry+0x7c/0x90
[    3.493706] [<ffffffff9220834c>] rest_init+0x15c/0x170
[    3.496986] [<ffffffff938a974c>] start_kernel+0x74e/0x78f
[    3.500247] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.503518] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.506790] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
[    3.510045]    IN-SOFTIRQ-W at:
[    3.511680] [<ffffffff91164988>] __lock_acquire+0x668/0x18b0
[    3.514923] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.518148] [<ffffffff9221a33c>] _raw_spin_lock_irqsave+0x4c/0x90
[    3.521370] [<ffffffff91c2b8b8>] sdhci_tasklet_finish+0x28/0x290
[    3.524614] [<ffffffff910c5308>] tasklet_action+0x1e8/0x650
[    3.527872] [<ffffffff92220bb8>] __do_softirq+0x118/0xa7d
[    3.531142] [<ffffffff910c59bb>] irq_exit+0x10b/0x170
[    3.534460] [<ffffffff9221d6fc>] do_IRQ+0x8c/0x1b0
[    3.537808] [<ffffffff9221bad0>] ret_from_intr+0x0/0x19
[    3.541156] [<ffffffff91c01564>] cpuidle_enter_state+0xe4/0x690
[    3.544519] [<ffffffff91c01b67>] cpuidle_enter+0x17/0x20
[    3.547924] [<ffffffff9114eef3>] do_idle+0x223/0x420
[    3.566208] [<ffffffff9114f96c>] cpu_startup_entry+0x7c/0x90
[    3.569371] [<ffffffff9220834c>] rest_init+0x15c/0x170
[    3.572589] [<ffffffff938a974c>] start_kernel+0x74e/0x78f
[    3.575789] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.579007] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.582246] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
[    3.585474]    INITIAL USE at:
[    3.587071] [<ffffffff91164526>] __lock_acquire+0x206/0x18b0
[    3.590251] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.593438] [<ffffffff9221a33c>] _raw_spin_lock_irqsave+0x4c/0x90
[    3.596618] [<ffffffff91c296f3>] sdhci_set_ios+0x43/0x6c0
[    3.599774] [<ffffffff91c0a587>] mmc_set_initial_state+0x77/0xe0
[    3.602980] [<ffffffff91c0a90d>] mmc_power_up+0x5d/0x1d0
[    3.606193] [<ffffffff91c0bd26>] mmc_rescan+0x2d6/0x550
[    3.609398] [<ffffffff910f3f3a>] process_one_work+0x38a/0xf40
[    3.612619] [<ffffffff910f4e05>] worker_thread+0x315/0xc70
[    3.615838] [<ffffffff910ff616>] kthread+0x176/0x250
[    3.619044] [<ffffffff9221b39e>] ret_from_fork+0x2e/0x40
[    3.622257]  }
[    3.623875]  ... key      at: [<ffffffff949d4190>] __key.36450+0x0/0x8
[    3.625495]  ... acquired at:
[    3.627088] [<ffffffff91162c4e>] check_irq_usage+0x7e/0x230
[    3.630257] [<ffffffff9116575a>] __lock_acquire+0x143a/0x18b0
[    3.633441] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.636640] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.639832] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.643024] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.646205] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.649374] [<ffffffff91950e3c>] init_iova_domain+0xec/0x300
[    3.652552] [<ffffffff9195d62c>] find_or_alloc_domain.constprop.34+0x8c/0x4f0
[    3.655773] [<ffffffff9195fe11>] __get_valid_domain_for_dev+0x51/0x380
[    3.658961] [<ffffffff9196093d>] intel_map_sg+0x28d/0x3a0
[    3.662204] [<ffffffff91c29e62>] sdhci_pre_dma_transfer+0xf2/0x1c0
[    3.665556] [<ffffffff91c2a51a>] sdhci_send_command+0x55a/0x10d0
[    3.668817] [<ffffffff91c2b756>] sdhci_request+0xe6/0x220
[    3.672185] [<ffffffff91c082cb>] __mmc_start_request+0xab/0x4a0
[    3.675448] [<ffffffff91c08865>] mmc_start_request+0x1a5/0x2b0
[    3.678723] [<ffffffff91c094c7>] mmc_wait_for_req+0xc7/0x1e0
[    3.682009] [<ffffffff91c17dec>] mmc_app_send_scr+0x14c/0x200
[    3.685429] [<ffffffff91c15ef2>] mmc_sd_setup_card+0x32/0x7f0
[    3.688831] [<ffffffff91c16829>] mmc_sd_init_card+0x179/0xab0
[    3.692232] [<ffffffff91c174aa>] mmc_attach_sd+0xea/0x200
[    3.695746] [<ffffffff91c0bd86>] mmc_rescan+0x336/0x550
[    3.699206] [<ffffffff910f3f3a>] process_one_work+0x38a/0xf40
[    3.702748] [<ffffffff910f4e05>] worker_thread+0x315/0xc70
[    3.706067] [<ffffffff910ff616>] kthread+0x176/0x250
[    3.709612] [<ffffffff9221b39e>] ret_from_fork+0x2e/0x40

               the dependencies between the lock to be acquired
[    3.714749]  and HARDIRQ-irq-unsafe lock:
[    3.719802] -> (pcpu_alloc_mutex){+.+.+.} ops: 762 {
[    3.721616]    HARDIRQ-ON-W at:
[    3.723250] [<ffffffff911649aa>] __lock_acquire+0x68a/0x18b0
[    3.726700] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.729954] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.733392] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.736796] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.740221] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.743490] [<ffffffff913bcd61>] alloc_kmem_cache_cpus.isra.33+0x31/0x140
[    3.746906] [<ffffffff913c2c9d>] __do_tune_cpucache+0x3d/0x220
[    3.750278] [<ffffffff913c2eaa>] do_tune_cpucache+0x2a/0x180
[    3.755475] [<ffffffff913c3099>] enable_cpucache+0x99/0x210
[    3.758842] [<ffffffff93918a9b>] kmem_cache_init_late+0x85/0xf4
[    3.762197] [<ffffffff938a94bb>] start_kernel+0x4bd/0x78f
[    3.765565] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.768966] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.772350] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
[    3.775741]    SOFTIRQ-ON-W at:
[    3.777426] [<ffffffff911649d7>] __lock_acquire+0x6b7/0x18b0
[    3.780812] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.784135] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.787442] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.790698] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.793990] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.797269] [<ffffffff913bcd61>] alloc_kmem_cache_cpus.isra.33+0x31/0x140
[    3.800569] [<ffffffff913c2c9d>] __do_tune_cpucache+0x3d/0x220
[    3.803873] [<ffffffff913c2eaa>] do_tune_cpucache+0x2a/0x180
[    3.807175] [<ffffffff913c3099>] enable_cpucache+0x99/0x210
[    3.810481] [<ffffffff93918a9b>] kmem_cache_init_late+0x85/0xf4
[    3.813781] [<ffffffff938a94bb>] start_kernel+0x4bd/0x78f
[    3.817076] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.820379] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.823704] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
[    3.827021]    RECLAIM_FS-ON-W at:
[    3.828677] [<ffffffff91163bd3>] mark_held_locks+0x93/0x160
[    3.831433] usb 2-1.7: new high-speed USB device number 3 using ehci-pci
[    3.833654] [<ffffffff9116706b>] lockdep_trace_alloc+0xcb/0x150
[    3.836980] [<ffffffff9130f13a>] __alloc_pages_nodemask+0xba/0x540
[    3.840337] [<ffffffff91352fa2>] pcpu_populate_chunk+0xe2/0x8f0
[    3.843760] [<ffffffff913551bd>] pcpu_alloc+0x60d/0x900
[    3.847152] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.850579] [<ffffffff910f9a10>] __alloc_workqueue_key+0x270/0x8c0
[    3.854003] [<ffffffff938f8bb9>] cgroup_wq_init+0x3f/0x9a
[    3.857432] [<ffffffff91000471>] do_one_initcall+0x61/0x250
[    3.860873] [<ffffffff938a9c8f>] kernel_init_freeable+0x502/0x62f
[    3.864309] [<ffffffff9220836f>] kernel_init+0xf/0x120
[    3.867753] [<ffffffff9221b39e>] ret_from_fork+0x2e/0x40
[    3.871177]    INITIAL USE at:
[    3.872880] [<ffffffff91164526>] __lock_acquire+0x206/0x18b0
[    3.876260] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.879646] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.882982] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.886318] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.889651] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.892969] [<ffffffff913bcd61>] alloc_kmem_cache_cpus.isra.33+0x31/0x140
[    3.896313] [<ffffffff92209703>] setup_cpu_cache+0x33/0x270
[    3.899652] [<ffffffff913c3857>] __kmem_cache_create+0x247/0x300
[    3.902998] [<ffffffff9390fb09>] create_boot_cache+0x19a/0x1fb
[    3.906362] [<ffffffff93918943>] kmem_cache_init+0x111/0x1e4
[    3.916826] [<ffffffff938a9322>] start_kernel+0x324/0x78f
[    3.920181] [<ffffffff938a73b8>] x86_64_start_reservations+0x4f/0x70
[    3.923580] [<ffffffff938a7731>] x86_64_start_kernel+0x358/0x39f
[    3.926944] [<ffffffff910001c4>] verify_cpu+0x0/0xf1
[    3.930292]  }
[    3.931955]  ... key      at: [<ffffffff92ac0d10>] pcpu_alloc_mutex+0x70/0xa0
[    3.933650]  ... acquired at:
[    3.935323] [<ffffffff91162c4e>] check_irq_usage+0x7e/0x230
[    3.938658] [<ffffffff9116575a>] __lock_acquire+0x143a/0x18b0
[    3.941982] [<ffffffff911661c9>] lock_acquire+0x119/0x2d0
[    3.945303] [<ffffffff92210638>] __mutex_lock+0x88/0x17c0
[    3.948616] [<ffffffff92211d8b>] mutex_lock_nested+0x1b/0x20
[    3.951921] [<ffffffff91355086>] pcpu_alloc+0x4d6/0x900
[    3.955241] [<ffffffff913554e5>] __alloc_percpu+0x15/0x20
[    3.958570] [<ffffffff91950e3c>] init_iova_domain+0xec/0x300
[    3.961878] [<ffffffff9195d62c>] find_or_alloc_domain.constprop.34+0x8c/0x4f0
[    3.965156] [<ffffffff9195fe11>] __get_valid_domain_for_dev+0x51/0x380
[    3.968490] [<ffffffff9196093d>] intel_map_sg+0x28d/0x3a0
[    3.971821] [<ffffffff91c29e62>] sdhci_pre_dma_transfer+0xf2/0x1c0
[    3.974441] usb 2-1.8: new full-speed USB device number 4 using ehci-pci
[    3.976866] [<ffffffff91c2a51a>] sdhci_send_command+0x55a/0x10d0
[    3.980175] [<ffffffff91c2b756>] sdhci_request+0xe6/0x220
[    3.983543] [<ffffffff91c082cb>] __mmc_start_request+0xab/0x4a0
[    3.986903] [<ffffffff91c08865>] mmc_start_request+0x1a5/0x2b0
[    3.990288] [<ffffffff91c094c7>] mmc_wait_for_req+0xc7/0x1e0
[    3.993637] [<ffffffff91c17dec>] mmc_app_send_scr+0x14c/0x200
[    3.997010] [<ffffffff91c15ef2>] mmc_sd_setup_card+0x32/0x7f0
[    4.000412] [<ffffffff91c16829>] mmc_sd_init_card+0x179/0xab0
[    4.003825] [<ffffffff91c174aa>] mmc_attach_sd+0xea/0x200
[    4.007231] [<ffffffff91c0bd86>] mmc_rescan+0x336/0x550
[    4.010640] [<ffffffff910f3f3a>] process_one_work+0x38a/0xf40
[    4.014046] [<ffffffff910f4e05>] worker_thread+0x315/0xc70
[    4.017484] [<ffffffff910ff616>] kthread+0x176/0x250
[    4.020867] [<ffffffff9221b39e>] ret_from_fork+0x2e/0x40

               stack backtrace:
[    4.029156] CPU: 1 PID: 34 Comm: kworker/1:1 Tainted: G        W       4.10.0-rc6-next-20170130-dirty #379
[    4.030866] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A18 10/13/2016
[    4.032570] Workqueue: events_freezable mmc_rescan
[    4.034264] Call Trace:
[    4.035943]  dump_stack+0x7b/0xc8
[    4.037621]  check_usage+0x4f3/0x570
[    4.039279]  ? native_sched_clock+0xd5/0x200
[    4.040970]  check_irq_usage+0x7e/0x230
[    4.042652]  __lock_acquire+0x143a/0x18b0
[    4.044317]  ? dump_stack+0x9e/0xc8
[    4.045976]  lock_acquire+0x119/0x2d0
[    4.047624]  ? pcpu_alloc+0x4d6/0x900
[    4.049248]  ? pcpu_alloc+0x4d6/0x900
[    4.050857]  __mutex_lock+0x88/0x17c0
[    4.052449]  ? pcpu_alloc+0x4d6/0x900
[    4.054033]  ? __alloc_pages_nodemask+0x36c/0x540
[    4.055637]  ? pcpu_alloc+0x4d6/0x900
[    4.057221]  ? _raw_spin_unlock+0x69/0x80
[    4.058788]  ? cache_alloc_refill+0x90b/0x1310
[    4.060368]  mutex_lock_nested+0x1b/0x20
[    4.061923]  pcpu_alloc+0x4d6/0x900
[    4.063493]  ? debug_check_no_locks_freed+0xe1/0x200
[    4.065049]  __alloc_percpu+0x15/0x20
[    4.066612]  init_iova_domain+0xec/0x300
[    4.068151]  find_or_alloc_domain.constprop.34+0x8c/0x4f0
[    4.069704]  ? _raw_spin_lock_irqsave+0x78/0x90
[    4.071260]  __get_valid_domain_for_dev+0x51/0x380
[    4.072807]  ? do_raw_spin_unlock+0xdd/0x1d0
[    4.074356]  intel_map_sg+0x28d/0x3a0
[    4.075886]  ? mod_timer+0x2a7/0xb30
[    4.086650]  sdhci_pre_dma_transfer+0xf2/0x1c0
[    4.088222]  sdhci_send_command+0x55a/0x10d0
[    4.089703]  ? sdhci_request+0x55/0x220
[    4.091164]  sdhci_request+0xe6/0x220
[    4.092622]  __mmc_start_request+0xab/0x4a0
[    4.094068]  ? led_trigger_event+0x6f/0x90
[    4.095511]  mmc_start_request+0x1a5/0x2b0
[    4.096934]  mmc_wait_for_req+0xc7/0x1e0
[    4.098342]  mmc_app_send_scr+0x14c/0x200
[    4.099751]  ? mmc_align_data_size+0x20/0x20
[    4.101142]  mmc_sd_setup_card+0x32/0x7f0
[    4.102536]  mmc_sd_init_card+0x179/0xab0
[    4.103910]  ? _raw_spin_unlock_irqrestore+0x78/0xa0
[    4.105287]  mmc_attach_sd+0xea/0x200
[    4.106658]  mmc_rescan+0x336/0x550
[    4.108010]  process_one_work+0x38a/0xf40
[    4.109357]  ? process_one_work+0x2f3/0xf40
[    4.110707]  worker_thread+0x315/0xc70
[    4.112040]  kthread+0x176/0x250
[    4.113359]  ? process_one_work+0xf40/0xf40
[    4.114683]  ? kthread_create_on_node+0x60/0x60
[    4.115993]  ret_from_fork+0x2e/0x40
[    4.118134] tsc: Refined TSC clocksource calibration: 2691.258 MHz
[    4.119471] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x26cafc29fa8, max_idle_ns: 440795270837 ns
[    4.123247] mmc0: new high speed SDHC card at address aaaa


--==_Exmh_1486142856_2881P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.5 07/13/2001

iQEVAwUBWJS9iI0DS38y7CIcAQIWjgf/aGXLL0qk55icd6yMI8TW0wcjMaOMsYDA
+Y/qdbW0zwSHg/QSImFIcik9DMat4odQki/8y9Yfvc6XTBcuXl5bJdYr03fTNwUV
9F4BPySIYbjQRSqVRYhXuICjPPKv3pbhNTjcZ/Vkl3z0L2tcVKI1HphVFePkjbWQ
JUqXgvz6ls+NpfXDtzotvqwlYnzLM0E0y0pQos5PIDr3vFm3dhLDSRgooSFWXNt2
AmCruh9LWMK3g+vC9Po272g5u8ydFzPquvwBArCI6CIrkK0MWCVW7u4ZHyapkvlt
PWG5RT1zeC+qWRnhNyBodORMCI6l0JSQKZidRWA2omQth0RJqYXJAQ==
=KDSV
-----END PGP SIGNATURE-----

--==_Exmh_1486142856_2881P--
