Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14F176FD3;
	Tue, 27 Aug 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744189; cv=fail; b=RtwG/ul2dT2jlETdPZDdKOGsCr6RpsFNsaThaWiklzruTphOlwc2TKAk3K85l+Lx91Fh01XiEg/RlunHNxlOwuSFpTlhceVlu0scUVaIbEdEsG7I7HhXeYpuYTwnRm2bo4+YAXaI65vetP2PdUSREVZ0LadUyvr0sjlurVO2ZO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744189; c=relaxed/simple;
	bh=ctxVaJ7p1II2FYJ/Tfd0zeaFEiFvZ3twZzpUG45S6u8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2Rtn7GCwNHeAUrWH50ZQEA/pn1Ohmd1T9Nlbvks05SVbZAu0FGFvNKRjo7AyZqHr+3c7UsKga1HsRV/3Wtt/L1/GLIn9M2If6z+Mm93qjdTA+ygrF8mXcOqjPVFXHdiWAhd+ZtGy6KlB3i7qA3sv3VQvdSul0dyZoQH0iN8oJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dgigVOSe; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dgigVOSe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atNW5LZhKGH0XBzM9JQ4BVvMQSCSWRZOqNv3sWX6ejKGlpPOkDoTyGRtk9Xj/zA6s9QDhP0H7SilmzomdRRHejYV4pkum+rUUnH3eIazSKJvXW7amAvkv1+7NJ3Us7Yn727jzyOcdtNH+H5gosV7L0BDUn875h9fHK6FlU9uJCsO4D7R1xmp5hNuuVdVfSCCEUItndRwKcplSBfKvMr6QOLRSKpd/FgQqJZa6sUfOHlE8j3weWmOzqwFCv+mO6R229rqBx3mKnkw8+z9IsOUnEAeMMGxKC5SM0WMNcAaFTdv4HRC6z/ej1ed2eEXOsbZq3ZPiq/n1MV8/al9sheaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQeZ1C+yLysxsMh7x+D1RHqd/VgZh1AfNgeP17PvPZg=;
 b=Ekb4cUk77LujdmKw1sJkCu0nu3bc3hR1wGHSswAGVMoS/ZYDfLvCVHpRdzpNg27sN3PKt+LHj2b0zRtMwpF4kCte6qonh3CNEOO6ecHunfFY4u885YYNqiYYHFeeXSpKr+FSVYqBl3jZPlDKgArKkQJtJGh5eXxVkCk0RE7yhuxszaUpBSEdz0+LPjxe8xfc7S9YYTf5NaICJqShj7QwlNaAPDJmvBc6styEiPKbCFh7CEjNSMq4iYTMszv8GCJ0SJ4ZE1kq0fJNiz9Gn3DH6vo1t0ByLRP/wBjkDzaB7x/fM7vaGbS7b0UmBWPGhWOq1iJpgIw1JsLcTnsmLX+i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQeZ1C+yLysxsMh7x+D1RHqd/VgZh1AfNgeP17PvPZg=;
 b=dgigVOSeMmLT8Ta6WwuhaMDAOnOUQ3DHQUA42osT69RVGfWiuZbTtk34U3T/xp9AANkq8PG4GwjagJEYRv8H2+NOSI5T3iQ6NxrfeglkXdV64OOuv5jDIGlOoLAi9xA/Ej7pJmTCWsHAFFENgDuKj6g8QZCFmPaRx09r2pxkcFIlm9JKmBJkR89wc5krqhfPKU72jrEv+7V+OXLMnyOEZZIKqRQSIQlxzNoCcd7yAm3BxRIZpF8aZCMpQAbCXoyZnlZ9+XxefnSqewihWRoXED/GZEGKq1DPGSwqVuLFJARSdyX3g8xITh3wBn1/sVth5OWm/z4ZFTMsWsEj4GUdEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 27 Aug
 2024 07:36:23 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:36:22 +0000
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
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:47 -0600
Message-Id: <20240827074857.2671808-10-xirui.zhang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|JH0PR06MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcaed42-2224-4c48-a1ea-08dcc66af31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wMj7oCHHOF9tL8iXSALqHvrq+o/vWj9cGy9AMNu/J2t/fzve+BPf8HF0wqT?=
 =?us-ascii?Q?JnunlU9qao7OIejbqJLRQJ06ZiBlow5Ind57U8uw4zdNJLZd1tE4ZYQC+Wz6?=
 =?us-ascii?Q?YcUxUVmbNDBo0J6zQ8mvxEQyjnWCuw9vkEfElHO/IL4GFrYMRN6cIwlB4B/i?=
 =?us-ascii?Q?yI/gYWf3uQHXDO6mzui1uX/heFCAefKRI6bhAQ8QKhSICKDRpVdPCj3KS4a6?=
 =?us-ascii?Q?ltwQCmH4WHPUTtww+UzaiWVfwSboLxenbLqk9CdaiJ8XuPIi6Yu6huWZ8oQ5?=
 =?us-ascii?Q?uoIQ/Tzg+g+himceY7E+lNx8h6dbtn5SxhPQKibGfdJltZYMXePl9sN1HPHN?=
 =?us-ascii?Q?snNa7PCOHdEvwKde7voFrYN80wwdrDI78DGe8ZMAiT8hNV2zSO43Q8vbHZ9D?=
 =?us-ascii?Q?BAJj7Qv6YL+F6bMQsINilVeVxULQPnuwHbfyGa8rEnZeRndJ3oBXlnrq8AXV?=
 =?us-ascii?Q?E4sVGmjx9b6gXlPbppj8NkLisSCNlZWnCCAiHDIdO9mZ98bGK5n8M3h8WBwd?=
 =?us-ascii?Q?Q2NwNmpOUe/MxH6z+cL2Xk8EZJDGeRUblz0Qdcq/GFAzx145xoYwfiSVRDIO?=
 =?us-ascii?Q?qHHksgsjl3Csykb8qWMGgZpGUcAFM7Kp2cgxNKIUymNMz1uCWuNV/8mPIXXo?=
 =?us-ascii?Q?AJZ7swL7/2AXxVr33EtnZ2/jHJP6v3GMNt6eZeNprmCDm+yLEqiwKhcnXTIO?=
 =?us-ascii?Q?P451K7E9VbecQHE02Fkh9sqfOSpULrD/1w92xrAyL5mVY6zo3iPEELJuehW2?=
 =?us-ascii?Q?wUPmaiCZhFd1J6UJEOUaimMy6OzyJJCkAXlUJihU1JM/VSiHySKYtjIdCZ8x?=
 =?us-ascii?Q?xRq01VULYCq8zV+n8jPX2jZnfLtOF8A+sEwE6sjFSUGz8QlHizCzV5TGoz+d?=
 =?us-ascii?Q?1YSeTi7Wm3E+lxl1Yh522WCv6CBiXAdJJFFxd93itVyjvLjPO3o2v5odMdZK?=
 =?us-ascii?Q?nBgIWoW7O8wEu2BBpbTpk8h5V2VePW8XuPz9sjqYam6l3NfagjlVXnIyDa1r?=
 =?us-ascii?Q?KbU7Ieb0q+Nnyq4qqOh0hArVTLoBuak2ILGr9PNyHpF/GYjXUxDPLivdiTO/?=
 =?us-ascii?Q?Gf9lvhL/NIoq91D6yMBHQr4OHK2vcB186dH9aFHcmeNBTcnonDnGtQV4dIVh?=
 =?us-ascii?Q?6E/6NcMRg6DQNhvu9jZjYZMC5kwcgjG2g74h+7UaoRso5UF9s6yNYjwgepWK?=
 =?us-ascii?Q?I3upOoG9+cA91BUNesDxn2PCniFzJFHEGjpwOehPt71gWEk16d1vaR2kVjum?=
 =?us-ascii?Q?BJtdZWga5d2Z+Qh40OBjFv/YpEtgA440YT+kwzIhhlo99B1GeeRQmqTqH+ie?=
 =?us-ascii?Q?jUtGGUL+WThn74XQS02w2gxLrw+hxSy5a9N1fW2NLLxYfAerU4xZiVQtHMi4?=
 =?us-ascii?Q?WVKXdsqI4XE2fqP/ZXgkVqTs18xBH+6moo8cd01yZqW9BLGNFA7V7O6bfCyz?=
 =?us-ascii?Q?XibVz+oCpij8Uv4/JaCw64BlLOUfhXsz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XmrGRsB+UfrTxO9TU9O3KVsIWzr15gKha3qUFY6maXWJq5pkgAX3lTX/KCTH?=
 =?us-ascii?Q?oT8KbsB/8YuNq7yUJXhHyJ+moDklTktINtjLlTdHaiwQVIVmSEcDndmIOivc?=
 =?us-ascii?Q?jgcI0M/N5DEp3G9zbQ1Iju/QmB2ThlqDy8winc9Vf2Sr3f7yEt6PCW1uiF+D?=
 =?us-ascii?Q?TpXQew6aO2YeowUP6tatI0WP5F79iJvsL5SvhDSgY0d+WUkxecTnyuKkshcj?=
 =?us-ascii?Q?ezDFtSatNYxDmmFWItdj0nJIcFLdzdEaN4b33VDG5H3L+LK1/mh66KkXujKD?=
 =?us-ascii?Q?xn2e7ggKP4mnb9k9U5ka/6qBAelJrVxkL6DMvIb7ejZ/+ELvEJQd1N79XzPP?=
 =?us-ascii?Q?zml8SVF8hYvdj/kA9dQpI+9BNs9uSH/+WmJdGBqqOH8VYnu2kru2XIOCtjDE?=
 =?us-ascii?Q?cbLPrpAVT8JYFNXwfp0NEXk2ohoAUkl3ChMx4Jk2Qhf8IVoc+HajjYCXYQFi?=
 =?us-ascii?Q?0E/uy9jPgmCFm1ZBbve05u5HfZragrXlB4e3U4LKDEU2d1S2S+a8Shy6ruxb?=
 =?us-ascii?Q?4RCpliKjgwl6matLESNmtVKOy5DJ855tpWg+3yO6ol9k75ETL81H55HAreW0?=
 =?us-ascii?Q?9Maq78dEEowjdinybwUDLPh2Adjo3vMY99elC6L8jElN/7lA8GMBPAcxhOZX?=
 =?us-ascii?Q?p2od9Ov/URtdBBRtjp7MFrEH1sn5m5l29CbORsdRpekAUY8jyNhGzW06VlOe?=
 =?us-ascii?Q?KeGsj8/iFW9GlUVWWadFLH/Lwktg4rmKTz8fPWHEb+ZnIf8YuXcQ2gRoyQwc?=
 =?us-ascii?Q?eKQwTz6u2Qr5xyEOqrleEbLLcwyUTeGAKUL8zPCCxQWjVZqmRAMS055/AF4o?=
 =?us-ascii?Q?qhVXeRObgn9EsuqQrBoQsh4m4ZVzUM5ZwpWiAUae2CDOtteU0Ohldi86Q5Ke?=
 =?us-ascii?Q?eFISDeuYxYgop1EPMxgtU8dFOlQtMeZQ0Rls4agFWDzU10X7HCH8ZK2HvKFQ?=
 =?us-ascii?Q?gQOyI1UuIkAzb9tRHfc1PkUxeCRVa0+R5SReFHnLloQPJmsx4tbfQY5MRdG7?=
 =?us-ascii?Q?+jZsu3pESvgePIGfWGlvgKvMkq+ce7GhVZnVMGIHCB7d/Pmq1dHV17sCl75a?=
 =?us-ascii?Q?nFnv8DtE7+NKX4P340sVw2c2tQQxwBCARj0eTaSdjMVAfrDF0pm1RWCc7z9U?=
 =?us-ascii?Q?FLcCL3UVAGie2uChCSyICnU9JxJxUq/lZFr+e5L5JAyagf1RLDVlni4ZAuqn?=
 =?us-ascii?Q?KVk6v9MogP93l+pgt6vAAErC1/w80OE8UlOHHNnAb8jnVFoO+rXdwE89p90D?=
 =?us-ascii?Q?68p3voh4C2LJWxk8Zuz0On4fyDbyru2M3pGnSDsivr4wK75yv52WKhod39/o?=
 =?us-ascii?Q?yWsrY3JPH/UepR8Z9UMHS/gc45gQvw2yOt3z9wio+pMkhiJaZcidvgphrWuX?=
 =?us-ascii?Q?yN8K0vEJqVkKpQXBAYLSV/UY8GtxPqT97+HtACvIi9hPRiwoQCIMbet8Ne2F?=
 =?us-ascii?Q?jpia4+H9kpKqURRx/ctrTRixuW2fyhkwPui+E+eqNlQF69XQmAbQUSMXh57Z?=
 =?us-ascii?Q?r9i00GdGkvy8QARmiAOrRvOPpkA9l8cadTVDFrnmNxcBgam5Nwd57060D5Of?=
 =?us-ascii?Q?yxK7+LPqWwI1uWGIst/iVoxCXjCQtBPfVOSu/B2g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcaed42-2224-4c48-a1ea-08dcc66af31e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:36:22.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsQCaY1obd8Sz/y/rCptG+WfiZ3WROfYzzt/rRE/V4MElNhQnaLevGJY55pqU8F4tnHjUVtNtiv1XXqcoSp2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6656

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 36 +++++++++-----------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index c58e7cb1e2a7..ba49c5d70ca6 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -21,8 +21,6 @@
 #include "sdhci_f_sdh30.h"
 
 struct f_sdhost_priv {
-	struct clk *clk_iface;
-	struct clk *clk;
 	struct reset_control *rst;
 	u32 vendor_hs200;
 	struct device *dev;
@@ -118,6 +116,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	struct f_sdhost_priv *priv;
 	struct sdhci_pltfm_host *pltfm_host;
 	u32 reg = 0;
+	struct clk *clk_iface;
+	struct clk *clk;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
 				sizeof(struct f_sdhost_priv));
