Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B2C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8767F20C56
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075475;
	bh=+v0Gvo3NEuIgVnTGsMBHhqS8LDWaVSLs4O1rtCOSwpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0BWkVf8zoDG6S1M1GcQo0EvKOKX1ezpVanyQ+n/CuUHb2zr59L79ZkiSm4E1gFLd2
	 kfhpuCxrCtQd/2c4euxPGUe6c+hYzy3LYWu/8/XHmyW9ZB5MijvkKw42W8yf1gnhhA
	 IAVFsUMA/VwYIoe7oUOm3DtkOQRniMu2A3rm5iXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIBThz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgIBThx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:37:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A8C20DD4;
        Wed,  2 Sep 2020 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075473;
        bh=+v0Gvo3NEuIgVnTGsMBHhqS8LDWaVSLs4O1rtCOSwpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmFkZ/kkB4WxgIEw8otKZYIuPvlX/EZQ8cGAMveQSNYjAkyBOCW75NK/Sx/61+kgw
         oqzDBwnVLGJVpfqsBudQ9kKBz5GwYGbGmeAR7ntYjzpzVzksZRsfxAcVDQrI63d+ji
         t7Q1KG7yC0Y3C+kYXOaBipkZhyU0eLOUrSp1OlTo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 05/11] mmc: meson: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 21:36:52 +0200
Message-Id: <20200902193658.20539-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 08a3b1c05acb..2802e4520783 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -426,11 +426,9 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 		snprintf(name, sizeof(name), "clkin%d", i);
 		clk = devm_clk_get(host->dev, name);
-		if (IS_ERR(clk)) {
-			if (clk != ERR_PTR(-EPROBE_DEFER))
-				dev_err(host->dev, "Missing clock %s\n", name);
-			return PTR_ERR(clk);
-		}
+		if (IS_ERR(clk))
+			return dev_err_probe(host->dev, PTR_ERR(clk),
+					     "Missing clock %s\n", name);
 
 		mux_parent_names[i] = __clk_get_name(clk);
 	}
@@ -1077,12 +1075,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	ret = device_reset_optional(&pdev->dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "device reset failed: %d\n", ret);
-
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.17.1

