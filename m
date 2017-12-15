From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Fri, 15 Dec 2017 17:30:55 +0100
Message-ID: <20171215163055.vxxiswgsvfybf4hi@katana>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFqE7Pg8fJFyOtihdRnma+dFQd3+YPWGn6pXbpzhpERK9Q@mail.gmail.com>
 <CAK7LNASQfsnQY6henk5RvAysQUh3=cPXV1GPNeWeXgBxZvadAw@mail.gmail.com>
 <20171215111225.ekrau5e27xknb3jf@ninjato>
 <CAPDyKFopKm2psU19vGQfGL6WizXQA0vvzQubqsypvytbpRtyAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hap2cul7cpxi6p4d"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53426 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932512AbdLOQhi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Dec 2017 11:37:38 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFopKm2psU19vGQfGL6WizXQA0vvzQubqsypvytbpRtyAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--hap2cul7cpxi6p4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Ulf, this patch then in deed should ideally be applied before 1-8 here.
>=20
> Okay, once you post it to linux-mmc I will pick it up, and put it in fron=
t.

Bad news, that patch didn't help. The problem is that sparc64 doesn't
include 'asm-generic/io.h' and also has no own 'readsw'. No surprise
that just adding this include will cause lots of redefines which are way
too much to handle as a side-task.

So, the best option I see here is to drop COMPILE_TEST for now, report
this to the sparc64 maintainers (I assume they know already), and see if
they can fix it.

Other thoughts?


--hap2cul7cpxi6p4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloz+LoACgkQFA3kzBSg
KbYCEQ/9F0JemgG6APDVBDDiD7bdz8pirpaoUI9A3WiyjaospSzaTwO5NTlNEIHc
qsnzMexXBKjyGQNV0Z/v0NUv5XxaY+LAGvXVOkD6wZ+wjTbw/73yALJ5cVWN4mXC
WY/MXoCBNvPjHLHY7Ibkf/2axSd3umc4kGqzsPUhLAM4LE/aAOZOBxD0P3PLZEPg
sYjUwsEzAHRCc6adF2iIS1Rj9R2ZuwJXRqayJ7C3OBlXLxz2TaMv97XA9Ec/t+T9
H/rrHMtnkrOPi0htzzpTZYerhVTeRxbxfmAW1ikS6FiWg6EEWRJxn5FV1pEHGjnn
9v0v0vDWHhEan/rl7RiDjfgVfkQ93HGpsMIRHqe9DT9ozqZ8t/eQtCK2GKMk0EYt
AN1urJ5j1Ut86BHszrOOx95r1wv6R3DywDcWXCGyPgKmqzD1r+iNin00ID1c7hGA
CqZ7e5jBPMQxdHfo532Cy+PTKMh20jF2JX0EcwCpg/qQG1/WBV8l+l1VSrJOndlJ
3hrxt8H25bZgrE7eaMyolJx+Ag0PlwgV78suGpBofv69Ye/prQdMNgSORO92MH1g
JNb4mRdPG7yar7hqyuNNP1UbEPiA5NpN1X6w7lUOiCkgRb/cH+WkwVce1aIkmmxI
RvOqcsq/c+ZctwsQ/+jKd9TgQ5w5r79BCAXNK5PuhNn3ZbgH2LQ=
=+uPw
-----END PGP SIGNATURE-----

--hap2cul7cpxi6p4d--
