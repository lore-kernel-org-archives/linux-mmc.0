From: Stefan Agner <stefan@agner.ch>
Subject: Self-detected stall on CPU when using SD card
Date: Tue, 26 Jun 2018 12:53:08 +0200
Message-ID: <037cbd3560a68bad0cea92f453c1b819@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adrian.hunter@intel.com, aisheng.dong@nxp.com, fabio.estevam@nxp.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On our Colibri iMX6 (arch/arm/boot/dts/imx6qdl-colibri.dtsi) we
experience the following stack trace when a SD card is plugged in:

INFO: rcu_sched self-detected stall on CPU
 0-....: (2600 ticks this GP) idle=0be/1/1073741828 softirq=4854/4854
fqs=1299
[   65.617559]
INFO: rcu_sched detected stalls on CPUs/tasks:
 (t=2602 jiffies g=1373 c=1372 q=1688)
 0-....: (2600 ticks this GP) idle=0be/1/1073741828 softirq=4854/4854
fqs=1299
[   65.641767]
NMI backtrace for cpu 0
CPU: 0 PID: 128 Comm: kworker/0:1H Not tainted
4.18.0-rc1-00001-gd22a0b44f5c7-dirty #89
(detected by 1, t=2602 jiffies, g=1373, c=1372, q=1688)
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: kblockd blk_mq_run_work_fn
Backtrace:
[<c010edbc>] (dump_backtrace) from [<c010f0bc>] (show_stack+0x20/0x24)
 r7:00000000 r6:60070193 r5:00000000 r4:c11ce6c4
[<c010f09c>] (show_stack) from [<c0bc68cc>] (dump_stack+0xb4/0xec)
[<c0bc6818>] (dump_stack) from [<c0bcd4d8>]
(nmi_cpu_backtrace+0x10c/0x120)
 r10:80070193 r9:c11089b4 r8:c0c02db8 r7:00000000 r6:00000000
r5:00000000
 r4:c1954258 r3:8610ebe3
[<c0bcd3cc>] (nmi_cpu_backtrace) from [<c0bcd5c0>]
(nmi_trigger_cpumask_backtrace+0xd4/0x128)
 r7:00000000 r6:c01124d4 r5:c110c01c r4:00000000
[<c0bcd4ec>] (nmi_trigger_cpumask_backtrace) from [<c011334c>]
(arch_trigger_cpumask_backtrace+0x1c/0x24)
 r9:c11089b4 r8:00000240 r7:c0c02db4 r6:c1108934 r5:c111d780 r4:c111d780
[<c0113330>] (arch_trigger_cpumask_backtrace) from [<c01b2094>]
(rcu_dump_cpu_stacks+0xb4/0xf4)
[<c01b1fe0>] (rcu_dump_cpu_stacks) from [<c01b11b4>]
(rcu_check_callbacks+0x7dc/0xa90)
 r10:c1108e74 r9:c11089ac r8:c111d780 r7:1aac1000 r6:dbb9ed00
r5:c10ddd00
 r4:c111d780
[<c01b09d8>] (rcu_check_callbacks) from [<c01b8890>]
(update_process_times+0x40/0x6c)
 r10:c110892c r9:dbb9a600 r8:c01ceb1c r7:0000000f r6:00000000
r5:d8829900
 r4:ffffe000
[<c01b8850>] (update_process_times) from [<c01ce8b4>]
(tick_sched_handle+0x64/0x68)
 r7:0000000f r6:457832d2 r5:d899fa58 r4:dbb9aaa0
[<c01ce850>] (tick_sched_handle) from [<c01ceb88>]
(tick_sched_timer+0x6c/0xd0)
[<c01ceb1c>] (tick_sched_timer) from [<c01b9740>]
(__hrtimer_run_queues+0x194/0x634)
 r7:c115d3d4 r6:00000000 r5:dbb9aaa0 r4:dbb9a660
[<c01b95ac>] (__hrtimer_run_queues) from [<c01bad60>]
(hrtimer_interrupt+0x124/0x2ec)
 r10:dbb9a740 r9:ffffffff r8:7fffffff r7:dbb9a700 r6:00000003
