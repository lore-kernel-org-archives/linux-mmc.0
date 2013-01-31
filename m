From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Thu, 31 Jan 2013 08:00:53 +0100
Message-ID: <20130131070052.GA31996@avionic-0098.mockup.avionic-design.de>
References: <1359576681-14797-1-git-send-email-thierry.reding@avionic-design.de>
 <20130131003118.GC2765@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55749 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab3AaHA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 02:00:58 -0500
Content-Disposition: inline
In-Reply-To: <20130131003118.GC2765@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 08:31:20AM +0800, Shawn Guo wrote:
> On Wed, Jan 30, 2013 at 09:11:21PM +0100, Thierry Reding wrote:
> > Commit 3f175a6 (mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from
> > IO accessory) removed all the code that was using these variables, so it
> > is safe to drop them.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Thanks for the fixing, Thierry.  But Chris has already queued a fix [1]
> from Fabio.

Okay, great!

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRChakAAoJEN0jrNd/PrOhJVcP/iRLLWTBvjx8oYRKO0g0kdT0
RcBbvEO4vJfSQk6zbt/1989U3+zqYj7iMhZIDTOKS/ObMVkWpR/TbKLt2DgRMGo1
AhEMCTAVdXgtORjR6+xG+rmvcAtG2xFR4xJS0gUu2KHD+Jsdsa+cYbR35jX0Wcea
CyhlUIxxliSKaodukFJyCXp1XvJZoJoJd6Cz6cpMMlH6TvxrgWwlH1aLX1m9TDoL
9D7rd/opLfcnKA09rx5KBH8lscT2ViJfXJKG2n2Tmf5bWtnesQ4THURaH57EwOOL
gvwYxY2JbjP2m97kOoRmAuj5p4jP+0eCyIU3S+KXa1OZwxGkDbqDkRPmhSxm7plo
cDkpeelKHianVoFYWGivc+LXOSI22Soq8leoeq4+cuGYAXWmiLq0kA2qtyfLzBCY
Caon2qU+PsNCipwrckA5XCgvzsLFcckXdcO5DGkJqeF46Z5jHsbHD4dquoAU+r1I
GZFXZUlRAF9C93X2i8XxqU3wwIiKjWwHzwCxaFisYbd/A+6mAqY4KV6/FPTdPL82
rUyDZ5r2k6D//H74ZC/PpM/zJeFPQVgmMMkqhF/3ZPK71ly2DbW02EHOA3R48G0L
if4bCqHFl7LytzitbZiLN4JWBRENm+BJvCkva5Ag/hOyxuI3J8yXFgFZPOWSRlGp
SFFw0+emMxKs6IWl1LqX
=EGEG
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
