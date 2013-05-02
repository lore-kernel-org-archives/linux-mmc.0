From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V4 0/4] mmc: Use runtime pm for blkdevice
Date: Thu, 2 May 2013 14:02:35 +0200
Message-ID: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:58524 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756090Ab3EBMCv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 May 2013 08:02:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

SDIO has been using runtime pm for a while to handle runtime power save
operations. This patchset is enabling the option to make the sd/mmc
blockdevices to use runtime pm as well.

The runtime pm implementation for the block device will make use of
autosuspend to defer power save operation to after request inactivty for
a certain time.

Corresponding pm_runtime_get|put calls has been added at those places that
do requires the card to be fully powered to communicate.

Patch 4 can be considered as a proof of concept patch. It implements
aggressive power management for (e)MMC/SD. This feature has also been
discussed on the mmc mailing list previously.

Next step would be to implement the IDLE BKOPS on top of the runtime pm
callbacks.

Changes in v4:
	- Updated patch 4 according to review comments from Adrian.

Changes in v3:
	- Make sure the card device is powered from a runtime perspective
	when needed. This is also the indirect reason to why the new patch 1
	has been added to this patchset.
	- Added a proof of concept patch, in patch 4.
	- Replace acks with cc, since quite some changes has been done.

Changes in v2:
        - Removed the stated patch below from this patchset. It can be handled
        separately. "mmc: core: Remove power_restore bus_ops for mmc and sd"
        - Rebased patches on latest mmc-next.
        - Added Acks.

Ulf Hansson (4):
  mmc: core: Stop bkops for eMMC only from mmc suspend
  mmc: core: Add bus_ops for runtime pm callbacks
  mmc: block: Enable runtime pm for mmc blkdevice
  mmc: core: Support aggressive power management for (e)MMC/SD

 drivers/mmc/card/block.c   |   32 ++++++++++++++++++-----
 drivers/mmc/core/bus.c     |   14 +++++++++--
 drivers/mmc/core/core.c    |   47 ++++++++++++++++++----------------
 drivers/mmc/core/core.h    |    3 +++
 drivers/mmc/core/debugfs.c |    8 +++---
 drivers/mmc/core/mmc.c     |   60 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/sd.c      |   53 ++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/sdio.c    |   16 ++++++++++++
 include/linux/mmc/core.h   |    3 +++
 include/linux/mmc/host.h   |    2 +-
 10 files changed, 199 insertions(+), 39 deletions(-)

-- 
1.7.10

