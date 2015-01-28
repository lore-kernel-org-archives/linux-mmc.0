From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/7] mmc: sdhci-pxav3: Modify clock settings for the
 SDR50 and DDR50 modes
Date: Wed, 28 Jan 2015 21:44:06 +0100
Message-ID: <CAPDyKFpTnGrdKLYjH=GaG2bQ-44F68fSxRvRQBi8bHP5A83Ahw@mail.gmail.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>
 <1422031587-18212-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422031587-18212-5-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 23 January 2015 at 17:46, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Marcin Wojtas <mw@semihalf.com>
>
> According to erratum 'FE-2946959' both SDR50 and DDR50 modes require
> specific clock adjustments in SDIO3 Configuration register.
>
> This commit add the support of this register and for SDR50 or DDR50
> mode use it as suggested by the erratum:
> - Set the SDIO3 Clock Inv field in SDIO3 Configuration register to not
> inverted.
> - Set the Sample FeedBack Clock field to 0x1
>
> [gregory.clement@free-electrons.com: port from 3.10]
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 60 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index cf017fc39143..a3ebb4404849 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -62,6 +62,7 @@ struct sdhci_pxa {
>         struct clk *clk_core;
>         struct clk *clk_io;
>         u8      power_mode;
> +       void __iomem *sdio3_conf_reg;
>  };
>
>  /*
> @@ -72,6 +73,14 @@ struct sdhci_pxa {
>  #define SDHCI_WINDOW_BASE(i)   (0x84 + ((i) << 3))
>  #define SDHCI_MAX_WIN_NUM      8
>
> +/*
> + * Fields below belong to SDIO3 Configuration Register (third register
> + * region for the Armada 38x flavor)
> + */
> +
> +#define SDIO3_CONF_CLK_INV     BIT(0)
> +#define SDIO3_CONF_SD_FB_CLK   BIT(2)
> +
>  static int mv_conf_mbus_windows(struct platform_device *pdev,
>                                 const struct mbus_dram_target_info *dram)
>  {
> @@ -122,16 +131,31 @@ static int armada_38x_quirks(struct platform_device *pdev,
>                              struct sdhci_host *host)
>  {
>         struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_pxa *pxa = pltfm_host->priv;
> +       struct resource *res;
>
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
> -       /*
> -        * According to erratum 'FE-2946959' both SDR50 and DDR50
> -        * modes require specific clock adjustments in SDIO3
> -        * Configuration register, if the adjustment is not done,
> -        * remove them from the capabilities.
> -        */
> -       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> -       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +                                          "conf-sdio3");
> +       if (res) {
> +               pxa->sdio3_conf_reg = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(pxa->sdio3_conf_reg))
> +                       return PTR_ERR(pxa->sdio3_conf_reg);
> +       } else {
> +               /*
> +                * According to erratum 'FE-2946959' both SDR50 and DDR50
> +                * modes require specific clock adjustments in SDIO3
> +                * Configuration register, if the adjustment is not done,
> +                * remove them from the capabilities.
> +                */
> +               host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +               host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +
> +               dev_warn(&pdev->dev, "conf-sdio3 register not found\n");
> +               dev_warn(&pdev->dev, "disabling SDR50 and DDR50 modes\n");
> +               dev_warn(&pdev->dev, "consider updating your dtb\n");

One dev_warn() should be enough. Also I don't think checkpatch
complains about long lines for dev_warn().

> +       }
>
>         /*
>          * According to erratum 'ERR-7878951' Armada 38x SDHCI
> @@ -226,6 +250,8 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
>
>  static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_pxa *pxa = pltfm_host->priv;
>         u16 ctrl_2;
>
>         /*
> @@ -255,6 +281,24 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>                 break;
>         }
>
> +       /*
> +        * Update SDIO3 Configuration register according to erratum
> +        * FE-2946959
> +        */
> +       if (pxa->sdio3_conf_reg) {
> +               u8 reg_val  = readb(pxa->sdio3_conf_reg);
> +
> +               if (uhs == MMC_TIMING_UHS_SDR50 ||
> +                   uhs == MMC_TIMING_UHS_DDR50) {
> +                       reg_val &= ~SDIO3_CONF_CLK_INV;
> +                       reg_val |= SDIO3_CONF_SD_FB_CLK;
> +               } else {
> +                       reg_val |= SDIO3_CONF_CLK_INV;
> +                       reg_val &= ~SDIO3_CONF_SD_FB_CLK;
> +               }
> +               writeb(reg_val, pxa->sdio3_conf_reg);
> +       }
> +
>         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>         dev_dbg(mmc_dev(host->mmc),
>                 "%s uhs = %d, ctrl_2 = %04X\n",
> --
> 2.1.0
>

Kind regards
Uffe
