Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A2383C6F;
	Mon, 11 May 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530912; cv=fail; b=kKjyZ9BoHLugsU8TO6PnS3OK1YgPFZEciqd/kiTdys2mRQJ+imb6xqBQ27EMMW3ovZzapJBhcaIqB7CbtzGLYn+149HG9JAtbSgBUnqd4ZTL9rSmYyy8d1qUOjGljE3P78z3wq6foy995YDzgSr1EfJQVZettO50fmF6wIhUO8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530912; c=relaxed/simple;
	bh=6gtoRwt1hjmhbTPx0kBAgOPfZg/MaeAz67UrbfoPP3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IChYuypEYb2K+2aUjmzGxiFbdn7N3jDBXSi57mJh4Hh5ox/mu+tw1BxuYm0YQGCAzyG/7MEsyJkk8lkvLShwi586RwDEFPBxtdCWVC0V1eAV+sZdNHJTBSXHdyb/D2NwBP+yV0HDrN634C20vkoh6AL3+27qHwqW77sahOSZ+ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=CE11WWRe; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="CE11WWRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du7PMzFZdnOSLmV98hLIP3f1OZ/D6Q1ZiYtVaPAm1hRAWoEcrJc1ygQQrhhDeGdEEeAUvHDQTLpFoTj5rDcxtdZEzJOrtFDynAuaNDA/zK6MqJtw/Cf8xg8Coa3gR2hrHrHC7cpCk9XOvLBkLALDDF8aVSN6COOpfRFscTCV2LX5gLkLQToCBICHvbOSK2R2z6iB6KRa/qtK2Ij/eG5t4qfuSY8xdmwVH4MMY/iIn/PjyGOe/yRabk0hntsU6OVCcnjMffq5WP251iHF9XCa8bGWyPzCAvwIJJmrowgHCWuroiaF1O0NyehFBGtseMW1J+hltAF1tmCOY97O0HNm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4GfUgp25GkLR/M5LQacqg8sKaX8X791I9niT+LxMto=;
 b=Zxdpc6nraO2XoArVPKuQZdKrlP5qRQb+LmsPK3bNHM85xiF6aDqfe4pGRwu1Sp/QBz9lHs9SgtdeqNP8nfo8icLULxk+Jny4vcRPbdfjZqpMN8xem/+pl6jTf/avPRlywJ13Vggg1sFXeCPsgBxmtTb18cJIYAW1xwemKGagUGWOtjWCSVarle0ytDNwbs3IxWTxQBDEs+qmb6lGoiHIpuOA4wi+yBExTWMNYjdxSpH5yyXH+JeK1CxjP3f4SFLApeLeALszjKV9/tVbKTPk2TOtJNtOwLBy4Z7W0DOgzux4K+3x/bGCttSC1uRpLaj1AphxyL8qVZg/Y5lve4z/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4GfUgp25GkLR/M5LQacqg8sKaX8X791I9niT+LxMto=;
 b=CE11WWReQ+/6EVM0vZBGRbhvMjCl1dL3QnoL82+DacZl0eqDrJIHXxXYeeX5BeJZKJsOujH1nxW7j/tt26DKEXt1KYHizKyN3G+tsnWSRWh4g1wFV0OiHEYklykT3NhrpEkM2uRjXmSyb468Fjq7+6yQqLAQZhzFVntRcUNaPRVyBKDvGQUK0Rf3PGnGXrX5R15Z4/fecj34yW6JrRRAOeUwI99OcwwMxhkoUtHAwpmxznSe5tG3WbmEjyeKU8/ZvimrXMohXAutz3F1JTi+HdPtY5vaHBTb/rVpVT0WEG87HnN3RwNhm3hlzAwcwFzS7KEqPyZ2F5MTxc7cMsfh2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB8296.namprd03.prod.outlook.com (2603:10b6:8:292::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:21:45 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:21:44 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/9] mmc: sdhci-cadence: rename V4 functions for V6 controller groundwork
