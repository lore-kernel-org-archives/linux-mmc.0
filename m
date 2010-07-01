From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/2] OMAP HSMMC: Adding a Flag to determine the type
 of Card detect
Date: Thu, 1 Jul 2010 15:32:16 +0300
Message-ID: <20100701123216.GP2822@atomide.com>
References: <43583.10.24.255.17.1276788418.squirrel@dbdmail.itg.ti.com>
 <20100617131911.de257575.akpm@linux-foundation.org>
 <AANLkTikInbivUfkulAf7RZyaIjRo9GuxvQjRHHE1duCY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53761 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab0GAMcK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2010 08:32:10 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikInbivUfkulAf7RZyaIjRo9GuxvQjRHHE1duCY@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com

* kishore kadiyala <kishorek.kadiyala@gmail.com> [100621 09:49]:
> On Fri, Jun 18, 2010 at 1:49 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Thu, 17 Jun 2010 20:56:58 +0530 (IST)
> > "kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
> >
> >> --- a/arch/arm/plat-omap/include/plat/mmc.h
> >> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> >> @@ -43,6 +43,9 @@
> >>
> >> =C2=A0#define OMAP_MMC_MAX_SLOTS =C2=A0 2
> >>
> >> +#define NON_GPIO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
> >> +#define GPIO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1
> >
> > I'm counting about seven different definitions of "GPIO" in the ker=
nel
> > already.
> >
> > drivers/hwmon/it87.c:
> > #define GPIO =C2=A0 =C2=A00x07
> >
> > drivers/media/dvb/dvb-usb/ec168.h:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 0x04,
> >
> > drivers/net/hamachi.c:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0GPIO=3D0x6E
> >
> > drivers/staging/rtl8187se/r8180_hw.h:
> > #define GPIO 0x91
> >
> > etcetera. =C2=A0It's a crazy identifier to use in a header file, an=
d
> > the chances of a miscompile-causing collision are increasing.
> >
> >
> > enum cd_type {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0CD_TYPE_NON_GPIO =3D 0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0CD_TYPE_GPIO =3D 1,
> > };
>=20
> OK , Will repost with above changes

Please also do it the other way around where you pass CD_TYPE_NON_GPIO
in the flags in the platform data. Then there's no need to patch
all the existing boards.

Tony
