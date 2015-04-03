From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [V2 PATCH 0/5] mmc: Soft Command queue implementation for eMMC5.1
 device
Date: Fri, 3 Apr 2015 19:25:05 +0800
Message-ID: <20150403112505.GA29880@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31542 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbDCL1N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Apr 2015 07:27:13 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alex.Lemberg@sandisk.com

Here are V2 version of eMMC5.1 soft command queue patches.

Performance data captured by iozone command shown it has improvment to both random read and random write. The command used is:
iozone -zec -t 4 -i0 -i2 -F iozonefile1 iozonefile2 iozonefile3 iozonefile4 -+n -I -r 4k -s 500m -O -R -+r -+D

		Without CMDQ	With CMDQ
Random read    	5074.91		7916.06
Random write   	1354.69		1444.52

Changes in V2:
1. not to send CMD13 during CMD46/47 is executing.
2. added a timer in case the data never complete for CMD46/47


Chuanxiao Dong (5):
  mmc: replace sbc to precmd and add postcmd
  mmc: host: add runtime PM for host class dev
  mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
  mmc: core: add support for CMDQ feature in MMC Core
  mmc: sdhci: add SW CMDQ support for SDHCI host

 drivers/mmc/card/block.c      |  561 ++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c      |  224 ++++++++--------
 drivers/mmc/card/queue.h      |   14 +-
 drivers/mmc/core/core.c       |   81 +++++-
 drivers/mmc/core/host.c       |   13 +
 drivers/mmc/core/mmc.c        |   37 ++-
 drivers/mmc/host/dw_mmc.c     |    8 +-
 drivers/mmc/host/mmci.c       |   14 +-
 drivers/mmc/host/omap_hsmmc.c |   18 +-
 drivers/mmc/host/sdhci-acpi.c |    1 -
 drivers/mmc/host/sdhci-pci.c  |    1 -
 drivers/mmc/host/sdhci.c      |  178 +++++++++++--
 drivers/mmc/host/sdhci.h      |    2 +
 include/linux/mmc/card.h      |    3 +
 include/linux/mmc/core.h      |    5 +-
 include/linux/mmc/host.h      |    4 +
 include/linux/mmc/mmc.h       |   21 ++
 include/linux/mmc/pm.h        |    1 +
 18 files changed, 980 insertions(+), 206 deletions(-)

-- 
1.7.10.4
