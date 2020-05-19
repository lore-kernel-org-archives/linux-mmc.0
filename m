Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A9FC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B042072C
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ED85HAT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESLcf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 07:32:35 -0400
Received: from www.zeus03.de ([194.117.254.33]:45556 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgESLcf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 07:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=M/0PbwmMp/KQ+QwbeMlV+an7rw4H
        cCBFhHGtcLD6y8E=; b=ED85HAT/feAqYguFrh1DAExzCYPkPaEztEaH0AUitOkF
        3N4s++CFgmMf7JaBQd87aMTod2qb7rTovVseQ3VKZDvtw2uwPbHD8vqrqB42sTZG
        lRfQjhBg6BgOCyxK1N2t7raOox8vHtvqwKyj2yKHRUrOeaOg4NpDlkAYOvC2Zx4=
Received: (qmail 234079 invoked from network); 19 May 2020 13:32:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2020 13:32:33 +0200
X-UD-Smtp-Session: l3s3148p1@HOqrov6lfOMgAwDPXxCmAFNwG0mTH/5q
Date:   Tue, 19 May 2020 13:32:32 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started'
 while probing
Message-ID: <20200519113232.GJ1094@ninjato>
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato>
 <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato>
 <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
 <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
 <CAPDyKFqM6YoS+0YhHaqLqjZYnvQywb9t0OHQ1Lw2T=dAKeWvtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqM6YoS+0YhHaqLqjZYnvQywb9t0OHQ1Lw2T=dAKeWvtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> And no matter what solution, can always drop to manage the "main"
> clock from renesas_sdhi_clk_enable|disable() as it's managed by the PM
> domain.

Good. That was what I was aiming for.

>=20
> Although, then we need to call dev_pm_domain_start() prior
> renesas_sdhi_clk_enable() during ->probe()?

Yep, I moved it upwards in my proof-of-concept diff. But it would be
better if you would apply this change in your patch already.


--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7Dw8wACgkQFA3kzBSg
KbZlqQ/8DYS3B50jEa66KyfdN4uTscPXNJP653R/kygwl/uOhz9GgXjLle8RVw8g
1Q89YqwMB/VklsXynhpSBCtafEIdADoF1ODtzBXRM/yIOXqSIu/+3BvwLjtdAzK1
n/ucfCLhIgxpOmbQbt8S1X5OTIBOxjtQg75KjaQMPFhYMpJPh0awdm9+eb6UjiJC
23Tyrg5WXoB8sIzSTyCk45fpB7scgo3DjGJb3oROzEzO51/7fUWSu0NdHCiy9e3t
+uYtjX4HKQrfJDCtPjVxmWCIhWUi1WxVVEjjXxWsJ2LZ92wbJZTmkGWzmsN84ZMo
FlcR2TyMRQWG3C8MWPm6jZBbRAgmakkQByXvK8MwvhE+iYiL/xY0HexITPldSfXI
NZRMfk3oX6yEhveJhmkN3WfsOFE1iCakt9pDoUBRPTQ5gcBLXXwRNLCsO/uWiwdr
8dz/zkJiov/smRYtLI4NEiLr1L2QLEp2qbGPNdL9zG2TAwCKpUZ9+TXSjIS6M5pf
XqBhqWD1V8+n+Jz3op5Y6y0hzi2wv3VBcYex19Cj/9v+OJkH06EYquz3guMRER2u
mKv22kl569D1cEWFYq6b8JXHfghIpE7a+9nzYd43RhG6labF6NvlCuTaWopXgqtM
icLObz8g3da2zsyAZAq2dETROSr+zqRV0tkRZ1wf1TOZxUp7Do8=
=zApZ
-----END PGP SIGNATURE-----

--va4/JQ6j8/8uipEp--
