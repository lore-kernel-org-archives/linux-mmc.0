From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro
Date: Tue, 5 May 2015 12:34:41 +0200
Message-ID: <CAPDyKFrusYNvS3n6A6GzaUvF7Ei_GCwNpgAxNtwY85GqnH8W-Q@mail.gmail.com>
References: <1430817114.20613.1.camel@ingics.com>
	<20150505172429.4711e86f@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36444 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEEKem (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 06:34:42 -0400
Received: by qku63 with SMTP id 63so102108869qku.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 03:34:41 -0700 (PDT)
In-Reply-To: <20150505172429.4711e86f@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Axel Lin <axel.lin@ingics.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 5 May 2015 at 11:24, Jisheng Zhang <jszhang@marvell.com> wrote:
> On Tue, 5 May 2015 02:11:54 -0700
> Axel Lin <axel.lin@ingics.com> wrote:
>
>> This eliminates having an #ifdef returning NULL for the case
>> when OF is disabled.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/mmc/host/sdhci-pxav2.c | 4 +---
>>  drivers/mmc/host/sdhci-pxav3.c | 4 +---
>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>> index f98008b..beffd86 100644
>> --- a/drivers/mmc/host/sdhci-pxav2.c
>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>> @@ -252,9 +252,7 @@ static int sdhci_pxav2_remove(struct platform_device *pdev)
>>  static struct platform_driver sdhci_pxav2_driver = {
>>       .driver         = {
>>               .name   = "sdhci-pxav2",
>> -#ifdef CONFIG_OF
>> -             .of_match_table = sdhci_pxav2_of_match,
>> -#endif
>> +             .of_match_table = of_match_ptr(sdhci_pxav2_of_match),
>>               .pm     = SDHCI_PLTFM_PMOPS,
>>       },
>>       .probe          = sdhci_pxav2_probe,
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index b5103a2..01cb2d3 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -578,9 +578,7 @@ static const struct dev_pm_ops sdhci_pxav3_pmops = {
>>  static struct platform_driver sdhci_pxav3_driver = {
>>       .driver         = {
>>               .name   = "sdhci-pxav3",
>> -#ifdef CONFIG_OF
>> -             .of_match_table = sdhci_pxav3_of_match,
>> -#endif
>> +             .of_match_table = of_match_ptr(sdhci_pxav3_of_match),
>>               .pm     = SDHCI_PXAV3_PMOPS,
>>       },
>>       .probe          = sdhci_pxav3_probe,
>
> Looks good to me.
>
> Thanks

I consider that as an ack.

Thanks, applied.

Kind regards
Uffe
