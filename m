Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035BC6FD1D
	for <linux-mmc@archiver.kernel.org>; Sat,  1 Apr 2023 13:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDANQi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 1 Apr 2023 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANQh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Apr 2023 09:16:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF711C1C6
        for <linux-mmc@vger.kernel.org>; Sat,  1 Apr 2023 06:16:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pib5t-0007FZ-Oc; Sat, 01 Apr 2023 15:16:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pib5s-008Egx-VK; Sat, 01 Apr 2023 15:16:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pib5r-009iOz-Uc; Sat, 01 Apr 2023 15:16:31 +0200
Date:   Sat, 1 Apr 2023 15:16:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: sdhci_am654 and runtime-pm issues
Message-ID: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tc42fogcrc63y77i"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--tc42fogcrc63y77i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I looked at the sdhci_am654's probe function and concerning runtime-pm
this is at least unconvential:

It does

	clk_xin =3D devm_clk_get(dev, "clk_xin");
	if (IS_ERR(clk_xin))
		...

	/* Clocks are enabled using pm_runtime */
	pm_runtime_enable(dev);
	ret =3D pm_runtime_resume_and_get(dev);
	...

I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but I
thought it is to be used the other way around, i.e. put the device in
operational state and then runtime-pm cares to suspend the device under
some conditions (e.g. CONFIG_PM being enabled).

With CONFIG_PM unset the driver is broken for sure, as then
pm_runtime_enable() and pm_runtime_resume_and_get() have no effect. So
the clk stays off.

I don't have the hardware, so I cannot test. But I guess someone with
interest in this driver might want to take a look.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tc42fogcrc63y77i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQoLqkACgkQj4D7WH0S
/k5RmQf/UXmL09IECWuUC+mGO7wUYRSCFDnHYEpPBd7vWqbEIhV1JMsoSScqOqhZ
TdYT4R8mVR89Z0AphhuvyuqPzz5r2UmstlJ+XOTyBHgTZf/RYdqdYgU6Hie/WK20
mZlH52K7EiQ0YpkcIQh+QrVu8bUAKPVwTSs0GqxPsN6WAja5NjiVh12KWteIqTRe
zP20hV+jNoEaTS5PFQDW147IA3WX/g1puh4w8/Q0Nr7ZjPiydnUc+E69her0Sp7d
9Ax870Nc4Qb9wm16Cde3AWhC9pgmbjdGfAzPSBqAqzE3Y9CR6JY0ekvf9zqqdOwF
LF2yKBXUucZTWxzUAEHDYjG0Q09bvg==
=tiEG
-----END PGP SIGNATURE-----

--tc42fogcrc63y77i--
