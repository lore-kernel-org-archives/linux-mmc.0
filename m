Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362138F230;
	Thu, 20 Aug 2026 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252266; cv=fail; b=mV0LaK6cg5VL0GOHBt/rfqlEIfjDFGqoR30vmc9oTArOTLa3AOFA+8tHlAxfgE7hnJrZE6DRbWN/Xua714ttoIZJvucIFSfv3PuVxuT1FTZClSduNUWpU0+JPYif1er2P3CGm57rxTl9fi5TA9AH2BEw5BVJ69wuX9K+r+PvxqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252266; c=relaxed/simple;
	bh=rA1Rcfrt544covNMpl1oWIGjKDxpF9hgQK35DGfTSUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGrqDn0o3lQCiujGVjI3/CGBbjLk59w72I9/yMwAisP+fLwLDO5/yibDU2nSGwwxkmzwozYWHM7pvb3Gh7uRYyfVCGGDqmrD5SMOEnicxoz2ZvxiVn5q75JsJSqADocWXCfTPiyltvPoZ8FbR/ihqTng2Y2TrQBoKvluzDvXDc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ksuW8Qoz; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ksuW8Qoz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1H1cL/cI1qPyMi10+UpeCyrMpyUDxiyAdRtQUikCvuNVZs6HdqgohLJg5vbisQGMgiQjAkOvCkcYXc/aqZf4Y82+3rsXfrl7CqsYJMjfHynlakbyqzrlPSi3HA9xkpjPXFd09fE340tncqgRQNV10I/H6lxkLg3l0YlXsbKtKBQCIo143c5hzgsr+pvd1uhpezEl2/JrYeLwgEk8jRvtvTBPfm9zJ+R3ShXD7NssD4x7DFPA98dcCNt8Qa+o0r9rTp+biMB85OmvR78JTh2VrENGaEFg/DrsbTog+tZcuSNQQXrUqUFVo4pxPF5Esju3aiE+bowvkRigR4NtIwtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v8+neQRBC5Yc/c1X6jFKpLDmFyxuh+2yw1dNUwk/jc=;
 b=lfyR7BxppIP070fY67awaUO7gRMllooyZGsYtIiDRm2na3spDHuRo1ImFWD31xYiJ7VAHLARhklFiFhqi3h3N4zAdOMjPHc2t5kNY2/MRFFBMDbmUKgPPw2dec7Oi7/pcafwiG5CAzilySElA8l4vDaZFtN6q1fUbp0UbRpidaSazQYtoqJtm1H+MAHX3Sc5Cz7HATwr4hHSwxUbueLP0BdopECi1cZRYtupIZo57odEChJgTAHb/SN9ebDW8UUmhuk7IXXlDccfe1+kt150yEa95nouQG4seMagIsRQPSuekNvug8dbRsOgQiMRqb7Sjyk3hOv5XIIyd77vmhIC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v8+neQRBC5Yc/c1X6jFKpLDmFyxuh+2yw1dNUwk/jc=;
 b=ksuW8QoznwEMrwl/9VTa+pmTDgwx1Vx96rz6hIAtnlP5XDbFahCsEDrSes73HfIBVOu7577zHq2biR/7vr7gLJn7K1bHJ8ruc5AJyqkqgnVOgqEfhXF0N6xp4M/+Yef7LGjE+aWGfKUdgbFWY3dd5Fr9GDFXAmIZ55Di207s34sxf5jRgtJHvn3GzKyNXXqIUy2rpf+A64mcn2sRaKaNyhsIqUjjW1OwQsSOVCmUc/6Q1/Kr4QuyNfzzX0iv4FXRjkMLBJdyr/KoD+88I0TnVsOBaDpJMqOQA8mQ0LKon32kcG2C2d5cNE2+Qf3MdX1zTl6Ba5qTwl6a3iI8Als1Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH3PR03MB7364.namprd03.prod.outlook.com (2603:10b6:610:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 18:57:36 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:36 +0000
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
Subject: [PATCH v5 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Date: Thu, 20 Aug 2026 11:57:08 -0700
Message-Id: <20260820185721.22823-3-tanmay.kathpalia@altera.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH3PR03MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b4e33e-91f6-42a4-2ea9-08defeece67a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	oF9Y16a5GQrBdDG9I6xRF+sFxsKPR0Jzg+kYTP16fHlKdzTIL6G6XJjWRYLZnu0Um+wjYQihVr/sGyfwptYatu0dhHXVKkPGZrmm1Oqfp2Agujx1gb94Qj+Qk3TqA41ftXT9JcLRAI1l/YrBmCmL208AP/fIPRQFs6KmtP/Bg34x7L0qBykzUxqL6iaNaSDIrjZRgpgcq+T2j69KcSkm4WVklnGO2CgLU56MwMOSOW7QGXq/7j/bZXQSUcb5lAZE8AvQBVa3c1cDFzWy08s06b8D+sF0pI9XHwu6p+tK8UK9QFFhwKonZ7jNlrJSRYce9OhmwjtobTrKeAN2MJWt/I62QnvI/qmNf2OUmH83u7tqJXOkJ2fg72jiGWINyORP6XkuajvYdRwACe8baRe6E7AvcMErBslQbVHJlqUy0yGp972hXVzdxlPb8w5HXZ5dcZVpZ0+kp3kBpChFSinuEdzzMqe8BWEUg1U3wIld7HjfSQ8AjUFLF5y3pV2JUqyTuR8uLH8n+iyFx1uHqZg3u6PzJz/Sg9C3l2SZytnIPVOmhJPMPw3kxktQCsXeljPz66iIR2W+ZoCjfzqvpEeZEZST6p7sutNCoWjsWOlheDTnjPH3QlkOuQ46v+knpJYLgavdb3Umm//sTbxYub+9uUdBpdtk6ouxwEErTv17fRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTVAox/WnfqKU8MgrRhjGLWzdQVGKZmQUkTyhWtjLgVc7My7RGp3J1pXWfcI?=
 =?us-ascii?Q?mqt0W5Yx7T4OON7eLKGgzb0B+vFg9r0Bk0WLXXKckexbJfGeMNbvJYEOUtCo?=
 =?us-ascii?Q?UrtE91PeySjnmWcv0o/ECU1YR98lV0IfyYtOuVVQ+kOy2vw4sTVUjyJw/RnU?=
 =?us-ascii?Q?a3tahx6Zfv/p6IH1FM85BfJ5KYYTrooQQGLcXWIWrW0UMNxy5J9ygrH9XODh?=
 =?us-ascii?Q?7KXywmGBw5diXdQY3noovWsOy5pHN0WIWgfC+L9QfA+JBWwQ99f6YDjG8rMS?=
 =?us-ascii?Q?fUQjjJ7YOWijWoa5VQqIWGKroVfqNcz3NNLISomfv0DJQxMgAfDgPxgtjYPC?=
 =?us-ascii?Q?18uLD3YC0t3eOD9krIe8TgUkpISYBQ7diDoeuQqhzmEKzzNHUuidflAUPp0A?=
 =?us-ascii?Q?RlpvLndCXLvyfPUWxmYtyPANvf9tVjzWhVjWvqiukxUpkXAukX6RSI2sLAl9?=
 =?us-ascii?Q?aZ8Q43Z4KVuWvkAwf6lgvfhl0J9+yVlamJvv+t7O5Bw7fG/WaQlCFoNbA5bo?=
 =?us-ascii?Q?TuKfhCl2AKac9JrWkxqCJbZD9021/dvNYC/bCFc9jY6zdi9UjmB7IYfYWrGH?=
 =?us-ascii?Q?TcRpYoctwTmaP40sAWXXDO+QP/swmZBXchTG9wIk8UGLNC/7DWbJPdMk9o6B?=
 =?us-ascii?Q?ZqSxpUgU0wVxpbbvbSf+kmZNkvbnCnRKBU5X6YEp+8TV7fdblSulZ1Mj8EA+?=
 =?us-ascii?Q?0jvJ5p6B5lGzSkPbFz0ZrWc70cRGb0HOLBvXpHHHrD4cUx4QFY85NwNHRBBg?=
 =?us-ascii?Q?hldyaYTxLwk93MMhoYC39qJudtnmeA/Ufo/DDo6P8NhTjFBzcDFt6GGmXuwe?=
 =?us-ascii?Q?Kz8YmGUaQCACZmLGIQFJjQHKqQu3TaOSybdn+OSz0NrkBg1VrGMMBGxpNsLW?=
 =?us-ascii?Q?tmVfIFlEjks8ltzrIWlmErqwTGTRv6kq7JvdXv0szuhC92GDYx/r7yanw9+E?=
 =?us-ascii?Q?ftOpJlDgvkwkD4lUeug3bWwj2dkKVmTf7a2G5q9daPQHwbeOBdRo5xd63/UM?=
 =?us-ascii?Q?252Bbtq3nWYLAKTPzztAAT6u9h3PKiqyAyJ6rBS5f/poDY8oaSkQ0276o6aQ?=
 =?us-ascii?Q?gzcPj6XDokdtNNgUUsYxvb9JpWutQ80Qnvfe5PFm0uE5lrWmaAr2MOsoCar5?=
 =?us-ascii?Q?9leCAWk9Oi4X6AhR+S3o3BzGFm+c8+Jn2zbzKB9bWUqXESCIrlDvSLXcxyN7?=
 =?us-ascii?Q?ZLJ/wDtwUq9wt9QNnuVwEHRTMOowxR7EdcLkLqUNBu+ItGNoR/IJDTIIROs0?=
 =?us-ascii?Q?HkC0s7HKt3z3gBWLCRPTjXTNgWcwU06NXjkDOkFyaglG0AT+22bL/zR0HRbX?=
 =?us-ascii?Q?mxbj7mJpvm5TtSB87VyezIq61Sflsd7xyYjp/cklLyGGs0AZTuKO6OV3+VC4?=
 =?us-ascii?Q?Kb+xJJgyYEd3VJ++dGjiPmjncbUrby9+hMmqYvo1Xi/9BEJxD0vpqlqlCFcs?=
 =?us-ascii?Q?s6dWPSo1z0JNfRpCm7sqrUFoqMo2th2TSzh5AA5B6Slyv9JLt1G6cIaNdkOs?=
 =?us-ascii?Q?4XoIxyJHUSzwF2MRKqz6p5rhgFQgNRmxmvehcVhqqHhWPhQSW6jBmNjgzH8Z?=
 =?us-ascii?Q?vlFE0ogC0EXsKbX+hC4Xm22ZiqRLVNK2AWHa9UUkh1dKuDBFyknCFnrKUOSB?=
 =?us-ascii?Q?mf8I6cXF09LFcoYl0Ahzcz5IUdih1qvVKzpUPR/eQS4eT14J4CQLyH7pHa9a?=
 =?us-ascii?Q?d+P5cw2ZwVUytAwtvRqYy1AtpdxztNXePX+EQeN0XESqpRNdC36/oGgKXtZ+?=
 =?us-ascii?Q?B7Jj5plz26snLDtIS4I3uTrdPoF4sJI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b4e33e-91f6-42a4-2ea9-08defeece67a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:36.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZn3MP26OxArrtPdzE+AdKty0TIsJQ7OE550eU10sf1G4igz9GcmVKTEjE0wQmMUxPHzgIRCetqKbKxgPMOjmuWecWzaetJTpPRp5egTmlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7364

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

Depends on commit 10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable
the SMMU"), which is already in the SoC DT tree. It is not yet in
mmc/next; apply or merge that commit when building/testing this patch
on top of mmc/next, otherwise the SMMU remains disabled.

 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 ++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 34 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

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
index 57d3c5807c65..93222b199038 100644
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
-- 
2.43.7

