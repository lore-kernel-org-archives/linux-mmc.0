From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: in mmc_hw_reset(), allow power cycle.
Date: Mon, 11 Apr 2016 15:33:11 +0200
Message-ID: <CAPDyKFocr6No-1TZR_x6ss6WGh05ZduA5oH6hiyxUEuTGzmSog@mail.gmail.com>
References: <1459531522-31874-1-git-send-email-gwendal@chromium.org>
	<1459551862-38853-1-git-send-email-gwendal@chromium.org>
	<CAPDyKFq0o8ii27c8Qwh73EgANOfdEc-kXNdDDsjgVk_eU4y_TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33396 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbcDKNdN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2016 09:33:13 -0400
Received: by mail-vk0-f42.google.com with SMTP id k1so212460187vkb.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2016 06:33:12 -0700 (PDT)
In-Reply-To: <CAPDyKFq0o8ii27c8Qwh73EgANOfdEc-kXNdDDsjgVk_eU4y_TA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 4 April 2016 at 14:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 2 April 2016 at 01:04, Gwendal Grignou <gwendal@chromium.org> wrote:
>> When the eMMC device does not support/allow sending RST_n signal,
>> try to do a brute force power cycle instead of returning EOPNOTSUPP.
>> If power cycle is not supported by the hardware, mmc_init_card still
>> send a CMD0, performing a Software Reset.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>> Changes in v3:
>> - clock setting in already done in power_cycle.
>> - clarify behavior when power cycle is not implemented. .
>>  drivers/mmc/core/core.c |  5 +++--
>>  drivers/mmc/core/mmc.c  | 24 +++++++++++-------------
>>  2 files changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index d8bbc78..d5bc2d8 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2468,8 +2468,9 @@ int mmc_hw_reset(struct mmc_host *host)
>>         ret = host->bus_ops->reset(host);
>>         mmc_bus_put(host);
>>
>> -       if (ret != -EOPNOTSUPP)
>> -               pr_warn("%s: tried to reset card\n", mmc_hostname(host));
>> +       if (ret)
>> +               pr_warn("%s: tried to reset card, got error %d\n",
>> +                       mmc_hostname(host), ret);
>>
>>         return ret;
>>  }
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 96cc7e2..92b7bea 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1988,19 +1988,17 @@ static int mmc_reset(struct mmc_host *host)
>>  {
>>         struct mmc_card *card = host->card;
>>
>> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>> -               return -EOPNOTSUPP;
>> -
>> -       if (!mmc_can_reset(card))
>> -               return -EOPNOTSUPP;
>> -
>> -       mmc_set_clock(host, host->f_init);
>> -
>> -       host->ops->hw_reset(host);
>> -
>> -       /* Set initial state and call mmc_set_ios */
>> -       mmc_set_initial_state(host);
>> -
>> +       if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
>> +            mmc_can_reset(card)) {
>> +               /* If the card accept RST_n signal, send it. */
>> +               mmc_set_clock(host, host->f_init);
>> +               host->ops->hw_reset(host);
>> +               /* Set initial state and call mmc_set_ios */
>> +               mmc_set_initial_state(host);
>> +       } else {
>> +               /* Do a brute force power cycle */
>> +               mmc_power_cycle(host, card->ocr);
>> +       }
>>         return mmc_init_card(host, card->ocr, card);
>>  }
>>
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>
> There are more two callers triggering the host->ops->hw_reset() to be
> called, which also have special treatment of the error code
> -EOPNOTSUPP. These are mmc_hw_reset() and mmc_blk_reset().
>
> Please make sure to update their error handling accordingly. Otherwise
> this looks okay to me.

After some more investigations, I realized that the error path in the
mmc block layer needed some additional cleanups.
Therefore I have decided to apply the v3 version of $subject patch for
next, then I am going to post some cleanups changes on top.

I also took the liberty to update the changelog as I think it needed
to be extended with some more information.

Thanks and kind regards
Uffe