Date: Mon, 11 May 2026 13:21:28 -0700
Message-Id: <20260511202132.5597-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 8845736d-2e8e-4f45-4d00-08deaf9aeb7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	JeN9E82X5YrbE4ej6pwp8Zqsmw47rjeZRCUOGqmAp3EDhZrjbMm9iROP9rqHhL8yJeM/CYr21WZALtBABbiPsw+ukv7tNx7+KiB0uLoW5aQ/FIrdtYo7CwSpzIHxhb5cNwZcL2tf0oXndxdhBzDY9NnpoftKWHbH1uZcOyov4zmaIGUzNcVpK1dP9o77FdCR0xSOOYDnM/Ucaj+jQNvy0q0p2o02t/BuXc/bxUbhSunVa9FBdV+1oo3sKvLoDMS75v5+4be+WfRP5Z8+N4ykBopamyelGO+KAQZ/kXtLUu1by3U9wN8RWqiaFN9M9172tq/ubx36xp63qET6ZQ1jNgOeRYodIvd+89laW07EbV0W4sPBXCW3hAVZoC+1FVcYmJPZCZqHXrOv1MN6dpBZQy6H7aEcurRQbHTn6gxnzFZrfpzMORVhI0lwAXj3Pcj7NPsJ6pVHg1UKeZGyqiGuXrvkoUr07PW+DOoxqXYVfN3KzfiA5gmhazLU1mrMRb3jQdzUac+3JcpHxlKYlTwjgysFpxK/Bortko2OAoleweeTPziCS5ejx0aySt4IdH8pkhXcbHKNo0fwnWl2LYECKijuwt7v2y1YJCHGYTZ+KmsRYdzW8hU6v2oaLDCZ2WJuQinbt2rDUOYUqRo9vgRnYbfhY66gF7NEKt4p8evLZO5tJlUWOtcSR3dgmFfaV+/p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDKJgFlPHAYDooMpFExYvnnRo0lckI+defutvEi74jzZn4NTGrbHy1t/nz9u?=
 =?us-ascii?Q?7SyCY4DPih+p/IvxTIfEU6Ja4AuAqljlz4Ug17fAhoVi6nv9JA6YM7rdZgFj?=
 =?us-ascii?Q?omCcLvRugGfjBf8bwnQJKL9s0KeURzL3TsKIJcM7JsO8auNbdTWTAFpe5HwL?=
 =?us-ascii?Q?5yFXu2X/kTOXwESFoWsOMG4cuk29hHrbI09QvgUvg4FgSTLBeBljg3XjCe4R?=
 =?us-ascii?Q?pBzooW03xn1vfbZMIC4zFrynel/cAe0leyi5QH3fzBfHstT3rkUcqPkN1WO4?=
 =?us-ascii?Q?knD7psmHWmmQyfeWQiaz7bToWiwo/TXX80cO2/OZgJtqTrFGMfefEe/9gBJx?=
 =?us-ascii?Q?5Pyfar71mREAQ0CPAXFKavCkQggUrwa5qA4POb9gARJyxkpX1B7Dpn2ufucF?=
 =?us-ascii?Q?38rSDAGLowNgGdfD0uF1sm5QYJe5AA2PIkXqVN2Z4b6rspORn7QlAjBFhvzL?=
 =?us-ascii?Q?53mxgkdC8jKS77iEciAWkLedT4VmH2FdoNXF8XhC+cfAH3Ko4H8FUQgnpzRx?=
 =?us-ascii?Q?k5p9wHEhGTMRIRRnplSXZoX2GkiLsal6JRazd37pFOWXkABuCIm6x5zqRE5o?=
 =?us-ascii?Q?OIoQNSItWz4IdnTBa3kSvqH1nMzlIB8M6JOpGIu60xYE8O/JCGZLAxbDWDwc?=
 =?us-ascii?Q?BKg8KjYRHpzKjsHfU5+OdYgX+EK6HxgoKYmq+4f4Nd80fRgvzwdG3pVe7p1o?=
 =?us-ascii?Q?OvqyDavjF8nmXfxvUc5QqvWiDT0WeOw38JZ4zLJzMcwJ+3vwwh9dWS36DhQH?=
 =?us-ascii?Q?vAhn8yaYj5nNzRzH0yJWrHomCCnMo1bKuPmiw9By2YGqwHdIYQyo4/dCm4UH?=
 =?us-ascii?Q?kMK/6UXzscrn+3c2KIMFqT1BaR5J0gHRPi85qKTMHGQXreY4MZtvcCEcn0TT?=
 =?us-ascii?Q?NYKuYJOnNwaSETy9iZnw2uUv9bnRSkDfztF6mIMv0/QZ2qWZwxUdvF4DZJYu?=
 =?us-ascii?Q?TuGQfARdX6d0i0tEIC/1wjJUCJqN36pUQH0nNObVzkVsaD4xWYcKE4ArbuiI?=
 =?us-ascii?Q?upKxq+oI/hq+NMIuyfXd6y0OU17n+Acs0iGmJXjHCxJ2++UAmGJAPONchb3R?=
 =?us-ascii?Q?489XTAGtHpiFmzY13DGrau+MTuUL6CFfCnhCctVoqbkiROupR52P9nrq4zWo?=
 =?us-ascii?Q?0S3wzzYiSb4YnO4PSpwEZUeatg3uV7AMwRmnvxfwpokvxf5yTwTlfPpxygjY?=
 =?us-ascii?Q?d4R/58mnsAhV8k+ymxbPNCvoR5YN7rsT48gDDTNFM8SojLkiYd/X4O4GjKcX?=
 =?us-ascii?Q?1KRhKQz1GmUTWzbhYrF9MXcHF5l0EUfOqKJiehoJR1IDgMaQBKFP7Phc8UO2?=
 =?us-ascii?Q?3hSEoJOBt62zJtqLSCYrpJCIYa41zQVQlL3Tog1yFvjQQyoehI9b0cm5ue13?=
 =?us-ascii?Q?yxYuc0MckIrmghY2FfKj5Ka948NAjM/MyaqUp4nE5yt00hUcX8B6N7o4VEyF?=
 =?us-ascii?Q?1ql5w8UX2uVmVWfMP2lCr5OOEJDdhdgMFKqlY9hnI4pcfdmswRkcv3oDrp43?=
 =?us-ascii?Q?NytR9Ts7DbHzybkx66eOD40DsdSPmBao02GP0mXk6EsorYoa5zxsdUSfWX/r?=
 =?us-ascii?Q?ty++fql/Qd5QliJ7YdDBA2BKrA8JiRvAEaKP3KlVjLPBiC6Nsz22nhrgAgTe?=
 =?us-ascii?Q?ylUKlAZkVNol4ontqjBVLG3PEma+Yw4MflC7MWGG4Y+KHrwl/tolWljQ1m8a?=
 =?us-ascii?Q?lAhm7M3uZ5cIuRltPWduGBayVOcOVZH7NrBh7EvR0/IEcS+InXUNx/GhWBlH?=
 =?us-ascii?Q?C+cB++rfQ+/XbJS5F3nP77vOQEAKZtQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845736d-2e8e-4f45-4d00-08deaf9aeb7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:44.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYR03947socWiDBken6dPlp7vS019V2kRub2jCUkQU5wm5VpHBVMOe2dVtuHjcTBtOaoYhwSxiviC+VZeDsMO2c/6LBZSEqYmzCJmhk9PtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

