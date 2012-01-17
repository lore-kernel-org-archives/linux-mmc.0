From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: change mmc_delay() to use usleep_range()
Date: Tue, 17 Jan 2012 09:46:40 +0200
Message-ID: <4F152760.3080004@intel.com>
References: <1326696200-514-1-git-send-email-dmitry.antipov@linaro.org> <4F152347.1060703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57262 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab2AQHqj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jan 2012 02:46:39 -0500
In-Reply-To: <4F152347.1060703@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Antipov <dmitry.antipov@linaro.org>, Chris Ball <cjb@laptop.org>, patches@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 17/01/12 09:29, Adrian Hunter wrote:
> On 16/01/12 08:43, Dmitry Antipov wrote:
>> Use the usleep_range() to simplify mmc_delay() and give some more
>> accuracy to it - but with an exception of mmc_card_sleepawake():
>> for the hosts with very small (<100us) sleep/awake timeout, it's
>> value is rounded up to 100us so usleep_range() always makes sense.
>> ---
>>  drivers/mmc/core/core.h    |    8 ++------
>>  drivers/mmc/core/mmc_ops.c |    9 ++++++---
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 3bdafbc..fbd2cba 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -48,12 +48,8 @@ void mmc_power_off(struct mmc_host *host);
>>  
>>  static inline void mmc_delay(unsigned int ms)
>>  {
>> -	if (ms < 1000 / HZ) {
>> -		cond_resched();
>> -		mdelay(ms);
>> -	} else {
>> -		msleep(ms);
>> -	}
>> +	unsigned long us = ms * USEC_PER_MSEC;

A blank line here would be nice

>> +	usleep_range(us, us + 1000);
>>  }
>>  
>>  void mmc_rescan(struct work_struct *work);
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 4d41fa9..457443a 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -82,9 +82,12 @@ int mmc_card_sleepawake(struct mmc_host *host, int sleep)
>>  	 * SEND_STATUS command to poll the status because that command (and most
>>  	 * others) is invalid while the card sleeps.
>>  	 */
>> -	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>> -		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
>> -
>> +	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY)) {
>> +		/* JEDEC MMCA 4.41 specifies the timeout value is in 200ns..838.86ms
>> +		   range, which is rounded it up to 100us here. */
>> +		unsigned long us = DIV_ROUND_UP(card->ext_csd.sa_timeout, 1000);
> 
> The divisor has changed from 10000 to 1000 but the change is from ms to us,
> so it ought to be 3 zeros different - unless it is a bug fix (which should
> be a separate patch)?
> 

In fact, why not just drop this part of the patch and leave it as mmc_delay?

>> +		usleep_range(us, us + 100);
>> +	}
>>  	if (!sleep)
>>  		err = mmc_select_card(card);
>>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

