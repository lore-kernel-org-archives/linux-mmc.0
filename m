Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5739902D;
	Thu, 25 Jun 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385047; cv=fail; b=JZfw9LCejzAkJcS0woJ2KO/V1kV9puYG0psGhVSHsWVzU5Di1cFmZZGA32KC0DY3RHcLzncZQ/ZsAdQwgFv8gwnVfmYkAyaTTc0Vd+sg4rgkD1jgNGmnshBTClLCbtFzaSSpS7R0n0Ns5YjpbFowGFhUr9c4NXVkFJ93PmVGxlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385047; c=relaxed/simple;
	bh=ZfU+ycWFiZXhrtFUX2BYCsNjw24il/VxtpWNExlAhXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6OvYk/+n4t4wjrK1bf9RsuuHaKjzoafxj64eY/wF6G8iAbg8//zm45n/MV1voh/gTQvYLrcJQxHh4LKRQnyL8WyF5816h4YqJHdZYdC8B+fTyLNhXmJp9n2hStrxJ3NWrFo5BCEjGWXXDeWYiRltlvc/RaQ6kPxAl02t4xMVXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZhUA6Mkm; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZhUA6Mkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9t2n4rqiBwcg8wt+nnNekmzd2r94vL8KckPtEBfmzHRVB67SN7dF8dXhRvtE8vuzl7JSyf2ZW8cCuDkvhKmTJExhogbAJ0cQCYG2AqrenxQ8e00oqXX/pcbeJqlQSURXWVRDD56wC4nbBDs/SoC2VzYXk/mG7y1xOl74pGIJQAphi6n/VU7K46lhU91a+A9GcjPc9h5jpH1zxVTMcskgSIxnzVpZqrnRzKgp6c2/RGXH6o1bWCuZbDxUvGTgHL2r1CRo1iHsTIj4czh4AFzWFfvPnJ4z4s43wbGjS80CnhGSwcLVymvFnVn34FbrShkZIcfh2Z8bpNkuWflHRzWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvCVhIXSPdhQS3gNBSZAZW93rNOBLcYbEbMhqMfD98E=;
 b=vkSX1ASYWyV469/KC08xVRzFyRFoCOt9J6e1ZCS2W/E8wt4ePAmsBfQsWqt+ZszM2/IxLy9IyRjBnudRj1ErLWoasXFDzhF+f3Qz6QbyWxZtbS/ZPMntUHQpjchRx10925gKlenLDr8ga7dTtch63r9YtQOrganFrItx7MHEeyPjpR7ZMDaQ3mdYY6JWaHzuM0+tL2H0N89aSqxZQ9CP6MnJLSE6F1DRh/T3Yc7WHwumLgFkPhy+BxJVnfrNgi4YQwHIEzgMU/SYIzFIdnJWVOPvgDC5FBGBeFD3oUgnXnnYXfLmBUBQQ7HxlAsgFOSCdxHVCLoBxbqeLqMHaEZYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvCVhIXSPdhQS3gNBSZAZW93rNOBLcYbEbMhqMfD98E=;
 b=ZhUA6Mkm1ot01jOK+q9CN7S9hOAlSzChls6euaP8W3ZBFsXfBbdWo5/U2Rj9CadHO1MVDYyqFplTlAFm8L7cTp3n1tJGlSLrhiGsC3d+ZbzqGgo3RtUiQ7p2YNWW3c3hO4MR5nmE+26v1AtHDI2FO4JOGyRwK7uT8eA7o1vdlzpa07Ae36F2PACDNX8Db3Zrspe8ui7UMfzqVjYuNQOJxBb5nr239wD3v9zFyzTUtI12ruDMA1EolNIjieAm3EKDD31jLwCtjCm4myeEf+LE/enHixBjZhSl7MCRoz1KAZrWgx8SMLdQNtyY3EF8FJAfI7z1+PR3P2hk/EZhk9F+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 10:57:20 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:20 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Thu, 25 Jun 2026 18:59:31 +0800
