From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH 2/2] msm: 8x50: Add initial support for SDCC
Date: Tue, 18 Jan 2011 12:38:46 +0530
Message-ID: <4D353C7E.30201@codeaurora.org>
References: <1295329970-26814-1-git-send-email-stummala@codeaurora.org> <1295329970-26814-2-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1295329970-26814-2-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: davidb@codeaurora.org, dwalker@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, san@google.com
List-Id: linux-mmc@vger.kernel.org

Hi Sahitya,

On 1/18/2011 11:22 AM, Sahitya Tummala wrote:
> Signed-off-by: Sahitya Tummala<stummala@codeaurora.org>
> ---
>   arch/arm/mach-msm/board-qsd8x50.c               |   81 +++++++++-
>   arch/arm/mach-msm/devices-qsd8x50.c             |  196 +++++++++++++++++++++++
>   arch/arm/mach-msm/gpiomux-8x50.c                |   23 +++
>   arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |    8 +-
>   4 files changed, 303 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
> index 6dde818..29ef683 100644
> --- a/arch/arm/mach-msm/board-qsd8x50.c
> +++ b/arch/arm/mach-msm/board-qsd8x50.c
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
> +/* Copyright (c) 2009-2011, Code Aurora Forum. All rights reserved.

Why not 2008-2011?

>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 and
> @@ -21,6 +21,7 @@
>   #include<linux/platform_device.h>
>   #include<linux/delay.h>
>   #include<linux/usb/msm_hsusb.h>
> +#include<linux/err.h>
>
>   #include<asm/mach-types.h>
>   #include<asm/mach/arch.h>
> @@ -31,6 +32,8 @@
>   #include<mach/irqs.h>
>   #include<mach/sirc.h>
>   #include<mach/gpio.h>
> +#include<mach/vreg.h>
> +#include<mach/mmc.h>
>
>   #include "devices.h"
>
> @@ -95,6 +98,81 @@ static struct platform_device *devices[] __initdata = {
>   	&msm_device_hsusb_host,
>   };
>
> +static struct msm_mmc_gpio sdc1_gpio_cfg[] = {
> +	{51, "sdc1_dat_3"},
> +	{52, "sdc1_dat_2"},
> +	{53, "sdc1_dat_1"},
> +	{54, "sdc1_dat_0"},
> +	{55, "sdc1_cmd"},
> +	{56, "sdc1_clk"}
> +};
> +
> +static struct vreg *vreg_mmc;
> +static unsigned long vreg_sts;
> +
> +static uint32_t msm_sdcc_setup_power(struct device *dv, unsigned int vdd)
> +{
> +	int rc = 0;
> +	struct platform_device *pdev;
> +
> +	pdev = container_of(dv, struct platform_device, dev);
> +
> +	if (vdd == 0) {
> +		if (!vreg_sts)
> +			return 0;
> +
> +		clear_bit(pdev->id,&vreg_sts);
> +
> +		if (!vreg_sts) {
> +			rc = vreg_disable(vreg_mmc);
> +			if (rc)
> +				pr_err("vreg_mmc disable failed for slot "
> +						"%d: %d\n", pdev->id, rc);
> +		}
> +		return 0;
> +	}
> +
> +	if (!vreg_sts) {
> +		rc = vreg_set_level(vreg_mmc, 2900);
> +		if (rc)
> +			pr_err("vreg_mmc set level failed for slot %d: %d\n",
> +					pdev->id, rc);
> +		rc = vreg_enable(vreg_mmc);
> +		if (rc)
> +			pr_err("vreg_mmc enable failed for slot %d: %d\n",
> +					pdev->id, rc);
> +	}
> +	set_bit(pdev->id,&vreg_sts);

non-atomic version? __set_bit?

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
