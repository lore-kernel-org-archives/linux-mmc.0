Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158DC2D0C9
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55E2214D8
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfLLHxL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:53:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57080 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbfLLHxL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Dec 2019 02:53:11 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C041D20014C;
        Thu, 12 Dec 2019 08:53:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 931E42006B7;
        Thu, 12 Dec 2019 08:53:06 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 80877402CF;
        Thu, 12 Dec 2019 15:53:03 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/2] mmc: sdhci-of-esdhc: update tuning erratum A-008171
Date:   Thu, 12 Dec 2019 15:52:19 +0800
Message-Id: <20191212075219.48625-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212075219.48625-1-yangbo.lu@nxp.com>
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is an official update for eSDHC tuning erratum A-008171.
This patch is to implement the changes,
- Affect all revisions of SoC.
- Changes for tuning window checking.
- Hardware hits a new condition that tuning succeeds although
  the eSDHC might not have tuned properly for type2 SoCs
  (soc_tuning_erratum_type2[] array in driver). So check
  tuning window after tuning succeeds.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index cd0f21e..a99c000d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -848,20 +848,20 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
 }
 
 static struct soc_device_attribute soc_tuning_erratum_type1[] = {
-	{ .family = "QorIQ T1023", .revision = "1.0", },
-	{ .family = "QorIQ T1040", .revision = "1.0", },
-	{ .family = "QorIQ T2080", .revision = "1.0", },
-	{ .family = "QorIQ LS1021A", .revision = "1.0", },
+	{ .family = "QorIQ T1023", },
+	{ .family = "QorIQ T1040", },
+	{ .family = "QorIQ T2080", },
+	{ .family = "QorIQ LS1021A", },
 	{ },
 };
 
 static struct soc_device_attribute soc_tuning_erratum_type2[] = {
-	{ .family = "QorIQ LS1012A", .revision = "1.0", },
-	{ .family = "QorIQ LS1043A", .revision = "1.*", },
-	{ .family = "QorIQ LS1046A", .revision = "1.0", },
-	{ .family = "QorIQ LS1080A", .revision = "1.0", },
-	{ .family = "QorIQ LS2080A", .revision = "1.0", },
-	{ .family = "QorIQ LA1575A", .revision = "1.0", },
+	{ .family = "QorIQ LS1012A", },
+	{ .family = "QorIQ LS1043A", },
+	{ .family = "QorIQ LS1046A", },
+	{ .family = "QorIQ LS1080A", },
+	{ .family = "QorIQ LS2080A", },
+	{ .family = "QorIQ LA1575A", },
 	{ },
 };
 
@@ -929,13 +929,13 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
 	/* Write 32'hFFFF_FFFF to IRQSTAT register */
 	sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
 
-	/* If TBSTAT[15:8]-TBSTAT[7:0] > 4 * div_ratio
-	 * or TBSTAT[7:0]-TBSTAT[15:8] > 4 * div_ratio,
+	/* If TBSTAT[15:8]-TBSTAT[7:0] > (4 * div_ratio) + 2
+	 * or TBSTAT[7:0]-TBSTAT[15:8] > (4 * div_ratio) + 2,
 	 * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
 	 * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
 	 */
 
-	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
+	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio + 2)) {
 		*window_start = 8 * esdhc->div_ratio;
 		*window_end = 4 * esdhc->div_ratio;
 	} else {
@@ -1008,6 +1008,19 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (ret)
 			break;
 
+		/* For type2 affected platforms of the tuning erratum,
+		 * tuning may succeed although eSDHC might not have
+		 * tuned properly. Need to check tuning window.
+		 */
+		if (esdhc->quirk_tuning_erratum_type2 &&
+		    !host->tuning_err) {
+			esdhc_tuning_window_ptr(host, &window_start,
+						&window_end);
+			if (abs(window_start - window_end) >
+			    (4 * esdhc->div_ratio + 2))
+				host->tuning_err = -EAGAIN;
+		}
+
 		/* If HW tuning fails and triggers erratum,
 		 * try workaround.
 		 */
-- 
2.7.4

