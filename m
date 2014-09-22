From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 00/13] mmc: Some Braswell and misc patches
Date: Mon, 22 Sep 2014 13:17:31 +0300
Message-ID: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4573 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaIVKT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some patches to further support for Intel Braswell
SoC plus some miscellaneous changes.

The patches needed for Braswell are:

      mmc: sdhci: Add quirk for always getting TC with stop cmd
      mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
      mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
      mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
      mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
      mmc: sdhci: Let a driver override timeout clock frequency
      mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency


Adrian Hunter (13):
      mmc: Fix use of wrong device in mmc_gpiod_free_cd()
      mmc: Fix incorrect warning when setting 0 Hz via debugfs
      mmc: It is not an error for the card to be removed while suspended
      mmc: block: Fix error recovery stop cmd timeout calculation
      mmc: block: Fix SD card stop cmd response type
      mmc: sdhci: Add quirk for always getting TC with stop cmd
      mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
      mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
      mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
      mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
      mmc: sdhci: Let a driver override timeout clock frequency
      mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
      mmc: sdhci: Transfer Complete has higher priority than Data Timeout Error

 drivers/mmc/card/block.c      | 30 ++++++++++++++++++++++++------
 drivers/mmc/core/core.c       |  2 +-
 drivers/mmc/core/mmc.c        |  2 +-
 drivers/mmc/core/sd.c         |  2 +-
 drivers/mmc/core/slot-gpio.c  |  2 +-
 drivers/mmc/host/sdhci-acpi.c |  6 ++++--
 drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
 drivers/mmc/host/sdhci-pci.h  |  4 ++++
 drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
 include/linux/mmc/sdhci.h     |  2 ++
 10 files changed, 82 insertions(+), 23 deletions(-)


Regards
Adrian
