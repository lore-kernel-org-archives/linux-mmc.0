From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/6] mmc: Some misc patches
Date: Tue, 23 Sep 2014 23:00:24 +0300
Message-ID: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205AbaIWUBy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:01:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some miscellaneous changes.


Adrian Hunter (6):
      mmc: Fix use of wrong device in mmc_gpiod_free_cd()
      mmc: Fix incorrect warning when setting 0 Hz via debugfs
      mmc: It is not an error for the card to be removed while suspended
      mmc: block: Fix error recovery stop cmd timeout calculation
      mmc: block: Fix SD card stop cmd response type
      mmc: sdhci: Transfer Complete has higher priority than Data Timeout Error

 drivers/mmc/card/block.c     | 30 ++++++++++++++++++++++++------
 drivers/mmc/core/core.c      |  2 +-
 drivers/mmc/core/mmc.c       |  2 +-
 drivers/mmc/core/sd.c        |  2 +-
 drivers/mmc/core/slot-gpio.c |  2 +-
 drivers/mmc/host/sdhci.c     | 13 +++++++------
 6 files changed, 35 insertions(+), 16 deletions(-)


Regards
Adrian

