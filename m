Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DE2E041D;
	Wed,  3 Dec 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755832; cv=fail; b=CzmmCilUxzdXC4P6inCtx1yT+SXHdWTOh3QhP59V+LBPOqHSkRrEQex5Wa9xYaqtPCsA8+8sk5pnwG+x2skK3wW3dBMtAUcjGJZEYamK4oiRa+vLU3SqGbwyQ/pE/6NSuzMlKyAMeKjO07AyZzrh++rQbcqBXtD3H48eg3YEz3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755832; c=relaxed/simple;
	bh=5/hIdbh/3QAEAkvT7y/j0yan9Hhrc2ffFx3z4oXPdSw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SAYbNMx3qyyZ2DWgJqMlafSJvtIobtI8wJUN5mAJlEqu0PqgUGt/S3zOi8mIy5mvNfC61kruCTtJBCgzx928nRpD6VZY0XeVibvTKzvNCvUoUXvBAbfyp4h2teMiE7fzHlRYHWZytn5OHGUcY//xmDeS8ZEwBDndCR0TcwZqd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZaLxcCpp; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZaLxcCpp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNjbJLxYhIMOsfnV+tDSNuPkmzaxFYC1nTgqltRzlq5p3tE76rbu0qAxVrPReP5VoRT0FyHLokkgaM7me9bHICuz3YhOkUift8lUsHqAyyJzZ29HnsAAUnSOZjpEhznNK5ILPrQM1TIlo8B+MvrT75NRm28cBBGVG/RzYBy/N8gXX+qj45C6Vq+XQtZfdNlCo+DnOMy4BNq1dmOK6eXd5tK8Qo5a84tN1hVJsGu6Qo80TqY6/heYoh/DTda2eMQ0cPD8uv2CkY1sibKcKXXog3LNFjmXIaatcf0v1ub+d4ieHsdhnuWxxiC5HLEFGld++RUrwl1o0vVCxkOKc9aLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGgKZoSLxfc6mxXg2Yahlv/iCM/FNCuAK97K1B8mESo=;
 b=FbHvfP0yBFgPkaMdhQxM1nv2fEQQMCt7KYQZiOGg2KfUHK8Mpas6tn0b5cUfU0BwSt4pZyguhVdXu4j85NI4W2SpVoiSSisD3o6T8wjscg9FRC/DTt3wkXyb1qcfD8tL0Nu6SbScybxBBWNChRgGzWILko4xZlqkkY3TnI4weAgeqhdrjG74HE+5BY2huhQy5LXrizSkUZOZB3WIMT8tdpGGDsV8oNXMD/q8a4Lf0hDuaLHhirL68XZWyko9m3IEPNvrLTreArLbXdaR4LQn6Kp28oOxnNP4iW4oNu4wCACJsHEtKnwow16gnyRqs8FTGfprDULyfj472nmdN8gFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGgKZoSLxfc6mxXg2Yahlv/iCM/FNCuAK97K1B8mESo=;
 b=ZaLxcCppCEkUWRgZ8ggrA/tpDY+eKNAc7rgVToARsmoaRwkfXownIF8rWW/y1DRIDdESA6PfZ566ZT/h1JUjm499ChFWo41lOPkHJmJ+m3JZIGghOyhb1KBDN5jSYc0rKYi8O7ql5hcYZa/l2kNhIgIFBrFIJLfw+hjyH6yqrkEP9VpNic18ikRg38VqhH6K3rO9Uhi61r5vCLr3AMDs0NsrUSysFeOZcflGNXxpm0fRAwWlDNxaMp+zEeKtwHBW7EapviJ1I+50YZe2OFtTFLhEyE9tE4Xu+PwKTQmfXtjWbd7H8T+CHreV4xJRVhNu9/mUS1139S39ed1P2EPmVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:57:07 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:57:07 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	haibo.chen@nxp.com,
	ulf.hansson@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: wait for data transfer completion before reset
