Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC03352005;
	Sat, 27 Jun 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591342; cv=fail; b=fbU8tKQ1mWRXTnpjOnudl8PZbCZVH30p2dCPaNSXVALNl0g3s1QF3mcQfUq0miy+XtQdgsdiKUDBbeoVGf9Oez51yhYODA1KvXE80c3vkSXqJXaqMSgTC69Vcnb9fHvoguRyOXXlNmpFIX9YWZz+qoIKA6yteELuj/Pb5FjCdeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591342; c=relaxed/simple;
	bh=oFAjYH+HJ6qUdU37eZp8GJQm13wfNg4RV0mXdoSBNcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRnUHJfg8MutuM007rPHYVp3DfGeGPXHPC69lFaA3+XtlhKPNYsrKzkMGu8XsYSDQlZ8zJ1o0Tq+bj43chNBBY5Ourqwku69cTTaEj18vKtbLOZdKM4/6ZBo5jqzonWUpjmQFgDh7/ECQDRWeZZXOwYZmUwxkKJL5TW1qno1JfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=utNpaiDI; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="utNpaiDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sShY/1BDBmvbD8srxyZyvUNqmcdMQwSyZc5UzLWSUW2P33klJQSozTaHkCSTqAbrNiSsFTbhYLh5CQ5bMI9n0uLmuCERNsasvIyvK8mh5j/JkYuf/HjmZpv0TqYFr+wANypKihTR4sasUaHrzaea0SuOpGi9KM8L3F4Df42d3mTn8J+uCV5sN2go16urXWIORh+L7s33Xe0YpuOo3woJfnVJp2ZUz5uylO+2NWh07R4/xOOX/ELThIWkhIVHDPcU/7Ol4U/+YQTEUGTS4hZM9IVZk0kCUORhnZzBzcWwIV9Li5gW+YbXugaQm6I/bH7qqjG2YH3sSwHYIJ8FnE2HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WW7gBd6KrCqCHQNulmpAGJ+Vp0KkWJ8sRBOoXykiAU=;
 b=ngp6JcLzRje50te5mt4JEQK2yZ6KzctNki1JwOsMtfNzfZPbJRmgFnGB9uK0B5KfhhXt62OMU12Hi67zg0kjpOuDy9OAlhDgWR/UvoYWvTLEzMieGrfuwnvLyvSwqIPB+UCWzHVLAyLRi5AFKfzpO6Hk0M6unmoFullleyUmMQPWu+DKLLyaKWcKmoHWTZaBlaQq8xAOAhhKt4hPIVUieRdvKmjuRpUjaa+2nHVJ1/F6DleoJ3ojfbvMwWgcefLgz147FJlj3hHfcyjLe1ffAEU9w+gXYaCEC9qR7Ev81vJf5psYJDMmh4YJGTDsBycqIkNPZH2SZvGXqpixM1jIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WW7gBd6KrCqCHQNulmpAGJ+Vp0KkWJ8sRBOoXykiAU=;
 b=utNpaiDIPBtP+s/3RUHsABUk4kK3ESlMiVwlkbw6+VUE9OP5FM6G+Ntfj2G2vqMcH//6hJi88X2RZL1ZYiauGadEJ0izhtY/ZTqsSrmB72NDK9XcDjHcbq2bCvu4CrfQr5N5K2poBgohBMzTVuf27x/66MAPtVVQW2KUjg9GluyRQj16yaw/0+3rnNOUgQ3v5oOfk5zOmmTlXdBqXOWyIahf7WL+HElpXTGpx6MehXzJPIoOajYDSIMaP+eY1ystaEhQoXePd8CIgmhu8TYcZLU62MgTGDTEXTHZo/rsIbRc891bF7Abcq9ZPXQsNRTBgiWom5FVsZxWYNM4ratFMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:34 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:34 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Sat, 27 Jun 2026 13:14:52 -0700
