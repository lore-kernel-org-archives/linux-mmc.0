From: Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH 0/4] Enable setting of sdio device power state with ACPI
Date: Fri, 12 Oct 2012 11:12:37 +0800
Message-ID: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab2JLDMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Oct 2012 23:12:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

This patchset enables setting of acpi power state for sdio device
when it is runtime suspended/resumed. SDIO function drivers can use
the interfaces too introduced in patch 3 when there is such a need.

Patch 1 adds slot number information to the sdhci_host structure,
the slot number will be used to bind the sdio device with acpi node.

Patch 2 does the actual binding.

Patch 3 introduces a platform power management operation structure,
in which 4 callbacks are defined. The reason this structure is used is
that in addition to ACPI, there may be other platform mechanisms to
place a device into a low power state. And a implementation of this
structure is done for ACPI in this patch. The idea and the definition
of this structure is heavily based on the one used in PCI subsystem.

Patch 4 utilizes the newly added platform pm api to set the device
into a low power state after its driver's runtime suspend callback.
Its runtime wakeup capability is also enabled, and for this to work,
driver must call device_set_run_wake(dev, true) somewhere when wakeup
is desired. Please note that this wakeup mentioned here is realized
through a sideband signal, it's not done by a SDIO interrupt. So
platform support code is needed.

Aaron Lu (4):
  sdhci: add slot number into sdhci_host structure
  mmc: sdio: bind sdio device with acpi device
  sdio: introduce sdio_platform_pm_ops
  sdio: pm: set device's power state after driver runtime suspended it

 drivers/mmc/core/Makefile      |  1 +
 drivers/mmc/core/sdio.c        | 37 +++++++++++++++++++
 drivers/mmc/core/sdio.h        | 28 +++++++++++++++
 drivers/mmc/core/sdio_acpi.c   | 81 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio_bus.c    | 63 +++++++++++++++++++++++++++++---
 drivers/mmc/core/sdio_bus.h    |  2 ++
 drivers/mmc/host/sdhci-pci.c   |  2 +-
 drivers/mmc/host/sdhci-pltfm.c |  4 +--
 drivers/mmc/host/sdhci-s3c.c   |  2 +-
 drivers/mmc/host/sdhci-spear.c |  4 +--
 drivers/mmc/host/sdhci.c       |  3 +-
 drivers/mmc/host/sdhci.h       |  2 +-
 include/linux/mmc/sdhci.h      |  1 +
 13 files changed, 218 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/core/sdio.h
 create mode 100644 drivers/mmc/core/sdio_acpi.c

-- 
1.7.12.21.g871e293

