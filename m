Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3AC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B298420758
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 11:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="2ZIiylDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgESLfs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 07:35:48 -0400
Received: from www.zeus03.de ([194.117.254.33]:46766 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgESLfs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 07:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Fr7SK5ZlMO7ObWQT9rVGgOnzmdw/
        gHa5YkKKChKkP3c=; b=2ZIiylDRd5e7OUIeZU2kRVs7hDQ89rJXN2IOyfbLz6RY
        7yfZ7jidIuUvq7+HooJQAmXj+cleuYIdw+mgFVZq7ReQTAVtJOTfn+WiKMOdEMox
        BZT+3SRbGtm7TAqDAxUNmCVuKllstqcPhjGgdiPiLE7eEoeXuZtuHU0XN9WPtv8=
Received: (qmail 235465 invoked from network); 19 May 2020 13:35:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 13:35:46 +0200
X-UD-Smtp-Session: l3s3148p1@ujIvrv6lfuMgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 13:35:45 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200519113545.GK1094@ninjato>
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato>
 <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato>
 <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
 <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This means dev_pm_domain_start() is needed only for the SDHI renesas
> variants. But on the other hand, it doesn't hurt for the others (the
> uniphier-sd variant doesn't even use runtime PM as confirmed by
> Yamada-san).
>=20
> I don't have a strong opinion, but it looks like we can either apply
> $subject patch as is, or modify it to make dev_pm_domain_start() be
> called only for the SDHI renesas variants.
>=20
> What do you prefer?

Dealing with PM is confusing often enough. To keep it simple, I'd
suggest to avoid unneeded calls. It may take a while later to rediscover
if this call is essential or not. So, for the uniphier case, we know it
is not needed. If we agree on a best effort basis that it is also not
needed for tmio_mmc, then I think we should keep it only for Renesas
SDHI.


--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7DxJEACgkQFA3kzBSg
KbbFmQ/+L2mBWlTid0R/FtjJaab1r/dnsc7vkBGWoLECY8SFi3/bQQmbPNrBaPCq
AuxqDt3yKc2wOD1Bzd2wqlDwzX6Kqr7Zfjh9KcLbSIcQDJwv2/AeItv9VOl6Z3fr
cKlLep4SOU0CppGLqTQa3ivt+GJDxEenk82HsSb1pSvh1ezbx8cOf7wu4yzRRh/t
iG3zNtwIZ5hMHmpsd6bBJCOwCjZu/idAOyI788jqDeg9/PNsR4tQxjKJf78vwjKQ
U1MMgPu/QMCrBMXNRcSqfhm9tO5wh24hie09DsshhKq85Jgy4gpreku9Ota/rkdq
pWtB+BpBMnRCvDR5C6+DWGOP3uAKaS1mZq4TOQN4kj6Vnljb1Sd7K+XuMtlnf0UO
7u8Rf2FIaKt5QYcNoE53WkrMOWC40LJ16Dh2JUNFHJ3FnWXQNqtx9jqVUrTdbAxn
jG2xafcxajc7kh7ApihGymburP865OYUFO6pUKTi0SNq6k8/0dC5LdV1GnmWVlMb
J6LxydsaqfW9BVe5s25d1aft0Zb/d3aq8LUMluw4J+0QPj9QlztrKDFeIyN7x84l
WIDNIq3PU696/zxCG/Ed43tOs2nLMRiajrV3GpZAOp0QVN+AcwUmaFBxOEPsUhYY
nmQxcLt+c2NjhQhcufeXMV2AZkM2Uw6kIxidHPC2b0FaBM6B12c=
=Y8O1
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
