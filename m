Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2B28D82A
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592973; cv=none; b=LYtFuJVLCx6ypp1OFo1TzGNR8twQqWMRfwnE4GAcKqNbNUtUX67VD4ZygMY1tYr1HCxZwb272dxFjwM0hP3cuOkAECOEGvh9ReuxQ5w0gO7psZd7UEesijmOckbmBp4IHSt4cui4nu+TZEUnRPUA/7cZImMMteNJ4HY2nSDLo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592973; c=relaxed/simple;
	bh=nDbdPA9ndGVjTQeDdCrcstq8/o/mLx5PUKUleDJKv0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFUtFWUwsLoUJos97ITjdqHvpNB3CGzsPGw8ChT/+DdR8y56n+aS+leSFzJyJi06HyTHuSo+YO5cOLlRlR+aZR7fO/FwXhCihiNm1DpoGg7TA7PDKV1qlIXu87hX8+d3kUqUudvMjpuTMmU89AoDailARTmI6txLoI/siU7AukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfCiektz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfCiektz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767592969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llFKcS1KI3udgKGsj6Aicnjnw1BtILGJ2Zx4ZI9yBZI=;
	b=xfCiektzLzvGnrVOu+FgzbEulUkqobWfEgwZJ4GFXR0pUME8+T673OYWACOGSHkOupZrj0
	PRSDy7+t0bt2d+HwpCwCizPABVpzli6ZM5d8GFgnhzoHZzfZojeDhhHeMvP4PCcWpM7h/T
	gRbfrwWemKdvhRCoYdURuL2kAnegrMc=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricky Wu <ricky_wu@realtek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 1/2] mmc: rtsx: reset power state on suspend
Date: Sun,  4 Jan 2026 22:02:35 -0800
Message-ID: <20260105060236.400366-2-matthew.schwartz@linux.dev>
In-Reply-To: <20260105060236.400366-1-matthew.schwartz@linux.dev>
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
to skip reinitialization on the next I/O request, leading to DMA transfer
timeouts and errors on resume 20% of the time.

Add a power_off slot callback so the PCR can notify the sdmmc driver
during suspend. The sdmmc driver resets prev_power_state, and sd_request
checks this to reinitialize the card before the next I/O.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 22 ++++++++++++++++++++++
 include/linux/rtsx_common.h        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index f9952d76d6ed..f1f4d8ed544d 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1654,6 +1654,7 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 	struct pci_dev *pcidev = to_pci_dev(dev_d);
 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
 	struct rtsx_pcr *pcr = handle->pcr;
+	struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
 
 	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
 
@@ -1661,6 +1662,9 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 
 	mutex_lock(&pcr->pcr_mutex);
 
+	if (slot->p_dev && slot->power_off)
+		slot->power_off(slot->p_dev);
+
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3, false);
 
 	mutex_unlock(&pcr->pcr_mutex);
@@ -1772,12 +1776,17 @@ static int rtsx_pci_runtime_suspend(struct device *device)
 	struct pci_dev *pcidev = to_pci_dev(device);
 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
 	struct rtsx_pcr *pcr = handle->pcr;
+	struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
 
 	dev_dbg(device, "--> %s\n", __func__);
 
 	cancel_delayed_work_sync(&pcr->carddet_work);
 
 	mutex_lock(&pcr->pcr_mutex);
+
+	if (slot->p_dev && slot->power_off)
+		slot->power_off(slot->p_dev);
+
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3, true);
 
 	mutex_unlock(&pcr->pcr_mutex);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 792ebae46697..74ee8623ad4e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -47,6 +47,7 @@ struct realtek_pci_sdmmc {
 };
 
 static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
+static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode);
 
 static inline struct device *sdmmc_dev(struct realtek_pci_sdmmc *host)
 {
@@ -821,6 +822,15 @@ static void sd_request(struct work_struct *work)
 
 	rtsx_pci_start_run(pcr);
 
+	if (host->prev_power_state == MMC_POWER_OFF) {
+		err = sd_power_on(host, MMC_POWER_ON);
+		if (err) {
+			cmd->error = err;
+			mutex_unlock(&pcr->pcr_mutex);
+			goto finish;
+		}
+	}
+
 	rtsx_pci_switch_clock(pcr, host->clock, host->ssc_depth,
 			host->initial_mode, host->double_clk, host->vpclk);
 	rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, SD_MOD_SEL);
@@ -1524,6 +1534,16 @@ static void rtsx_pci_sdmmc_card_event(struct platform_device *pdev)
 	mmc_detect_change(host->mmc, 0);
 }
 
+static void rtsx_pci_sdmmc_power_off(struct platform_device *pdev)
+{
+	struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
+
+	if (!host)
+		return;
+
+	host->prev_power_state = MMC_POWER_OFF;
+}
+
 static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
@@ -1556,6 +1576,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	pcr->slots[RTSX_SD_CARD].p_dev = pdev;
 	pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
+	pcr->slots[RTSX_SD_CARD].power_off = rtsx_pci_sdmmc_power_off;
 
 	mutex_init(&host->host_mutex);
 
@@ -1587,6 +1608,7 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	pcr = host->pcr;
 	pcr->slots[RTSX_SD_CARD].p_dev = NULL;
 	pcr->slots[RTSX_SD_CARD].card_event = NULL;
+	pcr->slots[RTSX_SD_CARD].power_off = NULL;
 	mmc = host->mmc;
 
 	cancel_work_sync(&host->work);
diff --git a/include/linux/rtsx_common.h b/include/linux/rtsx_common.h
index da9c8c6b5d50..f294f478f0c0 100644
--- a/include/linux/rtsx_common.h
+++ b/include/linux/rtsx_common.h
@@ -32,6 +32,7 @@ struct platform_device;
 struct rtsx_slot {
 	struct platform_device	*p_dev;
 	void			(*card_event)(struct platform_device *p_dev);
+	void			(*power_off)(struct platform_device *p_dev);
 };
 
 #endif
-- 
2.52.0

