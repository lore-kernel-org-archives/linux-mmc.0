From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/4] mmc: sdhci: Fix card detect race for Intel BXT/APL
Date: Tue,  9 Feb 2016 16:12:34 +0200
Message-ID: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757314AbcBIOQa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Feb 2016 09:16:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

Hi

Here is V2 of patches to fix a problem on Intel BXT/APL.
The PCI and ACPI Ids for BXT/APL were added in v4.4 so the
patches are cc stable v4.4+.

Changes in V2:

Override the mmc host ->get_cd() operation instead of adding a
new sdhci host operation.


Adrian Hunter (4):
      mmc: sdhci: Allow override of mmc host operations
      mmc: sdhci: Allow override of get_cd() called from sdhci_request()
      mmc: sdhci-pci: Fix card detect race for Intel BXT/APL
      mmc: sdhci-acpi: Fix card detect race for Intel BXT/APL

 drivers/mmc/host/sdhci-acpi.c     | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c | 31 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c          |  5 +++--
 drivers/mmc/host/sdhci.h          |  1 +
 4 files changed, 65 insertions(+), 2 deletions(-)


Regards
Adrian
