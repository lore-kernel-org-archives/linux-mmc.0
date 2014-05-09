From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 0/6] mmc: omap_hsmmc: convert to use devm_* and fixes
Date: Fri, 9 May 2014 22:16:47 +0530
Message-ID: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37611 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbaEIQq5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 12:46:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

v2:
use devm_ioremap_resource
add cmd23 multiblock read/write fix

Balaji T K (6):
  mmc: omap_hsmmc: use devm_clk_get
  mmc: omap_hsmmc: use devm_request_irq
  mmc: omap_hsmmc: use devm_request_threaded_irq
  mmc: omap_hsmmc: use devm_ioremap_resource
  mmc: omap_hsmmc: fix cmd23 multiblock read/write
  mmc: omap_hsmmc: split omap-dma header file

 drivers/mmc/host/omap_hsmmc.c  |   57 ++++++++++++---------------------------
 include/linux/omap-dma.h       |   19 +------------
 include/linux/omap-dmaengine.h |   21 ++++++++++++++
 3 files changed, 40 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/omap-dmaengine.h

-- 
1.7.5.4

