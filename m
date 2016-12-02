From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/9] mmc: sdhci: Fix recovery from tuning timeout
Date: Fri,  2 Dec 2016 15:14:18 +0200
Message-ID: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50159 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755680AbcLBNTo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 08:19:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some small SDHCI tuning-related fixes and some clean-ups.

Changes in V2:
	Added clean-up patches


Adrian Hunter (9):
      Revert "mmc: sdhci: Reset cmd and data circuits after tuning failure"
      mmc: sdhci: Fix recovery from tuning timeout
      mmc: sdhci: Fix tuning reset after exhausting the maximum number of loops
      mmc: sdhci: Always allow tuning to fall back to fixed sampling
      mmc: mmc: Introduce mmc_abort_tuning()
      mmc: sdhci: Use mmc_abort_tuning()
      mmc: sdhci: Factor out tuning helper functions
      mmc: sdhci: Simplify tuning block size logic
      mmc: sdhci: Tidy tuning loop

 drivers/mmc/core/mmc_ops.c |  25 ++++
 drivers/mmc/host/sdhci.c   | 278 ++++++++++++++++++++++++---------------------
 include/linux/mmc/core.h   |   1 +
 3 files changed, 173 insertions(+), 131 deletions(-)


Regards
Adrian
