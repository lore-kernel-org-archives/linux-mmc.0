From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH v6 1/2] mmc: core: refactor the hw_reset routines
Date: Mon, 12 Jan 2015 15:37:57 +0100
Message-ID: <CA+20K0AKEGnxdWiyAfk9-ZE9d-747CcES35ei69E4fdeFxXs0A@mail.gmail.com>
References: <1420801699-6274-1-git-send-email-johanru@axis.com>
	<1420801699-6274-2-git-send-email-johanru@axis.com>
	<CAPDyKFqUajxeSt9Mhv_Mif18SwmRHUY0CDWvb34mis3CnNY78Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:45482 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbALOiC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 09:38:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 8800A1809E
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:38:00 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GLUYD6xpIwOO for <linux-mmc@vger.kernel.org>;
	Mon, 12 Jan 2015 15:37:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id CD9AB1808D
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:37:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BDDA1F4B
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:37:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id B2BC2F22
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:37:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id AFE9A3E326
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:37:59 +0100 (CET)
Received: by mail-qg0-f49.google.com with SMTP id f51so17783391qge.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 06:37:58 -0800 (PST)
In-Reply-To: <CAPDyKFqUajxeSt9Mhv_Mif18SwmRHUY0CDWvb34mis3CnNY78Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johanru@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

2015-01-12 13:55 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 9 January 2015 at 12:08, Johan Rudholm <johan.rudholm@axis.com> wrote:
>> Move the (e)MMC specific hw_reset code from core.c into mmc.c Call the
>> code from the new bus_ops member hw_reset. This also allows for adding
>> a SD card specific reset procedure.
>>
>> Always check if the card is alive after a successful reset. This allows
>> us to remove mmc_hw_reset_check(), leaving mmc_hw_reset() as the only
>> card reset interface. This also informs any callers, for instance the
>> block layer, if a reset was sucessful or not.
>>
>> Signed-off-by: Johan Rudholm <johanru@axis.com>
>> ---
>>  drivers/mmc/card/mmc_test.c |   18 ++++-------
>>  drivers/mmc/core/core.c     |   70 +++++++++++++++----------------------------
>>  drivers/mmc/core/core.h     |    1 +
>>  drivers/mmc/core/mmc.c      |   32 +++++++++++++++++++
>>  include/linux/mmc/core.h    |    1 -
>>  5 files changed, 64 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index 0a7430f..7dac469 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>> @@ -2342,20 +2342,16 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
>>         struct mmc_host *host = card->host;
>>         int err;
>>
>> -       err = mmc_hw_reset_check(host);
>> +       if (!mmc_card_mmc(card) || !mmc_can_reset(card))
>> +               return RESULT_UNSUP_CARD;
>> +
>> +       err = mmc_hw_reset(host);
>>         if (!err)
>>                 return RESULT_OK;
>> +       else if (err == -EOPNOTSUPP)
>> +               return RESULT_UNSUP_HOST;
>>
>> -       if (err == -ENOSYS)
>> -               return RESULT_FAIL;
>> -
>> -       if (err != -EOPNOTSUPP)
>> -               return err;
>> -
>> -       if (!mmc_can_reset(card))
>> -               return RESULT_UNSUP_CARD;
>> -
>> -       return RESULT_UNSUP_HOST;
>> +       return RESULT_FAIL;
>>  }
>>
>>  static const struct mmc_test_case mmc_test_cases[] = {
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index d3bfbdf..8598287 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2273,67 +2273,45 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
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
>> -
>> -static int mmc_do_hw_reset(struct mmc_host *host, int check)
>> +int mmc_hw_reset(struct mmc_host *host)
>>  {
>> -       struct mmc_card *card = host->card;
>> -
>> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>> -               return -EOPNOTSUPP;
>> +       int ret = 0;
>> +       int card_alive = 0;
>> +       u32 status;
>>
>> -       if (!card)
>> +       if (!host->card)
>>                 return -EINVAL;
>>
>> -       if (!mmc_can_reset(card))
>> -               return -EOPNOTSUPP;
>> -
>> -       mmc_host_clk_hold(host);
>> -       mmc_set_clock(host, host->f_init);
>> +       mmc_bus_get(host);
>> +       if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
>> +               ret = -EOPNOTSUPP;
>> +               goto out;
>> +       }
>>
>> -       host->ops->hw_reset(host);
>> +       ret = host->bus_ops->hw_reset(host);
>> +       if (ret)
>> +               goto out;
>>
>>         /* If the reset has happened, then a status command will fail */
>> -       if (check) {
>> -               u32 status;
>> +       if (!mmc_send_status(host->card, &status))
>> +               card_alive = 1;
>>
>> -               if (!mmc_send_status(card, &status)) {
>> -                       mmc_host_clk_release(host);
>> -                       return -ENOSYS;
>> -               }
>> -       }
>> +       pr_warn("%s: tried to reset card (%s)\n", mmc_hostname(host),
>> +                                       card_alive ? "failed" : "ok");
>>
>>         /* Set initial state and call mmc_set_ios */
>>         mmc_set_initial_state(host);
>> +       ret = host->bus_ops->power_restore(host);
>>
>> -       mmc_host_clk_release(host);
>> -
>> -       return host->bus_ops->power_restore(host);
>
> I would like you to move the mmc_send_status() and onwards code in
> this function, into the mmc specific ->hw_reset() callback.
>
> In that way, mmc/sd/sdio can separately decide if the
> mmc_send_status() is needed and we also can remove two users (sd/mmc)
> of the ->power_restore() callback.

Good idea, this makes the core.c code cleaner. I've decided to put the
removal of mmc_hw_reset_check() into a separate patch, to make it
easier to see what's happened.

>> -}
>> -
>> -int mmc_hw_reset(struct mmc_host *host)
>> -{
>> -       return mmc_do_hw_reset(host, 0);
>> +out:
>> +       mmc_bus_put(host);
>> +       if (card_alive)
>> +               return -ENOSYS;
>> +       else
>> +               return ret;
>>  }
>>  EXPORT_SYMBOL(mmc_hw_reset);
>>
>> -int mmc_hw_reset_check(struct mmc_host *host)
>> -{
>> -       return mmc_do_hw_reset(host, 1);
>> -}
>> -EXPORT_SYMBOL(mmc_hw_reset_check);
>> -
>>  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>>  {
>>         host->f_init = freq;
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index b528c0e..4d1ee8a 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -27,6 +27,7 @@ struct mmc_bus_ops {
>>         int (*power_restore)(struct mmc_host *);
>>         int (*alive)(struct mmc_host *);
>>         int (*shutdown)(struct mmc_host *);
>> +       int (*hw_reset)(struct mmc_host *);
>
> ->Please rename to reset()

Ok.

>>  };
>>
>>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 0b8ec87..f64a53e 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1795,6 +1795,37 @@ static int mmc_power_restore(struct mmc_host *host)
>>         return ret;
>>  }
>>
>> +int mmc_can_reset(struct mmc_card *card)
>> +{
>> +       u8 rst_n_function;
>> +
>> +       rst_n_function = card->ext_csd.rst_n_function;
>> +       if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
>> +               return 0;
>> +       return 1;
>> +}
>> +EXPORT_SYMBOL(mmc_can_reset);
>> +
>> +static int mmc_mmc_hw_reset(struct mmc_host *host)
>
> Please rename to mmc_reset()

