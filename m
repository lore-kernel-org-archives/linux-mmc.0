Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F16FC76196
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDCPRT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjDCPRS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 11:17:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3030FE
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 08:17:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjLvm-0001oP-BP; Mon, 03 Apr 2023 17:17:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjLvl-008iVn-DZ; Mon, 03 Apr 2023 17:17:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjLvk-00AHSs-JL; Mon, 03 Apr 2023 17:17:12 +0200
Date:   Mon, 3 Apr 2023 17:17:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: sdhci_am654 and runtime-pm issues
Message-ID: <20230403151712.pqzmyqz3tose3bc3@pengutronix.de>
References: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
 <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dnfwsfaquk3wddzs"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--dnfwsfaquk3wddzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 12:19:20PM +0200, Ulf Hansson wrote:
> On Sat, 1 Apr 2023 at 15:16, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > I looked at the sdhci_am654's probe function and concerning runtime-pm
> > this is at least unconvential:
> >
> > It does
> >
> >         clk_xin =3D devm_clk_get(dev, "clk_xin");
> >         if (IS_ERR(clk_xin))
> >                 ...
> >
> >         /* Clocks are enabled using pm_runtime */
> >         pm_runtime_enable(dev);
> >         ret =3D pm_runtime_resume_and_get(dev);
> >         ...
> >
> > I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but I
> > thought it is to be used the other way around, i.e. put the device in
> > operational state and then runtime-pm cares to suspend the device under
> > some conditions (e.g. CONFIG_PM being enabled).
> >
> > With CONFIG_PM unset the driver is broken for sure, as then
> > pm_runtime_enable() and pm_runtime_resume_and_get() have no effect. So
> > the clk stays off.
>=20
> In principle, you are correct. I wouldn't recommend the above pattern
> in general, but it doesn't mean that it can't work.
>=20
> Some platforms are selecting "PM" from some of their toplevel Kconfig,
> as they simply can't work without it. That means that the code you
> refer to above, doesn't have to be broken.

If I understand correctly the driver under discussion is supposed to be
used on SoCs in the CONFIG_ARCH_K3 family. This isn't one of those that
enforce PM.

But yes, adding a depends on PM would be an action that improves the
situation. Having said that even on such platforms you can disable
runtime PM, so even a select on PM isn't a complete fix.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dnfwsfaquk3wddzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQq7fcACgkQj4D7WH0S
/k5BLAgAp7XFoqTlp7a5uBbrDqXfeevB7NrgtxKB0xml1pB44ZX/4elorvnrkMGI
3BVRmaNJO+Nd/oBgZVbHvwfgu1Uyd/K9jr5TF/lnXs6I26HNgIRWYRpWzSz9ZMaf
H5bqCyHbZx6yh3VkyllHXU3EaMFIxIUFidC3iCxW7YBqKGtfmgh5PrugbpkNvYrI
QPfJbQXKjFEnB4VkNVqW83ewuoG24bpjKPF550JTKkV2A0VYjdfImq6w2uEo1+mQ
ElE1SK1vHNd3ExkwrybKYvCqioyTEU7KiKMHr1c1njQPLwqtHw3g0l61b4/saUva
8ewqP0tsXC0WufWlcWJRwOTPAPqGbA==
=Gcuz
-----END PGP SIGNATURE-----

--dnfwsfaquk3wddzs--
