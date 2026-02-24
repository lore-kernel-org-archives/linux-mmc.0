Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1403043C9;
	Tue, 24 Feb 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967359; cv=fail; b=ov/skKHkLqQ5qo33JnWVLUprI03KWfLEfVY22ZVFWEbPK4COF/gihyO1j3SbkiVu4/e2QpyQ3hYL7h45eImCBV0aAxTO+HkwyXyhMd0nhBmdza+l2BXXNk9LIevMqdpGcjeP2X9h23LQvqG7esxjR+e7omE0UyjFiGsn9icLo9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967359; c=relaxed/simple;
	bh=ib/bXJHqIxySw4b+suJFdBNnU/vsvBWvttnWi0ra42s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VV27u0FM997Rl7dLXYT+CxzGMi/841LxRDMxbvFqpmG9onuZv7NynljzytNNhmcRuErbOIfO2iCaJk/1zbROvGbPUHN1N5kkMAjW4vItwtew1T0+uXlzH3e6u/3t8eJy3IYWoLu+BAeKzIiIcQqxNzEQiHvWuNt7aTRi7A+lRvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JMH1Ww/K; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMH1Ww/K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWB5eH2EhRbnUdRVwX8E26g3ACKM/XAdmPhhZO3+d/AirSkzgqB82shNFCqBhztRWSzu3BbCcznsdtKqcvbGlRuOFjLRw3wtDuNFINZ8CEpUZUlRF9BsIUUxCm02bSw9daqUg5vfilNASKY/+mriDsugyVf3jqI/90IkYe8aLqz3c8y+iWd/xJTNNwRyQTwZzrf0Ps1fDCsb1rJQhJrb646NRLGMwX004zKt/y3mdvMO6w/h+wCk2OdnoCKcIR7E1eMJljfJnEw6aeYUdaS6dRUei09LAcrSLd3GO6n02bI/mkLcbml24nh8kuukAF2tzOYLLkqCc6emjzylB8wpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdf69i8XDltF8dtpdMSxZvioCTly503GAYPa15jU1AA=;
 b=HQbxk9NhQQc5DTOZBJbREMRoADegpUGpUIjaYVpf31c960IZoZQeUmRXpJvmC2Zo3KdSrepf9U/iQMohRnlu9Fnu7JqqyZufiV+ASJ+1rTUP8ygPDJEU1TMTq5joQggepJeJyGvG346z0IUjwIHhQHAjso6vim1o21B1qtdi5sTim5nW+Js4tDWI0EgKkwpAfiJ+VIQMsW0aTOT1muUdtXQ26CXC2OSr6JN/eMkzBzI8gpgx9jhnw47ZdJlG4v5k8ABAxjQTG7z1pnDum8j191dyH6Ub9fqgnkvkUNydxjV/Q/3ggTe95/rXNI7xDqOW0ao8m5qDC2d0XQVhtt0bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdf69i8XDltF8dtpdMSxZvioCTly503GAYPa15jU1AA=;
 b=JMH1Ww/K/Vzut6dj/2xPCSZwyfuIV8N9lB0Kzn6nPmoN3xwE/jguOxJ8ASJlSmd3vdKDsVzs289AhPqHcJEODViV/yqvEaZ3B0HbbV6P0xcw0cLKpKzLkAA/v79K5QGy2Cy259dyeeI7IfkFerNFw97D9499nD7eAT5gBSPlOg4+UhKuFKRInl1wKdK55npKcrxKT1HNjzoxl7EX8a9nOB8VwoM+jJIUO/IRszZ54PbTRM0fmp1s+9fUxddT1dpl4uG62ypLMyHDnHaBHvO2YZ10YlWweRTdSQEafTzIrW97ggWbirEvxuH149rRlGGvVyFJvblxbfTNDi4XRto/MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 21:09:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:09:13 +0000
