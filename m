Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545F49E5FC;
	Tue,  1 Sep 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288551; cv=fail; b=CXnfC2KYZlCrSK8gTCxjM3NbYNMH2BKvPBP9JEnIllksrXfzpiQkJ4GHXqKovDhmiD/Gz4HaBcp5gPS5iUOIQ5Xh2YtRui1pTFaqb60TnRB967GsCUf+HadSGp6rBI4URblLy3uwYjFyXxyTa/5rKC9OEo3/r+uQQ2KczD/N1rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288551; c=relaxed/simple;
	bh=kk34rIg84PEbpLYtTvP9w2pe+KkRdfHRxIm14le2TDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6z0uVlF4HKqnv/t5Mzdt4rcPwDftRpWYwUN20Go0bIAImY6pdf42WdTVpAKNe1doFPuO0/XLJcuICBVKpsl/vj2G4HwGFaLAnndmsKtDFYJtciatjfydZ20GxK4i4IL1lRi6zHQqHEdWB/5KqPByiXs4odv5CvxiHmmDf7j5Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=s91P9kwi; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="s91P9kwi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9FNEiW9eko3CmPosUH5UBYlKZb9noL4i2Bb7MXjAhkZgCJkFwdURXNtpMOVu1Fkk7DCmq6FBX+p5Gr3HRMW7j5Jq68Zg5x17LPafCORg4pytZj6Ec7zPInij6HDZNXBzPqt1Q+5qVNCBL1sto/Gw+v/x/vw263+V9ybKJPMvx/wSw4gOuyYlX6UQiScgdQURlfpweAhi0drMfGt5iADyVdDXBflf2rAnyHcXIvADR3mqJmB50NMW3MY09nHMwlHQ2VtBsOCb80KwbxC6oj9U3CT4s9y1Zojzv6qToKTjJjD/4ykRoDMm8nbRSfa85er7y4BpP5WeFm7topnRMqxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkEWI1qEvYVC1CCbAZgngLC2FrPGQNYzRd29I4JbwZY=;
 b=xzpW5JOd3OPsS4t9P78adLFPwQbsUwTAHGu47iC86NruB0heZN4djg9c0ccdaFAhLTKZJPJSyz+qaMzqEPBabXymHwqPM7W9u1irdR/2EdKciIOoDBcJBrrBm0X85yjNSsH6/nuj2fuaxYU1PCNXvo85vCj6VvRPlXOYAuzfCaEwi6n18WP2ew+9nPeGPxovOmSU3AoFRkRI/NC7WiSpqemc5BR+SLYrGs7mVNi6mXb2Zrwd0SwkHQA8DNEzcHrFr+T4jc/7FQDDteTBUQAIuVM/dT5JtmdcjHCZWAbp4bdUVppbrWm6EBvjCs9YijXAfb5C1dtPOZ8H8CyTxV9kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkEWI1qEvYVC1CCbAZgngLC2FrPGQNYzRd29I4JbwZY=;
 b=s91P9kwiDljX/6yaJFwvBH8z1q7vJOMd7z7A+Vq1i03x358SJcbetvdQZHhGcjXQJpJCsEY8jGmq1PaaL51+F8qAhvK2dEd1aFM9rEPzplszluGQSoVSqvoBGNfDWBTedZVN6j7ZXieqz1MDG8sTW7Ud2x4JfaSR1jfm3lq7CBAd3T3ktQXJqcAcEzUShjAnPOwSgBoTeWGcdBaLd4dI8mhIpdIFcEwlAHMj62Gam+7WSuALSILhSsCp7Xl8IzUS350vhVeY+5vYZfSJDTWg2nhgvgAGAlRySxqcmhG3LVgw26js/6LSdBsLsqfm+UzzyzpewXhuRXEQ4NCBwiGGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB5278.namprd03.prod.outlook.com (2603:10b6:208:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 1 Sep 2026
 18:49:07 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:07 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter board
Date: Tue,  1 Sep 2026 11:48:14 -0700
Message-Id: <20260901184828.15653-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 89abae1b-2cf2-4b3b-7d66-08df0859b3ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|56012099006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OhVssiGVmdnJs34S3Z775UJ7+xZXSTtK+vSGKXhDf9vsplaJbib9hh+xPV4vx0oQfa4jtFED4NDX88P/ZOiq916TokYe4LDelr4/ajAZAmbxbY9/LZ0raDyZKoWCvoHuSllanUiDv2pqDhB3mgnTzpoNUHXz9lKR9L5I+pCWOPQhcM5rZr3uXU3kdfctcd8N+iAycpf46VdwRDKjmrVwmDRs5ZWHKaGcjBrx2lW33y02Npm6Y9ZnzzFVWoDvLwefdp36+tvrXp29/XOUvbuJEUPtZMyMzo+OGRkM2QP7RAwjX23Qf7yuwqeToBt+VmFKvKl+oq664TXYNKEv/MDcU11PaKXDeBzvwd3EO/iSdenqwZOgT8W5mOhFNHbuvIrEreAdkF7Vn673QLFCVOrn6O8aZy+hPoN/KhDYaFCN/H8In58eL2GMcoHvhZKPSSwuG6bOVmsHX2q7uoJIJiRug13mPSWXzF/9WuwAVcenGKsLaXCwKGDn9UyhNeL8T00fFyiBwj1GYSHjj/p5Y1pdQRfskRMQkiM36IPwIR6Pui2JjdqMS62Xa38k+eLuOj7To81kZnmt76SmzpXyEqJkAH7+QbRLJi/WUPcG5oEjYLwh6cuDC09YpUW8H67Vk+jde5ntZ4xA6IXACfcjepM5u9l/pYzMYOoUs8JZ8CYKMWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gapv9h6+YSwQ2WwVFMlvg4lvE96a62ZGKWZgIYDxyvZd+z5OcspEG4P5RI++?=
 =?us-ascii?Q?DsOTrm7Yp1qXxu5eKgn8jRoUpfd3F3XFSTgfV6YF4yGWWOyCKHSKNtj3qzgp?=
 =?us-ascii?Q?jIvtpYbnCV0VpfLwVDger4TYBt6FWIXbPdV4G7wrYlLbvEZBJwyWkHIudLe8?=
 =?us-ascii?Q?zqiLjp0dqlstxBpssGktEyFvhc2TSfFGs6aiudu9S+cbu2iACQ/fM9vHEzPA?=
 =?us-ascii?Q?l78phV7o4VKbdB7KqsF++JoLP0HcMLVWkzRc3z3OEtk40qEjUxi4XaWi3K53?=
 =?us-ascii?Q?WguFTxgsufG2f6h7/xvCSnmF5P6VrQ5uoQ+omlRIzeBsWJuxRoLuVn5/oXB2?=
 =?us-ascii?Q?PjN2e31Zwyd6tkTpyZmC8misThOulUnwlz3G7VWE/P6+Z3cr4X+mb0oXnRxo?=
 =?us-ascii?Q?X0fTbFCfC2YCcYhN1s1Fdz2yY/YtjKEzwJKfBUn9SD+AxXmAU6oTEOI4wJr4?=
 =?us-ascii?Q?dNXhWJgxg3e7fnCQpU+B2PSJlRSWCTFgHZ5AxtFxEuWgth0Y2uwz51FjvJoe?=
 =?us-ascii?Q?qj8ej0IaR5yUbagaL7hPjd1IkVPflnbVvSryX5DRmaWYwGs4LniLWFCyjK4l?=
 =?us-ascii?Q?CuH6JXEj7WQeeqg50UClOIj/5ZeTGY1RjqfmINW1nI6jG9rziGZqTc//yNVq?=
 =?us-ascii?Q?ul+c07ONL8HkAaQCQ8PISFfvAWFKLcGiSv98SyO7/btb3s7HYH6TlVrqLwNS?=
 =?us-ascii?Q?9xJRwRZv3WYhks0U2bJFyT5ozaTJos4kwPPKTmcWFeTFqeOEGjmSdch0vAhj?=
 =?us-ascii?Q?DHzmBeL4uFAxdZjA3wPC5xCH3VXyDsksvJO9DVMAUyq8XszZPGvnXqeYQb29?=
 =?us-ascii?Q?AMMb77bR/ubWeHR+ymgn1DX7hZhbfHWwvYwEqHKHufpW2Y0N6Onavq9N8eV6?=
 =?us-ascii?Q?CZT8uW6D2Fm0HbvvIzDAhEsbK/gqHWv3j2SlKq3eNRAhISTtJjn14HKpkbTm?=
 =?us-ascii?Q?w9pCm/WbyTL3yzPi+GIYwKKuPGmKYkht+eBmhF1XntJHqOKuLOvdxdTFvtPb?=
 =?us-ascii?Q?xntzYrAxMEO6qWrPmn7A9puryf1is3OZ5FvGVqyLz84DfzOgzC3ST/ypl8wV?=
 =?us-ascii?Q?pybis9z7obgBQEB949y4fUPYDKFUUvWJxg/GI+SkXY6WEUsTzGS84rEVTTn3?=
 =?us-ascii?Q?dWBwy7d5gtMctxm1V5KkfcCcVogOfwFIVZqWg2zQA7w1nF2gezDCyyESX0JO?=
 =?us-ascii?Q?GACyZMAjHkD/iWR2x2maw5aaT0LqPRL7V4fXOUbLG7k5TF6lZdwSYrlkiu07?=
 =?us-ascii?Q?KqdJWkQUfq/3b8bPG3VCHWStVFpgIke792LkCh82HxZChehMV39WE4d6zcJJ?=
 =?us-ascii?Q?tcdWA3o7xXiox997eGV8jeYfwvlPXGH32x5PMWvm6Pml4dLQsOUUGnZdlU9Z?=
 =?us-ascii?Q?jc8rQ7cC0l/Z1vnckF9MgnF82SB2ksnu1wBP/NK0zkA2K8+QucY4mME1MoUd?=
 =?us-ascii?Q?KSEM73mdZDe5Za0eA/fuNoHoNq91fUadrWX7hMzuAC88u1c4jmhBicY2PiVu?=
 =?us-ascii?Q?DCekV4HXk8q5whjvixufzeK3XMFYfAg/WF8dn/i3tqmD9K1vOhPiYhzvNxOp?=
 =?us-ascii?Q?fSk93DubFWvACCudKRB+onItLWCTD70nao79/dbwvvpRySLSk40AorEpdqCB?=
 =?us-ascii?Q?huUzLCuyx6IIUz+9PxlPvo9eUjwoGn9Jzb/AsPiYVHzY0xXbUAxuHMHgjkN9?=
 =?us-ascii?Q?2Nkco12C7T/hAYM0B5qverCneQurmeTjimwH1jAJX5zyHi9R0xfbjjs7FhWG?=
 =?us-ascii?Q?xEkarOAz9s6ONSOYcDxu7RDLQf4aW8k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abae1b-2cf2-4b3b-7d66-08df0859b3ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:07.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTgAnIxUKhPA+AqEqkIAbm69fazp0++ZK7uwW0FNavkQxwh/N9895KFbiHVG5aULMRPkDh2+D+CBGBVmbp3G7Gnnlw5Ncy6V+05bWQCgkpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5278

The Agilex5 SoCDK eMMC daughter card wires the shared HPS SD6HC to an
8-bit onboard eMMC with fixed 3.3 V VCC and 1.8 V I/O, supporting HS200
and HS400. The board also brings up GMAC0, I2C, I3C, LEDs, and the UART.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Depends on commit ab45ecfab540 ("dt-bindings: reset: altr: add
COMBOPHY_RESET for Agilex5"), which is already in mainline via the
reset tree. It is not yet in mmc/next; apply or merge that commit when
building/testing this patch on top of mmc/next.

Depends on commit 10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable
the SMMU"), which is already in the SoC DT tree. It is not yet in
mmc/next; apply or merge that commit when building/testing this patch
on top of mmc/next, otherwise the SMMU remains disabled.

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 123 ++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 088a03b89c99..add2b91f5972 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex3_socdk.dtb \
 				socfpga_agilex5_socdk.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
+				socfpga_agilex5_socdk_emmc.dtb \
 				socfpga_agilex5_socdk_modular.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
 				socfpga_agilex7m_socdk.dtb \
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
new file mode 100644
index 000000000000..beb4f444c471
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 SoCDK eMMC daughter board";
+	compatible = "intel,socfpga-agilex5-socdk-emmc", "intel,socfpga-agilex5";
+
+	aliases {
+		ethernet0 = &gmac0;
+		i3c0 = &i3c0;
+		i3c1 = &i3c1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "hps_led0";
+			gpios = <&porta 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			label = "hps_led1";
+			gpios = <&porta 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* Expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	vqmmc_io_reg: regulator-fixed-1p8v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vqmmc-io";
+	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc-emmc";
+	};
+};
+
+&sdmmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+
+	status = "okay";
+};
+
+&gmac0 {
+	max-frame-size = <9000>;
+	phy-handle = <&emac0_phy0>;
+	phy-mode = "rgmii"; /* TX/RX clock delays provided by Agilex5 I/O hardware */
+
+	status = "okay";
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.43.7

