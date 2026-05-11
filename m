Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DB3806B6;
	Mon, 11 May 2026 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530907; cv=fail; b=JO3oCCon95KMW3M2AWzP6l2OCoVTAUD2PAe/csXM/O5D5BVhi+hrAYFbhe1yZscXVSbxMyIYLPLmMav5v2baxT3dEj8ro5t0LLxOfndOOp02iAH64oMgG/EmPqHgAYl6dBAOJ2OvVPGoi6EATzDbgibEbSKduvBwFr5qomKw1kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530907; c=relaxed/simple;
	bh=HxfMeFlLQSifDQWmPUg6vKJnAIZYJj8+Bi9J79v9ZAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrR+Jom4XM4BCdVic7Uj2EwAikmyQfPfkHcp0IIC6xFUa2IEb9vQKWIzMfJYB1j6daL0fWzns9brAIPjzEqfQOqPQ6u8nQX1SIX75KAlebCKOT8OFEd6m+WuhBQLa+FmDdTvbpilDWMM19flLs7aivRnxODGvHdqt5XmjNzjajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qgg7bfIs; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qgg7bfIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnZQPW7SVkZYHB/6pqe1UlSYiTsthqkP4o5Bhlr9Wm9lVdVffDTutasr8FHdnE9mSMbl5GaIOM6FLhkS9/LesTmDahWuThyNh0jaraeUYDr/Nd2pssjbUtGFBXKlgjixaAqM0b8O+hUk0kCV6RoiWx7nJSTNOvA3rBz3etGBZKn6uqp/G3KqcXJ7nv4YSU8GBEdS4LgCQNDxympHfYoOUXCYmNOKDliDwYKz0HsFQIlQEuNhtIAEQR9dvYMW+aPuCRgqF2w9TQKkW0KYB60f0CIO68qZ0RDqFS4dcq18TWoob2Wu4yaxmgqxcmr1fUxJ/yVS6l9juMBcxptERY7caQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWNwDWgd9XUNbzQRNW0e7h1SVtMwpVgVfI5974SlrQg=;
 b=kjzSPXeS1V38eWypQjOX8ZPBhoTXwG3E4A1i/rAgDCI5GpN2VfSu87mXr3xglIdwctgJllkNV68MwUkGGZfCgHH+B7WaDfFLC1uXf9R21BhqUW6bOxpwHZ/Zj+HxjiQqCTfKSGzXwbGHXpEJ5Vm9gilxh2RqcDOCSxTexiVWfFZaWWLo/v+XBgfw0aJj6J0Judkqze2pDWXBR4ldTovNjq0/DqtK0rQKhngtjLo1O5c9RlfuxhKH5TTa5GUrDHonEBtccPjUl78HKs/XlkJ8txElRFogCjq9x0Yc2Y12FyUh16mEazU/VupYhlYVrZYhPg8zcge3q8CpCxNhDeIIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWNwDWgd9XUNbzQRNW0e7h1SVtMwpVgVfI5974SlrQg=;
 b=qgg7bfIsopU/SaLptd522skTRlcwIHWryVbLI6PDGDgNHyaT4eFYT072656MWqueWCz/RrBTB0A5pq/sn7xj+eMyAcEWVR/Aj9zkGC0r8E29rXcXIOy1YZ6g2jygod934NBOZ7qhOObDFOwKQL0qriEpiur1AQx2rGbH4t5wOxV/vCH1SYWmQwOVnVYf6lLo3BFp+at5WnJ4B6ETicuXyxuOGt1+c8ewsYjo1SJIvWHjRCEEC6ZYU50f3vvuCdhVB5oMdcoTBtkGxX5hl5lY16STsMBy4B4LIfdAk0hcB0loUshHm2v5S2FJ5reZkVHtsEEqVr/LyLuE4Nr70f+oDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:41 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:41 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/9] arm64: dts: agilex5: add Cadence SD6HC controller and SOCDK enablement
