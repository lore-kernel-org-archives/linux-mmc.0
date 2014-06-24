From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Tue, 24 Jun 2014 11:10:48 -0700
Message-ID: <CAD=FV=XxdWEpoTMfJmUHpY7ykF+ZWrvP-GAoF+=mEeSeP7+ekA@mail.gmail.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
	<1403520321-2431-3-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:42338 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaFXSKt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jun 2014 14:10:49 -0400
Received: by mail-vc0-f177.google.com with SMTP id ij19so704007vcb.22
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2014 11:10:48 -0700 (PDT)
In-Reply-To: <1403520321-2431-3-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, ks.giri@samsung.com, Prashanth G <prashanth.g@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Yuvaraj,

On Mon, Jun 23, 2014 at 3:45 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> On exynos 5250 and 5420 based boards which uses built-in CD# line
> for card detection.But unfortunately CD# line is on the same voltage
> rails as of I/O voltage rails.When we cut off vqmmc,the consequent
> card detection will break in these boards.
>
> Also if we let alone the vqmmc turned on when vmmc turned off, the
> card could have half way powered and this can damage the card.So
> this patch adds a check so that, if the board used the built-in
> card detection mechanism i.e through CDETECT, it will not turned
> down vqmmc and vmmc both.
>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Yes, but...

As I mentioned in our separate email thread about this you're now
preventing mmc_power_cycle() from working properly.

IMHO you need the patch I sent you back on April 24th (was it that
long ago?).  Due to the brokenness of exynos (and anyone else that
powers CD off of vqmmc) you need to extend the MMC core to
differentiate several different types of "power off":

* power off because no card is plugged in: you should keep your card on.
* power off because you're power cycling: you should power off your card.
* power off because the system is suspending: you should power off your card.

...the third bullet point is something I hadn't though of until just
now and probably isn't addressed in my old patch...


Also: as we've discussed privately: you could imagine someone
designing an exynos5-based board where they've put the CD on a
separate GPIO.  On a system like this then all these hacks won't be
necessary.

---

Verbatim from my email about this topic on May 28th:

There are two important cases to handle:

1. Properly power cycle both vmmc and vqmmc (at the same time!) in
mmc_power_cycle().

2. DON'T power off for mmc_power_off() unless it's part of
mmc_power_cycle().  Specifically note that mmc_power_off() is called
in a whole bunch of places other than mmc_power_cycle().  For
instance, if we fail to probe a card we'll call mmc_power_off().  All
of these _must_ not turn off power to card detect or else we won't be
able to see future card insertions.  Note that mmc_power_off() might
be called on its own even when a card is inserted.  Look at the end of
mmc_rescan_try_freq().  It will be called if there are errors
attaching a card.


Rules to always remember:

* On all boards you should turn on vmmc and vqmmc at the same time.
It's illegal to have vqmmc on without vmmc and not good to have vmmc
on without vqmmc.

* On exynos you must ensure that vqmmc is on at all times, except
during power cycling of a card.  If vqmmc is not on you can't detect
card insertions or removals since the card detect line won't be
powered.

* To handle errors, you must ensure that mmc_power_cycle() actually
cycles power to the card.
