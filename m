From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci-acpi: Fix voltage switch for some Intel host controllers
Date: Thu, 19 Oct 2017 13:41:42 +0300
Message-ID: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21701 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdJSKsi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Oct 2017 06:48:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are a few patches to fix voltage switching on some Intel host
controllers.


Adrian Hunter (4):
      mmc: sdhci-acpi: Use helper function acpi_device_uid()
      mmc: sdhci-acpi: Tidy Intel slot probe functions into one
      mmc: sdhci-acpi: Let devices define their own private data
      mmc: sdhci-acpi: Fix voltage switch for some Intel host controllers

 drivers/mmc/host/sdhci-acpi.c | 174 +++++++++++++++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 45 deletions(-)


Regards
Adrian
