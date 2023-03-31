Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5BEC76196
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 17:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjCaR4T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjCaR4F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 13:56:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3DC22EAE
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 10:55:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so15883452wmq.4
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dv6Eb/XHCNKSdHW5zbcXguJe5+5nqrZlLcRsnMdnSlk=;
        b=OW1I/HpTd6gwek7twf0SQygxsjaBDGPlw6XLmjOHRw+RCGza/dT/ilwqv7mx+0YgDj
         3+9Y8VGc07ecPntbYAP59sL6fk5qUEprfIHFPOrC8yXI2xwnWYz/NWydT4Z/KChelMM7
         Vgkf6CE9rO8aMklk03l5mtaPwa1xS+NpyH0Hg48E3IM0R+3i7QBwDzU90grlyL2MjLAI
         jkGSkL2gnt5xLRNEdNHry9eD3HrO5Zpxk/4YxHhUsKI3EB8cKcNOmwPCNFsJ9znTxvRM
         nJtrIgA4Sm4J63x3uZKUaP4dOW5mkkjzfPGjbtqOFs7ucPPU5orSrDiDUVsW3eJ7zCZ7
         vilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv6Eb/XHCNKSdHW5zbcXguJe5+5nqrZlLcRsnMdnSlk=;
        b=o64AiIzGXPMzCH7gyAsTLki9kO5shqLxEmV7Vvmk8anrirj1nhpo4jT0OcBQn9DCw6
         rkO07TUd+tWKyypCNNeptq8/UARgP7buNQVqkrCT6albFs/5relvq3ipHn83ViibCEOq
         dEqIXmJMxxU5xYOk2GQK3uMpSCSP+LOl/mMD1xxZe9S/QmWvUH4cUpheaCv9qII/pgOw
         GOYSXrR3SihF1rehe1629DDy83nLNfkySb+xU+HG3Hp4VW2kVLhvEiafuGYTtDBOx2+b
         9Qxq/ElzPh1WsWy7O2q5wpMVnY4jemsQD2Ur22CfB4Dl2iztEf8q8AcB7e3pDN3Nx1KI
         RwGw==
X-Gm-Message-State: AAQBX9f/setwMzsFQszJScKl8kb97LmbmHvPENpLF4Lf0VHcE57tZRs/
        UiiaX1Ngf5g+X8EaLvOJCFC5rg==
X-Google-Smtp-Source: AKy350bfRVtG29VerTWqwRENbywC1O625nf1NpuMhXSxiaUOIshZn4OAN9pkhfj4fUG8gks4a7yI/g==
X-Received: by 2002:a1c:7717:0:b0:3f0:4428:9432 with SMTP id t23-20020a1c7717000000b003f044289432mr2118165wmi.26.1680285343819;
        Fri, 31 Mar 2023 10:55:43 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:43 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:53 +0200
Subject: [PATCH v4 09/11] arm64: dts: mediatek: add OPP support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-9-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vbee9YlPZnb6kFNtpMf6YbhiqwJ/puB0VHW9S9J3p/Y=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6U8qi3/eBgn1928vnMIxSgut2P2oseEaXCwFbv
 67PPr/mJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcelAAKCRArRkmdfjHURej4D/
 91YCFkicGT0TlcSGqT0D6mA0aMFzYIkzkyY1fyPYfZIOzvqyrGcgwZp8096BD/32FBBawocK13NnPN
 Ka3FluzrS3GlYCPzolybM+5v3Od2KVXINBsouVBSPjorglDVBB8RrxbeKEyMLgiyYQKFWU5Ux0ZWNQ
 bKXiC6nL53OVgPrykwIlOrfWU2Qq7UluH24Uvpi8Ph2J+MrLNRpvOGEPPwVbUocBuFX0MacskXXOt4
 FaLFGc2WnQ6vwBFrcurQGJMLiqpfmQzRt0x71P97dhaHmlD33fx9za371N9CsTK9xxwC4P/TI3H+Xr
 JH0ntiKc1lIduYtj65JPuuzSb8FI9nQ9GfWWJTFQeYwpeAS5bXdDxe2sE4xXj2FfVIjbS1BJktWKNP
 zEjxDgwmFPtk4xM/bPo+Uy+a7jeAyu7qAgjPI9fFhJCn6NBgGBorJbrTCjt9zfgftaCpL0wcID9lcy
 BsNxhIbmjOuGSiejjTYC7ezUd9ukXoQR9PBBfj5QQPAIKWmuAw+7BgZ8K5lyHR1jr00jBxfwL10myh
 0HH0NFWE58zFpKB+uYm6khCcuLN2pgFmzltrXR/EG4uJRpvllWtCgpSf0Ds2wsviwW4GXUVQ1WsQh4
 Qrxf9361pryPzLgTNTJu4lKq6OBFitwz0bei0OPqLlIsGxChTgLmH1zuoUFQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In order to have cpufreq support, this patch adds generic Operating
Performance Points support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index bb45aab2e6a9..cfe0c67ad61f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -20,6 +20,91 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <650000>;
+		};
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-microvolt = <668750>;
+		};
+
+		opp-987000000 {
+			opp-hz = /bits/ 64 <987000000>;
+			opp-microvolt = <687500>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <706250>;
+		};
+
+		opp-1125000000 {
+			opp-hz = /bits/ 64 <1125000000>;
+			opp-microvolt = <725000>;
+		};
+
+		opp-1216000000 {
+			opp-hz = /bits/ 64 <1216000000>;
+			opp-microvolt = <750000>;
+		};
+
+		opp-1308000000 {
+			opp-hz = /bits/ 64 <1308000000>;
+			opp-microvolt = <775000>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-1466000000 {
+			opp-hz = /bits/ 64 <1466000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-1533000000 {
+			opp-hz = /bits/ 64 <1533000000>;
+			opp-microvolt = <850000>;
+		};
+
+		opp-1633000000 {
+			opp-hz = /bits/ 64 <1633000000>;
+			opp-microvolt = <887500>;
+		};
+
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <912500>;
+		};
+
+		opp-1767000000 {
+			opp-hz = /bits/ 64 <1767000000>;
+			opp-microvolt = <937500>;
+		};
+
+		opp-1834000000 {
+			opp-hz = /bits/ 64 <1834000000>;
+			opp-microvolt = <962500>;
+		};
+
+		opp-1917000000 {
+			opp-hz = /bits/ 64 <1917000000>;
+			opp-microvolt = <993750>;
+		};
+
+		opp-2001000000 {
+			opp-hz = /bits/ 64 <2001000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+
 		cpu-map {
 			cluster0 {
 				core0 {
@@ -50,6 +135,10 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +154,10 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@2 {
@@ -80,6 +173,10 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@3 {
@@ -95,6 +192,10 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		l2: l2-cache {

-- 
2.25.1

