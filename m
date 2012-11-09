From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 2/8] mmc: sdhci: fix coding style in sdhci_set_transfer_mode
Date: Fri,  9 Nov 2012 17:09:52 +0530
Message-ID: <1352461198-21941-3-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42166 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab2KILp6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 06:45:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2731136pad.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Nov 2012 03:45:58 -0800 (PST)
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ff2b9e..2d3d76e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -898,9 +898,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12))
+		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12)) {
 			mode |= SDHCI_TRNS_AUTO_CMD12;
-		else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+		} else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
 			sdhci_writel(host, host->mrq->sbc->arg, SDHCI_ARGUMENT2);
 		}
-- 
1.7.4.1

