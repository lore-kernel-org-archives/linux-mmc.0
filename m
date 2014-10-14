From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/7] mmc: Cleanup and modernize PM callbacks
Date: Tue, 14 Oct 2014 13:45:13 +0200
Message-ID: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65476 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so8020965lbv.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

This patchset cleanup and modernize how to set up PM callbacks for the
mmc_driver in the mmc core. There shouldn't be any functional changes.


Ulf Hansson (7):
  mmc: core: Remove superfluous ifdefs for SDIO bus' PM callbacks
  mmc: core: Don't export the to_sdio_driver macro
  mmc: core: Convert the mmc_driver to use the modern PM ops
  mmc: core: Convert mmc_driver to device_driver
  mmc: msm_sdcc: Use platform_set|get_drvdata
  mmc: block: Use dev_set|get_drvdata()
  mmc: core: Remove unused mmc_list_to_card() macro

 drivers/mmc/card/block.c      | 55 ++++++++++++++++++++++---------------------
 drivers/mmc/card/mmc_test.c   | 18 ++++++++------
 drivers/mmc/core/bus.c        | 55 ++++++++++---------------------------------
 drivers/mmc/core/sdio_bus.c   | 14 +++--------
 drivers/mmc/host/msm_sdcc.c   |  6 ++---
 include/linux/mmc/card.h      | 20 ++--------------
 include/linux/mmc/sdio_func.h |  2 --
 7 files changed, 59 insertions(+), 111 deletions(-)

-- 
1.9.1

