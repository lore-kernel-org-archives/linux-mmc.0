From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5] mmc: tegra: enable UHS-I modes
Date: Mon, 21 Dec 2015 14:06:20 +0100
Message-ID: <CAPDyKFpqVj4PJBPk6_UEz72n1q_wV5LYLEb0EY_ULTidVTn9kQ@mail.gmail.com>
References: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
	<1450552564-32697-5-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35057 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbLUNGV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 08:06:21 -0500
Received: by mail-yk0-f175.google.com with SMTP id v6so129587513ykc.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Dec 2015 05:06:20 -0800 (PST)
In-Reply-To: <1450552564-32697-5-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 19 December 2015 at 20:16, Lucas Stach <dev@lynxeye.de> wrote:
> Keep the quirk bits, as Tegra30 and Tegra114 host have different levels
> of support for UHS-I modes and so need different spare bits to be set,
> but change the logic to be positive.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index fd0529c..b5374d7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -45,9 +45,9 @@
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200   BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET   BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300  BIT(2)
> -#define NVQUIRK_DISABLE_SDR50          BIT(3)
> -#define NVQUIRK_DISABLE_SDR104         BIT(4)
> -#define NVQUIRK_DISABLE_DDR50          BIT(5)
> +#define NVQUIRK_ENABLE_SDR50           BIT(3)
> +#define NVQUIRK_ENABLE_SDR104          BIT(4)
> +#define NVQUIRK_ENABLE_DDR50           BIT(5)
>
>  struct sdhci_tegra_soc_data {
>         const struct sdhci_pltfm_data *pdata;
> @@ -144,18 +144,18 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>         /* Erratum: Enable SDHCI spec v3.00 support */
>         if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
>                 misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
> -       /* Don't advertise UHS modes which aren't supported yet */
> -       if (soc_data->nvquirks & NVQUIRK_DISABLE_SDR50)
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
> -       if (soc_data->nvquirks & NVQUIRK_DISABLE_DDR50)
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
> -       if (soc_data->nvquirks & NVQUIRK_DISABLE_SDR104)
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
> +       /* Advertise UHS modes as supported by host */
> +       if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
> +               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
> +       if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
> +               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
> +       if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
> +               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
>         sdhci_writew(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>
>         clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>         clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
> -       if (!(soc_data->nvquirks & NVQUIRK_DISABLE_SDR50))
> +       if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
>                 clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
>         sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>
> @@ -302,8 +302,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>  static struct sdhci_tegra_soc_data soc_data_tegra30 = {
>         .pdata = &sdhci_tegra30_pdata,
>         .nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> -                   NVQUIRK_DISABLE_SDR50 |
> -                   NVQUIRK_DISABLE_SDR104,
> +                   NVQUIRK_ENABLE_SDR50 |
> +                   NVQUIRK_ENABLE_SDR104,
>  };
>
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> @@ -332,9 +332,9 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
>
>  static struct sdhci_tegra_soc_data soc_data_tegra114 = {
>         .pdata = &sdhci_tegra114_pdata,
> -       .nvquirks = NVQUIRK_DISABLE_SDR50 |
> -                   NVQUIRK_DISABLE_DDR50 |
> -                   NVQUIRK_DISABLE_SDR104,
> +       .nvquirks = NVQUIRK_ENABLE_SDR50 |
> +                   NVQUIRK_ENABLE_DDR50 |
> +                   NVQUIRK_ENABLE_SDR104,
>  };

Pleas re-base the patchset, towards my next branch.

Tegra210 support has been queued for 4.5, which means there are
additional occurrences of  NVQUIRK_DISABLE_SDR50,
NVQUIRK_DISABLE_SDR104 etc.

>
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> @@ -380,7 +380,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_parse_dt;
>
> -       if (!(tegra_host->soc_data->nvquirks & NVQUIRK_DISABLE_DDR50))
> +       if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR;
>
>         tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
> --
> 2.5.0
>

I would also appreciate if you checkpatch, before posting the new
version. Some of the patches has some warnings that I think you should
fix.

Besides the above minor things, the patchset looks good to me!

Kind regards
Uffe
