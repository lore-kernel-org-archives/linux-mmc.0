From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH RESEND v4 0/2] mmc: block: Add write packing control
Date: Sat, 14 Jul 2012 21:46:51 +0300
Message-ID: <1342291613-3189-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <n>
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

Changes in v4:
    - Move MMC specific attributes to mmc sub-directory

Changes in v3:
    - Fix the settings of num_of_potential_packed_wr_reqs

Changes in v2:
    - Move the attribute for setting the packing enabling trigger to the block device
    - Add documentation of the new attribute

Maya Erez (2):
  mmc: card: Move MMC specific attributes to mmc sub-directory
  mmc: block: Add write packing control

 Documentation/mmc/mmc-dev-attrs.txt |   17 ++++
 drivers/mmc/card/block.c            |  176 +++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.c            |    8 ++
 drivers/mmc/card/queue.h            |    3 +
 include/linux/mmc/host.h            |    1 +
 5 files changed, 197 insertions(+), 8 deletions(-)

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
