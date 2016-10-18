From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 0/8] Attempt to clean up BUG_ONs for mmc-tree
Date: Tue, 18 Oct 2016 20:03:12 +0800
Message-ID: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:58900 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbcJRL5t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:57:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


We have already removed some BUG_ONs recently[0][1], however there
are still many pointless BUG_ONs for mmc core. So this patchset is
going on removing these BUG_ONs from drivers/mmc/core/* and drivers/mmc/card/*.
It is also possible for us to remove it from drivers/mmc/host/* in the future.

No functional changes intented in theory, except for adding some error
handle, but I held it for a while in order to test it fully and decided
to send it after the merge window of 4.9.

Please review and comment. :)

[0]: https://patchwork.kernel.org/patch/9300739/
[1]: https://patchwork.kernel.org/patch/9300741/



Shawn Lin (8):
  mmc: core: remove BUG_ONs from sdio
  mmc: debugfs: remove BUG_ON from mmc_ext_csd_open
  mmc: core: remove BUG_ONs from mmc
  mmc: core: remove BUG_ONs from sd
  mmc: core: remove BUG_ONs from core.c
  mmc: sdio_uart: remove meaningless BUG_ON
  mmc: queue: remove BUG_ON for bounce_sg
  mmc: mmc_test: remove BUG_ONs and deploy error handling

 drivers/mmc/card/mmc_test.c  | 12 ++++++++----
 drivers/mmc/card/queue.c     |  2 --
 drivers/mmc/card/sdio_uart.c |  2 --
 drivers/mmc/core/core.c      | 40 ++++++++++++++--------------------------
 drivers/mmc/core/debugfs.c   |  6 +++++-
 drivers/mmc/core/mmc.c       | 24 ++++++++++++++----------
 drivers/mmc/core/mmc_ops.c   | 20 ++++++--------------
 drivers/mmc/core/sd.c        | 20 +++++++++-----------
 drivers/mmc/core/sd_ops.c    | 30 ++++++++++--------------------
 drivers/mmc/core/sdio.c      | 26 ++++++++++++++------------
 drivers/mmc/core/sdio_cis.c  |  3 ++-
 drivers/mmc/core/sdio_irq.c  | 12 +++++++-----
 12 files changed, 89 insertions(+), 108 deletions(-)

-- 
2.3.7


