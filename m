From: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] mmc: recognise SDIO cards with SDIO_CCCR_REV 3.00
Date: Thu, 20 Oct 2011 18:30:59 -0700
Message-ID: <1319160659-24221-1-git-send-email-bzhao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57336 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750709Ab1JUBrt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 21:47:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Bing Zhao <bzhao@marvell.com>

Table 6-2: CCCR bit Definitions, address 00h
Part E1 SDIO Simplified Specification Version 3.00
Feb. 25, 2011

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/mmc/core/sdio.c  |    2 +-
 include/linux/mmc/sdio.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 925bab0..3ab565e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -111,7 +111,7 @@ static int sdio_read_cccr(struct mmc_card *card)
 
 	cccr_vsn = data & 0x0f;
 
-	if (cccr_vsn > SDIO_CCCR_REV_1_20) {
+	if (cccr_vsn > SDIO_CCCR_REV_3_00) {
 		pr_err("%s: unrecognised CCCR structure version %d\n",
 			mmc_hostname(card->host), cccr_vsn);
 		return -EINVAL;
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 2a2e990..e0b1123 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -72,11 +72,13 @@
 #define  SDIO_CCCR_REV_1_00	0	/* CCCR/FBR Version 1.00 */
 #define  SDIO_CCCR_REV_1_10	1	/* CCCR/FBR Version 1.10 */
 #define  SDIO_CCCR_REV_1_20	2	/* CCCR/FBR Version 1.20 */
+#define  SDIO_CCCR_REV_3_00	3	/* CCCR/FBR Version 3.00 */
 
 #define  SDIO_SDIO_REV_1_00	0	/* SDIO Spec Version 1.00 */
 #define  SDIO_SDIO_REV_1_10	1	/* SDIO Spec Version 1.10 */
 #define  SDIO_SDIO_REV_1_20	2	/* SDIO Spec Version 1.20 */
 #define  SDIO_SDIO_REV_2_00	3	/* SDIO Spec Version 2.00 */
+#define  SDIO_SDIO_REV_3_00	4	/* SDIO Spec Version 3.00 */
 
 #define SDIO_CCCR_SD		0x01
 
-- 
1.7.4.1

