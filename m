From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH]mmc: core: not to --qty when calculate timeout for SECURE_ERASE
Date: Mon, 21 May 2012 14:27:47 +0300
Message-ID: <4FBA26B3.8020704@intel.com>
References: <20120413041934.GA30513@intel.com> <4FBA217D.4020402@intel.com> <17296D9F8FF2234F831FC3DF505A87A90FE598D3@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10481 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab2EUL1Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 May 2012 07:27:25 -0400
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A90FE598D3@SHSMSX102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>

On 21/05/12 14:19, Dong, Chuanxiao wrote:
> 
> 
>> -----Original Message-----
>> From: Hunter, Adrian
>> Sent: Monday, May 21, 2012 7:06 PM
>> To: Dong, Chuanxiao
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org
>> Subject: Re: [PATCH]mmc: core: not to --qty when calculate timeout for
>> SECURE_ERASE
>>
>> On 13/04/12 07:19, Chuanxiao Dong wrote:
>>> --qty when calculating erase timeout for trim/erase & secure
>>> trim/erase can prevent the erase range crossing qty+1 erase groups,
>>> which made the final timeout value is too large for the host.
>>>
>>> When operate SECURE_ERASE, driver needs the erase range is aligned
>>> with erase size, otherwise do nothing and return an error. That is to
>>> say it is not necessary for SECURE_ERASE to --qty since it will never
>>> cross an erase group.
>>>
>>> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>>> ---
>>>  drivers/mmc/core/core.c |    9 ++++++++-
>>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>>> e541efb..b5a393a 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1761,7 +1761,7 @@ static unsigned int mmc_do_calc_max_discard(struct
>> mmc_card *card,
>>>  	if (!qty)
>>>  		return 0;
>>>
>>> -	if (qty == 1)
>>> +	if (qty == 1 && arg != MMC_SECURE_ERASE_ARG)
>>>  		return 1;
>>
>> arg is never MMC_SECURE_ERASE_ARG
>>
>>>
>>>  	/* Convert qty to sectors */
>>> @@ -1772,6 +1772,13 @@ static unsigned int mmc_do_calc_max_discard(struct
>> mmc_card *card,
>>>  	else
>>>  		max_discard = --qty * card->erase_size;
>>>
>>> +	/*
>>> +	 * since SECURE_ERASE is erase group aligned, otherwise
>>> +	 * it cannot be erased in secure purpose, needn't --qty
>>> +	 */
>>> +	if (arg == MMC_SECURE_ERASE_ARG)
>>> +		max_discard += card->erase_size;
>>> +
>>>  	return max_discard;
>>>  }
>>>
>>
>> What about:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Mon, 21 May 2012 13:32:42 +0300
>> Subject: [PATCH] mmc: core: fix max_discard calculation
>>
>> The maximum discard calculation was unnecessarily pessimistic in the case of
>> erasing entire erase groups.  In that case, the quantity does not need to be
>> decreased by 1 to allow for misalignment because the erasure is always aligned to
>> whole erase groups.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/core.c |   22 +++++++++++++++++-----
>>  1 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 0b6141d..36bfdce 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1742,7 +1742,7 @@ static unsigned int mmc_do_calc_max_discard(struct
>> mmc_card *card,  {
>>  	struct mmc_host *host = card->host;
>>  	unsigned int max_discard, x, y, qty = 0, max_qty, timeout;
>> -	unsigned int last_timeout = 0;
>> +	unsigned int last_timeout = 0, aligned_qty;
>>
>>  	if (card->erase_shift)
>>  		max_qty = UINT_MAX >> card->erase_shift; @@ -1769,16 +1769,28 @@
>> static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>>  	if (!qty)
>>  		return 0;
>>
>> -	if (qty == 1)
>> -		return 1;
>> +	if (arg & MMC_TRIM_ARGS) {
>> +		/*
>> +		 * The requested number of sectors may not be aligned to an
>> +		 * erase group, so we have to decrease the quantity by 1 (unless
>> +		 * it is 1) e.g. trimming 2 sectors could cause 2 erase groups
>> +		 * to be affected even though 2 sectors is less than the size of
>> +		 * 1 erase group.
>> +		 */
>> +		if (qty == 1)
>> +			return 1;
>> +		aligned_qty = qty - 1;
>> +	} else {
>> +		aligned_qty = qty;
>> +	}
>>
>>  	/* Convert qty to sectors */
>>  	if (card->erase_shift)
>> -		max_discard = --qty << card->erase_shift;
>> +		max_discard = aligned_qty << card->erase_shift;
>>  	else if (mmc_card_sd(card))
>>  		max_discard = qty;
>>  	else
>> -		max_discard = --qty * card->erase_size;
>> +		max_discard = aligned_qty * card->erase_size;
>>
>>  	return max_discard;
>>  }
> 
> Hi Hunter,
> Your patch looks good to me.
> 
> Since you also mentioned that the arg will never be MMC_SECURE_ERASE_ARG, I want to know why not calculate erase size for secure trim/erase operations? As specification said, secure trim/erase operations has different timeout value with trim/erase.

There are 2 problems.  First, there is only 1 value for maximum discard
whether secure or not.  Secondly, the timeout for secure erase can be so
great that any quantity exceeds the maximum timeout.

> 
> Thanks
> Chuanxiao
> 
> 

