From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH RESEND] mmc: sdhci-s3c: fix wrong error-control
Date: Wed, 12 Oct 2011 13:14:29 +0900
Message-ID: <4E951425.4000807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14159 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1JLEOz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 00:14:55 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSX00KPZQGU7VL0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Oct 2011 13:14:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSX00472QGU7E30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Oct 2011 13:14:54 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

If sc->clk_bus[ptr] is NULL, happen NULL pointer error.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 82709b6..3d00e72 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -567,8 +567,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
  err_req_regs:
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
-		clk_disable(sc->clk_bus[ptr]);
-		clk_put(sc->clk_bus[ptr]);
+		if (sc->clk_bus[ptr]) {
+			clk_disable(sc->clk_bus[ptr]);
+			clk_put(sc->clk_bus[ptr]);
+		}
 	}
 
  err_no_busclks:
-- 
1.7.4.1
