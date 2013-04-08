From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 4/5] mmc: mxcmmc: constify mxcmci_devtype
Date: Mon,  8 Apr 2013 23:28:08 +0200
Message-ID: <1365456489-13152-5-git-send-email-agust@denx.de>
References: <1365456489-13152-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38699 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965131Ab3DHV2m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 17:28:42 -0400
In-Reply-To: <1365456489-13152-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Anatolij Gustschin <agust@denx.de>

mxcmci_devtype struct contains constant data, so
constify this struct.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v3:
 - add Acked-by line

v2:
 - remove build warning fix (already fixed elsewhere) and
   change commit log

 drivers/mmc/host/mxcmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index eb45bf0..9b01acb 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -165,7 +165,7 @@ struct mxcmci_host {
 	enum mxcmci_type	devtype;
 };
 
-static struct platform_device_id mxcmci_devtype[] = {
+static const struct platform_device_id mxcmci_devtype[] = {
 	{
 		.name = "imx21-mmc",
 		.driver_data = IMX21_MMC,
-- 
1.7.5.4

