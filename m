From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Wed, 15 Mar 2017 14:39:26 +0100
Message-ID: <CAPDyKFrQb3NA53o6z9go0+RxxvstwWdeLHpiXtKaXOksxrov3g@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <b646d28daf3d8cb8e57774ce040f39350364041e.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b646d28daf3d8cb8e57774ce040f39350364041e.1487091464.git-series.gregory.clement@free-electrons.com>
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
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lis>
List-Id: linux-mmc@vger.kernel.org

On 14 February 2017 at 18:01, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
> Multiple types of PHYs are supported.
>
> Add support to multiple types of PHYs init and configuration.
> Add register definitions of PHYs.
>
> Xenon PHY cannot fit in kernel common PHY framework.
> Xenon SDHC PHY register is a part of Xenon SDHC register set.
> Besides, MMC initialization has to call several PHY functions to
> complete timing setting.
> Those PHY setting functions have to access SDHC registers and know
> current MMC setting, such as bus width, clock frequency and
> speed mode.
> As a result, implement Xenon PHY in MMC host directory.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/Makefile          |   2 +-
>  drivers/mmc/host/sdhci-xenon-phy.c | 751 ++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.c     |   3 +-
>  drivers/mmc/host/sdhci-xenon.h     |  37 +-
>  4 files changed, 791 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c

I see, you put the phy implementation in a separate file. I guess that
makes sense. However, I leave the decision for Adrian.

Anyway, in such case I guess the extended Makefile options and the
separate header files makes sense.

>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index b0a2ab4b256e..893b48db5513 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -84,4 +84,4 @@ ifeq ($(CONFIG_CB710_DEBUG),y)
>  endif
>
>  obj-$(CONFIG_MMC_SDHCI_XENON)  += sdhci-xenon-driver.o
> -sdhci-xenon-driver-y           += sdhci-xenon.o
> +sdhci-xenon-driver-y           += sdhci-xenon.o sdhci-xenon-phy.o
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> new file mode 100644
> index 000000000000..c26ba3a180a0
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c

[...]

