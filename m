Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C8384238;
	Mon, 11 May 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530914; cv=fail; b=TZzOWbSP4S0q8I2B+gVCO3RA2ZJUNGfHbmcwSu5AbQKeNcXTaLGZxby6dXerKxFHyXmkITadpLvbLy0YcHQRn7cqQELmVMBINqFDGCFrBLXBAQ/fGS3hpZBSb2jI8LRgSkezJGw7eIQLbiPyPWNV2mQms6TisSbW1RrYN2kQI9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530914; c=relaxed/simple;
	bh=LN9qMRUKMSaOLYadqP3Vkzh7NHAPe6awch/xZvy0jaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqhJBL8wCKBt4SPvmqCq8P7WPkL5qrZ9UYzVRbIDwWFl8WHMqB/00790A2PhgkxJQMWrOFtv05rXIUDOTJqY9KzIMmB0+i0mnVPrnxappDQkx9b7GHaw2FqEq1Lzo+JvZqo4LsBJlialq6jubEIT5ceJSWeterIpNFjFt+lqRxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U8RKuDzY; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U8RKuDzY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaU/kIosMuHjKsfw4hBeXT59M7B0KcO73mfbZPWAq9zG8My9jrp/BRn87gXXaUb8RaoTW6Pi0d5TJlhJO88XPmuWKZGFRtOTwxVlTH5qcbcYN6v4fy7ge7OFOXRhX/6Zh37RJuD5cqIncBT3wEHJ3/UafXxRNXC97hMVJnndb1wnrsu3y4gWsLzhvOnnUKjiz0G5mOzKLFzJiWtdjhWRcrFpUI8BLHW5FrAtKOaPQbayBxoYng2eBjwZU8wUz1rhWuGhKF4nGfSxJipLYXYBKpyeCM6sDBzjkSeYLU5X8fA8kBZh2q8PA7DkzlVjGlWM6FZc5c5OzJS2hFDMh7sPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnPtzq3ExNv43l8e8c3eBcSC2VO/fUUThj/TOcYrWP4=;
 b=h1FlwfWBiI8mfrwUDDsG1GrpGDnebwNjOqXbeSsWCcOH6DCH6nUaYjDkJzVvw/2Bi5eMTNri6C40DMXpj0KZTbdJiZBHT0ufvcE18LH6NpOst1l8L/iO4gNbSaDpnHvddHINTQA8hL+PNm4XvBZiTNxQMlJ5zv9OFR6MAXVWtDL+nMJ55pX8U+oRfnydjQ/7h+sIVDw33umImSrqGWhExBIxM9my95yS3bmfWVf6GkACUVcua1vTp7WBhDrEzlT3VARg3BcFlp5nFY2md/g2FCrwHyKGfATzgSLvoREiMADRw8gBCXQfALworWA0XVQblPD5Z0BV5O/6ZvioM/HZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnPtzq3ExNv43l8e8c3eBcSC2VO/fUUThj/TOcYrWP4=;
 b=U8RKuDzYPXFktKkBrB/TYgbSJmn87DkmbR0NYkqvVdr36Zm6lo1KFW4RpCwjrVHuQXK9OORoEcUoeW3VOO1kWOeoM9MKx7BVmPDPkMi1p/QOFo2eyyB4pqFIFqZ3I5exUK8DQWuPYR+msG41cEAQDTfTo11pqPq1aux24VSuQ0rW3sCwhWL9nJRdNXH0TIRJLE3WhH4hleBeZqyaBR5dEW/CjxNXi4TfuB0+nvlgshPSZSysW1Mv3w7NB15MSRmjkndW9KUk7nNGSgp2P5fokcU2cYwjgvrQFiVVxbLiS5KQeRiFGtyKgcNhRrLWom6ICGvJ59SHBqKHGIgeZtElcw==
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
 20:21:45 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Mon, 11 May 2026 13:21:29 -0700
