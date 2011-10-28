From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci/sdhci-pci: prepare for wl12xx/SDIO
Date: Fri, 28 Oct 2011 12:33:53 +0300
Message-ID: <1319794437-16870-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62681 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab1J1JeD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Oct 2011 05:34:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are some changes to allow wl12xx/SDIO to be set up for sdhci-pci.
There a a couple of fixes plus a method to get platform data.  The
changes to the platform files are not included in this patchset.


Adrian Hunter (4):
      mmc: sdhci: fix vmmc handling
      mmc: sdhci: prevent card detection activity for non-removable cards
      mmc: sdhci-pci: add platform data
      mmc: sdhci-pci: get gpio numbers from platform data

 drivers/mmc/host/sdhci-pci.c       |  137 +++++++++++++++++-------------------
 drivers/mmc/host/sdhci.c           |   50 ++++++-------
 include/linux/mmc/sdhci-pci-data.h |   18 +++++
 3 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100644 include/linux/mmc/sdhci-pci-data.h


Regards
Adrian Hunter
