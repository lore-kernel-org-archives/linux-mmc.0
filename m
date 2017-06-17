From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 0/4] mmc: renesas_sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Sat, 17 Jun 2017 17:03:42 +0200
Message-ID: <20170617150341.q2pcilgi2fdpfaz2@ninjato>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhpzc7awab725pa3"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--yhpzc7awab725pa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Based on mmc/next
>=20
> Headline performance boost: 9.5MB/s -> 39.7MB/s

Did you test writing as well? For me, this fails on M3-W with CMD12
timeouts. We had some changes in CMD12 handling recently, so it might be
because of that. I'll check on Monday.

Visual code review follows...

Have a nice weekend all,

   Wolfram


--yhpzc7awab725pa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllFRM0ACgkQFA3kzBSg
KbaAvA/+MHhGn+AkE8pEzPw2WKTL49VfttQX2sPfCrQRUdHCbdth/lnc4YgFROyH
m4DwmPUkrvehTnvl9MihurTB0PtY/afr3/IlDbjloZFJEEo2VflHh8o+BANzE7X3
VX54SmhCj0I8s8FU6q1IrpVzVqFAHtbLH7lQ50oBqfsB5VCiMyt6KyUaBKR7JO2D
Dz7J8nj69zITyeCyZVD0emZl5O+7+gmLu0mwZmZIrsJXZI+PmtXEp2qO8slddgth
iRLWAVgYeA8B4qt7BfcPNUg3gq4lcJJWBkEexTu7koglIKDht2lSzcAPhFtBM50L
WXTvxZ97P18ZquWpEyExVntRxiHhxi4DklRAkria7BwwKGnwOn4Qc0QrwODVF9sr
/wB8lazDI3Oxs3WgOH5Mzm/ryyOlpmhj84+JsMUNhjIhlj/HKnzEduYFitMEHlIb
KtzJ49ER8izrorOeQkZaH3Y9NrDhWjjoqP2bIL4vnv9BYlEzI7GuowYD30bF3nQ0
dAabz+FFnGh7yJwNVGODOoTk3XG93c+zbkQMqTWWJaN/pu+ghIgUdkDKJVJxtHZm
zERdjg4PwOn0KFqNL+RX1ljVkGKCRS/d+rTw5G4RudKT93DaEdHxtzdcczdYyZhz
71nC6VX80SYmGFFasclxkdo2dmDL+zZ7FOBlKJO+tL2JtiI2RHk=
=TOqx
-----END PGP SIGNATURE-----

--yhpzc7awab725pa3--
