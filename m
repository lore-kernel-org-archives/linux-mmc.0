Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6FC46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjAPTow (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjAPTor (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAEE2CC48
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q23-20020a17090a065700b002290913a521so12617055pje.5
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqYz5wS1ns0kl8A6NpaJdCKujdrpwt6VlQVEZ72mUB8=;
        b=JgGZYlqHWBDT0cSi8VIWA3vQKajGGfoljiLjNUR+0boPilQkPK6/05Ab4AgGogOeJB
         1uNS8OKQ7znEpz4DR3ExcfV3qkM0shC5fUX0odRr0vDasuPeWy6aH650rw0v6+INA3BL
         4j7Wt5LRfuMSOo7vJsD2f3NPkTZ6jJxAXPSRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqYz5wS1ns0kl8A6NpaJdCKujdrpwt6VlQVEZ72mUB8=;
        b=rH61E0kS2jraOdnrb84QvtpO9k+pGXDd3+VurJ4xEefKUAuN+lmfa+qBjbkiqc5J5k
         LNSh9POxq7cL3MjKt2uefA6WxLy41yAYZXgcQbqZHs+ZyyWQyRbZOKtbon9GI6nVLFu6
         UA1XIgMDAGMvMEr4/jVV40z1J4mn/7U0XjrRN202bEsZpjbxUF4IMBANOXMjh/TWKbT2
         1NCTMgK0B3Ts6CkoGPRbYjcMoa86U6LCIjSIF2GpvBfrd4XJ6NpBxGGPHegN8swuzAJ4
         PNzOOGnYkgF93zwfTy5kamB7Ur0FS3XdfD3nz05rRJGny6bv14qV7wHsZ38XhcYe5jWS
         U+ug==
X-Gm-Message-State: AFqh2kp4fhJrskc+tAXIFafkHqyZPf4m3/o2q0v0CHAkTHHA4USp9cPP
        P/ClkN448/dUARChXnbeyjx+L6oYEVhtbRMCizY0gg==
X-Google-Smtp-Source: AMrXdXubMwBfH/DZX7c3dFUOa8kG4jN6M/+ViULMkQLspFA2078qgDhevkj/6jCy6zbxF8nNGc/Aow==
X-Received: by 2002:a17:902:e9cd:b0:194:5de4:52d0 with SMTP id 13-20020a170902e9cd00b001945de452d0mr970515plk.41.1673898285006;
        Mon, 16 Jan 2023 11:44:45 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:44 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v5 4/8] mmc: sdhci-pxav2: change clock name to match DT bindings
Date:   Mon, 16 Jan 2023 11:43:57 -0800
Message-Id: <20230116194401.20372-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The devicetree bindings for this driver specify that the two allowed
clock names are io and core. Change this driver to look for io, but
allow any name if it fails for backwards compatibility. Follow the same
pattern used in sdhci-pxav3, but add support for EPROBE_DEFER.

Get rid of an unnecessary pdev->dev while we're at it.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 5e01dab94426..f5c86e1ba734 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -199,16 +199,18 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	clk = devm_clk_get(dev, "PXA-SDHCLK");
+	clk = devm_clk_get(dev, "io");
+	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
+		clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(clk);
+		dev_err_probe(dev, ret, "failed to get io clock\n");
 		goto free;
 	}
 	pltfm_host->clk = clk;
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable io clock\n");
+		dev_err(dev, "failed to enable io clock\n");
 		goto free;
 	}
 
-- 
2.34.1

