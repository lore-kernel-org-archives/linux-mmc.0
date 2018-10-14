From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
Date: Mon, 15 Oct 2018 00:35:34 +0200
Message-ID: <20181014223534.GG3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:57:38PM +0900, Masahiro Yamada wrote:
> host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
> is set. In this case, it should not set up DMA.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxLYACgkQFA3kzBSg
KbY9khAAoHCwQFucHtw3l83bHMbMnG/2J0ScVnEdsY2d3izomHfJZNCSa9Ser/gp
2IPqGrfhGSmO8ISz7yHeHpR7rM96N6KhnCQsAd/lvzPhlzcWfhlYtLrZls7lpJIj
/sTWD7kj4h0NvVkI1RgUu4AGchchBaX6CD2FbON6T0ktS4Omti8yjwf9mLKm0r9D
39R5vcmPqHEGBqGAWfpKSRRxzge5Q5tHVv1nb64xTAR5V6sIlBoRDwvfuuG/NyVk
+QCx/g7UbXobx5oS8O5fta6FMAFFRvF9NiT6rEWBOUM1Z7MiP2yfAspLZIxVt7fy
1SJAavmrDC9huuL3dsl6KKWlc7JH/BNKar2gq17/XpDlBVSejWppIQo37Tqnou8C
YoNPjtHFtk81kQ/Tb/6w0b9SLlZ51+PTSvYCxMMxEzrsJu69jNUKLkhjJ75cgIUj
kOUSa3E98yPTOo1ZLBVBllKa4sEcbQdEU5xrzMpQTutx2JXfMVKeX3w+CsLnH7E+
fX8EAUjaRu3vbhnd/3lD05Xwk49QEIY6y7f8yEuH8/uNGKuoa0tZNz5b+oQXLd7d
tV7dpfCVRib7ZUGOobZizVHrMwR5n+zOHSAVmdn6E0nAJj1cKM6sKN8tEaH3fx0O
myIXWHecDp8nc8hKLycZ6WmqDCh6ULdrE0Vp024+6wRJmth927Y=
=pBgP
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
