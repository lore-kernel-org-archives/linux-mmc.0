From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Thu, 21 May 2015 09:07:50 +0800
Message-ID: <20150521010750.GU26848@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
 <1431674695.13197.14.camel@transmode.se>
 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
 <1431693634.13197.29.camel@transmode.se>
 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
 <1431851766.6782.7.camel@transmode.se>
 <20150519092014.GR26848@pek-khao-d1.corp.ad.wrs.com>
 <1432133667.6782.81.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kSOhxpxUsM1s2qz/"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34304 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbbEUBH5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2015 21:07:57 -0400
Received: by qgez61 with SMTP id z61so28472583qge.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2015 18:07:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432133667.6782.81.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--kSOhxpxUsM1s2qz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 02:54:27PM +0000, Joakim Tjernlund wrote:
> On Tue, 2015-05-19 at 17:20 +0800, Kevin Hao wrote:
> > On Sun, May 17, 2015 at 08:36:07AM +0000, Joakim Tjernlund wrote:
> > > On Sun, 2015-05-17 at 13:06 +0800, Kevin Hao wrote:
> > > > >=20
> > > > > How about this one:
> > > > >=20
> > > > > From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00=
 2001
> > > > > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > > > > Date: Mon, 20 Apr 2015 22:36:55 +0200
> > > > > Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
> > > > >=20
> > > > > esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.
> > > >=20
> > > > Do we really need this for the 8bit bus support? There is already a=
 specific
> > > > API for setting the bus width, this change seems unnecessary to me.=
 That is
> > > > also why I choose to revert that patch. Did I miss something?
> > >=20
> > > We do, the bus API really only works well when the bus bits are in an=
other=20
> > > register but the HOST_CONTROL register.
> >=20
> > Sorry, I didn't get what you mean. Could you elaborate a bit more?
>   clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
>                         ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
> and=20
>   esdhc_writeb(struct sdhci_host *host, int reg) with reg =3D=3D  SDHCI_H=
OST_CONTROL
> is the same register so esdhc_writeb() will stomp on the settings esdhc_p=
ltfm_set_bus_width()
> did earlier.

The .set_bus_width() is the only API we use to set the bus width. We never =
do
something like this:
	esdhc_writeb(host, SDHCI_CTRL_8BITBUS, SDHCI_HOST_CONTROL);

So the scenario you mentioned above should not happen. That is also why I t=
hink
your changes is not necessary.

>=20
> >=20
> > > The only reason 4BIT works is because its bit placement is where=20
> > > SDHCI expects it to be. 8BIT is not, so unless readb/writeb funktions=
 compensate
> > > for that they will overwrite what the bus API set earlier.
> >=20
> > But the implementation of esdhc_pltfm_set_bus_width() already take care=
 about
> > this. And in the current kernel, we only set the bus width via this API=
=2E So why
> > do you think that it can be overwrote?
> >=20
> > static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int widt=
h)
> > {
> >       u32 ctrl;
> >=20
> >       switch (width) {
> >       case MMC_BUS_WIDTH_8:
> >               ctrl =3D ESDHC_CTRL_8BITBUS;
> >               break;
> >=20
> >       case MMC_BUS_WIDTH_4:
> >               ctrl =3D ESDHC_CTRL_4BITBUS;
> >               break;
> >=20
> >       default:
> >               ctrl =3D 0;
> >               break;
> >       }
> >=20
> >       clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
> >                       ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
> > }
> >=20
> > >=20
> > > Atleast this is my understanding, Ulf?
> > >=20
> > > Didn't this patch work for you either?
> >=20
> > I don't have a 8bit card at hand. For 4bit card, it works with or witho=
ut this
> > change.
>=20
> Sure it does, that was not the question though:
> Does it still work with this version of the patch?

I think I already answered your question. For 4bit card, it works with or
without this version of patch.

Thanks,
Kevin
>=20
>  Jocke

--kSOhxpxUsM1s2qz/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVXS/mAAoJEJNY7TDerrFxUNYH/jbAy0vwtDCIdiHMPd+RPY7G
rHz42z0xSKmod+nvmiSPwtrMerrj9CPJTyITK4tWk/3UFOFO90AfWvHkkv2VHHOW
i9xkIbzWCqnE6H6S0PJXIJ2m96nVYZQBju9TAFzhPDFXEBjOa1yWJjwbZvTBr2mI
pfwNkvOXMOpycPQP4KlWcYFtus9SwbdYJTGym/Z/zgX6AsPbxwWXb6t8M0j4Jo5c
CK+6KGkdfRp0CcrKEUBdwzwif1iLZzYem4zyJnhnt3d2LM7UbM4J3K0DzBwO0bjY
7OAgdpRgbbBqC8qFQ5lSKbgbBBmgkMbSelYtVgXItuDFr98uKkHUU9Mpa0+XUTA=
=9WiB
-----END PGP SIGNATURE-----

--kSOhxpxUsM1s2qz/--
