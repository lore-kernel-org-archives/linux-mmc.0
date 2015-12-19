From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 01/17] mmc: core: shut up "voltage-ranges unspecified"
 pr_info()
Date: Sat, 19 Dec 2015 20:29:44 +0000
Message-ID: <E1aAO8O-0007xP-Do@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36096 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSU3v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:29:51 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

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
index 5ae89e48fd85..b5e663b67cb5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1220,8 +1220,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 
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