Date: Mon, 11 May 2026 13:21:25 -0700
Message-Id: <20260511202132.5597-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: ade2d3ba-5c32-44b8-4bb9-08deaf9ae9a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	MjuqHnkQ1jK4Fm66L+4ipvbbJ/pk1VgHSKKw1aYTBoi8kc23Oj4HkJCyCZEVAVyUMcWO1ydlmRdW2zQEsfc8zCQPYXAYqT/n0kN9Ee29ZdEbyy//9xnI9pY9ghvRIrbx7ecTo4gKQd63GmNbhr49uMr6piRpIqmjMfxctkiAif6RzkEvXL4ZKuWbIxXIMDqtcEhnrUElr2KYJWt6GbNpEUul1CR9JkcIATbq33kPn3JURaEmEBwx61062g8mdnpy078mYYgn3zPoyReBmYvyAYmb0IanJgyxFjU3PDo4Qg3+Gy0PwREJN+GQ7jgIG0JmN90DTYGbX0j+riNTvjTYbUS6jUd4De7TL4GVAA+pAyc1xvbs3c9nbrfMoaWlOLHl3hzI7y4WKYEwtQg1OYMQTLY1vh3/IMBz0jV/kMqR2AlsoU/Odul3Uzl4lECVmSev0LpKdZSEzwhDHsU6mk8vUTCAQyRdhvZ7XuYS+u8ft+tsCb79mHldNk4h2PiMKOoEbdOH05vYYF5Bn8eMX0p1SfplzD0Z4ht0ncSgeDhlnqWiM8ffjzCisK+TSC1wJ+12VU4qz2UGMG43K7MpR7EhRIm0YW75LPjkZJ2ZKFfEv4TBANDs9YzwrC7kp4WprgRC9sf/UBTrWoJZmyMzIuhqGHweGKmn5+hpIwWQp7dz25bSTh1XxtnQhzFdqVnSSoSq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2o7RB+65xoquQw/nUuSw8ovIAC4BGfM4psvmX07oIidHL0sv7zPBZG/AzVM?=
 =?us-ascii?Q?0tOB/9EisPmTguXleFT0xH6f5MbNyyJgnt8QkK/SFUGplw2sLubkZzBii3FB?=
 =?us-ascii?Q?wTz/erb9T119lUotH9NEGU2tEmeOVdQ/XqfpQgTqjp8OAspeNLPKxZhBOKaZ?=
 =?us-ascii?Q?5lCYmRVQkm3f0DrYkhgZPZ/2vc5wiLQzjFsGWN6nJEC+DD+haoTXYcPFJUzx?=
 =?us-ascii?Q?lERO36j7ZcBZ2zCkYUm6ZvM57pY49jeK7IAE074ButbxjLqQ/AxJamMKbLmE?=
 =?us-ascii?Q?QAjr5rkGWhLSfdN1r2V76ckvxcT3igF/RFnTzT4JgOpbfm3iU/1ulK0Lh9+1?=
 =?us-ascii?Q?ntJaIsUgYxroeKPYo73Njvu0OJlF8wrHB3dJwXJbLlmPzoCnrElMzVXjMWi3?=
 =?us-ascii?Q?SPvBL9TqwWisb60MklxpVdgvE26N9o1cQlntsq3jwAoqNDohu12XbZxjhsMP?=
 =?us-ascii?Q?g6tdKjfC4SQQaozH1lRrvUb1dGmMq/Z6YLuJw4jq6yrQJgZFDQTCSJ3mvNDy?=
 =?us-ascii?Q?gpqc4E5M7m9KTJizV5GndhTRc1WhG0ZFO/eJZipaeAxLayLhs23B0J8n5suj?=
 =?us-ascii?Q?FtpsWBMUjIzDdx5w3IC+VPq8KjoI9IhOZe6GanLue4KFly3GZlm8BygLqKyl?=
 =?us-ascii?Q?T3nDuC5RleZ32TAtK9PJmSsLSFHfPscktEX4N9H+7oJgCsad+cDX7/JNjO2b?=
 =?us-ascii?Q?Al+hqc2DDDjAwTDHvBfYnC373M0UDSN6q7batt2TQIFhGQ8ZgDqTX1OlyUhC?=
 =?us-ascii?Q?SODeUJseGzyWqUN2dCwY+jaVRafKIN8P0zRArFW6fWpw4vjtyLJk5Vds/n/Y?=
 =?us-ascii?Q?i7ssuZNBGH5j8WCQLH14rBEXNrjdcuRsVbj+TsULYBrXUwxTGoMcJb+JGBaD?=
 =?us-ascii?Q?sMYOy7xhM2jdYV4O9I7N/8IVAPz04OQxoM8ShI+qbg/ZtIfuoSNMDSGab7HL?=
 =?us-ascii?Q?H7KYdVNTkSD1eWQY7wj9bjOQs9aEmTeoIffW0vOtx1R2XWjGfrOJXn26qF4d?=
 =?us-ascii?Q?6xKRdxTrca9gtDHrvXgJqh3jpqTZ32N1pX5aBIoUg2b8FdOk0ulkQgLFen+Q?=
 =?us-ascii?Q?V4f8ayWUgiYbQ4FMQ5/k0WlLjA+2JBHc6LgmFVIVIDPVLEtaAKmUN46xNNoM?=
 =?us-ascii?Q?9kxnLNXRXZtr/LnMpQs9fySkpwyI05MdrQ2Vv42uNbO7noSPvm9GBUG5L4WG?=
 =?us-ascii?Q?gY7ZdyJ+kUf9n0FvWJvfgu/FJP1l7iJk7FrWz6oOSyXOovHXb67Au2rjKjkf?=
 =?us-ascii?Q?8FQ/AwP/WObyR1qZbhvTltb6oReuOoPDSWCUrwuFW2lg8fzmnuGFiVSC9ofx?=
 =?us-ascii?Q?W668wdrMus/H6KhbpTRJmDqP8M1Dr9y3aJf+/d7WPt3I6HaFzWnPfGftoBF6?=
 =?us-ascii?Q?0cixLd5BHAjM27Oe/HU1nbvMA7LX0E3xhnxOihy5nJJVUajpWRwB8f+HZqzu?=
 =?us-ascii?Q?e3DuIYutkdQCc3jqLUnNbZn/AxxihMRfrPWO4DkOt+F/QRSnLNi7uKPNsBUS?=
 =?us-ascii?Q?1hACN/GKCjeodW4i8TV8vCjH36ENSmspO09pW6Ii+auo2TnixuQ5a93/Rzwn?=
 =?us-ascii?Q?fe4Wni4PK216c5/PEJYGMk+24OOlGBublS0npqJ3ylCw8+R6qq0uky1w0sjT?=
 =?us-ascii?Q?f1ZVYzKZHn/WD+0ykgp8CPUaQ1Nois4PiihXtg6f/gukFtcwOGF4nQFyvpvK?=
 =?us-ascii?Q?pAAPR/Qut+DpOFXHdWw+fJoTjeE3D3FBNPYCYXJh5oETAyJQgNeb0qdzBJWf?=
 =?us-ascii?Q?jDrSnr+wNrdxCbEmH5+lmdfuXmr1XIA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2d3ba-5c32-44b8-4bb9-08deaf9ae9a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:41.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/AkGNEsK+ie2gw3xU3GKteyWjME3OVXC9BFWYGiA+2IKNKFQB+cZY0p+ROZw6IUWgjgQKdTjuvgUznE2A8VRdoSj3/k6TQ3CHV698uZiiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

