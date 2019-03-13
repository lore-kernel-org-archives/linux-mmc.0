From: <sean.wang@mediatek.com>
Subject: [PATCH v1 3/3] Bluetooth: btsdio: Use module_sdio_driver helper
Date: Thu, 14 Mar 2019 05:02:00 +0800
Message-ID: <38ca0408d4c189cb8a01820749c10077450c4465.1552510141.git.sean.wang@mediatek.com>
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

Macro module_sdio_driver is used for drivers whose init and exit paths
only register and unregister to SDIO API. So remove boilerplate code to
make code simpler by using module_sdio_driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btsdio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 282d1af1d3ba..4cfa9abe03c8 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -376,20 +376,7 @@ static struct sdio_driver btsdio_driver = {
 	.id_table	= btsdio_table,
 };
 
-static int __init btsdio_init(void)
-{
-	BT_INFO("Generic Bluetooth SDIO driver ver %s", VERSION);
-
-	return sdio_register_driver(&btsdio_driver);
-}
-
-static void __exit btsdio_exit(void)
-{
-	sdio_unregister_driver(&btsdio_driver);
-}
-
-module_init(btsdio_init);
-module_exit(btsdio_exit);
+module_sdio_driver(btsdio_driver);
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth SDIO driver ver " VERSION);
-- 
2.18.0
