From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: check interrupt flags in ISR again
Date: Wed, 14 Mar 2012 08:53:05 +0100
Message-ID: <1994979.AaWWmIIAYQ@ws-stein>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com> <1331659002-13743-2-git-send-email-alexander.stein@systec-electronic.com> <4F604B16.606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:57005 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751673Ab2CNHxH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Mar 2012 03:53:07 -0400
In-Reply-To: <4F604B16.606@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Hello,

Am Mittwoch, 14. M=E4rz 2012, 09:39:02 schrieb Adrian Hunter:
> On 13/03/12 19:16, Alexander Stein wrote:
> > When using MSI it is possible that a new MSI is sent while an earli=
er
> > MSI is currently handled. In this case SDHCI_INT_STATUS only contai=
ns
> > SDHCI_INT_RESPONSE and the ISR would not be called again. But at th=
e end
> > of the ISR SDHCI_INT_DATA_END is now also pending which would be
> > ignored.
> >=20
> > Fix this by rereading the interrupt flags in the ISR until no inter=
rupt
> > we care is pending.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.c=
om>
> [...]
> > @@ -2336,6 +2338,14 @@ static irqreturn_t sdhci_irq(int irq, void
> > *dev_id)>=20
> >  		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
> >  =09
> >  	}
> >=20
> > +	intmask_unhandled =3D intmask;
> > +
> > +	intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
> > +
> > +	/* Do interrupt handling again if we got new flags */
> > +	if (intmask & ~intmask_unhandled)
> > +		goto again;
> > +
> >=20
> >  	intmask &=3D ~SDHCI_INT_BUS_POWER;
> >  =09
> >  	if (intmask & SDHCI_INT_CARD_INT)
>=20
> Why not just replace mmiowb() i.e.
>=20
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..da8a101 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev=
_id)
>=20
>         result =3D IRQ_HANDLED;
>=20
> -       mmiowb();
> +       intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
> +       if (intmask)
> +               goto again;
>  out:
>         spin_unlock(&host->lock);
>=20

Well, I chose this way to only printk the error once. With your suggest=
ion it=20
might be printed in each loop, dunno how often/fast these IRQ stats are=
 set=20
again after clearing. This would end in an endless loop if error flags =
are set=20
again fast enough, but see below.
But in general I like this approach.

> But maybe it would be safer limiting the number of loops i.e.
>=20
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..d88247d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2268,7 +2268,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev=
_id)
>         irqreturn_t result;
>         struct sdhci_host *host =3D dev_id;
>         u32 intmask;
> -       int cardint =3D 0;
> +       int cardint =3D 0, max_loops =3D 16;
>=20
>         spin_lock(&host->lock);
>=20
> @@ -2353,7 +2353,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev=
_id)
>=20
>         result =3D IRQ_HANDLED;
>=20
> -       mmiowb();
> +       intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
> +       if (intmask && --max_loops)
> +               goto again;
>  out:
>         spin_unlock(&host->lock);

The actual problem I saw was a CMD6 command with an R1b response where =
the IRQ=20
for the 'not busy' event was sent during ISR for the response. So I thi=
nk=20
normally this should only occur once.
Regarding error flags I masked the unhandled flags out in order to prin=
t an=20
error only once, even if they might be set again in the next loop. With=
 a=20
simple check on intmask they might occur up to 16 times in the kernel l=
og.
IMHO it makes no sense to repeatedly print errors about interrupt flags=
 we=20
don't handle.

Suggestions to get a more clean way?

Best regards,
Alexander
--=20
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
