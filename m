From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/4] mmc: sdhci: try to avoid another division by zero
Date: Wed,  3 Aug 2011 18:35:57 +0300
Message-ID: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16490 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab1HCPga (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Aug 2011 11:36:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The set of patches that applied for 3.0 exposes another "division by zero"
error. This set tries to remake the "Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK" patch.

Comments are very welcome!

Of course, the set needs to be tested carefully.

Andy Shevchenko (4):
  Revert "mmc: sdhci: Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK"
  mmc: sdhci: check host->clock before use it as denominator
  mmc: sdhci: move timeout_clk calculation a bit further
  mmc: sdhci: use f_max instead of host->clock for timeouts

 drivers/mmc/host/sdhci.c |   50 ++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 26 deletions(-)

-- 
1.7.5.4

