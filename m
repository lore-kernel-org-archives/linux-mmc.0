From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 07:24:55 +0000
Message-ID: <1431674695.13197.14.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:60289 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbbEOHY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 03:24:59 -0400
In-Reply-To: <1431673364.13197.10.camel@transmode.se>
Content-Language: en-US
Content-ID: <4583BA6BBD03D543AA824D1782088360@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, 2015-05-15 at 09:02 +0200, an unknown sender wrote:
> On Fri, 2015-05-15 at 14:29 +0800, Kevin Hao wrote:
> > This reverts commit 459fe0cfda71835eacc0b24571e8425cea975688.
> > It causes kernel panic due to a null pointer reference to .set_bus_width
> > on fsl p2020rdb board.
> >   Unable to handle kernel paging request for instruction fetch
> >   Faulting instruction address: 0x00000000
> >   Oops: Kernel access of bad area, sig: 11 [#1]
> >   SMP NR_CPUS=8 P2020 RDB
> >   Modules linked in:
> >   CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc3-next-20150514-00001-g76c7a15bee83 #103
> >   task: ea858000 ti: ea846000 task.ti: ea846000
> >   NIP: 00000000 LR: c048036c CTR: 00000000
> >   REGS: ea847c70 TRAP: 0400   Not tainted  (4.1.0-rc3-next-20150514-00001-g76c7a15bee83)
> >   MSR: 00021000 <CE,ME>  CR: 22010022  XER: 00000000
> > 
> >   GPR00: c04802c4 ea847d20 ea858000 eaa3ab00 00000000 00000f20 00000002 00000000
> >   GPR08: 00000000 00000000 00000000 90000000 22010022 00000000 c0002a68 00000000
> >   GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c08a64e0 000000e9
> >   GPR24: c080f398 c08a0000 00000000 0000000e 00029000 eaa3ab28 eaa3a9f0 eaa3ab00
> >   NIP [00000000]   (null)
> >   LR [c048036c] sdhci_do_set_ios+0x164/0x824
> >   Call Trace:
> >   [ea847d20] [c04802c4] sdhci_do_set_ios+0xbc/0x824 (unreliable)
> >   [ea847d40] [c0480a60] sdhci_set_ios+0x34/0x4c
> >   [ea847d50] [c046c96c] mmc_power_up.part.16+0x3c/0x120
> >   [ea847d70] [c046da10] mmc_start_host+0x50/0xa4
> >   [ea847d80] [c046ee28] mmc_add_host+0x50/0x78
> >   [ea847d90] [c0481438] sdhci_add_host+0x8c4/0xcc0
> >   [ea847db0] [c0485824] sdhci_esdhc_probe+0xa8/0xc8
> >   [ea847dd0] [c032ed28] platform_drv_probe+0x3c/0xa4
> >   [ea847df0] [c032d170] driver_probe_device+0x1f0/0x2c4
> >   [ea847e10] [c032d370] __driver_attach+0xbc/0xc0
> >   [ea847e30] [c032b178] bus_for_each_dev+0x6c/0xb8
> >   [ea847e60] [c032c6b8] bus_add_driver+0x168/0x220
> >   [ea847e80] [c032da70] driver_register+0x88/0x130
> >   [ea847e90] [c000234c] do_one_initcall+0x8c/0x1e0
> >   [ea847f00] [c0815b08] kernel_init_freeable+0x138/0x1d4
> >   [ea847f30] [c0002a7c] kernel_init+0x14/0x100
> >   [ea847f40] [c000e838] ret_from_kernel_thread+0x5c/0x64
> > 
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> 
> Reverting this seem a bit to much. Looking in the log it seems commit
>  2317f56c055fcad524bf6a873df48a754e7ebc4d 
> introduced the error by not checking for host->ops->set_bus_width before
> calling it.
> 
> How does this work for you?
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..23603b2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1528,7 +1528,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>         if (host->ops->platform_send_init_74_clocks)
>                 host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>  
> -       host->ops->set_bus_width(host, ios->bus_width);
> +       if (host->ops->set_bus_width)
> +               host->ops->set_bus_width(host, ios->bus_width);
> +       else
> +               sdhci_set_bus_width(host, ios->bus_width);

Ahh, now I see. Drivers are supposed to call sdhci_set_bus_width instead of NULL:
Instead of reverting this add:

 diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7a98a22..07b9df2 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -283,6 +283,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
        .get_min_clock = esdhc_of_get_min_clock,
        .platform_init = esdhc_of_platform_init,
        .adma_workaround = esdhci_of_adma_workaround,
+       .set_bus_width = sdhci_set_bus_width,
        .reset = esdhc_reset,
        .set_uhs_signaling = sdhci_set_uhs_signaling,
 };

Should I repost the full "sdhci-of-esdhc: Support 8BIT bus width." with this fix added
of just the above fix?

 Jocke