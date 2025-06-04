Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7551F4C8C;
	Wed,  4 Jun 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027131; cv=fail; b=g+z+dO1nfd29iHutgh3rnikXg0xgi8CGTIxVe4dWgpu/RVNPeeGANOWrij/y9baW4/PDxXPaDmSMJGtPudF59f6mVuBO5ZYvrjK3ER7ZZdNN1+4omClEOlAb5DqVCT4TnNFrUZTSZxB+dWF4XcNKDUgmQrzRpF7ivbAtmcJTrqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027131; c=relaxed/simple;
	bh=xuCpJuD3CRu24JE2kBDsjldm+otw7gzHfGLZOaIeMBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pvtzPdpgLIWTM0BEI4u4B2V05KILoLN1J1RxepXeYVMkwdRS8ivHjssRYi8kb5nte68Aa/Qpp/sU242TbVnpqOoO8ZqCjB0B+2srw03s0t3yuS7O2FbxlgGxYpTb7RI6Tjbu0Jrz3/4ufduxr+YJoDTbMu/HqguNK8Kh9jxwNNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAilgrvo; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAilgrvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arG5/KQQkMI4tRfK4JmS7rTt/isuZITFYWqr/vKBqsrPFPHoxPnRrphqcp3s9Ya5s665Gi5XtnCG58+REMsSzZE6BGyYfNeH2DIjaKAxWM6QVsp4F1/I7C2h+k6iyBsctaGz0WsbYTOAcgkekVE+3WCkCLju3BTI3LDMogEqCwTbyOL+vMENckss3G7fRoxeLfBXuWUW+D0qdOCLSJpSZttiB8iz8B4vP8orBiFPVHvS1Y7NfvL2hOgd84D++8CQLHo/iWTUYyClwLrItGpvnzHuPJUIGiaiDO8jFbqcm38Do/YhzUfXytxSnVUe7SLaLqooso926Z0F01CpcWmkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSl2cXs20mGjws9X6IA7KwxLXv+6jjze8lBAtntP0YU=;
 b=tPW15f0p3YnUFtxLphVctW5FjS17fY36nCg7U8e4JhTypM0OQR2NbirzJtovHTJ3cjudyce1J/hZG9GF6L79w3Bhxn7W5c3+pEQG3Ov2rKm0FSEwSBJRrNz/Gz32+ilCt1XzH+rHaTj/BDNGfccslcaPGfVvYQjSRVVEH5Vq9rfP5tPRObzggkRpi6EhgySfIGY92ipS3F0pH9fcLsGfC0CvTOuUTcIHcb+oiwOD+nwBczGIKhXHEylUru9lpCJx2qI7D5hheElWI4DnDRt6OL9K5DFbG4ufgeXMSKfX+xBVTikthplp/JIBVb/X/g6gVG7aRhj214egydg7toGklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSl2cXs20mGjws9X6IA7KwxLXv+6jjze8lBAtntP0YU=;
 b=wAilgrvovKt4MQGzLYDKu+IVfAOLxa9JbAtdvQ1N/7Ojq9uEu2tzToGLREV5gue8DrTjriV0cZMxdagMTY/h+x4CeFMkkPneF5pQ27UQX6eiJjWxb3xQVws0MlfYr6Uy9B0IGT09B0iYfZaEdQdZVchw4Th7p2It4wErhhUQFNQ=
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 4 Jun
 2025 08:52:01 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::f0) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 4 Jun 2025 08:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 08:51:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 03:51:58 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Jun 2025 03:51:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Adrian Hunter <adrian.hunter@intel.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
	<linux-mmc@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: arasan,sdhci: Make interrupt optional
