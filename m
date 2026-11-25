Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609844;
	b=G6h86WcScO1P5Y7v3550BetbpmgSb9PqO/RBDxBdrxXmzj9NUj7tv7v+rXnAJtBskVbk
	 WiKjUW+3Q97+Glxpmws2ua0BJPw9gkNUChSwxQseQZkbpGNsRMaRl9WqpcdlfJHoQEmp+
	 lcDMEQ0rXF0w9lfsrJp1xhM9FhFGSPVJxAsQLXT7+TdznKjxy6eLQk0/rfskex1oMGr/9
	 VC0T4x+kmu/OiD3A4m/2BEAMPmUj77e5qbWXMOvSZ68cj4u2B34g9UG1b02AXa0t/vPvo
	 OkjplTCxhtE1/abCsxuWNC5CpmCE+uNbe9W3z2aQeuZSxCrvFqtUY0sep1JdTfd0ssQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609844;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=+CmFwaJRariwxhSpUGmRCUzpCSpSczPIyVPFrxQ01qI=;
	b=NWdMrQ4jZKihfjgA9v95faOwEYDQ+8j8XCFM/yFckbqi1nRI5KKBviGYdCiTYfwuoZxT
	 2xXRJPZ/R/WXiJJphIquaMxKyC3PnOwZ5BPlNg3HAJDunNp8vr/+/mJwxUetdqH8wvsuN
	 SfCcUzFt+1Ls+QhvbwOjq/gDd8D8c3EhY/9qMPohH4SsZRxPnfaEeFec+836/DTZBoVRu
	 9zTI4TTBqkMtsL8i85ujOXrEJRqBqSoKZcO3/oiC0RFPLYTkYE2UAB8Iurlv9bQPez54l
	 mUcn2U2ha6zQobqMyPZJB/w2N5OL7BtYN3B79Il95NzjTCBPKf2oL+rrtUULqFZdONQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Fz8F4t3Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.38
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011038.outbound.protection.outlook.com [40.107.74.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA51606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 12:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Fz8F4t3Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2t2hSVZMEDwlvunejKWeKwOOIFTmOy11Tj0RC8tF3U4o66jYQ7dkRgojtrMfGM4AdvkfOklY/m3zFyypL6Jyc90acs4Hedh7e9fXMTvQ6ncCg3jUm/12yJ3TX9gdqYPnNhtdCYdq1jTZtvIgGwzm4FJvf6j1sR3TcTLRfD+kqWsxzLdKCrgV7n528BnFf1ni4j23pGOritu5PKy5fzQ4ynHULGQ6RxbddvVnNeB7yDC4tLlkNptsELer70h9x9tSTmYEXx9tTw+i9mgcHsZCy6DIyff5BtOV+jCzQEtXG4EePozvW4ZZE2fsS1OnOHRSWo37l4JKj4gsMPNMsRjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CmFwaJRariwxhSpUGmRCUzpCSpSczPIyVPFrxQ01qI=;
 b=nWdrP7eXagPuOqC/GY2Cfugs/Fg0G6JMCflNztUW8x2vfzfccwKL8oaOOMlxbrASy7OMF63FNsDGyARqQDxDkJjeOmPxm32GDRkHgOcH+W9OZTzY15bj58mfA9laDZnCi62brjR490laq4BWpI+XuvOBLPQjg4a+pS1XvpfczUXqQl+OPoR9NaFHC4pB/VrWQ8a/fLEPA1RxKuzXwh2FAMfGjHR0F9ZIKRd8tOqmU6C4+vogcJT4jYLqOSIgVQRnhQ6rjPqV1xoLZfPFwJkKmXiq5hk5M8j1LagA6f1DtHFt3Grz10SLTJeAh5lObHa/KrtPbQynMSHu3j1NtGBDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CmFwaJRariwxhSpUGmRCUzpCSpSczPIyVPFrxQ01qI=;
 b=Fz8F4t3Y+IBjeYWohw9zFk1FszYKLRQY12660x2LwSE8sepub13kW7U8aglFjNyE3mKMRIYz8w+KtjEQzIsOodMXaolswbL73mXfyXXy7a9SnhZu3xMUoUombJIrj0s3CI7yvIFZjtIp0mdlRuaiRqLAFzaxGGBPuT/0atTVnxc=
Received: from OS7PR01CA0314.jpnprd01.prod.outlook.com (2603:1096:604:26f::9)
 by TYCPR01MB8535.jpnprd01.prod.outlook.com (2603:1096:400:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 12:30:37 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26f:cafe::1d) by OS7PR01CA0314.outlook.office365.com
 (2603:1096:604:26f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 12:30:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 12:30:37 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.37])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CB240300043C;
	Wed, 25 Nov 2026 21:30:32 +0900 (JST)
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
Subject: [PATCH 1/2] mmc: block: Limit the CMD23 block count on eMMC
Date: Wed, 25 Nov 2026 12:30:14 +0000
Message-ID: <20261125123015.3999-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125123015.3999-1-ovidiu.panait.rb@renesas.com>
References: <20261125123015.3999-1-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TYCPR01MB8535:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 070b058a-64a5-490e-c7b3-08df4aefe8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|7416014|1800799024|18002099003|261009223027099003|22082099003|921020|261028144727099003|261102123227099003|56012099006|10067099003|11063799006|261026121527099003|261022105027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	dJG8Z5jQTzVFn/22PGjpkKxtAmsf1Yo3mp+rT8436Rfw4qK+xKwUTgInlRiBqm9QpmIMoa286e+X/LeHnx5oFZxveTSDpcVSbD06RhwGaBVion8gSuDw6m9jOqGXM2tmU5O/V5SUN3f6sWsO67UZbH+VfAE7IYLELCnrPZZNmn3hmpqx3vT8SsPKY5Zoaae8U+4T9BUQv4lrr9C5THNzAsOmVQ2qIXyBHmESYXtxPo+JtXRi9hf0XCNdG00Sklt+UPWClP0Jqu+wPO/KK05EJDahvLhn69o7IR3IhPvNXJQH4gwrOs8mz/UuxknEOtw88umj3eAiK6vO1F9boR7aBfG5zXBMixeIJ7yJkaCMTiQ/nzjtl0Qr3R51CqJc8ifFkznpqZEvHDqxa9nUMl2rlq1IvSrPGPF1UwTaH2lnuguOOczPAq744YwTYHo57rmftIdSvFTQqRwUvPqEwWVFul3uZB+If3ydhUDfdQcbEOkTIf5QDxgmOe0kisyCEUgrfE/L//sW96zhFcvA+7qrF6mV09Ol67kpzFYYr1FaF7gSlG0q+FQsqspe0NL73NvCC/d3nOEj6iSDY8owK/bcleKBV/LApHxXfvMKB6qFPV4Fz1JJQipxUsrLpsHfuXxATcNIU9k8Ail3tei6YsyUpXcvj8wmYU9vdmzN46s/UOlm0PBJu0DlLpwz0uKSVpBwev6RRBSMqX64yM6FoowS5iWQ07cbJfLfgMGOVw2I23B8xusFjTQt9aM9Tw6ffySi
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(261009223027099003)(22082099003)(921020)(261028144727099003)(261102123227099003)(56012099006)(10067099003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4AUHueGL/AbQZ4qikLccSD0xhDxLbOU8AHRhAl5DdLLVBo7m6fSY7/zWePEC/s3ffRye791aWOvbtKdpjslFfVm13c/s7l1UyDufaiJ68gn2M8LxwOwCJfhek5SPw018IrBmtqr75plEEz7r6Rt0s0yBJ7UvjH2/DbC7Q1G9PFjlaYpDqIi1U/6l3YWDjGBouNupsDhnPkojVMJKZ2QQQifihWPiedCG6yTSkr3b6W8Cxo3g+MeOyEycZ6C9zIWu2wU5tCHv1kml+4VXCLuRrTteIUTZMg+cziRYnNC4VeWxz/t4qB7cVcO+bI8iVeXkfUVQN97IOG92f+WiYK13j+xIZAMp/MozbXaJeWpZ/mhEefKF3wzu34dyNYmqXYGrsDPXUYmBzR+TKebC5X1MN1hWNY/papWPFDmoIWCFFYTR6VnpHlwBC26hGGLIoqSf
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:30:37.3095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070b058a-64a5-490e-c7b3-08df4aefe8d3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8535

On the Renesas RZ/V2N platform, a 32 MiB write to eMMC fails with:

  mmc0: Card stuck being busy! __mmc_poll_for_busy

For eMMC, CMD23 only has 16 bits for the block count, while a 32 MiB
request is 65536 blocks, which doesn't fit inside 16 bits. Currently,
the driver does not check this and puts the full block count into the
argument.

To fix this, limit the number of blocks per request to what CMD23 can
send. Round down to the physical block size so that the split stays
aligned on eMMCs with 4 KiB sectors.

Fixes: d0c97cfb81eb ("mmc: core: Use CMD23 for multiblock transfers when we can.")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/core/block.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a02bb2fee874..be092d6291bb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1383,6 +1383,15 @@ static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
 	}
 }
 
+static unsigned int mmc_blk_sbc_max_blocks(struct mmc_queue *mq)
+{
+	if (!mmc_card_mmc(mq->card))
+		return UINT_MAX;
+
+	return round_down(U16_MAX,
+			  queue_physical_block_size(mq->queue) >> SECTOR_SHIFT);
+}
+
 static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 			      int recovery_mode, bool *do_rel_wr_p,
 			      bool *do_data_tag_p)
@@ -1441,6 +1450,10 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	if (brq->data.blocks > card->host->max_blk_count)
 		brq->data.blocks = card->host->max_blk_count;
 
+	if ((md->flags & MMC_BLK_CMD23) &&
+	    brq->data.blocks > mmc_blk_sbc_max_blocks(mq))
+		brq->data.blocks = mmc_blk_sbc_max_blocks(mq);
+
 	if (brq->data.blocks > 1) {
 		/*
 		 * Some SD cards in SPI mode return a CRC error or even lock up
-- 
2.34.1

