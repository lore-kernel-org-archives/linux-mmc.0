From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and
 cleanups
Date: Sun, 4 Mar 2018 23:42:48 +0100
Message-ID: <20180304224248.mzhsvl4ccmtzg5am@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yszxsr7oewrqteql"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--yszxsr7oewrqteql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:28:00AM +0900, Masahiro Yamada wrote:
>=20
> In the previous batch (https://lkml.org/lkml/2017/11/24/428)
> I sent 22 patches for TMIO MMC.
>=20
> 14 patches were applied, the rest is under discussion.
>=20
> This series consists of 16 patches.

Which I tested now, so we can add

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

to the patches except for

> Patch 12: updated per Wolfram

this one which needs a fix. I will send it as an incremental patch.


--yszxsr7oewrqteql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqcdmgACgkQFA3kzBSg
KbZk8Q/9HwCGNFQurY6N8ZOxjaTvUVyMWSSfTRbGAIq5dE8cDMsIzKjxzurENvNs
1eg1aq2HG/W59pbCcqbt5rcCwtnqWjXjXprbVXQWbDxOfDh5MracWtCsyGxiDvLt
MADjdQlRBEumF2XGlVpcSgFmQqG/W3vjvPXaYijInc8twkIGOd/bPU71Kt4bQXZV
5Ft4VOLK/JQXfysIqHDZL9z1LTeCMeJ1Ow6+vK/izpTS9O2sv5a/ZmjnQKLEX+8V
GZdaLDEsZ1CbAmMj0ByQ3udvqrw5K8j+MpR41T6wb2XilMG8a9i+PsuRG517P+94
DLq0PnyUy4ABEAzR6/fGhuera1x6oRSvYzOfuXtwy0n+xPS2Nq0gSaDnO6VWYoBg
kjoUDdujpFbFV2mc7eaV+oHfRLzCFO3hmm8NlQGIY59/ESmk5Fq2dtcIKarYaYkS
phWN8dgpE6uiMeCFuzdeXwloYcCw5kehYfxBgHmVGQuRlNqsWQnr7W6tvqOgxbFh
UDATbvqQ+haeKmrzduMjrtSNKwk2kK95T2vrCDK3XUMDou2N6hmkL0VFbOuxRe9p
WQ9ayT/rEI0N2z6QG64E4KED89FgZu7B6KWCC4Yo40pb45xjxZQUEavPmXQbzoTb
vi9eMvgMsgeJy7JSv1TW1QUclewYXxPhK0puxY5r0QuyzRZTDDc=
=8bck
-----END PGP SIGNATURE-----

--yszxsr7oewrqteql--