The Agilex5 SoC device tree gains an SD/MMC controller node backed by
the Cadence SD6HC, with IOMMU integration via the system SMMU. Card
power is supplied by a fixed 3.3V regulator and I/O voltage switching
between 1.8V and 3.3V is handled by a GPIO-controlled regulator.

The SOCDK board enables the controller for SD-only operation in 4-bit
bus width with high-speed and SDR104 UHS-I modes at 200 MHz maximum
clock. SDHCI capability overrides clear the SDR50 tuning flag and
override the clock base mask to report 200 MHz.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 38 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 26 +++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 352c96d144a8..7e080f13166f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -300,6 +300,44 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		sd_emmc_power: regulator-fixed-3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "card-power";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		sd_io_1v8_reg: regulator-1p8v {
+			compatible = "regulator-gpio";
+			regulator-name = "sd-bus-io-power";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			states =	<1800000 0x1>,
+					<3300000 0x0>;
+		};
+
+		emmc: mmc@10808000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+			reg = <0x10808000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			fifo-depth = <0x800>;
+			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>, <&rst SDMMC_OCP_RESET>;
+			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
+			/*
+			 * "ciu" (SDMCLK) is listed first so it is selected as the
+			 * primary clock by the SDHCI platform layer; the SD6HC PHY
+			 * timing calculations are derived from this clock rate.
+			 */
+			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
+			clock-names = "ciu", "biu";
+			iommus = <&smmu 5>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		nand: nand-controller@10b80000 {
 			compatible = "cdns,hp-nfc";
 			reg = <0x10b80000 0x10000>,
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index 262bb3e8e5c7..a9de824e292a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -98,6 +98,32 @@ root: partition@4200000 {
 	};
 };
 
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+};
+
+&emmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr104;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	/*
+	 * SDHCI capability overrides:
+	 *  - caps_mask[0] 0x0000ff00 / caps[0] 0x0000c800:
+	 *      Override SDHCI_CLOCK_BASE_MASK to 0xc8 (200 MHz).
+	 *  - caps_mask[1] 0x00002000 / caps[1] 0:
+	 *      Clear SDHCI_USE_SDR50_TUNING; SDR50 tuning is unsupported.
+	 */
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.7

