From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
Date: Fri, 29 Apr 2016 15:42:58 +0800
Message-ID: <20160429074258.GA28427@shlinux2.ap.freescale.net>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
 <571A1D85.3020200@intel.com>
 <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
 <5721B602.6010306@intel.com>
 <20160428132249.GB27560@shlinux2.ap.freescale.net>
 <57230515.9030602@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35218 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcD2Hu5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 03:50:57 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so13550104pac.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 00:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57230515.9030602@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On Fri, Apr 29, 2016 at 09:54:13AM +0300, Adrian Hunter wrote:
> On 28/04/16 16:22, Dong Aisheng wrote:
> > On Thu, Apr 28, 2016 at 10:04:34AM +0300, Adrian Hunter wrote:
> >> On 24/04/16 13:47, Dong Aisheng wrote:
> >>> On Fri, Apr 22, 2016 at 8:48 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>> On 15/04/16 20:29, Dong Aisheng wrote:
> >>>>> During card detection process, mmc core may sends commands
> >>>>> to detect if card is still exist in mmc_rescan for removable
> >>>>> card which may trigger mmc retuning process after a bit time
> >>>>> of runtime pm suspend.
> >>>>> Obviously this retuning process is meaningless for card remove
> >>>>> case, so we disable mmc_retune in mmc_detect_change() for it.
> >>>>> For card insert case, the mmc_retune will be enabled normally
> >>>>> in its card initialization process later in mmc_execute_tuning().
> >>>>> So disable it at first has no side effection.
> >>>>
> >>>> We don't assume that the card has been removed, which is why we send
> >>>> commands to find out if it is still there.  If it is still there, this
> >>>> change will have incorrectly disabled re-tuning.
> >>>>
> >>>
> >>> Do you mean the 'fake' card remove interrupt like caused by glitch?
> >>
> >> Sure
> >>
> >>> Yes, if that the card is still exist and re-tuning is wrongly disabled.
> >>>
> >>> So we could re-enable re-tuning for this special case?
> >>> Something like:
> >>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>> index 41b1e76..e1990a8 100644
> >>> --- a/drivers/mmc/core/core.c
> >>> +++ b/drivers/mmc/core/core.c
> >>> @@ -2607,6 +2607,8 @@ void mmc_rescan(struct work_struct *work)
> >>>
> >>>         /* if there still is a card present, stop here */
> >>>         if (host->bus_ops != NULL) {
> >>> +               if (tuning_is_enabled_before())
> >>> +                       mmc_retune_enable(host);
> >>>                 mmc_bus_put(host);
> >>>                 goto out;
> >>>         }
> >>>
> >>>
> >>>> Do you have an actual problem with the way it works now?
> >>>>
> >>>
> >>> No actual problems now.
> >>
> >> So let's not spend time on it.
> >>
> >>> I just observe a lot tuning commands keep sending although the card is already
> >>> removed which seems a bit meaningless.
> >>> And most tuning execution process is executed with sin_lock_irqsave, i'm not
> >>> sure if the mass tuning commands may affect the system when CPU is busy.
> >>> What do you think?
> >>
> >> sdhci spin lock is unlocked while waiting for tuning commands.
> >>
> > 
> > It's 40 commands continuously and only cmd transfer time is unlocked.
> 
> Not for sdhci_execute_tuning() it's not.  Only one command is sent.

IMX case is different.
Please see below log on MX6SX SDB.

For IMX6SX SDB:
root@imx6qdlsolo:~# [   39.649322] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   39.661452] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
[   39.668295] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   39.679146] mmc1: starting CMD13 arg e6240000 flags 00000195
[   39.684908] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.693359] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.701654] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.709717] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.717718] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.725057] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.734818] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.744197] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.752316] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.760363] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.778296] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.788348] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.795731] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.803932] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.811865] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.819801] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.827710] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.835046] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.843384] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.851293] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.859209] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.867111] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.874450] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.882725] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.890610] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.898615] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.905953] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.913821] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.922283] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.930177] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.938082] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.945676] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.953696] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.961914] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.969792] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.977682] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.985018] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   39.992898] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   40.001107] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   40.009125] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000020
[   40.018058] mmc1: req failed (CMD13): -123, retrying...
[   40.023435] mmc1: req failed (CMD13): -123, retrying...
[   40.029614] mmc1: req failed (CMD13): -123, retrying...
[   40.034981] mmc1: req done (CMD13): -123: 00000000 00000000 00000000 00000000
[   40.042891] mmc1: card remove detected
[   40.047446] mmc1: card e624 removed
[   40.208083] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   40.222000] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
[   40.228813] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   40.238175] mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
[   40.247693] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0


