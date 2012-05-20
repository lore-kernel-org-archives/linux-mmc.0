From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v1 0/1] mmc: block: Add write packing control
Date: Sun, 20 May 2012 22:10:33 +0300
Message-ID: <1337541034-11125-1-git-send-email-merez@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198]:54935 "EHLO
	lx-merez.qi.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756741Ab2ETTKz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 15:10:55 -0400
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
  [PATCH v6 1/3] mmc: core: Add packed command feature of eMMC4.5
  [PATCH v6 2/3] mmc: core: Support packed write command for eMMC4.5 device

Maya Erez (1):
  mmc: block: Add write packing control

 drivers/mmc/card/block.c |   44 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.c |    2 +
 drivers/mmc/card/queue.h |    2 +
 drivers/mmc/core/host.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 +++-
 5 files changed, 104 insertions(+), 1 deletions(-)

-- 
1.7.3.3
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

