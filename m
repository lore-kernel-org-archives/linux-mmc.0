Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D639B4BF;
	Thu, 20 Aug 2026 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252274; cv=fail; b=PNho1LDYGRCfKceG3XzpDsaebDG73+dZqVLb6lBk3pitmlM2HeySpAVYhgWPKbSYSaS3QKCCTjalR53fL+leH1O46kFZJWKNLuvMShpZ/SsKC/rWGuGStIh36XHJwHj6Q04J/19y+D9nHG0LGLSbE7s4bBa7QQfnpWwCt0Em+X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252274; c=relaxed/simple;
	bh=/9kP3YIJI2bPUJlRgqfKMOa4sX6p86n54QKNqeycb7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOkvsxroi2MU/+22zkP6bXHCM2xrWLevvzzViH98aewzgNvV2WFqFPrGq8QUugWqXh0L6cz27eMRbwDZj86E3/+XLdYJlA5yliaSNxhaRKrbclY14gdxZ8ygj8CsaF5jZFdkvzvK5W01zo3cJ0TPTnJjJguJywltAZPUh63xVkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sGJhSVO9; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sGJhSVO9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgBOkvoj9VlVgPsdUHiIx7GKEEijMDWcM3ziIekaEsXDPmt1/Ecyr+lKF0IHja+AklHjLJRiTpzM0xEzgX8uraPABCd5R//gAdnI9/tALc3oTfFch8AKWfzAYw/hIhSHr0MrgwsnwILtsflD5r3BNxYBtHtSBwF2CIHg02wkBTc4I7adWBI+Zg/b2Jj0vbd2654gfvtWpYPTNZBMRBttAR+xb9Ihcz3Z6NJRuT77/zOUUShe7eITb+IhKuF8OUGmeJYPirkca0YssTB6wPqAwVjrjdLZBWV+VkFDVwUJPMZJMBMQZ1nDyGmq+dfXtXeYsaA7x6YFPns12WsdzOMa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=eFVuj6xXG3oNYaI47WB6a2jKS707CUwuwI+jerzRfdY9yQYVqAIQpj2x4AABT4EqLdwnkvzwRtIzJaJftH2yhHtUy8KkJ3Btw8B+L7JqJVeq93saAN+3f9JipqWcaCgUeYWylPgfRdmM1Dsm/566r/ckLQmw27sfD2todPo0WDZMPnTRQNmtvSy+wzete0F8Z2P6CJ30/Oa557ASycGm+6osANuLuRiKBxmnO4AZVlvk7MhBtQ4UDvsuwttm3JbpOF0RBOyRnAk46GVXlDs6hzq+xc9QjQx4SSrzvK9ru1X367hbFXuwK4a8gfSb8lTxNmmy93J1Whcgg8C7ptIOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gwlxfy4vj6TJOe5K7c6UuF8wpEdHBkJnS7xTRYGQP4=;
 b=sGJhSVO9ovNyUSQgQb/BAOIskM78X8hEHROHKrEEGmYHMsXK+ChDYJ/8SGvCw32G8YR7SoOE0caVAn7ZmKQ0MGpspvSiVtk9smMGPtcEzIWz67EWkSGPwjVrOzgRkg09UjJ5Hg6cjilN/EsFt6OD6HzmMKpB3ROHstZPLO7wpcf+Kmbj6G4bvJqAnbtTEEYKfr3/Qequ6MmMfHQYlYM+7DiVlHDN1GEyE35t+TFoR952eOWHVUMM8+oUcjvv8qRDDYiBl/re1nfhkICgQpkNDuvS+q5q5zJHW3TPiicUUIjOKBEF3xrj48lcGcrT+eLwNbea2MQFnPkQEF1MNR7D+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5636.namprd03.prod.outlook.com (2603:10b6:208:297::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 18:57:40 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:40 +0000
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
Subject: [PATCH v5 5/8] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
Date: Thu, 20 Aug 2026 11:57:11 -0700
Message-Id: <20260820185721.22823-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: bc357dbc-818c-4ed5-1476-08defeece8e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	pSYn/oCJeQTk9iHT3TWG1oHUsOS7u81rpzE+SdMnJzyes6Jc03aUAorYC7/E5Z694ZWgWI2ryoRiVPCFz48L7/gsMxZe2rtfAgDmTNZf69OehBl//CqyJhn6G0pr+o6hCBxQWiy/mw5SsrJhMrfq7qxqGDcWwWtopdpJW+CTT31Sm345pm5nQ9YLTZq2WAFmQ2CaCXqf/KslLw9Lddg+D/B2pngu64PYW1U2xsL15jEQsUcblVg5K2XdXiSSXAa0HPBo+XwgPC0USWiO663tiCKu0gNmguOo72e2sULBokcoHlqIpb5M6qU73jO3rABPIC+qkHPNMWblxt/o7cfCVUEbQCW+DrveAZ9QSBKwNLe0X1/Dz0dgyaTln/XMjbknEGcy+Ykxpidty4hbsiFb/lA4nNwHzTJKaAU1tvfI6hn7frUPc9uYP1atqYhKg6ZC6ZPAkJ6C+vIroDbb0pqzYiQVWOOHVVuXDdwBPuB17EkYjo6DNZ33Z4ArVdg6vgUlCqzxgYvP28oi7tWtWVk1vVKjkVfFlSL7D1lCrIiiWLI2iRE3f58SHI01C1ROHzpFE6OWUpVLXpx7uBl+ffxPx+96HVSckGpXD3H+WEHY4O64SHugjOBVt9zDQNLjuX8NdrRzS3aCcdABNRVjxP3uSTVMHMe8z4KBvzPLU+W905g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lXAi1o1xzu+n1zc/MtJdfyYkDUIhq+3cg/tS203vmXKxcg1BToA++E1imTy?=
 =?us-ascii?Q?bOAoYKjafCXDxkqVJijJwPCs0amAe0eVox6l/S50UQm2HnhCv2qR930iWEY8?=
 =?us-ascii?Q?3nbs2pI2D3E+wf0AoEwVQTxIaRPVUilEaPBXYf/2ixXChPZwotpwPVhvsu1D?=
 =?us-ascii?Q?UYR4EHU4XFW1Z+bFuINA04YGGRNVVdCBDId2mDaf8TjPzyD4UOmYrMis5ebV?=
 =?us-ascii?Q?HNwX3OpBC8ic4cW5vXqNZ9kIX4zyhP6wFV8p/uHs8UvrEnISr0Mm2USR0//B?=
 =?us-ascii?Q?2HIPwQz98+tKjUdp+i58g/HPjXYBU975AIMSku6bVKbCrAdkoWFCJE2vs5Ll?=
 =?us-ascii?Q?wgnvVZv9lmItPNQHxGosbd+vceraE59dJpK6qXvXLWnoeGYIhyY8N2q7T9Vp?=
 =?us-ascii?Q?MWDYI5nDmi2NuZrDWL5DJjZbcStgzaAVtPWodbuzRz1CK488rLE/hnGMtR3e?=
 =?us-ascii?Q?WptbOo4gN6sVXbsKQJPMXNA+J0bF073mDnXrgkKjJhlP1CaC4QK5Cv8+af6U?=
 =?us-ascii?Q?iqfU4JDleLf860xSLpj/4D6IX9w68OWTM+4qZntjegQqIUkNf4zeCtKRr2CH?=
 =?us-ascii?Q?1SXu7r1Yzx8zsRxluz/c72p5Mh1eoCcv8S9IfvTioqk5xlBCv4r9DAJr/whR?=
 =?us-ascii?Q?ydzxzHqh41u8YxF3oBtcSHmzg5iiiFGsLdhUakekvIYNbEsukA4PKqtIG+3p?=
 =?us-ascii?Q?Un9pEGDzbQUIu52vEUhBxXpckKg6OyB59+e/XqppHJCrzp41OTb4N8En5g6/?=
 =?us-ascii?Q?C/1o0kF4pQWLdy0E8ZmerCJ6DZrWO/H/K3nbskzPUz3Fiext44rGgUV7Dyd9?=
 =?us-ascii?Q?JVbO9AlicGS+JpKq7yVx47DDEtJBOsUr4zhM11DM2ntJdPrzYm0AhV2VAn5B?=
 =?us-ascii?Q?sglvInyB1LwTNq86/ndktYtwwoUn9jOQcvm8fV8W5IW28/I/C0bxDQSmi7W5?=
 =?us-ascii?Q?xBmYTIVP4anTXM4RGPzXbH1PmRFt1hoSQk6E1kDAiNOkllfPoc0j6gpXJxOA?=
 =?us-ascii?Q?i19Jh1ShCF27FzifaU1gAfMgCbzFiAHJrryM5TcJSmiA79p1dlTAaG/dG0/2?=
 =?us-ascii?Q?EkTS/yHekVawejXtC/eaa53bLiD8tQ5JezUbzyoB7eHHkiZLvbDFwDSH4ZXN?=
 =?us-ascii?Q?gQKX3rrG7WMPsJ2QUHtx7BRSxOEqaKD2Bpx+akJzzIaeSPQRD+j8cgMVgU2M?=
 =?us-ascii?Q?09Q5wrKTobRoDzWy+d0/CSVHlcEA/aMS+xClHF0lAdZR46HKoRiZGN7bhDgk?=
 =?us-ascii?Q?9cLlVzICjyFiHjhByp4RcHQAw6kWvGWgYZKpPFfW3M4bNlRffUZbfUAn7d0q?=
 =?us-ascii?Q?qLNTiyK4f49eI3jXIafJzfJh+jPTQe5rM6HrCcuhgTm3rmh8+l5tcR7LKS0B?=
 =?us-ascii?Q?I5nn49LSn1Q0XhUG/pBYpO7aV1xArDGoqJDRYkrU5jchN9xfi6OjtKGHRMGB?=
 =?us-ascii?Q?L9tqWOmk/kFWUzM0D7PtMYW+9ixP8pKeq2EDJXvrSt/OT7bcMIJvIubWMIWL?=
 =?us-ascii?Q?Rgfy9Vc6JjJKZD7b1WwueOuEG4o0FF2qrsmQOiv6pwZvaXzYZTw2M7hp764d?=
 =?us-ascii?Q?zQxNY8O0R7siEK8szDzMWvx4DILkiRVqXWdsGmtoAouL/IckT+0AKyVqatf0?=
 =?us-ascii?Q?aBbkDdSGNwdxWem42ERr83mu0S8VyrVjjUPOO1aQDhy/L56uhcSihLKRCmCV?=
 =?us-ascii?Q?FYLjryQ9Hh+NE8h3FMq0HdrDZKN/HfICHDfVHUgMckKEBQBBDT3hiKhpjxNf?=
 =?us-ascii?Q?sPTaVy10w/9LLFqqLRDOPZ+CoOXbXxE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc357dbc-818c-4ed5-1476-08defeece8e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:40.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWkoVMA7O+jUTRtCP6W18uOV8ncOEiA9WZ7vMHaqjmZuaeBMqoll923Q/lA1pr4hyMuzED9lluLGM8Q2LeDTZJwlifPyZLINhhxhxFXIEhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5636

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

