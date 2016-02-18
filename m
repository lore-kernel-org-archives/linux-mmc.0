From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Thu, 18 Feb 2016 17:07:01 +0100
Message-ID: <CAPDyKFowEH=4PU1ErNxMA0=SiDT1Q86H0SfMuiH5jA+H7mvquA@mail.gmail.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455806924-14967-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

+Adrian

On 18 February 2016 at 15:48, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> SD card support for Tegra114 started failing after commit a8e326a911d3
> ("mmc: tegra: implement module external clock change") was merged. This
> commit was part of a series to enable UHS-I modes for Tegra. To
> workaround this problem for now, only disable UHS-I modes for Tegra114
> and in order to do this it is necessary to revert changes from commits
> a8e326a911d3 ("mmc: tegra: implement module external clock change"),
> c3c2384c3ac0 ("mmc: tegra: implement UHS tuning"), 7ad2ed1dfcbe
> ("mmc: tegra: enable UHS-I modes") that impact Tegra114. To do this so
> that UHS-I mode can be disabled for Tegra114 but not for Tegra124
> separate the platform data, soc data and sdhci-ops so they are no longer
> common to both Tegra114 and Tegra124.
>
> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This looks okay to me, although I need and ack from Adrian to pick up
this for fixes. Adrian did recently step in as the maintainer for
sdhci.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 83c4bf7bc16c..bc7a0847e316 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -147,10 +147,16 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>         /* Advertise UHS modes as supported by host */
>         if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
>                 misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
> +       else
> +               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
>         if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>                 misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
> +       else
> +               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
>         if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
>                 misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
> +       else
> +               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
>         sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>
>         clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> @@ -315,6 +321,32 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>         .write_w    = tegra_sdhci_writew,
>         .write_l    = tegra_sdhci_writel,
>         .set_clock  = tegra_sdhci_set_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset      = tegra_sdhci_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> +       .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +                 SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +                 SDHCI_QUIRK_NO_HISPD_BIT |
> +                 SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> +                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .ops  = &tegra114_sdhci_ops,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
> +       .pdata = &sdhci_tegra114_pdata,
> +};
> +
> +static const struct sdhci_ops tegra124_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
> +       .read_w     = tegra_sdhci_readw,
> +       .write_w    = tegra_sdhci_writew,
> +       .write_l    = tegra_sdhci_writel,
> +       .set_clock  = tegra_sdhci_set_clock,
>         .set_bus_width = tegra_sdhci_set_bus_width,
>         .reset      = tegra_sdhci_reset,
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
> @@ -322,7 +354,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>         .get_max_clock = tegra_sdhci_get_max_clock,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> +static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>                   SDHCI_QUIRK_SINGLE_POWER_WRITE |
> @@ -330,11 +362,11 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
>                   SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -       .ops  = &tegra114_sdhci_ops,
> +       .ops  = &tegra124_sdhci_ops,
>  };
>
> -static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
> -       .pdata = &sdhci_tegra114_pdata,
> +static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
> +       .pdata = &sdhci_tegra124_pdata,
>         .nvquirks = NVQUIRK_ENABLE_SDR50 |
>                     NVQUIRK_ENABLE_DDR50 |
>                     NVQUIRK_ENABLE_SDR104,
> @@ -357,7 +389,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>         { .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
> -       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
> +       { .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
>         { .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
>         { .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
>         { .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
> --
> 2.1.4
>
