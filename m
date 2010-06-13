From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 0/4] Add MMC erase and secure erase
Date: Sun, 13 Jun 2010 13:38:12 +0300
Message-ID: <4C14B514.4040405@nokia.com>
References: <4C14AC7E.6030308@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56471 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0FMKif (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jun 2010 06:38:35 -0400
In-Reply-To: <4C14AC7E.6030308@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kmpark@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

<Now with Jens Axboe correct email address>

Hi

Add ability to do MMC erase and secure erase operations from userspace,
using the BLKDISCARD ioctl and a newly created BLKSECDISCARD ioctl.

Changes from V1

- use discard I/O requests instead of implementing BLKDISCARD in mmc_block
- do not validate erase size for MMC erases, instead round to erase size
- rename MMC max_erase to pref_erase and expose it through sysfs as
"preferred_erase_size"

Adrian Hunter (4):
      block: Add BLKSECDISCARD
      mmc: Add erase, secure erase, trim and secure trim operations
      mmc_block: Add discard and secure discard support
      omap_hsmmc: Add erase capability

 block/compat_ioctl.c          |    1 +
 block/ioctl.c                 |    5 +
 drivers/mmc/card/block.c      |  125 +++++++++++++++-
 drivers/mmc/card/queue.c      |   16 ++-
 drivers/mmc/core/core.c       |  346 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h       |    2 +
 drivers/mmc/core/mmc.c        |   47 ++++++-
 drivers/mmc/core/sd.c         |   82 ++++++++++
 drivers/mmc/core/sd_ops.c     |   48 ++++++
 drivers/mmc/core/sd_ops.h     |    1 +
 drivers/mmc/host/omap_hsmmc.c |   13 ++-
 include/linux/fs.h            |    1 +
 include/linux/mmc/card.h      |   19 +++
 include/linux/mmc/core.h      |   19 +++
 include/linux/mmc/host.h      |    1 +
 include/linux/mmc/mmc.h       |   24 ++-
 include/linux/mmc/sd.h        |    5 +
 17 files changed, 742 insertions(+), 13 deletions(-)


Regards
Adrian


