From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 3/3] ARM: dts: r8a7790: lager: Enable UHS-I SDR-104
Date: Wed, 11 May 2016 14:44:41 +0200
Message-ID: <20160511124441.GA1716@katana>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-4-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoRjZjC=uEBvJsWYwu0EMEZwO3zS0JWNwVoBR8zjakMpnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoRjZjC=uEBvJsWYwu0EMEZwO3zS0JWNwVoBR8zjakMpnA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> SDR104) while SDHI2 and SDHI3 do not have this hardware feature. How
> is this difference handled today?

We read out the version register. (That reminds me I have a
documentation patch for that lying around...)


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXMyk5AAoJEBQN5MwUoCm2zq0QAIflxIOZEgBIfYon9caqhpx/
ROD/21QtUzTm7ufS6E1rFBzjpmJDjib3Y6kl+TzvIF7+8nZOt1s1oHxzGXNwWdAS
+fue08X4j+5UDqCLTCjVWNpbZcuIXXRvRr9t8BWXQ2XNaSZ2B+MiLiyPGH+wLAEx
Tu0F/6yqfp8n5QqzQZmewWChKV7c3BzatEsEXts2iNYqa6sItYJYlFPkZmn7OKHW
KEgSVVMJPYniilo8YUAvHjZA2Cu475JhvcE/u4gCUxrGuRttjyUypumsCWmW355s
6g27ZiQtHsWA1ZUD3mnknLPv9B+QZhwYl0l54JlhazPbUv/GjSuM2lt7rin+f1DV
fNw/PUcPJlP5eM5L3SbLfzMpTeyE35qo0OZn9jgU6m2TR1hBzP5w9DSgVSoHDd8r
/3qKevXoT9PClNpL/5iKuXcStmWRpfN1j+91sM325trUbA14nFcvNtciGu3k2bR2
cr1fGUYf2mWRbcgleZThq2loI8vFRouGGNENe/XQnoeCEs5/Mzqs3ce6RKVKWLMo
WNnpt7BfACU9yqcbwLG4+HvIyglMzQiNlHgIlYRvgil7ObdnqTEVHM3euzs4lkOG
FxrlUurCyapj+z7LtUaFSSGpPudx7XK96q0DtRzzZkwYcQ5U4lz7l+hcOjKQ6zK4
NR+1AEu6zxaLtM0yP4hV
=MKzX
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
