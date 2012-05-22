From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 4/4] mmc: dw_mmc: correct the calculation for CLKDIV
Date: Tue, 22 May 2012 12:35:24 +0900
Message-ID: <006401cd37cb$ec45d260$c4d17720$%jun@samsung.com>
References: <003501cd3640$ec0f1270$c42d3750$%jun@samsung.com>
 <CAFbHwiSHB8NBc1Ji192L4sP_=RDjFEz7_+pOw8+jGby89AjLAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26486 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2EVDf0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 23:35:26 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E0071MN8LAU70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 12:35:24 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E00AH9NB0RCL0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 12:35:24 +0900 (KST)
In-reply-to: <CAFbHwiSHB8NBc1Ji192L4sP_=RDjFEz7_+pOw8+jGby89AjLAA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james.hogan@imgtec.com>

Will Newton <will.newton@gmail.com> wrote:
> On Sun, May 20, 2012 at 5:27 AM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
> > In case of "host->bus_hz < slot->clock", divider value is
> > miscalculated. And clock divider register value is multiple
> > of 2. If calculated divider value is odd number, result can
> > be over-clocking.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/host/dw_mmc.c | =A0 10 ++++++----
> > =A01 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index f2f8463..c87745e 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -617,14 +617,16 @@ static void dw_mci_setup_bus(struct dw_mci_sl=
ot *slot)
> > =A0 =A0 =A0 =A0u32 div;
> >
> > =A0 =A0 =A0 =A0if (slot->clock !=3D host->current_speed) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_hz % slot->clock)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D host->bus_hz / slot->clock;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_hz % slot->clock &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz > slot->=
clock)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * move the + 1 afte=
r the divide to prevent
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * over-clocking the=
 card.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>=20
> This comment seems to be no longer relevant so it should be removed.
>=20
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D ((host->bus_h=
z / slot->clock) >> 1) + 1;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D (host->bus_hz=
 =A0/ slot->clock) >> 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div +=3D 1;
div +=3D 1;
It's still effective.

Best regards,
Seungwon Jeon
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D (host->bus_hz !=3D slot->cloc=
k) ? DIV_ROUND_UP(div, 2) : 0;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&slot->mmc->class_dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Bus speed (slot %d=
) =3D %dHz (slot req %dHz, actual %dHZ"
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