Date: Wed, 4 Jun 2025 10:51:54 +0200
Message-ID: <a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=michal.simek@amd.com; h=from:subject:message-id; bh=xuCpJuD3CRu24JE2kBDsjldm+otw7gzHfGLZOaIeMBg=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ4cGp3MxYbXL9x2e6npVAhg1Wqk4xZZMyngts8bHlfO NRj2k06SlkYxDgYZMUUWaYz6Tis+XZtqdjyyHyYOaxMIEMYuDgFYCLCRgz/o6+HGrXb68eKpie/ uVEboLuL75Lb+eAIWdGgGFWO0phljAzf762uiC/0zL3YM6/oz5eDJ/9d3TJpo5xb5d8JO8KbOdw ZAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7fd9c8-a273-4810-8603-08dda345119b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgXCQYYU6DHgr9bapD41SMI3c98TFXbJnD2Y9dOXnhzHJy1ZzYEu5/JRTfcW?=
 =?us-ascii?Q?ziAVwSlr9GB9TiuDv0F1IMeiX8WDm1syNmisJKLNMUFFjxQ2OuyMjQeqEDXi?=
 =?us-ascii?Q?d27J4zA2B2LGEHM+Nf2VEZ9eOhJLefNKoCMWThWWwTgG81OZ5/PWhoGvMKw4?=
 =?us-ascii?Q?uL60n+e6/6/WTNGB6+a3hr2eBwg2ny7M8S4EJnux9SFzLmnPzzZYvK5Alp9D?=
 =?us-ascii?Q?B5fZKZWJUYG4lhEI3y7+mg5ledF43BKAj5MdJmAA94sAZj2bt/oL6N4o67zC?=
 =?us-ascii?Q?gKjePfrWadEakpGWgV3PunSVtGDCcAnYeVuiq79TCsiSBsdgtG5wdWNVRQh5?=
 =?us-ascii?Q?2iA1fy8Af7uSOe4uZFWNaPCibVeJDnwMxIVjJGT8/jUTpCBUkBOTLNU5Qr4+?=
 =?us-ascii?Q?9r8NiUUPJSJbNoQ1U1cPeRvbEbj/zbBDz+CWDiwl0WN1OX+46naqCJ3Erl38?=
 =?us-ascii?Q?Sw0CoPijU47BJm28/Te2TtT0UKR0vY3lYFrCjI5o5v4GmvpQjupzywGHzkvP?=
 =?us-ascii?Q?APmpl/vEiKoGhuN/1EPIHN8OF8Rc+3v6TZiqle+1t8yUUKekI/1l8JkiWxmS?=
 =?us-ascii?Q?7ioZ6mgApAt0MlQ8oyNFdF3qsvhLJjpvnRl391hD7VKrfY1cyhYLrNtvitmX?=
 =?us-ascii?Q?D2qW8Hg7zuPlbqO22FUs3RPWrq0k3ldRe+Xcq5ZaRrr6sixDW4/Xw/R8eYdl?=
 =?us-ascii?Q?f6Y5rFem9HhD0s5M2mkPsKRYVtalBEDH/2LB6YnZHGGX0UKQRdVSSuAuLQsb?=
 =?us-ascii?Q?EV5y7catk9YzxgvKZ7QlHBJwcQs7rAFDwvGERmo3GdVuuHpdnfg45NjkcPae?=
 =?us-ascii?Q?0b9BN6bins8bGfFAyPWG1bNZrMSKUzWUx1ypP7Y6VVZguTLL6om55s4LzCAB?=
 =?us-ascii?Q?O311+WmtKJCdnkCxafINCzvnGxZghcYQ9Z5ZgHc46Lumy2ke0nj+S+mflRlP?=
 =?us-ascii?Q?BM9MTyD+9XYM1s1odQ4XSqXvZtDZrt99iT0/e1rc9bp9ORuqipnLpIttL53V?=
 =?us-ascii?Q?XtWDqu4WWtHfejb3WXTe/P5kBx8LAiCQ5WpVw6smKTppHAT/x3aP6hwuWeFv?=
 =?us-ascii?Q?byQGOQbQEte807A1ocqBpiSgpuZ987yFeW+Eq67FEnShOxW7/M6PLoWg4Jyh?=
 =?us-ascii?Q?VsQsMkvmS9hhb/TvnpXD30ll33sW/yGXYCwQNyTTYaPXJnG884/NXV2rUOBQ?=
 =?us-ascii?Q?O3kS4LL/7UZuls9v5Bbt9LagZyB9awGr1rFeq0A7OQwfxlrcAeYVwR/koTU4?=
 =?us-ascii?Q?LufQaa1LKFeqVZgKK/FaH8oMz64dZlN37AfvJQf9/VoGqtvk/KlwYHbp1qe+?=
 =?us-ascii?Q?sCkAret1XiuCX/lt4xSLyDDbxsT+kLgoySncmij8D7Gh1Wvvb+6lss5LXTuS?=
 =?us-ascii?Q?8o/mEvYVLBmSWJi0ishd+a0gbmPiPZsKyYh/7XQ1ErmU5x8OxJYhd5GWoJYL?=
 =?us-ascii?Q?+0M0GllV2g5NMahfzrSUkHQsTF1CuOwsa2F5X32MFbSnwT62jiCtTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 08:51:59.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7fd9c8-a273-4810-8603-08dda345119b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

Bootloader (as U-Boot) is not using interrupt which doesn't need to be even
described in DT that's why make interrupt optional property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

For example mini configurations used for programming.
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/zynqmp-mini-emmc0.dts
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8e79de97b242..0472225e6e58 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -192,7 +192,6 @@ dependencies:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - clock-names
 
-- 
2.43.0

