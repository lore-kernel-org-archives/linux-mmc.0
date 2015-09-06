From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH repost] mmc: sh_mmcif: Fix suspend process
Date: Mon, 7 Sep 2015 00:42:58 +0900
Message-ID: <CAH1o70+9ik2vAjZUr9n6jUVJS-XSzco4cA6X53naVHBuKoLEpA@mail.gmail.com>
References: <1440334688-20674-1-git-send-email-ykaneko0929@gmail.com>
	<CAPDyKFoRZ2fns=i7tua+dDjLFeMLxOEkcUB4AOPdFHqXs-eYOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35013 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbIFPm7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Sep 2015 11:42:59 -0400
In-Reply-To: <CAPDyKFoRZ2fns=i7tua+dDjLFeMLxOEkcUB4AOPdFHqXs-eYOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Ulf,

2015-08-26 0:27 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 23 August 2015 at 14:58, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> The clock should be enable when SDHI registers are accessed.
>
> Yes, correct. But...
>
>>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on mmc-next branch of Ulf Hansson's mmc tree.
>>
>> * Perhaps this relates to the need to enhance clock management
>>
>>  drivers/mmc/host/sh_mmcif.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index 5a1fdd4..ad9ffea 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -1632,7 +1632,9 @@ static int sh_mmcif_suspend(struct device *dev)
>>  {
>>         struct sh_mmcif_host *host = dev_get_drvdata(dev);
>>
>> +       pm_runtime_get_sync(dev);
>>         sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
>> +       pm_runtime_put(dev);
>
> ... when will the clock be gated, since the pm_runtime_put() here wont
> do the trick!
>
> That's a bit more complicated to deal with, but for now I will apply
> this patch as is.

Thanks!
I need to learn more.

Best Regards,
Kaneko

>
>>
>>         return 0;
>>  }
>> --
>> 1.9.1
>>
>
> Thanks, applied for next!
>
> Kind regards
> Uffe
