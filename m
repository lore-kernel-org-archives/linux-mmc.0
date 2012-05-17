From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v6 0/3] mmc: core: Support packed command feature of eMMC4.5
Date: Thu, 17 May 2012 18:38:36 +0900
Message-ID: <009c01cd3410$d5539c40$7ffad4c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29306 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158Ab2EQJii (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 05:38:38 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, merez@codeaurora.org, linux-kernel@vger.kernel.org

This patch-set adds support of packed command feature
for eMMC4.5 devices.

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


