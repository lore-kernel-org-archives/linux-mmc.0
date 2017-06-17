From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH mmc/next v2 4/4] mmc: renesas-sdhi: remove gen3 support
 from SYS-DMAC driver
Date: Sat, 17 Jun 2017 17:01:09 +0200
Message-ID: <20170617150109.cnmjbsk6cmemw7my@ninjato>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gletfm6imhstwdra"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497607134-10241-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--gletfm6imhstwdra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 11:58:54AM +0200, Simon Horman wrote:
> Gen3 SoCs are now supported by the internal DMAC variant of the SDHI driv=
er.
> Remove them from the SYS-DMAC variant where only PIO mode is supported
> for those SoCs.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--gletfm6imhstwdra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllFRDUACgkQFA3kzBSg
KbaejQ//VLPXyQwgt2XpY7RI+SyK367OtgjZ/FbbC/RFLgiKLtQCBIrTmR418CBz
dqrffyGNmdwAXQ0IotWtjmyoP8y166SrSKYsko2Qeo62ASLuyu4xVKs25Cnjcx4J
yOpi3Uc9hBfuiTd67YPik+MF9s48sxgt4sLp/n0TNPa4YRf7YtKTdWvolrutGndg
L7Meq9lSf8c/Ea+tMsjdxAnlWWPd247zLBSDUyNTuGW7u9SBlkvEoSePlrrvd/93
RLFzHoAzzDC5kV1JPzQL8dVsWTzlJAQnt3Freb2dGyeFFm5dGft7pi7N0gPIwqf8
svcd2f/i5+G3mwFDxaxLvooerx1+UM8Hw5PP/D6WA/wtSLirV5H66qK6W3mb05ld
JxtSzvwVW+BzIWHnR23JKv9Eh23ZBFEI07UEl1yKe7pQIsoME8d325MEDtQM9+fZ
AaYhWQnLb1PCjS1iQz2l8PW4DewrNh8YfvSrZUheD7lZLcJRpccWfOehu+K1K5wa
RiuVRfef/KTshphkHMTbOkRG8NQMkmVKnvsqwoefHlfhh0iCGbWRLm5pxVRrrQkg
QL66JmcMdPHob9lDQTQ2lXq5eUGn0aUy1ZXS4/upcOTfmUsCdK5hyWrSA7lNXMNL
DsTGLK1Q7GfN2tcGwStVY955uXQxa4kyScRe1NlIR7fP1Vpiez8=
=S3Ql
-----END PGP SIGNATURE-----

--gletfm6imhstwdra--
