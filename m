From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/4] mmc: meson-gx: add pwrseq-based hw_reset
Date: Wed, 8 Feb 2017 22:49:25 +0100
Message-ID: <bf895a14-c4c9-d70b-fea6-843d8412b7b4@gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36032 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHV6R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 16:58:17 -0500
Received: by mail-wr0-f194.google.com with SMTP id k90so9998483wrc.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 13:58:16 -0800 (PST)
In-Reply-To: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Use new function mmc_hw_reset_pwrseq as hw_reset operation.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5eca88bc..260a8ea8 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -716,6 +716,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
 	.get_cd         = meson_mmc_get_cd,
+	.hw_reset	= mmc_hw_reset_pwrseq,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
-- 
2.11.0


