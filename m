From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] mmc: renesas_shci: remove wrong depends on to enable
 compile test
Date: Mon, 20 Nov 2017 21:40:00 +0100
Message-ID: <20171120204000.aza2oyrf3fx2hh65@ninjato>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
 <1510041442-15176-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dwu6g3r6g7grioeh"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50691 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbdKTUkC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:40:02 -0500
Content-Disposition: inline
In-Reply-To: <1510041442-15176-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--dwu6g3r6g7grioeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:57:22PM +0900, Masahiro Yamada wrote:
> ARCH_RENESAS is a stronger condition than (ARM || ARM64).
> If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.
>=20
> What is worse, the first depends on line prevents COMPILE_TEST from
> enabling this driver.  It should be removed.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Simon, you did the last refactoring, can you have a look, too?


--dwu6g3r6g7grioeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPaAACgkQFA3kzBSg
KbZ6nhAAgB/1QdbI5jstbQs7et7QB/4hw/v+d1Y2SNTgL9+ZfVmtafLuZ9/1J4nf
4nGQajaNpt/QcO31/smPFQsXTdT54Sk7Zb8TsJt7rz5xDPLxr0RI71hmAgkCeKAU
t+AzM60TOqt7aSRoFhf9bPZD+iiYVNjmNuxyXhlN6DkI/sQewGMMbKJwpp0YlsVU
LvlYUpSyy+zDDS5EFo5nQdweKnQu9wBd2zKs0gEdftH+t6/PlmjNoJVBXjtA8yEN
bnq42dtWOyM6O1q5JhNnyZ4XV0MviuyU90yyR2UOlqyFf0wcSVHyodK/VipbdnV4
AI+Fr/iNSOPflXJiswLPPmQsz81X0/y6TUGo6UaMrstbmtW3qGzRZgzHI5PL54Dm
FxVZMIlNiLIYJ0Y3RfxSlov4r8u1uXhEpRXvLjxAeZwa+905CSMaQfV2l8XN45W8
j9M8Pf1JARIaCdN2aGqZHwquMdc83jLNGxXYsNVVnfOk9e5vsoOkI1BJewvXZao2
F9iMc56G5XGwYFWfgxR14G4fNNJzrbJlNVoLlejEJ6cEb+bJxngBHmBp78mB6qtG
dB0aSArPlkPylBwyfKV4FeeVslCQg1d3vw9bZ2tT9/VfqQ6HcL5E8czV6mxPBOhD
HZN9Ky1Klbzh33HqQ23yDZlZmliaein+1pfEl4e+W/jgi9dAZbg=
=fUFs
-----END PGP SIGNATURE-----

--dwu6g3r6g7grioeh--
