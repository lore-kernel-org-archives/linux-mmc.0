From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: Is it possible for sdhci host controller driver to schedule inside
 sdhci_request() function?
Date: Wed, 26 Jan 2011 23:56:12 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473321F45A4@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33189 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1AZP4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jan 2011 10:56:23 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi all,

Our platform use sdhci host controller. And now there's a discussion to schedule inside sdhci_request() function of drivers/mmc/host/sdhci.c.
According to the mmc stack code, seems the sdhci_request() is in the context of kernel thread (mmcqd), so I think it should be OK if schedule inside of it.

But when I tried it with below patch:
-----------------------------------------------------------------------------------------------------
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5dead05..2c2ac66 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1184,6 +1184,10 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host = mmc_priv(mmc);
 
+	printk(KERN_ERR "%s: Enter into sdhci_request:\n", mmc_hostname(host->mmc));
+	msleep(10);
+	printk(KERN_ERR "%s: Go on after msleep 10ms ...\n", mmc_hostname(host->mmc));
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	WARN_ON(host->mrq != NULL);
---------------------------------------------------------------------------------------------------

The kernel reported 'scheduling while atomic' BUG as below:
-----------------------------------------------------------------------------------------------
...
<3>[    4.985928] mmc0: Enter into sdhci_request:
<3>[    4.996750] mmc0: Go on after msleep 10ms ...
<3>[    5.007822] mmc0: Enter into sdhci_request:
<3>[    5.018790] mmc0: Go on after msleep 10ms ...
<3>[    5.028727] mmc0: Enter into sdhci_request:
<3>[    5.039841] mmc0: Go on after msleep 10ms ...
<3>[    5.049772] mmc0: Enter into sdhci_request:
<3>[    5.049815] BUG: scheduling while atomic: swapper/0/0x00000104
<4>[    5.049845] no locks held by swapper/0.
<4>[    5.049866] Modules linked in:
<4>[    5.049889] Modules linked in:
<4>[    5.049912] 
<4>[    5.049930] Pid: 0, comm: swapper Not tainted 2.6.35.3+ #8 /
<4>[    5.049960] EIP: 0060:[<c152ab86>] EFLAGS: 00000206 CPU: 0
<4>[    5.049997] EIP is at _raw_spin_unlock_irq+0x25/0x3b
<4>[    5.050024] EAX: c1751f28 EBX: c2607bc0 ECX: 00000007 EDX: 00000007
<4>[    5.050055] ESI: c1779a1c EDI: f74400b0 EBP: c1751f2c ESP: c1751f28
<4>[    5.050086]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
<0>[    5.050116] Process swapper (pid: 0, ti=c1750000 task=c176dea0 task.ti=c1750000)
<0>[    5.050150] Stack:
<4>[    5.050165]  c2607bc0 c1751f58 c10288bc 00000000 00000002 00000000 c1028865 c176dea0
<4>[    5.050229] <0> 00000001 c184cbc0 f74400b0 c176dea0 c1751fb4 c15285f8 2c66255a 00000001
<4>[    5.050300] <0> c184cbc0 c1845000 c184cbc0 c184cbc0 c184cbc0 f74400b0 00000000 c176e108
<0>[    5.050376] Call Trace:
<4>[    5.050407]  [<c10288bc>] ? finish_task_switch+0x57/0x90
<4>[    5.050441]  [<c1028865>] ? finish_task_switch+0x0/0x90
<4>[    5.050474]  [<c15285f8>] ? schedule+0x78e/0x869
<4>[    5.050509]  [<c10584ef>] ? tick_nohz_restart_sched_tick+0x154/0x15d
<4>[    5.050545]  [<c100192c>] ? cpu_idle+0x6a/0x76
<4>[    5.050576]  [<c150a524>] ? rest_init+0xd4/0xd9
<4>[    5.050609]  [<c17f28bb>] ? start_kernel+0x2f7/0x2fc
<4>[    5.050642]  [<c17f20d0>] ? i386_start_kernel+0xd0/0xd7
<0>[    5.050667] Code: fc b0 ff 5b 5d c3 55 ba 01 00 00 00 89 e5 8b 4d 04 53 89 c3 8d 40 10 e8 97 2b b3 ff 89 d8 e8 f0 b2 cb ff e8 84 06 b3 ff fb 89 e0 <25> 00 e0 ff ff ff 48 14 f6 40 08 08 74 05 e8 e0 dc ff ff 5b 5d 
<4>[    5.051060] Call Trace:
<4>[    5.051088]  [<c10288bc>] finish_task_switch+0x57/0x90
<4>[    5.051121]  [<c1028865>] ? finish_task_switch+0x0/0x90
<4>[    5.051153]  [<c15285f8>] schedule+0x78e/0x869
<4>[    5.051185]  [<c10584ef>] ? tick_nohz_restart_sched_tick+0x154/0x15d
<4>[    5.051221]  [<c100192c>] cpu_idle+0x6a/0x76
<4>[    5.051250]  [<c150a524>] rest_init+0xd4/0xd9
<4>[    5.051280]  [<c17f28bb>] start_kernel+0x2f7/0x2fc
<4>[    5.051312]  [<c17f20d0>] i386_start_kernel+0xd0/0xd7
<3>[    5.051340] bad: scheduling from the idle thread!
<4>[    5.051368] Pid: 0, comm: swapper Not tainted 2.6.35.3+ #8
<4>[    5.051393] Call Trace:
<4>[    5.051415]  [<c1527b01>] ? printk+0xf/0x11
<4>[    5.051444]  [<c10251ff>] dequeue_task_idle+0x1a/0x27
<4>[    5.051475]  [<c1029a0a>] dequeue_task+0xca/0xd9
<4>[    5.051506]  [<c1029a38>] deactivate_task+0x1f/0x25
<4>[    5.051535]  [<c1527fb9>] schedule+0x14f/0x869
<4>[    5.051567]  [<c105b212>] ? trace_hardirqs_on+0xb/0xd
<4>[    5.051598]  [<c1528b59>] schedule_timeout+0x27c/0x2cf
<4>[    5.051630]  [<c104101a>] ? process_timeout+0x0/0xa
<4>[    5.051662]  [<c1528bc1>] schedule_timeout_uninterruptible+0x15/0x17
<4>[    5.051723]  [<c10414cd>] msleep+0x10/0x16
<4>[    5.051758]  [<c1372c45>] sdhci_request+0x33/0xfc
<4>[    5.051790]  [<c136a3a5>] mmc_request_done+0x42/0x6a
<4>[    5.051820]  [<c1373603>] sdhci_tasklet_finish+0xc4/0xca
<4>[    5.051854]  [<c1039e7c>] tasklet_action+0x69/0xb0
<4>[    5.051883]  [<c103a4bc>] __do_softirq+0x122/0x27a
<4>[    5.051912]  [<c103a63f>] do_softirq+0x2b/0x43
<4>[    5.051940]  [<c103a7cf>] irq_exit+0x35/0x72
<4>[    5.051969]  [<c101643f>] smp_apic_timer_interrupt+0x6e/0x7c
<4>[    5.052002]  [<c152b4ab>] apic_timer_interrupt+0x2f/0x34
<4>[    5.052035]  [<c105007b>] ? down_trylock+0x18/0x27
<4>[    5.052064]  [<c152ab86>] ? _raw_spin_unlock_irq+0x25/0x3b
<4>[    5.052097]  [<c10288bc>] finish_task_switch+0x57/0x90
<4>[    5.052129]  [<c1028865>] ? finish_task_switch+0x0/0x90
<4>[    5.052159]  [<c15285f8>] schedule+0x78e/0x869
<4>[    5.052190]  [<c10584ef>] ? tick_nohz_restart_sched_tick+0x154/0x15d
<4>[    5.052224]  [<c100192c>] cpu_idle+0x6a/0x76
<4>[    5.052252]  [<c150a524>] rest_init+0xd4/0xd9
<4>[    5.052282]  [<c17f28bb>] start_kernel+0x2f7/0x2fc
<4>[    5.052312]  [<c17f20d0>] i386_start_kernel+0xd0/0xd7
<1>[    5.062718] BUG: unable to handle kernel NULL pointer dereference at (null)
<1>[    5.062774] IP: [<(null)>] (null)
<4>[    5.062806] *pdpt = 0000000001856001 *pde = 0000000000000000 
<0>[    5.062851] Oops: 0010 [#1] PREEMPT SMP 
<0>[    5.062890] last sysfs file: 
<4>[    5.062917] Modules linked in:
<4>[    5.062944] 
<4>[    5.062967] Pid: 0, comm: swapper Not tainted 2.6.35.3+ #8 /
<4>[    5.063003] EIP: 0060:[<00000000>] EFLAGS: 00010046 CPU: 1
<4>[    5.063037] EIP is at 0x0
<4>[    5.063061] EAX: c2607bc0 EBX: c15304d4 ECX: 00000001 EDX: c176dea0
<4>[    5.063099] ESI: c176dea0 EDI: c2607bc0 EBP: f747de3c ESP: f747de28
<4>[    5.063137]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
<0>[    5.063173] Process swapper (pid: 0, ti=f747c000 task=f747a230 task.ti=f747c000)
<0>[    5.063216] Stack:
<4>[    5.063236]  c10298a7 00000001 c2607bc0 c176dea0 c2607bc0 f747de48 c10298d3 00000000
<4>[    5.063309] <0> f747de70 c1031fad 00000000 00000001 00000001 00000000 00000282 c1751dd8
<4>[    5.063394] <0> c1751e18 f747debc f747de78 c1032183 f747de80 c1041022 f747ded0 c1040b47
<0>[    5.063488] Call Trace:
<4>[    5.063520]  [<c10298a7>] ? enqueue_task+0x72/0x7f
<4>[    5.063559]  [<c10298d3>] ? activate_task+0x1f/0x25
<4>[    5.063597]  [<c1031fad>] ? try_to_wake_up+0x268/0x416
<4>[    5.063636]  [<c1032183>] ? wake_up_process+0xf/0x11
<4>[    5.063674]  [<c1041022>] ? process_timeout+0x8/0xa
<4>[    5.063712]  [<c1040b47>] ? run_timer_softirq+0x299/0x414
<4>[    5.063752]  [<c104101a>] ? process_timeout+0x0/0xa
<4>[    5.063790]  [<c103a4bc>] ? __do_softirq+0x122/0x27a
<4>[    5.063828]  [<c103a63f>] ? do_softirq+0x2b/0x43
<4>[    5.063864]  [<c103a7cf>] ? irq_exit+0x35/0x72
<4>[    5.063900]  [<c101643f>] ? smp_apic_timer_interrupt+0x6e/0x7c
<4>[    5.063942]  [<c152b4ab>] ? apic_timer_interrupt+0x2f/0x34
<4>[    5.063984]  [<c105007b>] ? down_trylock+0x18/0x27
<4>[    5.064022]  [<c1209a63>] ? intel_idle+0x169/0x1aa
<4>[    5.064062]  [<c13676bd>] ? cpuidle_idle_call+0x71/0x14c
<4>[    5.064101]  [<c100190b>] ? cpu_idle+0x49/0x76
<4>[    5.064138]  [<c152514f>] ? start_secondary+0x1c1/0x1c6
<0>[    5.064171] Code:  Bad EIP value.
<0>[    5.064208] EIP: [<00000000>] 0x0 SS:ESP 0068:f747de28
<0>[    5.064251] CR2: 0000000000000000
<6>[    0.000000] Initializing cgroup subsys cpu
<5>[    0.000000] Linux version 2.6.35.3+ (root@yunpeng) (gcc version 4.4.4 20100630 (Red Hat 4.4.4-10) (GCC) ) #8 SMP PREEMPT Wed Jan 26 22:49:08 CST 2011
---------------------------------------------------------------------------------------------------------

So, does anyone know why it failed to schedule inside sdhci_request() function? And which kind of context the sdhci_request() function is in? Thanks in advance.

Regards,
Yunpeng
