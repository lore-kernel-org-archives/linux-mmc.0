Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C47310779;
	Tue,  1 Sep 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288549; cv=fail; b=GLy6ys8vnUxBnA+jBKQ1lnmoSdxcm5+n0yclX539zzZhk3OyK79MybogvyZCeRuZ2iOWLtM7Jei9lOHt/yS8EGCfrLJvKd0eD0vvh89Lx6rk4LxU2ah3gv3ynHi1XRDnMQgeWKEotaYy6g3CIZHFnl64bgiX/NiSVktI/C8o7OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288549; c=relaxed/simple;
	bh=E0FzgtGWd5tqJ07B2qpPBjSc574Ekjb5dHSZqo4BhnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFzdDVTCnmfkUO/8h8K8G4WAAn/UeZ/JgK/ZlzR4ktYXrU6sYYYAysMEkQpa1P6e7IgUs2IkYbXA8SWQloXWYa083pYiuBVZTGGinaWdDyErc3KIjilIfX9oQzJWRRNyGjtOY/pQmGTtm1u3CiSwJJql0rSQ7H2Gs3+DuQWQhYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vt2rNVS+; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vt2rNVS+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c55UDB4LCOV+Phqyd9KSZUhN3l6dYon/olAg1gSGa6j59cwNuCJi+wNxV4zHsY3FekNm/eemvJyMpVndNeT/IlJ6tSp8ZrAXjvtZZu6hu3/9D2ZuNP23IzXTfziKvjK9BTpmzBIsIkqdPr7m4soBUV1YdVnrbAiWasQFwHWBojd6++4K/ky2BgcIEYVEWb4no/hC5bwGGu4LO3rLj/X6rwTUp56LBKcGWfb5hU80NnfhWgh2Ohn6dOq25vDwOAxwrtmwLbWafnuksoUAcxYjoEECItdDvCD4FnTrU8+Ltx9ZwJG0jdZ/UhpLPrybFctS6E88AjT5//nbutCCdA+NTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0DxzHQ0eX/j84gUO1QQCVL/RZCXXZOP4Il96dYseZQ=;
 b=qNdvJQa9Zd1O+glI6YKN7VjEDtExLnRtthN5I4IHgdz41STlgrD3mRE8f07zhZ76EdTrmLneXF98U0ZMGh/j5P/Qb39KOZU1NhglFm+TczDA4LkmQDr0NG8Or02ZKoCM2vAoaKyRCVvk+tk1NhrZhayrIo3EQd4tloNAA03g4imIfGkD/wvx3R2RxBc2Eu2Klu064n714Mme3cXgLMKfOTZhptvwVfzS+cxifYtvUFiMKErR2n4Ouym6RK9rp4KFDpy5PCu0vFxk78YxiTTiyRTHBqGeFVyoT+ORXIB1lcRzk7Qc7qfIBN//F4LCLCq9sNZamGhjMQrfajgvHIE1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0DxzHQ0eX/j84gUO1QQCVL/RZCXXZOP4Il96dYseZQ=;
 b=vt2rNVS+ucJ8CRQygERRI+dk0JRE6Cm9qCL1LhnT+4TF0fSFJ8e+/i9gY1IR2o28iiSvErSt6NaDZbIFq9g8+BiQkp1jkIVcXJaSfb0ho3MOrD+ya45Yre7IK36xwtyGDmX1uk6ceSlhRx2Z1/rtmL2N5pieXwoqMy7//TFQ8YNhXIEXn/gwgwIuzJmAsS/g+ezBSmKb8hzHSPpGd6DV8t+0IjKsKPNe3/efYgdZa7IyFbiijvsE6FQprUj5Y1TxSUa81Qr5KZsPFPvDPEFpMcweEoQx5gAhpCTp1pImIsnCxR4KBCwPDRZic6Dc8T2sNFDAlC5XrEjXX3/9W6B/SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH7PR03MB7338.namprd03.prod.outlook.com (2603:10b6:510:2f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:49:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:02 +0000
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
Subject: [PATCH v7 2/9] arm64: dts: agilex5: add SD/eMMC host controller
Date: Tue,  1 Sep 2026 11:48:11 -0700
Message-Id: <20260901184828.15653-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH7PR03MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: d9769b70-393a-4fa3-5994-08df0859b127
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zTbQ1ZHoZETi8NyxdeVU0Seg72KfYzO8quUHLIeSc4neDtBtMg3C7k8F89ZdiPZSfrr8lkhCMTYFJYAh0SkK692YqnO16wYvKYLAUPM3boV74GFjbAaePtpNWXAMUu6noy/x7YczZCNmSmfJOQigL0uXfHnTvZWat9WgFzVz5P2CrD5jOJfJRXkJ+KAALDSiZsnO+Q/BXFHnnYQAfYLJqNc6BZAkDBLc58w7iv2z91w1LJu+T6N2iLmQxEVLmurR3glyeM1lzgGTHVT57RheNfOui33iio/vpy/zUiSJ0OK1yzisQjta7tlt2xtDDizWPo4NkfIuigqGfd4kIyeK9cg4GiDOFD2OnocERlNK+nakUr7g5xkWNtedjJ1BD76uMzDpTPC/rF+YPXrp3iJhNb2QSyCJkA+Ela7e0SA0hv/QqefDkrFvAji5GCgvxTExhPmb6NYV3bzMAacLqKk99xoeDRfzrL/tBX5H8EHu7+s7eVHQtmb2reFHC7GNcLcZeFpohxXbFuZiblaPkWT8PuDsC3MJwP4Tr9j/NN3LJ8+ZYCt+8fo0+s746yIpNiPzCKnOKQznvG3xi4BToi6UKuBfSWL7lao5q1L/gPBbAiRNUniBO6yFE98Eusf0W1blPmLr9feC5MlbTcsBPEaOF8GMGE3SmxJATS3lfPh77lk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCAMeIDwwHHKxQs+mS8/LjlNyGPsMBD12aw8i1efQQZefv8E/+NNsgH5TWnA?=
 =?us-ascii?Q?QFVDMKy2KsUpvInaQUVtqpKrvYtjrl66QQknuPw1hwR4OvIaKP9mBzhvVjmA?=
 =?us-ascii?Q?kuWg5vc7Utue6QBc1zL+OEZCQRTYTfoaflgkUvJFdlGOneBnPuK7+qmOKJGg?=
 =?us-ascii?Q?+ZGxrSE2EE9VBP78i1Sjl8fbYp83mf0QRHTn/2z3FTsf4tG0Jp1iP+eiOfz/?=
 =?us-ascii?Q?gSt2AxOScotMXKOTh8nekl5SKm/CVgTQsp/Vz9frhYsqdP7W7ncbIkfdsFo5?=
 =?us-ascii?Q?OzMMSwUCQUB5O3HdVe1U9gLHrwmAu2gCCosm1kCnE2ZF/NNGLHwwcHHkRkTT?=
 =?us-ascii?Q?3D3gOrb95jDn/bau2cxIdQcHRixEu2wjPwz8w8BXUUIAA5QsUGR24r7Lmmft?=
 =?us-ascii?Q?TJR2SPlZMnNSqmjM6k+/9NSjJehJSIf/hDwBwUY1q0vn2Ugh+S/fSWbzFkEl?=
 =?us-ascii?Q?EwTjsjCW2TLXlji5MtFusikv0xPEZYFJtRncEHHRMXnDHH2sFJ2ZtENr6JF7?=
 =?us-ascii?Q?iCbIvaEoA79+mNh66kVaeVsVueq1xRxyFnML8r7MUscoE7sYHDSXeGMzC+Wv?=
 =?us-ascii?Q?7ZFBtORP8sOxWePhyzC8vbVYZjCmwRftACpj4yrLiN5KTxX2vVFX/q6OhyLZ?=
 =?us-ascii?Q?SmxezBez/GlsTVyzcwFVokqaVr64YcBylAdaCzUOQptLadz8K8lfOIaRPcJe?=
 =?us-ascii?Q?2/60rwvjPi/TECY+86HVZXJAbeWNWm92eQhoziiRy3QzyLT8Wd2RzweGwB08?=
 =?us-ascii?Q?J+YNZip3kFycpAjYNy8iNPNbLejs0p0s3a8ncJ1FSAGC4McHFEdMvDfZ4b+8?=
 =?us-ascii?Q?gfpuHgLSww6CObizsCcMc2ACDOmJS4ZCbKabqhV5H6JaNS2JBenYxa6nMAYW?=
 =?us-ascii?Q?0rBi+SQFLb+7lof2RWy9X95p+smeuVUUvhzuhWz+WQxzOzb+GeturpJu79Bj?=
 =?us-ascii?Q?RcsW8hAhQOpVfeygOz1JpdSa3hTX6hRHSTZ3IPXtZInNI/WAZBQlTHBPqbtt?=
 =?us-ascii?Q?d43gRD20gwcGFqj/0fbJ+J9i29sKb1KDUk+jIQDkpt+e6RImZrCTo+6Mu4iF?=
 =?us-ascii?Q?KQ0X03mMHGOvmEd1e1lZohm6l9YR35OeIYG0L6G+by5tj00qaX8Y1FcIanfG?=
 =?us-ascii?Q?KVomv3FgPgzPwHzVdva54o1MpV/VNqyxRind/Z7k5dgyhAewhYTB6xQiljul?=
 =?us-ascii?Q?mVN7KHkg7Zb0Wb0fukFIeFANSBwncBcVX4SNXjSY8gIcnUNA27BDYIrplQNm?=
 =?us-ascii?Q?SxnoerOcohl6F3e8SOAJfvKe+0ySdNxPv39FgHS/+5KOqzXFVlfU0uugy4CZ?=
 =?us-ascii?Q?FWr9be/mVQrXRDu5JFZiJDJe48wMUpaq+y2jTOW0K/z6DP6GNOgpe/P+JEN6?=
 =?us-ascii?Q?AMpCaLA03T/+9nlt45mXMIBbsGNYVaaMIIcXVuPu/tqDn8z5JYbJvEWjnD0m?=
 =?us-ascii?Q?u/oHfuNlJ5P76KV1sK8AnFGtj8rD8F/tG2X2H475hy69MM48PdOKbH3XhjYB?=
 =?us-ascii?Q?Y72O41tLYTE3cQWkydUR7tO0AFmD3rm+wc7tLkiow1ou4VvdmofRVetaLHsb?=
 =?us-ascii?Q?tq0n0fmivCBTdg5M/pecuLpGeclxXw1XyP0RoA1yQ54UIbjrGPkYEOa5zxMm?=
 =?us-ascii?Q?QUPt5/F1lAbze9GB9u+GYQjU26urxno1fZ7AWvYvWVieyP2G8x1t7q6jHODf?=
 =?us-ascii?Q?3EJujotiL4QrjG3hAoOVhw8mN0QhhCxmJ/t4Bg5ZJkpJi/USisbLzFg20wQP?=
 =?us-ascii?Q?gapfpx4+tsbgN4k9GtfwDBcrNDeR0x8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9769b70-393a-4fa3-5994-08df0859b127
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:02.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSRg6II2szJGjmZKInoWvZ4XpRQVlIlSluYCmt25qndYFQj3k9wVgPbtwqqo8LMOiGxEA9evdvCspBLhOsn1b5hUEiEo7lBialtS6ccELPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7338

The Agilex5 HPS includes a Cadence SD6HC that can drive either an SD
card or eMMC. It uses separate SDMCLK (CIU) and L4_MP (BIU) clocks, and
has three resets for the host controller, Combo PHY, and SDMMC OCP
bridge.

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

 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index b06c6d5d60ee..6de5a470d423 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -300,6 +300,21 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		sdmmc: mmc@10808000 {
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+			reg = <0x10808000 0x1000>;
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
-- 
2.43.7

