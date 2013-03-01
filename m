From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Fri, 1 Mar 2013 13:47:12 +0100
Message-ID: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:42575 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab3CAMsH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 07:48:07 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

SDIO has been using runtime pm for a while to handle runtime power save
operations. This patchset is enabling the option to make the sd/mmc
blockdevices to use runtime pm as well.

The runtime pm implementation for the block device will make use of
autosuspend to defer power save operation to after request inactivty for
a certain time.

To actually perform some power save operations the corresponding bus ops
for mmc and sd shall be implemented. Typically it could make sense to do
BKOPS for eMMC in here.

Ulf Hansson (3):
  mmc: core: Remove power_restore bus_ops for mmc and sd
  mmc: core: Add bus_ops for runtime pm callbacks
  mmc: block: Enable runtime pm for mmc blkdevice

 drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
 drivers/mmc/core/bus.c   |   14 ++++++++++++--
 drivers/mmc/core/core.h  |    2 ++
 drivers/mmc/core/mmc.c   |   14 --------------
 drivers/mmc/core/sd.c    |   14 --------------
 drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
 6 files changed, 60 insertions(+), 32 deletions(-)

-- 
1.7.10

