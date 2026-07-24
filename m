Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C834D4E2;
	Fri, 24 Jul 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904626; cv=fail; b=nkT2LAcpg4r+VHBnDpO4q5lDbKEsqrsAOut17AbdVCK1H/Sybnmz7G+LtciSe9mwfXbiqLENroGC26aBjSXGTQKijOfaGv/zKZ2IK+ZZwsiZ9owS5jf+qoLhWDN4GXZg6PXZCUfO9QIR8QKV/MWu1A1SoYJoBZ+QGorCRYzyBWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904626; c=relaxed/simple;
	bh=V3imySbw84C6toaYahkRvRS9bFULfcijKXJdRYzVadU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuQ7gDnGdoTGndB1FkbjODHAUrGeQunAScRuKcBEpxyW2K4k+5Z7lMMs3j61PQpKERoppD9PofnwULstQhRLzqDbWNmWtc72N8LrGfR622IS5wHTU5Qdw81Y+oMJPDvFboGzR6JJYl1tp6pICa32rF5A29XQsOfVz9G4gKs0ni0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sK/mXxqA; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sK/mXxqA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXkUFnvur7fbm5taylIrHbHJydPLyPmDDSz2RfpJvIyS1qjGzvAPRiXKT+njgvKVUOLZ6syYd/8J0Uj6CVtKbLREbRP+yQYCoPKX6CIr0DEnMN6Qxagt3h6JJiWi3dcFgqgRscqVswdqUCC8mHt90MiqB8hFg0pwAAHVt+7/fV51rmukjj10jgwPpTDHPO4UcsSdtF+7Ngb1dzeZ3Ozfbbj5HoL/IDCRCZAI0gr0E79d7iCQ7Ow2MRgwl3IwDVdcK6loTb9P7Uo6pzCiHCceDsynaVogoW48kjVBS/ZIpWe+0jO7rzz1Hjtmzw5BjGvPoAPZhr/9N/D7bgAbowVcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkVgsfrgM1oW1wcs/64cLRwkLfZ0jQ3U7hck9zOywBI=;
 b=wXzqldPAxCB5I25HYT28f5KsZUCg9HgxVs0jqBXa30DLvpdXKoZM9diHvamqYl4OQcjpmmYJ/W9IeXTaCoGvYtE9UNz6a9IiE1H6MHwT+O/XTVDiRdJfvVw/rzXGL3CZ1Sl+0pqaLG5xYaaVqHFGIt3SMsaC7ZOLt6nyCd9vhSZnE/hikxFvCB6ayorfEHVLN+ZWaf1ACoyJ2nE6ycwqvAIK2HHRPERXKRCMdZceene3ZkPz4HgjZX6hl5PT7XxvJfYV+N1WxQC9GF+ImD1Te5kGJrFiBcNESCcLtCdFWn0t7B20pk8rTr0GGf0KMaf55P6pRs8asDD7ndMKoU4+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkVgsfrgM1oW1wcs/64cLRwkLfZ0jQ3U7hck9zOywBI=;
 b=sK/mXxqAcY99/FoYUNOw5c3NcOGyobGY2mJr+F6e6SIC2sCjomr8DGbpCYHXHWteWiviQ38NUaaNHOCCM/roln3wtjvoZVAaPvSh2xJ/wqO8Fh9ghqzkWdRQLtQLb1p+bzeiiND9lK1aK0Cxa3I49iZ0ug9OhFmGvs1eM3POnKTykwGnqHZdbm6kPPFmzKj0/xkrifS1FEW+axbdTZ0cJbYoeWmH915AU2sCaeIdnXf5xNfaHYBTyRyraXmLCGWvsKOeULSQ2fi3A6KmtGI3qvxdYjmBLi8P89rGN5AgQjbqma/dO8Ey0SxFYAVz1XLZjpHq6U4JLTVxWOk8mQeX2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:19 +0000
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
Subject: [PATCH v3 4/8] arm64: dts: agilex5: add SOCDK eMMC daughter board
Date: Fri, 24 Jul 2026 07:50:03 -0700
Message-Id: <20260724145009.7456-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: e13d8ef1-4968-4565-d8bb-08dee992e1b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	7GxpfliBmNcW8tmimD83Vd7qZFM2UO2EADB3e3oCCIN7msobKjKe2lxhvxuOGuo5V+QPQMgcaklH5cbOg5rZ+qCTon0+H8bjcgQJtupTLzDR524TYkhK7LYx9XZoM0yBLjZ4Lvdyw2TNudkXeTeBdSB5LlcXqdbnWZ1ygV64I+svkIlLftBVxvR9tHzO0tyZOqxMzgupsjSZPFuwGHPOxr8Bdbm9Jx764OMF0hHON7sbc3CyRDdAnbR8NQ50r4SkIK2uDqrTidnu+O1UUZmsA8hSEcXFvM5IouM/uPefHsUo+Oqbn4mmwwxg6u65SEhh88d1fCVb62fCE82Fj6IzBEpD+I4ce8cdKPM88Ldq0C7WcmLCArThW3o3DIeDEpl8RuGvuDBR93OZEhnwjDYf6tzTyZUEyKZ5/mSyQxMAhrs2coqe+ao0S3tcU8+mifcnkHwfcN9R70oIA/3N6nT9xidEsxxFjff4jrm+abTtP8SooahWAU5W+FnUVIceHyivxBd0y1MOu0xqP3eA9Pa7T04wm5lstrHlwgMumrV7/ptoPF7MBfZErzfXoH31gKZ/zKqqp2AQuMviHaeKIvVhCivtYYGJ/9H7E8Kk0T9BiewW9D7/tUR2d9kV3rrt6EKIjBT54eeaN5relEaQOk8V+kSjOWhTB/E3p/XjmldB4yU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIYBlb3uoleIXqh6cl4N54xYUXv6+cu2rBMeK1ES9ipOAfli5l0FWOTA9p3O?=
 =?us-ascii?Q?TQFkTUkAqoLEofrAGpkKVDfiJAXYOSXi3zm+kPFxpUnZDB6BEjhUQt7KMgr1?=
 =?us-ascii?Q?28uYYd6QD9NtwanrUO7IxBw7RGWnArt3OKOrs4wvXXOYxt9NsjBc6Y2ifb62?=
 =?us-ascii?Q?Mx0otS/BzOmyNFjOKMxWLy8OTtj5Sl4zKOwMSOt9RK65icDl6CiZaeWYAsOe?=
 =?us-ascii?Q?kPQEAK38JCjZW+vkaxkKjMRF/9mJLfB0AZpr9dIiGM3ROtd1McwAnYvAkxs5?=
 =?us-ascii?Q?BOEWCu5RWRZF5rlOddlbAdw5pk4p6DeK+AcnZPXZiXwDPh6+sZM10GPwxUra?=
 =?us-ascii?Q?+omoRB6LOHIq/vcqwoefAwQPGiFAdHcmwUxVWwYsvf0UJ5tIXmaM/NpeaDOk?=
 =?us-ascii?Q?1Qv27jVvsTI2HSaSKxONMVEX7XZS7bo3rgalppzPF8/ke9uZYEscxhK/B0yO?=
 =?us-ascii?Q?yAbiiaGT0sLb8+/AN1u+qXEMR5a925fRFnw6ilMF2uD5L6nYWVVOOM7jA20W?=
 =?us-ascii?Q?bJy+p42nfFHbxxw9XNYoArdRWW43fm6Bp/5t6sG3ECWghxAMHNLEDvSbbad8?=
 =?us-ascii?Q?798qexS5gO8UJXHvchEUDeLr22ESxvZM83yMGFFsXpzMAQpm8BG8CGd59gco?=
 =?us-ascii?Q?YtUO5pdsG9CaMcRkHBwzH5rDGoynLceI7J2Sh3g1eaPGCfsbUpMKPuc87J0p?=
 =?us-ascii?Q?d5juRKTaEgmLbu5+OH3bGl8ovZ0hktizLrCBpMj1ND2XPtEZUFiBD4GalZ4t?=
 =?us-ascii?Q?g3G307SX2aGgRHaoQVl4q9DGhhrICKRnuuut//tkc8FX2arc4Ne9GdfoFvVy?=
 =?us-ascii?Q?RqGkyQfUsZ4YGc+iPDMf8lzVFm7DtEzF8vymDY6J6VGUrqB70YwS1mgHKuIo?=
 =?us-ascii?Q?ZkNQyMwUmfLx8fbBSQzyl7X3od9cllyht8bIEtGY2ofZos9XU/w7n7WWOgRf?=
 =?us-ascii?Q?zrp6ceXj8FtwKc3TbOMTtBlQBbrvZNkfomNqldXcIrNgcIxcgx2aZbk0hWNy?=
 =?us-ascii?Q?V1oRNzyHB+vH+fbqtVbLJbDIzhCu25et2lO7k3GcutDNCq/WxJV3KGljLBQ1?=
 =?us-ascii?Q?KrLBTVlOHYcLs41VhIg3gF17Qad8E9Vb0DL9AwlDF0xcqNy60BNybWNv4uUL?=
 =?us-ascii?Q?yXf72FNUvkEXMaaM0zzHkX9MsbJKmczdPfXe/RFPiPV3RujVyTgWMNhgJ8/I?=
 =?us-ascii?Q?bmwhMwH1O6yyZZLut67KP/9nykb3CJs0hMhfWhBwRik+XYQ6YNg7yoAbqraT?=
 =?us-ascii?Q?UDmjUH3NiwP5iv5lh9wxckt1o8Uyp5AgiRKotLm5A4jMSG/uwWEgNlGnfb2J?=
 =?us-ascii?Q?/bTJV/gAa60NceYs6OTgi5xRfVQ5P8qJPW77DHaIEcU9Q+YqPTOoYiKkGCmZ?=
 =?us-ascii?Q?qpMUpqKJ6HkKibqg0Y42HhQo1mzVw9TYBOYzlEYFMqFV+jl4om5D2QRbe2x2?=
 =?us-ascii?Q?sEd8xtfR9JaKNXrdUetwOnDsjcA/sr8XHRHlwznUzXhNoW52SSthMPB5A1QC?=
 =?us-ascii?Q?AauAvDSI61NdVybQ+Ve0/Hkt+FwOy2cuo8k0KCHqFnMqVJaXeGamiVnWyCmn?=
 =?us-ascii?Q?dcjUjpdyorJIByQX6qYwL8u9aOe6oxoul0X4JTyR5guqI7ISsHGNrTO9kFTs?=
 =?us-ascii?Q?M+K9aFGbo67aK/hAsfB4VVPrYXEZVyoDjTQjoxAtbFjsOMnVqEgvCZar/7bh?=
 =?us-ascii?Q?cXDzBxnFTYKlSM+iLqudlGCOOMs6yI+EsFMAfA1HmQtnh50YrR3eEG2seqGR?=
 =?us-ascii?Q?//UfdvL418ncH6Ij+HHII6coHMU59/o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13d8ef1-4968-4565-d8bb-08dee992e1b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:19.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7TQPSdKh6ASutwSNLk8LiHJGuP6yGmgy1vq9/rVcUe4mICYTkNm8y/9jzlsrKvvRZ7V9GJeLD3Ks/7qppI/VKteJgG1aUZuMe6nswwrZoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

The Agilex5 SoCDK eMMC daughter card wires the shared HPS SD6HC to an
8-bit onboard eMMC with fixed 3.3 V VCC and 1.8 V I/O, supporting HS200
and HS400. The board also brings up GMAC0, I2C, I3C, LEDs, UART, and
the SMMU for DMA.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 127 ++++++++++++++++++
 2 files changed, 128 insertions(+)
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
index 000000000000..0ace9f7e0330
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
@@ -0,0 +1,127 @@
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
+&smmu {
+	status = "okay";
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

