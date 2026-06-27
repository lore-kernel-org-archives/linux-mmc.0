Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7819344DB5;
	Sat, 27 Jun 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591341; cv=fail; b=k+njonLZx3jX87JFSMfg8liG/Ix9q4PrdfAWSaSzfIlddI1qvqWUW5aHGi5wlD1jPz7x06G36818zDsUALfPP+29wALbW3/TefNpv5AYEU+yaTznXlkP7DmTl+ZdbAayusn71whFTwhpV1h6HM7n6ZEgLWpw/uIbwXyKBqFRCbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591341; c=relaxed/simple;
	bh=ZPdJwBZrqZVTgJ38ZUvJyNbfR+8rBfY8uSNo3htyExg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8dfD4L9nj+fzmbq5z0XfWNQ6HMobZxztJ/AcTmHYkxGR3a3YsEnZfkCGG0CTZqdlhCMxWW/F8IzM08yRNRKwmYdiXZkZ90OTfivhAT1aox/DQeRZy97/A28QY0oQrhxF8KtAwvAeA2M8aJiwVTPbPyXnS/yHFu4JZIRy1dBHvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aj15rRfh; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aj15rRfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms09roeHquKmkNnr5VBnqHvLOvuFpxw8z5r0kfW3mhA4cNX7eNNyZGcdYFKNaMiFwA+7EFFSo5P+jlYozSrq8Y7fhsR5ywlbcwm+vkHaUT7JSzw4SrqmBwbc3GOesbvXKKCxTyD7RBBrqH1hyXIUtpOMo0FKar4ENmZ2C2RXnd51QwSVzOFuhelmQfIp+gnl1O8GtnqUWuld5uz2kU/8f8/mY+xax19Bu3VOxJOwIkbjjvaL3AWo/zJW9phwjG9Ev1LNg6yYOhyGOMP9W9uo8Ko5Cjz85zSph7hNHqFTNYaASIcO6C0/HZNU0/jedonhlN5b6gWF8+DKQhIpTfTwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g81YHeLBmEpV+cEfGHlXRuI9Ub2PaJf69Y3WFDz/P+I=;
 b=W/gRUwhV0WAvTGbywfW8yPnPWoKpHxqnRxLmgUt/G909B8fj0H9hB39x979DlYhukukuirVHbXlNk04JhEBdO5pSX9pnqDsJ9DLXcxxuLWSP91QOTwVPmcfemVW9GSr1+ZPfTnGLRRxB4NLVfdbp/P8iLYYQaKqJnPIfO/+cGyVGIG+D4KfHhzrOSI9NqTW7X7n02Lapz7eRS0tMI4Bi8vAaCgeYPPHmuAZdte26aFvdYtPLpsw9SXs2XV7Aq8FoSJwPrg978sXI3A8tGZ8h8Vi9enMmed6p5akf9KvvZAcOweVkn82CZnaMElfY+aGjZQ3XeJ+FJ+s2OIhb2O6log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g81YHeLBmEpV+cEfGHlXRuI9Ub2PaJf69Y3WFDz/P+I=;
 b=aj15rRfhOdPxxxdXSHN/peD1ZpZg6wITcaxbc3xwgr0JQfOTIpej2rgjGFr+Jv91ROqfaRC8X4I7Bs5d3PX1FCDp1iBef/nAqB/cfG4fxcSSjtv/fl1BsbRRcQQkzEFCGRbsK06UDucl2E42zHfODbvi3OU/dDoQ9wzfSTkV/lJlDlC6x363oyGGwW/GP2ExuUQgiWvOtswV+dgBcJmesGUebRYo27dB6xzmgKQjwNlPBMRrAod2l5beq6Gn32oVCXxLHLUt09ExSvcdvVj3/7uMkH2REqkur/DcZ+g5w/qa9c7ZnZk/mi4AgXLQOmTlU5JeLh68FduBwbk8weOyPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:32 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:32 +0000
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
Subject: [PATCH v2 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter board support
Date: Sat, 27 Jun 2026 13:14:50 -0700
Message-ID: <20260627201457.12318-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 88656b1c-d6bd-4c59-94de-08ded488d6f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zvFacgzORoIf6IQqSflZlq9p0gU+dDJedik1eM2NXilN0/dZn1PK659RwT0jzMMCYaRJajNJwoDSIK0MbLmiAz0lp4527/7kWBrKv1Vm4WImGmOR3SaDDnnitiuassjeezXK6mGeAqIjcsqXcAMAbWE942uS3RuK5ThSBWgxQN5ouTD5tlUPlaMRduCwyQBw5yCfvzeRIAs4PEApeuFDbKyjLYs9RrKmBNwIu39L4EvwTC2eDCxF2urqjmh2g70I1VQzhls6B/yVtYvC56KqP2q1WRc8rMwFB7XKo0c4Wqt80qJNhtZ+ZI8FEpUV7dPmOPX4qYBNr8DPLPg+9rDbGAoQkoPJG3yjxBb2g/XgJFb4w7c/vaexJc5Lz+mn58UTGMBkxA0po8tdp94Pck/mdF4NyN9BFpiybv/pw32n4pLAzCEaU3o5cqOC/DO+e2vgh8VnvAJ78ZdCQ9ukABQj+FkzMedmVKt3S+tV2kKakdPvrzHBN6GM6Q9Uuuh9PrhVATyCCGC8Qwp7xo9cB5qEwptFEnKN7jZEjAmhbHYpaUgxX3oobXeIpub080blOWwms3uXGDGCNeMjyp4mTb7XZOPkRwzwJDDEUsHXMQF8F0X6Acnt3RvfKzb/k24WV4xjDs6vtcxRep9mECevygzKwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9k6vEtOYgie95yag4giw4Fy1IOgemWCBuDRPH9jYK+5YIeS7IzcuOT5oj8nA?=
 =?us-ascii?Q?9CiyUzw+GTebTlid3oN4tNC0z6/C49EN/yH997wq9OoEYZoEPp774npQ0uX0?=
 =?us-ascii?Q?ZXpez8L3c+wABK3JpYusIGdg6OPU27Nd00RmnXnpLto117AdPjS8xN7MPdhH?=
 =?us-ascii?Q?8TndjRG5xJ3Csv0MctdBgAZsOKCc8hHC1ZOlwTSJGBd48IIeZnvCmGm30+LS?=
 =?us-ascii?Q?hBiNhtHnfIvncwGXQ0HySoTkxUYCU2cbE2KM2kAVAzF6wMBXX8vYQLfJFjbI?=
 =?us-ascii?Q?nelceDflrDhUq+nyc1yhui7JZxlysmnYVV+nSpyfps01mJpvia8Qx+KWMQlP?=
 =?us-ascii?Q?RlMePZqft7/J0BVKlJcTjDTbP6wbCS7YT20ghkc2QKIFxwFWL30y47YF9BV4?=
 =?us-ascii?Q?ZcybHVOLgGu1ymOEABjAoaaDj7MfWo12zoEMoDqX4c+RYFYGehNiTl1c/Xyk?=
 =?us-ascii?Q?DTZ5IFMcbJsFaHu17oxhPwv3vpELjaEI/Jrv0f+iZJIVXx1BKljOLrJIpfRt?=
 =?us-ascii?Q?i/JIOP69Nw0xIA5m7729R8oY+BS9gXxJ8ZBv+934Kvc8eI+9CJ44mcDYpF4N?=
 =?us-ascii?Q?LWORFSE/Slziq6B5mH8X3zKTOATZgCy+63utvyXp+BGuSt1ukJAXfkW8SuIR?=
 =?us-ascii?Q?Vr8zw0AyhA+CDBTyZ+hHhyPeXkAbqJUKIvzIwCMgE739s1yltr/0TjypLfNQ?=
 =?us-ascii?Q?1G93CzFTh7Q4uLGAGgD34YRxHIqvXZkKgEGVxVN6cNVrZyVyWlakQTbdhxwx?=
 =?us-ascii?Q?mnVHmUsU9ayfnZcExx/pL98O2mubqXKJmQwElUXGTuW4DEOaR4rxGOp9uSKd?=
 =?us-ascii?Q?RXAmXswZxuWYSAco73LuNVAO1sqaB2b06ftMxmdyTUzNJgM98t88mUhypH0d?=
 =?us-ascii?Q?5g+KkZuzrHZVmpRVy+3v/BGxEA2MAExFy/ihLn22GQ3/Ii8S1vMHS8hhbhnB?=
 =?us-ascii?Q?WhEYE1APzkhSkHsMkG6kV/KwzXQkZDfNhzgrywu022n44aScB0RcUjyh6sN1?=
 =?us-ascii?Q?GGQ9HS6bfYRyy+rf5lBgWReKMLaU5r2Oae80GQdVurSkTrIPpyHSPCLw4Jwx?=
 =?us-ascii?Q?OUNdEOFqTdKyWGA/poxFkVfxS9zUiASetT+7BU8fLhsrDEtE+R467BUt/sFl?=
 =?us-ascii?Q?HuG/zN//qXt75yy0syBSs/LiBvhjOaTdr7mPqY5gsoFyHYsK8ud/c5LRI2tj?=
 =?us-ascii?Q?wlKRviq8UNiWI13WVLAAb0I5SsNtYmDXufzXaDDEYFyZFGaPsBiGUgYjk2x6?=
 =?us-ascii?Q?42Yh1nOLj3m6QNyg+WovHigZs2XqjkfBfWvPNoc0AowyGpsMHo2WfStf0+z1?=
 =?us-ascii?Q?cuQ1mvGSzrl0aPLlzww/AnCSSFEnyDDsyhraCMlP+ytO/Wr65UsGEB5FAD1Q?=
 =?us-ascii?Q?izAOUcaQyCShegUNoXczhBDYW0OckbwMaeiEXljay91yrvAHGgkjLAkA1CM8?=
 =?us-ascii?Q?dMZoxLnj/iNo4lHNR6gpAr54T8ZcD9LHSgGjJ+R9ZRD6IvSk/hHiimrmgIo2?=
 =?us-ascii?Q?SrGUHvumhUM0ZeQeoskGx98WZFiRx5R1PPZQ5EzRKr7L2I0K1H52ymhgxnU6?=
 =?us-ascii?Q?OTvE31YUKdqiT6GeDvZzA21M3suhNVSSqG/RVmSxM0jlGM6f5eNl2jsIgrfj?=
 =?us-ascii?Q?/26m9+kqdCWCvLLEyEBAn+1GGvl6EAEJQYYpMTEH9VwfFt0REIATM4Wct+1j?=
 =?us-ascii?Q?mEjJjEuDW8ccv4IBkR0r2pTOguslNgdV03PTakJ30ceZS5RUFDEBcJqjUR+Y?=
 =?us-ascii?Q?srb8DKgpM6ZgzQ/0WLTl10dfZ26Wtog=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88656b1c-d6bd-4c59-94de-08ded488d6f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:32.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vaggwe+Ki2B1FNBjxXWgNdxW2QcaiVxo3A2rEhic0MwmVQU6W/pxKfj1b5aDHweS1em6Km9evOZ4qcJqDY4aqOqi+wAM38hYBcvJNBS6hyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

Add socfpga_agilex5_socdk_emmc.dts for the Agilex5 SoCDK eMMC daughter
board variant. Define board-specific regulators at the DTS root: a
fixed 3.3V supply for card power and a fixed 1.8V supply for eMMC I/O
voltage.

Enable the shared SD/eMMC controller for eMMC-only operation with an
8-bit bus, HS200 and HS400 modes at 1.8V signaling, and a 200 MHz
maximum clock frequency.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 120 ++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 33fcc55d0cb9..5bbbcfda1f48 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_modular.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
+				socfpga_agilex5_socdk_emmc.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
new file mode 100644
index 000000000000..455808db32bb
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
@@ -0,0 +1,120 @@
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
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
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
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-emmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vqmmc_io_reg: regulator-fixed-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "vqmmc-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
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
+&emmc {
+	status = "okay";
+
+	no-sd;
+	no-sdio;
+	disable-wp;
+	non-removable;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+	max-frequency = <200000000>;
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

