Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC1C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Dec 2021 15:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351084AbhLAPlu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:41:50 -0500
Received: from smtp1.axis.com ([195.60.68.17]:57193 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350676AbhLAPlt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Dec 2021 10:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638373108;
  x=1669909108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iO8jJWMqoAAW4Jlh6nzdM1f0Z6tG13tscAmxz+u6rOo=;
  b=dfl1C4WyADkKxqdcOdJldbZ+1K3h+6cZpUJpfUbRjvrvfNgevoe00xhB
   X/7/j8MESVFRmG+h0B2q94n7nSWq4uN6HkIbJBB/f0ozX1Pte3pdYeRWS
   ArOeLvjHrZd6mZJ/A8ZbZrIJgir4yq/KN5isLS3f2uzfuOdD9B72ijFxZ
   yzjitF9/4gaV8qoQV75t1HxURWTRdovNoM1ORqUeT96cYZtLF0DCKil3N
   qTiHZOj9yKGgGNAHlqcT/mLXpPvm34uOa0jXPxqiIr/Kow8XrZI0R1co7
   K+c15u2R85m/R6yeggYefj151oj/eJbvRf6ReRVK/b5nZSvLhHzWyorSc
   g==;
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
Subject: [PATCH 3/4] mmc: dw_mmc: Add quirk for extended data read timeout
Date:   Wed, 1 Dec 2021 16:38:03 +0100
Message-ID: <20211201153804.27655-4-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201153804.27655-1-marten.lindahl@axis.com>
References: <20211201153804.27655-1-marten.lindahl@axis.com>
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
 drivers/mmc/host/dw_mmc-exynos.c |  5 +++++
 drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h        |  7 +++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index cae7c94b5d6e..6ae9c0ec1282 100644
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
index 771d5afa3136..071f4479f166 100644
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
@@ -223,6 +224,9 @@ struct dw_mci {
 	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
 	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
 
+	/* Workaround flags */
+	u32			quirks;
+
 	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
@@ -274,6 +278,9 @@ struct dw_mci_board {
 	struct dma_pdata *data;
 };
 
+/* Support for longer data read timeout */
+#define DW_MMC_QUIRK_EXTENDED_TMOUT	(1<<0)
+
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
 
-- 
2.20.1

