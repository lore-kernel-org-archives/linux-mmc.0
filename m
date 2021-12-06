Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Dec 2021 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbhLFOd0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:33:26 -0500
Received: from smtp1.axis.com ([195.60.68.17]:52820 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242092AbhLFOdZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Dec 2021 09:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638800997;
  x=1670336997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oMIQqZW8PBJSiuntECWVbhUwyE6oY/NcOyzE/8jFkzs=;
  b=Zjm1QzhdnHGg+ZhjLOTmpE8IziUycyhULpf03M1iMApc3+syLKR0vU+N
   DBUH4KtXlYt/FuwdZnTyLYvWTqDNDy/ZH1tmSvli/KtRlGPB7gnAwgxK4
   7fU7bMDiCk6yVajJVx3TD0aFIXdbz6mI4WeTA4C9O0JhBLtUvMSsWcNDf
   qSsF/0PFYn+AFSkL/HFcrLPv1cLeNQ1aqaOPFZc0EBtQ0gq23ySDruhNH
   ykvX/6rAqe13EmrDDIPJtN9kiOgD6rqJWPuVar7E4ZSNlrnphMgexGhgi
   c4uWgi7TV9lYS96Vy0GrOZVzvVmjjLr/RSXiRArK5TyY/3aaPq9U0IK17
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 3/4] mmc: dw_mmc: Add quirk for extended data read timeout
Date:   Mon, 6 Dec 2021 15:29:28 +0100
Message-ID: <20211206142929.26729-4-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211206142929.26729-1-marten.lindahl@axis.com>
References: <20211206142929.26729-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Current dw_mci driver supports a TMOUT register which consists of a 24
bit field (TMOUT[31:8]) for the DATA_TIMEOUT. The maximum value of this
field is 0xFFFFFF, which with a 200MHz clock will give a full DRTO of:

0xFFFFFF / 200000000 => ~84 ms

However, the ARTPEC-8 SoC DWMMC IP version has a TMOUT register with an
extended DATA_TIMEOUT field, which supports longer timers for the DRTO.
In this version the DATA_TIMEOUT field is split into two, which with the
same 200MHz clock as above will allow a maximum timeout of:

((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms

Add a quirk to support this. The quirk is enabled for ARTPEC-8 SoCs.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Removed unnecessary comment
 - Change 1<<0 to BIT(0)

 drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
 drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h        |  6 ++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 86486e6659de..1b625642c5b4 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -127,6 +127,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
 	}
 
+	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
+		/* Quirk needed for ARTPEC-8 SoCs */
+		host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
+	}
+
 	host->bus_hz /= (priv->ciu_div + 1);
 
 	return 0;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f2a14a434bef..45ea9fd97a6a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1289,6 +1289,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
 {
 	u32 clk_div, tmout;
 	u64 tmp;
+	unsigned int tmp2;
 
 	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
 	if (clk_div == 0)
@@ -1301,10 +1302,28 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
 	tmout = 0xFF; /* Set maximum */
 
 	/* TMOUT[31:8] (DATA_TIMEOUT) */
-	if (!tmp || tmp > 0xFFFFFF)
-		tmout |= (0xFFFFFF << 8);
-	else
-		tmout |= (tmp & 0xFFFFFF) << 8;
+	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT) {
+		/*
+		 * Extended HW timer (max = 0x6FFFFF2):
+		 * ((TMOUT[10:8] - 1) * 0xFFFFFF + TMOUT[31:11] * 8)
+		 */
+		if (!tmp || tmp > 0x6FFFFF2)
+			tmout |= (0xFFFFFF << 8);
+		else {
+			/* TMOUT[10:8] */
+			tmp2 = (((unsigned int)tmp / 0xFFFFFF) + 1) & 0x7;
+			tmout |= tmp2 << 8;
+
+			/* TMOUT[31:11] */
+			tmp = tmp - ((tmp2 - 1) * 0xFFFFFF);
+			tmout |= (tmp & 0xFFFFF8) << 8;
+		}
+	} else {
+		if (!tmp || tmp > 0xFFFFFF)
+			tmout |= (0xFFFFFF << 8);
+		else
+			tmout |= (tmp & 0xFFFFFF) << 8;
+	}
 
 	mci_writel(host, TMOUT, tmout);
 	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
@@ -2005,9 +2024,15 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	if (drto_div == 0)
 		drto_div = 1;
 
+	if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
+		drto_clks = (((drto_clks & 0x7) - 1) * 0xFFFFFF) +
+			((drto_clks & 0xFFFFF8));
+
 	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
 				   host->bus_hz);
 
+	dev_dbg(host->dev, "drto_ms: %u\n", drto_ms);
+
 	/* add a bit spare time */
 	drto_ms += 10;
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 771d5afa3136..3b6510d4a684 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -118,6 +118,7 @@ struct dw_mci_dma_slave {
  * @part_buf: Simple buffer for partial fifo reads/writes.
  * @push_data: Pointer to FIFO push function.
  * @pull_data: Pointer to FIFO pull function.
+ * @quirks: Set of quirks that apply to specific versions of the IP.
  * @vqmmc_enabled: Status of vqmmc, should be true or false.
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
@@ -223,6 +224,8 @@ struct dw_mci {
 	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
 	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
 
+	u32			quirks;
+
 	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
@@ -274,6 +277,9 @@ struct dw_mci_board {
 	struct dma_pdata *data;
 };
 
+/* Support for longer data read timeout */
+#define DW_MMC_QUIRK_EXTENDED_TMOUT		BIT(0)
+
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
 
-- 
2.20.1

