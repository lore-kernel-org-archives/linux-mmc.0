Return-Path: <SRS0=8m0a=24=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE16C33C99
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 10:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBD52146E
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 10:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgAGKts (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:49:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgAGKtr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 05:49:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77070AC8F;
        Tue,  7 Jan 2020 10:49:45 +0000 (UTC)
Message-ID: <cfd3a908f7e899c8199a0e34bf9ec294f9e027d3.camel@suse.de>
Subject: Re: [PATCH v2] mmc: bcm2835: Use dma_request_chan() instead
 dma_request_slave_channel()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com
Cc:     vkoul@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 07 Jan 2020 11:49:43 +0100
In-Reply-To: <20200107104040.14500-1-peter.ujfalusi@ti.com>
References: <20200107104040.14500-1-peter.ujfalusi@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-N+V++2Edv1iq1XaEBcoq"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-N+V++2Edv1iq1XaEBcoq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 12:40 +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>=20
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>=20
> Changes since v1:
> - jump to err: instead of returning in case of EPROBE_DEFER
>=20
> Regards,
> Peter

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks,
Nicolas

>=20
>  drivers/mmc/host/bcm2835.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 99f61fd2a658..c3d949847cbd 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1393,7 +1393,17 @@ static int bcm2835_probe(struct platform_device *p=
dev)
>  	host->dma_chan =3D NULL;
>  	host->dma_desc =3D NULL;
> =20
> -	host->dma_chan_rxtx =3D dma_request_slave_channel(dev, "rx-tx");
> +	host->dma_chan_rxtx =3D dma_request_chan(dev, "rx-tx");
> +	if (IS_ERR(host->dma_chan_rxtx)) {
> +		ret =3D PTR_ERR(host->dma_chan_rxtx);
> +		host->dma_chan_rxtx =3D NULL;
> +
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			goto err;
> +
> +		/* Ignore errors to fall back to PIO mode */
> +	}
> +
> =20
>  	clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk)) {


--=-N+V++2Edv1iq1XaEBcoq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4UYkcACgkQlfZmHno8
x/5e3wf/eUvwQW2b9ZB6S1muHMTUNQhpNJKwE77BmeyyDodnuNKbTzeR1TyJzEws
JIMPSXnOKwuF2qvNLnpZrFTsCVmBqAY0M3U2M2Q1lIsiuWpRW0CpiHVWlMV3spHx
553nQ3mxwWXTvt1mHlJ5I6YIqivfGZSoRU6c0JuGLNZanttjfapD6BDIAy0pepdb
Xviq1Qzo5GxpLiabSs5rBPnxzZFZUtpXoLZJZv5nSW43q5xLugFxWjAY41xxFK85
AD2V6mWKd+fQ4GXZGTaw1IaRPYDODJcskngQntKuoclCSkY2/3LKn+eu0DF7STFs
lLPQIkggT59U+JX3iT3AoS6xf8NRWA==
=KfEu
-----END PGP SIGNATURE-----

--=-N+V++2Edv1iq1XaEBcoq--

