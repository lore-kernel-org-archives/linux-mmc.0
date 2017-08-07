From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Mon, 7 Aug 2017 22:51:17 +0200
Message-ID: <20170807205117.GA2104@katana>
References: <1502069565-114396-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502069565-114396-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Mon, Aug 07, 2017 at 09:32:45AM +0800, Shawn Lin wrote:
> We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
> mode as it is expected behaviour and most of the backup partition
> tables should be located near some the last blocks which will always
> make open-ending read exceed the capcity of cards.
>=20
> Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop c=
md into account")
> Fixes: a04e6bae9e6f (mmc: core: check also R1 response for stop commands)
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks a lot for debugging and working on this issue! I think the above
reason is correct, yet I wonder if we shouldn't implement it
differently: how about introducing a new #define called STOP_ERRORS
which does not include R1_OUT_OF_RANGE and use it instead of CMD_ERRORS?

Kind regards,

   Wolfram


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmI0sEACgkQFA3kzBSg
KbZG7Q/+ODFbSPvjzua7h482Bx1d2Cdufk+i1QJlubBpKmqaU9HSzib3IMv5XCTH
wEP85+kLgoLOAwVcgrzPHpZENPOMEUTJVUjP9vNvIGUSOVB69usrf6MASv6XYLQq
TqduNLgp+XIaxY7wNXtVdFsQBKqUPV61D7M4ThMoUTRPRIGXzVLj93YM6miDzquc
sAQxOhQJzhUu4ygZeSHZ77nZADToG4i45N/pjXYwoAO+wcxsfRfMsua5ZfoyFESw
iMCWPqB5ODOrpVNhJeBDSPBFptU8mGGY+Qj864cN5KN+pV3rvkcvtwyfbuGEvhYo
wnM0VHyuFa1fDm/fh7DxpHd5vDSmSKgzCADslbFeHynNfEpG6s6HFxWiBSNeKUpI
ZgR/uWCxycNh0NwHfHzTo6ksHJtBQJTvqbH+51NcwblBuI5/Ds16f4Qre2cZm6Ed
NuG/u0NzQ0T3sTLPms31PflSlom32bIMNhdFsQ8qkdSKYOuwpHsKyzybP1ZjaGX3
BZxUzWSq1j+qVSLoGgkUJoA+OkFNKwnXJvBjhwe3+XuDvcY63XVbbZmnj3iCO2Ei
xhgTFFlaVmiET7/xnQ7UmyPRABHlc7GAZPQjp0yKLVUIM+8iZvvZ61nKLJl0bLVL
HnnQMX0RQx8dwbj/vuo4UGG8aSZRFicwW+825SQQmFVhjSCh1MU=
=Aa2U
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
