From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Date: Fri, 19 Aug 2011 12:30:49 +0900
Message-ID: <20110819033043.GB12106@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-3-git-send-email-horms@verge.net.au>
 <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53624 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HSDaz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2011 23:30:55 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 12:09:50PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> w=
rote:
> > Provide separate interrupt handlers which may be used by platforms =
where
> > SDHI has three interrupt sources.
> >
> > This patch also removes the commented-out handling of CRC and other=
 errors.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
>=20
> > +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct tmio_mmc_host *host =3D devid;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int ireg, status;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("MMC IRQ begin\n");
> > +
> > + =C2=A0 =C2=A0 =C2=A0 tmio_mmc_card_irq_status(host, &ireg, &statu=
s);
> > + =C2=A0 =C2=A0 =C2=A0 if (__tmio_mmc_card_detect_irq(host, ireg, s=
tatus))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDL=
ED;
> > + =C2=A0 =C2=A0 =C2=A0 if (__tmio_mmc_sdcard_irq(host, ireg, status=
))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDL=
ED;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 tmio_mmc_sdio_irq(irq, devid);
> >
> > -out:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(tmio_mmc_irq);
>=20
> Is there any particular reason for returning early in this interrupt
> handler? By returning early I mean the "if ... return IRQ_HANDLED"
> cases above.
>=20
> I realize the old ISR code in the driver does just this, so if the
> goal is to stay compatible then I guess we should keep this behavior.
> >From my point of view it usually makes more sense to try to handle a=
ll
> events that may be associated with the IRQ.

My original post had the behaviour that you suggest but Guennadi
indicted that he would be much more comfortable with keeping the origin=
al
behaviour as it is know to work on a wide range of hardware.


