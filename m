From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v7 0/3] mmc: core: Support packed command feature of eMMC4.5
Date: Mon, 11 Jun 2012 17:22:54 +0900
Message-ID: <000501cd47ab$665923b0$330b6b10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31515 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2FKIW4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 04:22:56 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M5G00G321XI9CT0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Jun 2012 17:22:54 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M5G00BYQ1Y6WTO0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Jun 2012 17:22:54 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>

This patch-set adds support of packed command feature
for eMMC4.5 devices.

Changes in v7:
	- Change the condition for enabling packed command (from Venkatraman).
	- Break the endless execution in some error handling(from Maya Erez).
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


Seungwon Jeon (3):
      mmc: core: Add packed command feature of eMMC4.5
      mmc: core: Support packed write command for eMMC4.5 device
      mmc: core: Support packed read command for eMMC4.5 device

drivers/mmc/card/block.c   |  507 ++++++++++++++++++++++++++++++++++++++++++--
drivers/mmc/card/queue.c   |   49 ++++-
drivers/mmc/card/queue.h   |   13 ++
drivers/mmc/core/mmc.c     |   24 ++
drivers/mmc/core/mmc_ops.c |    1 +
include/linux/mmc/card.h   |    3 +
include/linux/mmc/core.h   |    4 +
include/linux/mmc/host.h   |    4 +
include/linux/mmc/mmc.h    |   15 ++
9 files changed, 594 insertions(+), 26 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


