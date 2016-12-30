From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/21] mmc: sh_mmcif: Remove unused use_cd_gpio/cd_gpio from platform data
Date: Fri, 30 Dec 2016 13:47:16 +0100
Message-ID: <1483102054-1752-4-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36349 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3Mr5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:47:57 -0500
Received: by mail-lf0-f48.google.com with SMTP id t196so236780382lff.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:47:56 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c  | 6 ------
 include/linux/mmc/sh_mmcif.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9007784..5f97055 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1509,12 +1509,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pd && pd->use_cd_gpio) {
-		ret = mmc_gpio_request_cd(mmc, pd->cd_gpio, 0);
-		if (ret < 0)
-			goto err_clk;
-	}
-
 	mutex_init(&host->thread_lock);
 
 	ret = mmc_add_host(mmc);
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index ccd8fb2..5ce5a2c 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -35,10 +35,8 @@ struct sh_mmcif_plat_data {
 	int (*get_cd)(struct platform_device *pdef);
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
-	bool			use_cd_gpio : 1;
 	bool			ccs_unsupported : 1;
 	bool			clk_ctrl2_present : 1;
-	unsigned int		cd_gpio;
 	u8			sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
 	unsigned long		caps;
 	u32			ocr;
-- 
1.9.1

