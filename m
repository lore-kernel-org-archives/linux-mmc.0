From: merez@codeaurora.org
Subject: Re: [PATCH v10] mmc: support BKOPS feature for eMMC
Date: Tue, 17 Jul 2012 23:31:36 -0700 (PDT)
Message-ID: <66ba92a0b384c7ce5c84df6a9c374bc1.squirrel@www.codeaurora.org>
References: <5004D176.7090306@samsung.com> <50055AED.4000709@intel.com>
    <50056176.5010502@samsung.com> <500654A7.8010501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:1937 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2GRGbh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 02:31:37 -0400
In-Reply-To: <500654A7.8010501@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>


On Tue, July 17, 2012 11:16 pm, Adrian Hunter wrote:
> On 17/07/12 15:58, Jaehoon Chung wrote:
>> On 07/17/2012 09:30 PM, Adrian Hunter wrote:
>>> On 17/07/12 05:44, Jaehoon Chung wrote:
>>>
>>> <snip>
>>>
>>>> +/**
>>>> + *	mmc_start_bkops - start BKOPS for supported cards
>>>> + *	@card: MMC card to start BKOPS
>>>> + *
>>>> + *	Start background operations whenever requested.
>>>> + *	when the urgent BKOPS bit is set in a R1 command response
>>>> + *	then background operations should be started immediately.
>>>> +*/
>>>> +void mmc_start_bkops(struct mmc_card *card)
>>>> +{
>>>> +	int err;
>>>> +	int timeout;
>>>> +	u8 use_busy_signal;
>>>> +
>>>> +	BUG_ON(!card);
>>>> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 &
>>>> MMC_CAP2_BKOPS))
>>>> +		return;
>>>> +
>>>> +	if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
>>>> +		if (card->ext_csd.raw_bkops_status)
>>>> +			mmc_card_set_need_bkops(card);
>>>> +
>>>> +	/*
>>>> +	 * If card is already doing bkops or need for
>>>> +	 * bkops flag is not set, then do nothing just
>>>> +	 * return
>>>> +	 */
>>>> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
>>>> +		return;
>>>> +
>>>> +	mmc_claim_host(card->host);
>>>> +	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
>>>> +		timeout = MMC_BKOPS_MAX_TIMEOUT;
>>>> +		use_busy_signal = 0;
>>>> +	} else {
>>>> +		timeout = 0;
>>>> +		use_busy_signal = 1;
>>>> +	}
>>>
>>> Is this the right way around?
>>
>> use the mmc_switch() with R1B..
>> this case is no problem, because after sending bkops, repeat the
>> checking card status until prg-done.
>> But, at sdhci controller, be occurred data timeout error.
>> Because response type is r1b, and timeout value is too large.
>> (Actually, i think that is controller's problem..but just its my test
>> environment.)
>>
>> if other sdhci controller working well with R1b, use_busy_signal need
>> not.
>> Just use the mmc_switch().
>>
>> But When running bkops level2/3 use with R1 type, also no problem.
>> Because the also checking status in mmc_switch() until prg-done.
>
> You added:
>
> +	/*
> +	 * For urgent bkops status (LEVEL_2 and more)
> +	 * bkops executed synchronously, otherwise
> +	 * the operation is in progress
> +	 */
> +	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
> +		mmc_card_set_doing_bkops(card);
>
> But:
> 	status < 2		=> use_busy_signal = 1
> 	use_busy_signal = 1	=> waiting
> 	waiting			=> the operation is NOT in progress
>
> Hence my question: Is this the right way around?

Good catch.
in mmc_start_bkops, use_busy_signal should be set to 1 in case
card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2

>
> Also this change is needed for the addition of 'use_busy_signal' to
> mmc_switch:
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index baf90e0..e202a5e 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -417,7 +417,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>                 err = mmc_send_status(card, &status);
>                 if (err)
>                         return err;
> -               if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> +               if (use_busy_signal && (card->host->caps &
> MMC_CAP_WAIT_WHILE_BUSY))
>                         break;
>                 if (mmc_host_is_spi(card->host))
>                         break;
>
>


-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

