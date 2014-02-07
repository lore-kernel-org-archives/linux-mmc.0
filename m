From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 3/8] mmc: dw_mmc: replace the bus_hz checking point
Date: Fri, 07 Feb 2014 11:44:51 +0900
Message-ID: <52F448A3.7070302@samsung.com>
References: <52EF7B6A.6040901@samsung.com>
 <002701cf232d$c04aecf0$40e0c6d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27251 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaBGCou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 21:44:50 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0L00JEXUAOU830@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Feb 2014 11:44:48 +0900 (KST)
In-reply-to: <002701cf232d$c04aecf0$40e0c6d0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>

Dear Seungwon,

On 02/06/2014 08:22 PM, Seungwon Jeon wrote:
> Hi Jaehoon,
> 
> Please check minor thing below.
> 
> On Mon, February 03, 2014, Jaehoon Chung wrote:
>> It's right that check immediately whether host->bus_hz is assigned or not.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V3:
>> 	- Maintained original place for the drv_data->setup_clock
>> Changelog V2:
>> 	- When drv_data->setup_clock is present, set to bus_hz with it.
>>
>>  drivers/mmc/host/dw_mmc.c |   22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 8193e21..e7357b8 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2427,12 +2427,19 @@ int dw_mci_probe(struct dw_mci *host)
>>  			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
>>  			if (ret)
>>  				dev_warn(host->dev,
>> -					 "Unable to set bus rate to %ul\n",
>> +					 "Unable to set bus rate to %uHz\n",
>>  					 host->pdata->bus_hz);
>>  		}
>>  		host->bus_hz = clk_get_rate(host->ciu_clk);
>>  	}
>>
>> +	if (!host->bus_hz) {
>> +		dev_err(host->dev,
>> +			"Platform data must supply bus speed\n");
>> +		ret = -ENODEV;
>> +		goto err_clk_ciu;
>> +	}
>> +
>>  	if (drv_data && drv_data->init) {
>>  		ret = drv_data->init(host);
>>  		if (ret) {
>> @@ -2445,8 +2452,8 @@ int dw_mci_probe(struct dw_mci *host)
>>  	if (drv_data && drv_data->setup_clock) {
>>  		ret = drv_data->setup_clock(host);
>>  		if (ret) {
>> -			dev_err(host->dev,
>> -				"implementation specific clock setup failed\n");
>> +			dev_err(host->dev, "implementation specific "
>> +				"clock setup failed\n");
> Rather, this change makes cherry-pick warning.
> Keep it.

Check it.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
>>  			goto err_clk_ciu;
>>  		}
>>  	}
>> @@ -2469,13 +2476,6 @@ int dw_mci_probe(struct dw_mci *host)
>>  		}
>>  	}
>>
>> -	if (!host->bus_hz) {
>> -		dev_err(host->dev,
>> -			"Platform data must supply bus speed\n");
>> -		ret = -ENODEV;
>> -		goto err_regulator;
>> -	}
>> -
>>  	host->quirks = host->pdata->quirks;
>>
>>  	spin_lock_init(&host->lock);
>> @@ -2619,8 +2619,6 @@ err_workqueue:
>>  err_dmaunmap:
>>  	if (host->use_dma && host->dma_ops->exit)
>>  		host->dma_ops->exit(host);
>> -
>> -err_regulator:
>>  	if (host->vmmc)
>>  		regulator_disable(host->vmmc);
>>
>> --
>> 1.7.9.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

