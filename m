Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81173C09E2;
	Thu, 16 Jul 2026 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244417; cv=fail; b=TpwPVug7dTlqXNKMZDu50ArorNWNyqnOqOAxaKs/1vwyjzZCUw8A09ePKNaTNPlnDvDdJz7rpEbgt5tXy+XLxiJbjplA0ohFEV9UpWeNJktCQXweDP/tASB5k5H8edenk6TKpwxvJ6+g9M7UbL1yplKKYfSufMQ7XcLNh8Yuhsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244417; c=relaxed/simple;
	bh=OPZ9iuD5D2fT9ftnnvoivM7bxLNmogEMb0KH/ESBW68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQA3On5UDmvDJEmyIQeNs9QWgHjuYzvamEieccu840rQMPhl8RrysDyvS82zT4ABZ79cWPJQL13XjOQGDvUsTn5HcDKr6+JRMfx8rfQ1afygQ4OWlW7v7XX6vT/nRakJ/v2MwG7wxi0/ztuCvrI3QyNC4PQ591WdOGJD7bqcnk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=M0bOROIm; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L35+fpCb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="M0bOROIm";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L35+fpCb"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GNGa6u915342;
	Thu, 16 Jul 2026 18:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=f2MLvU1vIGPx0BLHh7UMOuTb0nYYuogWn7MHr0KPG
	JA=; b=M0bOROImlPXEBMT4H+VLbHo30YTAZLgZftDwaf6ASSdaHpYhSJ3D/a8MD
	Qzm/TtS9qClU9hOkjNzVlVjugqfqMIPU+IS51ARcuyZ94OyQP/8L6wx6Mpewz37w
	4bvlxEKZNb5Ol463J/ErgHFpjRjGMvK1zByImPj8SQbGaqhpPLB8tjZ3eUm55bdY
	17+VSjaoEfuq3iLxCoS3MYSzfqX6mGsRPnymVC0bn1J5s159ZVT9qyGB0wMuFobR
	WSVK9SkgaG9NMZkCjyM2DKXZQb1tDVCXDyYMIs7ak/jhmssixotzUoK0ouqUw6JS
	IIeBDHmG+EWAq0DDHPbsRvngrC1yA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fex78bq4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 18:26:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AicGC1CIwQnuXy5g8RUalmHslFFyNNDleAeusXYLmM5GFzYlna4FCSrczD+H1eOW3CtD0so0tzsCaPYbZdj5X5qFOCOSXxOTRdCJejMzR9W3URcbfHc/56jyKAWYvly1UbjjK6iELQ+EUESOsT8Ca1I3weF59zVst8x5xdgKlUXqDewWX9PRYsUMYNWWo49r4oeTJmA1IzsKVHQ3QmhWIDym60ros2XAEzKP7ziifYt6FXDTHjUavFl+Arn2jiSnzHCuRkLIJlUQl7kLmPrWvRuICFvwzAOOxz7XREtSClHiiYvKOJGTFXJjMIFVaIYkRQqk/dZ/F7ZgpZRlA3cRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2MLvU1vIGPx0BLHh7UMOuTb0nYYuogWn7MHr0KPGJA=;
 b=Vf2pnDbvxbXgcgJypYKrF1yqgEwamZMpDtuetMsqXv9YmfLZTjy/hKd5iKZwBC5OgLEDzGSbaK/N6LS2OKhLqDobXk4hCvjRIg9QyT8cKyyEsUkQc5IMWBaXNhPI0/qAvo+W+dWF+Enr/EiaYApFxpzRuBzj9pAgULEYV1wFAVLUxPsbbQhjmvK3VJj1D6foXr1IH0NnSxYjik+tLCiAaEJV7TcJOhecWf5WePLbJZ09Fd0yTAnEYA1L3jviADMjywk/NgPoVngEWWWwo/s572RVmyPMdh6HX6uy0oxKO3S/Ty8EXDPgs+v/gYXmte+9CckGzyerZbgaCThy7xO5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2MLvU1vIGPx0BLHh7UMOuTb0nYYuogWn7MHr0KPGJA=;
 b=L35+fpCbwosjv4L/x/s9EiF5+BFC27hnrO6nr6wL3D/5ahUtzSbMsy3+xxw6zob/OatZGjOaXVGN5fbR1hJ1UM9cuKKpyZIxD+vgMUntcsWOemEQzv488FF0TIqlv8NLfpUSWuYwpYEqSwOZXxV7ETyhjIWnHOnJe2q8avH5i4s=
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by PH9PR10MB636474.namprd10.prod.outlook.com (2603:10b6:510:3eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 23:26:50 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::1f) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 23:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 23:26:48 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:42 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 18:26:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 18:26:42 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GNQfhw2435480;
	Thu, 16 Jul 2026 18:26:42 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mmc: core: Add post-power-off-delay-ms support
