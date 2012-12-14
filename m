From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/3] mmc: Signal voltage switch procedure for UHS mode (sdhci)
Date: Fri, 14 Dec 2012 18:53:55 +0800
Message-ID: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:54434 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753461Ab2LNKvV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 05:51:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com
Cc: per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com


This patchset is based on Johan's below patch series submitted recently:
  mmc: core: Add mmc_power_cycle
  mmc: core: Add card_busy to host_ops
  mmc: core: Fixup signal voltage switch

This patchset mainly update sdhci.c to co-work with Johan's above patches.
The first two patches are some update for the core stack with Johan's patch.
The third patch add the card_busy function and change the voltage_switch function in sdhci driver to work with the new code.

Kevin Liu (3):
 mmc: core: enhance the code for signal voltage setting
 mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid
 mmc: sdhci: update signal voltage switch code

 drivers/mmc/core/core.c  |   71 +++++++++++-------
 drivers/mmc/core/sd.c    |   16 +---
 drivers/mmc/host/sdhci.c |  188 +++++++++++++++++++---------------------------
 3 files changed, 125 insertions(+), 150 deletions(-)
