Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353533A9639;
	Fri, 24 Jul 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879846; cv=fail; b=H0zD3WKHb0aFfelmGrYMvhHhfR55GbKTbwt4olJ7Xdm3826XalmudE/p8Q4nbQNZ36lk6RYoyvdivKdPkdKvhks5vEJkAbr2c2hgU9ag76FtXqRURqzGfJ9jb3yOXML71a4MDlZkGFtz6YFraLXC2dUBdzJstQBSm2XAG2b5gA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879846; c=relaxed/simple;
	bh=SXtZmsNmlSUlJRH0j3o2wyBQTMWksmeFrurWX4a1Ge0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3ubgJhNNjFIdgkcp8/ybfRk+CZSniqbJIaSY23Z6fOeAzpZ2sJLCg4k9NzlWbjkQnR9qJDv6/DgowaFcgHUGVfosU/fT5RTlVQpSpduH9LW4Iuo/z7Ie5ymlV6XMg5t+gwhejzdwk/2Hh/tecZ0heNYgiVTz6X37zjfiwPcxLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJYPKIKh; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJYPKIKh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMqJTzT+Cs35ElDzemsMZ5Q7q9XZdQMGace1jdHGc5srEj9qv2a3/cDcqTC2GyqzuhpPwOyZhoxC7RDZUtNdv9iWvKnM1KDdrmj7DgPLcokVWuq7LGIQlJt+eTmb7GlyMeLVOAFH6EXbwdvTNMM5hGOsGiA1A4V62LQhj3CNDjTA+q3ShfGFLGrlSgWR0kXBD5OAV9TmPj2z3+T/CUKZjQ4k2zUnOeE/9kEfWP3a1eZiqt0p7O5H5nm3GBK643zhh2YLTBrBh3l1nFss9uL2po44mRroSsevPllUVqun+FkR36nI5m/SGnG+wJLQxalPfMjS91eH5miaHXOCqa9Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8pZXUAxSinIdAEhPavCRvgVd5OqOskstYIO38DzTlo=;
 b=E+8OJynsao3jv79F32okj15BqGuEqvxCrb7ykOSmD+p7U9BNyDMrRwJFtM21RJ71Ebo/yWr71d+VvugMVvEu022sEEdQVhii3xPPiMxYszcQdqNCaaq91bAp8OGuJZXvQWFpZ33MkDJVP0vcyG9pByvZKkCVXlrPMEDnu2noqFloUNimGpgMyTkgLEF4MzBjv5Bp+g6GgnxALfaoY9XkdWFUTOW0imQwtv/DrEejE1mekNBaEkNXZuMMHTQeWzHa+oDzM6sVmPgZSOw5wShbHuhXVd31ewnqUC45Ibt3X/d8b6sXxvmMbDuGtt4KGcFQJuX4saZKKp9cNx13C0wIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8pZXUAxSinIdAEhPavCRvgVd5OqOskstYIO38DzTlo=;
 b=SJYPKIKh/KmLmnAuT4WMeH4+STAFl6Z7okpJhDCELxCWFZqANoc93LXfPKBZNGm6ZNmq5gQiipoSCgk5KkHazILMykah2rSvrKvWvRtQtEh2hyStyWRQAd4XtXWQetnQzXcotw+tZTqT9OhJz3Kj5lU9kQD/1VUzcsb6m6DvG7HmPdDwKvAIncrgZ2Id+a2m6L5gecD/zgjf0/PoiMBE0E/J51wTaBobMmxEY0KMi2mpIYai6VSRp4E2AMkGk/9iyRRXSIfwO64pZGOpwMnVRFKhi2Xu2FLJZ3dbpCSasgbGVpXtPSEgqB+6DeqSnE9Gep0/gV7R8mydAweB7AjlKQ==
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Fri, 24 Jul
 2026 07:57:21 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::a) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Fri,
 24 Jul 2026 07:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 00:57:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:06 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:06 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 1/5] dt-bindings: mmc: tegra: Document Tegra238 SDHCI
Date: Fri, 24 Jul 2026 07:56:55 +0000
Message-ID: <20260724075700.714261-2-pshete@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4d2449-20ab-405c-1cb3-08dee9593035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|11063799006|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	5aL5OmSyXzpEdnWSHwLWR3hk6bZgLMbqh/qBrpzgu1D+cA07ykKFRTSRUF4l2BccSclOvnxa9l0W3mOh2byoGJg03BOb5uVNGy8Fli4yL+z2mImbFVDmK+H4lFX4doWZbLppwMWtofoOAICC7qpYe174LeAabX0Z6g+PyikhtJ/LXhfFJJ0PPuRwAdvP+fFXQlJZq09FHPHjnsdkx52dNmJc7GLZWCyE3haLdYc2p0jOfWn0eXYeYuscfOWxIIt3wlxKuNO7hTBIgQ8o1O3nRTpDmi8t6gq890OCO09tCRjLq8CWIdO0LhdwGaLVx/LjxYotqFc/4J1Q8lpvKWVZfBBri1yDrbKrlYANCttV9C9uVw75mBAEkP/RAQ5V3gaalVJmEVK86ZkT4fT09u5IHZFid6J0Y8t1YLkgoc6Mz2EL4BqVHIixc6VKDGfCxPEdnjnBIrCdJymU284Yg7v2eyJcykeu/Bqz/WoIXhzx/A8clBJpOyLNb6djyOXz3AEPV8dZM9+Wg2QYlUmNjJrQNSO1YNzNKpjRdBXJGGasaUfOLbXz9/6p17FAg/DTCvXtJXIXaK9oEdE7xBerlCeuMwxWZ4A2i7cHYnfW1wfWuq0wHicGVQvidOgD3HIwS4IP9p2BaJ8fPRFfL+OWDMfagsKhHRA+jdM7sRJsEqpExO+JjcTa8YjKda8dLGLn/1i8J1I4V3P7y7u88hz1OjpLNA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(18002099003)(10067099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ATD7K9PZSzD3ZZ9LXTUWXif4FQduUrq0mnepk28bu7Ajjx2QOYiXlnubCoqlPBzzXN4Us+O4hzwZ5JLSq60s63K+9DQcIqKQipFmwfHFh0WrskDXZLbByr3KdbaVMXQqv0rwAey3EM4x1xdLEHj97YeACydUthQTqYGbq3jemL4aqCxqe3mx2td+x0bx8ezpL8WlVsFjV3fPw+hQMm7G6skcalFmKtt9sEZFUlOgZ3QpVoQgwWMBikSyVZhXnucKfNh/QRTKK6RUegdANRTaDEzSKI23YmTkoRzzTvhnRfKdqcwXDwHq63ENKR5+Clvx82o/9YzGB3bXXB5+waAwNml9AiFbm4oKfCN1GtQp/l/HyaVwl/zmpT9LLQ+k+jde5sHMep6zBxM/RSvfaCmokmoa7J6aW0oIr6YNRuNnWjPsuqO7rV0B1TPzudJfy1UG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:20.1928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4d2449-20ab-405c-1cb3-08dee9593035
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203

Add the compatible string for the SDHCI block found on the Tegra238 SoC.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
index 72987f0326a1..0926a0cb892e 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
@@ -39,6 +39,10 @@ properties:
               - nvidia,tegra234-sdhci
           - const: nvidia,tegra186-sdhci
 
+      - items:
+          - const: nvidia,tegra238-sdhci
+          - const: nvidia,tegra194-sdhci
+
   reg:
     maxItems: 1
 
-- 
2.17.1

