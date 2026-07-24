Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC733314B63;
	Fri, 24 Jul 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879840; cv=fail; b=jgZ3ql+FeTDGYmEZSLSTE1VXuqFXeeDbe5vkQyzjqH7ZZuaBtbPokFIisZ2vk7hu0aGduQNvjWkfQhnCgdQfT8YCPXLWY7O6SX4mFzXqQapU9nIdhX+AFNzBAMopmYE/iDStOKPhuRdZ9+MbXAUiM1GS+vA47yOle9J0wlY6+Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879840; c=relaxed/simple;
	bh=pAlWe3KPZRgpXN4mVmCDbr55EhOPzXVSf5FQyuY+UUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neSj85J2GtCH3S5oRhsW/fOeF3KSD12wovbBBsUg3EI8ieu1R8ojKco82Y0qlvocxqyNNE6mIobSBNGCjvl6Q49cRzPGhFpR7XCaXX51KyDcNCqG7XqB5TcxX3DFOtTdWLbvxekmKXy655VAzPBKy6ZuzmreYg7lEbUeYIrnDOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bL2XPxHk; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bL2XPxHk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1Icfy0pzTdHZHbcjpUDDIyW8jkxwBHxWj+BmJOb5zjWBTS5zpL1z3AAGSUR9P6XqKdwjO4dkPPUVlo77k5hSZWsg9afoVyUuJ3Eb5MrQ1gqgFYwLqVgtk8eof1q9I03G1gC1l1B5dMOqdHjKtXty60lKtQZp+5mKceFM+h0WTiuGYqpOXolOe05SN52NjylLfez+UPicXCgpE0QFv3dD0SlFdwbrogogup7MEubOJvPn3F0gwJ+VdfQVz7lf5lUhipTeofivImf1bCHWCg2A0jx68fQ8Wd9sFH8ywU1YrA2voD0zMozKDZJb7DFlk8+giLg9wXYNBMkAz76U1uigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlmSp26XuO+O/esKi7J7WvDscLL7eDOFAvQOz9pTnXM=;
 b=fx+e7DNIip5wcBxBU9TSTEHhHruflBU654i44eQ+Q/dinWaHmVgej7bxyZZtauQHb++Hghg/BrnwYebve9xL7r7LWk31L2WdlykZVJbxJk4nuhj/SQ7sQK5hYOKjEg1RqAHy/rwfDNL/2lve6a7XARTeJMZtqvjElFAhc75ydSARtOwZeszogfLGkb/RJq+6qYQ8hL3nFefmwKmm9A6OITDxuRpbVC/rbDK+TP9JbRGGILJWT3aiPpOrMCUOQqh5lyyEbGehA3Zj/vgq7XPArXY+HbWN98Wi50U3ESBU/qZ17PnJrjsjtHgsXSfIoAnzvLt4gqsqhiTSAT5Xk7xRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlmSp26XuO+O/esKi7J7WvDscLL7eDOFAvQOz9pTnXM=;
 b=bL2XPxHkl8hx92BgLS/poi39AfgoEpvdlRbOCcZNoc5MdW3eg9O2T18HfVziDLz3tbOpebDzV3Iw3TG0tMLc2/hSI2xEan1ihNOmD9bDGhGMANMX/J4LZ1FFUoqcwEbeUZq93ya3mpPmGhjV+GMGNphCqm1B9dqxdW8qJ67cD7uQfwRMZNRL8z7uZuXtmlXBKod0m9MIBC+SVOWp5KKBWYbOj0R0IRkPd12ID1SGDZiMIaMkY2d5H0cYTrDzIvc3AOWMZj5sFhHYBae1q2jnIkybWZlZdCpnVhWJUPcQ7jSDcvAcelq1ObIHd6lteVPSy7K2Z94RSz5O9aAnyeueNg==
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 07:57:12 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::19) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 07:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 00:57:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:04 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:04 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 0/5] mmc: tegra: Add Tegra238 and Tegra264 SDHCI support
Date: Fri, 24 Jul 2026 07:56:54 +0000
Message-ID: <20260724075700.714261-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: f174891d-dc1e-44e0-30ae-08dee9592b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|7416014|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	McHhDWRKUh1J7P83Ql25ZxUaqSS2eGvMFfCoV5ixyT2WSCGEJ5325ghWyPagGhiHGb0PdxIUSw251mQl8RJPWsaQhYGVIrVZhE7vr5R0aYMJmhCSfvdQMLmMGRv1ytH7J9+m/TPw87oxOkkCFQvKIkDiuFQPmf2FptX4TgQP7tUAPKH1vga8Ag9cymQkqUgcWB091/FttuFskF6pB8oVUQv4P5V6D94OFNKf9Jl7h8/dxgqzQq1jDolPEz+oS3+CrKozwSOerOoxUoCUNZY/DlTG1hmPhOGAXaz5+T7iNwiJtcra//NsJe3dsQwEnM5vSqFxP7ZFgw5CgLqv4qRBEBBcLtAoEs2qJnYzf41zNnYmi4ajp2ZUySASyEuOuWhQr/JLOVnfpJePpGNiX+tS+RUfovZlw+4/DCzBlT4rccnBOnbfuX0O5CQJDq6j5WGrBFzPTbYCxzwKSO9rZswt5voER2L/fr7v6CS4swp1tSneirFX+1Rn0lBDsXb4Iu5Sq5nGMarfeKMfHeyDSLeSL1sSikxpadghkmoehEIPo6As4bVvqbrrgpNRvHAo29rrVRNt6KP8qcYZJqVGSAPGpPxNYUCAM9TbV+BfqPTXoDg0cdB5QhXw7vi0KvXnStCfYaciDUsX5KUPXWZdAm8fNnVcUDFZ8WhHP7RnzZbqvTvCMygJJToWbWTWJA0YmJ4ogDmWRs3ZQhOKLyxfToKDag==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(7416014)(376014)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lD086/Ez4O7juAEXf2AJ7myOoZIACL7IOjibgvOJsCBBMazwDpo0DvvWPTggP4HQmx80pNtN5jsUEoARdYUyj9WjHmRBOPql3XpvL0J7Xp448kafH/HlHEXQ9A6JMTKdNFU9EDa+T8WZC5GESwIFq+ftw4xjwEp1Y8MYWfTwgpRs8wX5Pf1oMNIUoJRbmRliuhakryTkTR1+frn6q9EwCE8XWxnUhGRQZNFtSxOV9fHZ7qn1xCXnoBEk5Pk0dABBNQav/wbujtrER80lCBXJv8+syVXFLhjrjJK2/nONKqnFiQlmJX+6pc/kHIJdQpI1S1NLGo3vvUGnp5CsQdQ51HYQe2ldnyaMEM9LrVVjyyL7GQHvSEczNuDaUqHWZMQKfeo/7JQNC/CRjzwekKDRR7vB6Uj2y+fi2eBGEhTh9EthTLMqZdSusRl3E783I4uh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:12.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f174891d-dc1e-44e0-30ae-08dee9592b92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

Add SDHCI support for the Tegra238 and Tegra264 SoCs.

The series documents the compatible strings and adds the corresponding
SoC data. It also adds the Tegra264 SDMMC1 device tree node.

Prathamesh Shete (5):
  dt-bindings: mmc: tegra: Document Tegra238 SDHCI
  mmc: sdhci-tegra: Add Tegra238 SoC data
  dt-bindings: mmc: tegra: Document Tegra264 SDHCI
  mmc: sdhci-tegra: Add Tegra264 SoC data
  arm64: tegra: Add Tegra264 SDMMC1 device tree node

 .../bindings/mmc/nvidia,tegra20-sdhci.yaml    |  6 ++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 34 +++++++++++++++++++
 drivers/mmc/host/sdhci-tegra.c                | 30 ++++++++++++++++
 3 files changed, 70 insertions(+)

-- 
2.17.1

