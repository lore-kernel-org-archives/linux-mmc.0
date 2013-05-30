From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/4] mmc: core: Let the mmc_bus handle suspend|resume sequence
Date: Thu, 30 May 2013 14:53:07 +0200
Message-ID: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:59745 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754551Ab3E3Mxe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 08:53:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The MMC/SD/SDIO cards are registered on the mmc_bus and should from a power
management perspective be controlled from there. As of today each and every
host driver needs to issue mmc_suspend|resume_host from their respective
.suspend|resume methods, which seems like an unnecessary requirement to
put on them.

This patch set moves the responsiblity to suspend the cards into the mmc_bus.
In this patch set, the mmc_suspend|resume_host functions are not removed, but
will instead always return successful. As a separate patch build on top of
this patch set, we shall remove the API:s together with updating each and
every host driver.

Ulf Hansson (4):
  mmc: core: Remove unnecessary check for the remove callback
  mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
  mmc: core: Push common suspend|resume code into each bus_ops
  mmc: core: Initiate suspend|resume from mmc bus instead of mmc host

 drivers/mmc/core/bus.c  |   28 ++++++++++++++-
 drivers/mmc/core/core.c |   87 ++++++++---------------------------------------
 drivers/mmc/core/core.h |    1 +
 drivers/mmc/core/mmc.c  |    4 +++
 drivers/mmc/core/sd.c   |    4 +++
 drivers/mmc/core/sdio.c |   48 +++++++++++++++++++++++---
 6 files changed, 94 insertions(+), 78 deletions(-)

-- 
1.7.10

