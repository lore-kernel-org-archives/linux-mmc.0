Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA6C433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D802086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZnvFZ7rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgH1W0o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:26:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18095 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgH1WZ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 18:25:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4984450001>; Fri, 28 Aug 2020 15:25:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 15:25:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Aug 2020 15:25:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 22:25:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 22:25:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.186]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f49846f0000>; Fri, 28 Aug 2020 15:25:51 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 4.19 5/7] arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
Date:   Fri, 28 Aug 2020 15:25:15 -0700
Message-ID: <1598653517-13658-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
References: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598653510; bh=cs93Y65AvJG6HL4KxlXFSRtA/ZESg046FGj+oeZhuiY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZnvFZ7rLaQXDLNKOm2YWnnzDyjCXr/10vUvjrP1DX/gfBuA99st7iXe/VtvcrlhC+
         ItPRxGgLBYG+fdXlG1e/SmII7JTSd4FK9Znt7rvbZVN7HpAxeRpoauCIpo+Ml5GJQM
         nEuO4aUAUY/9c5jJmbnG//PV2gJ9l2Zilz7dRy78e4gygoAnxcq3DquVy8UQNC8nyG
         D2RCMJpRKWwzxTq+ZmhCz9CmlTPwlXpcZ/VZDDBsAQr6JksgSsu9kO8xmwNJLLlE3L
         9NAt0fqDCWElLQjFssevghA1dN5Xn0+Ot3aSzapZx8gw6PQbp6WOOOCZtpMbNlXANL
         FGsU0lnEUD6uA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit 39cb62cb8973 ("arm64: tegra: Add Tegra186 support")

Tegra186 uses separate SDMMC_LEGACY_TM clock for data timeout and
this clock is not enabled currently which is not recommended.

Tegra186 SDMMC advertises 12Mhz as timeout clock frequency in host
capability register and uses it by default.

So, this clock should be kept enabled by the SDMMC driver.

Fixes: 39cb62cb8973 ("arm64: tegra: Add Tegra186 support")
Cc: stable <stable@vger.kernel.org> # 4.19
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..821dc5f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -232,8 +232,9 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03400000 0x0 0x10000>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&bpmp TEGRA186_CLK_SDMMC1>;
-		clock-names = "sdhci";
+		clocks = <&bpmp TEGRA186_CLK_SDMMC1>,
+			 <&bpmp TEGRA186_CLK_SDMMC_LEGACY_TM>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
 		reset-names = "sdhci";
 		status = "disabled";
@@ -243,8 +244,9 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03420000 0x0 0x10000>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&bpmp TEGRA186_CLK_SDMMC2>;
-		clock-names = "sdhci";
+		clocks = <&bpmp TEGRA186_CLK_SDMMC2>,
+			 <&bpmp TEGRA186_CLK_SDMMC_LEGACY_TM>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&bpmp TEGRA186_RESET_SDMMC2>;
 		reset-names = "sdhci";
 		status = "disabled";
@@ -254,8 +256,9 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03440000 0x0 0x10000>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&bpmp TEGRA186_CLK_SDMMC3>;
-		clock-names = "sdhci";
+		clocks = <&bpmp TEGRA186_CLK_SDMMC3>,
+			 <&bpmp TEGRA186_CLK_SDMMC_LEGACY_TM>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&bpmp TEGRA186_RESET_SDMMC3>;
 		reset-names = "sdhci";
 		status = "disabled";
@@ -265,8 +268,9 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03460000 0x0 0x10000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&bpmp TEGRA186_CLK_SDMMC4>;
-		clock-names = "sdhci";
+		clocks = <&bpmp TEGRA186_CLK_SDMMC4>,
+			 <&bpmp TEGRA186_CLK_SDMMC_LEGACY_TM>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
 		status = "disabled";
-- 
2.7.4

