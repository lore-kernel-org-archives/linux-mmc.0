Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840B3803D7;
	Mon, 11 May 2026 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530910; cv=fail; b=EnZJmv7Vw7F5VFswi66AsdmeFyLLWZh/nv9ekFt/9uoh9b/XJsUns+9laWqys8L2kDiuVfeu3X8DK0TGiTbkAlOlN8SzxHn7mqVt4US+VbGZv+PXnnvv1h4kTeG6IBjH1vWo35aNfhkh6GRkIYKzWmJXLjkOdxTsOKBtpeS3krI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530910; c=relaxed/simple;
	bh=ahusg+k0t+8mnHg4JADD5KFhp7i3fNMNLML3uhEnwsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j99kMlbPDisSMdqtCEMWo1hLg14ZA2MS8i2QTzs/GbgaogWWSNPuSjTVkELT2SgRrVxUTr2mZgmwBfZver/1PPhhEtppGOr5pknc2vGlUJqc6jZiWgLoTcGGTjKgDt8pMfURfbR5npfbYxXfLIzC8rj6UFhn9jIEYhbWQ1Q5t4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fI7flS6y; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fI7flS6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovAq1TN3jzCfCALnnNA04bWhAfJsdMFtz+xksvcI9bP1iLsKX0FQWrbzPfBTxvGUcN6t/siM5C7WLe6spPxzMtuyjR9Gty7KebaCuJ0s03GiH5di3jqDZnevBF42DQx5nfZ34UtgQOXvb3R1bckSp2b4EifWqOWXwNH5kKE2Iiko25D8VIRsgoJCxrrFT7zuRtGMJEIPlAE+/eD9GBNQ8N5YVmDu+8tZozeGQTVJg8mwF0ABjWwUB6sFBIdUFilR0nDuC10mwI9khdYA9g5/2hAUkimXvbSjPAjnYbkm2JmclFA+ufZ+3a//uSJUad0JmnGr6unbwrK79OTv7CmHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MsrPexm8jdtabk95Uby8jeNuAfv8NDZgZVIeN6/AXo=;
 b=CvHnYIpAugi+V8rgsZZOkTOeqLocuyd2aEdkalNHdfZIqY9hp2VvaUNjvGTdKEeBdsyPXOj3YVtjpayTmOXbtXPDEdGDL+/uzWbuFXQ4bHvT3pyR6TmKE0bFUNPR/4OtFsPrAj549YskIXtW1BMrbq6arn63LVZn9JICqtO+6GJJ1Ieq521qNDyAK27dHlJ/feVRvMumNYEfKQoAck2uGKDzNgyzTFjvd12AHLt6MAiPG2OPurBaexMgKAZMDAaxfFjYlX/u/naK5pOnRdjRzl0QKnUjXJi60z07VauYBmhqemj6R9zM+BnyD4KB00dmTvVVDA5F5AJDvqRiptLUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MsrPexm8jdtabk95Uby8jeNuAfv8NDZgZVIeN6/AXo=;
 b=fI7flS6y/bnce9wBRqJiou30lycrpJnYvnaRuuHCceRlUtuCpsZoe/PnB/vax/t/mT7h58WN9Mn6a2oi1yFcDU4a+Ruj7FEVVNoVdjWh9HXbCIkd13SO45p2ziOK92FR372M02BER27nhKp105/8jc8BOeGq75NHjbtMd6yxCGeIZ0jh3ETeuuIZXv+VU6c4z9sFet/27bdgWA8jyDeWFRXB50XIZKOAlaxJgxCRavVMtYZjzUTlVRrTtknVrVnH9ftAymkALsXRy2lDGYeWZPWNMN8kfT20BdjBRI12nN/2DZUg1vOaTqv2zZ/W3uFg5MG1tHQKVb5hPDmWIQrFzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:44 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:43 +0000
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
Subject: [PATCH v1 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter board support
Date: Mon, 11 May 2026 13:21:27 -0700
Message-Id: <20260511202132.5597-6-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00526ade-8806-4e9d-2dda-08deaf9aeafc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	rXmdCjZj8JrHjPQBrG60rW/6RbRz842dY/xugVRd7QkEa2QaOMhJ+a8FtPa2J5CCMqIgdOpHuvFhQNv64saggEIV3GSTLrcUQUJEX2iAFdHSve8jZIx0rHCmE1+Gurs1i7W1OGWGYp3X4DqUY9vnrSf67mgqRqahwdGdieRpwkc8EvXrpYFAOTMDeXROeveJ7TS2BIAQsnzfPvExT6MPFqcUYuYukEaVT453o7V4f84yRGkz+Mjy3YIRNKyDb7abUbfIG0mqPLIggaFhy9AEIvaG2fl/CEVSkZEpkKymjQv5Oa/lWJWj0tZebnjQsXOrd7zvhLRb7eg1/MSNZlIXJh0J/M1o1g4vH+hpUBaZk9frcJtpxjz8JTlLvsuaolwfsHvIgivUMKtgCFPtWYxzU7sK6JBokvyKlj3BojMrPrIa6l4IE2NsrTff1bkVq0fJIPIKuMWHjCnOu/+FSL4PNitfulyn4mWdqaXtJO/KbYk50y7DD+5tX7luqNz0mQUMaeyipUvuc9wJlvRGiYs4ObWB6dsWFNusURGSNu/dQO1bNMNTMYm3UEyyZA71LBZWR9NjtcJQdUZQ9aB4XRn/hor7u3D7LVqlQMIWFAuATrxtttXN5THm0WV7Pot5H7Fe2fw/q48cz2diIPQvREwPEIttDgY9Wgp3HWEyrYnTJb0A1aRT1ls0Vns3UV+Lvbzz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmByzK0a6S9n5CQQSM8l2tX6r0sxK6fKpdaCjG4rG4eTriGxTsJ3l8ryyktb?=
 =?us-ascii?Q?fV8tPLW4xVXG/0qLuwFQisAc7LetG+Vw9aM29sgtXSBldPINCAEGY5NJVxL/?=
 =?us-ascii?Q?dElEJiLtetMibSdmoSYEGBJqLKG62uOgiGwShX4+cRGmOqQEgQv8wJRgPkaZ?=
 =?us-ascii?Q?Z9lu3JOKJquh9MEm0a56DmD3RaRzbswYos06pq3XFoKTrhSMJO9FhB/WIlq1?=
 =?us-ascii?Q?Wk37MiJsOGghO2Mxy1AuJ8HuaQQYwPAwBBx4zl+doUXj1VaQi6uMvY+fZlI8?=
 =?us-ascii?Q?6OH1JTO2+L+CFIBs1rrOlWtR4CDKA9zqOJ9mSDih/nLVS0aOPHgCjEDDLH+e?=
 =?us-ascii?Q?TOCluPd/Te+pCytHjyvTtLAnLERqIXnT16OsfhBBUg6GudFz29VP1RLXLMvZ?=
 =?us-ascii?Q?zTJgsuVjjDQSCPdlq/bd0sFIkpb8sLzJ1y1FiIm95yGAWB3R03c/f5FagrXn?=
 =?us-ascii?Q?EY+EygI4Vc9VqhlPjsz1Pspd036azLQIaz2ltEwj3JcuGkNgoxLGkzdp9Mln?=
 =?us-ascii?Q?LjGZfTYjl9+zXJCi/hXnoDl1Zzi2XNs3PVQIxxeyda7/uQuwHnu7BGA+PPSp?=
 =?us-ascii?Q?daBsZjVbPfak2Y5yShr7vjw60ZOrdYT79+DigJkk510eiC/2d2PssUA+RJ+c?=
 =?us-ascii?Q?oUVUmwdzDuh2V3nDRyRFbeMTFCw1qJJFem0GaKONkNhf34aJoWd+AvbgDnNE?=
 =?us-ascii?Q?sLg3o2dURZUB8XLFoBuUi7jRVSQnVnhMmCyiaH1fkTuG3JeBojqgeIk3sbHa?=
 =?us-ascii?Q?gk27O4A5hsZ/N9wja8H2c+nTideuSoYcKqhOYoQwhhBbeUSyJ0qUVBP4qSe4?=
 =?us-ascii?Q?1sKD4OUyduhKNFgPGatKyGoqWeni49xPPMAZV8dcRf/qNcyaPwfk6OE4yOw2?=
 =?us-ascii?Q?Gfse9cpL0XH7tf2TpwsCZqUGOBmr4HioD3coV4QmqCNZ2I0ywE29rSL61w+E?=
 =?us-ascii?Q?7yfwuTvvVD9iwjrbg5htVRzBVn5G7IEnr9x+1E5thNjEh+kIeyDRbxoWFk1L?=
 =?us-ascii?Q?nzrNqS7DldVPBXluibGDZnZZ5gvJo0nw9QGab31FRdUC9aRwIIGeoTPChhjn?=
 =?us-ascii?Q?7b7COVyyzEJfsg1DAjcIVVRn03QbAIyh+knrqpX8ov0bsj+d8VT9unwn4PdU?=
 =?us-ascii?Q?pHcbR04n5zJnl+YHk9/9yLC+v0POUzdx6OTR6XvtEkcqCSj4dKQ/UUNMRANM?=
 =?us-ascii?Q?AN//M+nIp3zVIr/gqfNJegY1l8CgnfoKjV2F4nI7iLtu0YUfezRYx3pwODIW?=
 =?us-ascii?Q?OWrP5atiJGP+yirzH4HHgo2cF+MVCr+zg5FSiCtGG5m4ULRIUEywL7uirPtl?=
 =?us-ascii?Q?vaXXo/Lui+EYIaqFNdufLCwa9MEpOFp9G40Bo3DYhKojcPpKD1KgkluN45MK?=
 =?us-ascii?Q?zykqlCwv2rWypoXqqmivYZzwUR0K2uafDud9dWPN61BDo8pWAwHCvIsdFLvV?=
 =?us-ascii?Q?Pb3BSrcu3NI8qp6aIUulfhMAHFCsVjbifdSpdGTfkeBd0rNhOKnDM/QyIOyo?=
 =?us-ascii?Q?kvI95iRPQl8m0MHEV9N5OGhyBqh5PaMJL3q6khaw838qR0b/uoE54Rr3Xw/2?=
 =?us-ascii?Q?jLJ9n0u/kD5xsz02QCfaUe8Nw980uxa4pMwYKQQauHmRXpvC/4T/NEu8LKYI?=
 =?us-ascii?Q?z7nAFwlKLWIhIH6hqjY+U4qFEG6IGjcxyJsj8Lj+6bDlC2MuAykDqVwRELis?=
 =?us-ascii?Q?rQ3Dqx6tzuYQ+4PL8HUDCWzUQrW9LSeUpVuCRafBDzzMwJ5Xi240MNQsmcT1?=
 =?us-ascii?Q?jnNOjGgurr3YPYED/3v81ddvv3iMouI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00526ade-8806-4e9d-2dda-08deaf9aeafc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:43.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nn9gQMqdVm13tkjeiLLpJfqBKAEzO+Bw5WbL+QZ7L6N26Ps6pjFmxiXWX1Dzh4rKeAw/BmscX0YpZMvPSMlXfJlQui83uKhn+l74B2nxio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

Add device tree support for the Agilex5 SOCDK board variant with
eMMC daughter card.

Update the SoC dtsi with a fixed 1.8V regulator for eMMC I/O voltage.

Add socfpga_agilex5_socdk_emmc.dts with eMMC controller configured for:
- 8-bit bus width
- Non-removable eMMC device
- High-speed, HS200, and HS400 modes at 1.8V
- 200MHz maximum frequency with SDHCI clock base capability override

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   8 ++
 .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 111 ++++++++++++++++++
 3 files changed, 120 insertions(+)
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
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 7e080f13166f..feb4ccb317a7 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -317,6 +317,14 @@ sd_io_1v8_reg: regulator-1p8v {
 					<3300000 0x0>;
 		};
 
+		emmc_io_1v8_reg: regulator-fixed-1p8v {
+			compatible = "regulator-fixed";
+			regulator-name = "emmc-io-power";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
 		emmc: mmc@10808000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
new file mode 100644
index 000000000000..87bde9fa69c6
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier:     GPL-2.0
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
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
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
+	no-1-8-v;
+	disable-wp;
+	non-removable;
+	cap-mmc-highspeed;
+	mmc-hs400-1_8v;
+	mmc-hs200-1_8v;
+	bus-width = <8>;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&emmc_io_1v8_reg>;
+	max-frequency = <200000000>;
+	/*
+	 * SDHCI capability overrides:
+	 *  - caps_mask[0] 0x0000ff00 / caps[0] 0x0000c800:
+	 *      Override SDHCI_CLOCK_BASE_MASK to 0xc8 (200 MHz).
+	 */
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00000000 0x0000ff00>;
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

