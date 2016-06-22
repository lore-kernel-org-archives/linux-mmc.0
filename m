From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 2/4] mmc: renesas_sdhi, tmio: make dma more modular
Date: Wed, 22 Jun 2016 16:13:11 +0200
Message-ID: <20160622141311.GB1645@katana>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
 <1465963317-28672-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45494 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbcFVONT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2016 10:13:19 -0400
Content-Disposition: inline
In-Reply-To: <1465963317-28672-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#if IS_ENABLED(CONFIG_MMC_SDHI_DMA)
> +int tmio_mmc_init_dma(void);
> +#else
> +static int tmio_mmc_init_dma(void)
> +{
> +       return -EINVAL;
> +}
> +#endif

Can't we make this another tmio_mmc_dma_ops to save the ifdeffery?


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXapz2AAoJEBQN5MwUoCm2DBwQALKiS+M23UtVYz9G/jTWNriR
R+08sLGm0uGeJW1lwkVBbI4lAz1FHpL6h3kbpgHXexJ0cCAAjhQX3MxQ7+e/t++M
cjKfPkWOar77J1R0ToxXOpeZstip5USO4O7fFqlozKynqMdvePcCUB9rKFxNofR4
vx8iuA+ZF8h5X+oySxyCe+WXWjLFLy0iraz9yx6oBfNqin+HA1cqXw9OFPgmT2u4
2iD46mRy+iwObBK6wqUzDYCsaR7nv9+iCoQm8FhG5tx8mQRV3yVIJcKKpiZKpGlL
nMAPHnfRkmHOUiUbf8oPXHTshqWl68RMB9gYoRkkzkSf6dqEy6gfEW8WPFt2KVYL
a6ES0Xs2syVs6plNUKevl0eHCY5UNkFJbEznG/mYPDzIN7SmZ34sQPNe+ViZNFEK
6e5dlnRPtLeZHgh1Yh9gy/OMFLEY5fZXDzKNv1y35ADq/B9fIi3OEZrex+nkoIxv
8qy9ZAyvMqvMDdaHNZ7EAniKspQ/+siYuFjarI8bqymzWsb1ofNl2xTWw0Va9rLO
EV0NcEPkJr3HTYiZ7K3AD1+kkCHGqQEUyOQqCTZFewQF35mYBrhvH/i0pw8CDxJC
mtmXmj6xOd7JlQPCb6Z937f7DwNqrgwtQR215QlnxD73KgJF8geBI7Syu2E8Z+WY
kjohA/8HUKCdKECa3nHc
=zQoe
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
