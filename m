From: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Subject: [PATCH 0/2] mmc, block: override default max_dev_sectors
Date: Wed,  2 Mar 2016 09:54:15 +0100
Message-ID: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42189 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbcCBJAU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2016 04:00:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-block@vger.kernel.org
Cc: Mateusz Nowak <mateusz.nowak@intel.com>, linux-mmc@vger.kernel.org

From: Mateusz Nowak <mateusz.nowak@intel.com>

commit ca369d51b3e1 ("block/sd: Fix device-imposed transfer length limits")
introduced max_dev_sectors as upper limit for max_hw_sectors. This caused
limitation of maximum block size to default max_dev_sectors value - 127,
causing performance degradation with higher block sizes.

This patchset is allowing mmc driver to override max_dev_sectors value.

Cc: linux-mmc@vger.kernel.org
Mateusz Nowak (2):
  block: Allow to set max_dev_sectors for a queue.
  mmc/block: Override default max_dev_sectors.

 block/blk-settings.c     | 24 ++++++++++++++++++++++++
 drivers/mmc/card/queue.c | 10 ++++++++++
 include/linux/blkdev.h   |  1 +
 3 files changed, 35 insertions(+)

-- 
1.9.1