Date: Wed,  3 Dec 2025 17:58:50 +0800
Message-Id: <20251203095850.4019706-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: a19aff6a-852c-476a-7b98-08de32525183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3cXr7IRz/VbGb8YE3ZNNDhx82UarCeedma8WVQVcCEDmNbi+naqvOymbdwNK?=
 =?us-ascii?Q?SWThHyEOPQF4bn/NFDq4gKVzX/jR1nwgThUAHNr+cJrSgLRR8gwSAzHno2Y1?=
 =?us-ascii?Q?VlMttcJil41L18SjOXgFkgwKrQcz+hWp9nH25Tl+bu5V4mmcebPV2P6y/O/4?=
 =?us-ascii?Q?cTprXXnNsx0iuJomBqlB//94Xh/47weiKBmccqG7OQAd9yrQL/nj/zh6NH1S?=
 =?us-ascii?Q?9dz9mIfR+mrcj1QEDGkaw+ZYytlDce5bZywWkjMXvYh/1sgtUyOc4Im9uLB7?=
 =?us-ascii?Q?ddHy8fVGykMhC+5bZqYU+FOV0ji1yMzBRqbPKg0fOinbti9ZHuKEt25sZnCp?=
 =?us-ascii?Q?bYXF+8Qw8l2AlfO5BAbpjgubvgIvnQbSkP3u6DphDHmWb3O+RGld8J+15n9m?=
 =?us-ascii?Q?RWsFtTHl+Qgo3vQzAuGe/5zuIiKMb0mIMLRhDsJ2FZ2ZBX/JqoB+8ttH/9KL?=
 =?us-ascii?Q?l2LOS4qrDVDcBY0tYLviZrYXDT9OIeGAjHUvrmOrm9Q6ceEu10bjyFeRFgMP?=
 =?us-ascii?Q?y1q2AcbUIUHquxNgfsLFRrIF/DaVxKdwQGmBFKCfVRZ+Y8wFvZ0vz9+kYI1+?=
 =?us-ascii?Q?reKSMcDymr6Avv/55Gr0g/d0qFdC3Gs4e0HZtq4zGp9twFjeiIWC/JIvvS+o?=
 =?us-ascii?Q?bdPxYUDs5Ri/kkEE68h+ck2rLndzX48lm992WJU54Gdvgbe0isjcvYMJx0cw?=
 =?us-ascii?Q?sp0lmOKqhFrTxaFUjKEeyxLjMCLjT4ZJrZ0Z3jLg0Oyz1bzuulQVUtXGWWJu?=
 =?us-ascii?Q?79H/XDegQIfgpFM3u5YKtSh92DBhaWD8SFvu/KteIghrYtiVAQlPzxuJQkaU?=
 =?us-ascii?Q?Xth5UA3gHAbIXDqunu9fsnE1fJ7LiWKwgw/UKwQQGYCROaFopJ8sqSa/8pVa?=
 =?us-ascii?Q?wpSa5ZXS+eZ290iYCATp81/tNMjVUohUPberTOv0bYfE64cubdYghXCwbjeu?=
 =?us-ascii?Q?2XhsM1zEh4wpHPz3G7YQg/8KYC49YLR35192fNCGhdzWELZudSlkpssT+jI7?=
 =?us-ascii?Q?FmNuTFOZ3DqQzTTFus7l5XQeIAwJaQ5zCXE5U/WcEbK07eTI6DVgeFlTh3lw?=
 =?us-ascii?Q?xIJNHAcw/tiGkG640Nwm9gpZaqIC2TMiYGQUoDP5QFUKOGjzwO9szLH7XjZu?=
 =?us-ascii?Q?wpkTrfLJNPYrCGM/iLYLRJyr3qP/4iH0B9svQMwi2l0PyR/Nw4K89ddVMkcT?=
 =?us-ascii?Q?twGfnCdbIGqtCpr/8f8NHJJCl9uc+8hFb98efR4qlxuYVUyRKBICG+iQgUDx?=
 =?us-ascii?Q?3oQoorSwbPJEFA1GBURI09MV06On616VKTjsEAuH4keH5qCznnKglPx/Dl5B?=
 =?us-ascii?Q?m+b/G5wbA/LChCYOWvLrqe/7Ro4Z7berTDqzdUUFlCqdzqO4n2yZY+7QngVl?=
 =?us-ascii?Q?Fg+eL0E0aYOZMoSfm4kYPlU6Sq/aeyF+bSBmqB8NTylBLKcKPfSEy3GV0XWP?=
 =?us-ascii?Q?oeBVcVpIHo114wD5M3lvUCEsl5VGg+1/q5VroUWCMvUpZatUmfW54J6zwEXQ?=
 =?us-ascii?Q?hlVO8O8JGyYocW9NAXKgo9Hiw9sJMoVgn3nU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0TGeCybjEfNqvc24I0L242m9xdXc4HfyYx7POUp17bwT6fNLQlqpZHm/6Ve?=
 =?us-ascii?Q?8YBSEIpXJdg7cVdyfX0NC/BYQg+TKKu4fiO3kwU4rYLlJvcUSTGf2/sDaLjG?=
 =?us-ascii?Q?YJhJuBGmZ0Fy570SvtFTWIKQLP9eiAvaCuNr/XWQlG++WL5UjCYxFFrlr8Bk?=
 =?us-ascii?Q?TTJv363Thj3rCNgK8ETo6nRVBqHzILRtSztDVhMkUnJuE+KTAVgRH9//qB+7?=
 =?us-ascii?Q?QQZ1Dp04jifDByefOVveeDQrQiNAfRjM6F+nypfz9WKHpDZu4ow6nLBuLTkX?=
 =?us-ascii?Q?8XswM8lPOTNpP5IMbRyVo73xaiArFctPPA+gkqmK8FxV1ToavWE2y4FA75dH?=
 =?us-ascii?Q?TkSvUFOFhADrPZHUwTpAULi7nslLdK37hd1SAuk+X5nUVWICifQxm2Ut9m4t?=
 =?us-ascii?Q?gj6jxERV/8lqIqthaJOHLxLFWy7ZhIF+BBLW/xH02Yjyin4x76BW7wKcs9bg?=
 =?us-ascii?Q?NFv+tu+sjhjHw87U6AjAq0RRVKXG7olAMSpi+tmgYMJLDIs/WjYwUjvL1Z+/?=
 =?us-ascii?Q?6TSil95xW5UdYaZjaPc5sy6zNHnSMc35E3Ol+su9OGbaZwd9zJTUNQhKk4Zt?=
 =?us-ascii?Q?VwLiGM/O+Il53wuEFaynIE9z7AZxgO/3t60Mu+B7m8JL3nJijUKvPop3zr9i?=
 =?us-ascii?Q?BZq0ApB+JfYEmeOr75BmnoSl47viFU1o3vHcKdB1mzippo4Y0R5tZPlzA7hs?=
 =?us-ascii?Q?E8CjkZ+yqNAXbc4N4/pz2DW9M8YP8K4a/pLobmIVhVY6T+5HRDy7NgLx7A5+?=
 =?us-ascii?Q?3DnU5h7d2vDeVjNtrSTb+0of1TcoWRLABjkZLh+Iz7Lcup4PlVpQ1FoK31UN?=
 =?us-ascii?Q?buZl3ofSuNOCk7vSX+naPJvqku3S3+QW++qCfj8IHj/0YA/goo6HNClaiQw9?=
 =?us-ascii?Q?16pe8XoGqKjSMkUFxNd0ewahaFFju5lkX9uE/Ejho3fehRKKUEiTsfIydKvl?=
 =?us-ascii?Q?WLMqp4z3PJLjoFx4jSiiR43o7u1y8a+NWSLihTp74TBo+wvYoLArp2PswxsT?=
 =?us-ascii?Q?LmP0nHZYQeHNu0UpGbIly09swphCPzvy//Kmy85wkT/N0Ls2tOZk6xEmeZVf?=
 =?us-ascii?Q?8HTpSZFxGf51NpTGlDUnLk0uwgJ80OYJR1SyB0+RIHo4+H+doGyIoDuqF44P?=
 =?us-ascii?Q?iUcErS4C4F6BQ90WSCuG2LT4fXtPVFMJW6uBv907BrmI9v4EgL2C9Hiwvb/R?=
 =?us-ascii?Q?01WRXi05O+/ZCxvG+wXMMmXbK/lWPOP3QReTsbeY21kdfWsfKWnXflgPbgdL?=
 =?us-ascii?Q?0C24gJsN3tPb5fX8vNA4phUt2PqqnFAlXn0cZ/j8xd/XfND4bPxthqSiI4gn?=
 =?us-ascii?Q?tbrkBd5Zb1KA18UJvoldXoM36x3oH0ync+eeBrdAjBeoHBsmDbKpfnemsbNZ?=
 =?us-ascii?Q?Saab64LuWcGm5HvBik85GVS+3f9Jtl1s9BJhFuAMosIXpR6KN+KauJ3u2HCC?=
 =?us-ascii?Q?TaldB/CMM0kY7q3HD1YfIOTiorheEn8tAmWYJqmYkjrs4T1/fYQUPYeRxSI4?=
 =?us-ascii?Q?BZhDeEjK6FUSsF4TvRJHY1EYU77cvAPg54YjmVCmCcyjeJOEnXPdNd7snuP/?=
 =?us-ascii?Q?Vi0MQBIuKaNHxBTO1Gy1lYBrdZLqsfwd3beCw+LX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19aff6a-852c-476a-7b98-08de32525183
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:57:07.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/3S40OJrPv0itIh/1spCWCTJpNrxVX+wSma2/nIGE7tP7Ieoc6VeveNGyMTCeLGhY8wY2sjVcqBESIK2MizjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Luke Wang <ziniu.wang_1@nxp.com>

On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus)
cause system hangs and reboots during manual tuning. These cards exhibit
large gaps (~16us) between tuning command response and data transmission.
When CRC errors occur during tuning, the code assumes data errors even
tuning data hasn't been fully received and then reset host data circuit.

Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
make sure no active data transfers. Previously, resetting while data was
in-flight caused unknown behavior. This patch adds polling for data
transfer completion before executing resets.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673b0f..affde1936510 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1453,6 +1453,21 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	u32 present_state;
+	int ret;
+
+	/*
+	 * For data or full reset, ensure any active data transfer completes
+	 * before resetting to avoid system hang.
+	 */
+	if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
+		ret = readl_poll_timeout_atomic(host->ioaddr + ESDHC_PRSSTAT, present_state,
+						!(present_state & SDHCI_DATA_INHIBIT), 2, 100000);
+		if (ret == -ETIMEDOUT)
+			dev_warn(mmc_dev(host->mmc),
+				 "timeout waiting for data transfer completion\n");
+	}
+
 	sdhci_and_cqhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.34.1