r5:20070193
 r4:dbb9a600
[<c01bac3c>] (hrtimer_interrupt) from [<c0113d68>]
(twd_handler+0x3c/0x50)
 r10:c11d55ce r9:00000010 r8:c1108e74 r7:c110892c r6:c11090a0
r5:d80ea200
 r4:00000001
[<c0113d2c>] (twd_handler) from [<c019aa0c>]
(handle_percpu_devid_irq+0xec/0x430)
 r5:d80ea200 r4:d80d1800
[<c019a920>] (handle_percpu_devid_irq) from [<c0194990>]
(generic_handle_irq+0x30/0x44)
 r10:c115d628 r9:d80c0400 r8:00000001 r7:d899fb70 r6:c1108e74
r5:00000010
 r4:c10dd12c
[<c0194960>] (generic_handle_irq) from [<c019509c>]
(__handle_domain_irq+0x74/0xf0)
[<c0195028>] (__handle_domain_irq) from [<c0102474>]
(gic_handle_irq+0x68/0xcc)
 r9:d899fa58 r8:c11090a0 r7:f4000100 r6:000003ff r5:000003eb r4:f400010c
[<c010240c>] (gic_handle_irq) from [<c0101a30>] (__irq_svc+0x70/0x98)
Exception stack(0xd899fa58 to 0xd899faa0)
fa40:                                                       00000001
d8829e30
fa60: 00000000 d8829900 ffffe000 00000000 c1108e74 00000000 00000001
00000002
fa80: c11d6b04 d899faf4 00000003 d899faa8 c018440c c01025a4 60070113
ffffffff
 r10:c11d6b04 r9:d899e000 r8:00000001 r7:d899fa8c r6:ffffffff
r5:60070113
 r4:c01025a4
[<c01024d8>] (__do_softirq) from [<c0134660>] (irq_exit+0x108/0x1a8)
 r10:c115d628 r9:d80c0400 r8:00000001 r7:00000000 r6:c1108e74
r5:00000000
 r4:ffffe000
[<c0134558>] (irq_exit) from [<c01950a4>]
(__handle_domain_irq+0x7c/0xf0)
 r5:00000000 r4:c10dd12c
[<c0195028>] (__handle_domain_irq) from [<c0102474>]
(gic_handle_irq+0x68/0xcc)
 r9:d899fb70 r8:c11090a0 r7:f4000100 r6:000003ff r5:000003eb r4:f400010c
[<c010240c>] (gic_handle_irq) from [<c0101a30>] (__irq_svc+0x70/0x98)
Exception stack(0xd899fb70 to 0xd899fbb8)
fb60:                                     0ccccb60 00000730 e0a98000
c0bc3d8c
fb80: d818f480 02faf080 00000001 0bcd3d80 00000001 008f0008 c0f2f8d4
d899fbf4
fba0: d899fb88 d899fbc0 c08397f4 c0bc3d8c 60070013 ffffffff
 r10:c0f2f8d4 r9:d899e000 r8:00000001 r7:d899fba4 r6:ffffffff
r5:60070013
 r4:c0bc3d8c
[<c08396f4>] (esdhc_pltfm_set_clock) from [<c083622c>]
(sdhci_set_ios+0xd8/0x584)
 r10:ffffe000 r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f480
r5:d818f2e8
 r4:d818f000
[<c0836154>] (sdhci_set_ios) from [<c0836070>]
(sdhci_runtime_resume_host+0xa0/0x184)
 r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f648 r5:d818f000 r4:d818f480
[<c0835fd0>] (sdhci_runtime_resume_host) from [<c0839b08>]
(sdhci_esdhc_runtime_resume+0xbc/0x118)
 r9:c1105900 r8:00000004 r7:c064e6fc r6:d87906c0 r5:00000000 r4:d818f480
[<c0839a4c>] (sdhci_esdhc_runtime_resume) from [<c064e738>]
(pm_generic_runtime_resume+0x3c/0x48)
 r7:c064e6fc r6:d82800b8 r5:00000000 r4:d8280010
