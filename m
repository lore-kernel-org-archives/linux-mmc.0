From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: add a cap and a quirk
Date: Tue,  7 Feb 2012 14:48:51 +0200
Message-ID: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2BGMsx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 07:48:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are patches for Medfield to allow the use of high-capacity erase size
and to allow the SDIO host controller to be off when the card is kept on
during suspend - replacing the earlier patch "mmc: sdhci: always reset all
during resume"


Adrian Hunter (4):
      mmc: core: add high-capacity erase size capability flag
      mmc: sdhci-pci: select HC erase size for Medfield eMMC
      mmc: sdhci: add quirk for keeping card power during suspend
      mmc: sdhci-pci: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for Medfield SDIO

 drivers/mmc/core/mmc.c       |    3 ++-
 drivers/mmc/host/sdhci-pci.c |    8 +++++++-
 drivers/mmc/host/sdhci.c     |   13 +++++++++++--
 include/linux/mmc/host.h     |    1 +
 include/linux/mmc/sdhci.h    |    2 ++
 5 files changed, 23 insertions(+), 4 deletions(-)


Regards
Adrian
