From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] MMC: meson: remove redundant return value check of platform_get_resource()
Date: Sat, 20 Aug 2016 15:30:16 +0000
Message-ID: <1471707016-28957-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35135 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbcHTPaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2016 11:30:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so3204187pfg.2
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2016 08:30:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/mmc/host/meson-gxbb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
index 10eac41..96cd883 100644
--- a/drivers/mmc/host/meson-gxbb.c
+++ b/drivers/mmc/host/meson-gxbb.c
@@ -811,10 +811,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto free_host;
-	}
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->regs)) {
 		ret = PTR_ERR(host->regs);