Date: Thu, 16 Jul 2026 18:26:41 -0500
Message-ID: <20260716232641.2659710-3-jm@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716232641.2659710-1-jm@ti.com>
References: <20260716232641.2659710-1-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH9PR10MB636474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2c961e-3545-478c-088d-08dee391b576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+K4HY2kYzg+w5VJVKx9/w1ajAk+NOtCX3ASkwvky1oT3QrYV4f80mt8Us5fNpmNIsQY6yCMYBdc3V5pD+qhu8+ewRLmngDbD0Xrd8in4gLwTp4WXsPuSEbEnBr8MrDgirlt526T8QP10izMcu1pBA366SR36Zc+pe9sKp1dmAcNGLgLrvFq+bP1L82Eh7tB149v5yog7U8vnml0+yB/E0xmyc3o01o35SAqOwQDrEJvAJBe9jCoixp0FgMSM/nYsx2iDhEGHAoA6izDA3LarbhLx/ey3ZKoFtumfz6TF7pxU/VdwKxzuFE749MfUCB7jKMZzfvIFKdfTaCWBGlcSLX0aZs4LmFhH5E8IOsazPUkb78BL/xB+qSHge+A+VVhl6P4idkAmeUqL8LyPrkaj1x1y01hh0MNURahfIExcdwiliwYKQh8Amrb9uKxnedxGoCLWR+ZsmSwL9XsZh7zpvm/S0KfR9Kkvyz9cpePhXhkZTHvazz4KUZHM64Wjbo845P+85A/MS0dYGg5PhR6DGiWYOY5m+cnm5pOnJ5kr2fSdTSThRwKP7/ocbskyujADb/8HRkW9G8dt+AwbjInFa7jKUDyYtBw4wHMDEdhXWIAf/1QAT5jjYUd/USS2HYZg4Yxq2KQAkHSInSJIUhullxdKPaaQifjjZVc+wcrfkwx8Bv6JQzqUUQtY6e/MixxJ
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Rde/rvQuSAAn6NN2LH7p66Eo9N2aLtZWZurx5lF7am/IbMiTNKn39faBjp/dtBAJg6ItZx4Qrjhz/YFVzQjDpb8jWGohExwGdlMXGTWmMtQ6eiUOkJbsZdYoxUnLwzC6FA9/kFIwy+0TSHl1T/mKiYkLtxPDQz1qQF8YRom2eBMWgpWVkUdpLX0O6ss58x5Yn9o/vgf3L/DrGXcfvkJB+HCTjEZm+I1UxwggnVGbZmrDTBsd1xT4IhW6ZY8XdPw7MjXKwRK2TNp20F9OG6rCEs5frbltagjgUribqexNOcU9YOxNohFDXiQHJqktq0po6bxTd8Gmc+kKg9MyGbxcrGpGKICnrG/SkeQ+TJjx5xj2vsGh2D6yBSvnF4wAmep2ogV5f/80Ckr+r3NZVvQsmBW7cCAtRpYFen9oeSengo2D+EJWgZRD6YeFLE7RtLO
X-Exchange-RoutingPolicyChecked:
	ESfyV/zgtnXwmESdpleMKBSDdTImnkc24PpVhIbcAOVevEY739BWAHjnHMlwBYt58eoVX2YTGugbSdjn7hfK+O5+nHZLUqY9m4j+XDKfgAsA6sRRzM4nUqAJSlpLyhY8VCkFOiWQj4ng5HVZtuTw/xQb4U7dlSVak6/o82pIz1ys1rMhUeYQEJuwuxJdNJUNLro1HxpgABK5/Izx8Tn69l+BBko690E64ChlBlQYyUKXoZGL4n08PNthrWz8YzUjZALOIrkfNZHbGwi1qjWtZ4yRvWAYD2Sfn01pTrIxFwJGFgAKjvVdLU/SUkShHHcwWnA1dJEklrl0rTIYX2kcpQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 23:26:48.6148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2c961e-3545-478c-088d-08dee391b576
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR10MB636474
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfX6L+0VSSaRM7w
 ILZUs5kGXbc/DyXv+yBq9hwY/kbHuWrin8tco1FhIatrE3GOn6uqowSvZLY/AMaWQd5vL/BS5n9
 Mf1geq1thjcUs9xja1kmVr/kQbn0KHDb3Vf2idwnOW5J7dbRh5zYt1qsvAQY5qsTbfJFJKcf+Dq
 MWNOGDznC2jdTYeSOtFmF87SGdwX6sVoV6q3uLkI5OjFPfD6wjfvqQn0vv6iREyO15rvOizmwry
 mPbkNhxBvG82ORJB3bE1RH6psNDCJYki85iMXqb6kFzR3e49iHLm8185opwWkqpxbWvBXt7GDIa
 sucF3I5OHuvtL0NwcUY63sc6n1FD+UOPUQRhJrVP4fl0d3xWborxIGdccWyYc0Sk8n6OjVvyQtE
 zDbNaFtmnJDqofObJnjILvRFn3Y3nkJgi+rEDflPGoTSxaUjrm97Gg+eUKsvQSXmoMWpaBF2wrG
 vq5Xp6CPk+ZFh0wrleA==
