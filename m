From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix setting power notify state variable for non eMMC
Date: Fri, 11 Nov 2011 22:12:26 -0500
Message-ID: <87fwhuhw4l.fsf@laptop.org>
References: <1320403967-2940-1-git-send-email-girish.shivananjappa@linaro.org>
	<4EBD23FC.3070203@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4EBD23FC.3070203@stericsson.com> (Ulf Hansson's message of "Fri,
	11 Nov 2011 14:32:44 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 11 2011, Ulf Hansson wrote:
> Girish K S wrote:
>> This patch skips the setting of the power notify state variable
>> for non eMMC 4.5 devices. Also fixes the problem of omap_hsmmc
>> noisy/broken for suspend resume reported by kevin Hilman.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>>  drivers/mmc/core/mmc.c |   10 +++++++---
>>  1 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 3627044..4db73a9 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -882,10 +882,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>  				 card->ext_csd.generic_cmd6_time);
>>  		if (err && err != -EBADMSG)
>>  			goto free_card;
>> -	}
>>  -	if (!err)
>> -		card->poweroff_notify_state = MMC_POWERED_ON;
>> +		/*
>> +		 * The err can be -EBADMSG or 0,
>> +		 * so check for success and update the flag
>> +		 */
>> +		if (!err)
>> +			card->poweroff_notify_state = MMC_POWERED_ON;
>> +	}
>>   	/*
>>  	 * Activate high speed (if supported)
>
>
> I encountered similar problems as for omap_hsmmc for the mmci driver
> (although with some ST-Ericsson internal pm_runtime patches). This
> patch fixed the problem. Great!
>
> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
