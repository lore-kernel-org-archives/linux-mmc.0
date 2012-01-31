From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-s3c: support the broken voltage.
Date: Tue, 31 Jan 2012 20:01:26 +0900
Message-ID: <4F27CA06.4010701@samsung.com>
References: <4F27907B.10103@samsung.com>
 <CAGxe1ZGDA8ja=rmo+9fbqarDPzUq9g8706tnqRr0dLJN9a1HnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56948 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2AaLBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 06:01:36 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYN00GFGT9WQ1Y0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 20:01:35 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYN00EW6TANK180@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 20:01:35 +0900 (KST)
In-reply-to: <CAGxe1ZGDA8ja=rmo+9fbqarDPzUq9g8706tnqRr0dLJN9a1HnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, m.szyprowski@samsung.com

On 01/31/2012 07:32 PM, Girish K S wrote:

> On 31 January 2012 12:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Samsung-SoC need to add the MMC_CAP2_BROKEN_VOLTAGE.
>>
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/sdhci-s3c.c |    7 +++----
>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index d065e37..e7e2b6b 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -521,9 +521,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>        if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>                host->mmc->caps = MMC_CAP_NONREMOVABLE;
>>
>> +       /* It supports additional host capabilities if needed */
>>        if (pdata->host_caps)
>>                host->mmc->caps |= pdata->host_caps;
>>
>> +       host->mmc->caps2 = MMC_CAP2_BROKEN_VOLTAGE;
> 
> Dont you think this should be set in the machine specific platform
> data structure. If done in the machine specific file
> only   if (pdata->host_caps2)
>               host->mmc->caps2 |= pdata->host_caps2
> would be more generic to pull all the caps2 fields

Right..i think also that.
Actually I sent the second capability patch for Samsung-SoC before...
Kukjin Kim didn't accept the patch.
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg07456.html
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg07455.html

I will resend the patch..if he will accept them..

Best Regards,
Jaehoon Chung

> 
>> +
>>        if (pdata->pm_caps)
>>                host->mmc->pm_caps |= pdata->pm_caps;
>>
>> @@ -543,10 +546,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>                sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
>>        }
>>
>> -       /* It supports additional host capabilities if needed */
>> -       if (pdata->host_caps)
>> -               host->mmc->caps |= pdata->host_caps;
>> -
>>        ret = sdhci_add_host(host);
>>        if (ret) {
>>                dev_err(dev, "sdhci_add_host() failed\n");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


