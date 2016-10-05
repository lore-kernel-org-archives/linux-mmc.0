From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci: Minor fixes
Date: Wed,  5 Oct 2016 12:11:20 +0300
Message-ID: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbcJEJRB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 05:17:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are a couple of minor fixes.  While it would be good to have them in
4.9 or a 4.9-rc, they are not urgent.


Adrian Hunter (4):
      mmc: sdhci: Fix SDHCI_QUIRK2_STOP_WITH_TC
      mmc: sdhci: Rename sdhci_set_power() to sdhci_set_power_noreg()
      mmc: sdhci-pci: Let devices define their own sdhci_ops
      mmc: sdhci-pci: Fix bus power failing to enable for some Intel controllers

 drivers/mmc/host/sdhci-pci-core.c | 54 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  2 ++
 drivers/mmc/host/sdhci-pxav3.c    |  2 +-
 drivers/mmc/host/sdhci.c          | 40 ++++++++++++++---------------
 drivers/mmc/host/sdhci.h          |  2 ++
 5 files changed, 77 insertions(+), 23 deletions(-)


Regards
Adrian
