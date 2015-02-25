From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Add exclusion between cmd and interrupt
Date: Wed, 25 Feb 2015 22:21:54 +0900
Message-ID: <CAH1o70K0O7kcQEzNqsHqKzUhuhxLnVsf7vgVjW-2rhY-7xhjkg@mail.gmail.com>
References: <1424011607-3682-1-git-send-email-ykaneko0929@gmail.com>
	<54E0C2FF.3040401@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:64172 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbBYNVz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 08:21:55 -0500
In-Reply-To: <54E0C2FF.3040401@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Sergei,

2015-02-16 1:02 GMT+09:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
> On 02/15/2015 05:46 PM, Yoshihiro Kaneko wrote:
>
>> From: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
>
>
>> A command end interrupt should not be processed between command issue
>> and setting of wait_for flag. It expects already the flag to be set.
>> Therefore the exclusive control was added.
>
>
>> Signed-off-by: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>
>
>> This patch is based on next branch of Chris Ball's mmc tree.
>
>
>>   drivers/mmc/host/sh_mmcif.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>
>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index 7d9d6a3..e5d0b42 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>
> [...]
>>
>> @@ -1171,6 +1174,12 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>> *dev_id)
>>         struct sh_mmcif_host *host = dev_id;
>>         struct mmc_request *mrq;
>>         bool wait = false;
>> +       unsigned long flags;
>> +       int wait_work;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +       wait_work = host->wait_for;
>> +       spin_unlock_irqrestore(&host->lock, flags);
>
>
>    Locking don't seem to have much sense here, as the read is already
> atomic.

Thank you for your review.
I agree with you and I will remove this locking.


Thanks,
Kaneko

>
> WBR, Sergei
>
