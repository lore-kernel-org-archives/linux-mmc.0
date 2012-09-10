From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH] mmc: mxs-mmc: implement broken-cd
Date: Mon, 10 Sep 2012 13:04:00 +0300
Message-ID: <504DBB10.9030702@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com> <20120910060840.GT26709@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:1999 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab2IJKEE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Sep 2012 06:04:04 -0400
In-Reply-To: <20120910060840.GT26709@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, veli-pekka.peltola@bluegiga.com

Hi Shawn,

On 09/10/2012 09:08 AM, Shawn Guo wrote:
> On Fri, Sep 07, 2012 at 02:45:17PM +0300, Lauri Hintsala wrote:
>> This feature allows to use SDIO bus without wiring card detect
>> signal.
>
> This looks like a case of "broken-cd" ...
>
>> This is relevant in cases where SDIO device is connected to
>> SDIO bus and there is no way to disconnect device from bus (device
>> is always present).
>>
> ... while this sounds like a case of "non-removable".

Right, I'll remove this comment.

In our case the SDIO device is always physically connected to SDIO bus 
but the power of the device can be controller. So in SW point of view 
the device can be removed by switching the power off.


>> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
>> ---
>>   drivers/mmc/host/mxs-mmc.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
>> index ad3fcea..992760e 100644
>> --- a/drivers/mmc/host/mxs-mmc.c
>> +++ b/drivers/mmc/host/mxs-mmc.c
>> @@ -165,6 +165,7 @@ struct mxs_mmc_host {
>>   	int				sdio_irq_en;
>>   	int				wp_gpio;
>>   	bool				wp_inverted;
>> +	bool				broken_cd;
>>   };
>>
>>   static int mxs_mmc_get_ro(struct mmc_host *mmc)
>> @@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>   {
>>   	struct mxs_mmc_host *host = mmc_priv(mmc);
>>
>> +	if (host->broken_cd)
>> +		return -ENOSYS;
>> +
>
> The .get_cd caller does not check for error.  This change makes no
> sense to me.

In our case we don't want to read card detect bit and we have to 
continue MMC probing because card detect pin is routed nowhere.

Could it be better to return zero instead of error? ENOSYS is used to 
indicate "unreachable card detect" in other drivers (e.g. atmel-mci, 
omap_hsmmc) and I followed them.


> Instead, the driver needs to set MMC_CAP_NEEDS_POLL in
> case of "broken-cd".

MMC_CAP_NEEDS_POLL is always set in mxs-mmc.


Best regards,
Lauri


>
> Regards,
> Shawn
>
>>   	return !(readl(host->base + HW_SSP_STATUS(host)) &
>>   		 BM_SSP_STATUS_CARD_DETECT);
>>   }
>> @@ -808,6 +812,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>>   							&flags);
>>   		if (flags & OF_GPIO_ACTIVE_LOW)
>>   			host->wp_inverted = 1;
>> +
>> +		if (of_get_property(np, "broken-cd", NULL))
>> +			host->broken_cd = 1;
>>   	} else {
>>   		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>>   			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>> --
>> 1.7.9.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
