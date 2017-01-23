From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Mon, 23 Jan 2017 10:22:35 +0100
Message-ID: <CAMuHMdWwqa7CbNCRr8q60hDVsj243-ZjHCPp+o9R2a6Dg7YNWQ@mail.gmail.com>
References: <20170121030604.7672-1-chris.brandt@renesas.com> <20170121030604.7672-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35550 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750843AbdAWJWh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 04:22:37 -0500
In-Reply-To: <20170121030604.7672-2-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Chris,

On Sat, Jan 21, 2017 at 4:06 AM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Some controllers have 2 clock sources instead of 1. The 2nd clock
> is for the internal card detect logic and must be enabled/disabled
> along with the main core clock for proper operation.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v4:
> * add technical explanation within probe routine
> v3:
> * add more clarification to the commit log
> v2:
> * changed clk2 to clk_cd
> * disable clk if clk_cd enable fails
> * changed clock name from "carddetect" to "cd"

Thanks for the updates!

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 59db14b..360d922 100644
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

As enabling the "core" clock but not the "cd" clock is not a valid setting,
shouldn't the cd clock be enabled first?

>         /*
>          * The clock driver may not know what maximum frequency
>          * actually works, so it should be set with the max-frequency
> @@ -255,6 +262,8 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
>         struct sh_mobile_sdhi *priv = host_to_priv(host);
>
>         clk_disable_unprepare(priv->clk);
> +       if (priv->clk_cd)

No need to check for a NULL pointer first.

> +               clk_disable_unprepare(priv->clk_cd);

Disabling is already done in the correct order ;-)

>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
