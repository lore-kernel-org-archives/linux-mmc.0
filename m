Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE928C5479D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjALCYz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjALCYx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:24:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3744C56
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so14228439pjg.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWCr/YXdDUyPASQrplk+fJu9/v4utJbMHhi33acQ5XM=;
        b=MbOlu5oRT/kwKuLcQm+WfpA66ETGwI/6pT0fCj1R57kpsdq+5e3yKoX/WggwYebOEN
         1vBCK3Z6fooe09k7tYFzYhbyP85O1si7gf9qXkGtDuFopaKBHhq+PkVNgQO8BXBtxy3u
         /uEOsHH22lewuuj+sDAHLAsPc9Y17lKkgxF78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWCr/YXdDUyPASQrplk+fJu9/v4utJbMHhi33acQ5XM=;
        b=vX+iNklPnT0c50FEHVnoZuYzwRsX7w9LpidG/x6VCV/HLmXrvkMCzMvI1AOyMho1+Z
         PyDSFLYP/tprfuHR0L6RCxRwG5OOBrx/0y4+Knhu4jJ+h1XnYIsx1zFaAh7Zd2+YDJqO
         0CNkAi+mvQti3RUEf1PrZIGW6vcG7wIXUCh8oJSkEzZQxAakxOyhBeZCqwGCRMebx4TQ
         a1dH+miduEtJ73UcLeJ/32wA3vYgF/K+48U0SaJiymVeX2GyRh0ETzUdzGEcLdDmIq0z
         tGrtXXBdDZP/zxPiMOuyYpxLImxbEstZi0y7IatidokqGf+DlKGM16HWUcJVqgxMu5eR
         Mgrg==
X-Gm-Message-State: AFqh2kqY+SCg36zN8/h+dVkiP4anAZDztBmB2gVnTzp7QJfKQgCltQ2M
        26h+aUG2qlWNbYvS9w9KQLJEzA==
X-Google-Smtp-Source: AMrXdXvX9ykjlHOwrc8I3VTRauJgtZRWEOLmx13qVPKe5okF96ILjCtjFgHjVf3rEQRh0vLroRrQVg==
X-Received: by 2002:a17:903:1355:b0:193:3a92:f4bd with SMTP id jl21-20020a170903135500b001933a92f4bdmr4888980plb.47.1673490292698;
        Wed, 11 Jan 2023 18:24:52 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:24:52 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
Date:   Wed, 11 Jan 2023 18:24:13 -0800
Message-Id: <20230112022416.8474-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112022416.8474-1-doug@schmorgal.com>
References: <20230112022416.8474-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ability to have an optional core clock just like the pxav3 driver.
The PXA168 needs this because its SDHC controllers have separate core
and io clocks that both need to be enabled. This also correctly matches
the documented devicetree bindings for this driver.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index f5c86e1ba734..b10f55b478fc 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -191,7 +191,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	const struct sdhci_pxa_variant *variant;
 
 	int ret;
-	struct clk *clk;
+	struct clk *clk, *clk_core;
 
 	host = sdhci_pltfm_init(pdev, NULL, 0);
 	if (IS_ERR(host))
@@ -214,6 +214,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	clk_core = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(clk_core)) {
+		dev_err_probe(dev, PTR_ERR(clk_core), "failed to enable core clock\n");
+		goto disable_clk;
+	}
+
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-- 
2.34.1

