From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] mmc: sdhci-s3c: use the sdhci-pltfm.c and move
 the header file
Date: Tue, 6 Mar 2012 16:30:52 +0000
Message-ID: <20120306163052.GX19635@opensource.wolfsonmicro.com>
References: <4F55ABF0.1060801@samsung.com>
 <20120306130054.GA9890@sirena.org.uk>
 <201203061415.18836.heiko@sntech.de>
 <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ycl1UgPPPgGZoSL"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48991 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755294Ab2CFQay (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 11:30:54 -0500
Content-Disposition: inline
In-Reply-To: <CAELcNGS6UynrJPRk1KtEJT3Rm6Jb5_scLm4KKca+dJ1ZYDOVbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, kgene kim <kgene.kim@samsung.com>


--4Ycl1UgPPPgGZoSL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 11:40:08PM +0900, Jae hoon Chung wrote:
> 2012/3/6 Heiko St=FCbner <heiko@sntech.de>:
> > Am Dienstag, 6. M=E4rz 2012, 14:00:54 schrieb Mark Brown:

> >> This series will break S3C64xx, you've not touched it at all in the
> >> update but it uses the same SDHCI controller.

> > This problem will probably also surface for the S3C2416 which also uses=
 the
> > same SDHCI controller.

> i didn't know why will break  on them. Could you explain to me?
> Are there codes which affect S3C64XX and S3C24XX?
> If i miss out something, let me know.

The same IP is present and used with the same driver on other Samsung
SoCs.

--4Ycl1UgPPPgGZoSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVju1AAoJEBus8iNuMP3dsBAQAIJ4hpSIa0wssqHypr31++jQ
ut1fxUkl1L00sEI5z09SySvM77NFz2EEWXMGO3vim0SuipI0DOkwlrHAOZcqbHax
7zk/uKgDZ028lKqDNYajRr51TEr7SQ5pHh/aP7Bt3AWHB0EgF/XQ4Bo7jT++J/OF
AdxFBr16kVQOYHzAqQdTa11JPY8aHaC2CmgTfDz0lIXAtu+bwRb7lJXO202Vsmbw
7S2BUEtrLntHA2l6T3dilLOIPUbMhshJVjya6AKhdGfb1Dg4Xo+2yEPLCTLcfkcX
kqyeuN9+4Q9+W3jjVfuN0uR8KOFKSqi/TKtjH0Gb/2yPiLIiUv/kNP9DgJ9Pzq/8
/DEf1Q+Vm9iihYxLPqMcS4pwfKwfhEIOxmymZAcSjH1v5RUDv/pTRpEI1F7+lUtL
jhCeNwUmhXGUECyeZYGss4MvFAGVI65E5Helyfj5KjsOgNzsfM4TksUJHkj0sOuE
1nboHkO3UD4jddGnP/6yzEauMZEsTYpO4Kgj8ve3Bg1vV7tayCJxr2LshzPMwk4J
ndvCF0nRZYBbcFLVh62YXe9L+epFHxOD/4/LKJKXqnO1AUumWs5YWTwtloNanMFA
BnTdPveBhQ6Wl9WJFYR89eIY4ErAPsSZ81u/hleI3k5b1dE5kVUG4FcDGXRwwBjo
ddgKrxhbTWk+pxrfMF11
=emwT
-----END PGP SIGNATURE-----

--4Ycl1UgPPPgGZoSL--
