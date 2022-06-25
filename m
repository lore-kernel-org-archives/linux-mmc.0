Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46904C433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Jun 2022 08:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiFYIPz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Jun 2022 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiFYIPz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jun 2022 04:15:55 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2012031535
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jun 2022 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Pgxk4GfqdEazMAaUU8Vogm2IvjJW
        if2mBoFjn2TkMjk=; b=Nf+lUCla94gyxk8LVQxRbj9mYLSCbDmDWziQGqiEJWUx
        Xvi6U2bnZGYMyHW3ugkYNa9KaHaYbDloZj/Ijh4tSbltdUBe7NLEy3fqCiEfe8CD
        myzROIqI2UYIuJaU2WKPcwWe/YsU4puPWSPtJsSIdhWD2ICCXJBJmMF1EQgr5zM=
Received: (qmail 1730323 invoked from network); 25 Jun 2022 10:15:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jun 2022 10:15:48 +0200
X-UD-Smtp-Session: l3s3148p1@9S9VS0HizZgucq2i
Date:   Sat, 25 Jun 2022 10:15:47 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] mmc: renesas_sdhi: Get the reset handle early in
 the probe
Message-ID: <YrbEMwqtpTPWCJte@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624181438.4355-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uukWhCvGKCjJxTsP"
Content-Disposition: inline
In-Reply-To: <20220624181438.4355-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--uukWhCvGKCjJxTsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2022 at 07:14:37PM +0100, Lad Prabhakar wrote:
> In case of devm_reset_control_get_optional_exclusive() failure we returned
> directly instead of jumping to the error path to roll back initialization.
>=20
> This patch moves devm_reset_control_get_optional_exclusive() early in the
> probe so that we have the reset handle prior to initialization of the
> hardware.
>=20
> Fixes: b4d86f37eacb7 ("mmc: renesas_sdhi: do hard reset if possible")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uukWhCvGKCjJxTsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmK2xDMACgkQFA3kzBSg
KbZ6vw//dYXe8UJWJ4MK6BZEyBiOHEgwHi/XvYWgWd7XgvHGqEbxS/zHZfkp7sjH
CBm7q7lDmwoNpcyNIWxeTYalAnTMMLSjNu7aV112qc58Bj6DmyuvHvP0kN+eD8dP
wyTGXkW4hEhLvAuHWhocPoS1iQ9IHiOCOqS9vyO7ClKkEKJIflbJqI1RCeUc4BVS
C3WAmfLFtorwQGt44IQJ7NteAcpxbwF+o4oG59o86DkdscbHlQNxEEJDnAqPz8Cb
3rVkO7g1NnF3NsO4ko2uFEoyMa5z1lkkvGIztdLHczg6nDUIWtjpqAC1/tzbK8u2
emgJfmKpULEivIMt1TBSpRAdJHK0gqt5Q4IuZzy4R3VQjOkaODqoEVwPiRYBf5qU
34QaH31pbHbqqKk8X3b98J5jZXr17KsguZMYUXHb4ivl/kFHH8U1rMhppSdIK0to
VRNarMDkOkQG31vWyjYhydHRzNlyXTdnqUoQ38MP5eTbJSge3GapAvK02ilA5VJG
KipMmBmWh3jDoLPYBqEIXfbRbk071HDqsP15CySUDQgS+dTDjSqFLf27qsjMy8xe
bqifTDsBZGrjsxrw7ztCiJCwbIJ7zQJanHghAMsfje3I42WLGRpc8fgfz8uBijnp
mnXAInO8quyuOiWRLEq+PqVrJNOMOZZYB+jLj492RttIDQnOPog=
=TIva
-----END PGP SIGNATURE-----

--uukWhCvGKCjJxTsP--
