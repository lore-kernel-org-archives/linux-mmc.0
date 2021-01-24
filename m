Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C8CC433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FEA22CF6
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbhAXREx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAXREx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 12:04:53 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD32C061573
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 09:04:12 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DNzpW60Qmz1rypD;
        Sun, 24 Jan 2021 18:03:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DNzpW5mRcz1tYWh;
        Sun, 24 Jan 2021 18:03:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KuxJqv3bOtab; Sun, 24 Jan 2021 18:03:14 +0100 (CET)
X-Auth-Info: MK1HaulPFt3pwc96jWmY+6TlkqmepZu6o30G7xYMpu8=
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 24 Jan 2021 18:03:14 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2 4/4] ARM: dts: stm32: Enable voltage translator auto-detection on DHCOM
Date:   Sun, 24 Jan 2021 18:02:58 +0100
Message-Id: <20210124170258.32862-4-marex@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124170258.32862-1-marex@denx.de>
References: <20210124170258.32862-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The DHCOM SoM uSD slot has an optional voltage level translator, add
DT bindings which permit the MMCI driver to detect the translator
automatically.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com
---
V2: Rebase on next-20210122
---
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
index ff70bd03a017..661d8d071296 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
@@ -408,14 +408,19 @@ &rtc {
 };
 
 &sdmmc1 {
-	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-names = "default", "opendrain", "sleep", "init";
 	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
 	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_a>;
 	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_a>;
+	pinctrl-3 = <&sdmmc1_b4_init_pins_a &sdmmc1_dir_init_pins_a>;
 	cd-gpios = <&gpiog 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	disable-wp;
 	st,sig-dir;
 	st,neg-edge;
+	st,use-ckin;
+	st,cmd-gpios = <&gpiod 2 0>;
+	st,ck-gpios = <&gpioc 12 0>;
+	st,ckin-gpios = <&gpioe 4 0>;
 	bus-width = <4>;
 	vmmc-supply = <&vdd_sd>;
 	status = "okay";
-- 
2.29.2

