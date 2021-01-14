Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC3C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E889023B5F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 16:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhANQt0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbhANQtZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 11:49:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BE423B18;
        Thu, 14 Jan 2021 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610642924;
        bh=mZr4R3ehu/swshPtE+4zaVh7GoE9qRWxUwRqeOUyYSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF6fckKXuekmtn6KlC00fhxapzqwNGdB5gwSDmuF6hJ9bi7c0bC/widRrjalI9mKi
         hmILfwxNaTVh6YBK89XJGe4qIxMqXjdTSn7wtjwnNMoSi6n33FecCDGzEvFTeHYvoP
         xCvn6ye6HUhprVilm38uro4VF7suP+9OPyxWxiiB36oNpcFgTO3Jclvli++cfsvKzi
         YxZnj/rD88rF3x9Ka+8WhT1j7vZhlZ/GCpiFzr+Tuw/VHmJdrJlWvFWTFK+MN5WgX0
         YHKBhMbwRAOVsMe1W5Ke1lJtxrG9Fz49UdtPXgRBdcjdd869vla+OoZ+9fDxL6fnVB
         yyeVZeAbvGzmg==
Date:   Thu, 14 Jan 2021 16:48:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     ulf.hansson@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Message-ID: <20210114164811.GG4854@sirena.org.uk>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 11:26:56PM +0800, Muhammad Husaini Zulkifli wrote:
> Export inline function to encapsulate AON_CFG1 for controling the I/O Rail
> supplied voltage levels which communicate with Trusted Firmware.

Adding Sudeep for the SMCCC bits, not deleting any context for his
benefit.

> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel=
=2Ecom>
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  include/linux/firmware/intel/keembay.h | 82 ++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 include/linux/firmware/intel/keembay.h
>=20
> diff --git a/include/linux/firmware/intel/keembay.h b/include/linux/firmw=
are/intel/keembay.h
> new file mode 100644
> index 000000000000..f5a8dbfdb63b
> --- /dev/null
> +++ b/include/linux/firmware/intel/keembay.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Intel Keembay SOC Firmware API Layer
> + *
> + *  Copyright (C) 2020, Intel Corporation
> + *
> + *  Author: Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.c=
om>
> + */
> +
> +#ifndef __FIRMWARE_KEEMBAY_SMC_H__
> +#define __FIRMWARE_KEEMBAY_SMC_H__
> +
> +#include <linux/arm-smccc.h>
> +
> +/*
> + * This file defines an API function that can be called by a device driv=
er in order to
> + * communicate with Trusted Firmware - A profile(TF-A) or Trusted Firmwa=
re - M profile (TF-M).
> + */
> +
> +#define KEEMBAY_SET_1V8_IO_RAIL	1
> +#define KEEMBAY_SET_3V3_IO_RAIL	0
> +
> +#define KEEMBAY_IOV_1_8V_uV	1800000
> +#define KEEMBAY_IOV_3_3V_uV	3300000
> +
> +#define KEEMBAY_SET_SD_VOLTAGE_ID 0xFF26
> +#define KEEMBAY_GET_SD_VOLTAGE_ID 0xFF2A
> +
> +#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> +			   ARM_SMCCC_SMC_32,		\
> +			   ARM_SMCCC_OWNER_SIP,		\
> +			   KEEMBAY_SET_SD_VOLTAGE_ID)
> +
> +#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> +			   ARM_SMCCC_SMC_32,		\
> +			   ARM_SMCCC_OWNER_SIP,		\
> +			   KEEMBAY_GET_SD_VOLTAGE_ID)
> +
> +#define KEEMBAY_REG_NUM_CONSUMERS 2
> +
> +struct keembay_reg_supply {
> +	struct regulator *consumer;
> +};
> +
> +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
> +/*
> + * Voltage applied on the IO Rail is controlled from the Always On Regis=
ter using specific
> + * bits in AON_CGF1 register. This is a secure register. Keem Bay SOC ca=
nnot exposed this
> + * register address to the outside world.
> + */
> +static inline int keembay_set_io_rail_supplied_voltage(int volt)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);

There is a SCMI voltage domain protocol intended for just this use case
of controlling regulators managed by the firmware, why are you not using
that for these systems?  See drivers/firmware/arm_scmi/voltage.c.

> +
> +	return res.a0;
> +}
> +
> +static inline int keembay_get_io_rail_supplied_voltage(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE, &res);
> +
> +	return res.a1;
> +}
> +#else
> +static inline int keembay_set_io_rail_supplied_voltage(int volt)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int keembay_get_io_rail_supplied_voltage(void)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
> --=20
> 2.17.1
>=20

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAAdcoACgkQJNaLcl1U
h9CerwgAhiPIFIqpjvEP9eFGGVSOXlw2+GQLMVzLRhS7iYZ5jDGj7dVYplWej/EL
Tq65lLb07E96iICUEsKo1nmfnfUgcV5bjQluyn20FIB2Pr6glP3+4fLrDWClim9l
P5AisADLrbjpcDDVPkBUK0hl6Y0UJO6GIlaN7HEwsU1OOU7uGGGucvuTzP/eM4r0
fxSKPI8OW3S2l8M5stQmdjz9GnH5kZoe0fQjlEsY05DSXNtvu89RsQTLhaEyXciE
UnRQz2Bl62+BR2oc19ZhXrwo7w23kEvKTiiFjkSX5hoo7zo8gC+gPsVkV602AWCd
D7kPeQY85lOWuefKm8KnrOTLCm58uQ==
=mnFr
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
