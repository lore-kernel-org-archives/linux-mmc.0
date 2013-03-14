From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 3/5] mmc: mxcmmc: constify mxcmci_devtype and fix build warning
Date: Thu, 14 Mar 2013 17:40:52 +0100
Message-ID: <1363279254-22351-5-git-send-email-agust@denx.de>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33854 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933724Ab3CNQlL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 12:41:11 -0400
In-Reply-To: <1363279254-22351-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

Fix:
drivers/mmc/host/mxcmmc.c: In function 'mxcmci_probe':
drivers/mmc/host/mxcmmc.c:1137:41: warning: initialization discards
'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/mmc/host/mxcmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index dc25802..c0115e9 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -169,7 +169,7 @@ struct mxcmci_host {
 	struct mxcmci_reg_ops   *reg_ops;
 };
 
-static struct platform_device_id mxcmci_devtype[] = {
+static const struct platform_device_id mxcmci_devtype[] = {
 	{
 		.name = "imx21-mmc",
 		.driver_data = IMX21_MMC,
@@ -1091,7 +1091,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	host->reg_ops = &mxcmci_reg_ops;
 
 	if (of_id) {
-		struct platform_device_id *id_entry = of_id->data;
+		const struct platform_device_id *id_entry = of_id->data;
 		host->devtype = id_entry->driver_data;
 	} else {
 		host->devtype = pdev->id_entry->driver_data;
-- 
1.7.5.4

