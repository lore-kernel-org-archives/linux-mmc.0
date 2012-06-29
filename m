From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v8 0/2] mmc: support packed command feature of eMMC4.5
Date: Fri, 29 Jun 2012 13:31:44 +0900
Message-ID: <006701cd55b0$168c2220$43a46660$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44873 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2F2Ebq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 00:31:46 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6D001EI38WM670@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jun 2012 13:31:45 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6D00M2S38WXE40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jun 2012 13:31:44 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

This patch-set adds support of packed command feature
for eMMC4.5 devices.

Changes in v8:
	- Ensure the alignment of sector size for native 4KB sector
	  in command packing(from Subhash Jadavani)
	- Exclude the packed read in this phase due to performance issue.

Changes in v7:
	- Break the endless execution in some error handling(from Maya Erez).
	- Change the condition for enabling packed command(from Subhash Jadavani).
	- Spilt the error related routine from mmc_blk_issue_rw_rq.

Changes in v6:
	- Split the patch for packed read.
	- Remove the unnecessary code. 

Changes in v5:
	- Revert "Add a variable member in mmc_host for minimum number of packed entries".
	- Fix the partial packed command from failure index.
	- Clean an unnecessary parameter of mmc_blk_packed_hdr_wrq_prep 
	- Clean warning of checkpatch.

Changes in v4:
	- Add Data-tag as CMD23 argument for packed header.
	- Separate the capability of MMC_CAP2_PACKED_CMD into read and write.
	- Remove unncessary initial value.

Changes in v3:
	- Add a variable member in mmc_host for minimum number of packed entries.
	  This value can be overridden by host.
	- Fix a handling of error sequence.

Changes in v2:
	- Fix the packed read sequence and error handling.
	- Apply checking the exception status for all cases with
	  the comments from Maya Erez and Sahitya Tummala.
	- Fix preparing the packed list with the comment from Maya Erez and Venkatraman.

Seungwon Jeon (2):
      mmc: add packed command feature of eMMC4.5
      mmc: support packed write command for eMMC4.5 device

 drivers/mmc/card/block.c   |  394 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.c   |   45 +++++-
 drivers/mmc/card/queue.h   |   12 ++
 drivers/mmc/core/mmc.c     |   25 +++
 drivers/mmc/core/mmc_ops.c |    1 +
 include/linux/mmc/card.h   |    8 +
 include/linux/mmc/core.h   |    4 +
 include/linux/mmc/host.h   |    4 +
 include/linux/mmc/mmc.h    |   15 ++
9 files changed, 491 insertions(+), 17 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


