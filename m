Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C94A0151;
	Tue,  1 Sep 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288553; cv=fail; b=G0OLG1gczeNSLqtuGr9HKfc4YGBJciIK32zF1L4X0RD1RjqgyQw48h3xS94hOWFAlysvs3lVZc6mxHlSFlZCSA5lQmQFeX+p/IrZ/bkF4yR6bxeuXGaAQiWbbdXFq7qTAb8udl1SHXukjQP1wnUlNw2cboptErcZs28JjGjN6WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288553; c=relaxed/simple;
	bh=ZEk8T9XCZNopBBGFEyXl2CMK5gIA98oQtTbvOVRVTwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th7/Zo+wW9xEcJfIdx0vEpDxsSXI6leblRjLvPHFleFz9wnqZiGDxkk81ADGf6rEZ6K50GJPC9g7OUZl1W0R8/NtocpxHBfM7Pc0iwSVTWsQZ1v/xMAUMeTNz4HkmjWcLP+F+QsRkHUTKOZxKOQDlwVuJXH4jjZp5zAJL/+Hok4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Xe1zV4YS; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Xe1zV4YS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD0mmZ4rWK8wXq/lZFWi7jG+hymzsreHJlLoBMsVB4TwMMfGFY7+v6Eh2zIkEXd6U+gGaBpmSP9QANPhDxWsbD40HhuZJHzDMtIE3GeL5KfrDa7h9wMh4Tq7JTeD5XAAex8VWwge2/PIJbspWisxjWE4AF/KZe777h8D61t3Kl10TjMzSfNK5Jar1jOWqUflbztOHt89YqDVvih9K/kpzvi58sCZL/3bF5bYzFzNbjhgeYycF09bNxPEKDoYeHDpxb5i2SSWYcsCDmeEwTzJp7Jb6aRaJ8RMfrO8FIamIioVzbc/Mh1aaNvrT5AiajpjVj/5xm1dDOw+3MpRyYrx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4o9yTBiTYTouYVN0LcB07wmuxcpltyupnk2qpN90AU=;
 b=QxYXa76pLEFynYjKsLjIwq4k+K283SiE2wmI4gcBpMb/NKECpcToe8+z51p1kZ5MzL2jj3W45eM4nzdw+XC4++kn03RgoxcxYnXKjK2uhfeL3F36zRVYkeJIqnMtsfnE/bd8CdAwkTGDxQRSvuKX9RP5D36XCFFIA+NcdOKvmMkvIeG2SQsqgnAxHw5IAz4hGUbZXmMh3XcidYatN8Szja1WfK0dkDJxTqRhKwkJ6V7Dmtz9H6e5GevxnEai25nttdPmGZGUmNosZkzDrBwTVycfLh0Ppwg5imIZAf8NKCJ5szBZHhjbzozIeI8/aFoFakV7DONJiT5v638i915KbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4o9yTBiTYTouYVN0LcB07wmuxcpltyupnk2qpN90AU=;
 b=Xe1zV4YSiE+0R/2268v5WGwBRIbywpDa9N7AlQuHm/RA9xnUyM3YyhX5FLlhk3+gGUz0aaDIsgfNy2/4fcG01G4f+YvSEdHwC1SNGUOP0MC4xY5BnTNep//g1rIIokcGTgk9SS4QoZ56BvqpcEQ/xM3wjgruuMBts/x9uCvmf8c4LhFm1iJpTkgMo1noaS9W/rZVO9P0jKt37T+7vc1JzcoTkWokpjB3GzHGrxCjJX7/NCMOT92E8eLeQLj/3ZYqcaf445ho2idQ7MOFBozTIm5H/Fcvo3yzdiXwayLgEizK1gOiXFUcj7s5h4CpcffAf5go5EKexaZ2u9DUZDrwKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB5278.namprd03.prod.outlook.com (2603:10b6:208:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 1 Sep 2026
 18:49:08 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:08 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/9] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