And IMX6DL ARD is even worser due to it's using common
mmc_send_tuning() function.
root@imx6qdlsolo:~# 
root@imx6qdlsolo:~# [  129.462564] sysrq: SysRq : Changing Loglevel
[  129.466902] sysrq: Loglevel set to 8
[  131.616078] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[  131.625311] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
[  131.632133] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[  131.642121] mmc0: starting CMD13 arg 59b40000 flags 00000195
[  131.648925] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x0 ESDHC_TUNE_CTRL_STATUS 0x0
[  131.657818] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.663518] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.670835] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.678069] mmc0:     0 bytes transferred: 0
[  131.683433] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1 ESDHC_TUNE_CTRL_STATUS 0x1000100
[  131.692940] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.698709] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.705625] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.712854] mmc0:     0 bytes transferred: 0
[  131.718251] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2 ESDHC_TUNE_CTRL_STATUS 0x2000200
[  131.727375] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.733074] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.740043] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.747256] mmc0:     0 bytes transferred: 0
[  131.752611] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3 ESDHC_TUNE_CTRL_STATUS 0x3000300
[  131.761751] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.767506] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.774419] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.781642] mmc0:     0 bytes transferred: 0
[  131.787035] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4 ESDHC_TUNE_CTRL_STATUS 0x4000400
[  131.796156] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.801851] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.808832] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.816037] mmc0:     0 bytes transferred: 0
[  131.821389] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5 ESDHC_TUNE_CTRL_STATUS 0x5000500
[  131.830503] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.836254] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.843162] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.850385] mmc0:     0 bytes transferred: 0
[  131.855737] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6 ESDHC_TUNE_CTRL_STATUS 0x6000600
[  131.864863] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.870613] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.877565] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.884728] mmc0:     0 bytes transferred: 0
[  131.890133] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7 ESDHC_TUNE_CTRL_STATUS 0x7000700
[  131.899247] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.904939] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.911903] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.919122] mmc0:     0 bytes transferred: 0
[  131.924474] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x8 ESDHC_TUNE_CTRL_STATUS 0x8000800
[  131.933591] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.939340] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.946300] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.953464] mmc0:     0 bytes transferred: 0
[  131.958869] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x9 ESDHC_TUNE_CTRL_STATUS 0x9000900
[  131.967965] mmc0: starting CMD19 arg 00000000 flags 00000035
[  131.973657] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  131.980621] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  131.987831] mmc0:     0 bytes transferred: 0
[  131.993183] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xa ESDHC_TUNE_CTRL_STATUS 0xa000a00
[  132.002295] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.008039] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.014945] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.022167] mmc0:     0 bytes transferred: 0
[  132.027555] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xb ESDHC_TUNE_CTRL_STATUS 0xb000b00
[  132.036682] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.042376] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.049341] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.056555] mmc0:     0 bytes transferred: 0
[  132.061905] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xc ESDHC_TUNE_CTRL_STATUS 0xc000c00
[  132.071020] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.076760] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.083663] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.090886] mmc0:     0 bytes transferred: 0
[  132.096237] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xd ESDHC_TUNE_CTRL_STATUS 0xd000d00
[  132.105233] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.110981] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.117911] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.125072] mmc0:     0 bytes transferred: 0
[  132.130494] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xe ESDHC_TUNE_CTRL_STATUS 0xe000e00
[  132.139538] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.145227] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.152185] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.159403] mmc0:     0 bytes transferred: 0
[  132.164755] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0xf ESDHC_TUNE_CTRL_STATUS 0xf000f00
[  132.173884] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.179622] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.186579] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.193743] mmc0:     0 bytes transferred: 0
[  132.199157] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x10 ESDHC_TUNE_CTRL_STATUS 0x10001000
[  132.208432] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.214124] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.221088] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.228308] mmc0:     0 bytes transferred: 0
[  132.233658] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x11 ESDHC_TUNE_CTRL_STATUS 0x11001100
[  132.242930] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.248677] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.255584] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.262803] mmc0:     0 bytes transferred: 0
[  132.268190] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x12 ESDHC_TUNE_CTRL_STATUS 0x12001200
[  132.277483] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.283184] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.290171] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.297385] mmc0:     0 bytes transferred: 0
[  132.302737] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x13 ESDHC_TUNE_CTRL_STATUS 0x13001300
[  132.312043] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.317786] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.324697] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.331920] mmc0:     0 bytes transferred: 0
[  132.337308] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x14 ESDHC_TUNE_CTRL_STATUS 0x14001400
[  132.346604] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.352297] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.359271] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.366482] mmc0:     0 bytes transferred: 0
[  132.371833] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x15 ESDHC_TUNE_CTRL_STATUS 0x15001500
[  132.381125] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.386867] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.393773] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.400990] mmc0:     0 bytes transferred: 0
[  132.406344] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x16 ESDHC_TUNE_CTRL_STATUS 0x16001600
[  132.415517] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.421265] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.428214] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.435375] mmc0:     0 bytes transferred: 0
[  132.440827] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x17 ESDHC_TUNE_CTRL_STATUS 0x17001700
[  132.450046] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.455736] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.462696] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.469914] mmc0:     0 bytes transferred: 0
[  132.475264] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x18 ESDHC_TUNE_CTRL_STATUS 0x18001800
[  132.484554] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.490299] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.497255] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.504419] mmc0:     0 bytes transferred: 0
[  132.509826] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x19 ESDHC_TUNE_CTRL_STATUS 0x19001900
[  132.519096] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.524786] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.531751] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.538971] mmc0:     0 bytes transferred: 0
[  132.544322] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1a ESDHC_TUNE_CTRL_STATUS 0x1a001a00
[  132.553609] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.559357] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.566325] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.573488] mmc0:     0 bytes transferred: 0
[  132.578898] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1b ESDHC_TUNE_CTRL_STATUS 0x1b001b00
[  132.588168] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.593861] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.600820] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.608037] mmc0:     0 bytes transferred: 0
[  132.613390] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1c ESDHC_TUNE_CTRL_STATUS 0x1c001c00
[  132.622680] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.628428] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.635334] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.642556] mmc0:     0 bytes transferred: 0
[  132.647945] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1d ESDHC_TUNE_CTRL_STATUS 0x1d001d00
[  132.657231] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.662930] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.669892] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.677099] mmc0:     0 bytes transferred: 0
[  132.682450] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1e ESDHC_TUNE_CTRL_STATUS 0x1e001e00
[  132.691737] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.697490] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.704403] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.711624] mmc0:     0 bytes transferred: 0
[  132.717010] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x1f ESDHC_TUNE_CTRL_STATUS 0x1f001f00
[  132.726301] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.731998] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.738960] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.746169] mmc0:     0 bytes transferred: 0
[  132.751525] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x20 ESDHC_TUNE_CTRL_STATUS 0x20002000
[  132.760817] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.766577] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.773491] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.780714] mmc0:     0 bytes transferred: 0
[  132.786069] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x21 ESDHC_TUNE_CTRL_STATUS 0x21002100
[  132.795243] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.800992] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.807923] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.815084] mmc0:     0 bytes transferred: 0
[  132.820546] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x22 ESDHC_TUNE_CTRL_STATUS 0x22002200
[  132.829787] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.835477] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.842441] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.849663] mmc0:     0 bytes transferred: 0
[  132.855016] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x23 ESDHC_TUNE_CTRL_STATUS 0x23002300
[  132.864305] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.870056] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.877015] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.884179] mmc0:     0 bytes transferred: 0
[  132.889584] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x24 ESDHC_TUNE_CTRL_STATUS 0x24002400
[  132.898860] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.904551] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.911512] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.918731] mmc0:     0 bytes transferred: 0
[  132.924080] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x25 ESDHC_TUNE_CTRL_STATUS 0x25002500
[  132.933368] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.939114] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.946071] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.953235] mmc0:     0 bytes transferred: 0
[  132.958640] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x26 ESDHC_TUNE_CTRL_STATUS 0x26002600
[  132.967924] mmc0: starting CMD19 arg 00000000 flags 00000035
[  132.973614] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  132.980584] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  132.987796] mmc0:     0 bytes transferred: 0
[  132.993147] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x27 ESDHC_TUNE_CTRL_STATUS 0x27002700
[  133.002433] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.008181] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.015089] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.022310] mmc0:     0 bytes transferred: 0
[  133.027699] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x28 ESDHC_TUNE_CTRL_STATUS 0x28002800
[  133.037014] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.042712] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.049679] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.056890] mmc0:     0 bytes transferred: 0
[  133.062237] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x29 ESDHC_TUNE_CTRL_STATUS 0x29002900
[  133.071525] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.077267] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.084172] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.091392] mmc0:     0 bytes transferred: 0
[  133.096746] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2a ESDHC_TUNE_CTRL_STATUS 0x2a002a00
[  133.106021] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.111714] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.118679] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.125889] mmc0:     0 bytes transferred: 0
[  133.131241] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2b ESDHC_TUNE_CTRL_STATUS 0x2b002b00
[  133.140530] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.146272] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.153184] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.160409] mmc0:     0 bytes transferred: 0
[  133.165762] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2c ESDHC_TUNE_CTRL_STATUS 0x2c002c00
[  133.175059] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.180798] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.187759] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.194922] mmc0:     0 bytes transferred: 0
[  133.200329] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2d ESDHC_TUNE_CTRL_STATUS 0x2d002d00
[  133.209600] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.215291] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.222254] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.229474] mmc0:     0 bytes transferred: 0
[  133.234823] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2e ESDHC_TUNE_CTRL_STATUS 0x2e002e00
[  133.244124] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.249865] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.256828] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.263991] mmc0:     0 bytes transferred: 0
[  133.269395] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x2f ESDHC_TUNE_CTRL_STATUS 0x2f002f00
[  133.278668] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.284361] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.291340] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.298566] mmc0:     0 bytes transferred: 0
[  133.303922] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x30 ESDHC_TUNE_CTRL_STATUS 0x30003000
[  133.313213] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.318975] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.325939] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.333103] mmc0:     0 bytes transferred: 0
[  133.338506] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x31 ESDHC_TUNE_CTRL_STATUS 0x31003100
[  133.347792] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.353484] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.360450] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.367661] mmc0:     0 bytes transferred: 0
[  133.373010] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x32 ESDHC_TUNE_CTRL_STATUS 0x32003200
[  133.382312] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.388059] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.394965] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.402178] mmc0:     0 bytes transferred: 0
[  133.407573] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x33 ESDHC_TUNE_CTRL_STATUS 0x33003300
[  133.416864] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.422560] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.429523] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.436727] mmc0:     0 bytes transferred: 0
[  133.442079] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x34 ESDHC_TUNE_CTRL_STATUS 0x34003400
[  133.451364] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.457116] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.464027] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.471251] mmc0:     0 bytes transferred: 0
[  133.476608] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x35 ESDHC_TUNE_CTRL_STATUS 0x35003500
[  133.485780] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.491574] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.498529] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.505693] mmc0:     0 bytes transferred: 0
[  133.511177] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x36 ESDHC_TUNE_CTRL_STATUS 0x36003600
[  133.520407] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.526149] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.533061] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.540285] mmc0:     0 bytes transferred: 0
[  133.545638] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x37 ESDHC_TUNE_CTRL_STATUS 0x37003700
[  133.554931] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.560681] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.567639] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.574802] mmc0:     0 bytes transferred: 0
[  133.580206] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x38 ESDHC_TUNE_CTRL_STATUS 0x38003800
[  133.589493] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.595185] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.602144] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.609359] mmc0:     0 bytes transferred: 0
[  133.614712] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x39 ESDHC_TUNE_CTRL_STATUS 0x39003900
[  133.624000] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.629754] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.636727] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.643891] mmc0:     0 bytes transferred: 0
[  133.649293] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3a ESDHC_TUNE_CTRL_STATUS 0x3a003a00
[  133.658567] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.664259] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.671225] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.678445] mmc0:     0 bytes transferred: 0
[  133.683798] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3b ESDHC_TUNE_CTRL_STATUS 0x3b003b00
[  133.693086] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.698824] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.705728] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.712950] mmc0:     0 bytes transferred: 0
[  133.718336] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3c ESDHC_TUNE_CTRL_STATUS 0x3c003c00
[  133.727625] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.733322] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.740287] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.747498] mmc0:     0 bytes transferred: 0
[  133.752851] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3d ESDHC_TUNE_CTRL_STATUS 0x3d003d00
[  133.762139] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.767913] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.774827] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.782051] mmc0:     0 bytes transferred: 0
[  133.787438] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3e ESDHC_TUNE_CTRL_STATUS 0x3e003e00
[  133.796727] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.802421] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.809397] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.816617] mmc0:     0 bytes transferred: 0
[  133.821967] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x3f ESDHC_TUNE_CTRL_STATUS 0x3f003f00
[  133.831258] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.837001] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.843909] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.851122] mmc0:     0 bytes transferred: 0
[  133.856476] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x40 ESDHC_TUNE_CTRL_STATUS 0x40004000
[  133.865647] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.871395] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.878332] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.885495] mmc0:     0 bytes transferred: 0
[  133.890922] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x41 ESDHC_TUNE_CTRL_STATUS 0x41004100
[  133.900145] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.905886] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.912795] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.920018] mmc0:     0 bytes transferred: 0
[  133.925371] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x42 ESDHC_TUNE_CTRL_STATUS 0x42004200
[  133.934662] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.940411] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.947371] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.954536] mmc0:     0 bytes transferred: 0
[  133.959943] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x43 ESDHC_TUNE_CTRL_STATUS 0x43004300
[  133.969217] mmc0: starting CMD19 arg 00000000 flags 00000035
[  133.974908] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  133.981871] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  133.989092] mmc0:     0 bytes transferred: 0
[  133.994441] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x44 ESDHC_TUNE_CTRL_STATUS 0x44004400
[  134.003714] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.009465] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.016434] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.023598] mmc0:     0 bytes transferred: 0
[  134.029006] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x45 ESDHC_TUNE_CTRL_STATUS 0x45004500
[  134.038294] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.043984] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.050936] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.058150] mmc0:     0 bytes transferred: 0
[  134.063501] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x46 ESDHC_TUNE_CTRL_STATUS 0x46004600
[  134.072790] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.078541] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.085447] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.092664] mmc0:     0 bytes transferred: 0
[  134.098068] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x47 ESDHC_TUNE_CTRL_STATUS 0x47004700
[  134.107355] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.113053] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.120021] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.127231] mmc0:     0 bytes transferred: 0
[  134.132580] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x48 ESDHC_TUNE_CTRL_STATUS 0x48004800
[  134.141866] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.147617] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.154527] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.161749] mmc0:     0 bytes transferred: 0
[  134.167137] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x49 ESDHC_TUNE_CTRL_STATUS 0x49004900
[  134.176430] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.182129] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.189101] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.196310] mmc0:     0 bytes transferred: 0
[  134.201660] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4a ESDHC_TUNE_CTRL_STATUS 0x4a004a00
[  134.210944] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.216683] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.223586] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.230807] mmc0:     0 bytes transferred: 0
[  134.236162] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4b ESDHC_TUNE_CTRL_STATUS 0x4b004b00
[  134.245335] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.251076] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.258013] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.265177] mmc0:     0 bytes transferred: 0
[  134.270609] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4c ESDHC_TUNE_CTRL_STATUS 0x4c004c00
[  134.279849] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.285539] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.292509] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.299730] mmc0:     0 bytes transferred: 0
[  134.305087] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4d ESDHC_TUNE_CTRL_STATUS 0x4d004d00
[  134.314397] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.320147] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.327115] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.334281] mmc0:     0 bytes transferred: 0
[  134.339692] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4e ESDHC_TUNE_CTRL_STATUS 0x4e004e00
[  134.348979] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.354671] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.361642] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.368858] mmc0:     0 bytes transferred: 0
[  134.374209] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x4f ESDHC_TUNE_CTRL_STATUS 0x4f004f00
[  134.383503] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.389253] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.396215] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.403378] mmc0:     0 bytes transferred: 0
[  134.408785] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x50 ESDHC_TUNE_CTRL_STATUS 0x50005000
[  134.418057] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.423747] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.430706] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.437930] mmc0:     0 bytes transferred: 0
[  134.443285] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x51 ESDHC_TUNE_CTRL_STATUS 0x51005100
[  134.452586] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.458348] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.465259] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.472479] mmc0:     0 bytes transferred: 0
[  134.477873] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x52 ESDHC_TUNE_CTRL_STATUS 0x52005200
[  134.487159] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.492855] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.499830] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.507051] mmc0:     0 bytes transferred: 0
[  134.512400] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x53 ESDHC_TUNE_CTRL_STATUS 0x53005300
[  134.521693] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.527433] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.534342] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.541563] mmc0:     0 bytes transferred: 0
[  134.546952] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x54 ESDHC_TUNE_CTRL_STATUS 0x54005400
[  134.556236] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.561935] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.568899] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.576107] mmc0:     0 bytes transferred: 0
[  134.581455] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x55 ESDHC_TUNE_CTRL_STATUS 0x55005500
[  134.590757] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.596497] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.603405] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.610625] mmc0:     0 bytes transferred: 0
[  134.615978] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x56 ESDHC_TUNE_CTRL_STATUS 0x56005600
[  134.625152] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.630900] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.637831] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.644992] mmc0:     0 bytes transferred: 0
[  134.650416] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x57 ESDHC_TUNE_CTRL_STATUS 0x57005700
[  134.659636] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.665325] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.672284] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.679498] mmc0:     0 bytes transferred: 0
[  134.684849] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x58 ESDHC_TUNE_CTRL_STATUS 0x58005800
[  134.694145] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.699896] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.706858] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.714022] mmc0:     0 bytes transferred: 0
[  134.719434] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x59 ESDHC_TUNE_CTRL_STATUS 0x59005900
[  134.728722] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.734413] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.741380] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.748608] mmc0:     0 bytes transferred: 0
[  134.753963] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5a ESDHC_TUNE_CTRL_STATUS 0x5a005a00
[  134.763253] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.769011] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.775986] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.783153] mmc0:     0 bytes transferred: 0
[  134.788564] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5b ESDHC_TUNE_CTRL_STATUS 0x5b005b00
[  134.797852] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.803543] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.810512] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.817723] mmc0:     0 bytes transferred: 0
[  134.823075] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5c ESDHC_TUNE_CTRL_STATUS 0x5c005c00
[  134.832368] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.838117] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.845029] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.852241] mmc0:     0 bytes transferred: 0
[  134.857633] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5d ESDHC_TUNE_CTRL_STATUS 0x5d005d00
[  134.866932] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.872626] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.879595] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.886806] mmc0:     0 bytes transferred: 0
[  134.892156] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5e ESDHC_TUNE_CTRL_STATUS 0x5e005e00
[  134.901443] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.907182] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.914092] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.921315] mmc0:     0 bytes transferred: 0
[  134.926673] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x5f ESDHC_TUNE_CTRL_STATUS 0x5f005f00
[  134.935947] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.941639] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.948607] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.955772] mmc0:     0 bytes transferred: 0
[  134.961210] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x60 ESDHC_TUNE_CTRL_STATUS 0x60006000
[  134.970504] mmc0: starting CMD19 arg 00000000 flags 00000035
[  134.976244] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  134.983152] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  134.990374] mmc0:     0 bytes transferred: 0
[  134.995734] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x61 ESDHC_TUNE_CTRL_STATUS 0x61006100
[  135.005021] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.010768] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.017753] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.024919] mmc0:     0 bytes transferred: 0
[  135.030320] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x62 ESDHC_TUNE_CTRL_STATUS 0x62006200
[  135.039604] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.045295] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.052271] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.059486] mmc0:     0 bytes transferred: 0
[  135.064837] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x63 ESDHC_TUNE_CTRL_STATUS 0x63006300
[  135.074125] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.079884] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.086848] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.094012] mmc0:     0 bytes transferred: 0
[  135.099418] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x64 ESDHC_TUNE_CTRL_STATUS 0x64006400
[  135.108707] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.114399] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.121366] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.128591] mmc0:     0 bytes transferred: 0
[  135.133943] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x65 ESDHC_TUNE_CTRL_STATUS 0x65006500
[  135.143236] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.148988] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.155949] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.163114] mmc0:     0 bytes transferred: 0
[  135.168523] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x66 ESDHC_TUNE_CTRL_STATUS 0x66006600
[  135.177798] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.183489] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.190452] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.197662] mmc0:     0 bytes transferred: 0
[  135.203010] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x67 ESDHC_TUNE_CTRL_STATUS 0x67006700
[  135.212295] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.218043] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.224949] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.232173] mmc0:     0 bytes transferred: 0
[  135.237560] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x68 ESDHC_TUNE_CTRL_STATUS 0x68006800
[  135.246843] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.252540] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.259505] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.266712] mmc0:     0 bytes transferred: 0
[  135.272060] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x69 ESDHC_TUNE_CTRL_STATUS 0x69006900
[  135.281350] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.287101] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.294008] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.301231] mmc0:     0 bytes transferred: 0
[  135.306589] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6a ESDHC_TUNE_CTRL_STATUS 0x6a006a00
[  135.315763] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.321523] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.328479] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.335640] mmc0:     0 bytes transferred: 0
[  135.341099] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6b ESDHC_TUNE_CTRL_STATUS 0x6b006b00
[  135.350324] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.356063] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.362976] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.370198] mmc0:     0 bytes transferred: 0
[  135.375553] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6c ESDHC_TUNE_CTRL_STATUS 0x6c006c00
[  135.384848] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.390597] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.397554] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.404717] mmc0:     0 bytes transferred: 0
[  135.410125] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6d ESDHC_TUNE_CTRL_STATUS 0x6d006d00
[  135.419424] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.425117] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.432086] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.439313] mmc0:     0 bytes transferred: 0
[  135.444664] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6e ESDHC_TUNE_CTRL_STATUS 0x6e006e00
[  135.453948] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.459709] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.466672] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.473836] mmc0:     0 bytes transferred: 0
[  135.479239] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x6f ESDHC_TUNE_CTRL_STATUS 0x6f006f00
[  135.488521] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.494213] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.501177] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.508392] mmc0:     0 bytes transferred: 0
[  135.513742] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x70 ESDHC_TUNE_CTRL_STATUS 0x70007000
[  135.523027] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.528777] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.535683] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.542902] mmc0:     0 bytes transferred: 0
[  135.548295] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x71 ESDHC_TUNE_CTRL_STATUS 0x71007100
[  135.557587] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.563280] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.570241] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.577451] mmc0:     0 bytes transferred: 0
[  135.582802] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x72 ESDHC_TUNE_CTRL_STATUS 0x72007200
[  135.592096] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.597839] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.604746] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.611968] mmc0:     0 bytes transferred: 0
[  135.617357] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x73 ESDHC_TUNE_CTRL_STATUS 0x73007300
[  135.626650] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.632347] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.639314] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.646523] mmc0:     0 bytes transferred: 0
[  135.651872] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x74 ESDHC_TUNE_CTRL_STATUS 0x74007400
[  135.661160] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.666903] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.673811] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.681033] mmc0:     0 bytes transferred: 0
[  135.686388] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x75 ESDHC_TUNE_CTRL_STATUS 0x75007500
[  135.695558] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.701309] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.708245] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.715406] mmc0:     0 bytes transferred: 0
[  135.720832] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x76 ESDHC_TUNE_CTRL_STATUS 0x76007600
[  135.730053] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.735742] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.742700] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.749929] mmc0:     0 bytes transferred: 0
[  135.755283] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x77 ESDHC_TUNE_CTRL_STATUS 0x77007700
[  135.764573] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.770334] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.777303] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.784468] mmc0:     0 bytes transferred: 0
[  135.789882] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x78 ESDHC_TUNE_CTRL_STATUS 0x78007800
[  135.799170] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.804863] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.811831] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.819052] mmc0:     0 bytes transferred: 0
[  135.824404] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x79 ESDHC_TUNE_CTRL_STATUS 0x79007900
[  135.833708] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.839457] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.846418] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.853582] mmc0:     0 bytes transferred: 0
[  135.858990] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7a ESDHC_TUNE_CTRL_STATUS 0x7a007a00
[  135.868280] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.873973] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.880955] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.888190] mmc0:     0 bytes transferred: 0
[  135.893542] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7b ESDHC_TUNE_CTRL_STATUS 0x7b007b00
[  135.902832] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.908590] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.915500] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.922722] mmc0:     0 bytes transferred: 0
[  135.928115] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7c ESDHC_TUNE_CTRL_STATUS 0x7c007c00
[  135.937409] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.943108] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.950080] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.957288] mmc0:     0 bytes transferred: 0
[  135.962637] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7d ESDHC_TUNE_CTRL_STATUS 0x7d007d00
[  135.971935] mmc0: starting CMD19 arg 00000000 flags 00000035
[  135.977695] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  135.984873] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  135.992111] mmc0:     0 bytes transferred: 0
[  135.997536] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7e ESDHC_TUNE_CTRL_STATUS 0x7e007e00
[  136.006774] mmc0: starting CMD19 arg 00000000 flags 00000035
[  136.012466] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  136.019444] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  136.026656] mmc0:     0 bytes transferred: 0
[  136.032008] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x7f ESDHC_TUNE_CTRL_STATUS 0x7f00
[  136.040939] mmc0: starting CMD19 arg 00000000 flags 00000035
[  136.046687] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[  136.053600] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[  136.060826] mmc0:     0 bytes transferred: 0
[  136.065180] sdhci-esdhc-imx 2198000.usdhc: tunning failed at 0x7f ret -123
[  136.072151] mmc0: tuning execution failed: -123
[  136.076816] mmc0: req failed (CMD13): -123, retrying...
[  136.082738] mmc0: req failed (CMD13): -123, retrying...
[  136.088413] mmc0: req failed (CMD13): -123, retrying...
[  136.093743] mmc0: req done (CMD13): -123: 00000000 00000000 00000000 00000000
[  136.100994] mmc0: card remove detected
[  136.104984] mmc0: card 59b4 removed
[  136.113392] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
[  136.120648] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[  136.373709] FAT-fs (mmcblk0p1): FAT read failed (blocknr 942)

