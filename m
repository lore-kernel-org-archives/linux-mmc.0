Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDA34889F;
	Sat, 27 Jun 2026 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591341; cv=fail; b=o/GtLna0cgG9bRHWBZqEPn/g8CeKm2G7phIWLC3faV6ydaa+G8EgwPCZv2tDuiqcHiNMmo09IeCQWBsj3KcoZLfXb1Twi20LQ0eH/LIf/xEdkDNIBPQ9GKedva0UH2Sd+5T8+AP2ex7ASZMpCaoycQxfn2Brn1LSv/VPeseDOt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591341; c=relaxed/simple;
	bh=+p6HcttQakR/ZonPbw44mf0bJHjD7o8tauc2oE8CW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQAj1TZ4f7lYr9JtiysaQSWoRZpoZ3SdTr4wmAO74kFbFs4fYec6nXzJ/G5w0TsbhxT/7dvP26bPxaHK9MzZBS4ZDCaHyTt7I7jIcBXLKfqF1A1i7rIrtSFsTupEDxlu8ZxIWnJlQHeDcnUqHF3A6Hy4khXBqz+cGhekFQCQRIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=A7/xzBTP; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="A7/xzBTP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW0tI1ABSDD0ew9CkJkd2A6J6Owmh8w5hgW5AvPweDZhdA2XU5qmNTOgI/7PGdGFab7ADKiZasfGBapDIk6IHryPjQwal/tH9QkmBKgt/lcUMe7WRKfSi/WZksGBrnYeUEskaPuiQJxhGxB3u05AcA7T1BHuqj8B6JB4L5nD4aVw3BB2UL04uKjSJFmg7kJFdSYJwgsFEhwRECqSUQxzEJjxTor1vFJ3Rfc9zUuU9S191oy3hs6Iohz2/JqTlCGVU1xx52Lm+5djP42jzmlrYxv+qqwpaovau9N1WCPk3J8Lk2zAYC/ye8OoSMVsDY38KbQ+JpPfyrxpoFRpXcBuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/soF+yxxL0ki9eoMjreQrfXL9YrKHyuJzkD8dDpvf3E=;
 b=FFbgGQ0+98FZAkLp1cWoQ3i2UN6ul0noM/6mFu1Q/be11kNgm0O7dIhvkI+F9S+D61OajuAROz9SiwU98qWoSYHwtNpjdM6vA2oVTwdakrQqcAzlUjDKtR+DTJsFIXz0yw0Ro2QqVwocM/L8gHfGahPOyNBa1gx12jeDk0bn5yAWg/mSzeE9kCd5X0TCjBBt2ourKYjsGEfcoGxvyUcedj14p6nkTll3jWhWSRG/8SF4od7x+ieeqzyIDVII0iksJMip7DNYxpFqnz+ykUZ5WuBi+aznUXqUvSzH9BF4EDNmFofYjVFWMUvPU0IcR49/4JOU/ZQ7WRjJwDXv3m33gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/soF+yxxL0ki9eoMjreQrfXL9YrKHyuJzkD8dDpvf3E=;
 b=A7/xzBTPPXp5OewP8/l4BdEAOyxLrRmHplGXthxTuN5PVlfkNbrBSuQlmOoPDtsphkHQ/6yU0z7HAVMhDcrxk2HfctcYi065LJksEDgMwyZ2MeI728CsIbTogHpvXhOJFzengNlObz2OWR9vu0gR3KyB9q3lntS2OvHB0+5Sr6cjHBPMxEUYZSIzmZ9vG9ZY9n8BnxZMJZ2OHG6+F5bgsllGwSD0qw57ogBM5Vq1Xr2dx1EQPJOsuwYhNrhjsaDMXAqz6L38y8hqmX2LXuW2itsr5FU/9yGlc0iCEgFYQEkeoDuzg+ka183/I/uV+kGewH9wZUCgKk63AnsG+gQ79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:33 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:33 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] mmc: sdhci-cadence: rename V4 functions for V6 controller groundwork
