Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC45BA45;
	Tue, 29 Jul 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771553; cv=fail; b=AImG/jiu6OMlwg4NZeCKGhha038b96Ct7PliWlhbVsMlVUXh2RdOyiuCBY9gnj6wds4cmNy8cOIpYBr4lwE2zy3kPsw6MhClcPgj6RsX4TlOpJ8kYTqTWNGBPWhbJaHanQ0OHMh+bFwZnfmtn3xw/rIWDHsKqvbJcJhTHVspUVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771553; c=relaxed/simple;
	bh=i2ZXHzdZpLK0FHcetQjM+hpl97k06MOUhN0RMlyWjzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdZ9P3s67GDeikjuVwrxzBJB6G7lykjKeULN5+RPjsPIJYOcaVW6mRBNKd6JA5DrGNs6gLbAYDAr+fIIXJvKdW3Y8JOE4Nx6E4jtBA///Eq3S/dd3Avv7tofbuFP8fhG9/x1iu6MPeGfnel9tDNwZ/0LnzN7KFIEXHFet8PFLyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBUUSRAR; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBUUSRAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3ot6C2It3zynGfvCkSI4kmV3d7kELx4K056RJU1BkbOF1pj0osFfyApEaboH+aqVs7B7IudGz3zniKkLwLKv09oFSeXAZqhBKxONFNmuWAPzJ/xxXKnM/bKqsA0GqSUZoFbWEf93zIedHAKRgZxDlVHU+5zTwqoA114xs8WUsX4CPvcJ8aUO9pzQFimP16LUqVCZtTyMyuJbvG3sJbW5p8mI0usXMmEjrjwkVd0EXCaSiA25bCjwqA0zV7r1DquxLDR4zE+/eQ2WlHIWfMGB5fEB0ip+QRQl1wDX9/gy+jZtuPpxMw/phfJbbhgNZAZGj+yJbIPUzU/OYITsen/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Ac9dp8V9tjSc5XCuBlVXRgh/DNt7pNR6m3/h8QbQ0=;
 b=PlIqYBbp32WxS5yZdk4vkV1S17pVgog9yk6Dk0XlampOfw2KInqmBKRbr8njY5dk63weII3bJlPRTH65RBTP6au6Of9MgHuUAtUCh70YbX6m88A+jsBlnheRinZq4fosK74HyHk9IUbP1PWb4ibZDiuzwgNZYyIj/ojeRPJtjPeBRQ0lh582Hr6RV/MsnBun81c9p7KBH9WhN/NFY8Do9oNpCPRhihkJBm4NDLAI2s4rljT3QNrkXxdlTbTBgLJXeqBeeMjwQkmoAMg/rTl6skdCBGP+pXvEzt7zTyiqaHg4qtjhjog6BfqdZhFeDbsrM35MfqSqkA+ISKwVoXOZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5Ac9dp8V9tjSc5XCuBlVXRgh/DNt7pNR6m3/h8QbQ0=;
 b=gBUUSRARgQnjcuhIVknvaoHGDT7iUdPhcBf7s8xIb7MROkJ4OEgF/whsgrmaHxCVnyK/ZaxJfRT77QhJB/G6Sfltp89kzV7aNfctbO/OgYvjcWTJILaBuqBQevu8PhsC15tTvrbG2y88Mi03ZjsaIGQ/TwoKjvu4XciYo16laCA=
Received: from BL1PR13CA0380.namprd13.prod.outlook.com (2603:10b6:208:2c0::25)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 06:45:45 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::48) by BL1PR13CA0380.outlook.office365.com
 (2603:10b6:208:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 06:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 06:45:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 01:45:40 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Jul 2025 01:45:37 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <saikrishna12468@gmail.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2] mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up
