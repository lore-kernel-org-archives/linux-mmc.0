From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048
 with a platform hook.
Date: Mon, 6 Jun 2011 18:53:58 +0200
Message-ID: <20110606165358.GB14126@pengutronix.de>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
 <m3mxi6p7fm.fsf@pullcord.laptop.org>
 <20110601040050.GA24330@pengutronix.de>
 <m3sjru40yt.fsf_-_@pullcord.laptop.org>
 <alpine.LFD.2.00.1106011053020.30544@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45560 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1FFQyC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 12:54:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1106011053020.30544@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

> > > :( I still like the io-accessor-method a lot better.
> >=20
> > That's okay -- nothing's final yet, I just wanted to get things moving
> > again since we're out of quirk space now.  I'm still happy to take a
> > patch from you instead if we decide it's the better way to go.
>=20
> What about letting the platform specific code override the caps bits=20
> instead?  That would work for many other things as well, like the=20
> various DMA quirks, etc.  And that requires only one callback instead of=
=20
> one per parameter you might want to override.
>=20
> This should be made explicit with a dedicated callback of course, not=20
> via some magic in sdhci_readl() please.

I proposed a kind-of fixup() function once, but someone (Olof?) didn't like=
 it
because it broke abstraction. However, after Shawn's patch series turning s=
dhci
into a library, things might have become easier for this approach. Hmmm, I'd
like to try it, just have to see when.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3tBiYACgkQD27XaX1/VRs0IgCfcBiP0csVZBv1WDFjhbK3r2kH
2bIAn36XjHHUs+11c7gJE00lxXlYA6AT
=NjQx
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
