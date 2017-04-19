From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers
Date: Wed, 19 Apr 2017 16:09:21 +0300
Message-ID: <1492607363-5346-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763519AbdDSNPG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are 2 small patches to enable card detect wake for Intel BYT-related
SD card host controllers.


Adrian Hunter (2):
      mmc: slot-gpio: Add support to enable irq wake on cd_irq
      mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers

 drivers/mmc/core/core.c           |  5 ++++-
 drivers/mmc/core/slot-gpio.c      | 12 ++++++++++++
 drivers/mmc/host/sdhci-pci-core.c |  3 +++
 drivers/mmc/host/sdhci-pci.h      |  1 +
 include/linux/mmc/host.h          |  1 +
 include/linux/mmc/slot-gpio.h     |  1 +
 6 files changed, 22 insertions(+), 1 deletion(-)


Regards
Adrian
