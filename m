From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
Date: Wed, 2 Sep 2015 20:46:52 +0530
Message-ID: <55E712E4.7080608@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139838.12163.5.camel@perches.com> <55E6F497.8080300@linaro.org>
 <1441206476.12163.44.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36777 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbbIBPQ6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 11:16:58 -0400
Received: by pacwi10 with SMTP id wi10so14660248pac.3
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2015 08:16:57 -0700 (PDT)
In-Reply-To: <1441206476.12163.44.camel@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On Wednesday 02 September 2015 08:37 PM, Joe Perches wrote:
> On Wed, 2015-09-02 at 18:37 +0530, Vaibhav Hiremath wrote:
>> On Wednesday 02 September 2015 02:07 AM, Joe Perches wrote:
>>> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>>>> Return value would give clear information about the actual root-cause
>>>> of the failure.
>>>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>>>> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>>>
>>>>    	ret = sdhci_add_host(host);
>>>>    	if (ret) {
>>>> -		dev_err(&pdev->dev, "failed to add host\n");
>>>> +		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
>>>>    		goto err_add_host;
>>>>    	}
>>>
>>> If this is really desirable, there are many other callers of
>>> sdhci_add_host with error messages just like this one.
>>>
>> How about this? If you are ok, I can change it and submit the patch
>> again.
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> []
>> @@ -3176,8 +3176,11 @@ int sdhci_add_host(struct sdhci_host *host)
>>                   mmc->caps |= MMC_CAP_NEEDS_POLL;
>>
>>           /* If there are external regulators, get them */
>> -       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
>> +       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER) {
>> +               pr_err("%s: regulator supply unavailable, deferring
>> probe. \n",
>> +                               mmc_hostname(mmc));
>>                   return -EPROBE_DEFER;
>> +       }
>
> (your email client has inappropriate line wrapping)
>
> The KERN_<LEVEL> here probably isn't right.
>
> Deferring isn't an error, at best it's a notification

I would consider it as an ERROR if it gets deferred
continuously/multiple times due to same reason.

> and perhaps should be at pr_notice/KERN_NOTICE
>

Yeah, KERN_NOTICE looks right here.

> I don't know how often or how many times this deferral
> can occur.  Do you?
>

-EDEFER_PROBE usually means that driver has some dependency,
for which it has to wait.
In my case, during every boot, I pxav3_sdhci_probe gets deferred once
due to regulator unavailability.

Thanks,
Vaibhav
