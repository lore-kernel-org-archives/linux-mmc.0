From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/4] mmc: tmio/sdhi: prevent regressions when setting clock
Date: Tue, 3 May 2016 10:49:02 +0200
Message-ID: <CAPDyKFp_PuTBn1iD4CpMUvDciccKr1oBGmnG8rVAcvp41k=FPg@mail.gmail.com>
References: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

On 2 May 2016 at 22:25, Wolfram Sang <wsa@the-dreams.de> wrote:
> Here is a small refactoring series for setting the clock for SDHI cores. This
> is to prevent regression on platforms where this feature has not been tested.
> One such regression is known on r8a7740 (patches 2+3). Patch 4 fixes an
> oversight and patch 1 is a small cleanup.
>
> RFC for now since I can't test these patches on my hardware currently. Will do
> so on Wednesday, probably. Posting now since because Geert may already want to
> test on r8a7740. Branch is here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git sdhi-for-ulf
>
> Thanks,
>
>    Wolfram
>
> Wolfram Sang (4):
>   mmc: sh_mobile_sdhi: make clk_update function more compact
>   mmc: tmio/sdhi: introduce flag for RCar 2+ specific features
>   mmc: sh_mobile_sdhi: only change the clock on RCar Gen2+
>   mmc: sh_mobile_sdhi: check return value when changing clk
>
>  drivers/mmc/host/sh_mobile_sdhi.c | 17 +++++++++--------
>  drivers/mmc/host/tmio_mmc_pio.c   |  6 +++---
>  include/linux/mfd/tmio.h          |  4 ++--
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> --
> 2.6.2
>

This looks good to me, so thanks, applied for next!

Kind regards
Uffe
