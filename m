From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v2 6/8] mmc: sdhci-pxav3: controller can't get base clock
Date: Tue, 25 Sep 2012 00:11:14 +0800
Message-ID: <CADz5_gJe8gPj97jJa3PvxcbcSEbTduQW_v5OxaxnDs8NENjf3Q@mail.gmail.com>
References: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
	<1348474558-23088-7-git-send-email-keyuan.liu@gmail.com>
	<42BF0A4E-A5E5-4E8F-8BD6-C6CA4BC40020@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63395 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180Ab2IXQLQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 12:11:16 -0400
Received: by wibhm2 with SMTP id hm2so312921wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Sep 2012 09:11:15 -0700 (PDT)
In-Reply-To: <42BF0A4E-A5E5-4E8F-8BD6-C6CA4BC40020@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "pierre@ossman.eu" <pierre@ossman.eu>, Haojian Zhuang <hzhuang1@marvell.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>

2012/9/24 Philip Rakity <prakity@marvell.com>:
>
> On Sep 24, 2012, at 1:15 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:
>
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
>> SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
>> clock value. It return a fixed pre-set value like 200 on
>> some sdhci-pxav3 based platforms like MMP3 while return 0
>> on the other sdhci-pxav3 based platforms.
>> So we enable the quirk and get the base clock via function
>> get_max_clock.
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>> drivers/mmc/host/sdhci-pxav3.c |    3 ++-
>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index e918a2b..75cc79b 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -249,7 +249,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>       host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>               | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>> -             | SDHCI_QUIRK_32BIT_ADMA_SIZE;
>> +             | SDHCI_QUIRK_32BIT_ADMA_SIZE
>> +             | SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>>
>>       /* enable 1/8V DDR capable */
>>       host->mmc->caps |= MMC_CAP_1_8V_DDR;
>> --
>> 1.7.0.4
>>
>
>
> Kevin,
>
> would you mind adding:
>
> Reported-by: Philip Rakity <prakity@marvell.com> since I originally sent you different code to fix this.
>
Sure, I will add this.

> This patch is NOT sufficient to fix the problem since the clock code was not correct in the marvell mmp3 code.
> Has someone sent upstream the patch to fix the base code in linux ?
>
I think mmp3 clock code has not been pushed to opensource.
This patch is for the driver side.

> Reviewed-by: Philip Rakity <prakity@Marvell.com>
