From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 5/5] mmc: renesas-sdhi: improve checkpatch cleanness
Date: Tue, 30 May 2017 21:57:26 +0200
Message-ID: <20170530195726.p7zzhjujnetc56dw@ninjato>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
 <1496148654-20386-6-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hsjbug3576toclth"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496148654-20386-6-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--hsjbug3576toclth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 02:50:54PM +0200, Simon Horman wrote:
> Trivial updates to improve checkpatch cleanness.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Two comments here:

> -	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
> -	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to deter=
mine the shift */
> +	/*
> +	 * Originally registers were 16 bit apart, could be 32 or 64 nowadays.
> +	 * Old way to determine the shift:
> +	 */
> +	if (!host->bus_shift && resource_size(res) > 0x100)
>  		host->bus_shift =3D 1;

I liked the old way much better because it makes clearer which comment
belongs to the whole block and which comment belongs to just this one
line.

>  	/*
> -	 * All SDHI have CMD12 controll bit
> +	 * All SDHI have CMD12 control bit
>  	 */

Single line comment?

And hooray for finally fixing the controll bit :D


--hsjbug3576toclth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlktzqYACgkQFA3kzBSg
KbYBTQ/+NWMwR3miSppMNHuDjQw77Aa9NySM9r5YOONqEe7JYJHlxYjcPq/jmv8l
eO5dhqC456SqMz4uI+5g14Q7Ag0+XfW7qk2aCzicYhMMY+z57eaRmZdh2XPgt4gu
qNBj4kv5Y4Vxx0P78ETx1NozdPa/4DYuUPlA7Xx6tOhNRuVkr+Hzj/Jl2y5mYkKc
YvC7RKtD3yzm1bRmDgE+SxHM/+4gjS2uYHdePsV1q6eV2Yi37NHKllUwenNlccij
LygFO47E17wMZwJNK1Fwbi0Vvze7jnZOUuhSKGfHHULMTEDi5lunPSz0cdMJgzv9
C6AJMlR8qik9zcUs9bHvXIWxFJkukA6cjHr5n8MmMecN8v//Qjxp+gyA4YrgWfVL
BspFFlBdg2TFwynQ3smA81osjL5fWSCRKJHK/z8iii0iOpH5tNJloopjRc/fFRQ+
/q12dH+Ag2keEuBfi02T+dc6iZP+qTWXWXn5cQaXw3ahmfdWolXFq64a3H65254D
d1SilTE7ZEeRa4uBMG/9YfpBa+EhwJ/zUJkXsHxw89bwpqyozjxGZzor9M3yOHFk
2Rlx0zmBRU/DbwPNtwIfzYiG2FkndtYF8VNBzsiTsB5UYjDrV6YhvSWz/iVdIlQ+
8MPUQr7AgZmd+W475w1P+dx1v/SgAK1F3YxYjSNspgsiJXBnFw0=
=trUV
-----END PGP SIGNATURE-----

--hsjbug3576toclth--