Date: Sat, 27 Jun 2026 13:14:51 -0700
Message-ID: <20260627201457.12318-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: d23a2b93-37b0-4154-522f-08ded488d7b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Y8AvoKyj22/BNEK8mfc8N5CCwMZvOluY22A7LCr2MjTTGJ3ERaRH2ss0hOjlAqbI0+soxOPg0JwcO0vy2vgx8lgP/KJI6Lw1ESAVUsa2GS8aX7zUGRql15ZC2DOZWDLZk7jlmcjvPSJMEtKR9DCz2sGFulcLl9wIIxm9uNjsa0KJmSn6OulECFGmE1Iu5kGVHW4pQeChwMAPcheZsseyRaPgOCoOHSkeuT9R+W6LvmuZp5uXJgPW3Xa4kecfzWkBpWxnF4D5r8LaqVVgt8Tv6V57Mv7hxTKOjlcc0IwZXFLZaOyJUvtdmU11/8Z2RgxOrWhfYa7Hu3bVps6JAmbSojEiM7YYKP23fWh8nmzRIO3I18eBPiu5dPlTAQjFA+0NBKeOVZ9kdHPg5+4Jx/b1WCHm4hUXVaEkAkZ04krhATZCJsGTsfwZf12JvKz5vH5pNTsui9Z7uRS7rqDAadx/qbGB+aR2lQJcxDOiRjnjV+zyJCytAro5V/OLncQ1kW9zjbBz+JZgaT2ZANG5S6s9YanrRVyaf/p448p4v3QUUH6NiAUthTPyznOph4LHOfISuPajTHIFCDo03ie/kW0qpvrNyAaq/ULmGy2jnnVFvLAPZ5FoTfbHtluKuj08K/JojwdONKmj9GzYja7OSYNB447FEaquIik8SmQjwO4kHmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qUmJC6KBep8qoc7c4T46UKvQA2pSvEj7j3NsZUz6fSocjSZJ9LGsqcr0E4I/?=
 =?us-ascii?Q?1oCv7SLdnAbddaN2Lj+iORHB5gVzVZljN11KUE33eTqHRgsOiG0oSq+Yaegy?=
 =?us-ascii?Q?1maF+p0Z9fMXn/5rTS5kYXC41DdPHOXROWu77HbMSx5Q+/x2+j/dbecP0Bx/?=
 =?us-ascii?Q?JoIpqFNfy5tLfibzOHSxtslsGr0JjguQI5tcRtW1tDBWx8dvEeYo17TnmOfH?=
 =?us-ascii?Q?IjSY3QhKvlq8d1tlrD2UwJCj/tXk98/WW/mccBruZw9mq0N9v4/J+ITB8Gg9?=
 =?us-ascii?Q?ha0DLP/WlHT1ChdjxwcZOHMgJLR7k4tjKy2flwJZIuyEvpMlHVJaoIwqbfaX?=
 =?us-ascii?Q?4HKYjDDEYDrgynyT1tSudIoohxvc6vfIcXGTm0sF11VVoD1vzzrCxPxL7i04?=
 =?us-ascii?Q?k/ITGU8APgb+Hr5dslCcnWoBpI8GmoD3GLjVnh86fUj8ihXJUxEmdc8tEcWH?=
 =?us-ascii?Q?cO9JmFFIG76C2b/R0qAytnnv7D3NpZvDBmJV/tJBzWLfa3NTALv9MTGowYMi?=
 =?us-ascii?Q?q0w3HEtWYM/GRHtVNd/wiAP5+3Bey8qpqT+6gtht+E3jGHtLAex/r/StrTP1?=
 =?us-ascii?Q?vmCXsYLXbJwmi3DDuGY9w1BL+mprmSgpf6FXt73gSfQ0woCIqm2hg6zsrI47?=
 =?us-ascii?Q?tbAhd25vRr/9BbktDlaNHc45s0y13LTd8MqdvYP7xUNr7IPYVNiznTj31zbq?=
 =?us-ascii?Q?JCDqk2I3DMY+QHJgHa+CWEmSbC2h+ytTv9Y1AR0tuR2mFsCDMuFf/y3/5/Pw?=
 =?us-ascii?Q?a/kQSxc+apJh5m5WldY/RTYVaPGgsh/6nwlQA5QYFn7dGO2HBv8A68x3mvDf?=
 =?us-ascii?Q?umjimyM+XjwOe5u1miElhCTqrvspvDJ/aJwLToHf2eCFIIEMgqIPHcvRdyPV?=
 =?us-ascii?Q?A7IIICxlQLoJDtjoiS+x9YSrr2awMqs7XI0mvDCwDmT18gIKP47LVQmzXjXT?=
 =?us-ascii?Q?g43uO50C/f7V3hkF1LM2raCN49Ml+GL/x9RYqJxLVmyEgSPRJDIpEE4ulQWU?=
 =?us-ascii?Q?vdvQu6e9tHWy99q04/nkmu23MxwSSbs61cTzYwwp6ylGEQRLDiXS0UFKQ+Ye?=
 =?us-ascii?Q?nOYZxa3I8Pi/nOWcN7GmM3OcNBV4exxePEYu+VqyvwwBVqU99fYiDq7DCGJu?=
 =?us-ascii?Q?6Bg0jJq9YZOdPKHII7+Xcd3OTcEsx3BiZDzjbMLQOygJT+vOZDet4XOjvTeN?=
 =?us-ascii?Q?hSvVIBgML4/2MGpQ6rNco5osdoDcdUmorYVxtDtVg20ipp/1OrerBgzGD1Md?=
 =?us-ascii?Q?Fvmnp+xisybCIAudsLF9XwWj02UK912wqd0TZGoKKLJMFku69zlVFZFVG0yh?=
 =?us-ascii?Q?uWlHPNdsppKnfrsKCiYRAzGvMMwSJd2ysJihcJjVlvym5w6T7dsXUendWhvZ?=
 =?us-ascii?Q?sNYGNiEIWEc4L3UIV8IGw1N4wXdcMp7Pe4lY9Y3VEp8WVrYKKci5Alk8crSE?=
 =?us-ascii?Q?aHusdlk2qIZ3xe6DyyXiZIxKYXezAF7nIsvBkljd38159+gtMfW4ReyWVD2G?=
 =?us-ascii?Q?SyhBTf2zU5zXFy880tYmA0zXdbRXEBIdriCbLzq2NjQI6SPLu5EzpnIDF3+M?=
 =?us-ascii?Q?R0HQbN8OMvMfMO40R2200BNDbfTMOdQGKwaBcWG7pgNTmiRIio5E9pcUsZhQ?=
 =?us-ascii?Q?sKiRAsmZCDOhDS7nakoC1pBtL3mcTXx5emOmVaA3WCgdIMyYt28jmNwneC3+?=
 =?us-ascii?Q?a8O7jfi7kkngxXTdhPVzTP4QBbjcXU4C9iTAfxWFqFKAsvG6CiLGz30DDhas?=
 =?us-ascii?Q?BNZJ9UG280k0kRzO68/xi8P+2diFAEs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a2b93-37b0-4154-522f-08ded488d7b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:33.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyWnd+RDYtPbCmkH/sZCX7HFZvyf/bX/e0T0fz5spQj3t5ACyAL8vLcSBz6I3J+PJGUIjkHH6hRpzcQeyMWNq4QQoeg+MWr18wDYbdrJK54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

