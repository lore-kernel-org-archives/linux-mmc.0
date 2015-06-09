From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH 0/2] adds quirk SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
Date: Tue, 9 Jun 2015 13:01:49 +0530
Message-ID: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stripathi@apm.com, Suneel Garapati <suneel.garapati@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

This quirk will support controllers whose clock divider zero is broken
and if the calculation results to zero, forcing the divider to next value.
This is tested on zynq ep108 and enables support for UHS cards where formatting
cards fail. Added few quirks to arasan platform driver as the base clock reported in
registers is broken and preset values are broken too and tested on zynq ep108
platform. max-frequency devicetree parameter is alternative to get upper limit .

Suneel Garapati (2):
  drivers: mmc: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN
  drivers: mmc: add quirks for broken clock base

 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 drivers/mmc/host/sdhci.c           | 4 ++++
 drivers/mmc/host/sdhci.h           | 2 ++
 3 files changed, 9 insertions(+)

--
2.1.2
