Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A206BC433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2DD2083B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075444;
	bh=QI1dbgDJjoYYCfP5Ig/mRza3CKsYxoxxWzwXZDaG6PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFFMDg0V61FOvzIRvICcVKwRe1YiGfqyVxQOsgR8qaIiEpc66kPOx1mw03OUqBUGy
	 spgsmaoxc2v4RrLLUTSyKomGLAXyCdw3t8FPnKUV/tCyn7rAENoGWrsjKjPcyMkK/J
	 0oNzLDJrPAKR4yD7WbyuWHwcvny1cJCweCrk81kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBThX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBThX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:37:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97F620C56;
        Wed,  2 Sep 2020 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075442;
        bh=QI1dbgDJjoYYCfP5Ig/mRza3CKsYxoxxWzwXZDaG6PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AphxV8QEPolpObOxM6UHjrZjADaAg1btgTTHrvzO2dWIADsBTTqpuMWAL4i370o7v
         4p9el5oYjDyJ+MbJEwURiHc7zp8MMUlNuPfYUBojB3mCF8mIcvTL88iitSV6+7veqF
         PcmNdGmheaZlQtHy9Nuvsk99SoqL4pFsrHLfZamU=
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
Subject: [PATCH 01/11] mmc: bcm2835: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 21:36:48 +0200
Message-Id: <20200902193658.20539-2-krzk@kernel.org>
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
 drivers/mmc/host/bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index a0767790a826..35320bc9dc02 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1406,9 +1406,7 @@ static int bcm2835_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "could not get clk: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(clk), "could not get clk\n");
 		goto err;
 	}
 
-- 
2.17.1