Message-Id: <20260511202132.5597-8-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: d417b4b0-c487-4a6e-93a6-08deaf9aebf0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	HpoybkMXzs4haOTIsf7OeRXtUb1BwIWSvjhZUclvAMiPmj0qFK0XpmYemO4BlF+W54Q9oRNEVyBs5pPhykEVNbStcgAhKJJyuqBJ0pHMQUkyNiWt384HNajexSG+1dF94wWCu48E4qhjbR4Bc4lE8tkK3ShSWA3pMh8l7FR8jEDazyNJ434GoW/QUKBf8l671j+w0+Bh652z7YVnaMGnzVNZL2Fsz2874EN2abqeuGrGmhzX0+GIPSyJHZk2gH6gT6O7E81OLP0d6cR7m2LYqYlimFTSJ0TBniybuXJqrAxDwWHcFB1e2yDubB9HACHvGJjLTLYWWp2qgUnKeqb/qZIrml8UKR6mG7LQ78bBOwv0N/lTasid6abNKYzdaGGkBvkBCpTN/esyHaqvACLbGX+K0PRNBowF3tfGj4CwvZJY6SFKdXBPtZYwnZ9DCfcjDHr8W24CZfV8jHFqhzQzMVTY/rZ+DzRE1XhB2GMFE/ZHtSnJQklFx0oO26/Yb8ZaW5+matccwl8FdQjKa+Q1gj+bOU7YkHQMVsfs2JjRgnwyh6Yxv61NiojnYqJq2vxJVubaq9cIPIsuZlr5NXdYpeOzBCRr3JrkKOLZMxpUso7qaj4FFJDkFysdnfMm7PyPbRJTOWyqo0ZQWFcKdvenWOtUExZ8mHz2PtguLcvLdQCVpynqtK6dDLhPIwbGZtw0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/i7nrfxPkVIVbt/NacN+MW81Md6uunMvo+0dnh4xb7LkwxkWamEinhcGOTW?=
 =?us-ascii?Q?YCMVmyFQzsulx0MWq+CHkns6bu5YwRFpF0dp4dEGS8gL3Snnhud+xh5N+Hax?=
 =?us-ascii?Q?EvYmj+c1te9IWSMRMvvsSg9xlqsVGlRGFk+tfA5uHjgZdCPagoYEXc27knMT?=
 =?us-ascii?Q?W4Hj1U5iBhtn2brbLbsATlB7BoxE8E7ayNgBT7TbXCdFNioUSRupgU3nKta5?=
 =?us-ascii?Q?GzrmIfZMfriSfyxBomA4mgwFDodt9RQQIdrNZcQakkqVXVenzKMsurj+TCoY?=
 =?us-ascii?Q?EfZEBPRen6el1ZowcOSokzJq9A83k2agOU6AO/2gbVFc6jevbGhR0yT67MVE?=
 =?us-ascii?Q?98MEeegvrBgJYNMEKJNwEuQex/RVBHqE5yhQOR9JwIVSz0jsm7+9+AnJdqlQ?=
 =?us-ascii?Q?NF+lXZk1SsFMvyRn9weT8wU01D3s5LjBykU0KrRtyyBZSuiAtGlhG2i+xzI1?=
 =?us-ascii?Q?7ZgkJt6Nz5D37r2faOOO113DK9sK6n5zUV/zNZKInfNm7CefSM0nL+WK4suR?=
 =?us-ascii?Q?2DEA9jLAs++S2FGjVkFA7Aceh9EqX7RFxUHMvJNiqbzHmXWByuPs4vELDewo?=
 =?us-ascii?Q?svfykiDTyvmCOEg5XCV6lQJpDHTMkgFKSxCkBJjBjtuq3pKgthvkd7MK7tM9?=
 =?us-ascii?Q?OZU29+LYeDu1x7mt4ZyoGQZNHWRRvTKVYXYlF6HK7FRisu9i7+a1kg1avspP?=
 =?us-ascii?Q?0gLTtbI3V8EpOKIUJTl3XNN0LK7GZAXqotUJ8NRGqk3zAKyYFqnPyGCZ2kUz?=
 =?us-ascii?Q?pWHfd0qvKPjvUAjni0i3gdlqnej1kKegevOWA2GwAnkmPOvn8aHD6qtJErwb?=
 =?us-ascii?Q?DoG2wakew26Yfcz9hbaTFLtKKhmlJLOk9u6Pw7qENNbApu0wvSdAd5smPWe+?=
 =?us-ascii?Q?zqRY3sINGwmPUoJkz/CC8Ss4nZQOwJDSm+gEZsud5M/wR+4BKXtmCir8pWUD?=
 =?us-ascii?Q?/hnJsgNxuD7qajJwBsuM9A0eyg+pw3LDN8b4axLeMaWZL2IhhvAtYzziAhxi?=
 =?us-ascii?Q?wdk9wHjmcou6jj3F8Sgzy1P1JN2iF1rOc+fVrmOw/OHZKTmMbMBzbrUjLyW1?=
 =?us-ascii?Q?XDMHdg1C9lX0f8J/hI9XmWd9pKn2xB6IhKSfiRKkrwYPW0RT/lKEigEUiWmF?=
 =?us-ascii?Q?Z4IIlwSafuMqfLoHT3UW7os04D/pW5RhWtaSEpgE2yeb0XEf4H05q3/I7GQd?=
 =?us-ascii?Q?fxpBqEr+i+LzC3XnlKYnSJWx9PF1NC0iuTmRcKQhLxjnyEbLm1VHGieKanjU?=
 =?us-ascii?Q?3MjmEAQOGWPjpH0/VEpzuHRXinEMXNNUg5jOGX2NpalkjQhKlJMFraH+gsE6?=
 =?us-ascii?Q?I5z3G58Tk71MZBcmuPa9fxL0uiCUY+hzPDiqTFgNbgZtT5wLRW8v2nZZvKu+?=
 =?us-ascii?Q?byeIyI6BBRZzVQxRaNb0CyWVtxfXSU5gztUZJy8vzF2A5EfunNb6bbLGNhOk?=
 =?us-ascii?Q?lpLtuSrUUK7p5lg1jKAIXtePn8AAU2pa+1tEoD2GkHVCLgBgpo5/IZCBGNRG?=
 =?us-ascii?Q?QitvbEMANTzt4phSGzN/uSOTuoFC4jmeWFEY4itMgD7ZtrDaqm+JkqynpEIF?=
 =?us-ascii?Q?K6RZrBp81ANXD2pUDXuf/c0GGB4lOHNj+WINKbMx3p01LA6wKYfboF8ZZLrV?=
 =?us-ascii?Q?iXgt6XLPqdaA0tf4jsjCnac6sPSPx2IQkW9gnYyHMvw7djwiqOVvwZcnRet6?=
 =?us-ascii?Q?AkfyFSYUKKM9oU+ObFNt6r5pQ6d4TTi2x3pQH/RC2sLboo2dM0LoeaDkEYm5?=
 =?us-ascii?Q?gU10DG6cLz392xIT5fdU87r+1Ep7Gf0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d417b4b0-c487-4a6e-93a6-08deaf9aebf0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:21:45.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CGgzgEmgYSBlpkrPtx8T/S5uOkpQIv0uzmC7XUIwINjigdBXV6YJf8lJH0r/cWmZwzAZC5KpqMYRxK3MFL6RRuxoqeYMn4xQ0iuWx9jlb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8296

