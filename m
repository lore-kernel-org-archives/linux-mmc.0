From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Wed, 12 Oct 2016 19:58:16 +0800
Message-ID: <4009a66b-1e09-0780-b7c1-128ff1401b5f@marvell.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <ecde22fd342b0b2001ff5676ea1e67b7226d6946.1475853198.git-series.gregory.clement@free-electrons.com>
 <1b015f16-aa37-591c-3299-9431f6e82cce@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32897 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753866AbcJLL7A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2016 07:59:00 -0400
In-Reply-To: <1b015f16-aa37-591c-3299-9431f6e82cce@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Keji Zhang <keji@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng

Hi Adrian,

	Thank you very much for your review.
	I will firstly fix the typo.

On 2016/10/11 20:37, Adrian Hunter wrote:
> On 07/10/16 18:22, Gregory CLEMENT wrote:
>> From: Ziji Hu <huziji@marvell.com>
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
>> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> I looked at a couple of things but you need to sort out the issues with
> card_candidate before going further.
> 
	Understood.
	I will improve the card_candidate. Please help check the details in below.

>> ---
<snip>
>> +
>> +static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
>> +					    struct mmc_ios *ios)
>> +{
>> +	unsigned char voltage = ios->signal_voltage;
>> +
>> +	if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
>> +	    (voltage == MMC_SIGNAL_VOLTAGE_180))
>> +		return __emmc_signal_voltage_switch(mmc, voltage);
>> +
>> +	dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n",
>> +		voltage);
>> +	return -EINVAL;
>> +}
>> +
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
>> +
>> +	if (priv->card_candidate) {
> 
> mmc_power_up() calls __mmc_set_signal_voltage() calls
> host->ops->start_signal_voltage_switch so priv->card_candidate could be an
> invalid reference to an old card.
> 
> So that's not going to work if the card changes - not only for removable
> cards but even for eMMC if init fails and retries.
> 
	As you point out, this piece of code have defects, even though it actually works on Marvell multiple platforms, unless eMMC card is removable.

	I can add a property to explicitly indicate eMMC type in DTS.
	Then card_candidate access can be removed here.
	Does it sounds more reasonable to you?

>> +		if (mmc_card_mmc(priv->card_candidate))
>> +			return xenon_emmc_signal_voltage_switch(mmc, ios);
> 
> So if all you need to know is whether it is a eMMC, why can't DT tell you?
> 
	I can add an eMMC type property in DTS, to remove the card_candidate access here.

>> +	}
>> +
>> +	return sdhci_start_signal_voltage_switch(mmc, ios);
>> +}
>> +
>> +/*
>> + * After determining which slot is used for SDIO,
>> + * some additional task is required.
>> + */
>> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	u32 reg;
>> +	u8 slot_idx;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	/* Link the card for delay adjustment */
>> +	priv->card_candidate = card;
> 
> You really need a better way to get the card.  I suggest you take up the
> issue with Ulf.  One possibility is to have mmc core set host->card = card
> much earlier.
> 
	Could you please tell me if any issue related to card_candidate still exists, after the card_candidate is removed from xenon_start_signal_voltage_switch() in above?
	It seems that when init_card is called, the structure card has already been updated and stable in MMC/SD/SDIO initialization sequence.
	May I keep it here?

