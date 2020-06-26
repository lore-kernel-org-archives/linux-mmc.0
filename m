Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D7C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D784214D8
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgFZJcn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:32:43 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:59362 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgFZJca (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 05:32:30 -0400
X-IronPort-AV: E=Sophos;i="5.75,283,1589209200"; 
   d="scan'208";a="50657266"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Jun 2020 18:32:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 91A02420330E;
        Fri, 26 Jun 2020 18:32:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v4 4/4] arm64: dts: renesas: add regulator-off-in-suspend property for eMMC
Date:   Fri, 26 Jun 2020 18:32:22 +0900
Message-Id: <1593163942-5087-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add regulator-off-in-suspend property into eMMC related regulator-fixed
nodes because PSCI on the boards will turn the regulators off in suspend.

By this property, the regulator's status will be disabled in suspend.
MMC subsystem can get the condition and then eMMC condition will
be better than before.
 before:
  - enter sleep mode and then turn the vmmc and vqmmc off.
 after:
  - call mmc_poweroff_nofity() and then turn the vmmc and vqmmc off.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts   | 10 ++++++++--
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts  | 10 ++++++++--
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts   | 10 ++++++++--
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts   |  9 ++++++++-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 10 ++++++++--
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 10 ++++++++--
 6 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index 01c4ba0..9fe634a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -74,7 +74,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	vcc_d3_3v: regulator-1 {
@@ -83,7 +86,10 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	vcc_vddq_vin0: regulator-2 {
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index ef8350a..5898c7f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -37,7 +37,10 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	hdmi-out {
@@ -87,7 +90,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	x1_clk: x1-clock {
diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index dc24cec4..80736f8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -113,7 +113,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_3p3v: regulator1 {
@@ -122,7 +125,10 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_12p0v: regulator2 {
diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 79c73a9..9ac5361 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -103,7 +103,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_3p3v: regulator-3p3v {
@@ -113,6 +116,10 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_12p0v: regulator-12p0v {
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 98bbcaf..fa8c45f 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -172,7 +172,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_3p3v: regulator1 {
@@ -181,7 +184,10 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_12v: regulator2 {
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index ff88af8..7c5bccc 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -79,7 +79,10 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	reg_3p3v: regulator1 {
@@ -88,7 +91,10 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		regulator-always-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
 	};
 
 	sound_card: sound {
-- 
2.7.4

