From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 07/12] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC.
Date: Thu, 26 Jan 2017 12:29:33 +0100
Message-ID: <CAPDyKFpx23wio-QmDrx277+YO2Jt2S0ZrokZ2E4K+oVURSR1Hg@mail.gmail.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <130ccd5a0fe4f822b954e0256c9dccec0b6ca523.1484154449.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <130ccd5a0fe4f822b954e0256c9dccec0b6ca523.1484154449.git-series.gregory.clement@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan
List-Id: linux-mmc@vger.kernel.org

[...]

> +
> +static inline bool temp_stage_hs200_to_hs400(struct sdhci_host *host,
> +                                            struct sdhci_xenon_priv *priv)
> +{
> +       /*
> +        * Tmep stages from HS200 to HS400
> +        * from HS200 to HS in 200MHz
> +        * from 200MHz to 52MHz
> +        */
> +       if (((priv->timing == MMC_TIMING_MMC_HS200) &&
> +            (host->timing == MMC_TIMING_MMC_HS)) ||
> +           ((host->timing == MMC_TIMING_MMC_HS) &&
> +            (priv->clock > host->clock)))
> +               return true;
> +
> +       return false;
> +}
> +
> +static inline bool temp_stage_hs400_to_h200(struct sdhci_host *host,
> +                                           struct sdhci_xenon_priv *priv)
> +{
> +       /*
> +        * Temp stages from HS400 t0 HS200:
> +        * from 200MHz to 52MHz in HS400
> +        * from HS400 to HS DDR in 52MHz
> +        * from HS DDR to HS in 52MHz
> +        * from HS to HS200 in 52MHz
> +        */
> +       if (((priv->timing == MMC_TIMING_MMC_HS400) &&
> +            ((host->clock == MMC_HIGH_52_MAX_DTR) ||
> +             (host->timing == MMC_TIMING_MMC_DDR52))) ||
> +           ((priv->timing == MMC_TIMING_MMC_DDR52) &&
> +            (host->timing == MMC_TIMING_MMC_HS)) ||
> +           ((host->timing == MMC_TIMING_MMC_HS200) &&
> +            (host->clock == MMC_HIGH_52_MAX_DTR)))
> +               return true;
> +
> +       return false;
> +}

Both the above functions seems to be really fragile to use. If
anything changes in the core layer related to these sequences, you may
end up getting a wrong validated expression.

Perhaps an option would be to add one or two new mmc host ops, which
could be called during the related hs200/400 sequences that could make
this less fragile for you? What do you think?

> +
> +/*
> + * If eMMC PHY Slow Mode is required in lower speed mode in SDR mode
> + * (SDLCK < 55MHz), enable Slow Mode to bypass eMMC PHY.
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
> +       /* Skip temp stages from HS200 to HS400 */
> +       if (temp_stage_hs200_to_hs400(host, priv))
> +               return false;
> +
> +       /* Skip temp stages from HS400 t0 HS200 */
> +       if (temp_stage_hs400_to_h200(host, priv))
> +               return false;
> +
> +       reg = sdhci_readl(host, phy_regs->timing_adj);
> +       /* Enable Slow Mode for SDIO in slower SDR mode */
> +       if ((priv->init_card_type == MMC_TYPE_SDIO) &&

Ah, noticed that there is some specific things going on here for SDIO
here as well. So perhaps you do need to implement the ->init_card()
ops anyway. Which I suggested not to, for patch6. :-)

Although, there is one problem with using ->init_card(). That is
particularly for removable cards, as mmc_rescan() doesn't invoke
->init_card() when it removes a card, which means, you may use old and
thus wrong information about what kind of card in the next card
detection attempt. So perhaps ->init_card() needs to be called from
the core before it even figured out what kind of card it is trying to
detect, as to allow the callbacks to reset some data.

Or perhaps you can think of another clever way!?


> +           ((timing == MMC_TIMING_UHS_SDR25) ||
> +            (timing == MMC_TIMING_UHS_SDR12) ||
> +            (timing == MMC_TIMING_SD_HS) ||
> +            (timing == MMC_TIMING_LEGACY))) {
> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
> +               sdhci_writel(host, reg, phy_regs->timing_adj);
> +               return true;
> +       }
> +
> +       /* Check if Slow Mode is required in lower speed mode in SDR mode */
> +       if (((timing == MMC_TIMING_UHS_SDR50) ||
> +            (timing == MMC_TIMING_UHS_SDR25) ||
> +            (timing == MMC_TIMING_UHS_SDR12) ||
> +            (timing == MMC_TIMING_SD_HS) ||
> +            (timing == MMC_TIMING_MMC_HS) ||
> +            (timing == MMC_TIMING_LEGACY)) && params->slow_mode) {
> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
> +               sdhci_writel(host, reg, phy_regs->timing_adj);
> +               return true;
> +       }
> +
> +       reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
> +       sdhci_writel(host, reg, phy_regs->timing_adj);
> +       return false;
> +}
> +

[...]

Kind regards
Uffe
