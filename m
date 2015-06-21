From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] mmc: tmio: Fix timeout value for command request
Date: Mon, 22 Jun 2015 00:46:46 +0900
Message-ID: <CAH1o70+mM0=4g-wjW2PgJHB59Vfafs0t=-_NQXNGXVpht-6Yuw@mail.gmail.com>
References: <1434302606-31040-1-git-send-email-ykaneko0929@gmail.com>
	<CALq1K=+kP2qwbhreMMTg9T362AVjinW9bZObgBi7sP7z5y-Dhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CALq1K=+kP2qwbhreMMTg9T362AVjinW9bZObgBi7sP7z5y-Dhw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Leon Romanovsky <leon@leon.nu>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Leon,

2015-06-15 14:49 GMT+09:00 Leon Romanovsky <leon@leon.nu>:
> On Sun, Jun 14, 2015 at 8:23 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> Fix the problem which timeout occurs at the time of command request with
>> several cards.
>>
>> The timeout value was insufficient as a verification of several cards,
>> so it was changed 5 seconds from 2 seconds.
> Hi Yoshihiro,
> Can you please throw a light on which cards you were reuqested to
> increase the timeout?

I am inquiring to the person concerned.

Thanks,
Kaneko

>
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on mmc-next branch of Ulf Hansson's mmc tree.
>>
>>  drivers/mmc/host/tmio_mmc_pio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index e3dcf31..0f7c4ae 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -230,7 +230,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>>          */
>>         if (IS_ERR_OR_NULL(mrq)
>>             || time_is_after_jiffies(host->last_req_ts +
>> -               msecs_to_jiffies(2000))) {
>> +               msecs_to_jiffies(5000))) {
>>                 spin_unlock_irqrestore(&host->lock, flags);
>>                 return;
>>         }
>> @@ -818,7 +818,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>         ret = tmio_mmc_start_command(host, mrq->cmd);
>>         if (!ret) {
>>                 schedule_delayed_work(&host->delayed_reset_work,
>> -                                     msecs_to_jiffies(2000));
>> +                                     msecs_to_jiffies(5000));
>>                 return;
>>         }
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Leon Romanovsky | Independent Linux Consultant
>         www.leon.nu | leon@leon.nu
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
