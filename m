Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA8C4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 20:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLIVCh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:02:37 -0500
Received: from smtp2.axis.com ([195.60.68.18]:28277 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhLIVCg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Dec 2021 16:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639083543;
  x=1670619543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mfbtyMndSHZT9bkMkmzaCh0YFgQGV2cvG+VwO9zV4RY=;
  b=hI1kmEBP7x/B2Kn0gH61G9alBdup4qkXWNCl6E4c7By9ZVmN1Xf1Fq9E
   6jgH4lf34neoVcXklxz0SAGUmlxyRGjDlx/P7iNzOPCkn3xYgs9fsvk8n
   nFrASIcL6hdxa0bhNQdBWgTmPxFzIYFHe6waogZXFFKDFLvGsqE6CtgU/
   W8lWfqBZgYogexR4ABHBs6zvvVq+UNoDJnU0NqRDzQ+cCMXlK36JkXShG
   4cIDR/EpBqfnGSJaqI/5P56mdP9OoyDvvB9CjE2zJ3+AGLEFBx/uJmXMS
   eSbJ8p3RDsfZQV/VyRZWiol4AsgoXCUlD6Gz9cL6FXWQ9N/6QvSNrQHZ6
   w==;
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
Subject: [PATCH v4 4/4] mmc: dw_mmc: Do not wait for DTO in case of error
Date:   Thu, 9 Dec 2021 21:54:56 +0100
Message-ID: <20211209205456.11027-5-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209205456.11027-1-marten.lindahl@axis.com>
References: <20211209205456.11027-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When running the ARTPEC-8 DWMMC IP version, and a data error interrupt
comes during a data read transfer, there is no guarantee for the data
transfer over interrupt (DTO) to come within the specified data timeout.
This case is handled by the dto_timer handler which will complete the
request with the comment:

 /*
  * If DTO interrupt does NOT come in sending data state,
  * we should notify the driver to terminate current transfer
  * and report a data timeout to the core.
  */

But since the ARTPEC-8 DWMMC IP version, supports an extended TMOUT
register which allows longer timeouts than the non ARTPEC-8 version
does, waiting for the dto_timer to complete the request in error cases
may cause the request to take significantly longer time than necessary.
This is specifically true for the failing steps during tuning of a
device.

Fix this by completing the request when the error interrupt comes. Since
this fix is specific for the ARTPEC-8, a quirk is added.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v3:
 - Define DW_MMC_QUIRK_EXTENDED_TMOUT.
 - Implement DW_MMC_QUIRK_EXTENDED_TMOUT for the ARTPEC-8 SoC.

 drivers/mmc/host/dw_mmc-exynos.c | 5 +++++
 drivers/mmc/host/dw_mmc.c        | 9 +++++++++
 drivers/mmc/host/dw_mmc.h        | 5 +++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 4e5612d04504..00b89231467f 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -127,6 +127,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
 	}
 
+	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
+		/* Quirk needed for the ARTPEC-8 SoC */
+		host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
+	}
+
 	host->bus_hz /= (priv->ciu_div + 1);
 
 	return 0;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a7745e193afa..da09a06898c9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2762,11 +2762,20 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
 			spin_lock(&host->irq_lock);
 
+			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
+				del_timer(&host->dto_timer);
+
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
 			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
+
+			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
+				/* In case of error, we cannot expect a DTO */
+				set_bit(EVENT_DATA_COMPLETE,
+					&host->pending_events);
+
 			tasklet_schedule(&host->tasklet);
 
 			spin_unlock(&host->irq_lock);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 0a85d05eaf12..7f1e38621d13 100644
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
@@ -223,6 +224,7 @@ struct dw_mci {
 	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
 	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
 
+	u32			quirks;
 	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
@@ -274,6 +276,9 @@ struct dw_mci_board {
 	struct dma_pdata *data;
 };
 
+/* Support for longer data read timeout */
+#define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
 
-- 
2.20.1

