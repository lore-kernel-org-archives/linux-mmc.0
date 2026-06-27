Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F7348C4B;
	Sat, 27 Jun 2026 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591338; cv=fail; b=QOpkT35mY2qX3LMx2Q2fqTKp0ZwRtEX2vsQam8AbhZ2z+PlWUdJtNTFPeBufr1d3puglw7HW5EB0FPxQy1hdrGOgiAMmDf7B6u1/pDjAhfXBdOrA+oMvOGdUGpCoh7vAf2i3R/bxgGH0MR8UVknZN856/vSCmCcDul9OBwFMSFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591338; c=relaxed/simple;
	bh=kzg9g+bCEQAKkEq0KOFsD6sKPkLWC1Apy+KPnyDByiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWhWhtnpEQz5nZLBH3E6cgmMZig3AMlYceV12GjPCxEff2M15JRY+UOVa36t1LLijFFFYuzaKoKtbIRDPcam8+eseS1UB4OqODJrDmua3eVCjkvUdAGT/xfNQNSNETs05x3bbf+OOY7pccvlaY8ij0Z1gALnY3ie/iCMyXoI9bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=o/GliwiE; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="o/GliwiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyxlnbk0qef6Qnm1Yqr5W+riqC/JN2PF9Teek/BwGsRgwX8Fb64E8uXudCzz+006ktdRQR8LAw7U3dkaEQ9bz4OAYQqj2wey3xnjnYQcxWuxG/wSeIACKqb2tKPmCPOVsEToM1UiZLOEkT5ajiRV2StVwht0bVqQQz0/QqYi365P0ESutNSAJxOSPcQ7Z5nMes+OH8pJvYbc4ilg/r/GT7sHJn/lQ29B9PUeZl6nSWGKXsBkXGrhDERVEDriZaHaO2R0HJNqmO/VPtDxEy8K7Tg37ydjATuNluSi6sWvAKiiW2tMi4BzgOia2mokLx/u5HwCInvP90ZPDQIFgI2KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hXqK2zHUbNJiGNus9pJinAk+JaHEoA8Jn86i7FgEeY=;
 b=DiX5A7qWa7DiG1kv9OYfyI2liwU5sP8dgAMVbdXiygWbh7fIzJ9rjETlqQLnHljvaOf2F2yJ8RzzXMVCDfv0Y61donXZGCAk1zNFjqzJsV82URhIbodfzqCsUdVDveKAjQQEVpmuPChIkLiQ6W09w62cVa+xFwd27sL3/Lcge+QQhmBUJG/1Yj++K58XQQi7VVjuOtscKzH77yPqa9vGAugKRYHhRFBZFbnvpIKgGGzoPHNKRwJEYT4aRg6IuhYJxRqA2uU1vtJflSFqR5wyqne/ogWM5+5JvceIHfni+Gwik7OrTXq2p2WS8WoYiIFpT4uElQmMbPmaS57jBoadFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hXqK2zHUbNJiGNus9pJinAk+JaHEoA8Jn86i7FgEeY=;
 b=o/GliwiEl7pea6C4FCooGf0pPZNgu7TJytqkztfQwmVxPCcz/qFcBOYmb8Uui2d/i1le8X/t9qszscsp2PYwiwcj5VD36lLvsfqELsesZgTyHjZtUdsZrmE5BinQ1rsKjH2j3bDSE3sbBkl40CO6oAQgVLxwhrEPOcSwoxG7eT/4rKaqLwEfHWz0b6SyislujaT0E74I/iVWV7qJsTRIWvnwnaVtwnWFlaGpBoGL3ND50QoMuSqfiQSiFRhaFXLpb7PSKRGLCdoeNhD4UlBRFeGEm3LUeh63p5iun8q1BMZFhgRwDOF3ibZsfcMbpXWWTh3BpCbKWBgZ1RsUTOqGdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:29 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:29 +0000
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
Subject: [PATCH v2 3/9] arm64: dts: agilex5: add Cadence SD6HC controller and SOCDK enablement
Date: Sat, 27 Jun 2026 13:14:48 -0700
Message-ID: <20260627201457.12318-4-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a0b59f7-104f-4f80-4662-08ded488d52f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	JHoWNaEQIy825TxSKya/zCRRArJ/CEFZcM1lWaD8xJrbV/y8tOHz6gwdEepJa3HPCMoRSIRdqRwKE4duXAtiyMP4cJqgpwXa4oEjfva1Mxigs1tF19pa+QVj5+SLh1D+wJprxgPOuET21IggALeqSBXJFrYFPU+WTEv07GYh4kvjF+PqjI35sJcqtLtLzAJfrPGMhFOoeRcb2H+DYtcCySbPCbCwDsRQLt9Lp23xsJswb7sp+Nlp9yuvlkpzyxt24PvD5oC5an2eKk3bHyze/NGZumlaB7+/H0fv0p/IuRfLjWepA4BKoAf+34owD+48SVMiK5BEWcIHR0TxLQ80md7nGjcPeMaoZObdhVCbx5rPFUsZYI9/1Zy0FkO9y/2JaEl0M7XnApbVEgVfthI8KIL1f1EVvCvCV1MGpr62wmtgbDzN+cuMfcVWhO6aMjEwuSqwTw9eqjQ6smlEJ4NoGGzDEdmImsvpDc+wMZ96lAPetiNUbHqCKuoR3Aakr0TWMBWkiWnwApGv6YVpB5Xjv4OaX9cln/QaWMI7fxCkm5Y9XgU1ye/7gwhVy6h4P53fQL3IW9ItaOZbg3EocqYBzuEyx2qlkhp0ZWg/yXWhXad/hMZWkgAsFH9ruh090lMbreUzaIj87/ci6K++xgndkEbchYRyC6sCzbW/9yjNC4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Us1iDVlJ5SR6xMZ7MMaNbB7TOc8BVfbhw1LG7qVWKnLngC4gmmqmkSMV/d4?=
 =?us-ascii?Q?rPlRQAjW3d47V1/xF7KKLWtndN/44eEITu6XGzIdjLrN2BgoAvqs4Ow1a1gL?=
 =?us-ascii?Q?zXOcDvNHUFs4LjhuuxcVL0JsDywaFcUDd6OctBjom1zMHrtW8F3ZKnKgEKMk?=
 =?us-ascii?Q?MLeoYtCtdLYiML9A86f0LC/2R5s1hO612zlmmYQyVqkgqwl/jFXQxBws90yf?=
 =?us-ascii?Q?mIYY4XP/NzM7tQnaBnBFTUisjJJ4hoA4Yyq4mkRsFT4zXXqtE1jczH4GkcI7?=
 =?us-ascii?Q?XN8Htp7pvWpBAK7/7O1Mti3jWXwhraoPQNvsd+zrEZ9to7U9hEqhnZLScff9?=
 =?us-ascii?Q?mmPYWkMU6qaxq9gcFquLOdOlgXnhdf58U2c31BhaCokoK2I7AaXrpLAWKTqA?=
 =?us-ascii?Q?7ubxFP7bvKW3GiizKKhs0fW+onDqbp9vUWlE9t2dH3JCAcOS45Z5E+k05vM9?=
 =?us-ascii?Q?ADf89zT0yXztH/SPttSYleejJ0Pbj/ZxvOegl2XJs7HwYeAQcewLAtTevQGj?=
 =?us-ascii?Q?ZThcVrM5Uno1t3MaA6gBrU08RCrCVzC1UhmDAAu9kCrMmg4uHL/kAzfLHJsY?=
 =?us-ascii?Q?W7ukYkpELP1RYVODBJE0LfId5BwSnhVc/ozSFBoBjgaUhoD0vi6BDAkF3e34?=
 =?us-ascii?Q?m12bmNKiYvN8eCPoIfjTwkUwX5uE3+QWnqL88Zodk3KxbkvUFOfxUyQ8V6mZ?=
 =?us-ascii?Q?Be1pFVcBv81sxMZW+znRvfrVZ0bo1LG4C2K+yZYuPhlA4p0IEdjlUawP2oLy?=
 =?us-ascii?Q?8+ivGdbI5H9GZyGbL33SLc0JM9Enc6OtbNIScqbvMxBAiKiGKMG680+XLJvV?=
 =?us-ascii?Q?GxvHKGBNuDmpO/wVNTZlpn/y+YvpDoY8xDDl4Be9VpHZ/nxx60brDBuruNSD?=
 =?us-ascii?Q?cFPbUq1AWztsZmuOf3gMnGzCoXFxVK+LH3xu+Wi+F3UdLPN3PWlHqu/Rf/27?=
 =?us-ascii?Q?QAejiZlEFy3q+SQgL3Uc3Idov8N6Qy3exxZtLlsoSghr+CpaFyFwqK81s2q+?=
 =?us-ascii?Q?gzK2bY8gL6X+LqjHTy0EzrxN4tDMlzJdFcOZvusVGRGin2Qw1xrHlpqCAf8J?=
 =?us-ascii?Q?4aQfR5HH7f9/gdwvhhz8Xg6LHT53McyTkLhnHHd0FuYrGMzN2x++pJpW3Oqu?=
 =?us-ascii?Q?aDz+7paPUHbqP5g2+sQt2p4eR7mJOCJM5t3e0Xz9HLyUvK6Eh8Y1Q3IbmXVs?=
 =?us-ascii?Q?ZAh8Z933zipeag3f2rF++egCKJXRC+EOLLexrorupjscCGspjrCmISWmPF4c?=
 =?us-ascii?Q?ynCziSWOxFhl9i1VekV3IDnFWiXFv65aJaGmiVWVx6ad+X7Eb5DjIni6DKKg?=
 =?us-ascii?Q?mgvfnsy9TAIhWOovtoHwqj0Mrx6cEL4WbHS9o12TvsSX+xv1uqpuBPINbK+x?=
 =?us-ascii?Q?Iw5giGGILnkFFMtUfWescF3kPvNoCwePfmpfWO6+aW//1x9wlKfZGwdnd0No?=
 =?us-ascii?Q?2m/goczfnojqZWt0TMCMfwVSuWTgQsY56OCdHfwkmMYtf5hYIEVDVYzQazag?=
 =?us-ascii?Q?YlEGaaw5WBypqv3aWQg7VyfgVeRYWUQ+xuTxoR7SP2fhBR2W8RJH0kqtjYoS?=
 =?us-ascii?Q?2HjK+8hHMYGR3dYsqu29JH7hfHUWGjUxZshznGMHdJXVrffyVtzD2xOhZ2Ob?=
 =?us-ascii?Q?c4SWdfKFCv6oSMWvnTrU53zoYeNzPZSkg7yVqqhVNuBKRohzWIj0KAB69W6l?=
 =?us-ascii?Q?vaN/Mr7MbiR3DdaPcUjlsdtAE1+77BhoSijjP2udqau68vwHHIOkQuXYfW1t?=
 =?us-ascii?Q?8j5iNnP1fdW89iiScnLt3AsOGQyQ3Qk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b59f7-104f-4f80-4662-08ded488d52f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:29.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1atnaKGtkXtXy6csWCCM/0t/Z7trv9NvFRkljXXzqWi/7G2Tf+gg1hA5iMlWok2W0zzpoN2uTQGAkD+XuKPxmnZvjEq2ou8M28iHew+lBy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

