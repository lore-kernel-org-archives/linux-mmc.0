From: Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v3 1/1] mmc: dw_mmc: Add runtime pm to dw_mmc
Date: Mon, 09 Mar 2015 14:46:37 +0100
Message-ID: <1425908798-9906-2-git-send-email-k.wrona@samsung.com>
References: <1425908798-9906-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425908798-9906-1-git-send-email-k.wrona@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds runtime pm handling to dw_mmc.
It mainly uses mci_request/mci_request_end for mmc host state information.
The goal of the runtime pm in dw_mmc host is mainly for giving an information
for containing it power domain about its activity.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |  103 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.h |    2 +
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..4f45932 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/pm_runtime.h>
 
 #include "dw_mmc.h"
 
@@ -113,6 +114,8 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
 	struct mmc_command *stop;
 	struct mmc_data	*data;
 
+	pm_runtime_get_sync(slot->host->dev);
+
 	/* Make sure we get a consistent snapshot */
 	spin_lock_bh(&slot->host->lock);
 	mrq = slot->mrq;
@@ -142,6 +145,9 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
 
 	spin_unlock_bh(&slot->host->lock);
 
+	pm_runtime_mark_last_busy(slot->host->dev);
+	pm_runtime_put_autosuspend(slot->host->dev);
+
 	return 0;
 }
 
@@ -1071,6 +1077,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(slot->mrq);
 
+	pm_runtime_get_sync(host->dev);
+
 	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
@@ -1082,6 +1090,9 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		spin_unlock_bh(&host->lock);
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
+
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
 		return;
 	}
 
@@ -1109,6 +1120,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		slot->ctype = SDMMC_CTYPE_1BIT;
 	}
 
+	pm_runtime_get_sync(slot->host->dev);
+
 	regs = mci_readl(slot->host, UHS_REG);
 
 	/* DDR mode set */
@@ -1139,7 +1152,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				dev_err(slot->host->dev,
 					"failed to enable vmmc regulator\n");
 				/*return, if failed turn on vmmc*/
-				return;
+				goto _end;
 			}
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
@@ -1192,6 +1205,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
 		slot->host->state = STATE_IDLE;
+
+_end:
+	pm_runtime_mark_last_busy(slot->host->dev);
+	pm_runtime_put_autosuspend(slot->host->dev);
 }
 
 static int dw_mci_card_busy(struct mmc_host *mmc)
@@ -1199,12 +1216,17 @@ static int dw_mci_card_busy(struct mmc_host *mmc)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	u32 status;
 
+	pm_runtime_get_sync(slot->host->dev);
+
 	/*
 	 * Check the busy bit which is low when DAT[3:0]
 	 * (the data lines) are 0000
 	 */
 	status = mci_readl(slot->host, STATUS);
 
+	pm_runtime_mark_last_busy(slot->host->dev);
+	pm_runtime_put_autosuspend(slot->host->dev);
+
 	return !!(status & SDMMC_STATUS_BUSY);
 }
 
@@ -1217,6 +1239,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	int min_uv, max_uv;
 	int ret;
 
+	pm_runtime_get_sync(host->dev);
+
 	/*
 	 * Program the voltage.  Note that some instances of dw_mmc may use
 	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
@@ -1239,11 +1263,17 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 			dev_dbg(&mmc->class_dev,
 					 "Regulator set error %d: %d - %d\n",
 					 ret, min_uv, max_uv);
+
+			pm_runtime_mark_last_busy(host->dev);
+			pm_runtime_put_autosuspend(host->dev);
 			return ret;
 		}
 	}
 	mci_writel(host, UHS_REG, uhs);
 
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 }
 
@@ -1253,6 +1283,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	int gpio_ro = mmc_gpio_get_ro(mmc);
 
+	pm_runtime_get_sync(slot->host->dev);
+
 	/* Use platform get_ro function, else try on board write protect */
 	if ((slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) ||
 			(slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT))
@@ -1263,6 +1295,9 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 		read_only =
 			mci_readl(slot->host, WRTPRT) & (1 << slot->id) ? 1 : 0;
 
+	pm_runtime_mark_last_busy(slot->host->dev);
+	pm_runtime_put_autosuspend(slot->host->dev);
+
 	dev_dbg(&mmc->class_dev, "card is %s\n",
 		read_only ? "read-only" : "read-write");
 
