From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Sat, 21 Jan 2017 10:36:36 +0100
Message-ID: <20170121093636.GA1440@katana>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
 <20170121030604.7672-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170121030604.7672-3-chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 10:06:03PM -0500, Chris Brandt wrote:
> In the case of a single clock source, you don't need names. However,
> if the controller has 2 clock sources, you need to name them correctly
> so the driver can find the 2nd one. The 2nd clock is for the internal
> card detect logic.
>=20
> Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYgyukAAoJEBQN5MwUoCm2gRMP/0n57BNBr7W0V5XfUD70pb1u
KYPoZx5kRl3M0BdF89oxO3p3UON4KKYfKTBwqX2S3V2B6Rkb+wQimn8VFxv2WAfD
8kBb2COhdY/sjTgZ/BxT1fSWGLquG3L3xtS4sXz2lNTfPPp8I3fc73Im/FOvQtKN
msjH5P43oVTOpcGMWCDZYmV7TF2ZJxaOq9WKbcL7Y4x4FsE6E0Id9+HrGon3j2zR
BV4d1bKvznnfw6OZzZObaMMeGkXpFPeQHcnd9Tmwtc5RJ6Nbsnmb2P8qr0QoPoZM
ldrmafbvUYNhsSGB2AxvbjA4+N96avZbe/Xx2ZVDapicAkId0N0RrS8Czkd2jwKp
qbKoLa7Ce3nXi/qdwDaqGelkD56YKqvDgNIDGgNQjiyz6pE0XeW4ynzqjYL24X1e
noG3x/HUNtjmmmRbY7e9jBxzUrjCCQAwFyEsKckxdcQsmu8bEI5aAhzd7PvFZyMF
ezLOXfsOPFEljcN6wXOHrkXgW+LS6avZp2IY06zfLsH6NNpEeFqPkMzLwHishn/9
zjwJVPPYukTfmq3PLHdaQfVVYtI8+cNEj8zfcnpsqdchcrpwUKHWzkAE07GXNy8l
L7qjwewmVB6jpVNxAWwgD8lApsVJAQJjWETPbTo3nkrkA49gV2qo3kLIYodcRst1
QdwqkiyNoRrGwuR1hYLk
=3biQ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
