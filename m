Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609837;
	b=koZt0M931/dgu8vauuRRLEWe3d0BSRcwhsTYg/plEKraCiuV7tZwy429GwLGTE58PqFg
	 o9xULvgO53fu+duIn0NxvkPh04mOxFSOyoeJiOroPM21DZ1UYazWCuMVugvviMouw8EO1
	 kJIAXwMa1oM/Av/YsUoylUuBdCcF8rY6d3OMT2v9xjBzKPpbzd2tJdfswqO7i/eFTVsyl
	 memeoIaXBBAdWndo3FwJ8dnkaGXs9jZeUgXZF22xdbcren60yIvLJnNR6wNvbIe9j67E3
	 +nr7uCIut3vGPJGKNPNk41WD7uMMm5GtLnX6q/+8tOwfV40aHj0VhKmnpmD4GTXHoTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609837;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oiw45g2DcC+W8YyglI1VJBpldE6LoaPc25Za2fkVxr8=;
	b=0hHh7xWwPJ+ORsEoK2CUjfKTYJK1xd/V0tTI6zaNfAjSgaLBY5rKED/5hkseHUbmFp25
	 +dxzrop80MLnw2bGMBzWt7sqvoWqkpgE6rXpr9uM0C5AG1Dncf9QAawLTn7rd/6PcB8Ww
	 DJdAEdTObIMYVYBMfpHU1Veq8DgTEqbEAx6YOu3nXYCPI1Kyde/Kdkf2OL5mAYOxyrLHU
	 z4X3LCNvxUy9aFSRgX8Zprpat1hUd9KMHSNNq02hGGmL0ES4+rG7pVQ6es9Shu5BBis9T
	 FMbTCUdMfWLjvERAPiboVyyeXc0V/ocRJMcP9RAStA2b4t8mfk/2tMZzTQ3odPENqEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=WdieEsvt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.39
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA0606A326
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 12:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=WdieEsvt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERV+aiP/pGJ5BkARQrDlNmRgO7/6tl+ED4LDTwXpz4reuJqNrsHj/cRIC2ux+VmUfO1SfqhZzHc/VPNB9CmBfhwOw9dgxqKwKocADvRJCuYKwy5sDVi+2TEl2adPmmnCegh/O2yrMyYSDKHgWBNU3Tn+h191vKDfiv0jQA8wBQFm8ZQlEJlE/LU4RCMR43Ahkky1WrIHvR8+NaeVUnZFjG0T4Pks87KwarqbrXjdiHpJoEfX2b2XJ9lYBDZmjrgQ28OpaUjZ4/0WZqvL8wkrB/DwdUrs2dUnPU0UVc3wf2RCfhxt0wwgVr9B6imqdnHQuh5fv6SDe6ONI83d5kLGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiw45g2DcC+W8YyglI1VJBpldE6LoaPc25Za2fkVxr8=;
 b=f7JYdsVCFdOtPIWtCemRiNslgHN9EActl3Dq1VfsEzSWKa2bHci3uabYTjhEKNNTQT84xRI3bnEM2jRSFXBX/Ius3+pFAr8AIrt6AdAbO/wjf0vwd4tM84Y28BIFGCunkFdcB+BGIk5SL2xZrtd5YTPrrzOazGByUyQF0WYxsmKaNLwlrijh7HDKnMLGWh0nrvOCx64x/FEOYPTsYFKyywLsDiWs1E/tXXprKZ/ccmz+Lrh0V/SpffVQgVXnOqOCEkOk7Q5raehc+hn2zGcR0sUxaP78/iPI6txDPN+dVbk/rET2eyp9jFOxP1cVscwRrzUuIux2nCWUPbXh3SQQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiw45g2DcC+W8YyglI1VJBpldE6LoaPc25Za2fkVxr8=;
 b=WdieEsvtuC+4mA4iISUU1f5JR9ELmp90xXLltbKyQXdXLxSjSWhgOPifFj1lRahknaFuiaipaRaXa3Ea7ayemsBzWir8VuA3vy6zDV+oxSPgV4zAwTGq6Ci9DYRk3rn3We3Zrn1etbXEJQrB/i/AZndYmJaOqb+6z+0bmOyUirw=
Received: from TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::12)
 by OS9PR01MB612879.jpnprd01.prod.outlook.com (2603:1096:604:539::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 12:30:32 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385:cafe::58) by TYCP286CA0209.outlook.office365.com
 (2603:1096:400:385::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 12:30:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 12:30:32 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.37])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 18C85300043C;
	Wed, 25 Nov 2026 21:30:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: ulfh@kernel.org,
	shawn.lin@rock-chips.com,
	ao.sun@transsion.com,
	avri.altman@sandisk.com,
	hemanth.selam@gmail.com,
	b-liu@ti.com,
	raoxu@uniontech.com,
	axboe@kernel.dk,
	ziniu.wang_1@nxp.com,
	mateusz.nowicki@posteo.net,
	andreiw@motorola.com,
	cjb@laptop.org,
	linux-mmc@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 0/2] mmc: Fix CMD23 block count overflow on eMMC
