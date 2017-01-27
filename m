From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH v5 07/12] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC.
Date: Sat, 28 Jan 2017 01:10:54 +0800
Message-ID: <1f174462-7644-1d02-9216-01c1fa3b402b@marvell.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <130ccd5a0fe4f822b954e0256c9dccec0b6ca523.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpx23wio-QmDrx277+YO2Jt2S0ZrokZ2E4K+oVURSR1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpx23wio-QmDrx277+YO2Jt2S0ZrokZ2E4K+oVURSR1Hg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2017/1/26 19:29, Ulf Hansson wrote:
> [...]
> 
>> +
>> +static inline bool temp_stage_hs200_to_hs400(struct sdhci_host *host,
>> +                                            struct sdhci_xenon_priv *priv)
>> +{
>> +       /*
>> +        * Tmep stages from HS200 to HS400
>> +        * from HS200 to HS in 200MHz
>> +        * from 200MHz to 52MHz
>> +        */
>> +       if (((priv->timing == MMC_TIMING_MMC_HS200) &&
>> +            (host->timing == MMC_TIMING_MMC_HS)) ||
>> +           ((host->timing == MMC_TIMING_MMC_HS) &&
>> +            (priv->clock > host->clock)))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +static inline bool temp_stage_hs400_to_h200(struct sdhci_host *host,
>> +                                           struct sdhci_xenon_priv *priv)
>> +{
>> +       /*
>> +        * Temp stages from HS400 t0 HS200:
>> +        * from 200MHz to 52MHz in HS400
>> +        * from HS400 to HS DDR in 52MHz
>> +        * from HS DDR to HS in 52MHz
>> +        * from HS to HS200 in 52MHz
>> +        */
>> +       if (((priv->timing == MMC_TIMING_MMC_HS400) &&
>> +            ((host->clock == MMC_HIGH_52_MAX_DTR) ||
>> +             (host->timing == MMC_TIMING_MMC_DDR52))) ||
>> +           ((priv->timing == MMC_TIMING_MMC_DDR52) &&
>> +            (host->timing == MMC_TIMING_MMC_HS)) ||
>> +           ((host->timing == MMC_TIMING_MMC_HS200) &&
>> +            (host->clock == MMC_HIGH_52_MAX_DTR)))
>> +               return true;
>> +
>> +       return false;
>> +}
> 
> Both the above functions seems to be really fragile to use. If
> anything changes in the core layer related to these sequences, you may
> end up getting a wrong validated expression.
> 
> Perhaps an option would be to add one or two new mmc host ops, which
> could be called during the related hs200/400 sequences that could make
> this less fragile for you? What do you think?
> 

    Yes, they both look fragile to use.
    In my own opinion, hs200->hs400 sequence might be safe since it has been
    defined and fixed by eMMC spec. I personally think it is unlikely to be
    adjusted again. Please correct me if I am wrong.
    However, as you said, hs400->hs200 sequence will have issue if it is
    changed in core layer, since such a sequence is not from eMMC spec.

    But, in my opinion, adding additional mmc host ops might not be helpful.
    The above two functions are part of Xenon PHY adjustment. Those two
    functions help save some PHY setting steps in hs200->hs400/hs400->hs200
    sequence. But other PHY settings are still necessary,
    which should be executed each time when mmc core layer set ios.
    Neither of them can be extracted out and put into another mmc host ops.

    Instead, it will helps us improve the above two if we can add a flag to
    indicate that eMMC is in a temporary status in hs200->hs400 or hs400->hs200
    sequence.

>> +
>> +/*
>> + * If eMMC PHY Slow Mode is required in lower speed mode in SDR mode
>> + * (SDLCK < 55MHz), enable Slow Mode to bypass eMMC PHY.
>> + * SDIO slower SDR mode also requires Slow Mode.
>> + *
>> + * If Slow Mode is enabled, return true.
>> + * Otherwise, return false.
>> + */
>> +static bool emmc_phy_slow_mode(struct sdhci_host *host,
>> +                              unsigned char timing)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       struct emmc_phy_params *params = priv->phy_params;
>> +       struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
>> +       u32 reg;
>> +
>> +       /* Skip temp stages from HS200 to HS400 */
>> +       if (temp_stage_hs200_to_hs400(host, priv))
>> +               return false;
>> +
>> +       /* Skip temp stages from HS400 t0 HS200 */
>> +       if (temp_stage_hs400_to_h200(host, priv))
>> +               return false;
>> +
>> +       reg = sdhci_readl(host, phy_regs->timing_adj);
>> +       /* Enable Slow Mode for SDIO in slower SDR mode */
>> +       if ((priv->init_card_type == MMC_TYPE_SDIO) &&
> 
> Ah, noticed that there is some specific things going on here for SDIO
> here as well. So perhaps you do need to implement the ->init_card()
> ops anyway. Which I suggested not to, for patch6. :-)
> 
> Although, there is one problem with using ->init_card(). That is
> particularly for removable cards, as mmc_rescan() doesn't invoke
> ->init_card() when it removes a card, which means, you may use old and
> thus wrong information about what kind of card in the next card
> detection attempt. So perhaps ->init_card() needs to be called from
> the core before it even figured out what kind of card it is trying to
> detect, as to allow the callbacks to reset some data.
> 
> Or perhaps you can think of another clever way!?
>

    It is a good question.

    Our Xenon requires to set SDIO Mode and PHY Slow Mode for SDIO card.
    Both of them are configed in function emmc_phy_set(). In emmc_phy_set(),
    we will skip setting those two configs if current timing is
    MMC_TIMING_LEGACY.
    It seems that card structure can be updated before switching into
    higher speed mode from MMC_TIMING_LEGACY. Thus I personally believe we
    can get updated card type in ->init_card().

    Hope my above answer can satisfy you. If there is any issue, please kindly
    let me know.
    I will also ask my teammates to do more tests, to make sure no corner case.

    Thank you.

Best regards,
Hu Ziji

> 
>> +           ((timing == MMC_TIMING_UHS_SDR25) ||
>> +            (timing == MMC_TIMING_UHS_SDR12) ||
>> +            (timing == MMC_TIMING_SD_HS) ||
>> +            (timing == MMC_TIMING_LEGACY))) {
>> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
>> +               sdhci_writel(host, reg, phy_regs->timing_adj);
>> +               return true;
>> +       }
>> +
>> +       /* Check if Slow Mode is required in lower speed mode in SDR mode */
>> +       if (((timing == MMC_TIMING_UHS_SDR50) ||
>> +            (timing == MMC_TIMING_UHS_SDR25) ||
>> +            (timing == MMC_TIMING_UHS_SDR12) ||
>> +            (timing == MMC_TIMING_SD_HS) ||
>> +            (timing == MMC_TIMING_MMC_HS) ||
>> +            (timing == MMC_TIMING_LEGACY)) && params->slow_mode) {
>> +               reg |= XENON_TIMING_ADJUST_SLOW_MODE;
>> +               sdhci_writel(host, reg, phy_regs->timing_adj);
>> +               return true;
>> +       }
>> +
>> +       reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
>> +       sdhci_writel(host, reg, phy_regs->timing_adj);
>> +       return false;
>> +}
>> +
> 
> [...]
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
