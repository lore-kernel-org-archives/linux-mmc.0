Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224113C1991;
	Wed, 25 Feb 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026760; cv=fail; b=Mrc9Kvx9etc6n3k8Fp2eAlwVy9V8m7P6PvGuQm5xGEED4a3AApZOy5q6kRSMsiidc3uodpBFG0+RAcqg1O74B/ycX4pC3eAb8EXB5qthEk3KWHR1LDrmkwI4NH8pZGQS6DG2H457xfs9Hl7l7F9hNtHp81i+hxoLewsRRADWA7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026760; c=relaxed/simple;
	bh=HCLAlzh/Oq6UkzPThOwysLCMcKrNySPF+jwJkN/IP90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLfpnWvLNgYkLq5f+wtBw/c5l9xkRjseBvTqriiot549Cvnn5Fh3yaQkxTeziseidVAlUlRpmCh9dT2Q0F3nOOnUVYzbBxW9xF9zCXYQj4F16VbR0CMpSaXwb393HTqR6X8A3bvEPZcRvbuA+iwWpbHWlWnEFTfGtRJaV+T027o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=It0oGrFG; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="It0oGrFG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1T2eVaP8w3YZYDaEevr8wuoCqq+p/UXc/d2GrTY1rTwpeAjz8wDA8aPAvnpFSV5YHGozfyQqIZQDToKvqLcntndUUx+MP6F+og6Rc0mv0QLYG1o8wSYrdO1iJeFVl3y7jZrQh8BI/v/MNp5MXhukVpf7CtMfsXYM2n08fii8A1MnEt0F7sbH/DA6v+cGfy12H/cw1AgoYerqeBPBVCB6opmCp7+QketFvi0PXHpmt7LdqQSnjfxy6IlBqkLSBxUkrx5FTWZHHVHkKjO2WuT0le0H7yeZhegy2fADxSkl3N8vg3tBTcbNxsLkVO8bB0bBP0tjw03TsvylKOxCUo24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c5qwBLGukcEIT0aLVqTiRXTKRN+RrgMhIWBCjMlrQ0=;
 b=iKVOBwcFvOhaLXqkH4xkgKjXjAerLvAftyyqMxS6HJptS/2K8J0g2HZi9JVZTbld280cK7nb0/8ZhoAV17bz2i4GULzQLuD2Bb0hVn+UETl9QuEW+uQfo12ytPAhGV7sTLfYgs3INDR0JU2vDZOn7E8+KcG9fTGzUAtCv5ieHu2+LhrPNc+bY0brdyl7XwcwhN4dOMuHuOPTx67n1jX9NQSnF0G8Y3E1+2ivhYk137sv4shVldFvaVwmyGZDvL2dslBoDmT+wSSR7MyWrOuPGnBiXNnumGRoT/J+JVCjVs5/ybLSGQlCyemq5J1s3SrlkBZVS+WdTukrv8SQmycy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c5qwBLGukcEIT0aLVqTiRXTKRN+RrgMhIWBCjMlrQ0=;
 b=It0oGrFGDEZm88g4IU26z+c6GUGKr0Exrp8vcge02ZEkA7b09i6bd/X61JXXQoI7yZZmP0345iKAfS633x8ro9GVHK/t5af6EednmuQ/FIWMGK0kUruj7gTizatli8HqR7Weee3dK5vA+EuguNn7hzLe0XABearFhn3JI9641mfEXnl1vf3ypIfE4irENvizEvrW61LIsUMri8LrtbxzfXVbNW6jvBU+qyKWz9J4+PptGRR+SJjpQTPM4bTrj0REgjXkvmIM8ZqBXy66ajGhdYYG7TWQw5FojtDx3t+fCy0pSzlhGTqWcU3dfBfnI/e8Acd1a4QBpxzsw5OD+DFSSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 13:39:10 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:10 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: [PATCH v2 7/7] arm64: dts: freescale: Add minimal support for S32N79
