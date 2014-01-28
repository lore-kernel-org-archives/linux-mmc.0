From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/8] mmc: dw_mmc: replace the bus_hz checking point
Date: Wed, 29 Jan 2014 08:54:40 +0900
Message-ID: <52E84340.6050505@samsung.com>
References: <52E76956.1090107@samsung.com>
 <000701cf1c28$1cf0b3c0$56d21b40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54386 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaA1XyM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 18:54:12 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0400DZJYE9ND40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Jan 2014 08:54:09 +0900 (KST)
In-reply-to: <000701cf1c28$1cf0b3c0$56d21b40$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>

Hi Seungwon,

Thanks for review.

On 01/28/2014 09:54 PM, Seungwon Jeon wrote:
> On Tue, January 28, 2014, Jaehoon Chung wrote:
>> It's right that check immediately whether host->bus_hz is assigned or not.
>> If drv_data->setup_clock is presented, then host->bus_hz should be set at there.
>> When setup_clock didn't present, assigned to value with clk_get_rate().
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>> 	- When drv_data->setup_clock is present, set to bus_hz with it.
>>
>>  drivers/mmc/host/dw_mmc.c |   39 +++++++++++++++++++--------------------
>>  1 file changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 8193e21..ead2998 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2427,10 +2427,27 @@ int dw_mci_probe(struct dw_mci *host)
>>  			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
>>  			if (ret)
>>  				dev_warn(host->dev,
>> -					 "Unable to set bus rate to %ul\n",
>> +					 "Unable to set bus rate to %uHz\n",
>>  					 host->pdata->bus_hz);
>>  		}
>> -		host->bus_hz = clk_get_rate(host->ciu_clk);
>> +
>> +		if (drv_data && drv_data->setup_clock) {
>> +			ret = drv_data->setup_clock(host);
>> +			if (ret) {
>> +				dev_err(host->dev, "implementation specific \"
>> +					"clock setup failed\n");
>> +				goto err_clk_ciu;
>> +			}
>> +		} else {
>> +			host->bus_hz = clk_get_rate(host->ciu_clk);
> host->bus_hz certainly should be touched at drv_data->setup_clock()?
> I think origin would be better.
> The others is good to me.

I understood what you mean. Maybe We can change the code at dw_mmc-exynos.c.
It's refered to host->ci_clk at dw_mmc-exynos.c.
But If ciu_clk didn't assign, clk's rate didn't get.
How about this? host->bus_hz was already assigned in dw_mmc.c.

--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -117,9 +117,8 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned long rate = clk_get_rate(host->ciu_clk);
 
-	host->bus_hz = rate / (priv->ciu_div + 1);
+	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
Best Regards,
Jaehoon Chung

> 
> Thanks,
> Seungwon Jeon
> 
>> +		}
>> +	}
>> +
>> +	if (!host->bus_hz) {
>> +		dev_err(host->dev,
>> +			"Platform data must supply bus speed\n");
>> +		ret = -ENODEV;
>> +		goto err_clk_ciu;
>>  	}
>>
>>  	if (drv_data && drv_data->init) {
>> @@ -2442,15 +2459,6 @@ int dw_mci_probe(struct dw_mci *host)
>>  		}
>>  	}
>>
>> -	if (drv_data && drv_data->setup_clock) {
>> -		ret = drv_data->setup_clock(host);
>> -		if (ret) {
>> -			dev_err(host->dev,
>> -				"implementation specific clock setup failed\n");
>> -			goto err_clk_ciu;
>> -		}
>> -	}
>> -
>>  	host->vmmc = devm_regulator_get_optional(host->dev, "vmmc");
>>  	if (IS_ERR(host->vmmc)) {
>>  		ret = PTR_ERR(host->vmmc);
>> @@ -2469,13 +2477,6 @@ int dw_mci_probe(struct dw_mci *host)
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
>> @@ -2619,8 +2620,6 @@ err_workqueue:
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

