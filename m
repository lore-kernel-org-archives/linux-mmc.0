From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/4] mmc: sunxi: Make sample clocks optional
Date: Mon, 25 Jul 2016 10:18:30 +0200
Message-ID: <20160725081830.GF7419@lukather>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
 <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54681 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751952AbcGYISc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 04:18:32 -0400
Content-Disposition: inline
In-Reply-To: <1468665964-27142-3-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 16, 2016 at 12:46:02PM +0200, Hans de Goede wrote:
> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
> clocks, so make them optional.
>=20
> Since these do not have sample clocks, they cannot (reliably) do
> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
>=20
> Note this patch only changes the devm_clk_get error checking and sets
> the clocks to NULL if they don't exists. All the clk_foo calls accept
> a NULL clk and will return success when called with a NULL clk, so this
> is all that is necessary.

The clocks aren't really optional. They're not needed for the A10 /
A13, and mandatory for the A20 and later.

Having a new compatible for the A20 that would require that clock and
not require it for the A10/A13 anymore seems more appropriate.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlctWAAoJEBx+YmzsjxAgK3IP/iVNhu+yO/IZ/CTA8+87h+jL
QpPQFocqMinmHROWnDZNmxbpEsq2tHEbiis4y2FC2nymlJrixzuhr3IhNFUSGJ4C
ZeTKbHva9gDC9YL4IPtZZ5XR9hrPfs0OlSjGvRMlOghmyfmSHcLifih2SMf34hEu
UzxYeoI7BkzWXrqKqohR9k8cO//DOrVecxkqzviA/RJgRu0tWB4LBvBI0mZhKgbI
UQ8n/2nLzMHoWukga1bl60vULrNayu4fdpturVKvouXbFDUIQ026PH5kQbWQQXOE
GXZpY2LCHWhQw5/qPVV9kF7poVits/JoF/cq7Wmt4nZZdwx4YH36yKwbqwUFHi1y
4QMHktoTLhVaRAqviAlO1sYOycP7eCD5nE3lC/mEpR9e8NlyI17lHaiPIB3O/FMt
STPrPG4LyXPrJHcdnbQCD7/TNODZ/XzBf+apYnX4uEJv9SE/kwLzp3DY1sE7ZbXo
C6WNkTUVq7kgRMO4qxgl4fgfEFdt3cVOAU7bIBnYxNl0IWDdorQ4Vl7orn+nP6nw
5pxABCyivf0Qee57voFXhZpaPUnYaz9cOB02uRirO0ztH0T7SZ8N79gRthnWdSKV
u9f7+poxsCHRBIXzAwylLn3RJ8vzMkNgLE0MDPJpQXe01oXcUCaEUpiLRmFJdPKU
NeLKBZnEQ+r57d1Fwx8d
=QCB+
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