Date: Tue, 29 Jul 2025 12:15:28 +0530
Message-ID: <20250729064528.1426093-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.potthuri@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 79894a76-3bdf-4dc9-144d-08ddce6b8b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ha8qeqERodqLrCNzjveiWat9yF3dWIQMm9vbza4f66XO/lc+/By9c8KsM3+I?=
 =?us-ascii?Q?k3JSfeb4JQSI+XQnA9MreQ6ugKVLZj2w3URyOsEdymC6s9KG3FsIVHj3AUtq?=
 =?us-ascii?Q?9G06eG/gNfRC/Lg84Jt427blSwMQwfkP0zCuNypFbuOtPWq4Wu2tlaKQ7WlK?=
 =?us-ascii?Q?hEJ0We/Za8sbjFSYv9oRJC2vZL3cxfhZJlGIdm3ISFfswZwxPD8CmJPXaxNM?=
 =?us-ascii?Q?Xf35WWcIuV42rdPPMcMcPSN3xhO0oUfoSsmbolKkYVeFCRcV1B1ZtPpxZ21R?=
 =?us-ascii?Q?K430PV7JD6zf6Fnaea+6SzI2R1i1PC/RcUA7qftVpnp7Gyfnvot1TiRfXsOe?=
 =?us-ascii?Q?haJ5r3Y3TKzEs7h6dJh11gn3a60OPxlE4HmyxV187PLUGPOJjGdqnIUn7sEC?=
 =?us-ascii?Q?h2U8VPFLjxmnqxOxKlTN1HdHDAT7u/i1dWbjMRzPA5WiIaFZKy/RQUqi7h60?=
 =?us-ascii?Q?XN8vdVylQSL2+Ajnk8tCaIF4oN/Do4M63+BvyrMW1bm4b1Soid4bU8Jrhpun?=
 =?us-ascii?Q?2nBYi/UD9VmNAJPpLR5IJE4GYMwac2amUA/MI8nd/RlYAiF0CRV+N6bPGxw7?=
 =?us-ascii?Q?XtZsysQ1xjk9ewPuT2l23S5y/eKBdFD6PN//VkfQ1q7L0ZWsmRvVesV4pNQC?=
 =?us-ascii?Q?F68O61ssaLZsWZRd8MCprZ7xV55q4/2C6fG7JdMx8YpRHpmyN1vXuJKgsZ5p?=
 =?us-ascii?Q?Y0GqkfKOU7rA6XL+isZ3njnV6SBBSOWYNclpgsM4pnNwGMtaBlFtiWwnQq0V?=
 =?us-ascii?Q?13jIAj0QSu1Gkn1izZceumBThm51REmRq6gqZghYzwbhm+MMqg8F/iPP5+KS?=
 =?us-ascii?Q?Ih7MnERP0PqbxYOlO4oJKsYh3HKRHFU5P0N6CwC4rRsSkBFQ2MdyFOnpngEH?=
 =?us-ascii?Q?6uhcVWhmh+n0SmqzFIA9ZpE0wCeD7BPx5UNBXJvl5GUZozOE3NtVZRDtpHFQ?=
 =?us-ascii?Q?cks8ksA4NWbIWU5ssfWhcBX4SZmRR/PqkzSpcugLtm6XYH0vvdPwI0tRJZZ3?=
 =?us-ascii?Q?aPRKXNKhc8fJ/0Of8bu4DIqRvd4m2LOP2vPK0bwbr+u6Jolaumn5C0H0fH9J?=
 =?us-ascii?Q?yvc1KqjNpM+V5mXMg81PjxbvI9FoMDHpvMRhlq0Y7b5iOVpYCZY9wE7zu8fG?=
 =?us-ascii?Q?ifpVR1FV1AI029SfJcnd23NZ1vz24HptOi5D9mZeoW8/uuBBNJo113YRgq3e?=
 =?us-ascii?Q?Strm7gmmnYrBJZpZroOIctsAW/izLav36Sg1IBpUlpx+GPgcGuHZs+JcGr7k?=
 =?us-ascii?Q?MeLM24q30zMyqbN9DChKs/2IAYBmnpfXOmt6KpQh3PW0qi+FmXpKmnyCeSpG?=
 =?us-ascii?Q?ZjeOrQwKvTrOflRTied2VhLkIyf69aSLaWMu9ZBz62/4myFdtNu1VUVEVxWB?=
 =?us-ascii?Q?fV4wDdlJbkc8P8+cVdaab6VcjTUKrY9WA7n2zy59CxJ7NSsuMzK73IHSpmKh?=
 =?us-ascii?Q?tFk+RZzYt3+Lm+Nj845HG7w1RSqMpnzPUUjwRf221T7sxbwQAArGwUODZt1s?=
 =?us-ascii?Q?znOlCThRFPXB0vWoOvC66J5j19tLmVmc3YDj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:45:45.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79894a76-3bdf-4dc9-144d-08ddce6b8b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

During SD suspend/resume without a full card rescan (when using
non-removable SD cards for rootfs), the SD card initialization may fail
after resume. This occurs because, after a host controller reset, the
card detect logic may take time to stabilize due to debounce logic.
Without waiting for stabilization, the host may attempt powering up the
card prematurely, leading to command timeouts during resume flow.
Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card detect
stable bit before power up the card. Since the stabilization time
is not fixed, a maximum timeout of one second is used to ensure
sufficient wait time for the card detect signal to stabilize.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
Changes in v2:
- Use read_poll_timeout() instead of readl_poll_timeout().
- Enable the CD stable check using platform specific quirk.
- Define the quirk for Xilinx/AMD ZynqMP, Versal and Versal NET platforms.

 drivers/mmc/host/sdhci-of-arasan.c | 32 ++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 42878474e56e..86da766fa480 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -99,6 +99,9 @@
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
+#define CD_STABLE_TIMEOUT_US		1000000
+#define CD_STABLE_MAX_SLEEP_US		10
+
 /**
  * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
  *
@@ -206,6 +209,8 @@ struct sdhci_arasan_data {
  * 19MHz instead
  */
 #define SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN BIT(2)
+/* Enable CD stable check before power-up */
+#define SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE	BIT(3)
 };
 
 struct sdhci_arasan_of_data {
@@ -514,6 +519,24 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
+						   unsigned short vdd)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * Ensure that the card detect logic has stabilized before powering up, this is
+	 * necessary after a host controller reset.
+	 */
+	if (mode == MMC_POWER_UP && sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE)
+		read_poll_timeout(sdhci_readl, reg, reg & SDHCI_CD_STABLE, CD_STABLE_MAX_SLEEP_US,
+				  CD_STABLE_TIMEOUT_US, false, host, SDHCI_PRESENT_STATE);
+
+	sdhci_set_power_and_bus_voltage(host, mode, vdd);
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -521,7 +544,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
 	.hw_reset = sdhci_arasan_hw_reset,
 };
 
@@ -570,7 +593,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_power = sdhci_arasan_set_power_and_bus_voltage,
 	.irq = sdhci_arasan_cqhci_irq,
 };
 
@@ -1937,6 +1960,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
+	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a") ||
+	    of_device_is_compatible(np, "xlnx,versal-8.9a") ||
+	    of_device_is_compatible(np, "xlnx,versal-net-emmc"))
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_ENSURE_CD_STABLE;
+
 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
 	    of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
-- 
2.25.1

