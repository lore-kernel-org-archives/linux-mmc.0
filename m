From: <sean.wang@mediatek.com>
Subject: [PATCH v1 2/3] Bluetooth: mediatek: Use module_sdio_driver helper
Date: Thu, 14 Mar 2019 05:01:59 +0800
Message-ID: <97430233d791cf69398e6a5f568a61ad42077249.1552510141.git.sean.wang@mediatek.com>
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

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 23cf63888bac..ca7f28f439da 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -956,20 +956,7 @@ static struct sdio_driver btmtksdio_driver = {
 	.id_table	= btmtksdio_table,
 };
 
-static int __init btmtksdio_init(void)
-{
-	BT_INFO("MediaTek Bluetooth SDIO driver ver %s", VERSION);
-
-	return sdio_register_driver(&btmtksdio_driver);
-}
-
-static void __exit btmtksdio_exit(void)
-{
-	sdio_unregister_driver(&btmtksdio_driver);
-}
-
-module_init(btmtksdio_init);
-module_exit(btmtksdio_exit);
+module_sdio_driver(btmtksdio_driver);
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth SDIO driver ver " VERSION);
-- 
2.18.0
