Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191853BA240;
	Wed, 11 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222509; cv=fail; b=ngTrhOzzAEbH9xXJI1DrYvm63/7KGrX++mW1sEUShGHtcgMlzqT3AmeQSOpA6wufGzFA+Po2tJAbN6gO9/fEltcNJwQRXKq8WUmJGfPrdqTVmdlFINnB2Fy9FYaIfPNiaFfwRNcC2UfchlrHZV0gN5B25LPiBDnVldP5zjP5tR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222509; c=relaxed/simple;
	bh=c5TZKOurLCFSajd6+MMUv/Sw7/U17sxZQpXb/V3316A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pG8hyxhO706ZXeKfZIqq8WRA/N1SQudobc16PJYD5klx9lOF0npoEiI4TeelWIkED62vGSWSOBMsr8OZBYwMyYheGrw+fftou8cs2KsjiWUA0KAX4mx9TJQWFLLVuvEdTOGITkn3va56hdJJgAIIQrQARvCMIwBxXSrU9oOc9Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hwiquwqa; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hwiquwqa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJl1xf0PJpYDeK9K8SxjVAJcglC4hOxeMv4vRnoDYiwCMyCECZZmdG96lcBhIVZA9aFSlPRWtyGf1gcHSk1HVM6qq9vzm30HuNm2WZGonnQkMloVn35B+0c9ghi6DnLg0RPI5yQbTg1c+LCxs2/Uyb9FnYT9fojlsnbJi3qTstqFkGD4ExiPjY9GbXQPVOQFkNlfPaM9vqf1JiiTDrW4Y8AdMm2/nfK/LM0A9ZMTumByXOyEod125hBTg4NzuwMRoQmC107ZMQS5rhmmDqjtEVp2AnL308Ucgumfe441E/z/OEhbZrtoqBxMktpP+CgQpmQXhqn0r7kFwAy3pPi6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cyafBGebTGhC30s2SrV/9w+nifBpBroyZ6iYQiKfYQ=;
 b=JcJxjMYuLVP/BMzIgN7apb9S8CTltIfvxGJaAgn0sqVsmMmSGR6t8JPv4p6ZjlQ6naxckksMjbx9oOPkthMzhrjKL+21m15Ixg8dLk1f/3/Ah0JTYpuZzB1KezBhDNCHt9cMz473QmumVjfsZol4f9j5oKKAZSgN5FaxL4UCjzxvHSrxzg9VzU0eeXQdN9nbSrA6QKESzuJnkJ1te8HjAR15LMbKTXRnHzaG/AaOilrtPkhkNM9yidAKoGMthfnHfLmOINdaMXhpNyeAx/gSU4s3xm/DUpKyZh68x1nUqBNSlI2GiDtvnN08sL8UusCEjl/BfkhkrtChQAGbqISzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cyafBGebTGhC30s2SrV/9w+nifBpBroyZ6iYQiKfYQ=;
 b=hwiquwqaej33xZc2hcMNtcmEyX/b11+nEjpxz5NczIPONv3VqmXKEyxRFZxrzEk3eOp0mfSehITAWqZpBWVNzL6M39jh2TsGaq/6e08HKnP77KRy8Mq+OL5D1IXIfGNjS4MDxq37afiJWUeM5pEP/LFgVtjpgoxL2M+KHwUvJl1XQ2GmDc786wcoswCue31K2cbIrTPTY/kYVi3mKAOXgIJfQIlORJB1y19akvDk6JxzKrQsmE9RGDFq0OBPfPybBYXHPcS6g147MprIllbeTZjTyITWYuHxWIbSGT7nrX8/a/uo2k3tq8JWQ0ba67+oorqaaDUs0shfDSRbPAW+Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB10418.eurprd04.prod.outlook.com (2603:10a6:800:231::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 09:48:25 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:48:25 +0000
From: ziniu.wang_1@nxp.com
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
Subject: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Wed, 11 Mar 2026 17:50:07 +0800
Message-Id: <20260311095009.1254556-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|VI0PR04MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: 044031ad-f418-4a41-0c4b-08de7f5356d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	B4wrTTtIB2N9EHXk0AbON2IliWwuGiGhPH7kfZYcEHiJyEigzdVHzr1x3ccDRQUCutShV4lS4nVK8RZksjDjv222MaWg9+G5GtjpUpkPLagXIE9/46BuNRlX1ExYvi5ml/hvY9DrWTo9wH1eVG02ozMc4mV6IPbaCbSzwG/Pv4oOE/UaE0J6+EhqfxPILVN0gREpMqoqSggyEVpOuRE4uwTbuZbmvpHrpeUZYz/KlI7YJ3WiiodwRAcBTX1E+GFO4YJgXviYcjLZrZkLyu5Z1PGfbtQWx/QTnSGBORrVsWDVcTWgqrWa+xmmnc+HeBC60JkTz0T51qsqh1u4sa+x9rs3Ww366MEnBoB2yZeJz1JAS/bW1zdEUHzCE0uS5DWRrNLlaMCRV+dVw0KP/lNkEYjzUryifMqw28emffF1IKonANL6TWPM26Hert1b1DdvioK6ctoKP2C6Rih5yitsepVfh23TBntncmcwoaNhCTnVObM9i7WHshnjgc4N9bLHqDzgEC9GU+vDNlpdGyC7HPCA/0hnmR5I1YmDH6NDB5/vSfQNkH2L3hWAMm53K1w706syIfAmRRex/xwtW+GjhYqycj02MGCgz8OK1ZfiMY+uv4wuRcVdvNx8PXr3oCnQpeETVuo7YuoUB91UsS3M1sdk7jOSzbfXpoccrWglDKyPnyDPffYFsN8uIdHJZTIs385P5+KPGk/ZT9lTxdYcwO09yNj4E/BI4ARMjvRuXl1ztTGHc3XQScAqp5CrCMFeddS1WjuZOuUCnOT9za3nZdNEpzEd30ZXVVWf+h1yheo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12TPWopsUAi1+D5Qetfls6IZ6cukO2QUAU8/Hedb5DBfMbzvcA/YfBkhRJ9w?=
 =?us-ascii?Q?MdrGZYgYsO/0QQvOEsXRcomhwjoLLXSx717+x0f0eHVTVZdC/ym61FRY4ZYf?=
 =?us-ascii?Q?akuYkb5CU+TezQxnXHWdWgG+qSw9E2z43NLnLcMLRAR9kB/YPRORwdFLhETN?=
 =?us-ascii?Q?07aqUD9+GTxmH4u3782oPJaRG5hwiZbdl1XQvHgX9KvLJRsn8rlQIZqi8P+A?=
 =?us-ascii?Q?DTFDFSi1X3kmYVJSW2wtQEcgyPcXBqVhQUBGXG9XUZtZ2rHKnk5HkLBk1uiK?=
 =?us-ascii?Q?IO7UOA05Rv3WSqhY+7C1M3UyMOYV8w8nDuYCECyDDEMDkA43UTtUihPcRs/f?=
 =?us-ascii?Q?itd0ktwFLVQBCkPxICLiVWgyX5yrGudL1M+ZEsLtiezYCFpwA9djRJrwoLCt?=
 =?us-ascii?Q?qt5f7+o4IupU+v23nxQQ6NCz3lESXzakcW8iPkuGzEq59D7AfJJ78l2dj88H?=
 =?us-ascii?Q?DXOh4HZVZCcjIJqzq+/KWrlEftROpoiKfNjr5ebQIpsJ1nQD3c0DkBKwPOFd?=
 =?us-ascii?Q?lf0PsuCphPds1SP4q1MlctWW8JxOn5SEm83O9tkEHrgkgHnMCGExg8VuyLtY?=
 =?us-ascii?Q?C3UOE7yA6n8WKoo9hRAk0sMctWT0r2tBx/KXfYK5ktNyAUB2Jn2w3TQl5PWa?=
 =?us-ascii?Q?d3Xolt6d1ike+YHwnV8B7hgsznnNh3UOutuqcVs9wWMFg4GgP+IJs5ihuvuD?=
 =?us-ascii?Q?tVvx8Ttg05WECDAKaFrjxhTbeneZ5J1tszNUGuDbF82Zmc4kKEEp+0HhcoEm?=
 =?us-ascii?Q?CaX4Ni0Wk/TVytce5GZkxjnYXc76gGyfuac55N7r2HQ8gyThEPxwD3Vrmr/z?=
 =?us-ascii?Q?sHzEXDDYMjoVijCMKbjr5A5u73dTleuVPsnj2bvWzqy39uTb+NbKTYVVBrkX?=
 =?us-ascii?Q?7+63H4oaO3ysCQRSNKpBavh/rSirND8P50EMY/SsoRbnRqaUX5YtWkrEIKLU?=
 =?us-ascii?Q?zwoTC332ffhWzsbjEoYIFpKV7IYDKvZz6KraK74yQrVdX30/4cEzJyVMb1Hj?=
 =?us-ascii?Q?Kreghf0OTrBBHPHyqfzQfcvQ0rTll4u7U1p8iPkqCrDNK912y9KRZzTgzQpc?=
 =?us-ascii?Q?sCHX3K3MMJao8mLuLfccJVaIDJI5vWi+WAMFCBcymBqlvfGFb3DuXlu1mfaN?=
 =?us-ascii?Q?rRSzEZV/0SurQQBFNrA/0YW8wrjr9yMIz82JBUDPbJ4JAghgaO0wPl7s/f7i?=
 =?us-ascii?Q?4i2tWStUYzcuFONcdepMo1/dxyOKMhwSrJL/KLFgjmcfpq0fFcPK5LmBPV2M?=
 =?us-ascii?Q?z1wuj4YqeeZUMfUDpEFb9IQY9ovV0/SUMyo2EsfwxLa0REr3YlqrEoHLcX3n?=
 =?us-ascii?Q?wT4BGttadQLAaUKwFFssFlGETUJhEOCIPpRgQ6yxHJvwdOEQ2OAfUByTTLXo?=
 =?us-ascii?Q?ZmRprQz/l/Ha5Shzn/XXAYo0gT8V0M1EAXrW/Uoqwjmp78yTvzs+hNRD9MP+?=
 =?us-ascii?Q?Mkr8EtzrHOE+Iua3LtYa+9icedkLUfBtVqGVaMNj2YXwG4jN+80azfI+0/zs?=
 =?us-ascii?Q?PlBl1G0Oejs2ckR3D4wkziGZfBaigObpLN2VnpdvzI4eiaHNyjK5dW0zfn51?=
 =?us-ascii?Q?4avAJ64Z1UTDB2fWa4IuF5mnN6SXfae4goZ3I+iWQyjkN47YgTMyCooLfE97?=
 =?us-ascii?Q?b4jry4KPzQ1mb7EcEKqnv7I/MIkb/y2bcvmHU0OqhVwhJMo1ovIGGxEWH4VM?=
 =?us-ascii?Q?fpCJp5MK0ruVVJ+tuBomyGUp5HFIBWJwCUCnLFqHDdBciIlH1efg2fYJwT90?=
 =?us-ascii?Q?JfKfXbtcpQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044031ad-f418-4a41-0c4b-08de7f5356d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:48:25.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezi9JdqHB0POUkaMrcbAVrJ2Qy9Y1Y3K/xCUCwY55AOLLi7nlR9nCmRicMzGPY6GcYXUT58VB1K3JUKK5LSUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10418

From: Luke Wang <ziniu.wang_1@nxp.com>

Add sdhci_get_property() call to parse common SDHCI DT properties,
including "bus-width = <1>" which sets SDHCI_QUIRK_FORCE_1_BIT_DATA
quirk for 1-bit data bus width configuration.

Remove the duplicate "no-1-8-v" property parsing since
sdhci_get_property() already handles it.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 97461e20425d..b607d4ffc562 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1813,8 +1813,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
 				&boarddata->strobe_dll_delay_target);
-	if (of_property_read_bool(np, "no-1-8-v"))
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
@@ -1833,6 +1831,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	sdhci_get_property(pdev);
+
 	/* HS400/HS400ES require 8 bit bus */
 	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
 		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-- 
2.34.1

