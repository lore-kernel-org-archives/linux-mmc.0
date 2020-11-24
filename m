Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4691C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 06:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7820657
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKXGCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 01:02:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49982 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgKXGCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 01:02:38 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AO62B0Y0025905, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AO62B0Y0025905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 14:02:11 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 24 Nov 2020 14:02:11 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 24 Nov
 2020 14:02:11 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>, <bhelgaas@google.com>,
        <ricky_wu@realtek.com>, <vaibhavgupta40@gmail.com>,
        <kdlnx@doth.eu>, <dianders@chromium.org>, <rmfrfs@gmail.com>,
        <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH] misc: rtsx: rts5249 support runtime PM
Date:   Tue, 24 Nov 2020 14:02:02 +0800
Message-ID: <20201124060202.776-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMBS01.realtek.com.tw (172.21.6.36)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

rtsx_pci_sdmmc: add to support autosuspend when the rtd3_en is set

rtsx_pcr: add callback functions about runtime PM
add delay_work(rtd3_work) to decrease usage count to 0 when staying
at idle over 10 sec

rts5249: add extra flow at init function to support wakeup from d3
and set rtd3_en from register setting

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5249.c  |  25 ++++--
 drivers/misc/cardreader/rtsx_pcr.c | 122 +++++++++++++++++++++++++++--
 drivers/misc/cardreader/rtsx_pcr.h |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c  |  18 ++++-
 include/linux/rtsx_pci.h           |   1 +
 5 files changed, 152 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index b85279f1fc5e..1da3b1ca1121 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -65,7 +65,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr_dbg(pcr, "skip fetch vendor setting\n");
 		return;
 	}
-
 	pcr->aspm_en = rtsx_reg_to_aspm(reg);
 	pcr->sd30_drive_sel_1v8 = rtsx_reg_to_sd30_drive_sel_1v8(reg);
 	pcr->card_drive_sel &= 0x3F;
@@ -73,6 +72,8 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
+
+	pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
 	if (rtsx_check_mmc_support(reg))
 		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
@@ -278,13 +279,25 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
 
-	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
 		rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN, PWD_SUSPND_EN);
-		rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
-		rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
+
+	if (pcr->rtd3_en) {
+		if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+			rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x01);
+			rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x30);
+		} else {
+			rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x01);
+			rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x33);
+		}
 	} else {
-		rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
-		rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
+		if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
+			rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
+			rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
+		} else {
+			rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
+			rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
+		}
 	}
 
 	/*
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 5d15607027e9..cb105563bde7 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -20,6 +20,8 @@
 #include <linux/rtsx_pci.h>
 #include <linux/mmc/card.h>
 #include <asm/unaligned.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include "rtsx_pcr.h"
 #include "rts5261.h"
@@ -89,9 +91,16 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   enable ? pcr->aspm_en : 0);
+	if (pcr->aspm_en & 0x02)
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+			FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+	else
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+			FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+
+	if (!enable && (pcr->aspm_en & 0x02))
+		mdelay(10);
+
 
 	pcr->aspm_enabled = enable;
 }
@@ -143,6 +152,9 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
 	/* If pci device removed, don't queue idle work any more */
 	if (pcr->remove_pci)
 		return;
+	if (pcr->rtd3_en)
+		if (pcr->pci->dev.power.usage_count.counter == 0)
+			pm_runtime_get(&(pcr->pci->dev));
 
 	if (pcr->state != PDEV_STAT_RUN) {
 		pcr->state = PDEV_STAT_RUN;
@@ -1075,6 +1087,19 @@ static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
 	rtsx_comm_pm_power_saving(pcr);
 }
 
+static void rtsx_pci_rtd3_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, rtd3_work);
+
+	pcr_dbg(pcr, "--> %s\n", __func__);
+
+	while (pcr->pci->dev.power.usage_count.counter > 0) {
+		if (pm_runtime_active(&(pcr->pci->dev)))
+			pm_runtime_put(&(pcr->pci->dev));
+	}
+}
+
 static void rtsx_pci_idle_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -1094,6 +1119,9 @@ static void rtsx_pci_idle_work(struct work_struct *work)
 	rtsx_pm_power_saving(pcr);
 
 	mutex_unlock(&pcr->pcr_mutex);
