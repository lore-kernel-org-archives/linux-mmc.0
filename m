Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92266C07EA3
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EDE611BD
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhI1UKI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:10:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:60914 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242672AbhI1UKF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Sep 2021 16:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=50+VZZr763Y4Yc
        o+HsRSmUs/xv+RBnk0KYigKvjNxLk=; b=VJTPXTjnqkxydEykH0ffjquQuo4dWJ
        mWZuOKS/CsHVxDUXaHGiGffrpACWdUqxPimp4Rv0XHrHqJqOELOQ10rCYzVqqNKg
        CwzZMdbDHo8MB28K2P/nZVXJOI4WYvxnax9kJFAmGip8NLLW033klZAsO2K+yhpU
        1V99OmUSlXiCA=
Received: (qmail 1377488 invoked from network); 28 Sep 2021 22:08:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2021 22:08:23 +0200
X-UD-Smtp-Session: l3s3148p1@qNCKxhPNgtIgAwDPXxnDADNsFyRXxb9N
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 9/9] mmc: renesas_sdhi: parse DT for SDnH
Date:   Tue, 28 Sep 2021 22:08:04 +0200
Message-Id: <20210928200804.50922-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
References: <20210928200804.50922-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If there is a SDnH clock provided in DT, let's use it instead of relying
on the fallback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 100f86d311ea..41a5ee80c661 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -922,8 +922,16 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	priv->clkh = devm_clk_get_optional(&pdev->dev, "clkh");
+	if (IS_ERR(priv->clkh)) {
+		ret = PTR_ERR(priv->clkh);
+		dev_err(&pdev->dev, "cannot get clockh: %d\n", ret);
+		return ret;
+	}
+
 	/* Fallback for old DTs */
-	if (of_device_is_compatible(pdev->dev.of_node, "renesas,rcar-gen3-sdhi"))
+	if (!priv->clkh &&
+	    of_device_is_compatible(pdev->dev.of_node, "renesas,rcar-gen3-sdhi"))
 		priv->clkh = clk_get_parent(clk_get_parent(priv->clk));
 
 	/*
-- 
2.30.2

