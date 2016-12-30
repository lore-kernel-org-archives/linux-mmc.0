From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/21] mmc: sh_mmcif: Remove unused ->get_cd() platform callback
Date: Fri, 30 Dec 2016 13:47:17 +0100
Message-ID: <1483102054-1752-5-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35605 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3Mr7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:47:59 -0500
Received: by mail-lf0-f48.google.com with SMTP id b14so236435439lfg.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:47:59 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Removing the callback also enables us to remove the sh_mmcif_get_cd()
altogether, as we convert to use mmc_gpio_get_cd() to the same kind of
work.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c  | 18 +-----------------
 include/linux/mmc/sh_mmcif.h |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5f97055..7ba92a4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1079,26 +1079,10 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->state = STATE_IDLE;
 }
 
-static int sh_mmcif_get_cd(struct mmc_host *mmc)
-{
-	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct device *dev = sh_mmcif_host_to_dev(host);
-	struct sh_mmcif_plat_data *p = dev->platform_data;
-	int ret = mmc_gpio_get_cd(mmc);
-
-	if (ret >= 0)
-		return ret;
-
-	if (!p || !p->get_cd)
-		return -ENOSYS;
-	else
-		return p->get_cd(host->pd);
-}
-
 static struct mmc_host_ops sh_mmcif_ops = {
 	.request	= sh_mmcif_request,
 	.set_ios	= sh_mmcif_set_ios,
-	.get_cd		= sh_mmcif_get_cd,
+	.get_cd		= mmc_gpio_get_cd,
 };
 
 static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 5ce5a2c..7cafc95 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -32,7 +32,6 @@
  */
 
 struct sh_mmcif_plat_data {
-	int (*get_cd)(struct platform_device *pdef);
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
 	bool			ccs_unsupported : 1;
-- 
1.9.1