Date: Tue, 24 Feb 2026 16:09:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: Re: [PATCH 4/4] arm64: dts: freescale: Add minimal support for S32N79
Message-ID: <aZ4TcK6GLZTsbGBf@lizhi-Precision-Tower-5810>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-5-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224111533.3194883-5-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e9eeab-918a-4a64-671f-08de73e8f5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUiFrOHeui/fhXBvk9mytCLKvOu4oHszuaNgY/uhh/P8pEFuJ/MKnFMsW2Y1?=
 =?us-ascii?Q?kaYf4KH82TwpQbNIPWrO3Qel+viHsA+C8AScMCgfbIS9mnQgqjpuSNEBWwa0?=
 =?us-ascii?Q?uonQoQlkELeBLg+esxryKWbhM3Grl+Om+4NtvFr+Br2bD0ClGY4Xh5ID0gup?=
 =?us-ascii?Q?ndW3XOoitf3s581qWlTLB8oAW22iUzA9Xgm8+n+3dnJtxFRynBV6zVcfScH0?=
 =?us-ascii?Q?8mc/mwYozQaiaOZ5W8aoXYz7pLyxvAtlLP/oWV5PQBxWC4rgqma8l+G71bB8?=
 =?us-ascii?Q?XXK9UnHvC7w6pnHl8r1rIUSUG+SijwwsjnSF3m3oHFEPNpZkytnibiTFGT14?=
 =?us-ascii?Q?G9STh4HEOfmBIPTV/huw2JsKN88i4DxQkvOAV1wf4EmbxuSaR1X2ZWdyG/9H?=
 =?us-ascii?Q?lMPGbw10i6eYc6rgcdLUj9jhDYybFI9y4ShH5nNyKVgQLzZiNM/8Nflsy8oN?=
 =?us-ascii?Q?mSjQlO+wbLzxfzglnzbr/rG71oP0DUgHmGtpCX9MXoDAesEPFWk/2FSo3IDt?=
 =?us-ascii?Q?oqwxCGV+SAREBOYQ4zSJ+SkfpvnyyvQvne99Oy0tkhetpQn7nCoGJ3A5tDkS?=
 =?us-ascii?Q?480hhkeWH3R/7RNpI3kyd3rqibsA6UxjU7YIFpOJLdHFBBS51qL4NijG6Omm?=
 =?us-ascii?Q?6rijE7I4e35bn8qX/TQzbqtf0kgNZuF44Bix+gcr6YCuOgX80v5qs5cZ6hpW?=
 =?us-ascii?Q?8+7kwPrvf9Su2mBIYueSrIqfwjPR1zWvhomA0sL9MlOwayXStwb8cj2OQwvu?=
 =?us-ascii?Q?1P8A28wTa6Pd+rFbMllNCuFPqRKkqvf1krVSzy/6yHQIMV+NfWagf46x4ngj?=
 =?us-ascii?Q?ozluLwEvljrwJkwHtOJLv/2hNFedcCHw96tu9Kzh6OByduW04NmOeMqgOUOt?=
 =?us-ascii?Q?CKDInO0K0fFSToFs3FknSpjW/jhgWOg6TPvct6g1sf7eINgJw+4H9s7KpyZI?=
 =?us-ascii?Q?VXDIQ9YqQUbc62IxX9EHLcHv5qIpfez8ZRbdRU1TAYzee58fAXxiI9sLRVy8?=
 =?us-ascii?Q?jX8ZsGIrcjQUkFT/16CLXCunRA2g+fIjhhrBbapc4RpbGsEOjGW02/LwjBGd?=
 =?us-ascii?Q?gyFlOoK0XXdDFlHZacDzYE+IlnTqYmSlPTkx+jUJY3/PWUe+W3BR77YqiiVa?=
 =?us-ascii?Q?U6gpTmhxkgHpqzN84UdCIjPT/joBO+1HexjnL/HayqqZjsFDr+2t2BZQsNHc?=
 =?us-ascii?Q?tvlCEothib21K1Gex4rUlRZVO5xaMtGI9Zz5UxR+/fRWCyr4mgtitmb5XLgc?=
 =?us-ascii?Q?ZRqpIzwBWA/4dfzMLgIJDrJydjm94q9sMdv/yiQEYBUBtCO9uHRNbIl5F1Qp?=
 =?us-ascii?Q?rpRGkrKa/4ltSe0sLHjz8JhEWRqcihds+axCUawMdO2CUgVWKvE8LAIFk6C1?=
 =?us-ascii?Q?EXNjooDABdKQCYhsBxel5I0pjzDN1O1j2d3/G6zr0OEshjC0U0ah0ruohtlW?=
 =?us-ascii?Q?EDGP8YSRnhg0c3GoAs4Fob4PFIHQ5oqG5EAs3eqf5OmSvdRBq4tOWDzgAgMx?=
 =?us-ascii?Q?CFSxAoZhBj1FzPkUUeGjpPDfgVTikG3v8ofwb7hdHXbfYV64GTe/oZfaNFXl?=
 =?us-ascii?Q?gv8XZZcJcw4exLgK1U0TnrR7KW0WdMoLjPDKt8kW8/WbUfVYYAFwDe+LqqZL?=
 =?us-ascii?Q?8DSZX4AlxljEYCwLAlJtXo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaGDVbuNGhgIX5o5dVI9fTm9Zj9ceXoaWiao3cGB5hpNvmiuRkDkK+Z6WabF?=
 =?us-ascii?Q?IUmsf05LUDDKFU4fHSyNxsmmsZYpB2P3vFTTMmYhMQYu1+7cYVEKcG1BgEe+?=
 =?us-ascii?Q?rEB5ZtkSdR1Hcq6w9CvfUysnViO3nAVEPZILTZJGo2qc2zWVDj2ZBbo1ZgOc?=
 =?us-ascii?Q?ip8UBFMK0b2P78mnQ6shd2tHtqf8cYEKVOm/djkDLPB9wF8NANn3RGuEQT/Y?=
 =?us-ascii?Q?Bw62gglzcdR9EgtBnkCP0kMjK3zq3rLttK9wTP9wr1gN3kwHM1G0zdUSQrQy?=
 =?us-ascii?Q?1EozjNQez3tkyDXzBPepXZpYrRNbkAW9bll8a6lQ9311Q7sfehqOeG3ah6W7?=
 =?us-ascii?Q?UGG3LqLk6P/7q+bxq/rTi35vjQY1lDQ+n+sf5qLE+8W6uVz3UVqk/Iqa0V3J?=
 =?us-ascii?Q?eJ/2IiU3exZBWl2hFIJE1bgreQV/JLshlpavsdD/mHZjVrCo7cc9ffNx7cuL?=
 =?us-ascii?Q?QHUh64hf+dMI4DAvUOhVQ02JIMVFc1l+JNGrrTA73QUEESXnAtqMiF8kDjXq?=
 =?us-ascii?Q?xzG+hW0Xs7m1/guo5+QnWTm7qN9IHzVJ909/KCZ6OG4BGbjqy0zqDTnGVImN?=
 =?us-ascii?Q?vhV64V/I3ZsKg00h2AuQvi5eiWmvFPnwvM0vlarA55/Y/MNneHrZ4Ys53m2+?=
 =?us-ascii?Q?c1IiFF9LsMF+DdvRJRGux+3Nr2NBYOc7FsWr+bPIqgPXW6V1YW7nXTlBdlld?=
 =?us-ascii?Q?AyHdH+r2/sDk8pL8PuGsxtWU6hIhngOCcQYv/XCGLrk8eeCK2yDyKUseVTpp?=
 =?us-ascii?Q?gVkBmv6xnmhNSvPIwE16UcY8wr//NNFS2cEPYMUXSWwzLflEDgihSOryV0pI?=
 =?us-ascii?Q?e/V0RdgZwjUIANw3VIVdpqqgUanUzRNmSsxh9YqUcLAPvPIleYxxGx98Yzmp?=
 =?us-ascii?Q?w6krJc+vbzBOX4SNcEg60ersjsVVMRLqAqANY3LPi9LkJ+ALpGXtMFi4nLce?=
 =?us-ascii?Q?SvPdQolFfYoSql2qMv8KELCZDeuaUXoe+MR+2co9I0J8cx38TDnlcPgEKbY0?=
 =?us-ascii?Q?ToTGzCzj4yB9yGIrA/oLXHIqLUDSbXxxtJWE3PWDWn386iA9xcxH9A+RdSdF?=
 =?us-ascii?Q?v49tpU6/PiqkNgrXM8W5/fatMtn9ngcAUPPLXmOJYQ/kmk5W9iOOlbgQhwBd?=
 =?us-ascii?Q?uc4jJqt/i1xbxiZE7VqHj525kEmKImwAIaEOK9iPkx+JRBK0qe/bqxu5pg80?=
 =?us-ascii?Q?X0yDLLbQmZZh+laOSMe35q2JkcVNDmlp5kGqTpCGHrKcm91BVbYAmPttcDMJ?=
 =?us-ascii?Q?gLc+A5OBxTtpOVS8dSkt3neDheuMO2vRmwpJQCULQ3INghW4HvhdPT9m+su4?=
 =?us-ascii?Q?0quMjS55F+OpA8u/B+tRCn309L8cScoWN7LjGltcABXAQmgCxGV0mh4L+BpR?=
 =?us-ascii?Q?+2SqIAfkG4kxVTq1Lk4+8jvRF3z3J9/bSWL9qzzFwUPQ/1KaHYK7Xjs51vzc?=
 =?us-ascii?Q?ptW+xCTaxDQwNbJshexVHuph8Be37I70KBeZ8q98DMKDqZq9RaUu9GqazVRJ?=
 =?us-ascii?Q?X9goBV4JgT5PnotX4UiTz/yhuso83aBkz3HFBFhDtNkY7g3ccmaJCG83OUIs?=
 =?us-ascii?Q?7BNz6AdlfE1nWtBQ2MSm0dBVoPz283S5c+GTQB4YwZ3v6JIMopgrABizVsUi?=
 =?us-ascii?Q?Qy2R5xYo4jaFMvUyiXqJ/859lazL7Q8U8PdxjDoMlKjkewmQ5JdtRiq7AQsq?=
 =?us-ascii?Q?bTlzWFAel5DoQhAh8tW/f+YqKVMum4HyTVqk0ttUaIyv63VLfDM7xExQ2St0?=
 =?us-ascii?Q?CfRFADDycQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e9eeab-918a-4a64-671f-08de73e8f5fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:09:13.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yptByqiqTsVCvjWnxDbyunM6XDJZzArz7fdWKQg/KL6o6L1cTQHbhrVaPlXYCs4C9QzsM/2Ml0Z+mCuHyZiyQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

