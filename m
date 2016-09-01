From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Thu, 1 Sep 2016 09:51:06 +0200
Message-ID: <CAPDyKFo18+h9UTUTD4q6_-5rWYO6rLXzDVbd29imDLhecF-=_g@mail.gmail.com>
References: <20160831162324.15480-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831162324.15480-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 31 August 2016 at 18:23, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
> addressing, but testing shows that this doesn't work. On a device which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
> addresses above the 32-bit boundary.
>
> One way to work around this would be to enable IOMMU physical to virtual
> address translations for the SD/MMC controllers, but that's not easy to
> implement without breaking existing use-cases. It's also not obvious why
> 34-bit addressing doesn't work as advertised. In order to fix this for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.
>
> Reported-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Looks good to me, although could you please address Lucas' comment and
send a re-based version.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index d89200ee017e..a3d045630d0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -394,6 +394,22 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
>         .pdata = &sdhci_tegra114_pdata,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
> +       .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +                 SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +                 SDHCI_QUIRK_NO_HISPD_BIT |
> +                 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +       .ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> +       .pdata = &sdhci_tegra124_pdata,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -427,7 +443,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>         { .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>         { .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
> -       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
> +       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
>         { .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
>         { .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
>         { .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
> --
> 2.9.3
>
