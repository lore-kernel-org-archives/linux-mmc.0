Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7A14B96D;
	Fri,  5 Jul 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187246; cv=fail; b=PkGz3xu63UY5mEi5MPcH16ZuOZBWHkuf/KytdbSqcwsoiKuhcU131WoL7NbIDSUf9Py9NDZ/m4BttpoCnPKed3TWUIiV2aJugzltYxgJvF+5e5HhRnZ+QS+lm2mXQcqqzRLefovQZczM4LKplqamPT3bj7/qP5f2sepFnCeUP+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187246; c=relaxed/simple;
	bh=RVkWMjcCMqugx7ZXO4KK1b3IZ6Gy54ufQ1NT3e5grp8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fI2oblFQy25IcEdIlNmoimLVA+u1iU+T+N56NMqmxWNcg6bU/UStaALIJY37Tj3ZNMifsM70KCnU60XlRxQIApmFum/hVhNuMgfC7soWFTvTHYXqwYwSc4839Tu/5Pa+csqSPuw4V0Sa8pdii4OaKkosheIL+bhqQb+y/kM6AuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aLHBryBh; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aLHBryBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+QhUhNqjeXpuqVS2Ah7XozWQLQYxJzRe+wuFM5gGilH4E2bzyWfUKSocxEqODOssIBg7uMZALTPIvFtmaoHfYg0SpGCY5vgXuiOmz8yaryKJcMASSI33k3mtOct4QWM9PFEbyKUs4jtsaIn6BoIiJdK96JzlQwU9p+9yT7QTCK5LoGQ6KNt+Pg105d8eY6frOUjI/JDIjuSolCcV3pEoE8Kj83JZ6y+ltGGUlEGMKdQGrSWwh7jkfxlZA1WHHyVtICxPwdv+uPodDSNVdbVku5BU8PTSetlqBPHeX0NkbKAM7xjv3lpHWcFbhR6IzbmSwwfEm1NE8idDR8IBqZYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aIGSENashp1opWHQNZ/LlzM9Td+liywpUh9IgXwvsw=;
 b=d5dtnaMBMXx5NwLEtdC8LoVaZoeyzbkwbf2YrN7TxnpciwrOCBmGiXhs22sLGfv69SW7WVyaNoQ9ejx6HsfMF/BollqMj3J8wqbTLtq792gCYPEEMQf3l6u8LIce0c80wa70OtPYdsdJDG4GIAmSUzfyVJK1pl+dG5mC9u8cuEHCz6E8/vaUuclnW7pBNtnh3FcmomBSwiXJJOrRS1YmGzcyyz3dtTQJJjRdPtRreMZAhCIpSNpdmTLpj2gDbBxcmsxDny9CuxEP19BI/FVjdgJ1HBEfr6kr8NguxRzgpXo0ccNxF0EgAmaJP7QfX3Sq2N8f+Qq4ZIgq1ZT2LpTk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aIGSENashp1opWHQNZ/LlzM9Td+liywpUh9IgXwvsw=;
 b=aLHBryBhc4XfqxJrNt3cOmSas7jIQCeaa+08kEQ0tTEjO6PpCHSAVDDjS2sr4HYx2TZMhMjQo/XFXDF0QLMqdOiaE34nMkyKQ8fkxMjFm31To77Xye5dWn3G/w2Q3ko+EYsCmj1GxyRH41ZhlzMdK353rggZyWaVcAc9LoA9ra0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:47:17 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:47:17 +0000
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
Subject: [PATCH 0/4] address several S32G2/S32G3 SoC based boards particularities
Date: Fri,  5 Jul 2024 16:46:43 +0300
Message-ID: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5ab0f3-d39c-4bef-a934-08dc9cf8fbf8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTM4VUMrcUpPWkZmcFBFVjJvS0dDeXRRUHdySlhlZWZQeTBSWVlUb0Nkdnpl?=
 =?utf-8?B?K3dUOEdlSVRwUU5aTGZiTm0weWhMeGJVbW56anh2ejNIOEhzcFlYVmllZHdX?=
 =?utf-8?B?ZWZwbVhzR3h5OHBnWmphWThkYllGK1Axd2swYmwvSTRwOG1EeUlQVjVybS9D?=
 =?utf-8?B?SFpCQktGd0Z5QUFYWVU1a0ZPQThDb3JaK3hUS0NENU9rV3d6SnpESnJGVW1H?=
 =?utf-8?B?bWI4K1RMWFhPcTVBVW4rVzJTOW1LRU9taDl5d2N4cENmSTNSWGx5WjRpYUtk?=
 =?utf-8?B?THJYUVlrN0xma09pcFNEQ09JeUFmbEg1T1Q5RWxXaXJxL3I1Y2VDUWZDRURG?=
 =?utf-8?B?VU9nMXF5bTFWR3IwUFhuZGRodVdWK0lieXVPYVN1NlpNUlRzNFltMkZxZXc3?=
 =?utf-8?B?SDRNUktUZktNZjloNmlKczAyQ294UTFsQzMxMnk1dCtMdm1VOGU5cld6RHQr?=
 =?utf-8?B?bGlsZEJGVkF4TEhrM1dmd0prQVRDWmM0N2g0UTBzYnljbW5DdERjTGpCUHpJ?=
 =?utf-8?B?QlpzTktXQTR4WEpzdjZtUTRQK3owSEwvNWpTQXZ2WjBxTVlVaTVpMTloY21G?=
 =?utf-8?B?TXNTcVIxQi9GU1d5QWVYVUxLRmlhRzEvSXQ0RktDVGhjdy9zcEEzN3l1bmt5?=
 =?utf-8?B?cWg0Z3dONkI1S3JoUkhUVEp0Q1IybzJBNUV1RzdkQVNSTkpXVi9GYk1ZNzRv?=
 =?utf-8?B?ZlVJZGRjd2JranQ4TlZId0ZwdTU5K3htSjZXQkhQdk5SYzJsZTJ3dzRpZHJT?=
 =?utf-8?B?cW9DbnFlSlU1MURJeGFOTk5uVC9lUzFXdjcvdlMrbG9lb29LTGxzWHJBTmxq?=
 =?utf-8?B?QU5BaVhsK2RJK2xQLzZGL0JwTTFqZGxmVWZLYnIxRWltOFp2OHdJaER5aTlB?=
 =?utf-8?B?RXNhM3B0ZmYxNEJBbzNMck4ycTQzN282R1loMUw4SWpiajFMNno0ZXZScGxl?=
 =?utf-8?B?cTlLQVZvUjZNLzhFZzdOV0RzeUVyNFcyZ0kybDlINkZIMHBRdGUrSHpUZ3Ns?=
 =?utf-8?B?Z3RUODZkUmlvVVMwaG1XMVNQbytxLzZwSFNjMlN2VDFkNEhhQnN0MHkxKzkw?=
 =?utf-8?B?ZHI0UFRlSWxhUEpNM3EzUkpNc1RVSnlJeUhObUE4YXVwa1gzQjJDNUhJYlQ3?=
 =?utf-8?B?SXJXWjA2VGI1WHJOSCs1emJJU28wZEQ0UDJDdERSSlVGdnNnbXA1VHpyZEw2?=
 =?utf-8?B?ekg2MTRDWEhENEh5M1BGZ05nb2JQSkpidHRpRXJxTUU4dDlxUUVNaTVUSWJP?=
 =?utf-8?B?OXpQSFFZUitYdTZYRk5sMWRVSURxeTFuMmtGSVBZa0NpMXZ3UkFuZFJpRVNj?=
 =?utf-8?B?MFFLbkJQbkI3RGVvS1pSRGx2ZHFDYTcrcTExMnpBU3ptdk4rYW8rM1M3Nkd4?=
 =?utf-8?B?aFZjQzFNS2ttQlBaRDl2UGh1cnQ4M0JUb3h0enJWUDlpNWM2TGFGQ29Kc0N2?=
 =?utf-8?B?YU5TUG15aHd1S3k1QU5nWk1vR1U2WjRMNFRRNDZyd1c2R2RFaHBOTjRINy9P?=
 =?utf-8?B?OFVUcmhpNHBnTGNkbG9Pd1htZjR3eVpIN1FHOE5jNG5YTzFlNEhqQ1R2YkpF?=
 =?utf-8?B?WjErK3Uxc0dwOFFYVXVuN25VQktITHk1TjRUckxYWnMvbitmUjRjZFVJY1hQ?=
 =?utf-8?B?a2FpSEJ6YTN5SWJtdHgvMkpJR0hUTnFNMnF2SHVySjBmWFN3RFQyOTJTS1cw?=
 =?utf-8?B?anh2ZFY3NVAzVmV6UitSbkFzWEZxUnVVRVNQY3BjM1lZVVAvTmhIQ21HNjA1?=
 =?utf-8?B?S0tjM3pnc0V6S2RPWE43QnZnR2NUeTVsR1oxSEo3bjc2MzJLSE5RRytLT211?=
 =?utf-8?B?TElYa0ZFcVdTbFpLbEt4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjNISlB0S3dmZkcxZ1NFR3U3clNqTkl6K2lQRzhRV2VHandOT1NvQWs0K0d3?=
 =?utf-8?B?Z3ROcXpOY1BCbGJhdTFOVzdZdTJZdjRTV2VXR1hlMlE1NW10L0poKzZ6MDBM?=
 =?utf-8?B?NFNISlQyNFppejFIeVZPVldJejJQUFNqRFdxV0xRWnJjaEwvRXE3YmNmKzVP?=
 =?utf-8?B?aGhmc3VKdXA4WXovQTM3bUN1a1pYelZnbFpiVW9kcTBXUFlLT0ticjlDU3Bt?=
 =?utf-8?B?Z1BKeTczR2RjWUlHdkhKRkdQalh0WHVXVHBMMWcreDQrT0xUUUtpdk94ZzNG?=
 =?utf-8?B?eGNPb1lkVTlpNE10enNGYitheW9LLzhVaGFnNFhXWTBjVXFOL3podnhsQjZQ?=
 =?utf-8?B?MTFOWHM4N0t5Mk81UlMrNmd3dmlObGtvYk9NNnBOOG02aWh4MVVHMk1ESE90?=
 =?utf-8?B?T0ZSMGxNRFdVVU1lTmc2RE5xcWtBNGl1NndObm44R3FuQTN5REU4YzI1Uyty?=
 =?utf-8?B?TWRoUVBIRTFWRmhLVXB2dyt4LzBveU81NFlOdGx0WU5XeVFBV3VmVmZQZUJC?=
 =?utf-8?B?M0cyZE5mS0FiTDM3NzlTOGRqc0pySGtQWWR5OEdSd0lQamxGcFM5dlU4Sm5T?=
 =?utf-8?B?TGJ2ZzBHR0xpL3k3TWhBN3pWZVc3ci9hQUwrSFZCLzR2aWdTZjNkdFUzdG5a?=
 =?utf-8?B?VGFldTUzdmpQL1ByN2hIcEFCc0k2bDNZdTRwNzd1RGs1ZURFVzFuVlpROFZM?=
 =?utf-8?B?cCtQbVltbE1xMVdNRjhMZnY2cHNFZUt3RnFtQU4vVkFoUXJjRGZoSFlIa3pJ?=
 =?utf-8?B?dW9DeWMzcmlqdFZKL0lvOUpZN3hpQlYvMXN3S21yRmhHc0dVbE03L3FOVC8x?=
 =?utf-8?B?UG9ZVWlocERyMC9EM1VROTVwRFRQOXFPRVZnNFdDR2duM0ZqZFlocjdZd296?=
 =?utf-8?B?djBsVXpjS1EvQUc1a3NOYktZTzZuYjZXTk9oWGJmSlE3eTRNcUU3TzBKalor?=
 =?utf-8?B?RnQrTFp5YXNCQ0VBZlZMeThBazhaa25CaXVsMGNPMFM4Uy80Q3BlamhNWGtW?=
 =?utf-8?B?N1F5MnNVZzRrc1AzSnROekFGQlBsdlNiWWp0MSt4NzB3bmRKUzU2S1hFYnA4?=
 =?utf-8?B?Y0ZVeHBpV0p0ell2U1ZUQ3FJcWNHdmFGQmpINUpBTm8rMzRrUFpLRWFweHVW?=
 =?utf-8?B?dmZ0NFNQYTRmaU42KzREeVpkckVBVVJoM094WmpZd3hjTmFid2JCTnA0RlpU?=
 =?utf-8?B?M0FYWW5kZG5hUVZzVm9jOHZGdGlYb0k0RnA4ZndHSGNpWlBKbTRJQUxNYlJW?=
 =?utf-8?B?NUNFazl0a3RaWXBneU0vUFcwNEhJSmFtUjZrN3JQb1RVWjhrMTBpNzF3ZkZl?=
 =?utf-8?B?am1wbmxPZVB0bXV0VFpuYTJ1SnFhSVl2bXRyVzZ5cGRDSFBlZGNHWXZBR1dw?=
 =?utf-8?B?U2JDSUQ4V3N2ZGgrNFJrZFlvTWNIdjF0WmUxRnV2ZU1DZEFXU3FBcGRON29X?=
 =?utf-8?B?YmRBZU1pQ01Pd1BTVFdsZ3cxbDVkL2dtSlhOd2pTMG5JVlRnaDZZR1U0VVFD?=
 =?utf-8?B?TDlVVlY0YmprbUR1VjJFVXRXdytxc3ppM3kxMUVmd2ZGV0Z6WTNmMlJRd1JX?=
 =?utf-8?B?MUtkYzhtVHQ5cTdIREdFUFFyYnZYQVFKNEMrRngrTG9QaWR5b01VbUl3cTBh?=
 =?utf-8?B?TnR0b1loZ2dGNjhGV2dPQ3I3MVFLWjBQbENHZUV0U2ZGRjB2M1BwUVorTVU1?=
 =?utf-8?B?UlZ4cjJIUDhjL3FaR2d5ampwS3Ric0lrMjgrNVlYMlhPUnQwL284SldhdFda?=
 =?utf-8?B?TnJxbGRqRTlQdHJ3YlRHcTIrdVBNZ25LT1BOZEJ3ZHo3M3I2NDVpVXpKTm5B?=
 =?utf-8?B?aGMrTnBmK2loYWhXd2dhZmZOUkgrTFNOUnYvTkRMcEtaWkVHVEZoMkNYR3Iy?=
 =?utf-8?B?eXpURCtVNEg1aVV4UjJjZzk2TUxKSjl4WklDKzFHTm1UVHBYa2ZMWUxNd1Za?=
 =?utf-8?B?cWZrK3JzMDcwZmUvWE9HdFVKdUVIcmxvOS9tZnhDc1JndFlJNEVQR1p6Rml1?=
 =?utf-8?B?SDg4Wi9ETWROT091Mng2UTBGanI2aHRLYm9YSUxTZmtqczFJdktEc1o4aHlU?=
 =?utf-8?B?Zk9uc2JZQjZJNlNxQy9CWjFjbWlpUGZhUEloK1A0Qm1YRUx3WmEyYjJ5YkNJ?=
 =?utf-8?B?TTRYQjVIb1ZkUlRqeDF3cms4Mis0ZnNUcFVwQUpFREpTQmZNZXpsSUtVVlZ0?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5ab0f3-d39c-4bef-a934-08dc9cf8fbf8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:47:17.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YauBBskMl8ydTqJjgxR4gJRA08rzzUhwZnxdo5xjoSraZRhRgDqsDIvt6cPpOGAHLAe5kLCN6aQ7g4gngrkDCQBSfmUP8YFyZt5xtOc6b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

This patchset addresses several S32G2/S32G3 SoC based boards
uSDHC controller particularities such as:
- GPIO card detect wake mechanism is not available
- Changing the pinctrl state in suspend routine is not supported

It also fixes a clocking usage issue on 'clk_get_rate',
in case of 'per' clock.

Ciprian Costea (4):
  mmc: sdhci-esdhc-imx: disable card detect wake for S32G based
    platforms
  mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
  mmc: sdhci-esdhc-imx: add option to not change pinctrl state in
    suspend
  MAINTAINERS: add 's32@nxp.com' as relevant mailing list for
    'sdhci-esdhc-imx' driver

 MAINTAINERS                        |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.45.2

