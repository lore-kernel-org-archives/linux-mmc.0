From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 1/6] mmc: core: check endian mode in mmc_of_parse
Date: Fri, 8 May 2015 14:50:06 +0800
Message-ID: <1431067806-41334-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0124.outbound.protection.outlook.com ([207.46.100.124]:5661
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751679AbbEHGxt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 May 2015 02:53:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

The mmc_of_parse will check the endian mode by finding whether
existing 'big-endian' property in device tree. The default endian
mode is little-endian if no 'big-endian' property specified.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v3:
	- Moved endian mode checking to generic mmc host driver
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 drivers/mmc/core/host.c                       | 2 ++
 include/linux/mmc/host.h                      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 438899e..e7980ad 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -42,6 +42,8 @@ Optional properties:
 - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
+- big-endian: If the host controller is big-endian mode, specify this property.
+  The default endian mode is little-endian if no 'big-endian' property specified.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..a3559b7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -323,6 +323,8 @@ int mmc_of_parse(struct mmc_host *host)
 
 	np = host->parent->of_node;
 
+	host->big_endian_mode = of_device_is_big_endian(np);
+
 	/* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
 	if (of_property_read_u32(np, "bus-width", &bus_width) < 0) {
 		dev_dbg(host->parent,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b5bedae..bbb064f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -200,6 +200,7 @@ struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
 	int			index;
+	bool			big_endian_mode;
 	const struct mmc_host_ops *ops;
 	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
-- 
2.1.0.27.g96db324

