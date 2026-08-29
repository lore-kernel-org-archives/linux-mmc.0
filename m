Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F022418A39;
	Sat, 29 Aug 2026 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788029000; cv=fail; b=B1koNjcJweRmFC/A7CzxK9n+MmB4iAPNCS6NsYYZsFPg41KM5xfB8hI23MsbRCh7uUlpHzvrx8shg4NFw7y0lxI1ibT5LQjRvq1ZFz+Z+YG1/RRMYcCnolu6mQ8Ck/4AKKpJAVuled4YefouKNL9/kZamBKrip5oWx6z7jiivwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788029000; c=relaxed/simple;
	bh=/9kP3YIJI2bPUJlRgqfKMOa4sX6p86n54QKNqeycb7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfvtf9ZvQ2bzfrCqJWlZhXUUMepnz+LelbZU/G6rkszzNrCZlSm3nl3tbysnMT4uFFdLPMCIrRW3MKdO4efBhKmNrm8cnR8gF1mxe+sKB9vWBEnzJVJSHveNCWt+PJ4xhjghVcSALKNk1xlc5DvZf1cebENbqbb+QWmveS/Ji5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GBCLQT94; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GBCLQT94"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1oy61wbDAoOVzJ3i/n7cvxXQwAnB9MHObcKrVxcnTw/oKtO0/EsrxCGAAq4d1EkNvB6udxsfSBHBhJ6kd15Elok4afYfhKdSmdDtoCtt2QlMrZWttQ6MDq8sNyM8r6+7A/08UCjDffzj2K21ZEE2fG+bWy4yxjxjBLvYnxNTpWN2lByVbfa/6SALTk1eJLVTwmlu8FrFfd8+t6r1ZCXQiE7yl2yshoBmHwIKSFy9bX3NZmw7nr9DuiK1PRX38AoObj5LYr8cfNU7PeAK8IS9zoMOGeUMWIT3ozn+gayw6mflU22yigjsm5/5vQ004C7WV+/vWjXU8z4NNl+Le6mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=yTMC/3aWhU3b6AZcWj4gqiAKSdmZLa5CwtlG6eVH5Tt2xstoC1dbMF59Ya6LSYBz+ZBebD8/KUMdmqE1VptnM2o0RMtaFZyt6jPIbRqR2KXVucdGLGglXXZ2ktkFUDvRLOETkrrdS7b6HcwATSyEKu7Mvse1NUT4nKRqSUyXh9huTZUqFLZPQ91YtVV/lcg7l6FNcgyKY1rwzU9eTTNhiz87DZjmk9BkjoT5LawTm4Ll2U9hiMzBt8txao3v9UAL/et6DaSiq5aN++21lHBl5O5AwqxGwBHqca6fuEk6w2eDcUib+gok+tMZ4PgVJPZxe8wbSberZgP0+LB59zFZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=GBCLQT94IZq72rdRSWg57zEpXI4tqLwqVnX/Qtqu/YAH73ooauVmJTyMtLJwtCrfc70CgILogbQNkV7nKJYqH6O0sZKgXllSwuZGLlZR+WWiUE4mlWBgIxCOnmfGJCW+Jf+qI9qIBPjNR0RjynQyxvgOWY0yvvkAMCSK3AbYCRdzVcdiJ/nSpEiSr5w0ZcQZLMQ3sMRiab1YMgxxJq4GNa9vVzxOBZYlYCl+qUVA3WbJV140du9aKIOwOgUBjG+MNGJJsZaoVe0dvymX3jzbTEgitsZis79QvmFTJCvSuVgOJvHVTbjJBvRQvJjp+18tNZ2djTPHPg6V2E9fmYQ4Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:05 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:05 +0000
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
Subject: [PATCH v6 5/8] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
Date: Sat, 29 Aug 2026 11:42:47 -0700
Message-Id: <20260829184252.27644-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 824d9fbd-ef41-4d0e-f598-08df05fd5d00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	/IX6Tyoy5pZwb+tsFky+4AIVIXpkyg84OffBMb7WvJuz/4emJYFEoOFmMxKYVJa1xKE05fxcBIzLvIgLzUYnLPwA3Rx8UxuWgB4+KdwFk6/93zTe3Koa5nBkT0ZeDIEblO7IGTfT4wGEi/FhG4/mGs5Vwg42X90lH7C5Lly6tAqdWiLjBMaTusE4PCQdHNuNxfe/SgIOxQryfdTOPAnLd1DEUCOb11KR1p1MgF7ffAGzeCG5fbwGD9crHtZodDozvWdfEObxUDStxFnU4hOC9qR0203nPc/KDgzB1u1oWnfF6l+a86VtI8kCajRt03dy1q7Ha3kCxJhHDMQGLCaZ4EUPXcw/gjaS9GPa7VCbzJBnxN8uFMnpyIDFbBuU+cnhrUzriCrzFLJIGaDI1PvnlVGqLL7/D4C6Z6HMHR8lZ07M/3jc1GjujAJruvBZAycVDZ59g5TayptJtQhNH+bIi0ygAV7pb7HTCD4IrVKwGsrEY588YFe/yBAdnh3TQQ2VwfLeXcUrH1t3XRCIo1akng3Uh2xo4VS5ow/NxlWzoS4vkZXUPPLCs4zytO9u+g+T+ZY8RCdgvee50oHGy+PYkTyVP6MgY14wU0hnYWfLxKVfoQkinMc1fTg4zKjKJXlIGVjoRkYG34eqn0STtXRTcH8RzqQcx/W+eFFQEwNwlhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/xuK/ImBzoLOtdmQJK7uSSnMEWaQOXetZGDolqX2oePh3i8SP7j6wqmqunI?=
 =?us-ascii?Q?O8VtVZVC6i2zN4yfo9jIYEUFHFj+Fy1Ia4yPEIW/s1vzXgTIjUyL/oRo57Bk?=
 =?us-ascii?Q?yIiBK2jn+NT4eUyPtJSr7HzXT2DijZIFcA8rhphx0X5lELKEGaVQ/9tfdgwA?=
 =?us-ascii?Q?cdWPwZcGxPsVD2PtERSfzFptf/iQ5jPuwa2pJrceHUVINZgauLvbXMO4GX1L?=
 =?us-ascii?Q?uN9r9aM0C649XQBSbyC1ia1sJGFrvV/f4naSQDVTpIefG6dKIZdYSDeQ0xXK?=
 =?us-ascii?Q?EJYORFxGdb4DhRbZQnImpRa4qJEgdg7qOsPK110lX49rOe4/KZx7A2MJkxqi?=
 =?us-ascii?Q?usWySST9hHyaIuF9TfCa5QXrkiEdnvnWG8IIHuUCInIajZpiYQgddv70BH02?=
 =?us-ascii?Q?mYt+v/0zBaSLctOc8c+ddSPm2PmBHus+X/K+bWg/ClF1HrwRKDAPnECBt00Z?=
 =?us-ascii?Q?i4cGv50AC4WTJqR62necto/b/sVFcMkaNiihjnJIpGxBdosoMUQ/gFGWXsNn?=
 =?us-ascii?Q?3gIdtnNExrOg/yo+mZszOQRzWA1vBwKaj4sFWrvhlo6ipcy82qd2/MkWV4BX?=
 =?us-ascii?Q?n0sCTxcOwlk0nvtKsf0ZGYBM3YsZfVc44C5dZ1+boWK0vBvn2jI4+GFhf2l+?=
 =?us-ascii?Q?tz5Ldpo4a8o/l4iAtCXjCz2DmWrTXNhASFnrByJZ6vcFYrqorGWC3agVH65Z?=
 =?us-ascii?Q?xBYVdL7GX8TqFqe2qQIiYrc9F+dNj+JNUXkcg8jf6XyroIi6QHGO7bNQhcMi?=
 =?us-ascii?Q?gFQ5V3n21he/1tnxgdJ9kiE56ZACqIfG3kV5UfiC0LYKsjZ6s1oxbjtsGGlI?=
 =?us-ascii?Q?rFOqmfsHjXsF+qWqULRjBhalw8rDQlKFDjbQNxKhPDZ2ogcqccRAG/xrFh/S?=
 =?us-ascii?Q?OplCcukYp8NR2gN6NNi8zrGATlKjsmAcm1RglzuHVXTd6CocrmyOnW1nR8oH?=
 =?us-ascii?Q?utMf4PZrd5SwIgcGWi2y8tNTcNZSE5X6czBE4QBYvTUWz67WWre/YWJDR1eh?=
 =?us-ascii?Q?KX6apdzSVTNLDSVpBue5+DoKCZsVb86rAVf8AUTK6YmlHBCv2NZbRDCFzSc9?=
 =?us-ascii?Q?b7Y85NGYxXjP8Hv7dFbWDOqG9aG96douAX/YnRFjcVd3vwa2+/B7FgLNQvTt?=
 =?us-ascii?Q?Aq75lQeLWg3sxOlmkloGfQ9cUvOVuwfM0Go7QzJv5wB+pASb1G9slrY3a4C5?=
 =?us-ascii?Q?dMIzhxIh6gMWtG6CfKG9fSxJS54SWqt6/FQmWlE/qI9FuYtD6MRmBvBohBpx?=
 =?us-ascii?Q?cPAk0SgWFng6tXtycVYrSOHkPEwYmUJ79gceu2RzIw7kCOxMgRBQ/Hu955uS?=
 =?us-ascii?Q?ERhHyXpWuwl0YR1AzPsFeiXMmIiPIzjar4KSN6Fjxu/D0GHEF5fj2HWDoMPL?=
 =?us-ascii?Q?HrFNuxZZnj0Hx8GCrgVUZGhsnVC2phBMWPAoKRN8OJZQ77IoRBQv2dYEASEN?=
 =?us-ascii?Q?ktuCl5VNL55vnI7K+bebpP09RXFdQJQt4JdVFqA8i81NeTUhQFcjZz6fIFXB?=
 =?us-ascii?Q?fMlma8qQE9Nmi1mmRUph7lXQN6VcjWwpImKkRB0dfY+yoNAbHG2vSzgOxGWM?=
 =?us-ascii?Q?JUqHumj+hnybVN3JWRls+YAfjq6i3NIG/lHyLgK5dtKTQBMvU7GKZecHny3t?=
 =?us-ascii?Q?Kvm2vj/oG2qe6vUqA0POwUfDQdEvHezz7zpd6aHYVX00OiAEn1Mg7JDIMNlc?=
 =?us-ascii?Q?MkOQSxHbmm56BLxo/GiWXMMTSCjPKcBbT05rYT47iXUc5acI1K1aKzxuPk40?=
 =?us-ascii?Q?C02lxIWlZjIUDQol9sd4xcaqGWKSoxU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d9fbd-ef41-4d0e-f598-08df05fd5d00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:05.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq3urxK3jKIlKC249zXAtswff+7vG9H6lDAowhLYFfq4uB7wlu83UgNoHaruovH3rDu8Tsl+KMORRFa9Kb6hSyaFdv75IM8ZdVQFQM9zfAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

SD4HC PHY helpers and the default ops/drv_data are not marked as
version-specific, so it is unclear what is shared versus SD4HC-only
ahead of SD6HC support.

Rename those symbols with a cdns4 prefix to separate the SD4HC paths
from the shared driver core and avoid clashes when SD6HC is added.

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

