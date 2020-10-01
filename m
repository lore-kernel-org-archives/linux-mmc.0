Return-Path: <SRS0=Kjhy=DI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962AC4741F
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386122074B
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgJAPfg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:35:36 -0400
Received: from foss.arm.com ([217.140.110.172]:37880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbgJAPfc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Oct 2020 11:35:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B187D6E;
        Thu,  1 Oct 2020 08:35:31 -0700 (PDT)
Received: from bogus (unknown [10.57.52.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B14B3F70D;
        Thu,  1 Oct 2020 08:35:29 -0700 (PDT)
Date:   Thu, 1 Oct 2020 16:35:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     muhammad.husaini.zulkifli@intel.com
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201001153526.GD906@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 01, 2020 at 10:21:48PM +0800, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Add generic firmware driver for Keem Bay SOC to support
> Arm Trusted Firmware Services call.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>  drivers/firmware/Kconfig                   |   1 +
>  drivers/firmware/Makefile                  |   1 +
>  drivers/firmware/intel/Kconfig             |  14 +++
>  drivers/firmware/intel/Makefile            |   4 +
>  drivers/firmware/intel/keembay_smc.c       | 119 +++++++++++++++++++++
>  include/linux/firmware/intel/keembay_smc.h |  27 +++++
>  6 files changed, 166 insertions(+)
>  create mode 100644 drivers/firmware/intel/Kconfig
>  create mode 100644 drivers/firmware/intel/Makefile
>  create mode 100644 drivers/firmware/intel/keembay_smc.c
>  create mode 100644 include/linux/firmware/intel/keembay_smc.h
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index fbd785dd0513..41de77d2720e 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -305,5 +305,6 @@ source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/smccc/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
>  source "drivers/firmware/xilinx/Kconfig"
> +source "drivers/firmware/intel/Kconfig"
>  
>  endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 99510be9f5ed..00f295ab9860 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -33,3 +33,4 @@ obj-y				+= psci/
>  obj-y				+= smccc/
>  obj-y				+= tegra/
>  obj-y				+= xilinx/
> +obj-y				+= intel/
> diff --git a/drivers/firmware/intel/Kconfig b/drivers/firmware/intel/Kconfig
> new file mode 100644
> index 000000000000..b2b7a4e5410b
> --- /dev/null
> +++ b/drivers/firmware/intel/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Intel Firmware Drivers"
> +
> +config KEEMBAY_FIRMWARE
> +	bool "Enable Keem Bay firmware interface support"
> +	depends on HAVE_ARM_SMCCC

What is the version of SMCCC implemented ?
If SMCCC v1.1+, use HAVE_ARM_SMCCC_DISCOVERY

> +	default n
> +	help
> +	  Firmware interface driver is used by device drivers
> +	  to communicate with the arm-trusted-firmware
> +	  for platform management services.
> +	  If in doubt, say "N".
> +
> +endmenu
> diff --git a/drivers/firmware/intel/Makefile b/drivers/firmware/intel/Makefile
> new file mode 100644
> index 000000000000..e6d2e1ea69a7
> --- /dev/null
> +++ b/drivers/firmware/intel/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for Intel firmwares
> +
> +obj-$(CONFIG_KEEMBAY_FIRMWARE) = keembay_smc.o
> diff --git a/drivers/firmware/intel/keembay_smc.c b/drivers/firmware/intel/keembay_smc.c
> new file mode 100644
> index 000000000000..24013cd1f5da
> --- /dev/null
> +++ b/drivers/firmware/intel/keembay_smc.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2020-2021, Intel Corporation
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/firmware/intel/keembay_smc.h>
> +
> +static noinline int do_fw_call_fail(u64 arg0, u64 arg1)
> +{
> +	return -ENODEV;
> +}
> +
> +/**
> + * Simple wrapper functions to be able to use a function pointer
> + * Invoke do_fw_call_smc or others in future, depending on the configuration
> + */
> +static int (*do_fw_call)(u64, u64) = do_fw_call_fail;
> +
> +/**
> + * do_fw_call_smc() - Call system-level platform management layer (SMC)
> + * @arg0:		Argument 0 to SMC call
> + * @arg1:		Argument 1 to SMC call
> + *
> + * Invoke platform management function via SMC call.
> + *
> + * Return: Returns status, either success or error
> + */
> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(arg0, arg1, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +/**
> + * keembay_sd_voltage_selection() - Set the IO Pad voltage
> + * @volt: voltage selection either 1.8V or 3.3V
> + *
> + * This function is used to set the IO Line Voltage
> + *
> + * Return: 0 for success, Invalid for failure
> + */
> +int keembay_sd_voltage_selection(int volt)
> +{
> +	return do_fw_call(KEEMBAY_SIP_FUNC_ID, volt);


What are the other uses of this KEEMBAY_SIP_* ?
For now I tend to move this to the driver making use of it using
arm_smccc_1_1_invoke directly if possible. I don't see the need for this
to be separate driver. But do let us know the features implemented in the
firmware. If it is not v1.1+, reasons for not upgrading as you need v1.1
for some CPU errata implementation.

-- 
Regards,
Sudeep
