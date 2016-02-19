From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND 3/3] arm64: dts: r8a7795: salvator-x: enable SDHI0
 & 3
Date: Fri, 19 Feb 2016 18:58:23 +0100
Message-ID: <20160219175823.GA1392@katana>
References: <1455548510-1690-1-git-send-email-wsa@the-dreams.de>
 <1455548510-1690-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455548510-1690-4-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 04:01:50PM +0100, Wolfram Sang wrote:
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>
>=20
> Add the exposed SD card slots. The on-board eMMC needs to wait until we
> fixed the 8bit support (it works with 4bit if you really want it now).
>=20
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Simon, if you apply this, can you drop the sentence inside the brackets?
It is probably not true until I fix the timeout handling. Or do you want
me to resend?

Have a nice weekend,

   Wolfram


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWx1e+AAoJEBQN5MwUoCm2HxcQAK0+8xoTFBPWxBo4sboCrUnH
veWd/lWLgW34Nhp5NceEv2vEcguLgqUOdirI5Tp1omJnLlpwMeeMCy5SqULE0On0
OFzJETn7Gd64/lfANDL9A6nEFmZu5FSpHLxnz9ZL/jU896MvcbvWWtUNVvJfrXMW
T+A+SZulZXyXvXKFUYmhO09QK53X7tu2xLsVr+Zwzx7z6AqnAJpPgVotxhDzK0Ns
Z+LTOmOkA9rfhrz+K3CJvdmb/dIgns9zyh5hICJL+JDVjmsD1E0pO1nGPu5X7RmB
Rrp2Vv4JmKVchCCQpbDRwqgi1xm8bqK1P9pdCOU89HzqRqM41J8C9l8qQba/AtSD
P6tNn0SCfUeoSfjN0GTtaK21fXXmRgGrcIITP9jDTncRZLER6jifPcSSsZs1GQpN
NTqCZoOvorqIb8qYFNYEpvM9q99YEgSTaCjsGaxyl5yIaDnQA1C4rZHxDliEobNe
pbTIC2Z0P/MdEnqE9+6DkXBr6DzC7i848niNC+zmwJMYTpN1EjQMzB/bMAMHLosD
qmVsNJdSE5cwV5ERPrknDQNwJp7zPySg888Hy72jmVuldMFQ6LB9j/zYEHnA1dXH
zecdLmxKBldU40yAWPF4gvDiLL9s8kiRBjy9y6eQYGSRIQpBbA3pfZHvNUJekBEl
01gEgOtzYI8VvWpPwN1a
=xJox
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
