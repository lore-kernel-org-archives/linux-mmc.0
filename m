Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4339184C;
	Thu, 20 Aug 2026 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252271; cv=fail; b=ZvQTylYbhZdRLeGYW2kC7ySsJOOp1ojP1wlHoowcfHN6g3CfDC6kxAapujc/Cvyg/nwUXdnadsLY5CzdbKVkJZivaxHOb4i22rckhnYVjCBLYho8UyBFc+vCeF2hBoCBiDZnKbuGJMSS2P4G2Ya1riH+ZdvkrM4VIrncu99Tp2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252271; c=relaxed/simple;
	bh=WczcylBLqQu5lmjS+gZkofPspz3tzFt5QxTbeKFM2Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toVBCFN1voIYEqIoMY1kSrztO9J68u1ZbRTcU3M51n+ANspp7TH8wwCMR1Oflt+a2Rp2YUNwB/H14wBtxRzTg94ATkx4K8kWZK1roALyGKxZYmBjcy2dfujakb8dTkbL6V53vwXfElKFJzKL8Dn0/9e8tYKtGxI8Fm2tTmlLtoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y7mHQ80N; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y7mHQ80N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMUB+X2EX9uisG7OYGXwEuDckAPR1DSXnSpDfYT1SRx2q3aKDS5Z0RxddhJncs6BZPCAjbJFN0CYZSae68QzMA36VN0L5ZkTAcLiIUjEFPtgJMET5xZMvpyL0JK4jloHUmC6ZzIkDfNdkE8U9bGS95f0fcSYy4CYF1Tl3fE8xzQ16ZITfcXtiw6mvfyde6/Vlu8TDvboVNO51NKDQC67TWisnHjAf5W9/tfXwAm7/EaQaq9k92RWtlzfLKuwapjVFZWnE1U9jqZuQf+5AcMB3cJKdxsviuDTivENdZFYT0JveVF5F/jo02jbae+IhYvyUHuzXaF109qWzTFKIU5nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6UZTonAKOknQboePts5Go6bifpHd7XMpHd0Nj2KV14=;
 b=RtQPAJjr5QuVFJOhIHrlXYnf6dNISZSELAPD69a8ntAbo7ybCk5rUXXvdS5+8GznDApc3UMBhFEtt60OZHfA6YT8Ha5Iv2DAQgt58kN53bCcHUXLvxdccBlPxGyE1grCGzw0ACEVzawbVTBknYX8Y4gUbql15Lp6trrmgZ1ebXFXiPHFwf/HlSrain92Cl4JSVGa3ovWnDDpTbt6yWrtThD2eVbyLoN2niV5gELUEU5OEBhoeqAtjIGtwHos3IBktd1UxlHA4JMsVDpYphzsOupuyKEnO24vIN2MV9pXcw4bxvFUkdWJzkTxdcaU7C2q89rgDY1nkj9A7BWbZbdS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6UZTonAKOknQboePts5Go6bifpHd7XMpHd0Nj2KV14=;
 b=Y7mHQ80NFyUqimZPC63q39Mn3/Ug68TPZ0P+1g0HqNWG7vlM/m33My5AXU+8zY/3z1iHg/RYu1tyhRHyxG6MzdVwRpxoyAJE/Y9TZEzAshDqwC9YUWkUigCTBgIOjs+XKRL1lIeT3Lm9mB3l/I6Fxh4nmNv6pDUZLe8Y7oRc9AzGfanr7W70BdLj2mEx9m3vA00yr0BhkRy+qZ05fxEEMoDb3MwMzC7j7bXMDy7+2HemOtHuuyBHIMMB35ZQi8GlKQKLMUm12nDjdmL9MheFim9F9/6CTc6+ep9emcCogeJi7hkPynMPTVaTAEv6+NnOGuN+2N3avoO2rYrZ5GfbGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5636.namprd03.prod.outlook.com (2603:10b6:208:297::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 18:57:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:39 +0000
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
Subject: [PATCH v5 4/8] arm64: dts: agilex5: add SOCDK eMMC daughter board
Date: Thu, 20 Aug 2026 11:57:10 -0700
Message-Id: <20260820185721.22823-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a16492-67e2-4ec6-9132-08defeece80a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	oIt+BsWdTLnnE1i1+eyrrP9kx2xndDs25t5XDtef++Co6wuodv2q0VpLPqyyWy3vuOPy2D3dlGJHLDmyog4PXw6U3SgKrgoKn6538Ulu2E9iQHdQw3ua1vb7Cqnnt/BpL+5topZl2cJh+5IVLnibfClhBing35BfAEsUlLhqwCJ4NnnpkrTjFwxvepwvr0u+1SjLmVOnNl+4umyihbw8pRGhkbwv2EIz3oaCUQXOPrxDVnsvdZv6SE1jsrhuBY57Vcj+BqDBAfN6UOEpMcd+0teFTjB4IdMDQSVw1qkFKVAjk+e/g7XZxRGkF81PZJkygfd424BBbIPqATbwMiJPGXXInQmaVW6ZcEfI0Q7nVvJnrt4Bn1lC+voP0P8d3WZngzmWU6CdMHFDjnvCw9p9bpt9kdmnCWSpF89F34smb/+q5MxScMLk6hphOr+z/icrGHBr46xb3BCHanpbCBSPxzDri2AqrvMI1YSwMCllDZn7SqmukEE4xN0WCayVJd9W5Qr48KZ0ffy9siTFzGt8/XDRcRPkgqtgBQhYBDqpbtrJYYXQr8lUALCyG31VrgDIYI/ahNteIIwYIivtSEAcsM2LRwTBh5prDXKL6wLebhKjY+mk/XyqZ4P8gcWojQQdnG5P//q5VtlQQ3FDVA2iVWPN7cYpx5+qToIbPd+wW+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnF+YXqWTxJjeg9WgED82+7tKaYNG2N0Iv9xo3/Xa37hY6H6aHg4FvaVQ824?=
 =?us-ascii?Q?g62tzr+EYVoH9TkRDFfJep4cw1iHyg0XUq9uKhynrL6uPKZCW2u8e4oYUzz2?=
 =?us-ascii?Q?x3HHKzcNIkP24M0tBGkq3hT+OouE1CI+0npm3Sr5/vyJQlQ0e3YwMwQ/E+LE?=
 =?us-ascii?Q?v8PEBeCfNbhGu6LWo0A9+0mBVuy1YtETadGjprIv5rhqZ7ZKvrONQcJmENR2?=
 =?us-ascii?Q?EK5gnFivLmh/L487jpnqJGkivAErA/HKU/Wn5ddzSN1jfMrr9oj52UOwizri?=
 =?us-ascii?Q?th4XnVXi1QIbNwel4o9zva6xS/ktQqivoFlTVhulQyuB/Mvz4DPvMC+iOXak?=
 =?us-ascii?Q?AiTpLMHMFNWSvZHwaqzn9a3sgLg0HQG5HVxj1uktfKV1ghdd+6xEb5oSQHko?=
 =?us-ascii?Q?ZNRKalGlgdzZCgHc+Z2hYgmUb32Iaslvh45MnegeE0ZPRI7tHXCZmfqoM+yt?=
 =?us-ascii?Q?5BogZmB41xL0CN+WBdVS4sIeE+qMAqWvrIX71eCSTuai0GiuY3X7BnY6S7JC?=
 =?us-ascii?Q?u47lX2hbcgJyOmp1Src41BFUzaKpTJrlWJOzQUh0xwOlcPa0ShKRrxzo8Y/H?=
 =?us-ascii?Q?gVv7wrp26s8iXXSWl8wC/oNwSa/Tk91qzY3Yk3s0yHsVk+b1At386d+yK1KB?=
 =?us-ascii?Q?6Jd7DBzhsR9TjJIj9PbYLxITn9XsOSCGBm8HqzF0Eu9P/0NJ7LAauTeuNPMR?=
 =?us-ascii?Q?Pk7Lio2waKYp5FCCrTbdspaoZyyoKMPkzz+jFhZ62Ly8UI/i/JnUw91GLZvz?=
 =?us-ascii?Q?FYl3TTvZJfS6KbG4mb9Kgyvd4tTZeWVCupo9QOxnk1k8TjYCiwub+NV3zVMv?=
 =?us-ascii?Q?Tl/WX7RgBwpwFO+mhJs+KAzFL/0GdWNxD/C/Y4Cydf/VZTbAQabIfkWkjPys?=
 =?us-ascii?Q?UJQuYkcxVqZF5kRtXwMAl0my2zXBAZMedktNMcD0He7ka6AwGqiG5NAgsp1/?=
 =?us-ascii?Q?4EoHg5p8tgN6sYaIvXSocI9to7k4YMHcvo2oq18F2mOpEJ8dmYZPqcVWhxuc?=
 =?us-ascii?Q?129XQ2McW/yaVxkFGXdfDxVm5an9AUyir/QJNrt6Ew56j7+WyQhLUwBv7DRG?=
 =?us-ascii?Q?POHIqlHk2w/q1VyquQC7ron7R1TwZdvxgXi6uxf5/9IqjVPGxjaPLAwDiA1z?=
 =?us-ascii?Q?A2Z4epSRWB8sT+7YHb5BDAjgvEoBJm9E/DJAdtKcuUkrggBvGe5OdI2Z5fgM?=
 =?us-ascii?Q?az8PPJNhBw5vYXisIuiwXpee+sbklsJAXNk/jp4V7HUFKRr2pySYDI9ddItM?=
 =?us-ascii?Q?lJwaA5AlRYsfxthcKcV2Y9Tc7c7p9WoS6ZYcAFRF17vkXttyVXl/MdXWZkVa?=
 =?us-ascii?Q?hbdaeItWhK5SzRIXkD1OXxwRs/FsjSBTUEoIQDx9+U3Ii0hHJ80ijC7DPo4S?=
 =?us-ascii?Q?a6+GfXHxTpQZRkbsN7i2dYAe1+Q49jGxD1TmLvhP4i93muUwDUs8zgLNKCWH?=
 =?us-ascii?Q?raMLaNdXlPmrjsvccVhXzgMNE84uIpe5JsGouc+TBGBh1Eu3wbvx8/JDiHHy?=
 =?us-ascii?Q?aQV1dtZcDGdDt7FuyMR1TyDHQr7CJ31zyxY7qi8WjzXLWdnMy95kqFfo8bJV?=
 =?us-ascii?Q?jsYakUbeMK0vcBcwlH/8pOPak3vOf5dGhEyxoOS8XEKxQ39CXEqPWUA4dEHZ?=
 =?us-ascii?Q?v22/heANr4EyJpGIiBCSr4PgU8VNGaO2ZPEQkXBjbTbtFD9ZtyB/EcJgREKA?=
 =?us-ascii?Q?REFWADHz//pKeM16XtQHkiGrk14lopq9QmYA8bep45KYht9YjgBWIsWmmcfU?=
 =?us-ascii?Q?W+PkSF8PotB4G8mFalcqQMrBj8tg5wI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a16492-67e2-4ec6-9132-08defeece80a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:39.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJnOhee4iG01rpcgp3kJ3k7PS1KwhsYPq6hFlNTfsuyviSl18aGEHN4COd2RDVrL/YLrhRMZGF7tLVn0Prcy9DRaMYBxKQWU9b7l69c/k+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5636

The Agilex5 SoCDK eMMC daughter card wires the shared HPS SD6HC to an
8-bit onboard eMMC with fixed 3.3 V VCC and 1.8 V I/O, supporting HS200
and HS400. The board also brings up GMAC0, I2C, I3C, LEDs, and the UART.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
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
index 000000000000..af9cf11ca0f2
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
+&emmc {
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

