From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Mon, 1 Aug 2016 21:52:48 +0800
Message-ID: <CAGb2v67ocbAVhUA530JC9OiOW8ozybTgP+3yzjPomMKKwP-Bcg@mail.gmail.com>
References: <20160801133359.5B1802E03D@muse.csie.ntu.edu.tw>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBR5I7W6AKGQEGZ2UBSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160801133359.5B1802E03D-Jpzvh7getMvJf3mlLi/bRIJY59XmG8rH@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Aug 1, 2016 at 9:10 PM, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrote:
> Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> a 'New Timings' mode.
> Set this capacity in the DT and use it when possible.

           ^^ capability?

Also, in this patch you are adding support for a DT boolean flag
property, not adding stuff to the DT.

>
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---

I got 3 copies of the same patch...

> I don't know if this mode works or is needed at 25MHz.

Could you test it? You can change mmc->f_max in the probe function
to limit it to 25 MHz.

I'm more interested in the throughput you get after applying this
patch though.

> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
>  drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 4bf41d8..a541bf4 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - reset-names : must contain "ahb"
>   - for cd, bus-width and additional generic mmc parameters
>     please refer to mmc.txt within this directory
> + - allwinner,new-timings: the controller may accept the "New Timings" mode
>
>  Examples:
>         - Within .dtsi:
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ee4c21..98922b5 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -64,6 +64,7 @@
>  #define SDXC_REG_CBCR  (0x48) /* SMC CIU Byte Count Register */
>  #define SDXC_REG_BBCR  (0x4C) /* SMC BIU Byte Count Register */
>  #define SDXC_REG_DBGC  (0x50) /* SMC Debug Enable Register */
> +#define SDXC_REG_NTSR  (0x5c) /* SMC NewTiming Set Register */
>  #define SDXC_REG_HWRST (0x78) /* SMC Card Hardware Reset for Register */
>  #define SDXC_REG_DMAC  (0x80) /* SMC IDMAC Control Register */
>  #define SDXC_REG_DLBA  (0x84) /* SMC IDMAC Descriptor List Base Addre */
> @@ -171,6 +172,9 @@
>  #define SDXC_SEND_AUTO_STOPCCSD                BIT(9)
>  #define SDXC_CEATA_DEV_IRQ_ENABLE      BIT(10)
>
> +/* NewTiming Set Register */
> +#define SDXC_NEWMODE_ENABLE            BIT(31)
> +
>  /* IDMA controller bus mod bit field */
>  #define SDXC_IDMAC_SOFT_RESET          BIT(0)
>  #define SDXC_IDMAC_FIX_BURST           BIT(1)
> @@ -261,6 +265,9 @@ struct sunxi_mmc_host {
>
>         /* vqmmc */
>         bool            vqmmc_enabled;
> +
> +       /* misc */
> +       bool            new_timings;    /* new timings capable */
>  };
>
>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
> @@ -715,8 +722,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>                 return -EINVAL;
>         }
>
> -       clk_set_phase(host->clk_sample, sclk_dly);
> -       clk_set_phase(host->clk_output, oclk_dly);
> +       if (host->new_timings && rate >= 50000000) {
> +               mmc_writel(host, REG_NTSR,
> +                       mmc_readl(host, REG_NTSR) | SDXC_NEWMODE_ENABLE);
> +       } else {
> +               clk_set_phase(host->clk_sample, sclk_dly);
> +               clk_set_phase(host->clk_output, oclk_dly);
> +       }

Does this mean the old phase clock stuff will still be used for slower cards?
You should probably mention this in the commit log.

>
>         return sunxi_mmc_oclk_onoff(host, 1);
>  }
> @@ -1133,12 +1145,17 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto error_free_dma;
>
> +       if (pdev->dev.of_node &&
> +           of_property_read_bool(pdev->dev.of_node, "allwinner,new-timings"))
> +               host->new_timings = true;
> +
>         ret = mmc_add_host(mmc);
>         if (ret)
>                 goto error_free_dma;
>
>         dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
>         platform_set_drvdata(pdev, mmc);
> +

This doesn't belong.

Regards
ChenYu

>         return 0;
>
>  error_free_dma:
> --
> 2.9.2
>
