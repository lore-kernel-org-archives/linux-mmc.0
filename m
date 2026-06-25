Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557339D3EC;
	Thu, 25 Jun 2026 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385056; cv=fail; b=t7V3EBLcOjLYrIwQKV5MrXii9vlnZ5WVVfvM3VSBiAdXUZdqSHYTl/VHcyjAM2LkDnBI0TQQdL0ZfJ0UFbX70MPznA1ATnpmiYxOLkt/s5TM81ZRhhTo7lNTB7cE4SPamrFJFEMqNLJDlMecX6SjmlE34s/hsPLdK0Cm6AmbX/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385056; c=relaxed/simple;
	bh=9JhnwEZC9H3ccgsmqcRQmwMO9cJXYop65UqeLh/f2qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNA7UaZLtENAnkBxoOkkqNJ8G5kJBGx9o/miU0ywFDvwR6gSygSb9kLzh7M1l/zRxTCqU/yzyb1ej1YomwA5RG9NvMCwQPO/BEZsc+pj9UOQhBBl7iY1ICyrPG3XXHCK1vOd66FFQYwTLnWQ0JdBt+VUPUOSXnEHO2MIBqLbgsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ATWJXnJb; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ATWJXnJb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKcYlXSjeAFRnS6vUNlCqlsdjfKhEEeAZNZQZPdmrhhHvbQit4GBEFKStuDwJY9cqoh2SPii625lEUVYFAHACrP4gm3JzM3ESCFdEgqpS0qG18P7e6dEPFXToD7Nst7pKSKtsnXi0A7XO5kIzF6kCt3+B5y9BoJsIc+Mbn7kJdb472JhxDMo5d9CfBtRj3ep7Wnw/gXp0NVmZo7Uj53hUD8rs2oKfDMSOrAr5I/PcohlFKBdiyThotkrog8szY9/KeahzDl++MPcILKJDBX/maLI0Mg2Klmu4T3hy9wvvCjrYCvr7Uy6IMDkptG+yTDFRyYXszEFCjAUXQJhUsw+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux4kyKhbb+/j4z0gF7nCQIt9DNfsyPoKC2HTRfbaT0w=;
 b=Xrp8naTMXsXDsgJdHca4U5k5zWOPmdfHmgxvPEYcFEF4TvhxhUawMH0NnJ5QjgRwxVYDyhJ/a5tu4eHN3GSvvNRKQcdv6qvsEXvWJ1UcZUttITbBN+LJ2/5K3Q1RoegGabETEN6Wx+Mvk7J+T0pPKdaiXtFhKWQ03MVptA3YvsJqYc17D+WWYNKM9m92cxb/vgtcFXmXEb4HGDbqnvOOvnDtgSKP9rFuuJxR+dpbLHVOb2KOYfDumvvbbzQr62f3HxU1tMwMFXGS51wNFtNn54Udzo7OuoKIRmfgLK0G5WbZViMdsPNbKDG8L8D8RwUvZX8J/9cVskHJEqsIdBxdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux4kyKhbb+/j4z0gF7nCQIt9DNfsyPoKC2HTRfbaT0w=;
 b=ATWJXnJbfmHEHXT+pJER90eHQm/tiw3ohw8/jCiP0RcuSJAinNbWzloP//G/EFr/2rpqjSSG1mIsvdbDyAIcdFZR/3+fHj3x4lesyZ93yhib1tCCU+hFGrpjQLIeNZNQ7oNf+Zzk+fNhBQ4004jAxF8ehiOcieTj7LXQZSjbpSUnYViITeZ+94jTEm3j2DR9UF7+b1YlFM4a/yqfZNl+IDnxGqUlXc1wmy5QwJrE44OG7MG2DTIVCWte5yd/ym18R1OhJIE5CL2l4S7aZWJCiPbyCxWlF4fqWFIuWF9tTUK++4kL1lCKiP8MW+WaNOKUy20Sy4tQuW7qqG6qwEvLag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 10:57:32 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:32 +0000
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
Subject: [PATCH v2 4/5] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Thu, 25 Jun 2026 18:59:33 +0800
Message-Id: <20260625105934.2890635-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e146fba-732e-4ecc-8ca6-08ded2a88ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cvWUZLBsNXDjF3iJ2ZZg7PR7DrQAIY5KJbeZIcGtLPsr0VMGzQJz/ultuWVQDtyPROoqLP400qexYLFYdmmDafO7ckb7dvO+l23BG8S33jgqui9/p7dwpwSmD1uEWUmUdorPLcNoaMWz2kuVZp4aq0iwcrl700ofCJwNgl+VbfyooBCNq5Iyf7fDljrYPlyf+/0wHbTdMxcfz5tFLWyrf3I/aOgxtF72EVEiP2GGdFJWGjuyPJejkkHvsRfbJSWDfYv2WA1VCYXitiEq9l1SfvXoU4h0GtlySZtRHyCPssf6OaW4NSF7L4dDNO5oPRj+Jy4R1fAvKH/ZPIZTKAr1LpXW0qjrLr6TZfn1wb4hWFoXFgAJDnOFKFkEA9wtGDj5kcIK4V0GO2z6GEusOfwYNZAVnlhVBL+mJM2g5542BpesTan3UQxpvykCJJrOrjtSLXc9+lihqa2lU3xdffpzTFV9Y6zkjARq92Kx/HgdbUVAbomIBo5yWTTjvtiRKDgMdRAGYl+FzxCH/Awf8CWSkmkOAECL9I30kWnGFthTJHbxB+VXJ+OQIrvGIroht/bbtiWXchUYA5CUVrWfJ7sGy5wqfcF5kIDeOwUyPtyXfURgU8zV/E+RzvGi5joCkGH6C6z3M8jnYDXTT2ejjhiiKTtB+Ly95Xz/0hloVIseRH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odCgptxmm8FrPJ4xu/JeMZr6M5H7C7J5ZNF2uu8jx7Y76yBnQ4SyI+z30sR3?=
 =?us-ascii?Q?eBmZ+o/t1y3GWyCkRFj7/L/6znJXFUlAVFeoejqdD/BbaZJ09rfj96ewyg6z?=
 =?us-ascii?Q?UxDSFdRm9oh6/RYOrhIFWbwFl7jzzeU7YoaxgFvTIJ4kKO1iFvOvsnezkQxd?=
 =?us-ascii?Q?kU5iraXN5moxtp41Gxdqdp6BF3+17XRssYKdHQ/N2Y2N5nbY9o/UvmXRcGC7?=
 =?us-ascii?Q?XAAqq5FSHxNSLhFZIcttJh7XIAe5kpoPn461nGJbGKIOXx9bYyi5uXzl1JJG?=
 =?us-ascii?Q?PtgnDFQV41sVIl/y/jTb5YKStEbqfbHojCTbiGjI9herZYvMQPciE6XzWMR5?=
 =?us-ascii?Q?MTf3qCXrd934fNlsoIKpmPguO3Q+XceCffigzbYYlmfvDnf9rwve2YGtbX2A?=
 =?us-ascii?Q?x2kSZeJo77uBqGdBGyugf1qJpoZdxCBRUfdO7PzpJdzy/1m5+1GTWjLybBei?=
 =?us-ascii?Q?uU5DFF2ur0upVLgITsBJgO5howiQMO0pf08d2+hbnb/HYXUwDLB0eqSKW1F9?=
 =?us-ascii?Q?Z7PU4jK5HHG+ed6vTe1PrUweZ8ZXI6PKg5ulv63lwofDcy36nwuEuW4AU9v/?=
 =?us-ascii?Q?YMY6W+q0n9hvRrLZ/ICZKfVvQcDCY79IHxQUTeFAywwBF7dP4e/yPY/3EYEP?=
 =?us-ascii?Q?3l7olxV1KSecAhqhJzGpkj6mzFrcIZSzlUGr8kqbAUtiEbsM2MvOU3a4ElFq?=
 =?us-ascii?Q?R/8pdELzcKsz+01xOww0l2B81pV2n3OgyJKqwPiRD9HpqCgMG4xr08QhJHhV?=
 =?us-ascii?Q?fCRsyMdxvUd8bOTGAFhlN8WF70lYEZ02j6qdk04/s/DJ9at+odv0dQdFF0ym?=
 =?us-ascii?Q?9V9B3flgGh6Y2DhVpKxmmwjPjJ5JZ2/Pvu+rCMCaRItoSjbbuNAMIxPj/zR3?=
 =?us-ascii?Q?9p5h2Spa0JlaMvxEhQoCNz96xQcKjq8GFHnTGXaPhb8gJQ3AIWWovs8dI2jT?=
 =?us-ascii?Q?sUbpn3WnvEADwnJfYidKGy+L/j7FfQKNr5DWQUn6UG0//xsbvJ9cH955KrL6?=
 =?us-ascii?Q?NBryF1ff+30lZI3NEWu8nrRrMgHEYqUgWmU0NR1jeFCmycHJ5kDEb7Mx4rcc?=
 =?us-ascii?Q?ThHi+31vgmhRbhezHKhiqdcnhQixzdyQ4WbpzEwBG0nTLqZGF/u+wKCHlRHt?=
 =?us-ascii?Q?U2/5QDS6Yb0zwQUiJPYJHFybAdZgCNqALL+IMhsXma+0aPRJOLY+Wib7klDI?=
 =?us-ascii?Q?P0rBx3QsvKCIq+uaP43akZpBFNsf5E9ONb2NiXDugrPvLjKoEhQSDhVdN4Ks?=
 =?us-ascii?Q?DuSCGA80Iltxi4In9aufm0385S2DR2EaUdPe6fENYkSg7JBMU5QSKq9cSaE0?=
 =?us-ascii?Q?0yAFo+cB440fPDKaNvEBhxjbKYYJpkM4eHpYCiHboKOrzs9xbbc8uqt544Ro?=
 =?us-ascii?Q?dfN0DC7lg7o7dYx5YQuxEW8ukdQMP+XqSPK93aDrLWYTZKoauEGSGqOhkSwa?=
 =?us-ascii?Q?xha4JhzONHFcmLDBdP8WES+heh7kU+9LUrz+0tbEwI6qquyQWYE6K684IThU?=
 =?us-ascii?Q?A7K54qf/v6e9J5aqN5QDx5zErGT7j9jIP0b8L1KqyMutJ+8X34rCqrWV1UPC?=
 =?us-ascii?Q?9lLFx7h8NTErS6Rz+hgjcfLI9qV3JVowiGm5fdPKlEk+dLzqtdcbgsmK+Vd9?=
 =?us-ascii?Q?63KqFf97kehZAX5bp4/nGVwsf4F0iLq1boVeNTu5ILEIYsgeauEDV2GiZjWP?=
 =?us-ascii?Q?jjaOSww4g8lhKYWfHMtYKTzMnJwXn4U5c5/JOHVv/5ig3Y02Cubn1UVWRsHJ?=
 =?us-ascii?Q?8IeEv5bpFiiW+vY7rU0/oJD4Laf4qQpTjTiKrq5Ogn57KyNvFSQa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e146fba-732e-4ecc-8ca6-08ded2a88ee3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:32.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBsxAqRbNX8hrO/bJ8sN2kTCc9vXcdSmyWhAhv7QuNfjVoJUxIXaaEJhBNoYskwVSlsyDzO2IOaWsS1/zFzKEfowQ1J7KnI3q4sTpg+kRURHfVSBFmhTPpJF8Q28mtg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823

