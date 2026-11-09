Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794212328;
	b=x2A+LQVDNo88zIwkW/jWg1EgPznmWeKzoRGXvOH8Hq2BuIhcxtH0jS5AD1vQFQ0E6v76
	 q5uKdDtaEpm8zuIOcWw8Qf5q62SmQnJPe2J8sdZ8LsKsK8VRf+5CZZWVNmt2Kte1QwYMl
	 NahdXQqDBK0iZz+bZ/5oW1NWlUSjm8lFcsSWq8KnWDIU+j0bzuaXVINc5XnL7VjoeiHH2
	 nsibqFcekgKKbQxn/oBSkExJAfxGRRpMVhfW96iO2RUnN7koBAyAGFmhBXn+3+sqrNeuk
	 R6iXXSO62Y6CL+Ydfz5STSMPrtJ80TAfxXjvH3SqCzq5keuV/xGd5QUONC0NQsFYFLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212328;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4fho7gyXTyyDTEAxNAdXSeAxwYxcDT20l7bltJCIKn4=;
	b=LuWbRQ63tweJHpMQ3akGysz2epw7LDztreBKs5AAF3MGbgeVoFHCTgXOR4lII+4QRgnF
	 axhT0xnaQFO7fhU14gOtzMfhjnGumKAZcWGbJAydFrMMOjS5llv23hk4qZBDCnNKRv3PL
	 NdBitSI99ZUzwWMBOALARAM+BcS/eA49y+bV3srM3uQPMj6OMZWHISEE0sQ+YpI2+bkwT
	 3zB28XCyGqoehmgFfD39OXHeQDQjq6r6RMVsOqTR5KS8nnuMGLlKgu1Tk39RpUeMVU9Wy
	 tTE/aRoYYiGjSdqKupHsQ8TGQS8Q+rdVw/4LXpDIPcJPJVwDFslNvpJgYaZfQUhezxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.100
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D8606A33D;
	Mon,  9 Nov 2026 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 958D8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA4mIRgzll4KjYAt8h/8ODEDnbuJM2roH0c/ofy/2s87SQf1eJ30xupgCtew80HKSP6SU2TnY2uXHQmx6SOx9wI8Incjsg6dL6MJ8+LeEpwqCY8c0tteQIY0zZ/L2o0dRi3pZXqAlyTO/dh5dhutd65PwQA9pWwauX7ZrBBeSLQY/4zfAQrnoJo26ErZPfCgnbL3OmJVeqI1Ws0OAVXlSsp+zcYNrMVJIo//C9CAcFhTuM21anCGsSmpXhsm/uosXZDrnhCiSFVK12pCBdyCAsRUJ7OQnyG6o0jyS9pgB+4VxxwUpQCLaTO/Qe2UUjHN3ft3L/Yz6y0x590AeMytPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fho7gyXTyyDTEAxNAdXSeAxwYxcDT20l7bltJCIKn4=;
 b=SRJUZC5aWOREWbR4SXxVz7Ue5+2GSji6aRMTQDDubs1LioO3ZKPBQU8DyJBqAsjzKnq6bBugKKdtFbCfLpckJ7XG11qdCbaKFR8K7dmUrwdfVQ5dyuE2L00zhJvMQvZMb8owGJMEPzEC6e4NLvb3PejvjzprdyZEQKKLDbEamfe7W7QI60Q2FtEAvMIyOGMj6qMD74fQbyzFP7GP1Oi74LRpWdbh0QdllyA/CRalVVEDHgCJ7DiJh5NXlcWx3FhNMyR3eBRWpNdW3+EORKwITczj4HjBUwMJsO30Kzjc7P2c4vTS/TDMeOqOWghqWKI/kA/dVPwaCgDcjpcGfUwrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:18:29 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0592.010; Mon, 9 Nov 2026 08:18:29 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100
