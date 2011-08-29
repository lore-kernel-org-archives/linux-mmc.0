From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/5] mmc: add eMMC hardware reset support
Date: Mon, 29 Aug 2011 16:42:10 +0300
Message-ID: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab1H2NmX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are some patches to add eMMC hardware reset support.

Adrian Hunter (5):
      mmc: add eMMC hardware reset support
      mmc: sdhci: add eMMC hardware reset support
      mmc: sdhci-pci: add eMMC hardware reset support
      mmc: mmc-test: add eMMC hardware reset test
      mmc: block: add eMMC hardware reset support

 drivers/mmc/card/block.c     |  201 +++++++++++++++++++++++++++++------------
 drivers/mmc/card/mmc_test.c  |   30 ++++++
 drivers/mmc/core/core.c      |   99 ++++++++++++++++++++-
 drivers/mmc/core/mmc.c       |    4 +-
 drivers/mmc/host/sdhci-pci.c |   72 +++++++++++++++
 drivers/mmc/host/sdhci.c     |    9 ++
 drivers/mmc/host/sdhci.h     |    2 +-
 include/linux/mmc/card.h     |    1 +
 include/linux/mmc/core.h     |    3 +
 include/linux/mmc/host.h     |    2 +
 include/linux/mmc/mmc.h      |    4 +
 11 files changed, 364 insertions(+), 63 deletions(-)

Regards
Adrian Hunter
