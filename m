Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEAEC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 16:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A35623B1C
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhANQxl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbhANQxk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 11:53:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C0A523B1C;
        Thu, 14 Jan 2021 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610643180;
        bh=uuZYyJaIsef/Z9OY1xIrjyxjS3YbtqISQ1GMLl+gci4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHbmFJVPX4rvsbgmi6AW5c8sSHG/lArgLL8rhAjfuQuaxYkEveF4w3heuEsDLTcqH
         IGGoz9tB/Xn+VEjP7725ryZZOKvrVrVeoAfC2T0Ps2kiivHKGj2eG+S0V/dBhpnVAn
         9qIkVv5NNH05qtrXHF+DeDPoeOyCXYIkzxUyzUIAdHoNeOgRFIygWX8zdXgkZ7A2On
         8tcUT4kRlqFTVSl57CvV+KnJhOYhbrmBmiW5wQdSlntVbOYqPXtyoL4Q+g3mo5OGQM
         yFwkBi0E+EKwAwiWZpGROKDrtSP2NHgupvMocrCXvPEek5LKcIdqK1KiZ9VSi/2V5Y
         XOFYf6GZFr0Pg==
Date:   Thu, 14 Jan 2021 16:52:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     ulf.hansson@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com
Subject: Re: [PATCH v1 7/9] dt-bindings: regulator: keembay: Add DT binding
 documentation
Message-ID: <20210114165226.GH4854@sirena.org.uk>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-8-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <20210114152700.21916-8-muhammad.husaini.zulkifli@intel.com>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2021 at 11:26:58PM +0800, Muhammad Husaini Zulkifli wrote:
> Add DT Binding Documentation for Keem Bay SD Regulator.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +properties:
> +  compatible:
> +    const: regulator-keembay-sd

Device tree compatible strings should be in the format vendor,device.

> +required:
> +  - compatible
> +  - regulator-name

Why is regulator-name required here?  This is a standard regulator
binding property which is covered by the generic regulator bindings and
should be optional since it is for use by the system integrator to
provide more user friendly diagnostic information about which supply
this is in the system.  If you are attempting to use this for device
identification then you should be using different compatible strings for
the different regulators - even if you were using regulator-name you'd
need to document the values.

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAdskACgkQJNaLcl1U
h9AMyQf/VgGgzfftUWU23N84Ve6bSZ9At7jEd5Vl/ndNDPbslLtifKeUapcq4Ole
3T0jspGiWG/PXU8sxvLXitZZHZUoZuAgVXSzMjbD8icc4IaL2Gnmi2LJS7vwbSOU
unTsZ7ax4Gwx1snI9kkqQL8wzEsGYw2qNtd1FhKOHSw6mLJpsChnvWDNi6PWRGBc
v1eKy8PcwmnLArlvKFSxe2g2zWwO3CdqLHQL4YROFK4HZ4BxQPxaLRx09nRKPdNy
bw99ZXytcPjKzZSuOq1yzMJA5z2UJl10rT82kw4BeHcwHLzOeHriHu00ldv7B/QQ
btFSO7Prp04F7LkG634QHr9T/LFgxA==
=Q+TQ
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
