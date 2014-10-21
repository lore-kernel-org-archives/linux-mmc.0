From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 00/15] mmc: core: Cleanup code related to EXT_CSD register
Date: Tue, 21 Oct 2014 19:18:58 +0200
Message-ID: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:58114 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbaJURTT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:19 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so1429599lab.21
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Cleanup and simplify code, which handles fetch and decode of the EXT_CSD
register.


Ulf Hansson (15):
  mmc: core: Remove mmc_free_ext_csd()
  mmc: core: Remove duplicated definition of mmc_send_ext_csd()
  mmc: core: Remove redundant check while selecting powerclass
  mmc: core: Remove redundant check of max_dtr while selecting timings
  mmc: core: Remove unnecessary 'out of memory' message
  mmc: core: Add helper function for EXT_CSD support
  mmc: core: Fetch and decode EXT_CSD from mmc_read_ext_csd()
  mmc: core: Let's callers of from mmc_get_ext_csd() do error handling
  mmc: core: Don't panic when fetching EXT_CSD
  mmc: core: Export mmc_get_ext_csd()
  mmc: block: Use mmc_get_ext_csd() instead of mmc_send_ext_csd()
  mmc: core: Use mmc_get_ext_csd() instead of mmc_send_ext_csd()
  mmc: core: Remove the redundant mmc_send_ext_csd() API
  mmc: core: Don't handle buffers on stack while fetching CXD registers
  mmc: core: Convert to use kzalloc() for CXD register buffers

 drivers/mmc/card/block.c   |  13 +----
 drivers/mmc/core/core.c    |  17 +-----
 drivers/mmc/core/debugfs.c |   9 +--
 drivers/mmc/core/mmc.c     | 141 ++++++++++++++-------------------------------
 drivers/mmc/core/mmc_ops.c |  61 +++++++++++---------
 drivers/mmc/core/mmc_ops.h |   2 +-
 include/linux/mmc/core.h   |   2 +-
 7 files changed, 86 insertions(+), 159 deletions(-)

-- 
1.9.1

