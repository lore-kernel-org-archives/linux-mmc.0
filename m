Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59DF43C04A;
	Fri, 24 Jul 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904630; cv=fail; b=SR8Q5ycJTzTIWa6iiMoWbYhiLx2iz/X8yS7o3/jHWjsGWbF21NRj2YAKWvTo0D+yH1FAjAslCFJYXRfLafBFuVJU0pu/6rDAjVUFFMu69yP2Wwb/SSGpciMfGhygLs5j4bPyXoiQkBXcITNkqxAniuxyQ69vKnt7lTPwzhPc4BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904630; c=relaxed/simple;
	bh=hiLvys58qkQhbe/3j5Y5Ro4NHKwTa/gY0xce6W5Osj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJc/MSUSr8AsGirqNYWmRA/zMYcwTvqGXHd5aXJi3fLIGlklNprUIuBN4qB1FCJ39vDajkRzhlwh1xrmRuAtLCcCy2Re/iCfS2hGwM0DuFPRiPxMaFjZcT1RksjfcoGHkHTqbNxcPG50rBbxri3c5KdVV6VHV5BDxZorzl5Yqx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OpA/hZJi; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OpA/hZJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPWj+hw8f2r2tl1nn1miFdb9Sis34v8x1nf8xqDIB/su4L89wO2eS8bUibe7NP8Eknr6gh93YygtwBuDbnQkMchdS0WAKrcRMQFz/x877DFWDokPxHf3X8xKcGXUSXgVSPEW1MtAx3liEl9zW1OaeTsoHa0vocceAKO8JSyHjf86N33SUReC915Iy02oVcTBHqc7zxCETcAHyX77sHWBRBl/ISmunOclq39naJWnzYvQ7GP6we9XSZfhSZpUjEGi7/XBpB+fwv3qGEi2e/+HOWFIQSKBmlfsdfs3VKjITqgEbHJBzdKqC1swHQZJxWohQLf8FEqNPhdcQO/3PRA3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUPDiSJAhyMBRYieHZ/SyZyrpS62S7um7IjVml1I4aI=;
 b=V4twoZ2nOrCspQv70I3DLYdEOY1t8nLhr2v/S/JkdCFxR6fUPxGCM5i0F/zagtIOoa/qutnhyHj3w42LruCHO+/3BtEfMH4bqUuxfiysonvUZLsUPm0At0TTfhx4G58/grDixMW10Ctu3N8yVbQAUGv2naJx6EvbHyYetl3VQfVHbDCunO5vq+yJxZh4VnFNTB9FMlvDnxDB03nJhu2Ecba5VCJCYYQQTsbHeFxfhhVHGAsbaHLOhmuXRqbcHvjvAoLwhfIMcpc5XFyaeCLYFQwZpc6rDH8VWTvHJIFEmlK0qJIEVivE4bTkH6C5MViCGh8uBeGmTxhxehjbm+eSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUPDiSJAhyMBRYieHZ/SyZyrpS62S7um7IjVml1I4aI=;
 b=OpA/hZJiLRQ6LtK/OU4MH3vgmRwW4zZqB2eQl6pec5GVhXt191nWJLL7xvZMRYkGodHoTP031thF80FLjPyXmkzCI/fYucbq9r/evarpWhDq6uw6VBTxN+ggkQ6Gy7Vp+htfx/RzqzlkM/yhnQlB/Zdagw8fuFa4k36Jyzxd12nP6WtZtT3hy7U7p2Bq3RzkTh42kir/99DwgszwD9kg6sJf0SOgHPJizD+JsvH9f1a3Hqs1pkml8zng+PxOSMUGouz8PO7YW93uR22u60zu5R0ORQe/abIZp9k+XpHSLd/cia0dmyvX6//V5xZZZusY3BmzK3mA0YRK1Q/ItSD6Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:22 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:22 +0000
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
Subject: [PATCH v3 6/8] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Fri, 24 Jul 2026 07:50:05 -0700
Message-Id: <20260724145009.7456-6-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25df0502-1016-48b8-437d-08dee992e361
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mQEaFqrKs/QJ59Hb6cf1v+pd3nD3IMefFJ3BlF5X35FQeMZMVlBA9GihZj+lpx8BERuQZDOxKKCrLBMYUzHOxwN+TkZ78Mc1VutcJZb7QzLXT/P+drWR3sNRd18+458nBXnTI3ICzqi8N/e+VjpXG7sXoaFGJFM+KTlyqdBy/ObJAUiAJDyUws+sudGbSAynlZf04U1eGXvFJqrA60tlK9FcQwXMlFW3JPvVimIdoa7h8aq3W/E2o+9DgPy33Bs8HyIuW0FmfzgUVHESohCiICQ1U4jaHY4tWCbqr9nkfGphi6TlehY9KdrJLMIU0d8CMaRmSwv/VO4T7XEShY2VW0PBkRnziyS9SFw0kYMmZV5gsgAPY8zTIUp95sbaPCTg2cSkUpsYkGsfQwh8iovKTiaWLyiiiWBRIwjkrVNg1ayeoKczqadWgG697QJz8mCvOclGa0vN5qEEDH7wzUOtv5tng8G3hS5pgnt7kni4ZtER99cAnK3XWaR58/2E+i47iwtrqp6TUHfmyK/Ynn3ii1WCmyc4WosyqAHLJzRUh++pIMQM6z6EUgXChKs1fQQtg4/gv9z7jIJTnQNIGXJlyEMnDCKjVRYyv/yYEIP4VJWhiN0ri97uvIXXkUxP24CVj5zB9zj1CCOGLZZaaJDwr9JgmCtbKUjd0P+i/Kn+6+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcqDtsHhSK7X9FM9ymwmeaFGOMhs60wc2U0kR9qs+GAK2FrcLD9hJK3wwgST?=
 =?us-ascii?Q?fHkURI8dCd9ETIEEX5pDru9SxE/HbGbS7+h4HxAREY2elNu2mW9DZcN7rnQV?=
 =?us-ascii?Q?af2lIQJmJQg3zi1kE8dKKsAJMCct5To8aPWaavM4xXQBZ1vWV5jgrysXRpuw?=
 =?us-ascii?Q?k77nvnPeXYpkDBl2i0AgtWAlKvVTNJrvnEXu8u3mccyEVvc/gl1XjMjtM4aY?=
 =?us-ascii?Q?aNpiuX09uQuumHKH1LtFTV1mYCxnlNbCK+bsh4JSYxcvNOfvxCz7qo/bpkcC?=
 =?us-ascii?Q?rwJ7YlAPTew6g0rDLrUSoaDB4vb3EoF+Swo5+8aw2Uwnj1l76mptGWzUSs5Z?=
 =?us-ascii?Q?b8v2BvkSAaO4bwxla+98rZ8fAiZoxXI/ZegWykjub/ZT0Oo+FO1V5/jWDwyn?=
 =?us-ascii?Q?Ra2aCZt9vYEPI1UVQIj11ijf4YKWZiHWDnOuzJmnNqLLtHIWdNFrYWYCuTlW?=
 =?us-ascii?Q?wQpaqNv2IwfpnWF5qCc0GJNdxjKJFkbxEyABkh2X/tlWv4VxjH8y+0x5N2Zs?=
 =?us-ascii?Q?sVZ11XRSgxm0fNX7isnL6aHiQ3lb5bI+NEIa5+5bXXPddWYBXpEL+FR9PC/d?=
 =?us-ascii?Q?f6HqCQ4EzKhVoznXnF9OXfxIp5UvTnUM/850u68E7WEz2rB3prAl3WXzuBmW?=
 =?us-ascii?Q?wBbswbV4JMvQGeA1nF8XKkwAm9FDjHXL6noSSdbgs49n65/jtOWfkXrjfmJz?=
 =?us-ascii?Q?oLFa23c48mNY0JTRnSAlLGs4cEuWbxaTo/zbdeflR64RqpHNw014A60BpWlP?=
 =?us-ascii?Q?7qzhY48Fk/Q+A1yZgZDKsmR+dXu/xtqqsc9W0+JotYDAjEyn6q4dK1d5XI94?=
 =?us-ascii?Q?XyEU1T26dNDXtWMXuwvlZ/Euy2ecCojaL2fLkfvAiBPE/3cog+UTZXYZk0HI?=
 =?us-ascii?Q?R7PafcIize17EOqb5Xm4J+OKCx3p3WMndulZsyQ2iVL+VuQEAatBbfRgieHj?=
 =?us-ascii?Q?Yg2/ZL9c+q5e7DNy8JGGG6qCp35c4Q5SRGCYXOgTFKH0rqQL3D7eijNZ0HqK?=
 =?us-ascii?Q?2f/xSRHXsU+JDfIE0m+UhiqyWkcV0BvmWYhRl5askI3zGfkcg0pBVyCKo7X8?=
 =?us-ascii?Q?Kax5sFGsLT+csuWHRMs9l/rjhqkaj451TqfPbgox9I0wunLqWm5V43F+gv1e?=
 =?us-ascii?Q?ihk7x3wQUo5hLHhP/4v01EjsF6jxOpFzEu7NjqyBaCqvdApG/wT0CxTpTy3i?=
 =?us-ascii?Q?rpq6wBFWw1xyKSlStBP3aZxtVynWXd7lN/tzhJUOrVNOij2PnbUG+A5sH/nH?=
 =?us-ascii?Q?30b8tkMFqlTdYTZva7VGJo+lhdqbgxHqwcV4z9FjDt2lEM7FqNq0PvcH4k76?=
 =?us-ascii?Q?6xqzGObtQVc3wef7i5JN7SESP5sT/mFPthJ4Py2tGD1Wa163lTJfhq+AUeS2?=
 =?us-ascii?Q?wa2+jk7f87RK90dvYhGrShVP04MfTZaSj86wAcw3drKJPC7b6fvCU3OswOi+?=
 =?us-ascii?Q?vI0S3EK2O4vzC2NNR2S5UUx/qWhnUfhJkoETkd6zF+LqHXJzBJ/IEmlhM66t?=
 =?us-ascii?Q?+0krA6PENFBV8aeDj62PQVp/JkSYSlK6/4bqyqgwF8aaLL0rXaI79uhkubXR?=
 =?us-ascii?Q?heyhhyjx7+Pp22uIyUkn+ClU/8Pg3XUqa2nwMiEy8/eTc9Faav2hcIhbna9p?=
 =?us-ascii?Q?RiVq9M0932Gcp42UJdYgXGH5A+hfRcKMeUvHKujwhybqAmZch/QLqagkkrme?=
 =?us-ascii?Q?wVw8/uvFEoaEwXuNVnNaQ0usHiLf2o0riUWGw1qb/Uu1tYZxW+700TdSLzyZ?=
 =?us-ascii?Q?pZDmMQ2SLS5sknIRSoyzJ4MHCosNDus=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df0502-1016-48b8-437d-08dee992e361
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:22.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apaWs3/aHMrY0eietVBgCy4V7Yle6sB7vdIct8+s+zLu2Hq3r3llb0reA0lplcyVzMeA0ngZqdrTXVllwRfm3zyygSxxMSSpmJngrljLfXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

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

