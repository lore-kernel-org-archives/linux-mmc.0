From: <sean.wang@mediatek.com>
Subject: [PATCH v1 1/3] mmc: sdio: Add helper macro for sdio_driver boilerplate
Date: Thu, 14 Mar 2019 05:01:58 +0800
Message-ID: <6cb7e75934bc7ac56a0e7c6cbbc963f98a6730b0.1552510141.git.sean.wang@mediatek.com>
References: <cover.1552510141.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com, ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This patch introduces the module_sdio_driver macro which is a convenience
macro for SDIO driver modules similar to module_usb_driver. It is intended
to be used by drivers which init/exit section does nothing but register/
unregister the SDIO driver. By using this macro it is possible to eliminate
a few lines of boilerplate code per SDIO driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/mmc/sdio_func.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 97ca105347a6..5685805533b5 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -111,6 +111,18 @@ struct sdio_driver {
 extern int sdio_register_driver(struct sdio_driver *);
 extern void sdio_unregister_driver(struct sdio_driver *);
 
+/**
+ * module_sdio_driver() - Helper macro for registering a SDIO driver
+ * @__sdio_driver: sdio_driver struct
+ *
+ * Helper macro for SDIO drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_sdio_driver(__sdio_driver) \
+	module_driver(__sdio_driver, sdio_register_driver, \
+		      sdio_unregister_driver)
+
 /*
  * SDIO I/O operations
  */
-- 
2.18.0