PHY-related functions and data structures in the driver are not
explicitly scoped to the SD4HC (V4) controller, making it unclear
which code is shared and which is version-specific.

Rename them with a "cdns4" prefix to distinguish SD4HC-specific
implementation from the shared driver core, and to avoid naming
conflicts when SD6HC (V6) support is introduced.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence.c | 74 ++++++++++++++++----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 435603c8c00b..47690a52a221 100644
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
@@ -201,7 +201,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
 	return 0;
 }
 
-static void *sdhci_cdns_priv(struct sdhci_host *host)
+static void *sdhci_cdns_get_priv(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
@@ -238,7 +238,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 
 static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
 	u32 tmp;
 	int i, ret;
@@ -354,7 +354,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	u32 mode;
 
 	switch (timing) {
@@ -407,12 +407,12 @@ static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
 
 static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
 {
-	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
+	elba_priv_writel(sdhci_cdns_get_priv(host), val, host->ioaddr + reg);
 }
 
 static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
 {
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	u32 shift = reg & GENMASK(1, 0);
 	unsigned long flags;
 	u32 byte_enables;
@@ -426,7 +426,7 @@ static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
 
 static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
 {
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	u32 shift = reg & GENMASK(1, 0);
 	unsigned long flags;
 	u32 byte_enables;
@@ -452,7 +452,7 @@ static const struct sdhci_ops sdhci_elba_ops = {
 static int elba_drv_init(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	void __iomem *ioaddr;
 
 	host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
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
 
@@ -510,7 +510,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 	u32 mode;
 
 	priv->enhanced_strobe = ios->enhanced_strobe;
@@ -529,7 +529,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
 
 	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
 
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

