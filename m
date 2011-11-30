From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Wed, 30 Nov 2011 15:00:51 +0000
Message-ID: <WC20111130150051.910209@terrafix.co.uk>
References: <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com> <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com> <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com> <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com> <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:49436 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab1K3PBH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 10:01:07 -0500
In-Reply-To: <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

(For reference I have a Gumstix Fire (OMAP3530) revision R3118 plugged in to a PALO43 expansion board. The Gumstix Fire contains a W2CBW003, which in 
turn contains a Marvell 8686 SDIO WiFi).

Running linux-3.2-rc2 built with the omap2plus_defconfig (with a few features minor tweaks).

With the "stock" kernel I get:

# modprobe libertas_sdio
[   25.813598] lib80211: common routines for IEEE802.11 drivers
[   26.141082] cfg80211: Calling CRDA to update world regulatory domain
[   26.373718] libertas_sdio: Libertas SDIO driver
[   26.378479] libertas_sdio: Copyright Pierre Ossman
[   26.433105] libertas_sdio: probe of mmc1:0001:1 failed with error -16

So, I've enabled MMC_DEBUG (in Kconfig) and the DEBUG defines in libertas/defs.h, and now get:

[    4.036682] mmc1: new SDIO card at address 0001
[    4.042510] -
[    4.052459] mmc1: mmc_power_save_host: powering down

[   31.223724] libertas_sdio: Libertas SDIO driver
[   31.228485] libertas_sdio: Copyright Pierre Ossman
[   31.233703] mmc1: mmc_power_restore_host: powering up
[   31.239074] mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 20 width 0 timing 0
[   31.239349] omap_hsmmc omap_hsmmc.1: context was not lost
[   31.239379] omap_hsmmc omap_hsmmc.1: enabled
[   31.239410] omap_hsmmc omap_hsmmc.1: Set clock to 0Hz
[   31.243438] omap_hsmmc omap_hsmmc.1: disabled
[   31.262451] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[   31.262725] omap_hsmmc omap_hsmmc.1: context was not lost
[   31.262725] omap_hsmmc omap_hsmmc.1: enabled
[   31.262786] omap_hsmmc omap_hsmmc.1: Set clock to 400000Hz
[   31.263092] omap_hsmmc omap_hsmmc.1: disabled
[   31.286163] omap_hsmmc omap_hsmmc.1: context was not lost
[   31.286193] omap_hsmmc omap_hsmmc.1: enabled
[   31.286224] mmc1: starting CMD52 arg 00000c00 flags 00000195
[   31.286254] omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x00000c00
[   31.286590] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   31.286621] mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
[   31.286682] mmc1: starting CMD52 arg 80000c08 flags 00000195
[   31.286682] omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x80000c08
[   31.287017] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   31.287048] mmc1: req done (CMD52): 0: 00001008 00000000 00000000 00000000
[   31.287109] mmc1: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0
[   31.287109] omap_hsmmc omap_hsmmc.1: Set clock to 400000Hz
[   31.288146] mmc1: starting CMD0 arg 00000000 flags 000000c0
[   31.288177] omap_hsmmc omap_hsmmc.1: mmc1: CMD0, argument 0x00000000
[   31.288330] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   31.288360] mmc1: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[   31.289398] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
[   31.289428] omap_hsmmc omap_hsmmc.1: Set clock to 400000Hz
[   31.290466] mmc1: starting CMD8 arg 000001aa flags 000002f5
[   31.290466] omap_hsmmc omap_hsmmc.1: mmc1: CMD8, argument 0x000001aa
[   31.290832] omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
[   31.290863] omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
[   31.290893] mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
[   31.290924] mmc1: starting CMD5 arg 00000000 flags 000002e1
[   31.290954] omap_hsmmc omap_hsmmc.1: mmc1: CMD5, argument 0x00000000
[   31.291290] omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
[   31.291320] omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
[   31.291381] mmc1: req failed (CMD5): -110, retrying...
[   31.291412] omap_hsmmc omap_hsmmc.1: mmc1: CMD5, argument 0x00000000
[   31.291748] omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
[   31.291778] omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
[   31.291839] mmc1: req failed (CMD5): -110, retrying...
[   31.291870] omap_hsmmc omap_hsmmc.1: mmc1: CMD5, argument 0x00000000
[   31.292205] omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
[   31.292236] omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
[   31.292266] mmc1: req failed (CMD5): -110, retrying...
[   31.292297] omap_hsmmc omap_hsmmc.1: mmc1: CMD5, argument 0x00000000
[   31.292633] omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
[   31.292663] omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
[   31.292694] mmc1: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[   31.292877] libertas_sdio: probe of mmc1:0001:1 failed with error -16
[   31.387481] omap_hsmmc omap_hsmmc.1: disabled

