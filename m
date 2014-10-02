From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/9] unshare and simplify omap_hsmmc platform struct
Date: Thu, 2 Oct 2014 09:36:34 -0700
Message-ID: <20141002163633.GK3122@atomide.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18784 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaJBQg0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Oct 2014 12:36:26 -0400
Content-Disposition: inline
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com

* Andreas Fenkart <afenkart@gmail.com> [140929 02:33]:
> v2:
> - replace erroneous mmci by omap1/2
> - add description to all patches
> - full compile check with:
> 	CONFIG_MACH_OMAP3_BEAGLE=y
> 	CONFIG_MACH_DEVKIT8000=y
> 	CONFIG_MACH_OMAP_LDP=y
> 	CONFIG_MACH_OMAP3530_LV_SOM=y
> 	CONFIG_MACH_OMAP3_TORPEDO=y
> 	CONFIG_MACH_OVERO=y
> 	CONFIG_MACH_OMAP3517EVM=y
> 	CONFIG_MACH_CRANEBOARD=y
> 	CONFIG_MACH_OMAP3_PANDORA=y
> 	CONFIG_MACH_TOUCHBOOK=y
> 	CONFIG_MACH_OMAP_3430SDP=y
> 	CONFIG_MACH_NOKIA_RX51=y
> 	CONFIG_MACH_CM_T35=y
> 	CONFIG_MACH_CM_T3517=y
> 	CONFIG_MACH_CM_T3730=y
> 	CONFIG_MACH_SBC3530=y
> - reorganized and added more patches, hence no blank ack added
> 
> 
> Andreas Fenkart (9):
>   omap_hsmmc: use separate platform data for ompa3 and omap 1/2 driver
>   omap_hsmmc: remove unused fields in platform_data
>   omap_hsmmc: remove un-initialized callbacks from platform data
>   omap_hsmmc: remove un-ready power_saving field in omap2_hsmmc_info
>   omap_hsmmc: remove unused get_context_loss_count callback
>   omap_hsmmc: remove unnecessary omap_hsmmc_slot_data indirection
>   omap_hsmmc: pass mmc_priv struct to gpio init / free
>   omap_hsmmc: Remove unnecessary callbacks from platform data
>   omap_hsmmc: remove unused slot_id parameter
> 
>  arch/arm/mach-omap2/board-rx51-peripherals.c       |   4 +-
>  arch/arm/mach-omap2/hsmmc.c                        | 155 +++++------
>  arch/arm/mach-omap2/hsmmc.h                        |   9 +-
>  arch/arm/mach-omap2/mmc.h                          |   6 +-
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 +-
>  drivers/mmc/host/omap_hsmmc.c                      | 282 ++++++++++-----------
>  include/linux/platform_data/hsmmc-omap.h           |  88 +++++++
>  8 files changed, 299 insertions(+), 257 deletions(-)
>  create mode 100644 include/linux/platform_data/hsmmc-omap.h

Looks good to me, please feel free to merge via the MMC
tree as this should not conflict with omap changes. For the
whole series:

Acked-by: Tony Lindgren <tony@atomide.com>
