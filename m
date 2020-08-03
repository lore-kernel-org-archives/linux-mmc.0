Return-Path: <SRS0=0lJu=BN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836FC433E5
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Aug 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A783022C9F
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Aug 2020 19:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="axOc1qr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgHCToc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:44:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6349 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCToc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2020 15:44:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2869120000>; Mon, 03 Aug 2020 12:44:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Aug 2020 12:44:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Aug 2020 12:44:32 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Aug
 2020 19:44:31 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 3 Aug 2020 19:44:31 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.221]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f28691d0001>; Mon, 03 Aug 2020 12:44:30 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH v1 4/6] arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
Date:   Mon, 3 Aug 2020 12:44:21 -0700
Message-ID: <1596483863-22153-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596483863-22153-1-git-send-email-skomatineni@nvidia.com>
References: <1596483863-22153-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596483858; bh=eFc2VU5GTK3y8YU8lvXMTIrju/5qbDsv3weenC955gY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=axOc1qr08OYIAXDeOk7G7jvEFPBICz33ZtJTUrItnkjxbRqDG8GXHYy7lNvC1bPqq
         hyI4LCx7rgPe8B8s/jK1OaFx8kYJm8iLLXn2OJqsH/vsfZTOrdFyDlfTEB3ExPV9id
         V17Enl0F/ig7FU9z9PxlPT/zFxTEsEBU7STBbmoz0QY7FCyQQ2eDNZoMzxRFGDLSCz
         nVYYsmcnygc5taLJqaD/tC7mHja9EAl8X0Qsors1OFstXq1EVcgCxIt7XHhlPbbi9o
         CtvMGkSchAkJpjOlzmJEfykL/JHf8n7FYwdGUgEz1RjuaTYUYWAa0ETbeVbb3mE7S3
         MyuU/pmAbUWNg==
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

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 34d249d..8eb61dd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -337,8 +337,9 @@
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
 		interconnects = <&mc TEGRA186_MEMORY_CLIENT_SDMMCRA &emc>,
@@ -366,8 +367,9 @@
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
 		interconnects = <&mc TEGRA186_MEMORY_CLIENT_SDMMCRAA &emc>,
@@ -390,8 +392,9 @@
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
 		interconnects = <&mc TEGRA186_MEMORY_CLIENT_SDMMCR &emc>,
@@ -416,8 +419,9 @@
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03460000 0x0 0x10000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&bpmp TEGRA186_CLK_SDMMC4>;
-		clock-names = "sdhci";
+		clocks = <&bpmp TEGRA186_CLK_SDMMC4>,
+			 <&bpmp TEGRA186_CLK_SDMMC_LEGACY_TM>;
+		clock-names = "sdhci", "tmclk";
 		assigned-clocks = <&bpmp TEGRA186_CLK_SDMMC4>,
 				  <&bpmp TEGRA186_CLK_PLLC4_VCO>;
 		assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLC4_VCO>;
-- 
2.7.4

