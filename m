From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 4 May 2011 19:00:10 +0200
Message-ID: <BANLkTinptOJrpdwbLOF_Th-Jz9gKj5Y6dQ@mail.gmail.com>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
	<1304525161-14448-2-git-send-email-per.forlin@linaro.org>
	<BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63858 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1EDRAK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 13:00:10 -0400
In-Reply-To: <BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

2011/5/4 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
> 2011/5/4 Per Forlin <per.forlin@linaro.org>:
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> If there is only 1 function registered it is possible to
>> improve performance by directly calling the irq handler
>> and avoiding the overhead of reading the CCCR registers.
>>
> [...]
>> --- a/drivers/mmc/core/sdio_irq.c
>> +++ b/drivers/mmc/core/sdio_irq.c
>> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_c=
ard *card)
>> =A0 =A0 =A0 =A0int i, ret, count;
>> =A0 =A0 =A0 =A0unsigned char pending;
>>
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Optimization, if there is only 1 function registe=
red
>> + =A0 =A0 =A0 =A0* call irq handler directly
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (card->sdio_single_irq && card->sdio_single_irq->ir=
q_handler) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdio_func *func =3D card->sdio_=
single_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler(func);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 }
> [...]
>
> The second condition can be avoided:
>
> in process_sdio_pending_irqs():
>
> if (card->sdio_irq_func)
> =A0 call handler and return
>
I added the second condition as a sanity check. Same check is used in
the main for loop
>	ret =3D -EINVAL;
>			} else if (func->irq_handler) {
>				func->irq_handler(func);
Is the second check necessary here?

> in sdio_claim_irq():
>
> =A0card->func->irq_handler =3D ...
> =A0if (host->sdio_irqs =3D=3D 1)
> =A0 =A0card->sdio_irq_func =3D func;
> =A0else
> =A0 =A0card->sdio_irq_func =3D NULL;
I wanted to keep it simple and use same function in claim and release.
Your code looks nice.
Is if safe to not check the condition "(card->host->caps &
MMC_CAP_SDIO_IRQ)". What happens if the SDIO is in polling mode?

>
> in sdio_release_irq():
>
> =A0card->sdio_irq_func =3D NULL;
> =A0card->func->irq_handler =3D ...
> =A0sdio_card_irq_put();
> =A0if (host->sdio_irqs =3D=3D 1)
> =A0 =A0sdio_single_irq_set(func->card);
This works for me.

>
> in struct mmc_card:
> =A0struct sdio_func =A0 =A0 =A0 =A0*sdio_irq_func;
The name sdio_single_irq indicates it is only used for single irq.
"sdio_irq_func" is too generic I think. But the your name is shorter
and makes the indentation look nicer.
Not a big deal really.

I will wait until tomorrow to post patch v3. This will give time for
other to comment as well.

> Best Regards,
> Micha=B3 Miros=B3aw
>
Thanks for your feedback,
Per
