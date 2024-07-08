Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4391422DF;
	Mon,  8 Jul 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440635; cv=fail; b=JMBgG0e/hEptpUg6tZubaTSvoUuO6odUFuC5V6arGLxjkXxYDZD/rJRO97LwkgoY3UMJIhAfTfBq+m+bu/RQtbwLkQnCSaXMfDrR7LQ6w+yq3oPOg2eohZsqSxaf0+H6jLXR/6mlKBXVOaQ69/Z+tuuyZEvjz0vnxTbzSsM6ajA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440635; c=relaxed/simple;
	bh=4/UivPtlR60qrSoh3s+mf7nWjTTkNYETFIIUAGpASAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rzb3/btc/wDfc96R/q3p1dvlAnpMrvJrhd7pFxFxZd9YdiHglxACUgG2IfV65cGWxJAT0q1R51AQM7VWAei2e0cx7CvSN4dWUnCfJw4Vkgto1mvg0A5PBI/IWtkzuYtOi5THlPocFbfP1tkZfi3JyVEKqzr/JRChFFgQanDZQQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mhL/bqLP; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mhL/bqLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNH5zlwwUjPXXiwMHwiao6+UBC6Se5uO7ViHlpurPqhgMYfKyL8NmdYJtqCOynN9SBmkR5CX8tVX+6XSEk/w/k2rn/ocjCoQayctavGy82DlGjYzq/jr6B76acuJxOVWeezO1KE95hI+ErEhdUiGe8+zGpRozlNGFrc5FbENYS/Hv9p3oiapHnAcHAdmgWSJzv/kPviZgbHV1F/y4RWa+jvg5wxCcCamowgKQVVRAe2FtSxnGLXbj3nx4X8jaRRxZbzUqBelgqUTcXjsT5JsMqTSTeITZEgGFM0H2xBVnx3P6bnlJQuHfLwRxiOVnECSQIGb92UiunO4fmnXM1a3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=fTIBijthe6CNHMTddwgIbskHBQ0+lAUmCT9HlNuc/criiYyk4CvQvBcFCJiFjyxVLsmRrG74adh1i4lGOyzftHMxTs+rXAbl9oHDKnHWliUoh/dr41Dt/wLqoQl3zDFkhtUlEljle1DFULKB3+dWOpfUPK3lcacnSlA2JjGy4dQgtbVKd4s6nKg6PNzqAVpa2DjUOSudm1Gzx5Kdh8ItKGFRqgZeX8JCnWd5kymsk9lfCj/dsrySk5XAuFw9qo+1Oxqsj4XtQFqWzEyhXw4AIr8OypE9kTIT7VH+NBI8VL1sgezap/bUphWUkZVLeJCepQ7P/odecMA1+SlVzcrAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=mhL/bqLPZ+rF10pgfwH2bEB3d+XeXrGEvtfZRl4gSqTkVqOp0BYVZgui38GU2HOjKZtkLWEsUtVdFopX7e+csVvvI+HFhordW3o+guh3DEyhQOFjHtNdpucmgwFUvm9Sx6v07FUaJLmyFqSOFQruEOfo9ZZt+q4FvvW6Q7ZSSTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:10:27 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:10:25 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 2/3] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
