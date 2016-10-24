From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 3/5] Documentation: synopsys-dw-mshc: add binding for fifo quirks
Date: Mon, 24 Oct 2016 17:11:54 +0800
Message-ID: <1477300316-1420-4-git-send-email-jun.nie@linaro.org>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34752 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcJXJMZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 05:12:25 -0400
Received: by mail-pf0-f173.google.com with SMTP id r16so95437389pfg.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 02:12:24 -0700 (PDT)
In-Reply-To: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add fifo-addr-override property and fifo-watermark-quirk property to
synopsys-dw-mshc bindings. It is intended to provide workarounds to
support more SoCs that break current assumption.

See Documentation/devicetree/bindings/reset/reset.txt for details.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 4e00e85..eb64921 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -76,6 +76,17 @@ Optional properties:
 
 * broken-cd: as documented in mmc core bindings.
 
+* fifo-addr-override: Override fifo address with value provided by DT. The FIFO
+  reg offset of version 0x210A break current assumption that 0x100 (version < 0x240A)
+  and 0x200(version >= 0x240A) in some implementation. So this property serves as
+  workaround.
+
+* fifo-watermark-quirk: Data done irq is expected if data length is less than
+  watermark in PIO mode. But fifo watermark is requested to be aligned with data
+  length in some SoC so that TX/RX irq can be generated with data done irq. Add the
+  watermark quirk to mark this requirement and force fifo watermark setting
+  accordingly.
+
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
@@ -103,6 +114,8 @@ board specific portions as listed below.
 		interrupts = <0 75 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		fifo-addr-override = <0x200>;
+		fifo-watermark-quirk;
 	};
 
 [board specific internal DMA resources]
-- 
1.9.1

