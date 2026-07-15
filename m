Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C63C1985;
	Wed, 15 Jul 2026 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099824; cv=fail; b=sIjdJQdCrMfMninEIzInDKk4378+QOOvbdPTWFVUToJXcIvsRiuSLvXS2J6luAnLkJe90tfORcofWniQNTJelofXtuJM2JYheGNPpQmuRJ+gKS9IJYy2pQQmraTn3a5p/ffFfAc+FAQSVp8Fx1OqiEYFYQ93tVe5dkaUO2mOIPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099824; c=relaxed/simple;
	bh=bSEGAB1TAB5VXJNqsRLyIbEx2B6E2zZ5hYgl4RonSS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQ9rIY673kuvBOdP6DvQkpedkkNBA9bKCZ0sqAI4X93PnbVEeaHEUmGvYHa434gn0D8mvxCnBz4UwXeqxY8AmQ0EUfAVJeh3Pi4BZhqWa/HHFIJL4OU3IsJAD8MyDB+EdZquQZOvPoohC/8D3+ApOsCzH9k1z/gcDZVhGPxjlso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Lr3YZjcM; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lr3YZjcM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEoXv0JXkKPHWbqjBQBgAlDQaL5LjT8EFq3ZiLHJ87eAyPSLMkH2Vel+B6fkM4LaBzT4MsgB914fkfHxXcpjUs3gC2bnim6CZYZftAKi9zbRlVsonV+CoqjGG2OzkqDxbr+iGZZdpUl2wz8URzx4gYkRtVeN5pkdkziAWyp9+3DkJH1wiVLTkKHUlMTQNn8DXSXs6MVHPtIhkA1KRtfwGv44ZIjqLPdctZ7PQdp+TVwkPWKbddTAaEyNzxD1St9Ad9agx9PNGXMdgpjmocUKmDL9nBZcx8sPboXmbFU9os1oOEwItIfAe0olNosvvHO4Q62cDz49p9QntsyQov5S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPatnJygfDnHoMIp1M2Wfx9Vdb1EndPBC9kBt7e0ddo=;
 b=gLWe+MYdLYj8nTFFaE8n8GuejASP/HnyeBeM8bEdn/pS8PBFrxoAHTklP3Nf/NpflEEg40pv2+wOBOqDfHXuecakT/KmI1lGSLS7OzFoyoUlTRgPU30ZiYD0l9tcfkMU/im6i0zYWAnCh5gamjMLDz1bhtGVxhhVrXm2d9KQKtxwCa7l5FSFCf2ApaVPcWrqywpKTAwJJ+cGUEUCdCTleHMh4Mfydji5olZtPCrLErdUnIOKp9Xy1Y49Xh0A2KdjMbvR0DbVbPr6Bi4H+WXYmDz6TSUOBPfpBtwjV1Wr9wEUUUA0I2blrQQURujjl1Vn+Hl9GXyHXz0zIbV2RNS0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPatnJygfDnHoMIp1M2Wfx9Vdb1EndPBC9kBt7e0ddo=;
 b=Lr3YZjcMNdeTBNVQPIknJ3jwSIBrMpDUg2ufaDBRQtuV56iTlLXwI/WVZUGoKZJashonEUq0LpCMUDavx89spsuaIfBqERI5jPA/X4kGl+t00Hw6oU7Wq7sR0pTG1+OUe+jcP+y36XcYsSBTLbkUsLmp+Jt0FlXrOiP08z5VLQmRNOz5LYyFL22bM+XKHxRGwAp5DaYAqjA7sl/8d58w9lC3twIMsEQgb/GYjHwhU1RPYUOYVV5GTMs0napkCqaqCQvpp22EG7ty7kMWrWi7oGGFa9Ytse0yTNxI/79drSRGjrDKvpQY44NSTAB/DgS6NR8BnYGO+VCNE4Obu7TQkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA1PR04MB12197.eurprd04.prod.outlook.com (2603:10a6:102:560::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:16:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:47 +0000
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
Subject: [PATCH v7 8/8] mmc: sdhci-esdhc-imx: fix resume error handling
Date: Wed, 15 Jul 2026 15:18:18 +0800
Message-Id: <20260715071818.272318-9-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PA1PR04MB12197:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bc33ec-b647-4602-da95-08dee241082a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZU1KJq8Pn3NSXr0lZRULoM81lYPTsG3jOFi+rXHlVu75RTTa6ugFVaCTP0fMruwvMUG5RdHoUtxbO7j92vqMg5X6bxGSw7kpdK6Nx9vuZbPzImrmqAUwKzuz52LgcjlMBOH3ElWsRU8bWx3NUXa4NdE9boY7BO3cfRrSmB/kGt4zp4yakkKkv+gYDSYIxhm//XgIDvaxCue0WSWXaZWnqdaeWX8tzrQDk+c5bH2SO8wmZPhqHla95GEMc2uOiDgVp8Sx2l2MFWHsTzs/kBhm5OJvaqWp5824w3FA0oxkdSE2KDlYgtpL7JCM/v++H3VBFI7S62kBRr0mkQHoS7ZVfKGfWli5MAV0xgbuXKvz/11gxS5sophbiD8i6VbrEmpjpcmn4qh215MG5GtM8EBSXWSgTd8R0e/eCg58ZeNVjShirugIQ5dLg/zI+7Ci10zOz8z0HsRqg8Ig8ZO0K1fmbRwb69sGw2zZoGGFU9Bg90fO+6bIV9aOWokZg8N2HktPKCcjJEGYwbFv4Ut9Y6ec5MJ0qlMBTVHeA5G094+bfPhSHyM6se8dA8+rRp3MmFCaS/7AL3tLox6eHth4Qp/Ealhs0y57CPgSBAKKLHwLW5PNbC8sQFSQNwwMjwTGmeQVWWLIJoCzbrd57l+Sf4YqrsD2zjiBwZXmDWPGiBlI6Nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0Y6p3NFKq7z1RVvibiYJlO8GJFfK5dk/kkKgvhXcUXFVZqtwvQhMGmUWhwm?=
 =?us-ascii?Q?1VnS1rzFP5vghqlzs75YJo8pHcIUMmhTC4GcHnjF0o5CNWxRx5zcOZ7alZGg?=
 =?us-ascii?Q?zreXHPmAaOKrGp0/gh/UIolkpe+aODtWkaZS7penyQSSpuyez/Eq3M1BnhVa?=
 =?us-ascii?Q?UPG8SUYhjA9c5sxR0/7DbLTLZ81VPos1WUSHPEVIF/SSLfgeV6DSXb4EHbUY?=
 =?us-ascii?Q?ubV1/b7/GN5avlm8KYgASIstg3mFBGv34xojQifsBvLF8sCN4tIMYoCDrvdX?=
 =?us-ascii?Q?wFGtBgClBBqJma7w3S8EctjhjBJTOGH3zlO2/hgRc7wkNH+02DJfAkAciQ/o?=
 =?us-ascii?Q?UMpSQ55fOV/GZFdV0DPDkbsBn9Jk7fC5neuFbKzRbf0MG72NqEm7i3UeXNPY?=
 =?us-ascii?Q?tNayU7boREAC18vwHF/1fyDjusd1s5wZMtTuT/EhM8VRUGRS44/fCk+lGlf5?=
 =?us-ascii?Q?VB1vgRL3JtGzOuvctTFHXIjZQ2Fy60eRqWbgmQlxvFm/cBkcKlfcp0vKKTZA?=
 =?us-ascii?Q?G0IjV5GH16T4F+zRyrm/FQom1Rl9wX2zvY1lzZU3LU+zl++3Rz1NHj4ceb5O?=
 =?us-ascii?Q?nBK5DnkycJsgFUX8nYjJmYSpw4RAAljYt5zHog6QqzU68DihKMuRNFf4VAM0?=
 =?us-ascii?Q?XOOudhAH5aI/M8kPH96s5PghlMl/i4Jf1qOY0oMY1Jl9QEkFjWCMC+OelqZi?=
 =?us-ascii?Q?qNaLwpiVZmODA3fgmgvtq8hurvU7xJggbyGj9N4S3VetKv1NhoSVENFyXr84?=
 =?us-ascii?Q?OHrciWA9eL831if4mPnHKQa9jVqF2YvFq5YZACSrSAx7xbL21zxhMHcWiiZe?=
 =?us-ascii?Q?YN0ujjgyZe6e6KLMngc1i3DnG15nPxgHhwVVKEJVaqVoX3WpCOStYcba19o/?=
 =?us-ascii?Q?qAvUqL5fpjHaczXK1gem/LogyuDMuk9tPPL8TKV5WHiqJD8c9CGqN3AshI1G?=
 =?us-ascii?Q?SKQ/5k2CsmtboRifceZMrUVgmvvoNILR+bl9sdEcRUHX4pCsrekfQrZHsUQ9?=
 =?us-ascii?Q?+Vlcp+99fzdNWF2JQftm4MUnjWGSMIu6Law2roSPgj2Ba7UtzhgJj4OM4XcJ?=
 =?us-ascii?Q?ppvnhVZPWMkqKF9ikj2cYmfv08X1PW4tMu0/V7kkwfEYGt97vHEgXCE0e++c?=
 =?us-ascii?Q?j2NP9d9kwwL8t1uMZLiuu8d9GL10kb98oG/rDn96X0Ry4mgjvHDZNMjP1m6E?=
 =?us-ascii?Q?6EReIbjaDy8AAF1JUS8ngwAmO6GaLfwV/R2IBObv1HcGMZ71fXw6sSLdVvyt?=
 =?us-ascii?Q?pD7ZluZoyoHN6XLWLwuxqVGUelYd0dGnzHRxg73uxsR+25GJCCd2uMOepV0O?=
 =?us-ascii?Q?9svAzkKDt5EkAm4joYzMAPbXnz0Nb0xBGx+EsIJtL/NOiO7IZZBaKrPL8N/v?=
 =?us-ascii?Q?PAe08GqI0O/hrEHUOwkNhimp8wzY+D36HFZxDb8tvsfviln91tFfkWUG5idQ?=
 =?us-ascii?Q?OdUuDr0aQAYZblBmnDAqhVgmIyNX2mwFlh1oufDyv5olJVp46GKkxxEJcquZ?=
 =?us-ascii?Q?0Fiw1KE0AIRBz0F//5EXiagDr7WfFrqUtnHyv6S1kOo7XVQCHE5gsD1irteY?=
 =?us-ascii?Q?hcP5cvvLH4JZ4hTuGP27RveQrcexYUiK2gOqd1WaW6PEl+FgESIE1EHO//gg?=
 =?us-ascii?Q?q2c0lRqQknubI/+qy2sPiGu5E9fsqFde1fBE8z1K29TEnLSfJocad/trhxcx?=
 =?us-ascii?Q?T5II45OF1RwYfcNyYb08U1wHRknx+CIDKKzOmwV15kRzvO8VfrlTUSpFOxDR?=
 =?us-ascii?Q?AH+q/aHQ4G5bfPilPtgXckUdYysDgjq+lmekIgDPotvi83PsxIdT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bc33ec-b647-4602-da95-08dee241082a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:47.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plCJT4lqy8K6ETuGTgrJJUSZv69fGT72ARtFzM8HOoeSDO5w/5a9EKE163Fhy7oFPbYhXsGeJJ0MOJ1rVjf2kDNOh/jjTVC821bMa2K80kM1TYFSMKMG/0O7VrAHEidq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12197

From: Luke Wang <ziniu.wang_1@nxp.com>

Check pm_runtime_force_resume() return value in resume. If it fails
(clock enable failure), return immediately since accessing hardware
registers on an unclocked device would cause a kernel panic.

The early return intentionally skips enable_irq() and
sdhci_disable_irq_wakeups() because the IRQ handler reads
SDHCI_INT_STATUS, which would also fault without clocks. The PM runtime
usage counter leak only affects this already-broken device instance and
is an acceptable tradeoff to preserve system stability.

Remove the return value check for mmc_gpio_set_cd_wake(host->mmc, false)
since disable_irq_wake() called internally always returns 0.

Also return 0 explicitly on the success path instead of propagating
stale return values.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 290a3172931b..18f4905c15b9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2123,12 +2123,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 			dev_warn(dev, "Failed to restore pinctrl state\n");
 	}
 
-	pm_runtime_force_resume(dev);
-
-	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
+	mmc_gpio_set_cd_wake(host->mmc, false);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
@@ -2155,7 +2155,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
-- 
2.34.1

