Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010032.outbound.protection.outlook.com [52.101.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA117BEC1;
	Tue, 27 Aug 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744109; cv=fail; b=S6JmHxjMSkZItdP6NsqBpbSvfXMdnj/YteFk2zAz6gyxVoPn8HDHQdt5D9gKyYzZsYoYsrod6lzXNpYloOROK3nUSbSbCAjqZPYiKT3vqRaZaNoZ7yT7wEQCeJkyiCokfxxewycLFD5PmlwxAn6bUHa5TrOnk/+rS9L8SEUci/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744109; c=relaxed/simple;
	bh=HLmb+oWGzAToN/fOb4UKksZbmTEmxx7VMMCA6v9zkZ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6ye0TXKhCAFURZiA+Bzfh6CCNWexJwlq6spPVr+HXj6tp9jcML7hmeMZvPYVCeRkt3y+d/PqWuq6//3OHJj/pK93lawIx0XDAkBlU8ndnvf+gbeZFnYcnhGBPrjQGLkr/XbE5yAiET99SNTso0rw9CoStF57Qju4Exllh9ZzCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d0lRWB9Q; arc=fail smtp.client-ip=52.101.128.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d0lRWB9Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHIsvLJrEns7U9OnoQ2wPChroo0ButKY3pgxvE665Oa/5i+vl2O9YLXAyJhggdiyCEk33+t3SVCIebPtGGe4VPeixq2csKMi/lSv7FYksKfwzYk5lANqYLdoNIFbucT0KcuvZHeC18lYrmCmGD0ctagP876utj32+g6B5sta9wR7DVYhfXgJc8/XYVAUuUoUwg6xi5zUKstE5yTPSTIiVawGyTaNU8RkFg9j9QXpxpl0m2UozmphS7JHzn0QdqTOWNkhKDSe0LbqzEcqLftGbO+YwNccgosPFZK8gu7usdXfJ94bK4mXdr2ZHJG4/C64ncwKP3p6tn85tO8NWzXhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFNVBON9I5bH62fajLq5bTq3GknanUgV1wKqc6u83As=;
 b=Cri3nXnVnDzAr2qB7SMKoVOT3SV5bhxWhnmn2bYbuEu1CQTB5Idjci29HuBA4E/bB/oH6A9r91qHCVUZ97VumoDkUHVN2kuydhDCd/ubh8BqDt3LkwPjRqdlfRrdf+pVzzIIjK7haVPn0AAhUl83wMrLEMFqaqN66H59JIQoG858VUPEagspVclbiu3Vi+FO7kGk8McYotXjPdrvQV1HXId/7lyPtpF4q9/DySyUt079fWDjczsPQrgTbjcOO6vYt2SVHybAZsNULUsibvDMuILsINa13rTIXynxUaNBC2SEOnEf5aRyT78veMFVsBpOyZWYfy5uT8JOjH9AUPYp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFNVBON9I5bH62fajLq5bTq3GknanUgV1wKqc6u83As=;
 b=d0lRWB9QR75hYmwYccaxR0oEvj7o2F7pGUezsgqCLsZ5welnaBmHitSuY0kBePFZd2GTal7MuAVP4BNL5+ViSCzy/6/OghQ7inWZp452W09mZQBdAOPatLkm8IiWOSvm26ZNPGNfVtBuQdziytm8Nx8Oa5+ZvToVTFvdwWUoSOlWztB8jal03akq/XDjzu/ROPCJ/reBvhEjAkIebeO5f1LmR40kt9fk0n/R48y7GZDI+h0vI/lyZo70tQqwLciZIXnCwydGMsI1llDIyEu4GroHVEMOziESOdDJsKpTacugMUZN4JxNWntz5m47YnjsmVNqVuq1eh02kX3cnDkfcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:35:04 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:35:04 +0000
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
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:41 -0600
Message-Id: <20240827074857.2671808-4-xirui.zhang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SI6PR06MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8b4e6a-366a-48ad-3ba8-08dcc66ac43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xYj42Nex7njvRC5TgMa5+e1/+RQkrReOZ5ctA1xJjicwiiu2v3OrmEq8U7XM?=
 =?us-ascii?Q?U/C4j3QS0rdzGBxO0P34x7Tnq3qW4e6P+GU1ie8gOri/5Zcr0x40KSD3Rra7?=
 =?us-ascii?Q?r2ErcmUn0jq019G8rFeSo8kve9e0UXlqiT0bqY2YHbkRSc+tZyYkBq2SXHRC?=
 =?us-ascii?Q?+G7zOGV1Dnn4hxfPuUnB41XFv8nzTVDXGkjxOctNtoGtvQW2Ho4rXEcAdXQP?=
 =?us-ascii?Q?+vPTWK5DyOPaB8wlod643asdpqY4lJ2YoY384vrVgC1RjsXRSSxu4FJUJWXs?=
 =?us-ascii?Q?zZhiTj2LF6fGlRzhPpueMYsIst79FrafDLNFmXi+PJoqb6w8E/L9m9JH3/ar?=
 =?us-ascii?Q?+5nMsUAH02/SlCb6m2lvg7gCjmSAQ9YZhcWDEFzXDnfp0jZUBHbdsecz64AI?=
 =?us-ascii?Q?uO8pmINj/SAtGRYXitsW9h3z2rJL083XaG3LIGCo7Skvw5MDIsYH9Rv13ezs?=
 =?us-ascii?Q?Mw4zcjVvHT73dPVh2xn8Ubfut2m+KzfErhQdJQ2tJu1Ql1qxyGsydEpNg9EB?=
 =?us-ascii?Q?nAa/0S0d+EbvqXy6ZD63I7y7DHgrFeCeY4wlyrC6KEoxlH+CzK+IvGXJQJ8K?=
 =?us-ascii?Q?WuTXG9ORV41QgEIal/uNCiEBpzqojInGQpKlw1G4sjIQgrzH0wERnAHtqALd?=
 =?us-ascii?Q?BaMdSTZ/vnjqE72O50vEFOxF5HP9WaKQQ/NHtUMCncQV9rwirOEQmW/xCUWe?=
 =?us-ascii?Q?NBTkx35QfXgQ94JRSQtgvkHnow+lop9WoVkO+kOinKKMTqcBBdbtghgWR90f?=
 =?us-ascii?Q?QjQ42I0ffz5OFZLjFq6l8WRQelBAk5/WtNe9nRgq+k5JU5u3Z8R4rOoG5ck+?=
 =?us-ascii?Q?8Uw17ZCKgtSIrGx21g3/wP2M0SHs6pxFraC7Ug1sKbywjUxsAVhzhC1r9OEe?=
 =?us-ascii?Q?pmqNlGtFSKVx3zQxu3HArZBEjtXwU2MefziIDSPpaMrLtENTch+adfhmEk+k?=
 =?us-ascii?Q?a5i3OFm7WmDDqbZWZeYZdT6yLUL1WusBJ92Cy/lET/2dwZewUgS11mdwNNhr?=
 =?us-ascii?Q?9CpnaW5LNrcDb53b7dQ/X0Z503xvtumx5jyY4/lzpDdItUriFdG/+F0nV0SK?=
 =?us-ascii?Q?MqH9yzRQWgK2RsNQ464lwCHKr2A/cumpPj4sRuUVmiCfOUFtzFb7J0sdPip8?=
 =?us-ascii?Q?rR2L0p62As2ECvwQGLJWgiWAWtY18vxBa6Oe9ONANn9HU0HfKQ2UqX2aS2Je?=
 =?us-ascii?Q?hw7fitJo/RdcrhscVppuvRocESlczMQNvw1H4TbRsW6fKyTdvCFT3IwHBkOq?=
 =?us-ascii?Q?WwWlVZ5bc6kUZ0a7/gLJKQLm5e6fF1JB83SuAX3dAusu1JceVo7LT83+Dcvp?=
 =?us-ascii?Q?duIPRiHAyMAWsGxbXTZb+WqaNRsYgYOoC5RNdT9z5bJLu3o252u0JjSxguVs?=
 =?us-ascii?Q?jQf0nET97X7twp38P+HiUKbhfHkHTBG/bSR31i+HDny5/v9NpOk/0RSQc4Y1?=
 =?us-ascii?Q?z4RGEH0xRIC5uzTweZ4dxisO6Ol0qxPF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZZ7lHH/9M/QAbKRvLqcE2ODYbVjIyFemiugehf9A+CcPzty2Bte2ZMS6fpc?=
 =?us-ascii?Q?GqETNL41lRkmr3GUQgSuwjtL0rbRuGKVgJ//7cFz1ehXs292zCk0hBAqykCn?=
 =?us-ascii?Q?YxWNEtm1j/IYji61t9KqIKeEgpK7m0jDLgQCr++pVo5Z/VC3zixPpDuPsrjU?=
 =?us-ascii?Q?KwiEjNiP3ppiIQvYB2XqOVz78jNHWboJI54vL9Lp5y0KHUafZZ6K/w+cSY+G?=
 =?us-ascii?Q?QpTf5u+cO7ki7cgTOKM5ryEUg0P1v/Ltf1Z73mCSU3RyP8iBJVtBCsONhwfn?=
 =?us-ascii?Q?t3eB/bBIgSmPihKTLSqoL6GiMv5lG6Zp0dQBQNimkOcdTzW31EBWdh+W2TMu?=
 =?us-ascii?Q?gkawlhiSHDzY0Gp0gVaoPZO5kSyQQCtSm37cy5ru61IRSooS9dlO4cjBTTTv?=
 =?us-ascii?Q?gxfWKGri5KjLKkw7+JWL69XWqrOEjBjKwlpLRvaifI9HOR9S5Ebw18UBGDr0?=
 =?us-ascii?Q?pbgGCC8A20zvFePZyNMrD0c1PByRQ06p+R025rjXbFiFszNLMiweHCRkevAw?=
 =?us-ascii?Q?ukFUPtxXaf5cYmkpZZ6cYOKmRTQix9G4VsRimOH5s+K5AzF2WNxttheUAPtk?=
 =?us-ascii?Q?pIfsRb1c9P90KHMC49YYphXDg44ICGm1LMHLHXWz6RJMLwrVdn0ifySBVR1I?=
 =?us-ascii?Q?1et8pJeEYppKEIG5bMiNMDNMEFTrvtsv8JqnScfgEDgDo6lCXkzrS0yNbuiY?=
 =?us-ascii?Q?40UalLKmLziL2rUNTPr27LSZ6+5ZGsOddTkuho3m7nR17nP5T5r/2dEC0dww?=
 =?us-ascii?Q?YwGZ0GAhuDmgnN2EOiG9qNqn+KcWX1a6Yzxih0+5xyJJWyoNGY+1sxqVueN6?=
 =?us-ascii?Q?bcDhBdTsVmqxFVIltDElYdF0fQO8WNr3eFRctzNN4A91bR+mrCImthXJbY6H?=
 =?us-ascii?Q?kF5D/DDq0T8tKhvvfPwzE/OQxsSgTeDJu1FNH2e2oSntaS0nQamaOJIxf11o?=
 =?us-ascii?Q?9r5/GvhWaWfmpjkDsZipX3dag3WAKOZIw7H0fIFKdHWSTMwJYLrHr4eNZc32?=
 =?us-ascii?Q?+jThPxjRY8YawIHGPTeyjl1itqeViN81p5kliwgvX2AnmUSKEhhPxnhrLMXi?=
 =?us-ascii?Q?/6Jr1t062ONt/c0KKDX/oaAa44DNWWKLPKBWyCos75vBPSR+YRVPd4h8XUh4?=
 =?us-ascii?Q?6pO7JzTI9X4KxxhfDc3GHUrLhlwXiMSkvCctT3viY+gwpWSZePTJMtV1rNfP?=
 =?us-ascii?Q?DMimU2E7Wc1pSSzEzRfjwWOyFaXKsQ6Ci1+T6JkaOtILm9biAMqdg6KN8tB+?=
 =?us-ascii?Q?4jGyyQ2ieEEQjctHZZuM1F7WPgAyGLJJG6HBw6XdZjPqvhynR8v8YfrReNSj?=
 =?us-ascii?Q?itPNY+PK1Y9+0/B00haJAQLnjQEsiXlVRVpeJpoFNlOwrDE5aSP+UwAQ0sb9?=
 =?us-ascii?Q?keq2AwjxAtDM906AWXJlqNWLoIDXxTrHGmcCKGDtNG4kGrzH5yFj9xXjUsnV?=
 =?us-ascii?Q?ejbPds+e8IaMbiq8X6P3ac2x9iTsk9AtB90mxUKdGqgHC1l92XhS4qt+riBI?=
 =?us-ascii?Q?zpcKJP1UGUAEAeaAizCoHvXau2lcapf5gvyBaKG3Vi7bog2ub5WCdr5nK4er?=
 =?us-ascii?Q?939nIVs6dg9fihX/so7iOEMZRbEBlxm+QadhLRs8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8b4e6a-366a-48ad-3ba8-08dcc66ac43a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:35:04.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciPCfXvhn9SllLJQCqhMffuUVxgpM+bdYZtcRWnqDdajEkae+0lQO9g1GAEhBCjQ/gaJEVlqZxiRr9E7P4Us4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 28 +++------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 6099756e59b3..aef28cf807b0 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -120,42 +120,26 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 static int dw_mci_hi3798cv200_init(struct dw_mci *host)
 {
 	struct hi3798cv200_priv *priv;
-	int ret;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
+	priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
 	if (IS_ERR(priv->sample_clk)) {
 		dev_err(host->dev, "failed to get ciu-sample clock\n");
 		return PTR_ERR(priv->sample_clk);
 	}
 
-	priv->drive_clk = devm_clk_get(host->dev, "ciu-drive");
+	priv->drive_clk = devm_clk_get_enabled(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drive_clk)) {
 		dev_err(host->dev, "failed to get ciu-drive clock\n");
 		return PTR_ERR(priv->drive_clk);
 	}
 
-	ret = clk_prepare_enable(priv->sample_clk);
-	if (ret) {
-		dev_err(host->dev, "failed to enable ciu-sample clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(priv->drive_clk);
-	if (ret) {
-		dev_err(host->dev, "failed to enable ciu-drive clock\n");
-		goto disable_sample_clk;
-	}
-
 	host->priv = priv;
-	return 0;
 
-disable_sample_clk:
-	clk_disable_unprepare(priv->sample_clk);
-	return ret;
+	return 0;
 }
 
 static const struct dw_mci_drv_data hi3798cv200_data = {
@@ -172,12 +156,6 @@ static int dw_mci_hi3798cv200_probe(struct platform_device *pdev)
 
 static void dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 {
-	struct dw_mci *host = platform_get_drvdata(pdev);
-	struct hi3798cv200_priv *priv = host->priv;
-
-	clk_disable_unprepare(priv->drive_clk);
-	clk_disable_unprepare(priv->sample_clk);
-
 	dw_mci_pltfm_remove(pdev);
 }
 
-- 
2.25.1

