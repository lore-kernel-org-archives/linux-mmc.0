From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Sun, 19 Nov 2017 20:49:30 +0100
Message-ID: <20171119194930.npqfzqvmh4zbcb34@tetsubishi>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djs5xnfvcwdpv7vk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46965 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbdKSTtb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 19 Nov 2017 14:49:31 -0500
Content-Disposition: inline
In-Reply-To: <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--djs5xnfvcwdpv7vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:09:28PM +0900, Masahiro Yamada wrote:
> The remove, suspend, resume hooks need tmio_mmc_host.  It is tedious
> to get mmc_host from the driver_data and pass it to mmc_priv().
> We can directly set tmio_mmc_host to driver data to clean up the code.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

=2E..

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 64b7e9f..ccfbc15 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -128,15 +128,11 @@ static int tmio_mmc_probe(struct platform_device *p=
dev)
>  static int tmio_mmc_remove(struct platform_device *pdev)
>  {
>  	const struct mfd_cell *cell =3D mfd_get_cell(pdev);
> -	struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> +	struct tmio_mmc_host *host =3D platform_get_drvdata(pdev);
> =20
> -	if (mmc) {
> -		struct tmio_mmc_host *host =3D mmc_priv(mmc);
> -
> -		tmio_mmc_host_remove(host);
> -		if (cell->disable)
> -			cell->disable(pdev);
> -	}
> +	tmio_mmc_host_remove(host);
> +	if (cell->disable)
> +		cell->disable(pdev);

Hmmm, this changes the code logic. Any reason this driver checks for a
valid 'mmc' and can we safely drop it?


--djs5xnfvcwdpv7vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloR4EkACgkQFA3kzBSg
KbY/jBAApGvwwtuDGuZDMZgjo7394JLH5AnULeTdxmmZIqJVm8ye7J/21oTQ+IW3
zYb+O+pRib/aUgDE24u+dhjxydSo5NcMtlx5Bi2VrdLpkk3F3v+k5rg6kqkRGl8p
bXutuzqZTraBfFB45XRpZqWhL9qjS2+U6k7j6jEjWIJdP7Rk3s5N1+FwaNbvxJta
ga9Csn0hJlIq6g15quxansb0oRjlSyiQSXnuyJUXMsybQzzVIw4xXBQWu2Ge7A+5
lP8at0cQuu2/pgu8UNE2QnOpVelZyTvMPJ5iG+0jCIIKnkAXHLzHTZacki67ehyE
Bi+JbX8fE7TWhlZ+1BxyAIxLLGNyflVBqfc8Hnq3vkA6nJRwk9b1d6EY3P5eBpXC
EoasyOXtXuZU4Kxw1qq0rGPER2Xm3n4Xgs4UaPPIF1yw70C9C/s6YTUwcHaPeJFq
8rIZwUU6wSO+IXpLpK60RxN/6JXLmwuc6IwhnfOymHfwEWmAJMQCwzVuYTFS4LlJ
uMDZXLpXP3J1p9+mtKUKL6mxuA2fhFE8Mo906qgX0R1NckF/n+4aTr/rxoQc2904
QPvgcssIbc+6ESykLS6zb0V8IhS3Sq8I6zce2xIYEvrZF7igcEseSKv5sADt4ANQ
BAI1HNPtVhhn43Qcoc63P43lG0Mrhm8LNVt6YULLiy27Yeffc14=
=PXWB
-----END PGP SIGNATURE-----

--djs5xnfvcwdpv7vk--
