Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C9C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B8F615E3
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhKPNjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhKPNjK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2021 08:39:10 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A59C061570
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2021 05:36:12 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9ddb:b7d5:eb58:4276])
        by xavier.telenet-ops.be with bizsmtp
        id K1cA2600F3F42dW011cAq6; Tue, 16 Nov 2021 14:36:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mmyd8-00CvNW-8G; Tue, 16 Nov 2021 14:36:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mmyd7-001gY0-Nc; Tue, 16 Nov 2021 14:36:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: renesas_sdhi: Use devm_clk_get_optional() to obtain CD clock
Date:   Tue, 16 Nov 2021 14:36:07 +0100
Message-Id: <540d803d31bf9aa1d0f78f431cae0ccd05387edc.1637069733.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the existing devm_clk_get_optional() helper to obtain the optional
Card Detect clock, instead of open-coding the same operation.
a side effect, real errors will now be handled correctly instead of
being ignored.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a6c47362035a0415..f41225a34f4ae863 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -936,9 +936,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	 * to the card detect circuit. That leaves us with if separate clocks
 	 * are presented, we must treat them both as virtually 1 clock.
 	 */
-	priv->clk_cd = devm_clk_get(&pdev->dev, "cd");
+	priv->clk_cd = devm_clk_get_optional(&pdev->dev, "cd");
 	if (IS_ERR(priv->clk_cd))
-		priv->clk_cd = NULL;
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
 
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
-- 
2.25.1

