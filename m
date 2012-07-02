From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v4 0/1] mmc: block: Add write packing control
Date: Mon,  2 Jul 2012 15:15:35 +0300
Message-ID: <1341231337-6921-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198]:55763 "EHLO
	lx-merez.qi.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750803Ab2GBMPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 08:15:49 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>

Our experiments showed that the write packing causes degradation of the read
throughput, in parallel read and write operations.
Since the read latency is critical for user experience we added a write packing control
mechanism that disables the write packing in case of read requests.
This will ensure that read requests latency is not increased due to long write packed commands.

The trigger for enabling the write packing is managing to pack several write requests.
The number of potential packed requests that will trigger the packing can be configured via sysfs.
The trigger for disabling the write packing is a fetch of a read request.

this patch is dependant in the following patches:
  [PATCH v8 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v8 2/3] mmc: core: Support packed write command for eMMC4.5 device

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
