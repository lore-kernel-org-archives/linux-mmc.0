Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E903E51E0
	for <linux-mmc@vger.kernel.org>; Thu,  2 Apr 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133130; cv=fail; b=g6KN1zWQ5MmnTcNNgldVxK4kc2Hx8afTTddsww3sTNk4jSaUfc6NWacssVROpvNOMBiIdyzK8E2TTxWw7LXTfBg/ONlYMt0bO85BFv6VZMbuYD34ampeVNybf04eN1UyZbBdlm7qc9gs4m5AsCq+72dJQNd+dUX3kxoe8oD87ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133130; c=relaxed/simple;
	bh=4e/HilVG7xGIgjXeJvpsDDW3VDgQo5fruoqpByLy9aM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjjh8fZE8yZ4kZNIBfjzlO1fgck/PHelIQTVhrvGO+6jdVbRn4I9mPcdGnSq5262NK1xIJK159cgG//GzMtLAJYzTbCmXTTTAgeTId1YHI+Vv3x9pqmCJLyRHkhNYA67oCu8/HcXioBaKCHnr+pqPZIKQZx7eJMP2qlcGHusY40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k70Ggbyk; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k70Ggbyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpdGlXEfkxg/uBzyyIFYUAEJLev8uej2lUhDe1AIVXVq/dH8IS+SY8S3V/0YjbF6yIulZxFpGXPlhrJwBxLEcskWWdifP0Qo5tJFbQUa4fbl2jiV/mmccKqLGcJZsqCnxtC3au9YvbodPna8CBwzII/OkxS2VCdHnp/4uysogrcn9b0ZDwTxYB7XWjoABrTXuYKluFD11NE2p8D7lHgJb109Bg0O5Mogf0S7SHtHJEq+1jg9ATvfxzLS28SOxHmKw9OATOfW7cx6ivJh2d6eV1WRvLvqNIEvZoMdJKEMaOjkNwzkWDYgRuWR++hu4UabzLb37bkvGbB3sQFEIOlSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb8jlK2LKWaWgHlOvRgI3b6Ds4gefWHhYKic227AZZU=;
 b=bHCpotRROLOEWDGrvBx5ppMeCt+hwofXL6GiWwQA8sprAvHOQyjQIBOWYEthI6TK10sTdcBAgWWJ92l1m7Nxnhrb01jOiju7wJjjjkWGwxv6e0BBQNhp9DxMXwMi91FLQWvwafBaAchgxXQycAOc86dsayqSlDpDREK3eD96lYCcSQbYCfKIdzGQAYCPd+uQwcD3Zfc2DpvOAQc8e7Rl7FW8oeSvVDBR6ByRoSIA0pFICcMm406adCvB1WMzcHYb7Kd1wiDS0J2W+dTr1S8vdp7t60wNfN3SMe8BXj3y5iLeqlRlf/kx9EVPyEJjPh3vq9HdAIeG6TNmPCWX2jTQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb8jlK2LKWaWgHlOvRgI3b6Ds4gefWHhYKic227AZZU=;
 b=k70GgbykbCVeX1h9ZSsPeGO1Fkac8h19Ix+sFkWCF7lBPPM/ArL/gn85LJIgO6h6sGzqqAPLOpXsA3+9wl/BRIQ/cm+qhh9sbWbD2/sG+oA/W8mw8Uc/iLyIYq8SuEFp32lOfSpnXii6f2fz7Y7HARftoRaRiVDREGmnVVBxQ+A=
