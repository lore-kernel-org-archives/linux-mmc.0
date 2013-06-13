From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: add support for eMMC hardware reset for BYT eMMC
Date: Thu, 13 Jun 2013 11:50:25 +0300
Message-ID: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46664 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756822Ab3FMIpH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 04:45:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are 2 patches to add support for eMMC hardware reset for BYT eMMC.


Adrian Hunter (2):
      mmc: sdhci-pci: add support for eMMC hardware reset for BYT eMMC.
      mmc: sdhci-acpi: add support for eMMC hardware reset for HID 80860F14

 drivers/mmc/host/sdhci-acpi.c | 28 +++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.c  | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)


Regards
Adrian