Add the Cadence SD6HC controller node to the Agilex5 SoC DTSI as a
shared SD/eMMC node, disabled by default. The controller integrates
with the system SMMU for IOMMU support and uses SDMCLK as the primary
clock source for PHY timing.

On the SOCDK board, add a fixed 3.3V regulator for card power and a
GPIO-controlled regulator for I/O voltage switching between 1.8V and
3.3V. Enable the controller for SD-only operation in 4-bit bus width
with high-speed and SDR104 UHS-I modes at 200 MHz.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 +++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 31 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 02e62d954e94..f552aa0c1faa 100644
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+			reg = <0x10808000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
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
index 262bb3e8e5c7..c56f46721bb0 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -34,6 +34,24 @@ memory@80000000 {
 		/* We expect the bootloader to fill in the reg */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
+
+	vmmc_reg: regulator-fixed-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vqmmc_io_reg: regulator-1p8v {
+		compatible = "regulator-gpio";
+		regulator-name = "vqmmc-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states =	<1800000 0x1>,
+				<3300000 0x0>;
+		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &gpio0 {
@@ -98,6 +116,19 @@ root: partition@4200000 {
 	};
 };
 
+&emmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vmmc_reg>;
+	vqmmc-supply = <&vqmmc_io_reg>;
+	max-frequency = <200000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.7

