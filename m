From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/25] sdhci patches
Date: Tue, 21 Mar 2017 15:17:35 +0000
Message-ID: <20170321151735.g2emerbvkht2y2ij@dell>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <20170321110039.6vphjb7n4zpe65kg@dell>
 <04376d75-accb-b21e-f2ae-f3077157b205@intel.com>
 <20170321151436.carjcczuyuoota2v@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33195 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757592AbdCUPRl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 11:17:41 -0400
Received: by mail-wr0-f174.google.com with SMTP id u48so114051017wrc.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2017 08:17:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170321151436.carjcczuyuoota2v@dell>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

On Tue, 21 Mar 2017, Lee Jones wrote:

> On Tue, 21 Mar 2017, Adrian Hunter wrote:
> 
> > On 21/03/17 13:00, Lee Jones wrote:
> > > On Mon, 20 Mar 2017, Adrian Hunter wrote:
> > >> Adrian Hunter (25):
> > >>       mmc: sdhci: Do not disable interrupts while waiting for clock
> > >>       mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power
> > >>       mmc: sdhci: Optimize delay loops
> > >>       mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
> > >>       mmc: sdhci-pci: Let devices define their own private data
> > >>       mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
> > >>       mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices
> > >>       mmc: sdhci: Remove ->select_drive_strength() callback
> > >>       mmc: sdhci: Do not use spin lock in set_ios paths
> > >>       mmc: sdhci: Reduce spin lock usage in sdhci_execute_tuning
> > >>       mmc: sdhci: Improve debug print format
> > >>       mmc: sdhci: Add response register to register dump
> > >>       mmc: sdhci: Use sdhci_readl() not readl() in sdhci_dumpregs()
> > >>       mmc: sdhci: Improve register dump print format
> > >>       mmc: sdhci: Export sdhci_dumpregs
> > >>       mmc: sdhci: Get rid of 'extern' in header file
> > >>       mmc: sdhci: Add sdhci_cleanup_host
> > >>       mmc: sdhci: Factor out sdhci_set_default_irqs
> > >>       mmc: sdhci: Add CQE support
> > >>       mmc: sdhci-pci: Let devices define how to add the host
> > >>       mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
> > >>       mmc: sdhci-pci: Conditionally compile pm sleep functions
> > >>       mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
> > >>       mmc: sdhci-pci: Add runtime suspend/resume callbacks
> > >>       mmc: sdhci-pci: Move a function to avoid later forward declaration
> > > 
> > > Why have you sent this set to so many people?
> > 
> > Because they might have an interest in testing the drivers that they have
> > contributed to.
> > 
> > > 
> > > Mores the point, why have you sent it to me?
> > 
> > Because you contributed to:
> > 
> > 	drivers/mmc/host/sdhci-st.c
> > 
> > and might have an interest in testing it.
> 
> Please don't send patches to every email address get_maintainer.pl
> spits out.  If everyone did that contributors, especially the ones
> who work across many subsystems, would be completely swamped in mail.
> 
> Instead exercise common sense and only include the Maintainers and
> *maybe* super heavy, regular contributors or authors if you are that
> way inclined.
> 
> Personally I only send to the Maintainers of the file.  If anyone else
> has a keen interest they will normally set up filters on the MLs to
> catch patches submitted. 

I've just seen that you *are* the Maintainer of SDHCI, so I guess this
it *slightly* different for you.  In this case I would have only Cc'ed
your Co- and Sub- Maintainers and any heavy contributors/authors.

The long as the short of it is, little people like me shouldn't really
be in receipt of this change.

> > >>  drivers/mmc/host/sdhci-acpi.c        |  12 +-
> > >>  drivers/mmc/host/sdhci-brcmstb.c     |   3 +
> > >>  drivers/mmc/host/sdhci-esdhc-imx.c   |   6 +
> > >>  drivers/mmc/host/sdhci-msm.c         |   8 -
> > >>  drivers/mmc/host/sdhci-of-arasan.c   |   9 +-
> > >>  drivers/mmc/host/sdhci-of-at91.c     |   5 +-
> > >>  drivers/mmc/host/sdhci-of-esdhc.c    |   3 +
> > >>  drivers/mmc/host/sdhci-pci-core.c    | 551 ++++++++++++++++++++---------------
> > >>  drivers/mmc/host/sdhci-pci-data.c    |   3 -
> > >>  drivers/mmc/host/sdhci-pci-o2micro.c |   4 +-
> > >>  drivers/mmc/host/sdhci-pci.h         |  24 +-
> > >>  drivers/mmc/host/sdhci-pltfm.c       |   3 +
> > >>  drivers/mmc/host/sdhci-pxav3.c       |  10 +-
> > >>  drivers/mmc/host/sdhci-s3c.c         |  10 +-
> > >>  drivers/mmc/host/sdhci-sirf.c        |   3 +
> > >>  drivers/mmc/host/sdhci-spear.c       |   3 +
> > >>  drivers/mmc/host/sdhci-st.c          |   6 +-
> > >>  drivers/mmc/host/sdhci.c             | 404 ++++++++++++++++---------
> > >>  drivers/mmc/host/sdhci.h             |  58 ++--
> > >>  19 files changed, 691 insertions(+), 434 deletions(-)
> > >>
> > >>
> > >> Regards
> > >> Adrian
> > > 
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
