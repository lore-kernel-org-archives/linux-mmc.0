Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D58C63699
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE58D2227F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvMUPFfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58D2227F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKPNdb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgKPNdb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 08:33:31 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9B522240;
        Mon, 16 Nov 2020 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605533610;
        bh=AfprN1MLPuZxPJwWwhQ10Y05soQ+6PcoI/dzBev3uK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvMUPFfEnYP+7X+I3jS+BXXvuFdvsu7NObQM9gv3lyhncPwBvdgPZlymPe5fe5a3m
         2KnG9/v/PHJePREmnrtVnbtuyG+VQu8l3LuvhED4Ys4T/ruz+EAGsYatEYG75BgSL0
         lfVz49hRDbF2lTeo3XY3s53AU53yvuriDvJOgIOY=
Date:   Mon, 16 Nov 2020 13:33:11 +0000
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
Message-ID: <20201116133311.GB4739@sirena.org.uk>
References: <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
 <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
 <20201113161550.GC4828@sirena.org.uk>
 <3beaa12b-4a50-a3b6-fc43-ebb5ce7a8db7@gmail.com>
 <20201113172859.GF4828@sirena.org.uk>
 <74cfc6a9-3f59-d679-14b7-51102a6f11b3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <74cfc6a9-3f59-d679-14b7-51102a6f11b3@gmail.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2020 at 08:42:10PM +0300, Dmitry Osipenko wrote:
> 13.11.2020 20:28, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> >> What should we do?

> > As I keep saying the consumer driver should be enumerating the voltages
> > it can set, if it can't find any and wants to continue then it can just
> > skip setting voltages later on.  If only some are unavailable then it
> > probably wants to eliminate those specific OPPs instead.

> I'm seeing a dummy regulator as a helper for consumer drivers which
> removes burden of handling an absent (optional) regulator. Is this a
> correct understanding of a dummy regulator?

> Older DTBs don't have a regulator and we want to keep them working. This
> is equal to a physically absent regulator and in this case it's an
> optional regulator, IMO.

No, you are failing to understand the purpose of this code.  To
reiterate unless the device supports operating with the supply
physically absent then the driver should not be attempting to use
regulator_get_optional().  That exists specifically for the case where
the supply may be absent, nothing else.  The dummy regulator is there
precisely for the case where the system does not describe supplies that
we know are required for the device to function, it fixes up that
omission so we don't need to open code handling of this in every single
consumer driver.

Regulators that are present but not described by the firmware are a
clearly different case to regulators that are not physically there,
hardware with actually optional regulators will generally require some
configuration for this case.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+yf5YACgkQJNaLcl1U
h9AVMQf+IoDe7CVrA+pGhJ28AkcYg8sn+fM3Rc1IOht/iu21+rnclIoozR+TXdQS
Jm4mLzjjC4nogj7AsCKZhCKkWguwmpqIJMNSgmWoVJ74EOVlelev8tfIq9Ih2wNS
OfwLqZWOpetdcf2LYiCCMhJtAsfS0c8vaqXWKQyTFc1I12BSuWZD+CPPtw8c3h97
grOgbw1i3OIO5veJ0o6Ia96tJGNokju2054eJsAP0I+H5KXg4emm7um4AzSDmNh+
ewuLlkg4vtgEtT07Vf59X4CD3TEiHzZJpg6ADEaZmbDRYkPeogIw1W7R1lPJ/ahg
9kpqISDUQWH2TtJJXqZWteiMDzVYsQ==
=DOOy
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
