From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/4] mmc: host: tmio: fix minor typos in a comment
Date: Mon, 13 Feb 2017 15:11:27 +0100
Message-ID: <20170213141127.GB1445@katana>
References: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
 <20170212111227.1550-3-wsa+renesas@sang-engineering.com>
 <20170213123943.GA29718@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170213123943.GA29718@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -/* Definitions for values the CTRL_STATUS register can take. */
> > +/* Definitions for values the CTL_STATUS register can take */
> >  #define TMIO_STAT_CMDRESPEND    BIT(0)
> >  #define TMIO_STAT_DATAEND       BIT(2)
> >  #define TMIO_STAT_CARD_REMOVE   BIT(3)
>=20
> Is a similar update for CTRL_STATUS2 appropriate a few lines further down?

Yes, and SDIO_STATUS as well. Will fix and resend. Thanks!


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYob6PAAoJEBQN5MwUoCm2F8sQAIQMAUG8LhStvp5nY5Ng1lX6
2Pkv7dDJINgPo7qpdYkM4A5u8n1Vlb/W44DmhLfhHX1TM36lCmIF+9mQud7R7OYA
/hh2ew4xFhhJKqiOmbaYcVijaeIPOa88m8r+T7ADNVxGNdEwq65VZyirzeEq+3AZ
AIxiUs28w/KHU6rTEou/GgRYcBcrNhwwp8PS1SCcG4GhAyHxTIxjRDN4FchykLqP
7Z8NHpwG0cozp3Q9qyP8/1qDI7SzrYHictd7pYSbD9vDYCqGg8hi3mUZt0OSo4jH
Hb+OCgLpltQEDt37a9cS7coLUK/GefMMBQFiA4FMBo+Sf4eoJMCxstxWFtHU8XNf
chYGlREZhsS/Cilp4QIQENibiKgBQQH5+Ep3yC/wjPQZ/aN6q49CT4K9BgoCYgaO
bCWaEnzQhiz0MJMftJeWBsVuuKevY2FXKKG4fD5neA28Q/cPLze+4v2GCwFAuqX6
HbUcxUMzwjFfClqHX+ssRvtDXMNM99Fv8KPgOfVZPXFpClhK24cHQtuEBADBlqBD
qIk/rh1yKIjD8M5uzne5q6GoAn1WrPeuoxo8hPQgzCeOxEqi48dAiJikfQHnzSH8
OKQLFxdo+Ywje/81xr+rTLTuqAdWfDiieCs3ALF85yRIGSvuLuT9DHzhilX69xi2
9huHjFJ6o0mGRJJv5SeK
=V4Sh
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