From: Luke Wang <ziniu.wang_1@nxp.com>

When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
occurs. This happens because the usdhc interrupt is not disabled during
system suspend when device_may_wakeup() returns false.

The sequence of events leading to this issue:
1. System enters suspend without disabling usdhc interrupt
(because device_may_wakeup() returns false for usdhc device)
2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
3. WIFI sends a Card interrupt before usdhc has fully resumed
4. usdhc is still in runtime suspend state and cannot handle the
interrupt properly
5. The unhandled interrupt triggers "nobody cared" warning

Fix this by unconditionally disabling the usdhc interrupt during suspend
and re-enabling it during resume, regardless of the wakeup capability.
This ensures no interrupts are processed during the suspend/resume
transition.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7fcaecdd4ec6..c4a22e42628e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2076,9 +2076,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
+	/* The irqs of imx are not shared. It is safe to disable */
+	disable_irq(host->irq);
+
 	if (device_may_wakeup(dev)) {
-		/* The irqs of imx are not shared. It is safe to disable */
-		disable_irq(host->irq);
 		ret = sdhci_enable_irq_wakeups(host);
 		if (!ret)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
@@ -2129,10 +2130,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	if (host->irq_wake_enabled) {
+	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
-		enable_irq(host->irq);
-	}
+
+	enable_irq(host->irq);
 
 	/*
 	 * restore the saved tuning delay value for the device which keep
-- 
2.34.1

