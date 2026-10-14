Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F64C6EEE;
	Wed, 14 Oct 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979966; cv=fail; b=b2U6SDPIWkZ6U18oElDSvJ82586WEbsVWbDq92ceadDAzT5xnYmBXSMVwHRE8Z2NRS+TZyOpttqUHjKsoxv03SIhFYKn7BH5QA3y6eLLqKJ6Bd90/f06AP69dvqUHFiPVSiRM3x8wOYVQhlOdeA9PrG7+ZxYrBAHtPYBvsuzVoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979966; c=relaxed/simple;
	bh=65ti91tgIVZ+xnNMldZJyRpkwj7wig0bREWBmEk17r0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R4wNiKO/Pyd/UMwyM+NJ7bY1avnfrxijHxCM57jC9y5Yrk2JEZDywISqze/2XwS5/e25fZSjkdryyhce28HhxSF5uFhf19D482kYDBgXaaQlN390esg5QW7Iv1jEADcRweK8rffQnME/VamclwT+XFPSHvr4NI+6NzI126U8AtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G55R5ikDJGE9wmgHmEe2GBpZeXMiN1xlj78VNoTnlwzYybjaq0UR1njc4lW7o9p4EYIrT8jqYyaOLwO4wfy7Chy/etNUiA9Gv6nEwvbzC78NcENhXcrK9tWak4wkCLy2Z5sHKSYIP56REtWf6LUucxSTsU/HoYA7VLircagEviHBcQ1ElYsccpPUcxdduRapn1U32a4LApmTh2M8xeLFGTKU3b6FeGeqE5AD0AmhSjAhLgtC1I+9UHEnr0/I3Vz+UeqTR07SIOJSTVa99wtm1FH3HJjAwlq8DasFPAGa3lm0B2HZyEQDrzbcuUFAZ6o2iinFw10tMshq567wLlLpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldR0jV5QD+c16cy/6FMrm0fXXNn21VqnneAPGSvAyTc=;
 b=NAi3EZWvnEDOZX8E6Jooawla8eYlLwhmKLSRsR89w6a34ZT7UODWRM+TzndEZalxrI3UjG2S3OemZEz2wLxqxNZzvQSIheUj1liblUCScsQijSUf7TY3+yJfBrPYTTK9WM8h6TD2AgE/SeYOY9l47MFk9CVAZtIhq7yHLSv8W9azd19c86tYbd04EY4gzsWfe1ES9wQlSjJHCZfl05kBkHGoLWuRZ+TUXZ3xl4kbLPzXVxVY6r4fARslUGGivkEID927DoNHM0GAzs7Ryn5RF6sQBXYKgyQEeqDJA5M3UdxeyBtms2voZDtD+UuW+/hHu/iQ5zqxblqWv4Bl9D4E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1233.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:12:29 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.012; Wed, 14 Oct 2026 12:12:29 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 0/2] Improve eMMC performance for the StarFive JHB100 SoC
