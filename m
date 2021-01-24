Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E24C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3E22CA2
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAXREM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:04:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49791 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbhAXREK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 12:04:10 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DNzpV53jkz1qsk0;
        Sun, 24 Jan 2021 18:03:14 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DNzpV4sKWz1tYWh;
        Sun, 24 Jan 2021 18:03:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Lx4d8XAH60Lc; Sun, 24 Jan 2021 18:03:13 +0100 (CET)
X-Auth-Info: bLrTVO6EdRBUPMfKn+zJNQbikE6fCN+c0LiRyKwpu8k=
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 24 Jan 2021 18:03:13 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2 3/4] ARM: dts: stm32: Add additional init state for SDMMC1 pins
Date:   Sun, 24 Jan 2021 18:02:57 +0100
Message-Id: <20210124170258.32862-3-marex@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124170258.32862-1-marex@denx.de>
References: <20210124170258.32862-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add "init" mux option for SDMMC1, where the CMD, CK, CKIN lines are not
configured, so they can be claimed as GPIOs early on in driver probe().
This is used for probing optional voltage level translator.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
---
V2: Rebase on next-20210122
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index d8297dfff3e6..687f3534ba22 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1385,6 +1385,18 @@ pins {
 		};
 	};
 
+	sdmmc1_b4_init_pins_a: sdmmc1-b4-init-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('C', 11, AF12)>; /* SDMMC1_D3 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
 	sdmmc1_dir_pins_a: sdmmc1-dir-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
@@ -1409,6 +1421,17 @@ pins {
 		};
 	};
 
+	sdmmc1_dir_init_pins_a: sdmmc1-dir-init-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
+				 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
+				 <STM32_PINMUX('B', 9, AF11)>; /* SDMMC1_CDIR */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+	};
+
 	sdmmc1_dir_pins_b: sdmmc1-dir-1 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
-- 
2.29.2

