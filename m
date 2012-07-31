From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v5 0/3] mmc: card: Add eMMC4.5 write packed commands unit-tests
Date: Tue, 31 Jul 2012 17:25:07 +0300
Message-ID: <1343744710-31700-1-git-send-email-merez@codeaurora.org>
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

In order to test the eMMC4.5 features, the test-iosched is used.
The test scheduler allows testing a block device by dispatching
specific requests according to the test case and declare PASS/FAIL
according to the requests completion error code.
The write packed commands statistics are used to determine the success or failure of 
the packed commands tests, in addition to the generic request completion checking.

This patch is dependant in the following patches:
  [PATCH v8 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v8 2/3] mmc: core: Support packed write command for eMMC4.5 device

Changes in v5:
    - Code review fixes

Changes in v4:
    - Add large sector size alignment to the packed commands stop reason statistics
    - Fix error handling in test-iosched
    - Code review fixes

Changes in v3:
    - Fix the cancel round mechanism

Changes in v2:
    - Add MMC write packing statistics and test-iosched scheduler patches as part of this patch.
    - Code review fixes

Maya Erez (3):
  block: Add test-iosched scheduler
  mmc: block: Add MMC write packing statistics
  mmc: card: Add eMMC4.5 write packed commands unit-tests

 Documentation/block/test-iosched.txt |   39 +
 block/Kconfig.iosched                |   11 +
 block/Makefile                       |    1 +
 block/blk-core.c                     |    3 +-
 block/test-iosched.c                 | 1038 +++++++++++++++++++++++
 drivers/mmc/card/Kconfig             |   11 +
 drivers/mmc/card/Makefile            |    1 +
 drivers/mmc/card/block.c             |  139 +++-
 drivers/mmc/card/mmc_block_test.c    | 1522 ++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.h             |   15 +
 drivers/mmc/core/bus.c               |    4 +
 drivers/mmc/core/debugfs.c           |  176 ++++
 drivers/mmc/core/mmc.c               |   18 +
 include/linux/mmc/card.h             |   25 +
 include/linux/test-iosched.h         |  233 ++++++
 15 files changed, 3221 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/block/test-iosched.txt
 create mode 100644 block/test-iosched.c
 create mode 100644 drivers/mmc/card/mmc_block_test.c
 create mode 100644 include/linux/test-iosched.h

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
