Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324841D200;
	Fri, 24 Jul 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904628; cv=fail; b=R5++v+SBs9g6P37+TYveS7FCb3Isa5KYq04GieWdAml++m4ijZdlkw6DiltRw6BTX9mgR5fs0DfoQ4r9rpQNhN+wyA6i0NDQtzCKjpczMBHvYaGmekbJUdMPF2Ax2Dez310dJ6f4JoVKQdXouOCvPfmgNFC3HgxQC4SirlzkQ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904628; c=relaxed/simple;
	bh=/qCQbEe801eFYKXl15RuNDbK5TtT+CfLD7fUY+9k9Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQKXfWBlD6JKInQRuyY8U2UguymVPdBE5YSOTRGVBSeC0bu4IrbXCKhgNRiJD7FRYQv3seKXSJJM89OT765DqSbEtOexRRT87hnRMZOCM5HuJ8XuSc7dQJl3q5pEwuQomofddfOhKGr9pabNEkoXk9UW8y+gGGUuYnwRaMsVYNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=KQNLNSB0; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="KQNLNSB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCWji5L88j/kGQiuJL5b88PThtqqTFdrGNiskbUUMBKmnNK8RNOyp5o/qTrJnQP8N0YJGxs3cbMAs4U6u/0OdDzOONtPnXrpcMhKmfjZ+dD5a9ZFnKzO3RSjtc/vwkCjQaDiRkXaV9h/BMgxOzXiO54K4rxg1Vp1wXc2zTWo2op/TK4MoD3OPVjbG0EMzGzlOaMjAO2MfoBHLuSAIdZiXPDKsosooFf35jZcx+AYsDXfFtZPn9ALnZFVi219Iu0d8AhJ58tafIzdVK1oL6s3Z15Pwjx1bJqZaR8+3zsZO/hP39+hQil9y1PjpVp7iwYA5ffOQ2r4C2tgwQleCowWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+DFwZkYa2Wr1oCZ4U2M5BXeKBd/TzzU9827UIyV73E=;
 b=yR0z1WJM+R4uL6JU4k/V1yXil4EDS/0Bbvl1lfCyTH6iKBWyltM6wU/wNuacrsHVJ9MaJUbuLjp7btDv7aeKgGuU1AFJ4b/5dougkjUtwNfHLDenttI4s2l7G9xuOoTVANAP3IYIIFlI75mMz04+2Rs1lqL+ZYy0uw8aeYzmicgcgPMAiaptWGVVCTdZ2Jd28jYdkyNw4RRdWXHXTByF25f4YumwwphxWj6CRUVgmn6KTLjWUIMxHz4STUuMuVf97P4BkWe6OzLB7ny3eWk5LgXaMlpqALVg4/tXSnx4MG8AUvn1B4xjwjkBRI5yTuXdH27oBBNWkG3HXVswBC6EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+DFwZkYa2Wr1oCZ4U2M5BXeKBd/TzzU9827UIyV73E=;
 b=KQNLNSB0mP5PuzF8XUSUYQEZWhVWc41kIEKFYi/gvUbWnMmnv+/M+Kxf8YXxQkvEUA4DVH/Pv3XBwrlTcKh1AD/2+QTllkB6LAGTf4zstlFp6H4qG7he/6NuVKfID2lrOTpqgjbTCyYAAgrQZ3kwRXqVrAxYLpoFP1QCklu+CIoHq7Xty8BG11pd25RoeGjMn+tHcwVkpnmOt63/sv96iZ+0Ln0c7Iy4V+zDKezBpNNPDEr1k0Df7eE+7aKxz2e3h9584yu2m7QThUkPO67XtExVF92GkQO9cYkZQTAD0xmIvgU1ZaGgqRKs13AwJRq2NZHqHfEBPIKo35//SUzm2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:21 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:21 +0000
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
Subject: [PATCH v3 5/8] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC groundwork
Date: Fri, 24 Jul 2026 07:50:04 -0700
Message-Id: <20260724145009.7456-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ecca5c-9be4-47ea-4e56-08dee992e292
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	JYEDTpUrkw+SmEqxkI9A6gtx1O42nzeKB/QC/7KuxZvEfGXDU0VQHG/F97PxKwh4gRjaldH3wCNo3XJO47bDgFZg2N45UVfiwNuJgXixG4gDnqLpftNLkOAYn1Df1xSiV6//WzK6mQ+7+IZDijYm8CQavV8efsgKjoc5PU0GsvzM0yYf0K8yal8AFftCUpdq1xzktjswTRXld8dOelT981t0XjeIKn+YprYszMAoOdMx4qaHg7rxnc0E+yPX08Q7J5Bhf05nP+mIkulZnVTDZx1gXH1Ld7zxqdF7E+gkSY0sm795wyojEjFbGAFt3ptoi2AsGwJdDUPITXF2LfenPin5WibgcksCmmnL5lBzWQUWTjIe+/BVIzT/oAdHFdUkfmdTg4tsSub/x3eSoilRzYF/nzrOcvM41Bj28KN69sIVZxUQxTgjEZeAi8OonYzj4UAeB3YMxMPsPCMt8s6O/onvqGDOtAITrzHNxxmqjzMqfmfFFy8H9+829EJk8o15vhPzBj9UgwfRd3Gwc6eBc2pZYs8wMdJvewW5ZiFFwvI7rmIrgwouifvzdx23c7Qwm0J/GCeIrevIFasDHseRtDDFdxzT38YgG/c4qiIcbJS5smsQlLFSSNKsJEbrMyVYVWfTwnOo9hOCXJOH/jUEnD+BzUntQqqyZ3cH8i5SOr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iIlfsizx87SQ+re5ccxsD4wj3GJ7XAeRzv1meaUQQthTyPM/eTSrTA3Qd77?=
 =?us-ascii?Q?2O1DfN9lkAQoOMJoIuh+TyJjc6oVfkerDaSRSsrT9UXJ4pDFeHMlyUBNCXsO?=
 =?us-ascii?Q?JUl2sPx4bQj6Jq9KnQqTJrOktgc2ih3+y6iIcRfEfz/irjEAKTazorXU80Qb?=
 =?us-ascii?Q?aiqJRdykS6aNfi5+qbd+OZXPUNtz6KffpUV5d3Iq1kuhBS1a3/MJe2G1jYHy?=
 =?us-ascii?Q?j/wWTeQaR05rxAqHYiVdklFVqWqwxiiPYV6NtQpzqSPLImOEse5g5IGjl7id?=
 =?us-ascii?Q?yosOMRsKLDqhJNZh/WUu9ixEV48hB/IItWS1qW4OMr3uWOdl28LlGTy2QDwR?=
 =?us-ascii?Q?O+RDKuIaAVb4q3KLgybK6+Q6n5e3/1DASnKeS1BohSsUWuw73dlANYgBLOoa?=
 =?us-ascii?Q?pRzjQzsAwAGJgxDRtT/1Xkxve8sXcMINWUKUZeeMnwghRZTkriWIrWOjVm+c?=
 =?us-ascii?Q?Ct3ruFhSzNlM/yVz4aOq/l/QiSrmzpJCL6uBXvJ0+j1qS1Jpls3AvuMq8WXY?=
 =?us-ascii?Q?UMnCPY0Jq7GZSCh8wQAW5qbzKiwGZZBoKDDTarRErpegPK2XaGSArl1F2PYl?=
 =?us-ascii?Q?AM4lf4H+zwK59lU4yRbp/tU93EPeiuupCbNElCS0Si3tuh2iAj+i26hPnv6G?=
 =?us-ascii?Q?zi1PeehGyEOUsosf8BcJ3yikp/wI1Ee9Qarc4rj4gj6MgIGR3fVXxwHAVN83?=
 =?us-ascii?Q?eftVePzCdnJUjyznWyAOjQujAXuCFXNRtgXdu/Yvhrx2QUjB3ptnhZfanijy?=
 =?us-ascii?Q?3Xil5GFfO/ilGYU47tHf7MFz9bn4j5BeR+yi/8E4w9J6iLmjVpF/RLnsq5+x?=
 =?us-ascii?Q?Fh1UMXeIjTHBVq3CzP8EswBwSrqD0n3pazZazPLt5HnSjU+szroXHZCecPYV?=
 =?us-ascii?Q?gi4YpCj5vrncO/CNsEjw6cLuFrq+MruY1B1R2YEabN/R0VZb+0CkJYiQWoS+?=
 =?us-ascii?Q?TYoUIZOpUnUW/g1lnm+2ltP8M0/XQfQSmHtSiq4D3eCaOx8s4WQNoWzzqlzp?=
 =?us-ascii?Q?XiecWZyBgZtoQdPddKikeLG770s4Mk+z5XVhz8kfu3Z8k/PGQXkJv1upwjFa?=
 =?us-ascii?Q?eAj3C3oTgNPsKVKyoOFW8irW2YtaqXzAwKRW7CHhtSWBbHoN5FvOv6cKRSGN?=
 =?us-ascii?Q?OVuNamMS2DuH1mTbQKAUL3WOFvoyB4Hhfdk+XNeX/FK5VTTKZjUaqTsjFjV1?=
 =?us-ascii?Q?kdnYDDSrDxIp7mrUMLnoOqKFmHhODKjCgF3IUtLGVa6WwAZgrLWpEXsUQul2?=
 =?us-ascii?Q?4RB3P88UF0HLu1icI8BsGn5V6imQZF/aX/rhiXHerXnQ+h/JsymxgejFHsvE?=
 =?us-ascii?Q?LAyjrZQ8+tfG4JKQM7LSoTtbak8SYUSeDyAW593ZUQmImif4AG4cnqZ2gqI0?=
 =?us-ascii?Q?F8zx8laFQrzvd2YnapHriXLJ986dcfpPzvtLWbfm7iLdfF6RnpDCPyKxIT0p?=
 =?us-ascii?Q?H6P07xo/soPKTPd/uGKtrXnJ5hff1Xl8xr/YvoU4+gZy93YE7yCF1IZDoJa1?=
 =?us-ascii?Q?vYrDb++iSjq+1YW57ympKj1y4fSegE+dW3Ay+q3ss5qjOlA1lWTqQZrmu6Mb?=
 =?us-ascii?Q?YKD2AiEMIiBHp4flWhYL/jB+N5G7cgF1ayRqoUPAowjn4O+503FCeU5Sn2Tn?=
 =?us-ascii?Q?ZJ+s4N3v1Y2MGoBT5R1cv+4Zh/WSNlIIF6VEphO2op+b78mPX0XwKtRaZjW2?=
 =?us-ascii?Q?iLDD0OT8YAB8J087nQKng2G25lIDtHfxZ7pjx1WEophvQ7ybe33y2h2pPE07?=
 =?us-ascii?Q?/M4xK1TMTW4ei1ycgrJHGAuqqFgvNws=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ecca5c-9be4-47ea-4e56-08dee992e292
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:21.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onOmDZ7AMDY2sB2TsveBeHBJbW6ZZ5Yz65FH4NvgWvYpL3ql6RD/3InnSWof5JEGc1a3v1qks5N9yEKnxjcWMWJTxy8fRBz7XjSoiS8widQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

SD4HC PHY helpers and the default ops/drv_data are not marked as
version-specific, so it is unclear what is shared versus SD4HC-only
ahead of SD6HC support.

Rename those symbols with a cdns4 prefix to separate the SD4HC paths
from the shared driver core and avoid clashes when SD6HC is added.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

