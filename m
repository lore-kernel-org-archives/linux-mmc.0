From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH 0/5] mmc: Soft Command queue implementation for eMMC5.1 device
Date: Tue, 17 Mar 2015 19:09:56 +0800
Message-ID: <20150317110955.GA17141@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8421 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932806AbbCQLLy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Mar 2015 07:11:54 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello

This serial of patches can implement the eMMC5.1 device command queue feature
even a host controller doesn't support CMDQ. Several weeks ago I submitted RFC
patches for review and collected some review comments. Right now these comments
are fixed thus I submit again as the offical patches. Please have a review.

Chuanxiao Dong (5):
  mmc: replace sbc to precmd and add postcmd
  mmc: host: add runtime PM for host class dev
  mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
  mmc: core: add support for CMDQ feature in MMC Core stack
  mmc: sdhci: add SW CMDQ support for SDHCI host

 drivers/mmc/card/block.c      |  538 ++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c      |  213 ++++++++--------
 drivers/mmc/card/queue.h      |   14 +-
 drivers/mmc/core/core.c       |   85 ++++++-
 drivers/mmc/core/host.c       |   13 +
 drivers/mmc/core/mmc.c        |   37 ++-
 drivers/mmc/host/dw_mmc.c     |    8 +-
 drivers/mmc/host/mmci.c       |   14 +-
 drivers/mmc/host/omap_hsmmc.c |   18 +-
 drivers/mmc/host/sdhci-acpi.c |    1 -
 drivers/mmc/host/sdhci-pci.c  |    1 -
 drivers/mmc/host/sdhci.c      |  137 +++++++++--
 drivers/mmc/host/sdhci.h      |    1 +
 include/linux/mmc/card.h      |    3 +
 include/linux/mmc/core.h      |    5 +-
 include/linux/mmc/host.h      |    5 +
 include/linux/mmc/mmc.h       |   21 ++
 include/linux/mmc/pm.h        |    1 +
 18 files changed, 911 insertions(+), 204 deletions(-)

