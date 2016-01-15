From: Wan Zongshun <vw@iommu.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci: Add platform tuning callback for amd
 hs200 mode
Date: Fri, 15 Jan 2016 09:38:54 +0800
Message-ID: <56984DAE.2060200@iommu.org>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
 <1450802408-16354-2-git-send-email-vincent.wan@amd.com>
 <CAPDyKFp++EZB7a3PtAanJV7Wcn8ziwdFUJe80L36UwAFAEQzdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp++EZB7a3PtAanJV7Wcn8ziwdFUJe80L36UwAFAEQzdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wan Zongshun <vincent.wan@amd.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wan Zongshun <mcuos.com@gmail.com>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
List-Id: linux-mmc@vger.kernel.org

>>
>> But I also met trouble in sdhci_execute_tuning of sdhci.c, I have to suppose
>> only sdhci_pci_platform_execute_tuning is returning -EPERM(current code,
>> my assumption is right), so that those vendor that has no
>> slot->platform_execute_tuning could be skipped and go next standard
>> tuning process.
>>
>> If you have better idea for my requirement, please correct me.
>
> sdhci needs to become a set of library functions.
>
> Typically the mmc_host_ops ->execute_tuning() callback for sdhci,
> should be assigned to a default function, unless the sdhci variant has
> assigned it to something else.
>
> Yes, I realize that it requires core changes to sdhci to allow this.
> Although it's necessary do this conversion as I won't accept any more
> changes for sdhci that doesn't move the code into this direction.
>

Ulf,

Then Can you point me what's my next step for submitting tuning 
workaround for AMD emmc4.5 driver?

What your mean is you will change sdhci-pci-core.c to a core and library 
function?
And then I can implement a AMD specific emmc-pci driver call to those libs?


> Kind regards
> Uffe
>
>>
>> Thanks!
>> Wan Zongshun.
>>
>> ---
>>   drivers/mmc/host/sdhci-pci-core.c | 23 +++++++++++++++++++++++
>>   drivers/mmc/host/sdhci-pci.h      |  1 +
>>   drivers/mmc/host/sdhci.c          |  3 ++-
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 01c5723..e7b2bbe 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -905,8 +905,19 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>>          return 0;
>>   }
>>