Date: Tue,  1 Sep 2026 11:48:15 -0700
Message-Id: <20260901184828.15653-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fd4581-0cfe-4225-476e-08df0859b46f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|56012099006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DWYIHtXUM8ytNg25OT3BX0ratz+z4cFLD6sjX+tWtNgraUrcJyb/wunCujXPZYVYGZCV/RIg3XqCWTM4GFiy9Ne0tRsQW+xNklI05ouYHKTf9Vyp+WE1DW6gIJQCVPbeo4IumQwfni7DM3z/bonT+SljzW0yeLHyGrvynaKJUX0uSX523NtareMZZ2SuLztD7Och+V4p/ASEK71UbnIv0KM1Ty+wJQ/w16vT6PQlaWALKnLSyByI1hRh1bSo1vfazT5mcg+qkoOiwz9EmfxQVxGaXBEi2fau/I0lYTtQ8KJOEtT2qvgqHGaZ8hSO6U09aNI++1Mr1GyV6QQlQjCGSTisOZDmVl+KukMcxD7MrTxn9wurqBjvuVaehi+CLYamIywOwUKa9yGCL+aSF++3m+NthYMYFmmo1r1gKXd3zpZrlI5da90T9kRuN55i2YpUsTmXX/g59D6cS7CbouyamU7TYClrwLI2viriGx0ESYo16aI8/B4iB520OFhs1YFkIt9emjl2AnsgFDNzwAiADW//ACABp6dAeoKlT+kI3iiciKMLAYMvmYMsv6TfJJSNixshAQvYMzMEgqtDyZn8MdbbH2mG3QCKDA/HgF5pemw/ihpag1JAaNdZ4n805sKKEYdfiB53ykX5PZ2P0b9HM9pkyyDtwikx7juCFhQHQjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmFrSVj3tYbZ4q4tps1f843JtLFKJcxqmtnCzccVwMzBL6WEPhPurNtppvi6?=
 =?us-ascii?Q?msTDHrYG0gMSEE05tg1spB8Pb7rC4xBGBxCQk0nZr8hXbmjZJecJXYPvAraB?=
 =?us-ascii?Q?psM0Pb6jyq5IIMgjJnYxiGWI10fgai7eI3hIBbgj5mM3/pV5tBT5HLnA7VsB?=
 =?us-ascii?Q?8qluHeslFR3QbdBgPXSYOaU6Gkx/dKXm4ET+7JZNFmGrmxBbxValnY7J6PXR?=
 =?us-ascii?Q?tjXxMbDRvNIpWRYY5AWrkhb8EFBVDff98K3v0SnhQtPHHF2Vdf+dEZnAmkfL?=
 =?us-ascii?Q?xzhcyKSeoDWnwS7fYKxffGHdglt8xKfBruSvNWt+oLVuuRyQfA13KUsWYqna?=
 =?us-ascii?Q?q07/MM1Lblu6jfoYbF6dWuasDEsa3Rtvz/ogmbVSL5nJcn2FISXzYT5jQeBh?=
 =?us-ascii?Q?hxfvsEx4VjbaHIVvcbHIbzfBo+nsud8qD9IyHegeRW0dL5is/FZYdpu+MKBe?=
 =?us-ascii?Q?XxrWCl5wROPI8aw6bkwE+HyWsr6QFuUjSJ9Wsf+h0YEh9wWCL6OZv6XBDyZ5?=
 =?us-ascii?Q?ZXEE2geUgRpvclaM1YP+LJXfhgLsjjyNzYrEWqtS1MlwV0ZP8iwTTN6VwsKk?=
 =?us-ascii?Q?b0dO590LZKgORZ1Okr8k/JH+8C2f5Uf9sv9wgO7Nipxmqam8ctjurF843qbu?=
 =?us-ascii?Q?W2rb3YTdC1Cu8hXiZtbbw/ktOOrYWoEBPHNfSSl90svqnwxgZwKYHP2OHsu1?=
 =?us-ascii?Q?V2Dry5Pcnp5+h11vUHlb72uB2kck9g9+PgbMDHCsn+OUf7SlFTdYM9jCeb1Y?=
 =?us-ascii?Q?vMthuYXQuPysEU5OkdN9KnOyxCWRfLuUNOgxvpT33s9X3Qb2gnyMkmYEfOR5?=
 =?us-ascii?Q?6oMAsX3DExQyDn90hVzt8I9LOa/y77WUCOh1tvTePAUk/2KAaPMv7aRm0G2E?=
 =?us-ascii?Q?JC5bJGpJ23rKCTGGq38PGhQuZDpG9QfFV12pn3lc0wH2UL/Enb05gu+7ya3E?=
 =?us-ascii?Q?MUDs/7K1U2I5pJyC/DcndrdwNom7QkiVPVbHvIegRP3uB6oestPZO2mThOfE?=
 =?us-ascii?Q?i9LOV7v0FVlPM8RDazw3XNDF0QHlOSd2aGMKuVrv3hdeL1m0HglSGFCYu+Yo?=
 =?us-ascii?Q?yeyF/sAuLvxoTg0cMijGy72irN+3VDZwDCJ0UnHGuKmsAtj52N40D3nntD+5?=
 =?us-ascii?Q?FX+Am3MAq5QZmgT8+2SWWTR/T7FVfccPlFAt7mScZ8m6lAEuKDxl1aLcx9+2?=
 =?us-ascii?Q?bgeSowxbwzctyUhy0eh7Gm+pJ0s/LW4wqKr/LIQ9OiiWKEbziQQ9ESnLGzLH?=
 =?us-ascii?Q?q/zt783gqln+iYBHWo7NePFrucBHNdsQwBr4aXVvnYlMD68FCBZDa/Pov/4n?=
 =?us-ascii?Q?EbxOEp19mwcxdWD2BrJolOs9LPXBLCkdfbCXtW/oBJtbwVjVpANKsxHwuwlL?=
 =?us-ascii?Q?unbsRStpiUO3+ijS+CUeAECbBhdgqtPMJsOI5MA/znr1dEzE/Ap9f4UO7D5y?=
 =?us-ascii?Q?/p6yYZoFJseAo2XaWDU8A2rzgdQhE9F4B4SxaBJgzzsARsSSpgbOropwVa8F?=
 =?us-ascii?Q?s4X2SdlOiMg6FwCM6BiPWGSQkt0sD69NGE89bFwNV4xeU90EjYCauQ1dDxcL?=
 =?us-ascii?Q?wpktPESlzmhsC/ap3I8A5dOh2rYtSmJQ94wjd7gLrLh0GUjlGwH0k0qn/kj4?=
 =?us-ascii?Q?+rmGcm8SMSy3rnVqUSLNz8PqcKNXbdgcf0kUFDi1BBqmUdt2bbOM7Q9v8kzo?=
 =?us-ascii?Q?PL/oiwm/D1Mn4AEzRKVzkrIePUw0jpUi7/WPHQmsSF0gRAuJtga9iKpAYy3f?=
 =?us-ascii?Q?4RQkJYmoes9zVPfabR6VcEnmVD/iXL0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fd4581-0cfe-4225-476e-08df0859b46f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:08.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ/zdUcyzid+56Qum4ZTVMVL7VT7/dtKdpGC7IJq3vkDhEZkJuOXYn+zxWPsePweRLfcGq9a02VpCHxSqrpoNAa2uFpfZkvymU1UlgGlnDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5278