So it's a bit hard for me to believe it has no affection.

> Currently we don't even send the CMD13 because we check card detect first.
> I added prints for sdhci_execute_tuning and got this:
> 
> [  255.536326] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000080
> [  255.743653] mmc1: starting CMD13 arg 59b40000 flags 00000195
> [  255.750093] mmc1: sdhci_execute_tuning
> [  255.754358] mmc1: sdhci_execute_tuning: send command
> [  255.809638] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock

I double checked the code, it seems why your platform only sends one tuning
command is because your controller did not generate buffer ready interrupt
if card is already removed.

> [  255.824810] mmc1: req failed (CMD13): -123, retrying...
> [  255.832766] mmc1: req failed (CMD13): -123, retrying...
> [  255.840722] mmc1: req failed (CMD13): -123, retrying...
> [  255.848672] mmc1: req done (CMD13): -123: 00000000 00000000 00000000 00000000
> [  255.856773] mmc1: card remove detected
> [  255.861056] mmc1: card 59b4 removed
> [  255.872872] mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 0 timing 0
> 
> > 
> > Hmm.. I can't sure it's no affection.
> > e.g we did have customers reporting cd plug in/out causing jitters
> > when system is busy playing audio or video.
> > Maybe we need to do those tests.
> > 
> > Anyway, what's your point to keep sending tuning commands after card
> > is already removed?
> 
> Seems like a problem for your driver not the core.  Why not check card detect
> after the first error in esdhc_executing_tuning().
> 

It is not IMX driver problem.
IMX is based on SDHCI driver and it does check card detect for CMD13,
but sdhci_execute_tuning not.

We may either check CD in sdhci_execute_tuning() or disable tuning
for card remove case.

Personally i'd like to disable it in core since i really can't see
the meaning to keep it for card remove.

What's your idea?

Regards
Dong Aisheng

> > 
> > Regards
> > Dong Aisheng
> > 
> >>>
> >>> Regards
> >>> Dong Aisheng
> >>>
> >>>>>
> >>>>> CC: stable <stable@vger.kernel.org>
> >>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>>>> ---
> >>>>>  drivers/mmc/core/core.c | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>>>> index 52bfaf0..76d0802 100644
> >>>>> --- a/drivers/mmc/core/core.c
> >>>>> +++ b/drivers/mmc/core/core.c
> >>>>> @@ -1888,6 +1888,7 @@ static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> >>>>>               pm_wakeup_event(mmc_dev(host), 5000);
> >>>>>
> >>>>>       host->detect_change = 1;
> >>>>> +     mmc_retune_disable(host);
> >>>>>       mmc_schedule_delayed_work(&host->detect, delay);
> >>>>>  }
> >>>>>
> >>>>>
> >>>>
> >>>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
