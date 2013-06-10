From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 00/12] mmc: core: mmc_bus to handle suspend|resume|shutdown
Date: Mon, 10 Jun 2013 17:03:35 +0200
Message-ID: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:59218 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752854Ab3FJPEL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The MMC/SD/SDIO cards are registered on the mmc_bus and should from a power
management perspective be controlled from there. As of today each and every
host driver needs to issue mmc_suspend|resume_host from their respective
.suspend|resume methods, which seems like an unnecessary requirement to
put on them. Additionally, a shutdown sequence shall be initiated from the
mmc_bus.

This patch set moves the responsiblity to suspend the cards into the mmc_bus.
It also invents the shutdown sequence, also to be handled from the mmc_bus.
In the SDIO case, the shutdown sequence will not involve any SDIO specific
operations. If this would be desired, I suggest to handle that as and separate
step, since it would involve the sdio bus and potentially the sdio drivers.

As a part of the patches releated to adding the shutdown sequence, specific
issues to handle eMMC power off notification properly are included in this
patch set as well.

The mmc_suspend|resume_host functions are not removed, but will instead always
return successful. A separate patch(es) build on top of this patch set, shall
remove the API:s together with updating each and every host driver.

Do note, that patch 1 to 4 has been sent earlier in the set "mmc: core: Let the
mmc_bus handle suspend|resume sequence". Since the functionallity are very close
releated I decided to fold them in into this patch set.

A big thank you to Jaehoon Chung who has tested the patches 1 to 4.

Ulf Hansson (12):
  mmc: core: Remove unnecessary check for the remove callback
  mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
  mmc: core: Push common suspend|resume code into each bus_ops
  mmc: core: Initiate suspend|resume from mmc bus instead of mmc host
  mmc: core: Handle card shutdown from mmc_bus
  mmc: core: Extend shutdown sequence to handle bus operations
  mmc: core: Add shutdown callback for SD bus_ops
  mmc: core: Handle both poweroff notification types for eMMC
  mmc: core: Add shutdown callback for (e)MMC bus_ops
  mmc: core: Enable power_off_notify for eMMC shutdown sequence
  mmc: core: Invent MMC_CAP2_FULL_PWR_CYCLE
  mmc: core: Add DT-bindings for MMC_CAP2_FULL_PWR_CYCLE

 Documentation/devicetree/bindings/mmc/mmc.txt |    1 +
 drivers/mmc/card/block.c                      |   15 ++++-
 drivers/mmc/card/mmc_test.c                   |    5 ++
 drivers/mmc/core/bus.c                        |   37 ++++++++++-
 drivers/mmc/core/core.c                       |   87 ++++---------------------
 drivers/mmc/core/core.h                       |    2 +
 drivers/mmc/core/host.c                       |    2 +
 drivers/mmc/core/mmc.c                        |   40 +++++++++---
 drivers/mmc/core/sd.c                         |    6 ++
 drivers/mmc/core/sdio.c                       |   48 ++++++++++++--
 include/linux/mmc/card.h                      |    1 +
 include/linux/mmc/host.h                      |    2 +-
 12 files changed, 153 insertions(+), 93 deletions(-)

-- 
1.7.10

