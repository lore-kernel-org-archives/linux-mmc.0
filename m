From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead
 of MFD
Date: Sun, 13 Mar 2011 00:00:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103122358380.28741@axis700.grange>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <Pine.LNX.4.64.1103110845220.23675@axis700.grange>
 <AANLkTikjTNVQT7gzhGQy-wKmfTT=BWikAJ+Wo5+-kZvX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60374 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab1CLXAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 18:00:45 -0500
In-Reply-To: <AANLkTikjTNVQT7gzhGQy-wKmfTT=BWikAJ+Wo5+-kZvX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Sun, 13 Mar 2011, Magnus Damm wrote:

> On Fri, Mar 11, 2011 at 4:52 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > The CONFIG_MFD_SH_MOBILE_SDHI Kconfig symbol is going to disappear =
soon,
> > switch ecovec to using CONFIG_MMC_TMIO(_MODULE).
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/sh/boards/mach-ecovec24/setup.c | =A0 =A06 +++---
> > =A01 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/=
mach-ecovec24/setup.c
> > index 52751f0..37ad5dc 100644
> > --- a/arch/sh/boards/mach-ecovec24/setup.c
> > +++ b/arch/sh/boards/mach-ecovec24/setup.c
> > @@ -462,7 +462,7 @@ static struct i2c_board_info ts_i2c_clients =3D=
 {
> > =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ0,
> > =A0};
> >
> > -#ifdef CONFIG_MFD_SH_MOBILE_SDHI
> > +#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
> > =A0/* SDHI0 */
>=20
> What's wrong with CONFIG_MMC_SDHI? Too early in the patch series?
>=20
> I can't really see what the ecovec board has in common with the tmio
> mmc implementation. Or did you mean the CONFIG_MMC_TMIO_CORE?

Right, sure, it must be CONFIG_MMC_TMIO_CORE. CONFIG_MFD_SH_MOBILE_SDHI=
=20
has to go, because it is removed in a future patch. Will resubmit, than=
ks!

Regards
Guennadi

>=20
> Perhaps this is just a stop-gap solution and it is being fixed in V2 =
patch 7/7 ?
>=20
> Thanks,
>=20
> / magnus
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
