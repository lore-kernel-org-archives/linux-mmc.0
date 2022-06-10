Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1B8CCA480
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jun 2022 21:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350876AbiFJVNg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350883AbiFJVNX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2022 17:13:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C61139
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jun 2022 14:13:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwQ-0007EU-Lr; Fri, 10 Jun 2022 23:13:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwM-007eRf-Ef; Fri, 10 Jun 2022 23:13:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwK-00FTcu-57; Fri, 10 Jun 2022 23:13:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mmc: sdhci-st: Obviously always return success in remove callback
Date:   Fri, 10 Jun 2022 23:12:57 +0200
Message-Id: <20220610211257.102071-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; h=from:subject; bh=sBfylUDn+YAcBJHwK5z2IulY8PCwOzF75hj/D976Zfo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBio7PSDbPU5yZFpswOW+XYImggSvAQ/6ay2hPvdKMD v9/xSr+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYqOz0gAKCRDB/BR4rcrsCQBYB/ 9N7hpY3gM34f4oA9rrTOYJQUqg9o4V6U3/FzJtvrFGQWTs4oWbFiPLlXhnvx1Kb8ME8V3qnomET9q3 yGJwwl36xMvqiatk9VxSWEZUR8IJbONsirNukvhbmjVqo9P8CfnMwnI9DjbsnFfue5krFJU+O2z6om eiOLBX0lW0Lew8Yfs0LlqwVafAExsQPAP/1uOmGICCUB/geijfwkTtbRSYv9jZ8lp58ED9JlDE+qC8 nzGLAKbd8d7pW6nhV3qYwJGWrPK4pqgV7IJgsf11Juxxup2CA7kgT8PdFvnMvq8afGQGA5fg5A+xTf JQJZ3ey9+7sx3dabCuEEdnehcCjaUp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_pltfm_unregister() returns 0 unconditionally and returning an
error in a platform remove callback isn't very sensible. (The only
effect of the latter is that the device core emits a generic warning and
then removes the device anyhow.)

So return 0 unconditionally to make it obvious there is no error
forwarded to the upper layers.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/sdhci-st.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index d41582c21aa3..6415916fbd91 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -440,15 +440,14 @@ static int sdhci_st_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
 	struct reset_control *rstc = pdata->rstc;
-	int ret;
 
-	ret = sdhci_pltfm_unregister(pdev);
+	sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(pdata->icnclk);
 
 	reset_control_assert(rstc);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.36.1

