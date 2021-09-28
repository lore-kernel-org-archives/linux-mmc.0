Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680FC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3B361157
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbhI1UKD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:10:03 -0400
Received: from www.zeus03.de ([194.117.254.33]:60840 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242662AbhI1UKD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Sep 2021 16:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=KL3Z3mz2IpiTon
        QDblZA5x+7X8q2ANgi0ZOs401G1XY=; b=OypVbrR+0KGcZYp+EkGF1HsYljeOfO
        Qj2Ir6ar4bBClShbsTTH+5ehiBq2Zbw8/LKNRU6Y47PR0rQUegyBDiulKFHr61MA
        9JbJ1Fip8CmnotqE97xBOC7V42ifZZk4G62CJnnZ8ufwL6BaQuLcoT+ix77PgUZd
        hxPwqp2X/HsYI=
Received: (qmail 1377348 invoked from network); 28 Sep 2021 22:08:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2021 22:08:19 +0200
X-UD-Smtp-Session: l3s3148p1@kolWxhPNetIgAwDPXxnDADNsFyRXxb9N
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 5/9] clk: renesas: gen3-cpg: remove outdated SD_SKIP_FIRST
Date:   Tue, 28 Sep 2021 22:08:00 +0200
Message-Id: <20210928200804.50922-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
References: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We handle it differently meanwhile.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index aa0797b98e89..c4b36c90e159 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -397,29 +397,20 @@ static u32 cpg_quirks __initdata;
 
 #define PLL_ERRATA	BIT(0)		/* Missing PLL0/2/4 post-divider */
 #define RCKCR_CKSEL	BIT(1)		/* Manual RCLK parent selection */
-#define SD_SKIP_FIRST	BIT(2)		/* Skip first clock in SD table */
 
 
 static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
 	{
 		.soc_id = "r8a7795", .revision = "ES1.0",
-		.data = (void *)(PLL_ERRATA | RCKCR_CKSEL | SD_SKIP_FIRST),
+		.data = (void *)(PLL_ERRATA | RCKCR_CKSEL),
 	},
 	{
 		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = (void *)(RCKCR_CKSEL | SD_SKIP_FIRST),
-	},
-	{
-		.soc_id = "r8a7795", .revision = "ES2.0",
-		.data = (void *)SD_SKIP_FIRST,
+		.data = (void *)(RCKCR_CKSEL),
 	},
 	{
 		.soc_id = "r8a7796", .revision = "ES1.0",
-		.data = (void *)(RCKCR_CKSEL | SD_SKIP_FIRST),
-	},
-	{
-		.soc_id = "r8a7796", .revision = "ES1.1",
-		.data = (void *)SD_SKIP_FIRST,
+		.data = (void *)(RCKCR_CKSEL),
 	},
 	{ /* sentinel */ }
 };
-- 
2.30.2

