From: "Puttagunta, Viswanath" <vishp@ti.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: Errata i705: SD hot unplug
Date: Thu, 31 May 2012 09:39:10 -0700
Message-ID: <CANwLT1T=w4--i28aZj2pyHOxa+A5ENj7=1ysR2BVY-rHodTn2A@mail.gmail.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com>
	<1337890467-32573-2-git-send-email-vishp@ti.com>
	<CANfBPZ98Yf+CMoA0ApzHihQqrRNEDKKxPx4U0bMsV=M3XeX4hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57722 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752132Ab2EaQjN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 May 2012 12:39:13 -0400
Received: by qcse1 with SMTP id e1so766760qcs.37
        for <linux-mmc@vger.kernel.org>; Thu, 31 May 2012 09:39:11 -0700 (PDT)
In-Reply-To: <CANfBPZ98Yf+CMoA0ApzHihQqrRNEDKKxPx4U0bMsV=M3XeX4hQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Linux-mmc <linux-mmc@vger.kernel.org>, T Krishnamoorthy Balaji <balajitk@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>

On Fri, May 25, 2012 at 1:37 AM, S, Venkatraman <svenkatr@ti.com> wrote=
:
>
> On Fri, May 25, 2012 at 1:44 AM, Viswanath Puttagunta <vishp@ti.com>
> wrote:
> > Turn off IO & PBIAS cells and then SD card VMMC as soon
> > as we get disconnect interrupt. Failure to do so might
> > cause current spikes (latch-up issue) which can potentially
> > burn the IO cells.
> >
> > Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
> > ---
> > =A0drivers/mmc/host/omap_hsmmc.c | =A0 13 ++++++++++---
> > =A01 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > b/drivers/mmc/host/omap_hsmmc.c
> > index 56d4499..61d830f 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -1177,10 +1177,17 @@ static irqreturn_t omap_hsmmc_detect(int ir=
q,
> > void *dev_id)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0carddetect =3D -ENOSYS;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (carddetect)
> > + =A0 =A0 =A0 if (carddetect) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host->mmc, (HZ * 2=
00) / 1000);
> > - =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host->mmc, (HZ * 50=
) / 1000);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((MMC_POWER_OFF !=3D host->power_m=
ode) &&
>
> Should be if((host->power_mode !=3D MMC_POWER_OFF)
>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_=
slot(host).set_power !=3D NULL)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).set_po=
wer(host->dev,
> > host->slot_id,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 0, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_mode =3D =
MMC_POWER_OFF;
>
> This is just changing the default behaviour, irrespective of whether
> the errata is applicable.
> What is the effect of this change for other boards / platforms ?
>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host->mmc, 0);
> > + =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0return IRQ_HANDLED;
> > =A0}
> >
> > --
> > 1.7.4.1
> >

Resending as plain text without any html content/formatting.

I did not see any -ve effects of turning off the power cell as soon as
possible when the SD card is turned off. This is why I did not
differentiate.

- Vish