On Tue, Feb 24, 2026 at 12:15:33PM +0100, Ciprian Costea wrote:
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
>  arch/arm64/boot/dts/freescale/s32n79.dtsi    | 361 +++++++++++++++++++

all new dts, run https://github.com/lznuaa/dt-format to keep consistent
node order

Frank
>  3 files changed, 432 insertions(+)
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
> index 000000000000..c8b1dcefa2db
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
> +	model = "NXP S32N79-RDB";
> +	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
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
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00 0x80000000 0x00 0x80000000>,
> +			<0x88 0x00000000 0x03 0x40000000>,
> +			<0xc0 0x00000000 0x03 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_shbuf: shm@93000000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x93000000 0x0 0x80>;
> +			no-map;
> +		};
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
> index 000000000000..ff4e004fcd7c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
> @@ -0,0 +1,361 @@
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
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu2: cpu@10000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x10000>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu3: cpu@10100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x10100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu4: cpu@20000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x20000>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_2>;
> +		};
> +
> +		cpu5: cpu@20100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x20100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_2>;
> +		};
> +
> +		cpu6: cpu@30000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x30000>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_3>;
> +		};
> +
> +		cpu7: cpu@30100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x30100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2_3>;
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-unified;
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-unified;
> +			next-level-cache = <&l3_1>;
> +		};
> +
> +		l2_2: l2-cache2 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-unified;
> +			next-level-cache = <&l3_2>;
> +		};
> +
> +		l2_3: l2-cache3 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <524288>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-unified;
> +			next-level-cache = <&l3_3>;
> +		};
> +
> +		l3_0: l3-cache0 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <1048576>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +
> +		l3_1: l3-cache1 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <1048576>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +
> +		l3_2: l3-cache2 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <1048576>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-unified;
> +		};
> +
> +		l3_3: l3-cache3 {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <1048576>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-unified;
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
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			shmem = <&scmi_shbuf>;
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "okay";
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	cis-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
> +
> +		gic: interrupt-controller@4f200000 {
> +			compatible = "arm,gic-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x4f200000 0x10000>, /* GIC Dist */
> +			      <0x4f260000 0x100000>; /* GICR (RD_base + SGI_base) */
> +			ranges;
> +
> +			its: msi-controller@4f240000 {
> +				compatible = "arm,gic-v3-its";
> +				reg = <0x4f240000 0x20000>;
> +				msi-controller;
> +				#msi-cells = <1>;
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
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
> +			 <0x4e000000 0x0 0x4e000000 0x1000000>;
> +
> +		uart0: serial@4a030000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4a030000 0x1000>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <264>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@4a060000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4a060000 0x1000>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <269>;
> +			status = "disabled";
> +		};
> +
> +		uart6: serial@4aa30000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4aa30000 0x1000>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <270>;
> +			status = "disabled";
> +		};
> +
> +		uart7: serial@4aa40000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x4aa40000 0x1000>;
> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
> +			clock-names = "uartclk", "apb_pclk";
> +			interrupt-parent = <&irqsteer_coss>;
> +			interrupts = <271>;
> +			status = "disabled";
> +		};
> +
> +		irqsteer_coss: interrupt-controller@4ed00000 {
> +			compatible = "nxp,s32n79-irqsteer";
> +			reg = <0x4ed00000 0x10000>;
> +			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			#interrupt-cells = <1>;
> +			clocks = <&clks 0x9a>;
> +			clock-names = "ipg";
> +			fsl,channel = <0>;
> +			fsl,num-irqs = <512>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	fss-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
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
> +};
> --
> 2.43.0
>
