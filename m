Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6622C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDDPCd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjDDPCc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 11:02:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76EA40CD
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 08:02:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjiAZ-0002lO-Th; Tue, 04 Apr 2023 17:01:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjiAZ-008wji-5Z; Tue, 04 Apr 2023 17:01:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pjiAY-00AX89-Ek; Tue, 04 Apr 2023 17:01:58 +0200
Date:   Tue, 4 Apr 2023 17:01:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: sdhci_am654 and runtime-pm issues
Message-ID: <20230404150158.c5qy45truzyd6kjm@pengutronix.de>
References: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
 <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com>
 <20230403151712.pqzmyqz3tose3bc3@pengutronix.de>
 <CAPDyKFp0W_e051Ke2QFx046GH-u+TW+TaQxTjzWkuQFxf4KcPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkdsg5fpz2vfmvhz"
Content-Disposition: inline
In-Reply-To: <CAPDyKFp0W_e051Ke2QFx046GH-u+TW+TaQxTjzWkuQFxf4KcPg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--fkdsg5fpz2vfmvhz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ulf,

On Tue, Apr 04, 2023 at 02:41:33PM +0200, Ulf Hansson wrote:
> On Mon, 3 Apr 2023 at 17:17, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Mon, Apr 03, 2023 at 12:19:20PM +0200, Ulf Hansson wrote:
> > > On Sat, 1 Apr 2023 at 15:16, Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I looked at the sdhci_am654's probe function and concerning runtime=
-pm
> > > > this is at least unconvential:
> > > >
> > > > It does
> > > >
> > > >         clk_xin =3D devm_clk_get(dev, "clk_xin");
> > > >         if (IS_ERR(clk_xin))
> > > >                 ...
> > > >
> > > >         /* Clocks are enabled using pm_runtime */
> > > >         pm_runtime_enable(dev);
> > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > >         ...
> > > >
> > > > I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but I
> > > > thought it is to be used the other way around, i.e. put the device =
in
> > > > operational state and then runtime-pm cares to suspend the device u=
nder
> > > > some conditions (e.g. CONFIG_PM being enabled).
> > > >
> > > > With CONFIG_PM unset the driver is broken for sure, as then
> > > > pm_runtime_enable() and pm_runtime_resume_and_get() have no effect.=
 So
> > > > the clk stays off.
> > >
> > > In principle, you are correct. I wouldn't recommend the above pattern
> > > in general, but it doesn't mean that it can't work.
> > >
> > > Some platforms are selecting "PM" from some of their toplevel Kconfig,
> > > as they simply can't work without it. That means that the code you
> > > refer to above, doesn't have to be broken.
> >
> > If I understand correctly the driver under discussion is supposed to be
> > used on SoCs in the CONFIG_ARCH_K3 family. This isn't one of those that
> > enforce PM.
>=20
> Right. Thanks for checking this.
>=20
> In fact, I have just queued up a patch that fixes the behaviour [1].
> Maybe we should consider to backport it for stable kernels too, at
> least if there are some reports about errors!?
>=20
> > But yes, adding a depends on PM would be an action that improves the
> > situation. Having said that even on such platforms you can disable
> > runtime PM, so even a select on PM isn't a complete fix.
>=20
> Note sure I understand this. In what way do you mean that runtime PM
> can be disabled? Normally, it's the bus/driver that decide whether
> runtime PM should be enabled or not. Right?

You can disable runtime PM per device via sysfs. (Something like:

	echo on > /sys/devices/.../power/control

=2E) The docs say "Changing this attribute to "on" [...] while the device
is suspended causes it to be woken up.", so the right thing seems to
happen. (I didn't test what happens if that file is written before the
driver is bound.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fkdsg5fpz2vfmvhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQsO+UACgkQj4D7WH0S
/k4QVAf+JUE1P/oLlruF93D/h5yfTEVBv1fVar/9sGN8EJwoFFl+LeMcBlgmyLM+
3t72+N7vnvqfPVfBELy+N9mCQvXfTfZohCh9i1n+CT8zL4A1l0PRL/Wn8UGLHMKA
3mmuqnRrZ7eWeXsj/EtWBArwGYqR1xtaUouslWiRMYNVH0nD+LB5gteRTvStqIV8
lwhKRraGcWaNJFytkgIZePTl2VPSSShOieorYJONo1/Qvmd8miWodTfXnh56Iq0h
8Q2VzX4RB/ztNJL+9NL7npsmZAc3fOAjHfhivXrPiz52wSjMw2T7XTL4PBox7Rej
l/PCl0XibjAO0+/THl2aB66dAVwnag==
=+hI8
-----END PGP SIGNATURE-----

--fkdsg5fpz2vfmvhz--
