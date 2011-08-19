From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Date: Fri, 19 Aug 2011 13:59:06 +0900
Message-ID: <20110819045858.GA17548@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-3-git-send-email-horms@verge.net.au>
 <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
 <20110819033043.GB12106@verge.net.au>
 <CANqRtoQDFpr_YTnSObyidMKpTyQXE=W6JDoBXrJ-MpLM1r_wCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56635 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1HSE7N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 00:59:13 -0400
Content-Disposition: inline
In-Reply-To: <CANqRtoQDFpr_YTnSObyidMKpTyQXE=W6JDoBXrJ-MpLM1r_wCA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 01:27:41PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 12:30 PM, Simon Horman <horms@verge.net.au> w=
rote:
> > On Fri, Aug 19, 2011 at 12:09:50PM +0900, Magnus Damm wrote:
> >> On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au=
> wrote:
> >> > Provide separate interrupt handlers which may be used by platfor=
ms where
> >> > SDHI has three interrupt sources.
> >> >
> >> > This patch also removes the commented-out handling of CRC and ot=
her errors.
> >> >
> >> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> > Cc: Magnus Damm <magnus.damm@gmail.com>
> >> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >> >
> >> > ---
> >>
> >> > +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> >> > +{
> >> > + =C2=A0 =C2=A0 =C2=A0 struct tmio_mmc_host *host =3D devid;
> >> > + =C2=A0 =C2=A0 =C2=A0 unsigned int ireg, status;
> >> > +
> >> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("MMC IRQ begin\n");
> >> > +
> >> > + =C2=A0 =C2=A0 =C2=A0 tmio_mmc_card_irq_status(host, &ireg, &st=
atus);
> >> > + =C2=A0 =C2=A0 =C2=A0 if (__tmio_mmc_card_detect_irq(host, ireg=
, status))
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HA=
NDLED;
> >> > + =C2=A0 =C2=A0 =C2=A0 if (__tmio_mmc_sdcard_irq(host, ireg, sta=
tus))
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HA=
NDLED;
> >> > +
> >> > + =C2=A0 =C2=A0 =C2=A0 tmio_mmc_sdio_irq(irq, devid);
> >> >
> >> > -out:
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> >> > =C2=A0}
> >> > =C2=A0EXPORT_SYMBOL(tmio_mmc_irq);
> >>
> >> Is there any particular reason for returning early in this interru=
pt
> >> handler? By returning early I mean the "if ... return IRQ_HANDLED"
> >> cases above.
> >>
> >> I realize the old ISR code in the driver does just this, so if the
> >> goal is to stay compatible then I guess we should keep this behavi=
or.
> >> >From my point of view it usually makes more sense to try to handl=
e all
> >> events that may be associated with the IRQ.
> >
> > My original post had the behaviour that you suggest but Guennadi
> > indicted that he would be much more comfortable with keeping the or=
iginal
> > behaviour as it is know to work on a wide range of hardware.
>=20
> I see, thanks for your patience...
>=20
> So I may remember this wrong, but for the 3 different interrupt
> sources I believe that the SDIO IRQ code was added by Arnd for one of
> the Renesas SDHI platforms. Back then Ian disliked supporting more
> than a single interrupt source, so for that reason the SDIO IRQ code
> was added on top of the common interrupt handler. We had no
> documentation either, so it was added in a rather random way. I recal=
l
> the SDIO IRQ being handled before the other interrupt types in the
> common handler not last, but that's not very important. Anyway, with
> the fact that SDIO IRQ support was added for SDHI platforms in mind
> then we can assume that other platforms won't need it. Not sure if
> this fact will improve our situation or not.
>=20
> As for the two remaining interrupts, I believe they share hardware
> registers somehow. I guess I'm OK keeping the original behavior
> somehow, but I still believe it's incorrect. It may not matter very
> much though since it's rather unlikely that hotplug insertion or ejec=
t
> coincides with the data IRQs.

Hi Magnus,

to be honest I'm unsure if the current behaviour is correct or not.
But it does appear to work on a wide range of hardware. And as
tmio_mmc_irq() is an implementation of the single-source ISR intended
for legacy purposes it does seem reasonable to maintain the existing
behaviour.

If there is a need to change the behaviour of tmio_mmc_irq() in some wa=
y
then I think that is best dealt with in a separate patch (series)
subsequent to the current series that is intended to introduce broken-o=
ut
handlers.
