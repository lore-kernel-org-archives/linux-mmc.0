From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC card removal during suspend
Date: Thu, 1 Oct 2015 11:39:17 +0200
Message-ID: <CAPDyKFqRMZiv_LAmZNkCJ_nt697qH53ki5EjMp+A9sWS8NMacA@mail.gmail.com>
References: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
	<CAPDyKFraSBSeRebD7VXbo8TTquSK4qUnqO6GvfRa-ye--7JXuA@mail.gmail.com>
	<CAJ=nTsuy2aD66DSc5kmEi79OjzPsXdOC2bx5-GxS=xy8LMCA=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37837 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbbJAJjU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2015 05:39:20 -0400
Received: by wicfx3 with SMTP id fx3so19718058wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2015 02:39:17 -0700 (PDT)
In-Reply-To: <CAJ=nTsuy2aD66DSc5kmEi79OjzPsXdOC2bx5-GxS=xy8LMCA=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 30 September 2015 at 18:10, Mirza Krak <mirza.krak@hostmobility.com> wrote:
> Hi again.
>
> Thank you for your response Ulf.
>
> I am going to start over though since I did not get everything right
> the first time.
>
> As stated I am running the 4.1.5 Linux kernel and what I am actually
> using is a SD card. The host driver is sdhci-esdhc-imx.c.
>
> And my initial issue was that on resume I get the following:
> [   31.848397] mmc0: card never left busy state
> [   31.848412] mmc0: error -110 during resume (card was removed?)

Normally this should indicate that the card actually has been
physically removed from the slot. As of course you wouldn't be able to
re-initiate a non-existing card. :-)

In your case it indicates that something else is wrong.

> [   31.848550] PM: resume of devices complete after 2062.936 msecs
> [   31.931086] PM: Finishing wakeup.
> [   31.931102] Restarting tasks ... done.
> [   31.954336] mmc0: card dade removed
> [   32.358711] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [   32.391857] mmc0: new SD card at address aaaa
> [   32.418228] mmcblk0: mmc0:aaaa SU02G 1.84 GiB
> [   32.446402]  mmcblk0: p1
> [   32.835907] EXT4-fs (mmcblk0p1): recovery complete
> [   32.840873] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
> data mode. Opts: (null)
>
> And that was the reason of my initial questions on what is supposed to
> happen when suspending.
>
> The card IS actually "removed" when in suspended state since we cut
> the power-rail completely to the SD card.

Actually its struct device is not being "removed", until a new
mmc_detect work is scheduled, which is when a resume has been
completed. mmc_pm_notify() (PM_POST_SUSPEND).

That detect work will find that the card isn't responding to commands,
power cycle it and re-try an new initialization of it. Apparently that
makes the card work again.

>
> I assume that this is a sdhci-esdhc-imx issue, but then I wonder what
> would be a proper fix for this.

sdhci and/or sdhci-esdhc-imx issue.

>
> As stated before I get around this problem by adding a HACK to force
> removal of the SD card before suspending in mmc_pm_notify.
>
> Sorry if I am spamming but I am trying to learn :).
>

So, to give you some advise on where to start.

1.
I would make sure that "suspending" the card by itself, without
actually suspending the entire system works okay. You can for example
do that by enabling MMC_CAP_AGGRESSIVE_PM, since that should then
suspend the card at request inactivity point. Add some debug prints to
make sure _mmc_sd_suspend()/_mmc_sd_resume() actually gets called.

2.
If 1) work, it's probably an issue in sdhci/sdhci-esdhc-imx
suspend/resume callbacks. Perhaps you might want to invoke these
callbacks manually as those should also work separately.

Good luck!

Kind regards
Uffe
