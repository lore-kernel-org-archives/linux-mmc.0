From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 4 May 2011 21:48:12 +0200
Message-ID: <BANLkTik+LWiYYPTqR5pNKsZfSMGGE3xCZg@mail.gmail.com>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org>
	<1304525161-14448-2-git-send-email-per.forlin@linaro.org>
	<alpine.LFD.2.00.1105041217380.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55705 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1EDTsN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 15:48:13 -0400
In-Reply-To: <alpine.LFD.2.00.1105041217380.24613@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

On 4 May 2011 19:34, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 4 May 2011, Per Forlin wrote:
>
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> If there is only 1 function registered it is possible to
>> improve performance by directly calling the irq handler
>> and avoiding the overhead of reading the CCCR registers.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
>> ---
>> =A0drivers/mmc/core/sdio_irq.c | =A0 30 ++++++++++++++++++++++++++++=
++
>> =A0include/linux/mmc/card.h =A0 =A0| =A0 =A01 +
>> =A02 files changed, 31 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq=
=2Ec
>> index b300161..64c4409 100644
>> --- a/drivers/mmc/core/sdio_irq.c
>> +++ b/drivers/mmc/core/sdio_irq.c
>> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_c=
ard *card)
>> =A0 =A0 =A0 int i, ret, count;
>> =A0 =A0 =A0 unsigned char pending;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Optimization, if there is only 1 function registered
>> + =A0 =A0 =A0* call irq handler directly
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (card->sdio_single_irq && card->sdio_single_irq->irq_ha=
ndler) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct sdio_func *func =3D card->sdio_sing=
le_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler(func);
>
> I think there is little point using a func variable here, especially
> since you already reference the handler pointer in the if() statement=
=2E
> Hence:
>
> =A0 =A0 =A0 =A0if (card->sdio_single_irq && card->sdio_single_irq->ir=
q_handler) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->sdio_single_irq->irq_handler();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0}
>
What do you think about:
+       struct sdio_func *func =3D card->sdio_single_irq;
+
+       /*
+        * Optimization, if there is only 1 function interrupt register=
ed
+        * call irq handler directly
+        */
+       if (func) {
+               func->irq_handler(func);
+               return 1;
+       }

-                       struct sdio_func *func =3D card->sdio_func[i - =
1];
+                       func =3D card->sdio_func[i - 1];

>> @@ -186,6 +196,24 @@ static int sdio_card_irq_put(struct mmc_card *c=
ard)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +/* If there is only 1 function registered set sdio_single_irq */
>> +static void sdio_single_irq_set(struct mmc_card *card)
>> +{
>
> The comment is slightly wrong. =A0This should say "only 1 function
> interrupt registered..." =A0Nothing prevents this from working with
> multiple functions if only one of them has claimed an interrupt.
>
> Other than that:
>
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>
>
> Nicolas
>
