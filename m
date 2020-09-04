Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25918C43461
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DABE206E7
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 06:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iRNNr3B2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIDGDo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:03:44 -0400
Received: from www.zeus03.de ([194.117.254.33]:46218 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgIDGDn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Sep 2020 02:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=2j2B6NemcV8Dxeu6oSNbEuFBis/7
        VkF6rkRjkhOxqCQ=; b=iRNNr3B2DUSgFPPfphdXJmRk/r1Ok2OTR4IJi6L6UwsU
        MPi5BE0sy8aFqkiipm4rjGfBw60v2jM9lSB/+FAxwJuBrjKUBlLgwP3heNdbi8As
        l7F+An0yjq9qwJ0nZefjKOi+l+kJJgLrO0X5SXFv5XSFtGMj8gYFkUqRAUJGCkI=
Received: (qmail 3465450 invoked from network); 4 Sep 2020 08:03:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Sep 2020 08:03:41 +0200
X-UD-Smtp-Session: l3s3148p1@lax2oXauHqEgAwDPXwlxANIWpbLKE1Uh
Date:   Fri, 4 Sep 2020 08:03:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: Drop local dma_parms
Message-ID: <20200904060338.GA1506@ninjato>
References: <85e1fc97dbec3dea96102785a5e308ccb5e91cfe.1599167798.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <85e1fc97dbec3dea96102785a5e308ccb5e91cfe.1599167798.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 10:18:06PM +0100, Robin Murphy wrote:
> Since commit 9495b7e92f71 ("driver core: platform: Initialize dma_parms
> for platform devices"), struct platform_device already provides a
> dma_parms structure, so we can save allocating another one.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Double-checked the mentioned commit above:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

No regression and same performance when checksumming a large file:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for the patch!


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9R2LYACgkQFA3kzBSg
KbYNPQ/+LySpPJv7gjCKYrfj8+CLJgz77TYtIdkVeOYKkZWvz5CEvrYPquOJ6Otx
9z66asp0e9aupqEevqSy/sdFcvBnCnUfzGWfm6aY7C2bvTW/ay7hSk9mqHz4yoMd
LqS9oXdRfL9pfurPh68MFx0kM2HWTCV38YF6Hm9Rwlnwct/Ea2l48YpZx9dpiYm1
M2SkP5DvhBlMJAlJ2bE3m6RqSN7O7gQtPmNCHrT+ixiLiv3mQCPtO3YAY8CMcaeu
igP4qvt5drOLPyNqlCsdJLLzu9H9I8aSg6RkkUVxnLIT7q3JLYa/oGuwGfAkX0ne
wnX4fZS06sM3i2ZS3UVHHt9nUKbGKre/yGoCNFzS4XNwLwqXBvClVKNCeyJHS59T
rnF3MCNWKskFCblmRB9VTOOKlNDnEVjv0Nmx91SY4ijQIr87Fxe5GcEGcJRYNRlE
JL12rNV0xUk0oLNP/ZEEIWsy90k/p5H/U+P/Zp2bz7cay+VuoMSrH9dJ7aGhN8WQ
kyKmM95BVYc/9GeXt/Zwl24pMzskICwwJWA4T3joNo3tuJrJ0hjsi/XUrYXrFeuq
bLojTEqnSvq1FMga6sqFASH89bmZ4sdurAncU4bEIil4bRzXrS0om19xlkKqMVu3
wqnbh3+0ASBDxHZdkJZVvnoifhoahlzosNNvhW27FBFSvZ8du6Q=
=Q1Tk
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
