Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0243C04B;
	Mon, 10 Aug 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388481; cv=fail; b=X8iZMF0Cr6cfwfpv+WS57LooNHuP2w4RS5NzItm8na9G6vn1iwFVDpN83TME2tUtWQq8QxGyyxR+gM6SjfNG2EZttS6p/R70/kF3ZKqoGkSpbJUgpJp2E1M+az/Og09abORYYfMRyjaiu54ocFU/Ij1+hpeSarcNojQMyFJI7Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388481; c=relaxed/simple;
	bh=JlfpqPUU+GzssH1r7oCUMPtS5nR7MadffoSoOkF5lb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kav6yxDrNRsNbO/epYJNceL1yawOoHiVK1DzCxuXk5cr5TtJ0ixfeh9XctKr4zcvRwEyrbNuWZytxS9NlrWPi8cANUKBWgMiXVuRsAROumj39TsHcqyBENbXdcTw2bTCSif0uM2Nlb+8n6YcNytXhmoiNKYQ6Gtvte48M8e0H1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TmmC7iFE; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TmmC7iFE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUETheAGeNqSp+z1SGm3B+PH2fuY29hBAyqBjcmADdQkR30MerslXVkVAytgjb/rtAc2DVRNMr5IsWMKVFGizNX3EsE3w0k4gbu6ov7N6VxBNocMRpCmFXbbHw0RI2ezS1KRdUdlX1mwrU0+sWu8ufx65ILv7z02QC62rfVFOk7NBYCmHMBRjvkk/2BHjwiCamOfVro08k9HLG8qe1v4cjV6B3b0MoK0UBQgC5MCbnOy7pGQrclCI/DBr0kvSLsc47bQDTocaHJBNGFP2LdkJWc5BVtO01blZ9CbyGm7yk9sn0BdQtzoVkdaQmPk4JJzk/wgbcU60RO5kJ4DJgpEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=ix9pz7TnAI9IoWD3oCR02o2I8YvRecSWzxQA/pO49+HdovLQqw93W5rMzjfTylm6xNFRQLjWpnlL+UvmO8CxPMTdX0qCS1x96RwIi+UCTvZs+26YV8sxS18jJ4YBIoRjOlPXsdj1agFiI3ksw+9/EaaLxcELqWVuupsjiRa9RsTmIhhcmMtZx+7UGivz9MwxfS5PJR09/a/2l9yMqwiFv6m4PBxSGx+IXo7coiAy3+eQImExJP+17XGZsl5p1H2pgfLqSwTa3vBt4pb5WwqrYZMh2CoBfK+KiUMrdL8ZTAxBX3OVVF3U8DvxRqPGx1Cd40qfKhewdBOXCQWWxhYdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=TmmC7iFEygolKwATcZ9hPEIXeLTKSAsO2kFn/cA4xnrFgOHTXEo+6DDaQnjNeag/XMiNr5hyImdaMy7nMFQNIbAKOlLB+cvF4ggM55+v8DAay0erQxGzJeyMC6sC+k638saMVIPv/FViBf84+rdnolh+tm3W3M8G17TfXWAYFFCs2VfWInSFm3ncE5k7tA7EBRcuwulnSG+AhWCf+1ihx7ph+m6NcWO8Nkd/TmgshYxNqk9GBq3Z5tOwmUJSq9nAXrRL6aV09cix+shOey3bB3TvQFsJ4S3QFyxhIPH/ppzeXoRi5ipUBv7PuG7ka86UwLvK8hzwphtHgN+nTFrTHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:41 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:41 +0000
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
Subject: [PATCH v4 6/8] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Mon, 10 Aug 2026 12:00:20 -0700
Message-Id: <20260810190025.25045-7-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40f19471-8023-44da-c7ea-08def711ac83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WmCAxcmpgcaWhGhPVo/WSsIu9DTSEt0DHG4Q7+TFSC7H+u+cUqcQzjGrAKRLu9pmIu3knIJKZ+VlXIw+64pUhseQ+81xVB7Ck9BUEUTZNxNo/nDi8aRgquvKJnTHqg9AlD39VC+4O5xLI1TXK1SncbLQvnNIk3vFsc3tROrk10CMepWcnF1U1pgyz4fcbfiLLOPsIKxkpPDCGxTOhP2Lhc43D2YeGV18bokJzMRIE0JYAOdGfSGTpU1x34HbXagzqTihhvSs9Rdt8IUTNRunaJKp9ly12vLOl5ZA66MHwKh3Tg2sFa2d/iaFBwTplecw3Qzh7CVMDxB3Aw9lGAkupEoFm2Md7MVyCi8FeYOtE6jRRd6feqj6lZF94HFFjOzGzPXJWOVzUcqiMYX03iU6bPibvm4+roUjc8WAJv526vnqc6yy8C+bABIF3bGPS2sjUYAGhQhE209+3GU2v6bf6xZ4gt3Dftibab0hQWdVvnseDDL2tC76EEExCy4lP7SQiUausdznB+2/s2pXwc3oGrRRJb/3T7klcSl09Zg0PcW8BZGa4TbQiDcnwVsXXYX3AdkKTeUCuFuafMHsf1RViw/JqtQobvF0g4xGz6h7jmgjN5c6q4953j+4CN27frYH0lj6EY0X4kfjHUQGWLli1twAYnL3S+dPWPIUjZt0hEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbKfnREEy8gWSm1p24mswVS+zutjCtq5LXF4tqWSraj57hWoiqRuOoC/XpxL?=
 =?us-ascii?Q?ToEUwaE7OhydteE2EBrIv89yUd2UFcl+i2t0HInMxA4C/nI8KfPaqEB18ipi?=
 =?us-ascii?Q?rW/bSjYisIbpCt2UpY8fOtOi2QiHJolFbASZAXoM/8ECd4/jtGWVT1ua2fq1?=
 =?us-ascii?Q?jgPIGLn5r8ANiTmrGqHY71WOxc4bUV4NS8YQcuOmB/uC2uq7EPYnFFvDXXYy?=
 =?us-ascii?Q?dbDV0Ei4FccKh8jS49IMGp0f4YuzW9G/ORCVO0AWt8rZhfO2UThz65bYJSXl?=
 =?us-ascii?Q?/D+gjnx7BQCHZkGbD9vzqKLpfWEAmqXkch2H1PolEqz7khQY8zDlakRs+csq?=
 =?us-ascii?Q?25UKJXpq8N1oF8ZRcTXTeXl8/BrSs9RG6qnCOqOJHl03upTOO7saMdN7W03G?=
 =?us-ascii?Q?XyM2opdyZJ92eYAL4oNo03f44lySrmXQwzOsquok9fU8VaCKWQtYjcoDi6Ql?=
 =?us-ascii?Q?JEFkAWulEyxNf8TW/qoffDRtxFq1ZRwzYEiWtaRXUb4jlQfDr/9VzC/xtfFd?=
 =?us-ascii?Q?KUCoMDRzMGrO1i8jvtI0a/hJLAAGY2RngXFL70k55m02sEXSFjXzlqbPT5QI?=
 =?us-ascii?Q?0StrDtzJ/4DafY73Em+3D2PBNJ+MM8yK77j+rUeGk/5gkSNJ8MeRrIVxOoR5?=
 =?us-ascii?Q?vcUAiRQm3iXX2AkTOuh98eSG6mgX7hTxg5OFgpf6rPDYNBOFdPendDCCqBMg?=
 =?us-ascii?Q?Zklkf7QuSQxVfh3/2Z+QitrhRycygicXx8eATjbddcpiMnqMUfHcald2Sp11?=
 =?us-ascii?Q?D6FkxtgFtkXzRr6C9/Jv1Mg9vKkHAZLSLbSG5aXxeJnTTELvnEo2oKZxI+4t?=
 =?us-ascii?Q?HUple4/Fs5FtSaNTJuaPJx5xV84elTpw7O0lWhQD4W5CsN/3Zk90THERHK3M?=
 =?us-ascii?Q?OxgqOwca3G+/hhTsBXnATuIyTVhNZaZNBimfE3T1RRh2FneRapEnsWlcOdbv?=
 =?us-ascii?Q?ZGMPAuMlpcmFl8TyNOVkPN2ev+bUNWeL1taTLQSMJVE+aX25/u6gkrCZzEg4?=
 =?us-ascii?Q?3PytJASjzDdNnJpVKUwaQNj/dwYzHstm7Fbv5Xdo9QERClDfz27tnXqA+HwK?=
 =?us-ascii?Q?03vbcgewxh8+P3jODcQegeAS2QFVSzr/8e7l7SRcKkqKb7z6T5ZBAI0Rj8Z/?=
 =?us-ascii?Q?OO3Zdzig8kRthx/svl7/8GwxGpnJXWVwqCohR6QdPm7F8EG1IWso4qlJ7Z0r?=
 =?us-ascii?Q?n8aa4q2wgpY0W5zsj0MSglEeUAVDzU0R9RmcRLL2A5PvUcABBFYXHsnjxDCP?=
 =?us-ascii?Q?Q9xIlNeSsEnwPQZJeNVzztaQFvjWkHZpXq4thly9w51l+n64AqTT3A4NsoAn?=
 =?us-ascii?Q?DLRlH9JZfAm8gO2EWPXb8NJB07Hplh1no0szrdtghuUbnfgRMdJKKXzcGpQM?=
 =?us-ascii?Q?LUsfOwg/889MccrhzEG3EfAnyuuCcVRe8AIb82VjdfuAf1XmuAvt33AlK1hp?=
 =?us-ascii?Q?IY61alafD4Q/Nr3aoCK1bqKBlVPQqfrcjFsFyMYtW5N1CEJ7I0HidJy3Enst?=
 =?us-ascii?Q?bXwNN9nj9r0s2Lcv3BMwLoOIJKjzZSMg9b98iJaRZOiEJIygROGYzBq7JtuC?=
 =?us-ascii?Q?2uT89Rx8vPQRZkoqNlPogF2C6QOrmg+j4OFsGYnBjFne+NjidEeI21A1tho8?=
 =?us-ascii?Q?LgNLFxWP4ay9PCAUPUpx5lnVZqU3AXUX/ZYjn4sFHENnN5kzyeXevrceCxSy?=
 =?us-ascii?Q?J+ipPAHtIlb1ozareQBjxYyXxalMZTg9bvD0+GsXx/XQ0ksFmOZ8/Ny+xUfS?=
 =?us-ascii?Q?9p2Qp18j7C4R/5cwOyHLcY2fYxuuvqo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f19471-8023-44da-c7ea-08def711ac83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:41.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY5ArhYeYgSpFmL45pkyKm4Xoae/tg+6cc+qZ5QS9xa1hON4smWfmOUl8fhZFUvsnFGWCFefCHttnkQj417Bzv/18Z+lB2I9cXBeIQdsVfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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

