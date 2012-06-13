From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v3 0/1] mmc: block: Add write packing control
Date: Wed, 13 Jun 2012 22:37:15 +0300
Message-ID: <1339616240-27361-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Our experiments showed that the write packing causes degradation of the read
throughput, in parallel read and write operations.
Since the read latency is critical for user experience we added a write packing control
mechanism that disables the write packing in case of read requests.
This will ensure that read requests latency is not increased due to long write packed commands.

The trigger for enabling the write packing is managing to pack several write requests.
The number of potential packed requests that will trigger the packing can be configured via sysfs.
The trigger for disabling the write packing is a fetch of a read request.

this patch is dependant in the following patches:
  [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v7 2/3] mmc: core: Support packed write command for eMMC4.5 device

Changes in v3:
    - Fix the settings of num_of_potential_packed_wr_reqs

Changes in v2:
    - Move the attribute for setting the packing enabling trigger to the block device
    - Add documentation of the new attribute

Maya Erez (1):
  mmc: block: Add write packing control

 Documentation/mmc/mmc-dev-attrs.txt |   17 ++++++
 drivers/mmc/card/block.c            |  101 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/card/queue.c            |    8 +++
 drivers/mmc/card/queue.h            |    3 +
 include/linux/mmc/host.h            |    1 +
 5 files changed, 129 insertions(+), 1 deletions(-)

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