Message-ID: <20260627201457.12318-8-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64128ec1-d592-46e8-b729-08ded488d839
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	kE9Lz/sTAvSjHOA/LtV2cQWUchpzzKDN2q3EuhoSKhVXNwnTKAyeNIiuXT/bvlFU8PH4bZw0pHf1EM7bpnj+6VtoBfv9ZtpaUsVNwYpApZ3QDniQdiE3vg/KDVr1IUR1y/8YphC6psyhWE/Wd4PXOUZ2QLR7OnxVvS9HHmQnrSljjCEXOETMLOWkp9IuJ+4GWmDtsDvCDWzrF8Z4EWlY/6ogXjZLNHch/jG3xYYcK8dBfu1A7yA5O7WoCjWFpUd6dL1jjah9qKe4keRBTgX0GWs0aMEYrQKdxQeoQd9VzP4O/W1dadUfpQL4xXG6PgXVXU5HDOZCOsEgMpPRh2LRwECkRxVFtWra6P7x2K49gGEqs9AgSUHFg8IgtJePGG6jq0mp7yo6fi9Sk9HvQV3wj6aN3PE+aXYmn3m1ib8CkXGUtiv2/jO36wGnGy3Lk6+WnZThtoftZ4NouQg7sW9EtJpHf/q+W9pdhixJt5kpBDk0pHGNddkzuCz+eleMFfbXl/SSinAS/9z3PEYYsxdKK8hh1QJUU2v4jeDPEGSqMuXJflXgdVfQwJtowEM0exoKRQagoRDjQpGZ9FxxMRk4d8KUFRTkBp5N8wSM+DSy6vpnu0Covooq/DUw56ugiTWiImoDWk+7NzD6v8+mQPXSX58SKUTCedfveTT/dzmjDxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9UEle68ooKMrt8gAhVeoLNG7QnfJStm2aDHfhGkQB76pyPeXAHqoVp/cmdu?=
 =?us-ascii?Q?r8p53FZM+0WU9Mx++u8qcvpL5mwiS/IgW7Gza4LTGr10Z5Mc/ocxUL8qDBfC?=
 =?us-ascii?Q?Mq3MWsE05g+2flcNKwtwNIv0/VdWnea+jyjWfWxZzcPMplXYZ+C8JdgDb3rS?=
 =?us-ascii?Q?KuUVa3z3ltOAAB7mKnNcZJbSbAjIBDEWsegu3ywfRx6NfZ/fsEYuF4ytUIl7?=
 =?us-ascii?Q?glIy5CM1l/pqHTfkX0Os9IlGl1JQtUxLpaj6vHYpCD8UxE4QIcwGU3nHuB3g?=
 =?us-ascii?Q?hjy6ldlAeH6rB/S+S0Nz3C2Saw2h+qgjT8Jji3EbrY4oJR91HfgPacMM5XFn?=
 =?us-ascii?Q?bprqBKzjSP48NhzW1j0Y5ATyRZQL/3d/yAHjg/lVXDOQsIR7acJa6bNwqcuW?=
 =?us-ascii?Q?UTTLczVyETd6nwBRxlXEUgzc0V6tO7qjY6pumKJSlNqqfWoOcRW/aasn4qp8?=
 =?us-ascii?Q?1eryqg6GBRNjXgY2eAm/4gx5Y1iCchQ9+wqM38GBZhcnexVfjQrV02/GlmCS?=
 =?us-ascii?Q?M6xsTClrdl22iwMqiKxv2y0lfyjQqb0/gGzsqQThV1r+Rkhv2B3wqJul7PoD?=
 =?us-ascii?Q?ko6d5U/ul09MHBQPWITFuYkqgLGFG+LroCeaN/N93tJjIGP3L42TZjv5Qr5n?=
 =?us-ascii?Q?qqcnA6XyeupQaQG+a1f2ex3X3gem2JFCxtlh50ni1SfZB1GmWP5R4k12dFxZ?=
 =?us-ascii?Q?0jjyGJHbpVvamjl8blgYfTPNOXrFm10c0JdwRMsQcfGDWIysUwYSapzuJPk1?=
 =?us-ascii?Q?QBbP2uMm4QxGCi47lL19vKmweGWReW1ZJ1z+2DC3J0iPXVXEE+hZRdzgQ2xB?=
 =?us-ascii?Q?5mlDjxLtbNjANSxxuRdvoOqD+7J0voeFBgKzMYqxZo3s/o1/M7x4WggRIwXx?=
 =?us-ascii?Q?gwVBmSbDmoBnmN347WstwsP+vLS9NikfAmBsh6RcnGzPYVL//QcwP367oryH?=
 =?us-ascii?Q?WJb0ucQoYohZjuLRUyvV2BCdoP2O7gWDq7bMY0NxvOESyLXjFrdBrKffbdNk?=
 =?us-ascii?Q?qNzBYz53ix6hsukovtlQApiu329jE0qaNU0aYB0mXH8047Y4O4DqvGinNqni?=
 =?us-ascii?Q?JmSjsQG80M6pvzQoLab4Rr8qhdG+Iq1gJoFaLjC/yUU6jDo+5TXXOf6pnx2L?=
 =?us-ascii?Q?FRaWaGAA/I3Sw2ntEXSMREfv+ztTXliRR+78l5L2IIG3RjSqEOjzmqyHg897?=
 =?us-ascii?Q?TR8tsxxJ6tRVbCI6UvIQ7QeyAoyO5IVZXkzErjN7kwyggH4GzZZPAOKwYpAD?=
 =?us-ascii?Q?IRh7ynnDV2WXVGcjILaenx78BkdTXJ4u0NSLqf1Ze2LbW04hWtBN7UCMKRJm?=
 =?us-ascii?Q?OnaXdx1MZ1bBgQpOz48bbKtQmFYq4JHUpLg3mhXDt5SaiLQxIGkqIUH0CKho?=
 =?us-ascii?Q?CQCCAWav5M/rPr1rRZSLhQvn8/1+WQCotvekF64RI7/a01EVToMuEhQ4FOXx?=
 =?us-ascii?Q?u8GnyqclqbK56PgTdj4JvwySMYzU7rCLR2GV4TCwjaci2UByQCEWAPQ9m/zQ?=
 =?us-ascii?Q?sjy4o6BJ+4jvjxmhDMXrIZnn81eemrsdZmAllykui9w3EXOnqeSQG+XRigvM?=
 =?us-ascii?Q?7ptlTyzC6qjWWPh+RSg2m5n00pcP2jYTIL6SO0AnJePk+TJl8pIaNM8ZdZ3a?=
 =?us-ascii?Q?nR5ZPAGSLeJC5BG3iJRJ9gMZG4eOpqGQeL7U4nJoTvryPfbTwNx2pGRbRZzJ?=
 =?us-ascii?Q?1qX88dyYlQSJyY4uIVJuf9b2qIh8Y8V+W4qZ5/Iyxdynr3IhI6G3ZIvYUUn5?=
 =?us-ascii?Q?VVOxizjnCKnY/Y2rSD1MFG4do90OQBo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64128ec1-d592-46e8-b729-08ded488d839
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:34.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY65GOKNmqSl3BtsWxAHQ3wOOBeIs0qSAriNOtE6MZ+m5fA3RitngbukIDz4yvHdtvmR00DxUQ91CLdfr5rhwf48ttc2uQnC9HcwcNsDQAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

