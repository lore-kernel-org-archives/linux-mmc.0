Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609845;
	b=H7HDwRaIlf/RZNlgi88xYQivgIiWtHYbMw2FCzf8MuaawJ5VJCEd4cM3erp80//xVhiO
	 oyIzxJuhvQaquDPwctsmXUtT7wRsPR02UpX38I+VLucj4m8SX7OOP70Xe6FG6Tq/YmgYp
	 zj8N02cjntQdSM8Oc8NbSeGEcRNQJE9/Mw8j8tUz/dKIeSy2MvDACqW8mzMY2DyBVH1ca
	 RD6zu6UNEhWcgaB8kC5UcLAxweaHyLVtcDamipGR6Bhdkele5cZ1GRM25O2cP52NSPUDt
	 t68s2WmIrZkgzcbR0O3GKUvC/uzwaIyGJ+9bmXa8AK9oiqsNeRFRSNA5/Eoo4tmF+zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609845;
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
	bh=BfwrfPSMACCz53M5RHv1Ibi6VvLZrPl3SnByloFGbkw=;
	b=dPXnfA1CyUKo6iUqSaCniSFnZLbTBWBCZ6+6aU3rOc1Mr/nTKnxpz6NSjJ/nIZ/G8ZB0
	 q++ercad1/iinhBCbWEsC7ju90ceOYD7bO07bV9Dvn3NBcgWIJ9VImLhP+dQtlMCWq9sB
	 Hyha9awF++CT/gimFcYPOJWTVlXSJ1QlGyCwzpqWHw29E3pZypOH5e6j5vnZV1dG968PR
	 ufiDq411sa7SVSa13iZFbW9yu+2h8AkrHnuNNKcE/qHXaL2l90rEK9ZfWjHenc8IpRYCH
	 T5Sas2TuFnHmVwL8b7P3n6ru/SfBGCguuOfBDPJ2PFgJcOaJqIrI1KGDZ3/iH3kMqDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ud8+VLIG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.7
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010007.outbound.protection.outlook.com [52.101.228.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52307606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52307606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ud8+VLIG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X20JB3QfuU/b8oIokUSXEsNLDj0XWdzCo47GsWQxTZb0eTcttqI3Wl6P+yEkarXB7D3vcu1LOnb2kv2X1+WqPc9LGK2vXU1LQxnquw03+As3mPHcMxb65870gpEn/+xg1IuWwA3a0rDmXokUOR3k1CU8+0PYoC9+zyVHtrdpO9RdFz+Q4DQSxW9z5/W0fzKNaTAzYSxJZ7PVMPWe7u2ueGijzB1BZlHtjYyWgIYJ47F+vYEG5Byz92MaJI7fOzgPyc/V7a7JnZDaNQYjpbnXjQyKZTeqvNt7veK/vEo1LbDr2q2+STTFlFRoQgIDDIK8JbopLNEu3SAM2fIOH2S2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfwrfPSMACCz53M5RHv1Ibi6VvLZrPl3SnByloFGbkw=;
 b=wY0wzTP1G+RrKhPXdwCKUv6YhWapiXZRNIbUHvXM5Jzcs/Je/PY/sFiRoZiM6NeKVRE9go7c2DoXtpUMjXZjZffJ4gkikqcguHdOV6hRGMhJh00ENi2Ob0VOspbb+/7Z2pglB+wkRXgSy4Ujy6JmgqIX6JQKSGDj0HZtIRp3yP4hdA48JjEc5kk2rJFz4MielHV95cxISOUq5cnvlNsdONGWxlsRhc5Kjt6w87Ews9XRPaL645oArtPch/D4YTK3Q5k4rm7zLOPDvJCSgoTB9MADNDeXCQPLkEs2a2jiuK4eqV28HyyLBA7Zc/7qTVhcNWSCNHfcmoT7TFYrvCtNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfwrfPSMACCz53M5RHv1Ibi6VvLZrPl3SnByloFGbkw=;
 b=Ud8+VLIGwNA6DLuumqV3i6flhsi292mdHy8dH0wTtab9cTP6w2puvlt/aCW5MsK5Cy4XY9TMiIrV1iVuQAtU5qYNMQ0nHgLRB/FiF7FJBM9aH64MdfToqUBVkeAc8Gix6t5rh0vKOwa7mlSFLGWFa6W+p5XelugRga5Qn8KdqCs=
Received: from OS0PR01CA0002.jpnprd01.prod.outlook.com (2603:1096:604:24::7)
 by OSOPR01MB319733.jpnprd01.prod.outlook.com (2603:1096:604:4a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:30:42 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24:cafe::5e) by OS0PR01CA0002.outlook.office365.com
 (2603:1096:604:24::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 12:30:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 12:30:41 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.37])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 907A030014C1;
	Wed, 25 Nov 2026 21:30:37 +0900 (JST)
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
Subject: [PATCH 2/2] mmc: core: Clear the single block retry flag for new requests
Date: Wed, 25 Nov 2026 12:30:15 +0000
Message-ID: <20261125123015.3999-3-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|OSOPR01MB319733:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0229bc22-1f54-4d4f-a111-08df4aefeb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ObH/yxRKqmWBaaQ5S4jnY0EJhwHDIyJtbYPAlNu/1kw55Hnk+wlJCUzmkrp5bwJl1YHZxRi9bga1SRUw66W0QKF+Zwi7GwVunGDX7epsRyh+aMxVmcXI52ZGrs5lSECbYcbFr2FV2+pEwOj62/av7b+tJO9Ur8NLpgIReMn5i0U0PSdEZ433Hq2qJSEeFU8op04dczxVmVf8eVxHgVDpx9JYaOJgwjTpOPR4JIAFps4Lag4Ddi/6OP9cyiOyC6Kr06+a/nijfPpbTS85K94uVC1KzJXcQMZEN+wpSFVW1Z1oWYU3zDNuPoXZ9klgH977aStZoU5fcwPXC6Gh3nobs7UXyK5DTxoIleEvA1ch12RRJAivRghHNE3f7G3ZbHH9o2wEPojbVTueQYTgY4WucvgDM0dtOX4xo7ibWt77hX2fdHNOLM4hCvZzezoOS9tOVuqYkGtyqnJ0yfW8kWeE6hZ8LlQEVOM7OSRvXabploVoy7mnysLv73hxt/9HojArsCpeY8O07NP4Dw6YCfODGWwV14zewdWru4tlDMzWsXBeE7mo4Fvq0Z+8btwFqfjG4f6e/Op4LMUcN+uEXXq6l5WsXO/emAgPokX+DoC8uqRvy9Hs0h1QF2so64bzdw6H9Vl8sYFzsGA/QJcdILLyvenQz3RlEYstcu3VJo4w3Iml0ONlU+uJrjiZ91DF/Sbs5KGOhQnoC9T4Oz/FXQvWQob/dC+BYZJ/sQzOLKouT4dYC2N/oKY3Zs7HsN4v/eTU
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hRyWI9BPQwOzwHLJv1RPEuwxocE2ytqriV2aJmQKdhutoC5r2W8vb9Ca8uVg5SkgnQFFph7WkEVY5cjfPbHjKHS1YdSkjwLW09cAUFBd77Fohuiz+avqbxMcFRYtt/EqRJDJMr78+6V+RDvgw345Q5/hzF5RZvlFiRW2bECYVOpyn4IHrhwO+guzVEEA8uUDgF4srQo+PnMagZFWwcU1Ksh6w3V1ycTjXVvZIkH6YFHZL2IsomPiAsux+JT8p9VBjcFLchVx+3UddZk1QlLcDpNtfjbMdF+DzSM5kbogZ/I5jceeJyJFAZhNIoXbNYx/oRdEvWY6p89HkZHkA+j7Z8JaFXAvPZjjjyEEeT8RsuVHwjYoDWbxvP5ZBZpFZoj7PTL4c7yNxrYVR5qE6MFoeFLmunISpFdy3ha4gZwOKq8Pzq88RDAMPWJn/4/H2TQ0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:30:41.9475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229bc22-1f54-4d4f-a111-08df4aefeb97
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB319733

When a request fails and is retried, the MQRQ_XFER_SINGLE_BLOCK flag is
set so that the retry is done one block at a time. However, the flag is
never cleared and blk-mq reuses the same mmc_queue_req for later requests.
These then inherit the flag and are also transferred one block at a time,
which makes them much slower.

To fix this, clear the flags together with the retry count.

Fixes: c7c6d4f51038 ("mmc: block: use single block write in retry")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/core/queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5d187e063da8..5a153acfd808 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -301,6 +301,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		req_to_mmc_queue_req(req)->retries = 0;
+		req_to_mmc_queue_req(req)->flags = 0;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 
-- 
2.34.1

