From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 2/4] Bluetooth: btmtksdio: Add a bit definition for CHLPCR
Date: Thu, 18 Apr 2019 17:08:00 +0800
Message-ID: <59a2a29ece89c13ffc2c7cd32432c1731906f447.1555577565.git.sean.wang@mediatek.com>
References: <cover.1555577565.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1555577565.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Add a register bit definition about CHLPCR bit 8 because the bit is quite
different in the meaning between reading and writing that bit.

The patch adds a definition particularly for the bit read to avoid the
confusion about using write definition to read the bit.

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/bluetooth/btmtksdio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 681e3e34977e..9c123a9de673 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -56,7 +56,8 @@ static const struct sdio_device_id btmtksdio_table[] = {
 #define MTK_REG_CHLPCR		0x4	/* W1S */
 #define C_INT_EN_SET		BIT(0)
 #define C_INT_EN_CLR		BIT(1)
-#define C_FW_OWN_REQ_SET	BIT(8)
+#define C_FW_OWN_REQ_SET	BIT(8)  /* For write */
+#define C_COM_DRV_OWN		BIT(8)  /* For read */
 #define C_FW_OWN_REQ_CLR	BIT(9)
 
 #define MTK_REG_CSDIOCSR	0x8
@@ -526,7 +527,7 @@ static int btmtksdio_open(struct hci_dev *hdev)
 		goto err_disable_func;
 
 	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 status & C_FW_OWN_REQ_SET, 2000, 1000000);
+				 status & C_COM_DRV_OWN, 2000, 1000000);
 	if (err < 0) {
 		bt_dev_err(bdev->hdev, "Cannot get ownership from device");
 		goto err_disable_func;
@@ -606,7 +607,7 @@ static int btmtksdio_close(struct hci_dev *hdev)
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, NULL);
 
 	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 !(status & C_FW_OWN_REQ_SET), 2000, 1000000);
+				 !(status & C_COM_DRV_OWN), 2000, 1000000);
 	if (err < 0)
 		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
 
-- 
2.18.0
