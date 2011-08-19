From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Date: Fri, 19 Aug 2011 12:09:50 +0900
Message-ID: <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-3-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49075 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1HSDJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2011 23:09:51 -0400
In-Reply-To: <1313716221-20136-3-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wro=
te:
> Provide separate interrupt handlers which may be used by platforms wh=
ere
> SDHI has three interrupt sources.
>
> This patch also removes the commented-out handling of CRC and other e=
rrors.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---

> +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> +{
> + =A0 =A0 =A0 struct tmio_mmc_host *host =3D devid;
> + =A0 =A0 =A0 unsigned int ireg, status;
> +
> + =A0 =A0 =A0 pr_debug("MMC IRQ begin\n");
> +
> + =A0 =A0 =A0 tmio_mmc_card_irq_status(host, &ireg, &status);
> + =A0 =A0 =A0 if (__tmio_mmc_card_detect_irq(host, ireg, status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 if (__tmio_mmc_sdcard_irq(host, ireg, status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> +
> + =A0 =A0 =A0 tmio_mmc_sdio_irq(irq, devid);
>
> -out:
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> =A0EXPORT_SYMBOL(tmio_mmc_irq);

Is there any particular reason for returning early in this interrupt
handler? By returning early I mean the "if ... return IRQ_HANDLED"
cases above.

I realize the old ISR code in the driver does just this, so if the
goal is to stay compatible then I guess we should keep this behavior.
=46rom my point of view it usually makes more sense to try to handle al=
l
events that may be associated with the IRQ.

Thanks,

/ magnus
