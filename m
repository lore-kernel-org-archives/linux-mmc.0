From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 0/2] mmc: Use runtime pm for blkdevice
Date: Thu, 4 Apr 2013 18:41:36 +0200
Message-ID: <1365093698-6367-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:54674 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763633Ab3DDRJk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 13:09:40 -0400
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

To actually perform some power save operations the corresponding bus ops
for mmc and sd shall be implemented. Typically it could make sense to do
BKOPS for eMMC in here.


Changes in v2:
        - Removed the stated patch below from this patchset. It can be handled
        separately. "mmc: core: Remove power_restore bus_ops for mmc and sd"
        - Rebased patches on latest mmc-next.
        - Added Acks.

Ulf Hansson (2):
  mmc: core: Add bus_ops for runtime pm callbacks
  mmc: block: Enable runtime pm for mmc blkdevice

 drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
 drivers/mmc/core/bus.c   |   14 ++++++++++++--
 drivers/mmc/core/core.h  |    2 ++
 drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
 4 files changed, 60 insertions(+), 4 deletions(-)

-- 
1.7.10

