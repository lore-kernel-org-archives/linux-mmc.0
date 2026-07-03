Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3463CD8D4;
	Fri,  3 Jul 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075184; cv=fail; b=FLbtta4WsfD2/p4L4Pmfo++EOqd9OK+iXBTItKaMBJnDumkwe/8/bfmEkdlCahBJXo40oPnuF2W5dImqoSIAcKVSUHghUhPJFxVSgVtZ8rbO2dDQsrw5ZT5D63SlICYv+t1BIIcX5glSW6U5DNnaChLy+BDeGsPybgq/2/O36bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075184; c=relaxed/simple;
	bh=3ifrpah3ltd+VEFnCVlfOxLHaE4FDvROd3IUife4fc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwhIx39Zo7Ftt4Nld0WnAuKcIEvBkGngc3UW2uCNhwzikKRip7F59nVo62Z2Auv1UHFQZjkg872sAYvGKFFHqLw5qQZhDRZ48/uHSOocVUKD75RVt1maLgNQ9XKZIvHpn+UqgjrgUMVs1Q6bEuc0bmeGoPvquJFlGpZFxS3/mI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cOJAD55J; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cOJAD55J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knfLdwIFwbejHSmkYczOPNYkWHAhHsbmVW0myy/hH/txZ2nlp+lLaKfKz1hTJU4c72NRB/Ks4aNBAy+u+sMsnCoLf4dgbFUaTsT9oPwlE5JiEV1f1nEDTlsHWH0sf4CUTuKTEEctqFvYLAJgT/lZi2OszcfGjQbmGyk/6sH2glTnT219y3KwvNOB33D2KMsrxxuKcoTWMHpe0nhwP/RprywkmaRRKsH2HxA7ey3fKEXead1cfHXbHepkethPlbjDnWIR9bv4+kOrd6iM8hHRP7nUz7KAJ8UoHYHtIybg8aDn2em68sNZ9WgKrYOcbmPZ9PKK5O7AiVOC9Rn+JEOp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeKN9v54zOc/H6u1MZT+w32i6VrqdvMyckpkAQOsvmc=;
 b=F6aR2C61rlwMbZgR0WYc6GyxSImOoWJ94RK280MVs/f88mrkFqgolbFAzjPK14Z4Q4V/e/dp6Rs9ijmRK1HN4TVc5701vQ+B/LWkHv61P3eswOv2GfEU/Mbv1Bfg/NLhAsIveheKah28CGDhUQie9cnn+BLC1Dsq0MwyWsgEvX2O890Irx2Vgq4yixljQiAbaJmkv/oj2wTBlid8WnaGuzml3oIbVc7A0Hqwi/H1zeeKsNA6zMHWIQpaViJrl0D3oEgMHPv/aGOoU/cxAdHckWWPuBwa+3AHFE8/VjSKrJFQcULt/Q8JfDwDOcbOD5fHSdkOxoOTbj0s5g96giI0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeKN9v54zOc/H6u1MZT+w32i6VrqdvMyckpkAQOsvmc=;
 b=cOJAD55JqN2AXVZT8PzhXrafQxj0H+SWe+KiQrhFNRT5qWSswi7iW3N4R5vqQ/NfPF0fkXddednh0d2j/ls/w97u41mPhNsHf1tdF82m+gh6k1y2X52ifqByqIN8qlmWdUp09+bSQXBxlLZ8fKenawEgHTW7z7Uf7DpdLD5Cfs7+lib4g3KEqsrjprGqvE/dRI7/4Iks7oavzXUKHZSH93ypcl4p3M0EHX7k1LxCbB32244crR0JdR8WikHcYSuVNoWPUeiP5wee+uSx+sg0iGRPRGPHnLn5h1JVBBCK3kEhwVd73iomIcBkqQhoXrlLEqOgiHwhYpI+aMUJt4auIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:39:40 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:39:40 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
