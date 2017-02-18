From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in
 meson_mmc_clk_init / meson_mmc_probe
Date: Sat, 18 Feb 2017 14:57:22 +0100
Message-ID: <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IGhKHkcvqSqdLBA7E9Vaq2dixjgcBgdJf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpo77.poczta.onet.pl ([141.105.16.27]:57031 "EHLO
        smtpo77.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdBRN6x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 08:58:53 -0500
In-Reply-To: <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGhKHkcvqSqdLBA7E9Vaq2dixjgcBgdJf
Content-Type: multipart/mixed; boundary="qfOTQ8BCSc5sHpaSBSX9rV4Jua322rWO9";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-amlogic@lists.infradead.org
Message-ID: <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in
 meson_mmc_clk_init / meson_mmc_probe
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
In-Reply-To: <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>

--qfOTQ8BCSc5sHpaSBSX9rV4Jua322rWO9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



W dniu 18.02.2017 o 14:19, Heiner Kallweit pisze:
> The condition should be "if (ret)" as the disable/unprepare is
> supposed to be executed if the previous command fails.
> In addition adjust the error path in probe to properly deal
> with the case that cfg_div_clk can be registered successfully
> but enable/prepare fails.
> In this case we shouldn't call clk_disable_unprepare.
>=20
> Reported-by: Micha=C5=82 Zegan <webczat_200@poczta.onet.pl>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - extended commit message
> v3:
> - adjust error path in probe
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-g=
x-mmc.c
> index 68e76fa8..002e4aac 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -321,7 +321,7 @@ static int meson_mmc_clk_init(struct meson_host *ho=
st)
>  	host->mmc->f_min =3D clk_round_rate(host->cfg_div_clk, 400000);
> =20
>  	ret =3D meson_mmc_clk_set(host, host->mmc->f_min);
> -	if (!ret)
> +	if (ret)
>  		clk_disable_unprepare(host->cfg_div_clk);
> =20
>  	return ret;
> @@ -771,7 +771,7 @@ static int meson_mmc_probe(struct platform_device *=
pdev)
>  					meson_mmc_irq_thread, IRQF_SHARED,
>  					DRIVER_NAME, host);
>  	if (ret)
> -		goto free_host;
> +		goto err_div_clk;
> =20
>  	mmc->max_blk_count =3D CMD_CFG_LENGTH_MASK;
>  	mmc->max_req_size =3D mmc->max_blk_count * mmc->max_blk_size;
> @@ -784,7 +784,7 @@ static int meson_mmc_probe(struct platform_device *=
pdev)
>  	if (host->bounce_buf =3D=3D NULL) {
>  		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>  		ret =3D -ENOMEM;
> -		goto free_host;
> +		goto err_div_clk;
>  	}
> =20
>  	mmc->ops =3D &meson_mmc_ops;
> @@ -792,8 +792,9 @@ static int meson_mmc_probe(struct platform_device *=
pdev)
> =20
>  	return 0;
> =20
> -free_host:
> +err_div_clk:
>  	clk_disable_unprepare(host->cfg_div_clk);
> +free_host:
>  	clk_disable_unprepare(host->core_clk);
>  	mmc_free_host(mmc);
>  	return ret;
>=20
Doesn't the same problem exist with a core clock? It also could error
when being enabled, and it will be disabled even if not enabled before...=



--qfOTQ8BCSc5sHpaSBSX9rV4Jua322rWO9--

--IGhKHkcvqSqdLBA7E9Vaq2dixjgcBgdJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAlioUsIbHHdlYmN6YXRf
MjAwQHBvY3p0YS5vbmV0LnBsAAoJEJkcaD2ZyBT5y+QH/A49AmPs1ry3tph7wGeF
MS5g+no6r3k+oJjtqZx5vumBmr1kvvmdLcXy90YINhibgVSderf6aRe8qZUGeqQz
N1Y7eoT4ECRAHlyprEUtTVNQUeNSTBFPK1Wt4rOsE5PwvzOxk6w9HRt/ZDhPhQxk
FWrxlVyJ5+lFI0XX2TcKaQ9iYKW++sWIEsvHa6B/9vPQ4it/K68bQrX3MNmX8q//
ShFKZEHBhXtcqFaqE9bOX3h9/fgaEIZgDFh5Fg20A19YPWh7MBpbrPbzhDfTLrAK
FCIkNN/e1WTULS1fOM+fG65kpa1kuzi8tqbJqKDVTBQQHHJ9td21Zwwa8kJSmjV9
JUY=
=kB+Y
-----END PGP SIGNATURE-----

--IGhKHkcvqSqdLBA7E9Vaq2dixjgcBgdJf--
