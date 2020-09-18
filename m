Return-Path: <SRS0=X25L=C3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622CBC43464
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 21:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE721D7F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Sep 2020 21:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BiPu5Rts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRVym (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:54:42 -0400
Received: from www.zeus03.de ([194.117.254.33]:60608 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRVym (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Sep 2020 17:54:42 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 17:54:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=UElttBirg1sWaGcL1eGYBmQa2SWs
        9muzZlQ5Mtk1EL0=; b=BiPu5RtsR/3JvUnIfD7dr3aaFjjXrTlNGJzWjiopLre5
        6rNoQIvY73HDPRPz3sSCVPHiNNTlNJiFh+KHLhglyncsSUk9/caorVpcDnrGb5jd
        fhvY4fNCq6TBhzvSOya2VxaeK7v5bS07Sglt27mbVMqNrg7b787ZOh7wgKLTdnI=
Received: (qmail 3464751 invoked from network); 18 Sep 2020 23:47:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Sep 2020 23:47:59 +0200
X-UD-Smtp-Session: l3s3148p1@QGtNdJ2vRodQT+F6
Date:   Fri, 18 Sep 2020 23:47:59 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: document mmc_hw_reset
Message-ID: <20200918214759.GA65185@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20200916090121.2350-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFoUw=xkPbCORSJ2io7Gs34dbbXQaGXdTsuzUqd+WEdR=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoUw=xkPbCORSJ2io7Gs34dbbXQaGXdTsuzUqd+WEdR=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 11:47:10AM +0200, Ulf Hansson wrote:
> On Wed, 16 Sep 2020 at 11:01, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> >
> > Add documentation for mmc_hw_reset to make sure the intended use case is
> > clear.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > While working on this, I get the feeling this function should be renamed
> > to 'mmc_card_reset' or something similar. 'hw' is still confusing
> > because it could easily be the host controller, too. I volunteer to
> > prepare a patch if we can agree on a better name.
>=20
> You have a point. Although we also have mmc_sw_reset().

Ah, I didn't know that. Though, mmc_card_{hw|sw}_reset() sounds still
way better to me.

> Another thing that I would like to change is to make both of these
> functions take a struct mmc_card* as in-parameter, rather than the
> current struct mmc_host*.
>=20
> Not sure that it would completely solve the confusion, but at least it
> would be a little more clear.

Maybe if we do both, it will be really clear? :)

> > +/**
> > + * mmc_hw_reset - reset the card
> > + * @host: MMC host to which the card is attached
> > + *
> > + * Reset the remote card. This function is only for upper layers, like=
 the
>=20
> Perhaps make it clear that it's a full (or hw) reset, not just a reset
> (as it could also be a soft reset). Moreover, I think you can skip
> "remote".

OK, will send V2 in a minute.


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9lKwoACgkQFA3kzBSg
Kbb/iw//WkECDwEHSfNhrpknFeUJNWY+p9t090A7Z3CVfMEj1M6UA8m3tqD6LSWs
t/AZARmzxQKLD5rSblUHozrijGFc+kwj3CSj1MC9FhL5qZNaI77Ntzd+aUb/pgQE
06ef0oDoUgG7JOsI5562M7tJrdKq28OrUB2bxfHEhzHmuv6aPhV2HRmhZC/WUy0N
to7bJ7DSKqNFvyl6RShJcYioVGzCr9qG31egmr5aQPieXHnEaFo4q+sZMT2iXGTw
2Bk6iEsh0HS3XlEKg1M48WXt9JczztZVhLhHTdMb7dCQjaahvm3vnuroV6I1gBI3
6Ior3Gw8p7h83IlKzxNL4PUgk5Adx7gSPj7WUFU9NK4POTHxigGx/3HUxuXzfKCE
Z0JQ7A2YvfVY5WDYCgUFV7xqb5cmYjoF/lw0Wr9RN6W6FjdYhThg2SWezcqiJFHM
E4PFHHyfkFgPLU3uLuW9KM8eKgEG/fatBSmfAMZb/Ka74YJR5YQJ7/8N0XMCc/0c
mw5MKJmS2luessmAUtSXpaAWZlN2U75lvzlXAps+/hL/7DPaBEEvHtZddX8ynUbv
DQPctenWQwuKnOhfYkspjoGDMOHQiVnYOpxHo8wfiOtktL4XoVv/bMYjGzjKLdAB
dltBRqXdLCry72HpOSNwq7cgus7LFIxhB3Vz25zoc1f/mG3Aavo=
=2+Bh
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
