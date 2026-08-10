Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DF429019;
	Mon, 10 Aug 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388475; cv=fail; b=jf9p6pE2BYSBHff0LPl/Ooa6YFKDzTRpDl247Yh8Gm02sKkSLqa1w5Umxi4Hl0XMhlDfBrVxeUI760ccz0E/HtWX10xw4V8nl6IFVtahOsDdrUjLGOmv4ktuo+jh3IZuPMpmHn59xIIC4q6mYpnZ+OgiX+yXNB1f/ZAmLfUdJ+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388475; c=relaxed/simple;
	bh=tCMXUeaBrrg4qOo98h3Nt/kqcy52escRntH597ghNvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5DeMlSjXDelXcOHJQeUhwByLRQk5HO+I1jnf1M5u/ps6fxmP127M4Qlrbb8eon27m6Baf0K9tQksMTwDaqFeUJhxijGFp3OhJjEg5OlTLkLIg6mz4I294umhAQNZsWheDJiBT0SXIFTlVyykDS3/kO7BJ+V2pz+KXF3b5uxlIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=R/8G6WM4; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="R/8G6WM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3mc9W5aDC1uQhT5zz+4khsbf1GPHpRwNlj9b41PLNieoJhJ43QqBEPrS0UXvkDeRW7d0GJImLZH8f3nDf6Xx4pWyDvlOZGDAOdz18QS0PVJ94ddYtwAjWUOP39bnq5Hndd398e1emSdxRH3O/k2sugAgUPqEpQOepQhoJLLxA+2xEb+gMyb7Vz3f1n645OEj2vRJgBt8BEzq0b3WfB72HfN5vZh3HywrGfOvcCh+rqz5mLj2v2MEKa8ebPPWy3dbaJmQtsGLFBpqedAFXGH5dQMlUvIYagzf5iGEUiJbPlSCyK0n3P3jVT7hETEF82NX8HTeXAyWkeCsRq+bpFpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=uvO2cA+lL6LQIMACzxTxoXWcSwpDhcymbfOixjuEyLuYGZj51O5en+7QEPoAfG6HQ95E/X7kwkN3t3OMOhziKK/O/adLbcGi0/k/Tm5EVaD9D9f6RosDEMMYFQvpLXKBRWCTbrSCpqtz6Fy5/ME4x8wgUi+YL/I4LrzTg1YwuiWzZJNdZTw65jQlWF8fnkPRKRfLs+YBcGATivJ20/EBW7tKpOA09fdeNaEbpHeTLcbLQud9BtrA+TAfMnnf1hmjRbiuLMVVR9+Bi596teiQ7S4EbbQ/G62EJUaodMc2TmjRgeuc0zSfMdcqdyz3CDFad0KM25r4pKe0pzqJsowqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=R/8G6WM4cj1eIS3w2Rfu4wjd0DwxUnx0Mya7AuS/q/5XG3cZoSXzSvn/kOHabbXvNYL5lcTHNWxrEa+q3yVZElNgUoL9OASTE55BMjzkapHTUKjf+bnKiFuPITdOZgUH9yHWHTbW0OM2g1te+Ubm/o5ZntDoFZXV5XELjwNe/4CzrNf8O5h92H9gd6U9EFVmrdTDQ+6ay9nzU2fgty+YP4YDh5MmgfCPPctSMSOq7HnlNbbKeJ40AfCzxQVnUBTb89r3q8P5PVFsGaWBq4aKD0CNZchidGe7gmf+pGRWvHnk49AubaRB9+rCWee3GJkJ9uIOVN6hN8jN+j8uUfvKjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:39 +0000
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
Subject: [PATCH v4 3/8] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
Date: Mon, 10 Aug 2026 12:00:17 -0700
Message-Id: <20260810190025.25045-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d04df4d-a9d5-4cb8-367b-08def711aa52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p8HLLP9P8M0n/Nu2+XemLNd+moR3EWvYG6o44b/jc3hdqUEuT0baTDVuEscvfWBVQ7A+aQBstzQWM1b/SzD/WPERcBc2Fdm/FEoWUgWM2Od0/94GNvlt6sLvhOq2+1zSBgHxVLR9cjfSc0/vhMrHlxiet/XTk2E1EWUIh3tvHfpdYs9/mXD11OPXvUf5ld3HIiNm36PQBY30AyVFnPG5I2/kLMjj+Cm3cEeBAtYa9Z/kTeQoy1z+YWFEcRhcMNeu3/osDUxSVzed144jyfxJownlKNAm5qwUdgCCiwNaB66YHpcpT4zFXfYDjaEWamnow7KDQnTpN0rXoSucdKQ45labdqHyjAMyaD/fRXjIAcFeywQ+JF+1Np11+6SfbjajWVjREt0qUKdeh3qynwhDHVX3IDRrAsQ9YnBRuzZBXNe5+6PyRwYsVWu+d38kO1/S33OjC/azv9PUlgPT5oW6ySbt3p8EjOD0vO/YxuBocCb7R4UPvvfzMO8xVuVYn3JS3XrK2JXLCERjd9DM8hVxTPHZnQxBU/EaBmK1gj3c2OuyL5bNqNcK7NGWTV0NYysUMDGZCDsPLQ3O2F0oGLGRBbBIs9fu4cDe765ZBFbGghxls75rrAAKeVCDwaj0ZNqwuU/zytqef5Q9S99SaYzDlevZ0N/Rvbe7zLn90gXt0XQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofbjvf6qGgKMs1BjRBkpHBcPe+I6Xtt/MANNaIJAp3+KcZrTv2Oj1YXi+wc+?=
 =?us-ascii?Q?fMYpX+tI7t6XQ72MCNYir0lz/iA8PqRXQ3gU0klCFGq+CowmZrZx6ePvt3jX?=
 =?us-ascii?Q?4KSZRQ3kf7OtvBkqRbiEa98zQgsgM3/GaApbdrMavZProVg3SSKjzhniUd3r?=
 =?us-ascii?Q?LtVw5P7/0wruY2ev52OCRhL7Wfr4wB5EKwkJhe2xSaa1QH6+jldhMs0eSXQJ?=
 =?us-ascii?Q?86adgbm/476n1xFuf1y6qtCsdRat8WAL58Z8rA6fARh3FCFq80tjtovp9BL1?=
 =?us-ascii?Q?IIdUJsVkjiWCR6Qqz+sjLCNSk8c6vIDXiolMFH25FNU3bOE3Z5qt/2dmB3Oj?=
 =?us-ascii?Q?yDU1jto6+lduGUPdoVHw3bREz9p+z9qOMv4LfDGMkFYxWysEajccBryQ0a2W?=
 =?us-ascii?Q?d66/fSg1qJ9lCARLvfRB7DGn7nQ7w01+d88odKh9I8++/ZSIW0xYTbLBtsFm?=
 =?us-ascii?Q?U8SqH3EiKTFGEEQkGE878RAnvGp3yEPJjBNUj/ewOSaajfk5TZYh9F+kwQqO?=
 =?us-ascii?Q?ZQOcbdIAvACsu9pbSCcQFgn6vk6LAK8PZ4oLjnAf//n9/JOqgTKueUjln22T?=
 =?us-ascii?Q?qgc19DYQBh4pb39hxssK04mtDkGIoM7uoeAxTqdcHIhJEZwgwQKA4ZLp+pG+?=
 =?us-ascii?Q?o9N99w7sTzwe0fhF4P1T+FnzvcfZxrZd9cOR/p0mgu+PjBov9GkjHXzTy9k7?=
 =?us-ascii?Q?AbAXpG15MZA06c2+h85uUwPprIuOg82NWDIf48o58w21UU/PJUXrKbJVF0qw?=
 =?us-ascii?Q?FrX4aJw2Fg4q7NVPsangidts25UGkWRO8KqTNR6vfNSdtlQH11TYVr0f3CeT?=
 =?us-ascii?Q?vu6P8412AtnUwtOM45gMZ4FDRNbrD3Qb8kkzuKLuTgKhlE7DfzI9iIMkfEC/?=
 =?us-ascii?Q?IIVR9FLHcF8VxYtGCI31Wt3oNDIq6PZ7szQY8KoeRyxQ7S/qvMoqTdkJbuob?=
 =?us-ascii?Q?1lSYeVGV8E8hRBFSygpEIR4BnpCFwBzGMyrUiyzPvdjlouU2MNUKEo9l5BS7?=
 =?us-ascii?Q?K+cWwduHeTZCUhCMn7dEB2BHWa+dwJeOV8FWotCrnuycAPZCkl8WzjYEPTlv?=
 =?us-ascii?Q?yjhYC+l8vEiFi7Krse1so+5/KPcLeJ4ozPES8ITMTGB+krjFsbBs08BMLN7h?=
 =?us-ascii?Q?HzBO5yfw/onbJdyZZSX6XEr1l7pBGjbjdsDzbR1EvcM2k41xyDku+CewLxyb?=
 =?us-ascii?Q?thK9lBXVE9ze9l4VgBL0brT8L5IUUuQS86sDJuC+U4yMF0dF7jhz/vcsLCfI?=
 =?us-ascii?Q?H+esg0I6JOXjNe4QVY3BV64eSgm/iaXpDpysEaA2zFlPtYiDPk8gzcDgMnzb?=
 =?us-ascii?Q?jHL0m96ncJkFKvQzC5PRCfKVLfBNqh1fBtnJ+xtLGB08qbTQecRSxFZ/YYfZ?=
 =?us-ascii?Q?FegTi3Mn0A+w4LjPfzlTixynNrayoKbJaHTDOSsMtCY1oRZK5oM4PdIknDKD?=
 =?us-ascii?Q?DRNFQnH8ZN45acUppr8E9aj1FAdftmsz0llESGAULpMDV/KMI/r4de21GBKp?=
 =?us-ascii?Q?3247I7irMW5cNCtdqXNiriKvPI2Kvjhy8Buxf3oOX3skzKLXwDVl63QGUs6z?=
 =?us-ascii?Q?nAknM2PBkMJXMckc00rYPqDL6JastKpCV0lZkJCuHbScqnpvfWHnyeb8UsBP?=
 =?us-ascii?Q?LrGV9yvKHapF/nNthpDXyIWzLmJnUEz6L51CJT5Xl+nm/5JnFXT5k8rGLMZE?=
 =?us-ascii?Q?0AXblSbLeU5/JB4FNHZT68YcV4f5XzKrDN9Rb9LhrWkFqIUZFI0xiADQF0Bx?=
 =?us-ascii?Q?c0b28lkdLPDBm1lCvBUr+RUva8WMIyA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d04df4d-a9d5-4cb8-367b-08def711aa52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:37.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2Q7LLxzzEfqPLAtr7RO6tql9lYeb/lA5AQ/yznbLQ/otjSwy2qht4kiQsdtNBpTZJmxHRXNye+RueM+TWoeMNYoCbeh4ithHQpzGPuMQpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

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

