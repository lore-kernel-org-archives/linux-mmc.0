From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 01/25] mmc: core: shut up "voltage-ranges unspecified"
 pr_info()
Date: Fri, 29 Jan 2016 09:43:50 +0000
Message-ID: <E1aP5ao-0001oW-4u@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44175 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbcA2Jnx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:43:53 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Each time a driver such as sdhci-esdhc-imx is probed, we get a info
printk complaining that the DT voltage-ranges property has not been
specified.

However, the DT binding specifically says that the voltage-ranges
property is optional.  That means we should not be complaining that
DT hasn't specified this property: by indicating that it's optional,
it is valid not to have the property in DT.

Silence the warning if the property is missing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f95d41ffc766..8e25dcb42bfe 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1214,8 +1214,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 
 	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
 	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-	if (!voltage_ranges || !num_ranges) {
-		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
+	if (!voltage_ranges) {
+		pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
+		return -EINVAL;
+	}
+	if (!num_ranges) {
+		pr_err("%s: voltage-ranges empty\n", np->full_name);
 		return -EINVAL;
 	}
 
-- 
2.1.0

