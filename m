From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: remove unnecessary/dupulicated code
Date: Mon, 05 Dec 2011 13:29:23 +0900
Message-ID: <4EDC48A3.2020102@samsung.com>
References: <4EDC0D14.5080204@samsung.com>
 <000b01ccb303$148e84e0$3dab8ea0$%jun@samsung.com>
 <4EDC4607.3000102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12450 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab1LEE30 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2011 23:29:26 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVP00EBBR4YV1E0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Dec 2011 13:29:25 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVP00HB6R50QK80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Dec 2011 13:29:24 +0900 (KST)
In-reply-to: <4EDC4607.3000102@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>

And that flag didn't affect anywhere..in my case..

If you know why use this flag, i don't remove this flag.

Thanks,
Jaehoon Chung

On 12/05/2011 01:18 PM, Jaehoon Chung wrote:

> Hi Seungwon
> 
> On 12/05/2011 01:05 PM, Seungwon Jeon wrote:
> 
>> Hi Jaehoon,
>>> This patch is just removed the unnecessary code.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  drivers/mmc/host/sdhci-s3c.c |    7 +------
>>>  1 files changed, 1 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>>> index b6558b8..ad0ef39 100644
>>> --- a/drivers/mmc/host/sdhci-s3c.c
>>> +++ b/drivers/mmc/host/sdhci-s3c.c
>>> @@ -334,11 +334,9 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>>>  		spin_lock_irqsave(&host->lock, flags);
>>>  		if (state) {
>>>  			dev_dbg(&dev->dev, "card inserted.\n");
>>> -			host->flags &= ~SDHCI_DEVICE_DEAD;
>>>  			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>>  		} else {
>>>  			dev_dbg(&dev->dev, "card removed.\n");
>>> -			host->flags |= SDHCI_DEVICE_DEAD;
>>>  			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>>  		}
>> Could you explain the reason of these remove?
>> SDHCI_DEVICE_DEAD flag is needed for external card detection
>> and is used in "sdhci.c".
> 
> 
> I didn't know why this flag is assigned
> I found that if this flag is set when card is removed,
> ENSDCLK bit in CLOCK control register is always set in sdhci_set_ios().
> If device dead, be skipped set_ios.
> (In my case, when i use SD clock-gating, this flag is problem.)
> 
> Best regards,
> Jaehoon Chung
> 
>>
>> Best regards,
>> Seungwon Jeon.
>>
>>>  		tasklet_schedule(&host->card_tasklet);
>>> @@ -521,6 +519,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>  	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>>  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>>>
>>> +	/* It supports additional host capabilities if needed */
>>>  	if (pdata->host_caps)
>>>  		host->mmc->caps |= pdata->host_caps;
>>>
>>> @@ -543,10 +542,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>  		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
>>>  	}
>>>
>>> -	/* It supports additional host capabilities if needed */
>>> -	if (pdata->host_caps)
>>> -		host->mmc->caps |= pdata->host_caps;
>>> -
>>>  	ret = sdhci_add_host(host);
>>>  	if (ret) {
>>>  		dev_err(dev, "sdhci_add_host() failed\n");
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


