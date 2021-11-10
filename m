Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61148C31D97
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470BE611AD
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 19:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhKJTTT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:19:19 -0500
Received: from www.zeus03.de ([194.117.254.33]:55124 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhKJTTN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Nov 2021 14:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Jt6bVIzu1maQuO
        YMTVao4BLGiLg8fziSQRhfzzFu/wM=; b=irTv7tz/vQo0TiEFdO/hh4ortlCe4p
        b+BUg4O9WaUpn5i1J3SisdjGuaClMLyfrN7XYAzAjZWng+R7+LC0wvwOtKSP8Y5F
        73qiAGhhqDl/jalQxICiwouynjfLVc1k8rD4XGsn93Tvk5Yt9tmY0puYGIIuNTtw
        uXDkpTkw0e+iQ=
Received: (qmail 722661 invoked from network); 10 Nov 2021 20:16:23 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2021 20:16:23 +0100
X-UD-Smtp-Session: l3s3148p1@uc/MD3TQ5pogAwDPXwnKAAv7bcN/CGzA
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 12/21] arm64: dts: reneas: r8a77951: add SDnH clocks
Date:   Wed, 10 Nov 2021 20:16:01 +0100
Message-Id: <20211110191610.5664-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110191610.5664-1-wsa+renesas@sang-engineering.com>
References: <20211110191610.5664-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes since RFC v1:
* added tag from Geert
* fixed subject prefix

 arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index 1768a3e6bb8d..391ffe6ca03e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -2668,7 +2668,8 @@ sdhi0: mmc@ee100000 {
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee100000 0 0x2000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
+			clocks = <&cpg CPG_MOD 314>, <&cpg CPG_CORE R8A7795_CLK_SD0H>;
+			clock-names = "core", "clkh";
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
@@ -2681,7 +2682,8 @@ sdhi1: mmc@ee120000 {
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee120000 0 0x2000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 313>;
+			clocks = <&cpg CPG_MOD 313>, <&cpg CPG_CORE R8A7795_CLK_SD1H>;
+			clock-names = "core", "clkh";
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 313>;
@@ -2694,7 +2696,8 @@ sdhi2: mmc@ee140000 {
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee140000 0 0x2000>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
+			clocks = <&cpg CPG_MOD 312>, <&cpg CPG_CORE R8A7795_CLK_SD2H>;
+			clock-names = "core", "clkh";
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 312>;
@@ -2707,7 +2710,8 @@ sdhi3: mmc@ee160000 {
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee160000 0 0x2000>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
+			clocks = <&cpg CPG_MOD 311>, <&cpg CPG_CORE R8A7795_CLK_SD3H>;
+			clock-names = "core", "clkh";
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
-- 
2.30.2

