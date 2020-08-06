Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57503C433E3
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 00:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366C721744
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 00:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Fd8f+EAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgHFAdW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:33:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2407 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHFAcv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 20:32:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2b4f790001>; Wed, 05 Aug 2020 17:31:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Aug 2020 17:32:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 05 Aug 2020 17:32:43 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 00:32:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 6 Aug 2020 00:32:41 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.190]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2b4fa80002>; Wed, 05 Aug 2020 17:32:40 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v3 5/6] arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
Date:   Wed, 5 Aug 2020 17:32:28 -0700
Message-ID: <1596673949-1571-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596673949-1571-1-git-send-email-skomatineni@nvidia.com>
References: <1596673949-1571-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596673913; bh=lICUHst8XIrdQEZgqns7DQxwm/+9MXm6kDFL0GUgRTI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Fd8f+EAZf4TPQHbi4D1XdwHmxzsTpmQSCdlrJ8GrJrLUBfhdk/qJaPM4/pwGyOkcJ
         /t3aWN+FPhq8WjpsYsYn0W0cQ6CeLp62HdNSw/Hfjd5XzdZnZrV+Z/FU6tE1k6s6By
         jIctTAz5uzLjonM65le9pny0DDN8muEjtfzeApS14f0xVUmCGny5dEJM+LXiz8VP3e
         PDEpIyHzIBZ/8uY45/XZiBh0TSuFybYNuZpaGsGyA/nCEOfIxJlNXGK1r1BwdPN9Q/
         eQgd2Qe+k8+IIGSWyPUIswze7qq9m/46HpZevjcZUlR1ViZG8YmIKqQutVuZBU0wBa
         b0WQwRPwFB/cA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit 5425fb15d8ee ("arm64: tegra: Add Tegra194 chip device tree")

Tegra194 uses separate SDMMC_LEGACY_TM clock for data timeout and
this clock is not enabled currently which is not recommended.

Tegra194 SDMMC advertises 12Mhz as timeout clock frequency in host
capability register.

So, this clock should be kept enabled by SDMMC driver.

Fixes: 5425fb15d8ee ("arm64: tegra: Add Tegra194 chip device tree")
Cc: stable <stable@vger.kernel.org> # 5.4
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 48160f4..ca5cb6a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -460,8 +460,9 @@
 			compatible = "nvidia,tegra194-sdhci";
 			reg = <0x03400000 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bpmp TEGRA194_CLK_SDMMC1>;
-			clock-names = "sdhci";
+			clocks = <&bpmp TEGRA194_CLK_SDMMC1>,
+				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
+			clock-names = "sdhci", "tmclk";
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCRA &emc>,
@@ -485,8 +486,9 @@
 			compatible = "nvidia,tegra194-sdhci";
 			reg = <0x03440000 0x10000>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bpmp TEGRA194_CLK_SDMMC3>;
-			clock-names = "sdhci";
+			clocks = <&bpmp TEGRA194_CLK_SDMMC3>,
+				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
+			clock-names = "sdhci", "tmclk";
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCR &emc>,
@@ -511,8 +513,9 @@
 			compatible = "nvidia,tegra194-sdhci";
 			reg = <0x03460000 0x10000>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bpmp TEGRA194_CLK_SDMMC4>;
-			clock-names = "sdhci";
+			clocks = <&bpmp TEGRA194_CLK_SDMMC4>,
+				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
+			clock-names = "sdhci", "tmclk";
 			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC4>,
 					  <&bpmp TEGRA194_CLK_PLLC4>;
 			assigned-clock-parents =
-- 
2.7.4

