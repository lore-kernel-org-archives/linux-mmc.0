From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Fri, 15 May 2015 23:25:05 +0200
Message-ID: <3099867.Z5GbY7oWl2@wuerfel>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <2523437.y90mKuWhc3@wuerfel> <201505152322.37739@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201505152322.37739@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday 15 May 2015 23:22:37 Pali Roh=E1r wrote:
> On Friday 15 May 2015 23:19:44 Arnd Bergmann wrote:
> > On Friday 15 May 2015 23:14:48 Pali Roh=E1r wrote:
> > > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > > b/drivers/mmc/host/omap_hsmmc.c index 9df2b68..f6073dd 100644
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -1901,6 +1901,8 @@ static struct omap_hsmmc_platform_data
> > > *of_get_hsmmc_pdata(struct device *dev)
> > >=20
> > >         if (of_find_property(np, "ti,needs-special-hs-handling",
> > >         NULL))
> > >        =20
> > >                 pdata->features |=3D HSMMC_HAS_HSPE_SUPPORT;
> > >=20
> > > +       of_property_read_string(np, "slot-name", &pdata->name);
> > > +
> > >=20
> > >         return pdata;
> > > =20
> > >  }
> >=20
> > This property needs to be documented in
> > Documentation/devicetree/bindings/mmc/mmc.txt and preferably the
> > implementation moved into mmc_of_parse.
> >=20
> > We should not have an interface like this specific to one driver.
> >=20
> >       Arnd
>=20
> Interface is already present for platform data code (which do not use=
=20
> DT). So "pdata->name" is not DT specific...
>=20

The driver can of course keep providing the name from platform_data whe=
re
that is used. All I was saying is that when you introduce a DT property=
,
it should not be specific to that driver.

	Arnd
