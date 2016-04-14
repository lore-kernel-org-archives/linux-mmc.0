From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/2] mmc: sdhci: use IS_ENABLE(CONFIG_LEDS_CLASS) to enable LED struct members
Date: Thu, 14 Apr 2016 13:19:40 +0900
Message-ID: <1460607580-22599-2-git-send-email-yamada.masahiro@socionext.com>
References: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)

is equivalent to:

IS_ENABLED(CONFIG_LEDS_CLASS)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0decc85..27e8603 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -428,7 +428,7 @@ struct sdhci_host {
 	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
 	u64 dma_mask;		/* custom DMA mask */
 
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 	struct led_classdev led;	/* LED control */
 	char led_name[32];
 #endif
-- 
1.9.1
