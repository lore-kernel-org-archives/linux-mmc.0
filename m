From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: of_mmc_spi: fix restricted cast warning of sparse
Date: Mon, 31 Jul 2017 21:03:53 +0900
Message-ID: <1501502633-14205-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Sparse reports "warning: cast to restricted __be32".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/of_mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 85bbebfde02e..c9eed8436b6b 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -71,7 +71,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms;
-	const u32 *voltage_ranges;
+	const __be32 *voltage_ranges;
 	int num_ranges;
 	int i;
 
-- 
2.7.4