Date: Wed, 25 Feb 2026 14:38:58 +0100
Message-ID: <20260225133858.8026-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec76605-562c-46e8-f9d5-08de74734191
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	fMgytGMEMrTMvNfWYxjSOG2406a2TFHDO4UV86qlzm4Xp6Z7QvXQPWLz+lMC+nncXcxVVmz15ztQ/ui1HXFhSH0Um90M5QVw+kZXkpMVnTqi1TEZkOzmMYWgFPWqr8XXHSasaR/GKnUkRHZq94waQK8zrBmq9h8iMhpFrBJQ9y+0Rh6I635oUdyJbJ5UQ7U7N+T8SMcTvMB2Dr4atelBHHmGsFLfPaSGKpOmboUQ/EdqKfq+EJsXI5yH/OYQC4CpgxxAbk0zZ7PpC+OO3wwOPTrCFcxRzpFGy+NIOOsyF+1cyjvHVnU8Z4ugCnCCcZV9UFLq3D+TPqVQ512up5BpttSbf8mpPnC67ckmSFCgsbG+1PdUMcp92XmuDa2TBZyHwf4szDxJQgqVa4zwE15+ixbnMak1o9yGPrCFnG2Q9lE3eEWJyKIXTvY1brJdBygU2/eYxEeN26biGl9WXdKAlKBYVHv9Omaahu805r9FbKP825rVbGDwHxoWO8qRnwTfu+a51vPkz5Dqbeh2WvjxdG9NNvbrXOH2yul0zMoS4jeotYkDxFe5+/fyQPK076aXx1rhT/Qs05J0MtVFtB2X0XjyGh+eAfcCgUgBbfqwJ2JJt64YS7OEUNt+2338oHF1zhx2VSbBfQZo/2uwukFjn96PP53LSORFLCnz98bO7jyXw2WsGDE6FEnAPvGZIK43yZNHiKK4GTEFAqNUkf0wwvDdAvZqA5grOTqY+7XLQqFyYX5kbbuIh8lNegyiJ3RFVvlDRIvTu72Eh6JqH08LWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJmNnM3YWpwbjVOK0JZdHkxUTNKazROVGIwcHhQdUlrcmxDcFY4OE4xenV5?=
 =?utf-8?B?dXI0R05rWTZ3WlJmYkdXWlJLdVdGaTRnblI4dC9BeGo5V0M2L2JQdTlPN0pj?=
 =?utf-8?B?T3BuQzIxTFVSWTYwZ0NRS0Y0NHZ6TzBDZThUdWFOZENKNWFFZlRaTFFGTmlI?=
 =?utf-8?B?OStFSnczcFRFNTVHVmJWbTNxbHFFd0d2d0gwanhFMS90Nm9Tdzl0ckYwNXhK?=
 =?utf-8?B?VXphOGd6dVFGclBVUEhtSEkzMlVvVmZLSmJpWXBFOHcyK055aDFxWmlOaW9W?=
 =?utf-8?B?Wjc4bVVGTFRRZVlrN3A0aW5vRFpxTFZ3UjAxYU84WGo5Zmo0Wm56VjFyUytw?=
 =?utf-8?B?OWt0Zk92OWxGdUFXUEJ1RXhyR2o5UTJRQStaOFVZNEJ3MmtuSmFXckhKZFBt?=
 =?utf-8?B?LzFhSktISjRYdTNJZ3AveC82SExhSnhNWXVPdmVBVzBFeThmNnlVVjBPODcw?=
 =?utf-8?B?OXRkTkh4UEZhODJ0d0tLTWVteE9Fc0Q0SWZZMkhyOGVLZm9jYU9yNk1TMWNv?=
 =?utf-8?B?NThEUmxuMFZQSks4bzhsb3lqaHhPdXJlN04xVWgyWlcrQVlmc3J2Qk9JVDdS?=
 =?utf-8?B?OEpscHZjaSsrc1oxcGFucjZnSU5LL2s4N1diUE1hWi9DMy9xSU1MUnpGRWpo?=
 =?utf-8?B?T0hqa282R25udTJ4by90elBZUUFuc21FQXNmdTRRaEloSEZQL2I1bGtycW9G?=
 =?utf-8?B?MlFLd3VLOEFrdHJYZXRvVGpwbHQyaWU2cjVPK254RGdwSVlGSWpicUt2TXht?=
 =?utf-8?B?TlFVMTVjbkZyUlk2MTdUSGdWcmZXWi8xdGRyTDhnVWNlMnBqVVUxZHdJaWpC?=
 =?utf-8?B?SUt3K1FNNVZwczZHOE1VSGwzZzF4VEg3YjZkeHNOSWZ3WTkvKzZCMXI2bnRK?=
 =?utf-8?B?Qm91akNaOVVSeWxvMHB0dmR5SEFBT3QvRUl1Rnh6MldQelR2Z1EyTUNWZmVC?=
 =?utf-8?B?YTFFbmFyK2dIZldrL2lOd3Y4ajQ3ZkVkRFAxbUxwYU41b1RJTm11dVN2TDVC?=
 =?utf-8?B?OW0rTzN4SlZSOG9ucnZUcXdPZXBNTFpxd0ZGQ1JRU0tvTFFkNjMwb2lvWndw?=
 =?utf-8?B?bEYwSVpVblo1Wkd1N0daM1lDbXVnY0NJMXUvUEl3Slc1TEFjeE51Q0ZmRVhE?=
 =?utf-8?B?SCtKTlNHMkhEQUoxN3BwNHVkdkhBWnNkMkZpUHNSWkJ1R0lJWGlsTURWUVBz?=
 =?utf-8?B?dFVVMXVNL2FDV0xzMGJDd0RMZWZtYjkrR21xUFhIWlhNekdSbHVtT2cvMmc1?=
 =?utf-8?B?MFZLZG02SkxKNGVUZ01KVTR2MzVlQS9LN3hlSGx0T3kwUHNkamRSYlBib0Vt?=
 =?utf-8?B?MXZzN1VLdWlvZm1IczRDVFo4WGwxK216TTNZTVJST2M0MWt6bWpxTWhrNlhW?=
 =?utf-8?B?KytpS2NKTTRzaXZLTXJ3V0R3UEV0R0l2ak5ySlZETFBTUnB2UUdweThNYzU1?=
 =?utf-8?B?azE4MzRZUFlnQ0lIK0FCN2U5U2p1b0RETTlyT09GUk04eXdod1ZPSnlqS0Vj?=
 =?utf-8?B?VUdJaWpoeU9rR3lUSjdjYVhxdWIrc2Y1OXlvU0hVQUMxdm1ZZmFCWHA1aS81?=
 =?utf-8?B?a3VWalBUOUg2KzI1bmFQblFvNnlsZTMwRUt5NjkwSnZscmREVEpqMENwZzVS?=
 =?utf-8?B?R1dHTGtOT1loWGpEeTN5UUJka2xBbUtCV0lZVDZ4TStWQ2VGeE5lb1JuUkRo?=
 =?utf-8?B?ZlBwS3YySDEzbi9xMVlydHliekZRWXFHdVEwaXJyQnZvdDQ1Q0dUWmNwTnZq?=
 =?utf-8?B?SzVzSFRIdllYcml3aUtpVzhQaHBhaUhxdU1NOGZMMzhYZGwzQUVPbFBWeG5C?=
 =?utf-8?B?U05qSS8yL1Q1Y0xBS1dWbW92bzJ1MXNBU1VuR1hiSDdIWE9XVGRwTzRObmxq?=
 =?utf-8?B?Z0Z4a2JXRGZvamI4Ykh1VkJmdnpIa00yTFVlRW9Yb2dOT3BKbnFpSHVUYTBJ?=
 =?utf-8?B?NElwY1A2TGhrbUsvV1I3V21Ka0duZ2NGVjlXaUZMMTBWQVlOalZaM0IxZmxo?=
 =?utf-8?B?L0NPcTF1M0h3UnA5YWNPSnVsR04ySTBBUm53VDlleXdUVEQ3bWhxM3o3ZDEw?=
 =?utf-8?B?eStiVDVQRk9uell6TnBWVEQxeW91eXVzT2E1ak8wbmprazQzbVUzbVE3MFZz?=
 =?utf-8?B?N1hvNVpmbjJLZGZqNzRpRE44YVcyQ21kMm5UdWh6TE9FNmFMZnhSMTYwdTdn?=
 =?utf-8?B?Z2VlenQ1cGNGOUo1cWhYTUVDc1hxYitWMFZ6SFZCTHZ3TFhCZUNWYWVyZDVQ?=
 =?utf-8?B?VDVTMG5ZZG1ZSmY0UDZ4VUgvLzZ3Zjlna1lDYS9ZblBzdmExYzVHeGRyVU04?=
 =?utf-8?B?L1BFdjVOaEJxS01oQ0V5cnNvd0NSdnoxNGNYQWU4SktYOXhzeXhkenNGTCtl?=
 =?utf-8?Q?8+An6YJV1azWsTPw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec76605-562c-46e8-f9d5-08de74734191
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:10.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irLx8yjyRSIgq3f67wEXtO/7+0eqaIkKUGODwdivk+JwC9+W4ZKOPg6y06tL8iP0zal2IhrNCi6WzY1O/ZQUvj+H2vxU7BdybUE9ecJsMbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 automotive SoC and the S32N79
Reference Design Board (RDB) [1].

