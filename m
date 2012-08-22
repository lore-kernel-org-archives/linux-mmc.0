From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 2/2] mmc: dw_mmc: Add a DISABLE_MMC quirk that sets the core mmc cap
Date: Tue, 21 Aug 2012 21:05:18 -0700
Message-ID: <1345608318-15347-2-git-send-email-dianders@chromium.org>
References: <1345608318-15347-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f202.google.com ([209.85.161.202]:38762 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2HVEF5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 00:05:57 -0400
Received: by ggnu1 with SMTP id u1so72610ggn.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Aug 2012 21:05:56 -0700 (PDT)
In-Reply-To: <1345608318-15347-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Alim Akhtar <alim.akhtar@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Doug Anderson <dianders@chromium.org>

On some systems we need a way to disable MMC card support in a MMC/SD
card slot.  Add support in the dw_mmc to support this.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c  |    3 +++
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index af40d22..09111bf 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1810,6 +1810,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
+	if (host->pdata->quirks & DW_MCI_QUIRK_DISABLE_MMC)
+		mmc->caps2 |= MMC_CAP2_NO_MMC;
+
 	if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
 		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
 	else
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 7a7ebd3..5eaa9b9 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -201,6 +201,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/* Only support SD cards, not MMC */
+#define DW_MCI_QUIRK_DISABLE_MMC		BIT(4)
 
 
 struct dma_pdata;
-- 
1.7.7.3

