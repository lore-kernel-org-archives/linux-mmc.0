Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7B3BFE3B;
	Wed, 15 Jul 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099770; cv=fail; b=rL0ha4jY46fse9IyrwitRF1i+GYwYMNWgx3eSR+KPgfLT/Lq7/0nysDJdj9UAjlDehnzhFFC7f2x9kHalrNbvkQ0rid0o5uO831Aj9mKp9xcRhYziIhCObg8I2jtOUn1J9WCuooR5bXSI06W5KjpLakPX9IxXHJLMtc9tT3RysM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099770; c=relaxed/simple;
	bh=2OEDquF6HEXP0sxB0+sQAR8bFLwCWTw51d9L/0BGlEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRBCAb4rip3dj/UmFDWra9KZRComrlnHTMX/T7uqROZRWPmFBXGn1KrYqRuQODXOX+V4H1qRIlHmuf/Znk7LgUbDztkioxWBSF4k9LYPfj2GM6Xx0Hks8wVytK6tH6iwbT4UclXQ9G+RR+ykDyB8bA33Xvo5t74fFNEbirK9LQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ujghetku; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ujghetku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZzZ4bsp64snUhtWttIycVYUgAHmvDARRYg4B7brcJhIHTGhWPaH40PwSFOQrTm0cwoY26d67RQgn4lDTnhAbzoOP6W0VgZiFvOWha3wWX/3Dc7v9M2KPrXkYDihJjSiHhRQ5/+VLJaNuVHuQBT9NrguuVvFPkc7WKjrsTxkafdNFdu9IqzsyizReKVknFcqHZsGTscDuAlG//5pfR/GHKQ4gWnQAViFuxkPg3jN9qdYtjJ8oy5Gytar/dnTEDaU2nOwiG3HACrfvBX+JJW40XVLxrTtYg1jMdkzgOBpyfkh8M0li0/MOtkIrikkLCQY59JYc0/Y934Yt8HEES91zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=NRHfVifnATCk627HMr1B39TwdO+tHdVsNw8FTRMdktbSh3GEpFGOCEo6uxXL3LCgnRSx9oRQn69FiGMeYKZenfmATet1DRffAT+ZrMmwdXXK8fbrkQy+edZiNXZcUaD5XbuIrJ6X/yIZHkoZAdVqZM8d2v33dfk2AthBOP2LszxJGJWLzHzN+2CIVRPYDsnX8mnZNLZxn0vV7zrPuultoWrvOK7wCtw3/0vw1yFad3aR9ARAXXM/8epKblqiIPUSCMQLSwF5nKoSPrrHlMF1zMvJPIi5bkAJNGm/KhcEHvCgHsgGnSyFq22C1DOdsdCwFu2T3rKvFS7DPE4eNG/Mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=Ujghetkub2iULt+rgonJg1vUYpjaftzZvscG+yDszTJD9PrWnKjydegq2UmbnvnNE4qqGCKfdcxyEL5UckyEsVHvI5/VZpQN9cmEAGNUBoPFga53H4oLagjUZGKZCEsO1wQUYKuXydY1TbXTwZBwOwWYAeu5/JJlawME2G/bpoXBgs5ovFO7ZhPpMOjL18sh6X+au7r/9OlcqTLDfn1f55oZ/O+DuMvzkhm3obM+lLpWz7u8qBsMT+Z4sfZ1/0+GIEuFr9Kq2OB6y3Lq63jTXBY/TjdEJKEuiMcquZ/jsaQ6naPcvErF43mXnk3we+oYogoPzzvEldIyIEWnKg1mPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by MI3PR04MB12681.eurprd04.prod.outlook.com (2603:10a6:290:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:16:06 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:06 +0000
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
Subject: [PATCH v7 2/8] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Wed, 15 Jul 2026 15:18:12 +0800
Message-Id: <20260715071818.272318-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|MI3PR04MB12681:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bdad59-6aad-4c5c-8137-08dee240eff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|3023799007|6133799003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	r8Ahgf1G/edNaDmIwyR37AqTvtSaWLw/8JLAw1IUWLK0odY0O8iFouVcPY0uv/2Hww+uPjOGugC3QalUIwTCtjcDsPI9GA8q8SJ1KCRyjP22RNGG45+TO19xmehPGyZeXTem8YcLfd4M7G2gm4h0CUHJERqFl6xyDmVoLqYnONV9qZcctnFRd13BeUx9pITobLkJobwT/JP4nNCxJUWNYchdlWkcWw5JMrQGbKkOqTd1houIW4NaEHMVEXygEIg3sFlOadO+suqBCl9rOlvhjAcR4nGSu0w65I8YPvdzm5uJpnUJfs/eaNk66lVWhEIYtOKqvAcjOKhaifdBQIdRuagMYnzarN2EmUK7BPR+YaS8Bt9QEYUOKIU/zoGo1RdGHdrg0RG1ntiFQx5y0VtG6QTz6jIWQAqlXlUIelcXOCpT6QVFOJLJp1G4qZrwSWz936Wb8bJNoA9vV3faSpnH5RSbeX45h+sNDLtO+jrey1K5GpOgn2B4C5ecxe6mXeJISLlQfUwl6eZhuqTL4uC9cx5fp6aYnK3x9V3swPdxWzZetaa86TjtLS/kIPc/cY9Pu+wfjAZmVvpVgvHRzpQYG33Q33TfsJH8mdvJjhGViq1+6H6deysfbTn8IbRbQWmerogh4vZVC8+U9uz7dN45XnS7lqYz6XT9qrOGG/a5xzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QipNbQpQKaYpNhMI9oN+SOUqJS4HeyckNerr3mPcVmQqaAXf2dAA57VIMl2n?=
 =?us-ascii?Q?9YvJRtTms3HPhgWOxmubUGNpghNZNO76OtOf0tJU/4DTsgbjyyJ5C3EFOjWo?=
 =?us-ascii?Q?IcEESV3Vw58SuI1cTnWcm5SFSbBgGmAewAyZ1XhAEZsaLnuMwXPyoLLWseoH?=
 =?us-ascii?Q?42wKm1SPcfIfXDrURkwmQWDKESNtfqaDr7hGFdPIaiU0swD29cpchTtwuiZe?=
 =?us-ascii?Q?HOCPEbyZxu7/Iw7KXKm628yZ5yevVE5rxSlS5OE0LTwlQc6E+Hw4jv7syLSH?=
 =?us-ascii?Q?LIhHH6Yp0dz18/G3cLmqc7z8nIAKECc018dduzi7Blx4ja588mU1FzlDg7J2?=
 =?us-ascii?Q?zcf3CjnGIRq7TQAQKszdGFxFLkw0PLiVejm1WOG2sthwr4NRz40eUu+Ph9ub?=
 =?us-ascii?Q?LhLU/HZHeLz/UM26jcy7IXkMiycA6Wd8pirdQBvtKqz2rOVxO3VB1bcM3w8W?=
 =?us-ascii?Q?PcNdoiuW7kDG8p9MT6wnhhy057281qDFRxNZeDYfKpCHadffAYi32jrv38kF?=
 =?us-ascii?Q?HEBsibRuIgrtjhbvy5dQbmG+mM1olpH3do4itqmSQv1UEnaN6RaQvcbVV5pI?=
 =?us-ascii?Q?KTL/MJmjPkqE25CzvOuisPEavKrpOdukcsxrdHfoGsItv985tbi3wDNZJ5UY?=
 =?us-ascii?Q?1OQJf9YXMzvCEMjotuE9fKpRTLDCVb6KngHiKIwqCygaRyUgyGFh4cwQEFMl?=
 =?us-ascii?Q?HINrHxuoRSVWBHlYpI2pQxxsVs/cB4kcDTAKkxGfqRV1cp/kQtaH+53pXTrF?=
 =?us-ascii?Q?zVNSPy1mBpEkq5N3r3KD3icGTJ9MfJtZYX5sYYIe8/0xsmdvG8S82WKZXn6n?=
 =?us-ascii?Q?EXAoF2yTp3bV4n4yqcjh97MJovxW65r80zQeoegUFI8ltk6Fx1bL+qqamchA?=
 =?us-ascii?Q?NT/7XHCEe6bo1MgomfFSNKsEVWoY3w8WmFSUVZHxLruXdJzyHNvUjx8i1cDH?=
 =?us-ascii?Q?j033NVbU91uWAB4tw54LD4axKiLmXpr8k2p59HcTykYHeaz6j4jwMXj3EX6P?=
 =?us-ascii?Q?S4ICOt4KWVMHGsmihtIItzQutSSL08FhIsIaqTy1P/EASoeqsjTfUa46QIeH?=
 =?us-ascii?Q?8Hnzcvx+AnQZuWgOTu2yORfXc0VH5j2e0CiAZONUy3IR9jHj+EmygobUwHet?=
 =?us-ascii?Q?E0mp3AJK4rjHwLKUScWG2Dl+oybkKqIkbTvWdjKYt15Pav9q+VV5Q6M+LQqr?=
 =?us-ascii?Q?gIaERzj3ldD8bd1+jepTi5MXd5yrJPzQae6rujk05+C2Jqt3/xGgIKzCylRd?=
 =?us-ascii?Q?9oIqsE9eto/R2PQW86JaNzk0H66z1NjiPXq3t2IaAaQoPziJLa8saadGSJAW?=
 =?us-ascii?Q?19uo6ugfmzmLKhjpjXvY33+B8lK90+YgMF36AimZcDVvocCHFWrmYmFKZP8F?=
 =?us-ascii?Q?pjMVfp7G+Wn+O2VO9jfcDEMRyIMUmwig3xYdy8LvLXceyJTRiBWV/ryRlnwW?=
 =?us-ascii?Q?wfQyeoCK1O7UR+1Q8kzsdC0QjTq3Kzs3QnZOaLj+ezFpHHnbWcH0plyH+INS?=
 =?us-ascii?Q?jVTEp+lisFOt18gyenJcRtHBGkf2J7MLnmQGQOSgjotpOuC4FeXf4XUprgl0?=
 =?us-ascii?Q?7pUXA3PCJ3dpYiV9d/LfTzZ77crcqLsKygMVxC4ncuQ0EUGazF/Z7nSjaVGx?=
 =?us-ascii?Q?P9RV7RoWKD4A4UUyOxp+kQAnIcLH2W4TsnbnjGTdz/KgdKUgPzB77seoA6FC?=
 =?us-ascii?Q?cxpFgm8i+reCeaF8N/5mNhiwcCh+Ilw8lHw6KDm9S659/7BRLxDPVyUzy/04?=
 =?us-ascii?Q?Imh51UuYCpARveye1s3KuKgrSsDyi9RYBfn8DK8VzzYF0mIjN3V9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bdad59-6aad-4c5c-8137-08dee240eff1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:06.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqnwn5q+Z2CA01STSamTu9lyOh4MYuK3tukFQFuub0tHHVdQuKZgKsMLUO2Cu877BvR3is5f5jurva3qjrlpG858ZHEqTXv3UqzDzoEvZw9ZExWndA6ATaS4QuqKgrkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12681

From: Luke Wang <ziniu.wang_1@nxp.com>

sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
writing zero. For SDIO devices that keep power during system suspend
and operate in DDR mode, the card remains in DDR timing while the host
DLL override configuration is lost.

Extract the DLL override setup from esdhc_set_uhs_signaling() into
a helper esdhc_set_dll_override(), and call it on the resume path
when the card kept power and is using a DDR timing mode.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6526d65538de..7230d70e02ae 100644
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
@@ -1404,7 +1421,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	u32 m;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	/* disable ddr mode and disable HS400 mode */
 	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
@@ -1425,15 +1441,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
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
@@ -2123,9 +2131,18 @@ static int sdhci_esdhc_resume(struct device *dev)
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

