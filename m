Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27EC4743C
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E93F61164
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFWKCK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 06:02:10 -0400
Received: from www.zeus03.de ([194.117.254.33]:50872 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFWKCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Jun 2021 06:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=qu5snV65MT2dXm
        jt06pGR2OjRw6FIkGJrYDKJpHo0Xs=; b=b8Jfm2zgz3ETciAlTu3uo7WXsE1B7P
        UlIKEIxwOlbFfu73PmFwdUFjVIkvdwd0YOY18Zxgixf91mMUmeG/l7MBPl0EqwYp
        f94eOnCW4VRPQoY/8dAIAb64Ue0Q6U7omvV4Q1QrPsMhAWo3llMIBswZaNDBpt4e
        x2V1Drzge/+Fo=
Received: (qmail 2551991 invoked from network); 23 Jun 2021 11:59:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 11:59:44 +0200
X-UD-Smtp-Session: l3s3148p1@1LFC92vFFKogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] i2c: imx: : use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 11:59:36 +0200
Message-Id: <20210623095942.3325-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623095942.3325-1-wsa+renesas@sang-engineering.com>
References: <20210623095942.3325-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dmaengine_terminate_all() is deprecated in favor of explicitly saying if
it should be sync or async. Here, we want dmaengine_terminate_sync()
because there is no other synchronization code in the driver to handle
an async case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dc5ca71906db..b224e82924d2 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -423,7 +423,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 	return 0;
 
 err_submit:
-	dmaengine_terminate_all(dma->chan_using);
+	dmaengine_terminate_sync(dma->chan_using);
 err_desc:
 	dma_unmap_single(chan_dev, dma->dma_buf,
 			dma->dma_len, dma->dma_data_dir);
@@ -899,7 +899,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
 	if (time_left == 0) {
-		dmaengine_terminate_all(dma->chan_using);
+		dmaengine_terminate_sync(dma->chan_using);
 		return -ETIMEDOUT;
 	}
 
@@ -954,7 +954,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
 	if (time_left == 0) {
-		dmaengine_terminate_all(dma->chan_using);
+		dmaengine_terminate_sync(dma->chan_using);
 		return -ETIMEDOUT;
 	}
 
-- 
2.30.2

