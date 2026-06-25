Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC039935D;
	Thu, 25 Jun 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385037; cv=fail; b=k6q8FbCK2yY49NEYUPlxNTobemTEsEQ+BT1ud643m+/MZT/QqG1fm1P2lMDmbgfqU6eHltwJFyL1JRbA+KD20F5HZwFb3rM07s0GNBen4qOSpd7zaBKoV4HGJdgiA0+JhoVGz1ccv+nv+MVU4sKcUdLMcRDsXIXGTaby3FkOXuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385037; c=relaxed/simple;
	bh=UC8XgslV4IcPHSRbdfCCWH4+et7akvLSQMzXJ8obkq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGyUnmfaTtOR2LwmZt5cR+E9wv1TX3wE3nrsDhdfmcq4ro22cVB8v1Ir47AQIdO3T7Kfwv7JBPI4+ChBOtCae2ZyHW7fwtEgInGOtCbcd5Z3Vs8DNthhvC0lf8RQydLxKseIN9uhW9wAZyiSbHeriEFq1RIMFhQl2MEJBb6ycVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PSm+PDLH; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PSm+PDLH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3EfQeawYyxVpoM1IYVguMKyuIho9taL1PPtEVgpE5+2pjbn7LvPf3eIa9teCJnoDexmvWrgwvToYhHzDnNzND5n4i8zKPG7sXMD4HLdY5MtbtJqJE9FF3Ez5oKeEV5QY6uIolTShhhTUqBUYgUVNA1hRcqc8+pEoxiAmBoB3df44tS2ar/8PfE4vhZ973D1I8Po9Uw/+vwr8mnnU0kdRcWZ0Uqe0DCY2vRE8lhQZiHDwmqCbudF0EdTpCD+2LvI+m0ly21ZpnYJ/bYrC1p+ZDLC5o3rJg9U6X7HUooPkTKITHFcW+wb37/qGOEHelfgw4FxlmobAEaDrKvx6hFTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVp9khN8DLwFDn+Wm4TGgxdISOenKTKjrwCEaeM4PXY=;
 b=iLXL/JXrGDAgsTPLHq3ldE/tnhgnElx8bd1XK5qMJNv9gnvntkLB5BvUnJ/do3tHrEXp1hzsj9TMsw7HbDbhk/XbWmZNwQ9Ra2hogXsEfJ1QvouEYbI5f9ve813Y7HyVUtT/ACIKbOVDi5rZue/4WQ3+MfW2GKKlCGpvAwJppkDhj8C5Z+yk8jwZyEVlxPPGRTjlOMHuFXoOmr9s7CLho52gbOh4d4A604d01iY0fXcFXRwq0SwRwn290b0AwV9Q9/mmj8lMHURVuenyqSPpwwaVL8HpqLwjXsRqcxOcSNUAfFw8OityfBCLzrGsPtrnC+Yk9sfVZgQUhI7XNtt7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVp9khN8DLwFDn+Wm4TGgxdISOenKTKjrwCEaeM4PXY=;
 b=PSm+PDLHnPlROpi1Eg/YUocBQ+au2iVNaIKkXiWOyh3nkxE4Q7WOtECCVaAq/DjEs0ZcI1vHhKVX39SPTiihda/dTIe01ZTxfHsN62h6HBqMH6FCjmTotL8/3+fYufAOsoAV9cXXvPjrD4Lwt9O6NJHHbhvperWQ3/FY97VMI+SmrVVxYZmhljyrQJtUS7Yj+OCh/c9/5yjlK3kVNxKx+X05VvPLpBsa4C8f5/e3Hvy+37qu9B+WGvlYdAUOVxU2JkOMRFA5XqlTvRcaQ0Yp+aCLckivVntWv3HUxxPOc0iBWwTfq5GhH/MbNYF73imDzwjM8nyLRx4Ynhq8HMli6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by FRWPR04MB11283.eurprd04.prod.outlook.com (2603:10a6:d10:19e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 10:57:14 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:14 +0000
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
Subject: [PATCH v2 1/5] mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
Date: Thu, 25 Jun 2026 18:59:30 +0800
Message-Id: <20260625105934.2890635-2-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|FRWPR04MB11283:EE_
X-MS-Office365-Filtering-Correlation-Id: dfac058a-a274-4b0f-3ebd-08ded2a88434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|376014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xdUA0ZaIxhajjrByrSyCjSd13e+VuRhCiOreRUZuwjwN59yNttvW/JVtbRzCcotPgZ5VIEhZVkLi8LeepReXQT4ZpcCAQJAXanVZzeNqXVHYzFlmdZmhxxNwp0tETtP+md9JgI0DNclwGOoz1CXgkxROL7l+3oL+hhmhNmpuJxCL1gvz+I758aSt107y0Cks3w3jtJJGdzvU2yOIrgqsfWXe4zbwWxmlYwddoW+s5nbsgNPcYhQsvu007svEGcgUFY20eow6bzH8Vu65ZpMD7TrPMEldUpoiCYcyrjuGCoUXAD8d0KTW4pDgKbc6GdsWBUfBjbQieZJblcZZFXJQSCnHc2jsvBrRNrP6U+XiT8yp3bhwOwN9XgDOPw59pi3byhXcHM1+PDt/OtG2jMHO9hDjH8tyP9EvLPOPLy/qHNHBZ3PSZX3Qr8820JFdILhS10EMBkv6lf4Dn2GGq6bAL0gkZeVMFR+FnkAqQjIX8bSyCssJELXp7F0TqW5K2m2JRFgZ49YGyPrESSVIWywAqCpplpT8kYcQHq195UZzpfo2WyljRm6YQLjTr78HcYjmHLXyflM9PtBH2ULfjReaw+PXOKlu6oTwT98tUm65H2ubeFq9+1N6+G2SwJLPagRv7EKBinbW++qDU3yttSy/A0oCthTumROzBkFC6kOiH8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMBPprGEd4XJaujl1jTkLbsRica/ZsfTSvoPlXCJyBbQ4h4BETL8/num6p9s?=
 =?us-ascii?Q?FGHkDPK9reibhsfzDmZ5jCtkwghOaKp/pqqdExYltbPt5ZWQb+kBND5NOEZM?=
 =?us-ascii?Q?I5PNPIBKeUe0eYnPF3TzkGsRpP8+BtfBKLAthv/eRB0j4JSgJL4qvjUT12dF?=
 =?us-ascii?Q?av5GGyARwk53ASF4xxMhsZVTUnzOX1c38jWX7hd+0sv9YomZz5U0Vbmu/Vh4?=
 =?us-ascii?Q?V/kRlGJJqaR+4ljbTLb7lJTRl3uGh1dPDZgQXKzcanBw9y0R36OmFAUQM39J?=
 =?us-ascii?Q?HjqfHdKwAH0tUnR7F7FILJ2644WsH3rYP1BH+kULrSO35TVhGqXmvXMw50/C?=
 =?us-ascii?Q?v9n+2laAmUq8RTIFGqSxGY02/toD/ERnyJtE4SFRqLsF0AgXKyDOB84fcBP9?=
 =?us-ascii?Q?2+UD1bYcZ102NS7OKD2fjcKdgRhmdxi/P+aOkAKceRsH+xCid6B8Jo7x/ZeZ?=
 =?us-ascii?Q?pYO4t4U/BZNPU4K5etTmwHAYDVcLuDfSG37W0vrOZzDTwYnmnDjCk5qUPw3I?=
 =?us-ascii?Q?PsNWptksO23f08Rg6UvotQEgZBJfZbsb7STOUvqoHZniarsXATXqKK4Z7WU2?=
 =?us-ascii?Q?8TzaIL7308NN8W88p/8r02hvwS5/klPOocRDDqn0lV0JY/KQ714TE+uMg/HN?=
 =?us-ascii?Q?HOvcuipWu6emDmzLsYV3N9eJmiQJSi84FYlGMs5Tr3gTV8iW+KGlJ1QOSDWm?=
 =?us-ascii?Q?5PJ5vs106qEm576KbfrAge4h7qA4GR3KAZHYEkEvMQym76BSxfOJvai3tUnR?=
 =?us-ascii?Q?mqBik+S1YWIHkvaomvF7UOrfmCxcZ35hjqhMpeluEJkQU/VGGLwVYtk2L1ed?=
 =?us-ascii?Q?OdF/jilFGgT+pXdnxk0va2zPQtVt0XMMpFPn1leKDL+v6pBoA2CXYc/n+cSK?=
 =?us-ascii?Q?kBFPtVwf0bNjy/iUnBwVsTniQj+U8vwUZEYat+aZc3TKQxw71imCJFso46UR?=
 =?us-ascii?Q?QSL5IGN2V+qDGs5fS3h5TUaT52i0T1IWs1gScVNkqdQNh9OdwwkDR1GWG2mK?=
 =?us-ascii?Q?1EZVVPkwr7zJwO47sHytvMHIrAH0gd1PRRBZGGFhtF1D2o/gYy7j5XvhVDfO?=
 =?us-ascii?Q?m0R+2ksiP+BjSSpKyEQMWxuXjTBuiT9bQlHBIAD0DO9khFdLYgiM+FpzxM5Y?=
 =?us-ascii?Q?631/tViyp2xVREr6xT/RoTCEuciOqBdStZQltnR/+B32TPsCQf3gSksMEPdC?=
 =?us-ascii?Q?9hSykjDTUYSKVZ3GpGJT9gY4q3Xj7FEJik79Ikdw6+W+TCHYzLa5irB1zuTn?=
 =?us-ascii?Q?BoPRZUGekFxOOpycN3LxE7eejo1AwTD4tVrYQ6E0rthmM0+PFJQZ/YvNrX3A?=
 =?us-ascii?Q?2B2SmyBleZ7Ek6sGpiYypkqNNz7cNGPUiueb4ON6ymAdLuUaBEi8Qe/qS2p3?=
 =?us-ascii?Q?Wzmjv5kYAb6+DmvqQ+geh/uk2XodzPfLD3A0o7xeKdmDWmPw70ZlncFf3vOc?=
 =?us-ascii?Q?YtA5ZR/wK2YU9+cmhYsLlooS09qgmu3lZVQ4o4hwBW1iTWxV1V0fCr7gsLJJ?=
 =?us-ascii?Q?fD/+yOWGjeLCc/ehAkUnIIR9ACSvk3DnZ8bAuNHCS26gAMRcaRos/IBCORxu?=
 =?us-ascii?Q?jXyTrFmXCP/9E9C8fym3NpzQWXwDx/eODwxbTaCFCcHIgQeDpyz4L+h3rFLZ?=
 =?us-ascii?Q?5glQYUakiujxRevekNJqSfs4lSc0ejUKZV8hs8nbPOdRoaMobkGoj+ZvD3ya?=
 =?us-ascii?Q?oz456BL63+5BxooBtFyFicumb46C1Q8Pg7dfABt9o6qyJIDpbUi/64Bubyv9?=
 =?us-ascii?Q?vp+Xg04iSFCtoiE1jG3/I/0OWTmfNGy1+om9U9820SmNGH2LTxC1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac058a-a274-4b0f-3ebd-08ded2a88434
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:14.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiW771BcU/B7JAHicQw0W3KdMg3zar8+b1qsnKQ6UEVnQKPFBPsmyEYYlmWtUt1MC1YtgBVuDvezkCVAFKQ5iQpCiytUYYxQl+pTs898pRThD+eSd0YcR+hozT6Hpla3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11283

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

