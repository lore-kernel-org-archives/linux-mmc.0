From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH V2 0/3] Adding UHS support for dw_mmc driver
Date: Fri, 22 Aug 2014 19:17:49 +0530
Message-ID: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34974 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbaHVNsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Aug 2014 09:48:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dianders@google.com, dianders@chromium.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, javier.martinez@collabora.co.uk, a.kesavan@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

This series adds UHS support for dw_mmc driver.
Patch[1] reworks the handling of vmmc and vqmmc regulators by mmc core 
regulator API's.

Patch[2] was taken from chrome tree originally developed by Doug Anderson.
Comments recieved for this patch to remove extra state machine for CMD11
handling is dropped since it's very much required to set the 
SDMMC_CMD_VOLT_SWITCH bit(28) for the proper working of clock update after 
the first VOLT_SWITCH interrupt occurs during the voltage switch scenario.
Though its not mentioned in Synopsys data book, its essential to complete
the voltage switchingi sequence.  

Patch[3] handles the case where in some boards uses built-in CD line for
card detection and connected to a same voltage domain as of the IO rails.
This version adds the changes for the concerned expressed by Doug Anderson
in prevoius version.

Doug Anderson (1):
 [2].mmc: dw_mmc: Support voltage changes

Yuvaraj Kumar C D (2):
 [1]. mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
 [3]. mmc: dw_mmc: Dont cut off vqmmc and vmmc

 drivers/mmc/core/core.c          |   16 ++-
 drivers/mmc/core/debugfs.c       |    3 +
 drivers/mmc/host/dw_mmc-exynos.c |   12 ++
 drivers/mmc/host/dw_mmc.c        |  231 ++++++++++++++++++++++++++++++--------
 drivers/mmc/host/dw_mmc.h        |    7 +-
 include/linux/mmc/dw_mmc.h       |    4 +-
 include/linux/mmc/host.h         |    2 +
 7 files changed, 225 insertions(+), 50 deletions(-)

-- 
1.7.10.4

