Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44A19A288;
	Mon, 26 Aug 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707617; cv=fail; b=aMa2bq4MBAbW46yX1xyOuXEPg3VTsymzKBNdknSzGp62gvZKXSbsT2Z8ibMC2DbqCovhZhPg9/0P/o+lycSBkHOIhy9ItxGBlWrWYlImk2M1zOZXZ4q1QK4pr1Q1szMcwC/iD2K9ccVm9h5SscMSrNJnxdslURIQkURRZ3CFNXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707617; c=relaxed/simple;
	bh=wpQXg9Di62OGh+wnzeEq5dTmWbpdd3smlJtZWSh/rBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8985AhCQftiNKE+gqUujQRjaxb/Bx8L1sljrO0A4EL6cFp2f+ww7/SghhsannBPhFCMbLY8QPpZqKEcqBTflYyTCL+6Tr3D9TVMEunjPYS4hUoBo+xOX9O389IX4mtWHhpNTNUPxycXFxz1aV36WiCOZ9MY+6VxzbX836HL55w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJwdP/tN; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJwdP/tN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr9eViEUPNO6Kb5I7K6rHCicAnihX21q64i2LuZ9kujSiNl7rqZvxz+a+ZuLVGHw3BW15wdvQNnbvmqecCOUkxeYucV7ByCh24UfB3mTzqlRHd0zioYM2i5xtlJiC+fY2mjPMBpu9ZUX3mpuOJw/6L7F71UppRBYT2dUWAhbKzC3g64IotH4r79bTsbA0Tp6nqhc5nnp3wngCpUzdMNfFvLDCDSieagQQJeVZocLx8+Cr8MGARrQW5PzdL8Uh5YcVEjAN4KysjzyUJcZTZf8c71ucEvBx0nve01414J/K1S/UQbYPHeCSMdIOtkuaZssQWtRT+3fmU/mqWkQUDrpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6JeckLYSKOR1pLvB/LxAC2tq7Nu4l3LA1pDgNUAMug=;
 b=v0C9AJENATwpLrbJB7BMHWEscpHPxNtNtnNrK7DvJD7H8Hu6hNi5NimOjB5XhbSLnZ4rtCWm5ZNvt/M71Rhm46aGLRFA8+Ka6H/1M1svjXCyu7nNQyefKWL6od6svzWpf4X6KPMAOCG7GQTwLv7RwAJ4RDOVni7H7FjmvHA1lVbygb+IA6cHB+gjExbKdZ5re5kha4c+scjpbzXMBS4ex/o9CxReTdsaILKFlW67zeMkmv43BJARY2mfE5V0iKz5Y/9HnBo9RlJXEarAnN/qLTk82yPV0iEWw/rY00HGmR+s/xmFWUMAP/3M/TT1bfU1Qo9pj+PTen7Zhrl8mvjyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6JeckLYSKOR1pLvB/LxAC2tq7Nu4l3LA1pDgNUAMug=;
 b=YJwdP/tNB04KUerop0fpk8OVW9TR+sivdmgbSmcjZO9fO9CwW6JVLjguLTdtsX0S2z6IhlxPqINgB6x/0AfTLHz5m4HzC+HEGAkdio34+5QbOpt4uRihcgIUY2JEtmck53bNsmKjTyZAfsKtvJCoPGcI83yCZBbxeo0dOW7JWjUBDPlYlfZ7pXwR3LQyj4VtM3jwE2TxNjzMFzS/Jj8xsU7/O/3zSaBF8DhXMjVn7oJUV+YmYMUsZHV+1a45iELSaqAXjPb4sorPmId5FQmkCHHhKkwN1LZhbvxlrMC3Hg7HaXYYljuFA84nlUp8URrHeNqACLnAJmirjRWNXcBzEw==
