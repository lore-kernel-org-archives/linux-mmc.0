Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63475C49EA6
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C51A610C7
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFWKCK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 06:02:10 -0400
Received: from www.zeus03.de ([194.117.254.33]:50914 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhFWKCE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Jun 2021 06:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=tlNjdlJGQTVahX
        t3fq+jLObAGlqBZRvmoZLo/Q1OJRs=; b=runxqQxYQXRCXQNisM1nixlMjSP7JQ
        bYV9JKgaDqXCz2/cE87bMvMCO2riqv3VkgrDWS6SxpcmM67QhpYn7v70ct+tA8b+
        NW17bjrYfr7/zOmg0E/gmDziie8tG8ESCl10wHUPUBkVWT698+dVB0wipKd7/i1B
        s/PIMPErQg/ZE=
Received: (qmail 2552021 invoked from network); 23 Jun 2021 11:59:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 11:59:44 +0200
X-UD-Smtp-Session: l3s3148p1@5DNL92vFFqogARa4RfhaAavnjlTTqzSz
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] i2c: mxs: : use proper DMAENGINE API for termination
Date:   Wed, 23 Jun 2021 11:59:37 +0200
Message-Id: <20210623095942.3325-4-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index f97243f02231..864a3f1bd4e1 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -290,14 +290,14 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 select_init_dma_fail:
 	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
 select_init_pio_fail:
-	dmaengine_terminate_all(i2c->dmach);
+	dmaengine_terminate_sync(i2c->dmach);
 	return -EINVAL;
 
 /* Write failpath. */
 write_init_dma_fail:
 	dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
 write_init_pio_fail:
-	dmaengine_terminate_all(i2c->dmach);
+	dmaengine_terminate_sync(i2c->dmach);
 	return -EINVAL;
 }
 
-- 
2.30.2

