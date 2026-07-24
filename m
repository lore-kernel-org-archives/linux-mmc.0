Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1F314B63;
	Fri, 24 Jul 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879855; cv=fail; b=cAu+BL4qtPkbLqjXoc4kF1D3gArf7sYvFUgriFc/pgJUrwYEN3tEaIJ7rnKeEElBkHq8DT5DaqYYBNw1vheaksQ4sffkz3bNOM1Ktxj8WstzSoDEKte8669yOAtY+Gbc+cHD4ibsIR1zzaFBEMKGAxmvuieTstIRK9OXnF0z98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879855; c=relaxed/simple;
	bh=9pOp38/GBRQrwx9avyvrpgnK8wQL2hw76fEJQZUFCJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipBKLVaSU9NuY19M/hgX2sPVsPdNhAahKZj6vzDI9lY4OpoUlkxf8xFqAgZjueIrQzEmyDTE3vZRhTF46ZO+XcwGvRCN1pzpq+u/hDCB9yjqDcwFkfgy/UMlvK6dJiYwO/kwTZIRU6yYb3gjcxuU1x93zi27GfGelFiV1VK5liE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZok1E0b; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZok1E0b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0S4q7zhOI5Gi2Akn5qjRWQ+ybPnkgSwV5yLWXDIDa3zGHT0ffT/e38KAVjod1CBB6xYb6GwMPSsSwbhibKzypQu4p/sMYww0GniwHRyokfNxSww5lyZFUv8F2l3Kj1jEXsk2n+Zx/dcD76x86WVvWfQmEpFAM8cc8YbvbYN07gmw5eSviKCwOpEOsjqmZmIQVoQ1u53t569GYmzUI2UFHcnnYlpVplqnwoYy9IZJ+ajG69tDlQQNjoMn2Zn77M4pq37dFHM/ykji62gKQ+3+C4fFypJLEFiPALkgFQ7MIGCffDC2YJfJ13ems0L7c/3ca0jrTqhFhguHePREF+s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44H/CKfm+3iPGeysXBlWG5rW9eHl2gAihmLha3xDKuk=;
 b=T0Ie36BSpWH1BZV829fRMyQI+tfyr+nU1Gxlzn7XBMlTOBCfEu6bXrMl7P1CSfsOvgJ8nMbFkld02Dwfzu5zBm2jbCgVvRobrqRE8/pfZ6lgQVp/NWAYDTgxf282FGO/v7v+BdNYAhs2whXiQq2auByNETT+fvOgD7KIWxV2naXzWEH0yRCllGljgfRcw7EMd00RTCJIlr13ayLq3Y3PALjKsmWnqAg36cWgPKrZJ/7nHQH154Y7fMDAqUdixgARV+9Uu+pGGwbDTxtKnLGGINPf29QTCHXe3hgYIJXNifL69wJMFJc0brxxTjkicK8Gnjg4VXanJV7YYOMqlOUtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44H/CKfm+3iPGeysXBlWG5rW9eHl2gAihmLha3xDKuk=;
 b=tZok1E0b9rlUZRjLU/dHP+hd10kUEusD9S8AT2uAn9Va8gZ3KHq10mKg9iptWHds8BoJlHPngDCScWm+MJJL3OjNWN0FrPW9Ns1megTIMs3vEs7VZ8qT9UMfcpB7snWwj8XCJxwZhe/aaMsvDU9zy+5KvYFDOFSqq2V9GjyoOqqJV//5Y4S4yZEjr0bPOH8ftBKAw31eSyztYoYjmDzAwnhB4fS6C9jTboetpEZEo5JfQYftxxcQa1kbse7qwfjKNyNYUEITf7Usd2CYkdoyMaG9L9G5sBGb+dWY49HFJ3PLfLlBL55Mokgf0l4PjwZZ06DHUkcx8cY2CxShtQPV9A==
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 07:57:26 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::32) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 07:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 00:57:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:13 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:13 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 4/5] mmc: sdhci-tegra: Add Tegra264 SoC data
Date: Fri, 24 Jul 2026 07:56:58 +0000
Message-ID: <20260724075700.714261-5-pshete@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 6631df09-11c0-4630-b39e-08dee95933a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|23010399003|11063799006|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	G2EMd6pCwjM5t2+WjSXsRJL5CpkLHkqD2Kh/AfWufJsjm0X5tfv8dX5fhdWfEhM5scaUR5NMuu8ucmq7AJN451oP4c87G2ryK5KJcDSrsqIx2xvSmmMJCJwMTLPM+QpzSH3VPjwwLDyy9JDMJUESuw57EEEKnTXONttxIYbiPuo6PwvsfkcFA5kg5QfROi5EXJh6NrI+ApSx6srdQpTcIrS6dL/JnYuNFxmGUSzQAB5mWLqb1XJ9Xg8UKAlyUuUkoQRbXNNFRazU0Ej+zez+/nFcDuKPIzuMn+ntm2UWmEWH68IGguF/SrcK2v3mp3kFJfU/xNgDfoAiydl++FLQPn/C5kEwGSIvjVI3trzpESevitomUjmD0A5Dyk7GlUSt04x3a4LwE6YD6wOsF6nNzFnSnt1bLhT0HhpU/SJmDIYfJzDyySmbzLtTvhKZKXuxH+iocrN8BIusyAJgqG3P3SuHF4MzVFZSRcD/OXxTizvnKR29yNYrxlbU+HwSS9P9Q0B6pT5eqf2T+CKryGjKRmarEWlrQ0UkIxt//YS9W4oXDGM4g045jxCfY+kP2hvV1cb/+NARKsSjQZy0q8DINyeMPKgedwfl1Q5lguWBYhyjhxjWdBT35sMAonlV1us4HAvoPLbFQDTMeDYs7gkgvmWZ1bv8h128fbegYsonOTpnja1WRgGTEUGZ9MddOnes4QU6xKe7gxAf6OrbXX7UXw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dJrUR7lzTiprjMXKq0pqPiCpfw/FA7uiZX10oKW8pLfzWk7t3bba/geHamW9e7z9EpXC3XUdqy53IYtSsID2ISFZGMvM8HL1YFHsXjva5NdnBjMXUziZ77vP8YlswFqcH+34vjV8lTCKXs8XJA9a5BWsXrhdK1FnPYsXwpcgeZH9QzsEOPJJI/etDkB+D2XT0wryLrmn20J+MHwVt9fvfZstca5AveUA2XO08BLLdz3JTWtRKj0w4aduBBXbN14H2BXwZ4+1VuDkv+RwcyAvuVzetZ9XnGKKJKwuq4Qvvrnh5seuMdSLc43kpKZhvHTRDiui/678Thd12FTZhyynX+U9d2bMmDMPFfFH1jg/msV/RvD8k5DzDTQCUt4KGjXWo1OXkwtpXvvjJStc2lpWTMkEbdODBPJmSOUzBGNg7RzYGELdRBJp/b3uDH2EEswd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:25.9340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6631df09-11c0-4630-b39e-08dee95933a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

Add a new SoC data structure for Tegra264 platforms and register the
nvidia,tegra264-sdhci compatible string. Configure the supported
features and tap delay values for the Tegra264 SDHCI controller.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 5fd900ff9eb5..5c5efb62d7ec 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1572,6 +1572,20 @@ static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
 	.max_tap_delay = 111,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra264 = {
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
 static const struct sdhci_tegra_soc_data soc_data_tegra238 = {
 	.pdata = &sdhci_tegra186_pdata,
 	.dma_mask = DMA_BIT_MASK(39),
@@ -1587,6 +1601,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra238 = {
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra264-sdhci", .data = &soc_data_tegra264 },
 	{ .compatible = "nvidia,tegra238-sdhci", .data = &soc_data_tegra238 },
 	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
-- 
2.17.1

