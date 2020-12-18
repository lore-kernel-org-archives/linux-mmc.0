Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F525C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574CD23A52
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgLRHye (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 02:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgLRHye (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2020 02:54:34 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC92C0617A7
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 23:53:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id f132so1898989oib.12
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 23:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5MgUC7paGHE4/Tl28P/ns0cXKXhaheAa+ameYMg2Gs=;
        b=pUo9UJvb0kipZ84NNhdDxR9A4qx6b0JX53ykBFpB0AAchDKYDv9aQf3jWiT+SKPMYG
         FXsIdjRJXcKkA22d6R3BXVryDzgmYeCaW7PEpstmuJ5GRkIjmc/2xCVoWrHRmsIWcdQ6
         sGPJX3x4d9wn7lUGP4zwnb+eidetFQBl/xvypy01+GG6yiU5KALxOViwDnsxKQ86yvxo
         x7IqaeJoCLWtHhmZjaelJ7C530fuLWykLsJ+UGyXublyeY/ede5r2ikds/sNRTyh4XlI
         yZ0QPNF8x8wRbB31gh62GdPtB8NVqoKQ1SRYfrltXiGduH4PNk1Vm+sV3uVe4NUlUzaD
         lAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5MgUC7paGHE4/Tl28P/ns0cXKXhaheAa+ameYMg2Gs=;
        b=KMM2MTvHKaFORsg4B+dS5zytTYnDj4iGMw18Fsk64f6Yz9CQwom+U3WJZ2diMAj2Nn
         mLZpp4k5U/RXNeqbzdulsb8V4yOYg8K/dwbf0McCbJiJZRY0ID+9YOFFyGmJnM5TdZZw
         VbExubt7n8P8R53/Ye1VYk/2qayzW2wM8L7v655wcCz3KaZWhqKUvyarg+YArqIAUhWD
         guTn6pIVCAIDAY7Mdi7uim9NmjDWf6PA1YcyLZRSoGMRbmQVolwYP48e7xY5qWujk/v7
         h04XRaC4PImUX3mTFDDVgQ6jZruk/GXFkzgcCmgBvuThoHwdGxXHfLHzuKHpPJgYPwHe
         hy2A==
X-Gm-Message-State: AOAM533EsOg2nownZDtcxkCdRgnz98TPj2k+267O8JFoY2mnvyuR1erP
        tZAScTf3xR/fwZdfE29N2YJ9Hujjw3UhQDmy
X-Google-Smtp-Source: ABdhPJxUCbV4sKygbvNBCtFvaKwRR6uZavTE8HCLzFIree5M8LpYcK2DrYTvuviROegeHH8owUmi5w==
X-Received: by 2002:a05:6808:7d0:: with SMTP id f16mr1955164oij.109.1608278033799;
        Thu, 17 Dec 2020 23:53:53 -0800 (PST)
Received: from Dmitriis-MBP-16.attlocal.net ([2600:1700:5ae1:8180:69ca:e94d:4a3e:3e73])
        by smtp.googlemail.com with ESMTPSA id g3sm1376615ooi.28.2020.12.17.23.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 23:53:53 -0800 (PST)
From:   Dmitry Lebed <lebed.dmitry@gmail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org, hkallweit1@gmail.com,
        martin.blumenstingl@googlemail.com,
        Dmitry Lebed <lebed.dmitry@gmail.com>
Subject: [PATCH] mmc: meson-gx: check for scatterlist size alignment in block mode
Date:   Thu, 17 Dec 2020 23:53:12 -0800
Message-Id: <20201218075312.67338-1-lebed.dmitry@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable SGDMA support for SD_IO_RW_EXTENDED and add proper check
for scatterlist size alignment in block mode.

According to documentation, in SDIO block mode meson-gx DMA could
only handle buffers with sizes that are multiples of SDIO block size.

Some SDIO drivers like brcmfmac use scatterlist API, but do not enforce
proper scatterlist buffer size alignemnt, this looks like a root cause
of non-working CMD53.

Some minor style fixes.

Signed-off-by: Dmitry Lebed <lebed.dmitry@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 37 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 13f6a2c0ed04..eb6c02bc4a02 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -227,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	struct mmc_data *data = mrq->data;
 	struct scatterlist *sg;
 	int i;
-	bool use_desc_chain_mode = true;
 
 	/*
 	 * When Controller DMA cannot directly access DDR memory, disable
@@ -237,25 +236,33 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	if (host->dram_access_quirk)
 		return;
 
-	/*
-	 * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
-	 * reported. For some strange reason this occurs in descriptor
-	 * chain mode only. So let's fall back to bounce buffer mode
-	 * for command SD_IO_RW_EXTENDED.
-	 */
-	if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
-		return;
+	if (data->blocks > 1) {
+		/*
+		 * In block mode DMA descriptor format, "length" field indicates
+		 * number of blocks and there is no way to pass DMA size that
+		 * is not multiple of SDIO block size, making it impossible to
+		 * tie more than one memory buffer with single SDIO block.
+		 * Block mode sg buffer size should be aligned with SDIO block
+		 * size, otherwise chain mode could not be used.
+		 */
+		for_each_sg(data->sg, sg, data->sg_len, i) {
+			if (sg->length % data->blksz) {
+				WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
+					  sg->length, data->blksz);
+				return;
+			}
+		}
+	}
 
-	for_each_sg(data->sg, sg, data->sg_len, i)
+	for_each_sg(data->sg, sg, data->sg_len, i) {
 		/* check for 8 byte alignment */
-		if (sg->offset & 7) {
+		if (sg->offset % 8) {
 			WARN_ONCE(1, "unaligned scatterlist buffer\n");
-			use_desc_chain_mode = false;
-			break;
+			return;
 		}
+	}
 
-	if (use_desc_chain_mode)
-		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
+	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
 }
 
 static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
-- 
2.24.3 (Apple Git-128)

