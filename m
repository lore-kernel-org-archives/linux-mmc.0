From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 0/4] Consolidate sdhci pltfm & OF drivers and get them
 self registered
Date: Fri, 27 May 2011 01:26:47 -0600
Message-ID: <20110527072647.GE31953@ponder.secretlab.ca>
References: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33556 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab1E0H0t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 03:26:49 -0400
Received: by pwi15 with SMTP id 15so684122pwi.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 May 2011 00:26:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <cbouatmailru@gmail.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Wed, May 25, 2011 at 07:01:50PM +0800, Shawn Guo wrote:
> Here are what the patch set does.
> 
> * Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
>   a pure common helper function providers.
> * Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx,
>   sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
>   registered with calling helper functions created above.
> * Migrate the use of sdhci_of_host and sdhci_of_data to
>   sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host and
>   data structure works can be saved, and pltfm version works for both
>   cases.
> * Add OF common helper stuff into sdhci-pltfm.c, and make OF version
>   sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
>   registered as well, so that sdhci-of-core.c and sdhci-of.h can be
>   removed.
> * Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
>   drivers/mmc/host/sdhci-pltfm.h.
> 
> And the benefits we gain from the changes are:
> 
> * Get the sdhci device driver follow the Linux trend that driver
>   makes the registration by its own.
> * sdhci-pltfm.c becomes simple and clean as it only has common helper
>   stuff there now.
> * All sdhci device specific things are going back its own driver.
> * The dt and non-dt drivers are consolidated to use the same pair of
>   .probe and .remove hooks.

Hey Chris,

Any chance we can get this series into $NEXT_KERNEL?

Thanks,
g.

> 
> Changes since v2:
> * Drop imx mpc esdhc consolidation
> * Fix checkpatch errors
> * Add sdhci-of-core.c copyright into sdhci-pltfm.c
> 
> Changes since v1:
> * Rebase on cjb's mmc-next tree
> * Introduce helper function pair sdhci_pltfm_register and
>   sdhci_pltfm_unregister
> * Eliminate variable 'scratch' in .remove hook to make the code
>   look simple
> * Return ERR_PTR in sdhci_pltfm_init and use IS_ERR/PTR_ERR to check
>   return value in .probe hooks
> * Correct MODULE_AUTHOR statement
> * Split esdhc conlidation patch to ease reviewing
> 
> Shawn Guo (4):
>       mmc: sdhci: make sdhci-pltfm device drivers self registered
>       mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
>       mmc: sdhci: make sdhci-of device drivers self registered
>       mmc: sdhci: merge two sdhci-pltfm.h into one
> 
>  drivers/mmc/host/Kconfig           |   47 +++----
>  drivers/mmc/host/Makefile          |   18 +--
>  drivers/mmc/host/sdhci-cns3xxx.c   |   43 ++++++-
>  drivers/mmc/host/sdhci-dove.c      |   42 ++++++-
>  drivers/mmc/host/sdhci-esdhc-imx.c |  114 +++++++++++-----
>  drivers/mmc/host/sdhci-of-core.c   |  250 ---------------------------------
>  drivers/mmc/host/sdhci-of-esdhc.c  |   85 +++++++++---
>  drivers/mmc/host/sdhci-of-hlwd.c   |   66 ++++++++--
>  drivers/mmc/host/sdhci-of.h        |   42 ------
>  drivers/mmc/host/sdhci-pltfm.c     |  266 ++++++++++++++++++++----------------
>  drivers/mmc/host/sdhci-pltfm.h     |   39 +++++-
>  drivers/mmc/host/sdhci-tegra.c     |  116 +++++++++++-----
>  include/linux/mmc/sdhci-pltfm.h    |   35 -----
>  13 files changed, 578 insertions(+), 585 deletions(-)
> 
> Regards,
> Shawn
> 