PHY-related functions and data structures in the driver are not
explicitly scoped to the SD4HC (V4) controller, making it unclear
which code is shared and which is version-specific.

Rename them with a "cdns4" prefix to distinguish SD4HC-specific
implementation from the shared driver core, and to avoid naming
conflicts when SD6HC (V6) support is introduced.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence.c | 56 ++++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 435603c8c00b..b00dc2eec922 100644
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
@@ -124,8 +124,8 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
 	writel(val, reg);
 }
 
-static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				    u8 addr, u8 data)
+static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv,
+				     u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
@@ -156,44 +156,44 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
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
+static void sdhci_cdns4_phy_param_parse(struct device_node *np,
+					struct sdhci_cdns_priv *priv)
 {
-	struct sdhci_cdns_phy_param *p = priv->phy_params;
+	struct sdhci_cdns4_phy_param *p = priv->phy_params;
 	u32 val;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
+		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property,
 					   &val);
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
@@ -470,7 +470,7 @@ static int elba_drv_init(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct sdhci_ops sdhci_cdns_ops = {
+static const struct sdhci_ops sdhci_cdns4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -481,7 +481,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 	.pltfm_data = {
-		.ops = &sdhci_cdns_ops,
+		.ops = &sdhci_cdns4_ops,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
 };
@@ -495,14 +495,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 
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
 
@@ -560,9 +560,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_drv_data;
+		data = &sdhci_cdns4_drv_data;
 
-	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
+	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
 	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host))
@@ -593,9 +593,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns4_phy_init(priv);
 	if (ret)
 		return ret;
 
@@ -622,7 +622,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns4_phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
-- 
2.43.7

