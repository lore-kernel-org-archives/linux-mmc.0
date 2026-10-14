Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A14E0B67;
	Wed, 14 Oct 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979974; cv=fail; b=OhW13xNyTnEEjC/OKMgFzAe8ZNAkgAr4LdEenWvLrzN1FaxUJ/as2QuVzgRq2mdoXzvIjTWGGvZkCathJ/WxSbtIAufz/00Pz07dBsyFrPOYCVTPh330DiGGoXvFZUMXkQQj36mPpfYG9LKr+p83g1cYiiNCi8VH8a4EtCAA1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979974; c=relaxed/simple;
	bh=Gz1AAvoNN2Wuzb7ZY1S+i/XxjPdbiMWaW1I6RF9bnJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0/PIxIrcJTMn38YI9JEm47qRocYTapGK90atphHeEYVcn6OUw1e3HzZWt7jZsYZF6O+vIXk0yHX+UdXZnDNQxM11av0qN3NfF5yXss8TuNfYUQRPmCwaxLX+6DIu/o6G01wn3wkY+gVszmsH66TL2dqPDgYIdtF/6t/VUqLHYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmCIjgX1rrfmygH8GZzY7FEhKtzFVUnlHQKbq+T/E07DSCLaGEaalfryu7/fRiLM/khEwN6mVZi2aeICvC29TLWi/0wUIbP9GpVYLAuRZz2Zn8CRZq9EJSdXG3LLgYckIXZquKPdKHSTxrh+QR0DD3kNpHxeI39/hNiiKnbQmV0mAcJJxykXrN4Dlgazp4YXP0qj3hPSaMbqT4aWQfa141TMlbbKZTaqnlZuFK7GOtVgQvfRta6di3Gfa/q//IE4izUiuUtTq/543fi3+f5FFd6ctOzBBB8+efU9PTiNo6UvXXHspSVcG51a7C15rsDfLeHVsOCcpsblec7JvUyNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR5kNp9YIvjRgYoEwntofsA380D18e5VIfBMX2bmays=;
 b=bkyVj8b+hYJb6wX08dLzzlSMqUR6OnPtwt19JO3lGr7pVmxOmfjed6gnBvwkYo6QYDc4IZEVBG70MhWfd+xbs3ll4zKetnJONHUfAYI8VJylDiew+WxeAncJgCCSYSCeOvGGffZiYx7YWoEwsJDHNrmVJwOjA1rZvti77DbuzaQFuKlVhsqBN0BJn8kSj3kTCBfKcwC51IBNKUOIvKrgF+1WPVq2yEVwg+UnqZfG3QC2pey1mH72B0iwWe5VtSDb4pR0oba3j7rP/PO9b/MaO3fOFQpSoTMEmzSJ8IAXznPkISFONHK8Z/wRYT1Dqyr6paSTL+kAE4iY0MfqXeNNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1233.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:12:31 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.012; Wed, 14 Oct 2026 12:12:30 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100
