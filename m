From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/5] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
Date: Thu, 22 Oct 2015 15:29:44 +0200
Message-ID: <CAPDyKFqoNh+yThhMQHbJV4izcH=ZviQsoaY7YXfS3dCxdF8myQ@mail.gmail.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
	<1444926346-29763-2-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37771 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbbJVN3p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 09:29:45 -0400
Received: by wicfv8 with SMTP id fv8so120266444wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2015 06:29:44 -0700 (PDT)
In-Reply-To: <1444926346-29763-2-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, jaz@semihalf.com, Jisheng Zhang <jszhang@marvell.com>

On 15 October 2015 at 18:25, Marcin Wojtas <mw@semihalf.com> wrote:
> When resuming from suspend on Armada 38x SoC MBus windows have to be
> re-configured and for that purpose mv_conf_mbus_windows function needed
> rework. MBus windows register base address obtaining was moved to
> armada_38x_quirks function in order to be kept in pxa global structure,
> because it is used during a resume.
>
> This commit fixes resuming from suspend by calling MBus windows
> configuration routine and therefore enabling proper DMA operation.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index f5edf9d..54a253c0 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -63,6 +63,7 @@ struct sdhci_pxa {
>         struct clk *clk_io;
>         u8      power_mode;
>         void __iomem *sdio3_conf_reg;
> +       void __iomem *mbus_win_regs;
>  };
>
>  /*
> @@ -81,30 +82,16 @@ struct sdhci_pxa {
>  #define SDIO3_CONF_CLK_INV     BIT(0)
>  #define SDIO3_CONF_SD_FB_CLK   BIT(2)
>
> -static int mv_conf_mbus_windows(struct platform_device *pdev,
> +static int mv_conf_mbus_windows(struct device *dev, void __iomem *regs,
>                                 const struct mbus_dram_target_info *dram)
>  {
>         int i;
> -       void __iomem *regs;
> -       struct resource *res;
>
>         if (!dram) {
> -               dev_err(&pdev->dev, "no mbus dram info\n");
> -               return -EINVAL;
> -       }
> -
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       if (!res) {
> -               dev_err(&pdev->dev, "cannot get mbus registers\n");
> +               dev_err(dev, "no mbus dram info\n");
>                 return -EINVAL;
>         }
>
> -       regs = ioremap(res->start, resource_size(res));
> -       if (!regs) {
> -               dev_err(&pdev->dev, "cannot map mbus registers\n");
> -               return -ENOMEM;
> -       }
> -
>         for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
>                 writel(0, regs + SDHCI_WINDOW_CTRL(i));
>                 writel(0, regs + SDHCI_WINDOW_BASE(i));
> @@ -122,8 +109,6 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>                 writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
>         }
>
> -       iounmap(regs);
> -
>         return 0;
>  }
>
> @@ -135,6 +120,11 @@ static int armada_38x_quirks(struct platform_device *pdev,
>         struct sdhci_pxa *pxa = pltfm_host->priv;
>         struct resource *res;
>
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");

You change from using platform_get_resource(pdev, IORESOURCE_MEM, 1)
to above name based lookup.

I guess it's intentional, but there's no information about it in the
change-log, perhaps add it?

> +       pxa->mbus_win_regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pxa->mbus_win_regs))
> +               return PTR_ERR(pxa->mbus_win_regs);
> +
>         host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -403,7 +393,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>                 ret = armada_38x_quirks(pdev, host);
>                 if (ret < 0)
>                         goto err_mbus_win;
> -               ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> +               ret = mv_conf_mbus_windows(&pdev->dev, pxa->mbus_win_regs,
> +                                          mv_mbus_dram_info());
>                 if (ret < 0)
>                         goto err_mbus_win;
>         }
> @@ -520,6 +511,12 @@ static int sdhci_pxav3_resume(struct device *dev)
>  {
>         int ret;
>         struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_pxa *pxa = pltfm_host->priv;
> +
> +       if (pxa->mbus_win_regs)
> +               ret = mv_conf_mbus_windows(dev, pxa->mbus_win_regs,
> +                                          mv_mbus_dram_info());
>
>         pm_runtime_get_sync(dev);
>         ret = sdhci_resume_host(host);
> --
> 1.8.3.1
>

Kind regards
Uffe
