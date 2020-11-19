Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C479C6369E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2502467A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJc09AJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKSPTk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgKSPTk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Nov 2020 10:19:40 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E4F24654;
        Thu, 19 Nov 2020 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605799178;
        bh=0W6X+yvUpSkdAAGKagVENpsqMNRqNF4X/9HGlBkWMgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJc09AJAL2xk01qiS05ieRaCGIlLeUWY/cvod14/kBGzC1gFcG/mDtMvf8iSA9QUD
         jSD4dFUuEnrjJi4GroCmvV7jayJepAbLbLZeNgzQ9BKU3QE60JUhIRrlYDwHw/JhIU
         B+8st17jTJ6Z1DYEmUVIDvIfP/2L0eFW2zmF94NU=
Date:   Thu, 19 Nov 2020 15:19:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
Message-ID: <20201119151918.GA5554@sirena.org.uk>
References: <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
 <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
 <20201113172859.GF4828@sirena.org.uk>
 <74cfc6a9-3f59-d679-14b7-51102a6f11b3@gmail.com>
 <20201116133311.GB4739@sirena.org.uk>
 <332ab946-daee-bb83-24ab-0bda4fd8e1ef@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <332ab946-daee-bb83-24ab-0bda4fd8e1ef@gmail.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 05:22:43PM +0300, Dmitry Osipenko wrote:
> 16.11.2020 16:33, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > No, you are failing to understand the purpose of this code.  To
> > reiterate unless the device supports operating with the supply
> > physically absent then the driver should not be attempting to use
> > regulator_get_optional().  That exists specifically for the case where

> The original intention of regulator_get_optional() is clear to me, but
> nothing really stops drivers from slightly re-purposing this API, IMO.

> Drivers should be free to assume that if regulator isn't defined by
> firmware, then it's physically absent if this doesn't break anything. Of
> course in some cases it's unsafe to make such assumptions. I think it's
> a bit unpractical to artificially limit API usage without a good reason,
> i.e. if nothing breaks underneath of a driver.

If the supply can be physically absent without breaking anything then
this is the intended use case for optional regulators.  This is a *very*
uncommon.

> > Regulators that are present but not described by the firmware are a
> > clearly different case to regulators that are not physically there,
> > hardware with actually optional regulators will generally require some
> > configuration for this case.

> I have good news. After spending some more time on trying out different
> things, I found that my previous assumption about the fixed-regulator
> was wrong, it actually accepts voltage changes, i.e. regulator consumer
> doesn't get a error on a voltage-change. This is exactly what is needed
> for the OPP core to work properly.

To be clear when you set a voltage range you will get the minimum
voltage that can be supported within that range on the system given all
the other constraints the system has.  For fixed voltage regulators or
regulators constraints to not change voltage this means that if whatever
voltage they are fixed at is in the range requested then the API will
report success.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2jPUACgkQJNaLcl1U
h9Cg3Qf/ScTE8SCsHJLjKatjArehtbhKoUyG6aFABrEI/v3bjsqKt/Sq0WjEm255
nKAu6jVgldwyJP7JR+NQvS2KTy6/Ai/3r+U/lyG8X0xthT14nzXhC6QSAIfukqgq
JHderVdLXa+mc9bZ4vJ8AzG88ImFulrVA84t2cIuHOU27i4wVx5oQJZoRquB5JdJ
jAPleN81AYXwTdcJkckY0QoHEFVz55g/4xI2cuh9onlNHbt8eVr7FGsswsNnATrv
DlAATwOrW84BJnGHjaB0vfWLRx75q3bJ1z62kbdf0VqU5rYaVUppa5a+8eHY6i4V
A1ZTgD1YjmUvJjo2cbBpm7mJsYOinA==
=tj+B
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
