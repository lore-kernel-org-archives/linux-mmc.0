Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4740314E;
	Mon, 29 Jun 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724663; cv=fail; b=iJ8EsRAlE/tIdnqav1hc+Rfwr4q4Q4g5ojYxpErLiPjS778bxqD3B8cqUEK9VhLVEJBHoiJZWFEHsCU/xwtHYK405uZiD9b61Xh/86SoEPGLiqFsNjgxcfe7I9H2e/0RKlZW20q+xKPfMJai7xGyTiIYesvne7szJ5HykgLV86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724663; c=relaxed/simple;
	bh=MRUfthbhkti79at/SdgMliqZnHTmlIlzpRZQkNcWp+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c69McYsHq5/ZAttMUXdcuiDCXSXvrbdx7fGDwxa22OExBErUZ/qrBf/7D9Cb1MAbOeLAnk2mt/5i/o1uKBVDQkC/4ylgdPJ1uwXX0hiSxXnQomTyGTN2hUY5EXy0RRu+3Nv4HB96LQbTM5ua4Y01H3OTjc6bImnJXpf3XqMw6E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HXZaaQNJ; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HXZaaQNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPPEDyZA3ekQG7E0u+WQS2ls0pH5pEOCtXmBU3u7VWbS4jOfWVqhbGA97aEY7VzZ/koPpOgD/ZtVNiIzU7f2rhgvBSYcCaRZStYiu5ZtFOBInA7MyoRVK3DWJxt/7yxp70JM/yFA7h3kdC2EclyWdvYPz1Q3vod1mSbyiZtALoRKjQnA8RruYRoqs3W/rS1LOkavq5ZATU7dtInmWbqoj2/avJ4U8w5NinwSi9IU4wBs0GpS4kXzxzAuoLD8VqBDmd0+C7MZkf0A+jIZUxDgryaX8D/D2ciGrNnnunhdBsqx3vKKFoJ0Z767oBZgFuF98tZJOIAvUjwjYpVIeRndsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz3cNj/Hbo/HbJQImQ/mYKgy33GPcnhTB8p9Oa3+Ah8=;
 b=r/5lveA57598IJYaAgVmJp8yNeuNwk790GbB2bJPev2SLnDFx5nlx5OeK5VpGzpbRd5DafM1+3iWm0nk3x8tmk8a7nZZaaBah//eKZsfe2xGmPlm/RZIBOPuvxVGJhyEDWwP8/EoA9TNsZ8/cmHSjV7/f3CbQgjRgwt6zSuLEH+EfufciGjJsJ2vRgH57AahCxVbTZ4qOLCpQHOU/7ZhhckAwqUNfQpte3E79dK/IfJWAViTtLohcSxzTPxqY+vzd9L9jErA/mEHKH4R/ZWP3DSUutO3DjVHQZODHT1sJOsn/lyHImzHnv3XANZjtpvchb0aGTz9/qjQSxf6A2lkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3cNj/Hbo/HbJQImQ/mYKgy33GPcnhTB8p9Oa3+Ah8=;
 b=HXZaaQNJrfO0igt8yhpo6D9jB/mY6hF6BqGQ+NmJy45eLo49d0PMon6CFewRttmeZ2hDav/zJnrjdQEhizy80SuPsIe/I4UP8tRl7jX+APGC6f9anXhbIXG2oj7yYREvCsDy9AENgRq11NMcU4vVlTma53UM05WNRgk85mcNKGaDj0a+P/eMN/We1iKUSg62snos0SdOFY8F8yvj5xswDVcKfVkm3JxYw1SquPiu0WvzY8NTSbsztePKH9klvWYgyb6Vz6JCDTCadXg8D+d+xVGPQuba6VAs5wccPPyFMnwLXREp7nslB8G8H/wX8QorOjF04b9szTlQIFOerjINbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:36 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:36 +0000
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
Subject: [PATCH v3 2/7] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Mon, 29 Jun 2026 17:19:49 +0800
Message-Id: <20260629091954.3227151-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: c33c6b8f-b44b-49fc-4520-08ded5bf42ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|3023799007|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/zOp6IiK5MMXlQmk7v/qNlARqvSdlOP32Et+DHdSJffL5POIvW94zjBS8/4hzbBBDG/qA8dZhjqeMH3KUak92PK6IArUmboHHC0Ieb3BJL4EkOT6vYPOYJyymCCXKhp+715Mznp6SfJ6f0VQjgoiA9AU76dYnI82x9LAgT+uem/o5cyyWbZ8UGpoMq1j4wITU1ofT7PC3luDzOvXJldY52uJMM8sAfubmoyeJZaQww+D90wpwsPp3wnxfE68uQcNTmV973seECijRLsC8+XPTUfsvC3PpFzhPfeeqOZHQaYJWM84vqq7o0R4hhp2oR84E1F6bH2Lxsa+1uQlg7BTg3vBkvrKXiove3N++xkq7uEPOr/w4n7W3hcLvj0X7P5KW+UU4pKLdkbKR/PnGn4XUQUFd87kMtBD72NjFc/jYvF8qakjTYjVsO7AIFDigdFzDg12LF31k1CQAGvurrcXFI5Nile5FyrjDLTZZe6bDkLJdfsPnxUOai2nJsqH0dJ8stZvQWbBSfbZH4Ra6qEn38scBNwyfqUM5n/seLS3lua4v5JXHlR9GMOgMdNPPJ9ilu/1DvG1C5QMnYM3QFFp1iKSSw0921E5fWX+l5i0jlT28KEedc+2fgnNmzSsGsnwB9QXsivGg+3vqpr/VVeWdwsqD6xOAqUsmmDXKUvrAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(3023799007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZRrj796PMX6/EYnf5VEwpeB4JlOWi0dp/+TeTUDxEjpLVVslvoV7gSyBrP8?=
 =?us-ascii?Q?XZeEgMUk1APe9BQ2RCJIGM1i8A7B0iRkBLftdDCTgg4UeJmNLySPpCbXdD47?=
 =?us-ascii?Q?rWfg4yhOTcPMDi9vetCXmiuaNtvv6rrNUxIv5bncONPfny8Kkc0OwGTxa76l?=
 =?us-ascii?Q?ixfAW8N88B+avcUL/uz5mGEc94/IJ7Ow0+T1ifmYL3hDDhrLS4hiqQUTxIpK?=
 =?us-ascii?Q?tvneYopdjyYUTNABTxxDsYJ9na8GInafl2DLqayhdw+BmzxU2lfaVe90XIZ5?=
 =?us-ascii?Q?yd18FuNjtqQc7gBz8RD0lyXpQDHbKJFsFodqoiZmzv6LHIxwnQp67sRwpk8W?=
 =?us-ascii?Q?eWIm5JZPSpsJZbcay/0ajrRuj0F1od0CBGlafA5PuH0mjkMi69KYpls3czJ4?=
 =?us-ascii?Q?B9OJX5pOrd4QFK49FDEa7KGPgBU42S8q7JvYcE1Da7fIWF4KJYYpMgmfYTU+?=
 =?us-ascii?Q?Yrv19b//GQeWnG7KJ1B2eyPf+Lhucl+umUffVHuR0pr2AszOBOSvg5uOSVco?=
 =?us-ascii?Q?DuFbf5midmD4zekzHtS+KJyQsbgIOsa/DZq3pz7ptr1OGC8L7SMsrIn1pP/t?=
 =?us-ascii?Q?8wJPkT4GJP4JxqgBPAUidpSPngxLwfTHl1I+GGRe2qRTHWxlCmY9TljtJK3N?=
 =?us-ascii?Q?7oldgr8ZJrscLTTufaVIMHxeUs+GN87Ns4NUQBW6OWYyh9Ag5L+puLW6v2vK?=
 =?us-ascii?Q?Vn9SIu/WA1u6xMz6hFno7lFi396DHeQARHOfD5D/UPjeSyEH9AbAhi7fEBLq?=
 =?us-ascii?Q?8GCEzCp5C0eH2sw7TmmxxnbFp/O8KPcHWb7fZPS+/j62PSsxQ3bnrTpV2yBV?=
 =?us-ascii?Q?/gI3Hqdw9H8yggntPgO9AuG11Rz/dzNtpRXdWRKLX+7yJ5xweeha2Fd7S0CD?=
 =?us-ascii?Q?vULv6y5dqSR4i18j5NvI52iE1vfoWZwhMzT4bHiL1obCXNnY+KxU9A453tqI?=
 =?us-ascii?Q?F6q7CwPYqQpgNJKa74S5lvaLe/+s7Xdl/JiLssD6PkFUOSo9tlqwAdAi7PIw?=
 =?us-ascii?Q?9laKm004LBVLwQ4G0Kw6ZJdvWgHBgO8654O+jD0fe4/hvtK9K8XeAQGlBn4o?=
 =?us-ascii?Q?XTqno/Ubkb+SkkQ9EGmeBOkmFXxGB+3bW5qqo6ind8IeivERbTr8QVHCOpO3?=
 =?us-ascii?Q?UfMm6GTcbp5w21dHzYJlP+TGczMZKI58wXV51S7A7WA3wtkRulOHwdDOHLhd?=
 =?us-ascii?Q?uCEE4xZTpR09IDUy0MZ2JwbDkR9gdbl+9iZusINg4Y8nIu9K04tGmpJ2fJ87?=
 =?us-ascii?Q?EkPxUwk8NNmNnGYSNZgAOpS4W2FtZieSoa7cEystYdTe3tRXaQXyObgbrfbw?=
 =?us-ascii?Q?Ba3kbeMqnd6+B5jhor8tGRhC5zrw4355u8vZwRec308DSAIULXnuaxXNr7C/?=
 =?us-ascii?Q?1aauQ7qKt4f0eT8SjKgBaX45La7/NwpTFaEtF1rRINnE2iuOYnRS7sjGRGHx?=
 =?us-ascii?Q?ObEOQZvKO9nfblWiWpYyv6SPjKsEYNeslZv/x41McPlaxot5tYgvZCVc0nPL?=
 =?us-ascii?Q?rj0s/KOKYWFO4gnLdzQ2htw5gUxye1CSDg/mQfkMiTIwByptFTUWRcyvqbaJ?=
 =?us-ascii?Q?QiBiCzEReWymMBhdtgMw+3W8KUmzi6lkARHXMLYGIhFT8QxMomlxGdz6jonm?=
 =?us-ascii?Q?hu7sTfV0HhuIYLRqaIKYznIoMRFQbPmG7z75i9trX8cy/UXr30vdqBQ1L1Xy?=
 =?us-ascii?Q?45oA3YSQDKqW47NoRHXc9TdFgidNZTFFi2YPoufJq/4Z1i7EnwfUD/cqApls?=
 =?us-ascii?Q?Bv+DcQJ8H8K+JusBATooHPCKGj/qJ+DOIx3mEeNYojogL5Cr+lik?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33c6b8f-b44b-49fc-4520-08ded5bf42ad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:36.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8fJX00tloxs+XOZNNyHr77l1VNVCyid7jgnHRKOiZGrLsxhnVtcF/K2NZLYaqdnbJDt53muvKSqRxnmrdvSXjvjm+ZjNwMOrJYYi6tJjdFKTrEF1vSvXE6wxzvY2uE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

From: Luke Wang <ziniu.wang_1@nxp.com>

sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
writing zero. For SDIO devices that keep power during system suspend
and operate in DDR mode, the card remains in DDR timing while the host
DLL override configuration is lost.

Extract the DLL override setup from esdhc_set_uhs_signaling() into
a helper esdhc_set_dll_override(), and call it on the resume path
when the card kept power and is using a DDR timing mode.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6526d65538de..a944351dbcdf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1349,6 +1349,23 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
+static void esdhc_set_dll_override(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+	u32 v;
+
+	if (!boarddata->delay_line)
+		return;
+
+	v = boarddata->delay_line << ESDHC_DLL_OVERRIDE_VAL_SHIFT |
+	    (1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
+	if (is_imx53_esdhc(imx_data))
+		v <<= 1;
+	writel(v, host->ioaddr + ESDHC_DLL_CTRL);
+}
+
 /*
  * For HS400 eMMC, there is a data_strobe line. This signal is generated
  * by the device and used for data output and CRC status response output
@@ -1425,15 +1442,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		m |= ESDHC_MIX_CTRL_DDREN;
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
-		if (boarddata->delay_line) {
-			u32 v;
-			v = boarddata->delay_line <<
-				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
-				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
-			if (is_imx53_esdhc(imx_data))
-				v <<= 1;
-			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
-		}
+		esdhc_set_dll_override(host);
 		break;
 	case MMC_TIMING_MMC_HS400:
 		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
@@ -2123,9 +2132,18 @@ static int sdhci_esdhc_resume(struct device *dev)
 	 * restore the saved tuning delay value for the device which keep
 	 * power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data)) {
 		sdhc_esdhc_tuning_restore(host);
 
+		/*
+		 * Restore DLL override for DDR modes. hwinit unconditionally
+		 * clears ESDHC_DLL_CTRL, but the card is still in DDR mode.
+		 */
+		if (host->timing == MMC_TIMING_UHS_DDR50 ||
+		    host->timing == MMC_TIMING_MMC_DDR52)
+			esdhc_set_dll_override(host);
+	}
+
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
-- 
2.34.1