[<c064e6fc>] (pm_generic_runtime_resume) from [<c065208c>]
(__rpm_callback+0xd0/0x1dc)
[<c0651fbc>] (__rpm_callback) from [<c06521f8>] (rpm_callback+0x60/0x90)
 r10:ffffe000 r9:c1105900 r8:00000004 r7:d827e810 r6:ffffe000
r5:04208060
 r4:d8280010
[<c0652198>] (rpm_callback) from [<c0651b14>] (rpm_resume+0x454/0x810)
 r7:d827e810 r6:00000000 r5:c064e6fc r4:d8280010
[<c06516c0>] (rpm_resume) from [<c0651f40>]
(__pm_runtime_resume+0x70/0x9c)
 r10:d818f000 r9:00000000 r8:d8e7d42c r7:60070013 r6:d82800b8
r5:00000004
 r4:d8280010
[<c0651ed0>] (__pm_runtime_resume) from [<c081c574>]
(__mmc_claim_host+0x1d0/0x228)
 r7:00000000 r6:20070013 r5:d818f2c8 r4:00000000
[<c081c3a4>] (__mmc_claim_host) from [<c081c604>]
(mmc_get_card+0x38/0x3c)
 r10:d818f000 r9:d94a0800 r8:d8613f00 r7:00000000 r6:d8e7d430
r5:d8e7d42c
 r4:d94a0800
[<c081c5cc>] (mmc_get_card) from [<c08314a0>]
(mmc_mq_queue_rq+0x200/0x220)
 r5:d8f418c0 r4:d8e7d428
[<c08312a0>] (mmc_mq_queue_rq) from [<c04d92a8>]
(blk_mq_dispatch_rq_list+0xdc/0x53c)
 r10:00000001 r9:d8613f00 r8:00000000 r7:00000000 r6:d8f418c0
r5:d899fe34
 r4:d8f418f0
[<c04d91cc>] (blk_mq_dispatch_rq_list) from [<c04dd714>]
(blk_mq_do_dispatch_sched+0x68/0x108)
 r10:c11d6b90 r9:c1108908 r8:c1108908 r7:d8613f00 r6:d8e7d000
r5:d899fe34
 r4:d8b0bc00
[<c04dd6ac>] (blk_mq_do_dispatch_sched) from [<c04de0c0>]
(blk_mq_sched_dispatch_requests+0x154/0x1d0)
 r8:d8613f00 r7:d8b0bc20 r6:d899fe6c r5:00000001 r4:d8b0bc00
[<c04ddf6c>] (blk_mq_sched_dispatch_requests) from [<c04d71d4>]
(__blk_mq_run_hw_queue+0xc4/0x168)
 r9:c110892c r8:d899fefc r7:dbba2d00 r6:ffffe000 r5:c1108908 r4:d8b0bc00
[<c04d7110>] (__blk_mq_run_hw_queue) from [<c04d7450>]
(blk_mq_run_work_fn+0x28/0x2c)
 r6:dbb9e3c0 r5:d883d800 r4:d8b0bc40
[<c04d7428>] (blk_mq_run_work_fn) from [<c014cc40>]
(process_one_work+0x2c0/0x7d4)
[<c014c980>] (process_one_work) from [<c014d190>]
(worker_thread+0x3c/0x5a4)
 r10:c1105900 r9:dbb9e3f4 r8:ffffe000 r7:00000008 r6:d883d814
r5:dbb9e3c0
 r4:d883d800
[<c014d154>] (worker_thread) from [<c0154440>] (kthread+0x154/0x16c)
 r10:d8139e70 r9:c014d154 r8:d883d800 r7:d899e000 r6:d8848840
r5:d8812500
 r4:00000000
[<c01542ec>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xd899ffb0 to 0xd899fff8)
ffa0:                                     00000000 00000000 00000000
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000
r5:c01542ec
 r4:d8848840
Sending NMI from CPU 1 to CPUs 0:

It used to work in v4.9, so I started a git bisect. It pointed me to
this commit:

Commit d1e4f74f911d ("mmc: sdhci: Do not use spin lock in set_ios
paths").

Reverting the commit on-top of v4.18-rc1 seems to fix the issue too.

Any idea?

--
Stefan
