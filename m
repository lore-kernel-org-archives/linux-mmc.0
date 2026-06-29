Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF0402B93;
	Mon, 29 Jun 2026 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724655; cv=fail; b=pGCy/WOipGcKjN0OIwfILdYtNSSmTLBcp/EJtgMqqKGsF7z/0RLRJH52ANXabsz4kSr24Bw5G8hCxhjhWAzOLIWdNcQBYzv3fkuoY3vucEtpoS7LyklqJOEgaoYbd802PHo268cgAZw4v7tqGLuUlARkkvWGf/0ywCQj4GrY+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724655; c=relaxed/simple;
	bh=MTtQoSAGszXhOi4Lqoj1OfrZW1VdughdRYEBkgqj6xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWutHiXZ3vFvL+Vh4WGENqxI0PcO+eh+ssfKQDgR11zmBV+DJ5KkapQQ0fxyOuSZhsVJIFJQ4vh08G83NO5NDQ/abhlJrZLZQ66dew+RY8eMombrLYadW5xr5AMB+woNfWN8EyiM1kHxgw/MzWQz+NE6m2ukqrLTdIXd6p3DYpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YQc4RLJY; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YQc4RLJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfRmmt5AMpd52oVn5i8hHdiHmhU6ZeB45IYbhr3to+0KO4ht6ClHZjetFV0UFWUpezMAlkbIKYK7uFntmogppM5cjF0FU8Su+wv1BwBy9qM/emEqjmveQHLsG3YM2pGdt2GMnTxBUhL4YaeVE7yGAoy3u4cY6+GCYywc4Eo9/nhmsYRJTQutgZMSUIubjCqasCQmteM2x4rswa9QSzpI8SrFoWhlD9RCQyMI5qOOt6DF/XfAqXu19HlbTxPSIyNq4vQlyz4VsSJ9L0+Bj+WlgFX1hemnrEv63V3G5qbLjgWYBRTPm91Tx2jMWEijFfg/GiVUiY7kkKI4RVXO7p+PtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE6AHp0bsK33+9c9esUv15xh8BtQQmMap6KhkXJnkUo=;
 b=dsmr8JbHtd8btBOihNrJMBHDETaLWBt1ZX/WMOtPMIDubgHcJwBrtVblcGwyKfFy+/kt+0jty/Wv1RT2DWXKr81OkWydAanhoJmTz3RXHyavCzbtpDpFPiMaFGGu2iHQ0OFHW11rnAb717vHtTrJqmaIJZY5feYHMSZSd2gLhzk2ZI/wEogv7C+YYX0WA58k//EzNRSf3uGSo1tzG56dgjOpx7XU+rnvWfLC9tj8dFutiX2MhjMUENKmNzVlUnOGFrgZzio0KBTimf//ndEdBKspwgxy50Fv9MKhU3ieoKB3VDrsCgEeGLInA8So30hIy9YmfL2e5K5T9MFuhIaFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE6AHp0bsK33+9c9esUv15xh8BtQQmMap6KhkXJnkUo=;
 b=YQc4RLJYINgIUaKDtTA6EQ/HF522TmeFnqKFLiisJImz0g628T6IO4fdIcqVz1XAinUG/F8j7bZjIbuzfXruLCDMDwiTcnn1QFlYF6cct2JUq2gfi5hv+iNEXivmOqtGGK/O4X/6lH76FdaWsLAQezsEC8i1S1DArfyK3QfX6s39i1eA+icVxs7iGoibpWRlqLkaoMYycCFAvWfvXLfp8/J+WShud8L1ZgT7jPMr2c2yn7cb8RNywylcjkeilSYH+BJeyO+g/1F5BhwBP/YCfZNI8AbWSKL1uYQQeRE6NsU8U1Nb6P0RXiByqnxpkUajMpvXhUffbaVmh8rZhq/ahA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI0PR04MB12663.eurprd04.prod.outlook.com (2603:10a6:800:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:31 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:31 +0000
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
Subject: [PATCH v3 1/7] mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
Date: Mon, 29 Jun 2026 17:19:48 +0800
Message-Id: <20260629091954.3227151-2-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI0PR04MB12663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6288fb-63f1-4484-ce16-08ded5bf3f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NkKOFtr+IwTw4lbq2x9olr3ry39D+iqwhlmLi2TPUoboiCNuJqae33F9uHRShcS6J8DhAXozbomx8B14sYNfZ5++SWQ6fakzoKMW5CwuzI4KzQzUkgY9hoBjnUvOAHpwzikX3JWbA2aTlZPyOOvSMnUHimnNAgZh3LMd2R9uojEEA8iYXxHsnOTPAshoVGz30hEgXgsmenGJvYqvc0eNrV3wn1KU81hsC/wycrYj1oG+uZL2aimpEtqqIBKLfzn4vbChYLMXzoHHkWV+jKZwJztqIdVE2oZuV9NxN9yNlxJi6E9dsNoaJ0e7exEmAN+oiS9r4CH52M3MAY2NQNiqk5qtCEhjcLSDw9lq/4cNpIMK6sojEITgZUhb6pv/5pIugCYX1HBeGAdqRFpNyDWLINcVM/hjxEJg8WTCQrszSYS3CSDLg/d1Rc6CMAk4btIf9A+nsBnuZLOEMIRc13rr8JqbqYpwtvV+SfMF1Pxofq7SuSpIo9oZ34Yohb5cWS7TGAteK0lUB1r1Zw1UJ6pctaIf6j+OMYlrb36mSsBTvZbxe4PmJ6LzjUVjomS2v2gqXA002/wcCoJkQL7xEgLaOjPvfbcOxXxbW7iayZBrVScYrEtWjRwdZleh9DaoXVY2Wa0Jc83R7COQhR0wFiqYEDsx2qT8fr7X17HZ2SjHosI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XcAbnmX7bNOtaSC6h3dFlBEd+wxVoq3c8HT7bdvCSOox7NeB2rDTSik56a9J?=
 =?us-ascii?Q?DMyFDJ0wiT6zIxOHa92Il0NjTWxDrC/lppV/ZYGVtvdbVrJSQZEr9Qod4Sjm?=
 =?us-ascii?Q?jfJhGEv+fcF1XeUcxM4CW4tJcycmu79FarodOQxwkssn38SJ33elTiddRKJR?=
 =?us-ascii?Q?/blJtEEl1msrlTjLt1qag7bUO0kPe7hhq/gWwqwst3k62UU8SZ/6MJ1GmOFO?=
 =?us-ascii?Q?dzKT4lPCh7zBzBxL3a4aj7qfh4S+tOi8MKd+UeH5BcBIA/B0IfWakb8VGUfW?=
 =?us-ascii?Q?1nxzf8pHNRzRuTaADpZJSimiiOhGfSoxyG+EMs4F+EaqR0Z77DJMKLM2Z9Qt?=
 =?us-ascii?Q?Z9ZVBFb+0tAx52gGeHrSOKeitsWiPsO78ss3Z6Ck4GYQ3V32o9SyGSYV74By?=
 =?us-ascii?Q?rN9x0FcppqQ0x3NybJ/4UVxfALuxwSAyMTMVPtgUXq2agto1RSHHa1j7Uula?=
 =?us-ascii?Q?HoTdPTifRFJvtTjWMi95MII91GRfigtXmCe9D6dU7U7DVMw6L7+Qlt10/wD9?=
 =?us-ascii?Q?OcSkKaD+s+GhUEsWMgPpurww4l6RAAWuSllbOUdQzpvmd74LX20fFCf1x9Y8?=
 =?us-ascii?Q?ZDbMpq5LX7ohNXfG1Izm91SXQeNa04dozyk5EStZQp1PIq006aXw+OaCSXl4?=
 =?us-ascii?Q?aWfaPGDHTBZDeDJSXqH0cH8q2SNSHodgwdYGqTFAaTHmeICOo5SzATJrbTo9?=
 =?us-ascii?Q?HtIsaG4Oeqe89JqhMHKoLEslqTxmfs9sXjPie8OVCU/ne/vu2FxMAFCaaQhR?=
 =?us-ascii?Q?AfX4uhRGbmFyj7PpAjp5bTYBnl1nxkaggUL4TmouDMFFIxF6mXlhoETfpdkg?=
 =?us-ascii?Q?iTYfyYfZFXJizCIXu5HSzaD70Oi+sufdduULQelKwv8XoU/yo6JhO6OVESrm?=
 =?us-ascii?Q?cPOHjm8qwGD6pm0BJGvRDXMhNKmcO5FhcghDL26lqDMC4rMWJjLpyG093dOY?=
 =?us-ascii?Q?E5ndh/F5zyMgU6CbSrD1CxREKgAW3LBSGbOHQxy1ESSXyvwHz22Vcemb0VKF?=
 =?us-ascii?Q?mUIn3s9F/sMsxcCSISCqZX6jYlwu6H2Z7NDQjrmL3l3WW7nTeqT+wERyh9Tp?=
 =?us-ascii?Q?gmEqMriFUx0bme6yc9Iu6yw1A+C2wsYo52PdyhA0lP+soty69OGyt3JRGk92?=
 =?us-ascii?Q?IgU5DUP/8qQXeVWmHWHmZgJXXJaGBdzzFyqfV16G/sYC11CNSftmwFbxrxTi?=
 =?us-ascii?Q?EEAP+Q/yVczOhh7v4hn0UfX/iTnjwQ63MXsvhi7aLRwOc07cVPx3bawlCo3s?=
 =?us-ascii?Q?48yj9a0jqdje+WgFFz9Xb1tKZwhgn59em23qGynUwi/5J9f5s5YzMjTHVFBJ?=
 =?us-ascii?Q?3DFuOGPgbHIF/f7lsrOC2SY0gOon7ZxC/FQ3ED8Mu/n2/t7haxPF6KUCdm0R?=
 =?us-ascii?Q?ZiYGjKWAObd302/Fdu3uNHnmw+au3gkLZrHug8WekFXjZkDClUjql+AZ5NPK?=
 =?us-ascii?Q?srEFcdUz67HqLvaZgNew+l+ry5tIAk2ZsEDXYsmd3LL7unzCvEskPW2ERIOx?=
 =?us-ascii?Q?T/1taE6qECjrW9tV5U/COkZNxILqbQP0ftAbDQs2fdwOKJ3ya4fSuBkdxSvu?=
 =?us-ascii?Q?Z32wfepooBTo8srbbEYkCQy53l1B/gA4J3AdLST4CGuWhcSRLCu41tyht9L0?=
 =?us-ascii?Q?yk4A5OKeG3iCd17IaYORzgZEJMboPibwbdKIh2OzBLksYAqqQH1pJVKBLYzD?=
 =?us-ascii?Q?bQ0uxkONhuY6jeYN7onWSFLdbzXXMBWBHXnH2wfSRTYiLhBwi2/spCzd6JB5?=
 =?us-ascii?Q?0pdk6vDhS4uZMccCudY1nferuL/86kvTFxkFD7py5rhd57XLhJ52?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6288fb-63f1-4484-ce16-08ded5bf3f66
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:31.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZoBHMhNvuA8XYIf1HILqPEujdX4h7M9lFQdfjJtIbAU/YdyfNRtDBcSDYpAfvnkeQObisRWF09N4SXHP45vp/ogp52Yxu/HsgkriWryuH1VAZwsD+Cq1V9Ap6JoiFac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12663

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

