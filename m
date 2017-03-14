From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: tegra: Add Tegra186 support
Date: Tue, 14 Mar 2017 17:21:59 +0100
Message-ID: <CAPDyKFrcywQ_rG7y1pObMuegPKBw9kq_P-TRKPa_c9neRvBO6g@mail.gmail.com>
References: <20170308190040.28386-1-thierry.reding@gmail.com> <20170308190040.28386-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36334 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdCNQWB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:22:01 -0400
Received: by mail-vk0-f52.google.com with SMTP id t8so54721300vke.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:22:00 -0700 (PDT)
In-Reply-To: <20170308190040.28386-2-thierry.reding@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jon Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 8 March 2017 at 20:00, Thierry Reding <thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The SDHCI controller found on NVIDIA Tegra186 SoCs is very similar to
> the one on prior generations of Tegra and can be supported by the same
> driver.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks, applied for next!

However, the new compatible string must be documented. Please send a
patch on top to fix that!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 9d31ee8988ef..7f93079c7a3a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -434,7 +434,23 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>         .pdata = &sdhci_tegra210_pdata,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> +       .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +                 SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +                 SDHCI_QUIRK_NO_HISPD_BIT |
> +                 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
> +       .pdata = &sdhci_tegra186_pdata,
> +};
> +
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> +       { .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>         { .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
>         { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
>         { .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
> --
> 2.12.0
>