Ok.

>> +{
>> +       struct mmc_card *card = host->card;
>> +
>> +       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>> +               return -EOPNOTSUPP;
>> +
>> +       if (!mmc_can_reset(card))
>> +               return -EOPNOTSUPP;
>> +
>> +       mmc_host_clk_hold(host);
>> +       mmc_set_clock(host, host->f_init);
>> +
>> +       host->ops->hw_reset(host);
>> +
>> +       mmc_host_clk_release(host);
>> +
>> +       return 0;
>> +}
>> +
>>  static const struct mmc_bus_ops mmc_ops = {
>>         .remove = mmc_remove,
>>         .detect = mmc_detect,
>> @@ -1805,6 +1836,7 @@ static const struct mmc_bus_ops mmc_ops = {
>>         .power_restore = mmc_power_restore,
>>         .alive = mmc_alive,
>>         .shutdown = mmc_shutdown,
>> +       .hw_reset = mmc_mmc_hw_reset,
>>  };
>>
>>  /*
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index cb2b040..160448f 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -182,7 +182,6 @@ extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
>>  extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
>>                               bool is_rel_write);
>>  extern int mmc_hw_reset(struct mmc_host *host);
>> -extern int mmc_hw_reset_check(struct mmc_host *host);
>>  extern int mmc_can_reset(struct mmc_card *card);
>>
>>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
>> --
>> 1.7.2.5
>>
>
> I am overall very happy with this approach. Nice work Johan!

Thank you, and thank you for the detailed review work!

//Johan
