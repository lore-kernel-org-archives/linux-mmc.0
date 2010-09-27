From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH V2 0/2] MMC removable helper function
Date: Mon, 27 Sep 2010 09:42:18 +0100
Message-ID: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:44852 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754255Ab0I0ImX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 04:42:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>

Chris, I've rebased this mmc_assume_removable patch series against
mmc-next and fixed up the compilation breakage with allmodconfig.

Note, I've left your Signed-off-by on Jaehoon's patch because you
modified the patch slightly (and because it's going through your tree
anyway). I hope that's OK.

Jaehoon Chung (1):
  mmc: sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case

Matt Fleming (1):
  mmc: Add helper function to check if a card is removable

 drivers/mmc/core/core.c  |    1 +
 drivers/mmc/core/core.h  |    1 -
 drivers/mmc/core/mmc.c   |    2 +-
 drivers/mmc/core/sd.c    |    2 +-
 drivers/mmc/host/sdhci.c |    3 ++-
 include/linux/mmc/host.h |    8 ++++++++
 6 files changed, 13 insertions(+), 4 deletions(-)

-- 
1.7.2.1

