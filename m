Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069A1C6FF9;
	Mon, 24 Mar 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808148; cv=fail; b=KVyncaB/TuAjAbzu1o3yKWgS6eoDQ6WJEjSvMj6KwSrMaPM8vFmLNpilZPatMsqhusoTrwPyZiMCg2gsIrZa5z9ysS2ocM/pTwf7T687i76dqzDnRO/+GDhJX5N8wsRt+hPxuf6t2dAW8dMgCe+LkL/6/dL0EYGUOfMUbLkeW2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808148; c=relaxed/simple;
	bh=hT1D3C1lhA3Zi5cUDLqiaVfJYSuH5AZkV2q+nDDRpWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NoTX0u+6jx/0C6EzTnM/QrXdA9QEnaMmm2KAsOlfiBRPUzWak89XC5HRrXx7yXuMf1T7oI9ShjS6z5LZvgHLr7f8BnBZckxTODBY7vxwGeu8EFa76BYzFwnqoNVWPzGBmGZVEa8+cGZtJdX/RvKjmRRneFeqOsgFBEPsEvGmxGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GZ/icTw7; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GZ/icTw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YumayFMDRglKrQuOgfryzJKXgd4dh6VMkvK9BwcrLRo1yBGiXWG5pGD45mJoXWkpq5C/9SPH8jMfwqQRLZRta8YiUCxmEixuQhLUzed8hs10GzF9xCwnNLvjBE7hQgVbN5wBROsX8jLY2MlqXfKdJTEENzf0O7B3ZTqbQo4jGYzxRHCDfALZwfY4KwOrlvrZZnPMEWZFsyzOfOtVS/hYLZhZfZMPkr5uMJX0c5WehUO4Z2LjOHJVfdoAID7Xcis+Tm7CkYPSlE/TAzJqH5uwWZGoII8L5ayuWdSTGvrYPOTXteURsB33nO0Cp8fEyWZ3bm/IJkQXc+WL724rN82r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFFmounG2W9sWD5Y3RMGQfBopJ+KlrSUsBWxBqENes0=;
 b=Utw9bzyUT37kvNoDNmY+Bsu0Ijhn6g7OZB6t4GWU8o/pZTuyuGDAf17hIw7/OmUwAvriFPYyg1nwkzCG7A/b2JUKxi6/RVgChUeAdfD+4QGyOw72RjjBV3VeO5hfu9hjymWS+jK09Yn69qpZ1fIx3p8pLu5W2BoEmzV9v3uoY7wgSiDnh6cwgOYEGNw4YtrpsRE6ZOrTQp+TeVw0c+J7odFbVAbWXsaOVB/yIY+OhrObG81z5JVcm3514CDOq5GjNZN5/FCTakbI8yZ+/uSj0Wip5GxD3Yo2mAispmqAcji4TqKfpGq+UuFxR2zmrF0pyjmf6QoeONrBlrvg0MHYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFFmounG2W9sWD5Y3RMGQfBopJ+KlrSUsBWxBqENes0=;
 b=GZ/icTw7CCS6VAmaBQfhcVe74kJ7/CKIEbHyMjhKfQs5xS25UmwYpl/vznaEXlV8U6eVVeVmFaXQGkC5RmXy7a6IWhiabEQ6hXpW/4vXT5BloHzTYUQS3bPlg76eKc/8rRpUPXRFbno2bxMdSWMP2mv5nVbTkpRK7EodoV+qylkOZJl5vaS0RXVuBiqn3Rs9eEvqLepdsgAX0PezPyl20PMCLeKeGrEQvU1Bx4caq58nntRHu9RKPwiWgKLG6b10/BmrvYdQFmQVMMGbxvnmvBwPBhoSkWfjYlgU/BgjWeszIIEKnyYDzPWP6z/AQ8FCV3TIjdSv3PwYUtKpCOItww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:22:24 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:22:24 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: calclute data timeout value based on clock
