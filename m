From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Fri, 20 Jan 2017 11:50:32 +0100
Message-ID: <CAPDyKFqO3YrDdKqOqJ=xKSH7uAiZ+rCPEDKMZ+c8Y5RKaVK4kg@mail.gmail.com>
References: <20170118172502.13876-1-chris.brandt@renesas.com> <20170118172502.13876-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170118172502.13876-2-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 18 January 2017 at 18:25, Chris Brandt <chris.brandt@renesas.com> wrote:
> Some controllers have 2 clock sources instead of 1, so they both need
> to be turned on/off.

This doesn't tell me enough. Please elaborate.

For example, tell how you treat the clocks, which of them that is
optional and why.

>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
> * changed clk2 to clk_cd
> * disable clk if clk_cd enable fails
> * changed clock name from "carddetect" to "cd"
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 59db14b..a3f995e 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -143,6 +143,7 @@ MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
>
>  struct sh_mobile_sdhi {
>         struct clk *clk;
> +       struct clk *clk_cd;
>         struct tmio_mmc_data mmc_data;
>         struct tmio_mmc_dma dma_priv;
>         struct pinctrl *pinctrl;
> @@ -190,6 +191,12 @@ static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
>         if (ret < 0)
>                 return ret;
>
> +       ret = clk_prepare_enable(priv->clk_cd);
> +       if (ret < 0) {
> +               clk_disable_unprepare(priv->clk);
> +               return ret;
> +       }
> +
>         /*
>          * The clock driver may not know what maximum frequency
>          * actually works, so it should be set with the max-frequency
> @@ -255,6 +262,8 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
>         struct sh_mobile_sdhi *priv = host_to_priv(host);
>
>         clk_disable_unprepare(priv->clk);
> +       if (priv->clk_cd)
> +               clk_disable_unprepare(priv->clk_cd);
>  }
>
>  static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
> @@ -572,6 +581,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 goto eprobe;
>         }
>
> +       priv->clk_cd = devm_clk_get(&pdev->dev, "cd");
> +       if (IS_ERR(priv->clk_cd))
> +               priv->clk_cd = NULL;

Is this clock solely about card detection? So in cases when you have a
GPIO card detect, the clock isn't needed?

Just trying to understand things a bit better...

> +
>         priv->pinctrl = devm_pinctrl_get(&pdev->dev);
>         if (!IS_ERR(priv->pinctrl)) {
>                 priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> --
> 2.10.1
>
>

Kind regards
Uffe
