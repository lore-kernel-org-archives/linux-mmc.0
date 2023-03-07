Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B666C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCGQbo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCGQbd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2023 11:31:33 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D5867FE
        for <linux-mmc@vger.kernel.org>; Tue,  7 Mar 2023 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=/K+5ZHq3qxSf+u
        vMlu2Mbiy40EGhHX9fwgqPWBWOR8I=; b=bXVpGEvcPTMHGGn12V34q06RQqS/TJ
        MSkDKcNVIhNZGp7VZjENZqlGZICMjLAgfjIKNchkI9GePBemruUWSrM+vofyci+n
        b3iCFgHU4k7Vor6ZOMq4EWTXI6xjoJImlsPOWXkNpZqK/w6J6an/8HkMAIvd3pwc
        NZDsuJLSKxJho=
Received: (qmail 752100 invoked from network); 7 Mar 2023 17:31:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:07 +0100
X-UD-Smtp-Session: l3s3148p1@lJ5E8FH2go0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mmc: renesas_sdhi: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:36 +0100
Message-Id: <20230307163041.3815-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f38003f6b1ca..9ab813903b2c 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -72,11 +72,10 @@ enum renesas_sdhi_dma_cookie {
 
 static unsigned long global_flags;
 /*
- * Workaround for avoiding to use RX DMAC by multiple channels.
- * On R-Car H3 ES1.* and M3-W ES1.0, when multiple SDHI channels use
- * RX DMAC simultaneously, sometimes hundreds of bytes data are not
- * stored into the system memory even if the DMAC interrupt happened.
- * So, this driver then uses one RX DMAC channel only.
+ * Workaround for avoiding to use RX DMAC by multiple channels. On R-Car M3-W
+ * ES1.0, when multiple SDHI channels use RX DMAC simultaneously, sometimes
+ * hundreds of data bytes are not stored into the system memory even if the
+ * DMAC interrupt happened. So, this driver then uses one RX DMAC channel only.
  */
 #define SDHI_INTERNAL_DMAC_RX_IN_USE	0
 
@@ -222,7 +221,6 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
-	{ .soc_id = "r8a7795", .revision = "ES1.*", .data = &sdhi_quirks_4tap_nohs400_one_rx },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
 	{ .soc_id = "r8a7796", .revision = "ES1.[12]", .data = &sdhi_quirks_4tap_nohs400 },
-- 
2.35.1

