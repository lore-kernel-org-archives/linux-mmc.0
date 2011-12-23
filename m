From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 0/7] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Fri, 23 Dec 2011 14:58:03 +0200
Message-ID: <1324645090-5008-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40696 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756788Ab1LWM6P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Dec 2011 07:58:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are some changes (V3) to allow wl12xx/SDIO to be set up for sdhci-pci.
There a a couple of fixes plus a method to get platform data.  The
changes to the platform files are not included in this patchset.


V3: add "mmc: sdhci-pci: enable runtime PM for Medfield SDIO"
    roll-in "sdhci: Always pass clock request value zero to set_clock host op"

V2: change sdhci_pci_get_data() from a weak function to a function
pointer


Adrian Hunter (6):
      mmc: sdhci: fix vmmc handling
      mmc: sdhci: prevent card detection activity for non-removable cards
      mmc: sdhci-pci: add platform data
      mmc: sdhci-pci: get gpio numbers from platform data
      mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
      mmc: sdhci-pci: enable runtime PM for Medfield SDIO

Todd Poynor (1):
      sdhci: Always pass clock request value zero to set_clock host op

 drivers/Makefile                   |    2 +-
 drivers/mmc/Makefile               |    3 +-
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-pci-data.c  |    5 ++
 drivers/mmc/host/sdhci-pci.c       |  139 ++++++++++++++++++------------------
 drivers/mmc/host/sdhci.c           |   51 ++++++-------
 include/linux/mmc/sdhci-pci-data.h |   18 +++++
 include/linux/mmc/sdhci.h          |    2 -
 8 files changed, 120 insertions(+), 101 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-data.c
 create mode 100644 include/linux/mmc/sdhci-pci-data.h


Regards
Adrian
