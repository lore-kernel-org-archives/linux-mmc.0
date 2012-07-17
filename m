From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v10] mmc: support BKOPS feature for eMMC
Date: Tue, 17 Jul 2012 21:58:30 +0900
Message-ID: <50056176.5010502@samsung.com>
References: <5004D176.7090306@samsung.com> <50055AED.4000709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35114 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2GQM6t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 08:58:49 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7B004052PVTFT0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Jul 2012 21:58:48 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7B004ZN2PZ4540@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Jul 2012 21:58:48 +0900 (KST)
In-reply-to: <50055AED.4000709@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 07/17/2012 09:30 PM, Adrian Hunter wrote:
> On 17/07/12 05:44, Jaehoon Chung wrote:
> 
> <snip>
> 
>> +/**
>> + *	mmc_start_bkops - start BKOPS for supported cards
>> + *	@card: MMC card to start BKOPS
>> + *
>> + *	Start background operations whenever requested.
>> + *	when the urgent BKOPS bit is set in a R1 command response
>> + *	then background operations should be started immediately.
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> +	int err;
>> +	int timeout;
>> +	u8 use_busy_signal;
>> +
>> +	BUG_ON(!card);
>> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
>> +		return;
>> +
>> +	if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
>> +		if (card->ext_csd.raw_bkops_status)
>> +			mmc_card_set_need_bkops(card);
>> +
>> +	/*
>> +	 * If card is already doing bkops or need for
>> +	 * bkops flag is not set, then do nothing just
>> +	 * return
>> +	 */
>> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
>> +		return;
>> +
>> +	mmc_claim_host(card->host);
>> +	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
>> +		timeout = MMC_BKOPS_MAX_TIMEOUT;
>> +		use_busy_signal = 0;
>> +	} else {
>> +		timeout = 0;
>> +		use_busy_signal = 1;
>> +	}
> 
> Is this the right way around?

use the mmc_switch() with R1B..
this case is no problem, because after sending bkops, repeat the checking card status until prg-done.
But, at sdhci controller, be occurred data timeout error.
Because response type is r1b, and timeout value is too large.
(Actually, i think that is controller's problem..but just its my test environment.)

if other sdhci controller working well with R1b, use_busy_signal need not.
Just use the mmc_switch().

But When running bkops level2/3 use with R1 type, also no problem.
Because the also checking status in mmc_switch() until prg-done.

Best Regards,
Jaehoon Chung

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


