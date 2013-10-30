From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 4/6] mmc: sdhci-esdhc-imx: fix cpas over write issue
Date: Wed, 30 Oct 2013 22:09:51 +0800
Message-ID: <1383142193-24950-5-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:26517 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab3J3O3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:29:03 -0400
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

We should use '|=' instead '=', or it may over write
the original caps assigned before this line.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 92d5782..b2acb75 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1069,7 +1069,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 
 	case ESDHC_CD_PERMANENT:
-		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
 		break;
 
 	case ESDHC_CD_NONE:
-- 
1.7.2.rc3