SD4HC PHY helpers and the default ops/drv_data are not marked as
version-specific, so it is unclear what is shared versus SD4HC-only
ahead of SD6HC support.

Rename those symbols with a cdns4 prefix to separate the SD4HC paths
from the shared driver core and avoid clashes when SD6HC is added.

No functional change.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-cadence.c | 55 +++++++++++++++-----------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 435603c8c00b..8a6ef6d9d1dd 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -78,7 +78,7 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
-struct sdhci_cdns_phy_param {
+struct sdhci_cdns4_phy_param {
 	u8 addr;
 	u8 data;
 };
@@ -91,10 +91,10 @@ struct sdhci_cdns_priv {
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
+	struct sdhci_cdns4_phy_param phy_params[];
 };
 
-struct sdhci_cdns_phy_cfg {
+struct sdhci_cdns4_phy_cfg {
 	const char *property;
 	u8 addr;
 };
@@ -104,7 +104,7 @@ struct sdhci_cdns_drv_data {
 	const struct sdhci_pltfm_data pltfm_data;
 };
 
-static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
+static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
 	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
@@ -124,8 +124,7 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
 	writel(val, reg);
 }
 
-static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				    u8 addr, u8 data)
+static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv, u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
@@ -156,44 +155,42 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	return ret;
 }
 
-static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
+static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
 {
 	unsigned int count = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
-		if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
+		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
 			count++;
 
 	return count;
 }
 
-static void sdhci_cdns_phy_param_parse(struct device_node *np,
-				       struct sdhci_cdns_priv *priv)
+static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns_priv *priv)
 {
-	struct sdhci_cdns_phy_param *p = priv->phy_params;
+	struct sdhci_cdns4_phy_param *p = priv->phy_params;
 	u32 val;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
-					   &val);
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
+		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property, &val);
 		if (ret)
 			continue;
 
-		p->addr = sdhci_cdns_phy_cfgs[i].addr;
+		p->addr = sdhci_cdns4_phy_cfgs[i].addr;
 		p->data = val;
 		p++;
 	}
 }
 
-static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
 
 	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
-					       priv->phy_params[i].data);
+		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
+						priv->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -470,7 +467,7 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct sdhci_ops sdhci_cdns_ops = {
+static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -481,7 +478,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+		.ops = &sdhci_cdns4_ops,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
 };
@@ -495,14 +492,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 
 static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+		.ops = &sdhci_cdns4_ops,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
 };
 
-static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
+static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+		.ops = &sdhci_cdns4_ops,
 	},
 };
 
@@ -560,9 +557,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_drv_data;
+		data = &sdhci_cdns4_drv_data;
 
-	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
+	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
 	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host))
@@ -593,9 +590,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns4_phy_init(priv);
 	if (ret)
 		return ret;
 
@@ -622,7 +619,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns4_phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
-- 
2.43.7

