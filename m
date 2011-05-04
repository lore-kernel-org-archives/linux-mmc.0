From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v2] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 4 May 2011 18:23:38 +0200
Message-ID: <BANLkTi=LsmSepyUMbO7q2hG5-HWbRduO+Q@mail.gmail.com>
References: <1304525161-14448-1-git-send-email-per.forlin@linaro.org> <1304525161-14448-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61487 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1EDQX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2011 12:23:59 -0400
In-Reply-To: <1304525161-14448-2-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

2011/5/4 Per Forlin <per.forlin@linaro.org>:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> If there is only 1 function registered it is possible to
> improve performance by directly calling the irq handler
> and avoiding the overhead of reading the CCCR registers.
>
[...]
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -32,6 +32,16 @@ static int process_sdio_pending_irqs(struct mmc_ca=
rd *card)
> =A0 =A0 =A0 =A0int i, ret, count;
> =A0 =A0 =A0 =A0unsigned char pending;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Optimization, if there is only 1 function register=
ed
> + =A0 =A0 =A0 =A0* call irq handler directly
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->sdio_single_irq && card->sdio_single_irq->irq=
_handler) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdio_func *func =3D card->sdio_s=
ingle_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler(func);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
[...]

The second condition can be avoided:

in process_sdio_pending_irqs():

if (card->sdio_irq_func)
   call handler and return

in sdio_claim_irq():

  card->func->irq_handler =3D ...
  if (host->sdio_irqs =3D=3D 1)
    card->sdio_irq_func =3D func;
  else
    card->sdio_irq_func =3D NULL;

in sdio_release_irq():

  card->sdio_irq_func =3D NULL;
  card->func->irq_handler =3D ...
  sdio_card_irq_put();
  if (host->sdio_irqs =3D=3D 1)
    sdio_single_irq_set(func->card);

in struct mmc_card:
  struct sdio_func =A0 =A0 =A0 =A0*sdio_irq_func;

Best Regards,
Micha=B3 Miros=B3aw
