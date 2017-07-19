From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH] arc: remove num-slots from arc platforms
Date: Wed, 19 Jul 2017 08:39:09 +0800
Message-ID: <1500424749-206304-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55726 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGSAjh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jul 2017 20:39:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Alexey Brodkin <abrodkin@synopsys.com>, Shawn Lin <shawn.lin@rock-chips.com>

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Acked-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Hi Ulf,

Vineet prefer this patch to go via mmc tree where the driver's
conversion happened. So could you pick it up?

 arch/arc/boot/dts/axs10x_mb.dtsi     | 1 -
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 41cfb29..82e26ad 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -101,7 +101,6 @@
 		mmc@0x15000 {
 			compatible = "altr,socfpga-dw-mshc";
 			reg = < 0x15000 0x400 >;
-			num-slots = < 1 >;
 			fifo-depth = < 16 >;
 			card-detect-delay = < 200 >;
 			clocks = <&apbclk>, <&mmcclk>;
diff --git a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
index 459fc65..48bb4b4 100644
--- a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
@@ -104,7 +104,6 @@
 		mmc@0x15000 {
 			compatible = "snps,dw-mshc";
 			reg = <0x15000 0x400>;
-			num-slots = <1>;
 			fifo-depth = <1024>;
 			card-detect-delay = <200>;
 			clocks = <&apbclk>, <&mmcclk>;
-- 
1.9.1