+
+	if (pcr->rtd3_en)
+		mod_delayed_work(system_wq, &pcr->rtd3_work, msecs_to_jiffies(10000));
 }
 
 static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
@@ -1283,7 +1311,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	/* Wait SSC power stable */
 	udelay(200);
 
-	rtsx_pci_disable_aspm(pcr);
+	rtsx_disable_aspm(pcr);
 	if (pcr->ops->optimize_phy) {
 		err = pcr->ops->optimize_phy(pcr);
 		if (err < 0)
@@ -1357,8 +1385,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_init_ocp(pcr);
 
 	/* Enable clk_request_n to enable clock power management */
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_CLKREQ_EN);
+	pci_write_config_byte(pdev, PCI_EXP_LNKCTL+1, 0x01);
 	/* Enter L1 when host tx idle */
 	pci_write_config_byte(pdev, 0x70F, 0x5B);
 
@@ -1368,6 +1395,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
+
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
 	 */
@@ -1571,6 +1600,12 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 		rtsx_pcr_cells[i].platform_data = handle;
 		rtsx_pcr_cells[i].pdata_size = sizeof(*handle);
 	}
+
+	if (pcr->rtd3_en) {
+		INIT_DELAYED_WORK(&pcr->rtd3_work, rtsx_pci_rtd3_work);
+		pm_runtime_enable(&pcidev->dev);
+	}
+
 	ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
 			ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
 	if (ret < 0)
@@ -1610,6 +1645,9 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 
 	pcr->remove_pci = true;
 
+	if (pcr->rtd3_en)
+		pm_runtime_get_noresume(&pcr->pci->dev);
+
 	/* Disable interrupts at the pcr level */
 	spin_lock_irq(&pcr->lock);
 	rtsx_pci_writel(pcr, RTSX_BIER, 0);
@@ -1619,6 +1657,9 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 	cancel_delayed_work_sync(&pcr->carddet_work);
 	cancel_delayed_work_sync(&pcr->idle_work);
 
+	if (pcr->rtd3_en)
+		cancel_delayed_work_sync(&pcr->rtd3_work);
+
 	mfd_remove_devices(&pcidev->dev);
 
 	dma_free_coherent(&(pcr->pci->dev), RTSX_RESV_BUF_LEN,
@@ -1635,6 +1676,11 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 	idr_remove(&rtsx_pci_idr, pcr->id);
 	spin_unlock(&rtsx_pci_lock);
 
+	if (pcr->rtd3_en) {
+		pm_runtime_disable(&pcr->pci->dev);
+		pm_runtime_put_noidle(&pcr->pci->dev);
+	}
+
 	kfree(pcr->slots);
 	kfree(pcr);
 	kfree(handle);
@@ -1716,13 +1762,75 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 		pci_disable_msi(pcr->pci);
 }
 
+static int rtsx_pci_runtime_suspend(struct device *device)
+{
+	struct pci_dev *pcidev = to_pci_dev(device);
+	struct pcr_handle *handle;
+	struct rtsx_pcr *pcr;
+
+	handle = pci_get_drvdata(pcidev);
+	pcr = handle->pcr;
+	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
+
+	cancel_delayed_work(&pcr->carddet_work);
+	cancel_delayed_work(&pcr->rtd3_work);
+	cancel_delayed_work(&pcr->idle_work);
+
+	mutex_lock(&pcr->pcr_mutex);
+	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
+
+	free_irq(pcr->irq, (void *)pcr);
+
+	mutex_unlock(&pcr->pcr_mutex);
+
+	return 0;
+}
+
+static int rtsx_pci_runtime_resume(struct device *device)
+{
+	struct pci_dev *pcidev = to_pci_dev(device);
+	struct pcr_handle *handle;
+	struct rtsx_pcr *pcr;
+	int ret = 0;
+
+	handle = pci_get_drvdata(pcidev);
+	pcr = handle->pcr;
+	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
+
+	mutex_lock(&pcr->pcr_mutex);
+
+	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
+	rtsx_pci_acquire_irq(pcr);
+	synchronize_irq(pcr->irq);
+
+	if (pcr->ops->fetch_vendor_settings)
+		pcr->ops->fetch_vendor_settings(pcr);
+
+	rtsx_pci_init_hw(pcr);
+
+	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
+		pcr->slots[RTSX_SD_CARD].card_event(
+				pcr->slots[RTSX_SD_CARD].p_dev);
+	}
+
+	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
+
+	mutex_unlock(&pcr->pcr_mutex);
+	return ret;
+}
+
 #else /* CONFIG_PM */
 
 #define rtsx_pci_shutdown NULL
