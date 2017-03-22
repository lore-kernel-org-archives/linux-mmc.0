From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 00/25] sdhci patches
Date: Wed, 22 Mar 2017 09:47:56 +0100
Message-ID: <20170322084755.7q5zw6dg74uux4mu@rfolt0960.corp.atmel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48037 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759105AbdCVK0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 06:26:17 -0400
Content-Disposition: inline
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

On Mon, Mar 20, 2017 at 07:50:28PM +0200, Adrian Hunter wrote:
> Hi
> 
> Here are some sdhci patches that include preparation for CQE and some
> general improvements.  Patches such as:
> 
>     mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
>     mmc: sdhci: Do not use spin lock in set_ios paths
> 
> affect several drivers specifically, like:
> 
>     drivers/mmc/host/sdhci-brcmstb.c
>     drivers/mmc/host/sdhci-esdhc-imx.c
>     drivers/mmc/host/sdhci-of-arasan.c
>     drivers/mmc/host/sdhci-of-at91.c
>     drivers/mmc/host/sdhci-of-esdhc.c
>     drivers/mmc/host/sdhci-pxav3.c
>     drivers/mmc/host/sdhci-s3c.c
>     drivers/mmc/host/sdhci-sirf.c
>     drivers/mmc/host/sdhci-spear.c
>     drivers/mmc/host/sdhci-st.c
> 
> 
> 
> Adrian Hunter (25):
>       mmc: sdhci: Do not disable interrupts while waiting for clock
>       mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power
>       mmc: sdhci: Optimize delay loops
>       mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
>       mmc: sdhci-pci: Let devices define their own private data
>       mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
>       mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices
>       mmc: sdhci: Remove ->select_drive_strength() callback
>       mmc: sdhci: Do not use spin lock in set_ios paths
>       mmc: sdhci: Reduce spin lock usage in sdhci_execute_tuning
>       mmc: sdhci: Improve debug print format
>       mmc: sdhci: Add response register to register dump
>       mmc: sdhci: Use sdhci_readl() not readl() in sdhci_dumpregs()
>       mmc: sdhci: Improve register dump print format
>       mmc: sdhci: Export sdhci_dumpregs
>       mmc: sdhci: Get rid of 'extern' in header file
>       mmc: sdhci: Add sdhci_cleanup_host
>       mmc: sdhci: Factor out sdhci_set_default_irqs
>       mmc: sdhci: Add CQE support
>       mmc: sdhci-pci: Let devices define how to add the host
>       mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
>       mmc: sdhci-pci: Conditionally compile pm sleep functions
>       mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
>       mmc: sdhci-pci: Add runtime suspend/resume callbacks
>       mmc: sdhci-pci: Move a function to avoid later forward declaration
> 
>  drivers/mmc/host/sdhci-acpi.c        |  12 +-
>  drivers/mmc/host/sdhci-brcmstb.c     |   3 +
>  drivers/mmc/host/sdhci-esdhc-imx.c   |   6 +
>  drivers/mmc/host/sdhci-msm.c         |   8 -
>  drivers/mmc/host/sdhci-of-arasan.c   |   9 +-
>  drivers/mmc/host/sdhci-of-at91.c     |   5 +-
>  drivers/mmc/host/sdhci-of-esdhc.c    |   3 +
>  drivers/mmc/host/sdhci-pci-core.c    | 551 ++++++++++++++++++++---------------
>  drivers/mmc/host/sdhci-pci-data.c    |   3 -
>  drivers/mmc/host/sdhci-pci-o2micro.c |   4 +-
>  drivers/mmc/host/sdhci-pci.h         |  24 +-
>  drivers/mmc/host/sdhci-pltfm.c       |   3 +
>  drivers/mmc/host/sdhci-pxav3.c       |  10 +-
>  drivers/mmc/host/sdhci-s3c.c         |  10 +-
>  drivers/mmc/host/sdhci-sirf.c        |   3 +
>  drivers/mmc/host/sdhci-spear.c       |   3 +
>  drivers/mmc/host/sdhci-st.c          |   6 +-
>  drivers/mmc/host/sdhci.c             | 404 ++++++++++++++++---------
>  drivers/mmc/host/sdhci.h             |  58 ++--
>  19 files changed, 691 insertions(+), 434 deletions(-)
> 

Tested-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> 
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
