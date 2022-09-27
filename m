Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577EC6FA83
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiI0TSC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0TR6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 15:17:58 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06ADDCE91;
        Tue, 27 Sep 2022 12:17:55 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B115D84DEC;
        Tue, 27 Sep 2022 21:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664306274;
        bh=4vMbhbwGpwD7+mJZLz+7XjKP9e1tqSkXhVPOjHx2Sz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7ZRNuoZLlUNjoIFBN7WWfSH/Zo/cc8jARg3LruUCzVPq7iz0trQU07+gO70WdcF6
         YhuIRX+fIklcxgLxgqiCtOGUxiyWmDHwJ7isCo896nZHW/bezTTj3Bm4O8gdFmM2ci
         dZcOXws74LAi7xoM0OLH2sj2wLgieSwmBxHABpYlh0f++DOLkRYyJZvi9Urk2KqrjZ
         +s529+BxIXvKGCocd3DeXdPRPmQYuFFjCjpI7Hd9vO6ssrAP8Sz20gg0xO2Ri/YUFP
         pWL7ZaHwI6dKl6rpEXtAi8X39thlSBe6t26KZuPbDzPjwT0Cxk9D69W9F/vOValSjE
         Lmk0+GxAdF9CA==
From:   Marek Vasut <marex@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] ARM: dts: stm32: Drop MMCI interrupt-names
Date:   Tue, 27 Sep 2022 21:17:36 +0200
Message-Id: <20220927191736.299702-3-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927191736.299702-1-marex@denx.de>
References: <20220927191736.299702-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pl18x MMCI driver does not use the interrupt-names property,
the binding document has been updated to recommend this property
be unused, remove it.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/stm32h743.dtsi  | 2 --
 arch/arm/boot/dts/stm32mp131.dtsi | 2 --
 arch/arm/boot/dts/stm32mp151.dtsi | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 2059593da21dc..28e3deb20e1e1 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -375,7 +375,6 @@ sdmmc1: mmc@52007000 {
 			arm,primecell-periphid = <0x10153180>;
 			reg = <0x52007000 0x1000>;
 			interrupts = <49>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC1_CK>;
 			clock-names = "apb_pclk";
 			resets = <&rcc STM32H7_AHB3_RESET(SDMMC1)>;
@@ -389,7 +388,6 @@ sdmmc2: mmc@48022400 {
 			arm,primecell-periphid = <0x10153180>;
 			reg = <0x48022400 0x400>;
 			interrupts = <124>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC2_CK>;
 			clock-names = "apb_pclk";
 			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 47dc07abe4e37..4c9e095ed2a8a 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -356,7 +356,6 @@ sdmmc1: mmc@58005000 {
 			arm,primecell-periphid = <0x20253180>;
 			reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC1_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC1_R>;
@@ -371,7 +370,6 @@ sdmmc2: mmc@58007000 {
 			arm,primecell-periphid = <0x20253180>;
 			reg = <0x58007000 0x1000>, <0x58008000 0x1000>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC2_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC2_R>;
diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index e02b3f5d44cba..5491b6c4dec20 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1118,7 +1118,6 @@ sdmmc3: mmc@48004000 {
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x48004000 0x400>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC3_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC3_R>;
@@ -1439,7 +1438,6 @@ sdmmc1: mmc@58005000 {
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58005000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC1_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC1_R>;
@@ -1454,7 +1452,6 @@ sdmmc2: mmc@58007000 {
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58007000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
 			clocks = <&rcc SDMMC2_K>;
 			clock-names = "apb_pclk";
 			resets = <&rcc SDMMC2_R>;
-- 
2.35.1

