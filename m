From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci: Fixes
Date: Wed,  2 Nov 2016 15:49:07 +0200
Message-ID: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbcKBNyG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

Hi

Here are 4 small sdhci fixes.  Some of the fixes improve sdhci ability to
deal with errors (e.g. CRC errors ) when software command queuing is active.


Adrian Hunter (4):
      mmc: sdhci: Fix CMD line reset interfering with ongoing data transfer
      mmc: sdhci: Fix unexpected data interrupt handling
      mmc: sdhci: Reset cmd and data circuits after tuning failure
      mmc: sdhci: Fix missing enhanced strobe setting during runtime resume

 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)


Regards
Adrian
