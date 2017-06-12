From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove MMC_CAP2_HC_ERASE_SZ
Date: Mon, 12 Jun 2017 14:08:52 +0200
Message-ID: <CAPDyKFpbEnZyncYJ+T5iK10Ksh91y2hZBm63trmiEGnU6GOErQ@mail.gmail.com>
References: <1497257366-4223-1-git-send-email-ulf.hansson@linaro.org> <9877182c-13c5-6073-6607-95b95a2acd6c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35674 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdFLMIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2017 08:08:53 -0400
Received: by mail-qt0-f175.google.com with SMTP id w1so122320176qtg.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2017 05:08:53 -0700 (PDT)
In-Reply-To: <9877182c-13c5-6073-6607-95b95a2acd6c@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 12 June 2017 at 11:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 12/06/17 11:49, Ulf Hansson wrote:
>> The MMC_CAP2_HC_ERASE_SZ is used only by a few mmc host drivers. Its intent
>> is to enable eMMC's high-capacity erase size, as to improve the behaviour
>> of the erase operations.
>>
>> However, for eMMCs supporting trim/discard, the MMC_CAP2_HC_ERASE_SZ
>> becomes somewhat redundant. This because trim/discard operates on sectors
>> and these commands takes precedence over erase commands, when supported.
>>
>> In addition, we should really avoid software configuration options that
>> isn't necessary, but instead strive to deploy common behaviours. For these
>> reasons, let's remove the capability bit for MMC_CAP2_HC_ERASE_SZ and the
>> corresponding behaviour.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/mmc.c            | 3 +--
>>  drivers/mmc/host/sdhci-acpi.c     | 1 -
>>  drivers/mmc/host/sdhci-brcmstb.c  | 3 ---
>>  drivers/mmc/host/sdhci-pci-core.c | 4 +---
>>  include/linux/mmc/host.h          | 1 -
>>  5 files changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index e504b66..d1a6d74 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1655,8 +1655,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>        * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
>>        * bit.  This bit will be lost every time after a reset or power off.
>>        */
>> -     if (card->ext_csd.partition_setting_completed ||
>> -         (card->ext_csd.rev >= 3 && (host->caps2 & MMC_CAP2_HC_ERASE_SZ))) {
>> +     if (card->ext_csd.partition_setting_completed) {
>
> PARTITION_SETTING_COMPLETED was added in eMMC v4.4 but ERASE_GROUP_DEF was
> added in eMMC v4.3, so this doesn't work for v4.3 devices.
>
> Why not enable it always? i.e.
>
>         if (card->ext_csd.rev >= 3) {

Yes, that makes sense! Thanks for spotting this!

However, that actually means this didn't work as expected for hosts
that didn't specify MMC_CAP2_HC_ERASE_SZ.

[...]

Kind regards
Uffe
