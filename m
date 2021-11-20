Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20EC433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Nov 2021 11:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhKTLfr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Nov 2021 06:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhKTLfr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Nov 2021 06:35:47 -0500
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Nov 2021 03:32:44 PST
Received: from danwin1210.me (danwin1210.me [IPv6:2a01:4f8:c010:d56::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C2C061574
        for <linux-mmc@vger.kernel.org>; Sat, 20 Nov 2021 03:32:44 -0800 (PST)
Received: from danwin1210.me (unknown [10.9.0.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X448 server-signature ECDSA (P-384) server-digest SHA384
         client-signature ED448)
        (Client CN "danwin1210.me", Issuer "danwin1210.me" (verified OK))
        by mail.danwin1210.me (Postfix) with ESMTPS id 3263B1F558;
        Sat, 20 Nov 2021 11:23:35 +0000 (UTC)
Received: from prine.. (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by danwin1210.me (Postfix) with ESMTPSA id 613115A22C;
        Sat, 20 Nov 2021 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danwin1210.me;
        s=mail; t=1637407414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jUYdi6dVoR8O7AsyjiSRsSKtM7Q3dq3QhRqgbWsm8IA=;
        b=dscHkhzHz+PhtazDmH8zZdctpJy+iTmwmqd9uUhlKxhk+bbADeAmCpxwpoRteyUfeAOFAH
        2XviiVnTOnhONfy+CpkLN9X5KpmdRb9Ac5Tb3F+mVHh21HaJ5MMr9MumKMpLIk8UGRH2dz
        jgI5mBgFw02fpkACfH0jxmJh9XQSP0qRc+2/IrKk/5R9Ppw+qfGPClfFWFvs+8GtfUMY6E
        U2xAUS9ogU5tPGl288336d9NHWGtKH56EpeLtSN/J3Eb7R2bPQk16CfzAM7Mx2ta6PmaZQ
        r0liyeLoS8rBgHwhygO8G1Z87Q40Mk03NgSDGKBkwk3OPpOWYlkFNNGEAzuGVzeZ3oCg65
        MybxtidTdfZBej0DAzzxqwuEcSZyoIPIRlinD01o+RABMRJ/WspxmP6RSt11hzJg3NPcMr
        7Tx2dchiSuvyx8FXXuGz1YXXhaq1K+vBkHy4CIoSW2dc3GwqG9OnNDU0vj1S0KQczng+RV
        p3KNvYGdBqOw6O2HOa/LuWKENtpo1MAKvl5hVLkG7WcjjK5dSs1d95pW2zzXwvWr3gocG7
        gxnCxLLrYq4Yk7L50wwWpdqBQAY2mKlenHK8mkEE3xt4e4c1uGTrOH6CdHdDKnx7UTJj01
        d5VxQlVfNJ3C0DW8Y1AGn/Lynh7qxZF+vRdutTm3zxfrqv6JJbmpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=danwin1210.me;
        s=ed25519; t=1637407414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jUYdi6dVoR8O7AsyjiSRsSKtM7Q3dq3QhRqgbWsm8IA=;
        b=jGdZCyrPg7xKtUTGZFpAfQ986QoH3KIjCb6MhNK/4EplDV58L3exhzB4v9M6sGV5tdNL1R
        q/GiyVV2BF4veVDg==
From:   Kyle Copperfield <kmcopper@danwin1210.me>
To:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kyle Copperfield <kmcopper@danwin1210.me>,
        Manish Narani <manish.narani@xilinx.com>,
        Dragan Simic <dragan.simic@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: arasan: add runtime power management support
Date:   Sat, 20 Nov 2021 11:23:17 +0000
Message-Id: <20211120112318.10474-1-kmcopper@danwin1210.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add runtime power management support in Arasan SDHCI driver.

This patch is largely based on the original Arasan PM patch from
https://lore.kernel.org/linux-mmc/1537283046-13985-1-git-send-email-manish.narani@xilinx.com/
that was left abandoned since 2018 for an unknown reason.

Changes made to the original patch include reducing the runtime
suspend timeout to 50 ms and reusing the runtime PM configuration
found in sdhci-of-at91 driver.

Power consumption is measurably reduced on the Pinebook Pro and
PinePhone Pro, on which the patch was tested.  More precisely,
a reduction of about 200 mW was measured on the latter.

Originally-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Dragan Simic <dragan.simic@gmail.com>
Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
---
 drivers/mmc/host/sdhci-of-arasan.c | 88 +++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 737e2bfdedc2..63095d91a672 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
@@ -27,6 +28,7 @@
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
 
+#define SDHCI_ARASAN_AUTOSUSPEND_DELAY	50 /* ms */
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
 #define SDHCI_ARASAN_ITAPDLY_REGISTER	0xF0F8
@@ -456,6 +458,70 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static int __maybe_unused sdhci_arasan_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (sdhci_arasan->has_cqe) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	clk_disable(pltfm_host->clk);
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_arasan_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_enable(sdhci_arasan->clk_ahb);
+	if (ret) {
+		dev_err(dev, "Cannot enable AHB clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(pltfm_host->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable SD clock: %d\n", ret);
+		goto err_clk_ahb;
+	}
+
+	ret = sdhci_runtime_resume_host(host, 0);
+	if (ret)
+		goto err_clk_disable;
+
+	if (sdhci_arasan->has_cqe)
+		return cqhci_resume(host->mmc);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable(pltfm_host->clk);
+err_clk_ahb:
+	clk_disable(sdhci_arasan->clk_ahb);
+
+	return ret;
+}
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -552,8 +618,10 @@ static int sdhci_arasan_resume(struct device *dev)
 }
 #endif /* ! CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
-			 sdhci_arasan_resume);
+static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
+	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
+			   sdhci_arasan_runtime_resume, NULL) };
 
 /**
  * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
@@ -1681,13 +1749,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SDHCI_ARASAN_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	ret = sdhci_arasan_add_host(sdhci_arasan);
 	if (ret)
 		goto err_add_host;
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_add_host:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
 unreg_clk:
@@ -1715,6 +1795,10 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 		phy_exit(sdhci_arasan->phy);
 	}
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 
 	ret = sdhci_pltfm_unregister(pdev);
-- 
2.34.0

