Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F75412C17;
	Sat, 29 Aug 2026 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788029001; cv=fail; b=etsE1byg0opx1aBEOGr4efCIbt8VVcbS45eLwBQPmiF+bmx5Cx1EEWg4IblUR92WyHI00TxTkEzuThFWKRduzx+MTgms2ZjRMTaQIF0lpToVNlT8qGckXYgDWvHwfXKro6eBAMSRkoiYazXToDpckg6PGJ3hRXNGpiSJkphxQ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788029001; c=relaxed/simple;
	bh=JlfpqPUU+GzssH1r7oCUMPtS5nR7MadffoSoOkF5lb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+J1dpJ2iXgzlZu+1/Zlc7YA+i2ZS+/U66ivYEGMAeH3ejtCfVAho52bY2EjH1esklOtl+wDytI/r5E1jJsNhovbl9IL9hhL/HFJ4mo9c+n7UBm5F7FkduHy5dZWbL5DUM6EafIbvHZ9T9MQdNOvtl+HPODigmVwVUr+BctfBYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HOxJ3qnz; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HOxJ3qnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smRMSZo5JLxrEnCxd7Ny0kX2eJMqshrLlJ9Yib0sVBlsa17NccoxjncD7H9cz1gv4HXqB0mL5YiQYVKCxcR2F8P7UWclS87BROS66KCMOm6xQnDFvS/TMOePrM3c3vgJkZH4H1m8w2VJxOz4Z1Fwv3Mir+kr+x4urGAlPDyW+XXOUZoEB6xr2+oosSNuE64iBVFoNuB7GTAUi59KK0GgxPV41APHsrIIraFOuqCwPXT+0/CR7MLJjQNRHFKvqfSAxc4EcU03VOAQvpKzMOaHSh8gQY2lA4uLWokjUg3OyR390Sn/g3ac/whqCDDpVOu/T0hIS4sF4Jjw4bfrSq2xUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=HsNRYw6IrJqd+DlfMEF7SNbmPGriptQ5Pj2qpdpuytjYNLZK1OZp+7zF7ZOEocb0Mzj9Fs/iibFKDZJaKBLYjJwrwX/TZk+LgzYIg32XLVi2sM/m+IQhnSYCiqUjuR7nBUuCdJQNRU2Qw0XWmiybqGfJctknJ/6QRsLe3MspnZQ7IkP9lzcKuXjNDNrAoWUHqBlemb2EjfiBtC+Z+4J5dK3emmEYsjAjABrlJkIFIQGYnTrdsleVB9a4paQvsxhwzIARxjG0DdGFy8RPeOEv2y7mR2idsLD5KqMLO2D8wjVFTmro5yZqsfz/ScymrG7BHf0+itx8p7rl01MLrsIN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFM55r99TAaOMZWL2YMQZO55XP4I9u2oovB8jwSPAHw=;
 b=HOxJ3qnzpP2p4S+AXbi1HPJthO9u9anl0eaIqRDtVhMW7+K3romQ0iNAPmF9N3/xHj7/04S5XA+r888RQf8fq0PgkwWp6o8I3oVZOrZkg8aOcUOEFCyqgRuuDReTTkH8mOiY0Vwxbi0R62jG6NjYAPtj3bzQ6aTQlhsBNFaYqr+EY7tXhehR+zXrYmuVzJl/FFs66os0PBGYhFaEYBZzJ6p3pdF9KI7yjAtejizo9ySD7ECHOREbXaHbGdCIU5CYGVsdnEP1UO9ivBGTXuzlOMXg0tGG/Xuc1Rs9bF7Zpiri6sleqtLjoaVwd6nYmbW7eeUd5gqP9WmWFiyUOz5lqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:06 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:06 +0000
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
Subject: [PATCH v6 6/8] mmc: sdhci-cadence: refactor driver structure for V6 controller support
Date: Sat, 29 Aug 2026 11:42:48 -0700
Message-Id: <20260829184252.27644-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acba564-2770-4065-ad69-08df05fd5da2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nBdB0XbMCoI1lslGMuzI5PdOvWHo9VHhV7RShZB5wvPX6lA1xr2Wr+91yi4C7tOqVetWdu4TIF6Q0kun7CIWzU85TElmFqwRNJCHRjILKJYRJpVwxr3HaPrv6GPlEQftB1pTc7csvedO3met2+ASx4RKCuFg6z1bgDktyebIXJb5rGlrhay9CGFL83a7iXYxd/MckuHD2CAK/JbD92jGuco/fq4lJA3RpfeWklOvGaSMIdMJFWrbINf1MS1sRbOMJYdUh+BSzMdcVrxJDmKif1ZmCkIo1AOpQXd+4iBe+d1xrqXpXKdf4KP0yri/T0POXAawxE0TYw1nOSoZBXnTiupvMdSnQenQcO02Hwosy0Uj0yT6YFqj13xOtv3G4YjVbDHyZJD84bw4tk/e6rAwqUDjvjIg4V5wItzspYsEVq+4Ssw975ORNDoMkKWMDcGRIQK3RsTNzhkoZkv7lkXKixaO5rAEGVgZgLBXfdXtaMV4gR6gehNjTHYz9pTVvA6nR4Z66YcngsUFCj5yIMsue+TsY0Abso28i6s8Ia5yvSYHQdpEcswoC5F5HV+qXPG+NNwb0oGTOuyX8iPu73hogeIF+QdwERS8wAtOGdTgjlc+wHOXn6nef3LxhQ5F9wG8Or+9QDeY5JBjfUKsvS+cptg2kF7b8VbFaQbyq0cWrkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZEwZ6ifh8KeSqJWXj0hr4AE3RkXTyu14iWreErcdJgRYBuQt88UqG20nP6sT?=
 =?us-ascii?Q?bjrcJNAAFwrVXk8fi94eWih0tLfMfXpkQ7Mx4euutFDWVP7WLhfBisrmpxoJ?=
 =?us-ascii?Q?sa9ODIDEkfCQdwG7QSycoIV4rye1vBBOEAT+RCRCUMaJq2wmbuF6LUsi/VFg?=
 =?us-ascii?Q?ZRipTvIuD9UmBEzB53E/1p4/b88aSWU9WsoVavIefHh5kypCrX7JgWFgzMak?=
 =?us-ascii?Q?LN1AYidB/y1e+IORiETIm6ISOJwN4bTOskoWvkmNKlUajlH+wpGObP0GSa12?=
 =?us-ascii?Q?lJ/lrbkuZ2Cn4oJe+TR8MjOKiISgtaBNfEDetzUS+o9ysF/mD4nrYNqRVtFu?=
 =?us-ascii?Q?GYNbYIbNVjlApM1A1dWTaPdlXgnzpt9SWp9vIiMRqMGdknhB2Hx3mw5oCTlQ?=
 =?us-ascii?Q?0s+HTrxSbSFRvpvJ1h/80YIM970CwRN10977Td+I/PFuWn7ivQzPPQe2ZSLk?=
 =?us-ascii?Q?cU3qwAvAc4hDx3A2FVqzNdJ0v0f87V7uFWU+/tleFZTAak9ao3KplMIHSyV1?=
 =?us-ascii?Q?6+qQRZ8KwWOpDEyoEmkPWIjBfjpwqxf/2pubKzYf9MVd6X6sW/nG5L0nd6H7?=
 =?us-ascii?Q?VooFQQzq04XXsruPg9vfSvhalwSgPegubHUsgqOkesSmpJhplOUoqOo9ZfZ5?=
 =?us-ascii?Q?M98ixRV8r2Q3da24fneneqUXRUx6k7OiFikWom1/MLYADhyqYSgRgBSVIoe4?=
 =?us-ascii?Q?jrDA4fwawp03kIpqM/u/QNLoM6lmH4FdLPF0PBDTOWOvL7BOo5lV/rUk+RFg?=
 =?us-ascii?Q?owZ0a4lG1QidTI/ub0qiFA4qJ7dhTqJBBWqraVAeUrqGI8E2A6jHmL1OvLdZ?=
 =?us-ascii?Q?cJziXCv4IsiSXTUH8KbvI05tLGgtr2Twh+LPbsO3eMTBY5tgzlTSfaxTJs9V?=
 =?us-ascii?Q?zqUmGIjWWa3lTI8oZ4TmccUihJscg3cvA4zaO/H+UdVXiYk7XEUwOW0ufSMV?=
 =?us-ascii?Q?gVnL5szCUJ6FDJx8TEQwxjDS8IK/k4x9n57SLyQBFe17RAlkp5Es61lfg3Tt?=
 =?us-ascii?Q?FX7WumaXJD3gXlhsh4psWi5tRuVYhQmj21d5xXURLKv3ssvPLy03D58aCz9J?=
 =?us-ascii?Q?PdUPIz0KpojX59Nohbmrlq5xPZN5jNcMWQjkJ8Svna4AlNiG68cbpWpTbjsh?=
 =?us-ascii?Q?1Ai4/uv2IfcouXmS7KVFUp8kC3WhXpet3q9UcwQT+egfcOLBbh7vBKCDKN6W?=
 =?us-ascii?Q?C2RZ/lKws4wemFKhskcsuSsqhUXM6xzEpK8bfpfEpeUGc6OqpvuQ4GMalVuq?=
 =?us-ascii?Q?AR/bPSNyDjHYqQV8ruZg4aQIzvnk0yZFWeTuLRHkG/Oj4EDeRAM0yF1PCowh?=
 =?us-ascii?Q?pNj/fZaWXZO+eG8xrJP5y3BfkaohEsJx/CBVRP76p+lmWsOcC6yH/6SVc27S?=
 =?us-ascii?Q?BsyLi+zd+1aiEmBQbRMpHcaxL4hJer6qjlAr87r7P6+TSEfTR34srVJZ69j3?=
 =?us-ascii?Q?qxXisIvYmY+2Lt80fIGJ/QrcE6WPmLvdp2h+XQV9tMdynULEgLmNKH/MZhzQ?=
 =?us-ascii?Q?T+ivLbYbirhAV8pU10WHYEvhm4eRucLC/lGRrHrMYvUe6X2P1nUrmGYw/xWe?=
 =?us-ascii?Q?d8io00VvIdG7h5t0VmeV76wERJNyRlpj+DPTy67weFAjmpG327D2bxmXYq/b?=
 =?us-ascii?Q?5jZvnDqf3uNkrxwcXWljxvK01rRO0HM+SHdJNxnQM3dcV4KPPdx8jPD/8dmm?=
 =?us-ascii?Q?BVqGwPhev8udPL6aCvuOiuviUYr9fo0I71XZJSK7Cvr6Xv4fxwiy7FqA/22t?=
 =?us-ascii?Q?eNfGWgmqMk1u964e6wTXTrg3TmGQry8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acba564-2770-4065-ad69-08df05fd5da2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:06.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr5ep8n3ALul1HJ1x/zXLDFK5x0ZWNuDsDezWx5PwEMI/i9ebgxMBAKgjVI3lSa8TuBDC7QUG9ykv/LOH4gIp/SEDZmJIte4GSvEvkcKEW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

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

