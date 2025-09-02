Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3429A1
	for <linux-mmc@vger.kernel.org>; Tue,  2 Sep 2025 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791950; cv=fail; b=XT0Nhul1nZcx3eqjYDOXQr6dQzMqrOHW9gWSpJFKHJIv4L+cw6Nw/gLBXd296T9vkQOVD/g9dSOjfrLr+I7et9zdyIaKeAKW6kByd5GiZIwcI9exhmErsGEp3zDzHetuhUNcIMYfl5zYoO8QGJfCRQn5YzVyHaGS2+bLvjBYKJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791950; c=relaxed/simple;
	bh=henVqNaI3JfSxH6tj7XiC4EoKmkKEu1VE0p+hLM2omM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/PMkiGd7mCCnfP3dxuYnhTAKOia/YA0DO0T6WtOxjziRv135FDjpHwqCfxsTMn8Ln/icGURVOmsS1BpfsT/Malz+Kh9efxRPZHaa1SXtaBgaX5uLrw6qUZj77GavvL58EECDJFVpOptxoX75069yMVaYWGTquX3brprVEMIZxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fZClHGF/; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fZClHGF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaRTKVPI0iZK+rcjZVoFeWFcLMkzNvH6lLQZnRunZzW1haxZnD0gudsZwVShfTCaTzbK1Lm791nfhLzed/Is863B5yIqK19/BilqFZGE414PbZqXC/I0SkAyDRvJBzjOck8saoX34A4Ft6We+T3oWcSPZeWPfYfRc4F7IM20/wO5aR4CgxFTasvdttBktLzrRFZeHpxQUk9X773ajNQ5GoQF78zgekv/XuHGAV0xe6/ZIYQwOxh8yShR3DvEJSGbP7jKaqRaxFcJfmXZML04EgWqmo5vG9OtZ1F8lc54yzvZDQWG3Oza/zaakx00ZOxWqx0RGjEyb3iYEavS909bxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncxiL1rROZM+n74366ah3xxrNHBSfUIcwknMwOU+sjU=;
 b=ExH87l/BgduyIf4QtruZjMK2Sfp9oEx4wp1aOpIANVvZfxzW7lWBjWW2OfcavdA9nYFb7wt62uUchIvHW6i6ldstm7ijmX2ar9vTaJ9qhPolG5qaHzA0yyoc9AQLPA1I9cEuwqynDDLPUAoV7AI3rqXE18TeoXqgbsj31sIDgtF6JQuR0LpDSp6XaDNvB61lkB/HBY5A2qoqDaQ6fYqQtK8hB41JSH5hSpkLxsh5y8IoFRPBIe4JDkeF2AoQJT7k7GCYTXaIlVB6md1SSS+/kRbKzvfNwapSuZ/HQ1QnnGENubCcePl/SKR4K+SU5BXvF2Y9yvctluLvZgHX8KNilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncxiL1rROZM+n74366ah3xxrNHBSfUIcwknMwOU+sjU=;
 b=fZClHGF/Ga3rlQn4tDQEiQ97iKxj79woPtwrYcuQ1+B03THja20Y5CnV1LSyL1bq2k3co2iB5sGsBmzFPlf0IwA9Dbw+JwM58dXue0cH96yCqnM3dY8zmPuBMIlUUu7qsSS9+x9XZyzY+cT6UW5ADilCNsUQabxd7f9d9CWsLE8ABCvDJ9XN4GfoHtJ400WR0Ypt95EKaFWp9gB8z+PHHr5k77GB1BYSIPiZK8X+mqo93sSrHJXf5TAjZUH/E28VarxKBmuq1P/FUTZ8hr7MrYkdZ/Aymxu7V0bariaVSGEQ34l2UgtD01AW8ubpBnSBpe4zUQmKlCYp5AOfbZ2Dwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9470.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 05:45:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 05:45:45 +0000
