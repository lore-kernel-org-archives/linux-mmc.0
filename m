Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010009.outbound.protection.outlook.com [52.103.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FED242D65;
	Thu, 19 Jun 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311369; cv=fail; b=HtESc80IZzknQqTIpRRKwCJ4M3oxBo2d0xYQ1N+xADOgfJFpHSQ/yEWfPAE/TInLiDNtTbvmvwLOoIhzg/wVh389TsrLKNERvbeQlIS/6f+RUUD6vR5t2JXomgGSdOIvBAUwUHsEZXPLjfb8TDvIKJcRefc7Wg/FKnCxgDdWIyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311369; c=relaxed/simple;
	bh=CnmapRIrZmmuiV5GretVNszS0woofNOuD4gzoHN85js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7FMRehy/rkv4gxcvnOtvFocmmDoI6zZlF9Nq0C4zMsJzSNl5FYHePy8FZF7dh53P6Wc1hIUEQu6LdcfWjhfev4gZ+0EsLuvSqKRejAqaszf4jJBBKo09NixV4HO06bIdm2AjDR6/O/x1Tv4hLFy+Osa490mbbF6hYWLl8naZ30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Km7n3QS/; arc=fail smtp.client-ip=52.103.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Km7n3QS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZgz9WD5TysDhyzaqKppffbiQ/sSle4dwdWvRW6kjVUkmzao86Q0Uodn5DBw5Au1r5H+5mNAqUMxxI1lPM9Wz4DF1VcbB7aQY7vnABmiisCXD3W5I8yOo7bJUaqNYDoG9gjKBD0iqdZOdEqgvtPoDxMUXXiqvk8XMkBtSqpSbidbhoOO7YBqvYZhDi7bEKTetPepj4HFRY2+gOBnx249DHfKTadq9EIvS6wml6bua/B9dRlt7lmGelHeBmxo9e3g5ufCAgfeBYfhevF7NhLRSb+O5Bo2M8CM6cugpPbCGLr2zACcSEcQBzY/wvHFWtsLWakCWRJmwGJWJefbW7zwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsHhN8Sa1C64Bo9nY+E0KG8EOfTCWgxRV1weeY9UOtM=;
 b=aVLcEGnnS2DS64+fea0Cn/13xMOzIMhfy+Doo27vp4UegyK19R4mnXovgG969q5UENZdgMieqLQbb1bjJscltworCmZfJLgZffU7H0X2U3DZ5dS4tdYust+4gxPnPxnZRYvtcCrVaZ9ALlSzYs/ZpUpfMDCiwJUyQz+iEVXFNlwVTzJQiQAEHOcnsfQae3QOc7Sosa+eRwf1htehtNLsYPChbO2vFyCV1vHs3Svnu1a13c1d37BqhueL/e0aNcXpXKuGPYFqI9lYuFwhk1zfp2/+xbOrSujzA5mQ8XMvkx/vULU94STeRxT4+iRsDzyPAjDpIUKR0xoDln4slo8MaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsHhN8Sa1C64Bo9nY+E0KG8EOfTCWgxRV1weeY9UOtM=;
 b=Km7n3QS/iGjyI6Lm2YfoTlYZL2bkSs/TYYcyk/3+lzDb8bqgdYlIIj9grRcqSdME7mtSWPOc0BU1snp5FIM7cOMV6bESP2/+9qP9sgfHurGBRe/wexyxK7lPte3CeLwNX0ydIGRZfZXnYerkBhAO0eVsZ3UxVA/7HRC5ZJGw5Wcwyo6X7taKk0CykuoSNOHVA+AQo+7YFEEAo5ex1LyujlZ2oFj+J3A6r76M6R+rQB1WZQBKlqoYfNI/M9bJ7GnqUeRndBuEzxjxBvboz+uu0RNw1xMwc57Vbnntpv9pvmYPZC12S6tx5HkDbNl1xAoyhE/g+BiObueb4H4ncoTmZg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OS9PR01MB16295.jpnprd01.prod.outlook.com (2603:1096:604:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:36:05 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 05:36:05 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/4] mmc: mtk-sd: add default tuning parameters for mt7620
Date: Thu, 19 Jun 2025 13:35:10 +0800
Message-ID:
 <OSBPR01MB1670942996614E073E87077DBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250619053512.14507-3-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OS9PR01MB16295:EE_
X-MS-Office365-Filtering-Correlation-Id: e77c9364-6e22-4179-143e-08ddaef32f8d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|7092599006|15080799009|8060799009|5072599009|40105399003|51005399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cqiUfJLQzebvEElArWF2MXxRzUY2odTLC2rC4leHVs2banQCGBMA+EYhOUs?=
 =?us-ascii?Q?ohB9r9Nt9FqJLcsxApOJUG3hse1We1F+iGA7jZkB3i0Ukce7FaukFEW1cX3n?=
 =?us-ascii?Q?WHY0KoX8sBgpu//ynEKW0hSfKjyiVpi03GtHDLwKbYvyKRiL0PD5di95uL1x?=
 =?us-ascii?Q?FRBw2DQqEb39GjD9LpAL6MNQpFRtLhO8K8K/D+xa3VDwhVIZjC5d4pIkiiMG?=
 =?us-ascii?Q?wCMCqOfD7I/lfWvh4hVP01a8vDd+ikHux+grqI+hfCaZOrcnS9RrdVn1z8Ek?=
 =?us-ascii?Q?cXa9p97hrYuzGMOgxParFCBREcprJ81oXgaJHeMao3kveS2j7MZHpmZwqA43?=
 =?us-ascii?Q?POm7oviRPavRHc2Ox8u1KyU7iz0WA9WNOW3UcqLoivQz5ox59qr7x9l/bCzi?=
 =?us-ascii?Q?0AQvwfDrWj/ChVSM2pfxp1PU5e3tu3nNU84fP8xZCtL8XseTQQrNGSyKOWES?=
 =?us-ascii?Q?VxBecADQVfGdBrFxJ1GGU/3BHaaX8lM2XL8rcW8UYVRPkTs/jxwMTziblOgm?=
 =?us-ascii?Q?jLcG/stv89Nrefc2hzpOfCddOo57iwOQ3fe0M7Otn6G9dYzzubromsq8Vh2l?=
 =?us-ascii?Q?LuzbyyZ9pRU3vgwSsX25GIDiejKQjVIZWz1z03v962sYoRNQmBTF00lFvcvd?=
 =?us-ascii?Q?2ox6BsfJEwn/TuzGqO6gATl3gEBp6Q/KkFN4cFmSCptsXXjMjgvq+iOy9Ra9?=
 =?us-ascii?Q?JOMBGxSlWEkycpJlTOUFsstxC7zu6LY81DOs1vAvC7qTpDsOTaGqAfZ1JYcE?=
 =?us-ascii?Q?pZnxr+55ojmRaSRCY7TncXqS/XKkgTgH8HMLDaiWVRM2dsctiJHNw7kmo1rA?=
 =?us-ascii?Q?IC/xahGvHH3N16nEhpbwFSMDOPIpRyph5v44N2NmjVw02iVHoV1NRe18tQOk?=
 =?us-ascii?Q?kdyIFn4fj1/WPRKBYrRdGMvo5oBeLKhKe1iDe9pOWlO8et/vYG1FIvkCrOxX?=
 =?us-ascii?Q?76Y1RRtidG7f3l+jQs6zzYhzP9aK2WdMO1BJNSoDm/OZWPftJspmCrYSFZWt?=
 =?us-ascii?Q?kkG4eqN+/Z7ylkIVRd4NxFuOpRT+ScqvsIM6HArcpyEy5VPQOBLQBpBfU1xu?=
 =?us-ascii?Q?/szKGia/4euRYWEaf/uV9DhQbqIscciP+qjH36ykojlRVlxdbrLKI/ze+9L0?=
 =?us-ascii?Q?ROwTeEHPYlZFOtWmT47jABqtKsPOcQaRqY6ngPcpT6naOQ3tjGCLs/cCkMaA?=
 =?us-ascii?Q?sXudr6vgcEZR6uzXrom5OgEcoR1ziEmeqXu5PA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ijQRo5pDBnbFT8jaQI79zlE8Dc1BhP+chJ3tC0XRBJomMYnx1VRyiWcDr2S3?=
 =?us-ascii?Q?Wj9C3rygmDd0ysENTs0td2b8Y4pUOwdZHaAuA86PDiF/7Rfce0tB8GP01SeK?=
 =?us-ascii?Q?MqfaMPHXjcCNtJCzSaxAOG/AGQMl0YD9+OVlXemS1jE2AAq5q2Sdrc0OkNly?=
 =?us-ascii?Q?swCHUjI2yCpO52CcIKz6hW77BmFxQVBl2AFX22WtMEdLeXlIj7/K1YYmVLPM?=
 =?us-ascii?Q?IrCWW9XtX9SQYPn/n27aH9IjgqSb/prD4ZNX7EL5zrOJgzQn7yT6eQt0pFlG?=
 =?us-ascii?Q?0cjhV50aKFpC72C9Y7HLvw2kpGXtwxUbIO2clmB7gFMzMnac2t4XfSdx8ByT?=
 =?us-ascii?Q?FraFo+eSAU7q0SfoHiKou7VsSg7o71pDHz2KnxaDzoxisVB6KLVGa8SouMyb?=
 =?us-ascii?Q?mfyQWeUWjsxe8k1l4U2ucru5nrP3suuvCwCyv9xANw2hyRWZ6AVrNgkjOCLd?=
 =?us-ascii?Q?BftJVSHMAHpx8c5YSW2mpO3ImDYhyhzGhYyBFO3UvA5CeyyDDOfhqvlwMiYf?=
 =?us-ascii?Q?GKLb/4GxtOH+oQUJcORsaRpu5hk0UQFI3I6XuelUQVjXezIcIM6vEppELTnR?=
 =?us-ascii?Q?Nb4GqV3FM3csVqJs18jkNil7Ex76Ty+WkVRqpDxeX7jw3pmpV8U9surt2+lS?=
 =?us-ascii?Q?MlVVP6A8mQDVuoIyCt6xRwF1gC676g4Vmu/Zv5JeAUVM0JHU1uXjrMJB+Djo?=
 =?us-ascii?Q?f2XmQjXtNMU0N9vCmpdcFzsF64z3+439GX4xe1WRwUOdC5GlBP+IIN6JFhAG?=
 =?us-ascii?Q?vBhR5cXzUmqQqZifkDLgruKnG4MY/xpkmoVgNpJwX54+yMa7lXxrcQ29eTYH?=
 =?us-ascii?Q?Pnhor/DPDmiM+Ecshy3FvOlMvdqluGvcb54meAGaWflkEz+NcaRYYmApC2Xd?=
 =?us-ascii?Q?ITbxSxbn2/fUIUAYL8cdHrXxSE/10nz+OcShXT+4yPOx6e/j0GsenPQs20fh?=
 =?us-ascii?Q?J/nbH1f+G4R/6BoTpwxTRFti+cavMm3FPrgafoqWjU2QpkxCGKe/+5EeSSyO?=
 =?us-ascii?Q?xizzc403AjJmf4pSojHdodc7a8YBCD+QzZecJDlUOPaVb458tQtR5Da+6dO5?=
 =?us-ascii?Q?sSHsUJO7ee/2FbCoVk8MyAZNKcucT1Z3M+IbXe3jUHdw9R7dTm+xGPe5U8Ct?=
 =?us-ascii?Q?nhtTzDMYEHbrUY+kGWdBH4FWmCF4RxTRK/rsvLlhdl3lh275OL/m27cD5+d2?=
 =?us-ascii?Q?q6h88KHnbd62XLPM4WHXx1uZxgFC1sR4FgeH7lSk+3nHxd9Yg8YwgJ5q+tu9?=
 =?us-ascii?Q?jmY0D5g2cO8t8gT85OjU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77c9364-6e22-4179-143e-08ddaef32f8d
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:36:05.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16295

The MIPS MT762x SoCs require some specific tuning parameters at
different clock frequencies. These legacy SoCs only support max
48~50 MHz High-Speed SD mode. Therefore, the standard tuning step
is not available. We have to hardcode these tuning parameters to
make them work properly.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mmc/host/mtk-sd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 53d63bb4e..52198daef 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -79,6 +79,8 @@
 #define MSDC_PATCH_BIT2  0xb8
 #define MSDC_PAD_TUNE    0xec
 #define MSDC_PAD_TUNE0   0xf0
+#define MSDC_DAT_RDDLY0  0xf0
+#define MSDC_DAT_RDDLY1  0xf4
 #define PAD_DS_TUNE      0x188
 #define PAD_CMD_TUNE     0x18c
 #define EMMC51_CFG0	 0x204
@@ -449,6 +451,7 @@ struct mtk_mmc_compatible {
 	bool use_internal_cd;
 	bool support_new_tx;
 	bool support_new_rx;
+	bool mips_mt762x;
 };
 
 struct msdc_tune_para {
@@ -595,6 +598,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
 	.enhance_rx = false,
 	.support_cmd23 = false,
 	.use_internal_cd = true,
+	.mips_mt762x = true,
 };
 
 static const struct mtk_mmc_compatible mt7622_compat = {
@@ -1090,7 +1094,12 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
 	 * tune result of hs200/200Mhz is not suitable for 50Mhz
 	 */
-	if (mmc->actual_clock <= 52000000) {
+	if (host->dev_comp->mips_mt762x &&
+	    mmc->actual_clock > 25000000) {
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
+	} else if (mmc->actual_clock <= 52000000) {
 		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
 		if (host->top_base) {
 			writel(host->def_tune_para.emmc_top_control,
@@ -2028,6 +2037,13 @@ static void msdc_init_hw(struct msdc_host *host)
 				     MSDC_PAD_TUNE_RXDLYSEL);
 	}
 
+	if (host->dev_comp->mips_mt762x) {
+		/* Set default tuning parameters */
+		writel(0x84101010, host->base + tune_reg);
+		writel(0x10101010, host->base + MSDC_DAT_RDDLY0);
+		writel(0x10101010, host->base + MSDC_DAT_RDDLY1);
+	}
+
 	if (mmc->caps2 & MMC_CAP2_NO_SDIO) {
 		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
 		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-- 
2.50.0

