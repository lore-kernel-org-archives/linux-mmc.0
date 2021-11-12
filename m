Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E69C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7E61057
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhKLPDm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKLPDm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Nov 2021 10:03:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F709C061766
        for <linux-mmc@vger.kernel.org>; Fri, 12 Nov 2021 07:00:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlY2j-0002Kw-FN; Fri, 12 Nov 2021 16:00:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlY2f-0009aF-N8; Fri, 12 Nov 2021 16:00:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlY2e-0001S6-HH; Fri, 12 Nov 2021 16:00:36 +0100
Date:   Fri, 12 Nov 2021 16:00:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc:     ulf.hansson@linaro.org, srinivas.pandruvada@linux.intel.com,
        pali@kernel.org, TheSven73@gmail.com, lznuaa@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/mmc/cor/bus: Delete redundant match function
Message-ID: <20211112150036.6lhhoak4uk5hhgqt@pengutronix.de>
References: <22161945.a8.17d061e089f.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wbyaqsxhuvb4rjo2"
Content-Disposition: inline
In-Reply-To: <22161945.a8.17d061e089f.Coremail.sensor1010@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--wbyaqsxhuvb4rjo2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 03:12:51AM +0800, =E6=9D=8E=E5=93=B2 wrote:
> HI=EF=BC=9A
>      I failed to send kernel patch mail with git sendmail,
>     could  you help me take a look at the submitted patch?
>     the attachment is a patch file,=20
>     For convenience, I put the content of the patch in the body of the em=
ail
>=20
>=20
>                                                                          =
                   thanks.
>                                                                          =
                   lizhe
> patch :=20
> |
> From 40577316f4dbcf35061a14f27f7a777c2f4199a1 Mon Sep 17 00:00:00 2001
> From: lizhe <sensor1010@163.com>
> Date: Tue, 9 Nov 2021 10:13:43 -0800
> Subject: [PATCH] drivers/mmc/cor/bus: Delete redundant match function
>=20
>=20
> When the device and the driver are matching,
> if the device or the bus to which the device driver belongs
> does not provide a match function,
> then the device and the driver are matched by default.
> function 'driver_match_device' illustrates this mechanism.
> Because the return value of mmc_bus_match is 1,
> even if this function is not provided,
> the function 'driver_match_device' returns 1,
> so function 'mmc_bus_match' is redundant.
>=20
>=20
> Signed-off-by: lizhe <sensor1010@163.com>

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Apart from how the patch is put in the mail, a maintainer responsible
for picking patches up in this area will probably refuse because the
name in the From line of your mail doesn't match the name used in the
Signed-off-by: line.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wbyaqsxhuvb4rjo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGOgZEACgkQwfwUeK3K
7AlFoAf8Cau9xfSiQBZyFfnC7a9fAdv42gHWDFrcUV9IRMMMncRI86jgFP5Sp2Ju
+2/DEtNnc1xd+dkPWcJqkt9oDLze6b9yBNmLoBnmeBu2YOofObQ/3UECrpyuiy+H
B1fmgTG+VQqr8IGqCGrzSwFRlQBkPd1WiMs+9pTvtZDwd72PAaKAzZ3NuEkboAP0
vQ9QTF9jIxzzXpDrSD2RLb18+RUM3VzD1h1vS2bvCUirSyh86P6XDBTitv0YaMn6
thsdRIYLypP/ZPnW4Ca2FyGysR4tieWBCY9f5HPG5DLwO8fZyTte2TgKBIwkqYeH
iLIKwBbnZYvs2LL2wj3/npLzxaRtzg==
=ed8R
-----END PGP SIGNATURE-----

--wbyaqsxhuvb4rjo2--