@@ -138,35 +138,27 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
-		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
-		if (IS_ERR(priv->clk_iface)) {
-			ret = PTR_ERR(priv->clk_iface);
+		clk_iface = devm_clk_get_enabled(&pdev->dev, "iface");
+		if (IS_ERR(clk_iface)) {
+			ret = PTR_ERR(clk_iface);
 			goto err;
 		}
 
-		ret = clk_prepare_enable(priv->clk_iface);
-		if (ret)
+		clk = devm_clk_get_enabled(&pdev->dev, "core");
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
 			goto err;
-
-		priv->clk = devm_clk_get(&pdev->dev, "core");
-		if (IS_ERR(priv->clk)) {
-			ret = PTR_ERR(priv->clk);
-			goto err_clk;
 		}
 
-		ret = clk_prepare_enable(priv->clk);
-		if (ret)
-			goto err_clk;
-
 		priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
 		if (IS_ERR(priv->rst)) {
 			ret = PTR_ERR(priv->rst);
-			goto err_rst;
+			goto err;
 		}
 
 		ret = reset_control_deassert(priv->rst);
 		if (ret)
-			goto err_rst;
+			goto err;
 	}
 
 	/* init vendor specific regs */
@@ -196,10 +188,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 err_add_host:
 	reset_control_assert(priv->rst);
-err_rst:
-	clk_disable_unprepare(priv->clk);
-err_clk:
-	clk_disable_unprepare(priv->clk_iface);
 err:
 	sdhci_pltfm_free(pdev);
 
@@ -210,15 +198,11 @@ static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
-	struct clk *clk_iface = priv->clk_iface;
 	struct reset_control *rst = priv->rst;
-	struct clk *clk = priv->clk;
 
 	sdhci_pltfm_remove(pdev);
 
 	reset_control_assert(rst);
-	clk_disable_unprepare(clk);
-	clk_disable_unprepare(clk_iface);
 }
 
 #ifdef CONFIG_OF
-- 
2.25.1

