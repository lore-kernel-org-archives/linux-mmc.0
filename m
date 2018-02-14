From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/4] mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup
Date: Wed, 14 Feb 2018 14:56:28 +0200
Message-ID: <1518612992-4951-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi

Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
cd_irq") enabled wakeup irrespective of the host controller's PM flags.
However, users also want to control it from sysfs power/wakeup attribute.
That means the driver needs to check the PM flags before enabling it in the
suspend callback.  Patch 4 adds support for that in sdhci-pci, which is the
only driver presently using the MMC_CAP_CD_WAKE flag.  Patches 1 - 1 tidy
up aspects of sdhci and sdhci-pci wakeup handling, and patch 3 adds a
helper function to make it easy for drivers.

There are 2 contentious aspects to this patch set:

1) An existing problem with the SDIO API which does not let the host
controller driver know that the SDIO function driver has requested SDIO
card interrupt wakeup until the suspend callback - which results in the
host controller driver having to enable or disable wakeup in the suspend
callback.  Fixing the SDIO API is a separate issue IMHO.

2) In order to use the sysfs power/wakeup attribute, the driver must set the
device as wake capable even when it is really a GPIO that wakes the system.


Changes in V2:

      mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
      mmc: sdhci-pci: Use device wakeup capability to determine MMC_PM_WAKE_SDIO_IRQ capability
      mmc: sdhci: Stop exporting sdhci_enable_irq_wakeups()
      mmc: sdhci: Handle failure of enable_irq_wake()
      mmc: sdhci: Rework sdhci_enable_irq_wakeups()
	Dropped because they have been appled already
      mmc: slot-gpio: Add a function to enable/disable card detect IRQ wakeup
	Re-based


Adrian Hunter (4):
      mmc: sdhci: Do not unnecessarily enable wakeup for card detect interrupt
      mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
      mmc: slot-gpio: Add a function to enable/disable card detect IRQ wakeup
      mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup

 drivers/mmc/core/core.c           |  3 +--
 drivers/mmc/core/slot-gpio.c      | 25 +++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci-core.c | 18 ++++++++++++++----
 drivers/mmc/host/sdhci.c          | 23 ++++++++++++++++++++---
 include/linux/mmc/slot-gpio.h     |  1 +
 5 files changed, 59 insertions(+), 11 deletions(-)


Regards
Adrian
