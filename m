From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: MMC card removal during suspend
Date: Wed, 30 Sep 2015 18:10:29 +0200
Message-ID: <CAJ=nTsuy2aD66DSc5kmEi79OjzPsXdOC2bx5-GxS=xy8LMCA=Q@mail.gmail.com>
References: <CAJ=nTsuXgR4Fmjriy32LvbO49Yk_q0RYBV1S2FwHG+hZgG3aRw@mail.gmail.com>
	<CAPDyKFraSBSeRebD7VXbo8TTquSK4qUnqO6GvfRa-ye--7JXuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33706 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbbI3QKb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 12:10:31 -0400
Received: by lahh2 with SMTP id h2so52436093lah.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2015 09:10:29 -0700 (PDT)
In-Reply-To: <CAPDyKFraSBSeRebD7VXbo8TTquSK4qUnqO6GvfRa-ye--7JXuA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi again.

Thank you for your response Ulf.

I am going to start over though since I did not get everything right
the first time.

As stated I am running the 4.1.5 Linux kernel and what I am actually
using is a SD card. The host driver is sdhci-esdhc-imx.c.

And my initial issue was that on resume I get the following:
[   31.848397] mmc0: card never left busy state
[   31.848412] mmc0: error -110 during resume (card was removed?)
[   31.848550] PM: resume of devices complete after 2062.936 msecs
[   31.931086] PM: Finishing wakeup.
[   31.931102] Restarting tasks ... done.
[   31.954336] mmc0: card dade removed
[   32.358711] mmc0: host does not support reading read-only switch,
assuming write-enable
[   32.391857] mmc0: new SD card at address aaaa
[   32.418228] mmcblk0: mmc0:aaaa SU02G 1.84 GiB
[   32.446402]  mmcblk0: p1
[   32.835907] EXT4-fs (mmcblk0p1): recovery complete
[   32.840873] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)

And that was the reason of my initial questions on what is supposed to
happen when suspending.

The card IS actually "removed" when in suspended state since we cut
the power-rail completely to the SD card.

I assume that this is a sdhci-esdhc-imx issue, but then I wonder what
would be a proper fix for this.

As stated before I get around this problem by adding a HACK to force
removal of the SD card before suspending in mmc_pm_notify.

Sorry if I am spamming but I am trying to learn :).

Best Regards

Mirza Krak
