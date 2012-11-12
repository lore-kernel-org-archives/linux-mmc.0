From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v6 05/14] mmc: sdhci: fix null return check of regulator_get
Date: Mon, 12 Nov 2012 16:57:15 +0800
Message-ID: <CADz5_gJ5pdN+pUOkORCahkcKxcwxho7BP7pDZaMx2zBjnKHHKw@mail.gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-6-git-send-email-keyuan.liu@gmail.com>
	<878vagb1bj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48662 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab2KLI5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Nov 2012 03:57:17 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2687239wey.19
        for <linux-mmc@vger.kernel.org>; Mon, 12 Nov 2012 00:57:16 -0800 (PST)
In-Reply-To: <878vagb1bj.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>, dsd@laptop.org

2012/11/5 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Wed, Oct 17 2012, Kevin Liu wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> regulator_get() returns NULL when CONFIG_REGULATOR not defined,
>> which should not print out the warning.
>>
>> Reviewed-by: Philip Rakity <prakity@marvell.com>
>> Signed-off-by: Bin Wang <binw@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   18 ++++++++++++------
>>  1 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8e6a6f0..0104ae9 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2845,9 +2845,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>
>>       /* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>>       host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
>> -     if (IS_ERR(host->vqmmc)) {
>> -             pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
>> -             host->vqmmc = NULL;
>> +     if (IS_ERR_OR_NULL(host->vqmmc)) {
>> +             if (PTR_ERR(host->vqmmc) < 0) {
>> +                     pr_info("%s: no vqmmc regulator found\n",
>> +                             mmc_hostname(mmc));
>> +                     host->vqmmc = NULL;
>> +             }
>>       }
>>       else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
>>               regulator_enable(host->vqmmc);
>> @@ -2903,9 +2906,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>       ocr_avail = 0;
>>
>>       host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>> -     if (IS_ERR(host->vmmc)) {
>> -             pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>> -             host->vmmc = NULL;
>> +     if (IS_ERR_OR_NULL(host->vmmc)) {
>> +             if (PTR_ERR(host->vmmc) < 0) {
>> +                     pr_info("%s: no vmmc regulator found\n",
>> +                             mmc_hostname(mmc));
>> +                     host->vmmc = NULL;
>> +             }
>>       } else
>>               regulator_enable(host->vmmc);
>
> Pushed to mmc-next for 3.7 with this commit message:
>

Chris,

Thanks for the push.
But how about the other 13 patches in the same patchset ([PATCH v6
00/14] mmc: sdhci: mmc: sdhci: fixes and enhancements)?
Most of them also aim to fix bugs.

Kevin