Date: Wed, 14 Oct 2026 05:12:20 -0700
Message-Id: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c567f19-050d-49ae-41a1-08df29ec6ae3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|23010399003|38350700014|56012099006|261009223027099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	cuQ/A4Wm9pZSCAuQrgbojtYQtzY+56XtPWzggxqyRm3TeysCCUFx2R6DZeAFlY/LEGsHbEz2RLvdmnq06GWvSgWQK4NezrK+iTIRTRl7l+Nr8i1O1k5+tz/JV0GmktPy7l+HLV4bvsgC+7+trSnlrdjRU1tuCfzvfGOc8mXrLy+wS+7CoKk4FRacjEHQtF3paTR8OJXaPjLLkOUssZnCBkDp+Y2Zpz54nXGswZgDWISEvR8LIrrdhfnZwUwQxbTZE9nbIpWAw8BVLwdcKpo6vwBQM5PfQ0uvFANBVdSN/QUZ7y0PDowPeZ4ZoJjfFc4TDj6AKxRwf7L2EdVsE6DPSU+yAcOgidLIM+Jy+7ECMGY9EPJ5GGyQpPGgEP7qPX6dehzo7gxZ2+f3j1iyfxo0fmpPW+kg0SRPbxWQXNnsae/iBsM5B9tkpc5Ft2NZttiLVspDco4LklDiydsoFgyyOa/AfY8VGQWZZHHl0nvvVbG8trTIZa1h1tCVQii7jdfAu7YcEiPnP/b2Bj1CCIszYbMQGsGEwX9OE03CkDAUmZbvqkM3jDG5ag9ez7dNv4I6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(23010399003)(38350700014)(56012099006)(261009223027099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8PxkwnymcbeYUnflLlUtNLvtN1f6gc6Q84pkg73+nx1AzrPl5Q0rfyVqNOz?=
 =?us-ascii?Q?lAXpUZySroCrtkiJ7lscg3Yg6ho68Zh4YP2ByvD8XHJOeUa4QMBmo/AI1UQ7?=
 =?us-ascii?Q?HkI1pitzvnHv4MNZHfa08hWQrw/K+pHahydbCeqkC1kmu/8PKbptfRR8kY9o?=
 =?us-ascii?Q?StFNPKmXQE6FGkAcmP8qC3WhljIV1ZMIW/abS49YnyV6u7oEqzckE7tpT1Kr?=
 =?us-ascii?Q?yOJFmiS7slIysPfk1CggUPNnIKGz2l5NCVnksdTbVCx/hDC+5/zb5krIjjp5?=
 =?us-ascii?Q?Pmla/6IQr7X4UmC3XV4evPcUgUIlAG2HnGNt5jQBs8PHjZcj9RZSzXW0wX1V?=
 =?us-ascii?Q?CL7NZLj+YINlSOfA0Y/ulx0pTVwHrEBc89lFRI5LDeNrex2f2L3F+pc8gwht?=
 =?us-ascii?Q?1KvCZaZVmDUKQF6yukGfnO913MEoU7jDYBBH89yl4hGbtONbLdywl72HG3i3?=
 =?us-ascii?Q?a1nHBALmhnHvz0gYHZc8k7mVAN9ECf7vAelgf6vU6YWlNtcCTzYEtfvebt55?=
 =?us-ascii?Q?AIby/I7EHfmlOALQTPK03FA07odZnahPTl+PeiQ81c3StH0foM+2Pm4y9aDG?=
 =?us-ascii?Q?gQ62IlNG/Yp61QNxB4IdPKg5Dm2FFLkxjKpaOor92jNqoPPWcMdjQG41eUE5?=
 =?us-ascii?Q?1CaMj9tk4keJzEOPnYnlxcRO/H3zPwXxXEkY3ldXps/bZPYqnEOXiK8VNVtr?=
 =?us-ascii?Q?LioVLssn9jA07tZAK8lgp2fmBCH5HbRxjhA/SrjwQZAyIPHTUPJkHgy++dhH?=
 =?us-ascii?Q?C8va6DtUinxrP/eIQfkh+ccKgw4w46mZ6SgSSmkENjDM5vAc/otECfDhLTrX?=
 =?us-ascii?Q?f+c01rzqgOUKPMEyvUYEYfhriDmXgfriZsfMcOEPTqy4qBpD1L1j9Sw17gXI?=
 =?us-ascii?Q?dU5wu+MGr7qMuYQ3mE6DctQqmB3fhHpnfnwvQb/uJFM0/EQYvVZQm/xeEhFP?=
 =?us-ascii?Q?m+UkxoOMCUZts6emFP+uEiiE23I/hakFqpaGVjHb3bJ5tWdMqUU7IJFW4T8n?=
 =?us-ascii?Q?AiZy5KVM9iMgEN9J32oZ7OZZWMNbku0sdZbi+p2zVYU2wnUgoA6woFgWE6e3?=
 =?us-ascii?Q?eYCuUb56Bebu1SneKc0mdYGHfPBUu+QBzvh2xACALnuNKu6Og//AEkDH2FTi?=
 =?us-ascii?Q?wlXvq0vm5589Cg5YIaZEwnFCNVl4F1garEItSiY/dzDJ+9C8GhTT264AXRMS?=
 =?us-ascii?Q?d2MC34T16Vjjmjk9N2GCiUmZ3Y8YlIUKX/EgtTT6NnuwP3d2MoPGl2Ct2adl?=
 =?us-ascii?Q?XtiVtBhLN7FO7sGNdMbXL/LL3IP9kbAql3JAXKdSa7KHwH/RaEX9pCLGiu5j?=
 =?us-ascii?Q?EarRHGrFjcR4RyPbDKEqftEpP7qERmPZP8U8tuLxjNNqjJyyAL/+L9pgKrEu?=
 =?us-ascii?Q?6cj6ptVife8HHSYsdkD1lhuAE433C0uMksesQePjbIjsphZdG09oGPThnl9p?=
 =?us-ascii?Q?JsZ8j/xZFGSO4KVX27OVrN/yVVEoktR4m8agWX/gey8ta4Xqlyeqhcwrfyp5?=
 =?us-ascii?Q?z1esGnbcq8Cv+x4llY1XFfrNkRug/FG4OYJPhrYw7Ko1JV7K+lfabtraVXDL?=
 =?us-ascii?Q?b3svjjaaJjQeGCyA1ub3uyK004NAyx1O+NfWbqekt+37q6bOTSwI6u7Fvr8y?=
 =?us-ascii?Q?uoKdQIDxxPFJIVBdDsCK0F4q3/y4/Inm5zGPKbDBKrwTmnE74DjslJzyLF47?=
 =?us-ascii?Q?niGPrHh7UAh86OFiAbPsOtt+xZGsBX9OEta8qTF+ACnIqHsJ5X8NwJDgXqqR?=
 =?us-ascii?Q?89jz9yEXglo3+Y1JlaykBw18HsNVAQ9ZRozP9Twf8naSmHOckCy4?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c567f19-050d-49ae-41a1-08df29ec6ae3
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:12:29.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDQTYF878LhEza/O/5riuFBj9zgXjS6b0zSr2qWsAQxF9m9MCfSIOa2HxoIwXlW0PfrZIDiDktVK2Dz9QqyNpDRmoDwTB3/RO1iHftCH+KtZtbHhtRjhXN//6Mb5IF7G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1233

This series implements a generic interface to configure CIT based on
time (ns). Different platforms can improve MMC performance by
configuring their respective CIT. This series has been tested on the
JHB100 SoC.

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

This series depends on series:
https://lore.kernel.org/all/20260930103258.13375-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  mmc: cqhci: Add support for setting command idle time in nanoseconds
  mmc: sdhci-of-dwcmshc: Set CQHCI command idle time for StarFive JHB100

 drivers/mmc/host/cqhci-core.c       | 60 +++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h            |  6 +++
 drivers/mmc/host/sdhci-of-dwcmshc.c | 22 +++++++++++
 3 files changed, 88 insertions(+)

--
2.25.1
