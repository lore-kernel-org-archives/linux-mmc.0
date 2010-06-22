From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 10/12] mmci: support larger MMCIDATALENGTH register
Date: Tue, 22 Jun 2010 14:47:45 +0530
Message-ID: <1277198267-10860-10-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:51677 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759118Ab0FVJTP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:19:15 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

The Ux500 variant has a 24-bit MMCIDATALENGTH register, as opposed to
the 16-bit one on the ARM version.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3fca46d..6c8e41b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -40,22 +40,27 @@ static unsigned int fmax = 515633;
  * struct variant_data - MMCI variant-specific quirks
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
+ * @datalength_bits: number of bits in the MMCIDATALENGTH register
  */
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
+	unsigned int		datalength_bits;
 };
 
 static struct variant_data variant_arm = {
+	.datalength_bits	= 16,
 };
 
 static struct variant_data variant_u300 = {
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
+	.datalength_bits	= 16,
 };
 
 static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
+	.datalength_bits	= 24,
 };
 /*
  * This must be called with host->lock held
@@ -700,10 +705,11 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	mmc->max_phys_segs = NR_SG;
 
 	/*
-	 * Since we only have a 16-bit data length register, we must
-	 * ensure that we don't exceed 2^16-1 bytes in a single request.
+	 * Since only a certain number of bits are valid in the data length
+	 * register, we must ensure that we don't exceed 2^num-1 bytes in a
+	 * single request.
 	 */
-	mmc->max_req_size = 65535;
+	mmc->max_req_size = (1 << variant->datalength_bits) - 1;
 
 	/*
 	 * Set the maximum segment size.  Since we aren't doing DMA
-- 
1.7.0

