From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v9 0/2] mmc: support packed command feature of eMMC4.5
Date: Wed, 06 Feb 2013 17:00:23 +0900
Message-ID: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50327 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3BFIAj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 03:00:39 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHS00B7YGW5GRP0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:00:24 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHS001L4GWN0S90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:00:24 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>, 'Arnd Bergmann' <arnd.bergmann@linaro.org>

This patch-set adds support of packed command feature for eMMC4.5 devices.
Specially, packed write is introduced.

Seeing the NAND flash, write is expensive operation including the block management internally.
Because write data cannot be overwritten on the NAND cell, additional operation is needed.
Overhead of the management can be reduced with once large write size rather than several data of small size.
That is when writing large amounts of data, eMMC gives a significant speed advantage.
Packed write can help it by gathering the data. Actually we got the performance gain.
For experiments, three eMMCs of different type from two vendor are used.

Additionally, there is a interesting result for packed read.
Packed read has been excluded from whole patch-set with a performance regression conclusively.
I found the reason for this regression. As we know, asynchronous transfer improves the performance
over than 20% for the read.  And I found that packed read actually gives performance gain of 2% 
only if asynchronous transfer is disabled. This shows that asynchronous transfer is more effective 
than packed read although packed read is a bit useful.

When several requests is packed for read, asynchronous transfer doesn't occur. That is packed read replaces
asynchronous transfer. Choice of packed read equals to the abandonment of asynchronous transfer.
This also means the abandonment of performance advantage. As a result, asynchronous transfer is currently
best choice regarding the read.

Changes in v9:
	- Rebase with the latest mmc.
	- Rework including reconstitution of data struct, on the whole.
	* Extend the number of blocks for packed header considering large sector (according to the eMMC 4.51)
	* Use flag of mmc_blk_data to identify permission of packed command.
	* Check the max commands strictly conforming to mandatory minimum values of spec.
	Note: These patch-set is dependant in the following patch.
	[PATCH 2/2] mmc: block: don't start new request when the card is removed
	
Changes in v8:
	- Ensure the alignment of sector size for native 4KB sector
	  in command packing(from Subhash Jadavani)
	- Exclude packed read in this phase due to performance issue.

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
	
drivers/mmc/card/block.c   |  454 ++++++++++++++++++++++++++++++++++++++++++--
drivers/mmc/card/queue.c   |   96 +++++++++-
drivers/mmc/card/queue.h   |   22 ++
drivers/mmc/core/mmc.c     |   28 +++
drivers/mmc/core/mmc_ops.c |    1 +
include/linux/mmc/card.h   |    8 +
include/linux/mmc/core.h   |    4 +
include/linux/mmc/host.h   |    9 +
include/linux/mmc/mmc.h    |   15 ++-
9 files changed, 618 insertions(+), 19 deletions(-)

Thanks,
Seungwon Jeon
--
1.7.2.3


