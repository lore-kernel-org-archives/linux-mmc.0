From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: Fixes relating to Bus Width Testing on Intel platforms
Date: Fri, 20 May 2016 10:33:45 +0300
Message-ID: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbcETHhp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2016 03:37:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are a couple of fixes relating to Bus Width Testing and reading the
Extended CSD register on Intel platforms.


Adrian Hunter (2):
      mmc: sdhci-pci: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
      mmc: sdhci-acpi: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers

Matt Gumbel (1):
      mmc: longer timeout for long read time quirk

 drivers/mmc/card/block.c          | 5 +++--
 drivers/mmc/core/core.c           | 4 ++--
 drivers/mmc/host/sdhci-acpi.c     | 6 +++---
 drivers/mmc/host/sdhci-pci-core.c | 5 +----
 4 files changed, 9 insertions(+), 11 deletions(-)


Regards
Adrian
