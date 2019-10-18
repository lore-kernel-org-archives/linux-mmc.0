From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: add DT property to enable
 calibration on full reset
Date: Fri, 18 Oct 2019 12:58:14 +0200
Message-ID: <CAPDyKFrR810Yb+CqrhvJpSPW0yDEuWsNBysnbEq=3YHcOsVLhw@mail.gmail.com>
References: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
 <d25c8f909d039938a5696e8de32396cf2aaf54b7.1570537903.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d25c8f909d039938a5696e8de32396cf2aaf54b7.1570537903.git.nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 8 Oct 2019 at 14:34, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> Add a property to keep the analog calibration cell powered.
> This feature is specific to the Microchip SDHCI IP and outside
> of the standard SDHCI register map.
>
> By always keeping it on, after a full reset sequence, we make sure
> that this feature is activated and not disabled.
>
> We expose a hardware property to the DT as this feature can be used
> to adapt SDHCI behavior vs. how the SDCAL SoC pin is connected
> on the board.
>
> Note that managing properly this property would reduce
> power consumption on some SAMA5D2 SiP revisions.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index e7d1920729fb..9571c4a882a9 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -27,6 +27,9 @@
>  #define SDMMC_CACR     0x230
>  #define                SDMMC_CACR_CAPWREN      BIT(0)
>  #define                SDMMC_CACR_KEY          (0x46 << 8)
> +#define SDMMC_CALCR    0x240
> +#define                SDMMC_CALCR_EN          BIT(0)
> +#define                SDMMC_CALCR_ALWYSON     BIT(4)
>
>  #define SDHCI_AT91_PRESET_COMMON_CONF  0x400 /* drv type B, programmable clock mode */
>
> @@ -35,6 +38,7 @@ struct sdhci_at91_priv {
>         struct clk *gck;
>         struct clk *mainck;
>         bool restore_needed;
> +       bool cal_always_on;
>  };
>
>  static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
> @@ -116,10 +120,17 @@ static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
>
>  static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
>         sdhci_reset(host, mask);
>
>         if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>                 sdhci_at91_set_force_card_detect(host);
> +
> +       if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
> +               sdhci_writel(host, SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
> +                            SDMMC_CALCR);
>  }
>
>  static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
> @@ -345,6 +356,14 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>
>         priv->restore_needed = false;
>
> +       /*
> +        * if SDCAL pin is wrongly connected, we must enable
> +        * the analog calibration cell permanently.
> +        */
> +       priv->cal_always_on =
> +               device_property_read_bool(&pdev->dev,
> +                                         "microchip,sdcal-inverted");
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto clocks_disable_unprepare;
> --
> 2.17.1
>
