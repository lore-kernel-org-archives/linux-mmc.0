Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413BEC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11242222B3
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 14:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgLWOle (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:41:34 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64870 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727158AbgLWOle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 09:41:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNEb1YR022190;
        Wed, 23 Dec 2020 06:40:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=3TXqj1IKWDJvWf7QNtGMDFnQ22mG8KVQZxTTv7BIfm4=;
 b=BdpTkQzVGn9rCha3QHpBjEJXFAA5WsU/PZD3bXC0SEHxu5dUy8C5xz6FotHeRC8h6W1m
 Yr/QOKdbSLpHIt343WCK23D7YP4En6CVd000f1KsmAk0PkIjhHZ2F8Kn2gx0A1U1RJNB
 G6ruH4TU++yFbQckcr6UtYvADY9iEwcNfcsRXEQW792Ck9lfcvF/bTyGG1i3kmVOAXCJ
 xMysG4IKyorbcwnkszcURgZK/kBB45ecQSV7sj5zrdqGzBtgdnQlO3AvRML/JP6Oqodt
 waPXne9RV7EBeY/IxUl4Z6msStBEbj45/PjBo/6vOPi0oSmnld703kSoH7MUL0scna3X Ig== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebebf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 06:40:51 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 06:40:50 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 06:40:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 06:40:49 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 694F03F703F;
        Wed, 23 Dec 2020 06:40:47 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bhaskara Budiredla" <bbudiredla@marvell.com>
Subject: [PATCH v4 2/2] mmc: cavium: Add MMC polling method to support kmsg panic/oops write
Date:   Wed, 23 Dec 2020 20:10:33 +0530
Message-ID: <20201223144033.32571-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223144033.32571-1-bbudiredla@marvell.com>
References: <20201223144033.32571-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_06:2020-12-23,2020-12-23 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To enable the writing of panic and oops logs, a cavium specific MMC
polling method is defined and thereby ensure the functioning of mmcpstore.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 drivers/mmc/host/cavium-thunderx.c | 10 +++++
 drivers/mmc/host/cavium.c          | 67 ++++++++++++++++++++++++++++++
 drivers/mmc/host/cavium.h          |  3 ++
 3 files changed, 80 insertions(+)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 76013bbbcff3..83f25dd6820a 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -19,12 +19,22 @@
 
 static void thunder_mmc_acquire_bus(struct cvm_mmc_host *host)
 {
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	if (!host->pstore)
+		down(&host->mmc_serializer);
+#else
 	down(&host->mmc_serializer);
+#endif
 }
 
 static void thunder_mmc_release_bus(struct cvm_mmc_host *host)
 {
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	if (!host->pstore)
+		up(&host->mmc_serializer);
+#else
 	up(&host->mmc_serializer);
+#endif
 }
 
 static void thunder_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index c5da3aaee334..708bec9d0345 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -510,6 +510,66 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(emm_int != 0);
 }
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+static int cvm_req_completion_poll(struct mmc_host *host, unsigned long msecs)
+{
+	struct cvm_mmc_slot *slot = mmc_priv(host);
+	struct cvm_mmc_host *cvm_host = slot->host;
+	u64 emm_int;
+
+	while (msecs) {
+		emm_int = readq(cvm_host->base + MIO_EMM_INT(cvm_host));
+
+		if (emm_int & MIO_EMM_INT_DMA_DONE)
+			return 0;
+		else if (emm_int & MIO_EMM_INT_DMA_ERR)
+			return -EIO;
+		mdelay(1);
+		msecs--;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void cvm_req_cleanup_pending(struct mmc_host *host)
+{
+	struct cvm_mmc_slot *slot = mmc_priv(host);
+	struct cvm_mmc_host *cvm_host = slot->host;
+	u64 fifo_cfg;
+	u64 dma_cfg;
+	u64 emm_int;
+
+	cvm_host->pstore = 1;
+
+	/* Clear pending DMA FIFO queue */
+	fifo_cfg = readq(cvm_host->dma_base + MIO_EMM_DMA_FIFO_CFG(cvm_host));
+	if (FIELD_GET(MIO_EMM_DMA_FIFO_CFG_COUNT, fifo_cfg))
+		writeq(MIO_EMM_DMA_FIFO_CFG_CLR,
+			cvm_host->dma_base + MIO_EMM_DMA_FIFO_CFG(cvm_host));
+
+	/* Clear ongoing DMA, if there is any */
+	dma_cfg = readq(cvm_host->dma_base + MIO_EMM_DMA_CFG(cvm_host));
+	if (dma_cfg & MIO_EMM_DMA_CFG_EN) {
+		dma_cfg |= MIO_EMM_DMA_CFG_CLR;
+		writeq(dma_cfg, cvm_host->dma_base +
+				MIO_EMM_DMA_CFG(cvm_host));
+		do {
+			dma_cfg = readq(cvm_host->dma_base +
+					MIO_EMM_DMA_CFG(cvm_host));
+		} while (dma_cfg & MIO_EMM_DMA_CFG_EN);
+	}
+
+	/* Clear pending DMA interrupts */
+	emm_int = readq(cvm_host->base + MIO_EMM_INT(cvm_host));
+	if (emm_int)
+		writeq(emm_int, cvm_host->base + MIO_EMM_INT(cvm_host));
+
+	/* Clear prepared and yet to be fired DMA requests */
+	cvm_host->current_req = NULL;
+	cvm_host->dma_active = false;
+}
+#endif
+
 /*
  * Program DMA_CFG and if needed DMA_ADR.
  * Returns 0 on error, DMA address otherwise.
@@ -901,6 +961,10 @@ static const struct mmc_host_ops cvm_mmc_ops = {
 	.set_ios        = cvm_mmc_set_ios,
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	.req_cleanup_pending = cvm_req_cleanup_pending,
+	.req_completion_poll = cvm_req_completion_poll,
+#endif
 };
 
 static void cvm_mmc_set_clock(struct cvm_mmc_slot *slot, unsigned int clock)
@@ -1058,6 +1122,9 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	slot->bus_id = id;
 	slot->cached_rca = 1;
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	host->pstore = 0;
+#endif
 	host->acquire_bus(host);
 	host->slot[id] = slot;
 	cvm_mmc_switch_to(slot);
diff --git a/drivers/mmc/host/cavium.h b/drivers/mmc/host/cavium.h
index f3eea5eaa678..248a5a6e3522 100644
--- a/drivers/mmc/host/cavium.h
+++ b/drivers/mmc/host/cavium.h
@@ -75,6 +75,9 @@ struct cvm_mmc_host {
 	spinlock_t irq_handler_lock;
 	struct semaphore mmc_serializer;
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	bool pstore;
+#endif
 	struct gpio_desc *global_pwr_gpiod;
 	atomic_t shared_power_users;
 
-- 
2.17.1

