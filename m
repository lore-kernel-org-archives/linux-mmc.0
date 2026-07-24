Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E68347514;
	Fri, 24 Jul 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879842; cv=fail; b=kpo2zjXVKfDyVvVgd+q/wl6lSIpty9mohnrNNOgTEMcKqvwMAxfTSQDLHiRPGHOJqaZDWr6opHvJWktHLIEeUqFBq2yaw0y/ZvFi8h9AssyhuuTds1Xbr0SKO4KP5voeoEI6mJmYlP18HzsCH1/mhnycZY80LXWH/7W+mTcyZA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879842; c=relaxed/simple;
	bh=JJVn2l8Hkz5kSa6B4EHNk/L661Gau0Lmfj+9rBDKJjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sprty7E/wAo65G/YaanCbNuvZNQ00hdJlSWlw1KQtROYUGnIlH15dV+N6/OBvjvTqbbRZ1OPLT0jJ42wjBoyTf8NIKmp3r+lwSHANEEiQ3AAEH7R1TEpyTmN1ovnp6oacSqPoPaCXGhsPC/fra3Q+oGpKoq7Ilu+JTT+V2Qs/Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tl44FrzW; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tl44FrzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIk1tCCUj8XxfbHwo/JbZ/wsfZyAVZK2L9af7WOYNw8FeLLLVi3NPNhPzn1LBR9/OVhwRq6GZtIs//vl93aehpoP/ZY1w8TpFiAvTUEvdCpSMmrOaw/QCcprWYxTT1CeqZj6vbKyXebxtq0OltGa/B0wzITV5Jd8xdjltkP7Dr+YdPHP6PTXPqWrKSyPcUa4tsMG9DKLm2ibB3W0uxpPv/IL8MmWJzenFhozR2f1LsQOFc23PG0EOV682D3A6FuDF1uRoFE2hrJY43/fkPY9k/Gsr0w3/wvgqFgyAMcPeLQn7Z+XFvvI6pf7Jc9+KFIzd/S17hC4/mPml5aIPEvEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eFDaD27P2CdqfGgH4UBwKlHgwpRk/HlWOeOrA2cDus=;
 b=PNYiCq22M0nAdChfe2wk8q6xM/ymjMmSjliOGpyhSTTOxmvGkRKUqfPbhlYKVVoPXQRdAab7KwNNrxvvt+DOdnC/dfBsxMHdgBUYpPp5Ybg7sOpevSEHYLZSEB8Y3DaU8KCP4EhCUK1ruO/3UnsuLAhI0q11YGPbsAT2/gp/SYtU2G/VzPozTnNWoExAZbC7M43xm7z+/ZNBLDofdLVaiyMN9ObpLBrM1B/o5Qcq5tktJ0NUgXBxxjN306oi6/E1WAwUtegkGc60fdLmFq9byQQAXacXi8ebRdAkFVM70XG8pX77wOWiy9/Rcp1SvD3kTloqDWWLEqezim+B6c5BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eFDaD27P2CdqfGgH4UBwKlHgwpRk/HlWOeOrA2cDus=;
 b=tl44FrzWbQFA5hBzR8APEohVq3Td8JJA5luMEhvwArySXe2jMFUDM5LvGj+ezRacM97rKzb9dWuv1cHVsKVXJqvxHLKVXQEeM6buvzcZFde0XQYjSVsxHMvUP45KcsinHWPKIq8wivaR+3CgJDUB86N34lsnn+YTU/hvBWu/YyQ158LE8Jc2Xm4fuq99Zm5qp5EkpBYrKdZGr9WJLunKx6RLP64u3eOZ0gF9F9wmS3UCA1W6PwH9XvhAKoxp8wdeXbEFMeKfCcR5WHagMOjqnNDBmZAKD9b1DKnBrJhdWkLZTXWF22I/+t5WBpXpEGg8D97sFrw+2U932lsin2KmJw==
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 07:57:16 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::31) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 07:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 00:57:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:08 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:08 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 2/5] mmc: sdhci-tegra: Add Tegra238 SoC data
Date: Fri, 24 Jul 2026 07:56:56 +0000
Message-ID: <20260724075700.714261-3-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260724075700.714261-1-pshete@nvidia.com>
References: <20260724075700.714261-1-pshete@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: f348ed5e-b78b-4171-eda3-08dee9592dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+y6k++yZgB82AYeualjOg6g3fptwZhoHnhVDwiOxD12Qq331O2myMGIe5VuGBS3k/HusAEubMicAWnHY6yXKUzO7NtpCLTQFtiNo8vZmOBMIMDg4sfGqH8hnoJ1R6ehP85almS2zodxcrLRlsmTJxeMwA5imSP743Ou8swy+nFovGQ+xSHNE4hWccQc9ERe9KYNmBDbeNhSCCjTWRcl0kzvAHgAXGspssJ165ZIuIbdug6rL6Mj4mQoPME+6+YrvNcvxqAFEIIfwwV4m/zIIcSKvTpdlkmoHaEOFSCMdJHypYVzo4mrCCPaWN830SYRhydBNX05LTINOQ7hZ/q1cbUyuCZM/JHcUZ/tjxivGJSlUkVwXAIpR1swgDn/2L2HAHeuO79zM4eLlIZCSQiLJHrn+z2UMobZaxHWKv2a+kO5ekEr8XjW/I7mPQ4i3Zu4bTEPCUJAW9EELhhGm6bqCm2ET97YAH0hUdnxkk8kehkibZmRajmfO8DXeU+h7OEdCIuMSgKDaHLR7f6SkYfJYlNVTFOHJZZNR3jeLIUSicb7H3gjQ89upIO5EBzoYJsF3y4LJSzm19t/9fPsoJQlB3MUzCVcEawJdbnOQ0DrpMfEId7BfWL6TAKSPGQodgP11zv3LubO/JHc0JPBf4e0se6ZOMwuvo3NzJaIp3nt3yiL53WWOij281CGD/+sVd+F80gx8PML8UtvWPJhsUv8Lvg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RKF4QZuHzy+nibqskgG8JZgncZs3Y1sx9ne0PUAck1C4ajXsm2xSV4008QoGgPM90lQ/70A3q6pBbq6SqTVm1/5TF0kn/uFTJHURNqsKu2duNsYp5KkBYIXHGpe61Ik5vFqHqNh2zz5NDcG/l5nltSWn7L7thitO6i86ENwYcuXycTDKJw8VYqA07sYZZ+mJ77iMDENtZ1jp355/nj2XGZuV6bJhmb++VXqiu2jTagGEHY1glEt7bDSn2+qhOwcQR5l0JdbM48+LhpMjBoBWvPyClkGkzvxdGmZ294ms9S94relxHBwD2KLab5nh6750p4ly8hbXGUsxokXpGK7nsxy6NW5F8/JEzTeA1bjI95dWQa/OaFL3boyb2NAZILUX6e05WkuBzehBmHKzzlmpgFD/wGC0rYrzhVuphSKEKpoUoFmfNAhWT27qAG4c4U9d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:15.9091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f348ed5e-b78b-4171-eda3-08dee9592dad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF

Add a new SoC data structure for Tegra238 platforms and register the
nvidia,tegra238-sdhci compatible string. Configure the supported
features and tap delay values for the Tegra238 SDHCI controller.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 221e48b59f48..5fd900ff9eb5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1572,7 +1572,22 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 	.max_tap_delay = 111,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra238 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_PROGRAM_STREAMID |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra238-sdhci", .data = &soc_data_tegra238 },
 	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
-- 
2.17.1

