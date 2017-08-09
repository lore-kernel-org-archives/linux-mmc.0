From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT 1/2] mmc: renesas_sdhi: enably CBSY bit for RZ platform
Date: Wed,  9 Aug 2017 21:14:51 +0200
Message-ID: <20170809191452.5254-2-wsa+renesas@sang-engineering.com>
References: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33415 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdHITPA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Aug 2017 15:15:00 -0400
In-Reply-To: <20170809191452.5254-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

It is documented, so enable it to follow the recommendation in the docs
and also save a few cycles.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9b77f521cd2c2f..160fbb22ca00b4 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -33,7 +33,8 @@ static const struct renesas_sdhi_of_data of_default_cfg = {
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT |
+			  TMIO_MMC_HAVE_CBSY,
 	.tmio_ocr_mask	= MMC_VDD_32_33,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
-- 
2.11.0

