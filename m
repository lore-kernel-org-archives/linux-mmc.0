From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Date: Wed, 29 Aug 2018 10:49:13 +0200
Message-ID: <20180829084913.fgdrigpeu3vi7vqs@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pznduqydquaabgg3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--pznduqydquaabgg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (divisor <= 1) {
> +		clk_sel = 1;
> +		clk = 0;
> +	} else {
> +		clk_sel = 0;
> +		/* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
> +		clk = roundup_pow_of_two(divisor) >> 2;
> +	}

What about

	clk_sel = (divisor <= 1);
	clk = clk_sel ? 0 : (roundup_pow_of_two(divisor) >> 2)

More concise, but I think still readable. I don't mind super much,
though.


--pznduqydquaabgg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluGXgkACgkQFA3kzBSg
Kbawzw//cevnWqN2we7+wnmAITrE0rMxOUPFT0P8nDc/r98bsBxxSw7WHr8Sm527
7gzrdc7oM78IozpZIX3pd0YfdrKWbN2vEW698a5qSczi3DIhhBWPgfQNQJ0DrX6N
INY828lP6/eTm5N53QSEn7Xic4Y1DzSPWL+DPbH3S/HZCNcrOB4dSb89mpqurW+P
EdzL35ro3V19VHGJ1cp6JBCevR9J62cCRox2x0EwsRdgVFfL8tnnHVPzRNoFyI8x
sNqcW1o15xLoKwhJQjZjX3U8ofNrDYTjOCGjuk3N7Qe0DHJh3caVSOkX6PYbw3Ob
m7EL+gU6gJAWbMrv+TilDiJDm3nEpoIU+Lr1gD3VRZBmTwD/UMqoTif0Rm+5g7La
lk6HPFgstRkvLdKmcUzCpbipmrgnGc0RTuwtGdpTperOH3eq4u/MH2p83M4qAezL
o/q/jJNSpzH1XSnfWzS2tkh9bgbTYbI5YwYohIzbWuPfW+7m1BhPsgaUvyWjD5sE
A0p3Pxadvw6WOKHxkmfISzU09RyFt8m8DzbM4mDcFp3/Cjb/bWuyotYPvuZOjLJS
S9cr4WahvILZ5J2OIGdg8+FIuwRMO0D7y8SKmtOkAqH9cOsMvGPZfdAMxDFvwBJo
ysNzt9eZroXfkNY84z1sdJ5v3OleH1BBVzbs5APP+PfA/XjYl6Y=
=r6vt
-----END PGP SIGNATURE-----

--pznduqydquaabgg3--