Refactor the sdhci-cadence driver in preparation for adding SD6HC
(V6 controller) support. Separate PHY parameter handling into a
dedicated sdhci_cdns4_phy structure and move PHY initialization
logic into a dedicated sdhci_cdns4_phy_probe() function. This
allows different controller versions to manage their PHY
configurations independently while keeping shared logic in the
main driver.

Each compatible entry now carries its own driver data, so drop the
silent fallback to sdhci_cdns4_drv_data and return an error if
platform data is missing.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/host/sdhci-cadence.c | 57 ++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 47690a52a221..fe3f7c5109fc 100644
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
 
@@ -190,10 +194,11 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np,
 static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
+	struct sdhci_cdns4_phy *phy = priv->phy;
 
-	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
-						priv->phy_params[i].data);
+	for (i = 0; i < phy->nr_phy_params; i++) {
+		ret = sdhci_cdns4_write_phy_reg(priv, phy->phy_params[i].addr,
+						phy->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -542,6 +547,26 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
 	usleep_range(300, 1000);
 }
 
+static int sdhci_cdns4_phy_probe(struct platform_device *pdev,
+				 struct sdhci_cdns_priv *priv)
+{
+	unsigned int nr_phy_params;
+	struct sdhci_cdns4_phy *phy;
+	struct device *dev = &pdev->dev;
+
+	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
+	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
+			   GFP_KERNEL);
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
@@ -549,7 +574,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -560,11 +584,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns4_drv_data;
+		return dev_err_probe(dev, -EINVAL,
+				     "missing platform driver data\n");
 
-	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
-				struct_size(priv, phy_params, nr_phy_params));
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -572,7 +595,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	priv->priv_writel = cdns_writel;
@@ -593,9 +615,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
-
-	ret = sdhci_cdns4_phy_init(priv);
+	ret = sdhci_cdns4_phy_probe(pdev, priv);
 	if (ret)
 		return ret;
 
@@ -653,7 +673,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

