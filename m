Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB20C433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 11:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B758A22226
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 11:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbhARLUv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390164AbhARLUs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 06:20:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B890F221FF;
        Mon, 18 Jan 2021 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610968807;
        bh=E8QQY2aLftyITmKLMjzYemgVGG+nBpPUVZCtMkrxh70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyPbelTC+rVE0e/RrETG3NA/Cg2qYDaq9ddrxAUBpUPTYOMZfiT7CtSw86i+AAY2b
         SAlksssuAp41cepquQLKlHFa8NqHoTzD2CrfZpfv3yHVAwy2t/aksEQKOHe8Cib1Tu
         tJyqtCR3yATIeNW4Hkb6qZgeYl50CxwfLwQ45UQ//bYKpd/AIKPrf9A7aBlxdubZIi
         Tcdiev42g19kZI5rqNP3h9VeMY2jEU+yctGTXWFlSpZAk6siOHpJQ0RwElWkym24Gt
         UXXvIFPJUDzTmhqlGtonzE3KlyVtgOwEAvZpBWQmx0lXMBGI+yJAeA+YLQbsOAuXRk
         50QFQSMBCt45Q==
Date:   Mon, 18 Jan 2021 11:19:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Message-ID: <20210118111929.GA4455@sirena.org.uk>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk>
 <20210115185803.infufa4thlffagxk@bogus>
 <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 10:28:33AM +0000, Zulkifli, Muhammad Husaini wrote:

> >> There is a SCMI voltage domain protocol intended for just this use
> >> case of controlling regulators managed by the firmware, why are you
> >> not using that for these systems?  See drivers/firmware/arm_scmi/volta=
ge.c.

> From mmc maintainer's perspective, I should use the common modelling eith=
er using=20
> regulator framework or pinctrl to perform voltage operation. Not just dir=
ectly invoke=20
> smccc call in the mmc driver. That is why I came up with this regulator d=
river to perform=20
> voltage operation.=20

The above is a standard way of controlling regulators via SMCCC which
already has a regulator driver, you're duplicating this functionality.

> >Indeed. Please switch to using the new voltage protocol added for this w=
ithout
> >any extra code. You just need to wire up DT for this.

> May I know even if I wire up the DT, how should I call this from the mmc =
driver
> For set/get voltage operation? Any example?

There's one in the binding document for the driver.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFbrkACgkQJNaLcl1U
h9C0hAf+MTe7TY8tHxMsjksj2YMRZ39Ocrok7EGZgRzOkMp5uq8KLLqw2HxZAD2x
WjhHGgMwe5rtgH7R0YwRY7XdZaPQV+Pz6uKSHVjSFUv/WpcTnBna7AejBx9yf47S
dgKATC0kf+axN2P9tpC1sxECflrV0aOfo3uWGu4wVgpHQ5BDOWL6TuUoH9Z7QfR6
kiTSuFYJulD3OzfOqpQ9NLE/HQ38xX22OnDZ874S2l7tjofADlTNKynfszo0RQO0
WQrpFuaa/ZrrCarlvtzzNzJSpxUW7ew0I7h7f71tfWelGPB1nwzPQPEOD3/vrvww
YGcs2hozfssgLhhH5lioxj+mkoPzXQ==
=cOY2
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
