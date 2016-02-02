From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix num_slots setting
Date: Tue, 2 Feb 2016 14:02:41 +0800
Message-ID: <56B04681.9050801@rock-chips.com>
References: <1453448584-9854-1-git-send-email-shawn.lin@rock-chips.com>
 <56B033BE.5040102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:49779 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcBBGCt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 01:02:49 -0500
In-Reply-To: <56B033BE.5040102@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jaehoon,

On 2016/2/2 12:42, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 01/22/2016 04:43 PM, Shawn Lin wrote:
>> This patch make num_slots to 1 if pdata->num_slot is not
>> defined. Meanwhile, we need to make sure num_slots should
>> not larger that the supported slots
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 7128351..065a8f5 100644
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
>> @@ -3111,7 +3105,15 @@ int dw_mci_probe(struct dw_mci *host)
>>   	if (host->pdata->num_slots)
>>   		host->num_slots = host->pdata->num_slots;
>>   	else
>> -		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
>> +		host->num_slots = 1;
>
> If host->nums_slots is set to 1, it assumes that there is one slot.
> Then the code in dw_mci_parse_dt() can be removed
>
>                  dev_info(dev,
>                           "num-slots property not found, assuming 1 slot is available\n");
>                  pdata->num_slots = 1;
>

Good catch. I will respin v2 to move it.

Thanks.
>
> Best Regards,
> Jaehoon Chung
>
>
>> +
>> +	if (host->num_slots < 1 ||
>> +	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
>> +		dev_err(host->dev,
>> +			"Platform data must supply correct num_slots.\n");
>> +		ret = -ENODEV;
>> +		goto err_clk_ciu;
>> +	}
>>
>>   	/*
>>   	 * Enable interrupts for command done, data over, data empty,
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

