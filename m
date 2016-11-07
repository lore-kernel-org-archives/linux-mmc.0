From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v4 3/5] Documentation: synopsys-dw-mshc: add binding for fifo quirks
Date: Mon,  7 Nov 2016 21:04:46 +0800
Message-ID: <1478523888-4524-4-git-send-email-jun.nie@linaro.org>
References: <1478523888-4524-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33660 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753161AbcKGNFX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 08:05:23 -0500
Received: by mail-pf0-f179.google.com with SMTP id d2so91344692pfd.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 05:05:22 -0800 (PST)
In-Reply-To: <1478523888-4524-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add fifo-addr property and fifo-watermark-quirk property to
synopsys-dw-mshc bindings. It is intended to provide more
dt interface to support SoCs specific configuration.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 4e00e85..8bf2e41 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -76,6 +76,17 @@ Optional properties:
 
 * broken-cd: as documented in mmc core bindings.
 
+* data-addr: Override fifo address with value provided by DT. The default FIFO reg
+  offset is assumed as 0x100 (version < 0x240A) and 0x200(version >= 0x240A) by
+  driver. If the controller does not follow this rule, please use this property
+  to set fifo address in device tree.
+
+* fifo-watermark-aligned: Data done irq is expected if data length is less than
+  watermark in PIO mode. But fifo watermark is requested to be aligned with data
+  length in some SoC so that TX/RX irq can be generated with data done irq. Add this
+  watermark quirk to mark this requirement and force fifo watermark setting
+  accordingly.
+
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
@@ -103,6 +114,8 @@ board specific portions as listed below.
 		interrupts = <0 75 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		data-addr = <0x200>;
+		fifo-watermark-aligned;
 	};
 
 [board specific internal DMA resources]
-- 
1.9.1