> +/*
> + * eMMC PHY configuration and operations
> + */
> +struct emmc_phy_params {

Perhaps prefix the struct name with "xenon_".

> +       bool    slow_mode;
> +
> +       u8      znr;
> +       u8      zpr;
> +
> +       /* Nr of consecutive Sampling Points of a Valid Sampling Window */
> +       u8      nr_tun_times;
> +       /* Divider for calculating Tuning Step */
> +       u8      tun_step_divider;
> +};
> +
> +static int alloc_emmc_phy(struct sdhci_xenon_priv *priv)
> +{
> +       struct emmc_phy_params *params;
> +
> +       params = kzalloc(sizeof(*params), GFP_KERNEL);

Why not using devm_kzalloc()?

[...]

> +
> +/*
> + * If eMMC PHY Slow Mode is required in lower speed mode (SDCLK < 55MHz)
> + * in SDR mode, enable Slow Mode to bypass eMMC PHY.
> + * SDIO slower SDR mode also requires Slow Mode.
> + *
> + * If Slow Mode is enabled, return true.
> + * Otherwise, return false.
> + */
> +static bool emmc_phy_slow_mode(struct sdhci_host *host,
> +                              unsigned char timing)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct emmc_phy_params *params = priv->phy_params;
> +       struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
> +       u32 reg;
> +
> +       if (host->clock > MMC_HIGH_52_MAX_DTR)
> +               return false;
> +
> +       reg = sdhci_readl(host, phy_regs->timing_adj);
> +       /* Enable Slow Mode for SDIO in slower SDR mode */
> +       if ((priv->init_card_type == MMC_TYPE_SDIO) &&
> +           ((timing == MMC_TIMING_UHS_SDR25) ||
> +            (timing == MMC_TIMING_UHS_SDR12) ||
> +            (timing == MMC_TIMING_SD_HS))) {
> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
> +               sdhci_writel(host, reg, phy_regs->timing_adj);
> +               return true;
> +       }
> +
> +       /* Check if Slow Mode is required in lower speed mode in SDR mode */
> +       if (((timing == MMC_TIMING_UHS_SDR25) ||
> +            (timing == MMC_TIMING_UHS_SDR12) ||
> +            (timing == MMC_TIMING_SD_HS) ||
> +            (timing == MMC_TIMING_MMC_HS)) && params->slow_mode) {
> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
> +               sdhci_writel(host, reg, phy_regs->timing_adj);
> +               return true;
> +       }
> +

Two quite similar if statement. Can you perhaps combine them to avoid
code duplication.

> +       reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
> +       sdhci_writel(host, reg, phy_regs->timing_adj);
> +       return false;
> +}
> +
> +/*
> + * Set-up eMMC 5.0/5.1 PHY.
> + * Specific configuration depends on the current speed mode in use.
> + */
> +static void emmc_phy_set(struct sdhci_host *host,
> +                        unsigned char timing)
> +{
> +       u32 reg;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct emmc_phy_params *params = priv->phy_params;
> +       struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
> +       unsigned long flags;
> +
> +       dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting starts\n");
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       /* Setup pad, set bit[28] and bits[26:24] */
> +       reg = sdhci_readl(host, phy_regs->pad_ctrl);
> +       reg |= (XENON_FC_DQ_RECEN | XENON_FC_CMD_RECEN |
> +               XENON_FC_QSP_RECEN | XENON_OEN_QSN);
> +       /* All FC_XX_RECEIVCE should be set as CMOS Type */
> +       reg |= XENON_FC_ALL_CMOS_RECEIVER;
> +       sdhci_writel(host, reg, phy_regs->pad_ctrl);
> +
> +       /* Set CMD and DQ Pull Up */
> +       if (priv->phy_type == EMMC_5_0_PHY) {
> +               reg = sdhci_readl(host, XENON_EMMC_5_0_PHY_PAD_CONTROL);
> +               reg |= (XENON_EMMC5_FC_CMD_PU | XENON_EMMC5_FC_DQ_PU);
> +               reg &= ~(XENON_EMMC5_FC_CMD_PD | XENON_EMMC5_FC_DQ_PD);
> +               sdhci_writel(host, reg, XENON_EMMC_5_0_PHY_PAD_CONTROL);
> +       } else {
> +               reg = sdhci_readl(host, XENON_EMMC_PHY_PAD_CONTROL1);
> +               reg |= (XENON_EMMC5_1_FC_CMD_PU | XENON_EMMC5_1_FC_DQ_PU);
> +               reg &= ~(XENON_EMMC5_1_FC_CMD_PD | XENON_EMMC5_1_FC_DQ_PD);
> +               sdhci_writel(host, reg, XENON_EMMC_PHY_PAD_CONTROL1);
> +       }
> +
> +       if (timing == MMC_TIMING_LEGACY) {
> +               /*
> +                * If Slow Mode is required, enable Slow Mode by default
> +                * in early init phase to avoid any potential issue.
> +                */
> +               if (params->slow_mode) {
> +                       reg = sdhci_readl(host, phy_regs->timing_adj);
> +                       reg |= XENON_TIMING_ADJUST_SLOW_MODE;
> +                       sdhci_writel(host, reg, phy_regs->timing_adj);
> +               }
> +               goto phy_init;
> +       }
> +
> +       /*
> +        * FIXME: should depends on the specific board timing.
> +        */
> +       if ((timing == MMC_TIMING_MMC_HS400) ||
> +           (timing == MMC_TIMING_MMC_HS200) ||
> +           (timing == MMC_TIMING_UHS_SDR50) ||
> +           (timing == MMC_TIMING_UHS_SDR104) ||
> +           (timing == MMC_TIMING_UHS_DDR50) ||
> +           (timing == MMC_TIMING_UHS_SDR25) ||
> +           (timing == MMC_TIMING_MMC_DDR52)) {
> +               reg = sdhci_readl(host, phy_regs->timing_adj);
> +               reg &= ~XENON_OUTPUT_QSN_PHASE_SELECT;
> +               sdhci_writel(host, reg, phy_regs->timing_adj);
> +       }
> +
> +       /*
> +        * If SDIO card, set SDIO Mode
> +        * Otherwise, clear SDIO Mode
> +        */
> +       reg = sdhci_readl(host, phy_regs->timing_adj);
> +       if (priv->init_card_type == MMC_TYPE_SDIO)
> +               reg |= XENON_TIMING_ADJUST_SDIO_MODE;
> +       else
> +               reg &= ~XENON_TIMING_ADJUST_SDIO_MODE;
> +       sdhci_writel(host, reg, phy_regs->timing_adj);
> +
> +       if (emmc_phy_slow_mode(host, timing))
> +               goto phy_init;
> +
> +       /*
> +        * Set preferred ZNR and ZPR value
> +        * The ZNR and ZPR value vary between different boards.
> +        * Define them both in sdhci-xenon-emmc-phy.h.
> +        */
> +       reg = sdhci_readl(host, phy_regs->pad_ctrl2);
> +       reg &= ~((XENON_ZNR_MASK << XENON_ZNR_SHIFT) | XENON_ZPR_MASK);
> +       reg |= ((params->znr << XENON_ZNR_SHIFT) | params->zpr);
> +       sdhci_writel(host, reg, phy_regs->pad_ctrl2);
> +
> +       /*
> +        * When setting EMMC_PHY_FUNC_CONTROL register,
> +        * SD clock should be disabled
> +        */
> +       reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
> +       reg &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +       reg = sdhci_readl(host, phy_regs->func_ctrl);
> +       if ((timing == MMC_TIMING_UHS_DDR50) ||
> +           (timing == MMC_TIMING_MMC_HS400) ||
> +           (timing == MMC_TIMING_MMC_DDR52))
> +               reg |= (XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
> +                      XENON_CMD_DDR_MODE;
> +       else
> +               reg &= ~((XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
> +                        XENON_CMD_DDR_MODE);
> +
> +       if (timing == MMC_TIMING_MMC_HS400)
> +               reg &= ~XENON_DQ_ASYNC_MODE;
> +       else
> +               reg |= XENON_DQ_ASYNC_MODE;
> +       sdhci_writel(host, reg, phy_regs->func_ctrl);
> +
> +       /* Enable bus clock */
> +       reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
> +       reg |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +       if (timing == MMC_TIMING_MMC_HS400)
> +               /* Hardware team recommend a value for HS400 */
> +               sdhci_writel(host, XENON_LOGIC_TIMING_VALUE,
> +                            phy_regs->logic_timing_adj);
> +       else
> +               __emmc_phy_disable_data_strobe(host);
> +
> +phy_init:
> +       emmc_phy_init(host);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting completes\n");

Again you are checking the MMC_TIMING_* in several if statements.
Perhaps you can use switch statement instead and build a couple of
different register variables, that you use when reading/writing
afterwards.

> +}
> +
> +static int emmc_phy_parse_param_dt(struct sdhci_host *host,
> +                                  struct device_node *np,
> +                                  struct emmc_phy_params *params)
> +{
> +       u32 value;
> +
> +       if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
> +               params->slow_mode = true;
> +       else
> +               params->slow_mode = false;
> +
> +       if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
> +               params->znr = value & XENON_ZNR_MASK;
> +       else
> +               params->znr = XENON_ZNR_DEF_VALUE;
> +
> +       if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
> +               params->zpr = value & XENON_ZPR_MASK;
> +       else
> +               params->zpr = XENON_ZPR_DEF_VALUE;
> +
> +       if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
> +                                 &value))
> +               params->nr_tun_times = value & XENON_TUN_CONSECUTIVE_TIMES_MASK;
> +       else
> +               params->nr_tun_times = XENON_TUN_CONSECUTIVE_TIMES;
> +
> +       if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider",
> +                                 &value))
> +               params->tun_step_divider = value & 0xFF;
> +       else
> +               params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
> +
> +       return 0;

