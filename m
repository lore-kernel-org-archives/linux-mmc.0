From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 09/21] arm64: dts: hi3660: Add pl031 rtc node
Date: Wed, 14 Jun 2017 16:23:26 +0800
Message-ID: <20170614082338.15673-10-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34358 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754637AbdFNIYs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 04:24:48 -0400
Received: by mail-pg0-f41.google.com with SMTP id v18so72589047pgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 01:24:48 -0700 (PDT)
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org

From: Chen Feng <puck.chen@hisilicon.com>

Add dts node to enable pl031 rtc.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 7a90c92..3b2a3a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -326,6 +326,14 @@
 			status = "disabled";
 		};
 
+		rtc0: rtc@fff04000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x0 0Xfff04000 0x0 0x1000>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3660_PCLK>;
+			clock-names = "apb_pclk";
+		};
+
 		gpio0: gpio@e8a0b000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0 0xe8a0b000 0 0x1000>;
-- 
2.10.2

