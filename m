From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci: Add platform tuning callback for amd
 hs200 mode
Date: Fri, 15 Jan 2016 08:26:17 +0100
Message-ID: <CAPDyKFpFvtveE+ppiOBkHmXGAVw7AX5-VEKseU6_2qChipQroA@mail.gmail.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
	<1450802408-16354-2-git-send-email-vincent.wan@amd.com>
	<CAPDyKFp++EZB7a3PtAanJV7Wcn8ziwdFUJe80L36UwAFAEQzdA@mail.gmail.com>
	<56984DAE.2060200@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36280 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcAOH0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2016 02:26:18 -0500
Received: by mail-yk0-f172.google.com with SMTP id v14so440765845ykd.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2016 23:26:17 -0800 (PST)
In-Reply-To: <56984DAE.2060200@iommu.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: Wan Zongshun <vincent.wan@amd.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wan Zongshun <mcuos.com@gmail.com>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>

On 15 January 2016 at 02:38, Wan Zongshun <vw@iommu.org> wrote:
>>>
>>> But I also met trouble in sdhci_execute_tuning of sdhci.c, I have to
>>> suppose
>>> only sdhci_pci_platform_execute_tuning is returning -EPERM(current code,
>>> my assumption is right), so that those vendor that has no
>>> slot->platform_execute_tuning could be skipped and go next standard
>>> tuning process.
>>>
>>> If you have better idea for my requirement, please correct me.
>>
>>
>> sdhci needs to become a set of library functions.
>>
>> Typically the mmc_host_ops ->execute_tuning() callback for sdhci,
>> should be assigned to a default function, unless the sdhci variant has
>> assigned it to something else.
>>
>> Yes, I realize that it requires core changes to sdhci to allow this.
>> Although it's necessary do this conversion as I won't accept any more
>> changes for sdhci that doesn't move the code into this direction.
>>
>
> Ulf,
>
> Then Can you point me what's my next step for submitting tuning workaround
> for AMD emmc4.5 driver?
>
> What your mean is you will change sdhci-pci-core.c to a core and library
> function?

Not me personally as I don't have the bandwidth to do it. Anybody that
cares about sdhci are encouraged to give it a try!

> And then I can implement a AMD specific emmc-pci driver call to those libs?

The lib should provide common functionality needed among sdhci variants.

If there specific needs for any sdhci variant, that variant should
implement that part separately without affecting other variants. This
isn't the case when adding an sdhci callback/quirk to the sdhci core,
as that would affect more or less *all* sdhci variants.

[...]

Kind regards
Uffe
