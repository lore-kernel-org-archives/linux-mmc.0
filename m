From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 0/4] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Fri,  4 Nov 2011 10:15:59 +0200
Message-ID: <1320394563-29682-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62538 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab1KDIQM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 04:16:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are some changes (V3) to allow wl12xx/SDIO to be set up for sdhci-pci.
There a a couple of fixes plus a method to get platform data.  The
changes to the platform files are not included in this patchset.

V3: fix initialization of sd_gpio

V2: change sdhci_pci_get_data() from a weak function to a function
pointer


Adrian Hunter (4):
      mmc: sdhci: fix vmmc handling
      mmc: sdhci: prevent card detection activity for non-removable cards
      mmc: sdhci-pci: add platform data
      mmc: sdhci-pci: get gpio numbers from platform data

 drivers/Makefile                   |    2 +-
 drivers/mmc/Makefile               |    3 +-
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-pci-data.c  |    5 ++
 drivers/mmc/host/sdhci-pci.c       |  141 ++++++++++++++++++------------------
 drivers/mmc/host/sdhci.c           |   50 ++++++-------
 include/linux/mmc/sdhci-pci-data.h |   18 +++++
 7 files changed, 119 insertions(+), 101 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-data.c
 create mode 100644 include/linux/mmc/sdhci-pci-data.h


Regards
Adrian Hunter
