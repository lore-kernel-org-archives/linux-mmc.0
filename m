Return-Path: <SRS0=Qble=5A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628ACC10DCE
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Mar 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21751206BE
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Mar 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Xxpbxf4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgCOQoa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:44:30 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:24368 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgCOQoa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Mar 2020 12:44:30 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gQJB0NxHzw;
        Sun, 15 Mar 2020 17:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584290667; bh=rDTNmlgOKsGBnZDD5q6xH86TjWk5Qvp64M67qrlPK+E=;
        h=Date:From:Subject:To:Cc:From;
        b=Xxpbxf4Wu71jB3LN3nRvdBs/GmMhw1LWS9arZEXadRnFeS0yrsmeLwztm3jNJiR+o
         gykAXNXZf9B8y1PaqGP1mtV8lQbl/FSdX1VrEELtUF9DFn12bxA0wu/hjW2k3HAOAc
         DiQ+02IDClw+fbF6L6GHSttwuY0ZHe+syGJ1Qa3tdx/cMVWAYWIpvicmy2Y5sWlifY
         njeNRyBOR8CEb3OcH3v4WZNExyUFK8YC53Yb/ZAjDt3fJgaC8aoAZ1R7NAURGl1CZJ
         M/90+5mHOLSaJ7C7XtO+zN42Jv9EMvIkpcf1XzTLvtEL550mHolkNysHEJknlEsRHX
         1rHeTi7z1GwuA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 17:44:25 +0100
Message-Id: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SAMA5D2x doesn't drive CMD line if GPIO is used as CD line (at least
SAMA5D27 doesn't). Fix this by forcing card-detect in the module
if module-controlled CD is not used.

Fixed commit addresses the problem only for non-removable cards. This
amends it to also cover gpio-cd case.

Cc: stable@vger.kernel.org
Fixes: 7a1e3f143176 ("mmc: sdhci-of-at91: force card detect value for non removable devices")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-of-at91.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index d90f4ed18283..8f8da2fe48a9 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -185,7 +185,8 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
 
 	sdhci_reset(host, mask);
 
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
 	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
@@ -487,8 +488,11 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	 * detection procedure using the SDMCC_CD signal is bypassed.
 	 * This bit is reset when a software reset for all command is performed
 	 * so we need to implement our own reset function to set back this bit.
+	 *
+	 * WA: SAMA5D2 doesn't drive CMD if using CD GPIO line.
 	 */
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.20.1

