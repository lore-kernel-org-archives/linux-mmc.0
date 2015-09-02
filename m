From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
Date: Wed, 2 Sep 2015 12:07:01 +0530
Message-ID: <55E6990D.3000407@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139838.12163.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34617 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbIBGhH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 02:37:07 -0400
Received: by padhy1 with SMTP id hy1so873434pad.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2015 23:37:06 -0700 (PDT)
In-Reply-To: <1441139838.12163.5.camel@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On Wednesday 02 September 2015 02:07 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> Return value would give clear information about the actual root-cause
>> of the failure.
>
> I'm not sure why that is as nearly every error path in
> sdhci_add_host emits a message.
>

Not for everything.
No error message for -EPROBE_DEFER.

>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> []
>> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>   	ret = sdhci_add_host(host);
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "failed to add host\n");
>> +		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
>>   		goto err_add_host;
>>   	}
>>
>
> If this is really desirable, there are many other callers of
> sdhci_add_host with error messages just like this one.
>

Yes, true.
Ho about, adding pr_err into sdhci_add_host for -EPROBE_DEFER.

Thanks,
Vaibhav
