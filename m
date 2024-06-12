Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAC12D1FC;
	Wed, 12 Jun 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232785; cv=fail; b=PXOQHozIwcBK03zeoZQcvvRit2SBbPxG2wq2cjt+8ma/jupWPakdrp0WyWCTuiaPDVi8T0yQUB9OM3NyVlMtJq83Fe6IAslEiFFc3BwjNNy74mIPgY2H6dq9YXkS9mQlStns95lfredOOfeRKTw3P69GjMjh7g+brQP3nkbv/S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232785; c=relaxed/simple;
	bh=rwQ20bLJ5w18G/1hkWCOGeSauaJhDAb9t9KhuJqXnhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAR7I18RkvvmEV9cc0BDmbzVzWrsbIem+L6eG6mUi/jagnQeptMd5rqjRUVASW0SbawurxWnq7a6qjzPm61vWiN/4KNs/JG9a1SeBsZIYwEWs8+OHPvJylp8ImcmCWrGRQI8FKDIVLVDbvO9Fh5anbvEvrqilIdijrRtHY14RrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SD6mSZXG; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SD6mSZXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3NNric9JPMRQjR+cTJP1xwjEI4nMJMWQFCpbO20DWiAhaPeCI3dgUMqwB7cHYSxetVPEBL/Q3dY32sDCK+Yoapvb2m8p3FiB6wTlNjSmitDhx1+7lGcyZnNF5pvFrlbiU5hKHIaZD6MAhj7BqOya7p0jbhDBY62nCje8MNbGzX6S6/XcRxsjHhdzXFxDelZaSIJwD9ctqZ18QB3JA4ONUetF8aZsG1tYhnesf0L5O4Bxzbmhr+DPOOR1olOn96XX0tbvRORNO94wheFa+pOf4/YavzvZOL/1ak/5W5AuZmxHYxP5TpcaePfTCBDj6hbE/IkJVLtcurUyZZBZbDxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rbGcYsUfM+HJh4x57J+udjA1dowxSnQKISRUnFX2sI=;
 b=YvSsMQDOmwE7zVevvdGUwA7uLNvIJ7gHQqBUtSjjjAb++V0zB7YMNT6lIoWkTjNrPLaWoqVjgZLZ9ENsknI0pQIqQ+CtITzrM6cLH0Q6DgRaLB/j6vfWRtl3xzwIJLivGe3iWbRHptCM7CaA9ZBO/UFCifOIoeypGj0sMWgb/MI0VkNjkEviCktOnf6kvRQehSNn0Yyx8twRte/IJeQ1wj99jLhctoDHoQaDBJUeDwe522AnAZWM583xzR7JQCEJY02ky7X0uWzd13pH+n5a7Njm51Xcw8k4YKNSXyW5Agx38r8dng0j2q+CpSzrLzJh2sIkBIX0Gswqjdow8ETGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rbGcYsUfM+HJh4x57J+udjA1dowxSnQKISRUnFX2sI=;
 b=SD6mSZXGMKTmvylDp2sIPNOXuYQ5o+7nla3Il40SW9FWgfcVP6Ui/ieHdpEe89bToZpaSD3kBjFfDpLQ8v85jj28XgnksNnbP/tw/5Pt1CK8jKGlnsgY0BUVCQfVQusJ8gLMOAEtuSNdSynhPTOIYDUHH6FvHgcopCCC7q+Ims94wo4b12BlhEwOV8ziHGpXjg3ISYQM5gNwz9DOaAAGf9YZZ1edOsPsd+3T/5FPHqnr5BpSFErDgEW9L5uRu16RBiB2XPcB2c7kfG5o51lsuHbqdRUGR1T8IimmQrIxCVlMwOOeH2x7/4O6FVaZtJpIjADsEIMSj+OcN1dZseCenQ==
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 22:53:00 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d3) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Wed, 12 Jun 2024 22:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 22:53:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 15:52:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 15:52:51 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 15:52:51 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
Date: Wed, 12 Jun 2024 18:52:38 -0400
Message-ID: <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1718213918.git.limings@nvidia.com>
References: <cover.1718213918.git.limings@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a7f900-cce9-41ac-61bb-08dc8b32691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rVbjBIRVSFZ5ldO+qY0YaAZ+zmcfL+P3aZI1Pcow9ieoAngRuJ9m8Pzls15?=
 =?us-ascii?Q?WoNjL0/oZQjHCoypYFALBT4u/n9+ipZABGhdu+kW2VMQU9BQ9ssf7kia8pm/?=
 =?us-ascii?Q?Eb4LpJfzZyYF/8esYZcoiix/fXPdx/HjHAHORY3IhnIo5QooF7V6MkRtP+BH?=
 =?us-ascii?Q?JxT7lLA/oHdfrrykbkgEbTfZ/pm6HaNKq8QkeAzkKaIgJai8bDH44Ei4qx0Q?=
 =?us-ascii?Q?604PH1qQ6WmtpS9WTxFSpxogGRBwXR0mTrk+UsgTGjRiwE4ShyHkygqYHDVM?=
 =?us-ascii?Q?le4fB+FZBSzPdRuzwpyNVToFeHHhJU8/tV7fHruZ5De4eqNGL1EgTg2irJdO?=
 =?us-ascii?Q?3BmUYXc4JCt4+HlzymDw9lreZb9hYUq9zhfYvqfavuvwVtWSbAnwHNN6kz00?=
 =?us-ascii?Q?wjrW26+/Fpd4ndUQHVccOJ7dxvFHmysOcU7ROkP0ZQc/jllXjOKqdBEDicji?=
 =?us-ascii?Q?mfzRM4+Z6GsX/nFsa/TJZ46l1cj0fID/NHBWHEAn413/6O/iQITVl632lWcg?=
 =?us-ascii?Q?W/dPgdRdNEj/Zs9EQq3il2BfXuNeqDiZi0zT85iXa3w5gE+zffkUEAwO+J6Y?=
 =?us-ascii?Q?elOHLEKySXMMKVB3JxCRaTSLNtCb2Hxh4W70/rYpOuaTPRpbpAQzcZdNLl7N?=
 =?us-ascii?Q?Glqlh4YPYI17vfsf/7pWPHApsn8gMoJvq+tpHf7S7A0WRIfnonHL6ukfrWvn?=
 =?us-ascii?Q?/dCMBI5o7QuVdeCoqLBeZmjEpDV5e/Z/PkhnXzkR3wXXrF2lcm1hTUC6EFjT?=
 =?us-ascii?Q?R/Yix6yugEoqQ15wMZDh2mGWIY20E1EUT6/58uTXVeWcayUzqi1kk96JAiTa?=
 =?us-ascii?Q?Z1zjSUuLxaw2ZeTRU6uw5sC+qB7guNJra01JiPmsQ38LXLFeDa2tVPdnNa6b?=
 =?us-ascii?Q?+h1y3dFr4GBQZFmI1B3jRaHtJhOORB8q6DRgxex1DWbquYSSc3umt5QO6BPX?=
 =?us-ascii?Q?Q7u9ez660y7yCaDa7032Oaf9T7M8muK1BHzCBVI0jFPnGhR+oqzKobaDXQJj?=
 =?us-ascii?Q?3gW3WNT74GB4dgkB+0V7qQfMESYZPzsoLBTPHDG0ElCW/AL2KLXCuJlw3y3d?=
 =?us-ascii?Q?lQv4lKyfc84LwS8xJqNF0bwkqjhxvYK7oNsOB5mFVgfX4lD6s350nQrMs5ld?=
 =?us-ascii?Q?UoGtwGu090q0mf3MFTgrvNCeV6pNQhkIJWFYHeW9SplL7h4ihBWAXZoS2Mu6?=
 =?us-ascii?Q?EtLXlds7ab/kez36e3ecl3RFDDB7mYRsiwXC9wNgcPrnJY5SyXBq3WPZkstt?=
 =?us-ascii?Q?4njpSwOV2+4/zuDeSSWPTnTvhCbU/9G2V+j29BFviqgZ0AWdarSVIoj46nWd?=
 =?us-ascii?Q?Yo5UIchKYbXp/IaF6UGT7CfdJIeTIeUwkY9shGSrJMcNm9U77SNMo0QSIv+b?=
 =?us-ascii?Q?KRmj4/woZJnaM/XBSX+Sny3KSqv6vZ6Xy4tOfwXhVb5zory1rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 22:53:00.6651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a7f900-cce9-41ac-61bb-08dc8b32691f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

