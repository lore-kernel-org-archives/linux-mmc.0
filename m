From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [RFC PATCH 0/5]mmc: Soft Command queue implementation for eMMC5.1
 device
Date: Fri, 19 Dec 2014 16:04:42 +0800
Message-ID: <20141219080442.GA3775@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18886 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbaLSIFv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Dec 2014 03:05:51 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

Seems community already have some implementation for the eMMC5.1 device command
queue feature, but that require the eMMC host controller to support CMDQ. In my
platform, I don't have this kind of eMMC host controller but I have a
Samsung eMMC5.1 device which can support the Command queue.

With this limitation, I have to let eMMC host controller to manually send the
CMD44/45/13/46/47. So in this way, more commands are needed for an I/O request,
more interrupts/schedule are needed in driver.

Even this way have some more software overhead, but it can still use the eMMC5.1
device Command queue feature. After test with the iozone command:
"iozone -zec -t 4 -i0 -i2 -F iozonefile1 iozonefile2 iozonefile3 iozonefile4 -+n
-I -r 4k -s 500m -O -R -+r -+D" to test random performance, I saw a performance
improvment for random read on my eMMC5.1 device:

		Random read
SW CMDQ:	5544.6
Normal Read:	3993.05

So I want to send this serial patches as RFC patch for reviewing


Chuanxiao Dong (5):
  mmc: replace sbc to precmd and add postcmd
  mmc: host: add runtime PM for host class dev
  mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
  mmc: core: add support for CMDQ feature in MMC Core stack
  mmc: sdhci: add SW CMDQ support for CHT SDHCI host

 drivers/mmc/card/block.c      |  538 ++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c      |  213 ++++++++--------
 drivers/mmc/card/queue.h      |   14 +-
 drivers/mmc/core/core.c       |   78 +++++-
 drivers/mmc/core/host.c       |   14 ++
 drivers/mmc/core/mmc.c        |   43 +++-
 drivers/mmc/host/dw_mmc.c     |    8 +-
 drivers/mmc/host/mmci.c       |   14 +-
 drivers/mmc/host/omap_hsmmc.c |   18 +-
 drivers/mmc/host/sdhci-acpi.c |    1 -
 drivers/mmc/host/sdhci-pci.c  |    1 -
 drivers/mmc/host/sdhci.c      |  137 +++++++++--
 include/linux/mmc/card.h      |    3 +
 include/linux/mmc/core.h      |    5 +-
 include/linux/mmc/host.h      |    5 +
 include/linux/mmc/mmc.h       |   21 ++
 include/linux/mmc/pm.h        |    1 +
 include/linux/mmc/sdhci.h     |    1 +
 18 files changed, 909 insertions(+), 206 deletions(-)

-- 
1.7.10.4
