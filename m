Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122B418A22;
	Sat, 29 Aug 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028993; cv=fail; b=ZQtx77NdcCv9zQ0sp63k5ZsZr93QjdscKq/KcrsctuRjrDN3bggCB4VWwGw5m9t88SAFKQ03f/a3VfIMhT6fGPrcafkDSOLwM2Te5Ltz8nu2xI4VLm39fvUYxDMp43ySanjhsidSIkTViuw6SDJTtdRnHlJJwclJSzRYrmBws44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028993; c=relaxed/simple;
	bh=tCMXUeaBrrg4qOo98h3Nt/kqcy52escRntH597ghNvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1Gu9WZyLXtn20fQ6QH3BW+9I/q1SPif/qVOwA3jgiRU7Eg1H/KhR4k4UF2rTvQ8hRHBeh195kSPlaDo/ogdUYXuD6fbsqs6k4HEmN0mWMD+ck2IaghqabqOXJu0moVxAzhxnsijI68F73uPnQIw7rm1/7gzw7h9eiX9Mcpz0mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RAwZCYLx; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RAwZCYLx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivx2ePBXtIj34ZCkVNq4MFsdDONKSk2shJ6jP/6sQmRDPe3HKx7dLWB/t3AQ1JUL5q9KlL1cjkwptGLEEpJGFR1WqAqmPhWSfzarDZrbzQ2lTxhKP7mQW3+ZoJRvdgBdTXJV04SJEzLixVbzwKjPWAlTtRL/IIbCSpyjTW1phnCYvk7XqsYJY26Y4zzeLL03G0XIrYZvsW70t0AXJsJ+suNXDkmLV0MZLXOoxEum4w5EpOy3rE/D3/OgSTUxEc7KYhIamt6VcHhU8eLNlQ2d6w/lu5WhtNc7heqLKOJIPTmWCOKeUWDjZz+a6IbHZ0BGu5iNMxiGYJ7a1xEuU4xpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=FAS4c/KocBT29c7fWcLGjid4zw5sFZc4FPS67V0UbBYPABTJ5EokobWE9n/h8co455wEE8lKJ3X7CimBRkF30ONtjnhGJHAVAOZgS+RCNlfk/pBy09+oAe5J4GJ4Bb4CKBgem/sWLyyAqK/EF4wuL7QD7mBlKe3kipJwweG8v4hRaHJutoanxg04w9xz+P3iBrRTM79qGshKFSYouxQC63aXr2auZu/hPvmbuJ4Du2vegpb6BKKhF40oUK+AaITTZD0XT98HjoFXwC3jiDwVnw2j/zTxCRI3ZlwCK/kpePFa5D5WzcIBCgqX/Pvoat5HGDgt27kOh3higz2jRAarmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=RAwZCYLxCIiAGkhc0I39VfiyAKOU3nWdsVoL5v7eHkukq3DSTihZedwbB2jTXU2oJUl6I4v2Ee/WQzQpii4sC+gilIy6DiB3DVPOd6BDhk8PZtEenlO9HtbjQD4d2qr6wQrmDV4NhXG6nWD+aBjMAGDQx328v78SYhhyNCLAW2jLRLdLP3ITtTSuPPn+3bRl2r5d9A+YYnOHxz4dI8r/QfGkT/6yl/X9bp1hIuYTmuZzzUwHaaAMrFgQh+b9cZhHG5WQEJ1QzkAka9F+qV8oucdfgavJRan6EPC/Ebptyb+N6kNHhiM1JjMsSgffDWvF7VaLFvHwYQlr931Nxlh6Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:03 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:03 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
