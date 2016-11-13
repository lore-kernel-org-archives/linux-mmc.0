From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] mmc: tmio: remove SDIO from TODO list
Date: Sun, 13 Nov 2016 15:29:12 +0100
Message-ID: <20161113142912.4041-3-wsa+renesas@sang-engineering.com>
References: <20161113142912.4041-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46121 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbcKMO3Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 13 Nov 2016 09:29:24 -0500
In-Reply-To: <20161113142912.4041-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

We surely have SDIO support by now :)

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2b04e6e87192c7..87fea67a743674 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -22,7 +22,6 @@
  * TODO:
  *   Investigate using a workqueue for PIO transfers
  *   Eliminate FIXMEs
- *   SDIO support
  *   Better Power management
  *   Handle MMC errors better
  *   double buffer support
-- 
2.9.3

