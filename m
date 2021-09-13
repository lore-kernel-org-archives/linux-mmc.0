Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B5C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Sep 2021 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBE4603E9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Sep 2021 08:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhIMIGX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhIMIGW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2021 04:06:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C6C061574
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 01:05:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so13190366wrr.9
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXY1tPoSEl+8M4X5lxSarpt4hpv0pzy83yCKr/zoENA=;
        b=rNr+O/67esY0hgWf0Yp7SJb5ajXLS1aQHjGismtobxw0LiOLBEVEoJRv5cEIfZYgDQ
         6h3WJ6pJU/LRWfyvBVRDh6kwM+0INwPbDiCVGz/y5UZMzuve7jAR36220/VugQRGD1nr
         ta5WennfAkM39TwlyoZNRoBFtRZpkNbHxUtIUdCqRFWaDGF/tApqq3TE1uYKc+p9ot7G
         0AZr5MM+/74kX+WRU7sCoqNWWLJ7NuaPycXiQOSweuwEMwqlW4y6OXa3aBV71jKHSm0k
         TxNxptBp+ZbYwtPLELx8bd12b3u39FPvRltoMjB4M+tRtqMFFrI5Z1fG9+bZQx17hhB0
         Kywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXY1tPoSEl+8M4X5lxSarpt4hpv0pzy83yCKr/zoENA=;
        b=JueyQK5aJrR9dQr5Jd967Z8UnBusn2pyMH9Zkg2zR4vdG1CZaiMGG4U74BfOpml6pY
         YrPVwJ98arhHpqQP+CaEetRXcLvoBOnT+xTGzQbRVajiwTcPGIO20F71yr21kiH5FyOr
         BR4t+eE9peJZQIzD4g5FoJawGYCAmQmlTBVddf+sSGuzBOBe1LMyJaO+8IfrmzKNB2jc
         3fVWWUaircY+5F5N2QCmEx5HhLE0BudXuuDx7Xc7rHRmJJKNgsEq88NzL2LAmZQj3917
         +1b2WokZ0YlNX7DQY7km3ACsyDAx84P7mJodJZFaMloOIjz5d4FBNwNy+LumqqPn8beg
         6+ig==
X-Gm-Message-State: AOAM530ylqBSSYsXVj32ZT6TDNKXC5AubnyE1j1WhN6hS6ak4aOBqo0Y
        D0+oE5587ttD0Qehl5Xym13xnYIfrfmpcvjn
X-Google-Smtp-Source: ABdhPJyLCvPRKQ03gErPB5bBmXZHp2i4sRtxA8fP3GXkRBSqQAEjYgMydM9st3NvlemeyZCZpyLwyw==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr10689307wrw.311.1631520305736;
        Mon, 13 Sep 2021 01:05:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:9ebe:26f1:5acc:c894])
        by smtp.gmail.com with ESMTPSA id a10sm6770449wrd.51.2021.09.13.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:05:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk
Date:   Mon, 13 Sep 2021 10:05:04 +0200
Message-Id: <20210913080504.832521-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The memory at the end of the controller only accepts 32bit read/write
accesses, but the arm64 memcpy_to/fromio implementation only uses 64bit
(which will be split into two 32bit access) and 8bit leading to incomplete
copies to/from this memory when the buffer is not multiple of 8bytes.

Add a local copy using writel/readl accesses to make sure we use the right
memory access width.

The switch to memcpy_to/fromio was done because of 285133040e6c
("arm64: Import latest memcpy()/memmove() implementation"), but using memcpy
worked before since it mainly used 32bit memory acceses.

Fixes: 103a5348c22c ("mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 49 +++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3f28eb4d17fe..08c0ff0bfa8b 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -746,7 +746,7 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
 	writel(start, host->regs + SD_EMMC_START);
 }
 
-/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
+/* local sg copy for dram_access_quirk */
 static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
 				  size_t buflen, bool to_buffer)
 {
@@ -764,21 +764,34 @@ static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data
 	sg_miter_start(&miter, sgl, nents, sg_flags);
 
 	while ((offset < buflen) && sg_miter_next(&miter)) {
-		unsigned int len;
+		unsigned int buf_offset = 0;
+		unsigned int len, left;
+		u32 *buf = miter.addr;
+
+		if (((unsigned long int)miter.addr % 4))
+			dev_err(host->dev, "non word aligned sg");
 
 		len = min(miter.length, buflen - offset);
 
-		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
-		if (host->dram_access_quirk) {
-			if (to_buffer)
-				memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
-			else
-				memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
+		if ((len % 4))
+			dev_err(host->dev, "non word multiple sg");
+
+		left = len;
+
+		if (to_buffer) {
+			do {
+				writel(*buf++, host->bounce_iomem_buf + offset + buf_offset);
+
+				buf_offset += 4;
+				left -= 4;
+			} while (left);
 		} else {
-			if (to_buffer)
-				memcpy(host->bounce_buf + offset, miter.addr, len);
-			else
-				memcpy(miter.addr, host->bounce_buf + offset, len);
+			do {
+				*buf++ = readl(host->bounce_iomem_buf + offset + buf_offset);
+
+				buf_offset += 4;
+				left -= 4;
+			} while (left);
 		}
 
 		offset += len;
@@ -830,7 +843,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		if (data->flags & MMC_DATA_WRITE) {
 			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
+			if (host->dram_access_quirk)
+				meson_mmc_copy_buffer(host, data, xfer_bytes, true);
+			else
+				sg_copy_to_buffer(data->sg, data->sg_len,
+						  host->bounce_buf, xfer_bytes);
 			dma_wmb();
 		}
 
@@ -999,7 +1016,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	if (meson_mmc_bounce_buf_read(data)) {
 		xfer_bytes = data->blksz * data->blocks;
 		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
+		if (host->dram_access_quirk)
+			meson_mmc_copy_buffer(host, data, xfer_bytes, false);
+		else
+			sg_copy_from_buffer(data->sg, data->sg_len,
+					    host->bounce_buf, xfer_bytes);
 	}
 
 	next_cmd = meson_mmc_get_next_command(cmd);
-- 
2.25.1

