From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 0/4] mmc: sdio: To support hibernation add capability to skip SDIO reset at scan
Date: Fri, 21 Apr 2017 13:08:04 +0300
Message-ID: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

Hi

Before a hibernation image can be restored, the system must boot which
might result in the mmc core performing a SDIO reset on any SDIO cards.
That is a problem if the state of the SDIO function is to be preserved.
The patches here contrive to avoid that SDIO reset.

The first patch is a general improvement which avoids unnecessary runtime
suspend / resume, and therefore also SDIO reset.

The second patch adds a new capability to void SDIO reset at rescan time.

The final patches select the new capability based on whether there is an
ACPI child node with a _S4W method which is used to infer that the device
(SDIO function) is capable of waking the system from S4 (hibernation).

This patch set is sent as RFC and any feedback on this approach would be
appreciated.


Adrian Hunter (4):
      mmc: sdio: Keep card runtime resumed while adding function devices
      mmc: sdio: Add capability to skip SDIO reset at scan
      mmc: sdhci-acpi: Set MMC_CAP2_NO_SDIO_RESET if child has wake from S4 (hibernate)
      mmc: sdhci-pci: Set MMC_CAP2_NO_SDIO_RESET if child has wake from S4 (hibernate)

 drivers/mmc/core/core.c           |  6 +++++-
 drivers/mmc/core/sdio.c           | 11 ++++++++++-
 drivers/mmc/host/sdhci-acpi.c     | 17 ++++++++++++++++-
 drivers/mmc/host/sdhci-pci-core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h          |  1 +
 5 files changed, 66 insertions(+), 3 deletions(-)


Regards
Adrian
