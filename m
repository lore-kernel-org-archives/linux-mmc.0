Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52D156657;
	Fri,  5 Jul 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187254; cv=fail; b=uw3rDnFGe4q3nldN1ijW0Lb3pAhC2EIMtH6POFSxufpo6GLWwMb/rwk8RRdwurtjt4OejU3A5qB4aTclGize3S1TE1+2CajVzojyeo/hnzDnJ8iUZhYl+UCNfsSTnck1y1cr93rRB4EsXfSL3NkJnlrhdUpTzL8t/2U0/7iD2+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187254; c=relaxed/simple;
	bh=UvJ//py6u04igD8qG8neO2Kzkeg3fYEFwQSQ2MmZYw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GW5YaUWvpn10NHIBUL79CsRtLvPjStDdYGegONbE6cA+MyA2WybeUak9aK7/I0BZfUhToKyeOIjvpTbJdNa27+FJRG7HVKeBysbUMs9sfphF6PN6tpWUOX5ORhj6496/qPehtteiGOUEEGkKnL4WShQXTn15Pfx7EBx4b43JiiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aeoFjbZJ; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aeoFjbZJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxcR7SCtohKGyXmz8u7rKgXi1lOpH8XlfIOZftICSX//ELC2BFjOAN3vW5n0jdgRsO0M2Sewx7+y8aozFH3ouFTPryPYbjHTxM8UOb0xl22lBKprjhQi2G0xDh/uXldV1pdW2PJtFtCbBi65cnZVhweq6AcoUpirjqbfFZ1MOgysk8ah5+C8LwW16mhyppbwHHdywK0kDMYA1pUt5gTAXU+e0ZlKjMfK7Vvlv+7hMjZ5Msj6AbtoLXsHJA8Dm0yO71uNvyESsUQ4yIRCKf53cnKo5tXjlZo3F/Y2ETEaF476qFacPY+VWfUa0r/yX7ABtsr5tr/TMmCyhntDwwPC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=nS+zO5weg+aZ7FBNxik05uT9Qi+IoJZAuLfZuovaFbkeiFF8zX9QNA+hM1+DnK3XznoVb0tz2t2mNCKpEhFWitzhUTLX6p7e5/xqeYm2Fw5oXj9H7UK0nt7pEuo/bHfuY2jDrNFDfEFZLyCIeJ+w/eGfRf0sSg+oJ6Uaoa1z8NQRnPeC0PTVQD9mTGHa/eRVaztB3+oQ+maGdUvf2vrXRFPDdpJ3bD7zaauvf2MLZu0ygL974juZgiKvPr70YIPBFORanpUlSWfdrEvwOihfBFBoMhHr7EqiQTM9K21YXPS9uLRbaxsf0RPY3U9hjuoaUtWKNwM94+uaK0tStXG3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=aeoFjbZJ9KvE4TL0hkAFz27lT4Lav330bFn5gm+hi+iRkTuif3bX8rb3vqboUQqWMBLnCKVyScwaWXOevThWqI0jGc2CP+eEV1VwipCztIS5Mo67Kz94sjVPydZubiOSWBmxu3Jvo6NCBoUh36W+TsqcWeTFZmE3YUNkNxiMzZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:47:25 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 13:47:25 +0000
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
Subject: [PATCH 4/4] MAINTAINERS: add 's32@nxp.com' as relevant mailing list for 'sdhci-esdhc-imx' driver
Date: Fri,  5 Jul 2024 16:46:47 +0300
Message-ID: <20240705134647.3524969-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
References: <20240705134647.3524969-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 86077ca6-8e05-4c83-2761-08dc9cf900e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1ZIZG1BVklOd2pLL1FyaEZLRkx1TlJwbEJpa3ZuRFRJbjk4eDFtTVBGY0lG?=
 =?utf-8?B?dGdXVnc5c2tJUWJBR203QkVxby9qQW5zbi94ZEt4a3lLWi9FUWZCclJEUmow?=
 =?utf-8?B?cmk3L20xalZtNWJvTDVlbk1DYXpsdDY2cGp6b01abmppTGVsNU5oaHFPWDU5?=
 =?utf-8?B?WHY5NjRucXAwd0JCRGE0UGt5UUhEWHNvNjYraDIxYUw0KzRXZ1JwZXRGMmc1?=
 =?utf-8?B?bC9LbVovTXgzWllLVTNlTVBzcXcrTHZGNGYwSUFVczdkblZXbDNNTzcvNWN4?=
 =?utf-8?B?VHUyU2ozRTg3SVIxbjNSYnQySitPb1hjQTRZUkZkdUNmRVAyZHF5MTFNYm01?=
 =?utf-8?B?T2FJZmRHRjRyMXM1cVRLdXJtUEVkdStTbnNuajEzaHl3L3JYRDRzUTRsREgz?=
 =?utf-8?B?Q1dWZG5xRldQT1BjYWkrckpoeHFwVFpFQWhMSHBZMFVoZVRZUG9jdldKejUr?=
 =?utf-8?B?dzJQbERZa0RKRnh4TmFzem9GMGhHVFpuVlJoR2tIdHp1SGgxbWh1Vk1ycEE3?=
 =?utf-8?B?a1F3ME93aXdJWTdkSitIM0JlSjVwZ1ZMc05yU2d6NFFlUFFkVXYvT1I2TVZZ?=
 =?utf-8?B?S3BISWptbkt1VEVoTmVtd2IvYW9JU1BUZzRtU0lWTG5NVjdWUXVSVHVaWHZ3?=
 =?utf-8?B?YW42TVErb2dVTThQdzluOU5TdUl4MmxUL1pXSlpGUVRvRHdyUDQ4dmd6bDZO?=
 =?utf-8?B?NWJYd2MzVzMzSGdjRkljUW45NE5YUk1hVHhFdHFhbUJaVzRvUTUwdHc2MGta?=
 =?utf-8?B?YUp2N0UvaU52Uk5HbkFyTjlXTUt5WXFQWXo0dWRkamdaSTNTcTlvNFBrTDQz?=
 =?utf-8?B?WFFUaU03QmRJRXBHMnhSMEMvWmFSTFpmNFZtcGN3b3ByRkVydDNkNWd6N0Nx?=
 =?utf-8?B?c25jeUhoMERTYm0rWXhHci9EMmF0STdRWENSRGxzK01wODRaOGhVcHFrc0hO?=
 =?utf-8?B?MFNlRFBvRjZkcDQ2dlhyUVJXRmNWOGVKN0FiQmo3VWIyR1E1cnJSNmlYWjdS?=
 =?utf-8?B?NURtbWpMVTYyV1ZhaWdURUwxRlI0QmNrUjFOY2JGcEtRTDhZeEFBUzgxeUtv?=
 =?utf-8?B?KytlNlZnS01GUTdkSENlMkpIeStyeEZLclRYaHB1dXk0emtUMmVpUDkrS25B?=
 =?utf-8?B?eVM1aHhDakdBMEVGK3lwVlFyQTE3OThsZ1MvS0dHNEpmSnhJYk5ROFlXZnlS?=
 =?utf-8?B?SGVaRzhVZEZ2N0hzY1E5S2p4TFVyMjlsb05BVnd2QkpRNCs0Y256cHladDNk?=
 =?utf-8?B?TGY3VnlRRW8veXVkeGZ6TDdkcVM0ZnZSRkFkM1RDT0cwRi9YL3RIcEY2NGVy?=
 =?utf-8?B?WllzNVBCK1BZOURFVWJuUDJZUVF4eTFrNWsvRzNXeERSZWg4dHdiUUhRVjg5?=
 =?utf-8?B?eW9FTnFNcWlNQ3dIT0g2MEpMWnUwMTRrczB1dkFLbm16NWg4SUFWSGJucnBT?=
 =?utf-8?B?SXNJS25Vb3MvNDMrblZTK0N1Nyt1WVNLWm5KV1NKUWVFczJHSTJkT3k2THZL?=
 =?utf-8?B?UndFN0hiMk4rZlhKRTRUSk80Z3VTZ1piVWVTblR5bVNIbzB1anNvSDE5bkRv?=
 =?utf-8?B?UmIwWkdUeHVYVTJuWnQ4QkUzNmY0RHFqNGh6MjRLd3crdFlJakRFYWJBVzRk?=
 =?utf-8?B?blR1aGRBR1RRN0tNQWJIdUY5dURNOGJjRHpqZ3ErSDJ1UDJIdituOGpBNnBT?=
 =?utf-8?B?RkZZRmpCMzNjOWY4MUZPVkd3NHV4UzNnV044cHI1YWNsZWFWVmV4eDQrWGsz?=
 =?utf-8?B?ald5SHAxeXZlY0gxbUFIeVJidHc3Q2lodVVvWW1CQmZ0VGYrNFkwbkcxRTVJ?=
 =?utf-8?B?dzg0MUo2ZWRmQWNIcks2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K21MRVpkcWh6NCtTbytGZmpHbHUvRkhsbnZHZzg5bVlXc3hTbjVUa2M3YnJU?=
 =?utf-8?B?THMvb2FiYXYyQjUvbVRScHNBaUdjMkE4TmtpNm93STIyWDdVdHZOL3IzbTIz?=
 =?utf-8?B?bVFWQW5tYjV5azZnYWRtbDA5ejhsVFdDUmZFdUUzVFhtbXYyTDg1L2xhVzFs?=
 =?utf-8?B?dHlQZkRlMm1MMDlLalpLczRveDlKWjV5QVVHMVhzbFkwQWR5QW1jdHlNZ3BP?=
 =?utf-8?B?d3lINlVqQkNmL1hSSEx6U082NEJlVEZJWGtnaUJ3d2taeXU4dUtQNCtYbjh4?=
 =?utf-8?B?K0R0M2pUSzVONXhLdHU2U2lERFI0cmpZalg2NTBUTGthSU56V3RUZzU2Wmtr?=
 =?utf-8?B?eHlIdHZPMzJ0eVBpYmFyQXdRTE1mb1VDOHVVMzFSUmU0MlR4aTltT2tjR2JN?=
 =?utf-8?B?a3p6MzM5Rm9pU0pUYjUyb2Q2L0tZbXZaSmxyU3BlbGJPMW9DYjJucEVlME1x?=
 =?utf-8?B?SG1FTmZyYWhlS0d2dkNBYitHdVNyNFVMaGxuTml5bmlGOHdVQkljd0h5U3NR?=
 =?utf-8?B?Y1o4aFlsVlhKUm9VSHIrWmpRRFVITDVUS2xFLytQcmNjVmU0OG5uMHZSeVVL?=
 =?utf-8?B?OW1lbnYzSnQ5Y3k1TnVRT0kva05KeG5ZNVFOWU1MT3k4aFBvWkEvTDJ6OFl1?=
 =?utf-8?B?UndWTzliNHJsQnVTYkRhcXUyU2txOFVGQ1RRMm1pRlFDcHpOZWdHV21rNWp2?=
 =?utf-8?B?V0xFU0JBbkgwL1dWME41K2NuVkY3NjMxRlZGdkorZURWVVdOSExYY3NDVXM3?=
 =?utf-8?B?dkU1bVo1M25xMnUrcVVUbHdhZkJKQzRPZVBqZXV1bjBHR2NSUUVZZGRBSHpj?=
 =?utf-8?B?UVlVcmZQUEthZnJ5VEUyZkl6MTBKejdieSs0QWcwWkpoQmR2UlFOalljNE9z?=
 =?utf-8?B?cklUdFFPeDN5TnNVRld2QkJDM1Y0eXN3b0dpYjRIVWhJMFhiOHJpYkJlcllZ?=
 =?utf-8?B?ZERDdHRnSDJ3Vkd4MXVEZFVEUmM5OGx1eDBHS3c0WDdVYTJ5UFVac2JKZEJr?=
 =?utf-8?B?OG5qamZhQnVOSkR2QzVjcXhzMDQ1Vm1VbTJnLzFEb3BjTVEyckUxSG1lZEpI?=
 =?utf-8?B?amxjRmhoRmNWckdJRzFpZ3BJc0M1cU5MY3BrT1U5R3M0a3J5MkQvSnl4ZWFx?=
 =?utf-8?B?aURzYlA3c09aTWE5MXZKbFVvS0N0ZTBLSTFXMVRWUktFRC9oNkxhY3ZpTVpw?=
 =?utf-8?B?bTlJZ2RSN293a1ovZW5tWlhEY0tnNUluMWtQQ0Y3S0x0ZlBBeS9SbEZCOXMv?=
 =?utf-8?B?MHA5YWRjWDMvK1NoNHlhMDMzczdLUnpVYTg1TjMyVERhZ2NhM0F0aTIveWJl?=
 =?utf-8?B?UDZhQzBSUUtteUpyTkx6TjhNcUxYeCthQUdBNUJCeUZyU2xrQnFsWmNjQlR5?=
 =?utf-8?B?L3dPMGYxUlp2RUM4MUF5WjdkMHlobzVCQzZ4TEpGZ0dYd0FXZW14THhIa3dn?=
 =?utf-8?B?TndwblplVFRYVUtiN3UyQWJ3SVU5amt5am9KYjUyVVJLTDJ1ZGxGaEJJQllK?=
 =?utf-8?B?MVYzczZFNytWUmNMZzkrVmhUT2c5bkNaVHR2ZHNyRmU5Rm05Ukt6TmdydzMz?=
 =?utf-8?B?R1dsdlBHVkNEQm1EWWtjSU5UYSt6dnIyTWlPZmpFOXd5bWI1d282NzhJNXlu?=
 =?utf-8?B?TGZNNHg3K0p3SGdNYkZtWlRBMGNJeFE5Wm1wWmdBSkJvakVkcE9NRHdwSC94?=
 =?utf-8?B?djhmYVBIRG5VVkllYlExMGdhbWJXcFBkdUFKb1lNaEQzTEhya0dSYzNFRTRX?=
 =?utf-8?B?ZHFqVG1sL1dHdDNTVHVSODE1bEJSVlhzUjFTQ1hLdzZ0aFNSbngyTDVqTEF2?=
 =?utf-8?B?SllsTytZL2lDRFlQK2NaMGlCaGl0ajVIRkVtOG1yMnV0MEdxMzVEWS9OeTRW?=
 =?utf-8?B?bVZXU2tOY2hJVU8rQTFMcmE1UHU5cC84ZXhobWN6R0lPdVNCYXlWSHBOajFC?=
 =?utf-8?B?M2FUZVdQSTRON0graGhjOWtNM2IzejB6NTFvdk9FWEdFWWJrZXpTWTJwWkk4?=
 =?utf-8?B?T01KRm5pTGtvMERSM0FUVkJmWDlwVm1NTldxMEMvZHJQSytLRmMwdWhsM2ZP?=
 =?utf-8?B?V0N3VEM3ZkQ3TElOQmJ6bjBFNTlIbG1GZTVvbm9UMUdUcHJibWdNc2k3Ky9F?=
 =?utf-8?B?K1NDRmRyS01ZQ1B3Y0h5UXNiN1ZKUWNkMURBc2cvdysxUVpoUUZPQWpLRGM5?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86077ca6-8e05-4c83-2761-08dc9cf900e9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:47:25.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqVWHpSc2GlN/+8iavnNdNeUvwEwSZurQX/90PZN6MPLKf3aqETt5TwHAtDxEucUB5GqlEWNuOIkh4lnOO1hHoBfKIMd7p5Hnvh63CKQyTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

Since NXP S32G2 and S32G3 SoCs share the SDHCI controller with
I.MX platforms it would be valuable to add 's32@nxp.com' as a
relevant mailing list in this area.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a39c237edb95..26b1ec2ba094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20098,6 +20098,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	imx@lists.linux.dev
 L:	linux-mmc@vger.kernel.org
+L:	s32@nxp.com
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
 
-- 
2.45.2

