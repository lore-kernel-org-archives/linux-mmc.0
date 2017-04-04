From: Richard Leitner <richard.leitner-WcANXNA0UjBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] mmc: core: add mmc-card hardware reset enable support
Date: Tue, 4 Apr 2017 16:16:34 +0200
Message-ID: <1491315394-7568-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-M/VWbR8SM2SsTnJN9+BGXg@public.gmane.org, Richard Leitner <richard.leitner-WcANXNA0UjBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some eMMCs disable their hardware reset line (RST_N) by default. To enable
it the host must set the corresponding bit in ECSD. An example for such
a device is the Micron MTFCxGACAANA-4M.

This patch adds a new mmc-card devicetree property to let the host enable
this feature during card initialization.

Signed-off-by: Richard Leitner <richard.leitner-WcANXNA0UjBBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc-card.txt |  3 +++
 drivers/mmc/core/mmc.c                             | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
index a70fcd6..8590a40 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
@@ -12,6 +12,9 @@ Required properties:
 Optional properties:
 -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
               implementation, and that hpi should not be used
+-enable-hw-reset : some eMMC devices have disabled the hw reset functionality
+                   (RST_N_FUNCTION) by default. By adding this property the
+                   host will enable it during initialization.
 
 Example:
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b502601..518d0e3 100644
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
@@ -1810,6 +1817,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/*
+	 * try to enable RST_N if requested
+	 * This is needed because some eMMC chips disable this function by
+	 * default.
+	 */
+	if (enable_rst_n) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_RST_N_FUNCTION, EXT_CSD_RST_N_ENABLED,
+				 card->ext_csd.generic_cmd6_time);
+		if (err && err != -EBADMSG)
+			pr_warn("%s: Enabling RST_N feature failed\n",
+				mmc_hostname(card->host));
+	}
+
 	if (!oldcard)
 		host->card = card;
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
