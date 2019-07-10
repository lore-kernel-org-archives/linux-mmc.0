From: Joe Perches <joe@perches.com>
Subject: [PATCH 06/12] mmc: meson-mx-sdio: Fix misuse of GENMASK macro
Date: Tue,  9 Jul 2019 22:04:19 -0700
Message-ID: <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2d736e416775..ba9a63db73da 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -73,7 +73,7 @@
 	#define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK		GENMASK(7, 6)
 	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CLK		BIT(8)
 	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CMD		BIT(9)
-	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(10, 13)
+	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(13, 10)
 	#define MESON_MX_SDIO_IRQC_SOFT_RESET			BIT(15)
 	#define MESON_MX_SDIO_IRQC_FORCE_HALT			BIT(30)
 	#define MESON_MX_SDIO_IRQC_HALT_HOLE			BIT(31)
-- 
2.15.0