Received: from SJ0PR13CA0071.namprd13.prod.outlook.com (2603:10b6:a03:2c4::16)
 by PH7PR10MB5832.namprd10.prod.outlook.com (2603:10b6:510:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 12:32:01 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7c) by SJ0PR13CA0071.outlook.office365.com
 (2603:10b6:a03:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 12:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 12:32:00 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 07:31:55 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 07:31:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 07:31:55 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632CVtb82452818;
	Thu, 2 Apr 2026 07:31:55 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Bin Liu <b-liu@ti.com>
Subject: [PATCH c2] mmc: block: optimize size of struct mmc_queue_req
Date: Thu, 2 Apr 2026 07:31:55 -0500
Message-ID: <20260402123155.1896449-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327200851.3669019-1-b-liu@ti.com>
References: <20260327200851.3669019-1-b-liu@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR10MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: e29cee2b-6ecf-4da2-faf7-08de90b3d646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4UwG89kzFA625rxQ7+8z2/ewxgRrwG6bAMuWE/zZSDnwQfSdAE2g3K9bW5Rlu9nTGVmQUIJdOXGkzWUplqgOZ9Zx0Ud86Ej8Xvg1JArd3dnkOy5t3t9OPJ41XfYm/emTOmn5HnmmM53xuxsygANQc85AT6x8XJocpvGU+6n2xOc68dq2XQweog68TZA2gnstDZle16zf+j/HkippO5nmsdppPsLmFcslW/2vkUVmVmrSt2LlihQByRTdHXcBRy12k8KTC6pscG7LZ/1Fqm2GKtEhxRuw2HMDyDBuYQ6IKI7pWEXpz8Y1EaHGxAVxrDk6GIKwXbjKeirDFff7uaIdasuAn7f11wT2KTM30CmhzI6EQ/9cHioJLVF+ku5oWVfeEL3yiR5CQezNmMhcq5gxDw4mvPrjCZyKZ4SvlZZ5BwJdKPtW6joTBNIrZoYZ/8LVd+h1XBtt8t2iuNnN42CYvYO5T4dgbzm+V7RJETjD2yFAHjzS2vW2KiSHb3tEwOQM4LLWMeni7MH+iWDnnC2+4WoywYr0XIGMUAD2SS7D854Vtp9lqcQxDdhqXBWeS5UeL/+yBY/1LwEndsL1MSpPByXRQW81NJCSPzxobshdUGyKYrKMs9UZkEBlY5hbeF7XhB6uRNI7l+4WoYjJzP4tLxilNaxrLx/LxX1plxKgbIuWBO5ZEcZw1z3QlpSuhoz9swRRKWs9K0mKzHdzbWkL9hja8OL6VBoaSsphhjC+Cu9Z7SKGbyp2pMG9ijqZxuT7BoRKEPfYPSokl02Y3kljmg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	okj6NvobsSCETgKWhqcC3Gj+3CGU0U9ipXkVPcAiaiA8RqbCz9IxR/sdj7sNOL+OC6IJ0yfJKA6BmzwxX+wrL0TmROrzvncH7aRUmZeZo2LCbIZYFIRWikEpd4EkmbjgX36sHFJiCC5TXVBucIoN8N/JMP83IbqXgkGtzNYbK1+Q2u28sgoYKOzVD8qSzF4/VEBymcJ8hOCMtY777GAj8of5JJ3SmmFN1ApV4tcJ+ONZEizp/cNBHLI9iHSG/oYUst3xaFlGfkE5c3VUZw93H8EmALPeuhiyHm8Iz74sR70DO3p3nuAAa0SSchAYKNOrH/Kh1fohyBAagSqDU7GC9o1jBbG4lYFVGZ0+20z9WeTuFbVZy5xK+t68cQymts/xPEZ+oEGhkTsfUgwFlBpSmM7x+9Cganjb4Dc6tuQ9nyTqij+X5RBuYw+gg2sfAmxI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 12:32:00.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29cee2b-6ecf-4da2-faf7-08de90b3d646
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5832

ioc_count won't be more than MMC_IOC_MAX_CMDS (255),
retries won't be more than MMC_NO_RETRIES (6),
flags is newly introduced and uses only 1 bit now.

so change all 3 of them to u8 type.

Signed-off-by: Bin Liu <b-liu@ti.com>
---
v2: rebase to upstream tree
    change flags to u8 too

 drivers/mmc/core/queue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index c254e6580afd..dd7211e3a6d5 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -69,9 +69,9 @@ struct mmc_queue_req {
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
 	void			*drv_op_data;
-	unsigned int		ioc_count;
-	int			retries;
-	u32			flags;
+	u8			ioc_count;
+	u8			retries;
+	u8			flags;
 };
 
 struct mmc_queue {
-- 
2.34.1

