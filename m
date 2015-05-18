From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property
 in DT
Date: Mon, 18 May 2015 08:06:07 -0700
Message-ID: <20150518150607.GD10274@atomide.com>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com>
 <2523437.y90mKuWhc3@wuerfel>
 <201505152322.37739@pali>
 <3099867.Z5GbY7oWl2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3099867.Z5GbY7oWl2@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [150515 14:26]:
> On Friday 15 May 2015 23:22:37 Pali Roh=C3=A1r wrote:
> > On Friday 15 May 2015 23:19:44 Arnd Bergmann wrote:
> > > On Friday 15 May 2015 23:14:48 Pali Roh=C3=A1r wrote:
> > > > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > > > b/drivers/mmc/host/omap_hsmmc.c index 9df2b68..f6073dd 100644
> > > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > > @@ -1901,6 +1901,8 @@ static struct omap_hsmmc_platform_data
> > > > *of_get_hsmmc_pdata(struct device *dev)
> > > >=20
> > > >         if (of_find_property(np, "ti,needs-special-hs-handling"=
,
> > > >         NULL))
> > > >        =20
> > > >                 pdata->features |=3D HSMMC_HAS_HSPE_SUPPORT;
> > > >=20
> > > > +       of_property_read_string(np, "slot-name", &pdata->name);
> > > > +
> > > >=20
> > > >         return pdata;
> > > > =20
> > > >  }
> > >=20
> > > This property needs to be documented in
> > > Documentation/devicetree/bindings/mmc/mmc.txt and preferably the
> > > implementation moved into mmc_of_parse.
> > >=20
> > > We should not have an interface like this specific to one driver.
> > >=20
> > >       Arnd
> >=20
> > Interface is already present for platform data code (which do not u=
se=20
> > DT). So "pdata->name" is not DT specific...
> >=20
>=20
> The driver can of course keep providing the name from platform_data w=
here
> that is used. All I was saying is that when you introduce a DT proper=
ty,
> it should not be specific to that driver.

Yes sounds like it would be a usable generic binding. Not sure
that it should be called slot-name though, maybe you can use
the MMC driver instance name instead? I don't think much any drivers
support multiple MMC slots although it's in the original MMC spec.

If setting up the generic binding is expected to take a while,
you can naturally pass it in pdata while waiting for the generic
binding to get merged.

Regards,

Tony
