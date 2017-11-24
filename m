From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 08/22] mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
Date: Sat, 25 Nov 2017 01:24:43 +0900
Message-ID: <1511540697-27387-9-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Drivers do not need to call mmc_gpiod_request_cd_irq() explicitly
because mmc_start_host() calls it.  To make it work, cd_gpio must
be set before mmc_add_host().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 46f77c3..efffb04 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1205,6 +1205,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
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
@@ -1300,14 +1306,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
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
