From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 02/22] mmc: renesas_sdhi: remove wrong depends on to
 enable compile test
Date: Mon, 4 Dec 2017 16:25:33 +0100
Message-ID: <20171204152533.w5ykfqtkk6kzydet@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="palh3n6aloi4bzu6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--palh3n6aloi4bzu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:37AM +0900, Masahiro Yamada wrote:
> ARCH_RENESAS is a stronger condition than (ARM || ARM64).
> If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.
>=20
> What is worse, the first depends on line prevents COMPILE_TEST from
> enabling this driver.  It should be removed.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Because COMPILE_TEST now works, buildbot spotted something:

https://www.spinics.net/lists/linux-i2c/msg32556.html

Likely, we should include linux/io.h in the header?


--palh3n6aloi4bzu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlolaO0ACgkQFA3kzBSg
KbYmog/+KW+pbfK6SEf+7qBqUj9mHi6wdUR9W161pSr5yBNOMT0y5bDYbQQ+5OiX
HjKCvUwijSmtOy93EqBrR9PDXKzMujqwmXnzYalGgJMQo43rcpQtmSaY8OeVF1Jm
0JauudgwFoU1sbRRijCjVTLt2069GrRtxYyMwceaCovz1WcFHgdITHyfxODjlZlS
OBoqQu9Yws8S/LCpcXi3+krrO61mXnP+IdoE8t9oyNpFq5TWPQMePtHMYNKYZsco
kiEKMUDyiRlVNbrZiURzUdMic2KlvcG/P5XhVX8V2yUm6HZM4RQ/+yI3yclmbe3T
x9a1taNsqLdWs1Nl7vMQ5fVeNNyIFt4SkM2u2LUyUTPfig5W2VIBKO48X7iakC1m
/gfzuYkv71hhOm7CPHWuQ29TPq5EYWdJuwx449cse1xUWPAVYMfZbBwDU6a6JrEo
nikrOPpRBBNTDxvZrs4d+6ZnhY1JYVcunmtj0J9y90cfprI4DL5YlzVPtww6CXwB
nkJ6X3m51B3WCoqLIJ9lBjJr//mzmm2E5UcrluuFm/ITb6n/KaGXYejVw0vOxRD8
9Yaozw95mFuJ4AVjBc0WxThYHWQiIkhWADoZmcP4gXF0mVArJKAe3ex6HVS7s70h
PVIKZ4d9umAfdl+5xQ4pnnsQiZYoy1525uFBkitjM6ogtsIpXIk=
=EV3L
-----END PGP SIGNATURE-----

--palh3n6aloi4bzu6--
