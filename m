From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
Date: Wed,  8 Nov 2017 19:16:58 +0900
Message-ID: <1510136220-31853-2-git-send-email-yamada.masahiro@socionext.com>
References: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Drivers do not need to call mmc_gpiod_request_cd_irq() explicitly
because mmc_start_host() calls it.  To make it work, cd_gpio must
be set before mmc_add_host().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 2abc6bc..7c0e952 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1201,6 +1201,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		return ret;
 
+	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
+		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio, 0);
+		if (ret)
+			return ret;
+	}
+
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
@@ -1296,14 +1302,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
-		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio, 0);
-		if (ret)
-			goto remove_host;
-
-		mmc_gpiod_request_cd_irq(mmc);
-	}
-
 	return 0;
 
 remove_host:
-- 
2.7.4
