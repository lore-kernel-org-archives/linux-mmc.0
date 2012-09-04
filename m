From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tegra: move platform data header
Date: Tue, 04 Sep 2012 18:52:00 -0400
Message-ID: <87zk55flkf.fsf@octavius.laptop.org>
References: <1346798565-28884-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34415 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757926Ab2IDWwL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Sep 2012 18:52:11 -0400
In-Reply-To: <1346798565-28884-1-git-send-email-swarren@wwwdotorg.org>
	(Stephen Warren's message of "Tue, 4 Sep 2012 16:42:45 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

Hi Stephen,

On Tue, Sep 04 2012, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Move the Tegra SDHCI platform data header out of arch/arm/mach-tegra, as
> a pre-requisite of single zImage.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c                     |    3 +--
>  .../sdhci.h => include/linux/mmc/tegra_sdhci.h     |    2 --
>  2 files changed, 1 insertions(+), 4 deletions(-)
>  rename arch/arm/mach-tegra/include/mach/sdhci.h => include/linux/mmc/tegra_sdhci.h (93%)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f98ece6..73c5d1f 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -24,11 +24,10 @@
>  #include <linux/gpio.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/tegra_sdhci.h>
>  
>  #include <asm/gpio.h>
>  
> -#include <mach/sdhci.h>
> -
>  #include "sdhci-pltfm.h"
>  
>  /* Tegra SDHOST controller vendor register definitions */
> diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/include/linux/mmc/tegra_sdhci.h
> similarity index 93%
> rename from arch/arm/mach-tegra/include/mach/sdhci.h
> rename to include/linux/mmc/tegra_sdhci.h
> index 4231bc7..70aa1a7 100644
> --- a/arch/arm/mach-tegra/include/mach/sdhci.h
> +++ b/include/linux/mmc/tegra_sdhci.h
> @@ -1,6 +1,4 @@
>  /*
> - * include/asm-arm/arch-tegra/include/mach/sdhci.h
> - *
>   * Copyright (C) 2009 Palm, Inc.
>   * Author: Yvonne Yip <y@palm.com>
>   *

You should change the outer ifdef too:

diff --git a/include/linux/mmc/tegra_sdhci.h b/include/linux/mmc/tegra_sdhci.h
index 70aa1a7..2b31080 100644
--- a/include/linux/mmc/tegra_sdhci.h
+++ b/include/linux/mmc/tegra_sdhci.h
@@ -12,8 +12,8 @@
  * GNU General Public License for more details.
  *
  */
-#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
-#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
+#ifndef LINUX_MMC_TEGRA_SDHCI_H
+#define LINUX_MMC_TEGRA_SDHCI_H
 
 #include <linux/mmc/host.h>
 

After that:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
