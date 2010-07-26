From: "Gabay, Benzy" <benzyg-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
 powered 	off
Date: Mon, 26 Jul 2010 13:33:10 -0500
Message-ID: <676FD6AA0F002F49B89E70F0C5EFD22C131128FA47@dlee04.ent.ti.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
 	<1279733634-21974-20-git-send-email-ohad@wizery.com>
 <676FD6AA0F002F49B89E70F0C5EFD22C1311192A47@dlee04.ent.ti.com>
 <AANLkTim3RWv2-qi9UMg1imwKTJuh3GstdjMTxz64uOHf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTim3RWv2-qi9UMg1imwKTJuh3GstdjMTxz64uOHf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Ohad,

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, July 22, 2010 6:18 PM
> To: Gabay, Benzy
> Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org; Chikkature Rajashekar, Madhusudhan; Luciano
> Coelho; akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; San Mehat; Roger Quadros; Tony
> Lindgren; Nicolas Pitre; Pandita, Vikram; Kalle Valo
> Subject: Re: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
> powered off
>=20
> Hi Gever,
>=20
> On Wed, Jul 21, 2010 at 9:55 PM, Gabay, Benzy <benzyg-l0cyMroinI0@public.gmane.org> wrote:
> > From: Ohad Ben-Cohen [mailto:ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org]
> > Sent: Wednesday, July 21, 2010 12:34 PM
> > To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linu=
x-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org;
> Chikkature Rajashekar, Madhusudhan; Luciano Coelho; akpm@linux-
> foundation.org; San Mehat; Roger Quadros; Tony Lindgren; Nicolas Pitr=
e;
> Pandita, Vikram; Kalle Valo; Ohad Ben-Cohen
> > Subject: [PATCH v2 19/20] omap: zoom: keep the MMC3 wl1271 device
> powered off
> >
> > Keep the MMC3 wl1271 WLAN device powered off until its
> > SDIO function driver requests otherwise.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> > ---
> > =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A01 +
> > =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 +++
> > =A0arch/arm/mach-omap2/hsmmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> > =A0arch/arm/plat-omap/include/plat/mmc.h =A0 =A0 =A0 =A0| =A0 =A03 =
+++
> > =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +++
> > =A05 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > index 3230801..3ab9125 100644
> > --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > @@ -217,6 +217,7 @@ static struct omap2_hsmmc_info mmc[] __initdata=
 =3D
> {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ocr_mask =A0 =A0 =A0 =3D MMC_VDD_16=
5_195,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dont_power_card =3D true,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.priv_data =A0 =A0 =A0=3D &omap_zoom=
_wlan_data,
> > =A0 =A0 =A0 =A0},
> > =A0 =A0 =A0 =A0{} =A0 =A0 =A0/* Terminator */
> ...
> > --
> > 1.7.0.4
> >
> > [Benzy Gabay] small comment: Please make sure that all 127x related
> changes are not bounded only to MMC3.
> > On OMAP4 WLAN is used on MMC5.
>=20
>=20
> The only place MMC3 is bound is in the board files (see code snippet
> above), so that should be ok.
>=20
> I can probably split this patch to make this more obvious just by
> reading the diffstat if you prefer.


Yep. That will be great.

Benzy


>=20
>=20
> Thanks,
> Ohad.
>=20
>=20
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
