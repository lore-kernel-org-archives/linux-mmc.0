From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v3 0/3] mmc: card: Add eMMC4.5 write packed commands unit-tests
Date: Sat, 30 Jun 2012 11:43:33 +0300
Message-ID: <1341045816-10810-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <n>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Expose the following packed commands tests:
- Test the write packed commands list preparation
- Simulate a returned error code
- Send an invalid packed command to the card

This patch is dependant in the following patches:
  [PATCH v8 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v8 2/3] mmc: core: Support packed write command for eMMC4.5 device

Changes in v3:
    - Fix the cancel round mechanism

Changes in v2:
    - Add MMC write packing statistics and test-iosched scheduler patches as part of this patch.
    - Code review fixes

Maya Erez (3):
  mmc: block: Add MMC write packing statistics
  block: Add test-iosched scheduler
  mmc: card: Add eMMC4.5 write packed commands unit-tests

 Documentation/block/test-iosched.txt |   39 +
 block/Kconfig.iosched                |   11 +
 block/Makefile                       |    1 +
 block/blk-core.c                     |    3 +-
 block/test-iosched.c                 | 1020 +++++++++++++++++++++++
 drivers/mmc/card/Kconfig             |   11 +
 drivers/mmc/card/Makefile            |    1 +
 drivers/mmc/card/block.c             |  138 +++-
 drivers/mmc/card/mmc_block_test.c    | 1469 ++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.h             |   15 +
 drivers/mmc/core/bus.c               |    4 +
 drivers/mmc/core/debugfs.c           |  169 ++++
 drivers/mmc/core/mmc.c               |   18 +
 include/linux/mmc/card.h             |   24 +
 include/linux/test-iosched.h         |  233 ++++++
 15 files changed, 3141 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/block/test-iosched.txt
 create mode 100644 block/test-iosched.c
 create mode 100644 drivers/mmc/card/mmc_block_test.c
 create mode 100644 include/linux/test-iosched.h

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
