From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/5] mmc: sdhci: Misc patches
Date: Tue, 12 Apr 2016 14:25:04 +0300
Message-ID: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9541 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932393AbcDLL3H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:29:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are 5 miscellaneous patches for sdhci.


Adrian Hunter (5):
      mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
      mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
      mmc: sdhci: Remove redundant condition
      mmc: sdhci: Fix error paths in sdhci_add_host()
      mmc: sdhci: Tidy together LED code


Regards
Adrian