Refactor the sdhci-cadence driver in preparation for adding SD6HC (V6
controller) support. Separate PHY parameter handling into a dedicated
sdhci_cdns4_phy structure and move PHY initialization logic into a
dedicated sdhci_cdns4_phy_probe() function. This allows different
controller versions to manage their PHY configurations independently
while keeping shared logic in the main driver.

Each compatible entry now carries its own driver data, so drop the
silent fallback to sdhci_cdns4_drv_data and return an error if platform
data is missing.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence.c | 54 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index b00dc2eec922..ab5dfae12732 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -83,6 +83,11 @@ struct sdhci_cdns4_phy_param {
 	u8 data;
 };
 
+struct sdhci_cdns4_phy {
+	unsigned int nr_phy_params;
+	struct sdhci_cdns4_phy_param phy_params[];
+};
+
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	void __iomem *ctl_addr;	/* write control */
@@ -90,8 +95,7 @@ struct sdhci_cdns_priv {
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	struct reset_control *rst_hw;
-	unsigned int nr_phy_params;
-	struct sdhci_cdns4_phy_param phy_params[];
+	struct sdhci_cdns4_phy *phy;
 };
 
 struct sdhci_cdns4_phy_cfg {
@@ -169,9 +173,9 @@ static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
 }
 
 static void sdhci_cdns4_phy_param_parse(struct device_node *np,
-					struct sdhci_cdns_priv *priv)
+					struct sdhci_cdns4_phy *phy)
 {
-	struct sdhci_cdns4_phy_param *p = priv->phy_params;
+	struct sdhci_cdns4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
@@ -189,11 +193,12 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np,
 
 static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
 {
+	struct sdhci_cdns4_phy *phy = priv->phy;
 	int ret, i;
 
-	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
-						priv->phy_params[i].data);
+	for (i = 0; i < phy->nr_phy_params; i++) {
+		ret = sdhci_cdns4_write_phy_reg(priv, phy->phy_params[i].addr,
+						phy->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -542,6 +547,24 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
 	usleep_range(300, 1000);
 }
 
+static int sdhci_cdns4_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	struct sdhci_cdns4_phy *phy;
+	unsigned int nr_phy_params;
+
+	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
+	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nr_phy_params = nr_phy_params;
+	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
+	priv->phy = phy;
+
+	return sdhci_cdns4_phy_init(priv);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -549,7 +572,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -560,11 +582,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns4_drv_data;
+		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
 
-	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
-				struct_size(priv, phy_params, nr_phy_params));
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -572,7 +592,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	priv->priv_writel = cdns_writel;
@@ -593,9 +612,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
-
-	ret = sdhci_cdns4_phy_init(priv);
+	ret = sdhci_cdns4_phy_probe(pdev, priv);
 	if (ret)
 		return ret;
 
@@ -653,7 +670,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "mobileye,eyeq-sd4hc",
 		.data = &sdhci_eyeq_drv_data,
 	},
-	{ .compatible = "cdns,sd4hc" },
+	{
+		.compatible = "cdns,sd4hc",
+		.data = &sdhci_cdns4_drv_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
-- 
2.43.7