+#define rtsx_pci_runtime_suspend NULL
+#define rtsx_pic_runtime_resume NULL
 
 #endif /* CONFIG_PM */
 
-static SIMPLE_DEV_PM_OPS(rtsx_pci_pm_ops, rtsx_pci_suspend, rtsx_pci_resume);
+static const struct dev_pm_ops rtsx_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
+	SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume, NULL)
+};
 
 static struct pci_driver rtsx_pci_driver = {
 	.name = DRV_NAME_RTSX_PCI,
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index fe5f4ca0f937..daf057c4eea6 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -90,6 +90,7 @@ static inline u8 map_sd_drive(int idx)
 
 #define rtsx_check_mmc_support(reg)		((reg) & 0x10)
 #define rtsx_reg_to_rtd3(reg)				((reg) & 0x02)
+#define rtsx_reg_to_rtd3_uhsii(reg)				((reg) & 0x04)
 #define rtsx_reg_to_aspm(reg)			(((reg) >> 28) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 26) & 0x03)
 #define rtsx_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 5) & 0x03)
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index eb395e144207..02f31f4d0944 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -20,6 +20,7 @@
 #include <linux/mmc/card.h>
 #include <linux/rtsx_pci.h>
 #include <asm/unaligned.h>
+#include <linux/pm_runtime.h>
 
 struct realtek_pci_sdmmc {
 	struct platform_device	*pdev;
@@ -953,7 +954,6 @@ static int sd_set_power_mode(struct realtek_pci_sdmmc *host,
 		unsigned char power_mode)
 {
 	int err;
-
 	if (power_mode == MMC_POWER_OFF)
 		err = sd_power_off(host);
 	else
@@ -1249,7 +1249,7 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 
 out:
 	/* Stop toggle SD clock in idle */
-	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
+	rtsx_pci_write_register(pcr, SD_BUS_STAT,
 			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 
 	mutex_unlock(&pcr->pcr_mutex);
@@ -1343,6 +1343,7 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct rtsx_pcr *pcr = host->pcr;
 
 	mmc->f_min = 250000;
 	mmc->f_max = 208000000;
@@ -1350,6 +1351,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
+	if (pcr->rtd3_en)
+		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
@@ -1407,6 +1410,12 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	realtek_init_host(host);
 
+	if (pcr->rtd3_en) {
+		pm_runtime_use_autosuspend(&pdev->dev);
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+		pm_runtime_enable(&pdev->dev);
+	}
+
 	mmc_add_host(mmc);
 
 	return 0;
@@ -1426,6 +1435,11 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
 	mmc = host->mmc;
 
+	if (pcr->rtd3_en) {
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
 	cancel_work_sync(&host->work);
 
 	mutex_lock(&host->host_mutex);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 745f5e73f99a..689d955c2246 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1174,6 +1174,7 @@ struct rtsx_pcr {
 
 	struct delayed_work		carddet_work;
 	struct delayed_work		idle_work;
+	struct delayed_work		rtd3_work;
 
 	spinlock_t			lock;
 	struct mutex			pcr_mutex;
-- 
2.17.1

