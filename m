From: Ziji Hu <huziji@marvell.com>
Subject: Re: Re: [PATCH v4 07/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC
 core functionality
Date: Wed, 4 Jan 2017 16:51:12 +0800
Message-ID: <3dc96305-d711-5357-8128-2e8939b154ff@marvell.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <f48940626343ca9cf68b32b7324b243e76a11960.1481651244.git-series.gregory.clement@free-electrons.com>
 <aedd36af-8bf6-815f-34ee-9a3166e4fe5b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35370 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758504AbdADIv5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2017 03:51:57 -0500
In-Reply-To: <aedd36af-8bf6-815f-34ee-9a3166e4fe5b@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>

Hi Adrian,

On 2017/1/4 15:26, Adrian Hunter wrote:
> On 13/12/16 19:48, Gregory CLEMENT wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
>> Add Xenon eMMC/SD/SDIO host controller core functionality.
>> Add Xenon specific intialization process.
>> Add Xenon specific mmc_host_ops APIs.
>> Add Xenon specific register definitions.
>>
>> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
>>
>> Marvell Xenon SDHC conforms to SD Physical Layer Specification
>> Version 3.01 and is designed according to the guidelines provided
>> in the SD Host Controller Standard Specification Version 3.00.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

<snip>

>> +static void xenon_sdhc_tuning_setup(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	u32 reg;
>> +
>> +	/* Disable the Re-Tuning Request functionality */
>> +	reg = sdhci_readl(host, SDHCI_SLOT_RETUNING_REQ_CTRL);
>> +	reg &= ~SDHCI_RETUNING_COMPATIBLE;
>> +	sdhci_writel(host, reg, SDHCI_SLOT_RETUNING_REQ_CTRL);
>> +
>> +	/* Disable the Re-tuning Event Signal Enable */
>> +	reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
>> +	reg &= ~SDHCI_INT_RETUNE;
>> +	sdhci_writel(host, reg, SDHCI_SIGNAL_ENABLE);
>> +
>> +	/* Force to use Tuning Mode 1 */
>> +	host->tuning_mode = SDHCI_TUNING_MODE_1;
>> +	/* Set re-tuning period */
>> +	host->tuning_count = 1 << (priv->tuning_count - 1);
> 
> host->tuning_mode and host->tuning_count get overwritten in
> sdhci_setup_host() called by sdhci_add_host()
> 

	You are correct.
	I will move it after sdhci_add_host().

>> +}
>> +
<snip>

>> +/*
>> + * Xenon Specific Operations in mmc_host_ops
>> + */
>> +static void xenon_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	unsigned long flags;
>> +	u32 reg;
>> +
>> +	/*
>> +	 * HS400/HS200/eMMC HS doesn't have Preset Value register.
>> +	 * However, sdhci_set_ios will read HS400/HS200 Preset register.
>> +	 * Disable Preset Value register for HS400/HS200.
>> +	 * eMMC HS with preset_enabled set will trigger a bug in
>> +	 * get_preset_value().
>> +	 */
>> +	spin_lock_irqsave(&host->lock, flags);
>> +	if ((ios->timing == MMC_TIMING_MMC_HS400) ||
>> +	    (ios->timing == MMC_TIMING_MMC_HS200) ||
>> +	    (ios->timing == MMC_TIMING_MMC_HS)) {
>> +		host->preset_enabled = false;
>> +		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>> +
>> +		reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +		reg &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
>> +		sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
>> +	} else {
>> +		host->quirks2 &= ~SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>> +	}
>> +	spin_unlock_irqrestore(&host->lock, flags);
> 
> At some point we will have to get rid of SDHCI_QUIRK2_PRESET_VALUE_BROKEN
> and add a callback instead.
> 

	Thanks for the information.
	I would like to keep this workaround here, before the detailed patch is brought up.
	Is it OK to you?

>> +
<snip>
>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>> +					     struct mmc_ios *ios)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	/*
>> +	 * Before SD/SDIO set signal voltage, SD bus clock should be
>> +	 * disabled. However, sdhci_set_clock will also disable the Internal
>> +	 * clock in mmc_set_signal_voltage().
>> +	 * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>> +	 * Thus here manually enable internal clock.
>> +	 *
>> +	 * After switch completes, it is unnecessary to disable internal clock,
>> +	 * since keeping internal clock active obeys SD spec.
>> +	 */
>> +	enable_xenon_internal_clk(host);
> 
> We could try the attached patch.
> 

	I test your patch. It can work on my platforms.
	Thanks a lot.

	May I keep this workaround now?
	I would like to remove this workaround after your attached patch is applied.

>> +
<snip>
>> +static int sdhci_xenon_remove(struct platform_device *pdev)
>> +{
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xFFFFFFFF);
> 
> This 'dead' check was originally for PCI I think.  Unless you know it makes
> sense for your device, I would leave it out. i.e. just do
> sdhci_remove_host(host, 0);
> 

	Got it. I will remove it.

