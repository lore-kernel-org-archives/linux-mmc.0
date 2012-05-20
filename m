From: Maya Erez <merez@codeaurora.org>
Subject: [RFC/PATCH] mmc: block: Add write packing control
Date: Sun, 20 May 2012 16:16:44 +0300
Message-ID: <1337519805-31919-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Our experiments showed that the write packing causes degradation of
the read throughput, in parallel read and write operations.
Since the read latency is critical for user experience we added a write
packing control mechanism that disables the write packing in case of read
requests.
This will ensure that read requests latency is not increased due to long write
packed commands.

The trigger for enabling the write packing is managing to pack several
write requests. The number of potential packed requests that will trigger
the packing can be configured via sysfs.
The trigger for disabling the write packing is a fetch of a read request.

this patch is dependant in the follwoing patches:
  [PATCH v6 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v6 2/3] mmc: core: Support packed write command for eMMC4.5 device

Maya Erez (1):
  mmc: block: Add write packing control

 drivers/mmc/card/block.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.c |    2 ++
 drivers/mmc/card/queue.h |    2 ++
 drivers/mmc/core/host.c  |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 ++++-
 5 files changed, 97 insertions(+), 1 deletions(-)

--
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
