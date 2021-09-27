Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ECC433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761FC61206
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhI0Mwe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46136
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234458AbhI0Mwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:32 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 019F840268
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747054;
        bh=SyASrYorVTAId0TEMO105U7AUWnylOwqoa8kfxON3jE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mJPw7Nz6WeuyECFKgt9pjR7Z0iCnc8tm30kV7Q1ZvhAnPDMuLS4rWWVzfjEtGrqhB
         R0DDomD+yUFbOcwqIJ+r3YwQzyFMHu4S9vRZNWPcsY5vy2hk43qhj0F2IRaBihU9nK
         8XiD3TIu+aDQIFzA0TBLZ7VHJFHbefGbIOColYdYUxBBNLm+OACvle7Gt7qSaKf0eT
         re92aJwmcVtXomypOctaHMmFZFWMf/esp5NjqCa4quTRMnFu2l4SvQWNiQH6uxJJz/
         4iAs8+BZ8O42hM5bPx+BAyEYPtp9AazRbqvdcJ8UlVsP83u4JGnTQut/4cWDFnFW/j
         RxzM/9p9qDkgA==
Received: by mail-lf1-f69.google.com with SMTP id v197-20020a1948ce000000b003fc99be7fecso15754287lfa.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyASrYorVTAId0TEMO105U7AUWnylOwqoa8kfxON3jE=;
        b=1mjkby2fE2Tn1VFb1AVYZwSYTwHkggSVnupVDD9yEHv0Ln8Nvkf7catG4LtIkXeNnf
         HD6djHqvZ4drIhzUNpQphjcthtN2wIGoTHtFlYKKyYMKQt9uzPnbPfiY8LqS47JGbLMN
         KYyrUxkAoLaZva4DEHiNDKZ0SJE4SY9RC/WOaZlUoBvY0eGvRNY2mJkI2LAHQxAJLFaJ
         BhwJnD77BC4KcS/p116Mwd8sfukoUi8lY0F2wIvCUxA/rVPMzzVSg0WgfuMlyjNBOHAB
         FQs9bL80r1WSLSIiYWwEdFd8qXCxArGIYAui80MQq54Ag5Zn9Bl4qt2O1Xf8EpQ2AM3m
         0D3Q==
X-Gm-Message-State: AOAM532k4KQ9N6Brb8RxMDOBVInaKOBsLDPqTxEVsUWWGzcDLDgSfQn+
        ZPB+HtjBhW2DKEULMjJZ72Ok+Ee0Srwvdh0GnWeXdZ8dCRnOCnehE52R2qo3bf4Bw/zrG4Jn7FI
        lcB9gIM5reE5/OJBOsCgCJnN+502BZa5GtXcWqw==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr29270310ljf.458.1632747052646;
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycBjgE5omkxVTRNXAq3XyHF8zrpabI33eB8OG82RLQU8OwyqzbTmKcsU4pMNaQM29AXA8IbQ==
X-Received: by 2002:a2e:a782:: with SMTP id c2mr29270295ljf.458.1632747052477;
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC node
Date:   Mon, 27 Sep 2021 14:50:42 +0200
Message-Id: <20210927125044.20046-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
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

Changes since v3:
1. Keep two interrupts.
2. Add comment.

Changes since v1:
1. Move also bus-width, suggested by Geert.
---
 .../microchip/microchip-mpfs-icicle-kit.dts   | 11 ++++++-
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 29 ++-----------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 07f1f3cab686..fc1e5869df1b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -51,8 +51,17 @@ &serial3 {
 	status = "okay";
 };
 
-&sdcard {
+&mmc {
 	status = "okay";
+
+	bus-width = <4>;
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
index 1d04c661bccf..b15e93d1702b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -262,39 +262,14 @@ serial3: serial@20104000 {
 			status = "disabled";
 		};
 
-		emmc: mmc@20008000 {
+		/* Common node entry for emmc/sd */
+		mmc: mmc@20008000 {
 			compatible = "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
 			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
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
-			compatible = "cdns,sd4hc";
-			reg = <0x0 0x20008000 0x0 0x1000>;
-			interrupt-parent = <&plic>;
-			interrupts = <88>;
-			pinctrl-names = "default";
-			clocks = <&clkcfg 6>;
-			bus-width = <4>;
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

