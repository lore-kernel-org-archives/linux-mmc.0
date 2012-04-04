From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: card: move variable initialization earlier
Date: Wed, 04 Apr 2012 09:20:02 +0300
Message-ID: <4F7BE812.50403@intel.com>
References: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org> <8762dkm6wc.fsf@laptop.org> <4F7AB768.8020702@intel.com> <26E7A31274623843B0E8CF86148BFE326FB57128@NTXAVZMBX04.azit.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19482 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab2DDGTv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Apr 2012 02:19:51 -0400
In-Reply-To: <26E7A31274623843B0E8CF86148BFE326FB57128@NTXAVZMBX04.azit.micron.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Rabin Vincent <rabin@rab.in>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 03/04/12 19:55, Luca Porzio (lporzio) wrote:
> Hi Adrian,
> 
>> The sanitize logic looks wrong to me.  I would expect it to look
>> like this:
>>
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index b180965..f5e0534 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -881,17 +881,12 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue
>> *mq,
>>  		goto out;
>>  	}
>>
>> -	/* The sanitize operation is supported at v4.5 only */
>> -	if (mmc_can_sanitize(card)) {
>> -		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> -				EXT_CSD_SANITIZE_START, 1, 0);
>> -		goto out;
>> -	}
>> -
>>  	from = blk_rq_pos(req);
>>  	nr = blk_rq_sectors(req);
>>
>> -	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
>> +	if (mmc_can_sanitize(card))
>> +		arg = MMC_DISCARD_ARG;
> 
> The sanitize and discard are not coupled functionalities.
> Discard is a hint for performance meant to replace trim and erase 
> where performance matters.
> Sanitize is a security operation meant to clear all unmapped contents.
> Jedec 4.5 spec does not guarantee that a discarded sector will be sanitized.

True, it is a bit vague on that point, although you might infer it from:

	The Sanitize operation is a feature, in addition to TRIM and Erase
	that is used to remove data from the device.

which does not mention Discard.

Presumably, some cards do make the guarantee e.g. Samsung since they
submitted the original Discard/Sanitize patches.

> This patch, if applied, will expose the kernel to a potential security 
> risk (retrieve old contents not wiped by a sanitize)

Well, the kernel is already exposed.  Current code does not even do a
Discard if Sanitize is supported.

> 
>> +	else if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
>>  		arg = MMC_SECURE_TRIM1_ARG;
>>  	else
>>  		arg = MMC_SECURE_ERASE_ARG;
>> @@ -918,6 +913,12 @@ retry:
>>  		}
>>  		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
>>  	}
>> +
>> +	/* The sanitize operation is supported at v4.5 only */
>> +	if (!err && mmc_can_sanitize(card)) {
>> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +				EXT_CSD_SANITIZE_START, 1, 0);
>> +	}
>>  out:
>>  	if (err == -EIO && !mmc_blk_reset(md, card->host, type))
>>  		goto retry;
>>
>>
>>
>> Also the timeout for eMMC v4.5 DISCARD looks wrong.  It should be
>> the same as TRIM:
>>
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 14f262e..00fd7db 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1407,7 +1407,7 @@ static unsigned int mmc_mmc_erase_timeout(struct
>> mmc_card *card,
>>
>>  	if (card->ext_csd.erase_group_def & 1) {
>>  		/* High Capacity Erase Group Size uses HC timeouts */
>> -		if (arg == MMC_TRIM_ARG)
>> +		if (arg == MMC_TRIM_ARG || arg == MMC_DISCARD_ARG)
>>  			erase_timeout = card->ext_csd.trim_timeout;
>>  		else
>>  			erase_timeout = card->ext_csd.hc_erase_timeout;
>>
>>
> 
> Although I suspect that the discard cmd will be much faster than the
> Trim on most devices, there is no such info available as of today in ext csd.
> As such I agree with Adrian, discard timeout is nearer to trim than erase.
>  
>>
>> In addition eMMC v4.5 seems to indicate the use of the trim timeout
>> irrespective of the setting of erase_group_def, so maybe it should be
>> like this:
>>
>>
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 14f262e..4691a23 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1405,7 +1405,10 @@ static unsigned int mmc_mmc_erase_timeout(struct
>> mmc_card *card,
>>  {
>>  	unsigned int erase_timeout;
>>
>> -	if (card->ext_csd.erase_group_def & 1) {
>> +	if (arg == MMC_DISCARD_ARG ||
>> +	    (arg == MMC_TRIM_ARG && card->ext_csd.rev >= 6)) {
>> +		erase_timeout = card->ext_csd.trim_timeout;
>> +	} else if (card->ext_csd.erase_group_def & 1) {
>>  		/* High Capacity Erase Group Size uses HC timeouts */
>>  		if (arg == MMC_TRIM_ARG)
>>  			erase_timeout = card->ext_csd.trim_timeout;
>>
>>
>>
>>
>> Alternatively, maybe it would be better to switch to HC erase size for all
>> eMMC v4.5 cards?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

