From: <sean.wang@mediatek.com>
Subject: [PATCH v1 4/4] Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth
Date: Thu, 18 Apr 2019 17:08:02 +0800
Message-ID: <3946c88c48f088c242d94204d7302364133fe2b9.1555577565.git.sean.wang@mediatek.com>
References: <cover.1555577565.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: ulf.hansson@linaro.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add runtime PM support to btmtksdio. With this way, there will be the
benefit of the device entering the more power saving state once it is
been a while data traffic is idle.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 144 ++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 877c0a831775..813338288453 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 
 #include <linux/mmc/host.h>
@@ -33,6 +34,10 @@
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
+#define MTKBTSDIO_AUTOSUSPEND_DELAY	8000
+
+static bool enable_autosuspend;
+
 struct btmtksdio_data {
 	const char *fwname;
 };
@@ -150,6 +155,7 @@ struct btmtk_hci_wmt_params {
 struct btmtksdio_dev {
 	struct hci_dev *hdev;
 	struct sdio_func *func;
+	struct device *dev;
 
 	struct work_struct tx_work;
 	unsigned long tx_state;
@@ -301,6 +307,8 @@ static void btmtksdio_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int err;
 
+	pm_runtime_get_sync(bdev->dev);
+
 	sdio_claim_host(bdev->func);
 
 	while ((skb = skb_dequeue(&bdev->txq))) {
@@ -313,6 +321,9 @@ static void btmtksdio_tx_work(struct work_struct *work)
 	}
 
 	sdio_release_host(bdev->func);
+
+	pm_runtime_mark_last_busy(bdev->dev);
+	pm_runtime_put_autosuspend(bdev->dev);
 }
 
 static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
@@ -471,6 +482,18 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 	u32 int_status;
 	u16 rx_size;
 
+	/* It is required that the host gets ownership from the device before
+	 * accessing any register, however, if SDIO host is not being released,
+	 * a potential deadlock probably happens in a circular wait between SDIO
+	 * IRQ work and PM runtime work. So, we have to explicitly release SDIO
+	 * host here and claim again after the PM runtime work is all done.
+	 */
+	sdio_release_host(bdev->func);
+
+	pm_runtime_get_sync(bdev->dev);
+
+	sdio_claim_host(bdev->func);
+
 	/* Disable interrupt */
 	sdio_writel(func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
 
@@ -507,6 +530,9 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 
 	/* Enable interrupt */
 	sdio_writel(func, C_INT_EN_SET, MTK_REG_CHLPCR, 0);
+
+	pm_runtime_mark_last_busy(bdev->dev);
+	pm_runtime_put_autosuspend(bdev->dev);
 }
 
 static int btmtksdio_open(struct hci_dev *hdev)
@@ -815,6 +841,23 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
 
+	pm_runtime_set_autosuspend_delay(bdev->dev,
+					 MTKBTSDIO_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(bdev->dev);
+
+	err = pm_runtime_set_active(bdev->dev);
+	if (err < 0)
+		return err;
+
+	/* Default forbid runtime auto suspend, that can be allowed by
+	 * enable_autosuspend flag or the PM runtime entry under sysfs.
+	 */
+	pm_runtime_forbid(bdev->dev);
+	pm_runtime_enable(bdev->dev);
+
+	if (enable_autosuspend)
+		pm_runtime_allow(bdev->dev);
+
 	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
 
 	return 0;
@@ -822,10 +865,16 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 
 static int btmtksdio_shutdown(struct hci_dev *hdev)
 {
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x0;
 	int err;
 
+	/* Get back the state to be consistent with the state
+	 * in btmtksdio_setup.
+	 */
+	pm_runtime_get_sync(bdev->dev);
+
 	/* Disable the device */
 	wmt_params.op = MTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
@@ -839,6 +888,9 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 		return err;
 	}
 
+	pm_runtime_put_noidle(bdev->dev);
+	pm_runtime_disable(bdev->dev);
+
 	return 0;
 }
 
@@ -885,6 +937,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (!bdev->data)
 		return -ENODEV;
 
+	bdev->dev = &func->dev;
 	bdev->func = func;
 
 	INIT_WORK(&bdev->tx_work, btmtksdio_tx_work);
@@ -922,6 +975,25 @@ static int btmtksdio_probe(struct sdio_func *func,
 
 	sdio_set_drvdata(func, bdev);
 
+	/* pm_runtime_enable would be done after the firmware is being
+	 * downloaded because the core layer probably already enables
+	 * runtime PM for this func such as the case host->caps &
+	 * MMC_CAP_POWER_OFF_CARD.
+	 */
+	if (pm_runtime_enabled(bdev->dev))
+		pm_runtime_disable(bdev->dev);
+
+	/* As explaination in drivers/mmc/core/sdio_bus.c tells us:
+	 * Unbound SDIO functions are always suspended.
+	 * During probe, the function is set active and the usage count
+	 * is incremented.  If the driver supports runtime PM,
+	 * it should call pm_runtime_put_noidle() in its probe routine and
+	 * pm_runtime_get_noresume() in its remove routine.
+	 *
+	 * So, put a pm_runtime_put_noidle here !
+	 */
+	pm_runtime_put_noidle(bdev->dev);
+
 	return 0;
 }
 
@@ -933,6 +1005,9 @@ static void btmtksdio_remove(struct sdio_func *func)
 	if (!bdev)
 		return;
 
+	/* Be consistent the state in btmtksdio_probe */
+	pm_runtime_get_noresume(bdev->dev);
+
 	hdev = bdev->hdev;
 
 	sdio_set_drvdata(func, NULL);
@@ -940,15 +1015,84 @@ static void btmtksdio_remove(struct sdio_func *func)
 	hci_free_dev(hdev);
 }
 