Date: Wed, 14 Oct 2026 05:12:22 -0700
Message-Id: <20261014121222.31385-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1233:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a2e9e3-ce12-4f50-fa34-08df29ec6bd4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|23010399003|38350700014|56012099006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8XASUxXDEAWR4WGtl65vLEBQlT7Edyj2T69qYZDguB5ywO/uRwzNR+w/PaJdWFeTaiqm/R0vZf+pUuHYeGCDeK5b+UHvpboGO/IJ6c+A5bwEzYP0Ea6x0T1Z3Kh6EXQPT9CCoT72yCq7w5Yha+52s4X1TzUhHbKEquJsLHWdz/hNoib0PtcFUIh7Ldl/TMm1OaHsVzYmbV9ILfUqeO+KXdc9M01Vawd2jxy6BeTOHvNjW8WmvM28fJKVHZOAyYCgPZCz7Xb1OYgLhf0o93TYqmtCDjXQQdnCEKLWLs/rQWip1UK5zg/clwAGjElT+6qPzq38Dcm0UfCAOmxxAFzEcnf7LzyAVKRFr+Tt3h09IjVWFVFoyCGctiogl4NjUBXxz0JjyeWek2hUfbYJQTyRlRxSVC3taTLtwmuzfoClUCyqiXh9+1dZD2T9q+ZO1QeTuQQm21IkAN7rPYJGPriHFf+vi9BogUHSiCjsiauMkJBj5lPdiccdcut/otlr7ibThUthrkkmxzYDE5TSAgZ+HzaGhEmRe84jEuE/TD4f0MKkcZiTTQnj69FVPUaiV3Gv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(23010399003)(38350700014)(56012099006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZTHdn9z1BlPUcFkNfIeiMIB7TIHb867DzyQXYA+iybig3nk2wM7bTgEVwaE?=
 =?us-ascii?Q?ddmu6donVNt9WvL1FEZ4t82pFy3z8NVYb+EPCdEn3/5lGAtjOsSSaTw5E7IB?=
 =?us-ascii?Q?dJ0V6SMlEOYOMHkEBgAZuRqzOSyCdMUo8lGYtF0qgPScGk8QX7cMPXBAwsBN?=
 =?us-ascii?Q?C2au8VGp3MRdztXFNH5iYJ0mfBFSp6+rFc9G/WNqRjGMrnJa5xiobbIwTGUn?=
 =?us-ascii?Q?cGGlFk1KSHg/k5mxzNEF3D9Q6zYxkusps+EHKNULJkuGK1UGldM5sWKtTNc5?=
 =?us-ascii?Q?s5xE5puIO/vbK3LDpXBjrwgvn3Q0hGfNs8EN6+oR9Sy4o7KB+jC0NjiOkkqJ?=
 =?us-ascii?Q?kSbX6EBJ2Dkeln2ex2sqwW3P1QD7Cz+0/9BK57gOLnQPuOq66fYQudI851X3?=
 =?us-ascii?Q?WRM7HHRonZeGUVB5eFre4jNNu3PHlQ5Middrjo1y9JOyI9dfS8O/eF7jzNtq?=
 =?us-ascii?Q?QXH82rjnJFtlQg6LTgzuK/8nAaaz/vtmoDzw3Ok4lhlf52VkkiAWqDrs2xME?=
 =?us-ascii?Q?nF+7MUZtzVgNi3WjBXQWHgClkD4DpQidCOECHQCEpLr2TGdqFh2Y1xez6rfE?=
 =?us-ascii?Q?RgFOB74odsH/mftT6Alh5qqIl2cuFaLYxjvaJrc0VW6a0TMri88GCMooVnJi?=
 =?us-ascii?Q?q1Ig4ncCfLfpR1kokmzDbfrtWKQjVDKnY6N8RrqhfG5ENT/hFVPIFtkkub3L?=
 =?us-ascii?Q?PcwXEynnqVX7yjJUcHZfWcDHKQ94VZS0ZWhYDW1SZUiD0y7eff/N9HDzovOU?=
 =?us-ascii?Q?/+yfOcmC6HXz9HQb39ycR0qs5WMDpW2YhdWqYQxf426/uJymMhuu9zAJXT63?=
 =?us-ascii?Q?bhLCk79Bc1FFtybMi+Z6Y1lvDM1mEPVX2C3kbZlzHVZ+OoF/Zw28Ny8K96Gw?=
 =?us-ascii?Q?0C6bJaLWppekfq1QlWJdMM+8W2hbGs6ZfLzV42zD0EiPm/PpqD82owD0zwcF?=
 =?us-ascii?Q?MEyq2vXXuvAaFeoQPNUneqctQIYNzJySV8b5YDzBLCkkXFynkgXpbyEgleHG?=
 =?us-ascii?Q?LD4K8p+d/KTmo43tBx+VgN97HxD67KsxPhJdaKxefLK65qaEiglPOMhUXZFk?=
 =?us-ascii?Q?HGPGmdL8pdwWAQhErx2pHcTCtlQjdJAL7CWV6NdyxCSVR3gqxzSUTeRUxbQN?=
 =?us-ascii?Q?TtEJMpEduRI+cN3nCpMRklla30yaPalaXH7tGGjIDfYQcuj+17oXWk+Hp8fu?=
 =?us-ascii?Q?cK0aD1dQz2PRZnFhNM4VtGLkoGZEhudF4GrWjyiNlTr17V25HubL7QnQf+wx?=
 =?us-ascii?Q?33wxjp4VECszEqNuLe2UG1RJdGmm3iaT8sl9YLqw1raaIlF/NBizf98I7P7f?=
 =?us-ascii?Q?kxgyX47LHtSVb9z1K9F+pyPIH+Ywgz6UU+Rhi49G88ZxYTFd7e4zCJIBTil3?=
 =?us-ascii?Q?z+2QxdI/lOqZ3JeiS6bQ7CcXnxBDEWwmi0ek634YGLQNPIx6JaHnURHQC5FE?=
 =?us-ascii?Q?HJHHptjg7AmrJiw/iKZq/545Auz9qdy0rvFd43QKPueU9P4BHmsR8z5G1djE?=
 =?us-ascii?Q?36f7eqzQIpaWr3UnDRh247UNBatMy3UVjmcZ5943QJDlzfHO4Ey89/YdKs3f?=
 =?us-ascii?Q?6slsCpTuG/RSEbmQIzr8dKFrbdvFetyMNSovNWd8m10kGpkCu9v29mJ48k1W?=
 =?us-ascii?Q?0up+BM/53EoqN6EVeEMfymnCH0BxcGxDWELt+ihhZD81xURF+lxARa0nFSUt?=
 =?us-ascii?Q?7rAucjyFtRBhBWpFMvoycdSbJeKVY1GZqEPAfztX8TYJRdEAkYCyyOnuLB4X?=
 =?us-ascii?Q?+aBt9KJfVNjCiK+M47igIZF8E1Y0lXB7jzZjRNDlMiuI27EThmLt?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a2e9e3-ce12-4f50-fa34-08df29ec6bd4
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:12:30.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahBNlolru4ZX8ist2bN+KQzzRSbl6jGSRlAy6VMdO0Y4qENw1KZAvJWf0mQVTZTk4MD7hqfbU5G3DKykBMjHN8m7K3tMsO5h0OYd3mcTSpf7RVxNETE+MSU22fnuXsT0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1233

Add a cqhci_host_ops for the StarFive JHB100 platform that sets the
CQHCI command idle time (CIT) to 320 ns during pre_enable.

Setting the command idle time improves eMMC performance on this
platform. Before/after dd results:

before:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s

after:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 249055f14162..36628b44f78b 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -283,6 +283,8 @@
 #define PHY_DELAY_CODE_SD		0x55
 #define PHY_DELAY_CODE_SDIO		0x29
 
+/* CIT for the JHB100 SoC */
+#define JHB100_CQHCI_CIT_NS	320
 struct rk35xx_priv {
 	struct reset_control *reset;
 	u8 txclk_tapnum;
@@ -2340,6 +2342,25 @@ static const struct sdhci_ops starfive_jhb100_ops = {
 	.platform_execute_tuning = th1520_execute_tuning,
 };
 
+static void dwcmshc_starfive_jhb100_pre_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	int ret;
+
+	ret = cqhci_set_cmd_idle_time(cq_host, JHB100_CQHCI_CIT_NS);
+	if (ret)
+		dev_warn_once(mmc_dev(mmc),
+			      "failed to set CQE command idle time: %d\n", ret);
+}
+
+static const struct cqhci_host_ops starfive_jhb100_cqhci_ops = {
+	.enable			= dwcmshc_sdhci_cqe_enable,
+	.disable		= sdhci_cqe_disable,
+	.pre_enable		= dwcmshc_starfive_jhb100_pre_enable,
+	.dumpregs		= dwcmshc_cqhci_dumpregs,
+	.set_tran_desc		= dwcmshc_set_tran_desc,
+};
+
 static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
 					struct dwcmshc_priv *dwc_priv)
 {
@@ -2412,6 +2433,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
 		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
+	.cqhci_host_ops = &starfive_jhb100_cqhci_ops,
 	.init = dwcmshc_starfive_jhb100_init,
 	.deinit = dwcmshc_starfive_jhb100_deinit,
 };
-- 
2.25.1