The S32N79 features eight Arm Cortex-A78AE cores organized in four
dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
for IOMMU functionality.

On S32N79 SoC, peripherals are organized into subsystems, such as:
- CIS (Coherent Interconnect Subsystem).
- COSS (Connectivity Subsystem)
- FSS (Foundation Subsystem)

This initial support includes basic peripherals:
- GICv3, SMMUv3 from CIS Subsystem
- PL011 UARTs and IRQ steering controller from COSS Subsystem
- uSDHC from FSS Subsystem

Clock and Pin multiplexing settings for the chip are managed over SCMI.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi    | 362 +++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 700bab4d3e60..e79807bf1820 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
+dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
new file mode 100644
index 000000000000..d13eb3a0666b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * NXP S32N79 Reference Design Board (S32N79-RDB)
+ */
+
+/dts-v1/;
+#include "s32n79.dtsi"
+
+/ {
+	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
+	model = "NXP S32N79-RDB";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart5;
+		serial2 = &uart6;
+		serial3 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		scmi_shbuf: shm@93000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x93000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+			<0x88 0x00000000 0x03 0x40000000>,
+			<0xc0 0x00000000 0x03 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&irqsteer_coss {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usdhc0 {
+	disable-wp;
+	no-sdio;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
new file mode 100644
index 000000000000..94ab58783fdc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP S32N79 SoC
+ *
+ * Copyright 2026 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cis-bus {
+		compatible = "simple-bus";
+		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gic: interrupt-controller@4f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0x4f200000 0x10000>, /* GIC Dist */
+			      <0x4f260000 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* GICR (RD_base + SGI_base) */
+			ranges;
+
+			its: msi-controller@4f240000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x4f240000 0x20000>;
+				#msi-cells = <1>;
+				msi-controller;
+			};
+		};
+
+		smmu: iommu@4fc00000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x4fc00000 0x200000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+			#iommu-cells = <1>;
+			dma-coherent;
+			status = "disabled";
+		};
+	};
+
+	coss-bus {
+		compatible = "simple-bus";
+		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
+			 <0x4e000000 0x0 0x4e000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart0: serial@4a030000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a030000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <264>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart5: serial@4a060000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a060000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <269>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart6: serial@4aa30000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa30000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <270>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart7: serial@4aa40000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa40000 0x1000>;
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <271>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		irqsteer_coss: interrupt-controller@4ed00000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x4ed00000 0x10000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x9a>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+			};
+
+			cluster3 {
+				core0 {
+					cpu = <&cpu6>;
+				};
+
+				core1 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_2>;
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-size = <524288>;
+			cache-unified;
+			next-level-cache = <&l3_3>;
+		};
+
+		l3_0: l3-cache0 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_1: l3-cache1 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_2: l3-cache2 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		l3_3: l3-cache3 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-size = <1048576>;
+			cache-unified;
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu2: cpu@10000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu3: cpu@10100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu4: cpu@20000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu5: cpu@20100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu6: cpu@30000 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+
+		cpu7: cpu@30100 {
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+	};
+
+	firmware {
+		psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&scmi_shbuf>;
+			arm,smc-id = <0xc20000fe>;
+			status = "okay";
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
+	fss-bus {
+		compatible = "simple-bus";
+		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		usdhc0: mmc@5b490000 {
+			compatible = "nxp,s32n79-usdhc";
+			reg = <0x5b490000 0x1000>;
+			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
+			clock-names = "ipg", "ahb", "per";
+			bus-width = <8>;
+			status = "disabled";
+		};
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.43.0

