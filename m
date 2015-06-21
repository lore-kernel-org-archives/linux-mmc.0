From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] mmc: tmio: Fix timeout value for command request
Date: Mon, 22 Jun 2015 00:52:40 +0900
Message-ID: <CAH1o70+D2MZN0Y9v4X7qt7fBvcx-pyG9ogVqiFL1erCuF7brqw@mail.gmail.com>
References: <1434302606-31040-1-git-send-email-ykaneko0929@gmail.com>
	<20150615163431.GA1583@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35319 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbFUPwk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jun 2015 11:52:40 -0400
In-Reply-To: <20150615163431.GA1583@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Wolfram,

2015-06-16 1:34 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi,
>
>> @@ -230,7 +230,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>>        */
>>       if (IS_ERR_OR_NULL(mrq)
>>           || time_is_after_jiffies(host->last_req_ts +
>> -             msecs_to_jiffies(2000))) {
>> +             msecs_to_jiffies(5000))) {
>>               spin_unlock_irqrestore(&host->lock, flags);
>>               return;
>>       }
>> @@ -818,7 +818,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>       ret = tmio_mmc_start_command(host, mrq->cmd);
>>       if (!ret) {
>>               schedule_delayed_work(&host->delayed_reset_work,
>> -                                   msecs_to_jiffies(2000));
>> +                                   msecs_to_jiffies(5000));
>
> What about using a define here since the same kind of magic value is
> used in two different places?

Sounds good. I will do it in the next version.

Thanks,
Kaneko

>
> Kind regards,
>
>    Wolfram
>
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
