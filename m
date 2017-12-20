From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/9] mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup
Date: Wed, 20 Dec 2017 10:18:44 +0200
Message-ID: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36183 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdLTITV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Hi

Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
cd_irq") enabled wakeup irrespective of the host controller's PM flags.
However, users also want to control it from sysfs power/wakeup attribute.
That means the driver needs to check the PM flags before enabling it in the
suspend callback.  Patch 9 adds support for that in sdhci-pci, which is the
only driver presently using the MMC_CAP_CD_WAKE flag.  Patches 1 - 7 tidy
up aspects of sdhci and sdhci-pci wakeup handling, and patch 8 adds a
helper function to make it easy for drivers.


Adrian Hunter (9):
      mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
      mmc: sdhci-pci: Use device wakeup capability to determine MMC_PM_WAKE_SDIO_IRQ capability
      mmc: sdhci: Stop exporting sdhci_enable_irq_wakeups()
      mmc: sdhci: Handle failure of enable_irq_wake()
      mmc: sdhci: Rework sdhci_enable_irq_wakeups()
      mmc: sdhci: Do not unnecessarily enable wakeup for card detect interrupt
      mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
      mmc: slot-gpio: Add a function to enable/disable card detect IRQ wakeup
      mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup

 drivers/mmc/core/core.c           |  3 +-
 drivers/mmc/core/slot-gpio.c      | 25 ++++++++++++--
 drivers/mmc/host/sdhci-pci-core.c | 73 +++++++++++++++++++--------------------
 drivers/mmc/host/sdhci.c          | 67 ++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h          |  2 +-
 include/linux/mmc/slot-gpio.h     |  1 +
 6 files changed, 108 insertions(+), 63 deletions(-)


Regards
Adrian
