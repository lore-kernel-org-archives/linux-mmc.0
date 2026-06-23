Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7853C4563;
	Tue, 23 Jun 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200029; cv=fail; b=W2A4LoNk6ae/Hzx6vdMAG9owTJdc7qETRtxpkQ+ysroPpTQi/QRVja6JZnFbgvKmyJ7BhRE40rRKiIvbA6tpuAeJM8kf5Zm56BL/uS/HUYWTCAHL+GY0wg32XSyuLmHIYsGClhF3+XA7AWYmel6pCb+yGUndxNna6ffUljoe4mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200029; c=relaxed/simple;
	bh=ZfU+ycWFiZXhrtFUX2BYCsNjw24il/VxtpWNExlAhXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3rbu88MPDAZFdLCO2ZYbdhxYdbTxuRmamuQS7tuFEgqmve3h9c4fWqRGnFfWz0YSBhQJt396FsbqiNQbXmmn9Tix7jha4GNueK2o5nBlRIpLcgY0gYoB56sDjPBtVMiYFGhLm1Xr+o6iHjCHZ4l/9NhXmACL1kZmz3X1JD2jvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xGmNHeUx; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xGmNHeUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp7H+e+y7YHnST4Dr7uwa1L1dtFAb/UW661vpQUoJCooYLaswtiX2pVWZlzsnsP3XKuKNz074/Aqm95xOezyQnFp4I2eKfwcS27DcJHxR5zdprsi7/R75/9C+npng3AjV3f3T+8DZVfakhuF9HTkYviER+F6iZ706KCm0NN72jbrjZN9WwIM59A59HFFbnaPPnUIpn2+XtVYsG2soiMfFQPBwaxQ208SqhJhV2wSzND9BZG0CRU0eFDIkWNOyL/GmDVw1xyEPG05N4n2Jq6nT2ynJMdQqtP2GvfR4lUedRlmm0feGaMtm02FMywPc9umQyWTDtNR5yDvc+u5bv/XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvCVhIXSPdhQS3gNBSZAZW93rNOBLcYbEbMhqMfD98E=;
 b=CiJ/7Owwr4P3F5Timy678rdVHGHjO+IclaxcFBPQ0wYbP0F0FIj0F1kcGzGeWEseOGZGr/5HAQBahlR0QzokbNZQy8nr9VvHepZ5fXKq3JnhNIDJtWj8T4KBL4xEBs9wu6fejMyOJb0uy7pHzxYjpxgs3Ce84qayD7a8HNCjE342I/omKQG1E90EfY+NauGYhEZSD/PRhS9EgE8VsmIlIM0FQUGRXSXC96zv0z31Hsyhaqg7b+ruHcbBOiRe1XEOmiE2V3IfnzM015JOT/+6cYmDA77B/erH22b3eNZodDIEsnlVQ405YW5cb3LZn+aplP3GNXSmQsqZf8gyLWcCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvCVhIXSPdhQS3gNBSZAZW93rNOBLcYbEbMhqMfD98E=;
 b=xGmNHeUx8aYPFgRbo89JRLYdHjBX4KN7cANsfXLgGQ5/2idRa0acQRCou6vX626R/IeRc8DU6zlnHuf9jiYsASdrFAGZQmUeT+h/I3SZIAhGogzBFmn0w/NGUq+OaFBJXYiFDgFpgLWkIX97bfAIcY8vUUDpiatWHAgvpQdOeJVE8auEJ0R3IlZgPBCXIzsgfvvMRULSWLocWsOEuJdepdJc3dwpkISK4th8V8rGD8jtp6jaWq5Jo3DYUPK0RR+G/ZykKMNmG/lAfGVKpoY5xe88vSsZgvQqpDDZd67NQwO6jxh4Xb57NwlXZ2aqJ1LJef1jGvmsPk+3k7e4U38/4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by GV1PR04MB10822.eurprd04.prod.outlook.com (2603:10a6:150:205::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:33:43 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:33:43 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
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
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Tue, 23 Jun 2026 15:35:13 +0800
Message-Id: <20260623073515.2658205-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
References: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::17) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|GV1PR04MB10822:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2aa3c1-8aa0-4131-074f-08ded0f9c09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|18002099003|22082099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	bOz/pLcEb41XLZogOiIA5vOyNCVacjvBZylMKLXnckgOk6HZz3dFgvesXBIDaZjFmkydLj1PVTbf5lwvhJbvVt+5Hy/Bv9rZ0PLb5rAh600NmYw/OCrJOm+rKDQEa1my415SwC8f1uWIwmQyII1kNfKhsGIpL7ocVnA92VdlHe32/eLzy1aS8BOlVHRGesze/H6UvIFst60stmWb3UHSsddAFjZH7wtTZagJNa4XYYrpxX9YUT5gI4sxAMa515l3HyGH9Jj2BpdqgCGcXroZXnkqHmzuajlDgq95j89dfO+6yAvEoo3Vwec96qPfHhZw5A3RY41dIQiwvqqXpJC8fD5bi1pB/YLcgp0in12xKqHJ/QrFVxyCUvT5PhgVUsWRYhQOPxEkOaxCYfpRFDwhHe621zaq+/ibupzFnBEAeoCazIY0ZQ+YBrs8GDi/9lXpuwhw2e3+v4eh+IbnG3Ik9Gc3XZbvqx+JsoEieyM7yDPQX1WcplEsN3bMFKYY6tHLme1eHGvHHn1RU/IS8vo9tQfHKp+dvnC1Ka6eUMkJClnY+n1rx7NSO9ql5bJwZ+uxx/fVCnyBsFPlCOiairUEQE0AtfCBc88fiOmPHcuTDmpeTgg2ruRpG3kbmc/LCwhplXWJItJIerQukWw73J8tYMlhFJ66YNqSZ5qTtM9+Ol8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MaO5V9dXIWj4PAYyKykZukERB1M4fSSukh7e7LlVo3s0VRQcBi6gpRkqkOC+?=
 =?us-ascii?Q?l1NuPjy0fCJqjwXm5OcIfiHIT/jZdbyJ6I+Ncq6cfQ/huxzse4jBqUjHinXl?=
 =?us-ascii?Q?uNxNGH7OYYZCCilOmEzNBytsTqMEo9sNjksVKRjd6I1cORn+7uaiw/nQTjxB?=
 =?us-ascii?Q?/hf8XcJguNztrcwpkMaRLjWNaSR5ytpLPTuBFtxgv78Nrw7RHNA+H3S8pQfU?=
 =?us-ascii?Q?BzFG9ox8tjKUVtP8GRkpFw+iUoWmSXdrUkyvOlw5Fmr3tbfB2E96GWfffOQA?=
 =?us-ascii?Q?IWaXqEua6cZikpWB+jqkS9i+lVwDxvXO1//YHpFaxVJnoQ2tB7KwG/w+Y+Q7?=
 =?us-ascii?Q?PWc+37SU/8i+t6H9iK1hPlzw2Q04LK/62Ha7bQcjwfq9RBwupGhNf8SlqNOe?=
 =?us-ascii?Q?j9YkbMZ+oKn8Swm+rHpS+BMnKPRYbjLb/X0dlV3RokE1o6ZMxadhVq3V9iEd?=
 =?us-ascii?Q?fkzAT7WSakHshzKujW1tMKMFlz/ju4AeIeIJHsFy7q6Df5iEy+of+ntgmdI3?=
 =?us-ascii?Q?cXhsL00/26/Ilxckkd79FgtKs00yLBfIhszpiy0YaDLKhWF2uxLim3nZFlBH?=
 =?us-ascii?Q?Pm3m+z+n0p4Ed6jVXoR//+oB0PPfsLrcJoUbArqd/+niESoRBHtQlqGxapax?=
 =?us-ascii?Q?QRVvmLbS2Ea6Nv7dY7opqkZXYYDDAdBKT/rvunMofZ4tE8EXOKARDn+pRW+y?=
 =?us-ascii?Q?h+bd/YDtHG99ZzM6aw1N6/ncRz6VhdFBoycUZXtl1L3doM8nk7TQhb5Rkh+p?=
 =?us-ascii?Q?qXT3DrJFEwDpFbnGpau/aP5irClW1w+LGgxIPVn2NxNdgVtMPs6hQHun5giz?=
 =?us-ascii?Q?PngN9t5KymSbx8X+VKrBUC+P+lm3CYTllDngNcszOcOwKog8ZfAnLX0mvsG6?=
 =?us-ascii?Q?3QXHya6L9El1gNEjYZEoqd0Nm6iSxkdy1qOkzSjg99xwkgvqzsDk5yOONKOT?=
 =?us-ascii?Q?ykALqLrIUmquXscpqHR+hgHwXCz/2tTYaeva7INfnqsbvjCT/dct/4M9+dmq?=
 =?us-ascii?Q?OVhat8WHdPQWxMT2drHsMaiU2R99gDbEGOYn+QlQyxuK4j9O1cOqBp3zoHGC?=
 =?us-ascii?Q?5yvnLLT4SXEx6xR1YCxxolO/kKYgjGnqVx22952sbbJKsu06nN6vzD/zmu+9?=
 =?us-ascii?Q?LaVqQ6hj/afqBkIyT4ftVFdY+G3iefx2GkQIDVaafjFnmN+8teKqZ5KNd0AW?=
 =?us-ascii?Q?+I/rI+3d4aJpvaQL1DvyVhpHouxfBJYIwb3/pPpQz2JulnKGjkAvGKoxofBT?=
 =?us-ascii?Q?CaGFO6w56xW4S+ydSp6hpScZE/bFYU7rKq6egy4pp7SpTTaERGqzMnaNcTcg?=
 =?us-ascii?Q?p3c++DU9WXt6ccqFoggQ3jukrpS8cYGw79WIaV+7xormvvbCCZ//4HnX4oLA?=
 =?us-ascii?Q?0IdGlYKQBE2t7TO2q/MDJsiOfry8/OHs9slKxYJqgz55YPR24kKZdY0Xv5Qc?=
 =?us-ascii?Q?UHvVvIN+MxebpLDwXcGyI3l8Sruo4MWNbIbEhuewfr6inVwhBb1cOg7GTRvB?=
 =?us-ascii?Q?f8KjAt/f6QEhWRw8Wts49sSQ3cuhkW+je0p6IkR1H+M0A6ebWTd42JtOQ+9k?=
 =?us-ascii?Q?So9wAZLGQn+X2xZIC6Clwa3qInVeAKxloyro0/bl5USgx3+aPKAutgfHLXZ3?=
 =?us-ascii?Q?9/Zx99IFVe1UAH4iG3BkRKZMO/wolN8lI6bFhyOP76EA/yYkSCJnit4CTs3g?=
 =?us-ascii?Q?QeE4yNtkwgyt91ZCS11yuAIrUcFvhrmDuG2utNldIqPhGpmjuAlTwmgZKzmL?=
 =?us-ascii?Q?qbHbza2sCtYckBONA6VosP3qowb2o4O7okGt1a8zDVd80UxQOb32?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2aa3c1-8aa0-4131-074f-08ded0f9c09f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:33:43.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FFxZpDrefR2vYqZKoLedn8z+r5RQWrA8/r9kwh4clrZmCAgRcvaRrY1Uj/I4xMPuBUPDfMvxnZOMDo3MhoOMZuhCcXUDDvqlTgRIgGwsPLQ03N02Xn8zV0IjvORzjOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10822

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

