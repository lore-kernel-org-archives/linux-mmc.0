From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH] mmc: core: make hw_reset power cycle SD-cards
Date: Fri, 12 Sep 2014 08:44:23 +0200
Message-ID: <CA+20K0B0zXNL5Qokd1qBVoE6v-Y9Wq3xyh9Ym2XH+GTR9xdA8w@mail.gmail.com>
References: <1410272508-4885-1-git-send-email-johanru@axis.com>
	<CAPDyKFrNV1qoDkTMsRwSf=SihHBwGUhqP4yL3NNfwhnn9wf9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:44526 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbaILGob (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Sep 2014 02:44:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 1A5882E420
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2014 08:44:30 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pnpB82-BWV3W for <linux-mmc@vger.kernel.org>;
	Fri, 12 Sep 2014 08:44:26 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id F0FFE2E2EC
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2014 08:44:25 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id DA0FD1225
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2014 08:44:25 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id CE076CEF
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2014 08:44:25 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id CBD293E048
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2014 08:44:25 +0200 (CEST)
Received: by mail-qc0-f173.google.com with SMTP id w7so303859qcr.18        for
 <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2014 23:44:23 -0700 (PDT)
In-Reply-To: <CAPDyKFrNV1qoDkTMsRwSf=SihHBwGUhqP4yL3NNfwhnn9wf9Hg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johanru@axis.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf,

2014-09-11 13:03 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 9 September 2014 16:21, Johan Rudholm <johan.rudholm@axis.com> wrote:
>> SD-cards cannot be reset, but they can be power cycled. Power cycling
>> a buggy SD-card sometimes helps it get back on track.
>
> Hi Johan,
>
> This feature has been missing for too long - really great that you are
> working on this!
>
>>
>> Signed-off-by: Johan Rudholm <johanru@axis.com>
>> ---
>>  drivers/mmc/core/core.c |   16 +++++++++++-----
>>  1 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index d03a080..9171aa9 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2250,19 +2250,25 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
>>  {
>>         struct mmc_card *card = host->card;
>>
>> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>> -               return -EOPNOTSUPP;
>> -
>>         if (!card)
>>                 return -EINVAL;
>>
>> -       if (!mmc_can_reset(card))
>> +       if (!mmc_card_sd(card) && !((host->caps & MMC_CAP_HW_RESET) &&
>> +                                                       host->ops->hw_reset))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (!mmc_card_sd(card) && !mmc_can_reset(card))
>>                 return -EOPNOTSUPP;
>>
>>         mmc_host_clk_hold(host);
>>         mmc_set_clock(host, host->f_init);
>>
>> -       host->ops->hw_reset(host);
>> +       if (mmc_card_sd(card))
>> +               mmc_power_cycle(host, card->ocr);
>> +       else
>> +               host->ops->hw_reset(host);
>> +
>> +       pr_warning("%s: reset device\n", mmc_hostname(host));
>>
>>         /* If the reset has happened, then a status command will fail */
>>         if (check) {
>> --
>> 1.7.2.5
>>
>
> Before we decide to go ahead an continue to hack on the current reset
> code as your patch does, could you possibly consider to do some more
> extensive rework this code?

Sure, challenge accepted!

> Here are some of the ideas that I had in mind.
>
> 1) Invent a new bus_ops callback for reset. Or maybe we should re-use
> the ->power_save|restore ones, since those already exist!?
> 2) Since those bus_ops are specific for sd/mmc/sdio we shall handle
> those related parts in there.
> 3) Then let's mmc_do_hw_reset invoke the above bus_ops.
> 4) Remove the mmc_hw_reset_check() API. Currently only used by mmc_test.

Reuse makes some sense, since bus_ops->power_restore is already a part
of the current hw_reset reset sequence. But do you mean like letting
bus_ops->power_save call host_ops->hw_reset? Won't this interfere with
the other use case of power_save?

What's the current status of mmc_power_save_host and
bus_ops->power_save anyway? As far as I can see, they are no longer
used by the MMC framework. Maybe we can throw away mmc_power_save_host
and bus_ops->power_save, and instead add the reset bus_ops? The naming
of the bus_ops will be more fitting this way.

//Johan
