Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6BAC04FE0
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Aug 2023 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjHIS4E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjHIS4E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 14:56:04 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFD0E71;
        Wed,  9 Aug 2023 11:56:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C151FFB05;
        Wed,  9 Aug 2023 20:50:41 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mAFFqLzQD3xy; Wed,  9 Aug 2023 20:50:35 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v1 4/5] arm64: dts: imx8mq-librem5-devkit: Drop power-supply
Date:   Wed,  9 Aug 2023 20:50:13 +0200
Message-Id: <be0267a53cdf31c7a32f9ab43813dccf08b32477.1691606520.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691606520.git.agx@sigxcpu.org>
References: <cover.1691606520.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use a power sequence instead. As this handles the wifi disable line
rename the pincontrol accordingly. This also makes it similar to the
Librem 5.

Resolves following warning:

arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: mmc@30b50000: Unevaluated properties are not allowed ('power-supply' was unexpected)
        from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#

Reported-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index be9ef5c271df..244075e2a599 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -231,16 +231,11 @@ vibrator {
 		vcc-supply = <&reg_3v3_p>;
 	};
 
-	wifi_pwr_en: regulator-wifi-en {
-		compatible = "regulator-fixed";
+	wifi_pwrseq: pwrseq {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_wifi_pwr_en>;
-		regulator-name = "WIFI_EN";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -1032,7 +1027,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
-	power-supply = <&wifi_pwr_en>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	broken-cd;
 	disable-wp;
 	cap-sdio-irq;
-- 
2.40.1

