From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
Date: Tue, 9 Oct 2018 09:30:27 +0200
Message-ID: <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-6-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-6-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on TI's AM654 devices.
>
> Therefore, add a new compatible, AM654 specific quirks
> and a new AM654 specific set_clock function which
> configures the PHY in a sane way.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..142c4b802f31 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -231,6 +231,25 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>  }
>
> +static void sdhci_arasan_am654_set_clock(struct sdhci_host *host,
> +                                        unsigned int clock)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (sdhci_arasan->is_phy_on) {
> +               phy_power_off(sdhci_arasan->phy);
> +               sdhci_arasan->is_phy_on = false;
> +       }
> +
> +       sdhci_set_clock(host, clock);
> +
> +       if (clock > PHY_CLK_TOO_SLOW_HZ) {
> +               phy_power_on(sdhci_arasan->phy);
> +               sdhci_arasan->is_phy_on = true;
> +       }
> +}
> +
>  static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                         struct mmc_ios *ios)
>  {
> @@ -316,6 +335,29 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
>         .pdata = &sdhci_arasan_pdata,
>  };
>
> +static const struct sdhci_ops sdhci_arasan_am654_ops = {
> +       .set_clock = sdhci_arasan_am654_set_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_arasan_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_arasan_am654_pdata = {
> +       .ops = &sdhci_arasan_am654_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN  |
> +                 SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +                 SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +                  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> +};
> +
> +static const struct sdhci_arasan_of_data sdhci_arasan_am654_data = {
> +       .pdata = &sdhci_arasan_am654_pdata,
> +};
> +
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>         int cmd_error = 0;
> @@ -478,6 +520,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "rockchip,rk3399-sdhci-5.1",
>                 .data = &sdhci_arasan_rk3399_data,
>         },
> +       {
> +               .compatible = "ti,am654-sdhci-5.1",
> +               .data = &sdhci_arasan_am654_data,
> +       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> --
> 2.18.0
>
