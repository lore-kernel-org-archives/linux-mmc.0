Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3D3B83EF;
	Fri, 24 Jul 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879855; cv=fail; b=Y1qgqCD3C4rwqORGX85etvnfpzA5kY9+8yrjYG7ttFPInOtL3+MoYPigDbIs0sVeVxA3A9+yUQAKC8g2jAiz2DURZvQsK0S/tY1/T+b+4KHGWDA1CV5UfJxE704Iz9w/8TxOY21qwY8yV9AVfGSbt9gSimc7TfEuDJxz4xffLtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879855; c=relaxed/simple;
	bh=5icMnBorhcIomdf+6iRhElGpCUlw95w6H20U8expRGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gvzhh7b2zV62skfuVsuQFzkn3PVZFIyczjWiui7o9NWJO/wk4t82FqpZTFIHhoDBZD3a+vrfOoHM4Pq1MXoQs76BfvrubjZP6l0a/LW635TuLNkryXgN1styyEGYzzNggYEmgl4jXQTxRgF2CiyA3JSqEZNw+011RNMAXWFJaKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iXT53/g2; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iXT53/g2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emm+ba5/fZLc36InqlOdAcVHmKsjY7OF6E0sYiJxEswzIOK7jKrEEiw3D43GUbo3ul6a7N9qXvxCeTTGubiK3+wS0ZlxKvX5UqjuJNcfUvfnTrk4QOARpbS/EPQ9hEh88MLYYXAl5TquJd74nuzzY+S+UzrKVNbx6FKnNtQSCmAmN913FyLn6a7B6jP5yUrAAU2CFa2a34E4lRSBSvtW8Rb5WkFd9meINxVXaDbSIbYl40rEdvYnxmmcSKzHTvLVEd5IVnZu/65cWnTyBq5rfeSYGWvZCgguPZ5gFWrD+R295WX+5Uca+eqQrkXdsYaWAtoNRQ1VtdB907PaL+kYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyHjD7O7uRWzu/eGysHxszGrhk0pu0lHgRTb/Gr9bkE=;
 b=ne2srUzjXdotJ4BSgCg6IJlmjJ0ujAPMF8bZ59dxG9PhkQ2gdzuboIYGK5mnkjOvsdnkr2L5gZxCzfbeT1NSux4Tg65NRNUxbw5NTLOsXNPz36k+DZ95pWlPm+LgLB1KpQRkbP1Nhi+D9bgi8tTl8+870E82jW3emk9Z2B4QIOmqmmc3vF4cGwqCpG6uhuqjG6VLBJa1z2Nd0bMitaQRy4rCiQnX+zHVwO1L1RvevApp2eVpAs7rlZVI7w7RKXX9a8OdYcbprZZ7sNdYxV7/USzEYK/a68H+rO3cKb/Dr4TIqJw/wrjqWZne46eKG21hcEXYI2k6XUK83ToWQJdNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyHjD7O7uRWzu/eGysHxszGrhk0pu0lHgRTb/Gr9bkE=;
 b=iXT53/g2PgGIgFJpoTRXbNMPxU+9ka367UoZXwOeS3xcB3tIs2D11Z54ziFSMlMy8TaslKLuipMDo3HcKsBwgcg1Ad7NM34E9rfhQTIVin4j8E/l0bnYTl6Ni9NofsI5fZrdHlIlhrhti46WSU5n7L/YqU1YCTHDSriTZZr/baYKp6iK/7948lOi06vYyJEsJrSLM5aYalz8TujYoclP9XhFEX2vkC5u9S7HLtqEDeVHyypo5yWFZJo9PEtb7Jh7gbexTWMGZckYA06Ush33VR54vZAzrvw5zNq25t4hfGmbp0MmvxeFTijBKS9YGzWmxK9vUZdAAC28Fb3mKEyzsA==
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 07:57:26 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::90) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 07:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 00:57:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:16 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:15 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 5/5] arm64: tegra: Add Tegra264 SDMMC1 device tree node
Date: Fri, 24 Jul 2026 07:56:59 +0000
Message-ID: <20260724075700.714261-6-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260724075700.714261-1-pshete@nvidia.com>
References: <20260724075700.714261-1-pshete@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c391ef-ae8c-4fad-7add-08dee95933a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P4+orbPZdC8lLrR4ZD2KbroLGR2dzq4/kgS0jIFfUO7kp9J6twKk1u7Oi7LQrZpCD5j/fNsmz8ABpCZ7A2bNr3i8FbWSRBa0NTua9wcIIhmCUlKC4Uu7P0hJelXUelq3JknaZBBRsuM5QkvOnIE8YBR187nV5xUgnTBsVK+be41TovldrC9nBRR4rYX7VRKe85eKFemGygHCp3gsoFiwMyfON9tgMyCQ6G9sHcH998v+esXZpDd9pb1SJs2C+WpAH2uMZTwbwnjWSv0y2t64Uy0v5HP28B6yxDF1wcnVzCDgq0jsQd1b4zKFKcgeAUnfL5khoOclMVAbYonUgqRuxePYE7r4m3DZOuqLavrZGdY+gHcUtuNREeeVeKrlMTRUkPKYyLMQF910Bg/GqJzX7JCneabXsaMS4KzXLAui73htG07vgrgUhxCYcb22abwnvMe9bMQFkLhgHgmUNdkPPaOggN9rremN4Q26oy6nZTQCTghblXln1kdGWeFTyXIkCmGozcFRslwoebrscdIcSjbUVSB7JQ4NVn/JwI79GAjlitM+e5e0TWAaattHXFCs6FfQ6p/qvsYx6x4I+Oambq0YLu8fSHFv4NnSp3gWTVb6CZGYij4ntpnImNi9BPb8y6B3Y2EejtxjcK+VKKbEVMNM52wic0iZ/xvafBv229hr3XeGUmEJV//L0ucUQkSpN6XZxDAIkgtehBtD9dhZcg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GhTkoquBIFHtx+TDIZFJLJT8sNhxhfNVjReyu02qv66N9RroR3FbDVcdLl7WDs/RvBc3dnAQ/PMPmCIwTiRJq5BZGmi+s4Fk1vuI7dVcQ20K2yUwHpikto7oMGP7l/QYDuRU6YzACnajys6fUMu8MnCzA5/ezMTTT7qiku1fNPQi96BsojT/ALvBVhTxvvgDL0WpW1DsiUHSUVM4fIoMDcwJG8/CR/G32fKzLNHBtVLASdZ4RlIw6qxbmeouFDF0y5Vq1M9ti1QaYCIJ2Ovt0HJuWmW0jtDCb66Co4ZYAhTbUZJB06a6SkDuwKU0JFQDmK4+7Jefm+G7eqAFz+kUi37epsXTdy/V28CaOOL2WOp1pR9Q5yefjQwqDe0V2SFYNhBfzwZjFHMeBlLFHLAQYT/FOFfpebrATjrFGajCdvk4/1O7Jjsxl0ycmLsk34eT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:25.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c391ef-ae8c-4fad-7add-08dee95933a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

