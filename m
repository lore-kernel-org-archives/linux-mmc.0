From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: consilidate DMAC CONFIG options
Date: Mon, 20 Nov 2017 21:39:30 +0100
Message-ID: <20171120203930.x4wwb35jvf4h2fqu@ninjato>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
 <1510041442-15176-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6mw6notkvwsczvdu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50685 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbdKTUjb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:39:31 -0500
Content-Disposition: inline
In-Reply-To: <1510041442-15176-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--6mw6notkvwsczvdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:57:21PM +0900, Masahiro Yamada wrote:
> The description in the Makefile is odd.  Fix the CONFIG selection
> in a cleaner way.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Simon, you did the last refactoring, can you have a look, too?


--6mw6notkvwsczvdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPYEACgkQFA3kzBSg
KbavHA/8DGoE8dKljra+4CFKs1c/ytb/EDEOyhr/qjdD9l6PV/gqE5hUghHPf6SZ
huHFAleZXP8MsvlksPCH69Rf3st86QbAonV4G892l7/AmBurcw88PlXZzRXeWW4W
i2I0Ue5s9ZGEYfqCOnpA4kfCc6ToWzuJxXeygNLVSUq0uNOSvvkXlZyWj28ghz1o
Y3ZJMPCSciMGWKHydz2+LclB9DLqUrrbeJVLKGGvoZrVygWSbM7Ce3pVDYdwy6aY
cVaQhnPi61K4Q8yM2N8Xe/Ns1gDXVk7sHKoLLiL3Yiudm6/B6OjOAa5C1L5gEW3K
aep1T5p+BAih2OTtZPa6U00Z0nTuRfTxgYhFfWn/X+f/UsFf+uevaJVzRW8jMvmV
xuPdZvpdk6TRLakJonrwm3XuNezZ0tKltUFKj/Km8MYql/gChBVA/GGZ9mu7zkhZ
G8J2+OyPZae6f47EE5U4/lK3V2Xb/ZcvfYMFYnhZjuCbMG8AODgZ8vjKov3+7ECv
OTSbo/yKuiTQfuoQEIVHnLhq7MGnHmmYfWspKfL2Nv2z2VFiVh2sZyI8BqNr5RZr
a/CX7uFHgVKHBfXGYB+7nfQTBKBvA6+vDn/fIDjxhOhVgp6iLlGfgjVybTDnWv3Y
ILRl9akFHlwYf6eqvosPNFg3Wl+FU6iTaSSL5agWYFPWGtAoTGc=
=r7mG
-----END PGP SIGNATURE-----

--6mw6notkvwsczvdu--
