From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/21] mmc: sh_mmcif: Remove unused ccs_unsupported from the platform data
Date: Fri, 30 Dec 2016 13:47:18 +0100
Message-ID: <1483102054-1752-6-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32788 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3MsC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:02 -0500
Received: by mail-lf0-f49.google.com with SMTP id c13so236665794lfg.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:02 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

There are currently no users of the ccs_unsupported member from the
platform data, so let's remove it.

Note, as some of the sh_mmcif variants may not support ccs, let's keep the
current code in the driver, which deals with this. For future support, we
should invent a DT binding instead, but let's leave that until it's needed.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c  | 2 +-
 include/linux/mmc/sh_mmcif.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7ba92a4..9fa8ce3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1427,7 +1427,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->addr	= reg;
 	host->timeout	= msecs_to_jiffies(10000);
-	host->ccs_enable = !pd || !pd->ccs_unsupported;
+	host->ccs_enable = true;
 	host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
 
 	host->pd = pdev;
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 7cafc95..384b86b 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -34,7 +34,6 @@
 struct sh_mmcif_plat_data {
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
-	bool			ccs_unsupported : 1;
 	bool			clk_ctrl2_present : 1;
 	u8			sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
 	unsigned long		caps;
-- 
1.9.1