Instead of all these if-else, let's start by assigning default values
instead. This makes the code more readable.

> +}
> +
> +/*
> + * Setting PHY when card is working in High Speed Mode.
> + * HS400 set data strobe line.
> + * HS200/SDR104 set tuning config to prepare for tuning.
> + */
> +static int xenon_hs_delay_adj(struct sdhci_host *host)
> +{
> +       int ret = 0;
> +
> +       if (WARN_ON(host->clock <= XENON_DEFAULT_SDCLK_FREQ))
> +               return -EINVAL;
> +
> +       if (host->timing == MMC_TIMING_MMC_HS400) {
> +               emmc_phy_strobe_delay_adj(host);
> +               return 0;
> +       }
> +
> +       if ((host->timing == MMC_TIMING_MMC_HS200) ||
> +           (host->timing == MMC_TIMING_UHS_SDR104))
> +               return emmc_phy_config_tuning(host);
> +
> +       /*
> +        * DDR Mode requires driver to scan Sampling Fixed Delay Line,
> +        * to find out a perfect operation sampling point.
> +        * It is hard to implement such a scan in host driver since initiating
> +        * commands by host driver is not safe.
> +        * Thus so far just keep PHY Sampling Fixed Delay in default value
> +        * in DDR mode.
> +        *
> +        * If any timing issue occurs in DDR mode on Marvell products,
> +        * please contact maintainer to ask for internal support in Marvell.
> +        */
> +       if ((host->timing == MMC_TIMING_MMC_DDR52) ||
> +           (host->timing == MMC_TIMING_UHS_DDR50))
> +               dev_warn_once(mmc_dev(host->mmc), "Timing issue might occur in DDR mode\n");

Please consider a to convert to use a switch statment instead of the
several if statements.

> +       return ret;
> +}
> +

[...]

> +
> +static int add_xenon_phy(struct device_node *np, struct sdhci_host *host,
> +                        const char *phy_name)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int i, ret;
> +
> +       for (i = 0; i < NR_PHY_TYPES; i++) {
> +               if (!strcmp(phy_name, phy_types[i])) {
> +                       priv->phy_type = i;
> +                       break;
> +               }
> +       }
> +       if (i == NR_PHY_TYPES) {
> +               dev_err(mmc_dev(host->mmc),
> +                       "Unable to determine PHY name %s. Use default eMMC 5.1 PHY\n",
> +                       phy_name);
> +               priv->phy_type = EMMC_5_1_PHY;
> +       }
> +
> +       ret = alloc_emmc_phy(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret = emmc_phy_parse_param_dt(host, np, priv->phy_params);
> +       if (ret)
> +               clean_emmc_phy(priv);
> +
> +       return ret;
> +}
> +
> +int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
> +{
> +       const char *phy_type = NULL;
> +
> +       if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_type))
> +               return add_xenon_phy(np, host, phy_type);
> +
> +       dev_info(mmc_dev(host->mmc), "Fail to get Xenon PHY type. Use default eMMC 5.1 PHY\n");

Isn't there already a dev_err() being printed for this case. You
probably only need one.

> +       return add_xenon_phy(np, host, "emmc 5.1 phy");
> +}

[...]

Kind regards
Uffe
