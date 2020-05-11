Return-Path: <SRS0=e9Nt=6Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8AAC47255
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696D9207DD
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uSuUlZR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgEKGaZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 May 2020 02:30:25 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:64257 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgEKGaY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2020 02:30:24 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04B6SiJ4024114;
        Mon, 11 May 2020 15:28:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04B6SiJ4024114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589178525;
        bh=UZ9iiUxPKBmS0Mn31e7Z5LXfKunX+kDfVEaBQd1XIlg=;
        h=From:To:Cc:Subject:Date:From;
        b=uSuUlZR12aW+cvaMThllo+l65i/jh1c6+2jL1BLJwgQVM4KfqexvMG5ymvOeyCH2k
         WJnDjgmDDjvHX6yettUn7zWfG7eMZgwpZcLHyLJ9cQ+1LrKYETAfIbfmNIZWPNSekp
         QekYq6dyw3NHR5L/nWmvYA+WP3J35giy7wOibU93C+Scdd8NtzAUFtezZEVnAq715O
         awaBlks8RzY4Vv84+fOlJxCITct7lik2PpypQPcuQd2fH2HbAgPqMYfhP95+2mgWp/
         JmCTpehBKpHWCJSGMdsYMo/JAuBjuZaaGfknapx0o2KfUTbIFNayKHwonyUW/5I3IY
         n0BxULFplT3ZA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci: use FIELD_GET/PREP for current capabilities bit masks
Date:   Mon, 11 May 2020 15:28:27 +0900
Message-Id: <20200511062828.1791484-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use FIELD_GET and FIELD_PREP to get access to the register fields. Delete
the shift macros and use GENMASK() for the touched macros.

Note that, this has the side-effect of changing the constants to 64-bit on
64-bit platforms.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-esdhc-imx.c |  6 +++---
 drivers/mmc/host/sdhci.c           | 27 ++++++++++++---------------
 drivers/mmc/host/sdhci.h           | 11 ++++-------
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 38cd83118082..9896e03fce71 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -419,9 +419,9 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 
 	if (unlikely(reg == SDHCI_MAX_CURRENT) && esdhc_is_usdhc(imx_data)) {
 		val = 0;
-		val |= 0xFF << SDHCI_MAX_CURRENT_330_SHIFT;
-		val |= 0xFF << SDHCI_MAX_CURRENT_300_SHIFT;
-		val |= 0xFF << SDHCI_MAX_CURRENT_180_SHIFT;
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_330_MASK, 0xFF);
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_300_MASK, 0xFF);
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_180_MASK, 0xFF);
 	}
 
 	if (unlikely(reg == SDHCI_INT_STATUS)) {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 344a7e0e33fe..7818e650f974 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4355,35 +4355,32 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
 			max_current_caps =
-				(curr << SDHCI_MAX_CURRENT_330_SHIFT) |
-				(curr << SDHCI_MAX_CURRENT_300_SHIFT) |
-				(curr << SDHCI_MAX_CURRENT_180_SHIFT);
+				FIELD_PREP(SDHCI_MAX_CURRENT_330_MASK, curr) |
+				FIELD_PREP(SDHCI_MAX_CURRENT_300_MASK, curr) |
+				FIELD_PREP(SDHCI_MAX_CURRENT_180_MASK, curr);
 		}
 	}
 
 	if (host->caps & SDHCI_CAN_VDD_330) {
 		ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
 
-		mmc->max_current_330 = ((max_current_caps &
-				   SDHCI_MAX_CURRENT_330_MASK) >>
-				   SDHCI_MAX_CURRENT_330_SHIFT) *
-				   SDHCI_MAX_CURRENT_MULTIPLIER;
+		mmc->max_current_330 = FIELD_GET(SDHCI_MAX_CURRENT_330_MASK,
+						 max_current_caps) *
+						SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 	if (host->caps & SDHCI_CAN_VDD_300) {
 		ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
 
-		mmc->max_current_300 = ((max_current_caps &
-				   SDHCI_MAX_CURRENT_300_MASK) >>
-				   SDHCI_MAX_CURRENT_300_SHIFT) *
-				   SDHCI_MAX_CURRENT_MULTIPLIER;
+		mmc->max_current_300 = FIELD_GET(SDHCI_MAX_CURRENT_300_MASK,
+						 max_current_caps) *
+						SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 	if (host->caps & SDHCI_CAN_VDD_180) {
 		ocr_avail |= MMC_VDD_165_195;
 
-		mmc->max_current_180 = ((max_current_caps &
-				   SDHCI_MAX_CURRENT_180_MASK) >>
-				   SDHCI_MAX_CURRENT_180_SHIFT) *
-				   SDHCI_MAX_CURRENT_MULTIPLIER;
+		mmc->max_current_180 = FIELD_GET(SDHCI_MAX_CURRENT_180_MASK,
+						 max_current_caps) *
+						SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
 	/* If OCR set by host, use it instead. */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d7f1441b0fc3..2ff98891bf25 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -233,13 +233,10 @@
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_MAX_CURRENT		0x48
-#define  SDHCI_MAX_CURRENT_LIMIT	0xFF
-#define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
-#define  SDHCI_MAX_CURRENT_330_SHIFT	0
-#define  SDHCI_MAX_CURRENT_300_MASK	0x00FF00
-#define  SDHCI_MAX_CURRENT_300_SHIFT	8
-#define  SDHCI_MAX_CURRENT_180_MASK	0xFF0000
-#define  SDHCI_MAX_CURRENT_180_SHIFT	16
+#define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
+#define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
+#define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
+#define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
-- 
2.25.1

