Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010034.outbound.protection.outlook.com [52.101.128.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE99155C9E;
	Tue, 27 Aug 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744174; cv=fail; b=aSi/ABwbPD5THpLDDtkpMx0canuLJUlm9uUb+OLb69U5cAfyTVXCUXzkS40nRaazICmOodoZk5vfk2PKH5yAs2/GvX5ktK3P24GBkug7uTklNKdJ8AmxS5zTayQjQ6ATmuJ54P1h7DeXBPANT6EU4aNvRWqk+4T6m9KwzCW1mBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744174; c=relaxed/simple;
	bh=RDid/tL5/00Wf6CCa3ZGj2PbSRHOm2YsJ3uzb8tZ6Y0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNAz31HRZSa8hI1pT6Kye1HOaNnAqRRzQkJRfeAriDHIh+99cqatHtc4n6OiN5bCZYOTeTiEDNYvTnpM9HdYgDsBvcaejXzpWGxcRnoA8JW83veei3AMcp4Sy2vfDS5Hx2HBMxTodcqjDMO2fj4EyhPrX3hxx4fJ0aGyBw657oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oZtBkMZt; arc=fail smtp.client-ip=52.101.128.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oZtBkMZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuCfRD1TWCSN9jIDj+sTfoiOK/+hMcshq3sU12zLN02yCnAgSOlILewNfeyqcseGO5MHJz6f+BcCNKJyeTG2U1nrLcWd0bKlaKfesBsnnqEIO9gF7kCAb5veVGLNkbWgErvuOiPtWQrHFiQIyWjRS7AaroDQvtbVcT/4YEhvOY12Sngmvt/SZjtl/PPP5bB7kiMdoUqtmO1TuEQylm3no0/ZopppI28XzyJuX5R6sS6NBsrv/HrCSzPUsvCKh6FZ0KORAVfz0xIJnlmQixzdTFG0ebb0E0OMaiZfyk4v2Sl6FpUc5mMpHriBc5EXeOBCL2XSKn5JZ5eslU0LIgnG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkpV+tQtXNR8gyNVTilzqm1GZllsQl7RH9cQf1JVoRg=;
 b=ihUCasA8kTxN++ykGtCOOXSqOe4BMxE1n/9WNTXMemyXuczEIt0Mhx04Gyz8vN3gadEz1p81mdbUszfJvPSWHJ2SxmNdBtmcMbqY/2zQBAPvF/i5XVzd3DCEM6jORDI1aCbxfwa0nP+JB5nvRhbyjPNyo0SAOaNc6zLhfVxgkAyOm/RHZeN9CpvZrhB/XNT0ggqMzx8LghpVq9ZP6FjFGrdQ+UpG3Smfr+azo07C9DxNmBXhzeIqXYJIrEc5sYl6W0b42jflgdLzkrTtiFMuV5qPklL974ajROXL8L18ghSIRfzcWUA7/yAsHbFtwapFY/UOuuwSwx5I97x4QATW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkpV+tQtXNR8gyNVTilzqm1GZllsQl7RH9cQf1JVoRg=;
 b=oZtBkMZt0pZ6NkiGuttYvy4jQDVlxfyRGb2XkzJpRPh9rlU+KAffeFdfqDZD8NIcuOs4X9cmHg/ADdmOCa/dQEufBxfK6on4cG94SQqKBhIJ9U2AeYgBGGkwDGXAlABi/19Y1CzchOBYilDxmnIsC2OWOy58iWgSsXolMAemiL4MROcJ9yESoVs6zNlgIuhlboIhjfYGd7DO+slt+uaUMm2ESBBR6kqi0z0O2Yd3j5zTzjzU4tn3fjsz1zK+/iTUMGEHT5eJuI8+T2TM1//RgSmz+2QObNy9lmiSRsciD7NSR0+LNLgdQ1XyGIQPDlumdhiUHJCk4NzOwmGgKk80Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SEZPR06MB5047.apcprd06.prod.outlook.com (2603:1096:101:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 07:36:10 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:36:10 +0000
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
Subject: [PATCH 8/9] mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:46 -0600
Message-Id: <20240827074857.2671808-9-xirui.zhang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: df44ea22-f394-4d05-08e9-08dcc66aeb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQrkkQHv3ZRyxPzgeYbGwT0Wf37h0jZjYWt0Uck6g6+QM/zjKFBluRugDyn0?=
 =?us-ascii?Q?CBwtQzhWVTTuGHLGl7Hr6WQ4siJvcj8yNWwbzhThyCj85JULyk8KzdH/onmV?=
 =?us-ascii?Q?U0GnG1EQIK983PL3In0ajDDDOLRx+FUZEpl0COCz63cFldCNnz7vbjotS5CJ?=
 =?us-ascii?Q?8WlwnwKsB5y7MwrgFL8pQ32jYhU7bQ9SNKQvuwpM1dbnvKVBHMQyF/Fv4xoK?=
 =?us-ascii?Q?RTgsFrFlwyxD1Fne86UKhwk3xcA7rsLe/0yEOafP90/+PFL6a9WlgtY/ems6?=
 =?us-ascii?Q?B5lwRys4iJHgj7b0PD8Zco02tjI6zFvZiqt409cCZCU3a0LRXXmcVuxLYH+3?=
 =?us-ascii?Q?IZqWUqrpyC/kRu8Xp/ZIkvyAs8L0R4dkG7plHx+atVsoTC1rMCbwKnd0e9hC?=
 =?us-ascii?Q?TT6aBRoz1JCHdyoW4Kt9G+va/1PB6rtcVQrFVvrdQuj+33vD9XaISN1xAMc2?=
 =?us-ascii?Q?GGmulSi+05hGxV5VCRxJU8RC3wzt0pRXwPPTzR2dhaKMhjQn4NJWM4u/2B0c?=
 =?us-ascii?Q?s5k1xbee/QitBo8F05keR67DekBfulh7aczxjBNqEJZlCIamm5Ennk1sJ1Qs?=
 =?us-ascii?Q?GcQLmuwD8dVr0FX6rYk04xpyEwYUrDdqZOty7JKmcnNyA1KiZug2393pAxvp?=
 =?us-ascii?Q?eIEM5XpZXEFn+ENK6VAW4YvfA5uNnbMh91iHDg30FGc/wb++K7MsQmEIQwbT?=
 =?us-ascii?Q?K1Dlx/NxB3LytuFoaRH4W0kQf+LjEctrMdpXQYGkcMmSPU/M4A5IQAb5ByeV?=
 =?us-ascii?Q?H6LKAJjCJGjxYDEB4ROVEtHxowWCwjsd0ndFOh9TWc+RTuAjDJZ6qfad/bnA?=
 =?us-ascii?Q?065AD1/LJjBndOSIDUoU61JE5bIYwq6ua1K+pGi7oOql4O7LSCUXbmHP5OK2?=
 =?us-ascii?Q?PCBNxLuu6rLTZPU6ToepPyT9N+1CVjJT2/qtIdqkB/U/K8lFcb1p4y6Vpaiw?=
 =?us-ascii?Q?cgyBri031exkCJurf4JLfkFNXRQPVD9Dac2U70WYwjil2/Hq0M+DlPC1n3j4?=
 =?us-ascii?Q?Yl473KRnIo3f6bw++tuGgprMzs15vUkeamnAOwYbpirp5H3dk1o/9FmENTIe?=
 =?us-ascii?Q?/eVhvkJqAUv8Br+9/Ee0/+Ik4cySw7cCJzCqxP/TftG/3GBIxL66NbhoZeoP?=
 =?us-ascii?Q?JfDcRo3tCLL9PtTfsDHQpV+BgvmWxXftREHZWEcJGbp7taaDCrCcwjmCKSM4?=
 =?us-ascii?Q?KglM3UM7jPA+NryVYWV9SsZjljOCVBD66LJfFYV3EX0MGt8+uOu9wNzitTwe?=
 =?us-ascii?Q?tkrFXI1/vMXYYBplHEGrh+ja5TKSqfe7+ri9NYWAAHXnaaS+n7QhHn1YFK/P?=
 =?us-ascii?Q?A5lIx85T6Bfpq7kQjbt4rCCl2hfJ2KN80LSBPwSMNjtI+s42nkM9rRoK/SCm?=
 =?us-ascii?Q?nWHrT06nlyBdMol3aBuv8I48tN2q0V6i9h5puhkqTsyCEDmiKZ7HGivNlb5W?=
 =?us-ascii?Q?tBMWudB97+XFaCaHgVertP8dlBsDe7Zj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myqEywk4BAfqwat1OpodiWImG8pdfv2TbLEgaph6KFUwgdwR7KIBgpFZ9x6h?=
 =?us-ascii?Q?BG9FEJyYfxqGS2RBJ6nDkFQ4wG59EUsESzvCiGF4figqsXhCWp9p1ec9S1TC?=
 =?us-ascii?Q?tztFfHb1LBWQUlM6RlUFLy1yuxFY6R9c01hfh0ot6tPEFUdF466fuirwiVVB?=
 =?us-ascii?Q?Bkey1KH1L7sGBEU5d9Kzh9ej8E+yJDE33B/3oaVjozmK6aGlLh44KK7kNPqT?=
 =?us-ascii?Q?1yRKtkZEg+g2o/PjS2bflhRn/2/KFqqyzTTVl3jp6c0k/2P6Tc5wK1I5ATMB?=
 =?us-ascii?Q?7hwMB21rB6KSpZ7+mNVv9vgJkZKvfgi4QRCaFbWHDbKrh4il31Y1VgO/usDf?=
 =?us-ascii?Q?KLeXv8i4xe2hfConHIrcEWeypmSDtZ3VCiL3SAgShGoWa0kWCBSDeh7rcedb?=
 =?us-ascii?Q?DlP8KsSRb9XK5QERRsrLhAjcAMwx2Gb0QkkCyD9kUJoeBsWMHUD2Ozv9BDRy?=
 =?us-ascii?Q?SNIVzvH6DjXV0xNeZdZsEvGQ6nnfmqZvFibiM8P6mwyZSc4ubGMId7Cu+5EF?=
 =?us-ascii?Q?hfl1JM7TCHq5R66nvjInp8ntngfnVspQCfycCRu/gO1K/YqsgSdypkutIJHE?=
 =?us-ascii?Q?z5HMNpWVJ1ldFDSPx493gPYjLFeewXye6kU1XoRO0bjbrmBSHGvn0iAOyg4V?=
 =?us-ascii?Q?4OKXsJVFze/ZhLVF2qKMAqTpm+baCAj/p5LAgh4A9AMgCfE5Z7uEarUE1yKp?=
 =?us-ascii?Q?gRZC0WMY37L4F16PRyUNmPr14KqcZN7Ku5XLpN21sO7ItoeZFgZd/EWUYhH1?=
 =?us-ascii?Q?1QkFb8OguLRJkUfzJkH5Pvdl1XUSddCd0bx0Ha1lWfagGtdY0FahuNhuvU2B?=
 =?us-ascii?Q?c7yiPHUVGOXU51KwdivGZDqUVKG8477XZvpgB2SpGazcJNmH1jiEX/atz0qb?=
 =?us-ascii?Q?jQgDnv2EaE2rWb8RV6VTT7uR76HKvYy2yKHglOkb2a4ZNN1hH7FbpQPjSWWO?=
 =?us-ascii?Q?MkSJzS9WdXG4zXoBSzZA8EXsFdE7rOQU2BiPzaolSY1X9JMnErPj0gk1HQv+?=
 =?us-ascii?Q?rxGvFqjhYUxyWugl/JVHJ8yF02uyzLM8XBscgV3EurbVAw/HfWNgd96vMKFW?=
 =?us-ascii?Q?I+CSUjz4Gb/xIyGjNVtUkvBC3txgKEjiU+XHIUi8wciyZEmqleO5+d1PNuge?=
 =?us-ascii?Q?nlVjkXvA4bgNhG1gVofbqmxWINIY4Krjp9HeFHCfQ4TrYGezyoNet/QAr6C5?=
 =?us-ascii?Q?WAiTBPUSfC1FvXHqzmrAr+XHlYODgTv4dfIPUNk/CXXKlHtHWi0uuJK0dA9d?=
 =?us-ascii?Q?/Z5x8KnfGPj0tjygYPfWYTS5j8EMuDY1CEllX7LanYPtEv3SyIfgQbxFtHEA?=
 =?us-ascii?Q?so3fhMt4SGagLa+vkQpiWVAch0XxF36k1ratf9qb2sIVy0bIOkyH4EhgTaN2?=
 =?us-ascii?Q?qSEiKqqjATnjKaqtUHMIe5ZEgAzefgFM1sPZMyo+TROmFVgenzHSqs7U7J0c?=
 =?us-ascii?Q?egIhfT4OUxF2/1uC+6Odop8p9A70XpAJXRtEDCdjDiB25ErPTN7ScWsP4e1e?=
 =?us-ascii?Q?QUMy9WACGyPij6clBUd8WQfnOuYVcPl62wviq8PKjtKD9fyBzMlICXzSc/US?=
 =?us-ascii?Q?bi0pnRr+NXhfIz660lYlvLNZ81M5tf2BXcRRfKQx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df44ea22-f394-4d05-08e9-08dcc66aeb65
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:36:09.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTmXG1uR/7XivDhrJhav2H7ULPqwH70XcvorQqbqIDWREF1sVNml873rCYOHFEb6QEUMahkbmBlD/0U2qMcw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5047

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 31 +++++-------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5edd024347bd..f6458804ea0f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1875,45 +1875,33 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
-	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
+	sdhci_arasan->clk_ahb = devm_clk_get_enabled(dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
 		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
 				    "clk_ahb clock not found.\n");
 		goto err_pltfm_free;
 	}
 
