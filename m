Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228E1E3DF2;
	Wed, 25 Feb 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033436; cv=fail; b=nzGv+8IRilfsiA9rbVjeuqCLhsT7WhTyK3Ey7UPuNYMzqtcJq6BfgjB4iwq/keeAj5Q0wVWagbrRr3YmceMK09UfNcgvW90sHCj74KjfCrVTwOtN73A2eiRQMCAmvJ+zG+17Frudn6kuK3jLAqDWHFCQGwMIyqV6SNTmg8r3xh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033436; c=relaxed/simple;
	bh=7F5zt6LKcFxg01Kggauk/VNW8SNpMrZuX5HWOpnGU1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MZiAy9RenU8Zn5XuR8lWBEvbPbHjgSHCrlNs5xWt2ojzvdQSgThZsjpGMx4HoZDwB2VbMBbvkF8L9GL/L8vpRqB03WU/KEUhFDIV3BSc5aH/WTZT/W80BV2U+w0JOgACrYJXvjpNV8Kx9DKJTJQZhYUkzFZLcu1CuvRvZB4fV1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EH4tMRiY; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EH4tMRiY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjvaL0HsP/PtJ3yqff1VzdrEsOYmlgEt/SG4cKhE9qAibGI+fDS6bdCL28UcQ87z67FjhzkTKvh9Yp7HxdLIuOxRbwF/PBcbhz20n70+yyN+vUqanyb5hVQc6PChDPkGmyl+ZtNVbYLO6fXBqDDtpCzULHIrwCX34WzaZEaRZCNQ8sOuISQc/r3Cjnrw8FUu1sABm9fJbulKwrhiDhOGmaZAXnFDouoSEiteYv6SoezHcrgna5k/1lzhUQM9UDMI1XyF7KPpTyGc11BGBA1bJ68ICAtbzb/Getasfr/IIv6qqTc8nrUyhpDibXaYbh3TbE6tFcsyMy3n6K4PBGsBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE9qYN9UsJGGGT+Yl6G48Tiuqm4n2X00X8XwBGzi5Ls=;
 b=iylUoMRQ8mIpNVit3aIU03JxG0+JbpCdIvA2AsEIY2w2zb6WMObJnkVdcwnvuBEyW3NpM5HqnOil+HTzOMSj16kendL+sjCdZsy1qvSTEA9yKmTh/wMDle0PGXP7bxMoWpHsmuENeCl9EjGKJM4vRMDbV3OL6oXzadtk7AnTb155okoUf5jil3wSD7ZAlWqcchUUoLtwc757W9WfvCZ5+AIPZFfOlT6z9PFeln22dfr71Oq5+ojEs3NH164oKBPjmpzceb6aR7Q1WNP0zfWrOr4C9iphgheZMXg8gXJdzwvf2iWLYEY2sKcWxfVJhEXbi5D27w80NKwGocnngX0eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE9qYN9UsJGGGT+Yl6G48Tiuqm4n2X00X8XwBGzi5Ls=;
 b=EH4tMRiYOZua+xjBdKhNctQPuJZj/7h44ezb3KIbNO6vi+nmIdUpmHDYeK0gNItVEfHaXE+A3sh8ky+hbniCOyQ/7c0EMWkD4kjkAjzdTwPzSjXyF5vMiq95jFmrkYmMWwr4M7m2MJad0evq64jGV5vcIPc81fNTBRIHdw6ZuEKBQKJm2uvjbnVKqMa4SioZVDqFE+tOrBYyItRW+FutQeuPxHpPpkLJ3ULlkJRdQXM8uNIc8iTG2HyJ9nYML7dovpULRjkOD46ZcHP2/XMesgwYvwHUX0n0QBFV+ec9rr/O4clNTXdaPSSC286Y3MCuA8fhTxPbN22/wQrYbmsX3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8471.eurprd04.prod.outlook.com (2603:10a6:20b:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 15:30:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:30:30 +0000
Date: Wed, 25 Feb 2026 10:30:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: freescale: Add minimal support for
 S32N79
Message-ID: <aZ8Vitk2Q3ZxwoBB@lizhi-Precision-Tower-5810>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-8-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225133858.8026-8-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f0c85b-fc40-4a44-79a2-08de7482cee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	+hzRuA1m18P9bgiRNoF/j9SSBmmT6WNsr1h/qSnoS6NSez0MGS6PSI7fcpXsKc5s3i9UpXjwJDbLwl3s09Krt/a/h32Qgad8yMNmu0HylM34JcPdJc8Ykfd2+Znw8UICYEFcuCcjjgugi1/ps80vrcY6W8/7OEnFuK8jsaD1Gc5ttUJz616B/eHOe8S8QrpJJ1VkqEyL4QqvKofeEeUWzVWFpki84rUvf5WkPRpmqavkqfETtQwW/RbcVc0YBgWwcrmJ2O3Ee303yohu+K+0G89Y2d/Tpl9uCuF7LJtRJ/K9QCV5LxHQWZdDECfcKcPyqKmv8bBvqXHdXhHWLBOYANvlnyBmqJfuGW+QTvuZwylzaKJea5FaXLjUcXpYrEAiqeZyg4o9iyMe5bi01QvN6i4RByZXf64tD5CJkEUb+oBOisbvW6qPwLzmmcmEGBm31Fza1Y27hruD5BIdTAZAYsj80btMDoFY+ZJRh4zlvR2MbQZPOlZ9cytl6Tt249+68VGScyorXab7TEwaHka0kLJBAjokO0XfmFTDWfuaym2iQ2t828yxawBwyfbagp5T5TB3Wn1a388FiR5JUdFD3aS1TjjGS8TjX1TY541v3GFjffWsw/PuU9hPaz6kUW650G6W8XMnjNLV7kjc5FDCPwXTxQPooIVjlcS+HDw13X37A5et3Ew6PgGz9HzN4TYk/v9f6SwA+BLjY4LrgBkn39mKe2bxIOrvOx7oTliPnXWCVozc5u+foI6Jq6HdPmsg06sS/dc4orcBbO1dGAplVCZIje9OQJ3gUj5GCozIMD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PBaLxtCoJjkqp7ruALZZagYzw9Bwfq27ul0dotovSG/loMLLnpUJazvP+9j?=
 =?us-ascii?Q?jeQTegwGapz7aJvVDnTW6tj9O3t71A7ILC7M1sxfyQ/HTTUgFasV+yjYdtPL?=
 =?us-ascii?Q?EAMF4lHdy7TtUwAnPUeILKEEjLORkZOWpsuGlJxaUlfDi4/ZrxXKtPywiOWV?=
 =?us-ascii?Q?F9VP06chAOHdqftew911jdZAoGNNW4BKp6zcvKrY2kBIWeenuQgqaM6IXJns?=
 =?us-ascii?Q?kR40ilvIh+lVwlGA90Z/dbPBnGotPFCxupwd383l1hbzHf8KSurvwmyPob6w?=
 =?us-ascii?Q?woENgYTiQACg7uSPUuYmKUjwppb8JwRlZlRTsrR2upZpNwau6xr11HNBg/6I?=
 =?us-ascii?Q?yBMSAdzMboMQYMkjwUcmPNzpqdFth3PzULWRJt9fDVdFbwXLOddpe+e6TBTw?=
 =?us-ascii?Q?TsLd8LJJkbUnilEgQ+/8f62OQXlnOjtITh/i3bvS5AeM5gxA+IA8WVpqkVSK?=
 =?us-ascii?Q?TOA0Lv2X/iCNrOsDvhVdslYVxqC4JIGpGLxfUSL6mwHF+SkWYoPID3Nfii1C?=
 =?us-ascii?Q?+AiXXxIXuoi8dUdwN+iAPQcVBL5a2d1r8YZNOSI2xq07BKf6grlax/Y6OhIt?=
 =?us-ascii?Q?T8usgwVrnUfz+615fFuWHM32KQ8knZSTteKI0jeb1f7LZ8ck7gMmhBoUeJYV?=
 =?us-ascii?Q?djMOo3T6PMDXRx4M5v3OshrC9kHRT6ByQQPCjcKf6KZJoFtzlCr+oOuKuTlD?=
 =?us-ascii?Q?fNKli5W0cT+S2aHKvmR+YaR/oIjOswxaSSlSnuHk+fqJbQIoG4PvbBEMYGDo?=
 =?us-ascii?Q?gbjAwLxyXi19B8FjBRhIARBAbkRGvCG6EKNrobyjlKR+ugSWZr0VUPtFd7pI?=
 =?us-ascii?Q?A4VTelw3qss2ABpzc63f1iurTIOfAMpRGUX/UWIt17pl6rFOA7CcsnwcVLTb?=
 =?us-ascii?Q?Zgx7PmXYoHw/azgTKs959jAJCzNwSXGLfz8rStKal4hDYPrpflTZeCZw522N?=
 =?us-ascii?Q?zoFy+LJC+uh3hcfjOKBj01iSG7qGPqKeVe++EOhj4zNeyNMUsW0umSn25uFw?=
 =?us-ascii?Q?8ODFo3JhMiX4e6n0454HL/OHwF56qjlHiP0WLtMQD/DwAIIM1rc2IQqwmzME?=
 =?us-ascii?Q?SF/k/85hau1Y68+bywJac1wAOOmHvbtq3GgSv80xNFvLBYKVtPdwyDhmlVLw?=
 =?us-ascii?Q?hrOjrS3tvuY+e9zDTBhRNeGC2EazgCZ0roqalVxiqd9XeGqoLHnIUfiYlcP9?=
 =?us-ascii?Q?WxDbYueeWn2X/qZwynK4kwshgrigp/bifqswoRDlgoLlToEBA3lmbZIYWGKL?=
 =?us-ascii?Q?pYJMkmuR91j9ebNrxd7QnveP6hIUif++nBFFlhb0TFidgbU30/qGYqBBauxo?=
 =?us-ascii?Q?z2YrUEUQWBd0P4LGuZgppVt4ZouMYrKvz7cSARfQUknRkDL61pbqU16u58VI?=
 =?us-ascii?Q?8lR5zqP+5/AuMSayEbcLggrp/Difrn8lTTZluAYdMT/zLtYBECwpFQDLhvs1?=
 =?us-ascii?Q?3r0+reuxZzXrkh9SXpT8Q15gpOVuhdS+yLQLqub7cP/doSyWNqB5XlRF1OHk?=
 =?us-ascii?Q?8tKN9qyO4ShIKtJY6bw/CdnHRDRm6yPbEXnV++MMF0Q/TyDQ9ikeBhCxkXs3?=
 =?us-ascii?Q?AO/pZYJHKHzO1gxIlv3JZ39Liw5mIWDzXf3TKQrbWehuXT9tDfx6hmAAEn0s?=
 =?us-ascii?Q?d8Ai0UpgJK4SEen1GOI08JIGe+m2rX3A1LQoddCMpWDEymi8Bh8i7dfXK2CQ?=
 =?us-ascii?Q?zE9pAlZSD608n2dYbqTPay0Dqijxm0PASibySjEJ/jZXRmezT5XPCXX7TWCT?=
 =?us-ascii?Q?nKS0UQIssQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f0c85b-fc40-4a44-79a2-08de7482cee4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:30:30.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoiyYDLEK+WG0GGnAfGi1UAYsq5I9pLEWdqDpiHcTR6o3+VfG6UmiKHt7uVWtIlTD4VPy9PCiZ1Xm3u3+68Tew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

On Wed, Feb 25, 2026 at 02:38:58PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add device tree support for the NXP S32N79 automotive SoC and the S32N79
> Reference Design Board (RDB) [1].
>
> The S32N79 features eight Arm Cortex-A78AE cores organized in four
> dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
> L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
> for IOMMU functionality.
>
> On S32N79 SoC, peripherals are organized into subsystems, such as:
> - CIS (Coherent Interconnect Subsystem).
> - COSS (Connectivity Subsystem)
> - FSS (Foundation Subsystem)
>
> This initial support includes basic peripherals:
> - GICv3, SMMUv3 from CIS Subsystem
> - PL011 UARTs and IRQ steering controller from COSS Subsystem
> - uSDHC from FSS Subsystem
>
> Clock and Pin multiplexing settings for the chip are managed over SCMI.
>
> [1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N
>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
> Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile       |   1 +
>  arch/arm64/boot/dts/freescale/s32n79-rdb.dts |  70 ++++
>  arch/arm64/boot/dts/freescale/s32n79.dtsi    | 362 +++++++++++++++++++

chip dtsi need seperate patch.

>  3 files changed, 433 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 700bab4d3e60..e79807bf1820 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
> +dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> new file mode 100644
> index 000000000000..d13eb3a0666b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2026 NXP
> + *
> + * NXP S32N79 Reference Design Board (S32N79-RDB)
> + */
> +
> +/dts-v1/;
> +#include "s32n79.dtsi"
> +
> +/ {
> +	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
> +	model = "NXP S32N79-RDB";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart5;
> +		serial2 = &uart6;
> +		serial3 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		scmi_shbuf: shm@93000000 {

use common node name memory@93000000

Frank
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x93000000 0x0 0x80>;
> +			no-map;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x00 0x80000000 0x00 0x80000000>,
> +			<0x88 0x00000000 0x03 0x40000000>,
> +			<0xc0 0x00000000 0x03 0x40000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&irqsteer_coss {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&uart6 {
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> +
> +&usdhc0 {
> +	disable-wp;
> +	no-sdio;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
> new file mode 100644
> index 000000000000..94ab58783fdc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP S32N79 SoC
> + *
> + * Copyright 2026 NXP
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cis-bus {
> +		compatible = "simple-bus";
> +		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gic: interrupt-controller@4f200000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x4f200000 0x10000>, /* GIC Dist */
> +			      <0x4f260000 0x100000>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* GICR (RD_base + SGI_base) */
> +			ranges;
> +
> +			its: msi-controller@4f240000 {
> +				compatible = "arm,gic-v3-its";
> +				reg = <0x4f240000 0x20000>;
> +				#msi-cells = <1>;
> +				msi-controller;
> +			};
> +		};
> +
> +		smmu: iommu@4fc00000 {
> +			compatible = "arm,smmu-v3";
> +			reg = <0x4fc00000 0x200000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
> +			#iommu-cells = <1>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +	};
> +
> +	coss-bus {
> +		compatible = "simple-bus";
> +		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
> +			 <0x4e000000 0x0 0x4e000000 0x1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		uart0: serial@4a030000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4a030000 0x1000>;
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <264>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@4a060000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4a060000 0x1000>;
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <269>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		uart6: serial@4aa30000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4aa30000 0x1000>;
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <270>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		uart7: serial@4aa40000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4aa40000 0x1000>;
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <271>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		irqsteer_coss: interrupt-controller@4ed00000 {
> +			compatible = "nxp,s32n79-irqsteer";
> +			reg = <0x4ed00000 0x10000>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x9a>;
> +			clock-names = "ipg";
> +			fsl,channel = <0>;
> +			fsl,num-irqs = <512>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster2 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster3 {
> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-size = <524288>;
> +			cache-unified;
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-size = <524288>;
> +			cache-unified;
> +			next-level-cache = <&l3_1>;
> +		};
> +
> +		l2_2: l2-cache2 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-size = <524288>;
> +			cache-unified;
> +			next-level-cache = <&l3_2>;
> +		};
> +
> +		l2_3: l2-cache3 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-size = <524288>;
> +			cache-unified;
> +			next-level-cache = <&l3_3>;
> +		};
> +
> +		l3_0: l3-cache0 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-size = <1048576>;
> +			cache-unified;
> +		};
> +
> +		l3_1: l3-cache1 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-size = <1048576>;
> +			cache-unified;
> +		};
> +
> +		l3_2: l3-cache2 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-size = <1048576>;
> +			cache-unified;
> +		};
> +
> +		l3_3: l3-cache3 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-size = <1048576>;
> +			cache-unified;
> +		};
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x100>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu2: cpu@10000 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x10000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu3: cpu@10100 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x10100>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu4: cpu@20000 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x20000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_2>;
> +		};
> +
> +		cpu5: cpu@20100 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x20100>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_2>;
> +		};
> +
> +		cpu6: cpu@30000 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x30000>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_3>;
> +		};
> +
> +		cpu7: cpu@30100 {
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x30100>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_3>;
> +		};
> +	};
> +
> +	firmware {
> +		psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			shmem = <&scmi_shbuf>;
> +			arm,smc-id = <0xc20000fe>;
> +			status = "okay";
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	fss-bus {
> +		compatible = "simple-bus";
> +		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		usdhc0: mmc@5b490000 {
> +			compatible = "nxp,s32n79-usdhc";
> +			reg = <0x5b490000 0x1000>;
> +			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
> +			clock-names = "ipg", "ahb", "per";
> +			bus-width = <8>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> --
> 2.43.0
>
