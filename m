From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Tue, 19 May 2015 17:20:14 +0800
Message-ID: <20150519092014.GR26848@pek-khao-d1.corp.ad.wrs.com>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
 <1431673364.13197.10.camel@transmode.se>
 <1431674695.13197.14.camel@transmode.se>
 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
 <1431693634.13197.29.camel@transmode.se>
 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
 <1431851766.6782.7.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Qexx6XJGNEACt6j"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35423 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbbESJUV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 05:20:21 -0400
Received: by qkdn188 with SMTP id n188so456572qkd.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2015 02:20:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431851766.6782.7.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--0Qexx6XJGNEACt6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2015 at 08:36:07AM +0000, Joakim Tjernlund wrote:
> On Sun, 2015-05-17 at 13:06 +0800, Kevin Hao wrote:
> > >=20
> > > How about this one:
> > >=20
> > > From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
> > > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > > Date: Mon, 20 Apr 2015 22:36:55 +0200
> > > Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.
> > >=20
> > > esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.
> >=20
> > Do we really need this for the 8bit bus support? There is already a spe=
cific
> > API for setting the bus width, this change seems unnecessary to me. Tha=
t is
> > also why I choose to revert that patch. Did I miss something?
>=20
> We do, the bus API really only works well when the bus bits are in anothe=
r=20
> register but the HOST_CONTROL register.

Sorry, I didn't get what you mean. Could you elaborate a bit more?

> The only reason 4BIT works is because its bit placement is where=20
> SDHCI expects it to be. 8BIT is not, so unless readb/writeb funktions com=
pensate
> for that they will overwrite what the bus API set earlier.

But the implementation of esdhc_pltfm_set_bus_width() already take care abo=
ut
this. And in the current kernel, we only set the bus width via this API. So=
 why
do you think that it can be overwrote?

static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
{
	u32 ctrl;

	switch (width) {
	case MMC_BUS_WIDTH_8:
		ctrl =3D ESDHC_CTRL_8BITBUS;
		break;

	case MMC_BUS_WIDTH_4:
		ctrl =3D ESDHC_CTRL_4BITBUS;
		break;

	default:
		ctrl =3D 0;
		break;
	}

	clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
}

>=20
> Atleast this is my understanding, Ulf?
>=20
> Didn't this patch work for you either?

I don't have a 8bit card at hand. For 4bit card, it works with or without t=
his
change.

Thanks,
Kevin

>=20
>  Jocke

--0Qexx6XJGNEACt6j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVWwBOAAoJEJNY7TDerrFxICUIAIWEEQZTEmai9K9gcNKrUNUb
S+Mm5QJl0st0e/vhxlzYEe0lZCJ/izuIYMW/pQWolN4f8QGtrXLIN1U5+Ns7doTa
owjQz7MX+QHieGotecRiyWSvzu1XnDCcLikw6KftHcPybQ5+TB617TqGWGlUNhxk
U3S5rYJT3YQkHM7zakRdLjR0tr1GU6mE1wUyMrQ5QJE3j/viy/F/xVi+M20ldquI
DMmIScGK1PwpOx3FjCuWPoGzUV2qekt+Yz4agtBLZ3XTjR/lTvvG4FIyCfM/p2eW
KDQyTx7LNfq/86SKIJBMlnagF8g+QTLw5xDqzgNixGtXkv9ti/dn5zvgCnEkw0g=
=dXGC
-----END PGP SIGNATURE-----

--0Qexx6XJGNEACt6j--
