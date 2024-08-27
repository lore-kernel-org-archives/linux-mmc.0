Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010013.outbound.protection.outlook.com [52.101.128.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F08155C9E;
	Tue, 27 Aug 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744166; cv=fail; b=q0WO2eoY+biGTu/BIbzLsWFbv5rvZQzs9BgVbcnC63T0XbicQ3BcGjvR2e1iC4bsAYMq6UvAUQFdIskg+gcbqnimO+dXWFiwp0R8pMsOmHTmGnrHNkzzwJ9o2Giqu9OfSDmRAzRF7EMw/m4w04Ng9LruFJnSpkjpcLOrida+xc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744166; c=relaxed/simple;
	bh=oB1h09ThyZNkDo7GizzXTc/B+4i55hU0bHc9kDPRL98=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UENvCbBJJ545Ad2baHRVwJt+h6Wr1eAG6op+10X3G3SwUspV6roZk6f8bqvvBlNRrdYRvLIXJhx0wQ/GMtWBpSo3H1dIdyLhYRAtW+BWLho1Rrhw3pRf4yZ1sTGf614u+sn65aZ2UTJg/MSSXLQeCRg+JWVhlXtX1w6p9NfIN6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZwPCSyk8; arc=fail smtp.client-ip=52.101.128.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZwPCSyk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq5/e5/E5TUq9IDtqgN54pbT9HYXpAkWKsh/Xv0ZsirorJyhcihxa57x0DaVtaq5cJxnbeIgGybuGybUrAtgcpwPfGul0wux7GZKTF+t/x2o5Tnr1s7c7pdCPstwkG+641PPg+zNgxlqUGxyaxIGIgODZb9V0g/KkbVa9RZ/VXAezt+2Q7ATL1/vdaEFfbtL+Dg9o7hSY3ZxEM6kLLfDUKXslRXJ2eJzc3Bd0DLx6dTRrULnBKU4hZI56kjnNuibbVPp2E2SWHmoEPLLjnYzpeQ9PaR6QMOZNEWXLjnUNcW45qmIrgCKeAQVd4MywzBPZWbB+R/7nzYhqRwIkZjB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPJBExZK03MZKRGwDrFzKjbb+YooZH1A4LimPbJTXKQ=;
 b=zFbtKYyW3yh5/EnCWbzyDiyHWrwofOA3oH0LPahZg7HVsALhwqJE6I5PduGsB3zyKle6lie4ja6/o6X75sWa+svf6y2nAjourp3BakfZkUma4gbVEQPh8N3yfmnMMVj2WE+Xv7vkPTUUNgbSaRN6u16qAnyX7mkAAjzo3Y8NZ7EiXmis37RTQAntXMuMlVuvmZ3IxKz2zVLif1+roOFnA1oSBXtsC1zoseBNmyC3PflQSae3e7Zo6xIMvSWZ3dLj97Tzmr6wjBrDZUpDFETaFgHhompRq6NV3MsAfrZDvx4R0qP3qvdhpEbexL6VNRb0QzDcg6s5mhTkTdCa+qoXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPJBExZK03MZKRGwDrFzKjbb+YooZH1A4LimPbJTXKQ=;
 b=ZwPCSyk8ipbbuubhHAc3swSZRZ4P13JIfJOsGPSvZOx3GvxgTJoP9Z+NXXUilegTO7MlMFiMHajCQIUq0/ygYfciphD2A/6+Py9cfQhk9aYbor0ft6Xt69HI+HpcbEKNJLQW3sRFf6vhd9NKYtOdl4Q3RO4bdd3Wtjcc5VCdeIdNA0AJCmkJNnnnYHk6rfvHjjfXV5MLOF9Jo30BD7XlAbJVB4E+XUM2X7yKN68Z4mNBSgjWPHfewGc7wYJVTSe6b1d3F4z8g4kSrhD3s74BYzo7Ix8YtKcFdsI+L/Z3a73FB3bMl3tpQw6JYB9GTB3+NBQPBZLKl2BDxt3WIi5qeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SEZPR06MB5047.apcprd06.prod.outlook.com (2603:1096:101:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 07:35:57 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:35:57 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:45 -0600
Message-Id: <20240827074857.2671808-8-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SEZPR06MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: a095adc9-4625-4049-4f3f-08dcc66ae3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AkdrCBMoD/vL623Sn1pIYXrd/atW0zAjDIhO2crmPdw7Wmaa3vGsz0CyJHmF?=
 =?us-ascii?Q?epGVgvzp7DvQ3UtXoOjo8HfUADp7GFJZSXZdLe1nZM8e6hKRb2NBNtQbE6de?=
 =?us-ascii?Q?GSlU2sStpdute2GyNywEUNCkFteIra+EHWwMBu1jhVMNDcGRsPU1W9Ab267T?=
 =?us-ascii?Q?PBuguFQCgIevyyviiHkzkufGN1KreQZA/ziJ9DQBUU0mNrMMoW++akaRMvQe?=
 =?us-ascii?Q?aRfs9hl1lIgeDWAL4gUQ4kCC9TOSu1SYJcW7Qz9QwpLgtIBk9LE7Qp94PQO5?=
 =?us-ascii?Q?A2FPhKn+329LymoSXRA5F0D8tQwETuw9rt/viihQJdGY4h7Lig8HfJGsjpDg?=
 =?us-ascii?Q?PJKhQlpzCLBgIZiy/lO/V8Msnkl0QMDsHXUtnWrmb4novk5C/llxqBCe7ZQC?=
 =?us-ascii?Q?bq6pKdV++IKEA27lXgGxN2YDtThO4fNdD5W2ZbtKvPgHER0LmD5lHMoJKWFi?=
 =?us-ascii?Q?eKiradIxSj8HWpeo2k5Cz4DqwRl/k9F8+d4LzJn4f6smso/xsenJOMypU1KN?=
 =?us-ascii?Q?HcjkbIhBF8PPhiH1Nu6zVBKnNbWjhhYtzzobRheCP0j4jf6bPVPq/8W3U8vL?=
 =?us-ascii?Q?PI8WfWnF8Ajc9m0fkJeIo+pSjy9pzt3tDwqYHEQILl3syoAYLni89RA1gFIj?=
 =?us-ascii?Q?lB6Mg6hZzv8zhdqxGq8NP1Ol0QMJXL+JGbhZ4jvWS1tb+IU0eo/BEyOPM7Dw?=
 =?us-ascii?Q?+0Xr4ZyRuumeGI+HxPNt5mLLapPmUmKmVW4alludqWChd9uZnS+zGWrT+emt?=
 =?us-ascii?Q?zlQKY0A3uXVNnTocBeSrslg1e2PVGIvunnvDK6Q0po/EOPLPLtSy7PUlEfqo?=
 =?us-ascii?Q?8uJFI+x4GalZawolh8xB92N39vaE3agib6Ed4kSjV8T4DZCHxklsQ83PjvVO?=
 =?us-ascii?Q?KT/K93hnyE6rckg6MlK3N5mrMhyoeI0uczRLTOUYhlHHNAVXP6cLHDOxwZcO?=
 =?us-ascii?Q?JLlIbPPnoTm1WmZEtrucp7uNBr4GME+I74V7yly9/DAyn1OKch+sIHljssGd?=
 =?us-ascii?Q?5SLkzl5Dry081e7soi08T21bO3R2BJd49OCseHv6BQRgY4ztE+JK3mR6L7CO?=
 =?us-ascii?Q?dwyVIGEOgQMEVh83ERBW3yGE3Hs7jf9ex/xRfeB8Hti2faWK6Ddjgh1HEVPd?=
 =?us-ascii?Q?BTx0/Lt4nbah3HdHMev+8sV9AFtiCIXe73CJYXD1k/p70Fo5IbSYl2vcgH5H?=
 =?us-ascii?Q?pn502A8zXEHX4L9BCf2IDmS6woMegWwYSsydrcqNTzxZyTzA2qRLrOBpfbAa?=
 =?us-ascii?Q?wbTZDsyFXliqqE/gZBuR08P0ITZqr31/MI4E5RgXV/8sdytZ33MjDBkxsNfE?=
 =?us-ascii?Q?FijC8T6IyobIq1+1ZUPe8l4Vl6nLb9Bx2QlbSjL/iyaKM2CUmODqPvjpcBXx?=
 =?us-ascii?Q?+oyFzwLM4ETxppWBh+wpHG2ta/FGi6dSHN7TBmrsP23zpbvsE/iyc4t3x0Qk?=
 =?us-ascii?Q?n2zHN8M8Q72gitn8ToFWkSc5R+oTD1Ay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jG4qPfrFm9NsB6rybHWVSfusb5QOYni3C8sxJhDqjJ+c1n4I4Jn7eV67uFEY?=
 =?us-ascii?Q?NpVdkb11FScwOcbA/ip+M/gtJ3zsyTcCJCL4fGynjgTslbx5wL1TNjjOB6pV?=
 =?us-ascii?Q?5QwpWu4tjW8Cx25gn1l3ZsetLSrWMlkNksPb6LpBr5ikdTgo10GkntvlJVMu?=
 =?us-ascii?Q?Cldkf8VsOBhzFi8aQD639EvRpm1yv266MkpcBLCA/ZQaWyetUH3qvdco+TRu?=
 =?us-ascii?Q?YcOx9sZO1wTOY3M/wGvT0heV5SeAursOiHSO07YHtzlmMr/fjK0CyZTzuSKm?=
 =?us-ascii?Q?CfZmdqqulLE8sfDr4DUladZ8c2KYXtd/v0zcbQjLRKFDtSDZsXtHFMsU8434?=
 =?us-ascii?Q?2RKTNg+fqN26tduMVDGkFBC61c3Qik6DMLIV9ytPq70X/4FkyrJduaHvp2CN?=
 =?us-ascii?Q?v6AG2CkZsJgdLsFhDkV3VTlSCdfmp3utSEZtLVEEtPuMqT0BSQNi+H7zxwCe?=
 =?us-ascii?Q?HRAtXTnQas1YCJDtKtp/0s14qnoIAPgroUKhto7Zl+tVxEipf3mZlUm7ShBI?=
 =?us-ascii?Q?rDlx1HDZjikQ7wIZkHOWHMpn3V3ojV0Yuy4vlgV0jUVJpaLI2IqoZnNqQr3h?=
 =?us-ascii?Q?A7TUbjfGE9YDN6GJxqrXRKwoleM/NHHqY0jWpdfjmrlxryRDLBQQxdjiHfRG?=
 =?us-ascii?Q?cXVALhsWhXgECGVxKWFUbWPt4zaWpI3w7P01sz9pdlqtzNbi2PLtiKGcQlsF?=
 =?us-ascii?Q?A2Xvihjlb4UF3Jh/pYMjFgmQbf356SvtH3LKtLSpOe4X/ccvrUc2eqgsZFb3?=
 =?us-ascii?Q?00R1j+hJxnVyHgJ4Tr1wnNJs7jNdzuXN/SaeUEKzddeSh8YKJ8kO8ZnsuBXQ?=
 =?us-ascii?Q?3xQJMZc6Jl4/OYIkWdTvRQe7nRhB1CAUGsr5GLFuB7W4E6mvwUhzrKSl1nz4?=
 =?us-ascii?Q?OCf0aNLgp11sZHZ6HgDXYt5EsSDc+HjENDtTZTmyPNoxmhDQ1kecHO5oabPp?=
 =?us-ascii?Q?Wnyb/d5JiWF3UhFXfshl1C/D39PJ2MwLxuVCro1py+C+t57nU/gmOukC6HNF?=
 =?us-ascii?Q?xqLhh1MymaVNFZb8r5sRAxNgYDe0Wcdxtur+v+jPDPm2dXFEkl7nNGsf2Rxv?=
 =?us-ascii?Q?/vjTMjB0uwTQkj/iZFU6vgislVNuambY84rktHQ2F124jakFUkieJGbY7ysv?=
 =?us-ascii?Q?bWADDXOGuRcc4bHODpl/mTrI4enKBnra0Z6s8G0kK7HRLWZOk5J2UzbfeCqw?=
 =?us-ascii?Q?p59uHABLiBprr8DQlirRjf4ccv1nMYHqqWJ+iHetw+sbrhMzyBEgVcPwyyy6?=
 =?us-ascii?Q?t1BOhEv2zE7TGX7zpENLz3CiiM+MVF/hJ9nhbFmndD7qCKTXE01w+N9NcIfp?=
 =?us-ascii?Q?oxrxP8SCkM96ojju2rNNtcTMFu/4Za2duqNijpy9hMvL7Dt00OTpm9QXLxAP?=
 =?us-ascii?Q?I1S6l0vxB/D+royJ+3THa4TcUxBOUZsAcpWiqbMRu6QAaKJWowMuzO7lFlH7?=
 =?us-ascii?Q?zpldrDAKWgB8IoODu+S05qpL5CZMKxI0zzn6yTBaHIxqn2yPaIfLLzTGqC+Q?=
 =?us-ascii?Q?k9bImDhQJ26cSbXERYp89r8pulNZTW3S8IPOw2KRUzU9ZQv09BPqrsHv50Go?=
 =?us-ascii?Q?aR7yBW797tKP8A9qkYpxIwaOEXZutlUUknH3invN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a095adc9-4625-4049-4f3f-08dcc66ae3b3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:35:57.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krKcPgnJfSyWHkEvfHJ9SvTVWICYZrtftePIw6vSO3iYyhL1h6bSUrK/QN6quoqPbJZB5TGiWs5d2dpSqfs+pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5047

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/sdhci-milbeaut.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 83706edc9796..455e1e695ad6 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -275,39 +275,26 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
-		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
+		priv->clk_iface = devm_clk_get_enabled(&pdev->dev, "iface");
 		if (IS_ERR(priv->clk_iface)) {
 			ret = PTR_ERR(priv->clk_iface);
 			goto err;
 		}
 
-		ret = clk_prepare_enable(priv->clk_iface);
-		if (ret)
-			goto err;
-
-		priv->clk = devm_clk_get(&pdev->dev, "core");
+		priv->clk = devm_clk_get_enabled(&pdev->dev, "core");
 		if (IS_ERR(priv->clk)) {
 			ret = PTR_ERR(priv->clk);
-			goto err_clk;
+			goto err;
 		}
-
-		ret = clk_prepare_enable(priv->clk);
-		if (ret)
-			goto err_clk;
 	}
 
 	sdhci_milbeaut_init(host);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto err_add_host;
+		goto err;
 
 	return 0;
-
-err_add_host:
-	clk_disable_unprepare(priv->clk);
-err_clk:
-	clk_disable_unprepare(priv->clk_iface);
 err:
 	sdhci_free_host(host);
 	return ret;
@@ -316,14 +303,10 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 static void sdhci_milbeaut_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct f_sdhost_priv *priv = sdhci_priv(host);
 
 	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
 			  0xffffffff);
 
-	clk_disable_unprepare(priv->clk_iface);
-	clk_disable_unprepare(priv->clk);
-
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
 }
-- 
2.25.1