X-Proofpoint-GUID: BnIFbvnDjYK2C1I_f9B06SohcgYWQ4Nd
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a5968bd cx=c_pps
 a=+5nsKerQHvRPAoQt0ERV+A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=XYgKUNxwglpLbZAQICkA:9
X-Proofpoint-ORIG-GUID: BnIFbvnDjYK2C1I_f9B06SohcgYWQ4Nd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIzNyBTYWx0ZWRfXx4nDTW+wi9Sz
 PYOjFhQm5jC6mD4+gjZO76por803sk72cuWnvkJpEq+BaSiMXHSBZsPkHLU0zIQNqq1PKbdiu5X
 /dWWHhHyCeAxm7SU2BB8Hp6pOevYuDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160237

Add support for post-power-off-delay-ms which shall be used to insert
a configurable delay post MMC power off.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/core/core.c  | 8 ++++++--
 drivers/mmc/core/host.c  | 8 ++++++++
 include/linux/mmc/host.h | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 29e80e5f928e9..f9049aaf44394 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1394,8 +1394,12 @@ void mmc_power_off(struct mmc_host *host)
 void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 {
 	mmc_power_off(host);
-	/* Wait at least 1 ms according to SD spec */
-	mmc_delay(1);
+	if (host->post_power_off_delay_ms) {
+		mmc_delay(host->post_power_off_delay_ms);
+	} else {
+		/* Wait at least 1 ms according to SD spec */
+		mmc_delay(1);
+	}
 	mmc_power_up(host, ocr);
 }
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d4529..ea8f36827e41c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -421,6 +421,14 @@ int mmc_of_parse(struct mmc_host *host)
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &host->ios.power_delay_ms);
 
+	device_property_read_u32(dev, "post-power-off-delay-ms",
+				 &host->post_power_off_delay_ms);
+	if (host->post_power_off_delay_ms > 10000) {
+		dev_err(dev, "post-power-off-delay-ms %u exceeds max 10000, setting 10000\n",
+			host->post_power_off_delay_ms);
+		host->post_power_off_delay_ms = 10000;
+	}
+
 	return mmc_pwrseq_alloc(host);
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a101..b751b61b1116e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -578,6 +578,7 @@ struct mmc_host {
 
 	u32			err_stats[MMC_ERR_MAX];
 	u32			max_sd_hs_hz;
+	u32			post_power_off_delay_ms;
 	unsigned long		private[] ____cacheline_aligned;
 };
 
-- 
2.54.0