Date: Sat, 29 Aug 2026 11:42:45 -0700
Message-Id: <20260829184252.27644-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7fff13-2eb2-4e83-97a5-08df05fd5b99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	JRz2vF4TS1Dxi1T+UKJUIIPr/dPU6O/iQDMJPCWGN10tWGZxcV8WvYRgTBmFbMw98+i+UjIYQtRQy9WZVZ6o5OcaSGhMcWxP0MdXE1igg1XPEGBCXKfrejRwkzvvRtgQCqqmnceN3sPBvj6z4d90FbbZG87nG+77GypPzQ1ltR2iWQZWE+BvUlqYHUt9ZRDPgI0Up+Ic1O1xX3hgaSbIxNO/MBNVQ3mZcKHi2AHuBX9Mzrz+I2lzrtPGPTqWXgd+ZLNBW11yJUDuMv1wOyTeRLm37YDK80DLfXhCpy1lL/mpz0gNFgskYDJ0FrNInhMO54r9xZKEDps3Xpn/5iVKQWLH+MAHBA9S+qGKnHfrU3Plf4JhlfgLFDM74K3Cm6lp3z7XYkc2gPGj5MruMbO76wTGehMFU+71n9Hlvmmo6A9JIMpII4xkqiO+Ml/7wGNXnegen6hl0tyWfkvNEfG+vwkhizD4jcBNo6LX2A4zTcQkwp5bpGvI+VDNZqdpRxRx4Hi9cxMiX+Ca5iqpVkLKYAFjjnmBILIfCT0AeM5oaOzf/jE++6w9f2nf4TrSMk7hR7iOTjQkGdZt8DvkYkMQKycwS22w3Wbn2YQamkfnr6mOoQ84SkFq2XEmwVXGZJq6KrF0BY1FuhDg8X3TXjJwZu2XMcxEg8tibmwHzSJKDoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BDs+N6FZ8Cxh1SwzKv0nPFssR67dX3DyQJW9BxmTH5wa+2jsmUCDCluJeaf7?=
 =?us-ascii?Q?8YOv+QjAWOyUzyfaz41L4RxG+xxxsTezJZAhSElAvAsI91ENhyCZiFCbc5hX?=
 =?us-ascii?Q?rIhC19nNUK7YaiFxZzNvkZntfKnWN8AM16iiroPnyy2kAvnG+koZzSKXzQS1?=
 =?us-ascii?Q?IzKN9pEzYHwtQw3doPabkKl3RHR2PMJYKpc9Ml9t9l4lDZM3hth0SBchTHQy?=
 =?us-ascii?Q?mXbEwR6aP3FL46L4U93aSM4bUxMiRh6oM5zAu4ZibPLxyRWAewc5uKtmLqr8?=
 =?us-ascii?Q?ON8bbGZxuTcwnbasIJu9je+DgxiRJCo0bJG00mfvehT5Bl417P9uUwVlrJ0c?=
 =?us-ascii?Q?G/3E2kgj3149dWr76hglkStkJmB00WsoxZc0NSbB9FMsJ0qc1op8Su9s91+/?=
 =?us-ascii?Q?LaVdLjvKEjMPCiifaH4TVTDpZfHNbawVndOfRYAwm2XaGHpulUBXa9vrROCq?=
 =?us-ascii?Q?4fmJGrB0xIo8i6DN6tI/+Q3x3ee83nE7Z0CzSRM2wpZzjKq1UyDVs0zvjcZc?=
 =?us-ascii?Q?clyzOhg0xryq5c3A0NmTM7Z9c671Uoyi6jm24SWiS0aVUctYEySWV+eb7L8l?=
 =?us-ascii?Q?ipIMO1aKKR/EOHZJowuN9JKJg5OApsAH7HGec3bQXWczr/5pJlQh3Uljadha?=
 =?us-ascii?Q?C4y8CNqtZ7To8qEhXCkENkEzo0PqPbBcf9eALCk/BnggW9bnzqb66bz8ZQNX?=
 =?us-ascii?Q?v/P7KpSUGaXbEtQFW2ClVnlotr8uy+VHtzQ/WU6vyg18p/wFYx1Nf1tkTe9n?=
 =?us-ascii?Q?iaY072zE90e86UKQm9AWDt+EQ2phNybGNBf09JKkSiUpmZG1fIeXxRFlWp/h?=
 =?us-ascii?Q?hT43C1pvJm8t3/zk5aL0cuzxBB25kXa2Fujq4P4dOPdGIkujG7d/3PP9stMR?=
 =?us-ascii?Q?qz2nrT238MPGgTlQ0HOTRyY9XsWa7nZ8U9g5gNILVe+9dNfhTa45QcZIu5Vw?=
 =?us-ascii?Q?889+MNQFU8SkR8U50l6AkhBrrflLXrZzOeic1NZa8X7YI0ftXGpR/qONGBax?=
 =?us-ascii?Q?9/c8Snjrdd66l9egsF8gSr51/fFfSEsTqFPnSG2ov2Pb70gPCyKdUmhAAWQM?=
 =?us-ascii?Q?YJEQlHNu1z9GapECLVqt/JOJHaVDefCktGh95UPXy1QnqMaAlM8cQfRu/mbA?=
 =?us-ascii?Q?vqYUdSioEnou+odwg0xHO9rgzi2q+nwuDcN8aVOIISPJMvqHcrf1qyxDWmuI?=
 =?us-ascii?Q?+VBWDNta6dH8ePmalz+t8bhGMwzvbIEQbTuGg/KDzHSY/8t7FvJfH/fGcept?=
 =?us-ascii?Q?+Zpq+3LB5WzonV7/I7FDNXxFt0KSyQuW3uA9hSKeelj/o8q/dqItv3icaXO9?=
 =?us-ascii?Q?V4HLlw80wxcsakNqlG/F6+BpwFCyw0A+5ke0rrRhEmG/tFKjlWigvsxAgVza?=
 =?us-ascii?Q?nSzfZ5ho3QevX4DQCzJ6y6GWpHtanq8TROFw7Yt1+dM6n+Y+5qe2cE4SlTOT?=
 =?us-ascii?Q?xMjy8uA853Lpc5GxY42dstg9EHK++fEF9N2+fy3hGIi+MKRpLZBThbltSvgc?=
 =?us-ascii?Q?rMRnmSbFpl3J9tcG+9Oliy8vNYHRzukk5NQ6uFHzxgkYfLwN2JZJ4mDYK3Qh?=
 =?us-ascii?Q?ggX9nNMAq2XaYEk5lKiTjopkh4EDSKTW0DpZIqeQz1pkQGeB88QD0B2N2iy5?=
 =?us-ascii?Q?98toyzb5ATIKDCsADvWYk+CESq5xv1/+e1vbPySlVK13Bm4s2Z3ko4vR70i5?=
 =?us-ascii?Q?tLceF5eWswVt1InXeYkjWJescfZM5Tzes90gQwAeoALSdN3ryt5YWmAwoJV4?=
 =?us-ascii?Q?UZwkuXMlGmEzpUOhFgUAhGOKl2f9FJI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7fff13-2eb2-4e83-97a5-08df05fd5b99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:03.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKVMZwcoLrQ1WmJ7YYI4puQvf/4+Sd70rWL7t/3cCShToVesH4nSrH43BtPkHzX0u8OF0NJRPfG2Cp1Cw4ZCkiMKeZqaf7VD63kdMlGwR3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

Document the Agilex5 SoCDK with the eMMC daughter card, which uses the
shared HPS SD/eMMC host for onboard eMMC instead of an SD slot.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 0b418d9d60db..ce3a8c1679e5 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -112,6 +112,7 @@ properties:
               - intel,socfpga-agilex5-socdk
               - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-debug
+              - intel,socfpga-agilex5-socdk-emmc
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
-- 
2.43.7

