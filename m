Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14946C48BCF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBBB613C1
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhFIPFn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:05:43 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33454 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhFIPFm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2021 11:05:42 -0400
Received: by mail-wr1-f47.google.com with SMTP id a20so25932411wrc.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jun 2021 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGd3vej9Xv7tCX6p/j+Wd3uODyXRg/QkcngJWQeZQgI=;
        b=nvNbpYzwgzprXt2lVilg7oqUHRgsaxvUww91B29smt15nzyo6S5HMxBrqovVy8bPBj
         DWKNOxNxhNO2VFI8J9svI1LC670J1s/jF/+qwoYsOWZcZ4YG8GVz3QvchU4R14c3YFNf
         twfchpTpkIlHBEyTYSGFwXsjepH+XRjUpjYXt8SavWvkoFcfQgANfM1MomcHZnnngcrH
         99yIE7TRm2AWLTAqguwNPUoFRZqLGsyvUXoIjeCr+2LxlPtzH+VaybSJmXUTIp93oOAn
         4LR4LOxBbLy6+xbLWQY6ypQzx+g/29H7ciQoUZfZad+hpWWQG5MHswn1Dsolz1GChsu5
         CKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGd3vej9Xv7tCX6p/j+Wd3uODyXRg/QkcngJWQeZQgI=;
        b=ribcZ3R8COMnWfiHjeLccuoNaF4mF35lzKYRsmH8ca+QFaj/PW2NUPG5OFHF71pagg
         6TUIIVuqG/DpeMo8KAFmTGqZsV4DV9m07FghRXvL1IICmTESx0CMr9Dck2394PYjLorH
         UQteTi3cSCyx8Rq3fF64LXDGpcuUYpHkogwvBeDNdfVgZTrKk3qSUJ3NcK+QUMXlxu/O
         1GsCMxWsf96Rb6Dxhu29bM0nR0zR+58SxSq9m0u1eacecmNRUV/xyk9KOQ5ffJ9NCiWu
         Vm9GQK/ctkwIBJ7C9HoxigYQ0P5R5SfeSYbiaS9bT313szQSXdVzIwJAtuwMiCrsQeuP
         4fQg==
X-Gm-Message-State: AOAM530DMQWP8z5DOik9cFS7C8Ek7goHCpyEKR0BZE2RsoEEDkIVlfjQ
        N0MysjeCighbMQjYDzTe6yXiDw==
X-Google-Smtp-Source: ABdhPJxWu17j56SdQHAq1gC6qDDkB0RefAVQcawdtMTmlPVSTjiFSvOxv8KUDy2bB/jOZo8YHjCkOQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr307424wro.2.1623250953997;
        Wed, 09 Jun 2021 08:02:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:f5b2:1a3b:b4d:517c])
        by smtp.gmail.com with ESMTPSA id o3sm266509wrc.0.2021.06.09.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:02:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
Date:   Wed,  9 Jun 2021 17:02:30 +0200
Message-Id: <20210609150230.9291-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
and a recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
is used on the G12A/G12B platforms.

This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
when dram-access-quirk is enabled.

Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

[1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
---
 drivers/mmc/host/meson-gx-mmc.c | 50 +++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)


Changes since RFC:
- moved iomem address to bounce_iomem_buf otherwise sparse screamed when feeding memcpy_to/fromio with non iomem pointer

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8b771b643cc..3e9b28f18c70 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -165,6 +165,7 @@ struct meson_host {
 
 	unsigned int bounce_buf_size;
 	void *bounce_buf;
+	void __iomem *bounce_iomem_buf;
 	dma_addr_t bounce_dma_addr;
 	struct sd_emmc_desc *descs;
 	dma_addr_t descs_dma_addr;
@@ -742,6 +743,47 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
 	writel(start, host->regs + SD_EMMC_START);
 }
 
+/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
+static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
+				  size_t buflen, bool to_buffer)
+{
+	unsigned int sg_flags = SG_MITER_ATOMIC;
+	struct scatterlist *sgl = data->sg;
+	unsigned int nents = data->sg_len;
+	struct sg_mapping_iter miter;
+	unsigned int offset = 0;
+
+	if (to_buffer)
+		sg_flags |= SG_MITER_FROM_SG;
+	else
+		sg_flags |= SG_MITER_TO_SG;
+
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+
+	while ((offset < buflen) && sg_miter_next(&miter)) {
+		unsigned int len;
+
+		len = min(miter.length, buflen - offset);
+
+		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
+		if (host->dram_access_quirk) {
+			if (to_buffer)
+				memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
+			else
+				memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
+		} else {
+			if (to_buffer)
+				memcpy(host->bounce_buf + offset, miter.addr, len);
+			else
+				memcpy(miter.addr, host->bounce_buf + offset, len);
+		}
+
+		offset += len;
+	}
+
+	sg_miter_stop(&miter);
+}
+
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		if (data->flags & MMC_DATA_WRITE) {
 			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(data->sg, data->sg_len,
-					  host->bounce_buf, xfer_bytes);
+			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
 			dma_wmb();
 		}
 
@@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	if (meson_mmc_bounce_buf_read(data)) {
 		xfer_bytes = data->blksz * data->blocks;
 		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		sg_copy_from_buffer(data->sg, data->sg_len,
-				    host->bounce_buf, xfer_bytes);
+		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
 	}
 
 	next_cmd = meson_mmc_get_next_command(cmd);
@@ -1176,7 +1216,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		 * instead of the DDR memory
 		 */
 		host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
-		host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
+		host->bounce_iomem_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
 		host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
 	} else {
 		/* data bounce buffer */
-- 
2.25.1

