From: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Subject: Re: 2.36.1 sdhci R5C822 regression
Date: Fri, 17 Dec 2010 18:56:49 +0100
Message-ID: <4D0BA461.6050803@tls-tautenburg.de>
References: <4D0B380C.4000407@tls-tautenburg.de> <20101217153024.GA26910@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kso.tls-tautenburg.de ([194.94.209.8]:11641 "EHLO
	kso.tls-tautenburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab0LQR46 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2010 12:56:58 -0500
In-Reply-To: <20101217153024.GA26910@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Chris Ball wrote:
> Hi Bringfried,
> 
> On Fri, Dec 17, 2010 at 11:14:36AM +0100, Bringfried Stecklum wrote:
>> On resume from hibernation (suspend is fine) a kernel trace happens along with
>> the well-know "IRQ nobody cared" statement (see below). The interrupt gets
>> disabled, and since mmc0 is compiled into the kernel, I cannot do anything about
>> it (I tried CONFIG_MMC_RICOH_MMC=m but this will be overriden during the build).
> 
> Please try the patch below, and let us know if it cures the problem for
> you.  Thanks!  (This patch is already scheduled for inclusion in 2.6.37.)
> 
> - Chris.
> 
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 10 Dec 2010 08:40:31 +0100
> Subject: mmc: Fix re-probing with PM_POST_RESTORE notification
> 
> In the error-path where PM notifies PM_POST_RESTORE, the rescan-blockage
> should be cleared as well.  Otherwise it'll be never re-probed.
> 
> Also, as a bonus, this fixes a bug in S4 with user-mode suspend in the
> current code, as it sends PM_POST_RESTORE instead of
> PM_POST_HIBERNATION wrongly.
> 
> Cc: <stable@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/core/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6286898..e7c0c78 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1833,6 +1833,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>  
>  	case PM_POST_SUSPEND:
>  	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
>  
>  		spin_lock_irqsave(&host->lock, flags);
>  		host->rescan_disable = 0;
Thanks for the patch which, however, does not solve the problem. Now I don't get
the oops immediately upon resume from hibernation but later, on inserting
the card (2.6.37 is no solution at the moment since my system is on a Reiser4
partition, so I have to wait for those patches).

Dec 17 18:44:34 extragalactix kernel: [  161.320496] irq 18: nobody cared (try
booting with the "irqpoll" option)
Dec 17 18:44:34 extragalactix kernel: [  161.320510] Pid: 0, comm: kworker/0:0
Tainted: P            2.6.36-1-generic #7
Dec 17 18:44:34 extragalactix kernel: [  161.320515] Call Trace:
Dec 17 18:44:34 extragalactix kernel: [  161.320520]  <IRQ>
[<ffffffffa01131b2>] ? sdhci_irq+0xd2/0x2c4 [sdhci]
Dec 17 18:44:34 extragalactix kernel: [  161.320562]  [<ffffffff810ca5e6>]
__report_bad_irq+0x26/0xa0
Dec 17 18:44:34 extragalactix kernel: [  161.320571]  [<ffffffff810ca7e8>]
note_interrupt+0x188/0x1d0
Dec 17 18:44:34 extragalactix kernel: [  161.320579]  [<ffffffff810caffd>]
handle_fasteoi_irq+0xdd/0x110
Dec 17 18:44:34 extragalactix kernel: [  161.320589]  [<ffffffff8100dbaf>]
handle_irq+0x1f/0x30
Dec 17 18:44:34 extragalactix kernel: [  161.320596]  [<ffffffff8100d06a>]
do_IRQ+0x6a/0xf0
Dec 17 18:44:34 extragalactix kernel: [  161.320606]  [<ffffffff816019d3>]
ret_from_intr+0x0/0x11
Dec 17 18:44:34 extragalactix kernel: [  161.320610]  <EOI>
[<ffffffff813761fa>] ? acpi_idle_enter_simple+0xe4/0x11e
Dec 17 18:44:34 extragalactix kernel: [  161.320628]  [<ffffffff813761f3>] ?
acpi_idle_enter_simple+0xdd/0x11e
Dec 17 18:44:34 extragalactix kernel: [  161.320638]  [<ffffffff814c435c>]
cpuidle_idle_call+0xcc/0x150
Dec 17 18:44:34 extragalactix kernel: [  161.320647]  [<ffffffff8100a1a7>]
cpu_idle+0xc7/0x170
Dec 17 18:44:34 extragalactix kernel: [  161.320657]  [<ffffffff815fa87d>]
start_secondary+0xdd/0x110
Dec 17 18:44:34 extragalactix kernel: [  161.320662] handlers:
Dec 17 18:44:34 extragalactix kernel: [  161.320666] [<ffffffffa0144db0>]
(r852_irq+0x0/0x290 [r852])
Dec 17 18:44:34 extragalactix kernel: [  161.320679] [<ffffffffa01130e0>]
(sdhci_irq+0x0/0x2c4 [sdhci])
Dec 17 18:44:34 extragalactix kernel: [  161.320691] Disabling IRQ #18
Dec 17 18:44:43 extragalactix kernel: [  169.760266] mmc0: Timeout waiting for
hardware interrupt.
Dec 17 18:44:43 extragalactix kernel: [  169.760276] sdhci: ==============
REGISTER DUMP ==============
Dec 17 18:44:43 extragalactix kernel: [  169.760285] sdhci: Sys addr: 0x00000000
| Version:  0x00000400
Dec 17 18:44:43 extragalactix kernel: [  169.760293] sdhci: Blk size: 0x00000000
| Blk cnt:  0x00000000
Dec 17 18:44:43 extragalactix kernel: [  169.760300] sdhci: Argument: 0x00000000
| Trn mode: 0x00000000
Dec 17 18:44:43 extragalactix kernel: [  169.760307] sdhci: Present:  0x01f70000
| Host ctl: 0x00000001
Dec 17 18:44:43 extragalactix kernel: [  169.760314] sdhci: Power:    0x0000000f
| Blk gap:  0x00000000
Dec 17 18:44:43 extragalactix kernel: [  169.760322] sdhci: Wake-up:  0x00000000
| Clock:    0x00004007
Dec 17 18:44:43 extragalactix kernel: [  169.760329] sdhci: Timeout:  0x00000000
| Int stat: 0x00000000
Dec 17 18:44:43 extragalactix kernel: [  169.760336] sdhci: Int enab: 0x00ff00c3
| Sig enab: 0x00ff00c3
Dec 17 18:44:43 extragalactix kernel: [  169.760343] sdhci: AC12 err: 0x00000000
| Slot int: 0x00000001
Dec 17 18:44:43 extragalactix kernel: [  169.760351] sdhci: Caps:     0x00c02120
| Max curr: 0x00000040
Dec 17 18:44:43 extragalactix kernel: [  169.760355] sdhci:
===========================================
...


