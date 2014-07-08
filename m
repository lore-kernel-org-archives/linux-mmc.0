From: Maurice Petallo <mauricex.r.petallo@intel.com>
Subject: [PATCH 0/2] mmc: sdhci: Preset Value disabling and DDR50 mode enabling for BayTrail eMMC
Date: Tue,  8 Jul 2014 19:10:59 +0800
Message-ID: <1404817861-23359-1-git-send-email-mauricex.r.petallo@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Maurice Petallo <mauricex.r.petallo@intel.com>
List-Id: linux-mmc@vger.kernel.org

This patch series includes:
(1) Declare SDHCI_QUIRK2_PRESET_VALUE_BROKEN for PCI mode and ACPI mode
    Baytrail eMMC controller as it doesn't support Preset Value feature.
(2) Enable DDR50 1.8V mode support for PCI and ACPI mode BayTrail eMMC controller

Maurice Petallo (2):
  mmc: sdhci: Preset value not supported in Baytrail eMMC
  mmc: sdhci: add DDR50 1.8V mode support for BayTrail eMMC Controller

 drivers/mmc/host/sdhci-acpi.c | 4 +++-
 drivers/mmc/host/sdhci-pci.c  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.8.1.4