Message-ID: <2ec0d3e7-3637-46be-94d9-0d7af9137e12@siemens.com>
Date: Tue, 2 Sep 2025 07:45:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
To: Avri Altman <Avri.Altman@sandisk.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <PH7PR16MB61961D92DC4EAF96C8378802E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR16MB61961D92DC4EAF96C8378802E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 86af7d74-a4d9-4f85-8cfa-08dde9e3f60b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkgwazZESEF5ek9HanZXOGI0TXZvRHc3YU1KU09RVkRSS1dPWFIyU1FITkxR?=
 =?utf-8?B?NXRydk9vVHZjU2c1aVBpVGg5MTE3MlpNMEtqZ1dQcTBKMXZaUHpWYzZ5Umh3?=
 =?utf-8?B?YmIwTGU2VjltNTNVTHBPV0E1TURQeVhwNDZhL3pYbDVuYXhhZHltdDJvUm9t?=
 =?utf-8?B?TFFGdTdkbGJoM0RVcndiZ0cvTU1hYk9qRFZneG04Z1ZtY0ovblF3VVZuRzAr?=
 =?utf-8?B?RW9uRklJRnAwanJsNVBnVjBqQk90S1pxRWVLa1F3ZWlzalBBRk43MUI4NFll?=
 =?utf-8?B?Y0p0VWdyL1B3TVhGbVlsSVpyckxvUHFhUXhoZktUYkY2TGlrRnhLUi9MeHdi?=
 =?utf-8?B?TkErdGhoeUFjOVg5K1ZSSTZlMzBoS21WbmdVV1R0akd0SnBwUHFMVnRxMEVo?=
 =?utf-8?B?aTNROHRzZVc4dENiaEtqd0RMdlF1cXd4ZSswRGk2aEFJempzK3dZQXk5V2Y5?=
 =?utf-8?B?WUVqRzRsZFZEajUvOWxtaVVOcEJZaEpKSjMyaUpCbUVwbGZiTXlyV2lyQXBP?=
 =?utf-8?B?akxlbWU1YzZDSS91WS94OGpDNmZmRXpJN240RnFBem0vdXd4RW5lUVBuNmFt?=
 =?utf-8?B?THExMWp3V3lzTGI2TnUwelMwSWxPSWtsQjVzVTNsbVBLUktkbXBJNnlrSklK?=
 =?utf-8?B?MlE4a1ovQkRIWS9tSWt3b2ZGNFBwQ25icCtyWHhSdXZHRnVwVWJFdG11N2Ra?=
 =?utf-8?B?Vi91U28veWxXTCsyRUZtdCtSSk4vR2ViNi9ac050VWNDNlJDcVJ3bEpCcXRm?=
 =?utf-8?B?YzNDd0h6d2lyazZGYnF6QURVT2lxS3A4ZlBYWEtaWHVrbGVObkxNVlZCRVFV?=
 =?utf-8?B?N25aQmRmSjVoaHorWVRYbUpHS05SNXE0dEZIQVliWkkxUkxwOVczRUpmNHBY?=
 =?utf-8?B?V1J6NE1lVHl5WUZzeTd5RE1IOFM0MXRqYk9SVzViMXJJUGsyeDdoSHlDdG1x?=
 =?utf-8?B?elpOaHdIa1hDczRFdVI3S3ZHYlY2Z1JQRThLNlc5T2IzMFdzNFlDTWNpUU9B?=
 =?utf-8?B?VTZrSDVzdytMcXpvU2dWQXBSdHdNVVA4QUJzWW45d2VTS2RDSm9TRlpiRWVn?=
 =?utf-8?B?YllnQ2U5STJiNjJQYzVYN3BCL3pLclZKTWx5R3VLRTMzOCtIdVpNdFVubkQ1?=
 =?utf-8?B?Zmgwc1IrMm1kQ2dNNk8xSzM0VHh1c1dvZkNQcUhiN0xudnBlRkh2bS83cWZs?=
 =?utf-8?B?dlBYZ1FWY09VS2xEbXJaUlVHQUJ3SEMrTjJXY2ZxdXdzTnFuMDgrNWxsNmdv?=
 =?utf-8?B?MERNbzFnK25JOTFnTlhvaHFucGVtZlhpTHJSdnVlZUNlcHNjZVlwSU5Wbnkw?=
 =?utf-8?B?YkNTa2hUQmh3Wm1XZnEvRkhPUWltRFZCMjZZVDdrYjQ1UFBNODB3REd1T3Ba?=
 =?utf-8?B?azloMm40Z1UxeTFFaml4UVlaajkvR1doR20wdkRiem14dG1SQVF6NVprZE9S?=
 =?utf-8?B?dVRzUVJmYkhQU0lJNTYrSWFjckN5VldVemFvbUFOaVkyaFZUUWxLbUtaOGds?=
 =?utf-8?B?RzdLOXVLSThWRDRvVTRiMjFaVFlhY1VmblZ2aFM2Tno5ZE4wZ21UNFVkbXZH?=
 =?utf-8?B?a3FrTkszK3lWNHRDMXBXR09RUW1uODVyclRjSGhiQ0xRQnk0NXhYcHJYSVpt?=
 =?utf-8?B?Z1dLNkljNnQxNUY5UUhQbTNyaVIwaTF6ZlNnYmd4dmZSY3d5QWdXdXBWVnM4?=
 =?utf-8?B?clVXSFQ0aXllUitvb0IrdVlkMlBIeTNaMEltK3ZweXJUK056L245ZXVBcVll?=
 =?utf-8?B?bm54bUxYRUxNMHhZRmtFQjduMjJOTDdEMitVUmg4bEJ5aW02YWlwUllITXh1?=
 =?utf-8?B?TDJ5ZVA2eHM2SEZ2bVFUcGlzZFpyWCs3eFdJR1l2cldUU09vZmFLTFVuWUl3?=
 =?utf-8?B?dE00QnBidXorUEZEL1lpcUdzQUFYVFRLakh1R0lZRjJKQjdxSEhrWFR2dHBP?=
 =?utf-8?Q?22Q3Cum1zis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ArSS80ckUybzRtaVVOVmdxUVF0b2EvellTd1NLS25Wc2tUcFJ5QjRrNkxr?=
 =?utf-8?B?Wm5JZmpQUXFvczR4dy85LzNob0cvL1VJaytnVVUweU9DK3FMTnpNNFRseSsv?=
 =?utf-8?B?V2lUSi82VXoyM3BlaXY2eHhDTU9zMDVJTWJMbUtFaWJCTlpzM2RkZnVTbUFi?=
 =?utf-8?B?VlZjRlJlblA1OElKaVdvYS9ZejJ6TFJkbnJCUEVPZzJoWm54eExzeFdIeWJT?=
 =?utf-8?B?OVZ2djZVSEhzMFg2UE9mS3A1TSsycmdaVU5nM2NTWW1TZW5xVGcxU2ZZR0tO?=
 =?utf-8?B?Y1pOdS9jRURFeGJwdlRmSzQ4THFEQmpyKzA0Y1dCMDdkajJqWDM2SEwyVUZU?=
 =?utf-8?B?L2N4eGRmMzA5TEdFY2pCVnAzTFk1MmZNTXhQSGViT3Axb0tLdlZxZDB4RVVm?=
 =?utf-8?B?SWFuWW1VcENOWERQanNFTi9zWVlKeU51MnZ4eHhmLzNTTEFsNjdVQjFhRHVY?=
 =?utf-8?B?M1Bkc3RaNXRQeUgwMnZkTEk3VFZkdFRvUHhkTmhQVmY3bTZibmRoNC81NGhW?=
 =?utf-8?B?RTFOQmMybXNCdUoxK2pzU0NvZHJLbmJBeTE3TFh1czl1TmJXZmlmc29Gc29B?=
 =?utf-8?B?dFpWSkMxeEhoaXFhQ0xiVG1aRmtBeXpObUdaNFV1Mk4zS1R3Zk84d0tHcU9s?=
 =?utf-8?B?UWdLOWs0MGFlQzJtSDVLd0Nxam1zMFBrb21iZDk2aDA4ZFVWVUd1OHhYVTla?=
 =?utf-8?B?UGZ6VXkwQzVuUFJNSkZONmhTR2s1ZnA5WW9ad3c0MjkyVkZPWjZWa2w3ZzFX?=
 =?utf-8?B?OGlRVHdibXV6MjdOMWhtVVJIMW9xRWZCSHlqZldpSkhIbUJmN0QrUnJ3b2Nw?=
 =?utf-8?B?Z2YzU1lhQkJXM1JMVjlUQzFQcVFGc2d2U05JandTckpIYlVFdkZmcTIyeitv?=
 =?utf-8?B?MzVYclBNdkorNy9Ybjk0c0xBM1N3RS9MMjc3OVFlck9ndlUybmQ4eC9jVTEx?=
 =?utf-8?B?cXE4WVViTkUrWEtSMmdiNmZpcEJnWjhGdnYyNEQxL2IwSUlreEtWck1pRHZo?=
 =?utf-8?B?M1lLV3RhQWVoNzlBOTRPTUlIa0RzS01sYkRNV0diWUVYaUN3enhLczdHdlRi?=
 =?utf-8?B?TFRWZUk1SEtVem0vT0xmU2dkSGZxa2hYUnNMMXp6WGw5N2tkTFRWVHdsNDhN?=
 =?utf-8?B?UUo4bnprRHpyUWVBYmJlVktLRE5nallsMThLYyt3Y2dRTUN3UDNhS1dHbFhl?=
 =?utf-8?B?Q29TVnJsb0REMjd3ZVJLalM3MEdGczlWbTNoektXcmZHeFpXSFlHaGRtUDla?=
 =?utf-8?B?TDh1TU9yTkUrWTl2amt2aW5GVjlGa1Z4MUpnSWx4alpNM2hwSHNxR05Held5?=
 =?utf-8?B?TWpDNCtNQjY2aHpzdlRMZlE1TEZ6cm5rRm0yaHJMNUNIem1oQTJHM08yZVM2?=
 =?utf-8?B?T1l5WCttTU1XMkEzcVl3STZnR0Rpa2g1RTJkRjZPZUJ1YmoyZWtNci8vSy9p?=
 =?utf-8?B?UWZhaFZEM2crVUZGOHZMblZkcXd1UjdVeVpOektKYjF3YmZGVGVqcGozQ01s?=
 =?utf-8?B?TkgrMU82bWhRUVVGYnhiNXJRZWc5cTJML1A2alVaVUM4RHFPUlV0TEIzQkYy?=
 =?utf-8?B?WDJuZjF5aFh5T2lPcFFOSnJNYmVmdWhCNXZacmVPcHI5RWpDbi80K0RzU2VL?=
 =?utf-8?B?RjRacFlmamdNVHo5SmtERUVra2E2b1RKUjBwc2JSMXN0dUI0THVvRVpGNS9B?=
 =?utf-8?B?Q05JY3FYRHVZcWR4aHVTeUFIR05Kby9kdHVzdTNkdEZhSmZJTlpIWHRFcFlO?=
 =?utf-8?B?VGVXNG02R3NKbUQ1dkI5bkU3L0dFOGpsWkZUT1NVdW1valBQWXdwU3lJSC9S?=
 =?utf-8?B?SGZGVW9BR0hsZG5HTkdVZmp1ZkpCcUVHR1ZvNDdaNCtLSVg1bFFCYXJGUnhm?=
 =?utf-8?B?TnJTdnYyMHhFRmNzaUZuWjhZTG0yV3pGamo3RkxXVktxRTMwaStuNmp6TXQy?=
 =?utf-8?B?c214QmRjcUhaZ1NyaWxSdVEwa2crVXBHN1BQU0VmdlZPTC8zTHlSaXBpelBq?=
 =?utf-8?B?cm1FbE9HSGY0RmUxdWgvbndzSVFPZTBXVTAxN0plUkdRMDBPSlBHOGFUYlRX?=
 =?utf-8?B?ZVJIckVoRmdrWit0U2RxWkxLNDRTMjB6TGJ4OWp2L3BwZU52UnlWYjZINzJY?=
 =?utf-8?Q?YLCW1m5nby1npuiW3mN/PDWya?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86af7d74-a4d9-4f85-8cfa-08dde9e3f60b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 05:45:45.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5mVT+S3XhFYI2gemiolx3irvrLXu+UfgFh4Jot4k+ATK80HOxVkqmJt5q7q9gb35aEGI8KOXMWOpjyc3LLX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9470

On 01.09.25 19:53, Avri Altman wrote:
>> +#define RPMB_OP_RESULT_MASK            0x7f
>> +
>>  struct rpmb_frame {
>>         u_int8_t  stuff[196];           /* Bytes 511 - 316 */
>>         u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
>> @@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>                 printf("RPMB operation failed, retcode 0x%04x\n",
>>                            be16toh(frame_out.result));
>>                 exit(1);
>> @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned
>> int *cnt)
>>         }
>>
>>         /* Check RPMB response */
>> -       if (frame_out.result != 0) {
>> +       if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> Given that the Byte order of the RPMB data frame is MSB first, I am not convinced that:
> (be16toh(frame_out.result) & 7) and (frame_out.result & htobe16(0x7f))
> yields the same output on a Little-endian machine?

Because of the different masks? RPMB_OP_RESULT_MASK is reflecting the
eMMC standard (Bit[6:0] = Operation Result).

Or is the optimization too confusing? I'm shifting the byte order
conversion to the mask, that's all. The pre-existing code was already
comparing big-endian against zero, which is fine.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
