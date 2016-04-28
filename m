From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/5] mmc: tmio: make CTL_STATUS handling consistent
Date: Thu, 28 Apr 2016 12:38:06 +0200
Message-ID: <CAPDyKFqdvCF63GUF6dNaovh4WRzig2veH2OBBnZ2Z0Vzm12NkA@mail.gmail.com>
References: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27 April 2016 at 18:51, Wolfram Sang <wsa@the-dreams.de> wrote:
> It took me a little to discover that CTL_STATUS has a different handling than
> the other registers. CTL_STATUS and CTL_STATUS2, both u16, are merged into a
> virtual u32. However, CTL_STATUS2 was also directly accessed.
>
> Clean this up, make this consistent, and document this. Making the driver less
> complex and easier to work with.
>
> Tested on Renesas R-Car Gen2 and Gen3.
>
> Changes since V2:
>
> * rebased to mmc/next. Sorry Ulf, my branch had an older version of your next
>   included and I missed the update :(

No worries! The re-spin was probably more work at your end than at mine. :-)

>
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

Thanks, applied for next!

Kind regards
Uffe
