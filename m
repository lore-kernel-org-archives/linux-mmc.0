Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B723D6688;
	Fri,  3 Jul 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075191; cv=fail; b=ixjLuum33Tx0LwIQeyi/aFagoQAUrrO96V2ryK4lPFtqk2nzL02q2osNoh6CaUG+uA10rDTrQfsVZJXNa6IYh93sKh5r7ZhqV0MAjhL9VUQZ+5i/+gnprH78URmzjmWRVs4Tm9BoZnhfopOFYi6w6StEjdMMERHXci5lHzX9COM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075191; c=relaxed/simple;
	bh=+n2ipHNhJGFoMPXaGsztzAsvYkZe9WvfVQkaHQRkanI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCunEjUlr43APvhX9O1imBFIo/Y//hWQS+JsJ4Yvo1tUoFSxsUpDPlP5444A4UW5XJOoi8yPyn3zL/KgLULYY8Pj178OZ1o+w4IDIC057x9jmFXqX6w8h5Vz3QtgmfPSgmw6q29qPkbKjuLhF2xTI2xeMgqjfTMRzh+00FlWNUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EIOBeIc+; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EIOBeIc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj4u0c3b/pSXuzMmZDhdz6dX3LzxU1Hvh7g9sBFbzJmGArAErH3JamRPNhpv7khSfG3Ky8KqfDcJKr5lly6zF5jDOz4+2u5bOXcfWAtgt7jMkGlwgmUY4Gxa1wPbeXlgqM27ihc0+u54MLiL94jfhIceUpnqPUsT4/YGkAcLn3vSYwLGlasVcsr/jeDFTRChT/XrFmTPtE/H+6O/4Q3Bro5eHCoMtUiY930ujhtHRmEf/L8VWA5yiJ32NezSFMhYjMthbf+GWnuzAI5QEF8db/zOn/7CVLp0vF/MKTbt7W5OhbuaLvrPbQZ0jlFTR6nm+QtR0hJbUtAQxSVap/lk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfYWSlTDNFd0gQ/OYVTvZ5K+//lM82khuWXHXWv+dRY=;
 b=CEntiP46HymzPMLEA7UmCYGwqeY4xR7dc4yNsB4lBPq3GuBUo2l1MgIZhaxMyWjUusAXDnGQcXAgkDVfAWhZNSb3ogG1cuc0e0NBMBhOjlgUrm828LTJ1aKTwW6PRX4ecj1gAzacy8/lvHMZOGplJvWEEjb6GjNI8IPtAsvtGogr+Y7SXd78dlQmGHsVxpBYKswL8mrBrVudpxpzZD7ryxyaTeLQ55MA4vRRkIy/u/cExyRKemarTQ1ipbsEqCCBZ2Jl8d49TLkUJfkgwrVEW8PXXb3h1d4v7K7sgMfrtr7WWmpauLUywieKzYLGAjErXCvRKp7KwJILitxApgNuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfYWSlTDNFd0gQ/OYVTvZ5K+//lM82khuWXHXWv+dRY=;
 b=EIOBeIc+SrKlFfScF1yRsHr9h91XYMG5fufNRLea9cJIPgexSg734/AOOda4ogo4v5Hbkz+7eowEwnWYGGJ/NA91b6kb1o1GUGzU6TMpS+AMnYTYK9wwc/T8fH628nEZ3RK3DHK4XWnnTWegPIR25LIZkoTNcaKwiAKgvDnW3as2UrZlC5Q5+KstXk/uuCkDCjvjE8dJCz/9hBbDoS56AH3ydWsogCmrDRd0PLPYYuVke5lDqGyvQWWFl409z+zV2PLNhEJ2a35+R0D3z30yq58wQx3S2YzePsMZOd4KbOPH1AlH8gbQoUgPl+VNTkJdZbDKue0gegIF+w+w3a8uUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:39:47 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:39:47 +0000
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
Subject: [PATCH v4 2/7] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Fri,  3 Jul 2026 18:42:03 +0800
Message-Id: <20260703104208.3426374-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: 02569e7b-9675-4426-0868-08ded8ef6707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xEjmKttjb3KnVUsZa3Z23LzQFFbBITOHNBkgk72HPy2LXCFxL1xcI/zfcBwzqXLbGuKOWStNzwSOwGcnqq+puts44TJMVsdEA6JA4zmzqSrhnQ5anYwvt3jP1vbVBN5oGQ8LpGX0vwAMsAsVd7A7p3ZkcialDjWEdRdjXkLV35l/vfvycziXw+bre/5FHrb8qWL3E9FGySF+ZzP9pF26x2TKfPGRc33/QU001WtI3TPVk/xbBW1kn64Nduyyrdbo5yFH6SdF3QAojRspw0D0nc3Db/3ksexIR84UANXGm8C/He5Pnr5tOMbiAMK+dz7ItpabDoSWozOTCZn1H88742GQSCoh3R20KAKzBgkAfbRfOAMjEjy186jBSXmscpEhRq3lOTirPGWdMQuH/K5KvBVIsCt3LZl1lu248ycLBBKneXCCiT02RRP2KymrNgvNcmeJUSIrM/QjQ8/JRQUZHMH86b/kM2/cXnJ/sDZI04cz3DS8dRG7ZGzWci9Al5xmo4ZY+srFmNJLZqT/41vgSqpLCgQAr1jNfy1UnKr2+ucjhGdPOmGRGyStcYcZ/e0dB5uUcOpLY1xatsktD2H1//lQ6kmKKKgxVI5kt1maVIwEqs6yz5fdYNNiahvDRVpRcsTvfDB12/HOPhvBFPJJqzi4fvHx2FWJ5TEWhse6CI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3gYGJL9/4hHfWcHT8dsMe1jfN+qJBQsVroK8gIgyKOU6sJl6UXC/GYVkPts?=
 =?us-ascii?Q?XTDnspTjUX9313CMZb/h3pPNJDY3Y2gEXxHSIJpnbXzyfCWVK6QOBQXVPPIe?=
 =?us-ascii?Q?S/PqS6GLJ1dBqqwoY5Y8kPmsNM3k7nkw0f6jOfEX885oDcIqg8zSyvUPvJaf?=
 =?us-ascii?Q?E2vh7BEUUK/OL3HMRITmg1fN4zXK4cw/pLtN20zxXlxfD3rMNB1pK+7TRwXd?=
 =?us-ascii?Q?E8LDT8T/cWOJFnbRhiwgH/aWD7D7Ll/EanuwqEZxMGLS9A6krwmU37+VkSKf?=
 =?us-ascii?Q?Ld8OkDII03+IzdOv29gy71tFjFliYe4WUnYp0syiPsR8JFKnTIeQDn+GyuHH?=
 =?us-ascii?Q?Z2au34+e5VJAzXhP1vSd9gd7jNW1e5XlH2cpo6F9suXAV7WVVyzXqv9Envjm?=
 =?us-ascii?Q?ORuI6M9u7f4eJb+ocbsMwPHNKsQkDrqdEEcQQy31PI9EZagO9vv8OCCdxBZa?=
 =?us-ascii?Q?w/NjjvjfmqbhM5w4o4RBGnKQTNjndu3bZ5Ss8wl04l2bXtorysUrovl2vAsJ?=
 =?us-ascii?Q?8XDGaDRQg1Bl7EG9YfKgMo2ovMzEklPmYZY5e76OqDqp+BdR4/P12893KIAV?=
 =?us-ascii?Q?crOB5nPy0o1v/ce1F5yULSU45YTVVCCVUlCPCjXn7IE1gdLks07rkfr/lyKh?=
 =?us-ascii?Q?tu2GkOuDZ85R9Qzf5Ap8OEQ/ow0FFUKyGFisn8CEwifp1W0pcFzIuRhj1F1i?=
 =?us-ascii?Q?i7bC74jUlredXPyl9kHI0+kGHEupNym9dfaeVrRz0Ej97EYXfb98ri+0cfzK?=
 =?us-ascii?Q?nDe1i6VRHRGwuDZJ0z+ygGlIwehdLCvUC/Kd/uMfj2EZi5B8g8jbsIdIH4gM?=
 =?us-ascii?Q?7L7qF/JNjyf/xk1gPNeiz3x0skadm8Otsb+XCcXVwTxuQw3lympKfENxQJRF?=
 =?us-ascii?Q?fkswuO5loOWKn6JGSvhdo2FAlF5aIjBKm3+19i/a4zoSHwt15RFP68IeShd5?=
 =?us-ascii?Q?1XJYnycZ+ZpBYvFtnexxKuXBKXQO9p0YOMMqz4LDMBz68M83BwIA53TJTfKK?=
 =?us-ascii?Q?bd+QA5Yb8VbgaZLLooeOMKbw6zbQ5CzvfU2E6cBLQgnEmif8W27hFQcMKvvg?=
 =?us-ascii?Q?wI2i5/4XCLwxaeFvtQLuSOH1lFL0hAduFoi7vnWcoJOpd0jI4k1NCDcbGWb3?=
 =?us-ascii?Q?YtwFEItDYc3j1T2uXWSR03BshaEM23cE3wrANT04wpVc/UIrwv08hXygXjYk?=
 =?us-ascii?Q?vQoy7Hjo9H8rXuFexNpsIgqsrhe25b2tN2mw1LM6427HxhWNYgnno5IWqhXQ?=
 =?us-ascii?Q?W+sdwOvrfHRhrC2VwGyP63ROPRK5kvORNe05rQ7KnoaChZH4vI3/m5NUFLDi?=
 =?us-ascii?Q?k5TRR6XXapkDhA8CPCC4XjByH7z7yxRk98EAlmP8PPQVoT2ThsR8cb9zfPEF?=
 =?us-ascii?Q?BBz3NM9FgN/qt81mGRt+kW9yUeblzyXoSFveKbqaA7bfaSchTtkWj7ReM4Qy?=
 =?us-ascii?Q?w4Q7F+y5+azGwKx5/GMyBTxN4VABWyiLg2f9Kd35387XsSM8RNFet80Jtq10?=
 =?us-ascii?Q?ugxISSVjmSPh/Q+qD2BtEpIEZXBWzP/VbAZ15ujEuGcoV0xH3bTNYOcjoQKT?=
 =?us-ascii?Q?lRa9jhdoFvk5Kch0R33N6JIXbFxkzkfY+sWnPFKA2C/dkJhHnFQjzVrx2qH+?=
 =?us-ascii?Q?yFVRJAxJD9no4hZ4KqZxDQDFxy8vXAw9H7+9kHtYKYIoc6uwFNggRiuUmO3J?=
 =?us-ascii?Q?Sb1Y3lKfhCXHYE/EVvT3OjaxbqmEXR5e34GbSk2BizFMOMBgF50xr29Zp3xU?=
 =?us-ascii?Q?nUV228rB9zve+zMQKIsNzJgpBnaz6tmy+DK03tz1Hcc75NebH9vi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02569e7b-9675-4426-0868-08ded8ef6707
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:39:47.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roAzfwzH2LsYC4JC8Fe8H/qJasBMvsD5qND2m3RCDV2+JHlsViSak3n65dqxnCa263P7nhLSA0Ovq2Xhdb/LZATaI0743fuVkbFPy6c7PtbgdxnYQRyBoD5vBvV5if9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

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

