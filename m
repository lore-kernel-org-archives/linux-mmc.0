From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 1/4] mmc: tmio, renesas-sdhi: add
 max_{segs,blk_count} to tmio_mmc_data
Date: Sat, 17 Jun 2017 17:01:01 +0200
Message-ID: <20170617150101.i2faasygkmnvtn7a@ninjato>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="573kqo2wj5h2xtg2"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497607134-10241-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--573kqo2wj5h2xtg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 11:58:51AM +0200, Simon Horman wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Allow TMIO and SDHI driver implementations to provide values for
> max_segs and max_blk_count.
>=20
> A follow-up patch will set these values for Renesas Gen3 SoCs
> the using an SDHI driver.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--573kqo2wj5h2xtg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllFRC0ACgkQFA3kzBSg
KbZohxAAhK0rzVk1mGnU9/+N4EQ6fmXfqJ/iVvYm66xM7NsTELLQ9WNdZqnUhrsL
aRYUgZ/vzlcGZYsVTMte+y8mPw0Pm5cuXVLIo/Tg+dfLIdv2E15dC85w2FXRkc4X
e/zFP/cjEAsatUqKOZYpdzGG2DDzeE682a+TQ3q7+fV3HysMfdbYQm9f1GliitCR
JuV33njK46xNhkwrR0cyZSAcpnkMgZyrEsj9vywov83RD7JiWvKprb3+Ofox1ygL
khVgxdBm+HpEw5/3kgfBlMHfT6bGSQb14ALJFUMpET5+TEtRjbcQUIfALT+y9SfD
UskXz2PbAVb1ZRoUR691+ZiQtvJtwEKz67/0oP22kbvp5b09zxZ0XiqA3LGyq6xi
x05JaJ8NgOn/LCk0+TVnJTth+mXnmaUqf/QjjQzkporAN3VlW+gsf8nj2vpZ5BFg
gr3W+8FFGEGNOEi5w35mREg2KsUb5gg2vcg0Eip//jbREGOoIiko/zXhLXkXWNY/
ImoSI2B+LtI8tBuYh5VjkFGLZV6wRlO4oCUWb1CEHd0c7wTptwG6eeB7s78UZukj
ZR0S3LAa/9/VUUcOLUPHxfLEOKPqDOvMdbK/ISG+Yikycv7IYNYmaszV5gCDFSDN
sisfB8OkvUyO1WceM1cCswIRR9ZAGawcStFSPxpXEoUVtXue2Ns=
=Naet
-----END PGP SIGNATURE-----

--573kqo2wj5h2xtg2--
