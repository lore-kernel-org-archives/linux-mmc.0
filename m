Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14428C25B47
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjJWVHf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjJWVHc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 17:07:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6910CB
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:07:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so3081067b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698095236; x=1698700036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=3NUPWWrJKNmSuszwC3Q7w9wvAk79+YjRLRE53mXEj7tRriKxf8fMp1xtnnrSWKpGv3
         8AxwCuCYmesCKjRKSxSKFAktKtVWHc6GMy4Knb5WvDHHbgERyEp35TKpvA73jCuy2vL3
         0DobJVbEdpMyziQgsG7Ic6y4WeXTdh4zRzDU91G9I/r3HWGI3V3PrjqDmXQm/KOubcDP
         myWPAhK4qs2QtTrWLgwspIh3W0NmWi2LcGKWUAmBJrOPTjJuQ398RKajbZj3MOkZQvOc
         AWZhr3HaXHiElmNNUoPgmuioJxfxFPULFqXCocqPSmoJxanlFe4iU733pFfA1/44FXxm
         cewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095236; x=1698700036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=FEwimL7B4wRmIN394MyA9neirm3QNUclPLs0GT+C80nEi9wpkOfVD3dpxdX6xEtHQj
         1IDRa9WTm3g7/xS1jy2tap//uvkp6cMpC148up5PQP1LlUu5FeyUauCmFl1GN84+O/4k
         4DaJU02NJ5AviI3DgMib2FPcoy5vzt6fQxveHi1MiZo9G8WlNjGc3hiF7oTi64hJeMQX
         8rzqVYilUirXSSpRd6CokzM7T/vrlvpAycNcW/XI9nhiK5iZzAb6C2Ldgqpmvh0jaBgT
         l+62a9475SpUqmtw81t6fWLNWMLl8oEnvqQCHJsv7Z29HjB4rUNSjH4zrYfiStYlG2VL
         G2Zw==
X-Gm-Message-State: AOJu0Ywtw20WpPlJx27OgZ55M5L9yQglqeheSO9RMyAwXv8k7S/km+vT
        G+QIz6CemdHSQK5xotSqJ9f7lA==
X-Google-Smtp-Source: AGHT+IGWrHTrnLkYiQyu+QLLmhX/cQml0jPNHPXJOjZpJ+Z4E+jfkFscNGmA1AJnuN2Y6KPQM0ObCA==
X-Received: by 2002:a05:6a00:1747:b0:693:3851:bd98 with SMTP id j7-20020a056a00174700b006933851bd98mr8163238pfc.2.1698095236354;
        Mon, 23 Oct 2023 14:07:16 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b9a0:8714:407c:4146])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b006bde2480806sm6573066pfp.47.2023.10.23.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:07:16 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 23 Oct 2023 14:07:06 -0700
Subject: [PATCH v3 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-th1520-mmc-v3-5-abc5e7491166@baylibre.com>
References: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
In-Reply-To: <20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698095224; l=1608;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=118IOeI3EDHQnRGvuv5ewuNsGEAnYvxtIZdzQTMEyXk=;
 b=XyMu8wvvsVfsnmoVXWNgX+KUd9hOCnDa6dLi4MnIvVGBBqGRnsVHK86mx+4qjhfZBbXb1s2ST
 azF53vPUXUBAo9/G0vksN6nCUnyIEip5lqZ8/HB02fymtmxyf6Jbbam
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
controller instance which is typically connected to the eMMC device.
Add mmc1 node for the second mmc controller instance which is typically
connected to microSD slot.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..f5ec9326c4b8 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