Date: Wed, 25 Nov 2026 12:30:13 +0000
Message-ID: <20261125123015.3999-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OS9PR01MB612879:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd41e356-99f3-4b53-963b-08df4aefe5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|18002099003|921020|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	khAq6qAE1dmTQXQ7GZqFccep2GI4AJSjY/AZ59i44FgatzSUIFH0tO7YXwqMJb9CGTI3i9asDEGpkp2gIQ6PSjvLyT1W1uuuN+8Gs4LCPLjB5DObZZi0G3mj7Iw6s3auzYGPps//BxNMWhIcZRz8p5wLntH42WWgx5cR5yp+X17LcQe4mLfgznD1QlWi+7JoagTOrbioHFPWeLnH1VxXtKBef7HXrVkMbax85KORy4cZaZKEIVLLb9JiKOfAxqzqqIST9TWbuIvDgoaXx3wtXdt4gA5jeD+2hZGqX70zdm3RaX0v3zOEmHANQxl7Sb19HlF5jAHsYskYvTA2ulYY2y1zk9f1tWQosu6QohWcMlUXjBoDWTYL3obx2oI00kJVqyTzlf2J6cqynNcWE5pZ0Dyr/CgsKs3ntQQ8yeclnxWr5JZliY1ruLSXWXJd7j1wCIu52Qr6OEfj/v+vOh1a3YMV+iSjVmHH9EX3pm/w029zWB1xrkO2ARvOJy6NAS8heYcNJTSZKwJgJwgE+5PJFXC0vFn2KotTrQ+SukpeU+p/Q/JagSbjYQk2nvRXAKgpVxk5mwe4kwa+WTmWam3oJ+5L0dQXf9Nkq6lfabjt0Kng5je+R0OvOl08jtVXYVtL8HuxSoVgU6aFXxqMI+ZhH6RzNsdtbdgeNcmN0sOuJ9x/FpyzyLE3bbneFt+XEdId4obXB6tSAWTXZchpcdr8PZReVFoYiFrwL2Xu82V/WD3G+P7ff9UlqRXwA4hgtbBq
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(18002099003)(921020)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6OPCtvAvm2rrV/k/ApulkOaSopyTksQnYOHHfmWpeqXMW+mYpN9/MdBXBzT8QzlZBi0GSt9y0p0TlPUBvXBVTiV+dm+OEIewsrj5AfF1aQsPnGjLjbVgUc9fRZMDPdjckAS2vCgkJ363THjk7Lk6fnpY2ZaaoE3hU1D0HdiPz05d5lbxEswqKdNvTD8eVqUFiDqPdxxYbJDaPVBee8yOdgu6kZPxZ+Wew1eL3NcK8AhaKb2rfQXaIOcuYjDdD3s42Ue23NiNeiYyjE/cuiHR+J46G1jWCR4NwVlySsQ/5i2GALZJf+PCKr0dc5mNf9rxt34DCcz/OifwhdpHFueV4Z83xAip4XMosydfdlH+XN7q9u02lR+BkaqxzUMeywN4fyMZN+igJFfBcpZ//YslzJQqkRY/nDgBe+yVQY00hiPEWM/IM4SMeEnOo24gHSEA
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:30:32.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd41e356-99f3-4b53-963b-08df4aefe5e3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB612879

While testing eMMC throughput on the Renesas RZ/V2N platform with
max_sectors_kb raised to the hardware limit, every write of 32 MiB
or more failed with:

  mmc0: Card stuck being busy! __mmc_poll_for_busy

On eMMC, the CMD23 argument holds the block count in 16 bits, so a
request of 65536 blocks (32 MiB) or more overflows it.

This series fixes it by limiting the number of blocks per request on
eMMC to what CMD23 can hold. It also fixes the MQRQ_XFER_SINGLE_BLOCK
flag not being cleared after a retry, which was found while
investigating the CMD23 issue. Because of it, later requests were also
sent one block at a time.

Ovidiu Panait (2):
  mmc: block: Limit the CMD23 block count on eMMC
  mmc: core: Clear the single block retry flag for new requests

 drivers/mmc/core/block.c | 13 +++++++++++++
 drivers/mmc/core/queue.c |  1 +
 2 files changed, 14 insertions(+)

-- 
2.34.1

