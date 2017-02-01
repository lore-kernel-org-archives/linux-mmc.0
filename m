From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/10] Further MMC core/block cleanups
Date: Wed,  1 Feb 2017 13:47:50 +0100
Message-ID: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35713 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBAMsc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:48:32 -0500
Received: by mail-lf0-f45.google.com with SMTP id n124so227400162lfd.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:48:32 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This is a continuation of the series merged to start cleaning
up the very big mmc_blk_issue_rw_rq() and friends.

Again the goal is to get the code in a shape such that I can
get rid of flusing the pipeline with NULLs and report the
requests as finished directly to the block layer, without
having to wait for an iteration of mmc_blk_issue_req() to
happen before they get postprocessed and finished.

Feel free to apply this partially, or defer it all to after
v4.11-rc1 *NO*RUSH*.

It is just my idead of a cleanup road toward blk MQ
compliance. I think most patches stand on their own but can
be perceived as over-pedantic without that context.

Linus Walleij (10):
  mmc: block: inline the command abort and start new goto:s
  mmc: block: rename rqc and req
  mmc: core: rename mmc_start_req() to *areq()
  mmc: block: refactor mmc_blk_rw_try_restart()
  mmc: block: rename mmc_active to areq
  mmc: queue: turn queue flags into bools
  mmc: block: return errorcode from mmc_sd_num_wr_blocks()
  mmc: block: respect bool returned from blk_end_request()
  mmc: block: return 0 where evident
  mmc: core: start to break apart mmc_start_areq()

 drivers/mmc/core/block.c    | 179 ++++++++++++++++++++++++--------------------
 drivers/mmc/core/core.c     |  79 ++++++++++++-------
 drivers/mmc/core/mmc_test.c |   8 +-
 drivers/mmc/core/queue.c    |  12 +--
 drivers/mmc/core/queue.h    |   7 +-
 include/linux/mmc/core.h    |   2 +-
 6 files changed, 163 insertions(+), 124 deletions(-)

-- 
2.9.3

