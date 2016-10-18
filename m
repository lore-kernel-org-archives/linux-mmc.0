From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Tue, 18 Oct 2016 20:09:25 +0800
Message-ID: <d6429afb-ed45-e0c7-917f-54fd8c69fb11@marvell.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <ecde22fd342b0b2001ff5676ea1e67b7226d6946.1475853198.git-series.gregory.clement@free-electrons.com>
 <1b015f16-aa37-591c-3299-9431f6e82cce@intel.com>
 <4009a66b-1e09-0780-b7c1-128ff1401b5f@marvell.com>
 <7939a923-eb97-ca44-ac4c-f0a3cd4f45bc@intel.com>
 <6bed26dc-f4c1-7f0d-36b6-d7d5fcbf0da9@marvell.com>
 <ec7a2658-5af3-bff8-3cb8-adb72406df5c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44156 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754454AbcJRMKN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 08:10:13 -0400
In-Reply-To: <ec7a2658-5af3-bff8-3cb8-adb72406df5c@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>, Liuliu Zhao <zhaoliul@marvell.com>, Peng Zhu <zhupeng@marvell.com>, Yu Cao <yuca>

Hi Adrian,

On 2016/10/17 16:14, Adrian Hunter wrote:
> On 13/10/16 08:38, Ziji Hu wrote:
>> Hi Adrian,
>>
>> On 2016/10/12 21:07, Adrian Hunter wrote:
>>> On 12/10/16 14:58, Ziji Hu wrote:
>>>> Hi Adrian,
>>>>
>>>> 	Thank you very much for your review.
>>>> 	I will firstly fix the typo.
>>>>
>>>> On 2016/10/11 20:37, Adrian Hunter wrote:
>> <snip>
>>>>>> +
>>>>>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>>>>>> +					     struct mmc_ios *ios)
>>>>>> +{
>>>>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Before SD/SDIO set signal voltage, SD bus clock should be
>>>>>> +	 * disabled. However, sdhci_set_clock will also disable the Internal
>>>>>> +	 * clock in mmc_set_signal_voltage().
>>>>>> +	 * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>>>>>> +	 * Thus here manually enable internal clock.
>>>>>> +	 *
>>>>>> +	 * After switch completes, it is unnecessary to disable internal clock,
>>>>>> +	 * since keeping internal clock active obeys SD spec.
>>>>>> +	 */
>>>>>> +	enable_xenon_internal_clk(host);
>>>>>> +
>>>>>> +	if (priv->card_candidate) {
>>>>>
>>>>> mmc_power_up() calls __mmc_set_signal_voltage() calls
>>>>> host->ops->start_signal_voltage_switch so priv->card_candidate could be an
>>>>> invalid reference to an old card.
>>>>>
>>>>> So that's not going to work if the card changes - not only for removable
>>>>> cards but even for eMMC if init fails and retries.
>>>>>
>>>> 	As you point out, this piece of code have defects, even though it actually works on Marvell multiple platforms, unless eMMC card is removable.
>>>>
>>>> 	I can add a property to explicitly indicate eMMC type in DTS.
>>>> 	Then card_candidate access can be removed here.
>>>> 	Does it sounds more reasonable to you?
>>>
>>> Sure
>>>
>>>>
>>>>>> +		if (mmc_card_mmc(priv->card_candidate))
>>>>>> +			return xenon_emmc_signal_voltage_switch(mmc, ios);
>>>>>
>>>>> So if all you need to know is whether it is a eMMC, why can't DT tell you?
>>>>>
>>>> 	I can add an eMMC type property in DTS, to remove the card_candidate access here.
>>>>
>>>>>> +	}
>>>>>> +
>>>>>> +	return sdhci_start_signal_voltage_switch(mmc, ios);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * After determining which slot is used for SDIO,
>>>>>> + * some additional task is required.
>>>>>> + */
>>>>>> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>>>>> +{
>>>>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>>>>> +	u32 reg;
>>>>>> +	u8 slot_idx;
>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>>> +
>>>>>> +	/* Link the card for delay adjustment */
>>>>>> +	priv->card_candidate = card;
>>>>>
>>>>> You really need a better way to get the card.  I suggest you take up the
>>>>> issue with Ulf.  One possibility is to have mmc core set host->card = card
>>>>> much earlier.
>>>>>
>>>> 	Could you please tell me if any issue related to card_candidate still exists, after the card_candidate is removed from xenon_start_signal_voltage_switch() in above?
>>>> 	It seems that when init_card is called, the structure card has already been updated and stable in MMC/SD/SDIO initialization sequence.
>>>> 	May I keep it here?
>>>
>>> It works by accident rather than by design.  We can do better.
>>>
>> 	Could you please tell me some details which are satisfied about card_candidate?
>>
>> 	I must admit that card_candidate in xenon_start_signal_voltage_switch() is imperfect.
>> 	But card_candidate in init_card() and later in set_ios() work by design, rather than by accident. We did a lot of tests on several platforms.
>> 	
>> 	The structure mmc_card passed in here is a stable one. Thus in my very own opinion, it is safe and stable to use mmc_card here.
>> 	card_candidate is used only in card initialization. It is not active in later transfers after initialization is done.
>> 	It will always updated with mmc_card in next card initialization.
> 
> Ok, so maybe just add some comments and more explanation of how it works.
> 
> 
	Sure. I will add more detailed comments.
>>
>>>>
>>>>>> +	/* Set tuning functionality of this slot */
>>>>>> +	xenon_slot_tuning_setup(host);
>>>>>> +
>>>>>> +	slot_idx = priv->slot_idx;
>>>>>> +	if (!mmc_card_sdio(card)) {
>>>>>> +		/* Re-enable the Auto-CMD12 cap flag. */
>>>>>> +		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>>>>> +		host->flags |= SDHCI_AUTO_CMD12;
>>>>>> +
>>>>>> +		/* Clear SDIO Card Inserted indication */
>>>>>> +		reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>>>>>> +		reg &= ~(1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>>>>>> +		sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
>>>>>> +
>>>>>> +		if (mmc_card_mmc(card)) {
>>>>>> +			mmc->caps |= MMC_CAP_NONREMOVABLE;
>>>>>> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))
>>>>>> +				mmc->caps |= MMC_CAP_1_8V_DDR;
>>>>>> +			/*
>>>>>> +			 * Force to clear BUS_TEST to
>>>>>> +			 * skip bus_test_pre and bus_test_post
>>>>>> +			 */
>>>>>> +			mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>>>>>> +			mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
>>>>>> +				      MMC_CAP2_PACKED_CMD;
>>>>>> +			if (mmc->caps & MMC_CAP_8_BIT_DATA)
>>>>>> +				mmc->caps2 |= MMC_CAP2_HS400_1_8V;
>>>>>> +		}
>>>>>> +	} else {
>>>>>> +		/*
>>>>>> +		 * Delete the Auto-CMD12 cap flag.
>>>>>> +		 * Otherwise, when sending multi-block CMD53,
>>>>>> +		 * Driver will set Transfer Mode Register to enable Auto CMD12.
>>>>>> +		 * However, SDIO device cannot recognize CMD12.
>>>>>> +		 * Thus SDHC will time-out for waiting for CMD12 response.
>>>>>> +		 */
>>>>>> +		host->quirks &= ~SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>>>>> +		host->flags &= ~SDHCI_AUTO_CMD12;
>>>>>
>>>>> sdhci_set_transfer_mode() won't enable auto-CMD12 for CMD53 anyway, so is
>>>>> this needed?
>>>>>
>>>> 	In Xenon driver, Auto-CMD12 flag is set to enable full support to Auto-CMD feature, both Auto-CMD12 and Auto-CMD23.
>>>> 	As a result, when Xenon SDHC slot can both support SD and SDIO, Auto-CMD12 is disabled when SDIO card is inserted, and renabled when SD is inserted.
>>>>
>>>> 	I recheck the sdhci code to set Auto-CMD bit in Transfer Mode register, in sdhci_set_transfer_mode():
>>>> 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1)
>>>> 	As you can see, as long as it is CMD18/CMD25 OR there are multiple data blocks, Auto-CMD field will be set.
>>>> 	CMD53 doesn't have CMD23. Thus Auto-CMD12 is selected since Auto-CMD12 flag is set.
>>>> 	Thus I have to clear Auto-CMD12 to avoid issuing Auto-CMD12 in SDIO transfer.
>>>
>>>
>>> The code is:
>>>
>>> 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>> 		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>> 		/*
>>> 		 * If we are sending CMD23, CMD12 never gets sent
>>> 		 * on successful completion (so no Auto-CMD12).
>>> 		 */
>>> 		if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>> 		    (cmd->opcode != SD_IO_RW_EXTENDED))
>>> 			mode |= SDHCI_TRNS_AUTO_CMD12;
>>> 		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>> 			mode |= SDHCI_TRNS_AUTO_CMD23;
>>> 			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>> 		}
>>> 	}
>>>
>>> You can see the check for SD_IO_RW_EXTENDED which is CMD53.
>>>
>> 	Sorry. I didn't notice CMD53 check was added.
>> 	I introduced this Auto-CMD12 hack since kernel 3.8. It seems that this check is not added in kernel 3.8.
>> 	Thanks for the information. I will remove the Auto-CMD12 hack.
>>
>>>>
>>>> 	I just meet a similar issue in RPMB.
>>>> 	When Auto-CMD12 flag is set, eMMC RPMB access will trigger Auto-CMD12, since CMD25 is in use.
>>>> 	It will cause RPMB access failed.
>>>
>>> Can you explain more about the RPMB issue.  Doesn't it use CMD23, so CMD12
>>> wouldn't be used - auto or manually.
>>>
>> 	RPMB go through the MMC ioctl routine.
>> 	Unlike normal data transfer, MMC ioctl for RPMB explicitly issues CMD23. When CMD25 is issued, there is neither data->sbc nor Auto-CMD23.
>> 	As a result, sdhci driver will automatically enable Auto-CMD12 for RPMB CMD25 if Auto-CMD12 flag is set.
> 
> OK, so SDHCI should also not allow auto-cmd12 if there is no stop command
> i.e. data->stop is null.
> 
	data->stop and cmd->stop are forced to be NULL if Auto-CMD12 is enabled.
	Instead, currently I use cmd->arg to check if it is a RPMB CMD25. If CMD25 argument is NULL, it should be RPMB access.
	But I only verified it on Marvell platform. Please help check it when later I propose the formal patch.
	
>>
>>>>
>>>> 	One possible solution is to drop Auto-CMD12 support and use Auto-CMD23 only, in Xenon driver.
>>>> 	May I know you opinion, please?
>>>
>>> I don't use auto-CMD12 because I don't know if it provides any benefit and
>>> sdhci does not seem to have implemented Auto CMD12 Error Recovery, although
>>> I have never looked at it closely.
>>>
>> 	Actually, Auto-CMD23 is always used on our Xenon. Auto-CMD12 is not used at all.
>> 	But since this driver is a general one for all Marvell products, Auto-CMD12 is also supported in case that Auto-CMD23 is not available.
>>  
>>
> 
