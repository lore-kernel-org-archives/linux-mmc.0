Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339541DED45;
	Mon,  7 Oct 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294894; cv=fail; b=sNdRa43kd4tftUnqVvUAEVDsF3MMk7QQG7kU9u0POY5rBN2Vq6X5t1htI1s4XXL3nCc5uPMYbdUtZ6i/SnfgZtpAwIeIPLzARY71ZQCF3hA5fKTtj8bUYfUz1gJTGKg9f58F+2zrS/N1TtRkz/NTuuSzRhd73RQUBGsG+uqTxGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294894; c=relaxed/simple;
	bh=fKvRmK2MvQ5FL2X5jgo8uhtsCLOeUyb01Kah5uwc7+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FDQ1n1wDQeqqDbPG2+iGbgElUPfV7dGXyAJruxZ9XkOlLu2kKDiPPjiBO/Js+UiIyevmrJlrLHQUcFrYT8N/hig/Le+aD7fFOVOBGkfzgfcjfsnMnk7/P06p6HbbZew1zpM4Q9wo3mNjXQv00BOHCDbGPu88rK05GCw0ZL/14xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u44/jTqJ; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u44/jTqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKl2GzfcQwYBVUId+mlEmWgGasDYfbncOwRRpXuq91PUfBZMWOBKogc3tTQ0wGTrtVgGUhyWrfpP4Wylk5WlE+RyJqfjou4TkhCGBo0QTZxPNheMrTrvS18c662Oo1L/GckfSGthvHbARhWVks9t1MPa6hCbIHh/OR+FQGLxQJyAL29ms+/18syoLSn3XBaWqxBMh0NqLIq1ADMGONTtXq26hX0kYsn+BV+wUoV0lbs/cgtXOqAHT/jGDnulFd/Intyerjo229RndrK8P0StefUX/blXWrbQavkzMnv3WFldSgg8yZ3JuPqSbokqYaJBZygECa5wLCuPY1Q3Mz0IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TloFZgLuc71CGDfaUIfzAo5GkPpXsnKYJAV55Cv6cpQ=;
 b=P1HVAE+/PchlciFFK2pcmZqvAUbyXWGR9DUMl+lT5mJcKuF7uUYMGOx//8W9/gQcIBKpA807IYN9yWQA5suI4eOrHVQIzf/CbrTq28sqoXJmW9+T6YTR484+9IwSTpFy2KyfiszhlgJfc59hLPOXjlVnI+7euOQ1bU0y/H8Uh7J359yg5XUCNQrVO0GFXWp4jPtXpVUqkQmjOiy7LR6nnoR/LQz6dRRwThmuPTUG1ewY+QAGxC4ka2toRGkQQzI39tY5V9mPuTV6QLzMP2Hilpz8c+C20TP/JxgUsN0cmvy+zYAHPuKivFysAVcFIFCS+IPZXIEwzKqoDypq7GwiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TloFZgLuc71CGDfaUIfzAo5GkPpXsnKYJAV55Cv6cpQ=;
 b=u44/jTqJCikPdwCYgohddDfjy3D/pOPdMS+6+grYL048w8Bs2s30hMfUOK+vLP+Ub0CnYIMXl4M0YhZwPfKSYmv5JWVS7wZyhUmAzQI0F4L7INfG2U8HVKUMmSQVAbvkeCg+saGeRmWHQkUjcWO9ezCvxd7DwR4Of8lx4DvqQlU=
