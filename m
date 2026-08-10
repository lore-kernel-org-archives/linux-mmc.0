Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AA43B4B5;
	Mon, 10 Aug 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388477; cv=fail; b=qfUgHOeeYpq/eP46ftlhPbGvu3a2Xqmymz7FdZLEEdHRvRuoDQwmuosfJI/bemTqNG/bvNab1GImoDFOmzotDtiP07GZwn5QFNP3kMrF9wQbXKn5zev15gyJ/nx7EqoTXQSNs55GTKu3rJabPkrADJVZqKF5SRG/26DFOigUxsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388477; c=relaxed/simple;
	bh=V3imySbw84C6toaYahkRvRS9bFULfcijKXJdRYzVadU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j95AgWd5mXTMhsjVo36r1totyaR3J+LDlJiEHHubU1cWlw5+izylCmGTX+f4vqF/0Tv7LupnJzWaZMgb/X5MOCXt+qGg7+ZRmaccxjLoqrYxuIdrymtjeXFSMikfwjfnbkwZV186521gdOXrUoIi2g9WFaxx2T5YPYJLEFEs2vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QyUZwEnj; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QyUZwEnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwird5CghDLOSzxNf0IpdhvLTALYzenQSimOoO6IqLOZO7WcR4piUrjCX/tZGZYM7JQcdEUfXlH3HbFUKVA4wKjKvRRoUc8+QWrknoD0npgcD55OmfM9fq3P/QFFHFnFbwkXOHayIQ8VTja9yWvr1xChhM4ZJzm5WRMDAmVULVPzodzY2wG/VXwMHd5ncGxcWt/F40NF1wLGug8i//Uali0Arhrx7fSDYX5aBBq58DA+jPoFy8ayoGpv/ITKDgLJMgCtrHCxgUCCV30o22dqX3etrXe/7rv1AlyEtHd8jwHiqNTWp8Kq+PvV9wljbcYGu94V5OvSgTjhCPpGFkpVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkVgsfrgM1oW1wcs/64cLRwkLfZ0jQ3U7hck9zOywBI=;
 b=vdXNmK1DSwwHfCGFSkE8LIhBU0MiJUI73eLBlnMDVSHPeOMxFvJoZUKWcblQScxk7qqkE/igtgLnhTzHtNFxZDPeEcHU1NitcWtC1YpUgBt8sOtAutel9L881JuLtN3bm2oitzoi5+Q6wu8y1Q33+Dn3rbdfJf5WXK/GbL9XxVbg5hLS7tgjE3SryI9okgvGY3lzPEXxPG0deqfgH6MzDqJP/2ToW+YkYkzjAywZNehMgvyffWYqrD8FTTvDZlMbr6O5FcaWLQwmro3v/X1uRBXRAzv+oJToKB4ASHlWrGDNwQKRShMIXWHqmDw71tkJJNr3Tl+oIRptTGrHjuhAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkVgsfrgM1oW1wcs/64cLRwkLfZ0jQ3U7hck9zOywBI=;
 b=QyUZwEnjAp8kT0q7wsJrglZw7xsrLhiKZ+53QzgjF5hsn0pet5vpn6C7mg+QCNwPakLpvDI1KVvDB+tDlNch2bb3dKTZCud3Bh3My35MVZjYrlZT5xdAdVDhRRVWSmxTgBppYfUnyeBVs8uf0whKqU14i2Qf6GOpgFyOeomIXTUREt9Bn+nxIIvi/sd4EfDIm5jNuZ0s6rDPTpjankPqHaZUa/Lnuc8A0S4FWTU+puJ2lmdhpS42criYQUac7kIcuYy3shH/8W7lBZU2Ir1V9o743td/uWGHNDg+J+9c86J5ntg2EHGdmJL4rEwW/qNrUAYuNYZYEIEB+RB87Wg1CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:39 +0000
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
Subject: [PATCH v4 4/8] arm64: dts: agilex5: add SOCDK eMMC daughter board
Date: Mon, 10 Aug 2026 12:00:18 -0700
Message-Id: <20260810190025.25045-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccd57b2-92d9-4d1f-857e-08def711ab1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fm2rYUb/7ybnyEeAXYC+qCmDnle4J2HFuh6nPPRlX0GB3k+okmuisFNxVz4iKxKswinu2kK0WGKykm8yAWpivW2qq9Gh3nXhUScWCu3ZJcZNu+nmuG/K2H0fAU/9vmc+VmConFEXnXwVEPG83PqRALmtmnUUnaZc5byGCizJpFskdBIzTwVu7KDPrmv4fNAXsvhukjB0NW/U3Vkw8n4HdNXI7oYE1ah3fZt2aK0v/owdCDcrJEvsp5EPNHogq93YzZQa6mXa+TNOkGIOSQJSlvJma6J0/E/FEADfMnjmNHa6V7YOgC7KCD+4eBM2lNFqtlZOXv3xoABOrhnLrH4K6vtNQSbLha6xjv+lS90sy0WtxKZxy3FDZyaQQZQAoqo4sd8JCR3hCnnZ6vUgyRugF/fEqdTbjK/nyMz87vu3R9uNlOiyX3TgzbXlsuctxVZtZVFcuCVfYgAPjDaSxetQHssgCD58gSmNR7L3Uiq46/FYMijS+yCS/g5z9QVFos6jLfgI4ANxJ6LpSVbxYcieIoeS2vHx9kj1uGRYbUaaj/zSpVtTZhxjXllBMV/EI6NfnYrzP7XN9mkurv5dpUUMLjEogjsYJJk4KB0lv0m+HFvNXlopBE0KPwH19oRpTwHhyzX1N9soZu8SA/QihH7Vkm4haX2Dz8STTOsrxbwFu8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTWnK2q5/C2IQdRdxY9S0jSe9kl/lNq2LvU347rqUKjSBqpNu0Qss8W1CvPM?=
 =?us-ascii?Q?TWNFe0b0BiYRxbGZzKGnn/7lrMyEmvmFx14hlwqP1FJ19b8jzf/DWunBQBiH?=
 =?us-ascii?Q?A6EQRA7IhLBxinYlnMsDyTSnUUNp+uEz0YBxU+iwAal168b5acLA/DPHryJ1?=
 =?us-ascii?Q?XVWJnMfAVPUMgGnTK/H9Ys2K1AWDpSRVLs8mnbJ5zhmFjKX+M4n9Leasr7/p?=
 =?us-ascii?Q?ldZxDwCjNQY5IljeqnhH0JW2x3lgHNOOLSFcWeAK43Bg3onVdMO2PcKBcQBh?=
 =?us-ascii?Q?GnrnQ/5LRCIp9uo4ieC957ZaFcM8I2N2ed98FnvsPqKf0hChfquPabsdKADS?=
 =?us-ascii?Q?+IvTTwuOENHeewdh3L08ccmlWbYoCnx4246HMPF3SDHFdq1HxS6rcFTxx4Ox?=
 =?us-ascii?Q?bQuFuRQEFnzKUryiyGux4RZqGKX9fILqUIlkEFx+cfr4D7/Xa5iOgJtYJ8wQ?=
 =?us-ascii?Q?Y2iZgDPykFGuVHNrlR7keK66EFr0XmImjV8fnQA6mzugayY1uvJ4yE7at/XM?=
 =?us-ascii?Q?Y2tXpcouz/lT4/zJg/xr1iH+RfBY6Mi2OqM16VP/Lgz7oVAuCMTqdG7DlMNU?=
 =?us-ascii?Q?u9LjIOyczRuqsTBkBS7k9rvoKoTH3IrcytTj3SGieFyTpk4tYZNXaF3gG4Az?=
 =?us-ascii?Q?cu1HH/0hZ1dGlRn2/PZFQIOe96cfqfG/B5ZImt0VT8CuQr2fxMYox99q64v9?=
 =?us-ascii?Q?oj+p/H6/2mSjrl0iSabSbe7KTN0BiQEAvNTj7aYiI+b6FxgICXY5ahuQ6lGA?=
 =?us-ascii?Q?jRMSToj5u/zUj5HAf1ZDH/Lc5Vgf3XdQWi2ztPA7en/PwnouOFkwMRnYHbXb?=
 =?us-ascii?Q?DiHGDYKMwSjXmZ6yo71sWd4T0IjfCgvXNLCbuItiZGoluKiyQX6WQSNMkn7Z?=
 =?us-ascii?Q?5tvah3FYJ6esMLUCfF8SMgGW29wVNp+GWUJ2V8/ecUsdHahCdIvhumijkeqD?=
 =?us-ascii?Q?/6UV10333msxGHn+VpxaHOlYtuMa7lMGgCTT6l5aWab7Z1zyaPdDyMmj44ma?=
 =?us-ascii?Q?uAIqAPG28XFX9yQ9JTwOmN5/j1TzRW9yUpoGu9tKFuHmi2ZweEGSIl/MTVX2?=
 =?us-ascii?Q?MaOfKx1BlZBgL6XAVZotQPqb2YQgb2tsOGlpHyF2mcenXL6/6Zbqg1rOaHPD?=
 =?us-ascii?Q?2ZhR5LFq2R6YBxFfx31vb5AAg1ck6j/mhgIpPvwoOzVrTeN3JpfahvaEgO2U?=
 =?us-ascii?Q?Wbl22xlB7QIOLqJI17WK21mZX42uW46I6lDfGlrQLkkaL773ZvMnJxyFTPs3?=
 =?us-ascii?Q?1BDMnMmnu3Tqp2PoyQjkBQ4kr+e2K32FmBesDo724b112bWKAOUXgIVoZqpj?=
 =?us-ascii?Q?UAWGgoWc7YjHEWY/xTUZfQLkFZ9xW46DztA/uDPA3aLnKQgCmfAFdd0nLK46?=
 =?us-ascii?Q?1UWXYklXoiQmt3TsPs7xOzPng/HUNpFOnAVaDj/j5+h8pn9ulgpFRUuQHzNH?=
 =?us-ascii?Q?pGtiyNQZXc08+7I0UIIIICcu45Q+ZDsNJ8qDEgH/m5AmEKk35+p2bpuGqHSZ?=
 =?us-ascii?Q?2IkiXMGsVONAkNV66RCphD3nKB3N0KHVjYlHtiMPlo00ObRxc2dSV2Rb+jid?=
 =?us-ascii?Q?3uTw6p0SdjJsaXsAp5SUiGcqrHMgr+g7p1DDmDsrkK1k6cA8RrckGXkHM/Fh?=
 =?us-ascii?Q?Itdweav4Vm4kslFMcDw55ieBQuH7ube7BjySDYkISEHmDxKRcy7rbx3uZWML?=
 =?us-ascii?Q?31DOTN3zouGMaz95cQPCZijie4ijiWfyBvBV2vHHTU6WJ8CrUx7PdrsxFe2C?=
 =?us-ascii?Q?K0aei8YRIsTCMXRX5pVxMf/Q3S4pd/o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd57b2-92d9-4d1f-857e-08def711ab1f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:39.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzCNdUEOx5TAU4vCa4j9z4Qd64VfDFTVm1Kc8+wIJtjv7dmF7MeGMVKoJEIifUpnlUKFs7RJpNo77issfZaX9a36lNuHv12mWwGTItdUYkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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