Add device tree node for the Tegra264 SDMMC1 instance.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 2d2cb1a3d95c..f1eafb6a3970 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3631,6 +3631,40 @@
 			status = "disabled";
 		};
 
+		mmc@c570000 {
+			compatible = "nvidia,tegra264-sdhci", "nvidia,tegra194-sdhci";
+			reg = <0x00 0x0c570000 0x0 0x10000>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA264_CLK_SDMMC1>,
+				 <&bpmp TEGRA264_CLK_SDMMC_LEGACY_TM>;
+			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA264_CLK_SDMMC1>,
+					  <&bpmp TEGRA264_CLK_PLLC4_MUXED>;
+			assigned-clock-parents = <&bpmp TEGRA264_CLK_PLLC4_MUXED>,
+						 <&bpmp TEGRA264_CLK_PLLC4_OUT0>;
+			resets = <&bpmp TEGRA264_RESET_SDMMC1>;
+			reset-names = "sdhci";
+			interconnects = <&mc TEGRA264_MEMORY_CLIENT_SDMMC0R &emc>,
+					<&mc TEGRA264_MEMORY_CLIENT_SDMMC0W &emc>;
+			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu2 TEGRA264_SID_SDMMC0>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <0x6>;
+			nvidia,default-trim = <0x0>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			mmc-hs200-1_8v;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		i2c0: i2c@c630000 {
 			compatible = "nvidia,tegra264-i2c";
 			reg = <0x00 0x0c630000 0x0 0x10000>;
-- 
2.17.1

