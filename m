Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D358C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F3361029
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 15:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbhHSPqB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:46:01 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52862
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240640AbhHSPqA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 11:46:00 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 3BCD940CAC
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387923;
        bh=njwgOg9JKn80yhYbvXIAT/SFdeE7ctVHz3eviacs2wI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vCErhSEhYlrj6wQ2Oktlr5gUQBkcD5poJ4KNcis3Fq3FfqbJgv7JipyOWuZjAiHKX
         /dMVERRxdodpVoUQzr14Kzz8xByPH0tMjNiNiM9ob5W+b/ah7pF9tS2ZhkHBt7N/37
         sDPLIae17UE+rVbS5fgWn+l34hJ3+MgqpQHeNYjM/5D6IhFoj7Zv+kXlT3ClBWNW3/
         IyTzYi7r4bN8o98XcIsZOC3YWdrIE9WKHiQIEJbR0VHPuE6HQZI4pEUPIcw3UHcQ/N
         QYAKyWbVBDt/1OMcerRLAfDDv4pM/IVVG59sC01INTjL5jkXnRgWGPa5Hs4T4cFsxm
         LfDXVbslBDaSw==
Received: by mail-ej1-f71.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so2407685ejy.6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 08:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njwgOg9JKn80yhYbvXIAT/SFdeE7ctVHz3eviacs2wI=;
        b=rKTXPpQ2PzrbwNrmhIzQUrUfnuGrad68hNSEVcCEOLPxPKWWkr91CzED1FewGarYNh
         9+Bm4F9fMQfaVdioPe6pckjrph20HuZyXE9RlZOSFDvUJHxNL9ZXtvAgRSYxAcnv7poL
         Va9oVzQ7qmB8QM4WFk0SPlOtG0lGHtOO5aIaCz6IDQrdM6xDlBJJxlOv1YL3NqE5/bmM
         zeCMO5mH/dAmOGfBkm/AKdh/X7n6w1eUQWkUnBwrS50wJ/AezIBV0OnqnBJsLix6xQhi
         uKbP0jon6tO3xfrHj6EX/tKAlxcCLkrqkqCtHhIyXg1QUrZlUUlzwglw50gtmcwADNxI
         lvUg==
X-Gm-Message-State: AOAM533VMo7LNsbp0Cb0qtduiLHR7VqG4eBV/TANJwrxOLPiJGbAsS2V
        Pqm6bc58vtKq6kp5oub7ojhAJ3kzJ6OKbfzQrhMjOh4T+PHWibEWmQO3eNwJY5Z2yIJ/7EFrSoV
        cwVrcsddxEmAjkn3LPa2Yg9UrYcpxcIVcGKm6Ug==
X-Received: by 2002:aa7:d388:: with SMTP id x8mr17405652edq.254.1629387923010;
        Thu, 19 Aug 2021 08:45:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjjgc+MlbW3WgtXD5d1JgTS06sxNFURI2vP+cBd1uncao3bHmqg3HObd04dkwqF/n5zuGX8g==
X-Received: by 2002:aa7:d388:: with SMTP id x8mr17405630edq.254.1629387922833;
        Thu, 19 Aug 2021 08:45:22 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 5/6] riscv: microchip: mpfs: drop duplicated MMC/SDHC node
Date:   Thu, 19 Aug 2021 17:44:35 +0200
Message-Id: <20210819154436.117798-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Devicetree source is a description of hardware and hardware has only one
block @20008000 which can be configured either as eMMC or SDHC.  Having
two node for different modes is an obscure, unusual and confusing way to
configure it.  Instead the board file is supposed to customize the block
to its needs, e.g. to SDHC mode.

This fixes dtbs_check warning:
  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: $nodename:0: 'sdhc@20008000' does not match '^mmc(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../microchip/microchip-mpfs-icicle-kit.dts   | 10 ++++++-
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 27 +------------------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 62f7651de538..ac6083c76083 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -43,8 +43,16 @@ &serial3 {
 	status = "okay";
 };
 
-&sdcard {
+&mmc {
 	status = "okay";
+
+	disable-wp;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 };
 
 &emac0 {
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index cb54da0cc3c4..c4ccd7e4d3eb 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -262,25 +262,7 @@ serial3: serial@20104000 {
 			status = "disabled";
 		};
 
-		emmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
-			reg = <0x0 0x20008000 0x0 0x1000>;
-			interrupt-parent = <&plic>;
-			interrupts = <88 89>;
-			pinctrl-names = "default";
-			clocks = <&clkcfg 6>;
-			bus-width = <4>;
-			cap-mmc-highspeed;
-			mmc-ddr-3_3v;
-			max-frequency = <200000000>;
-			non-removable;
-			no-sd;
-			no-sdio;
-			voltage-ranges = <3300 3300>;
-			status = "disabled";
-		};
-
-		sdcard: sdhc@20008000 {
+		mmc: mmc@20008000 {
 			compatible = "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
@@ -288,13 +270,6 @@ sdcard: sdhc@20008000 {
 			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			bus-width = <4>;
-			disable-wp;
-			cap-sd-highspeed;
-			card-detect-delay = <200>;
-			sd-uhs-sdr12;
-			sd-uhs-sdr25;
-			sd-uhs-sdr50;
-			sd-uhs-sdr104;
 			max-frequency = <200000000>;
 			status = "disabled";
 		};
-- 
2.30.2

