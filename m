Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365243B484;
	Mon, 10 Aug 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388479; cv=fail; b=leQxC9ZIFM6LSvJyJqJVoM1pi66qppa4i724n/GiYY1/6HaTiOqyd+n9Gz6/Gf9EtMwY9jYzFSTR6F+qTGVoLKdKqWuGeRaBvxBuVcA7zcUi3sZycnAKV4RIXfsdACabUlEqj8IQtebWdkQPLctSnA9gfuyXb58GM09J0zPtT0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388479; c=relaxed/simple;
	bh=/9kP3YIJI2bPUJlRgqfKMOa4sX6p86n54QKNqeycb7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asEuHeR7WmRf2gvnR/cfw7U+sfMGC+Li9gu1ypzXnyoOqIGSYsvOgqB7pCavJXG1bGs/B/XUlOx3Fh4IC+s/yOhR/Aw/uF1flJJmKpPM47+0GUdFCBmngRk7/juPFeiap1RYsePbFIqokhHJOz9U6CAc5adip2ygsigonwC74n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LkoxJfy7; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LkoxJfy7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsmaDHi7tSKTi3ERFWxjqvWZbt8P+mbcOJOnQFlHZAe2aLI0S0XRFkIX0Gqo9lKjPNp20wbP4Ekq6UN9+RDcrpETRfXlePVbQz1gSYLRl8Nm+US+31tFokOCCYijlQ68rdQ+TLplxSnPYgbeTmdqlvlFGOx8uPKzZCbCkZIGCOrfFaCnUmI/ny0BRmj56/T0j4aT65EHSP5/hj2Pxbp8+gMDVGRUZcD+DwKYIRwLG7EchriBntSZOMLgcU/mmBq66bQitgYfoWYiyq3l1D9DEomSJ8uKw9JlKGwhv+ndwXwpG25UmaeXDjvK9zCMw0wGB3rSoB74NFXaMCC9keD/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=WHj/Y2N3lN68sN5JTfsksR1CrC5deVua7m4H0NX500nZt2UclmwXTIxJhkWbKPYreR/7eST7ZKkOPi7wdyOey7ONzPU3itTvJDMzj8rQvXNFXuxRqNvZwAMqr/7Dr9gSroFlGYINElByyNoddDWX4SZVfSGqljOZa0UAmr3YaEHF3rGZLYHBIObUXf6CZnE5vDAkQdU0fRhOVeAk/4khUJGqQJK3+okas6fnkNLbg4MzP4+NZSjowgWHEDs4JjtlyoCls2CDB4++B+O/EZaWWjZ1SOJNfi/cWosKIv51qZObggt2JL9z9vNLR55Fm+ZhqoRgL4AmMChCyxEBWXKeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=LkoxJfy7aD8HOFkJb9pZ1gb+8iuXoz/RBErEHWSr3SCdtvNMCq+SYq5aduSp5lc896apxKKoF4utQjbA+fwvuvnx1Cdei1ausF7Pk4l4+if/OObA+GBrZsPiStuR4u/pct9BXMSQPiRti6plYoplbL16uXi520/HHse2Rt4AZV/E2toVKwmmf93l2XSUqGu1bOZJM6cwVbhBD7IiIrUZkg62LgdZTrtM7Qz7d1scVvFKNQGUrsic2qvdCV8ukpuCDkVcPuuCPGAD/a8XgPwK8HM9sHmMckluPcV9rulpPsAW3ej6eQf5Jhp26dgGF2WopeOp8mTZRCEwo3U7iTiJew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:40 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:40 +0000
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
Subject: [PATCH v4 5/8] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
Date: Mon, 10 Aug 2026 12:00:19 -0700
Message-Id: <20260810190025.25045-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 8726d101-6da1-406c-113f-08def711abca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A8XCAu595agzt/+pvOV2gFl3aD5f25KSGPVXBI2v0JPwdQPq8ttrhMktFi3+X09+5gap8UQY9FiuyCHl4ykbyy+zA4dLyab9d7FGRw/jhf5ws/NZWNpu4bbQmZU41uetGPz0WZTGjpgSWpPvThkX8eOW951J1e3y6OacisLzBAl7eSWkY6ACP8otPrqoAomZrgjDmjDjLBm0ttj1I2JkdWqXbnbEa13Olpnabqa97e8Oz9mr7AHNoLGKQ2XRy+heXm2BSQfMYMxx9dblru5SdMUXY84HLS2GByKuwfknK+NJVaEi3X+1ls6eb0XfTKcMW+4+gS+j6qWsvE/847El4CEREeoL8CR2fR8kOxFnN8sqJakqzMbNQfc0p60w0HLbBa1UK1po9HKrD6nmgnnzt+ymxlWB8IiiptwrJW7ozFqCrfK9CxJFOdN0LGLTwPeEgT30J8nzwpNVDL9O0uKvqj/VVLHB+I/otkBVCWiJAUXy+C1J735JbxOlDBtHTVVLoazdTnaeX45dX46yl6UigUlWFRkZwCQnlOZ2smZDe1uqktvBP7tA4O10Rojn0+zPTVWkhlUZVxXxzEDoN+70HziFGKdAf+UZriO5ReFNAG2zW3MkfJQ/MAT1gy4iQ2VCNynMVLtpSYrmgppEk+xDJd8/LXCtq/rkpKTz1GgQOR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKfseoe0/JK6z5ZrzYAoUr4fk7CQuWyoeQ4NKYTcPmcSU5i2tW07v0nTnkIA?=
 =?us-ascii?Q?GaiFSvmTTTwGXE+Ym967WzFE2nTlTFy4lA6/dVZRrvsmQd1Ycb4NlyXhO7mX?=
 =?us-ascii?Q?4w4IX6Qx4OBigrfq0DKe3Ldi2kJed6me4DCNEl0LPVLv6AYb3HQrzRvfjGLs?=
 =?us-ascii?Q?P6/vxjTcrqXL7ceSuMZNi2/4O7hxPvrCQ2jHEgkJ1KXum/f3BxsWmtC4B/YJ?=
 =?us-ascii?Q?j+JFcZGHW3Kf+dyBZ4+DOB5hrFEBptJNT9gTWIFuZGpR6SmfX64DtCLjVn6h?=
 =?us-ascii?Q?Oxj86urzPJexM0MXM8mojxMODx6+IM5fqFDZIFwY5zyXre0wnX+y/xmMgJW/?=
 =?us-ascii?Q?otkXVWyYLzTFgqFJAzE0x/n6ak8qfj1Mh1kMnH0VEWBlw6pcplutn+QD/j5l?=
 =?us-ascii?Q?lu8BELOhFdaWJ/FJiQuYuu5Ey1c59i7Dzzn67GSqfaYtH74OSxpoiqXhK1Vg?=
 =?us-ascii?Q?wqBJck5vh1Jox/TrA3jqdehuGX0DJADCV13eniBpawkTh9WGHK8+nTC0hXLB?=
 =?us-ascii?Q?qz+A/M0hGW86ZulZyZXx4a2OCHruZ7QG9rpM038AW4kUNex1WIoTbtSjI68y?=
 =?us-ascii?Q?oEXNbLm9dALgdGe/D556VztcYiLOTx0iUYKKyl/0Y2+fDFFrBvG5VVFawmqj?=
 =?us-ascii?Q?n2WHZGGWgNpBjm37ywTyDe1lbqImeCZ3P5u3nAtCh67palYFsa/HVKmIvfZg?=
 =?us-ascii?Q?hfGC9emGhpZn/EUFy09tyKVzu6NQeB58Zrr2FsX1Z3DJ4/X/+B3jXxcV5vcG?=
 =?us-ascii?Q?sR8mVnzSytNQawx5wrHPiE/B77PriyGoNJHEqpjLe95SZBgTOS0hSdxwZ6M7?=
 =?us-ascii?Q?Uu25a/eu8YUesTDJ2eLV4TLfmy8QXNxAz6mR2p5ubmX86bfb+qDxQ+Hgi8Qq?=
 =?us-ascii?Q?A0eaQ2tTzQbVyj/iOs4EK190gYhmSQU8gPh39m7ugvbWZRAgxfugJlJW6VFw?=
 =?us-ascii?Q?3qqgYUKSoBFKru+dFYI5KMWdG68jiyXscXAkg1vVUA/yqF+TuLyLPs0GGSVA?=
 =?us-ascii?Q?uN8jbUoefKZ0gTVo/RQ/utKowbhSN5GNnJRUPIK0djs3KWyhF/HBgeKL4Z/I?=
 =?us-ascii?Q?AJsWKBVOuKAC4SKE8V+4ol3ElYO/YZ2vpPDKrSyLYOkfEtZUysXTUEpyE66A?=
 =?us-ascii?Q?DUQIyFiGr5tk5rXdMFsqpzoy4Hnd2RwWjHzNxNzKYVyFn5l3GJSabmjcwj9i?=
 =?us-ascii?Q?pz3umhxPcWWM5i1+iLrX9CTbS07XJjcj/RolKq13yHWIvsdayKfU907/i9OX?=
 =?us-ascii?Q?jEVCgkZXuYCHcOVezmn8a1FSCOdU8JpjspQi5jY2kSZjmTgYYwQ8mNsXh4Y4?=
 =?us-ascii?Q?UI5TVsA4mh6w6/6gYA/rlAs8837YFBfnjjBjqK7UJalW826i3Dmt1B/ukU3M?=
 =?us-ascii?Q?ZL9eu/qSCQDemwKP8Ll0kA+ZmmNvMP2QyaErVuEm7eHiHIP2RsEfj3GD1O8R?=
 =?us-ascii?Q?4aIl06Zmn41Kn7kwbFR8mVT2bQb30WOicGClS0hD/3gp4rLE1xghdpV0SsnU?=
 =?us-ascii?Q?MN5kBj9cBsllsX1WibB5XUkszgvhlYyG7DPJ2J+WfL5TEf6NkIbtLMZZwuD1?=
 =?us-ascii?Q?+36u6DqXdbvSXv37AQkxqi16jygW0wxiHZId3k73ncsxTcm/+IEyRq/mPmWL?=
 =?us-ascii?Q?WpjUaSq8TV7xqPlY8fH4cvx8Bv8i9aR/gcdHA9XVYT456esG/4TanB0kRmDX?=
 =?us-ascii?Q?MAALBfRhhMR4LMD+20phMGgBOb+IXDrubW4JKGUFnMUSgHjJy1VIGspFmylh?=
 =?us-ascii?Q?gaHUWbP7KVdABbq1jVFmm/wxVg73JUg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8726d101-6da1-406c-113f-08def711abca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:40.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PithprIhodq2ns89CcqKaDHmtBHu3hMcVvYA15GX6pLIdYr+UCPvzQPyvtW7L6LMqUrfDX7IZMY5Hj8RW1xD1KCmTVWo8ryBnzvVQGBmb9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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

