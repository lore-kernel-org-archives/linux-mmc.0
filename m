Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D4C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9862B61002
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 15:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhFHPg7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:36:59 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36832 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhFHPg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 11:36:59 -0400
Received: by mail-wr1-f44.google.com with SMTP id e11so11864646wrg.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exLxBy2kCwcrb17O37qOOT6y6QhrTOK1Z3D68o8QrCg=;
        b=WAULVsvebNiqIaTajbRIiAJln/Jzebl2PLCpoWKqyD0cnOwDTUEbk6xeNw9m3tUngD
         rF0mWGkKOu0isx6g4WE7bQUAIiXoDFFGGhn/Hd/pca7kIbpBwxft5Fxbev6oc+EX7gp3
         weADaTNlcscRdwf/XSsmH/O3BcCcVff6hTXCD+XNoikhuY328i8kSmYLUWcFZVwFoO9k
         XNNUv6Fn7XjEZqn/Oji3iM3YLXjLfrR43wk0PsTG9SaBOr1mpCYxwCbvMlb10uY7nnq4
         imy12B5l1gygD3++/3blup58DTT+xjmkMNKJrlOw+nahC9luHETXmtFLlR22jRtJzcCt
         arxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exLxBy2kCwcrb17O37qOOT6y6QhrTOK1Z3D68o8QrCg=;
        b=NN99D03I+wCR6gU9wq7GKXvqDNiZCeuiFhvmijZnlrtEIPm1U6x+TrbOvqRsBewUqz
         iUYbbEQOSH3xnLAbToqegQ2CEukf1fYvT3VmHiTO4KroWggsDD+mEwOmrfYpY3TScbRx
         r99ly5u0ogbCWxxHLzi7kNzsgp7IUsf5hlUVNk7xxCktXg2BV/OdXtw4l360A/a3W2WQ
         7PRwheAUOnrUxp4bQ/MTO0dOZ11hPA+rLfE+9Gos42gGnbNncXQpdCAXFM9BRkDPslSM
         yQt+RwVC99X83UCjzwrEhdEZq3pVuOZiFSr1P2ZmZZerikSr2PNbDqIji5kINfOUZY92
         EQAw==
X-Gm-Message-State: AOAM533AdjGrI7jiYM02ppViaPqmb3Z07d+al8KAm8VcpGEmHcQ/eO6W
        dTM6qKZ+gizbYeV2TV6d1XeG7w==
X-Google-Smtp-Source: ABdhPJz4U/K5xECU1x4OoWAIx1gh84A26TibgV9v+kXvpyqYw7RVPQq2d0+03ulU+sncMyS+Qjxrtg==
X-Received: by 2002:adf:a28c:: with SMTP id s12mr24192569wra.105.1623166431832;
        Tue, 08 Jun 2021 08:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d35c:a474:f6ef:ed8b])
        by smtp.gmail.com with ESMTPSA id v15sm3171074wmj.39.2021.06.08.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:33:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
Date:   Tue,  8 Jun 2021 17:33:44 +0200
Message-Id: <20210608153344.3813661-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; h=from:subject; bh=rXYEdEvR4nB8Uuzj3wSEdhErRQJIwUAAs0WLZJAZRBo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgv43EKHb0N7wWQADXSgVpC3TlHAvo7HVCKUWEUvdD 70tVpniJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL+NxAAKCRB33NvayMhJ0RYAEA Cn00ya6QR9FuG8XEUR73LXPWY5M4lH9jzVT80zXzAn9YbOkQp4U0pzyQIE6G73e5CzbRGHu4KMeCiq 97r0m1A1HkVzavTfhNKIHPSKhI1EyRr3aepPgWtTR5JuITYUTKmlnuj4+myBQwmg6DA+xXgTqignax c0Dep6KJJ+6Esn9TL8IGW5wVEHR+dXWhiVi5pi9ct8MJsddTBB3YidOiN65z2/viamzKKoU3mcvNqy USq5QU1XZSPlPYfag2lVMd7Jh0p4YD8dYGM+eYTbsg1AWNuGIjIP2V6Blws6rqtUOCo5T84/jFSPcU O7KM9LBo9KifwUpqlv2hj9PH82vINfOdOUBWAOyy+Qu2c3w9QdPju6mTOXRDceq1sjacQctW50My9G GOdb3NyqhRfKTZfYnEV0v0vwqTSU4l4O42vntZDOTfTz8xg3gOpZCfXW2gDzkwR3kSfgKELzqYAVMp /79j1+VMpxKzpau7x7HaA9+d3Ksil8V5dpGNi2153pblHv3cfz4tOwJlF5xYHrzrZmICr90aZeGBGD EFNUNRuQOTJ7dA3WJgrBPKn0+6aLFOAfiqoIEykuYYMBwwGPaUAUbtraUmC9igOk1AW+PU+nWKzQXv 88VGiq4uFR9Lme6YfTMdScMAOG1ukqzSoKS+72z4B108SLkPDfOQ5GVGDoZQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
is used on the G12A/G12B platforms.

This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
when dram-access-quirk is enabled.

Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Ulf, Marek, Mark,

I haven't tested the patch yet, but should fix issue reported at [2].

Neil

[2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com

 drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8b771b643cc..89ff6038092d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
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
+	void *buf = host->bounce_buf;
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
+				memcpy_toio(buf + offset, miter.addr, len);
+			else
+				memcpy_fromio(miter.addr, buf + offset, len);
+		} else {
+			if (to_buffer)
+				memcpy(buf + offset, miter.addr, len);
+			else
+				memcpy(miter.addr, buf + offset, len);
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
-- 
2.25.1

