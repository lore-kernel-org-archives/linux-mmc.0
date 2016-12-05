From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v7 3/5] Documentation: synopsys-dw-mshc: add binding for fifo quirks
Date: Mon,  5 Dec 2016 10:29:34 +0800
Message-ID: <1480904976-7081-4-git-send-email-jun.nie@linaro.org>
References: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35316 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbcLEC3y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2016 21:29:54 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so60200429pfk.2
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2016 18:29:54 -0800 (PST)
In-Reply-To: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add fifo-addr property and fifo-watermark-quirk property to
synopsys-dw-mshc bindings. It is intended to provide more
dt interface to support SoCs specific configuration.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 7fd17c3..bca30b6 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -75,6 +75,17 @@ Optional properties:
 * card-detect-delay: Delay in milli-seconds before detecting card after card
   insert event. The default value is 0.
 
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
 
@@ -102,6 +113,8 @@ board specific portions as listed below.
 		interrupts = <0 75 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		data-addr = <0x200>;
+		fifo-watermark-aligned;
 		resets = <&rst 20>;
 		reset-names = "reset";
 	};
-- 
1.9.1

