Return-Path: <SRS0=NlIn=2X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0DC3276C
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0A21655
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="T6T7EWX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgABKmT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:42:19 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:54057 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKmT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Jan 2020 05:42:19 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pPk03CW1z9d;
        Thu,  2 Jan 2020 11:42:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577961737; bh=oBmFlA6XBIskOllmY5RqPNoNc5yLITo26fvoXFWesDI=;
        h=Date:From:Subject:To:Cc:From;
        b=T6T7EWX03xDEfVkaMJEAcJk3xratjjFQNp0K41Qv6P6FHsfd7pnS5/YYyuE+UFkzg
         86YKxHeCFYy+RjScU+P2VMiGgNJElxk8oHm/z4VACtNpc00n/nld73ybXzrpxIYhNT
         aAm7PGYim9q0JOrkGr7yDb1YbR7KMQMzFGbrqNvebBmRjbTAtmYlYslUc2YWyM3JY4
         +7oixQUfmaKaEIqRjENcgCXPlY13EXjmp8aGUk+DsGYznNIxzHpOzwWcanGHHA9Ejk
         ecYPXglfhaKL/T5jyoobVzHa5m8iBo7eZj8n9AIlQ9YHLPXFRoPMOd2PM6F3JdF7n7
         u6q3CsrKzAO6A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 02 Jan 2020 11:42:16 +0100
Message-Id: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: sdhci-of-at91: fix memleak on clk_get failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_alloc_host() does its work not using managed infrastructure, so
needs explicit free on error path. Add it where needed.

Cc: <stable@vger.kernel.org>
Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-of-at91.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index b2a8c45c9c23..ab2bd314a390 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -345,20 +345,23 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 			priv->mainck = NULL;
 		} else {
 			dev_err(&pdev->dev, "failed to get baseclk\n");
-			return PTR_ERR(priv->mainck);
+			ret = PTR_ERR(priv->mainck);
+			goto sdhci_pltfm_free;
 		}
 	}
 
 	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
 	if (IS_ERR(priv->hclock)) {
 		dev_err(&pdev->dev, "failed to get hclock\n");
-		return PTR_ERR(priv->hclock);
+		ret = PTR_ERR(priv->hclock);
+		goto sdhci_pltfm_free;
 	}
 
 	priv->gck = devm_clk_get(&pdev->dev, "multclk");
 	if (IS_ERR(priv->gck)) {
 		dev_err(&pdev->dev, "failed to get multclk\n");
-		return PTR_ERR(priv->gck);
+		ret = PTR_ERR(priv->gck);
+		goto sdhci_pltfm_free;
 	}
 
 	ret = sdhci_at91_set_clks_presets(&pdev->dev);
-- 
2.20.1

