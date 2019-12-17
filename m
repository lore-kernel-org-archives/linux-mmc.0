Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35150C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DF32064B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfLQLh3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:37:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:34044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQLh3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 06:37:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88556ABD6;
        Tue, 17 Dec 2019 11:37:27 +0000 (UTC)
Message-ID: <cd316378273d18b93b5dcad8b357821a708c7805.camel@suse.de>
Subject: Re: [PATCH] mmc: bcm2835: Use dma_request_chan() instead
 dma_request_slave_channel()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com
Cc:     vkoul@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 17 Dec 2019 12:37:25 +0100
In-Reply-To: <20191217112625.30715-1-peter.ujfalusi@ti.com>
References: <20191217112625.30715-1-peter.ujfalusi@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uq1s881hQa76yme78kN4"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-uq1s881hQa76yme78kN4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, 2019-12-17 at 13:26 +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>=20
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mmc/host/bcm2835.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 99f61fd2a658..3821f159d36d 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1393,7 +1393,15 @@ static int bcm2835_probe(struct platform_device *p=
dev)
>  	host->dma_chan =3D NULL;
>  	host->dma_desc =3D NULL;
> =20
> -	host->dma_chan_rxtx =3D dma_request_slave_channel(dev, "rx-tx");
> +	host->dma_chan_rxtx =3D dma_request_chan(dev, "rx-tx");
> +	if (IS_ERR(host->dma_chan_rxtx)) {
> +		if (PTR_ERR(host->dma_chan_rxtx) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

I think you should 'goto err' here, as you have to free the mmc host struct=
ure
allocated earlier in the probe function.

Other than that the patch looks good to me.

Regards,
Nicolas


--=-uq1s881hQa76yme78kN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl34vfUACgkQlfZmHno8
x/7GHgf7BB1BUlD5qVItXGwvpFQA7/KItn4HOfYT/dNQPDT9S0YU6zPEhMBi68VI
QOjxSY+gHB+LJ3Pp9yWvhkx1hgBzxTF71SKbcszX8rtuYaC1evpDJK5U7zNOfZkE
byesISpFcZqv+oa4mTJTZYq0PvjMPm0n396tk81h+jVWWtKEP9L+c/aWqGVco9ea
qFHuOjazexHWP8P8GW8BpvR4md1RGfY9a8VghX9lU95DBWxwHdD6r62DPI41PVkJ
ZHvGv4xzPt3fLX4xB9Y3EUPXAqUgXMkDt1hrZTWgfdBSi8cn1DN7ddgIshoTeU66
9Ldmadht3ckR015FL0/tjOw4/00stw==
=GdIs
-----END PGP SIGNATURE-----

--=-uq1s881hQa76yme78kN4--