-	clk_xin = devm_clk_get(dev, "clk_xin");
+	clk_xin = devm_clk_get_enabled(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		ret = dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
 		goto err_pltfm_free;
 	}
 
-	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
-	if (ret) {
-		dev_err(dev, "Unable to enable AHB clock.\n");
-		goto err_pltfm_free;
-	}
-
 	/* If clock-frequency property is set, use the provided value */
 	if (pltfm_host->clock &&
 	    pltfm_host->clock != clk_get_rate(clk_xin)) {
 		ret = clk_set_rate(clk_xin, pltfm_host->clock);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to set SD clock rate\n");
-			goto clk_dis_ahb;
+			goto err_pltfm_free;
 		}
 	}
 
-	ret = clk_prepare_enable(clk_xin);
-	if (ret) {
-		dev_err(dev, "Unable to enable SD clock.\n");
-		goto clk_dis_ahb;
-	}
-
 	clk_dll = devm_clk_get_optional_enabled(dev, "gate");
 	if (IS_ERR(clk_dll)) {
 		ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
-		goto clk_disable_all;
+		goto err_pltfm_free;
 	}
 
 	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
@@ -1940,7 +1928,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
 	if (ret)
-		goto clk_disable_all;
+		goto err_pltfm_free;
 
 	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a")) {
 		host->mmc_host_ops.execute_tuning =
@@ -2007,10 +1995,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		phy_exit(sdhci_arasan->phy);
 unreg_clk:
 	sdhci_arasan_unregister_sdclk(dev);
-clk_disable_all:
-	clk_disable_unprepare(clk_xin);
-clk_dis_ahb:
-	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -2021,8 +2005,6 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
-	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
-	struct clk *clk_xin = pltfm_host->clk;
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
 		if (sdhci_arasan->is_phy_on)
@@ -2033,9 +2015,6 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 
 	sdhci_pltfm_remove(pdev);
-
-	clk_disable_unprepare(clk_xin);
-	clk_disable_unprepare(clk_ahb);
 }
 
 static struct platform_driver sdhci_arasan_driver = {
-- 
2.25.1

