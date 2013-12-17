From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3]: Support cpu frequency scaling and power management
 for iMX6SL
Date: Tue, 17 Dec 2013 22:15:40 +0800
Message-ID: <20131217141537.GW6691@S2101-09.ap.freescale.net>
References: <CACUGKYOKEk9RUVS52gGc=CUNFYm1q+zT6rURnB4hwPkC0GCC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:30240
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058Ab3LQOOi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:14:38 -0500
Content-Disposition: inline
In-Reply-To: <CACUGKYOKEk9RUVS52gGc=CUNFYm1q+zT6rURnB4hwPkC0GCC1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

On Mon, Dec 16, 2013 at 05:40:20PM -0800, John Tobias wrote:
> Enable cpu frequency on imx6 config
> 
> From: John Tobias <john.tobias.ph@gmail.com>
> 
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index 8d0c5a0..a56cb2c 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -43,6 +43,17 @@ CONFIG_PREEMPT_VOLUNTARY=y
>  CONFIG_AEABI=y
>  # CONFIG_OABI_COMPAT is not set
>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_GOV_COMMON=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y

We probably want to set ONDEMAND as the default one.

> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_GENERIC_CPUFREQ_CPU0=y

We do not need this one.

Shawn

> +CONFIG_ARM_IMX6Q_CPUFREQ=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
>  CONFIG_BINFMT_MISC=m