Received: from CH0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:610:e4::26)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 21:26:50 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::18) by CH0PR03CA0201.outlook.office365.com
 (2603:10b6:610:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 21:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 21:26:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 14:26:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 14:26:32 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 26 Aug
 2024 14:26:31 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add hw_reset() support for BlueField-3 SoC
Date: Mon, 26 Aug 2024 17:26:27 -0400
Message-ID: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 510c8bb9-546a-4cec-75bd-08dcc615cbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGza6bZmEL82Z6NcrhQfYRBtV6g5iXKhC4FyPkDy9xEZVPBBthCN6hSzqlry?=
 =?us-ascii?Q?uQFmzI+v3U2sEAvciT2IATE7lJ6fG0U+PbhG0F9vIgm89S4kEsmezulNsUka?=
 =?us-ascii?Q?2AbaKHryCclr2/MUwmx9SOf1sUvWPBrcGBUn1Sa1MwOeWD8KsaQwTyQlVyZc?=
 =?us-ascii?Q?uXjvKcTSI2e3PA0anwWeaJQKZ2M+FpPPtj3TnhgwQ0zN0OrKUC25w7wb7qf6?=
 =?us-ascii?Q?4RAPmvhG/+vnqaIb5LbFCigvKxvEEnSpQ6+H7itGdIiJ71D2K8ZK9Y5xqs+6?=
 =?us-ascii?Q?M6IKMTyy16Gxy1m6vrfkGLROZ7NOe0vth+QbOjBHpbLqjsWFsegnO7m9Tb1e?=
 =?us-ascii?Q?2MFwnW9yEGTiWpLCd8QTNucEDS/U1i3HesbngqBrCdcrP2ETA7t7bQbCfUi7?=
 =?us-ascii?Q?xiXjR43cCnvotFnWbM09edJPELP3pcpTq5b+D0ZQl/r3KGM0E0iLhzauQtnQ?=
 =?us-ascii?Q?13pgTZgLHOaVPB0OIFgj11hCL9LfD5R18LFqaicVTnqWmGp4oAtplTYtaoSH?=
 =?us-ascii?Q?Y3qQ8XNnQRXNl2uu4kmuiIR2zzTWWqt8lE+mIbUPAOVF6lWGT+Cg7MKO0wUh?=
 =?us-ascii?Q?CHLYQFo2HvffK+wFOetKvwfhDd8GOfQd+hV/b/l5fNIqQFHcXcBPtGtGFchU?=
 =?us-ascii?Q?yb+WjtErNg9wGSH/30Nf1xIqa+waOqN5GmEha84rJ3Q7+P0PhBzOIV2sBHaZ?=
 =?us-ascii?Q?qpTNjbcfNNXpV2yfVGgVbAsCPR05r5WkVVPrLKW3CPRIYAWpXAiHwGKOaiCX?=
 =?us-ascii?Q?xMg82HEu3aIVuHPeN1RxE/h5ra0/R0jt8NiBnFrTHV0xuCmAEJSvE9PK0QDO?=
 =?us-ascii?Q?dxAJNlF4xXHaXetBZ/KIQpG3UZYi1eZkDHirnwP0EaMiRftQUjTW8bFrSpw0?=
 =?us-ascii?Q?guM712Gt1rUWxkcxJDohCk8HqP7+z9XWI9BgfXGdTPn1crEsVygRXXdJ12iS?=
 =?us-ascii?Q?IE8HMSx1EYe0/QbRujJZtCoqKsTZmredL0BRDiHakJ3QT5h5ZS1Xx2LsMfOm?=
 =?us-ascii?Q?7yQMRIzwRD/dXk8Pf4M2yxxZA4EIp6hJoxzMnsfoDNF7h3FW9jzPVwe6aqkX?=
 =?us-ascii?Q?PIl7gcQbUiqCXZbVlJC5uy01prTJJ1tRqguFbkJOzmV+Rpx10P/Vu/jSzrnc?=
 =?us-ascii?Q?3hiyHwcskK8AJ4wC9sjjQLy6DpOr4V0Bg1ai1drEPIZURp1uTa6PzXlncMZs?=
 =?us-ascii?Q?wiCoK9jfJKLfzOTyufjCe37qpDRnRV3ZECmIE3FcD16lFYgDJ5qcbjK8k6hv?=
 =?us-ascii?Q?lo3VwAGkF2RuM48hqJq5n335J+QC4BQqsJOATV+20IMXXZTNAUAqwXLfbzc9?=
 =?us-ascii?Q?gsFwzKDIQMYtoZGf4Qy+uqlzhLQDfy3PRauFLgMVKuAdaLR0xN32t4tlhXl+?=
 =?us-ascii?Q?2/BZm7KwdN+LdeLZheE2wwBtdQ31xCxuHytQRyOUKAFaE4sL3i5ZWNpUoFEF?=
 =?us-ascii?Q?K4jTK/7qr2SLkif2lAL1IFZ8exBFxeJy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:26:49.4229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510c8bb9-546a-4cec-75bd-08dcc615cbd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

The eMMC RST_N register is implemented as secure register on
the BlueField-3 SoC and controlled by TF-A. This commit adds the
hw_reset() support which sends an SMC call to TF-A for the eMMC
HW reset.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ba8960d8b2d4..3c763e67e4ac 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -201,6 +202,9 @@
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
 
+/* SMC call for BlueField-3 eMMC RST_N */
+#define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
+
 enum dwcmshc_rk_type {
 	DWCMSHC_RK3568,
 	DWCMSHC_RK3588,
@@ -1111,6 +1115,29 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.irq			= dwcmshc_cqe_irq_handler,
 };
 
+#ifdef CONFIG_ACPI
+static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
+{
+	struct arm_smccc_res res = { 0 };
+
+	arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		pr_err("%s: RST_N failed.\n", mmc_hostname(host->mmc));
+}
+
+static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
+	.hw_reset		= dwcmshc_bf3_hw_reset,
+};
+#endif
+
 static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.set_clock		= dwcmshc_rk3568_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
-- 
2.18.4

