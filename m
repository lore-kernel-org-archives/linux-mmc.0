Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0B54767;
	Tue, 27 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776840; cv=fail; b=bFoZnM9vxUh3KsCS64SPSp5P6p0L7C9kIePBZKqh5pFlljJWjNm+g0stv634Lw3K5eS+9QA1iI67FcXbIEQjRP6FVmfcEHNZIMJCQpuMyOGcpMC/HOmMfRj96UGL/veXNyXBMa4GFa7qprlN/SGWgzkKYOf4OH80UlIEw24Xohk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776840; c=relaxed/simple;
	bh=YVhwRvoP3Rqt0ChCgPgHI6TFC4Psg5pDkYXGzkh24fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHrqzw4DrZ9aNtg8tqYZ52f5QH3Y9CReKEfx/HcN88BitX7P3SmhllFwncM/l275Wh3yvlPIXbe4iNR2JHXNqRKU3LuiS7arH2smgB1a+ZoSpGz4E3pjAuWC/aOU+OvNxuLpyoxfHlosbFuOfMgY66HDw5p4AYPKzs0SqYnv8/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWHF6ACA; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWHF6ACA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD0GlrhCAUZs6Eq6jqI318DYeu5BCWZVB/gxEI9BUuxlboQPlIFwrSv5eGetQTEmtGkfvkWdNadc5+p6JAmArdTYzr6ZnDYjhGP6sH0kggPA4f6WrAD9xbhOv1juTZi0j9fp8+JtcW1qx4FXUJGPhgrR6QFzqP3hnZ03d6aPllIZ1Y/sVejKGUPi6OB0jMSZJ5jnqBsPuPySClt/mYN7WKboThkCWfb+k0J/MqI+4XZYtinAsIc4UXRW9GOh5zcbwa2U9Ez/mbCGYVCKwuVgpIhAkEJEnzOsQ2+rK5xFkyFpAro6lk5ERfpkICETkG5Lg0G3jWYdV91HvWFX0Et2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4+P/mHKztuqkitojcO3t1/1PS8b8dRl3dIHUcjjYsE=;
 b=G4HozZmTuHUEUhUCtap1TK4xDNQgb3JTtvSiOcUs56dsb4K3FJ1cvYQBWGoLJuzqYyF3nD/KeaZkda/ZE34Neo/68ESugBjuMNJHpjijvIMzJb5TBROzgovc5ci6mRHmsPwOw0CKEnbnetHzqGgpWSm8LYIKDJGRFmaDZ/WIN7HOFJdpDPjYOKc8m69sbYrmRW7sez6g0mv84TSKOooxEZ3KDFqUBCtpSnmSGDTH33BpWMUg7muBMWzfmwvWa5zyPxV/bOATncUVXa2U7f+Bc/gtaoYwsL50+8ea9Kp+6b334wb29vaVJf93PCNFGN0vT6lz2EJaoP2aiRXbFRc9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4+P/mHKztuqkitojcO3t1/1PS8b8dRl3dIHUcjjYsE=;
 b=KWHF6ACAQpMxawA2ARv2HMhqr7wBOIbqNrvy6JthtzeBRja3MTE+pE9sjbrSOI155/xK1Gt6wFjiLE1SgMoyit8qlIjvVJkTDj4Jn3xqj2/aPY9Bi9uMdLn8ibilcLSuxyW2I2poR89F8p5MBu4UJMj28ul65YsYya1t4yCifg6rECyw4/Xq2hUAZBeObPXGOWjq3PmvSe5555PosKoIS9qGID3MkOr07BgpmLDizg4ofZW+5ruZYKWWbHjZdM+vQBTaAkSF9FUXUjh2rWC/n37W3CZEIIG+8YtB8mEBV6tBJgdDYz2EtDjl9x1Hy8oLvLViUd9U6HLZjSHHBmw3QA==
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 16:40:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ad) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 16:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:40:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 09:40:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 09:40:18 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 09:40:18 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: Add hw_reset() support for BlueField-3 SoC
Date: Tue, 27 Aug 2024 12:40:16 -0400
Message-ID: <20240827164016.237617-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
References: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aad3711-3c0c-43d6-b3df-08dcc6b6f916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/u5opN5aKtR2nS7sU0xGW/FpLbYh8QtecijGJ81Ka5vTYWWzdc4iSsU6ROnA?=
 =?us-ascii?Q?svCpSo17l/1yvBC0GQDG5O/O+rsd2e98rO3cvqezPOpk6ST171aXrIuj1y8V?=
 =?us-ascii?Q?I9Wu2vv1TjjTElhIFoVjkxNOvFZlNHFAO8yw0gE4Dy484OegSS3T3AGv6bKm?=
 =?us-ascii?Q?o4PHVHX4yJ+KBtlMKyaT6GJMRcVfZsIgVz/s+/J9Q7IqebbIMGXyYUjkZFd0?=
 =?us-ascii?Q?XgnpvfKtozr121GbODP9w7MfXpoMIOM9oL2pFSEYt2s/AIlODW6XsR0GagUN?=
 =?us-ascii?Q?e6mzk+Yx6LM/gp9CyMbZCmOTC8c71XDnbPUXlZ57gMxn9I7HZslpxjrmOAja?=
 =?us-ascii?Q?9+l2AuJxkWnXzbNf1YE+xUksTJYCFU2tQbK0RsrvgPhcLBFKVfRZEa/Hdkwh?=
 =?us-ascii?Q?9fNdWxF2abPNoD6fILcDNw3F1V6akmEhFSI5wYyHVqokPmCbVtXYwP3Txbdc?=
 =?us-ascii?Q?9eAm47Glwmw48FcB8UJ2fGQLCemBtO+r9ox1JGOC4OzyH87xyH99V6dk7mp7?=
 =?us-ascii?Q?hul9UaNxQb0NTS6FMr9UmkD71LFuNamuce4Mkqgom5FaqHV2MUwzqf2AS6e5?=
 =?us-ascii?Q?OzMkZ8gmpy+ifqYy82ax2qh0t+cwLaDamcDQSVXP3DXWE8ml3PEiwmUj/U7y?=
 =?us-ascii?Q?NYtSmM4Ll6E/rG6uL+uqdOAB7uKrA3gKtrrqowUKUmJUFB1ljEVcU1EX2c5t?=
 =?us-ascii?Q?3hwJsb7e5byNLsSENnJr0ObInU0HnK6upHnFl2glDafUpC6Co7Kp8MJfaXTX?=
 =?us-ascii?Q?OIAQiGIblK6fhMu2cxcjLW9T3SSd4XmP3N1kJr3W6hXXN8B/+57SLRKQhVSK?=
 =?us-ascii?Q?709+CZMidzVciiyLecphwQdm8NKbOaPjthVjQUv0/wiVXuh8tOnPjT7EDDyw?=
 =?us-ascii?Q?OydLaYrl1ekEWSePpwJgxOLbg9r4EvquG7KHBXbKJGCnG57jUaX3lhP5ZIlS?=
 =?us-ascii?Q?Uu4r/1M8TV3p7qZ1ypDa0+ZpQP7zZfj3pjsDZ/VmGWT8UB3giiypsmuHI5YK?=
 =?us-ascii?Q?cE/vte7E1U5xiGQzFGOVJRVo3tzdFsU1ahABk8hFXZE3y8v7NXLLoFUITsqi?=
 =?us-ascii?Q?lvSrAyz1p2B0vBC5eXkaWqLkLqLgdzrE7zkI+RB4IVz+jaOxjOrl5w1q8ei5?=
 =?us-ascii?Q?W8xi85JzeLBTmzsm5g15W9x2Ws9T2pPzJzewZ0+OKpZHGxv2LvCeUgFDGA48?=
 =?us-ascii?Q?pHlVkrLEPe5ZgrvZiPlOjdnE6x/zh5+ZY3qq4I1LORkPkRi7h463UvXXP3K3?=
 =?us-ascii?Q?XPinRgxxgDvPF9AEdkL4M8ZmG8bGIpTQDjL+pRLVYXIXr192nMdetzDlYAvJ?=
 =?us-ascii?Q?cKMbNuuZq61fg+buXymOrdYPAEMvEKuo2l7azEQyT06uKNWRctSJyW/cSg6t?=
 =?us-ascii?Q?stACINr/wm/2MaZYdPGU5VYwJZVArzTCAvpLK2k+0QHd4UvRX5r3A2TxOw0N?=
 =?us-ascii?Q?87nPCQO0Uy0wvdx29LxXSGsfSNxx2K6v?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:40:34.3567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aad3711-3c0c-43d6-b3df-08dcc6b6f916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

The eMMC RST_N register is implemented as secure register on
the BlueField-3 SoC and controlled by TF-A. This commit adds the
hw_reset() support which sends an SMC call to TF-A for the eMMC
HW reset.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v1->v2:
    Fixed a typo reported by test robot.
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ba8960d8b2d4..8999b97263af 100644
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
@@ -1163,7 +1190,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
 #ifdef CONFIG_ACPI
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
 	.pdata = {
-		.ops = &sdhci_dwcmshc_ops,
+		.ops = &sdhci_dwcmshc_bf3_ops,
 		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			   SDHCI_QUIRK2_ACMD23_BROKEN,
-- 
2.30.1

