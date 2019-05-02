From: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: [PATCH] mmc: alcor: Drop pointer to mmc_host from alcor_sdmmc_host
Date: Thu,  2 May 2019 11:28:16 +0530
Message-ID: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>, Lukas Wunner <lukas@wunner.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kamlesh.gurudasani@gmail.com
List-Id: linux-mmc@vger.kernel.org

The driver for Alcor Micro AU6601 and AU6621 controllers uses a pointer to
get from the private alcor_sdmmc_host structure to the generic mmc_host
structure. However the latter is always immediately preceding the former in
memory, so compute its address with a subtraction (which is cheaper than a
dereference) and drop the superfluous pointer.

No functional change intended.

Signed-off-by: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
---
 drivers/mmc/host/alcor.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 7c8f203..5bba6ee 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -43,7 +43,6 @@ struct alcor_sdmmc_host {
 	struct  device *dev;
 	struct alcor_pci_priv *alcor_pci;
 
-	struct mmc_host *mmc;
 	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
@@ -276,7 +275,7 @@ static void alcor_send_cmd(struct alcor_sdmmc_host *host,
 		break;
 	default:
 		dev_err(host->dev, "%s: cmd->flag (0x%02x) is not valid\n",
-			mmc_hostname(host->mmc), mmc_resp_type(cmd));
+			mmc_hostname(mmc_from_priv(host)), mmc_resp_type(cmd));
 		break;
 	}
 
@@ -317,7 +316,7 @@ static void alcor_request_complete(struct alcor_sdmmc_host *host,
 	host->data = NULL;
 	host->dma_on = 0;
 
-	mmc_request_done(host->mmc, mrq);
+	mmc_request_done(mmc_from_priv(host), mrq);
 }
 
 static void alcor_finish_data(struct alcor_sdmmc_host *host)
@@ -547,7 +546,7 @@ static void alcor_cd_irq(struct alcor_sdmmc_host *host, u32 intmask)
 		alcor_request_complete(host, 1);
 	}
 
-	mmc_detect_change(host->mmc, msecs_to_jiffies(1));
+	mmc_detect_change(mmc_from_priv(host), msecs_to_jiffies(1));
 }
 
 static irqreturn_t alcor_irq_thread(int irq, void *d)
@@ -1025,7 +1024,7 @@ static void alcor_hw_uninit(struct alcor_sdmmc_host *host)
 
 static void alcor_init_mmc(struct alcor_sdmmc_host *host)
 {
-	struct mmc_host *mmc = host->mmc;
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	mmc->f_min = AU6601_MIN_CLOCK;
 	mmc->f_max = AU6601_MAX_CLOCK;
@@ -1073,7 +1072,6 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	}
 
 	host = mmc_priv(mmc);
-	host->mmc = mmc;
 	host->dev = &pdev->dev;
 	host->cur_power_mode = MMC_POWER_UNDEFINED;
 	host->alcor_pci = priv;
@@ -1105,13 +1103,14 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct alcor_sdmmc_host *host = dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	if (cancel_delayed_work_sync(&host->timeout_work))
 		alcor_request_complete(host, 0);
 
 	alcor_hw_uninit(host);
-	mmc_remove_host(host->mmc);
-	mmc_free_host(host->mmc);
+	mmc_remove_host(mmc);
+	mmc_free_host(mmc);
 
 	return 0;
 }
-- 
2.7.4