Date: Mon,  9 Nov 2026 00:18:13 -0800
Message-Id: <20261109081813.3846-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
References: <20261109081813.3846-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: ba828f94-20cc-4cb0-f1b0-08df3e3a090e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|52116014|366016|18002099003|22082099003|10067099003|261102123227099003|56012099006|261021121427099003|261021123027099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VZMdK4AX7piBkaTkSbFOsV2pae0WR2ZSy4e7m4rowgsCMIue+TmkFNSQBv+OMT59lk5mRtZH6RYm8O9OS5LB7IMx+dzTUjhqQXfkVCrxTZ4lymS+EnRjLaDIg/CU2vjk8DDWBY505rnOwgYN5vEJsFDjkkI3eyWAS3LBSOxCpwuiZVkqi8VYLkWYKX7l4shKMpGCcG8jpaNXIS3ytQUTnmPFB3X5196DieVEAvw6EKThtlZttaajL99n0Yd8PpkoX6G8WF5fOCvI6ANSCAxfNSToLOuYreqx0EaXJB/7ESM5dh7wMWREB1ccGNLLIhcmCF6in3d5ZZKQLR3FU7TOE0HTb/vjTiU3G7WSl/2HoayVKsdMboP/3AgAF+JblZrgPg5a4EXJC3QRXDA22x9mY2RFeRbfpVIIp31SE8v+jJUBRN2tjbhi1p+l1FsMkrgQ5li5sQ7Vl+tyaq6X/QIrMOKwFC027lfr6LzIaIF+ruHFAcbketg+/WnuVq7eXwcAnwTApafW1HcxCDdw9YnQl+Fxy1+5Vd7AboZLI7a2l72WMGokDvso+zYY1gg057nF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(18002099003)(22082099003)(10067099003)(261102123227099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75c7lHCI3jbDc4MlRV2PIR8+ziu17nj/SRaMIT1BsmieWpEAEhQyS/wydnQ/?=
 =?us-ascii?Q?S9YjRwiKB7ZLfc+bnW2pZG3Cr5e5IYBhKSi9VzqnwQGnx7+o3Giyxi0Rz0Oq?=
 =?us-ascii?Q?dfZRngZqOrAix6altfDMGVV4/JpZy1Sm3HA8lKcsEcrU3LqX0Z/8xebCjwGQ?=
 =?us-ascii?Q?umKXokg+mYqJwC9r2nnqSwJTWNy0Rj3ebbS38GUfHjM3gqM1lwluNaILqQHq?=
 =?us-ascii?Q?YudwKFpv6k/UaS0UrOh3c3ios5tOiEOOriqKY24k/jZNxXpK/EzxdSjRerVP?=
 =?us-ascii?Q?xujWxFazCUmEq/Di352K+FnMaOtX07+rwVLKu/DWbwUmug+eeBJMTiGwVlK1?=
 =?us-ascii?Q?F66Wryso3kzfITXUbmK8EYaNYLhcJn8smtdiGTzUkYvTHRGdXKJc1BoQDvMY?=
 =?us-ascii?Q?2IETx7HvFBw8BaIKRYA4EcCYTkI8o1XUz9EwfJouepcLSKlmzvG4TaTAWS+X?=
 =?us-ascii?Q?gopZHCT6xRMUFqAwXkyScMzNZYZEKEY8WoTJSEDLp6da9XpM6w83dkw/wsgB?=
 =?us-ascii?Q?6JmY0ctxfE/2rIiO5aX/twuK6t0cBks9g+9jU1a+hdvMJckop3tTEMu4DcFi?=
 =?us-ascii?Q?TyN9gtVFOVC93nYEF/PietDbHz/KSQNjMTkIs+45e1oeKqS3LSepRrKMayJm?=
 =?us-ascii?Q?+Fvvmmz2B/BYAViA13tRgL6WiNcU6hxvOp9N4jyddy8dqwTdGJ96B8/zlT9X?=
 =?us-ascii?Q?+OUgSdXwqMRpYWFoZ6MQ/sgpl67RAV6jjGafov5JybaZMCyrndHibhTh+nWk?=
 =?us-ascii?Q?3zJGbbMr9wb43CfjCgkoaimcMnzV4j9mikScTtZlitN9jwCuetLjd7236X92?=
 =?us-ascii?Q?u55KOSmboKSOJS08NWhD6eQAj3u6fWkCcdnpAO31ky0pmqYTq6z+gKPgN+sO?=
 =?us-ascii?Q?i9FLiYYujT8HkgpwNR09v5msmSJT+EscLnrncMk/GDE/U25z6zCyA7+z2MKF?=
 =?us-ascii?Q?AwvnAqkC3zuAXj5feWkDnCMYJl+JOjFKAItde1CfPjSCgQj3ShFVttoGPlyE?=
 =?us-ascii?Q?AUpt/8X7KFNkTYoQZnwhDedtdFmS3+1Law91pumaYRQ0GzwDJjZ04uYv85Cl?=
 =?us-ascii?Q?DBCr1Own4gQcFJ0XB2jqoLM8KqQf+hihyEWF8N46fOCo9RFtmWN6DljT5ruR?=
 =?us-ascii?Q?2sExkrbs+EP3j+hzyjBiF+Qat7jV4OZLSAuEW0ebJkrLiwdqrYDJM1LmPyOp?=
 =?us-ascii?Q?KnbZxuyd23Aew9yGJtaV9DEsv/3qkmjXrCN+cauRRduiwfJcwzMoiMKm1qnZ?=
 =?us-ascii?Q?LViOIojPywcl8/6cNAZHV3o8l2EJToU5Bium02+BB/zY9MqPWnhCiZQv1LbO?=
 =?us-ascii?Q?LkKSApgzteGPysTlK1Lm3pv0oOYmE4a5hRK9kyEgTwUmRgrBNrcFiqnj7XeH?=
 =?us-ascii?Q?Au4v7fpQTHVX6JntbqhrUJ/HO4pmgcLPsaNjixY+cpeVibFmNxye6PwyIRU+?=
 =?us-ascii?Q?nHJNTU4E+ahZxmByJkZnCyWPAtG86Ek+sw7vWUZo5KfN1+yKJMOVbVjdC/z0?=
 =?us-ascii?Q?QgYXRhbzcR1rDdXzHXZ1AW1Gnekjth3D8nFeglxdZa+eeqNI0dVjPshCJCYS?=
 =?us-ascii?Q?glPYSaBGqAOKMko2RUShzXB6YWJSnfMesWpdj2CF6xeccyjex5zv/5MmsMRG?=
 =?us-ascii?Q?4q63sW6sBsn+0FKHg30RdAAhAayNVgmiz2PXS9HORjQH42q9CXttmNFf6LQc?=
 =?us-ascii?Q?Q1pk6DMgmPJjh4bSsyCP07dxRpQoTxH14oQCIhDMYBFo4aJJ3WwKPPRPbYfc?=
 =?us-ascii?Q?lSrE74lXqvfFSvMQ2qnxthOU+5kQ7PuqRjo7NvjIow8Xh3gGtn5/?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba828f94-20cc-4cb0-f1b0-08df3e3a090e
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:18:29.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCePgwdi/kIikjeHsRMD3TUKUqiIRvNEI57NgkwmOg3LCFWQnIdQMQbwVA3vDvXcPpisKYxvHgejtEg3ckvPPPAz6OZlbCV7MTORjD+dMVnIMnJFqGHp8GJjQ7FLccIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Add a cqhci_cit_ns member to struct dwcmshc_pltfm_data so that platforms
can set the CQHCI Send Status Command Idle Timer (CIT). When it is set,
dwcmshc_cqhci_init() passes it to the CQHCI core via cq_host->cit_ns
before cqhci_init(), and the CQHCI core programs it every time the CQE
is enabled.

Use it to set the CIT to 320 ns on StarFive JHB100 to improve eMMC CQE
performance. Before/after dd results:

before:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s

after:
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 249055f14162..2848dc39be82 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -283,6 +283,9 @@
 #define PHY_DELAY_CODE_SD		0x55
 #define PHY_DELAY_CODE_SDIO		0x29

+/* CIT_NS for the JHB100 SoC */
+#define JHB100_CQHCI_CIT_NS		320
+
 struct rk35xx_priv {
 	struct reset_control *reset;
 	u8 txclk_tapnum;
@@ -322,6 +325,7 @@ struct dwcmshc_priv {
 struct dwcmshc_pltfm_data {
 	const struct sdhci_pltfm_data pdata;
 	const struct cqhci_host_ops *cqhci_host_ops;
+	u32 cqhci_cit_ns; /* CQHCI Send Status Command Idle Timer */
 	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 	void (*deinit)(struct dwcmshc_priv *dwc_priv);
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
@@ -2412,6 +2416,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
 		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	},
+	.cqhci_cit_ns = JHB100_CQHCI_CIT_NS,
 	.init = dwcmshc_starfive_jhb100_init,
 	.deinit = dwcmshc_starfive_jhb100_deinit,
 };
@@ -2459,6 +2464,8 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 	else
 		cq_host->ops = &dwcmshc_cqhci_ops;

+	cq_host->cit_ns = pltfm_data->cqhci_cit_ns;
+
 	/* Enable using of 128-bit task descriptors */
 	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
 	if (dma64) {
--
2.25.1
