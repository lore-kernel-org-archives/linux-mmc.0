Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A8DC54E94
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 01:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjAYBC2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 20:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjAYBCY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 20:02:24 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC13222A27;
        Tue, 24 Jan 2023 17:02:19 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 522DD2059054;
        Wed, 25 Jan 2023 10:02:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:15 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id CB6E43D53;
        Wed, 25 Jan 2023 10:02:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/5] ARM: dts: uniphier: Add syscon-uhs-mode to SD node
Date:   Wed, 25 Jan 2023 10:02:00 +0900
Message-Id: <20230125010201.28246-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sociopnext,syscon-uhs-mode prpperty to the SD node to refer the handle
of the control logic node.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 3 ++-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 9dceff12a633..78cb3f5f514c 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -207,7 +207,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		mioctrl: mioctrl@59810000 {
 			compatible = "socionext,uniphier-ld4-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
@@ -272,6 +272,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&mioctrl 0>;
 		};
 
 		emmc: mmc@5a500000 {
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index a309e64c57c8..2c7434574bc6 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -241,7 +241,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		mioctrl: mioctrl@59810000 {
 			compatible = "socionext,uniphier-pro4-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
@@ -307,6 +307,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&mioctrl 0>;
 		};
 
 		emmc: mmc@5a500000 {
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 100edd7438d8..2ac78c3ebd17 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -341,7 +341,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		sdctrl: sdctrl@59810000 {
 			compatible = "socionext,uniphier-pro5-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -696,6 +696,7 @@ sd: mmc@68800000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index ca4dccf56a67..13331eb1caa3 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -422,7 +422,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		sdctrl: sdctrl@59810000 {
 			compatible = "socionext,uniphier-pxs2-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -486,6 +486,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 
 		soc_glue: soc-glue@5f800000 {
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 67b12dfe513b..af7488e2eb16 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -211,7 +211,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		mioctrl: mioctrl@59810000 {
 			compatible = "socionext,uniphier-sld8-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
@@ -276,6 +276,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&mioctrl 0>;
 		};
 
 		emmc: mmc@5a500000 {
-- 
2.25.1

