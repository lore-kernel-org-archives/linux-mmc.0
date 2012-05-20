From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v1 0/1] block: Add test-iosched scheduler
Date: Sun, 20 May 2012 22:40:30 +0300
Message-ID: <1337542832-19810-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

The test scheduler allows testing a block device by dispatching
specific requests according to the test case and declare PASS/FAIL
according to the requests completion error code

Maya Erez (1):
  block: Add test-iosched scheduler

 Documentation/block/test-iosched.txt |   32 ++
 block/Kconfig.iosched                |    8 +
 block/Makefile                       |    1 +
 block/blk-core.c                     |    4 +-
 block/test-iosched.c                 |  966 ++++++++++++++++++++++++++++++++++
 5 files changed, 1010 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/block/test-iosched.txt
 create mode 100644 block/test-iosched.c

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