>> +
>> +	xenon_sdhc_remove(host);
>> +
>> +	sdhci_remove_host(host, dead);
>> +
>> +	clk_disable_unprepare(pltfm_host->clk);
>> +
>> +	sdhci_pltfm_free(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sdhci_xenon_dt_ids[] = {
>> +	{ .compatible = "marvell,armada-7000-sdhci",},
>> +	{ .compatible = "marvell,armada-3700-sdhci",},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>> +
>> +static struct platform_driver sdhci_xenon_driver = {
>> +	.driver	= {
>> +		.name	= "xenon-sdhci",
>> +		.of_match_table = sdhci_xenon_dt_ids,
>> +		.pm = &sdhci_pltfm_pmops,
>> +	},
>> +	.probe	= sdhci_xenon_probe,
>> +	.remove	= sdhci_xenon_remove,
>> +};
>> +
>> +module_platform_driver(sdhci_xenon_driver);
>> +
>> +MODULE_DESCRIPTION("SDHCI platform driver for Marvell Xenon SDHC");
>> +MODULE_AUTHOR("Hu Ziji <huziji@marvell.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>> new file mode 100644
>> index 000000000000..d50cd663a265
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-xenon.h
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Copyright (C) 2016 Marvell, All Rights Reserved.
>> + *
>> + * Author:	Hu Ziji <huziji@marvell.com>
>> + * Date:	2016-8-24
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + */
>> +#ifndef SDHCI_XENON_H_
>> +#define SDHCI_XENON_H_
>> +
>> +
> 
> Double blank line
> 
	Will remove it.

>> +/* Register Offset of Xenon SDHC self-defined register */
>> +#define SDHCI_SYS_CFG_INFO			0x0104
> 
> A lot of these defines look like they could be just in sdhci-xenon.c or
> sdhci-xenon-phy.c.  It is also a little odd that they are prefixed by
> "SDHCI" because they are not standard.  "XENON" would be better.
> 

	Some registers are accessed by bother sdhci-xenon.c and sdhci-xenon-phy.c.
	As a result, I list all the registers here in sdhci-xenon.h, for convenience.

	Previously, Ulf asked me to prefix them all with "SDHCI".
	I would like to know which prefix sounds more reasonable, "XENON_" or "SDHCI_XENON_"?

>> +#define SDHCI_SLOT_TYPE_SDIO_SHIFT		24
>> +#define SDHCI_NR_SUPPORTED_SLOT_MASK		0x7
>> +
>> +#define SDHCI_SYS_OP_CTRL			0x0108
>> +#define SDHCI_AUTO_CLKGATE_DISABLE_MASK		BIT(20)
>> +#define SDHCI_SDCLK_IDLEOFF_ENABLE_SHIFT	8
>> +#define SDHCI_SLOT_ENABLE_SHIFT			0
>> +
>> +#define SDHCI_SYS_EXT_OP_CTRL			0x010C
>> +
>> +#define SDHCI_SLOT_EMMC_CTRL			0x0130
>> +#define SDHCI_EMMC_VCCQ_MASK			0x3
>> +#define SDHCI_EMMC_VCCQ_1_8V			0x1
>> +#define SDHCI_EMMC_VCCQ_3_3V			0x3
>> +
>> +#define SDHCI_SLOT_RETUNING_REQ_CTRL		0x0144
>> +/* retuning compatible */
>> +#define SDHCI_RETUNING_COMPATIBLE		0x1
>> +
>> +/* Tuning Parameter */
>> +#define SDHCI_TMR_RETUN_NO_PRESENT		0xF
>> +#define SDHCI_DEF_TUNING_COUNT			0x9
>> +
>> +#define SDHCI_DEFAULT_SDCLK_FREQ		(400000)
> 
> Unnecessary ()
> 
	Will fix it.

	Thanks a lot for the review.

Best regards,
Hu Ziji

>> +
>> +/* Xenon specific Mode Select value */
>> +#define SDHCI_XENON_CTRL_HS200			0x5
>> +#define SDHCI_XENON_CTRL_HS400			0x6
>> +
>> +/* Indicate Card Type is not clear yet */
>> +#define SDHCI_CARD_TYPE_UNKNOWN			0xF
>> +
>> +struct sdhci_xenon_priv {
>> +	unsigned char	tuning_count;
>> +	/* idx of SDHC */
>> +	u8		sdhc_id;
>> +
>> +	/*
>> +	 * eMMC/SD/SDIO require different PHY settings or
>> +	 * voltage control. It's necessary for Xenon driver to
>> +	 * recognize card type during, or even before initialization.
>> +	 * However, mmc_host->card is not available yet at that time.
>> +	 * This field records the card type during init.
>> +	 * For eMMC, it is updated in dt parse. For SD/SDIO, it is
>> +	 * updated in xenon_init_card().
>> +	 *
>> +	 * It is only valid during initialization after it is updated.
>> +	 * Do not access this variable in normal transfers after
>> +	 * initialization completes.
>> +	 */
>> +	unsigned int	init_card_type;
>> +};
>> +
>> +#endif
>>
> 
