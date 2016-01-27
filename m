From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 07/21] mmc: sdhci-pxav3: consolidate parsing path
Date: Wed, 27 Jan 2016 14:17:11 +0800
Message-ID: <56A860E7.4070503@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <1453871256-3599-1-git-send-email-shawn.lin@rock-chips.com>
 <20160127134449.310bc952@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:47118 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcA0GRn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 01:17:43 -0500
In-Reply-To: <20160127134449.310bc952@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi Jisheng,

On 2016/1/27 13:44, Jisheng Zhang wrote:
> Hi Shawn,
>
> On Wed, 27 Jan 2016 13:07:36 +0800 Shawn Lin wrote:
>
>> This patch remove mmc_of_parse and check return value
>> of sdhci_get_of_property.
>>
>> Cc: Jisheng Zhang <jszhang@marvell.com>
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Reviewed-by: Jisheng Zhang <jszhang@marvell.com>
>
>
> But I have some comments to your patch10:
>
>> SDHCI_QUIRK_BROKEN_CARD_DETECTION is for "broken-cd".
>> If we add MMC_CAP_NONREMOVABLE("non-removeble"), we shoud
>> not add "broken-cd" together according to mmc.txt for
>> dt-bingdings. Also, "broken-cd" can obtain from mmc_of_parse,
>> which will add MMC_CAP_NEEDS_POLL into mmc->caps.
>
> The problem is non-dt platforms which need the broken cd quirk don't have
> chance to set MMC_CAP_NEEDS_POLL in driver, unless we explicitly do so
> in driver. But then, the driver only need to do so on some platforms but
> not always.
>

Thanks for sharing your thought. That is indeed a historical baggage
to improve sdhci. So, it needs to check each platform case by case.
Let's wait more feedback untile I decide how to respin the patchset. :)

> Thanks,
> Jisheng
>
>
>> ---
>>
>>   drivers/mmc/host/sdhci-pxav3.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index f5edf9d..06eda25 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -410,10 +410,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>   	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>>   	if (match) {
>> -		ret = mmc_of_parse(host->mmc);
>> -		if (ret)
>> +		ret = sdhci_get_of_property(pdev);
>>   			goto err_of_parse;
>> -		sdhci_get_of_property(pdev);
>>   		pdata = pxav3_get_mmc_pdata(dev);
>>   		pdev->dev.platform_data = pdata;
>>   	} else if (pdata) {
>
>
>
>


-- 
Best Regards
Shawn Lin

