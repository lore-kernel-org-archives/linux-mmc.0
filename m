From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next] mmc: renesas-sdhi: provide a whitelist for Gen3
 SoC ES versions
Date: Wed, 2 Aug 2017 21:51:29 +0200
Message-ID: <20170802195129.5vf6xc7q7dfaphgx@ninjato>
References: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ap2iajdbxesm4pb"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--4ap2iajdbxesm4pb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 02:48:42PM +0200, Simon Horman wrote:
> Provide a whitelist for Gen3 SoC ES versions for both the SYS DMAC and
> internal DMAC variants of the SDHI driver.  This is to allow drivers to
> only initialise for Gen3 SoC ES versions for which they are the appropria=
te
> DMAC implementation.  Currently internal DMAC is the appropriate
> implementation for all supported Gen3 SoC ES versions.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +/*
> + * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
> + * implementation. Currently empty as all supported ES versions use
> + * the internal DMAC.
> + */
> +static const struct soc_device_attribute gen3_soc_whitelist[] =3D {
> +        { /* sentinel */ }
> +};

It may look strange to add an empty list, but I think it is worth it. We
have good reasons to believe the soc_device_match distinction is
necessary and I think it is good to be clear from the beginning how we
want to deal with the differences.


--4ap2iajdbxesm4pb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmCLT0ACgkQFA3kzBSg
KbY41g/9GbOeTZ4zxaqMitpQYfuEfAiUk8pctTl9bOVke2u2peOf5C6Bd4Vl+lcT
lCJnBCBNbNDsTB6PrBOmn9B5iTVIkPTz7LzEHrPNlgTSTCeiH+LGncmIvP8fCdPK
RM/Es6FnO4uY2eiR9jIuF6bg7/OlyERo6Az2C5dFuCp8Gf9SpJJAjIq01O47h8ll
re9WCDYI3LwrE7cMYw3X+F1XP9ET+Q8mqtAi/KN9Sy8SsjHVwdMeBj1EB3j2Wb9Y
o3L/9rpYdQ6YPWWrAJCfZLYqNo8TZNEHUqWHsqqDis6f3RNRF7aLEJBTTTDpPExE
xG+a5NU4seJleYCAfkAsxcVjCWVakSvIAUj5kLPzdzn3jGYR0gD1xqyBEoidvrIf
TK0ef1MgA5CkgGLyJPLm7/Q0qgJkuvLKOHbuqc/DypJPFCnRov8HvRcONFu+PAaN
sGhmR7AhrN6abZ0s6yGNR5rS3pW3Ku7o3z51vYvcC/4FUz6PrrlLZkg40LBB0SR6
1DzAFi5lZq28qW0CstL2XPkaOhrR45mHIntk+ovwihCwrL6UBYFZZz7Mo2NhrXv/
Zi3STjo1FWukIoD3HJaMhA2ldPqXd0FCUvgCQ2HdRpDBFYLvsv8VV73Zg9YEt/sc
620vK0mdAFFIevTJCb9U+ox9ZZISn502emcPgXg4pf3QBmrbphA=
=1RAl
-----END PGP SIGNATURE-----

--4ap2iajdbxesm4pb--
