Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E63C6A46;
	Wed, 11 Mar 2026 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222501; cv=fail; b=Lqx2e63ovdXooq3jCMHzPH8ZamSJlNB4k9h9xCWnto72OwRasZ052Grx7/t33NJ6N9d6r+elWt94ojGYKD3C5PHLiDG1WOxvnzQntqPCS5lAig0oe1XQCDnVQJe85ELhUH3bhv9F6Sp7GkWFGFWqqYl2kmvWeBfQR7yhPOfcIpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222501; c=relaxed/simple;
	bh=l4jQUKlANJvaM6TQkanhXTmYNw3/VctUeR1UTcG2Y+4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cxE7Wr3QuihI8muYwDEj/Pa403yXYFIVNLO0VUSDmp16FUhHDdeb0E81U+WC2qZgs5lqNfZMmLq0YlezWGqGagHbwi6GvNTpf4keqJifU59jXreH+WZ8d6DTiRLgYwr8YMJLeL+GKauaNXArEnFe7IF3VIBety5PSqd6PpkntSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IqxB/pVU; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IqxB/pVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHuPFdJUBzY+WpMiTd8xNS7CLQueueAeWo1s2PWPQGuquZxfUvy1P1Y1BCE1hMXXHR4LbO1G3X0jnyGeyn7RcO2kiklK5wtsdUjMruDBRU/METE2+rYoPahYf/mcTTra4eIr6ja7CBo1jJLeACNdng8ZhrxFMcsD7kE6uXBchPDl10EYRIJazzzpsPl23nkLboBLZPGZsIfuY5goH41X0z2hv6K54OH4R4vx1rY4qQcCH7jmU9iBD6Kvi3KpuPxhNfUwTYepJSZHgGFrPASkkVXXOpu16TSMVVYPANCjAJggkltKB/eCOYei+5FUPXhahZpaJajxLRFnqRQd2H4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m70zge5P+pBYJ/OnO/PjZyStjUy5s+UhHiPEnyjDXw=;
 b=CEH0hqbpheJGI908iHstUeDWBDRZup6G+5MURBTBS5Rwvl0Tf3a2u9xxiKTdnKu12y9WY+43EnKQOJV+4uT/mGrkcl+nSeZkiuGjIw1e/jbaXfhOJfShfFsgcpuLpLu0hpjCz4zckomXhsJtbZOly1n7FY7Uyaxr67Hiha98ajQwj5/HQuaRuErOW3PKDLMrdphBDpABRMZKjt79N9dwKQOD4dtV3n2XCFUloyVAsaAwaUhzlzj4tYMLUork5Dqa8etBwdEF6nwSP1RBP3ydGzP0yFK8cBBCyYzxu+Fgmh23JQynGUMmIfUZ0BVJHHXu3Lozsw2Ga8Kk3ukmDTnA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m70zge5P+pBYJ/OnO/PjZyStjUy5s+UhHiPEnyjDXw=;
 b=IqxB/pVUjtXdBoRFkLi+G80S7glAPaUDwQzrMa275ZM9QQ6Gm19zEm4Eb5e806zl5HBXthuWTlBbf6dTun2EzzL29pjajF01dipbkGbQfI8Zy24LzrMmKWI94XPyEzxGPt78UwHy5hJKtiqkCVZ0IqInmZ29gQEOpJxmfP5ZQ3B6y13G81cgCOomMUZwgY+A7uSvdRib7l0Nq5irRbg80h75P4tCWlPfAOk7tanpjXjqsMzACdZf9dWvCy7dx1OCiiXAMLLQ8wDpOSqwiMEB4XZq236OsRrkYYbA5J7uL2RTxbHoFSkKu4EiHBEWAO1YGuhrlKciAMep3XdxAf8nFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB10418.eurprd04.prod.outlook.com (2603:10a6:800:231::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 09:48:16 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 09:48:16 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Wed, 11 Mar 2026 17:50:05 +0800
Message-Id: <20260311095009.1254556-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|VI0PR04MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1ac11b-a815-4677-477b-08de7f5351b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OnuQuYtoR3KzqMjFnzQOlwSGO8IIWxjjx737U0ihKNv6DHYmo3gWbJ7CMWWCdQxpCJEqvggTQdhlOnieEjlFahqGYsbZaQfvnGtNRAead7jvhynVGAzXQ1dAHqpApc28SEt+RgaR3Q7uAhybw5UVTndZGZsG70qXHNX6YAUtq6qXmlgY2L6uB4uq666Kl5FLv+Xmwo0WNLTaQutMAkl16zAKmdJ7lSOSoNLiuwKMH6Hq4FdIZCqhRGNh8fwX4j/8+4l1oKHiAk02CJmEgxC1mXb2AHU2r3a0qvZLjUaCkAXmwBVKrukVGpdBuiLeCM5k5f/rIvJjCZYqx7iwPBMDFfdLQljZ2nXjA7+hIHtwCJpIcHPdRD69A+IGFVklbAPBMUkptcM3r9w8yOaZ+usnYrlNOHueJYHiANeAQAUD6ckTdW9FkYzoGh2kvE/aK0sLp5r4BUtawPukTlvvg8FWiBzfpMU/YGlY9CBXQFUYirqF+hknydRObmSTNng9Fxugo09RXQfyWLre+2FpA6MHYC0U4SNjJOe5x+tGbVHlFI9zhs/o2Hec8ZG3Mxn1/5dc/jcp9AExl4aw3Tu8CJX7EMGNN1JHk8M+/Q+d93VLmWrwUq7JgeIc2x9Wo3I67yftqGD4Mve6nh349Z480aL1QFKMMZGNhwWFNW410phUmi9esbiUWStAfyTPzOp8rDW1+n4CUh26Ou0n7rurQ8G2Dq/6bRc//JvhJdefKhuFgxuO+OnuNmXPYW3podJ0wN+4yyN0uHJSxLwO+W8Ml22GW9Htpwt8ZWmHiEI97Ld0LnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MUuZutbKzhj//jqLM+AFQHM1UWyI6Go/8/i7bxb4nX5P4a9eGSMrczgx2xPI?=
 =?us-ascii?Q?5YhjKKNvR+pMmetX/ZFbiCkSwrxaComn5yzzxRfz0jjI7BQcjitwrnEhrevW?=
 =?us-ascii?Q?96+SM4ohRmx3r6KzMYg5huJclkTwUuWN9et2WQjbOc5nq/L96ndWBKK1CI3y?=
 =?us-ascii?Q?YAWDSExQJIg3wVe9GY1OssEYE9pGDtjF+wle6Yr/c5pkJh9UVzDrw6RKq/VX?=
 =?us-ascii?Q?Wp6BAH/AKIYLVS6fyazBp4xqGPyGTBy0rrXCBDbbbtouhpONYqXCQ2lTWyp4?=
 =?us-ascii?Q?n4cMh/Jp8W3+mzNtYKkfMSXqBDBHiXPpNjILH+VEghZ1XAsD4XIn4QQrDRI8?=
 =?us-ascii?Q?Lqe+rIB+OCYsFpTEwZzmlNSV1o+DWKvRelSfuzBrLQXbc00j/AjJyHH2E4rD?=
 =?us-ascii?Q?mePzpqcGxD+vQefMtpHCKq67Rz86P+60Tb3VkM6vvG6lWfhcOWD2as83rKrO?=
 =?us-ascii?Q?lOjiZzHQbbSgohKAGuhsTbRNwJzgMtxvkdosVvEtEaN/sK/PPeS36/r8N6Yq?=
 =?us-ascii?Q?onj+TDueUGQMG8Rm8tfZnH2M/APAnL77NwzHIK7aTdgQNdThzLlMRU6wd6rJ?=
 =?us-ascii?Q?A57U69PWBJRT1nvwkSPxXd7jWaKfKrN4MAvYPbRu8ZAyuWEIogZLLH4vbAhC?=
 =?us-ascii?Q?U5RPlOTydlnfFATuZAufc5oVVSuG/f38udE25yg8ljP139Q77sCrnNbKUe2c?=
 =?us-ascii?Q?QX2rp2iubai/u1m8qkV00f9WXKVmGVECCWzmHhM4dPFFbbJob8wH4mPgj8QL?=
 =?us-ascii?Q?GnK4i99w7Kltz7ZKD+bL8jW5/T93Pw0RflGglI1TRsErggfPGND1nTcU2JHs?=
 =?us-ascii?Q?S6YUrP3+E1q9EmDzhTDjMnnoXbNA+B+YmCnqeLXGhnIpmlqBs9ReZ32mIOWi?=
 =?us-ascii?Q?4zFqXgHRi3CfXaE7unTV1DeMCU9oL1vW9wWchkpYvJsJo5BG5ETj99VunGrq?=
 =?us-ascii?Q?Ot6EsEmS8PiHekrpeqoX3jHYRnPmWprTBVMGrYW/QvIADfujpnOHbMp+mtr8?=
 =?us-ascii?Q?JQWoB3NqNOZcjCQryW8SCUHJMRKgMjxC2c5Op2bbZuaUVLlkF0R1m+npluft?=
 =?us-ascii?Q?dEE+3BhRFfDKi2emt7BM90+FZEmNW7joLYCy0fFojz0hMUYq0UGHhTKRTrOZ?=
 =?us-ascii?Q?DVZefVCHTD2u7Eie1ofWjIukQ2FToLWO9QBILVdWvPKJGn7xIau0+h2XX0eB?=
 =?us-ascii?Q?mUw66uoNxMGcCrkiCgwuszKOevTY4gbzF+2t4Fk4EJdWGuz2+P3CsTZEEqwS?=
 =?us-ascii?Q?m/+4LhYCHNKXCFZHBiMAucyePUmLU/PuUb/CHM1nqMc99u9NoJdBmAHlxo/r?=
 =?us-ascii?Q?OC5ven/XI1NN9oT3ZtjOw1wJHgr6e0njj+ExL0BPMB6AiaCiAQOX6Nng+dhb?=
 =?us-ascii?Q?6RldhB95axE60AqBrICsYKvarfoDv/Z8L2qOVw6kjjtWeBT1UCn+RyHFerch?=
 =?us-ascii?Q?dWnZlyz+ywBGQSowNCGCxtj8jss5VbfJNKGP0SCWlP1EOEE45U+BYdzRw2TJ?=
 =?us-ascii?Q?dKop/Bwzrak/QY6QdViOIIkdfPtHN9auKddo4uB13MlmjaDUqwyp9odGXBm/?=
 =?us-ascii?Q?3cUZWuvRN+qFWcQs65kTWM2K25ulggP8S3HCExRuK5EYoBiO6x4tymRGteeu?=
 =?us-ascii?Q?82VglmzGPsngQ0NsFPDsjpekoHov/xC06YkMOAqxeH/YQudgYMlVK7k58kU6?=
 =?us-ascii?Q?GbMfzOsHbRPPZ9y+JHaUJRoptN30EjSlw4wosz+YtAD9p83rSfPRXktPn3g2?=
 =?us-ascii?Q?gYF/QWzKcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1ac11b-a815-4677-477b-08de7f5351b3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:48:16.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fghwNmrytTM2fSwJfo4YxX23qBiwtZGoDXkV/gJgRf507SaDYAoenaUDTPlHRl0zgtV5VWNU7CbbUyDXIMjd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10418

From: Luke Wang <ziniu.wang_1@nxp.com>

This series adds 1-bit bus width support for sdhci-esdhc-imx driver.

Currently sdhci-esdhc-imx doesn't support 1-bit width because it
doesn't call sdhci_get_property() to parse "bus-width = <1>" and
set SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.

After adding sdhci_get_property(), another issue is exposed:
mmc_select_hs200() returns 0 without switching when 1-bit bus is
used, causing mmc_select_timing() to skip mmc_select_hs(). This
leaves eMMC in legacy mode (26MHz) instead of High Speed (52MHz).

Fix by dropping incompatible UHS/DDR/HS200/HS400 caps in
sdhci_setup_host() for 1-bit width, and clean up duplicate code now
handled by common framework.

Luke Wang (4):
  mmc: sdhci: fix timing selection for 1-bit bus width
  mmc: sdhci-esdhc-imx: add 1-bit bus width support
  mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
  mmc: sdhci-pltfm: remove duplicate DTS property parsing
---
Changes in v3:
- Keep SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 check for SDHCI_SUPPORT_HS400
Changes in v2:
- Moved fix from mmc_validate_host_caps() to sdhci_setup_host()
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 +-----
 drivers/mmc/host/sdhci-pltfm.c     | 7 -------
 drivers/mmc/host/sdhci.c           | 9 ++++++++-
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1