Is this useful?

It seems CMD5 fails (which seems to be what the workarounds were aiming to fix).
I'm afraid I may not be of much more use as Gumstix (annoyingly) don't release schematics of their COMs, so actually probing any signals isn't really possible.

Cheers,
Joe



-----Original Message-----
From: Ohad Ben-Cohen <ohad@wizery.com>
To: Daniel Drake <dsd@laptop.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Date: Wed, 30 Nov 2011 16:29:21 +0200
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> On Wed, Nov 30, 2011 at 4:12 PM, Daniel Drake <dsd@laptop.org> wrote:
> > My patch simply sets a flag to enable a whole load of code written by
> > you - code which I understand little about. I am now available to
> > help, but given that my understanding of mmc is limited, I didn't
> > write the code in question, and I also lack expert insight into 8686
> > powerup, I'm not sure how useful I can be.
> 
> Let's revert 08da834 then.
> 
> When SDIO runtime PM was originally introduced, we immediately faced
> two regressions with two different chipsets, and in response decided
> not to enable it by default.
> 
> With your work on the 8686 we hoped we found all the gotchas, so
> 08da834 did make sense (at least experimentally).
> 
> Unfortunately we now see that some setups out there still refuse to
> work when SDIO runtime PM is enabled by default, and obviously we
> can't live with these kind of regressions.
> 
> commit fd9fec7a00f58a16803e37a99a014ef82543ef6f
> Author: Ohad Ben-Cohen <ohad@wizery.com>
> Date:   Wed Nov 30 16:22:13 2011 +0200
> 
>     Revert "mmc: enable runtime PM by default"
> 
>     When SDIO runtime PM was originally introduced, we immediately
> faced
>     two regressions with two different chipsets, and in response
> decided
>     not to enable it by default.
> 
>     With the recent work on the 8686 we hoped we found all the gotchas,
>     so 08da834 did make sense (at least experimentally).
> 
>     Unfortunately we now see that some setups out there still refuse to
> work
>     when SDIO runtime PM is enabled by default (see
>     http://www.spinics.net/lists/linux-mmc/msg11161.html), and
> obviously we
>     can't live with these kind of regressions.
> 
>     This reverts commit 08da834a24312157f512224691ad1fddd11c1073.
> 
>     Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>     Cc: Daniel Drake <dsd@laptop.org>
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index e8a5eb3..d31c78b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -302,17 +302,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct
> device *dev)
>  	host->max_blk_size = 512;
>  	host->max_blk_count = PAGE_CACHE_SIZE / 512;
> 
> -	/*
> -	 * Enable runtime power management by default. This flag was added
> due
> -	 * to runtime power management causing disruption for some users, but
> -	 * the power on/off code has been improved since then.
> -	 *
> -	 * We'll enable this flag by default as an experiment, and if no
> -	 * problems are reported, we will follow up later and remove the flag
> -	 * altogether.
> -	 */
> -	host->caps = MMC_CAP_POWER_OFF_CARD;
> -
>  	return host;
> 
>  free:


