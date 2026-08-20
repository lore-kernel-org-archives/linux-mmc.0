Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA339D3FC;
	Thu, 20 Aug 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252277; cv=fail; b=DqW57rLlULmGetkbvVqDmPgaRU6ZOqvZwUQIotibX3FFpLwCUeZsq13MCcTOMO8PQfp93UbafBS/qCS6xHOuzCeuKcMi7StXrwxY+lluqYZwX4lzy5xiYS+HciMl83Vgdwoa05avd3mmSMTqnRSclmrQJ/eoqA/mbF7gWbau2Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252277; c=relaxed/simple;
	bh=JlfpqPUU+GzssH1r7oCUMPtS5nR7MadffoSoOkF5lb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0QWc4VsjDaKjyQk/raIOgQOuF7CtVNgXprj/Ba01tKGlIL1kXoXduDBPCCmotmJH3KfPorr8Ou9gFpPnKv3uQOLkYkRDq8AjeaMsk5pEBYyKcyGbgv//VUJlm0cqa0o7mGq1xL5N4LGpYHe4ON7/O2FTzwGHxN1yugUL1nzqWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DsZihwJ6; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DsZihwJ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVrEw8hhXI4RX8CbJ6I12I6/nN5a4Urs5Zplhg342WoLxsu8UkQUPvavt2BiajrXnMKoNEIjpUGvf/e2vIfa4bjOiHMd+E/8zN+VVpyT+6YeR0BVuLMLNaOcI2RHAUfgN0A+/KoP/CEiIWt62QC+p3CNnbbs0f0J+W8xJC8InyYNx9HG2G6mgO7wlhhH+c+zLbSwa0yMia/VKLREM1ZioifEnZaPRNoemCjUMLg7hUKEX2JE5xUZut+VSiOReTE7Szx/L//tAxhsMnV3OjcYFuiKIdng52eZX3H1vuETuLA+2xZF59pG3ugoBcaWufo22hXO+yRXnFeEWGWeTcpnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=nIwE7zT0IQlSNeYWSiTM96PnWj+UlHIDG6OcLEx+momZaDuj4V7FcmKv4eITFHb+kYPSf5JsRgCFDhTn6vqFXYDRGYZDhGDDKgRC6KDRZNxa45epnH3aqg+Y524Hyb1Vz1V/4O+kOygTDiNtd2LynjGLAZlD4xGII9Slp8d8RbxWuphZZRpxb06uL6UQYvYOjepVRI6YleR1pU988/ZQra/5zMMxHPy0e7AuZAyzF6CAtOzfI9Eus7Vjwdyy5ac2B84o4P8oD2SYAlHcjNGhehyk/IJXpLGTQNN/LMu3r+GAHBQIZ+mpXM9w3kmpfw8U6JlsFwERuDQW92rD0tfT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=DsZihwJ6XQdp1Rd+KrEp1TdgqyvcQs9Xjo1z0nNrdkx63xI/bQOEqHBaLR+aFQbvTSRCQAKqTloBm1pgXAjHJ/cxKKcjgGgOnKxpO1/7QGMH1y9vy9Qmx/wrCXonZNJ0NPX8YBig9Dr0hJwPxSe5JQ9/E5ySNNfHfh2SWR2AeGCagbO7ID6s259JwMaEnPy7EUnDiBVilNIx+wF2xgEzzF3Wo96aeP6AKH+Xwk/W7W8/td9KHBKbLOEvkNlKZCfDHKKPyMLXmwhqvAKn4nC+HD/X1NqPaChNf6TwLVTflG4kFr5FrZEF/JBc0dy3Dt9zVFXFCj39OCHU4acP7e7x6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5636.namprd03.prod.outlook.com (2603:10b6:208:297::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 18:57:42 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:41 +0000
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
Subject: [PATCH v5 6/8] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Thu, 20 Aug 2026 11:57:12 -0700
Message-Id: <20260820185721.22823-7-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a696b65-cd26-4382-cd7e-08defeece992
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ZAbacpSyA2F/Y03A4AsxMx8OThwhCsxlihryHZW5tR5a3X9Ac0QYPPjFKdlmY+37X3HczdkzQ+H3tJ2v9sX1MrtRv6CM7c90oSoV+tidYEr305y02/eHJ9FOKDvuF0JcZarVHhpce+bHVSYoDtk5FJax6I6H+o3spBM+EkAVZ9WJuais/thu8uxG4q2DEKdrMgfT2IsLR1HniFN9KLTFlJpa3Ts+oju+gc0xVmW1bXW5aJ5phfEBciVJa46y9OysLHVUA1zseTH/ZuaG1Z6/5uAhXILDYCscttzSU75G/SumRbAkqtTt6j9mCme1bMfNeTm2YoZCsVR3bYnT9ME1kTI3z10G0FJnuPxdcimm2VXlJcng4tcBIhKxWjkE9R1oMCIeUIE5DoCahLBs0s3Z0YZNhjvrOgQls26OmUuxakD7vKMaoi/bUrGBHIs9tTlq6p4f0q4lfkcA9Mep39V3V11Z2hWH9j6N9htocFrpHpPtkWhUfMjdpp4PU4GobnYI14w/ahSubjbG/Zph+mMsvYsbC8AUho3P3Kcz0lgL0b2Fsnt8e9HQJ/CtpqLtxQlWGCEDBfPhViLwwuDsgRO4Y18HudxjEz6Hzw0n5e+iUksXL6JUZ0uVIMXMFlmxuslhPTFf4eEeyISIrKvDBKIjwGh6v6lI7pnLx6xUlwSyhq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?47Oa5gvYMki8Li45Lupw8dOwz++6hpP4WJISA/F8QO7iz+f6qYhHfMA5DKRI?=
 =?us-ascii?Q?sxAIV0sXKo3vYf3utyHPPkz0W/g2d7yrKGpW+zYEFIm+bCALCVNz735iq+9M?=
 =?us-ascii?Q?/Xo1AXRWFBtFLZuroh0GKhX7IBmdzwirnoJHKgkmYXch5rI0gX+TY8bvJ3MD?=
 =?us-ascii?Q?9Kgc+wfQ1Mr56MaN+Ia5XyAxYcqg6BayQjKk5smciLl7c2kYnkHo5GFeOpI3?=
 =?us-ascii?Q?tC4bkXsC1ZOXbG0t1GMs59cRwNe2IxXdigJsgwtdBUfC9KSQjZMFLiexBCr6?=
 =?us-ascii?Q?fQ0jCDuZwpwAT3r7uhEiA17CJB3rI5ztpO8yOS3AFuNwqJgIe59iM4lV3hDm?=
 =?us-ascii?Q?ggQFLc73C/E7d5g3FzmllgieNdzTXitkoVUzXzeR5dBCNnrwflpZiQ+PVeuY?=
 =?us-ascii?Q?zC58jrWSYiCrIR+3yVRe5AWAmAE6cR3qKNfOAYvbIRaYtzUQ5hj/mUMTSg1H?=
 =?us-ascii?Q?+bYU5OiWFfR5MBoKf/m4jLr25mX8uTIfspim3lVbenzkXldJJa1nq29FvzNa?=
 =?us-ascii?Q?mv2v/LaYICpkYsZVmPnqd6YCtj3othvb5yn02sfMtH2nqa3a0QUEBODNBDAt?=
 =?us-ascii?Q?sPV/Pv5wM2yItFJBAewBJKHJ8wavl+S6HQSRklYocGJZwxTly8xaHpi8cJOO?=
 =?us-ascii?Q?6965ZQpQDUTJhdxVel8ipdSexWJePPs1VUNCOWCYF5ZmcN2Rh0b4Qy5IKQw9?=
 =?us-ascii?Q?nrjwc+7pH0pQrTZyIFLjRVIVgs+vDdRa9s7cR1qsK3yJ/HBQTEnb4raEaVZS?=
 =?us-ascii?Q?BqZSF2aY7YCbKHiU5ojiI3hxV8a3NFKj3DTIrHs+CtjyR6ES0oSdcsBsloMd?=
 =?us-ascii?Q?cS24/IBHmZSuN/uVsLJ3MFbPW7c0YFekynkGsdDZBQKz8scSs0PNSZA0BCZF?=
 =?us-ascii?Q?tWhh56DGrLil6mMUHHef54ZVBKHYEVZFOM0LHODM8RWabVJNZMubkJ/o2sHy?=
 =?us-ascii?Q?pTLm7DAQuwHvC6RgNodHvpfE4Dmpagh5Vu3fr+E2WQ1I+G3/DKKd8onoDQbT?=
 =?us-ascii?Q?LxSqSduTAk+bVdG9LZjzxkzCeTkxerI2tNdjKhxe4aSY25jMX4xooUgJK8Yx?=
 =?us-ascii?Q?HylHzEFY/WNn/e4Z0zIrX1BTjEtN5FNS3fMpaDJfISUtbH85rx10xJ949bp3?=
 =?us-ascii?Q?092as35ZpvxdR/iIAn5p4ba2ucRbTiBK23kj0Ak8BPrdP72OsfS+c0fSV6pe?=
 =?us-ascii?Q?W3tttcbUyDbCUrwWPG72TmbSam8x+y6LXFlT/07l0a+njdjlRsf76zVeS78a?=
 =?us-ascii?Q?CZtQbmbK3vI+k1g/W8MN762h8HwMA9eecWJSIBKsNE4tN+CVIWnEHkJMMII3?=
 =?us-ascii?Q?jCVU3tuePeDir61Q56orzn8nDB8D4sYIoviGhKz6fXjyGXyMnmt6R9s7W987?=
 =?us-ascii?Q?pLEwAiy4+haat9djAn55MrGRyBpadpt0QV4PaLf/olx5gPJ+uCHHIn5b7ls1?=
 =?us-ascii?Q?ANj2iDfZttQU7ODZp35UpnKgD7yUvVEV1f9KLYoK8ibfeEDVdY1MX4P6/wy9?=
 =?us-ascii?Q?G64CXQznB5pzLhDS2csvi3jWoOKVbt7tUQqLNon0gyByYXkXFNsiyUuldp0q?=
 =?us-ascii?Q?flOwfoh0gvB3ohnXfQBDXLzzQsnvX09j1obXYh1CDn3zbjHv3AVZ6CajEQ2W?=
 =?us-ascii?Q?5YQMpHEDKvj9Mdm9HQ8nJKE5+DlfemMo0e1sqYpR93UB4a/blQACgVVSKS7E?=
 =?us-ascii?Q?RvF3e4VxADIUXNjAWSBLZhphroQR+coZ5M02pSlHWjqunj/JKoZHWo6ke2nZ?=
 =?us-ascii?Q?xb2Q483cVAk/gsa6w9eDKGTgmLFEo6s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a696b65-cd26-4382-cd7e-08defeece992
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:41.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNhbRIkBiVcCOruRj7nORjvlbJ7Tk3MVYVfUsEexSBEf/i7R6dLbQGSRBFDbZoWi85GaCEnIZ8FZobZmBZEmDb90graf84gZweqwDK9j9OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5636

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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-cadence.c | 54 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 8a6ef6d9d1dd..1fb23051a047 100644
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
@@ -167,9 +171,9 @@ static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
 	return count;
 }
 
-static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns_priv *priv)
+static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns4_phy *phy)
 {
-	struct sdhci_cdns4_phy_param *p = priv->phy_params;
+	struct sdhci_cdns4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
@@ -186,11 +190,12 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdn
 
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
@@ -539,6 +544,24 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
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
@@ -546,7 +569,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -557,11 +579,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
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
 
@@ -569,7 +589,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	priv->priv_writel = cdns_writel;
@@ -590,9 +609,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
-
-	ret = sdhci_cdns4_phy_init(priv);
+	ret = sdhci_cdns4_phy_probe(pdev, priv);
 	if (ret)
 		return ret;
 
@@ -650,7 +667,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
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

