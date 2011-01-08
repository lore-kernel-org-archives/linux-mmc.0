From: Philip Rakity <prakity@marvell.com>
Subject: Fwd: [PATCH] mach-mmp: Fix Kconfig to allow correct PXA Selections
Date: Sat, 8 Jan 2011 08:45:15 -0800
Message-ID: <82004822-1E65-41BA-B6D2-875D634AAE90@marvell.com>
References: <4B37A311-C664-4C7B-A8F0-0B24A3E3F3B8@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34014 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751371Ab1AHQqt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Jan 2011 11:46:49 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <markb@marvell.com>


Forwarding to mmc-list for completeness.  Already post to linux-arm-kernel.

Begin forwarded message:

> From: Philip Rakity <prakity@marvell.com>
> Date: January 7, 2011 9:28:04 PM PST
> To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Mark Brown <markb@marvell.com>, Arnd Bergmann <arnd@arndb.de>
> Subject: [PATCH] mach-mmp: Fix Kconfig to allow correct PXA Selections 
> 
> 
> The following items are fixed:
> 
> a) inconsistent behavior when board is selected and if
> menu item is reselected board has disappeard
> 
> b) Ability to select options that will not build
> 	MMP2 and say PXA168
> 
> The behavior maps what is done by the mach-omap
> (thanks to Anrd Bergmann for his help and suggestions)
> 
> Mach-MMP is (as now) the sytem type.  Once selected
> the user can then select the SoC on the board and
> only the boards that support that SoC are shown.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> arch/arm/mach-mmp/Kconfig |   96 ++++++++++++++++++++++-----------------------
> 1 files changed, 47 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 67793a6..4739d27 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -1,99 +1,97 @@
> if ARCH_MMP
> 
> -menu "Marvell PXA168/910/MMP2 Implmentations"
> +menu "Marvell PXA168/PXA910/MMP2 Specific Features"
> +
> +choice
> +	prompt "SoC (System on Chip)"
> +	help
> +	  Type of System on Chip (SoC) used
> +
> +config CPU_PXA168
> +	bool "PXA168 Based System"
> +	select CPU_MOHAWK
> +	help
> +	  Say 'Y' here if System has a Marvell PXA168 SoC
> +
> +config CPU_PXA910
> +	bool "PXA910 Based System"
> +	select CPU_MOHAWK
> +	help
> +	  Say 'Y' here if System has a Marvell PXA910 SoC
> +
> +config CPU_MMP2
> +	bool "MMP2 Based System"
> +	select CPU_PJ4
> +	help
> +	  Say 'Y' here if System has a Marvell MMP2 SoC
> +
> +endchoice
> +
> +comment "Development Board"
> 
> config MACH_ASPENITE
> 	bool "Marvell's PXA168 Aspenite Development Board"
> -	select CPU_PXA168
> +	depends on CPU_PXA168
> 	help
> 	  Say 'Y' here if you want to support the Marvell PXA168-based
> 	  Aspenite Development Board.
> 
> config MACH_ZYLONITE2
> 	bool "Marvell's PXA168 Zylonite2 Development Board"
> -	select CPU_PXA168
> +	depends on CPU_PXA168
> 	help
> 	  Say 'Y' here if you want to support the Marvell PXA168-based
> 	  Zylonite2 Development Board.
> 
> config MACH_AVENGERS_LITE
> 	bool "Marvell's PXA168 Avengers Lite Development Board"
> -	select CPU_PXA168
> +	depends on CPU_PXA168
> 	help
> 	  Say 'Y' here if you want to support the Marvell PXA168-based
> 	  Avengers Lite Development Board.
> 
> +config MACH_TETON_BGA
> +	bool "Marvell's PXA168 Teton BGA Development Board"
> +	depends on CPU_PXA168
> +	help
> +	  Say 'Y' here if you want to support the Marvell PXA168-based
> +	  Teton BGA Development Board.
> +
> config MACH_TAVOREVB
> 	bool "Marvell's PXA910 TavorEVB Development Board"
> -	select CPU_PXA910
> +	depends on CPU_PXA910
> 	help
> 	  Say 'Y' here if you want to support the Marvell PXA910-based
> 	  TavorEVB Development Board.
> 
> config MACH_TTC_DKB
> -	bool "Marvell's PXA910 TavorEVB Development Board"
> -	select CPU_PXA910
> +	bool "Marvell's PXA910 TTC DKB Development Board"
> +	depends on CPU_PXA910
> 	help
> 	  Say 'Y' here if you want to support the Marvell PXA910-based
> 	  TTC_DKB Development Board.
> 
> config MACH_BROWNSTONE
> 	bool "Marvell's Brownstone Development Platform"
> -	depends on !CPU_MOHAWK
> -	select CPU_MMP2
> +	depends on CPU_MMP2
> 	help
> 	  Say 'Y' here if you want to support the Marvell MMP2-based
> -	  Brown Development Platform.
> -	  MMP2-based board can't be co-existed with PXA168-based &
> -	  PXA910-based development board. Since MMP2 is compatible to
> -	  ARMv7 architecture.
> +	  Brownstone Development Board.
> 
> config MACH_FLINT
> 	bool "Marvell's Flint Development Platform"
> -	depends on !CPU_MOHAWK
> -	select CPU_MMP2
> +	depends on CPU_MMP2
> 	help
> 	  Say 'Y' here if you want to support the Marvell MMP2-based
> -	  Flint Development Platform.
> -	  MMP2-based board can't be co-existed with PXA168-based &
> -	  PXA910-based development board. Since MMP2 is compatible to
> -	  ARMv7 architecture.
> +	  Flint Development Board.
> 
> config MACH_MARVELL_JASPER
> 	bool "Marvell's Jasper Development Platform"
> -	depends on !CPU_MOHAWK
> -	select CPU_MMP2
> +	depends on CPU_MMP2
> 	help
> 	  Say 'Y' here if you want to support the Marvell MMP2-base
> -	  Jasper Development Platform.
> -	  MMP2-based board can't be co-existed with PXA168-based &
> -	  PXA910-based development board. Since MMP2 is compatible to
> -	  ARMv7 architecture.
> -
> -config MACH_TETON_BGA
> -	bool "Marvell's PXA168 Teton BGA Development Board"
> -	select CPU_PXA168
> -	help
> -	  Say 'Y' here if you want to support the Marvell PXA168-based
> -	  Teton BGA Development Board.
> +	  Jasper Development Board.
> 
> endmenu
> 
> -config CPU_PXA168
> -	bool
> -	select CPU_MOHAWK
> -	help
> -	  Select code specific to PXA168
> -
> -config CPU_PXA910
> -	bool
> -	select CPU_MOHAWK
> -	help
> -	  Select code specific to PXA910
> -
> -config CPU_MMP2
> -	bool
> -	select CPU_PJ4
> -	help
> -	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
> endif
> -- 
> 1.7.0.4
> 
> 

