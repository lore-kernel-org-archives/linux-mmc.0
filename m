Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE49C433E6
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Feb 2021 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983B364EE1
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Feb 2021 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhBTOb2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:31:28 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:42458 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTOb2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Feb 2021 09:31:28 -0500
Received: from localhost.localdomain ([90.126.17.6])
        by mwinf5d57 with ME
        id XSVe2400507rLVE03SVehE; Sat, 20 Feb 2021 15:29:45 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Feb 2021 15:29:45 +0100
X-ME-IP: 90.126.17.6
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, kernel@esmil.dk,
        dianders@chromium.org, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
Date:   Sat, 20 Feb 2021 15:29:35 +0100
Message-Id: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A 'uniphier_sd_clk_enable()' call should be balanced by a corresponding
'uniphier_sd_clk_disable()' call.
This is done in the remove function, but not in the error handling path of
the probe.

Add the missing call.

Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/uniphier-sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 2413b6750cec..6f0f05466917 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -635,7 +635,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 	ret = tmio_mmc_host_probe(host);
 	if (ret)
-		goto free_host;
+		goto disable_clk;
 
 	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
 			       dev_name(dev), host);
@@ -646,6 +646,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 remove_host:
 	tmio_mmc_host_remove(host);
+disable_clk:
+	uniphier_sd_clk_disable(host);
 free_host:
 	tmio_mmc_host_free(host);
 
-- 
2.27.0

