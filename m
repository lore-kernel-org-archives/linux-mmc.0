From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci: Fix recovery from tuning timeout
Date: Wed, 30 Nov 2016 11:20:10 +0200
Message-ID: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18535 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754713AbcK3JZS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 04:25:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Dan O'Donovan <dan@emutex.com>

Hi

Here are some small SDHCI tuning-related fixes.


Adrian Hunter (4):
      Revert "mmc: sdhci: Reset cmd and data circuits after tuning failure"
      mmc: sdhci: Fix recovery from tuning timeout
      mmc: sdhci: Fix tuning reset after exhausting the maximum number of loops
      mmc: sdhci: Always allow tuning to fall back to fixed sampling

 drivers/mmc/host/sdhci.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)


Regards
Adrian
