From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT PATCH] mmc: tmio: make sure SDIO gets reinitialized after
 resume
Date: Tue, 23 May 2017 14:23:39 +0200
Message-ID: <20170523122339.GA3747@katana>
References: <20170519123052.26565-1-wsa+renesas@sang-engineering.com>
 <TY1PR06MB0992573FB717D7C90373F1FDD8F90@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR06MB0992573FB717D7C90373F1FDD8F90@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Yasushi SHOJI <yashi@atmark-techno.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shimoda-san,

> > This patch addresses a report I got from Shimoda-san. I can't really te=
st it
> > because the SDIO cards I have all require MMC_PM_KEEP_POWER to suspend =
and
> > that we don't support. So, I send this out to ask for testing. At least=
 it
> > didn't cause regressions for the setup I used. To make testing easier, =
this
> > is *not* put on top of Simon's SDHI DMA rework patches, so it should ap=
ply
> > on current upstream and development branches.
>=20
> Thank you for the patch!
> Hayakawa-san tested this patch on both H3/Salvator-X and E2/ALT.
>=20
> So,
> Tested-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

Very good, thanks, also to Hayakawa-san! I'll rebase this patch and
resubmit with the tag added!

Regards,

   Wolfram


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkkKccACgkQFA3kzBSg
KbZ20w//dPPhZu2Z99rjnw3pPonUU6smbgD7vCmvFe5/Mop7ZzdxRvIz/KpAd2ju
U9ZUeC+Hs0MtdzEb+IPp+/6Pb3NF0KRJkEG0SmCAFXYTbvghgcGgwIehL9QSAenV
p8qMNqHkjcdiAa6pHfQuzDrpvSEfKBx5UDAA9tneCIGHdQrUqSvLw+yAWtih4w13
VK28ZRZZHfqyHYlTsdQQ0TiKUgZmRnQkjdBBMsTpY96IL6M/Q8aZ2S3eIG9el01V
5c53FpNTXe7ae8aOveTcNCbzOBktYSOKh+vGCqg3BeeqLeyLGhwc/IyhDlxMLcaw
sIKUAOrdHPmDdGdTh1hnOoTDLOETz4BP6jnTwnfkpRc5yJBdm7nKQcjbQNKp/88S
zT+EjuRJsAuhObe0t6E53hg1oTos9oSOfMV8kEggGIqc+zQZdTfIVUdDKPTbVBgi
QwJzmmExqbdxNAt02kRv77yvAydPihAtBtmBJO0gbepjb97rZHYEo0BOkZPC9qq9
fSWaHlllPL2vpyrVP+DQcppM0BKNR1Uhog/3VvpLn23LmBqQS5PxOWCPiWVMRkfE
3Ru47ataUMckfd1TIU2qgcdSgnIJ1U49ZPtmdwshO+yrWSl8I7bT9+QOyhVgQA7p
sOG1+Wg3SlM4zR7mCGZW8+FY9ZbUMbylRv9y0WO1kv8WOaKrzeg=
=vpoz
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