>> +	/* Set tuning functionality of this slot */
>> +	xenon_slot_tuning_setup(host);
>> +
>> +	slot_idx = priv->slot_idx;
>> +	if (!mmc_card_sdio(card)) {
>> +		/* Re-enable the Auto-CMD12 cap flag. */
>> +		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> +		host->flags |= SDHCI_AUTO_CMD12;
>> +
>> +		/* Clear SDIO Card Inserted indication */
>> +		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +		reg &= ~(1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>> +		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
>> +
>> +		if (mmc_card_mmc(card)) {
>> +			mmc->caps |= MMC_CAP_NONREMOVABLE;
>> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))
>> +				mmc->caps |= MMC_CAP_1_8V_DDR;
>> +			/*
>> +			 * Force to clear BUS_TEST to
>> +			 * skip bus_test_pre and bus_test_post
>> +			 */
>> +			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>> +			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
>> +				      MMC_CAP2_PACKED_CMD;
>> +			if (mmc->caps & MMC_CAP_8_BIT_DATA)
>> +				mmc->caps2 |= MMC_CAP2_HS400_1_8V;
>> +		}
>> +	} else {
>> +		/*
>> +		 * Delete the Auto-CMD12 cap flag.
>> +		 * Otherwise, when sending multi-block CMD53,
>> +		 * Driver will set Transfer Mode Register to enable Auto CMD12.
>> +		 * However, SDIO device cannot recognize CMD12.
>> +		 * Thus SDHC will time-out for waiting for CMD12 response.
>> +		 */
>> +		host->quirks &= ~SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> +		host->flags &= ~SDHCI_AUTO_CMD12;
> 
> sdhci_set_transfer_mode() won't enable auto-CMD12 for CMD53 anyway, so is
> this needed?
> 
	In Xenon driver, Auto-CMD12 flag is set to enable full support to Auto-CMD feature, both Auto-CMD12 and Auto-CMD23.
	As a result, when Xenon SDHC slot can both support SD and SDIO, Auto-CMD12 is disabled when SDIO card is inserted, and renabled when SD is inserted.

	I recheck the sdhci code to set Auto-CMD bit in Transfer Mode register, in sdhci_set_transfer_mode():
	if (mmc_op_multi(cmd->opcode) || data->blocks > 1)
	As you can see, as long as it is CMD18/CMD25 OR there are multiple data blocks, Auto-CMD field will be set.
	CMD53 doesn't have CMD23. Thus Auto-CMD12 is selected since Auto-CMD12 flag is set.
	Thus I have to clear Auto-CMD12 to avoid issuing Auto-CMD12 in SDIO transfer.

	I just meet a similar issue in RPMB.
	When Auto-CMD12 flag is set, eMMC RPMB access will trigger Auto-CMD12, since CMD25 is in use.
	It will cause RPMB access failed.

	One possible solution is to drop Auto-CMD12 support and use Auto-CMD23 only, in Xenon driver.
	May I know you opinion, please?

>> +
>> +		/*
>> +		 * Set SDIO Card Inserted indication
>> +		 * to inform that the current slot is for SDIO
>> +		 */
>> +		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +		reg |= (1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>> +		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
>> +	}
>> +}
>> +
>> +static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +	if (host->timing == MMC_TIMING_UHS_DDR50)
>> +		return 0;
>> +
>> +	return sdhci_execute_tuning(mmc, opcode);
>> +}
>> +
>> +static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
>> +{
>> +	host->mmc_host_ops.set_ios = xenon_set_ios;
>> +	host->mmc_host_ops.start_signal_voltage_switch =
>> +			xenon_start_signal_voltage_switch;
>> +	host->mmc_host_ops.init_card = xenon_init_card;
>> +	host->mmc_host_ops.execute_tuning = xenon_execute_tuning;
>> +}
>> +
>> +static int xenon_probe_dt(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct mmc_host *mmc = host->mmc;
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	int err;
>> +	u32 slot_idx, nr_slot;
>> +	u32 tuning_count;
>> +	u32 reg;
>> +
>> +	/* Standard MMC property */
>> +	err = mmc_of_parse(mmc);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Standard SDHCI property */
>> +	sdhci_get_of_property(pdev);
>> +
>> +	/*
>> +	 * Xenon Specific property:
>> +	 * slotno: the index of slot. Refer to SDHC_SYS_CFG_INFO register
>> +	 * tuning-count: the interval between re-tuning
>> +	 * PHY type: "sdhc phy", "emmc phy 5.0" or "emmc phy 5.1"
>> +	 */
>> +	if (!of_property_read_u32(np, "xenon,slotno", &slot_idx)) {
>> +		nr_slot = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +		nr_slot &= NR_SUPPORTED_SLOT_MASK;
>> +		if (unlikely(slot_idx > nr_slot)) {
>> +			dev_err(mmc_dev(mmc), "Slot Index %d exceeds Number of slots %d\n",
>> +				slot_idx, nr_slot);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		priv->slot_idx = 0x0;
>> +	}
>> +
>> +	if (!of_property_read_u32(np, "xenon,tuning-count", &tuning_count)) {
>> +		if (unlikely(tuning_count >= TMR_RETUN_NO_PRESENT)) {
>> +			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
>> +				DEF_TUNING_COUNT);
>> +			tuning_count = DEF_TUNING_COUNT;
>> +		}
>> +	} else {
>> +		priv->tuning_count = DEF_TUNING_COUNT;
>> +	}
>> +
>> +	if (of_property_read_bool(np, "xenon,mask-conflict-err")) {
>> +		reg = sdhci_readl(host, SDHC_SYS_EXT_OP_CTRL);
>> +		reg |= MASK_CMD_CONFLICT_ERROR;
>> +		sdhci_writel(host, reg, SDHC_SYS_EXT_OP_CTRL);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int xenon_slot_probe(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	u8 slot_idx = priv->slot_idx;
>> +
>> +	/* Enable slot */
>> +	xenon_enable_slot(host, slot_idx);
>> +
>> +	/* Enable ACG */
>> +	xenon_set_acg(host, true);
>> +
>> +	/* Enable Parallel Transfer Mode */
>> +	xenon_enable_slot_parallel_tran(host, slot_idx);
>> +
>> +	priv->timing = MMC_TIMING_FAKE;
>> +	priv->clock = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static void xenon_slot_remove(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	u8 slot_idx = priv->slot_idx;
>> +
>> +	/* disable slot */
>> +	xenon_disable_slot(host, slot_idx);
>> +}
>> +
>> +static int sdhci_xenon_probe(struct platform_device *pdev)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_host *host;
>> +	struct clk *clk, *axi_clk;
>> +	struct sdhci_xenon_priv *priv;
>> +	int err;
>> +
>> +	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
>> +				sizeof(struct sdhci_xenon_priv));
>> +	if (IS_ERR(host))
>> +		return PTR_ERR(host);
>> +
>> +	pltfm_host = sdhci_priv(host);
>> +	priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	xenon_set_acg(host, false);
>> +
>> +	/*
>> +	 * Link Xenon specific mmc_host_ops function,
>> +	 * to replace standard ones in sdhci_ops.
>> +	 */
>> +	xenon_replace_mmc_host_ops(host);
>> +
>> +	clk = devm_clk_get(&pdev->dev, "core");
>> +	if (IS_ERR(clk)) {
>> +		dev_err(&pdev->dev, "Failed to setup input clk.\n");
>> +		err = PTR_ERR(clk);
>> +		goto free_pltfm;
>> +	}
>> +	clk_prepare_enable(clk);
>> +	pltfm_host->clk = clk;
>> +
>> +	/*
>> +	 * Some SOCs require additional clock to
>> +	 * manage AXI bus clock.
>> +	 * It is optional.
>> +	 */
>> +	axi_clk = devm_clk_get(&pdev->dev, "axi");
>> +	if (!IS_ERR(axi_clk)) {
>> +		clk_prepare_enable(axi_clk);
>> +		priv->axi_clk = axi_clk;
>> +	}
>> +
>> +	err = xenon_probe_dt(pdev);
>> +	if (err)
>> +		goto err_clk;
>> +
>> +	err = xenon_slot_probe(host);
>> +	if (err)
>> +		goto err_clk;
>> +
>> +	err = sdhci_add_host(host);
>> +	if (err)
>> +		goto remove_slot;
>> +
>> +	return 0;
>> +
>> +remove_slot:
>> +	xenon_slot_remove(host);
>> +err_clk:
>> +	clk_disable_unprepare(pltfm_host->clk);
>> +	if (!IS_ERR(axi_clk))
>> +		clk_disable_unprepare(axi_clk);
>> +free_pltfm:
>> +	sdhci_pltfm_free(pdev);
>> +	return err;
>> +}
>> +
>> +static int sdhci_xenon_remove(struct platform_device *pdev)
>> +{
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xFFFFFFFF);
>> +
>> +	xenon_slot_remove(host);
>> +
>> +	sdhci_remove_host(host, dead);
>> +
>> +	clk_disable_unprepare(pltfm_host->clk);
>> +	clk_disable_unprepare(priv->axi_clk);
>> +
>> +	sdhci_pltfm_free(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sdhci_xenon_dt_ids[] = {
>> +	{ .compatible = "marvell,sdhci-xenon",},
>> +	{ .compatible = "marvell,armada-3700-sdhci",},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>> +
>> +static struct platform_driver sdhci_xenon_driver = {
>> +	.driver	= {
>> +		.name	= "sdhci-xenon",
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
>> index 000000000000..c2370493fbe8
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-xenon.h
>> @@ -0,0 +1,134 @@
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
>> +#include <linux/clk.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/of.h>
>> +#include "sdhci.h"
>> +
>> +/* Register Offset of SD Host Controller SOCP self-defined register */
>> +#define SDHC_SYS_CFG_INFO			0x0104
>> +#define SLOT_TYPE_SDIO_SHIFT			24
>> +#define SLOT_TYPE_EMMC_MASK			0xFF
>> +#define SLOT_TYPE_EMMC_SHIFT			16
>> +#define SLOT_TYPE_SD_SDIO_MMC_MASK		0xFF
>> +#define SLOT_TYPE_SD_SDIO_MMC_SHIFT		8
>> +#define NR_SUPPORTED_SLOT_MASK			0x7
>> +
>> +#define SDHC_SYS_OP_CTRL			0x0108
>> +#define AUTO_CLKGATE_DISABLE_MASK		BIT(20)
>> +#define SDCLK_IDLEOFF_ENABLE_SHIFT		8
>> +#define SLOT_ENABLE_SHIFT			0
>> +
>> +#define SDHC_SYS_EXT_OP_CTRL			0x010C
>> +#define MASK_CMD_CONFLICT_ERROR			BIT(8)
>> +
>> +#define SDHC_SLOT_OP_STATUS_CTRL		0x0128
>> +#define DELAY_90_DEGREE_MASK_EMMC5		BIT(7)
>> +#define DELAY_90_DEGREE_SHIFT_EMMC5		7
>> +#define EMMC_5_0_PHY_FIXED_DELAY_MASK		0x7F
>> +#define EMMC_PHY_FIXED_DELAY_MASK		0xFF
>> +#define EMMC_PHY_FIXED_DELAY_WINDOW_MIN		(EMMC_PHY_FIXED_DELAY_MASK >> 3)
>> +#define SDH_PHY_FIXED_DELAY_MASK		0x1FF
>> +#define SDH_PHY_FIXED_DELAY_WINDOW_MIN		(SDH_PHY_FIXED_DELAY_MASK >> 4)
>> +
>> +#define TUN_CONSECUTIVE_TIMES_SHIFT		16
>> +#define TUN_CONSECUTIVE_TIMES_MASK		0x7
>> +#define TUN_CONSECUTIVE_TIMES			0x4
>> +#define TUNING_STEP_SHIFT			12
>> +#define TUNING_STEP_MASK			0xF
>> +#define TUNING_STEP_DIVIDER			BIT(6)
>> +
>> +#define FORCE_SEL_INVERSE_CLK_SHIFT		11
>> +
>> +#define SDHC_SLOT_EMMC_CTRL			0x0130
>> +#define ENABLE_DATA_STROBE			BIT(24)
>> +#define SET_EMMC_RSTN				BIT(16)
>> +#define DISABLE_RD_DATA_CRC			BIT(14)
>> +#define DISABLE_CRC_STAT_TOKEN			BIT(13)
>> +#define EMMC_VCCQ_MASK				0x3
>> +#define EMMC_VCCQ_1_8V				0x1
>> +#define EMMC_VCCQ_3_3V				0x3
>> +
>> +#define SDHC_SLOT_RETUNING_REQ_CTRL		0x0144
>> +/* retuning compatible */
>> +#define RETUNING_COMPATIBLE			0x1
>> +
>> +#define SDHC_SLOT_EXT_PRESENT_STATE		0x014C
>> +#define LOCK_STATE				0x1
>> +
>> +#define SDHC_SLOT_DLL_CUR_DLY_VAL		0x0150
>> +
>> +/* Tuning Parameter */
>> +#define TMR_RETUN_NO_PRESENT			0xF
>> +#define DEF_TUNING_COUNT			0x9
>> +
>> +#define MMC_TIMING_FAKE				0xFF
>> +
>> +#define DEFAULT_SDCLK_FREQ			(400000)
>> +
>> +/* Xenon specific Mode Select value */
>> +#define XENON_SDHCI_CTRL_HS200			0x5
>> +#define XENON_SDHCI_CTRL_HS400			0x6
>> +
>> +struct sdhci_xenon_priv {
>> +	/*
>> +	 * The bus_width, timing, and clock fields in below
>> +	 * record the current setting of Xenon SDHC.
>> +	 * Driver will call a Sampling Fixed Delay Adjustment
>> +	 * if any setting is changed.
>> +	 */
>> +	unsigned char	bus_width;
>> +	unsigned char	timing;
>> +	unsigned char	tuning_count;
>> +	unsigned int	clock;
>> +	struct clk	*axi_clk;
>> +
>> +	/* Slot idx */
>> +	u8		slot_idx;
>> +
>> +	/*
>> +	 * When initializing card, Xenon has to determine card type and
>> +	 * adjust Sampling Fixed delay.
>> +	 * However, at that time, card structure is not linked to mmc_host.
>> +	 * Thus a card pointer is added here to provide
>> +	 * the delay adjustment function with the card structure
>> +	 * of the card during initialization
>> +	 */
>> +	struct mmc_card *card_candidate;
>> +};
>> +
>> +static inline int enable_xenon_internal_clk(struct sdhci_host *host)
>> +{
>> +	u32 reg;
>> +	u8 timeout;
>> +
>> +	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
>> +	reg |= SDHCI_CLOCK_INT_EN;
>> +	sdhci_writel(host, reg, SDHCI_CLOCK_CONTROL);
>> +	/* Wait max 20 ms */
>> +	timeout = 20;
>> +	while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>> +			& SDHCI_CLOCK_INT_STABLE)) {
>> +		if (timeout == 0) {
>> +			pr_err("%s: Internal clock never stabilised.\n",
>> +			       mmc_hostname(host->mmc));
>> +			return -ETIMEDOUT;
>> +		}
>> +		timeout--;
>> +		mdelay(1);
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
>>
> 
