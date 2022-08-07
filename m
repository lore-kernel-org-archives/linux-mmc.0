Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB6C19F2A
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Aug 2022 06:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiHGG4s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Aug 2022 02:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiHGG4r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Aug 2022 02:56:47 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B5DE84
        for <linux-mmc@vger.kernel.org>; Sat,  6 Aug 2022 23:56:46 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KaDHoLSshSMw7KaDHo0n89; Sun, 07 Aug 2022 08:56:44 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Aug 2022 08:56:44 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] mmc: meson-gx: Fix an error handling path in meson_mmc_probe()
Date:   Sun,  7 Aug 2022 08:56:38 +0200
Message-Id: <be4b863bacf323521ba3a02efdc4fca9cdedd1a6.1659855351.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit in Fixes has introduced a new error handling which should goto
the existing error handling path.
Otherwise some resources leak.

Fixes: 19c6beaa064c ("mmc: meson-gx: add device reset")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2f08d442e557..fc462995cf94 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1172,8 +1172,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	ret = device_reset_optional(&pdev->dev);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "device reset failed\n");
+		goto free_host;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.34.1

