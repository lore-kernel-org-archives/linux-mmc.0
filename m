From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mfd: tmio: move register macros to tmio_core.c
Date: Mon, 20 Nov 2017 21:52:02 +0100
Message-ID: <20171120205202.3f3ikjyp4zfwbjqr@ninjato>
References: <1510042453-27619-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dpjrbdvlfxdo4l2k"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50797 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbdKTUwD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:52:03 -0500
Content-Disposition: inline
In-Reply-To: <1510042453-27619-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>, Simon Horman <simon.horman@netronome.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--dpjrbdvlfxdo4l2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:14:12PM +0900, Masahiro Yamada wrote:
> These registers are only used in drivers/mfd/tmio_core.c
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Well, yes, why not...

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--dpjrbdvlfxdo4l2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTQHEACgkQFA3kzBSg
KbZYlQ/8Ca46kybykuHqvJb9hG5OLMTJEt5jpKMSESBHMV84yfCRn57MIbj8Qdx9
E1tpztU6QHKHwSUNh1SS5shh2CnP536HHWQHYuLI8xLLTe/5FL2M5JD7sLW0PUV8
/ueBeDBG/4Gb6YOoEqezwhoAp4UBOGpcBHDxrLR9NA0Wq3TKw3QPjdzBiblCAqCj
qCvTLkBnX5raM3B4AnJx+qsvIxqg0n/FR0E7yUqkouJM7VEIb9SvDAsgbo7CqBG8
hVAPjHx0jd9zeAUsnzr03eb+CkbpKRXSggG2OLUcS0cDbJSkaTbJP7h1fg9KK5o0
NjoaBxgtc7Cue8PXUpxXAtFgISEakVeLDXlaX3KtcONqOUToQiED8fN4skbSGuwl
yDqVnQ0NufeuApXB08N0cWOH7fvojis108Fcjixcs7ogqmOSx/ZVyhW2EjMzKU/C
J+mlGWVKzkSBc4AcLDR9IrJo0xYtNdmqC1QTuE8PMGywzmPWy/2JTGapqU8NwnKq
y1dNvtKoUI0/pPYzMeZDZ/wRMwX1qRuC9+KtICN94Xv6SiEUMDRBQNA9pLZrGQmI
3CK2n1cXEQmaD/U2NXvwPoQ/tJSz6ghL8LOeoMKM4prh0ib5ddz6aSD1OvtNhebm
ogZ/VyWn6qn07NFmPhHywsIAp9816jI9awteV/w3YlpYgmXOjus=
=Qwag
-----END PGP SIGNATURE-----

--dpjrbdvlfxdo4l2k--
