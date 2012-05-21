From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 4/4] mmc: dw_mmc: correct the calculation for CLKDIV
Date: Mon, 21 May 2012 11:25:42 +0100
Message-ID: <CAFbHwiSHB8NBc1Ji192L4sP_=RDjFEz7_+pOw8+jGby89AjLAA@mail.gmail.com>
References: <003501cd3640$ec0f1270$c42d3750$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592Ab2EUKZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 06:25:43 -0400
Received: by pbbrp8 with SMTP id rp8so6754117pbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 May 2012 03:25:42 -0700 (PDT)
In-Reply-To: <003501cd3640$ec0f1270$c42d3750$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Sun, May 20, 2012 at 5:27 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> In case of "host->bus_hz < slot->clock", divider value is
> miscalculated. And clock divider register value is multiple
> of 2. If calculated divider value is odd number, result can
> be over-clocking.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 10 ++++++----
> =A01 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f2f8463..c87745e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -617,14 +617,16 @@ static void dw_mci_setup_bus(struct dw_mci_slot=
 *slot)
> =A0 =A0 =A0 =A0u32 div;
>
> =A0 =A0 =A0 =A0if (slot->clock !=3D host->current_speed) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_hz % slot->clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D host->bus_hz / slot->clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_hz % slot->clock &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz > slot->cl=
ock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * move the + 1 after =
the divide to prevent
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * over-clocking the c=
ard.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */

This comment seems to be no longer relevant so it should be removed.

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D ((host->bus_hz =
/ slot->clock) >> 1) + 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D (host->bus_hz =A0=
/ slot->clock) >> 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div +=3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D (host->bus_hz !=3D slot->clock)=
 ? DIV_ROUND_UP(div, 2) : 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&slot->mmc->class_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Bus speed (slot %d) =
=3D %dHz (slot req %dHz, actual %dHZ"
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
