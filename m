Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D00435EFC;
	Mon, 10 Aug 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388474; cv=fail; b=PMm2/T9G/EI/Zs5q9yvHhkYpnT6RKZfgsL4ecCnUNlprPfLRXlRlyQmTP4J1BubGM02o3qhVZR9HpGdd+svsTjuhjVOmM963LZqV1ynMhPXZs4f27CVLWZc9YFhD6GvAe4iia1lzkBRDxwtzsofAQDCCychzYejFB+U8nPRNhuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388474; c=relaxed/simple;
	bh=lEDbS0a03D6Z9pw6FkjaIZo5EwvJYZYgvTlaKTuK3K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJgzB8Ejp6ZsIPzy985J5Swu59SjnKpw5IQMxXCjPAwEezEjHnd7udmTJYmiGZCyqW9J46+s5sjBC5NgVjhq07203mUXPcveYBWo0GHxe6y0UwtodaPHt0nsKD+1RTY5UuyFlEGjnfkdUvNjZLRiOKxRSjhFrS8nCcJiO1DIobI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fbnmPhUV; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fbnmPhUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNfcLXMuB/ytQl23kpaK0LbYvJSbgxJlQRsre8pMc+bZE+XaS/OqrERiQ4jR1en1Q4+NGfyH33IV7Ox3/mZc8i8xAP1Hy0QwHj94kR0wlKYb6n0wLGJWN1otR1kBU4/1cJw0Zdp2jP8uNTSMACkI5x48IaBhaTpiyDJmRLjSYTCJLqFuO6InxSnL5Vl48c/T9+ehEBbUnTTdmnYa63VmdA5eaYT91Mi66hd7V05H6fJaqAPxfheXoMDCBYdtRpApQNoEEkZ+xURoKu0eGRzfgoXLlnGsbcIlslRqzHKMpF5bCb0ZEugijiMN2e17NqOE7o+Fjv3YCyX4wOZXBYW8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vetOpkdSTREJ5I2OJBKXWgYE/fBta9tDzjC8kvo44g=;
 b=DDyf5D034Wr5Z+Dr5ZqxZEjNpfQG1Jx+yCscYP/cYC7XlvOdTaI8nneViQsNCPXKU0hYSp0LT5iEpv/sMhoSWU+4o3WFSIjE0fSrnh+yDdzlCwPVMjN0dmfpUpntOszv6sPoHeSjgDMb+fU5J28/jTUuGuv0NOLgaDmubePPbTHNEinoAyLPC3gqjsP5gls5L660eSIDgIhh0F25s8GMxONNvrtfmlIGTXXLGk+mpQInd7NChMGrM2O2AGvprzHFGctJonildXM1jHR8iYlx8TgjC2VZQGhrfMlBD4pWchnqL+YzA9xxHk895Qx0vVm4m/lJzTlufo4f8B6c1XsveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vetOpkdSTREJ5I2OJBKXWgYE/fBta9tDzjC8kvo44g=;
 b=fbnmPhUVrSceqxvuKgwwRqGZ20QeJpWN02YInY7R/GmFtRTu+JBwgdWhnXUQ0KPJylLodD/Hacxs+HBnnU7z4tuqgbfwlWq+GVh0Hmg5Ws7UclocnEMNQTkPD4hETm8H88Si5UYRbIFhPvvxq/w3Fk0xFtgjlZWGfdFgxnOMAaiW8MRx15SQEuS8liykCjM+wRGlZ6OmP3KIlSFzApWB1LPNIMvDwUyH6fzN13Qb4ft6MLxwwPee9ZAraaaoEveIFn8RAwtJdHoyxovQZPY+YE0fBotwQ93q5Gxj81wNpwSZN9orSmKMS1Hel+XiPZZ0u/lsORFm7A+fgvo88N3NHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:36 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:36 +0000
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
Subject: [PATCH v4 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Date: Mon, 10 Aug 2026 12:00:16 -0700
Message-Id: <20260810190025.25045-3-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 890bd48e-ad01-4214-2912-08def711a9a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zqIHA2hpT8HOdtNBzlnfJnZTscWqNlFEj8IYto2qDT7o2y7ON/lVpnAwwAz8MENXB0oS0xiBdwPt6OOyJS3RFZILcE2x5d53IV68TZOSPcYj5RsXzHDSGiK+UOkn+Yp7+fuJEo763oMQO8Sqb/642IvNtdtG4e+R4C0LK76wvFRfZVZ+3sSF5ATU1cTEX8AiP/+AcXbzzMjHeGXfkHlas1/b6KyyH3xMHnAxmHQgtNZsyZgcU82Gdgz79EjyBJE1t9tLqcD9eqjzt8Hyz6ggM5VQKef2/enpSwpV2TLRq3rypy0H6Rg7iVA20FePLhzPXp3yMMWslXV1xvVT7MSj9Z1FhBWwK3DKNUY1beEr9uje+aOwDbTfhensInmrHedcgxwZjd1SHp1xAq17Ecc09MFr5bVEFFoV36ccziPMEoaIilFH/A1WTQQqL/QxQ9vd6h93vzRhpaBNczt9SxBUVlp1/khkY8lDJzRY8ramaG+mwTxTyZ4H8JGu13E8nTVCALR2wuG7Pg0xJn5xiD7CUwdvbrqK54G2tlDlFzm1fLIZkYtXcJawiax00H7/Wa8CiPA3cszE4RCy3Ba+MToRbBBI++gRPa7dDKHBQqHmwRo127cBuh3LeEW148AQA+MwnpCf+Yq9q+bbiXPDpkhgf1PhXaL8x2I5mPqhnzbN20k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbDx4x+nzelIwnojlXgXBCafgYDorV+E2j9J9Ih9wizNTtRcLQbeeBcs4OYa?=
 =?us-ascii?Q?wY0S7zGbmnfyRz+S8jJXIMi08wJweIofnN9SUoZ94FCgUdeoKh1XFVOxeVyr?=
 =?us-ascii?Q?+ZCmsm/RfrooDIIeRpQoFeQy3+yYcXNYygzdaCHRnCfuH8NcvBxRBUuidwMh?=
 =?us-ascii?Q?Lx3zzMSrIiDX1+Nyp0qFtb9oEUqfVMu1yWk5PE1lnP6UvPabzhdClERnsQ6f?=
 =?us-ascii?Q?PoKNEyKDp1RCrA67HmTMO9liLw2KPfiR3nTBCt8LJtvz7Vnc7zeNDxXAawud?=
 =?us-ascii?Q?5tYUiZysFIOrtoe8Grhhadd2crO/76nWnevUFqvv9g26tAobgbN5yLyUDSNG?=
 =?us-ascii?Q?wRXqF+Qy3GakywpPJV2VllTKUCa8ZTOeVGIbrk7jeg4sLFYQ7pakcY5LqHWt?=
 =?us-ascii?Q?ODcan+1Fxe5H33B0Yu2mqLTnHckoDUTwQwl2bktR39tYiarOxJkiwdTG60Vf?=
 =?us-ascii?Q?hT3oJ5dLNHgbARQJh8ijUDYeZ9mgt9qEhlWW7NNZ4uUonPtdz2TKS3iCXjVL?=
 =?us-ascii?Q?oTwi2+n7b0A28eTBwW4ItnAkDpbFkBqRlEgFEtz9oR4zByvrQLfpm2/FFbt6?=
 =?us-ascii?Q?aw2j/IvWZy1vxa5NyIsNWUoKxu49NWbg3liUoFSz/jMaiK/YPLLRiSGy5FSk?=
 =?us-ascii?Q?oobK77e/1gId/xBIwEAAvZwvvE8vrnsfxNIw1GH4/+pG8FOIQKjhfdtah4xQ?=
 =?us-ascii?Q?/06hwjfdOpN7Mjp9EDxJ5YDfaKCIPdoxNuWcqEB3PjdWjcnOeBBN1Ep6AZbS?=
 =?us-ascii?Q?JOPJ42t8ePXgLZPtoDbCH4LbeeFj/BWYB9UdJCHr2RfW4qKubEWxos/YfEW4?=
 =?us-ascii?Q?PT0pwUnRUH7/9cElCvtOLl68nvQW2oBVm5f8PBwRdr61ecu6RW1fLr+v6HpG?=
 =?us-ascii?Q?ITRzGuBOGuoQNQTo9MK58BbZX0NnsR5EytfXYZSb0LcNjw6cKQ6s4EDzRIr9?=
 =?us-ascii?Q?GOd+FHlquycbevE27JemoOVMBxzfSlWScreBZn2SsvImN50aa5tJ/T+Lwkw1?=
 =?us-ascii?Q?LjRkl3pVRHm2DdaHYwGBJRdM3NvJPrOPkNzmEUeD2O0DE2GhLSjzlIsgIOF+?=
 =?us-ascii?Q?YVN0M4ClcSqdI3F3E5VJ8fXIhyZ1I9NhfFvrUIT6EtJR/6wzovUtVR4Lj3UA?=
 =?us-ascii?Q?HBa//TSPbchWdSpzDsqWcDgG4X3jYcf0sBgTyWKkjH1QZ4k6iEUVhXXgNl2Z?=
 =?us-ascii?Q?CoIU9fuqpoUlE4X0UnsAlxkcGTlWEClnUlqXy6OHQI0T8kn5XBYugxaW8RHc?=
 =?us-ascii?Q?1NBpmqWHVqCQxMe1O1xq5iBmuzyhVq2i+0JaZjZMwoqTNFEdoHMEA8IGeYlb?=
 =?us-ascii?Q?TrSuI2ZeDdj1QjGg2e8nVjEIFm2wDpD4LuLQwjEqMUTCqXI11rPJfrGPHqfV?=
 =?us-ascii?Q?e5AvVT7DpMqpA1GEVcZMlQFdF7pa622g2GFrmp2BctK9jlmSSQ1PaPAgWGXH?=
 =?us-ascii?Q?NkT/vPXgh6BsKJP11R+Hhe1We1em7q/2+N0Hagtz0SuwUBvH5NnOtN7ejBp2?=
 =?us-ascii?Q?sD+N21SA+AeA0em5on7Kq9LIvI9m6yp9Hop+tPEQZZD56ZDcGTPUKyTjKw/k?=
 =?us-ascii?Q?3Qkgld9Oc75GQdsKx+m5ENwUDXQkDDTins8jbjnihSuM8sdnNJkiOA07+jqd?=
 =?us-ascii?Q?rfTRVbSe6XzGWr87B/K8wXILG9MWaRcASlN+gL92oCxzKAb60bq77S92c0Kp?=
 =?us-ascii?Q?wSC+HqdQRgJ4nvx7Of5tNlxsQWnUTVxRXb40IvNtW7fC9HroBuCy33PY+m9c?=
 =?us-ascii?Q?abnFYvv8nwfXpvXYi5QhtM6tifKE5wU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890bd48e-ad01-4214-2912-08def711a9a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:36.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RJHDehbdz2sKJPMhLGMxJegIm9jFXvyVSAQs1JhSWgQmnlKSirTQxtjNaExR25TC2lC2LQQeQC+xxlwy3oS2zDYpBHBL42rjV4/YA+87DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

The Agilex5 HPS includes a Cadence SD6HC that drives either an SD card
or eMMC, depending on the SOCDK daughter card. It uses separate SDMCLK
(CIU) and L4_MP (BIU) clocks, and has three resets for the host
controller, Combo PHY, and SDMMC OCP bridge. DMA for this controller
requires the SMMU (stream ID 5), so the SOCDK board enables it.

On the SOCDK OOBE card the slot is SD-only: fixed 3.3 V card supply and
a GPIO-selected 3.3 V / 1.8 V I/O supply for UHS-I signalling up to
SDR104.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Depends on commit ab45ecfab540 ("dt-bindings: reset: altr: add
COMBOPHY_RESET for Agilex5"), which is already in mainline via the
reset tree. It is not yet in mmc/next; apply or merge that commit when
building/testing this patch on top of mmc/next.

 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 ++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 38 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index b06c6d5d60ee..5ccbd7bf2034 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -300,6 +300,31 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		/*
+		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
+		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
+		 * it is configured for eMMC.
+		 */
+		emmc: mmc@10808000 {
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+			reg = <0x10808000 0x1000>;
+			/*
+			 * "ciu" (SDMCLK) is listed first so it is selected as the
+			 * primary clock by the SDHCI platform layer; the SD6HC PHY
+			 * timing calculations are derived from this clock rate.
+			 */
+			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
+			clock-names = "ciu", "biu";
+			dma-coherent;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 5>;
+			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>,
+				 <&rst SDMMC_OCP_RESET>;
+			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
+
+			status = "disabled";
+		};
+
 		nand: nand-controller@10b80000 {
 			compatible = "cdns,hp-nfc";
 			reg = <0x10b80000 0x10000>,
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index 57d3c5807c65..f37038066922 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -36,9 +36,37 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
+
+	vqmmc_io_reg: regulator-1p8v {
+		compatible = "regulator-gpio";
+		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vqmmc-io";
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc-sd";
+	};
 };
 
-&gpio0 {
+&emmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	no-mmc;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+
 	status = "okay";
 };
 
@@ -59,6 +87,10 @@ emac2_phy0: ethernet-phy@0 {
 	};
 };
 
+&gpio0 {
+	status = "okay";
+};
+
 &gpio1 {
 	status = "okay";
 };
@@ -100,6 +132,10 @@ root: partition@4200000 {
 	};
 };
 
+&smmu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.7

