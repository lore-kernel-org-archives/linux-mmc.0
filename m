From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] mmc: tmio: use devm_ioremap_resource() instead of
 devm_ioremap()
Date: Mon, 20 Nov 2017 21:42:40 +0100
Message-ID: <20171120204240.kfzphgfjf3qherzt@ninjato>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nf7xwdbjcsltzv32"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510042172-27220-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--nf7xwdbjcsltzv32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:29PM +0900, Masahiro Yamada wrote:
> The TMIO core misses to request_mem_region().  devm_ioremap_resource()
> takes care of it and makes the code cleaner.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nf7xwdbjcsltzv32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloTPkAACgkQFA3kzBSg
KbZ/Ug//cXMJsNfDP6IrFy0NH+suvSci5Cx2/SSx4r0xQXCmDYGYPpKOHXAch9+V
/M/Z4QNZcSwolaeJ8z9T6e7luSTMekseXslAKLuZIf6YOk1hHIdc9KY9BRxw+b2h
BXo8Dhq7HhJuIso0MFiAywzWQrgLtIOwz935mVg//8vUrq3CvOLsmdmoiNP6Gb4S
RYDtmtSgUdhpW6Tj6Ht9jXd6CpeNMeYPUM5w5JvGP1XELgWtjBBXAPysKNfFEbfb
86rvj3DSZYNyukg7wF97PPcRRoLuSNreT6owrnomE3laDuFivsjU1TYS4+yppWac
ZkhjczDA+Dehn0GEhJRh80bz9fh8/sc419mL5JfmEn3clROSR+LTOMm1lF+Ybxry
5JzUBGo/crzknZOg9BRNLGQHs4d4pV2t2+1QSGr13NRQWTt3EPgxVjfk9R/nGA8N
LbnQjbj72wHw4m5WU+3Bi7nkiQ9M+lJpLTJ25by+1HAquCxyaFP8QwV4g1Y259qt
ODSIRGCurdRBcBr6gJeYP+Byy7+7EK2c0rcSg7D+hMoojNQLPE6h9E/lMfpQILHW
kzPVRbM0urwLn7W2ZC1x64ozBDlb7H4YPJbMZXmXtnIrgHGIax/2w4Nd4D1rXZID
Gk143B2rg74vVPeiOsucAtRUI0m2btLOwjCuLlVzxQ+yxSpuWs0=
=lRW0
-----END PGP SIGNATURE-----

--nf7xwdbjcsltzv32--
