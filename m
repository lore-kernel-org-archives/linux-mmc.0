Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F763876BF
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642136; cv=fail; b=uRyvcxKTZl6Hy9G5wjgsaokR44L7mpQz0dhwbINg/d3vMTMUvlPhYqD7oaxdn2Wl/4n9OhI3nrPT0MsGfNjKVDwZWnU9szLzxXwt8xQFhIn4z++aBm4syx+NHhIEWBR43fnyHKuRpUBShzT+Nd9nLVsbw+mpEThjNFQlwRT02pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642136; c=relaxed/simple;
	bh=pES1K1H/lJ4WmUSaJS4JKYQuvUDuoAVvRUAs6RQltCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oa1SajpvimD1p8sHtmYNjdT7X/gV1hWWqZHK1hFxvvJuPDscQ0If/wEB7RC/PB7wwwIjk26tYmAGgeP50EkGjY4wf4H5vBRfWab1B1pydRqWQTCKQb61U0HnnK2aobkdw6zSB5tZcewQ1FpgFclHe47Ni/Th1vMOqiQfVNE0S9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aOu9wioC; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aOu9wioC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es+KBytCP/0kZTK+flKki4NHltfbU2kyj+5MxZphdEFW2UhKd+twROgpjRrsKA6BUsrpkXYR5uKoQ8v4XvQC16No+DQK37ue3tvO2KFo695wY6YS1IY/0Qj2bHx09yNVDkCtEHlr3QQyRpUBHiVD7mWtntV/Y1FDlEwnWjs+z72oVgZJ/DojYGsvNLc036RSTngsZ0AfmuS1hSmyIhksDntUiE42cYAXM+cMHx6N5Ie/PG+Y3m7NTP3jI7JSiM3rj3boXeR+/Ya9pjw+XnubAtekkdlIP88BmhEfGjQg8PqjS0+NBUWS+7XX7lTTYNf96gbizy7Ga0wkZa8d0btaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UK0OFTdOudw0ARebEZ09jKNXUg6YopkHo0uQtLq/3k=;
 b=TWQgw8E++udXw9c5yBoHP1PmMD0RjgtbvIfUeVPbZus1elTDvDVEXrrYVgDMAl7OQ0lGDNykWXxIXKs/hTCygpkQzvskSbyQOob1VYvfRN7IP1pQLAocGvyNm2sMDGR2C4LCaAfdZirDPiRkKtgNIzU42gfW07M3ftra8pLQs8CoESOWvs6bYkIXt1sBiwX1ttypMcAga9Bii+5FQHp49bmghkojHaR4utdV3zg5v1ZDq//id2hS4U5+JV98rv2z6zzjM3iaK5Edeqc+19Hokapb/NQ1kRN7E708YRtBF4Spr4qlZUsArvGf5kvCCMF9yUuFzPRc2MvajIaX2o5k3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UK0OFTdOudw0ARebEZ09jKNXUg6YopkHo0uQtLq/3k=;
 b=aOu9wioC4FgmuTDAsZgtSoUzCvh/7ptMrnzkZvIrEgTgrZq/aG/vM40CH8h/Jsh8BK+EtuOQTF2xCWoW2BIQC0QQCsyK3pwX/XU19rsf4HOoZv8Ua/80l4DuochBpMT4DPcx9SRjywrzx8Y7cWCQZA+6/C4AnH1IuYig9DBkNhE=
Received: from SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 20:08:52 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::4c) by SN7PR04CA0091.outlook.office365.com
 (2603:10b6:806:122::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 20:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 20:08:51 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 15:08:51 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 15:08:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Mar 2026 15:08:51 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62RK8pjn4145942;
	Fri, 27 Mar 2026 15:08:51 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Bin Liu <b-liu@ti.com>
Subject: [PATCH] mmc: block: optimize size of struct mmc_queue_req
Date: Fri, 27 Mar 2026 15:08:51 -0500
Message-ID: <20260327200851.3669019-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
References: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|BL3PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b95585e-2602-4c14-9233-08de8c3caa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GNZTfDuEazaRn5fXmKsdZN7pYqhOzp9BfpVdnl2jpEQGlBEurJXwP4oTv6UgK7FALQ+BVFiGW2owuPoOhtCMpPh1vIHrjF1nGtG6/tC4Phf81bepyRsss7KgewzV14zS3uFgsXI2w+SuYHaIEEXWQ4yAyzs54IR3bbLh50sJW3ZO8OLscG0eKdwITNooOEbyHHOIieIfVvAMAIC+57GI7M2JIjckkvwxen+uJgqun1XQ9XfZ3rTryiE8Ra/Byb4bdZmimbc7MUUrxN1pI3N/a+8nrcKjaikZhPEdlZc4WKLWHVRQZ/KBf8Ik1xUqH/PSbN+fvf5sZXzRv+YUArSdHaFElgaDj+iIs2W9yZcozwX3cPQ0mnSexTlPevh43D+nTp1bkKcTRSC6P6L5AEhwzz3zVKvByFWPVll8lW7QSvRWRq2ORwKRjKkNDZvHkYpHX1Rkbq31RWUv4ZQe+Tt/JrQnC4FZ1g8hohpuaIP0OlG3PnyKmT9hDbki3etbdwPD/iP0HVTHFo/iA1+Wx8FjCvMQ4fdJ2yC/7xKdyfbTsRECmPdX+P9P4ZMIbshdJjTJEmFKeQvCN+Hf1AzACp9+O/E35rxOz2nW0RgEtSc4m8IfquTdgC5HxLC6/bBZXr3W0dILY64rJ6yfsmCmBUpZWN+Vvi5UL40D9zL1zpADyJ1zfCQXUwNCanax+LY11vvmmoYkPcjSsnY3re96xq6L3X509GZZSeR5opZNv9I/WBjO0IaKPNdT0NyXkXGr3Jwp5W+kEZ8i6WAus5nliJRB5Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jDWRaGT55CkCYkCdhXTM6CErJrOiGbvlQ5QHj0O7THhMP67YKHp7ooYnqEWFPyTiZoOyCpXlw+E/DI69/tlHxZE6xOnVUYsc7y8DS6nCvKXwEgDDdIUCJTQxDi99o6BI5Wu+Itr+MebuYsq07e6D9I3iURCFBsoWBqZmASSPb9TN0UuGgODRW06bp60b6y5Uaak/tZfjA2XNic6ukGtJyRIm7fdaOzQusqjaE5OIEoFWz9VgLOJTZGUeuEdtX2VWLaKRTiFD6xvjhBFFiDWoG77BFfAmmLO14obovrdY+AjoyjQVQRaHOGHCx6I+GvCj4jdj1fhd2WZd/KlfcAhX+ck3V8kJoRTN3eA1O4A4v68xPWLtoyUHFtHhIzbZcFfG5ocnS2u1vTpmKO6G6CxYdqKO87iTRGsJkfIeuVZ317FnMFcQI/4Qru1kpg/IajVP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:08:51.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b95585e-2602-4c14-9233-08de8c3caa7c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020

ioc_count won't be more than MMC_IOC_MAX_CMDS (255),
retries won't be more than MMC_NO_RETRIES (6),

so change both to u8 type.

Signed-off-by: Bin Liu <b-liu@ti.com>
---
 drivers/mmc/core/queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 7bf20e3db5b6..71c82153dce0 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -69,8 +69,8 @@ struct mmc_queue_req {
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
 	void			*drv_op_data;
-	unsigned int		ioc_count;
-	u16			retries;
+	u8			ioc_count;
+	u8			retries;
 	u16			flags;
 };
 
-- 
2.34.1

