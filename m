From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: Optimize write_w path for tegra114 and later
Date: Thu, 5 Mar 2015 15:59:38 +0100
Message-ID: <CAPDyKForXhWDVf5T9qU9kw8Zs4F5uZfr4LhH7uQHhMwf9n1Brw@mail.gmail.com>
References: <1423677351-31635-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423677351-31635-1-git-send-email-rklein@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Chris Ball <chris@printf.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2015 at 18:55, Rhyland Klein <rklein@nvidia.com> wrote:
> Setup a different set of sdhci_ops for tegra114 and later so that
> the write_w callback is only used on tegra114. This allows us to
> remove the NVQUIRK_SHADOW_XFER_MODE_REG and simply the logic
> in tegra_sdhci_writew.
>
> This was suggested by Alexandre Courbot.
>
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>

Applied, with some changes, thanks!

1. Added the suggested-by tag.
2. Remove some unused variables causing compiler warnings.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c |   45 +++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f3778d58d1cd..180062498c35 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -41,7 +41,6 @@
>  #define NVQUIRK_DISABLE_SDR50          BIT(3)
>  #define NVQUIRK_DISABLE_SDR104         BIT(4)
>  #define NVQUIRK_DISABLE_DDR50          BIT(5)
> -#define NVQUIRK_SHADOW_XFER_MODE_REG   BIT(6)
>
>  struct sdhci_tegra_soc_data {
>         const struct sdhci_pltfm_data *pdata;
> @@ -74,20 +73,18 @@ static void tegra_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>         struct sdhci_tegra *tegra_host = pltfm_host->priv;
>         const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
>
> -       if (soc_data->nvquirks & NVQUIRK_SHADOW_XFER_MODE_REG) {
> -               switch (reg) {
> -               case SDHCI_TRANSFER_MODE:
> -                       /*
> -                        * Postpone this write, we must do it together with a
> -                        * command write that is down below.
> -                        */
> -                       pltfm_host->xfer_mode_shadow = val;
> -                       return;
> -               case SDHCI_COMMAND:
> -                       writel((val << 16) | pltfm_host->xfer_mode_shadow,
> -                               host->ioaddr + SDHCI_TRANSFER_MODE);
> -                       return;
> -               }
> +       switch (reg) {
> +       case SDHCI_TRANSFER_MODE:
> +               /*
> +                * Postpone this write, we must do it together with a
> +                * command write that is down below.
> +                */
> +               pltfm_host->xfer_mode_shadow = val;
> +               return;
> +       case SDHCI_COMMAND:
> +               writel((val << 16) | pltfm_host->xfer_mode_shadow,
> +                       host->ioaddr + SDHCI_TRANSFER_MODE);
> +               return;
>         }
>
>         writew(val, host->ioaddr + reg);
> @@ -173,7 +170,6 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
>  static const struct sdhci_ops tegra_sdhci_ops = {
>         .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
> -       .write_w    = tegra_sdhci_writew,
>         .write_l    = tegra_sdhci_writel,
>         .set_clock  = sdhci_set_clock,
>         .set_bus_width = tegra_sdhci_set_bus_width,
> @@ -214,6 +210,18 @@ static struct sdhci_tegra_soc_data soc_data_tegra30 = {
>                     NVQUIRK_DISABLE_SDR104,
>  };
>
> +static const struct sdhci_ops tegra114_sdhci_ops = {
> +       .get_ro     = tegra_sdhci_get_ro,
> +       .read_w     = tegra_sdhci_readw,
> +       .write_w    = tegra_sdhci_writew,
> +       .write_l    = tegra_sdhci_writel,
> +       .set_clock  = sdhci_set_clock,
> +       .set_bus_width = tegra_sdhci_set_bus_width,
> +       .reset      = tegra_sdhci_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
>         .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>                   SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> @@ -221,15 +229,14 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
>                   SDHCI_QUIRK_NO_HISPD_BIT |
>                   SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -       .ops  = &tegra_sdhci_ops,
> +       .ops  = &tegra114_sdhci_ops,
>  };
>
>  static struct sdhci_tegra_soc_data soc_data_tegra114 = {
>         .pdata = &sdhci_tegra114_pdata,
>         .nvquirks = NVQUIRK_DISABLE_SDR50 |
>                     NVQUIRK_DISABLE_DDR50 |
> -                   NVQUIRK_DISABLE_SDR104 |
> -                   NVQUIRK_SHADOW_XFER_MODE_REG,
> +                   NVQUIRK_DISABLE_SDR104,
>  };
>
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> --
> 1.7.9.5
>
