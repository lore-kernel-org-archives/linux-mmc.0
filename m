From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 09/12] mmci: enable hardware flow control on Ux500 variants
Date: Tue, 22 Jun 2010 14:47:44 +0530
Message-ID: <1277198267-10860-9-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:45916 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759111Ab0FVJTB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:19:01 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Although both the U300 and Ux500 use ST variants, the HWFCEN bits are at
different positions, so use the variant_data to store the information.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |    8 ++++++--
 drivers/mmc/host/mmci.h |    2 --
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a1d1023..3fca46d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -39,19 +39,23 @@ static unsigned int fmax = 515633;
 /**
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
+ * @clkreg_enable: enable value for MMCICLOCK register
  */
 struct variant_data {
 	unsigned int		clkreg;
+	unsigned int		clkreg_enable;
 };
 
 static struct variant_data variant_arm = {
 };
 
 static struct variant_data variant_u300 = {
+	.clkreg_enable		= 1 << 13, /* HWFCEN */
 };
 
 static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= 1 << 14, /* HWFCEN */
 };
 /*
  * This must be called with host->lock held
@@ -71,8 +75,8 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 				clk = 255;
 			host->cclk = host->mclk / (2 * (clk + 1));
 		}
-		if (host->hw_designer == AMBA_VENDOR_ST)
-			clk |= MCI_ST_FCEN; /* Bug fix in ST IP block */
+
+		clk |= variant->clkreg_enable;
 		clk |= MCI_CLK_ENABLE;
 		/* This hasn't proven to be worthwhile */
 		/* clk |= MCI_CLK_PWRSAVE; */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 5e635e1..0a11ddc 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -28,8 +28,6 @@
 #define MCI_4BIT_BUS		(1 << 11)
 /* 8bit wide buses supported in ST Micro versions */
 #define MCI_ST_8BIT_BUS		(1 << 12)
-/* HW flow control on the ST Micro version */
-#define MCI_ST_FCEN		(1 << 13)
 
 #define MMCIARGUMENT		0x008
 #define MMCICOMMAND		0x00c
-- 
1.7.0