@@ -1277,6 +1312,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	struct dw_mci *host = slot->host;
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
+	pm_runtime_get_sync(host->dev);
+
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
@@ -1296,6 +1333,9 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	}
 	spin_unlock_bh(&host->lock);
 
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return present;
 }
 
@@ -1304,6 +1344,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 
+	pm_runtime_get_sync(host->dev);
+
 	/*
 	 * Low power mode will stop the card clock when idle.  According to the
 	 * description of the CLKENA register we should disable low power mode
@@ -1331,6 +1373,9 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 				     SDMMC_CMD_PRV_DAT_WAIT, 0);
 		}
 	}
+
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 }
 
 static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
@@ -1340,6 +1385,9 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	unsigned long irqflags;
 	u32 int_mask;
 
+	if (enb)
+		pm_runtime_get_sync(slot->host->dev);
+
 	spin_lock_irqsave(&host->irq_lock, irqflags);
 
 	/* Enable/disable Slot Specific SDIO interrupt */
@@ -1351,6 +1399,12 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	mci_writel(host, INTMASK, int_mask);
 
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+
+	/* If interrupt is enabled leave device active. */
+	if (!enb) {
+		pm_runtime_mark_last_busy(slot->host->dev);
+		pm_runtime_put_autosuspend(slot->host->dev);
+	}
 }
 
 static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
@@ -1360,8 +1414,14 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int err = -ENOSYS;
 
+	pm_runtime_get_sync(host->dev);
+
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot);
+
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return err;
 }
 
@@ -1371,9 +1431,14 @@ static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 
+	pm_runtime_get_sync(host->dev);
+
 	if (drv_data && drv_data->prepare_hs400_tuning)
 		return drv_data->prepare_hs400_tuning(host, ios);
 
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 }
 
@@ -1414,10 +1479,14 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	} else {
 		dev_vdbg(host->dev, "list empty\n");
 
-		if (host->state == STATE_SENDING_CMD11)
+		if (host->state == STATE_SENDING_CMD11) {
 			host->state = STATE_WAITING_CMD11_DONE;
-		else
+		} else {
+			pm_runtime_mark_last_busy(host->dev);
+			pm_runtime_put_autosuspend(host->dev);
+
 			host->state = STATE_IDLE;
+		}
 	}
 
 	spin_unlock(&host->lock);
@@ -2688,6 +2757,11 @@ int dw_mci_probe(struct dw_mci *host)
 		return -ENODEV;
 	}
 
+	pm_runtime_enable(host->dev);
+	pm_runtime_get_sync(host->dev);
+	pm_runtime_set_autosuspend_delay(host->dev, DWMMC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(host->dev);
+
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
@@ -2877,6 +2951,9 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
 		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
 
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 
 err_dmaunmap:
@@ -2891,6 +2968,9 @@ err_clk_biu:
 	if (!IS_ERR(host->biu_clk))
 		clk_disable_unprepare(host->biu_clk);
 
+	pm_runtime_put_sync(host->dev);
+	pm_runtime_disable(host->dev);
+
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_probe);
@@ -2899,6 +2979,8 @@ void dw_mci_remove(struct dw_mci *host)
 {
 	int i;
 
+	pm_runtime_get_sync(host->dev);
+
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
 
@@ -2915,6 +2997,9 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	pm_runtime_put_sync(host->dev);
+	pm_runtime_disable(host->dev);
+
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
 
@@ -2937,11 +3022,14 @@ EXPORT_SYMBOL(dw_mci_suspend);
 
 int dw_mci_resume(struct dw_mci *host)
 {
-	int i, ret;
+	int i;
+
+	pm_runtime_get_sync(host->dev);
 
 	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
-		ret = -ENODEV;
-		return ret;
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
+		return -ENODEV;
 	}
 
 	if (host->use_dma && host->dma_ops->init)
@@ -2976,6 +3064,9 @@ int dw_mci_resume(struct dw_mci *host)
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_resume);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index d239867..2317f4b7 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -209,6 +209,8 @@ extern int dw_mci_suspend(struct dw_mci *host);
 extern int dw_mci_resume(struct dw_mci *host);
 #endif
 
+#define DWMMC_AUTOSUSPEND_DELAY 50
+
 /**
  * struct dw_mci_slot - MMC slot state
  * @mmc: The mmc_host representing this slot.
-- 
1.7.9.5
