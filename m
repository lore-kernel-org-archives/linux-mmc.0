From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Wed, 15 Mar 2017 22:31:53 +0800
Message-ID: <288b58dc-cce7-11c3-e946-7bf0ea5a4863@marvell.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <b646d28daf3d8cb8e57774ce040f39350364041e.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrQb3NA53o6z9go0+RxxvstwWdeLHpiXtKaXOksxrov3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFrQb3NA53o6z9go0+RxxvstwWdeLHpiXtKaXOksxrov3g@mail.gmail.com>
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

On 2017/3/15 21:39, Ulf Hansson wrote:
> On 14 February 2017 at 18:01, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
<snip>
>> +
>> +       /*
>> +        * FIXME: should depends on the specific board timing.
>> +        */
>> +       if ((timing == MMC_TIMING_MMC_HS400) ||
>> +           (timing == MMC_TIMING_MMC_HS200) ||
>> +           (timing == MMC_TIMING_UHS_SDR50) ||
>> +           (timing == MMC_TIMING_UHS_SDR104) ||
>> +           (timing == MMC_TIMING_UHS_DDR50) ||
>> +           (timing == MMC_TIMING_UHS_SDR25) ||
>> +           (timing == MMC_TIMING_MMC_DDR52)) {
>> +               reg = sdhci_readl(host, phy_regs->timing_adj);
>> +               reg &= ~XENON_OUTPUT_QSN_PHASE_SELECT;
>> +               sdhci_writel(host, reg, phy_regs->timing_adj);
>> +       }
>> +
<snip>
>> +
>> +       reg = sdhci_readl(host, phy_regs->func_ctrl);
>> +       if ((timing == MMC_TIMING_UHS_DDR50) ||
>> +           (timing == MMC_TIMING_MMC_HS400) ||
>> +           (timing == MMC_TIMING_MMC_DDR52))
>> +               reg |= (XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
>> +                      XENON_CMD_DDR_MODE;
>> +       else
>> +               reg &= ~((XENON_DQ_DDR_MODE_MASK << XENON_DQ_DDR_MODE_SHIFT) |
>> +                        XENON_CMD_DDR_MODE);
<snip>
> 
> Again you are checking the MMC_TIMING_* in several if statements.
> Perhaps you can use switch statement instead and build a couple of
> different register variables, that you use when reading/writing
> afterwards.
> 

	Sorry. I don't quite understand your comment.
	Do you mean combine all the related  register settings
	under a specific MMC_TIMING_*?

	swhich (timing) {
	case MMC_TIMING_HS400:
		config reg_1;
		config reg_2;
		...
	case MMC_TIMING_HS200:
		config reg_2;
		config reg_3
		..
	case ...
	};

	I have a little concern that there might be a lot
	of duplicate register settings. Some PHY operations are
	irrelevant to the speed mode. They have to be executed in
	a particular sequence in all speed modes.

>> +}
>> +
>> +static int emmc_phy_parse_param_dt(struct sdhci_host *host,
>> +                                  struct device_node *np,
>> +                                  struct emmc_phy_params *params)
>> +{
>> +       u32 value;
>> +
>> +       if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
>> +               params->slow_mode = true;
>> +       else
>> +               params->slow_mode = false;
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
>> +               params->znr = value & XENON_ZNR_MASK;
>> +       else
>> +               params->znr = XENON_ZNR_DEF_VALUE;
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
>> +               params->zpr = value & XENON_ZPR_MASK;
>> +       else
>> +               params->zpr = XENON_ZPR_DEF_VALUE;
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
>> +                                 &value))
>> +               params->nr_tun_times = value & XENON_TUN_CONSECUTIVE_TIMES_MASK;
>> +       else
>> +               params->nr_tun_times = XENON_TUN_CONSECUTIVE_TIMES;
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider",
>> +                                 &value))
>> +               params->tun_step_divider = value & 0xFF;
>> +       else
>> +               params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
>> +
>> +       return 0;
> 
> Instead of all these if-else, let's start by assigning default values
> instead. This makes the code more readable.
> 
	Sure. I'll change it.
	
>> +}
>> +
>> +/*
>> + * Setting PHY when card is working in High Speed Mode.
>> + * HS400 set data strobe line.
>> + * HS200/SDR104 set tuning config to prepare for tuning.
>> + */
>> +static int xenon_hs_delay_adj(struct sdhci_host *host)
>> +{
>> +       int ret = 0;
>> +
>> +       if (WARN_ON(host->clock <= XENON_DEFAULT_SDCLK_FREQ))
>> +               return -EINVAL;
>> +
>> +       if (host->timing == MMC_TIMING_MMC_HS400) {
>> +               emmc_phy_strobe_delay_adj(host);
>> +               return 0;
>> +       }
>> +
>> +       if ((host->timing == MMC_TIMING_MMC_HS200) ||
>> +           (host->timing == MMC_TIMING_UHS_SDR104))
>> +               return emmc_phy_config_tuning(host);
>> +
>> +       /*
>> +        * DDR Mode requires driver to scan Sampling Fixed Delay Line,
>> +        * to find out a perfect operation sampling point.
>> +        * It is hard to implement such a scan in host driver since initiating
>> +        * commands by host driver is not safe.
>> +        * Thus so far just keep PHY Sampling Fixed Delay in default value
>> +        * in DDR mode.
>> +        *
>> +        * If any timing issue occurs in DDR mode on Marvell products,
>> +        * please contact maintainer to ask for internal support in Marvell.
>> +        */
>> +       if ((host->timing == MMC_TIMING_MMC_DDR52) ||
>> +           (host->timing == MMC_TIMING_UHS_DDR50))
>> +               dev_warn_once(mmc_dev(host->mmc), "Timing issue might occur in DDR mode\n");
> 
> Please consider a to convert to use a switch statment instead of the
> several if statements.
> 

	It is a good idea to use switch here.

>> +       return ret;
>> +}
>> +
> 
<snip>
>> +int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
>> +{
>> +       const char *phy_type = NULL;
>> +
>> +       if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_type))
>> +               return add_xenon_phy(np, host, phy_type);
>> +
>> +       dev_info(mmc_dev(host->mmc), "Fail to get Xenon PHY type. Use default eMMC 5.1 PHY\n");
> 
> Isn't there already a dev_err() being printed for this case. You
> probably only need one.

	By default, "emmc 5.1 phy" is used on most of our products.
	Thus this dt property is an optional one.
	I can remove this dev_info.

> 
>> +       return add_xenon_phy(np, host, "emmc 5.1 phy");
>> +}
> 
> [...]
> 
> Kind regards
> Uffe
> 
