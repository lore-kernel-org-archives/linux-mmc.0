From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH] mmc: dw_mmc: remove redundant num_slots check
Date: Fri, 22 Jan 2016 11:07:10 +0800
Message-ID: <56A19CDE.3090401@rock-chips.com>
References: <1453362769-16223-1-git-send-email-shawn.lin@rock-chips.com>
 <56A19811.9000101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:46271 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbcAVDHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 22:07:31 -0500
In-Reply-To: <56A19811.9000101@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/1/22 10:46, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 01/21/2016 04:52 PM, Shawn Lin wrote:
>> num_slots comes from pdata if existing, otherwise from
>> dw_mci_parse_dt which make it at least one slot. If
>> num_slots is less than 1 for the existing pdata case,
>> current code return -ENODEV. But dw_mci_probe seems to
>> treat this a optional case as it will call SDMMC_GET_SLOT_NUM
>> if no slot assigned.
>
> Well, we need to consider more thing..
> Host can get the number of slot from SDMMC_GET_SLOT_NUM().
> But i think this way also has the problem.
>
> num_slot isn't defined anywhere, and num_slot should be set to value of SDMMC_GET_SLOT_NUM.
> If that value is higher than 1, it should be blocking..(I didn't test all cases..)
>

Actually, from the code itself, it confused me the way about how we get
num_slot. At leaset, we might should try to cleanup it someway to make
it a little more clear. And just as what you point out, we see some
broblem here.

> Even though this patch is not correct, i could check the problem relevant to num_slot, because of this patch. :)
>

Nice to here that. I make it a RFC patch since I also not quite sure
about all cases including some corner cases. Let's think it twice.

> my suggestion is if pdata->num_slot is not defined anywhere, just set to 1 by default.
> not take from SDMMC_GET_SLOT_NUM.
>

yes, SDMMC_GET_SLOT_NUM is the capability of controller, num_slot is
hardware wired number. So, geting it from SDMMC_GET_SLOT_NUM has
problem.

> if (host->pdata->nums_slots < 1 ||
> 	host->pdata->nums_slots > SDMMC_GET_SLOT_NUM())
>
> This is correct condition. num_slots can't be higher than number of supported slots.
> how about?

Seems reasonable.
I guess you want to come up with a new patch dealing with it? :)

>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 7128351..a116ec6 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2949,12 +2949,6 @@ int dw_mci_probe(struct dw_mci *host)
>>   		}
>>   	}
>>
>> -	if (host->pdata->num_slots < 1) {
>> -		dev_err(host->dev,
>> -			"Platform data must supply num_slots.\n");
>> -		return -ENODEV;
>> -	}
>> -
>>   	host->biu_clk = devm_clk_get(host->dev, "biu");
>>   	if (IS_ERR(host->biu_clk)) {
>>   		dev_dbg(host->dev, "biu clock not available\n");
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

