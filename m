From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: Warnings for invalid VDD (sdhci-s3c)
Date: Mon, 28 Mar 2016 17:09:14 +0530
Message-ID: <CANAwSgSzVCML2ZqO5Xz=W1GVFLcdfHyeBC=heDt9P6oqWxwq5g@mail.gmail.com>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
 <20160324155840.50474b98@xhacker> <56F3A0B7.4050509@samsung.com>
 <20160324162449.29c9cf78@xhacker> <56F3A88F.50603@samsung.com>
 <56F3E77D.7030201@intel.com> <20160324140307.GH12245@odux.rfo.atmel.com>
 <56F3FB13.9040505@intel.com> <CANAwSgToE8mg7SKSgcs66WEFCp0TOY-GrnkpBqmsDA3=mhy-yg@mail.gmail.com>
 <56F8C246.7060302@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113deb18e163bc052f1a5d32
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56F8C246.7060302@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

--001a113deb18e163bc052f1a5d32
Content-Type: text/plain; charset=UTF-8

Hi Krzysztof,

On 28 March 2016 at 11:03, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On 27.03.2016 16:41, Anand Moon wrote:
>>
>> On My Odroid U3 with debug flags enable I am observing bellow deadlock.
>
> There is a sleep in atomic context and possible deadlock, but:
> 1. Are you sure it does not happen without the patch?

I have tested this with this patch applied.

> 2. Are you sure it is not the same as already known issue on sdhci-s3c?
> For example reported here:
> http://www.spinics.net/lists/linux-samsung-soc/msg42398.html

Ok this is know issue.

>
> What is reproducibility rate?

It's reproducible intermediately.
If I am doing some thing wrong please ignore this.
Attach is the config options.

Best Regards.
-Anand Moon

