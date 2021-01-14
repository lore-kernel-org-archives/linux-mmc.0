Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787BFC433E9
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3F23B31
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 17:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbhANRPt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:15:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbhANRPs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 12:15:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D6123A52;
        Thu, 14 Jan 2021 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644507;
        bh=z7hkXnrOP+wdoKAOpVuktCD+Lqo0Rxh/iodjSrIZzbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZy7hLSB81pIj9mKxxRzhc+wwdn5BHyP2EYC9SdtRJZbj7oyA+GHXU8KwqAnq/00y
         ciTa6Rauf8t+NIKkni1TErjQg941Me0sq9knDwjQaljVZtDsEcBI5QMeqnE+DTWFVt
         uDWAC3CvldBTdTGUUMqDFvPBF63o0JuA5YH2Z6GLlBdq7f0y4ae3mSeYEfjz8Re9Tj
         2khaMHBxVPNabodymYPD/lAXnFiX1aZ7IoZrgvVf29tBlkSMUn+FyvcEwjgfgqJhh8
         4SBVSfd9lop8XgKnwMPEb+H3jWbdn2IjjCZI+giQ/UYoYUDBF7TyQDmpHY/b6rHPG/
         uerbnsJu3b5GA==
Date:   Thu, 14 Jan 2021 17:14:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     ulf.hansson@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 8/9] regulator: keembay: Add regulator for Keem Bay SoC
Message-ID: <20210114171434.GI4854@sirena.org.uk>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-9-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <20210114152700.21916-9-muhammad.husaini.zulkifli@intel.com>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2021 at 11:26:59PM +0800, Muhammad Husaini Zulkifli wrote:

> Keem Bay SD regulator driver module is added to encapsulate ARM
> Secure Monitor Call Calling Convention (SMCCC) during set voltage
> operations to control I/O Rail supplied voltage levels which communicate
> with Trusted Firmware.

Adding in Sudeep again for the SMCCC bits.  I just checked and am I
right in thinking this might already be shipping in production?

> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay SD Regulator
> + *
> + * Copyright (C) 2020, Intel Corporation
> + * Author: Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
> + */

Please make the entire comment a C++ comment to improve legibility.

> +static int keembay_regulator_set_voltage(struct regulator_dev *dev,
> +					int min_uV, int max_uV,
> +					unsigned *selector)
> +{
> +	int tmp_volt;
> +
> +	if (min_uV == KEEMBAY_IOV_1_8V_uV && max_uV == KEEMBAY_IOV_1_8V_uV)
> +		tmp_volt = KEEMBAY_SET_1V8_IO_RAIL;
> +	else
> +		tmp_volt = KEEMBAY_SET_3V3_IO_RAIL;
> +
> +	return keembay_set_io_rail_supplied_voltage(tmp_volt);
> +}

This has serious problems with input validation and is broken for most
valid input.  A set_voltage() function should set the voltage to the
lowest valid voltage within the range specified in the arguments and
return an error if it is not possible to set a voltage within the range
specified by the arguments.  This function will set 3.3V for any input
range other than exactly 1.8V so for example if the caller validly sets
a range of 1.7V-1.9V then 3.3V will be selected instead of 1.8V, or if
the user sets 1.0-1.1V then it will set 3.3V instead of returning an
error.

> +static int keembay_regulator_get_voltage(struct regulator_dev *dev)
> +{
> +	int ret;
> +
> +	ret = keembay_get_io_rail_supplied_voltage();
> +
> +	return ret ? KEEMBAY_IOV_1_8V_uV : KEEMBAY_IOV_3_3V_uV;
> +}

This ignores any errors or out of bounds values returned by the called
function, and please write normal conditional statements rather than
using the ternery operator to improve legibility.

> +/*
> + * Using subsys_initcall to ensure that Keem Bay regulator platform driver
> + * is initialized before device driver try to utilize it.
> + */
> +subsys_initcall(keembay_regulator_init);

There is no need to do this, probe deferral will ensure that
dependencies will be resolved.

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAe/kACgkQJNaLcl1U
h9Do4Af/RWczu73+RbTFDo9aNENM8BeoKxbtXH9eMaV1Ld1loIafX0ASjSYsJzW8
npIlmVMhfa0rdR3443Nd2AcCP8bu8y5QIkryte5XEac3nHy+BoLcxJLa8iUIdHqS
9REvzq4D7mwHyXQtangWa9gKnkJKZitOrOOxddj31DTQe4P1BZrje4qXcgfxKTsS
AB0EhRznmGJQxnssc+ANWs94IF7ixAKKPWBwhfrifKP4Z0GbMR5SjMbTGTEVsiMD
35k0h/EcBhl8/9mnHgO3Z8h7VpQ8hf4yIAFJwZNjEv1z52flc+v2o6HABWMts4VT
fNi1mU1wb/64EwoyDST2H6Ttk9cQQw==
=9PuY
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
