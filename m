Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3633B6C2;
	Fri, 24 Jul 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904623; cv=fail; b=LRoQWzCPeUtS1JsFb02WompwHLeEvzD4bMidvrcgbVK3HOeiWtaQGs71I+JyUDaOVoxXFfkdjqXmm3Axo+sgZAbDWicXvlaXwEv4gNq3/FzMGk9Jadaku/aPO7pA/bbU45fz2J6VJ92MKxCyBl+LN+Jp4tZqB+aMKrhpDl6fTfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904623; c=relaxed/simple;
	bh=kKorJm5qLnQNS8WXYTgCw9APl5uRxi6nvUbJ68mzjLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YPNCMNj0hCAmF6mRXxyedcuYhrbp+n5uRdj+McbSuiUmKQiCvY1Tt/GRCuq3yFbkojnZLWeM967G52HsEYYjAPzRRzX2YytoK1GENq0Bzlj9vMQe+1hDF0h79GvS8C/pEWZC5qruGpYgMKZ/VN+fie4En2XlsgeKjlXqSiOiL8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nF49kMJS; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nF49kMJS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRRb+Tzmc4WZKq1ryc05IVuTP4MpF+geD4VjPVfEYobzk/o37KZPxLT+dCZpRRAwqr/J9/OkbpoCDBj85PT8E0uOFhyEJE0/pCHTagWa98MpxHW0hwx+jupcWYVvVIg8iw5PBqWUVCwJwdEfl4odqI6UhtiOUNnPl5HI6aT31C8SpKJGv9AkKkIvNr6qVF3ZLGD8kFCptkZ7G+UQa86r6TFGoxZ6uhvukIm0nnBBqxPACpVdU67BXNAXkgAVrJX5e8TJnbTeQJLLblQeH0uvDhuk9B0ElfDF/NgCE5Eh7WBT0Mp6Kb1niY4MVLEbZtZlpjQTETIDTy8i2VnI8C3yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBcwnkIoj1KzJwii0WY9CUfsNrCOrp+nm02JiDmhFqY=;
 b=CtohbKoULTtgzTuLqccY76CoKn4tUS9Yg4jd1MgbBeTOjsfjDrl6xiIq/q80qOIfp6T3tF80mbqRY/iGEvI3gJi+vv4G4KOuwgNqjqf7hnV+QimQdBvPB9CZM5kpbt3iwmN9tcLnTz9OLuen1bx/m3nrp9qCv1rPAqcG3g2FFC/wUS2RJtNtJPKL6JajFNT/WPBTM+Ub5slsQKOHGxKy1v3e3OqOLvtnhSmy2ty/ji1iaLWV85oVwB/7pdlwzP0IvPO7r+giwzwMjSdV3pPzUGLrr7yA2hTeqarsSl8E1qsBKss7pvEOXwP9a+OFLG9KcURv/qB9t2rr2coXwcep3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBcwnkIoj1KzJwii0WY9CUfsNrCOrp+nm02JiDmhFqY=;
 b=nF49kMJSIf+XcmOQ6VK5AF+7ngmmICzfMBfzc9xRSw6PjEI10Xn5xjmxsZfZ91ahM1XcyC6BYzF4izQBd9VgRIcxaqgowTFNHrmcMkOwwjN6xZXCFTuLnyTPj6ZgD21XdBGRPiVIxLcWZ+f6z0KTrCBRTofMHlGMa/dBXMKAZSo84N5omoNhyoAfkZ4kg4ICGrE8XUs9q24DPo400gY8oOhsdJZJMfNVt0D3mV2zbuvONgex5T5hWMcFXQOgEXYstEYjGHFQHUia8L5b/CXY9jYweCMfOYQZDEWVwjCuslN9eZednaQRioSrxqvHfRFMHgtzFdQ39gn4P52OJGDKpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:17 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:17 +0000
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
Subject: [PATCH v3 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Date: Fri, 24 Jul 2026 07:50:01 -0700
Message-Id: <20260724145009.7456-2-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97d77562-fe9b-4dc4-d955-08dee992e045
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	5ofquMk8WiszO6TlncnHR56/lcc4yVP/3wTuf0vohnlQVhDnA7sWNVIJB4smmlk5hg3iPCuQNm2QqPLQr1VBcqJlawTMilBkSl197zdHNw3WK2Rc09q7tF+z0oHKaHTdM7GbvzClPjDadXvMLmyzIoEtKuq0xXxj0tsy+fo6Q1yY8YXpaNaESPgTyH+5TR+4aKCFxGYSVgnmxfcNU8/biXZjqAhQZAfWXqXmuxfVlh6dXPgoyoRF7YHiT0tNZMkJut/hnqS/Gfnoo5fZtDvju+jSVsjFkGGGoIL6ZOkiFAqDXM7LLLIhVMeOl8+lM9pad0+UTl1gMMJPsNyBRJOGOQBfUn8eGLPvgCGNFVC67BzxTKAX7Wl5azMdBFXKTOR9O8PohoVhEv/tW45XOutrY5AH+GVV9RDKD975Fm9riNHLXlJKLUCwAmLBv1W3X1ApJa61C42cGU0BI44u6S2iXE6zRU0oKXOo5JU0ZxKPXqy0ku6isc8/JGbtJO4iMn8jyAnpIyXu1IQGwHvBgsUV8R4qBx6lW1+FICYgkjKzGRugm9yFEI2WAmwhzTXF1BdGtY4TPMS9YzwHr5KdIk53VWywwFY9VyKf593thJXhI56ZNuRSx8mERg9oL7m6PspcCluWqRcx3ynVB1L/F/7cp7CA3g4Q6V8h/xou745xwcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Mt4cAC4Chn2tihXVP5hEaqveIQ07Hfn121k+juup9QfMZ3kqF85MXzKdF7+?=
 =?us-ascii?Q?cuMCGJpwR/Lh9/RJhr4yAWg6JB6xs1XjHUQgHOq8gD4UfQkvpJRYTuUQQcSI?=
 =?us-ascii?Q?Rpadqu23ERFBPA/gkATzZS5oFvDbmJ/vElnL0kVwu102m/KQC9FnScaVSZvO?=
 =?us-ascii?Q?r9NrD5GVd7bfxbvsf9FKAYEaxASKqvd/vCV7yB3AYFlYhDop2smN/zBfdira?=
 =?us-ascii?Q?JQoKcL2/nFSlQ9bXAQQAMOA9Eh3EXwcfh1qkmvMyHlfsiz6LIQIVJaEnR8sa?=
 =?us-ascii?Q?NDFpLeAFXJuqJaMdUUcul44HfQRzUj3zR34bNwU+Rru/zDO9nYKucfGAf+xp?=
 =?us-ascii?Q?UJyPzNZ9OGlNUOtdNCPpjw4friqVtQ7doQyUuANv3V9NkBDtAIYSyg4fo0zm?=
 =?us-ascii?Q?0csgc2SHCBJ6azeo8n0ISv0oOOCBxWWmX64A3O82RkHlSp1nXyDgV/7KCnmm?=
 =?us-ascii?Q?zJViecmkQ2pTrsp6z63OqlrWT7NmTb/9R3Vte/yRM36rR/qOWTmtPoIbMiGr?=
 =?us-ascii?Q?On0VEFv8Q5QMfKUDNUof7hkFpkV1L1QPQqJwSQq58Yv/9t2F5IJIwwhsfe21?=
 =?us-ascii?Q?fmeGFXX89rvl09xfyhgTpHhYOFg906fcNkNGqL0WqmTJvJx1HVjyomuqUkdH?=
 =?us-ascii?Q?Mk9gkhrs7N4vEnbGCyNxKgXtMYQ/HwTUoi2avFqefvb3EiHTa/NSERpxxoxd?=
 =?us-ascii?Q?IR8WSO801zjTZrNeEQsf8wvH6oU5o4m+A1M/JW1DKsivCRGZjt46h5fhG+0v?=
 =?us-ascii?Q?/eeW9Da5g/VkbnClrRpP+fwMnrXsjfyzGT4dG4OiP0rCKfkNyxewq58vtTLl?=
 =?us-ascii?Q?4MTYsIMzjjEedboFlpYp0fWxFmiP7mIRF9+jCSMiuR2SFFCBy/XsYfNu0ebn?=
 =?us-ascii?Q?AU+glvcH6HYw6rpto/HYY2aX2YMPzxbwOoJgFqrTjdP4u1DTh5eoHomL0q2g?=
 =?us-ascii?Q?l4IqFAxPutxh4jNAkTpDnqaH9/YcqpgxytGjSaL++5OeykbXYfPvvBu01/Gn?=
 =?us-ascii?Q?MeMnX9pqgAPXOWYJZXPIWM3wKQNgZOsZBCoBft2MCVFESeH5sPfi/g4+nd6T?=
 =?us-ascii?Q?fj8GVGsPOyoK1kWtxP0pvDkGA9rpA8OwHzU74dNIlbcnKuAge7zolCfdD9mi?=
 =?us-ascii?Q?OJRzpTXkkF4mjuYkBn6dtCYEic/ucPuJE0zYHm0V2uhWWzVQRSd9yskrkbrK?=
 =?us-ascii?Q?PxmlpO1Lzvd6tLDIcRrED8YewUSZGChZpMTT0Jnu4+eejx5h1zBpOhxvqJyK?=
 =?us-ascii?Q?X7wItsCmFv5eR7TGWc+twvBNAADw7YA+rBZXn+jh/CRLWgDpuH9yW+2MIz/8?=
 =?us-ascii?Q?1ns4cSKcA7rQ74UYQKOOHcXim1NDUThhIss1UlObuKPN2s7CWNrSEtO4dhj6?=
 =?us-ascii?Q?raN6meBKIW4okkKW2Ut8eGUJzlZ2CAXwe7mh3ngktmkOf1ohfSrwyCoTZuHA?=
 =?us-ascii?Q?PBWyaZKMs6ljPQWv4Z4qAkMJ7F2znLiRGsssO3KiO5bRpCxfvWXH/nb2u9DW?=
 =?us-ascii?Q?SgkwySwKgIafKiCoWjxekSt+rGDECTO0SOyEzZW56y/qZoWSeY0YcaK+twoU?=
 =?us-ascii?Q?AqFONJ9NPujQhLASrLMVY1YoD4LTX29w3bvbbWxAe6vB/2yfaSvyTyC+Gevs?=
 =?us-ascii?Q?1bplPBaSJd03mkOfdZeCePS5Al4oTsIxT3jnlbD7KG+vKh4TgtAs1p4Si+1A?=
 =?us-ascii?Q?XmsQ1+01EPieXq9WYg51D6UjLFcJfp0vnYJW/HoGJBMhMsiTpaOyHDLgFTlx?=
 =?us-ascii?Q?wBEwsaxRtsM3JQymZy08FmEuSwK2db8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d77562-fe9b-4dc4-d955-08dee992e045
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:17.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFjD5FlJYDyBhpLMql8PCANUe+4P3F6RcMvfsifZRJq2Z7ChW88OQmzPiyhdJILJep93oy8pDe5Gfm3IqKBNjxF9iJ8tTEouIXVTF34mjBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

The Agilex5 HPS includes a Cadence SD6HC that drives either an SD card
or eMMC, depending on the SOCDK daughter card. It uses separate SDMCLK
(CIU) and L4_MP (BIU) clocks, and has three resets for the host
controller, Combo PHY, and SDMMC OCP bridge.

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

