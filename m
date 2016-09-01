From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 10/11] arm64: dts: r8a7795: salvator-x: Enable UHS-I
 SDR-104
Date: Thu, 1 Sep 2016 09:23:54 +0200
Message-ID: <20160901072354.GA2893@katana>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-11-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46550 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbcIAHYR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 03:24:17 -0400
Content-Disposition: inline
In-Reply-To: <1472591399-13907-11-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2016 at 11:09:58PM +0200, Simon Horman wrote:
> Add the sd-uhs-sdr104 property to SDHI0 and SDHI1.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

After removing a SDR104 card from the slot, the interface is stalled
here. No new cards (even non-SDR104) can be detected anymore, sadly.
Happens for both slots on my H3 Salvator-X.


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXx9eKAAoJEBQN5MwUoCm2Sx4P/iL+SfohRGPn28uCyw2o0vbk
SdhSTWS6Ij7ZPDuPCh5boDFuFHN1v+L8FbRxKVcuWbreIzyIWaX0RTGMpCcICxHi
L+Rxl8j1R3Yfg/aiF5OjkGfApDeIkubIzzyWjxZTLM075Lk2Ek8kW6vtP0QM3wC8
f5ypeyDPee7EqGW+jUN4018Vh+xRImspmsJVeNVB+MaqyVw+IuWBxWf1yl94/fof
to/rVgvq5dj4rBKiHYsKe6GdPr/nnK11kffoO4xWufaxzAkIaf7l75t31zvzrcgP
1IgajB1aXv1hKo/EqOdcxH/ZHkJAsnd7cPWTNCPXXwO8EbodnaFZVC6Au5lq0EY3
YjjXugJ9cXFO8pVDGw83ljqtkY0V137Hk+LSwRceHmR+0Kw2vJm6D2nUWSjXYfGl
ff0QHLXYZGZFKG5iL348zqnfbNEOQJlOrT/xyKBjpdMJrB3nH2YsYKzl4uVMm9U/
mQl5gK2uuRVUEJVJ3EM/1UCHJMrZ6Wt/l32k0BHQp5sLpHA5E/DWYzBBX4+e5uZe
p/vnOaiXa+oIWX0MHgKuhMxk/oU1DbcLLb37P37jeLqH5cZyC9c4oMYpmT3IRb0y
1JFczDXGyoXuOKgrIG86Gzby215+/je2s54g0DuWl5Ho7m2phPQa2hu88fYhTAd5
4YUW3mgVabNinDA7uBV5
=3V16
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
