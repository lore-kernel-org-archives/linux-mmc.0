Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DE7C6FD1F
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Mar 2023 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCSQiQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCSQiF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Mar 2023 12:38:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB612585
        for <linux-mmc@vger.kernel.org>; Sun, 19 Mar 2023 09:38:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdw2h-0007Tl-Hm; Sun, 19 Mar 2023 17:37:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdw2b-005GT3-6P; Sun, 19 Mar 2023 17:37:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdw2a-006C3R-D9; Sun, 19 Mar 2023 17:37:52 +0100
Date:   Sun, 19 Mar 2023 17:37:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>
Cc:     TheSven73@gmail.com, ulf.hansson@linaro.org, fthain@linux-m68k.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, kernel@pengutronix.de,
        srinivas.pandruvada@linux.intel.com, lznuaa@gmail.com,
        pali@kernel.org
Subject: Re: [PATCH] drivers/mmc/core/bus: Delete redundant match function
Message-ID: <20230319163749.cmdyak2mhsetjt6e@pengutronix.de>
References: <20211206165038.123107-1-sensor1010@163.com>
 <20211207072322.37dljknm24nk5vk4@pengutronix.de>
 <2447b32c.1d53.186fa5703d8.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="57nfhufrbw27cwsp"
Content-Disposition: inline
In-Reply-To: <2447b32c.1d53.186fa5703d8.Coremail.sensor1010@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--57nfhufrbw27cwsp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lizhe,

On Sun, Mar 19, 2023 at 10:47:32PM +0800, lizhe wrote:
> HI : u.kleine-koenig
>     1.=20
>     This is the earliest submission record for this patch.
>     you were also involved and gave good advice.=20
>=20
>=20
>     2.=20
>    in may 2022,  i submitted the pach again.
>=20
>=20
>    i discovered and submitted this issue twice.
>    i did the discovery and submission.
>=20
>=20
>   please consider receiving my patch. thanks.

it's unclear to me, why you address me here. For the patch under
discussion it's not me who is responsible to judge and apply your patch.

If you check the output of

	scripts/get_maintainer.pl -f drivers/mmc/core/bus.c=20

you'll see that Ulf Hansson is the right one to nag.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--57nfhufrbw27cwsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQXOlwACgkQj4D7WH0S
/k7z+Qf+J+J3TZyttAyGr55dzmAYowOEX/4G6MtCZkc3/cEo0rZj5Fug6O+627ew
s5184bgcYqLS2FdStoCiTr6bpYre9gH7pdsYJi3tHeSvn62WmfIeHq8qVh5pct5T
Ra1BNOrOfrtXNlCHI7rD7UOrgxoWa7m+dWfsUV/oMuBE0xbj4N9MS+EaiUNu78v3
IfwJHbCev4gLL8e1Zuz9M/KvMn5x4otYUqmd7wwUCudLHjUtZ2JlTNFHjj3PVUjb
3t1tyKjZOER8sydO5zNPQ9U0kXHBh9RehEdIyzR9y8IvWjpJIRLifRZzRpAczk6R
OQcHawH5+0MxOeFDIDbGkuB3WNoKfw==
=+VhL
-----END PGP SIGNATURE-----

--57nfhufrbw27cwsp--