+#ifdef CONFIG_PM
+static int btmtksdio_runtime_suspend(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct btmtksdio_dev *bdev;
+	u32 status;
+	int err;
+
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return 0;
+
+	sdio_claim_host(bdev->func);
+
+	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
+	if (err < 0)
+		goto out;
+
+	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
+				 !(status & C_COM_DRV_OWN), 2000, 1000000);
+out:
+	bt_dev_info(bdev->hdev, "status (%d) return ownership to device", err);
+
+	sdio_release_host(bdev->func);
+
+	return err;
+}
+
+static int btmtksdio_runtime_resume(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct btmtksdio_dev *bdev;
+	u32 status;
+	int err;
+
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return 0;
+
+	sdio_claim_host(bdev->func);
+
+	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
+	if (err < 0)
+		goto out;
+
+	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
+				 status & C_COM_DRV_OWN, 2000, 1000000);
+out:
+	bt_dev_info(bdev->hdev, "status (%d) get ownership from device", err);
+
+	sdio_release_host(bdev->func);
+
+	return err;
+}
+
+static UNIVERSAL_DEV_PM_OPS(btmtksdio_pm_ops, btmtksdio_runtime_suspend,
+			    btmtksdio_runtime_resume, NULL);
+#define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
+#else	/* CONFIG_PM */
+#define BTMTKSDIO_PM_OPS NULL
+#endif	/* CONFIG_PM */
+
 static struct sdio_driver btmtksdio_driver = {
 	.name		= "btmtksdio",
 	.probe		= btmtksdio_probe,
 	.remove		= btmtksdio_remove,
 	.id_table	= btmtksdio_table,
+	.drv = {
+		.owner = THIS_MODULE,
+		.pm = BTMTKSDIO_PM_OPS,
+	}
 };
 
 module_sdio_driver(btmtksdio_driver);
 
+module_param(enable_autosuspend, bool, 0644);
+MODULE_PARM_DESC(enable_autosuspend, "Enable autosuspend by default");
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth SDIO driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.18.0