Date: Fri,  3 Jul 2026 18:42:02 +0800
Message-Id: <20260703104208.3426374-2-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::16) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: 855401fe-750a-4bc2-eabb-08ded8ef62cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gviJUE6k20OadvYHkyn77c9jNXxBleCREIEwFNf7zi3gqbjRvPpeFLCexvnJfVuPUQduFOLxOb1dF+gqxf8eElhRv4B4qgOoiPkReEdZjXS8kAaJFmyouLdm0YCcrjMPiujNKPI3rqSA4D+DvPEFFkMM/iKq6Q4WtxgJJobEVD1XoLH/OjVMWX5a1h7KTyKzTBy36MMRqmvWU1nkS1qFO/pDTgCZF4+8gmwnz0QixbPxPlNRzcuR7FLa0NflBihyHJ5Dm9Uaw5XoT45CAdweYBl/EM8R7l32Io4THDcGLjLVM7/pXx0yiU5e2UlrO23E8ZGmtQrGJ+QcihmRfwPjDbkneiQFSY42nluiOZ2KIc3iwSKAN0wzyhIH3M9jCcQgbIN1BXFjWv06ElrEHPA7bi3bkpAd08edeVBKR0WDrfcJNfiRCs6/t5gg/GFQCkJW6Tg8NSpXtzib2g3IfNK6I/NaBfLn1PzuJC5Q8ZtC9VeceCygUe3HiRLVHZmBLCFT3ek+bqape9+yrRu+nmErSKhkKbLVdiRCPdBhK9ESjWpOMmWqwBR3ChBWaHrgyQAQW030d2m66MPa2aiXgFashVLl/BV13gt7+vUaoBz8VF1ZQeGhoPXwvaVPMbePszNYYtCG7W2UpF1/BAJ5M5QAkbrvcdVCOjy2W7lsLBXXVtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ICQL3RDI8FJLkXHrI6crMs+5xUU9LPiXeXCWGdGZNR7/Bbq5Uo3ld7EfIwb?=
 =?us-ascii?Q?svJTANE2SHt3bYZE2AlhTP+Orm9b0WFiZsBI+DVLlvfww06kE3j/gTKOT5t+?=
 =?us-ascii?Q?0fFwDNkMbKpVX9PtgSiHw77PDQaVRSUpsn/pOIKtKppK3Ak4qRQmvrjKuMnR?=
 =?us-ascii?Q?yD3R2BbjBahLGyXoccmRnkOX1WjcHxF4XO+UwHjBO7+qlmOEE55tSyN3Bw11?=
 =?us-ascii?Q?mNxyVOfsccm8YR+vNaUZ5WnXmiBEOZO0mOtWgtQgPhkEmz7h90uvoL3zkwCo?=
 =?us-ascii?Q?wG21LJYdWYEuEEXbqGbrFwLrHpm4hrJJJZCCFT3sFjCIPsT9ZiHPBmUx1i+1?=
 =?us-ascii?Q?fu2qqVsEBT8819Rz2QureRO18PCF6JHOtzz1Y/etk6QWiSlCXewuX76HrNOC?=
 =?us-ascii?Q?REXIJwNT1WyNGy4RvEWPH5n68IeqaGCtj6txxms3OnFcCK92WjySlBGisj6P?=
 =?us-ascii?Q?X3auRzLzEN4Jb5sVELeAKItkaxlSXqyofuIo3oCg1fcAjnLtYiZTkhmVP2jq?=
 =?us-ascii?Q?SaMwmoDoEhmjKtwTv/VcLknxsvYU+8NnAUhMn0uJz+rKSj+cG6/+nMIFcnt5?=
 =?us-ascii?Q?kqCCVTJR6q+Y6m2bCTYoT72aQqB7LkhXewo2kSNU4ygXhEkxRiMT2o86IgC9?=
 =?us-ascii?Q?S330KRoPfxX1STPy7qYNrquJCqKQ7SJHbxxjkRSEkxdEJWkgfXmmhTbptmL0?=
 =?us-ascii?Q?LdyknGlHS8UUeo/IQeSmsc1TCWy2lwn0C+44qOF8FpcOBqlTRoB8c/OzUCGT?=
 =?us-ascii?Q?/QLrRzdd41B9Dp1cTFq6NYa2oDE14u4clZJW//1mT5IfT9P+w+kdUZFm78aJ?=
 =?us-ascii?Q?iFoID8fiPL63vaYg8EcOH1isMK4M5gj8C6E7H9kGaRNmsy156bcf67yvy3tj?=
 =?us-ascii?Q?qp7jY3vaCOSTwhKYbbTbrC1wM8s8SJQUGHWirIO86w2UtYvhgFEGLYji/VLy?=
 =?us-ascii?Q?hPVBIoEdYYYgkKbgJUhpwh1sUYP9MZlshgrJpVxUA+AfoNouUPYgBqQJ9QRC?=
 =?us-ascii?Q?tvpfGe/ObEbYm9rK5DeDFo/v1Y1HLQj/ziPOTY4oNpRQn8/yIgrgBS3CzGll?=
 =?us-ascii?Q?yb1qhkLJTqfD+ggaIXcXf3tMUl3SqbJP4/N2YSdNhxYIvNXjPDALXBL0V4q9?=
 =?us-ascii?Q?CaNFXfa0xa0LhMVRvERpGZm/bjceocXD4VpGKUirWwI7foKMIswdZ3a18/JD?=
 =?us-ascii?Q?v1XJTPgwf1/4IBe51jr1+jOo3XHGf21/bAwgu8DtZor6wZFhtUn1cD7hxwDY?=
 =?us-ascii?Q?KvXjJYwfZxL/4ZIHRtX7Z/2y1/e/g832v2WVwPA29IKkvSahESzwsFgH22i3?=
 =?us-ascii?Q?KQDja7Qo9FTMCld73eei4qI03gSqvzAHGPNG81P+Pza9Mumw52yXhTgBqYAH?=
 =?us-ascii?Q?sK8U9gQCY91mCYz1PfdsFVjSS2pGgBSUrNBpDEW1Vfx0djpgxA/Gg2RHazQa?=
 =?us-ascii?Q?hlUue/FCycgnXMvHyXln2ddL1/oxSL6YRdNrztfR3Nms1Z9Ew5wFb0rNpHeo?=
 =?us-ascii?Q?TjzlIJ7DEv/LhpJ8InSVaylVwiwc348o8z320IG8eyYsNRrDl5nucN6EAQeL?=
 =?us-ascii?Q?O9YYs57FV6InL7zfEmgjaLTJ2sngmrWB4sB7b50k8PvQsSfDQFuKYaohftaG?=
 =?us-ascii?Q?5WmTx4DeycGLbPdkqeP5Y9BnH78h0pWvvpECyaCiDvvJtZrvyOXcAnKCrpiv?=
 =?us-ascii?Q?dEDUSg443tm6lJXizuu2TGv3Z9CO88yRNLyiyitWEuClCjJY+I4UpMM83J38?=
 =?us-ascii?Q?+NdtRF39Cb+mLyW/xTdZVBe/SUFl5S2GFfloDpEIyaoLwQepg5sd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855401fe-750a-4bc2-eabb-08ded8ef62cb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:39:40.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRuogDyOEFt9Yv2jJS4Vq1SBirPs3dMsbwI94pz29euyAblURiiIG9X4NwnSLN4CdNLPxV/c/rZb7zDz7Tu899SIydxu8P/EmhKPqFraQ1X7f5terAldEI70P2OJshOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

From: Luke Wang <ziniu.wang_1@nxp.com>

The tuning save/restore during system PM is conditioned on
mmc_card_wake_sdio_irq(), but this check is unrelated to whether
tuning values need to be preserved. The actual requirement is that
the card keeps power during suspend and the controller is a uSDHC.

SDIO devices using out-of-band GPIO wakeup maintain power during
suspend but do not set the SDIO IRQ wake flag. In this case the
tuning delay values are not saved/restored.

Remove the unnecessary mmc_card_wake_sdio_irq() condition from both
the suspend save and resume restore paths.

Fixes: c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 18ecddd6df6f..6526d65538de 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2064,8 +2064,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 * to save the tuning delay value just in case the usdhc
 	 * lost power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
-	    esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
 	if (device_may_wakeup(dev)) {
@@ -2124,8 +2123,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 	 * restore the saved tuning delay value for the device which keep
 	 * power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
-	    esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_restore(host);
 
 	pm_runtime_put_autosuspend(dev);
-- 
2.34.1

