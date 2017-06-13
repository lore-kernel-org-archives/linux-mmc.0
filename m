From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/2] mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers
Date: Tue, 13 Jun 2017 15:07:50 +0300
Message-ID: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32287 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbdFMMNx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Jun 2017 08:13:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are 2 small patches to enable card detect wake for Intel BYT-related
SD card host controllers.


Changes in V2:
	Use a host capability to select card detect wake


Adrian Hunter (2):
      mmc: slot-gpio: Add support to enable irq wake on cd_irq
      mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers

 drivers/mmc/core/core.c           | 5 ++++-
 drivers/mmc/core/slot-gpio.c      | 2 ++
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 include/linux/mmc/host.h          | 2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)


Regards
Adrian
