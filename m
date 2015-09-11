From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Keep host claimed while invoking mmc_power_off|up()
Date: Fri, 11 Sep 2015 15:59:44 +0200
Message-ID: <CAPDyKFpzrEwG6W7SZfBL0_MHfEP=1QVD-+pW_BfyuoXhPd+5pA@mail.gmail.com>
References: <1441975315-30387-1-git-send-email-ulf.hansson@linaro.org>
	<55F2D59B.4060804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35086 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbIKN7q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2015 09:59:46 -0400
Received: by wicge5 with SMTP id ge5so64293472wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2015 06:59:45 -0700 (PDT)
In-Reply-To: <55F2D59B.4060804@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 11 September 2015 at 15:22, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Ulf,
>
> On Friday 11 September 2015 06:11 PM, Ulf Hansson wrote:
>> As mmc_claim_host() invokes pm_runtime_get_sync() for the mmc host device,
>> it's important that the host is kept claimed for *all* accesses to it via
>> the host_ops callbacks.
>>
>> In some code paths for SDIO, particularly related to the PM support,
>> mmc_power_off|up() is invoked without keeping the host claimed. Let's fix
>> these.
>>
>> Moreover, mmc_start|stop_host() also invokes mmc_power_off|up() without
>> claiming the host, let's fix these as well.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/core.c |  6 ++++++
>>  drivers/mmc/core/sdio.c | 20 +++++++++++++++-----
>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>
> .
> .
> <snip>
> .
> .
>>  int mmc_power_save_host(struct mmc_host *host)
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index b91abed..95bc101 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -897,11 +897,10 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
>>   */
>>  static int mmc_sdio_suspend(struct mmc_host *host)
>>  {
>> -     if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>> -             mmc_claim_host(host);
>> +     mmc_claim_host(host);
>> +
>> +     if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
>>               sdio_disable_wide(host->card);
>> -             mmc_release_host(host);
>> -     }
>>
>>       if (!mmc_card_keep_power(host)) {
>>               mmc_power_off(host);
>> @@ -910,6 +909,8 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>>               mmc_retune_needed(host);
>>       }
>>
>> +     mmc_release_host(host);
>> +
>>       return 0;
>>  }
>>
>> @@ -1018,15 +1019,24 @@ out:
>>  static int mmc_sdio_runtime_suspend(struct mmc_host *host)
>>  {
>>       /* No references to the card, cut the power to it. */
>> +     mmc_claim_host(host);
>>       mmc_power_off(host);
>> +     mmc_release_host(host);
>> +
>>       return 0;
>>  }
>>
>>  static int mmc_sdio_runtime_resume(struct mmc_host *host)
>>  {
>> +     int ret;
>> +
>>       /* Restore power and re-initialize. */
>> +     mmc_claim_host(host);
>>       mmc_power_up(host, host->card->ocr);
>> -     return mmc_sdio_power_restore(host);
>> +     ret = mmc_sdio_power_restore(host);
>
> IIUC, this will cause mmc_claim_host to be invoked twice since
> mmc_sdio_power_restore also invokes mmc_claim_host. I'm not sure if this
> will have undesired side effects.

That's not a problem, mmc_claim_host() handles that. As long it's the
same running context that tries to claim the host it will allow it.

Kind regards
Uffe
