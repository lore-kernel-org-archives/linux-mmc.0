From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/7] mmc: Some Braswell patches
Date: Wed, 24 Sep 2014 10:27:26 +0300
Message-ID: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23084 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbaIXHiQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:38:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some patches to further support for Intel Braswell
SoC.


Adrian Hunter (7):
      mmc: sdhci: Add quirk for always getting TC with stop cmd
      mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
      mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
      mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
      mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
      mmc: sdhci: Let a driver override timeout clock frequency
      mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency

 drivers/mmc/host/sdhci-acpi.c |  6 ++++--
 drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
 drivers/mmc/host/sdhci-pci.h  |  4 ++++
 drivers/mmc/host/sdhci.c      | 14 ++++++++++++--
 include/linux/mmc/sdhci.h     |  2 ++
 5 files changed, 47 insertions(+), 7 deletions(-)


Regards
Adrian
