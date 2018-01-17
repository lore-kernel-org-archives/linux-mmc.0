From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 09/16] mmc: tmio: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
Date: Thu, 18 Jan 2018 01:28:09 +0900
Message-ID: <1516206496-16612-10-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:36679 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeAQQ3d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jan 2018 11:29:33 -0500
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.

Only the difference is the TMIO_... makes tmio_mmc_get_ro() return 0
(i.e. it does not affect mmc_gpio_get_ro() at all), while MMC_CAP2_...
returns 0 before calling ->get_ro() hook (i.e. it affects both IP own
logic and GPIO detection).

The TMIO MMC drivers do not set-up gpio_ro by themselves.  Only the
possibility, if any, would be DT specifies "wp-gpios" property, and
gpio_ro is set by mmc_gpiod_request_ro() called from mmc_of_parse().
However, it does not make sense to specify "wp-gpios" property and
"toshiba,mmc-wrprotect-disable" at the same time.

I checked under arch/arm/boot/dts/ and arch/arm64/boot/dts/renesas/,
and I did not see any Renesas boards with "wp-gpios".  So, this
conversion should be safe.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0032707..bdbff2d 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1128,7 +1128,7 @@ static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 }
 
 static void tmio_mmc_of_parse(struct platform_device *pdev,
-			      struct tmio_mmc_data *pdata)
+			      struct mmc_host *mmc)
 {
 	const struct device_node *np = pdev->dev.of_node;
 
@@ -1136,7 +1136,7 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
 		return;
 
 	if (of_get_property(np, "toshiba,mmc-wrprotect-disable", NULL))
-		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
+		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 }
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
@@ -1171,7 +1171,7 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 		goto free;
 	}
 
-	tmio_mmc_of_parse(pdev, pdata);
+	tmio_mmc_of_parse(pdev, mmc);
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.7.4

