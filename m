From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 02/24] mmc: core: improve mmc_of_parse_voltage() to return
 better status
Date: Mon, 21 Dec 2015 11:40:31 +0000
Message-ID: <E1aAypL-00015u-Hz@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39671 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbLULkn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:40:43 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Improve mmc_of_parse_voltage()'s return values so that drivers can tell
whether a voltage-range specification was present, and whether it has
been successfully parsed, or there was an error while parsing.

We return a negative errno when parsing fails, zero if no voltage-range
specification is present, or one if a voltage-range specification is
successfully parsed.

No users need modifying as no users check the return value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b5e663b67cb5..e698c08c7a67 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1210,8 +1210,9 @@ EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
  * @np: The device node need to be parsed.
  * @mask: mask of voltages available for MMC/SD/SDIO
  *
- * 1. Return zero on success.
- * 2. Return negative errno: voltage-range is invalid.
+ * Parse the "voltage-ranges" DT property, returning zero if it is not
+ * found, negative errno if the voltage-range specification is invalid,
+ * or one if the voltage-range is specified and successfully parsed.
  */
 int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 {
@@ -1222,7 +1223,7 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
 	if (!voltage_ranges) {
 		pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
-		return -EINVAL;
+		return 0;
 	}
 	if (!num_ranges) {
 		pr_err("%s: voltage-ranges empty\n", np->full_name);
@@ -1244,7 +1245,7 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 		*mask |= ocr_mask;
 	}
 
-	return 0;
+	return 1;
 }
 EXPORT_SYMBOL(mmc_of_parse_voltage);
 
-- 
2.1.0