Message-Id: <20260625105934.2890635-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: b23761bc-253a-4161-364e-08ded2a88795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|3023799007|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IMmLgi7/6C6KiFDTTHDcUsGlKDC3wil7gvMlMlJUZtU7FNKkI7fbQ0UKSSqqS76JLlA/NyT+ww43zjjT2zvVki+SBsKgnOtmBqrwP796Gjr1YHInTMNCqB2lq3EYN9hA5OfDay7Fvmmm3TXUi+iAzKcxezwO8QfUlCxWEvqm3ghvbuLzVTiHsB+58Hblnb7hNN2PZAr9ku5VgBLwbOpiEIXi3Wy5F+RZ4VC1AI+VilLdEZI12tiYHQujLxPq7JdHa6bfbhROR8lps4ZfKDd0qSfSoD6O9bJebJvjupcZ5S7LHjtqQw9adVDLXL3H/EOFB6Map8r2qmzgB+mnDO056JPlT2S67HSYgtw3FHR2bMH7lt0YCZWdPc9f1p65XIcw+ZVJX3mxHXnVJWLPGmZfhxYzJLXN7qNEH97vRTDtCDUvPvZpfWIUdfVkhZ0d82RayG0gzzGMCUk4KxpPu+fDAAVJSxkCxKcfU5sGWb8o+BcywtuSl9mRsV7/QGEmuJWQgAmJvhcAbxGcBEt6SaSrtBTrK7ainrTYhb0FGvdigifUJJ2qXqPdUheMRqDL6wacunWgZKAllTrBXP7CO8b/4a4fYFjRVtf9deEVzVzfB9SbSW+bdd2FrTPWKcSjX68vzGiyT9RGaC1EK25amv+d5t4bksf6NUcUCNlUPypCa3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(3023799007)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JS+fvg3O3ye5gDxbNI8n1nSAhs75saNPv2apIjen8SNU4AXtQLwd+7PsI7zj?=
 =?us-ascii?Q?XqQhh0moRSnjqhsN+j/GnCzahui98v2ccTMg8tTtwXLLZsmOZFCWDTmGhlTP?=
 =?us-ascii?Q?f3uroCr+Kjdmlmy22EEBvsFafRTx2st4ojSKPpKhLTe11rL1WWyO7B95z4Mq?=
 =?us-ascii?Q?amzDAeNDM/eNPmBlDax+8RO70dB4qKBObxwrrYTdbeSYB+tPFIPLnEe64o0e?=
 =?us-ascii?Q?DakCXLab96kTeKsK+oohtg06AE8css2QkgN5FP4ZgCLGeZ+hWI5jeIXLup9p?=
 =?us-ascii?Q?VhXsOoC/S9MqWpPU8CumbqqSD8eX41xKE5FYDg9CeCcduoHEG+XPzYQDowrJ?=
 =?us-ascii?Q?5Ij3pR3Jg7Ci+vvR+xujZxamURK55IxOYGNMHLupD1z3CQBTeDncMvdx8rgl?=
 =?us-ascii?Q?0ci41kt6PHY768ZS7HO5Dyn4SOGSi5/n6cbFgwOXECz5dmacimk7QLYOwyu+?=
 =?us-ascii?Q?5v2AhjaiMs/LMQcJNNV22CWH8lj4dXgTQkxeu/+cSSaD9uKpEps97YouAvik?=
 =?us-ascii?Q?Lbi+mT+B7mZ+VPaJrgANHHPfRRVXPR8EC7Tnmj17oMNBJlKYimMPM6Xj+QRY?=
 =?us-ascii?Q?rbElqE4GTw/9voBLQc1MMw8TzD/KIcxcLN02+1VY1VYsFYQuquv0zlFogQK1?=
 =?us-ascii?Q?TYYF6PiItM0LNXBJiCm2UhaktHtnE3kwW2Feo1DL3VLPU4KhykEb21gyC0i/?=
 =?us-ascii?Q?5tUYLg7eolpEpgzF71ZfojemGwpn4/sMllXMPE4SnfaYLlDXz0IrBS2f7xdq?=
 =?us-ascii?Q?1oSKgBp0R8AZ6CktKo9Su/N0xOF/dgYPidOsLilFB2IN5cg12AcV5hpXP8zL?=
 =?us-ascii?Q?Owqed+/oPtFovO380umbMeWYQPQd6RigKBwHJcA238FVZABGwSasGNSASbEf?=
 =?us-ascii?Q?wqJfCl5aNOztYiQIZQoncEVEa9vS5mQhwyT+ECbWZPth04z5NDBqKOy4TRdb?=
 =?us-ascii?Q?Hd5pCoGqCrx+MHKJrAHKknx5a/z7drnMekgwu/icXuqJE6BCFLxORiFslZO9?=
 =?us-ascii?Q?m4HrSqZiumTqCBConildybth2G946tCVyvgAkc4hzchiXnbwwsjhTbXwGMu9?=
 =?us-ascii?Q?HPMy4kx/svNVS16WRQ0ZhzC3fPxXGs0RHcfssR3qnmkksZtHM2qUEgdSl56N?=
 =?us-ascii?Q?EC1DfwjWC1nZy6BDM3SSCKK1dpOBo95+QdqW7BbYdFPNzX4yDnysTO6g+dav?=
 =?us-ascii?Q?DzqeTXOEPNTzTfr5UG/KNIBCwXlVkoQxI/1SVboPmB+QU8jPXtUazs+6NAJE?=
 =?us-ascii?Q?8qS0acm0vyYtbPcccJl5TU4XJngMsuFpcXL6nC/Ga4jfsmZWpTmP4Y7Lp8Ll?=
 =?us-ascii?Q?ZESa20Do/YLt1x90GFtjFcQwIFnzyCUXyFFG0HwQNOUPAKYarOjicEAZ1FW8?=
 =?us-ascii?Q?3OtS/GR49eZ6kCSDPWy8utOWs/Mh/5ENjF991wn3VqZ8OAXoYPQaoa9AebUd?=
 =?us-ascii?Q?hkY+U2+SQSRnRqiIE9md1NO7CVaDY8Z0ZAtj6Bnlo8vfHfQJABr2YWls5QcO?=
 =?us-ascii?Q?MrcsxJMJBdkDWePnS35qMxHdOQprwZTl8vyXLnXJe8U+9VVLhiyA0FT7IPRJ?=
 =?us-ascii?Q?A2REsOFXspU9v7S60npOX2iZA7y3ZZOQpjBrcMdTN1y/+GKVs7kWcgPJoMPY?=
 =?us-ascii?Q?ib0gbe+W9pSTCtNwrt8Br9FQoSqHHghvYzK0/95ch1CIHGLGVKbzclDJzyJN?=
 =?us-ascii?Q?Nxyo/KHL1nidKqTuSjyTxPuSzXqpA/dvSkcJWxfHMeLSFg7SMlTY651qihcO?=
 =?us-ascii?Q?FcHWrHJcI8Eof5L/mnxpF830/84KbSxDj0o9yNeTPK/FM6Bgh91n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23761bc-253a-4161-364e-08ded2a88795
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:20.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5UDnwwyv7dR6wbTz/QRQ4hOIrTMMUmqWDMazMhx32FvtYDFeGvLBl579lyw6OlUFqxiwK6Qg6Yr9NlvknsC/T4JpWJoq2oGRVZWWfe80D/6wLPZ5OJBlIOoXrwoK2ZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823

From: Luke Wang <ziniu.wang_1@nxp.com>

sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
writing zero. For SDIO devices that keep power during system suspend
and operate in DDR mode, the card remains in DDR timing while the host
DLL override configuration is lost.

Extract the DLL override setup from esdhc_set_uhs_signaling() into
a helper esdhc_set_dll_override(), and call it on the resume path
when the card kept power and is using a DDR timing mode.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
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

