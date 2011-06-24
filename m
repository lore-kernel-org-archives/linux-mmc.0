From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/6] mmc: dw_mmc: misc fixes and improvements
Date: Fri, 24 Jun 2011 13:52:57 +0100
Message-ID: <4E0488A9.6050109@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:2150 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab1FXNJE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Jun 2011 09:09:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.c>
Cc: james@albanarts.com

Misc improvements and fixes for the Synopsys DesignWare MMC driver:

[PATCH 1/6] mmc: dw_mmc: clear TXDR/RXDR ints before enabling
	fixes a failure to probe the next card after an unplug
[PATCH 2/6] mmc: dw_mmc: fix race with request and removal
	improves spinlock protection
[PATCH 3/6] mmc: dw_mmc: convert card tasklet to workqueue
	to allow platform callbacks to sleep
[PATCH 4/6] mmc: dw_mmc: brackets in register access macros
	just a small tidyup patch
[PATCH 5/6] mmc: dw_mmc: don't hard code fifo depth, fix usage
	improve detection of fifo depth
[PATCH 6/6] mmc: dw_mmc: handle unaligned buffers and sizes
	fix some mmc_test failures wrt unaligned buffer/sizes
 
 drivers/mmc/host/dw_mmc.c  |  398 ++++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/dw_mmc.h  |   17 +-
 include/linux/mmc/dw_mmc.h |   20 ++-
 3 files changed, 340 insertions(+), 95 deletions(-)

