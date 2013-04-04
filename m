From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: Remove power_restore bus_ops for mmc and sd
Date: Thu, 4 Apr 2013 11:55:44 +0200
Message-ID: <CAPDyKFr983eazpW=ky2knujur+RND4m0nL=n1pZmUyzxVSe3uA@mail.gmail.com>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
	<1362142035-8403-2-git-send-email-ulf.hansson@stericsson.com>
	<515D3DCC.8000505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:53618 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab3DDJzp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 05:55:45 -0400
Received: by mail-ve0-f178.google.com with SMTP id db10so2474558veb.9
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 02:55:44 -0700 (PDT)
In-Reply-To: <515D3DCC.8000505@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 4 April 2013 10:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 01/03/13 14:47, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The mmc_power_restore|save_host API is only used by SDIO func drivers. SDIO
>
> NAK - it is also used by eMMC hardware reset i.e. mmc_do_hw_reset()

True for eMMC, but for SD card the bus_ops can go away. Thanks for
spotting this Adrian!

Although, I see some serious problems with the mmc_do_hw_reset
function - it could cause eMMC data corruption.

Issuing hw reset and doing re-initialization by using the mmc
bus_ops->power_restore will mean no consideration is taken to "cache
ctrl", "bkops" and "power off notify". I think it must.

So the more proper way instead of calling power_restore, should be to
use bus_ops->suspend and bus_ops->resume callbacks from the
mmc_do_hw_reset function. Additionally if bus_ops->suspend is done
successfully, we should be able to skip the actual hw reset and just
do bus_ops->resume.

Do you have any thoughts on this?

Kind regards
Ulf Hansson

>
>> func drivers are also moving towards use of runtime pm to accomplish the
>> the same operation and since this API is not used for mmc and sd it makes
>> sense to remove the corresponding bus_ops.
>>
>> Moreover, at least for eMMC the mmc bus_ops is broken, since no consideration
>> is taken for mmc sleep and mmc power off notify.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/mmc.c |   14 --------------
>>  drivers/mmc/core/sd.c  |   14 --------------
>>  2 files changed, 28 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index c8f3d6e..edc6bc4 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1445,18 +1445,6 @@ static int mmc_resume(struct mmc_host *host)
>>       return err;
>>  }
>>
>> -static int mmc_power_restore(struct mmc_host *host)
>> -{
>> -     int ret;
>> -
>> -     host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
>> -     mmc_claim_host(host);
>> -     ret = mmc_init_card(host, host->ocr, host->card);
>> -     mmc_release_host(host);
>> -
>> -     return ret;
>> -}
>> -
>>  static int mmc_sleep(struct mmc_host *host)
>>  {
>>       struct mmc_card *card = host->card;
>> @@ -1494,7 +1482,6 @@ static const struct mmc_bus_ops mmc_ops = {
>>       .detect = mmc_detect,
>>       .suspend = NULL,
>>       .resume = NULL,
>> -     .power_restore = mmc_power_restore,
>>       .alive = mmc_alive,
>>  };
>>
>> @@ -1505,7 +1492,6 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
>>       .detect = mmc_detect,
>>       .suspend = mmc_suspend,
>>       .resume = mmc_resume,
>> -     .power_restore = mmc_power_restore,
>>       .alive = mmc_alive,
>>  };
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 9e645e1..b71d906 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -1095,24 +1095,11 @@ static int mmc_sd_resume(struct mmc_host *host)
>>       return err;
>>  }
>>
>> -static int mmc_sd_power_restore(struct mmc_host *host)
>> -{
>> -     int ret;
>> -
>> -     host->card->state &= ~MMC_STATE_HIGHSPEED;
>> -     mmc_claim_host(host);
>> -     ret = mmc_sd_init_card(host, host->ocr, host->card);
>> -     mmc_release_host(host);
>> -
>> -     return ret;
>> -}
>> -
>>  static const struct mmc_bus_ops mmc_sd_ops = {
>>       .remove = mmc_sd_remove,
>>       .detect = mmc_sd_detect,
>>       .suspend = NULL,
>>       .resume = NULL,
>> -     .power_restore = mmc_sd_power_restore,
>>       .alive = mmc_sd_alive,
>>  };
>>
>> @@ -1121,7 +1108,6 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
>>       .detect = mmc_sd_detect,
>>       .suspend = mmc_sd_suspend,
>>       .resume = mmc_sd_resume,
>> -     .power_restore = mmc_sd_power_restore,
>>       .alive = mmc_sd_alive,
>>  };
>>
>>
>
