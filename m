From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: tmio: make CTL_STATUS handling consistent
Date: Tue, 26 Apr 2016 18:25:31 +0200
Message-ID: <CAPDyKFrHb3u2CcSGr3dyzPP53UzGCTDAQ6rK8FKBn80wS+znJQ@mail.gmail.com>
References: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14 April 2016 at 18:16, Wolfram Sang <wsa@the-dreams.de> wrote:
> It took me a little to discover that CTL_STATUS has a different handling than
> the other registers. CTL_STATUS and CTL_STATUS2, both u16, are merged into a
> virtual u32. However, CTL_STATUS2 was also directly accessed.
>
> Clean this up, make this consistent, and document this. Making the driver less
> complex and easier to work with.
>
> Tested on Renesas R-Car Gen2 and Gen3. It is on top of my not-yet applied
> series "[PATCH 0/6] mmc: tmio/sdhi: clean up cruft". A complete branch is here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi-uhs
>
>    Wolfram
>
> Wolfram Sang (5):
>   mmc: tmio: give read32/write32 functions more descriptive names
>   mmc: tmio: use BIT() within defines
>   mmc: tmio: use CTL_STATUS consistently
>   mmc: tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC
>   mmc: tmio: document CTL_STATUS handling
>
>  drivers/mmc/host/sh_mobile_sdhi.c |  3 ++-
>  drivers/mmc/host/tmio_mmc.h       | 56 ++++++++++++++++++++-------------------
>  drivers/mmc/host/tmio_mmc_pio.c   | 24 ++++++++---------
>  3 files changed, 43 insertions(+), 40 deletions(-)
>
> --
> 2.7.0
>

I tried to apply this one, but it seems like it need a rebase. Can you
please have look and re-spin it.

Kind regards
Uffe