Date: Mon, 24 Mar 2025 17:23:36 +0800
Message-Id: <20250324092336.2231385-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM8PR04MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d3d8d1-eed6-4b92-b771-08dd6ab562e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeMmVBa21BbqjuRYhRbGLRzcY1zd7VczoMImKVHZZnIcwJ9olwb4TgKwB3Ls?=
 =?us-ascii?Q?c9OrTsGgM3nICUIyeDIXaBNBN0HTSDOShggJWxRTTXA9tjQVp2d4YdoaOULb?=
 =?us-ascii?Q?bKgvp2H0WQ1UzhMNt90KD+8vKYI/vIqA55Yx6Y4zYJ+1VcbAw9gJKecf85yK?=
 =?us-ascii?Q?l3uv23m7MWZ8OcxLtLKQbpPaOBe2kZKbefmRAC/oyJfwMmmCZ2xKvuVYzNVW?=
 =?us-ascii?Q?r1gX93z0pqkGOtZEh/oTZA/V56E3gVmPlML+WreSXxqZe4rVZO+3lVmBQPfD?=
 =?us-ascii?Q?76bhWJLCVNnD5/pRy+MAZqumHp0SB411WV2N5IoAR7q1GMgvDudsHCqltSPh?=
 =?us-ascii?Q?sxz4bjuXQ/YxC/SNWz2a5TrG0zI2Z2bx/wo9NLfR2Wouxm/Rzryfg9vu2SSp?=
 =?us-ascii?Q?Xg+/1LxOM5NtEfubpVy0TWAfB1AhmY0j3F3WVD+AsZWvr3nE39X80nepz/fw?=
 =?us-ascii?Q?5ukann7BSmG9qtWoUeol/nv1cj1MEO8eYuoeF+55YHFXhJIGatNDbWsvtbsn?=
 =?us-ascii?Q?skdI0yHu3+1EYDfDu2fiYQT/1s+3VkGiH1aQnGdiKNTw5B3ebiQCoWTpndV4?=
 =?us-ascii?Q?bFd2aQ7FzeszWY8B/RhNl1XvxfFoeMYN9ozEv3LVYukVbdIL9MvpA8wEgf+D?=
 =?us-ascii?Q?IUuis1xcproAcBdH3y0oGd+POAxkqYHtm/ms2y/Ze9xDINmZ3BeDPT9mm7ij?=
 =?us-ascii?Q?T32kfbcW15xgmSVeoSk4fJP5opNLUgWByKIp/5uQzXjI15OJZV4gECct2i09?=
 =?us-ascii?Q?U+2qkaaCAJxWNOZIa1TLISGUuq/+fNJ60Mj+4aJvl0a437VTstLMzEzSI7GJ?=
 =?us-ascii?Q?MFKFVVgGsxEQnAEOiFOiIN7C/E0OmvyyJMa/vezRyhTR3+oHcIlx2PwjzFYI?=
 =?us-ascii?Q?MXg1DZ8+IGjTfsOB3IcEhbx3o7xv1Heo7LIpiuL5xkDwsGrD7NmRQBd/YQPw?=
 =?us-ascii?Q?2rwJG/qbApt8dcNy4B7rMv6bYotWM1tDvk0rDpvtTTsmaElihNWGskNuIy8F?=
 =?us-ascii?Q?CF5jxQx1fGvjI/HpQ7OdvI9D8QwdeG8aQY7VyQ84aEUTD6dakNExa5bjrn4k?=
 =?us-ascii?Q?bJREHRMvxIZNaOrnsBxp+B0L39tIM1nq6PKfS232SOJSkA6tGAKh9A5G5FOE?=
 =?us-ascii?Q?DgX1K+b1F762y/UwdZVdGPEL4Y0Ouhf5IZUeYDZHygb3oEmWl9oISVqCLTFU?=
 =?us-ascii?Q?lApvUoX/um3yC0bVTrt3aaecdQ/+d5Gzs+dCHINET/RelLGjlRxO2EAHgcFE?=
 =?us-ascii?Q?4A3XcvvxS4YKwCHXz5m9eNEIwxCUK5rcJJq7/Hcctomx90dWi7zk0XfNkCej?=
 =?us-ascii?Q?ibl+9WzOsCUhXsxz4NeL+XNf4MfyUmSSj3/9HeiwuxHpTVrGYk5yiiHYnFyk?=
 =?us-ascii?Q?27EVWrh+sZiOxtWiBtxYF1xOc2600xpuOS1e8JwfDBFwiFQjVceSc4oUgud3?=
 =?us-ascii?Q?GOpZsT2OPTVsUBSTk/QnI6o0DOdIq9Qq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?namxMA2+xwq6Q0PwoUTIcagMldfaq5EsoPSod7uThLm8sb/BoawbSvhzVMh+?=
 =?us-ascii?Q?VcSmUoN+94nebcaed06iZatMFTwOukI08WnOBLosA/WXJLxx8r7DVOj+8xJD?=
 =?us-ascii?Q?GeXA8acIbJD9mqp7EW3dSYyUuQh/53nBPJfOHZ9aLOkDq0RuH5peARfXFQ4D?=
 =?us-ascii?Q?8zMU1PeMBzIXtB+ptyKgQJxP8DKRwHacdLzP2FHjRqViVXH68MVEw9rg/dE9?=
 =?us-ascii?Q?mHweKCWMzw4fJ31YrFpBowNOWvhOLa5Lt3NDRTaFrp48L9y1UfZo1w2aPgqp?=
 =?us-ascii?Q?jjaKWnNcs7qqp7NvxUK3r44ur1jDMQFmij1y0djS9yTyvCHfy2WnWDlQmPyo?=
 =?us-ascii?Q?93uh7Y+n0UkC1Nfxbju2XjPvvxTC7TGqKyi1Qf6QKt0QNGruz0P+6IZ1Ukzq?=
 =?us-ascii?Q?3uuAzaTnqI4POQujgcxX6/yX7896M6l3JK0y2GDVRdamzxZPFZMeLzvHoryb?=
 =?us-ascii?Q?8RVF+H4bkwz4O5E30PLn8Awesnzx++wBtKJbC0e22id7vBSBVKSI0WbsEcwj?=
 =?us-ascii?Q?8JN9UeyAVwyfkOWqRWprmqxBL4bjmWU9CMmbCQzZyTh27xNwb0QicqIJXFCI?=
 =?us-ascii?Q?yrXMCKaUhp5ZcsKrulvRs1+9Uz39Ky1fcwFcDTOFgzMeDjETnry98Lp1Zknq?=
 =?us-ascii?Q?uWiIKJEbVy9iRhu/GaWzVny+Lou8Bhz0rMa5qTLpP2v/O062AhZTdKfcnpbi?=
 =?us-ascii?Q?520xT/PX3hljfMq/etXUBrBKOp3TUdU6qhP7kf3CcxBkFI0hhTTlyFYKKw5H?=
 =?us-ascii?Q?Uu6/+fdMgQewksK302USpOQ0zCROKjc6BLvs3ifXrpOapCrJ+f5sEALxPp2m?=
 =?us-ascii?Q?zV6HQhtJrvEamYxZixLOy3KpJPmHHh0Uf1jzh7tjCm8byWNImrvj1CGaQoRO?=
 =?us-ascii?Q?JWa+vqWEaQ+K0As3PiGcn58xu8I++tBjJ5kE777cMuwvJXYKXYiDKw4MXzId?=
 =?us-ascii?Q?NQmZVJyDAqwT3hWLgSRdWVAlKWSSBRvOJALcH5TtH0UfI7+aKSi/vHZYAaUz?=
 =?us-ascii?Q?yYM0r9MmfesjRBIVTdPS+poAXvAFR8elsEkB2hWPmFOSLQuNlfq357vRnJNl?=
 =?us-ascii?Q?eTPLEZQJqaZQCFVcbOCefiKI64W4Qnn/DMvapKNywmkT8cx8NFoSSh0XFj/H?=
 =?us-ascii?Q?bdAYmvTMSJZI6259poZRwrXz1/HwsuFnVNLrfTr3QYQEu9Wpji5HwCVvdHIZ?=
 =?us-ascii?Q?7vtqCRMDDgIpStFq/fpLJVEeu9kC9AQAllYNbJydKsrnfafxLLZkJKKG3mRC?=
 =?us-ascii?Q?qAI9h48sXH/A7jQvHneYklshA9CPsr2gAMAcCfZ2R1lEvot+amH01Aq1Eqdq?=
 =?us-ascii?Q?fVub9wWdBTRqZzCuAwsHIgFAtnU5uysMpecC/rrfuPEsz6i59CV/BmMv6UIv?=
 =?us-ascii?Q?3j6iFwRljonZauEyl0o3EWb5K8x6nCOgFP+pZa/U/sIdjZZxkhZkatXqGa7B?=
 =?us-ascii?Q?j7LFiV1+8r23wkIHLnzoxqdHSHobM79hP5bDrAeusIOVvVL0JTExHlc6QLgC?=
 =?us-ascii?Q?Zm4sc5xzo3wvIKsAfdAzlvhMRKihRUPrAE9yI4a37uN7PPks9u0frZ2p5XYd?=
 =?us-ascii?Q?mxoPpBeOALSR2CZoM/ZZexLuQiRQDOqkBmL3k1h5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d3d8d1-eed6-4b92-b771-08dd6ab562e5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:22:24.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0g7P2BLYCk9z3C7m28t/80+0Gbh6+hOyF0RYB/Pq/vXoq4z6D+y5Qr/xVxJbLD0hRzQevlbL2SsdRl/Y4d5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249

From: Luke Wang <ziniu.wang_1@nxp.com>

Calclute data timeout value based on clock instead of using max value.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..e7316ecff64e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,7 @@
 #include "cqhci.h"
 
 #define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
+#define ESDHC_SYS_CTRL_DTOCV_SHIFT	16
 #define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
@@ -1387,12 +1388,16 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 
 static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	bool too_big = false;
+	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
 
-	/* use maximum timeout counter */
+	/*
+	 * ESDHC_SYSTEM_CONTROL bit[23] used to control hardware reset
+	 * pin of the card. Write 0 to bit[23] will reset the card.
+	 * Only write DTOCV filed here.
+	 */
 	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
-			esdhc_is_usdhc(imx_data) ? 0xF0000 : 0xE0000,
+			count << ESDHC_SYS_CTRL_DTOCV_SHIFT,
 			ESDHC_SYSTEM_CONTROL);
 }
 
@@ -1777,6 +1782,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		 * to distinguish the card type.
 		 */
 		host->mmc_host_ops.init_card = usdhc_init_card;
+
+		host->max_timeout_count = 0xF;
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
2.34.1

