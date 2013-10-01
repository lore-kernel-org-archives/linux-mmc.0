From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in system
 manager
Date: Tue, 1 Oct 2013 14:33:18 -0500
Message-ID: <1380655998.13502.8.camel@linux-builds1>
References: <1379975760-18084-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379975760-18084-1-git-send-email-dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Just wondering if I can get any comments on this patchset?

Thanks,
Dinh

On Mon, 2013-09-23 at 17:35 -0500, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
> 
> Add functionality in the System Manager to set the SDR settings for the
> SD/MMC IP.
> 
> Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
> Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
> CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> CC: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
> Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> 
> ---
> v2:
> - Have socfpga_sysmgr_set_dwmmc_drvsel_smpsel() take in the SDR settings
> directly so that it does not have to walk the DTB.
> ---
>  arch/arm/mach-socfpga/Makefile     |    2 +-
>  arch/arm/mach-socfpga/core.h       |    6 ++++++
>  arch/arm/mach-socfpga/system_mgr.c |   28 ++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-socfpga/system_mgr.c
> 
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index 6dd7a93..e4ff8b9 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -2,5 +2,5 @@
>  # Makefile for the linux kernel.
>  #
>  
> -obj-y					:= socfpga.o
> +obj-y					:= socfpga.o system_mgr.o
>  obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index 572b8f7..b05fa6a 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -44,4 +44,10 @@ extern unsigned long cpu1start_addr;
>  
>  #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
>  
> +/* SDMMC Group for System Manager defines */
> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET             0x108
> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK    0x7
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
> +	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
> +
>  #endif
> diff --git a/arch/arm/mach-socfpga/system_mgr.c b/arch/arm/mach-socfpga/system_mgr.c
> new file mode 100644
> index 0000000..9fdce1d
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/system_mgr.c
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright Altera Corporation (C) 2013. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/of_platform.h>
> +#include <asm/mach/map.h>
> +
> +#include "core.h"
> +
> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
> +{
> +	u32 hs_timing;
> +
> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> +}
> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
