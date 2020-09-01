Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E17C433E7
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F79206EB
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Id9DKAh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgIAOWc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:22:32 -0400
Received: from www.zeus03.de ([194.117.254.33]:33136 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgIAOWT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 10:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=sDS+WFg3DhHAV/zWZxCTHjl6+AZm
        CAXSyO+MFPoof20=; b=Id9DKAh3kv15b/ZRUmolzN7CralUQH43ruz9z2sr/FUq
        4zrLNFJunTlZjHEnPzskU45akb5jBWosdYWsE2XNK32biAgrETFGCqo1+4vqIl7E
        WoMpK1cVF3LlBMKCFwN2GE3zPb9L+AbCjvqpSl0ABwFBeIe9NKB5Pv46g1KM22E=
Received: (qmail 2544193 invoked from network); 1 Sep 2020 16:22:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2020 16:22:14 +0200
X-UD-Smtp-Session: l3s3148p1@o1PiPkGuMIwgAwDPXxBIAL7SzoTwUEK2
Date:   Tue, 1 Sep 2020 16:22:14 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: simplify an expression
Message-ID: <20200901142214.GB11393@ninjato>
References: <20200901141931.25357-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20200901141931.25357-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 04:19:31PM +0200, Wolfram Sang wrote:
> We already have 'host' as a variable, so use it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sorry, I overlooked this depends on another patch. Will resend within
the whole series.

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6b3056437b37..6794eb142f05 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1173,7 +1173,7 @@ static int mmc_select_hs400(struct mmc_card *card)
>  		host->ops->hs400_downgrade(host);
> =20
>  	/* Set host controller to HS timing */
> -	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> +	mmc_set_timing(host, MMC_TIMING_MMC_HS);
> =20
>  	/* Reduce frequency to HS frequency */
>  	max_dtr =3D card->ext_csd.hs_max_dtr;
> --=20
> 2.20.1
>=20

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9OWRIACgkQFA3kzBSg
KbZQGhAAmZ/oUa4bC/3Vgqmq1rCZQVv7Zu1qyI9Rd7Q2mIxnl1lWAU/2tnXTEvJn
EG4guIN0aVAbQDO26HAwdP7ZuA+nxMZKeYoLOZR9rikIZoAM/yM4PJ2DfGLjhoV3
Ojg7GlD0GH48WwCubdRqfFWdZQQo7rYUUmUD//rgcw43JM4hX+sXZQwd82urnKWi
pyIk7q8xvA1J7J3Q1LrCbJsgARSzGQparsSNjIgHtVV4TVUiWGEBXUAmARingnuu
5no6/FWgQKpLjZm/jcQ4qQiPzxGieLCwOmwO2T++F5BuS1uEwYV28zVrXzcrmgRO
/oh35/G4bB3vH81y1Ym5Db2JWBe0PTpcgEZyHcpdVAmZO8FHVJW5T/YT4wArXK7L
EqxQXCl25EIxzkYeGsUygSdGY2GEJC4g017wnt3yRShJtI6Eh/qxmhWpr8Sez7XA
/+aMdV+34s7Tc40rgfQopHaHMkHlSct6VB6j9yQPFpzS0PAAWRM10OKg0qWc/bvj
XooOl6PGTIB64lxSRVTdJ5BEGYF5hNFpSKZ/1rWYj6N+SJEfS8ojSazB+0fJ0Zwz
9wrupvMqDWR8nEubkxbT5omyhFwyphGNCQJCrdDGVOwVQ+le1Yv2pgMlE3xO7b/2
2etBcjwO4SkLldue1a3TkntszPpPQ8Xt3CNE6x4F8YYfDtebuR0=
=somm
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
