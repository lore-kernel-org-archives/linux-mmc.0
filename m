Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ACCC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8613601FA
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 07:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbhI1Him (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhI1Hil (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2021 03:38:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6895EC061604
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2021 00:37:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so4407030wrd.13
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2021 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ukGi3jrrjha+D9TPzmB0py/6c66GKZD4MHDgm6P10=;
        b=jThVZfplycMd8BrUu3i9rNEKQNvwMgZjFUZXnQKydP/BPS7L2KFyndlKOcvnKctuZ9
         HRyckDu+6vU7w9dVAbB6kMteE2kSjzUJs9KPrvhM6bF86qVi/Greu59ujd8iaTfBbX3q
         aB5ZJEouLh6jYdGFvBFAMKG16NoUfuorcKE3kJ3dr8E4mfnQJQKzbl8shvPQWRIX5gcq
         6SfbIqKB9eS3DCtvImkzc2mPzCF63+01M3y8tB4DyB0Eq8I9eZ96KlsxTeQ/o6Cfqs5c
         JvHjRPqqPIl+4vcGso3fSkh9FW3I8xKhBV1p68mcwWM3lGiHKf/kWk6xh5nEzCPBwzm0
         Njfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ukGi3jrrjha+D9TPzmB0py/6c66GKZD4MHDgm6P10=;
        b=N1F8YlMiTd9l9KaLjQVeHlc/VUaXDgkbX4F7WD1AaZx6WAss50zpJHixm9whilG8jG
         v9xmralfuCxeOweRL2erdpMoCIHEwjgQYXNWMDztM5S/ZlEZanYcBUH/qjxWgsugViwB
         n52bEbfWuA8bJAc4LyXnzSeUGkX1d60Sivx8juv86jci10bUaBhXXN/rdGPAhGFkhV2Y
         jl2SAzsQUujAWKH3VRxoFNiZWyXcc3srKiHqVU9sNW7kuX/rhjHHRSU0ozSvbUxTzhwT
         JzPgr04dOjcdV1bECRjd+nw73SCxzVPWkys8f1QlKxV5abSja17qpFg1lP9P39XWz5xN
         aOCg==
X-Gm-Message-State: AOAM5330iWo0eBpyPQxh0cJnbCriTF3R6VYldPI+EclkLoakMvFjC2om
        45lhuaDUJhcHpmQxVssL7SrTVw==
X-Google-Smtp-Source: ABdhPJx7PDOCZTrSfSoBj6A6tBDBSqv3hllEA/Frui6VQ5UkscYFuYYCsZLNiyYN8XNDhB+/VDyqoQ==
X-Received: by 2002:a05:6000:18a4:: with SMTP id b4mr4703065wri.96.1632814620869;
        Tue, 28 Sep 2021 00:37:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:af32:f180:8ede:d9da])
        by smtp.gmail.com with ESMTPSA id q8sm8210170wrv.26.2021.09.28.00.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:37:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk
Date:   Tue, 28 Sep 2021 09:36:52 +0200
Message-Id: <20210928073652.434690-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5434; h=from:subject; bh=lS4QGxtvZRm6mTGA/rTgX19F6pA1j0bugQURcq/3QAY=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhUsXaGyiGIMSGGuF5dkoQ2VcYQnCURDzSJRc5WVYP IBzwcJ6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYVLF2gAKCRB33NvayMhJ0bN1EA CRjmWZncIY6W2w9k4SPCXrYZiHMywnxdATOrVB7b5363hyzdDXsHtZC+6y9ULstvXsiP9Komz47Oco ofPnbcey9KMoMlqPfyj/DhD1YcTPZPCWWvlGZjhI2I9+LYE0EWLqn/hRXFdWNio1OiRzuezN1fOPo1 sd512JiTtq5DvM8aL+/rcYO95MJbK0NJXH6TZW4obXhyPmXljqo7uA8j7/VmUv33oDw4G2S5PbQ5VE LrDugBmZJf1lkY5JonPRKa2QSH0MafVks71/GYWEsMRJ0EoUzVr8jJR0fmHYqTb8okkwVZ3I+1DoUP E7qsbgHgaoKjtdUomWpZLFpe8eVN2Xb/c/yirYY5/aL311Rh2qJnPvp07DCU38a/IBaa9iny8r+xkc 6xc5L8lv751VU/cl0DTOtxtiqXWatmXWm1m2bg9JvFIEYHN3uuRp2oSQFBw5q44tOfRRfPNofAadc/ votcgmMz5ocgQNQmryBf9xesLMaEOuvDljze7SFKJE9WBUJ4Wx+2HNg2BUWNQicsqr6UUhr15xK1cE MtiDXS/h7Epl0tw9+S8KmTYLSjnBgn6y0eDWqo5cp9ysLqPR1lL8G2+gFQNmmqZXWhks7pb+DkMSAl dzBmQqKX/+8kIVUYTyyy0fBInsdA/m0/Yn7cArfGcLpPiSHZaKyTuuoKDaZw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- added sg pre-validation at meson_mmc_request and dropped checks in meson_mmc_copy_buffer

 drivers/mmc/host/meson-gx-mmc.c | 73 ++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3f28eb4d17fe..8f36536cb1b6 100644
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
@@ -764,21 +764,27 @@ static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data
 	sg_miter_start(&miter, sgl, nents, sg_flags);
 
 	while ((offset < buflen) && sg_miter_next(&miter)) {
-		unsigned int len;
+		unsigned int buf_offset = 0;
+		unsigned int len, left;
+		u32 *buf = miter.addr;
 
 		len = min(miter.length, buflen - offset);
+		left = len;
 
-		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
-		if (host->dram_access_quirk) {
-			if (to_buffer)
-				memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
-			else
-				memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
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
@@ -830,7 +836,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
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
 
@@ -849,12 +859,43 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
 }
 
+static int meson_mmc_validate_dram_access(struct mmc_host *mmc, struct mmc_data *data)
+{
+	struct scatterlist *sg;
+	int i;
+
+	/* Reject request if any element offset or size is not 32bit aligned */
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
+		    !IS_ALIGNED(sg->length, sizeof(u32))) {
+			dev_err(mmc_dev(mmc), "unaligned sg offset %u len %u\n",
+				data->sg->offset, data->sg->length);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
 	bool needs_pre_post_req = mrq->data &&
 			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
 
+	/*
+	 * The memory at the end of the controller used as bounce buffer for
+	 * the dram_access_quirk only accepts 32bit read/write access,
+	 * check the aligment and length of the data before starting the request.
+	 */
+	if (host->dram_access_quirk && mrq->data) {
+		mrq->cmd->error = meson_mmc_validate_dram_access(mmc, mrq->data);
+		if (mrq->cmd->error) {
+			mmc_request_done(mmc, mrq);
+			return;
+		}
+	}
+
 	if (needs_pre_post_req) {
 		meson_mmc_get_transfer_mode(mmc, mrq);
 		if (!meson_mmc_desc_chain_mode(mrq->data))
@@ -999,7 +1040,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
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

