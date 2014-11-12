From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Date: Wed, 12 Nov 2014 09:37:06 +0100
Message-ID: <CAPDyKFp3obiNs=vs8sjr2bNyFac4gb-q+C+mOm8eqrLppxS=VA@mail.gmail.com>
References: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 November 2014 07:42, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Some more info in the commit message please.

>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on mmc-next branch of Chris Ball's mmc tree.

Please use:

git.linaro.org/people/ulf.hansson/mmc.git

>
>  drivers/mmc/host/sh_mmcif.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 656fbba..fe9a8b7 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1,6 +1,7 @@
>  /*
>   * MMCIF eMMC driver.
>   *
> + * Copyright (C) 2014 Renesas Electronics Corporation
>   * Copyright (C) 2010 Renesas Solutions Corp.
>   * Yusuke Goda <yusuke.goda.sx@renesas.com>
>   *
> @@ -57,6 +58,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
> @@ -1371,6 +1373,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         struct resource *res;
>         void __iomem *reg;
>         const char *name;
> +       struct device_node *np = pdev->dev.of_node;
> +       int clk_rate;
>
>         irq[0] = platform_get_irq(pdev, 0);
>         irq[1] = platform_get_irq(pdev, 1);
> @@ -1433,6 +1437,16 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
>                 goto eclkget;
>         }
> +
> +       if (np && !of_property_read_u32(np, "renesas,clk-rate", &clk_rate)) {

Why do you need a DT binding for this?

> +               if (clk_rate) {
> +                       ret = clk_set_rate(host->hclk, clk_rate);
> +                       if (ret < 0)
> +                               dev_err(&pdev->dev,
> +                                       "cannot set clock rate: %d\n", ret);
> +               }
> +       }
> +
>         ret = sh_mmcif_clk_update(host);
>         if (ret < 0)
>                 goto eclkupdate;
> --
> 1.9.1
>

Kind regards
Uffe
