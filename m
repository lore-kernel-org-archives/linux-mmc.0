From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pxav3: Fix tabbing issue
Date: Wed, 2 Sep 2015 17:55:09 +0530
Message-ID: <55E6EAA5.4030808@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139486.12163.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35685 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbbIBMZO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 08:25:14 -0400
Received: by pacfv12 with SMTP id fv12so10445358pac.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2015 05:25:14 -0700 (PDT)
In-Reply-To: <1441139486.12163.3.camel@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On Wednesday 02 September 2015 02:01 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> There were some coding style issues where spaces have been used instead
>> of tabs, for example, in macro definitions, alignment of function
>> declarations/definitions, etc...
>>
>> This patch fixes all such occurrences in the code.
>> And also use BIT for bit definitions.
>
> Please send 2 patches instead.
>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> []
>> @@ -128,7 +133,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>   }
>>
>>   static int armada_38x_quirks(struct platform_device *pdev,
>> -			     struct sdhci_host *host)
>> +			struct sdhci_host *host)
>
> This is not an improvement.
>

Missed to highlight one more point here,

The kernel CodingStyle talks about indentation, pasting it below -

-------
Outside of comments, documentation and except in Kconfig, spaces are
never used for indentation.
-------

But I see spaces are being used at lot of places :)

Till now all the patches or drivers which I submitted, I never used
spaces. :)
Anyway, just wanted to highlight CodingStyle document here.

Thanks,
Vaibhav