>
> Best regards,
> Krzysztof
>
>> ---------------------------------------------------------------------------------------------------------
>> [  202.519524] BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:617
>> [  202.522364] in_atomic(): 1, irqs_disabled(): 128, pid: 100, name: mmcqd/0
>> [  202.529129] 1 lock held by mmcqd/0/100:
>> [  202.529150]  #0:  (&(&host->lock)->rlock#2){-.-...}, at:
>> [<c059db68>] sdhci_do_set_ios+0x1c/0x484
>> [  202.529271] irq event stamp: 703530
>> [  202.529291] hardirqs last  enabled at (703529): [<c076d108>]
>> _raw_spin_unlock_irqrestore+0x6c/0x74
>> [  202.529343] hardirqs last disabled at (703530): [<c076cea8>]
>> _raw_spin_lock_irqsave+0x1c/0x84
>> [  202.529384] softirqs last  enabled at (703456): [<c0127518>]
>> __do_softirq+0x244/0x2c0
>> [  202.529438] softirqs last disabled at (703445): [<c0127938>]
>> irq_exit+0xec/0x128
>> [  202.529472] Preemption disabled at:[<  (null)>]   (null)
>> [  202.534415]
>> [  202.534449] CPU: 0 PID: 100 Comm: mmcqd/0 Not tainted 4.6.0-rc1-u3s #38
>> [  202.534473] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [  202.534544] [<c010ee2c>] (unwind_backtrace) from [<c010bab8>]
>> (show_stack+0x10/0x14)
>> [  202.534594] [<c010bab8>] (show_stack) from [<c037e0c0>]
>> (dump_stack+0x98/0xc4)
>> [  202.534639] [<c037e0c0>] (dump_stack) from [<c0768934>]
>> (mutex_lock_nested+0x2c/0x4dc)
>> [  202.534685] [<c0768934>] (mutex_lock_nested) from [<c05c00a0>]
>> (clk_prepare_lock+0x50/0xf8)
>> [  202.534726] [<c05c00a0>] (clk_prepare_lock) from [<c05c14b0>]
>> (clk_round_rate+0x1c/0x58)
>> [  202.534773] [<c05c14b0>] (clk_round_rate) from [<c05a00a0>]
>> (sdhci_s3c_set_clock+0x18c/0x1b0)
>> [  202.534819] [<c05a00a0>] (sdhci_s3c_set_clock) from [<c05a00e8>]
>> (sdhci_cmu_set_clock+0x24/0x17c)
>> [  202.534860] [<c05a00e8>] (sdhci_cmu_set_clock) from [<c059dbc4>]
>> (sdhci_do_set_ios+0x78/0x484)
>> [  202.534904] [<c059dbc4>] (sdhci_do_set_ios) from [<c059e1a8>]
>> (sdhci_runtime_resume_host+0x60/0x114)
>> [  202.534957] [<c059e1a8>] (sdhci_runtime_resume_host) from
>> [<c04728c8>] (__rpm_callback+0x2c/0x60)
>> [  202.535000] [<c04728c8>] (__rpm_callback) from [<c0472950>]
>> (rpm_callback+0x54/0x80)
>> [  202.535041] [<c0472950>] (rpm_callback) from [<c0473830>]
>> (rpm_resume+0x364/0x558)
>> [  202.535081] [<c0473830>] (rpm_resume) from [<c0473a84>]
>> (__pm_runtime_resume+0x60/0x8c)
>> [  202.535125] [<c0473a84>] (__pm_runtime_resume) from [<c0588f50>]
>> (__mmc_claim_host+0x1b4/0x1f8)
>> [  202.535176] [<c0588f50>] (__mmc_claim_host) from [<c059174c>]
>> (mmc_sd_runtime_resume+0x20/0xac)
>> [  202.535220] [<c059174c>] (mmc_sd_runtime_resume) from [<c04728c8>]
>> (__rpm_callback+0x2c/0x60)
>> [  202.535259] [<c04728c8>] (__rpm_callback) from [<c0472950>]
>> (rpm_callback+0x54/0x80)
>> [  202.535299] [<c0472950>] (rpm_callback) from [<c0473830>]
>> (rpm_resume+0x364/0x558)
>> [  202.535340] [<c0473830>] (rpm_resume) from [<c0473a84>]
>> (__pm_runtime_resume+0x60/0x8c)
>> [  202.535379] [<c0473a84>] (__pm_runtime_resume) from [<c0588fa8>]
>> (mmc_get_card+0x14/0x24)
>> [  202.535420] [<c0588fa8>] (mmc_get_card) from [<c0598b50>]
>> (mmc_blk_issue_rq+0x258/0x4f0)
>> [  202.535461] [<c0598b50>] (mmc_blk_issue_rq) from [<c059a4b0>]
>> (mmc_queue_thread+0xd0/0x1d8)
>> [  202.535513] [<c059a4b0>] (mmc_queue_thread) from [<c0142c6c>]
>> (kthread+0xf4/0x10c)
>> [  202.535561] [<c0142c6c>] (kthread) from [<c0107950>]
>> (ret_from_fork+0x14/0x24)
>> [  202.535624]
>> [  202.535893] ======================================================
>> [  202.542059] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
>> [  202.548742] 4.6.0-rc1-u3s #38 Not tainted
>> [  202.552732] ------------------------------------------------------
>> [  202.558902] mmcqd/0/100 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>> [  202.565317]  (prepare_lock){+.+...}, at: [<c05c00a0>]
>> clk_prepare_lock+0x50/0xf8
>> [  202.572695]
>> [  202.572695] and this task is already holding:
>> [  202.578510]  (&(&host->lock)->rlock#2){-.-...}, at: [<c059db68>]
>> sdhci_do_set_ios+0x1c/0x484
>> [  202.586930] which would create a new lock dependency:
>> [  202.591964]  (&(&host->lock)->rlock#2){-.-...} -> (prepare_lock){+.+...}
>> [  202.598650]
>> [  202.598650] but this new dependency connects a HARDIRQ-irq-safe lock:
>> [  202.606546]  (&(&host->lock)->rlock#2){-.-...}
>> [  202.606546] ... which became HARDIRQ-irq-safe at:
>> [  202.614359]   [<c076cc5c>] _raw_spin_lock+0x3c/0x74
>> [  202.619219]   [<c059f44c>] sdhci_irq+0x1c/0x814
>> [  202.623732]   [<c01810e8>] handle_irq_event_percpu+0x9c/0x150
>> [  202.629461]   [<c01811d4>] handle_irq_event+0x38/0x5c
>> [  202.634495]   [<c0184504>] handle_fasteoi_irq+0xd0/0x1a8
>> [  202.639790]   [<c0180704>] generic_handle_irq+0x24/0x34
>> [  202.644998]   [<c0180a18>] __handle_domain_irq+0x7c/0xec
>> [  202.650293]   [<c0101514>] gic_handle_irq+0x54/0x94
>> [  202.655154]   [<c010c5b8>] __irq_svc+0x58/0x98
>> [  202.659581]   [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  202.664354]   [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  202.669128]   [<c0167100>] cpu_startup_entry+0x1c8/0x24c
>> [  202.674423]   [<c0b00c88>] start_kernel+0x39c/0x3a8
>> [  202.679284]   [<4000807c>] 0x4000807c
>> [  202.682933]
>> [  202.682933] to a HARDIRQ-irq-unsafe lock:
>> [  202.688399]  (prepare_lock){+.+...}
>> [  202.688399] ... which became HARDIRQ-irq-unsafe at:
>> [  202.695429] ...  [<c07687e8>] mutex_trylock+0x130/0x250
>> [  202.700637]   [<c05c0060>] clk_prepare_lock+0x10/0xf8
>> [  202.705672]   [<c05c2a0c>] __clk_create_clk.part.13+0x4c/0x80
>> [  202.711400]   [<c05c33e8>] __of_clk_get_from_provider+0x88/0xf8
>> [  202.717303]   [<c05bfb08>] __of_clk_get_by_name+0xfc/0x114
>> [  202.722771]   [<c05bfb68>] clk_get+0x2c/0x5c
>> [  202.727024]   [<c05bf62c>] devm_clk_get+0x3c/0x78
>> [  202.731712]   [<c0b1d8a4>] exynos_sysmmu_probe+0xe8/0x310
>> [  202.737093]   [<c046baa4>] platform_drv_probe+0x4c/0xb0
>> [  202.742301]   [<c046a2a4>] driver_probe_device+0x20c/0x2b8
>> [  202.747769]   [<c046863c>] bus_for_each_drv+0x60/0x94
>> [  202.752804]   [<c0469fb8>] __device_attach+0xb4/0x118
>> [  202.757838]   [<c046945c>] bus_probe_device+0x88/0x90
>> [  202.762873]   [<c0467794>] device_add+0x370/0x570
>> [  202.767560]   [<c05babe0>] of_platform_device_create_pdata+0x84/0xb8
>> [  202.773896]   [<c0b1d784>] exynos_iommu_of_setup+0x120/0x158
>> [  202.779538]   [<c0b1d59c>] of_iommu_init+0x44/0x78
>> [  202.784312]   [<c0b03594>] customize_machine+0x8/0x44
>> [  202.789347]   [<c01017f4>] do_one_initcall+0x90/0x1dc
>> [  202.794381]   [<c0b00dec>] kernel_init_freeable+0x158/0x1e8
>> [  202.799936]   [<c076527c>] kernel_init+0x8/0x114
>> [  202.804537]   [<c0107950>] ret_from_fork+0x14/0x24
>> [  202.809313]
>> [  202.809313] other info that might help us debug this:
>> [  202.809313]
>> [  202.817299]  Possible interrupt unsafe locking scenario:
>> [  202.817299]
>> [  202.824068]        CPU0                    CPU1
>> [  202.828581]        ----                    ----
>> [  202.833094]   lock(prepare_lock);
>> [  202.836394]                                local_irq_disable();
>> [  202.842295]                                lock(&(&host->lock)->rlock#2);
>> [  202.849065]                                lock(prepare_lock);
>> [  202.854881]   <Interrupt>
>> [  202.857484]     lock(&(&host->lock)->rlock#2);
>> [  202.861912]
>> [  202.861912]  *** DEADLOCK ***
>> [  202.861912]
>> [  202.867820] 1 lock held by mmcqd/0/100:
>> [  202.871634]  #0:  (&(&host->lock)->rlock#2){-.-...}, at:
>> [<c059db68>] sdhci_do_set_ios+0x1c/0x484
>> [  202.880489]
>> [  202.880489] the dependencies between HARDIRQ-irq-safe lock and the
>> holding lock:
>> [  202.888106] -> (&(&host->lock)->rlock#2){-.-...} ops: 69588 {
>> [  202.893768]    IN-HARDIRQ-W at:
>> [  202.896893]                     [<c076cc5c>] _raw_spin_lock+0x3c/0x74
>> [  202.903316]                     [<c059f44c>] sdhci_irq+0x1c/0x814
>> [  202.909392]                     [<c01810e8>]
>> handle_irq_event_percpu+0x9c/0x150
>> [  202.916683]                     [<c01811d4>] handle_irq_event+0x38/0x5c
>> [  202.923280]                     [<c0184504>] handle_fasteoi_irq+0xd0/0x1a8
>> [  202.930137]                     [<c0180704>] generic_handle_irq+0x24/0x34
>> [  202.936908]                     [<c0180a18>] __handle_domain_irq+0x7c/0xec
>> [  202.943765]                     [<c0101514>] gic_handle_irq+0x54/0x94
>> [  202.950188]                     [<c010c5b8>] __irq_svc+0x58/0x98
>> [  202.956177]                     [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  202.962513]                     [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  202.968850]                     [<c0167100>] cpu_startup_entry+0x1c8/0x24c
>> [  202.975707]                     [<c0b00c88>] start_kernel+0x39c/0x3a8
>> [  202.982130]                     [<4000807c>] 0x4000807c
>> [  202.987340]    IN-SOFTIRQ-W at:
>> [  202.990463]                     [<c076ced4>] _raw_spin_lock_irqsave+0x48/0x84
>> [  202.997581]                     [<c059d71c>] sdhci_tasklet_finish+0x18/0x1f4
>> [  203.004611]                     [<c01271b4>] tasklet_action+0xac/0x164
>> [  203.011122]                     [<c012743c>] __do_softirq+0x168/0x2c0
>> [  203.017544]                     [<c0127938>] irq_exit+0xec/0x128
>> [  203.023534]                     [<c0180a1c>] __handle_domain_irq+0x80/0xec
>> [  203.030391]                     [<c0101514>] gic_handle_irq+0x54/0x94
>> [  203.036814]                     [<c010c5b8>] __irq_svc+0x58/0x98
>> [  203.042804]                     [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  203.049140]                     [<c01083b8>] arch_cpu_idle+0x24/0x3c
>> [  203.055476]                     [<c0167100>] cpu_startup_entry+0x1c8/0x24c
>> [  203.062334]                     [<c0b00c88>] start_kernel+0x39c/0x3a8
>> [  203.068756]                     [<4000807c>] 0x4000807c
>> [  203.073966]    INITIAL USE at:
>> [  203.077003]                    [<c076ced4>] _raw_spin_lock_irqsave+0x48/0x84
>> [  203.084033]                    [<c059db68>] sdhci_do_set_ios+0x1c/0x484
>> [  203.090630]                    [<c059e1a8>]
>> sdhci_runtime_resume_host+0x60/0x114
>> [  203.098008]                    [<c04728c8>] __rpm_callback+0x2c/0x60
>> [  203.104345]                    [<c047291c>] rpm_callback+0x20/0x80
>> [  203.110507]                    [<c0473830>] rpm_resume+0x364/0x558
>> [  203.116670]                    [<c0473a84>] __pm_runtime_resume+0x60/0x8c
>> [  203.123440]                    [<c0588f50>] __mmc_claim_host+0x1b4/0x1f8
>> [  203.130124]                    [<c058b9fc>] mmc_start_host+0x34/0xa8
>> [  203.136461]                    [<c058cb00>] mmc_add_host+0x5c/0x80
>> [  203.142624]                    [<c059eb20>] sdhci_add_host+0x8c4/0xdec
>> [  203.149133]                    [<c05a0704>] sdhci_s3c_probe+0x4c4/0x568
>> [  203.155730]                    [<c046baa4>] platform_drv_probe+0x4c/0xb0
>> [  203.162414]                    [<c046a2a4>] driver_probe_device+0x20c/0x2b8
>> [  203.169358]                    [<c046a410>] __driver_attach+0xc0/0xc4
>> [  203.175781]                    [<c0468594>] bus_for_each_dev+0x68/0x9c
>> [  203.182291]                    [<c046970c>] bus_add_driver+0x1a0/0x218
>> [  203.188801]                    [<c046ab24>] driver_register+0x78/0xf8
>> [  203.195224]                    [<c01017f4>] do_one_initcall+0x90/0x1dc
>> [  203.201734]                    [<c0b00dec>] kernel_init_freeable+0x158/0x1e8
>> [  203.208765]                    [<c076527c>] kernel_init+0x8/0x114
>> [  203.214841]                    [<c0107950>] ret_from_fork+0x14/0x24
>> [  203.221091]  }
>> [  203.222740]  ... key      at: [<c1617248>] __key.32364+0x0/0x8
>> [  203.228556]  ... acquired at:
>> [  203.231506]    [<c0174a48>] lock_acquire+0xa8/0xd0
>> [  203.236280]    [<c0768980>] mutex_lock_nested+0x78/0x4dc
>> [  203.241575]    [<c05c00a0>] clk_prepare_lock+0x50/0xf8
>> [  203.246696]    [<c05c14b0>] clk_round_rate+0x1c/0x58
>> [  203.251643]    [<c05a00a0>] sdhci_s3c_set_clock+0x18c/0x1b0
>> [  203.257199]    [<c05a00e8>] sdhci_cmu_set_clock+0x24/0x17c
>> [  203.262667]    [<c059dbc4>] sdhci_do_set_ios+0x78/0x484
>> [  203.267875]    [<c059e1a8>] sdhci_runtime_resume_host+0x60/0x114
>> [  203.273864]    [<c04728c8>] __rpm_callback+0x2c/0x60
>> [  203.278812]    [<c0472950>] rpm_callback+0x54/0x80
>> [  203.283586]    [<c0473830>] rpm_resume+0x364/0x558
>> [  203.288359]    [<c0473a84>] __pm_runtime_resume+0x60/0x8c
>> [  203.293741]    [<c0588f50>] __mmc_claim_host+0x1b4/0x1f8
>> [  203.299036]    [<c059174c>] mmc_sd_runtime_resume+0x20/0xac
>> [  203.304591]    [<c04728c8>] __rpm_callback+0x2c/0x60
>> [  203.309539]    [<c0472950>] rpm_callback+0x54/0x80
>> [  203.314313]    [<c0473830>] rpm_resume+0x364/0x558
>> [  203.319087]    [<c0473a84>] __pm_runtime_resume+0x60/0x8c
>> [  203.324468]    [<c0588fa8>] mmc_get_card+0x14/0x24
>> [  203.329243]    [<c0598b50>] mmc_blk_issue_rq+0x258/0x4f0
>> [  203.334538]    [<c059a4b0>] mmc_queue_thread+0xd0/0x1d8
>> [  203.339745]    [<c0142c6c>] kthread+0xf4/0x10c
>> [  203.344172]    [<c0107950>] ret_from_fork+0x14/0x24
>> [  203.349033]
>> [  203.350509]
>> [  203.350509] the dependencies between the lock to be acquired and
>> HARDIRQ-irq-unsafe lock:
>> [  203.358904] -> (prepare_lock){+.+...} ops: 5285 {
>> [  203.363531]    HARDIRQ-ON-W at:
>> [  203.366654]                     [<c07687e8>] mutex_trylock+0x130/0x250
>> [  203.373164]                     [<c05c0060>] clk_prepare_lock+0x10/0xf8
>> [  203.379761]                     [<c05c2a0c>]
>> __clk_create_clk.part.13+0x4c/0x80
>> [  203.387052]                     [<c05c33e8>]
>> __of_clk_get_from_provider+0x88/0xf8
>> [  203.394517]                     [<c05bfb08>] __of_clk_get_by_name+0xfc/0x114
>> [  203.401548]                     [<c05bfb68>] clk_get+0x2c/0x5c
>> [  203.407363]                     [<c05bf62c>] devm_clk_get+0x3c/0x78
>> [  203.413613]                     [<c0b1d8a4>] exynos_sysmmu_probe+0xe8/0x310
>> [  203.420557]                     [<c046baa4>] platform_drv_probe+0x4c/0xb0
>> [  203.427327]                     [<c046a2a4>] driver_probe_device+0x20c/0x2b8
>> [  203.434358]                     [<c046863c>] bus_for_each_drv+0x60/0x94
>> [  203.440955]                     [<c0469fb8>] __device_attach+0xb4/0x118
>> [  203.447552]                     [<c046945c>] bus_probe_device+0x88/0x90
>> [  203.454149]                     [<c0467794>] device_add+0x370/0x570
>> [  203.460399]                     [<c05babe0>]
>> of_platform_device_create_pdata+0x84/0xb8
>> [  203.468297]                     [<c0b1d784>]
>> exynos_iommu_of_setup+0x120/0x158
>> [  203.475501]                     [<c0b1d59c>] of_iommu_init+0x44/0x78
>> [  203.481838]                     [<c0b03594>] customize_machine+0x8/0x44
>> [  203.488434]                     [<c01017f4>] do_one_initcall+0x90/0x1dc
>> [  203.495031]                     [<c0b00dec>] kernel_init_freeable+0x158/0x1e8
>> [  203.502149]                     [<c076527c>] kernel_init+0x8/0x114
>> [  203.508312]                     [<c0107950>] ret_from_fork+0x14/0x24
>> [  203.514650]    SOFTIRQ-ON-W at:
>> [  203.517773]                     [<c07687e8>] mutex_trylock+0x130/0x250
>> [  203.524283]                     [<c05c0060>] clk_prepare_lock+0x10/0xf8
>> [  203.530880]                     [<c05c2a0c>]
>> __clk_create_clk.part.13+0x4c/0x80
>> [  203.538171]                     [<c05c33e8>]
>> __of_clk_get_from_provider+0x88/0xf8
>> [  203.545636]                     [<c05bfb08>] __of_clk_get_by_name+0xfc/0x114
>> [  203.552666]                     [<c05bfb68>] clk_get+0x2c/0x5c
>> [  203.558482]                     [<c05bf62c>] devm_clk_get+0x3c/0x78
>> [  203.564732]                     [<c0b1d8a4>] exynos_sysmmu_probe+0xe8/0x310
>> [  203.571676]                     [<c046baa4>] platform_drv_probe+0x4c/0xb0
>> [  203.578446]                     [<c046a2a4>] driver_probe_device+0x20c/0x2b8
>> [  203.585477]                     [<c046863c>] bus_for_each_drv+0x60/0x94
>> [  203.592074]                     [<c0469fb8>] __device_attach+0xb4/0x118
>> [  203.598671]                     [<c046945c>] bus_probe_device+0x88/0x90
>> [  203.605267]                     [<c0467794>] device_add+0x370/0x570
>> [  203.611517]                     [<c05babe0>]
>> of_platform_device_create_pdata+0x84/0xb8
>> [  203.619416]                     [<c0b1d784>]
>> exynos_iommu_of_setup+0x120/0x158
>> [  203.626620]                     [<c0b1d59c>] of_iommu_init+0x44/0x78
>> [  203.632956]                     [<c0b03594>] customize_machine+0x8/0x44
>> [  203.639553]                     [<c01017f4>] do_one_initcall+0x90/0x1dc
>> [  203.646150]                     [<c0b00dec>] kernel_init_freeable+0x158/0x1e8
>> [  203.653268]                     [<c076527c>] kernel_init+0x8/0x114
>> [  203.659431]                     [<c0107950>] ret_from_fork+0x14/0x24
>> [  203.665768]    INITIAL USE at:
>> [  203.668805]                    [<c07687b0>] mutex_trylock+0xf8/0x250
>> [  203.675142]                    [<c05c0060>] clk_prepare_lock+0x10/0xf8
>> [  203.681651]                    [<c05c2a0c>]
>> __clk_create_clk.part.13+0x4c/0x80
>> [  203.688856]                    [<c05c2d2c>] clk_register+0x1b8/0x5f0
>> [  203.695192]                    [<c05c4564>]
>> clk_register_fixed_rate_with_accuracy+0x94/0xc4
>> [  203.703525]                    [<c05c45ac>] clk_register_fixed_rate+0x18/0x20
>> [  203.710642]                    [<c0b249fc>]
>> samsung_clk_register_fixed_rate+0x4c/0xb8
>> [  203.718455]                    [<c0b24af8>]
>> samsung_clk_of_register_fixed_ext+0x90/0x98
>> [  203.726440]                    [<c0b25800>] exynos4_clk_init+0x88/0x5b0
>> [  203.733037]                    [<c0b24650>] of_clk_init+0x14c/0x1d8
>> [  203.739287]                    [<c0b04488>] time_init+0x24/0x2c
>> [  203.745189]                    [<c0b00b4c>] start_kernel+0x260/0x3a8
>> [  203.751526]                    [<4000807c>] 0x4000807c
>> [  203.756647]  }
>> [  203.758296]  ... key      at: [<c0d3bf80>] prepare_lock+0x3c/0x54
>> [  203.764373]  ... acquired at:
>> [  203.767322]    [<c0174a48>] lock_acquire+0xa8/0xd0
>> [  203.772096]    [<c0768980>] mutex_lock_nested+0x78/0x4dc
>> [  203.777391]    [<c05c00a0>] clk_prepare_lock+0x50/0xf8
>> [  203.782512]    [<c05c14b0>] clk_round_rate+0x1c/0x58
>> [  203.787460]    [<c05a00a0>] sdhci_s3c_set_clock+0x18c/0x1b0
>> [  203.793015]    [<c05a00e8>] sdhci_cmu_set_clock+0x24/0x17c
>> [  203.798484]    [<c059dbc4>] sdhci_do_set_ios+0x78/0x484
>> [  203.803691]    [<c059e1a8>] sdhci_runtime_resume_host+0x60/0x114
>> [  203.809680]    [<c04728c8>] __rpm_callback+0x2c/0x60
>> [  203.814628]    [<c0472950>] rpm_callback+0x54/0x80
>> [  203.819402]    [<c0473830>] rpm_resume+0x364/0x558
>> [  203.824176]    [<c0473a84>] __pm_runtime_resume+0x60/0x8c
>> [  203.829558]    [<c0588f50>] __mmc_claim_host+0x1b4/0x1f8
>> [  203.834852]    [<c059174c>] mmc_sd_runtime_resume+0x20/0xac
>> [  203.840408]    [<c04728c8>] __rpm_callback+0x2c/0x60
>> [  203.845355]    [<c0472950>] rpm_callback+0x54/0x80
>> [  203.850129]    [<c0473830>] rpm_resume+0x364/0x558
>> [  203.854903]    [<c0473a84>] __pm_runtime_resume+0x60/0x8c
>> [  203.860285]    [<c0588fa8>] mmc_get_card+0x14/0x24
>> [  203.865059]    [<c0598b50>] mmc_blk_issue_rq+0x258/0x4f0
>> [  203.870354]    [<c059a4b0>] mmc_queue_thread+0xd0/0x1d8
>> [  203.875562]    [<c0142c6c>] kthread+0xf4/0x10c
>> [  203.879988]    [<c0107950>] ret_from_fork+0x14/0x24
>> [  203.884850]
>> [  203.886326]
>> [  203.886326] stack backtrace:
>> [  203.890679] CPU: 0 PID: 100 Comm: mmcqd/0 Not tainted 4.6.0-rc1-u3s #38
>> [  203.897266] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [  203.903374] [<c010ee2c>] (unwind_backtrace) from [<c010bab8>]
>> (show_stack+0x10/0x14)
>> [  203.911089] [<c010bab8>] (show_stack) from [<c037e0c0>]
>> (dump_stack+0x98/0xc4)
>> [  203.918296] [<c037e0c0>] (dump_stack) from [<c017098c>]
>> (check_usage+0x49c/0x658)
>> [  203.925757] [<c017098c>] (check_usage) from [<c0170ba8>]
>> (check_irq_usage+0x60/0xb8)
>> [  203.933509] [<c0170ba8>] (check_irq_usage) from [<c0173404>]
>> (__lock_acquire+0x15c8/0x201c)
>> [  203.941844] [<c0173404>] (__lock_acquire) from [<c0174a48>]
>> (lock_acquire+0xa8/0xd0)
>> [  203.949598] [<c0174a48>] (lock_acquire) from [<c0768980>]
>> (mutex_lock_nested+0x78/0x4dc)
>> [  203.957639] [<c0768980>] (mutex_lock_nested) from [<c05c00a0>]
>> (clk_prepare_lock+0x50/0xf8)
>> [  203.965969] [<c05c00a0>] (clk_prepare_lock) from [<c05c14b0>]
>> (clk_round_rate+0x1c/0x58)
>> [  203.974085] [<c05c14b0>] (clk_round_rate) from [<c05a00a0>]
>> (sdhci_s3c_set_clock+0x18c/0x1b0)
>> [  203.982551] [<c05a00a0>] (sdhci_s3c_set_clock) from [<c05a00e8>]
>> (sdhci_cmu_set_clock+0x24/0x17c)
>> [  203.991403] [<c05a00e8>] (sdhci_cmu_set_clock) from [<c059dbc4>]
>> (sdhci_do_set_ios+0x78/0x484)
>> [  203.999993] [<c059dbc4>] (sdhci_do_set_ios) from [<c059e1a8>]
>> (sdhci_runtime_resume_host+0x60/0x114)
>> [  204.009094] [<c059e1a8>] (sdhci_runtime_resume_host) from
>> [<c04728c8>] (__rpm_callback+0x2c/0x60)
>> [  204.017938] [<c04728c8>] (__rpm_callback) from [<c0472950>]
>> (rpm_callback+0x54/0x80)
>> [  204.025661] [<c0472950>] (rpm_callback) from [<c0473830>]
>> (rpm_resume+0x364/0x558)
>> [  204.033214] [<c0473830>] (rpm_resume) from [<c0473a84>]
>> (__pm_runtime_resume+0x60/0x8c)
>> [  204.041201] [<c0473a84>] (__pm_runtime_resume) from [<c0588f50>]
>> (__mmc_claim_host+0x1b4/0x1f8)
>> [  204.049885] [<c0588f50>] (__mmc_claim_host) from [<c059174c>]
>> (mmc_sd_runtime_resume+0x20/0xac)
>> [  204.058563] [<c059174c>] (mmc_sd_runtime_resume) from [<c04728c8>]
>> (__rpm_callback+0x2c/0x60)
>> [  204.067063] [<c04728c8>] (__rpm_callback) from [<c0472950>]
>> (rpm_callback+0x54/0x80)
>> [  204.074788] [<c0472950>] (rpm_callback) from [<c0473830>]
>> (rpm_resume+0x364/0x558)
>> [  204.082340] [<c0473830>] (rpm_resume) from [<c0473a84>]
>> (__pm_runtime_resume+0x60/0x8c)
>> [  204.090326] [<c0473a84>] (__pm_runtime_resume) from [<c0588fa8>]
>> (mmc_get_card+0x14/0x24)
>> [  204.098487] [<c0588fa8>] (mmc_get_card) from [<c0598b50>]
>> (mmc_blk_issue_rq+0x258/0x4f0)
>> [  204.106559] [<c0598b50>] (mmc_blk_issue_rq) from [<c059a4b0>]
>> (mmc_queue_thread+0xd0/0x1d8)
>> [  204.114903] [<c059a4b0>] (mmc_queue_thread) from [<c0142c6c>]
>> (kthread+0xf4/0x10c)
>> [  204.122452] [<c0142c6c>] (kthread) from [<c0107950>]
>> (ret_from_fork+0x14/0x24)
>> ---------------------------------------------------------------------------------------------------------
>>
>> Best Regards
>> -Anand Moon
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

--001a113deb18e163bc052f1a5d32
Content-Type: application/octet-stream; name=defconfig
Content-Disposition: attachment; filename=defconfig
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imbx3wmu0

IyBDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE8gaXMgbm90IHNldApDT05GSUdfU1lTVklQQz15CkNP
TkZJR19GSEFORExFPXkKQ09ORklHX0lSUV9ET01BSU5fREVCVUc9eQpDT05GSUdfTk9fSFo9eQpD
T05GSUdfSElHSF9SRVNfVElNRVJTPXkKQ09ORklHX0lSUV9USU1FX0FDQ09VTlRJTkc9eQpDT05G
SUdfVEFTS1NUQVRTPXkKQ09ORklHX1RBU0tfREVMQVlfQUNDVD15CkNPTkZJR19UQVNLX1hBQ0NU
PXkKQ09ORklHX1RBU0tfSU9fQUNDT1VOVElORz15CkNPTkZJR19SQ1VfRVhQRVJUPXkKQ09ORklH
X1JDVV9GQVNUX05PX0haPXkKQ09ORklHX1JDVV9CT09TVD15CkNPTkZJR19DR1JPVVBTPXkKQ09O
RklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX0VNQkVEREVEPXkKQ09ORklHX1BFUkZfRVZFTlRT
PXkKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9EVUxFX1VOTE9BRD15CiMgQ09ORklHX0JMS19E
RVZfQlNHIGlzIG5vdCBzZXQKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CkNPTkZJR19BUkNI
X0VYWU5PUz15CkNPTkZJR19BUkNIX0VYWU5PUzM9eQpDT05GSUdfRVhZTk9TNTQyMF9NQ1BNPXkK
Q09ORklHX1NNUD15CkNPTkZJR19CSUdfTElUVExFPXkKQ09ORklHX0JMX1NXSVRDSEVSPXkKQ09O
RklHX0JMX1NXSVRDSEVSX0RVTU1ZX0lGPXkKQ09ORklHX05SX0NQVVM9OApDT05GSUdfUFJFRU1Q
VD15CkNPTkZJR19BRUFCST15CkNPTkZJR19ISUdITUVNPXkKQ09ORklHX0NNQT15CkNPTkZJR19a
Qk9PVF9ST01fVEVYVD0weDAKQ09ORklHX1pCT09UX1JPTV9CU1M9MHgwCkNPTkZJR19BUk1fQVBQ
RU5ERURfRFRCPXkKQ09ORklHX0FSTV9BVEFHX0RUQl9DT01QQVQ9eQpDT05GSUdfQ01ETElORT0i
cm9vdD0vZGV2L3JhbTAgcncgcmFtZGlzaz04MTkyIGluaXRyZD0weDQxMDAwMDAwLDhNIGNvbnNv
bGU9dHR5U0FDMSwxMTUyMDAgaW5pdD0vbGludXhyYyBtZW09MjU2TSIKQ09ORklHX0NQVV9GUkVR
PXkKQ09ORklHX0NQVV9GUkVRX1NUQVRfREVUQUlMUz15CkNPTkZJR19DUFVfRlJFUV9ERUZBVUxU
X0dPVl9PTkRFTUFORD15CkNPTkZJR19DUFVfRlJFUV9HT1ZfUE9XRVJTQVZFPW0KQ09ORklHX0NQ
VV9GUkVRX0dPVl9VU0VSU1BBQ0U9bQpDT05GSUdfQ1BVX0ZSRVFfR09WX0NPTlNFUlZBVElWRT1t
CkNPTkZJR19DUFVGUkVRX0RUPXkKQ09ORklHX0NQVV9JRExFPXkKQ09ORklHX0FSTV9FWFlOT1Nf
Q1BVSURMRT15CkNPTkZJR19WRlA9eQpDT05GSUdfTkVPTj15CkNPTkZJR19LRVJORUxfTU9ERV9O
RU9OPXkKQ09ORklHX05FVD15CkNPTkZJR19QQUNLRVQ9eQpDT05GSUdfVU5JWD15CkNPTkZJR19O
RVRfS0VZPXkKQ09ORklHX0lORVQ9eQpDT05GSUdfSVBfUE5QPXkKQ09ORklHX0lQX1BOUF9ESENQ
PXkKQ09ORklHX0lQX1BOUF9CT09UUD15CkNPTkZJR19JUF9QTlBfUkFSUD15CkNPTkZJR19DRkc4
MDIxMT15CkNPTkZJR19SRktJTExfUkVHVUxBVE9SPXkKQ09ORklHX0RFVlRNUEZTPXkKQ09ORklH
X0RFVlRNUEZTX01PVU5UPXkKQ09ORklHX0RNQV9DTUE9eQpDT05GSUdfQ01BX1NJWkVfTUJZVEVT
PTY0CkNPTkZJR19CTEtfREVWX0xPT1A9eQpDT05GSUdfQkxLX0RFVl9DUllQVE9MT09QPXkKQ09O
RklHX0JMS19ERVZfUkFNPXkKQ09ORklHX0JMS19ERVZfUkFNX1NJWkU9ODE5MgpDT05GSUdfU0NT
ST15CkNPTkZJR19CTEtfREVWX1NEPXkKQ09ORklHX0NIUl9ERVZfU0c9eQpDT05GSUdfTUQ9eQpD
T05GSUdfQkxLX0RFVl9ETT15CkNPTkZJR19ETV9DUllQVD1tCkNPTkZJR19ORVRERVZJQ0VTPXkK
Q09ORklHX1NNU0M5MTFYPXkKQ09ORklHX1VTQl9SVEw4MTUyPXkKQ09ORklHX1VTQl9VU0JORVQ9
eQpDT05GSUdfVVNCX05FVF9TTVNDNzVYWD15CkNPTkZJR19VU0JfTkVUX1NNU0M5NVhYPXkKQ09O
RklHX01XSUZJRVg9bQpDT05GSUdfTVdJRklFWF9TRElPPW0KQ09ORklHX0lOUFVUX0VWREVWPXkK
Q09ORklHX0tFWUJPQVJEX0dQSU89eQpDT05GSUdfS0VZQk9BUkRfQ1JPU19FQz15CiMgQ09ORklH
X01PVVNFX1BTMiBpcyBub3Qgc2V0CkNPTkZJR19NT1VTRV9DWUFQQT15CkNPTkZJR19JTlBVVF9U
T1VDSFNDUkVFTj15CkNPTkZJR19UT1VDSFNDUkVFTl9BVE1FTF9NWFQ9eQpDT05GSUdfSU5QVVRf
TUlTQz15CkNPTkZJR19JTlBVVF9NQVg3NzY5M19IQVBUSUM9eQpDT05GSUdfSU5QVVRfTUFYODk5
N19IQVBUSUM9eQpDT05GSUdfU0VSSUFMXzgyNTA9eQpDT05GSUdfU0VSSUFMX09GX1BMQVRGT1JN
PXkKQ09ORklHX1NFUklBTF9TQU1TVU5HPXkKQ09ORklHX1NFUklBTF9TQU1TVU5HX0NPTlNPTEU9
eQpDT05GSUdfSFdfUkFORE9NPXkKQ09ORklHX1RDR19UUE09eQpDT05GSUdfVENHX1RJU19JMkNf
SU5GSU5FT049eQpDT05GSUdfSTJDX0NIQVJERVY9eQpDT05GSUdfSTJDX01VWD15CkNPTkZJR19J
MkNfQVJCX0dQSU9fQ0hBTExFTkdFPXkKQ09ORklHX0kyQ19HUElPPXkKQ09ORklHX0kyQ19DUk9T
X0VDX1RVTk5FTD15CkNPTkZJR19TUEk9eQpDT05GSUdfU1BJX0dQSU89eQpDT05GSUdfU1BJX1Mz
QzY0WFg9eQpDT05GSUdfREVCVUdfR1BJTz15CkNPTkZJR19QT1dFUl9TVVBQTFk9eQpDT05GSUdf
QkFUVEVSWV9TQlM9eQpDT05GSUdfQkFUVEVSWV9NQVgxNzA0MD15CkNPTkZJR19CQVRURVJZX01B
WDE3MDQyPXkKQ09ORklHX0NIQVJHRVJfTUFYMTQ1Nzc9eQpDT05GSUdfQ0hBUkdFUl9NQVg3NzY5
Mz15CkNPTkZJR19DSEFSR0VSX01BWDg5OTc9eQpDT05GSUdfQ0hBUkdFUl9UUFM2NTA5MD15CkNP
TkZJR19TRU5TT1JTX0xNOTA9eQpDT05GSUdfU0VOU09SU19OVENfVEhFUk1JU1RPUj15CkNPTkZJ
R19TRU5TT1JTX1BXTV9GQU49eQpDT05GSUdfU0VOU09SU19JTkEyWFg9eQpDT05GSUdfQ1BVX1RI
RVJNQUw9eQpDT05GSUdfVEhFUk1BTF9FTVVMQVRJT049eQpDT05GSUdfV0FUQ0hET0c9eQpDT05G
SUdfUzNDMjQxMF9XQVRDSERPRz15CkNPTkZJR19NRkRfQ1JPU19FQz15CkNPTkZJR19NRkRfQ1JP
U19FQ19JMkM9eQpDT05GSUdfTUZEX0NST1NfRUNfU1BJPXkKQ09ORklHX01GRF9NQVgxNDU3Nz15
CkNPTkZJR19NRkRfTUFYNzc2ODY9eQpDT05GSUdfTUZEX01BWDc3NjkzPXkKQ09ORklHX01GRF9N
QVg4OTk3PXkKQ09ORklHX01GRF9NQVg4OTk4PXkKQ09ORklHX01GRF9TRUNfQ09SRT15CkNPTkZJ
R19NRkRfVFBTNjUwOTA9eQpDT05GSUdfUkVHVUxBVE9SPXkKQ09ORklHX1JFR1VMQVRPUl9GSVhF
RF9WT0xUQUdFPXkKQ09ORklHX1JFR1VMQVRPUl9HUElPPXkKQ09ORklHX1JFR1VMQVRPUl9NQVgx
NDU3Nz15CkNPTkZJR19SRUdVTEFUT1JfTUFYODk5Nz15CkNPTkZJR19SRUdVTEFUT1JfTUFYODk5
OD15CkNPTkZJR19SRUdVTEFUT1JfTUFYNzc2ODY9eQpDT05GSUdfUkVHVUxBVE9SX01BWDc3Njkz
PXkKQ09ORklHX1JFR1VMQVRPUl9NQVg3NzgwMj15CkNPTkZJR19SRUdVTEFUT1JfUzJNUEEwMT15
CkNPTkZJR19SRUdVTEFUT1JfUzJNUFMxMT15CkNPTkZJR19SRUdVTEFUT1JfUzVNODc2Nz15CkNP
TkZJR19SRUdVTEFUT1JfVFBTNjUwOTA9eQpDT05GSUdfTUVESUFfU1VQUE9SVD1tCkNPTkZJR19N
RURJQV9DQU1FUkFfU1VQUE9SVD15CkNPTkZJR19NRURJQV9VU0JfU1VQUE9SVD15CkNPTkZJR19V
U0JfVklERU9fQ0xBU1M9bQpDT05GSUdfRFJNPXkKQ09ORklHX0RSTV9FWFlOT1M9eQpDT05GSUdf
RFJNX0VYWU5PU19GSU1EPXkKQ09ORklHX0RSTV9FWFlOT1NfTUlYRVI9eQpDT05GSUdfRFJNX0VY
WU5PU19EUEk9eQpDT05GSUdfRFJNX0VYWU5PU19EU0k9eQpDT05GSUdfRFJNX0VYWU5PU19IRE1J
PXkKQ09ORklHX0RSTV9QQU5FTF9TSU1QTEU9eQpDT05GSUdfRFJNX1BBTkVMX1NBTVNVTkdfTEQ5
MDQwPXkKQ09ORklHX0RSTV9QQU5FTF9TQU1TVU5HX1M2RThBQTA9eQpDT05GSUdfRFJNX05YUF9Q
VE4zNDYwPXkKQ09ORklHX0RSTV9QQVJBREVfUFM4NjIyPXkKQ09ORklHX0VYWU5PU19WSURFTz15
CkNPTkZJR19FWFlOT1NfTUlQSV9EU0k9eQpDT05GSUdfTENEX0NMQVNTX0RFVklDRT15CkNPTkZJ
R19MQ0RfUExBVEZPUk09eQpDT05GSUdfQkFDS0xJR0hUX1BXTT15CkNPTkZJR19MT0dPPXkKQ09O
RklHX1NPVU5EPXkKQ09ORklHX1NORD15CkNPTkZJR19TTkRfU09DPXkKQ09ORklHX1NORF9TT0Nf
U0FNU1VORz15CkNPTkZJR19TTkRfU09DX1NOT1c9eQpDT05GSUdfU05EX1NPQ19PRFJPSURYMj15
CkNPTkZJR19TTkRfU0lNUExFX0NBUkQ9eQpDT05GSUdfVVNCPXkKQ09ORklHX1VTQl9BTk5PVU5D
RV9ORVdfREVWSUNFUz15CkNPTkZJR19VU0JfWEhDSV9IQ0Q9eQpDT05GSUdfVVNCX0VIQ0lfSENE
PXkKQ09ORklHX1VTQl9FSENJX0VYWU5PUz15CkNPTkZJR19VU0JfT0hDSV9IQ0Q9eQpDT05GSUdf
VVNCX09IQ0lfRVhZTk9TPXkKQ09ORklHX1VTQl9TVE9SQUdFPXkKQ09ORklHX1VTQl9EV0MzPXkK
Q09ORklHX1VTQl9EV0MyPXkKQ09ORklHX1VTQl9IU0lDX1VTQjM1MDM9eQpDT05GSUdfVVNCX0dB
REdFVD15CkNPTkZJR19VU0JfRVRIPXkKQ09ORklHX01NQz15CkNPTkZJR19NTUNfQkxPQ0tfTUlO
T1JTPTE2CkNPTkZJR19NTUNfU0RIQ0k9eQpDT05GSUdfTU1DX1NESENJX1MzQz15CkNPTkZJR19N
TUNfU0RIQ0lfUzNDX0RNQT15CkNPTkZJR19NTUNfRFc9eQpDT05GSUdfTU1DX0RXX0VYWU5PUz15
CkNPTkZJR19ORVdfTEVEUz15CkNPTkZJR19MRURTX0NMQVNTPXkKQ09ORklHX0xFRFNfQ0xBU1Nf
RkxBU0g9eQpDT05GSUdfTEVEU19HUElPPXkKQ09ORklHX0xFRFNfUFdNPXkKQ09ORklHX0xFRFNf
TUFYNzc2OTM9eQpDT05GSUdfTEVEU19NQVg4OTk3PXkKQ09ORklHX0xFRFNfVFJJR0dFUlM9eQpD
T05GSUdfTEVEU19UUklHR0VSX0hFQVJUQkVBVD15CkNPTkZJR19SVENfQ0xBU1M9eQpDT05GSUdf
UlRDX0RSVl9NQVg4OTk3PXkKQ09ORklHX1JUQ19EUlZfTUFYNzc2ODY9eQpDT05GSUdfUlRDX0RS
Vl9TNU09eQpDT05GSUdfUlRDX0RSVl9TM0M9eQpDT05GSUdfRE1BREVWSUNFUz15CkNPTkZJR19Q
TDMzMF9ETUE9eQpDT05GSUdfQ1JPU19FQ19DSEFSREVWPXkKQ09ORklHX0NPTU1PTl9DTEtfTUFY
Nzc2ODY9eQpDT05GSUdfQ09NTU9OX0NMS19NQVg3NzgwMj15CkNPTkZJR19DT01NT05fQ0xLX1My
TVBTMTE9eQpDT05GSUdfRVhZTk9TX0lPTU1VPXkKQ09ORklHX0VYWU5PU19JT01NVV9ERUJVRz15
CkNPTkZJR19BUk1fU01NVT15CkNPTkZJR19FWFRDT049eQpDT05GSUdfRVhUQ09OX01BWDE0NTc3
PXkKQ09ORklHX0VYVENPTl9NQVg3NzY5Mz15CkNPTkZJR19FWFRDT05fTUFYODk5Nz15CkNPTkZJ
R19JSU89eQpDT05GSUdfRVhZTk9TX0FEQz15CkNPTkZJR19QV009eQpDT05GSUdfUFdNX1NBTVNV
Tkc9eQpDT05GSUdfUEhZX0VYWU5PUzUyNTBfU0FUQT15CkNPTkZJR19FWFQyX0ZTPXkKQ09ORklH
X0VYVDNfRlM9eQpDT05GSUdfQVVUT0ZTNF9GUz15CkNPTkZJR19NU0RPU19GUz15CkNPTkZJR19W
RkFUX0ZTPXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX1RNUEZTX1BPU0lYX0FDTD15CkNPTkZJR19D
UkFNRlM9eQpDT05GSUdfUk9NRlNfRlM9eQpDT05GSUdfTkZTX0ZTPXkKQ09ORklHX05GU19WND15
CkNPTkZJR19ST09UX05GUz15CkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKQ09ORklHX05MU19B
U0NJST15CkNPTkZJR19OTFNfSVNPODg1OV8xPXkKQ09ORklHX1BSSU5US19USU1FPXkKQ09ORklH
X0RFQlVHX0lORk89eQpDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05GSUdfREVCVUdfUEFHRUFMTE9D
PXkKQ09ORklHX0RFQlVHX09CSkVDVFM9eQpDT05GSUdfREVCVUdfT0JKRUNUU19TRUxGVEVTVD15
CkNPTkZJR19ERUJVR19PQkpFQ1RTX0ZSRUU9eQpDT05GSUdfREVCVUdfT0JKRUNUU19USU1FUlM9
eQpDT05GSUdfREVCVUdfT0JKRUNUU19XT1JLPXkKQ09ORklHX0RFQlVHX09CSkVDVFNfUkNVX0hF
QUQ9eQpDT05GSUdfREVCVUdfT0JKRUNUU19QRVJDUFVfQ09VTlRFUj15CkNPTkZJR19ERUJVR19T
SElSUT15CkNPTkZJR19MT0NLVVBfREVURUNUT1I9eQpDT05GSUdfU0NIRURTVEFUUz15CkNPTkZJ
R19TQ0hFRF9TVEFDS19FTkRfQ0hFQ0s9eQpDT05GSUdfVElNRVJfU1RBVFM9eQpDT05GSUdfREVC
VUdfUlRfTVVURVhFUz15CkNPTkZJR19ERUJVR19XV19NVVRFWF9TTE9XUEFUSD15CkNPTkZJR19Q
Uk9WRV9MT0NLSU5HPXkKQ09ORklHX0xPQ0tfU1RBVD15CkNPTkZJR19ERUJVR19MT0NLREVQPXkK
Q09ORklHX0RFQlVHX0FUT01JQ19TTEVFUD15CkNPTkZJR19ERUJVR19MT0NLSU5HX0FQSV9TRUxG
VEVTVFM9eQpDT05GSUdfTE9DS19UT1JUVVJFX1RFU1Q9bQpDT05GSUdfREVCVUdfUElfTElTVD15
CkNPTkZJR19ERUJVR19TRz15CkNPTkZJR19ERUJVR19OT1RJRklFUlM9eQpDT05GSUdfREVCVUdf
Q1JFREVOVElBTFM9eQpDT05GSUdfUFJPVkVfUkNVX1JFUEVBVEVETFk9eQpDT05GSUdfU1BBUlNF
X1JDVV9QT0lOVEVSPXkKQ09ORklHX1JDVV9UT1JUVVJFX1RFU1Q9bQpDT05GSUdfUkNVX1RPUlRV
UkVfVEVTVF9TTE9XX1BSRUlOSVQ9eQpDT05GSUdfUkNVX1RSQUNFPXkKQ09ORklHX0RFQlVHX1VT
RVI9eQpDT05GSUdfQ1JZUFRPX0RFVl9TNVA9eQpDT05GSUdfQVJNX0NSWVBUTz15CkNPTkZJR19D
UllQVE9fU0hBMV9BUk1fTkVPTj1tCkNPTkZJR19DUllQVE9fU0hBMjU2X0FSTT1tCkNPTkZJR19D
UllQVE9fU0hBNTEyX0FSTT1tCkNPTkZJR19DUllQVE9fQUVTX0FSTV9CUz1tCkNPTkZJR19DUkNf
Q0NJVFQ9eQo=
--001a113deb18e163bc052f1a5d32--
