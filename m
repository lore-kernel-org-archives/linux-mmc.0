Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00C3B6BF1;
	Fri, 24 Jul 2026 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879845; cv=fail; b=aoSlm6EWHeXLGqLQyEpFv+TwUyNqwleW0momLLnkQkPrmQNW308Dq6AdeufLK0C76k6KbkmlwmxpAhVEDpSjVRefmfqqxwSca9S7TvVpV7/Ndv+lUMfVx95MqreS0FujGNknGafFfyNc2ekukuZZMZi9l2NF06N98VvSBgp5loc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879845; c=relaxed/simple;
	bh=wsM7QnbOwskj69FiduCGgAy6DVlZKzi2SI8KplOKi5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0zHGAfohuYW0GL1384C1GWA3nKkseCvrkJ24KzJpgLEkbUgcifkgma5sBCBtIuKZv0IbOVwLtuMKpSUyzdkOD7rfnmxdvEJPB7wI9woumRvAfHR+1u42X6pcrM2K3LsrUW9jI9SdvmzK2WPjA6HfxC1ZKgZKYeACrfJ86o0l7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nbGNYGDK; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nbGNYGDK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvROW2cBIVWcF0M3nhHXaHcUFjCk4wQXsn1+j/aN2Fi1I+oeRRFrh7iyoC0LAhvQUc8lJymIgCyI+C5lwZgtdOeo0Qde5WCm4JWexjE8zO8+XWlrhvVVns4ihavEims/jo67ZPG7moU6wUEmdMVFEJdfef/BkjsbLIlQjb27yL7CJSkygkM0wUFbS4gcOuRXv/zFKMpFv1fmLeG9b0GLFjqkmNJKJmCmC5dsn9JmW4WramWPhgk3lLvLx3sEDPCY+p/VJYkkaopLi8YP58yu3o2PPAiSf3M7zFqm5Bgp1b0XlRLoI50a7FuCONCMPfycrIZ2nXS8cw013QyrVCRnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSbABS7Bop/OAWIPXVeeIh6tfb70h/h6aDF1hEhfYPU=;
 b=WSPXBZzhnWo/3afSLltNij6k/p9hfV5DqNrXZP7JiGvVEsd6Sy1XFK0X1HvQ4tRNP7K5t850Kp0ZaEEZ4HZ6+6zfDCmTkvSOhH8zXWmbSq/sP6Uclle2Z3cUXBxbKZEj9FsMGJv/9rLFTl9Yjqmq30VyTGRuMIY9uYFDh5Qa+Hbv+kKptq0XhG4taQyRZ1O82OAhp8+ChhdMy0SjU7vQSGuIJTnHrjcopNA/ySwd0FcNvzzFXx++3rnqpmD1q1q5JuRwTLlfxabzELxOrsqWEh94284vBwerhZFqR6Y0OdpvM5JcG5obMu5XyNBgu2vFbbVrSMna7H/SrkQBEWilfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSbABS7Bop/OAWIPXVeeIh6tfb70h/h6aDF1hEhfYPU=;
 b=nbGNYGDKQQNEPhVaAug7hW23iTUIChg2RU26lLVj7HlZQQhpXyYaIZPImu9Acb6CUUytYNG6Bx2Uzd2SzDM3Bn2tFEt0JKM3w9tvso8hPA+pwuVRtnM7jEbAXZbmMOFATt0Bl59SpsgFAD+T2w6veiu9BtHSAF+l4fYqUEUqtRtXI//QBEWL2maB56HI+qHF0zBsJ5HZAgELpoly4HGHXKxfFMAqjnNhtUkVv0EtBiiopH509hTpxTd+0Xn3N2WneyTgA5ojHIeOF8dyY22a4RPhpG5+rsGZjZNuKQbIuvo3fTBUFnXHlQttuUSooGSDva9XEAVAmrFfr6GYSIYKrQ==
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by DSVPR12MB999123.namprd12.prod.outlook.com (2603:10b6:8:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 07:57:19 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::71) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 07:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 07:57:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 00:57:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 00:57:11 -0700
Received: from build-pshete-bionic-20260122.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 00:57:10 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <ulfh@kernel.org>, <adrian.hunter@intel.com>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pshete@nvidia.com>
Subject: [PATCH 3/5] dt-bindings: mmc: tegra: Document Tegra264 SDHCI
Date: Fri, 24 Jul 2026 07:56:57 +0000
Message-ID: <20260724075700.714261-4-pshete@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DSVPR12MB999123:EE_
X-MS-Office365-Filtering-Correlation-Id: caf8d0eb-fc4f-4104-ac08-08dee9592f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zypKXOSgeZlluLIYzCELZYVTOs1Q+J2RESfw/v4ZZxlZhanYD/AwyadpwYP0sFr2KNc1laeDlFITa4qO72ZH41abLpqAKpOvrspFL11NmoWq/0MyMr8Og7rLvQ36QzZB2oa3lxxSFHgzI1XY8O2PAgPCjmO2FwVkeCi/lG8EbchDfgrSili5s8C6ur4Swy8aLxd1xE0Tgiz4qDeJpayfI2GsKcSwKd3ercJLDcNGHfuyZTY/Sa4lcmK/E3UZaTWnSsDXR05AyyjwSMe5lrQX1V/bbz4hTkoKvtDRKV/e2yj3uKropvJCVolOE5arLgPlMavjUcdQAPy+HtJkZyCOOBzXw5mn4cXFA2cetDl1jVDN8mXZouNtzfSrd9InYIi21fo1KG7wmjgUVl0l4cYMAmkb1cNZLeZhw+6BS0xS64YN4hEOS0HAkY53EbKiFDxCx9dEubFdNjGohYMI8zqaGKrmzC3qV4V//9UB+r5CkrcitrrqwyyKsOpq1nbeHoFmQ4dBe2s9HWK5q2n1nD/7ue15sFP3go8fGyPTJpg+aPPn4oFMZHzzJiXD6qjnzjkHECrZcbTT4pnFF+g8pN97xn0rYi6Ry8ZgqXXTd5oSQI59ZabHs3qW5yqgM1dOeN6/7GjApyX0D/gKMt4HrrkelsB6eCG0IszFuhp/NlVFl401US5FgsRCLrw8tJVsSfzgmmgMDO01TQhUFpjVAAf2Vg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p3dFiT5Dd90/xQRK1L/bsQHHlA6YImAULjjaP6/IM8gIuNmCeYqLuLDw7jcOJ/9Fn22GL4Hfpngqey8tbuqkHoP5YMKCOkKL7+LFQ1sK5F2lYLqxOcdUjayzaGNg+am/tfutj0bdMrgCbRmfzMUCSElgrU8MPQzFr8W63XSAoIBRveUfM2Eve1S7cHjm/ISIf8QKisyuo1/ayaxlFoFTZIyIKmUqKZyoLUmzMAg268JdRGhudMjuGSn8lSmyPmXje9DZWQebcwVCCRXv0aw82qslDVd5Tjv1k+HCeRDz9PtINNSYIUmSsVsDfhfNrWPEmTMpr0vi25l5n4AfAYACIkieeJu7wc5vbWSpRLMsBVuihbnMiG0+YnUo9CNTXGR1dwKsNXswmzQk2vOrwBDCiJdXIjyaMr6E0+4NHNDIGpn6rnGXL5UfATRiDhcuunwY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 07:57:18.6978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf8d0eb-fc4f-4104-ac08-08dee9592f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999123

Add the compatible string for the SDHCI block found on the Tegra264 SoC.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
index 0926a0cb892e..3cac067c7c98 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
@@ -40,7 +40,9 @@ properties:
           - const: nvidia,tegra186-sdhci
 
       - items:
-          - const: nvidia,tegra238-sdhci
+          - enum:
+              - nvidia,tegra238-sdhci
+              - nvidia,tegra264-sdhci
           - const: nvidia,tegra194-sdhci
 
   reg:
-- 
2.17.1

