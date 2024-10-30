Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2138.outbound.protection.outlook.com [40.107.104.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F983FB31;
	Wed, 30 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295475; cv=fail; b=LrJDWIPyzTtHBnzbDh4t/9tREKIrGicmeI65YjUYRmjVzkLraXSA79HP91rsppeaGwBQcsRl5Sgzn+RWeR8oTscVag5+K4rW3LZKlsxvUVWrcrsEqQnxInnY1P3VU/pXsaukeLkJWyUdgJtB77/PJMFSpn9yG6ClydNlPCD+mg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295475; c=relaxed/simple;
	bh=Iz6D86BJ+v1kD30AlF3lE87DOG5fspHhe5cXH87xy+o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YDhoC8b/qbO88wGaf+hW07i/N92v5svRHu3+pNBGxVF8KA1nHp3+ZKzXxqCwbl6rADw1S8yJctNszrqUtoVeUVhAO1r1ZZaStGIxusybDCrrcTvEnEBhnjVw+3r+WPl5pw3tH7wogeXpZG3DmHuJVkQ1au5Pm8TZ4KlIjevee2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hJK98ixX; arc=fail smtp.client-ip=40.107.104.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hJK98ixX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0nkapL0KZpG/tYEmA6VRDKMOIEHOLn3kb3dZSu6HBEkyiT8z5pEawK7Tp3xpV2esZiXQHbLhAlnxr/v5XBZ5Xdj2uZqGJHVH4H+2mdAe3bc6ONjGEVN6ZyxRMRY53FY2mOfGM19j16XDWaqd33PVQJlSUVBQZsJGIaIya8iOLWN1L3RlGvkKFxNO5OmmuYJPmW6CCxRVc/l0OwHs54z1X5/TicbEL4nDJXCzFBRAHI2tXMXFYajZMRFnIqYgPjQwEqkByIuyCx7JxVMVak4LpkJaKKd7YlHbOwjDocRVzMEHGDXXNrlhpIIgZW4CxWUO9W86BXFp5SnjLWwuz7e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e184kCNwhO8v3NLRlRa1rf3Zevj3HAR1mS/hzlzijk=;
 b=WMNchNrfCtIPfNW/74lL9lBU8f5Fvpea7JsBuDBdRxJAvjR27rxEbkMv3sxLAFMwxq3E5/snYfJwdO8g4yE7dS+ODwcZ1hgWsx8V7niczNGks7JyNz3CAFtGEDDAn9ntMTaMrjxfEAI2pXAg7lOQ7lKOlFyrWsMAQHQnU03C5q/GsTlNBmKgnCtLQguJDjSeFkROUn5j7Q1iIvqy3/iCx025tAZtq2vvqwk/VsynO30TXe331RN+y8czH5YWlkCGkkjfLleMKJXVKtRlN6mDT2mgitqy8uODX3bIfDM2oj/GkV/1S7Dmeh0iWeeD5AzkVbNPlghUZCs1TWF2M10hLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e184kCNwhO8v3NLRlRa1rf3Zevj3HAR1mS/hzlzijk=;
 b=hJK98ixXQPBtTu8nYwR6huE7m4GUiVwm1mFAmlY++ABNo3a1qwL6sgemmGHw/wMfe6iHB5VyjXkRVB3kGNpD+4WSLRRzdk5O1Sq0VnjX9Fh+MOXmco7MmAKUp20L7Kk6Bi6m21eEPLUXKM1P/8v2eW8pVViWMVwVCa8LB4/wC+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 13:37:49 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 13:37:49 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 30 Oct 2024 14:37:43 +0100
Subject: [PATCH v2 1/2] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-imx-emmc-reset-v2-1-b3a823393974@solid-run.com>
References: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
In-Reply-To: <20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
 linux-mmc@vger.kernel.org, s32@nxp.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a6f39e-3e48-445d-a19e-08dcf8e80b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2RrbkpLMUJOdWN0M0hndmZoNHJzQVQzSGVidWZYazliTFI0OEtNd2FFNDFP?=
 =?utf-8?B?bVZWUnh0b3FVRkkrQVlrK2JmMVJWSEtLdUxhR1I3aVJ6cmwvc0RGYUwyU0dS?=
 =?utf-8?B?ZWFPNG8zNWtLVXJVWTlDZ3E0QUpxcnBnak5PTmdFd04rSjNVaVBSLzBnWTJz?=
 =?utf-8?B?ZUtKazYrVE1wNWY2SkxQNmtORjJwL05vRWZTMktVYU5OYnIwa1hTU2JMUFpT?=
 =?utf-8?B?a3Z5MzhPaVl2WnZjUERFaDdpMWQ2RUIvOHVsOGUwdDRFajlrbWZUYmtGWlpZ?=
 =?utf-8?B?Zm9POU9yalp0enFnaUNnb0pVdnFsUVIvaCtZSTg4NjVLcGh4NkdXRVNGZ2Jp?=
 =?utf-8?B?eXM4SkNTVVRzYjh6TW5mdzBnQU50bWRUN1p3cGxpdlkwR2V5TkJUUDYyZ3Jv?=
 =?utf-8?B?aFVYOThpSnhMOE5SSVJWODROU0JNU3RoZ1RweE1ocy9mRWhKLzRXR0pGMHBC?=
 =?utf-8?B?L0ZSUzJMclBTbGtJM3AxL1gyOE54WW9UVFNVVVhDOVRlb0tiSEZjQ05qZTBy?=
 =?utf-8?B?U01qaXNCMFVjdzhTSlNrSmU4ZWQrSFlYNlk0Z0k3Z1JoY0VrclV0TVNUKytR?=
 =?utf-8?B?MG5pOGZCcXRvY1hiZkkrUDR3NlZGWDRabDVWeXRRT2RCb2orblJUaTgzcVpP?=
 =?utf-8?B?SGY0YS9OVFRUUTNrYm9PamxiWmd0cG9DMXRtZ3NPQjgwWW9TYUNiY25pcksy?=
 =?utf-8?B?aGtwb21IVXJ3RWVyYWhBdFRxMW1ZS1R1aWZrRTFYZzlsT3lUTkdDWmp6a256?=
 =?utf-8?B?TGk1Wkc4ck9TVWxpRnRJdzVxaXBoaW43OWtRaXVQUS9FM1NKckt1ZkRMZDk3?=
 =?utf-8?B?UXZvcVNnZ08wZGRSU2paLzBlOHlUNFdVcWE1TVFWdXFPN1QyYkZrUXl1eGtY?=
 =?utf-8?B?MDNjNGovRHV4ZzUrUEx1cE5BQjA0cWljUFNNNWVNQWtPVmd1dHZMZHk1aE1v?=
 =?utf-8?B?UWlpQ2hRTEk2OTdzWVlyaW5rdUM0TEtVRW9KejgzZ3ZJcmUwNTJ6dHNXL2ZM?=
 =?utf-8?B?ZTU5dzlISUFVMW1hYnpDaFNZU3hNMStnNU9WcHdoS04xcEpZMjFhcEZKQXZw?=
 =?utf-8?B?NSttL3RqVTBYWmJQR3IrMU94NnpWL0s2L3hXb2s0KzJVekZGT2tGN1JBTG44?=
 =?utf-8?B?U3hlbjcxUHAzYmxNdkJtc0pieFpwTTVONTBHcTRvWTRhUy9XV0Zua3MwbVpq?=
 =?utf-8?B?cCtyNHZvMmJ0ekZWRkc3T05udGdMTGsxTHZtVVNkeVlSNzJDdW9acW5JNzlz?=
 =?utf-8?B?ZzI3QnZxWjlyM1VldkJSNFc2SHlSQXJjZWQ1eU5DN284cFpDN0daeE5MRCtW?=
 =?utf-8?B?T0Z5QzNiVkRtRitleWFDNzk3Q1ZzbEgvc3JTbzJpLzBiTTRxYXJ5M0F4azNx?=
 =?utf-8?B?NkFGeFhydXh2SGc1cDZsbTFOUDBITW1TdXhwU1Y3NUkwUnBGTkxKd1U4K1Ry?=
 =?utf-8?B?eFZGeUJqeitsS25pdDkzRWtZVCt3YmR3VzlodmFIclRUTjkzZ3lPamU0bFdJ?=
 =?utf-8?B?enE4S01nZTh0c051VlV0Um5VU3l2TmJiYnhPaGRiTnFkZ3lMZUtMaG02aGJt?=
 =?utf-8?B?Mlp1OG0ySHl3RE9tR0xsaWk2NmlwUGxMdWFzaUFCTWlUeWRmNndNZmY0aFc2?=
 =?utf-8?B?cFdjdnFqZ0Ezd2hDZ0c0YjcyczlMUkpyNksyWmJnelRkTitXMzF3TXMzOU5i?=
 =?utf-8?B?clFRd2R5NlM2Q1JUQkN1QXJMQWFySnZ6NUprVWRSR3ZsNm5rSm5SdVQ1RERZ?=
 =?utf-8?B?L0J4YlpxWm1UcGo1RExkL294MXpBMkluWTBxeTZNaDJvZUlaeEdkS0VxcFlT?=
 =?utf-8?Q?OmtbjEYdW9jfjyFJku5YVqFpdZLBwOy2SnaTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHNTSUZxWFhKd3VMVUY0Ti9UYnJjM0h3VVNBRjFuR3orMzI1NWlDSTBoam1a?=
 =?utf-8?B?MW5qeHVMNkxnLzVWZFNZKzIwb1Y4aVBCZU56WGtwZ0ZTS0pnR1Jic2dRZlRW?=
 =?utf-8?B?NW16TDFKK3pDSkRLNCtOY2htbXA3dmFoMmZPRk9wRTJNdXZHaDFTMkx0bmN0?=
 =?utf-8?B?MUY1akZ3OGNNaW9XdHpxZDJvdFAyMFVFS0hxNlhjS1BDalg0MndUSlUwN2dK?=
 =?utf-8?B?RGR6L3poR1dmTHJwTjZxb1RHMkYzbXFGQWhZcnVSQmpiSGZIeWZ6ZzhBeFpV?=
 =?utf-8?B?bDNQVEpCTEs4MFRYTkpES2lTdzFmMFRJU1hha3F4TllOVmpiVnN6MFE1bUxl?=
 =?utf-8?B?OW16cEdOR3loWVp0M29GNFQweXhhZGtqcnp3NnZYbjAyN2VyZWhtUDR1dHE2?=
 =?utf-8?B?dW1EQUVhM09ka0NGbnNWdTB5T3BTejg5WjltR2Uxanl3d3Z5T0UxUFV1N0hC?=
 =?utf-8?B?RFd3d0ZicENLcXVqbnZNNkVJZGpQN0pacjlsSlVrcVRwNEMxREZiVk1EQjI0?=
 =?utf-8?B?U2N2YVpwSmowN3hwdEZBSjJubG9aaGJaWFpRTmR6eDY0VWlnK3FnNUNINzgx?=
 =?utf-8?B?a0VqYVVTRDhGSnA3R1NaNWhlcjRMUngwQlpvK0pLeFpuUEo3ZjhsU1Y4VElT?=
 =?utf-8?B?YmlOakdiV1A3bzk4MmNNdXhzMk9iRmViQy9qUXhTSmZJSFBiWHRHT2R3dS9O?=
 =?utf-8?B?RGxHZUI5cWtVZzBNWVUzcFViZGVJU2t5UkVlSGduN21oYnlmaUE4ZCtZSHJ2?=
 =?utf-8?B?NGhrTHZ3VDdySXRaaDVIanlVdzVxOWFMRE9vUFVtOWJFcXRPS3BZKzAvT0pX?=
 =?utf-8?B?bS9rNzZaUDFuYnNlNDVKS1F3ajNGbVd0YU5wclErclp3WHBncTNTcDdkaTd1?=
 =?utf-8?B?cXM4OUxqV05mK08raFNTMDMvaC9hOHhvLy9jakc0SlM0TkVqVVdNZFBnNlpt?=
 =?utf-8?B?bVJUTUNnL05CNkwxd0NEUEdzWnN5dC9YMG1xOEZYajNKcFc2WWwrNk5qWDdY?=
 =?utf-8?B?dTJNdnMrVEd4M2JYejBHWkxBL2lSMGJNa0VDcDljRFpQME9DWE9nVTV1U1cr?=
 =?utf-8?B?dVcxNmZHa0JXZE1NL2hYc0JtWjBxODhQMlJXMkpzbnNYeVJtSER4NXF6Nm11?=
 =?utf-8?B?SFgxa3BiYS81NlFTSjZ4NE81aVFZT1N2K0xmWGhia0F3bm9XZ0ZDekczODNl?=
 =?utf-8?B?Wll0ZVVaemtIc0ttZEdBemYxVWE5cUs4cytsUElzSUZtWjVkQTVIQ2tSTVpw?=
 =?utf-8?B?UGhmOCtFUGNBY1ZUTGNuQmZJcE40bzd3alpPVnF0ZlM3ZFpxeVFjL2drK1hO?=
 =?utf-8?B?RVBhNVFSWlc4d0hvWWJpRU0yMzRGTmM2Y3QzSHovMjBIN0QvU0doWEt3N29L?=
 =?utf-8?B?YlB0cEEvb3B6R0VRbWxJalBTeHdUbXI4VTkzQlh3WktCcXEyejUzdXYrQWxE?=
 =?utf-8?B?aHpkdWNpRkRkanFJVU1Ha1JrUzhaRStTaytJTVd0UjIzeXJ1SHluODJWd3Zi?=
 =?utf-8?B?Q0gxRkxoak5YdVY5T2ZuTC9HeFgxdTFvckxKUDRuSHJ6WjZySzdvRUJObGw1?=
 =?utf-8?B?VmVFYTNnYm9ZL1dnQXlpMFYwK0JJRytxM1o1TjJ1M2M2b1NwcmN6U3NzWmJN?=
 =?utf-8?B?aVBmek5keTZpUyt2eTExUnl1YlhrcHo3bjRSdDJrbXJpUnpLSkNmNmVLMUF6?=
 =?utf-8?B?Y01Oa3ZVUStHOXRDNGtlSlBwSzdJWmRXMUU1enVONGhwbWpSS29TZzIzM255?=
 =?utf-8?B?UlJBK1lxSUtuQXd6dk8waW1VRGFycnBPbWlZb1MyWndDek8yb1pnTnBqdjBK?=
 =?utf-8?B?S2xobU0yQVVUeGFNclJuTWlaaVZ2SzFrZ3ZxbnN5L1dsNzZGaXYyR1NkUDg1?=
 =?utf-8?B?Ny96NUJBdWFPdnBhV0VicVVSWUovS0NyUXpYTktMVzNnOTQ2Z0t3Vk9jTmJh?=
 =?utf-8?B?OHBFSWhzZzNJRHJhdWpzL21DUkFPMWV6MFdJU2NhSDhldTNzUG5hUjloWUJl?=
 =?utf-8?B?TnNyZWRVamNnVEFnSlEvNkZLVS9temFZQ1NnRzZPS1VtZTYrWjRIU1JVeXBR?=
 =?utf-8?B?VTdYM205WlRWSHZaandSS2s1WEt0UlVQbkVmczFtMVZybUlvZUFWUDFxcFU3?=
 =?utf-8?Q?z2acdiHSf8qs1F2j7DYjQc8it?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a6f39e-3e48-445d-a19e-08dcf8e80b9b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:37:49.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvzdhCrEiEXgd1UDtNpdDXY4EjVU2bAg1BJEWEd/aB0nZOrqGuOTpe5VBK8g/jV81oEPPD2nyRv1JghgBZcPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

NXP ESDHC supports control of native emmc reset signal when pinmux is
set accordingly, using uSDHCx_SYS_CTRL register IPP_RST_N bit.
Documentation is available in NXP i.MX6Q Reference Manual.

Implement the hw_reset function in sdhci_ops asserting reset for at
least 1us and waiting at least 200us after deassertion.
Lower bounds are based on:
JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation, page 159.
Upper bounds are chosen allowing flexibility to the scheduler.

Tested on SolidRun i.MX8DXL SoM with a scope, and confirmed that eMMC is
still accessible after boot:
- eMMC extcsd has RST_N_FUNCTION=0x01
- sdhc node has cap-mmc-hw-reset
- pinmux set for EMMC0_RESET_B
- Linux v5.15

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0402fd2a0695903cf261a5b4e19dc..a830d9a9490408d3148b927bf1acc719a13e8975 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -33,6 +33,8 @@
 #define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
+#define ESDHC_SYS_CTRL			0x2c
+#define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
@@ -1402,6 +1404,17 @@ static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+static void esdhc_hw_reset(struct sdhci_host *host)
+{
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N, 0, ESDHC_SYS_CTRL);
+	/* eMMC spec requires minimum 1us, here delay between 1-10us */
+	usleep_range(1, 10);
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N,
+			ESDHC_SYS_CTRL_IPP_RST_N, ESDHC_SYS_CTRL);
+	/* eMMC spec requires minimum 200us, here delay between 200-300us */
+	usleep_range(200, 300);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -1420,6 +1433,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.reset = esdhc_reset,
 	.irq = esdhc_cqhci_irq,
 	.dump_vendor_regs = esdhc_dump_debug_regs,
+	.hw_reset = esdhc_hw_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {

-- 
2.43.0

