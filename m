From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 1/4] Bluetooth: btmtksdio: Drop newline with bt_dev logging
 macros
Date: Thu, 18 Apr 2019 17:07:59 +0800
Message-ID: <ca617836b66cb11f5c7a1131bd3f55d81cf6380b.1555577565.git.sean.wang@mediatek.com>
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

bt_dev logging macros already include a newline at each output
so drop these unnecessary additional newlines in the driver.

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/bluetooth/btmtksdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 7d0d1cb93b0e..681e3e34977e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -487,15 +487,15 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 	sdio_writel(func, int_status, MTK_REG_CHISR, NULL);
 
 	if (unlikely(!int_status))
-		bt_dev_err(bdev->hdev, "CHISR is 0\n");
+		bt_dev_err(bdev->hdev, "CHISR is 0");
 
 	if (int_status & FW_OWN_BACK_INT)
-		bt_dev_dbg(bdev->hdev, "Get fw own back\n");
+		bt_dev_dbg(bdev->hdev, "Get fw own back");
 
 	if (int_status & TX_EMPTY)
 		schedule_work(&bdev->tx_work);
 	else if (unlikely(int_status & TX_FIFO_OVERFLOW))
-		bt_dev_warn(bdev->hdev, "Tx fifo overflow\n");
+		bt_dev_warn(bdev->hdev, "Tx fifo overflow");
 
 	if (int_status & RX_DONE_INT) {
 		rx_size = (int_status & RX_PKT_LEN) >> 16;
-- 
2.18.0
