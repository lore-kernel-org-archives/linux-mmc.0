From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] sdio: optimized SDIO IRQ handling for single function
Date: Wed, 4 May 2011 10:36:11 +0200
Message-ID: <BANLkTim_x28NyWzo-Ug3+ZprgeT=VFwEfQ@mail.gmail.com>
References: <1304453087-7365-1-git-send-email-per.forlin@linaro.org>
	<alpine.LFD.2.00.1105032339370.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1EDIgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 04:36:12 -0400
In-Reply-To: <alpine.LFD.2.00.1105032339370.24613@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linaro-dev@lists.linaro.org, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>

On 4 May 2011 05:40, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 3 May 2011, Per Forlin wrote:
>
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> If there is only 1 function registered, and IRQ:s are supported and
>> currently enabled, call the callback handler directly
>> without checking the CCCR registers.
>>
>> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>
I am working o a patch version 2 after offline discussion with Ulf Hans=
son.
Instead of adding this code here.
Add sdio_single_func member in mmc_card. Set and reset this function
in sdio_claim_irq and sdio_release_irq.
process_sdio_pending_irqs would only check if sdio_single_func is !=3D
null and call it.

This will result in a bigger patch overall but the new code in
process_sdio_pending_irqs will be minimal.

>> ---
>> =A0drivers/mmc/core/sdio_irq.c | =A0 14 ++++++++++++++
>> =A01 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq=
=2Ec
>> index b300161..25291bf 100644
>> --- a/drivers/mmc/core/sdio_irq.c
>> +++ b/drivers/mmc/core/sdio_irq.c
>> @@ -32,6 +32,20 @@ static int process_sdio_pending_irqs(struct mmc_c=
ard *card)
>> =A0 =A0 =A0 int i, ret, count;
>> =A0 =A0 =A0 unsigned char pending;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If there is only 1 function registered
>> + =A0 =A0 =A0* call irq directly without checking the CCCR registers=
=2E
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&

>> + =A0 =A0 =A0 =A0 card->host->sdio_irqs && (card->sdio_funcs =3D=3D =
1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < SDIO_MAX_FUNCS; i++) {
Minor adjustments.
card->sdio_funcs may be > 1 but still only one irq is registered.
No need to iterate more than "sdio_funcs" number of elements.
+ card->host->sdio_irqs =3D=3D 1)
+             for (i =3D 0; i < card->sdio_funcs; i++) {

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdio_func *func =3D=
 card->sdio_func[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (func && func->irq_hand=
ler) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->irq_=
handler(func);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 ret =3D mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, =
&pending);
>> =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: error %d reading =
SDIO_CCCR_INTx\n",
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>>
>
