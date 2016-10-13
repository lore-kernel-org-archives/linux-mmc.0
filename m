From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/6] mmc: rtsx_usb_sdmmc: Enable runtime PM autosuspend
Date: Thu, 13 Oct 2016 13:37:39 +0200
Message-ID: <1476358660-8338-6-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33558 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754539AbcJMLia (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 07:38:30 -0400
Received: by mail-lf0-f54.google.com with SMTP id x79so135049409lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 04:38:02 -0700 (PDT)
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

Enable runtime PM autosuspend for the rtsx_usb_sdmmc driver to avoid the
device being runtime suspended and runtime resumed between each request.
Let's use a default timeout of 50ms, to be consistent with other mmc hosts.

Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 6e9c0f8..dc1abd1 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1374,6 +1374,8 @@ static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
 
 	mutex_init(&host->host_mutex);
 	rtsx_usb_init_host(host);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_enable(&pdev->dev);
 
 #ifdef RTSX_USB_USE_LEDS_CLASS
@@ -1428,6 +1430,7 @@ static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 
 	mmc_free_host(mmc);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 
 	dev_dbg(&(pdev->dev),
-- 
1.9.1

