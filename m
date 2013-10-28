From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
Date: Mon, 28 Oct 2013 13:38:09 -0700
Message-ID: <CAOesGMi59voTKvu1zA5zpv4xDiF_2OQFMOjtx2wg4S7W=MhY3g@mail.gmail.com>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
	<1379956836-5866-2-git-send-email-bcm@fixthebug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:62899 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab3J1UiL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 16:38:11 -0400
Received: by mail-qc0-f172.google.com with SMTP id c9so4204369qcz.17
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2013 13:38:10 -0700 (PDT)
In-Reply-To: <1379956836-5866-2-git-send-email-bcm@fixthebug.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Daudt <bcm@fixthebug.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Domenico Andreoli <cavokz@gmail.com>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, Matt Porter <matt.porter@linaro.org>, Alex Elder <alex.elder@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Replying here but since this is a part of your pull request. There's
still time to get this in since it's a fairly small self-contained
change, so let's try to get it right from the get-go. See comments
below.

On Mon, Sep 23, 2013 at 10:20 AM, Christian Daudt <bcm@fixthebug.org> wrote:
> Currently ARCH_BCM has been used for Broadcom
> Mobile V7 based SoCs. In order to allow other Broadcom
> SoCs to also use mach-bcm directory and files, this patch
> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
> uses ARCH_BCM to define any Broadcom chip residing
> in mach-bcm directory.
>
> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Changes from v1:
>  - fix alpha ordering in dts/Makefile
>  - break into 4 patches for separate subsys
>
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 6e49310..efb0132 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -27,6 +27,7 @@ CONFIG_MODULE_UNLOAD=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_EFI_PARTITION=y
>  CONFIG_ARCH_BCM=y
> +CONFIG_ARCH_BCM_MOBILE=y
>  CONFIG_ARM_THUMBEE=y
>  CONFIG_ARM_ERRATA_743622=y
>  CONFIG_PREEMPT=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 6e572c6..89a5064 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_ARCH_BCM=y
> +CONFIG_ARCH_BCM_MOBILE=y
>  CONFIG_GPIO_PCA953X=y
>  CONFIG_ARCH_HIGHBANK=y
>  CONFIG_ARCH_KEYSTONE=y
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 69d67f7..af86cda 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -1,5 +1,17 @@
>  config ARCH_BCM
> -       bool "Broadcom SoC" if ARCH_MULTI_V7
> +       bool "Broadcom SoC Support"
> +       select ARCH_MULTIPLATFORM

This should be the other way around -- all other platforms seem to
depend on ARCH_MULTIPLATFORM instead of selecting it.

> +       help
> +         This enables support for Broadcom ARM based SoC
> +          chips
> +
> +if ARCH_BCM
> +
> +menu "Broadcom SoC Selection"
> +
> +config ARCH_BCM_MOBILE
> +       bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
> +       default y

This shouldn't be default y, since it makes it less obvious in configs
such as multi_v7_defconfig that the platform is enabled.

Also, since you have default y here, the addition of
CONFIG_ARCH_BCM_MOBILE=y in the defconfigs doesn't actually look
accurate, they would fall out. As a matter of fact, the patch after
this in your branch you requested us to merge removes them again. :)

>         depends on MMU
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_ERRATA_754322
> @@ -14,7 +26,11 @@ config ARCH_BCM
>         select TICK_ONESHOT
>         select CACHE_L2X0
>         help
> -         This enables support for system based on Broadcom SoCs.
> +         This enables support for systems based on Broadcom mobile SoCs.
>           It currently supports the 'BCM281XX' family, which includes
>           BCM11130, BCM11140, BCM11351, BCM28145 and
>           BCM28155 variants.
> +
> +endmenu
> +
> +endif


-Olof
