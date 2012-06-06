From: Maya Erez <merez@codeaurora.org>
Subject: [RFC/PATCH 0/1] Add MMC write packing statistics
Date: Wed,  6 Jun 2012 09:16:26 +0300
Message-ID: <1338963389-3147-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

The write packing statistics are used for the packed commands unit tests
in order to determine test success or failure

this patch is dependant in the following patches:
  [PATCH v6 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v6 2/3] mmc: core: Support packed write command for eMMC4.5 device

Maya Erez (1):
  mmc: block: Add MMC write packing statistics

 drivers/mmc/card/block.c   |   56 +++++++++++++++-
 drivers/mmc/core/bus.c     |    4 +
 drivers/mmc/core/debugfs.c |  164 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c     |   18 +++++
 include/linux/mmc/card.h   |   24 +++++++
 5 files changed, 265 insertions(+), 1 deletions(-)

--
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
