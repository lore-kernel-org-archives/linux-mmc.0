From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2] mmc: core: add mmc-card hardware reset enable support
Date: Tue, 11 Apr 2017 09:31:02 +0200
Message-ID: <1491895862-7952-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.skidata.com ([91.230.2.99]:65030 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753703AbdDKHbl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 03:31:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, jh80.chung@samsung.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, dev@g0hl1n.net, Richard Leitner <richard.leitner@skidata.com>

Some eMMCs disable their hardware reset line (RST_N) by default. To enable
it the host must set the corresponding bit in ECSD. An example for such
a device is the Micron MTFCxGACAANA-4M.

This patch adds a new mmc-card devicetree property to let the host enable
this feature during card initialization.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
CHANGES v2:
	- add RST_N_FUNCTION value to dt documentation
	- set RST_N_FUNCTION only if it was not set before
---
 Documentation/devicetree/bindings/mmc/mmc-card.txt |  4 ++++
 drivers/mmc/core/mmc.c                             | 23 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
index a70fcd6..bbfccce 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
@@ -12,6 +12,10 @@ Required properties:
 Optional properties:
 -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
               implementation, and that hpi should not be used
+-enable-hw-reset : some eMMC devices have disabled the hw reset functionality
+                   (RST_N_FUNCTION) by default. By adding this property the
+                   host will enable it during initialization. This will set
+                   RST_N_FUNCTION to 0x1 (permanently enabled).
 
 Example:
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b502601..30066be 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1520,9 +1520,16 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr;
+	struct device_node *np;
+	bool enable_rst_n = false;
 
 	WARN_ON(!host->claimed);
 
+	np = mmc_of_find_child_device(host, 0);
+	if (np && of_device_is_compatible(np, "mmc-card"))
+		enable_rst_n = of_property_read_bool(np, "enable-hw-reset");
+	of_node_put(np);
+
 	/* Set correct bus mode for MMC before attempting init */
 	if (!mmc_host_is_spi(host))
 		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
@@ -1810,6 +1817,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/*
+	 * enable RST_N if requested (and rst_n_function is not set)
+	 * This is needed because some eMMC chips disable this function by
+	 * default.
+	 */
+	if (enable_rst_n &&
+	    !(card->ext_csd.rst_n_function & EXT_CSD_RST_N_EN_MASK)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_RST_N_FUNCTION, EXT_CSD_RST_N_ENABLED,
+				 card->ext_csd.generic_cmd6_time);
+		card->ext_csd.rst_n_function = EXT_CSD_RST_N_ENABLED;
+		if (err && err != -EBADMSG)
+			pr_warn("%s: Enabling RST_N feature failed\n",
+				mmc_hostname(card->host));
+	}
+
 	if (!oldcard)
 		host->card = card;
 
-- 
2.1.4

