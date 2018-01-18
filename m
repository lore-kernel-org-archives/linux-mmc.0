From: <patrice.chotard@st.com>
Subject: [PATCH v3 03/14] mmc: mmci: Don't pretend all variants to have OPENDRAIN bit
Date: Thu, 18 Jan 2018 15:34:19 +0100
Message-ID: <1516286070-24927-4-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch prepares for supporting STM32 variant which doesn't
have opendrain bit in MMCIPOWER register.
ST others variant (u300, nomadik and ux500) uses MCI_OD bit whereas
others variants uses MCI_ROD bit.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ use variant->opendrain instead of host->variant->opendrain
    _ remove comment about OD and ROD bit

v2: _ Replace opendrain bool type by u32
    _ Clean opendrain bit management code

 drivers/mmc/host/mmci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8a4fbc2..f0edfe7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -85,6 +85,7 @@
  * @mmcimask1: true if variant have a MMCIMASK1 register.
  * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
  *	       register.
+ * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -116,6 +117,7 @@ struct variant_data {
 	bool			reversed_irq_handling;
 	bool			mmcimask1;
 	u32			start_err;
+	u32			opendrain;
 };
 
 static struct variant_data variant_arm = {
@@ -127,6 +129,7 @@ struct variant_data {
 	.reversed_irq_handling	= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_ROD,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -137,6 +140,7 @@ struct variant_data {
 	.f_max			= 100000000,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_ROD,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -148,6 +152,7 @@ struct variant_data {
 	.f_max			= 100000000,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_ROD,
 };
 
 static struct variant_data variant_u300 = {
@@ -165,6 +170,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_OD,
 };
 
 static struct variant_data variant_nomadik = {
@@ -183,6 +189,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_OD,
 };
 
 static struct variant_data variant_ux500 = {
@@ -207,6 +214,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_OD,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -233,6 +241,7 @@ struct variant_data {
 	.pwrreg_nopower		= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_OD,
 };
 
 static struct variant_data variant_qcom = {
@@ -253,6 +262,7 @@ struct variant_data {
 	.qcom_dml		= true,
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
+	.opendrain		= MCI_ROD,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -1455,17 +1465,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				~MCI_ST_DATA2DIREN);
 	}
 
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
-		if (host->hw_designer != AMBA_VENDOR_ST)
-			pwr |= MCI_ROD;
-		else {
-			/*
-			 * The ST Micro variant use the ROD bit for something
-			 * else and only has OD (Open Drain).
-			 */
-			pwr |= MCI_OD;
-		}
-	}
+	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN && variant->opendrain)
+		pwr |= variant->opendrain;
 
 	/*
 	 * If clock = 0 and the variant requires the MMCIPOWER to be used for
-- 
1.9.1

