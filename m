From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 08/12] mmci: add variant data and default MCICLOCK support
Date: Tue, 22 Jun 2010 14:47:43 +0530
Message-ID: <1277198267-10860-8-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:56185 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759100Ab0FVJS4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:56 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Add a variant_data structure to handle the differences between the
various variants of this peripheral.  Add a first quirk for a default
MCICLOCK value, required on the Ux500 variant where the enable bit needs
to be always set, since it controls access to some registers.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   31 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/mmci.h |    2 ++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 63eb7f4..a1d1023 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -36,12 +36,30 @@
 
 static unsigned int fmax = 515633;
 
+/**
+ * struct variant_data - MMCI variant-specific quirks
+ * @clkreg: default value for MCICLOCK register
+ */
+struct variant_data {
+	unsigned int		clkreg;
+};
+
+static struct variant_data variant_arm = {
+};
+
+static struct variant_data variant_u300 = {
+};
+
+static struct variant_data variant_ux500 = {
+	.clkreg			= MCI_CLK_ENABLE,
+};
 /*
  * This must be called with host->lock held
  */
 static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 {
-	u32 clk = 0;
+	struct variant_data *variant = host->variant;
+	u32 clk = variant->clkreg;
 
 	if (desired) {
 		if (desired >= host->mclk) {
@@ -564,6 +582,7 @@ static const struct mmc_host_ops mmci_ops = {
 static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
+	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
 	int ret;
@@ -608,6 +627,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		goto clk_free;
 
 	host->plat = plat;
+	host->variant = variant;
 	host->mclk = clk_get_rate(host->clk);
 	/*
 	 * According to the spec, mclk is max 100 MHz,
@@ -860,19 +880,28 @@ static struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
 		.mask	= 0x000fffff,
+		.data	= &variant_arm,
 	},
 	{
 		.id	= 0x00041181,
 		.mask	= 0x000fffff,
+		.data	= &variant_arm,
 	},
 	/* ST Micro variants */
 	{
 		.id     = 0x00180180,
 		.mask   = 0x00ffffff,
+		.data	= &variant_u300,
 	},
 	{
 		.id     = 0x00280180,
 		.mask   = 0x00ffffff,
+		.data	= &variant_u300,
+	},
+	{
+		.id     = 0x00480180,
+		.mask   = 0x00ffffff,
+		.data	= &variant_ux500,
 	},
 	{ 0, 0 },
 };
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 516adc6..5e635e1 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -145,6 +145,7 @@
 #define NR_SG		16
 
 struct clk;
+struct variant_data;
 
 struct mmci_host {
 	void __iomem		*base;
@@ -165,6 +166,7 @@ struct mmci_host {
 	unsigned int		cclk;
 	u32			pwr;
 	struct mmci_platform_data *plat;
+	struct variant_data	*variant;
 
 	u8			hw_designer;
 	u8			hw_revision:4;
-- 
1.7.0

