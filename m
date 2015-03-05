From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update codes relevant to dw-mmc controller
Date: Thu, 5 Mar 2015 09:21:27 +0100
Message-ID: <CAPDyKFoJdQi6uDbw6gDFGR8oHfc2No0YFdGb2ZWPmpSC54aTGA@mail.gmail.com>
References: <54F7F0AD.5080903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:37869 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbCEIV2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 03:21:28 -0500
Received: by qcrw7 with SMTP id w7so41687702qcr.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 00:21:27 -0800 (PST)
In-Reply-To: <54F7F0AD.5080903@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Alim Akhtar <alim.akhtar@samsung.com>

On 5 March 2015 at 06:59, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> I didn't find that your-tree is rebased to v4.0-rc2.
> This pull-request is based on your next branch(v4.0-rc1).
> If i have to rebase this work for v4.0-rc2, let me know, plz.

Thanks Jaehoon! I have pulled it into my next branch.

I think it's fine if you just stay on top of my next branch. If you at
any point see that dw_mmc has a dependency to a new rc, then just tell
me and I will rebase my next branch on that.

One more minor thing, I suggest you to add your sob tag for each patch
and not the ack. Some of the patches had both.

Again, thanks for helping out!

Kind regards
Uffe

>
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
>
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git tags/v4.0-2-for-ulf
>
> for you to fetch changes up to 7aa3dc1a9ed5f38fa491016cff8cbec383bac805:
>
>   mmc: dw_mmc: Don't crash if we get an interrupt before slot has initted (2015-03-04 23:39:23 +0900)
>
> ----------------------------------------------------------------
> Main feature:
> - Support HS400 mode for designware controller.
>
> ----------------------------------------------------------------
> Doug Anderson (5):
>       mmc: dw_mmc: Make sure we only adjust the clock when power is on
>       mmc: dw_mmc: Give a good reset after we give power
>       mmc: dw_mmc: Don't start commands while busy
>       mmc: dw_mmc: Only enable CD after setup and only if needed
>       mmc: dw_mmc: Don't crash if we get an interrupt before slot has initted
>
> Seungwon Jeon (1):
>       mmc: dw_mmc: exynos: Support eMMC's HS400 mode
>
> addy ke (2):
>       mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME capability
>       mmc: dw_mmc: fix mmc_test by not sending abort for DRTO/EBE errors
>
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
>  drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
>  drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
>  drivers/mmc/host/dw_mmc-rockchip.c                 |    8 +
>  drivers/mmc/host/dw_mmc.c                          |  142 ++++++++++++---
>  drivers/mmc/host/dw_mmc.h                          |    2 +
>  6 files changed, 309 insertions(+), 54 deletions(-)