Received: from CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::20)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 09:54:50 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::11) by CH3P220CA0010.outlook.office365.com
 (2603:10b6:610:1e8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 09:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 09:54:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 04:54:48 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 04:54:46 -0500
From: Paul Alvin <alvin.paulp@amd.com>
To: <michal.simek@amd.com>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>
CC: <git@amd.com>, <alvin.paulp@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-arasan: Support for emmc hardware reset
Date: Mon, 7 Oct 2024 15:24:45 +0530
Message-ID: <20241007095445.19340-1-alvin.paulp@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alvin.paulp@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a43bf3d-d2d2-43cf-9a84-08dce6b61589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ofKfaQBrB6OlhyYlGB3fULUdZDuZ6ROphvqpZzaFRG/ap4eeub4QlJuDTjVy?=
 =?us-ascii?Q?fP0IbpieWDA1ddRG0tSPTWh+U4PqBtJD2wmTPR/ff6MEXlY3Z3cEduggPZ34?=
 =?us-ascii?Q?zkuAmUcXzsw7q+p1ZDFIOnMj9lar3snq8VCoHcSFH3HZzPE25Fw227NGonNH?=
 =?us-ascii?Q?OtERSYn4nxqvDSJnCz6SeqTM0wV+jpxzHAKVU1QZf/NCWNMmFjwJrkbBLq+W?=
 =?us-ascii?Q?dxzj8qxUX2E9PGGNJlRKGq34c94MlanMZj4BnaeYZqMnpo2L1YcduBQRobF6?=
 =?us-ascii?Q?fuMwS/nQsj6yLqkZB+uvF65e3eFBafN8LcHBDvncv2Zcn1JDXp0BxZXMQQme?=
 =?us-ascii?Q?4W4ujpK4RSgDGLqKrDcE3lGEUYZHG+JtejSOTbaM9BDdnvdTPjYm8+B28wM2?=
 =?us-ascii?Q?vPpn1pqnR8OhZhEsqZnrQRq/60XHwh1zFWfm5P7DOyWQ4J2KDtMK5ncBKWey?=
 =?us-ascii?Q?1d2d/kP4GRw52gSNTW7TQB4bQxWE/MpLZnApDrf9HvNrIN0QrWtb/QOXEEkN?=
 =?us-ascii?Q?FR280DfdmiPIxrATso20JQt9UbjjXsUAqZ6E4y62mxCf1BZANkuu+3MOvA6R?=
 =?us-ascii?Q?pYjok5HdrEt3fKyEJiOGIrDCE9YV5+T6L72aL4IXNf/61avWLLdrlaBc0OQJ?=
 =?us-ascii?Q?RiXg+TRnH2AUaksWmDquFDUTfoHmCwO6w0YZtuz2NGfGmjZ63hXI13rSCeYi?=
 =?us-ascii?Q?qOB988KPwL3oHHvqKp9ZGe6NRkhlC6yZnrCkkbbH9juB7+evtjY/uN3wkBhU?=
 =?us-ascii?Q?OCi51wcYa7oOsVmqjRVM4B78lbiFqU9k7LHXKspuC2K7Mc1si9AQaiG+nqnw?=
 =?us-ascii?Q?K6zlv8kUScWOU26TY+WU0Y+Z+sV5OZ1RveB5leDR7EXIgkaIQccNmPP7FVV5?=
 =?us-ascii?Q?ra/AN0ofF7xt8nWD2laiIcU1U0TG+RIyl9yibCG+56J3CjTrQAfEhSgO4vr+?=
 =?us-ascii?Q?aSmu6MfjQaFzaqSujXdX5R4f/E1oYMUG5/aWPhBis0N4VIeMVPzaVoqh+fgP?=
 =?us-ascii?Q?QDGpAQIZcZA3S/lbrhhkGaSHiHqlNWz8Tf06vmGfVmp1q8HCqoeMNo14zZy1?=
 =?us-ascii?Q?JKjgapxBwVtHDr9rxI+xvEI74GPuPdmompJoWWw8uV3HjOPQmQ7Zi4+/c8L8?=
 =?us-ascii?Q?7ssx6NiLwhd9Yodb6leBoF7f5PLW2lF+ghh1IySmPEmKDplktCLWr/4rk/i/?=
 =?us-ascii?Q?bcIt6eZesNUeyLhu7XoByhn1ctF89920vM49r+s9FBXF+cXPE9jWRVMbEQzj?=
 =?us-ascii?Q?4rQt+KE2ta27Sm8+tqFeKhbRLKCN4mCsTestgD89ge2sPj9iqdhlr4MzfIZu?=
 =?us-ascii?Q?yOu8yQeK1Cc5Wta1M4fbxr47F4l9WNITmwHQ5AWdPaasK5UxMoRf01rUIWgh?=
 =?us-ascii?Q?Z1EK97RKjoddBLm+kpl6YiVvYleq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 09:54:49.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a43bf3d-d2d2-43cf-9a84-08dce6b61589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

Add hw_reset callback to support emmc hardware reset, this callback get
called from the mmc core only when "cap-mmc-hw-reset" property is
defined in the DT.

Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
---

Changes in v2:
- Updated the CC list

 drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5edd024347bd..0cb05bdec34d 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -76,6 +76,8 @@
 #define FREQSEL_225M_200M		0x7
 #define PHY_DLL_TIMEOUT_MS		100
 
+#define SDHCI_HW_RST_EN		BIT(4)
+
 /* Default settings for ZynqMP Clock Phases */
 #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
 #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
@@ -475,6 +477,21 @@ static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void sdhci_arasan_hw_reset(struct sdhci_host *host)
+{
+	u8 reg;
+
+	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	reg |= SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
+	usleep_range(2, 5);
+	reg &= ~SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
+	usleep_range(300, 500);
+}
+
 static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 				       struct mmc_ios *ios)
 {
@@ -505,6 +522,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_power = sdhci_set_power_and_bus_voltage,
+	.hw_reset = sdhci_arasan_hw_reset,
 };
 
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
-- 
2.17.1

