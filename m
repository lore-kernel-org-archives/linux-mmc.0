Return-Path: <SRS0=tWKp=3S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22E9C3524C
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jan 2020 20:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52762071E
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jan 2020 20:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgA2Uh3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:37:29 -0500
Received: from sauhun.de ([88.99.104.3]:41392 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgA2Uh2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Jan 2020 15:37:28 -0500
Received: from localhost (p5486CF2C.dip0.t-ipconnect.de [84.134.207.44])
        by pokefinder.org (Postfix) with ESMTPSA id 77EA32C28B7;
        Wed, 29 Jan 2020 21:37:26 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/6] mmc: tmio: enforce retune after runtime suspend
Date:   Wed, 29 Jan 2020 21:37:07 +0100
Message-Id: <20200129203709.30493-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently, select_tuning() is called after RPM resume. But
select_tuning() needs some additional function calls to work correctly.
Instead of reimplementing the whole postprocessing, just enforce
retuning.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I couldn't trigger RPM suspend even with debug code. Shimoda-san said
it should only occur with removed cards which is not so easy with
soldered eMMC. For those cases, I think the aproach taken here is fine.
Needs more discussion, though, to make sure...

 drivers/mmc/host/renesas_sdhi_core.c | 1 -
 drivers/mmc/host/tmio_mmc.h          | 1 -
 drivers/mmc/host/tmio_mmc_core.c     | 8 +-------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 24ee8ac1fe21..0c9e5e010bda 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -898,7 +898,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			dev_warn(&host->pdev->dev, "Unknown clock rate for tuning\n");
 
 		host->execute_tuning = renesas_sdhi_execute_tuning;
-		host->select_tuning = renesas_sdhi_select_tuning;
 		host->check_retune = renesas_sdhi_check_scc_error;
 		host->prepare_hs400_tuning =
 			renesas_sdhi_prepare_hs400_tuning;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index bdb9973981ff..b6fffd3d2650 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -183,7 +183,6 @@ struct tmio_mmc_host {
 	 * and mandatory for SDR104.
 	 */
 	int (*execute_tuning)(struct tmio_mmc_host *host, u32 opcode);
-	int (*select_tuning)(struct tmio_mmc_host *host);
 
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3cacb516a66e..aeafa1c68ce2 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1302,11 +1302,6 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_suspend);
 
-static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
-{
-	return host->tap_num && mmc_can_retune(host->mmc);
-}
-
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
@@ -1323,8 +1318,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
-	if (tmio_mmc_can_retune(host) && host->select_tuning(host))
-		dev_warn(&host->pdev->dev, "Tuning selection failed\n");
+	mmc_retune_needed(host->mmc);
 
 	return 0;
 }
-- 
2.20.1

