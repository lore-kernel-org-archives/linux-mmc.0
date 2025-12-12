Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F521FF4C;
	Fri, 12 Dec 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521408; cv=fail; b=mbLt2bJ9C9BMTm0Jg1+wlEwY5NXp6LVWHiZ2BZ/tkTd+533EsReWP79l1dhvDLLQxuu7T6kVrS/0Ilkdn17uKoKMA+Qz4AtjuZCvGkAnPh4dchpVP+Tar192ZjZi1emEQAV3ys1x6Eoe8lNhBoOIBBZRN1K6k5KB6xjKk70FEmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521408; c=relaxed/simple;
	bh=ce6aytYoP8LWiI3cavO2QWhl5neRfOA4JXu0XeXFepQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=impNjB4J/RsOPzMQoG68vHIuhEYZwvKETKA0jGLH1FSc64ZBer7nCMquLddI2HGN7zyB9u7D8YzRawXFHpD4S619wEopfHEuMv3II5MoRDgl50ivtsvcZcI4bgCH5Ex7IOetAYSEVriiRurOdSP/j7gT9iPVcDeQn2GY9EC9UAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vOAmrT65; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vOAmrT65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg1lNApdYa4enaARo+p2aYsOcHEkg54bENYOR0CAVy9Wdz97KkaG80zjDpP2zlYXh3BSUKXWSodL1Oj++z5RfL024Gagb4s5NkelG61BfFqEhkpHoWVc4U9ILNXyzcijvo958VxBW+75cLTTPM+O+XN4wxy97YB+5pXmSZdBTdewRjHmg4mpyxvP42dchVtqxSQGim7Wkg+N2etb6OAGTWwEuAxg1qeiphXZYuf8Ze6hQ7kZxY1ME/Lx8tr/EfiAEZYP1W+zl+o7Y7YUAIN5OZezZTYObku0KAA9v+Afr9b0JcBIWrR1H/gRCcnkWJPisicdogEZtP/RDZTyQWhe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN1DM2uLftBPfRhei43YEoC2eN9SErzHD9rDUf8hkgE=;
 b=KPId0iYUvKEfC0BUi2dadX5w6r2TD4s4bq996A51AbiWj9lKhM54M/Ufvl6NN1zZDkP+CaZiqUTQ61oZihwREG1ZKH0kTtfsh3K0YUgm5A0swvgEzqg6CrKUMUAZfcfPxYvggV8x8T8XTWTMNH458t647AUp1V971J70kKvf1TO+UFqu//BusnyHZC872PFuwvmZBFLZTzPjSkeVZDlPBwqy4pgV87UWMD7VRzEvobOJwZdGc9Juj1nLcYvx43ok3OFvszEkS5V4PkhNruB5u4joz/J4MbWTAel3y3pbSHOlMLMbH/z4Ils6mW19liZPrlrA5NG4piN8BVAkDCDHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN1DM2uLftBPfRhei43YEoC2eN9SErzHD9rDUf8hkgE=;
 b=vOAmrT65h4ONT1sv55VDzymwy3BxD2eJ+HY6QAtMSr+FZPbL5VzBD1KwdLeBy0/7/4w63x0/uvEPBP0SMlffj0uk5OEQyfZOX0SAYzHQurWpNSBPh09Vqyv670gT0S9ig+SOqlnuhAOQe5Jr80FXdP7pmRPI8ln2cx4ua2JACv0=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.9; Fri, 12 Dec 2025 06:36:43 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::4f) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 06:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 06:36:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Dec
 2025 00:36:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Dec
 2025 00:36:40 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Dec 2025 22:36:38 -0800
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <saikrishna12468@gmail.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Increase CD stable timeout to 2 seconds
Date: Fri, 12 Dec 2025 12:05:09 +0530
Message-ID: <20251212063509.2002910-1-sai.krishna.potthuri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: ad788aeb-3626-4897-4331-08de3948d058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6h/uzqWCIp+pju4WNrcLXhUzzfTlPJ6pGpbNMML0ht11qW+3Yuc5To/0/BGi?=
 =?us-ascii?Q?A/gYNd8DS/l6BT42TPOM62ZYvDMK6n4QE4QU4kJxU/Aagli3sBaN3DVmt0Aw?=
 =?us-ascii?Q?ArqLRT4Ehkjo3TghZKHckWC1oVBUlcUW7cp8onXIwREVSXYrT/CvAEMM1976?=
 =?us-ascii?Q?dV/clBEFflfXhbknlFpV+F6WsbX4RmJnktNiRy2F/9qnFHevMH5MjLx7HlUC?=
 =?us-ascii?Q?fDNjz5djSR1cPsInwRkT3nklgP2e+koHBvFdq4THqtzI/tSH1u7c/p3pLVHb?=
 =?us-ascii?Q?LpsptjuwEr94R2Cc2W0brtqezhYLmVY2Gw5V1rSFdejprxBE8NyXiUbVsByU?=
 =?us-ascii?Q?s7115SpLr0rQjrVoSyrnQME4YPTfCmvc/U/j6xgdReX9FTO+cJIhqldRP9P0?=
 =?us-ascii?Q?BC3RsXuepX/vVaKjM6CQOxozWXQFVQKHTG/kfizcYFJ6etTbwF3cY2lMz1SY?=
 =?us-ascii?Q?xq4EFhTiyyrG7zy23ggS6FVlp4jlWsA3Ft4/CqgbvU1sKriXGFNwQQDjhaQy?=
 =?us-ascii?Q?tuZ2K41XcEitK5HmhX3bnAVRElEHuc2baHlYvZiyd6JXbErzBaLnYntgbfsg?=
 =?us-ascii?Q?/ZI2UqF7TkYxX1KtpvQYRPt0vZWgMsi0UJqfQ2jHXNrgynHJzrEEW+seVmyz?=
 =?us-ascii?Q?vwiPscQmazViWdNS45zScWPkK23M73JBk0Wmo9EKbZisEwRxd+4yHZKDcfAW?=
 =?us-ascii?Q?Hs63JoqF8WJMNl9eD+7/03dHFFiMsNR9wNQJOJ4ew/sgxDGGAHSxTAmi5yFw?=
 =?us-ascii?Q?+sK3mwKe8x1GgPfkxx9XTfL3XrSPR4Cbh9JdRQz8ZWxvFVdQTocC3YTzlPTm?=
 =?us-ascii?Q?Q3PE6RjVCOyNyzq7yiQfK8uZRKkyKrVvIdqaSHAr+wfTW+fBOWeEXxXqdQsG?=
 =?us-ascii?Q?f4YM7y1uFrLYajtzrj8nFDfWUawasuyEekgbGosQxUkPzb6hxEufOSaM4jdG?=
 =?us-ascii?Q?SaHhEaAOzQgImcsA5kaQCXSq/gENEW0ZjWO6AlEqfL61qW0jC7kpIonPM27Y?=
 =?us-ascii?Q?hdHT+11m9wO4E8gEUmABJD4wlazLKeyNi1u4jNsdrLciT0v9x928u4ir7EsD?=
 =?us-ascii?Q?d75gBFMWYyP/tlHBaIJP8y4sNBVl2bpWA11FEpyOu1ltWL9rsKtFDBClPj+4?=
 =?us-ascii?Q?10qGeKYUTGdUYSKIOc7vluM5S7fT7IcKgyncQmFq+K6egm8LbYapGpL8a54Y?=
 =?us-ascii?Q?K9sBy2Dc2S7iRhHv3s3Ylc6E951QzKmxXDWTNtHy4wn10XwIxmzpdMn24rcz?=
 =?us-ascii?Q?q/AQVaO83xljLXYBEgg4R4ZlaRHpgz3QFBa+I37Wbx6D4HM11ZZlyiBPVkuZ?=
 =?us-ascii?Q?ysqzB/wAZadAUvJ3fbcAjMJM3YDpDlgne23gLdpEXVA9E6j8O7f3QVVS/dGC?=
 =?us-ascii?Q?M/rBiIWpTGjm0JMK2t9MZ+htEKEuAPT89FZDp1xH5qT+VjLF2WAJyCIPZO5/?=
 =?us-ascii?Q?Z2uuYoy6Jr2nvLkClVjvbuYslcjp7IVPVawqE4JiH5hIPo1O7mh88xLcSGGt?=
 =?us-ascii?Q?RaA/oHGmuJiPIzKs2DKSlwZD4q/w2LKaT/wHib7kWeO7TZK/RGx+tpci1uHQ?=
 =?us-ascii?Q?Bs5SVc5hFKdDi+59f1k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:36:42.7714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad788aeb-3626-4897-4331-08de3948d058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

On Xilinx/AMD platforms, the CD stable bit take slightly longer than
one second(about an additional 100ms) to assert after a host
controller reset. Although no functional failure observed with the
existing one second delay but to ensure reliable initialization, increase
the CD stable timeout to 2 seconds.

Fixes: e251709aaddb ("mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up")
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b97d042897ad..ab7f0ffe7b4f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -99,7 +99,7 @@
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
-#define CD_STABLE_TIMEOUT_US		1000000
+#define CD_STABLE_TIMEOUT_US		2000000
 #define CD_STABLE_MAX_SLEEP_US		10
 
 /**
-- 
2.25.1

