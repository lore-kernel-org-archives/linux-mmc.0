From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 0/7] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Tue, 27 Dec 2011 16:00:07 +0200
Message-ID: <4EF9CF67.10809@intel.com>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9010 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab1L0OAI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 09:00:08 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org

On 27/12/11 15:48, Adrian Hunter wrote:
> Hi
> 
> Here are some changes (V4) to allow wl12xx/SDIO to be set up for sdhci-pci.
> There a a couple of fixes plus a method to get platform data.  The
> changes to the platform files are not included in this patchset.
> 
> 
> V4: Fix initialization and free of cd_irq in

Actually "cd_gpio"

> "mmc: sdhci-pci: get gpio numbers from platform data"
> 
> V3: add "mmc: sdhci-pci: enable runtime PM for Medfield SDIO"
>     roll-in "sdhci: Always pass clock request value zero to set_clock host op"
> 
> V2: change sdhci_pci_get_data() from a weak function to a function
> pointer
> 
> 
> Adrian Hunter (6):
>       mmc: sdhci: fix vmmc handling
>       mmc: sdhci: prevent card detection activity for non-removable cards
>       mmc: sdhci-pci: add platform data
>       mmc: sdhci-pci: get gpio numbers from platform data
>       mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
>       mmc: sdhci-pci: enable runtime PM for Medfield SDIO
> 
> Todd Poynor (1):
>       sdhci: Always pass clock request value zero to set_clock host op
> 
>  drivers/Makefile                   |    2 +-
>  drivers/mmc/Makefile               |    3 +-
>  drivers/mmc/host/Makefile          |    1 +
>  drivers/mmc/host/sdhci-pci-data.c  |    5 +
>  drivers/mmc/host/sdhci-pci.c       |  143 ++++++++++++++++++------------------
>  drivers/mmc/host/sdhci.c           |   51 ++++++-------
>  include/linux/mmc/sdhci-pci-data.h |   18 +++++
>  include/linux/mmc/sdhci.h          |    2 -
>  8 files changed, 123 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-data.c
>  create mode 100644 include/linux/mmc/sdhci-pci-data.h
> 
> 
> Regards
> Adrian
> 

