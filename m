Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7100C04A94
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Aug 2023 03:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHEDP2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Aug 2023 23:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHEDPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2023 23:15:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449484EF3
        for <linux-mmc@vger.kernel.org>; Fri,  4 Aug 2023 20:15:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2682b4ca7b7so1531952a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Aug 2023 20:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205315; x=1691810115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vubcOJoroAr2qpLW2iybw1ATfvK07sgIvUXsKV/dGPo=;
        b=LGi433l6mQveKcXNQ8Y6j78ExcqR03n9k/L1OfAkKCahAze79pGB2Y0MtDi+Qw2ASm
         TGGI52rMyq1PqT+SDascgrZ0puWjgRaeKAJiCu0az0PNrCWar3wxPKuj3bqESF/h8M04
         4BnrkLTJKlfz/VPflWWXAogpG6iiX2SgThVZ7Ub3QIYAQUL5yq69XHRDoGNsas2g1/A3
         wxa0tae5d0GklpUV0QEsamn4dIH92PGzVJU56JXTjjz1Bv8CGfqmWm0nPsdLNRVy7w8x
         Nf/KASp9qZXbh9hdRR8t4GCzUJ9Wr3kQBjiUbHbBzQAw58vjah38p0gU6N1IEi+yrvl3
         QEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205315; x=1691810115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vubcOJoroAr2qpLW2iybw1ATfvK07sgIvUXsKV/dGPo=;
        b=DkEt8/6mkYBe7fWdVYyCs+jAqYgH4a1JqLZbn+YgsiHje/nZre3QaD7sJnXtgITJJS
         hkWTBXVGwmT5jRMNR2DRNrP4etdG8R2eDZnVKQJTI8RJG4KKpMFEL9YkZtwzPd0mKFGP
         ERdZLqPZzNtnG2ESxoRyYbSTzapxsptvEKaf5W/fOyKw9dH0P4MuUsHtsqhso5jSnb6w
         ndqCECgL3fEP4YlN0K/GPD4jAvkeFZ8HmI6owDREy4Je3B5WWZ+kHyQiEAv7UXM+JJ2t
         ewyc/tau7vJ4OrO1sojHChZ+2JqTi+GXARamrAxDFiyEoi5kWbkvyiUsMWCHxsRBndNc
         JwkQ==
X-Gm-Message-State: AOJu0Yzh47z3xqIfJIJ4zWMRSrTJWbwFpyoGxceQIayVNVAF5j2RQVXg
        89t2Do98T6PYR84KYN9X/pZoAg==
X-Google-Smtp-Source: AGHT+IEIzLB+gYXvTfu96OP5IFhwtudwRxj3fhEs95i9tpZr2KcI4/UpG4tDELxFQG5+CJGzpt3jYw==
X-Received: by 2002:a05:6a21:3384:b0:13f:e0b0:359e with SMTP id yy4-20020a056a21338400b0013fe0b0359emr3791190pzb.21.1691205315615;
        Fri, 04 Aug 2023 20:15:15 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:15 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:46 -0700
Subject: [PATCH RFC v2 2/4] riscv: dts: thead: Add TH1520 mmc controller
 and sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-2-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=1329;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=6awbEzIrA6nzn4c2XYrw0EelLQcw8R2AyCuPywQYMDA=;
 b=yodqPE95p3HGw9U3//UMHr6pYcoh/zakm5zTVZxn/1bJrKKT3nNtZ9e5+RoS1Tgq4z2WdjHvU
 p3qCwUW8rCaB1WF8p8UPtz5Gqr2FgzDdCmAlV7h7Q/M9lVY/FUJNe1J
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add nodes for the SDHCI fixed clock and the first mmc controller which
is typically connected to the eMMC device.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 56a73134b49e..b33bfb04c955 100644
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
@@ -291,6 +298,16 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000
+			       0xff 0xef014060 0x0 0x4>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sdhciirq";
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

