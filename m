From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Only advertise UHS modes if IO regulator is present
Date: Wed, 6 Jul 2016 11:14:36 +0900
Message-ID: <CAAVeFu+VM+-sL8BAkq12bEa6NaZ8D0pKF54qAgmked=CxQsO9A@mail.gmail.com>
References: <1467727665-2709-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467727665-2709-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 5, 2016 at 11:07 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> To support UHS modes for Tegra an external regulator must be present
> to adjust the IO voltage accordingly. If the regulator is not present
> but the host supports the UHS modes and the SD/MMC device supports the
> UHS modes, then we will attempt to switch to a high-speed mode.
>
> Without an external regulator, Tegra will fail to switch to the
> high-speed mode. Although this is expected, it has been found that with
> some SD cards, once it has been switched to operate at a high-speed
> mode and hence a lower IO voltage, if the IO voltage is not changed then
> all subsequent commands issues to the card will fail. Furthermore, it
> will not be possible to switch back to a non high-speed mode and so
> eventually the SD card initialisation will fail.
>
> The SDHCI core does not require that the host have an external regulator
> when switching to UHS modes and therefore, the Tegra SDHCI host
> controller should only advertise the UHS modes as being supported if the
> regulator for the IO voltage is present. Fortunately, Tegra has a vendor
> specific register which can be used to control which modes are
> advertised via the SDHCI_CAPABILITIES register and if the controller is
> compatible with v3.0 of the SDHCI specification. Hence, if there is no
> IO voltage regulator present in device-tree for the Tegra SDHCI host, then
> don't advertise the UHS modes or that the controller is SDHCI v3.0
> compatible.
>
> Note that if the SDHCI is compatible with v3.0 of the SDHCI specification
> then this will cause the SDHCI core to read the SDHCI_CAPABILITIES_1
> register which will enable other UHS modes.
>
> This fixes commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes") which
> enables UHS mode without checking if the board can support them.
>
> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>
> Please note that I have been reviewing the series from Adrian [0] to
> make it easier for drivers to set the capabilities. However, given that
> we can control the capabilities that are advertised by the CAPS registers
> it seems easier to use this feature.
>
> [0] http://marc.info/?l=linux-mmc&m=146712062816835&w=2
>
>  drivers/mmc/host/sdhci-tegra.c | 50 +++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index bcc0de47fe7e..c8b51cd71c56 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -140,6 +140,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>         const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +       struct device *dev = mmc_dev(host->mmc);
>         u32 misc_ctrl, clk_ctrl;
>
>         sdhci_reset(host, mask);
> @@ -148,28 +149,37 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>                 return;
>
>         misc_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> -       /* Erratum: Enable SDHCI spec v3.00 support */
> -       if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
> -               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
> -       /* Advertise UHS modes as supported by host */
> -       if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
> -               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
> -       else
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
> -       if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
> -               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
> -       else
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
> -       if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
> -               misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
> -       else
> -               misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
> -       sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> -
>         clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> +
> +       misc_ctrl &= ~(SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300 |
> +                      SDHCI_MISC_CTRL_ENABLE_SDR50 |
> +                      SDHCI_MISC_CTRL_ENABLE_DDR50 |
> +                      SDHCI_MISC_CTRL_ENABLE_SDR104);
> +
>         clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
> -       if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
> -               clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
> +
> +       /*
> +        * If the board does not define a regulator for the SDHCI
> +        * IO voltage, then don't advertise support for UHS modes
> +        * even if the device supports it because the IO voltage
> +        * cannot be configured.
> +        */
> +       if (of_property_read_bool(dev->of_node, "vqmmc-supply")) {

Can't you check whether (!IS_SERR(host->mmc->supply.vqmmc)) instead?
The property being present doesn't necessarily guarantee that the
regulator has been obtained successfully.
