From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/4] mmc: rename ddr to uhs in ios structure to indicate
 usage
Date: Sun, 13 Feb 2011 23:16:15 -0800
Message-ID: <D29CB24F-7E04-4B4B-8B73-954AC55A5BA3@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33789 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab1BNHUS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:20:18 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


uhs mode comprises dual data rate, single data rate options
such as ddr_1_8v as well as sdr50 and sdr104
ddr name changed to indicate its true usage

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c  |    2 +-
 include/linux/mmc/host.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d9fb0d3..37e66d3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -718,7 +718,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr)
 {
 	host->ios.bus_width = width;
-	host->ios.ddr = ddr;
+	host->ios.uhs = ddr;
 	mmc_set_ios(host);
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..f11307e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -51,7 +51,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_HS	1
 #define MMC_TIMING_SD_HS	2
 
-	unsigned char	ddr;			/* dual data rate used */
+	unsigned char	uhs;			/* uhs mode used (ddr - sdr) */
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
-- 
1.7.0.4


