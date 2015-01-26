From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v3 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's caps
 according to erratum ERR-7878951
Date: Mon, 26 Jan 2015 13:57:52 +0100
Message-ID: <CAPv3WKcVAea-ePkeO32Z2mqPzfExg0iBy7DQh00vHKxfLDSFsQ@mail.gmail.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
	<1422031587-18212-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1422031587-18212-3-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Gregory,

This patch looks alright to me now.

Thanks,
Marcin

2015-01-23 17:46 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> From: Marcin Wojtas <mw@semihalf.com>
>
> According to erratum 'ERR-7878951' Armada 38x SDHCI controller has
> different capabilities than the ones shown in its registers:
>
> - it doesn't support the voltage switching: it can work either with
>   3.3V or 1.8V supply
> - it doesn't support the SDR104 mode
> - SDR50 mode doesn't need tuning
>
> The SDHCI_QUIRK_MISSING_CAPS quirk is used for updating the
> capabilities accordingly.
>
> [gregory.clement@free-electrons.com: port from 3.10]
>
> Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
> Cc: <stable@vger.kernel.org> # v3.15+
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 7b07325b4fba..cf017fc39143 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -118,8 +118,11 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>         return 0;
>  }
>
> -static int armada_38x_quirks(struct sdhci_host *host)
> +static int armada_38x_quirks(struct platform_device *pdev,
> +                            struct sdhci_host *host)
>  {
> +       struct device_node *np = pdev->dev.of_node;
> +
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>         /*
>          * According to erratum 'FE-2946959' both SDR50 and DDR50
> @@ -129,6 +132,21 @@ static int armada_38x_quirks(struct sdhci_host *host)
>          */
>         host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +
> +       /*
> +        * According to erratum 'ERR-7878951' Armada 38x SDHCI
> +        * controller has different capabilities than the ones shown
> +        * in its registers
> +        */
> +       host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +       if (of_property_read_bool(np, "no-1-8-v")) {
> +               host->caps &= ~SDHCI_CAN_VDD_180;
> +               host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
> +       } else {
> +               host->caps &= ~SDHCI_CAN_VDD_330;
> +       }
> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_USE_SDR50_TUNING);
> +
>         return 0;
>  }
>
> @@ -332,8 +350,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         if (!IS_ERR(pxa->clk_core))
>                 clk_prepare_enable(pxa->clk_core);
>
> +       /* enable 1/8V DDR capable */
> +       host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +
>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
> -               ret = armada_38x_quirks(host);
> +               ret = armada_38x_quirks(pdev, host);
>                 if (ret < 0)
>                         goto err_quirks;
>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> @@ -341,9 +362,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>                         goto err_mbus_win;
>         }
>
> -       /* enable 1/8V DDR capable */
> -       host->mmc->caps |= MMC_CAP_1_8V_DDR;
> -
>         match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>         if (match) {
>                 ret = mmc_of_parse(host->mmc);
> --
> 2.1.0
>
