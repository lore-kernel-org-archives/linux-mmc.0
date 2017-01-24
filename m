From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/13] mmc: sunxi: Fix clock frequency change sequence
Date: Tue, 24 Jan 2017 09:12:07 +0100
Message-ID: <CAPDyKFp735=MMm02PKEt2iZmN0Afyp52_g-8hKxpW71hw2RyiQ@mail.gmail.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <6f6b511bce9df86ee43486653ac55df0d135f198.1484585798.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f6b511bce9df86ee43486653ac55df0d135f198.1484585798.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

On 16 January 2017 at 17:56, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The MMC and SD specifications documents that the clock frequency should
> only be changed once gated.

Where?

>
> The current code first modifies the parent clock, gates it and then
> modifies the internal divider. This means that since the parent clock rate
> might be changed, the bus clock might be changed as well before it is
> gated, which breaks the specification.
>
> Move the gating before the parent rate modification.

This all makes perfect sense to me, however I am not sure you need to
refer to the spec to justify these changes.

Kind regards
Uffe

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index b1d1303389a7..ab4324e6eb74 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -761,6 +761,10 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>         u32 rval, clock = ios->clock;
>         int ret;
>
> +       ret = sunxi_mmc_oclk_onoff(host, 0);
> +       if (ret)
> +               return ret;
> +
>         /* 8 bit DDR requires a higher module clock */
>         if (ios->timing == MMC_TIMING_MMC_DDR52 &&
>             ios->bus_width == MMC_BUS_WIDTH_8)
> @@ -783,10 +787,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 return ret;
>         }
>
> -       ret = sunxi_mmc_oclk_onoff(host, 0);
> -       if (ret)
> -               return ret;
> -
>         /* clear internal divider */
>         rval = mmc_readl(host, REG_CLKCR);
>         rval &= ~0xff;
> --
> git-series 0.8.11