Date: Mon,  8 Jul 2024 15:10:17 +0300
Message-ID: <20240708121018.246476-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10614:EE_
X-MS-Office365-Filtering-Correlation-Id: a859684a-6210-4c5b-0157-08dc9f46f33e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N05qU0J2M0phNFJnQzlpT2M4RmJNeVVlaEdHbzRaZHNpVVVFYVBPQXlBWVlU?=
 =?utf-8?B?OWl5VTJPOHdONWpJNVhaQzdvZ29aTWVXdThJenNnODFwYTZPUVZKZVVNL0JO?=
 =?utf-8?B?M0xaN3JXSzc2UVBsSTRpeXI5WWZjL3YvUExuR0lNaXEvdmtZZjlaOFc5Tk5Q?=
 =?utf-8?B?bkd3ci8xUnRBRWdQT3ZxUzloV2JvRm15ZStHNWFVdm0wcjBYNGRrZGdOVWdL?=
 =?utf-8?B?cVJlTnFEM1BMN053akgvR1FUbFpTdEEzUmR2T1BFbHI1UldLVmJtb3RDcnUx?=
 =?utf-8?B?bU5SMVY5djRmYkRJVmdxS2FKVWpGS25maVVXbFJ2clVHTHZINXAvU3hsMlFW?=
 =?utf-8?B?aGxZUmhXUWYwc0Y3NUlmM1hvV012OHJKZUpzcnZSUG44K1l6M1BjdzA1RFN2?=
 =?utf-8?B?TFZpVDNKMks2NGttQkNsMkVzMk9uQVdYZ0FtbHVEMVlnUmo5cGpFa1dFTDdG?=
 =?utf-8?B?UzRaYUo5S0tZYVZpTzErUUR1T0ZBNnNITHgwVklUUG9DbGFGVTE0TjlHTUpY?=
 =?utf-8?B?bTZHRnltcTh3U2EyUngvV29VYVIvWGYzcHRuV2RHSTFEUzl0U2hPQyt6UVJY?=
 =?utf-8?B?bHpqb1l4Ykg2R0pCVi96WkRTMDBNU2k3MU5QK09wd3VkZUNIV28zby92V0NC?=
 =?utf-8?B?VmNyaXdiZ0hYdVo3OXdvOFNHVmJqYnI1VXZiTTNmdjJ1NHJxRFZ6S05WMUl5?=
 =?utf-8?B?OFk4WktydHZ3SENuRUFSQlgyZlFFemlpMTJmZHV6aGluUGg5a1g4SlppWXBN?=
 =?utf-8?B?WlJ3bFV6WVdFTTJheG1meEF2YndqYnB1NDJwdVFTeHJ4KzFxUE55Y212cEJt?=
 =?utf-8?B?S09iOWswcTh1QnEvWmE4L092VC91KzV2MTFJRHNIRjBPbm9vTTdhQjRhRGNN?=
 =?utf-8?B?YU0vdHBTVE5ZazZ4Z3VWNy9vMnowV0NYUnY2M2Q3VWM5bEZ3QU5nblpGbW1p?=
 =?utf-8?B?TjhZTk83ajM5SEhRYTFCWjBudk5rbkpwa2NveHN3bitSdW4zSzkwaWo5SEdT?=
 =?utf-8?B?b2pJb28zRjZhK1hNRkdjdjJrTVhDRzY0U2tSelV5Ylc4a2RHMzVXWFlwdEdS?=
 =?utf-8?B?NGVKdnJINGhPTVpHSGM2RFBHSDFyM20vdkx1L1ZObS8yWStnNVR3eWZ4TDk0?=
 =?utf-8?B?VFV1c3ZBQnNxaXpEZmZVbTJLVWR3d1hRcFRoa3BZTVYxQUhwWUNUNDVBZnkw?=
 =?utf-8?B?T0lUWlRWS2FXV0dRTWFVMDY0dFVpMW4rUml0ZitDZ25CWUFiMU9OakVZZ0x2?=
 =?utf-8?B?Sng5Zmc1Y3E5VFNEWUhTQ1M0cUhQTHQ2amNwdXlrYUlvWWUzWUNXVzhPMm5o?=
 =?utf-8?B?NFRDQmNBVHlMcmV1MndIcmtXZzdiSkpYOWJUWXRQT2dPbHd5dU8wTDdIQU5H?=
 =?utf-8?B?eVhWY01uVXNwRVJJYUliT09uN3hNUVNzS1lqVitzc3VsV0FqN1pITVptdzFk?=
 =?utf-8?B?Q2hoY2c2anVUNml2QlRUb0NDNEdjTkEvR3h0cGZmLzJrRzdYWFd5dVBoeWk1?=
 =?utf-8?B?SjRQczJGaERtYWNQWlZoK0lUU1llZStHS0N4OVVHZXkzdlVDTHNSWUdMcUZ3?=
 =?utf-8?B?ZXNNNHZubnRtUDZqL3dveExMTkRXT1dPbFMxTWE2NzNYMm9uSXVBRGY1MGF6?=
 =?utf-8?B?cDJLYTJLK0R3ZVZCU3JnRGt3UHNXNFNTcFJ5dWhKYWFQVnM0OC9ZamhuUk44?=
 =?utf-8?B?Z3c0UjhtbHg5ZjJ2clVPdmpjaklldTFTbmsybEVOSFBwSjVCMGpWVnBHVnN5?=
 =?utf-8?B?bnlvZUpXR2dEcEkxM3luV2V2Y3c1SnQ0NWd2NVdHaWRhZjFtaXVPd216WDhM?=
 =?utf-8?B?WC9ZNERDeFkxVkRBRjZkZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1BWSTl2RTN5U05XSDAvUVllMzJZd1d1d0p0ZFRNanFyY3prUG41djRDWVhV?=
 =?utf-8?B?MHdDek03bWpvdlRJUzFyeXRJZWpEY0lybUdtaEh2VDMwMFptNkJSYlJ2c1hF?=
 =?utf-8?B?eWhVUG8zUWhTMHFMbWdpZjFiUjRvNHdrcm1MSjdSY3JpZzQzNEVjRmtQNFZo?=
 =?utf-8?B?eWcvZm0xWXFud1RKejhPYkIyd3JvalJjb05CcVFyZWNXLzluYU5ha2JuQnN4?=
 =?utf-8?B?eDdlSkZjanczNC9mVnRsZlJ5ajVoVXora013ei94OVhCZUFTQWVUZkZtZFBM?=
 =?utf-8?B?bG45dzI2ZW41R1daeE5CZUVoT1l4NVZzODFHOWh0Y1VLa3NhNDBRN0Z3Z2J1?=
 =?utf-8?B?d1VZSW92aldsd0tROWl4UjMvSG5xcmlTYzhBS2h2b1RaaXZjQW5ackVsV1J6?=
 =?utf-8?B?SGlGSG1WMGNnVWJiT1pjcWtXbDJ0a2FIQkZUWDduSkhMWFNwMElhdGhXMCty?=
 =?utf-8?B?SU1TN3ZzOFBWNS91d21Bc1pXZ0tCRXlVait3WXY1bFRyaS9ldzI3cmNFa1RW?=
 =?utf-8?B?TWRTNk5CZXNUMExZQWtYcGVsdTlKKzdxQlJaZ1hTb0xjZTFYZ2hWUThSUDli?=
 =?utf-8?B?SnUrZDRrNGNGLzlZTWJsWU9IR3hNTVQ2a05OTzh0RHpvTUp6MGpOeW90R29G?=
 =?utf-8?B?Q1lPcHlIWWNRWXVPQjQ5MERhNjVrWmFXQUFQTlBVeEVJUmVhcDAxbVZIS3Uz?=
 =?utf-8?B?TmJGMk95cU9RVXRBdVBEYUdjUnNoMDBSVkphTnFidDVmamYxa3ZXNk5CMitk?=
 =?utf-8?B?SjhQWHZXYmpiZThUTHhsa1JvYUtyNGxIVzBZTVFScUVwK0c1VFQ1RkVyQVJ2?=
 =?utf-8?B?SUlBWjRndkk4dTIzVi82dTV6UTQ2dktwUUU0aGQ5MDZsY093YllTbUIzbVRQ?=
 =?utf-8?B?MFRrWktVYjZob2FFa3BvL0U2MEpzZitkTi9uekM4VTdpQnkrRi8zdXhwWWxz?=
 =?utf-8?B?dkZXakNhK1ZkTytydlgrQSsxTjUyOG04bDlGYTU4cTU1SUR2RDVTYzNpSnE2?=
 =?utf-8?B?R21tUi84bjlBaDZIUGR1ZGdBdVlDdG9yb2RreGVyMWsxWWdCeDZ5UmY0cmRl?=
 =?utf-8?B?d1U0TXFKeGRoYmlJNEtKdEVJVXZ0YjRiRitsOUd0TWV1Y2tPQ2hMbXNaYlBv?=
 =?utf-8?B?am9wektuYVpHWGVDVzhCMC9TeTJ5NXRSR2hTSzQ3ZkU3U0RoN3BCZ21hTXhG?=
 =?utf-8?B?MERKdFJCRVkyRUtSQTRZcm56QmdoTk1YVEN4bUdtT1Y0Z1huRUM4bm45emJN?=
 =?utf-8?B?ZXkvZVVHYytrMDhKYWlzTkgrOFdvNDBHbWVlbEdQT05qQ2lqSllPallTZ1J6?=
 =?utf-8?B?WkpMY1ZwQ2ZTTTVSbjZNSk1NaE1TZHR6VU1ObmllN1d6YThyTzdpRWZTOXBM?=
 =?utf-8?B?djlzT3BoQnZUaXdYVk5ueEcvOHJQV05pZVBHU3JrZ0xONjlBc2dEWlVQK01w?=
 =?utf-8?B?ZFltQkJYU2F5a1J2dHNhL0dObGtLc2dtTktzTEhFcGs4V3dzeXE2aDBXNklE?=
 =?utf-8?B?VEdJbmVWWkplQUlQaE92UDBHUUFCNEZ4VDFlbUpleWFzM0hVczVhSkNadmpH?=
 =?utf-8?B?c2R4TUVxU2dndWF2eFprRFkzZ29qSTFCdGVmQ1dHRG02aUI1bFNLV1Vaa3k1?=
 =?utf-8?B?aytqZDdnRTJyM2FzSjlRamJqUUxqUUFzNkhsVnB1VlBRa3NSL0FoMUNLUkxW?=
 =?utf-8?B?NUhtODRlRnNBNldVaytRbThOZW1oaDdRNW5UR09SZVk0N1dqc1BqZHVMRE9z?=
 =?utf-8?B?UmRhcUtRelQyT3BDdS9xdy9IcGxoekMrTUoyYVFYQlBpRkptMzdpblVQWWt1?=
 =?utf-8?B?QmtjcU03WU96MGdYbW1vVENkODJTR1ZjeXVwcnJ1ckhQSFk2eTkxbHVGYVMv?=
 =?utf-8?B?OEM5UlVGLzNBNHNNMlVaaFpxQUZRVUNMZEZrV2wxcEpacDZ2dkdNenU2b1lX?=
 =?utf-8?B?Um9ZZmNxUkliaXJBVFNkcjJHVmJYODN2c0tiK2tkcTBoWTBBVzBLaytqV0hL?=
 =?utf-8?B?YUU4UExScWJtODROZlhXcWNieER0MjZ4U3pvK1lxNmV3NU1kN2dZUytKUW9n?=
 =?utf-8?B?S20zVnY3c3F5WlkwT29pQkxpL2RCbzBtKytNeEJFVm8wek5OMjl2eGtlajBF?=
 =?utf-8?B?aG0zUExuaTNYZjhvR1AyY3FJTUxFeHdCSS9DSFp6LzAzOXdLRXVGQWJyOS82?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a859684a-6210-4c5b-0157-08dc9f46f33e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:10:25.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhANsu6diJ6xLneHGe/h3oqadYBDlBRJL80z6Z/ANp5teuTAzOJSNPpagTCa7E5tm7JRpUHuOB6h1hHP3FGXv64hz5Hpbv7jerVzdKuAZ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614

The I.MX SDHCI driver assumes that the frequency of the 'per' clock
can be obtained even on disabled clocks, which is not always the case.

According to 'clk_get_rate' documentation, it is only valid
once the clock source has been enabled.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 21d984a77be8..8f0bc6dca2b0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	}
 
 	pltfm_host->clk = imx_data->clk_per;
-	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	err = clk_prepare_enable(imx_data->clk_per);
 	if (err)
 		goto free_sdhci;
@@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ipg_clk;
 
+	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
+	if (!pltfm_host->clock) {
+		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
+		err = -EINVAL;
+		goto disable_ahb_clk;
+	}
+
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl))
 		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
-- 
2.45.2

