Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA93FB05A;
	Sat, 29 Aug 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028994; cv=fail; b=qkXYUtbPLiQCNf33uy9k1V89B4nAZIdX8OjF/djzDwues2wCwbgUDJpsuahuuonUhAqk9TPrmDkZJ2psdHMY6xDdP/NA9qJSc+KVAUwil8B2SLrfQ0NvVni3Hl85Vd09HCajiqYzTYjj+k7xUyWjCraszX1ozYUI6e8RF1nJceM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028994; c=relaxed/simple;
	bh=JikuRsuAMO+RMlk1aQRGf87Rjs7CpsJmJ84lZw0a0FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y04q5ZcJ0V7ckQKrX7LhRO7Ar6OZaweCjxvs8Pssg65DOVAxrKRTB24voD0pt/TibxCX1QpsJRChvsUj+98HxnxewCkzbkK0O35Wux1YQUYGGwZ5OSxWIfeJwvJiwlLeKbRVLkFNhERYVhMJHZ5qa/UqkcJ3RENL+R/i9FPIcfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OpLz5ASy; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OpLz5ASy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb7gTOIuoUixi9sZwDoG15yahgNtGAC5nwL4bQbUN084KsdNSEsW/f9GuYfGS2AtjC/ACHtozrqmIMfOIm8ld0HWpvl+tZwGUOFc45/+oS4HWkJHWfpJ9c67uQQz2rQ4sXYEPBgmknNqESNhIztd4gjBZXo5NemW5cQyYtmcjUJsTA3Xh64k+KhcZvnY4/8CzcpM1OLe0qFjgdk56Y6/absr473qUw9gBo1TPKUjVRcwbaLg5I/DEJ2iOBe5QSuliSfDZf4zRvMTXp5RPUtMWeH5edh8FsFdb8V+VW9V0FFhagGyIa1yxT8C1muB8biexl3yhsAtjIwXmqFlNU0XJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9eTubFRjtz32OPiG/UXG05CihLVyM4pSdvXjAyuSfk=;
 b=E0pVjQC52Rk06ep+PM1hv1fyevQzw3UezOeZgeKuVvhl/KdZOBiBjANKRIXkZiJdRQvEFN50m2wQzG3fU1z6gVNpEX+5L8niu5pSlLFYuNvQnsA7XQnyxAEkZhWFcjrDTTVdd+0q+zSudn2ky//SxMEF9rHfWafNT1FC92MPYGPn+DD2lohBtOBsp6h6yEkKpmYjO+RwVvIKIvnaqSQGC/q4bF1du+7u/CnTWsADKSC0xSI3rLVKl7/J9LfGkRX3TA4hCl9qeWnB+JhqpcaBCGW65RgoiwYVxOCAzK+TOHIqa6aVyIWiFk+ExobzdMRhBcS4QBV1R4BUr8iDUTcMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9eTubFRjtz32OPiG/UXG05CihLVyM4pSdvXjAyuSfk=;
 b=OpLz5ASy7AHNKXw45UMkUax7x8dLzNPaIKz/ND0Qj+OfD5c8pCOmrnL6kQDBjbGnVJciOLeDpSrnci196lV8nSrcpj0nFl7aYf+iBKe9NcaL7mFEqlwW4OA+n8f4HI/Fex1dQw/TELG1h54828Zw+R6FObLpVqnywILrZOSudSZQ5Nar0k9M0nLbKN+qUCdmIRcDSin1H7CCe+/ny4JsTBpTZvZU9u+JWoooMvBaRSRfgpTdLGhvGzEuAH9frSKqpM3hhJF6qgvibvUPU8852nlp8lBj1KVVNBg8Yw70BtUtAOs/iig7GwDe5JG4qdr/PJNkooqcFVBR/DamSNmpVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:04 +0000
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
Subject: [PATCH v6 4/8] arm64: dts: agilex5: add SOCDK eMMC daughter board
Date: Sat, 29 Aug 2026 11:42:46 -0700
Message-Id: <20260829184252.27644-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: ce502e89-ccca-4600-c997-08df05fd5c5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	wOiqKRx2nnH21324jPyGnqJdmmOBqWxnudJ8ebAXMcAxdQ7f++93HSq4QrbJu3MBSKHpj0FWtKS6pl39Fi2NMl1eg5zpU/gKATjZDl8rIPdnj2XAjp1VAlaflRnz8pSidMN5z9PoapB+bh9I+XlTKJgwPAC+Re0euJIyMtfV6EyQSMOfLYlN8L4AQoUrPJL3cV5m5tZSksk8MEx51iMV4kCVd/sfqODOpjCiQMid/nE5pej3J74WZzmOuTI4UsbcXsoWmeiiVQQRbWp2W244Pbgcg+5uGhQqMB1fZa/VkftRzJjRGsv9UtMdEDIwChNRMfhPTPVS4nfYP+0Cyv+HITZd3dfceVUaJF8SPx5J+kdcdkqZJxw7uoz5xDLYUAPu2mkhu9QnxXVkVoaa4sWnFf+y2pOkG/EuZ7pkvOrzQptfCitUTkc3gm57tObxrI/0Qlz9MW5Lls6IPddBaLOb5oy4wh8wckxsBOrNiF0QfjX3phYh/fFkYOysEqNEjy9UPS5d0xWAjMFTf6UjCQ15CZ/Kbn6v3TAesHx2SYVKZAw2hcCoypcnyPlu+NY8THMxNqyRl6fhbHrhTcNkByU6cCrQePkhlyliggdoZ5ota2H1j2tnQmTpZI0ocjeId3TlvA9fdkuzgsVTBtKASGS9so7oBpWUFHUiMRCEE/rBq7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbPj9suNEjWpCNWEkdvcH/mf+sEqQI0T/prJHpYnlX9auQzY8xqZmFPUNU0G?=
 =?us-ascii?Q?zlPnpwrkb8jVZqYRkydTPxReI21BmyBlxBDxfw9aTQldPBskr6E317NO1gv/?=
 =?us-ascii?Q?xB6u3HrmqfzvpTsLT8MxXJejvgCESDy0au7mdCM5uRXY4B9Vdu1XKmqIeQwU?=
 =?us-ascii?Q?U3i68tpfEYjqegvMob+HiZTV11O4zIjo/OTxrPNj0ozOKG6H/ehWHmzEAw3b?=
 =?us-ascii?Q?xRNxjZ1MrQkH35aJNiS9c2Qc/9tJb0DymfvpthMshRe2Th2f7KeMfu8pMUWw?=
 =?us-ascii?Q?wCRq0uiWO9J5DTINfo7tbkJZmh2RO05BkIh+5A9sCB6Iw1vP8aIb9x1FQ/Ym?=
 =?us-ascii?Q?F5Edmt4c4CHzaUd6t0i8Cj4NbVFW93ElR3bmCgtkwEyC2RProVNKvCqabv/G?=
 =?us-ascii?Q?hLfbmkTMSnPXM8dZWpvji6arkSnsYp+B8kAMMF+I9oUP76cBFiEpG9j0RJJZ?=
 =?us-ascii?Q?x80T2pXvs61FIR9iM5iONgkb31+mB0ghdTQiigcGq2lGv/oy+7+P7MGypV4y?=
 =?us-ascii?Q?99WshkepZYvyx3quTCNkK4geGtUWGAdZv0cJFh6HW7ohkblso54hqw2u9CUn?=
 =?us-ascii?Q?sq+CykSEgu6LSIVJlWLFbj8sFoIJPwC6RQbbXtIhDxhm6eZ+WxHba//TBN+t?=
 =?us-ascii?Q?jvSKYGpCNvfrkwfz2piqXzosIRDgDSnKifB0XSgP6QCDYLrBILqiZA8Cd7bV?=
 =?us-ascii?Q?bK107CA4mEHWm8obQejdpcBFzZ9g6VOHJz80BI2rZKji6IDgK/PxcPI8rYXu?=
 =?us-ascii?Q?3e5SdYbbQdp0t5G+ijmDlrw6yYnHIzaFxjtoS4NR/Xp8YNSM5Cq/wPi+9TIM?=
 =?us-ascii?Q?kTvvFVcJ3joG4UvBZ5spT91uViKGial/WH7oZFi+9GV6rR6rVvk6wdzbcuRl?=
 =?us-ascii?Q?fyMv2QUgtrsVp2vSVrDcEcx0LbNZE1V3Z92/qjC+C2ffVWAtArjOk9xXq5QZ?=
 =?us-ascii?Q?OCzlyVLL0f3M4WiNd80rtl3uqcKRTJXJRwtd0TaL0txobC9oVDYMFAsJOisG?=
 =?us-ascii?Q?9Jo/taS3fKEJ1PK/s5OArlhdVOEleo8EVyx8v/gicRhMtpVPEudf1O+PnXUL?=
 =?us-ascii?Q?6p0WcMW3oB2gkkmInH1l3uVftP4SuZANao5mNgd8lxz2LNU/qgG9EqTJ7n08?=
 =?us-ascii?Q?61LQ98szldmAZ3kkmGr0ncR4WD6x/0pGz682iFbWbm37sFbh7GC9KWCOMv7k?=
 =?us-ascii?Q?IVrrAWuIUGcesMeficsR7z3zTFuU/d1Az71KEy1f4BYc4/THJwhiQG/rN6gO?=
 =?us-ascii?Q?dhGqvh5gMUylPzKUUGehx8KSWHdIxOnRTrs1BFuS34XTC5lPqcuKgXvYoDiV?=
 =?us-ascii?Q?y0qj1zqACy728W5gjKbt1BYzhIwMRLYFcDw/4zbu4oBI439GNlqH/kgKog5N?=
 =?us-ascii?Q?axV3BlM25Cui8EYCRmcdhwcXot27R2msgD37IW6Or0jOb9hQEzvfF2NWMfiK?=
 =?us-ascii?Q?7oLAUPgcXZdsCpkdKw6gctfOIikUGUzBQGFVxrN5llxaRgog0sAQPHdxp4Hy?=
 =?us-ascii?Q?rtwR3rXeabZqiXbGA4k8MgUOTwc7jyhsQFd+UvtuGaKPrz3oZOHJHxfD/tnI?=
 =?us-ascii?Q?U6aMlTzuWMDLQ+b0Am9DWtMCHqDIIjKba0W0haFvUSC3wsI904Un52BUbs65?=
 =?us-ascii?Q?wT70w1jOl6Wo+yyizbz1gpsBk0fD1WTkJVDAUDm/UdrahcAHI4He6X6Q3Lmx?=
 =?us-ascii?Q?3gQrYL0I6syOLNWFXRyNJHov+VPiLSJ1GpXCl+N6TSCijZ2g5jVTKlTs2xBo?=
 =?us-ascii?Q?EkrO9YFeIIXBbmag34KDdfylSxUPtC8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce502e89-ccca-4600-c997-08df05fd5c5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:04.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1MJUuiBoD8D/EY2Yy18quUcQ4n/VputA/yzGFuDbJmEK1IIX4pZgqLlv9ZpJWZQwi2i5t7fpxG8l08p1JOJx7YA0lN7RLeWELa7diAMQ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

The Agilex5 SoCDK eMMC daughter card wires the shared HPS SD6HC to an
8-bit onboard eMMC with fixed 3.3 V VCC and 1.8 V I/O, supporting HS200
and HS400. The board also brings up GMAC0, I2C, I3C, LEDs, and the UART.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
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

