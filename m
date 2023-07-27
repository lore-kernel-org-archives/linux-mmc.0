Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96412C001E0
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Jul 2023 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjG0HoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Jul 2023 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjG0Hm7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2023 03:42:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4239883C5
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2023 00:36:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOvYB-0002P7-JL; Thu, 27 Jul 2023 09:36:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOvYA-002QP2-2r; Thu, 27 Jul 2023 09:36:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOvY9-0088t7-6v; Thu, 27 Jul 2023 09:36:41 +0200
Date:   Thu, 27 Jul 2023 09:36:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in
 sdhci_f_sdh30_remove
Message-ID: <20230727073641.kpwnnu3aywa56ip2@pengutronix.de>
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-62-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xi4w3mp2vov7xmn"
Content-Disposition: inline
In-Reply-To: <20230727070051.17778-62-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--5xi4w3mp2vov7xmn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 03:00:51PM +0800, Yangtao Li wrote:
> The order of function calls in sdhci_f_sdh30_remove is wrong,
> let's call sdhci_pltfm_unregister first.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

A cover letter summarizing the changes in this v3 compared to v2 would
be nice. Also mentioning the base for this patch set would simplify
things a bit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5xi4w3mp2vov7xmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTCHogACgkQj4D7WH0S
/k6usQf/da0MA8MgxgnuViEoBuKE39/GsKojI3lJ+Ma0SACqFBkpui9mNslWTo2f
sSdE0JljcQlsCq3GTLC6CLeZwP9Cjl52FLeK/gCVhsh/Is1ZU/y9a/Mqf2mxCV04
+jCoBwBmwIn92Gtm5AvaR3vNU+a2TLbIJjneuFnnXmdMv9QD8U+zBL9afb3j2KID
k76c9Lhuhg4erg1rQUV1K6MD7vXhLeqaADMOtEn+4GTKZMX8lxR0s+iftzJranL5
o5i/nFUbg2b9Tt4GDUFTBfOO70urhvVAmr0goV/DkUi7SR1Ke5H72ibTTT2F6Gr9
8XlW8UgbS2NMjRcs6f+xx3Ft5z4eww==
=qZfn
-----END PGP SIGNATURE-----

--5xi4w3mp2vov7xmn--
