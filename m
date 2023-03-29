Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0A1C6FD18
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Mar 2023 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjC2I43 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjC2Izv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2023 04:55:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA003C04
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2023 01:55:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so9616540wra.7
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2023 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+n7kTmZSLyy6JZOnafgLqENkBorz7cVoGb/c2ijGPg=;
        b=vZZKjgfgUkaAmm9eDa/n0yIPp/jvrZ8rqxyyVarmS9MeQTQuWX+9QtAws347nXlLsq
         9hIswfhbaOqCvvgku69nubwSIS2vxcyy3NpfkWJAcG33bZLRAatBAyrLEy8u5n1P0kjF
         +TSopNQpv4t5BvVsIwJxFsHvTqaZhHGrt7q0fqKnfMHiWCpFM3frNvSDSddWylBvplRE
         xnm64vTf5/2nwhoboYtoz7sZ/o0wrtlty5pr6e3Zut4ZD1DqgKZUejA47I8IX3mTygjM
         QwC5E+Hk3i8USpOCzXSWDpilwCpimYsxnwl7FOoB1RYDbjKxZ13PfNVusfiGkBDfgNh0
         EC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+n7kTmZSLyy6JZOnafgLqENkBorz7cVoGb/c2ijGPg=;
        b=TngGXB1Q4i3IZ980iIxBOEsDxEKcgMM6yFKfi6iVOkO8aXVSOIP+1SWDjBmG4lSZFG
         qnJIlgbhi+hGtg5xmJQc/v7z5wJGl9Xq8aTG2lBq8YImm+fCySH+01hEtaqFGmVzFwvU
         5IzsUKWA56f6fPy5yE3B0ertYZc9T9qXuPi7Q5xVWE4pmBQeFr94iTm/QLdq3zDME7b8
         VMKnGKwJ3DlvgkuVHvAhKONzgQEEwn/dqom5g0tAcLeEwMxHAO1aeAf8mB/KngnLhmHN
         AnUbeEL/O1nwUfeqLBYnY5sTffsQJf7mk36NF+9veq6faEUym/3aYVTAUydMPQRBVtoT
         AY2A==
X-Gm-Message-State: AAQBX9dgf9Ltg93nBIC6tIp/IsV57K7a5ZD89RUJpUe5U6hK/znf6eui
        dr0lF9oiX4Xc5qtbequB/E6yFA==
X-Google-Smtp-Source: AKy350beAHR2vBXDYS1dhRBIKKbrEnZiLQ/0TwuX8udPaiMplnlJkeIrKmdL2bitTYxYcDqOr5pgGw==
X-Received: by 2002:a05:6000:114f:b0:2ce:e571:5cc3 with SMTP id d15-20020a056000114f00b002cee5715cc3mr1068616wrx.28.1680080112211;
        Wed, 29 Mar 2023 01:55:12 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:11 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Wed, 29 Mar 2023 10:54:38 +0200
Subject: [PATCH v3 17/17] arm64: dts: mediatek: Add CPU Idle support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-17-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=aEgSs34mkL8gqjkYVK8GMwDs4v5ClGcJt3CH4UkG4Lo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zcm57eLBHsA1qwn3qogPxQmbXLdagGVtEIgyHC
 A29k4fmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURbQOEA
 CuU6n9SXlN0b8BAXdY3HrfCBV6LkNvTlxVo3DJ4CPxk/rVU6JdnNLmC5HgOG3cpN8++XvhibH9jO+8
 mh3hExwx6XxEo1HDXphJlS/9KH1hfRQgjvqRXCVZlSczl878fNxY3FVX1frfoEpTTJ55tJNZdCVo+a
 /MxH0lbca8RH6DEJVdjJs8L5a5FftxtsbMY/Y8FJjIf934MXMHQznJJC9P+SyKHWUuNx1/W3Y9drAz
 o4uDE8UZRg+xyL7QTi7Px5EzGoehViSW+1/Kavlap2mq6kM4IhEJUINhuXLaf/NtpIG4WqVFwNJe+W
 7yDVgM81dDUOug9HBWDq7P7cUKFw5lrW6utoY4wT+Z3TwKqpTr9yTZCMwSrVfKqvHzMQk+jrx6pxhb
 eas0/9+WEFrE/pOvy1UyYqsYjs/HzDMacXrO/8ecEUdgEzWxVt7vEhrlnBG1LjwhBw65sqUmj9LUbd
 B2hmFzlEjxGz7shN6W6n4I7MviMnRXFJR2XWIu/bmlzZLMZf1Y4eYWw/1immWUBjVJ+lk//FQkUbHQ
 nfOPre2roDA4sCR37ocJIm1/Hp/bG478zGFLSAFbjun+1wzvGDLJTzK6Jd7zr+ZTxW8LBfqtFgvF0s
 3HPh3Gx1WxpQ42/QAfObOir5xPQ0Lqp+jP/Ccx4M7WfBqrLYfQEW252gVOHw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

MT8365 has 3 CPU Idle states:
- MCDI_CPU. (Multi-Core-Deep-Idle)
- MCDI_CLUSTER.
- DPIDLE. (Deep-Idle)

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 959d8533c24c..b5f5c77f7f84 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -112,6 +112,7 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -131,6 +132,7 @@ cpu1: cpu@1 {
 			reg = <0x1>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -150,6 +152,7 @@ cpu2: cpu@2 {
 			reg = <0x2>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -169,6 +172,7 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -182,6 +186,37 @@ cpu3: cpu@3 {
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
+		idle-states {
+			entry-method = "psci";
+
+			CPU_MCDI: cpu-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x00010001>;
+				entry-latency-us = <300>;
+				exit-latency-us = <200>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER_MCDI: cluster-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010001>;
+				entry-latency-us = <350>;
+				exit-latency-us = <250>;
+				min-residency-us = <1200>;
+			};
+
+			CLUSTER_DPIDLE: cluster-dpidle {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010004>;
+				entry-latency-us = <300>;
+				exit-latency-us = <800>;
+				min-residency-us = <3300>;
+			};
+		};
+
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;

-- 
2.25.1

