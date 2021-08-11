Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A6EC432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5DE61019
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhHKNZP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:25:15 -0400
Received: from www.zeus03.de ([194.117.254.33]:36628 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhHKNZM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Aug 2021 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=0C/QMw9lspO1z11qtS+ELVksM9VL
        bqRKf1rdkezG+2g=; b=LCDjXeOiUfUC1oj6jSTtoBHTymkQqBb1Jn0Q3zUNFLqz
        E/ARIb2jwVQn0HOBOxLxnJwlijWvlJDrQl88ePENe28zMcxxvnB+jYkhu1bGx46N
        5+FfzM0ujqLoSVVW+xV3c7Ai10doWkGaGv+vpUUA1vpzhmPiK2hKrVV5Yb4KusE=
Received: (qmail 2664691 invoked from network); 11 Aug 2021 15:24:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Aug 2021 15:24:47 +0200
X-UD-Smtp-Session: l3s3148p1@/zrJikjJ+J0gARa4RTP4AfHKOCm/nqrR
Date:   Wed, 11 Aug 2021 15:24:46 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] i2c: sh_mobile: : use proper DMAENGINE API for
 termination
Message-ID: <YRPPnh2Q9/T1SEUC@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623095942.3325-1-wsa+renesas@sang-engineering.com>
 <20210623095942.3325-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svr2w2zu+FmcN8G0"
Content-Disposition: inline
In-Reply-To: <20210623095942.3325-7-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--svr2w2zu+FmcN8G0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 11:59:40AM +0200, Wolfram Sang wrote:
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Here, we want dmaengine_terminate_sync()
> because there is no other synchronization code in the driver to handle
> an async case.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--svr2w2zu+FmcN8G0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmETz54ACgkQFA3kzBSg
KbaBZg/9Hr0ckqBE7SfuC3nPCI4zxuToeE3sOVTXfDwY4eF5LqVeOR9gGuieD/UP
YT1HNPOC7SSywAGzSwTfjxhd2AzEYjYtmhvu72X2dap/49rLwEMA6sMqjNaDzrzC
8F4zlaCuEkRuHXXJ+BP/lJC6CJjP5I0inAmKURaonUA8fLT10x1SqlbRFOVeLLDj
JcX9Fy6Gq6luWXqhT5HBVRmEqpSY6Vc6BbVXIClHiRPc86N6KPzbIjhkatZ8xcMn
S0WUOIcArpfb0QBsKKT9THrYrb40ywlNoB9yYxSYFtVz4vPwLcOBqkBcFCpeZNQ6
N84N4C4LIVuU+jF7CSggrt7APb+bqFhvoWPvOPQXpbZzdvxxkGXuwhcB/HdsLiGW
T63g7f24pPOsUM3TXTKqLryaKXnaPgYOqGMN24qC+3aolTlNrIqHpjAWEv0J/x3v
SwW9N3qeODj2OkWveXpA6o4ZJziL3uzmv8RFnP8wkI+8aOL+NV6OW2yBzoQvFx2S
0VE6AxEtZeH2Qzi96P0roimEKMzFBvT9sGTGfAvgTkiocCRdXFo7UR9VPldszxPw
HUSCQHzgB8F/qebKTRy6Ne3Q8ohmD/UtoEClfuc5SM1PpUSo6ci6z9plY4kgconR
fK62SS8bPLQrfW+n43GcC2S1X1f8tLhhinLUp9+6D6u6dIyhXLg=
=8DB1
-----END PGP SIGNATURE-----

--svr2w2zu+FmcN8G0--