The eMMC RST_N register is implemented as secure register on
BlueField SoC and controlled by ATF. This commit sends SMC call
to ATF for the eMMC HW reset.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 4747e5698f48..24e0b604b405 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018 Mellanox Technologies.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/mmc/host.h>
@@ -20,6 +21,9 @@
 #define BLUEFIELD_UHS_REG_EXT_SAMPLE	2
 #define BLUEFIELD_UHS_REG_EXT_DRIVE	4
 
+/* SMC call for RST_N */
+#define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
+
 static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	u32 reg;
@@ -34,8 +38,20 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	mci_writel(host, UHS_REG_EXT, reg);
 }
 
+static void dw_mci_bluefield_hw_reset(struct dw_mci *host)
+{
+		struct arm_smccc_res res = { 0 };
+
+		arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0,
+			      &res);
+
+		if (res.a0)
+			pr_err("RST_N failed.\n");
+}
+
 static const struct dw_mci_drv_data bluefield_drv_data = {
-	.set_ios		= dw_mci_bluefield_set_ios
+	.set_ios		= dw_mci_bluefield_set_ios,
+	.hw_reset		= dw_mci_bluefield_hw_reset
 };
 
 static const struct of_device_id dw_mci_bluefield_match[] = {
-- 
2.30.1

