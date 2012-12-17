From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2 0/3] mmc: Signal voltage switch procedure for UHS mode (sdhci)
Date: Mon, 17 Dec 2012 15:50:24 +0800
Message-ID: <1355730627-8751-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58902 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab2LQHux (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 02:50:53 -0500
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

changelog v1->v2:
	- patch1: update the check for host->ops->start_signal_voltage_switch
	- patch1: change the parameter for start_signal_voltage_switch from ios to signal_voltage
	- patch1: update ios after voltage change success
	- patch3: add pm runtime protection for card_busy
	- add Test-by

Kevin Liu (3):
 mmc: core: enhance the code for signal voltage setting
 mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid
 mmc: sdhci: update signal voltage switch code

 drivers/mmc/core/core.c  |   77 +++++++++++-------
 drivers/mmc/core/sd.c    |   16 +---
 drivers/mmc/host/sdhci.c |  194 +++++++++++++++++++---------------------------
 include/linux/mmc/host.h |    2 +-
 4 files changed, 134 insertions(+), 155 deletions(-)
