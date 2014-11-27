From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH v4 1/2] mmc: core: turn hw_reset into a bus_ops
Date: Thu, 27 Nov 2014 10:05:17 +0100
Message-ID: <CA+20K0Dfi5SfkG_88j6yC-xMLE-5zZhB1WijsnmnWf8TwyOssg@mail.gmail.com>
References: <1416827198-29820-1-git-send-email-johanru@axis.com>
	<1416827198-29820-2-git-send-email-johanru@axis.com>
	<CAPDyKFrQySfFkR1VMK19gBwpO=97=V_U-HfmWpVHFMfzaVLwgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:43063 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbaK0JFZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Nov 2014 04:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id A66DC1806B
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:05:23 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 12ZH+foFRf2O for <linux-mmc@vger.kernel.org>;
	Thu, 27 Nov 2014 10:05:19 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 0B72218092
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:05:19 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id E4928110E
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:05:18 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id D8AB31108
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:05:18 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id D55A93429B
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:05:18 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id c9so3341987qcz.10
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 01:05:17 -0800 (PST)
In-Reply-To: <CAPDyKFrQySfFkR1VMK19gBwpO=97=V_U-HfmWpVHFMfzaVLwgw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johanru@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

Hi Ulf,

2014-11-25 14:48 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 24 November 2014 at 12:06, Johan Rudholm <johan.rudholm@axis.com> wrote:
>> Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
>> it from the new bus_ops member hw_reset. This also lets us add code
>> for resetting SD cards as well.
>>
>> Signed-off-by: Johan Rudholm <johanru@axis.com>
>> ---
>>  drivers/mmc/core/core.c |   56 +++++++++++++++-------------------------------
>>  drivers/mmc/core/core.h |    5 ++++
>>  drivers/mmc/core/mmc.c  |   40 +++++++++++++++++++++++++++++++++
>>  3 files changed, 63 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 9584bff..492b3e5 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2245,67 +2245,47 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
>>         mmc_host_clk_release(host);
>>  }
>>
>> -int mmc_can_reset(struct mmc_card *card)
>> -{
>> -       u8 rst_n_function;
>> -
>> -       if (!mmc_card_mmc(card))
>> -               return 0;
>> -       rst_n_function = card->ext_csd.rst_n_function;
>> -       if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
>> -               return 0;
>> -       return 1;
>> -}
>> -EXPORT_SYMBOL(mmc_can_reset);
>
> Isn't the mmc_can_reset() function used from mmc_test.c?

Yes. Maybe we should move this stuff to mmc_test instead. We could
also move the code that checks if the reset worked or not to mmc_test,
since this is the only place where the check is performed.

>> -
>> +/* Reset card in a bus-specific way */
>>  static int mmc_do_hw_reset(struct mmc_host *host, int check)
>>  {
>> -       struct mmc_card *card = host->card;
>> -
>> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>> -               return -EOPNOTSUPP;
>> +       int ret;
>>
>> -       if (!card)
>> +       if (!host->card)
>>                 return -EINVAL;
>>
>> -       if (!mmc_can_reset(card))
>
> You need a mmc_bus_get() here before accessing the host->bus_ops callbacks.
>
> Well, if you would executed this code with the host claimed and from
> the mmc block layer, you can be sure the bus_ops to exist. Now, since
> this is an exported function, I think you need to be more safe to also
> do the mmc_bus_get|put().

Got it, thanks.

>> +       if (!host->bus_ops || !host->bus_ops->hw_reset ||
>> +                       host->bus_ops->hw_reset(host, MMC_HW_RESET_TEST))
>>                 return -EOPNOTSUPP;
>>
>> -       mmc_host_clk_hold(host);
>> -       mmc_set_clock(host, host->f_init);
>> +       ret = host->bus_ops->hw_reset(host, check);
>
> What's going on here? You are invoking the ->hw_reset() callback
> twice. That seems odd.
>>
>> -       host->ops->hw_reset(host);
>> -
>> -       /* If the reset has happened, then a status command will fail */
>> -       if (check) {
>> -               u32 status;
>> -
>> -               if (!mmc_send_status(card, &status)) {
>> -                       mmc_host_clk_release(host);
>> -                       return -ENOSYS;
>> -               }
>> -       }
>> -
>> -       /* Set initial state and call mmc_set_ios */
>> -       mmc_set_initial_state(host);
>> +       if (check == MMC_HW_RESET_TEST_CARD)
>> +               return ret;
>>
>> -       mmc_host_clk_release(host);
>> +       pr_warn("%s: tried to reset card (status %d)\n",
>> +                                               mmc_hostname(host), ret);
>>
>>         return host->bus_ops->power_restore(host);
>>  }
>>
>>  int mmc_hw_reset(struct mmc_host *host)
>>  {
>> -       return mmc_do_hw_reset(host, 0);
>> +       return mmc_do_hw_reset(host, MMC_HW_RESET_RESET);
>>  }
>>  EXPORT_SYMBOL(mmc_hw_reset);
>>
>>  int mmc_hw_reset_check(struct mmc_host *host)
>>  {
>> -       return mmc_do_hw_reset(host, 1);
>> +       return mmc_do_hw_reset(host, MMC_HW_RESET_CHECK);
>>  }
>>  EXPORT_SYMBOL(mmc_hw_reset_check);
>>
>> +int mmc_can_reset(struct mmc_card *card)
>> +{
>> +       return mmc_do_hw_reset(card->host, MMC_HW_RESET_TEST_CARD);
>> +}
>> +EXPORT_SYMBOL(mmc_can_reset);
>> +
>>  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>>  {
>>         host->f_init = freq;
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index d76597c..f6e0a52 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -27,6 +27,11 @@ struct mmc_bus_ops {
>>         int (*power_restore)(struct mmc_host *);
>>         int (*alive)(struct mmc_host *);
>>         int (*shutdown)(struct mmc_host *);
>> +       int (*hw_reset)(struct mmc_host *, int);
>> +#define MMC_HW_RESET_RESET     0
>> +#define MMC_HW_RESET_TEST      1
>> +#define MMC_HW_RESET_CHECK     2
>> +#define MMC_HW_RESET_TEST_CARD 3
>
> Urgh. Is there a way to remove all this? I just don't like all these options.
>
> In fact, I would prefer to have none of them.

If we move the test and check functionality to mmc_test, I think we
can avoid these. What do you think of this approach?

//Johan
