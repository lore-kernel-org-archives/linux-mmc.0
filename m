Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08D156F3C
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244857; cv=fail; b=bpPgAXsLwsbGuB9hFQ+RATKTSEsAYKUNtqq14b0u5GvsgncQomWkQUcx8qJwqwe/z9jPdTh7Ksj38eB6pZzZgk4YrR9MXEP+9eCeHA0PwHtFictfqwsBsVaKUPvwKufprhDUdFdcde/76nexXSMTxwcpXFBFQW9qMKgPPv7LD7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244857; c=relaxed/simple;
	bh=TnUary1r/R/xH+5s8W5iMeX0QjITp/q9MBbwlFYF2JQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B32wOoflazkuOrMKkwf3qg3l639NV7GFNGU+5TYbKSOyiLxp8Jsi6VVC1jKgwM6akcK5qCDWa0Ira7yP3lxOL9Q9PVWEiXs5h9esYwSdJuY90Z2gfgEXOCibH3rSQkfImvcYKil6hahKkr3dtBYHfTgkmEMsfxY6HKBUbk9pVpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0EVk7OS9; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0EVk7OS9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyTm9ZBP+bZVYu7kE+J7zn7Gn11Lt1FbDQsPqg+Y/Due/fy9VaqjbXfGf1450AmyIRG13vAGM6AJmR01CVQXP8u6RmWxXye61rHrO47pWF5Mk5DXDa8jG709et4MPzJ2SsLyr4H1iCNrJ5AE1PLmeI+novo57zNzZGGu+bXYOaSAfMH8vuHgQpm8itKGz4i4FhlfroWlFIA9TGoBfdAWuIgX4yROK/vLlOMLxjQRxKK/0fF9zL3uZVpZKIVOe29t12mErB6zZBCx3axnfeSrYhLfy6fj8VktSbml/XtDfF6m3svUJOnRl3iu58Wu7+STaVQIEVr1Mppf/Mk/44iWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8yYTIa5JuSpckjy5oPtmKxPhATY1w//vB9Q5FpJhMs=;
 b=SmPpafNs1eby2TjVO4eDpflgKH4K3l0OTKKiy/86myQx5vDyZhqYZF8Sjv7bnW9Qq3sxvWr2aXyGhZRTIvObl6lesLcbWgCneLRg8425y80+81nrDga3TerDHflTa03hwb80yDEwBSj9cfWqhC4PmMRSwZVVYMVfk4Iym75x+i7DiFOwF3/xcAWSf/BNVssuEL/mEotGux+/KLYx4+ZZP0W/d0BzFqqJebXIEV/nrFZJLy6s7P6poBLq3VRgQcXo4KKK/dhINBGHx1bt5DOhEh/ScL2bWjdrQftAx0Rl5Bm6C/3WqbUkk1pjIeta9t0yxt26o7M4Z07s8dSsMPL6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8yYTIa5JuSpckjy5oPtmKxPhATY1w//vB9Q5FpJhMs=;
 b=0EVk7OS9T0OaLvWOlyy4LfjAt75RJ98lXMGOrj61pgtuYvYJ0SM3w7ld7LpNYyL3UEDl2siTdR6JBQneEFWkICu2XzT1uufY0b60c1BmQhB0e0jGZaczvhClffWzAxoVOPlfxYWkz5VOafyvVSjd0XeKyo50d9+raE0hnVVpLss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 07:34:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:34:12 +0000
Message-ID: <dec009ac-e185-4aca-986c-a8dda48fce19@amd.com>
Date: Mon, 26 May 2025 09:34:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/34] mmc: sdhci-of-arasan: Drop the use of
 sdhci_pltfm_free()
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
 <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
 <75f58a7bc0fef1236cd94cee8c9dc83bbc6a037c.1747792905.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <75f58a7bc0fef1236cd94cee8c9dc83bbc6a037c.1747792905.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0223.eurprd07.prod.outlook.com
 (2603:10a6:802:58::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 825d9800-3679-43c0-9fc9-08dd9c27b562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXNWT2RuYXBRcWU1SHMwRmhBUXBmbGVTdEJ4TDZuTXV1dWc4S0RCeURDZldM?=
 =?utf-8?B?NFNHcGlnc2I4Ynp3T3BNTjlxYUpvbFhJVGU0cEl6UGMvdlVnbUhEN1N1b1pG?=
 =?utf-8?B?TzR3MUtSN1dMVGVYRSt3Mk5oK2xJRmxJcHhEbHI4Vk9oUzRsRFU1YnVNNm1m?=
 =?utf-8?B?aDVuSDBvN1lIK1R6RUtMRmxTeWpsZE9jcXo2b1V5U01LcUh0dWZ5dTdmTmhs?=
 =?utf-8?B?aDdPMkF5eHloS3hEbnFaMkFub3RyTGE0bXBTb0xXR1BoU0RCTU1XUi9hQ2Ev?=
 =?utf-8?B?cFNteFBkTFJqc2hqZkNENUpzblc5SXNMTFpqOTJMNmMvR3RQYyt5d1ZtZFVp?=
 =?utf-8?B?Tm1WQTlocnd4ZjAxd20zVzkyaURQbUEvdFplWEdnNytWbSt4cElvcHBEV3ph?=
 =?utf-8?B?M2t5QmJYS1ozQjh1ZUR3QWhaTEVoVU85WHJDYXBWTlFUeG5EOE5XTkVnNUVG?=
 =?utf-8?B?MlhOVTF0dU9zMTB3eTNScE9RRmFWN2dpYTdWbnFJL2ViVU5YTFVHdmdXR0ho?=
 =?utf-8?B?azUwaHFoQSsvbkJmVWFScDIxQlM2TkQvZzl0QTlXcTNvSFdlT0NXYXZFZE5T?=
 =?utf-8?B?QzFWbnp2VnZuajBSRnRIOVRzREs2dVBtKzdrVlFZOEs2d0ZnSXljM3prMVEr?=
 =?utf-8?B?YlBUcWpGVXc0NFdZYytlbjFabXRUb0JEaXNjVUZ5NUtlRlZFeHloRmJ0NGc2?=
 =?utf-8?B?K2pNR2NRcEVaWXU5WUpXTzNvczQ1VUhQTkNuT1NNRGlMM1FjVXN5d0VPUFpr?=
 =?utf-8?B?cVdXWE9VZGdEaEx4bXZ3Sm9LN25IWlRXbHFKN1lVdFBOeXBzL2YvTWF3WUdS?=
 =?utf-8?B?enJiQnR6NHgrLzJzTnBxQjZuYUViNFpOT3V5aHhqbVEvTk5QeE4yT3BGZ0Zl?=
 =?utf-8?B?cDhuU0ZXQmticStMckNVNnpvOTBWaVBrZmZKMmxteGZHeXFDOEtGb29nZHJL?=
 =?utf-8?B?SCtsTGJ5M2lMS0dET09DVVFNcUlxdXY0SHVYMXg2M1BLL084WUZPMDJPejFG?=
 =?utf-8?B?TmhpdWVJRnNOSzd4QVY3RndHNUZrdk5BZzA4UFh4b1ZpYWFWdTM0d1Z5MUNm?=
 =?utf-8?B?Ri93NURJZVFTbmtMLzRqd0xkY0RJMjNBaWlSS2VsMlQvcG02N3ZsWVA1cStq?=
 =?utf-8?B?b3lDUmV2Yno3bVhvdVROOEdmQlV1OStGclMrQlkvdmFxazk2VVRaUkF6WnY2?=
 =?utf-8?B?MTR5SVVwTmdhVGtrYmZaTnZqaFF4Sjk3NG1WM2VNV0xvM0I3UUZGMXA2VG8v?=
 =?utf-8?B?WWJWblBRTW1zVjZBYkpkR2o2cjhSMUJIR0VwWUl6VjMwZkRwZERsL3ZRTXU4?=
 =?utf-8?B?dGVuZllrUkk0QTg4QXFhVGJibDNpa0g2WmZRckNEcjhhalRuT0J6d3hTNG42?=
 =?utf-8?B?dmg0ZXRQZjQrT1M1YVArVGtuOXdDVWpTZEZkMnQwSzJWRHViWEx2V1JQMjMz?=
 =?utf-8?B?Tm8rNUp5WHJhcjRDYXdYK0NNelF5VzRQUmdFK29tdDMxM1pIbEhXTzdib1k1?=
 =?utf-8?B?dFRyUk5mUDQ2cTJoVCsxbHZyZGRwdHNaNHpRejVMeUJJNC94OTAvVkdNZUFZ?=
 =?utf-8?B?VHBNbThVay94MUN3UXdnQTcxem93RzV3bmpGSXpDV2tDSEVlT2VBcGtiTEtU?=
 =?utf-8?B?Qzh2QVpCS1NOa01ZOFNXbWRja2FabEdVUnVZOWlYNnFtbjRlZS80ZTk0T3Vr?=
 =?utf-8?B?aXZEdmorOFgrOUFWcnEyeHRxTUxpa3kxbW9XVFFzTXg1aXd5ZjRINGxKTmVv?=
 =?utf-8?B?eFV4MFZ5RHVrWk16alpxNGh6OU9GR01iMndQOUNSY1JOMVBHRkNXTUpRZmpu?=
 =?utf-8?B?Y1JaRzg3OWNVREtJYjl1U2xaTHdXWktPVDlzcFBnTWliZG4rMzh6SForbVpW?=
 =?utf-8?B?WWJIQjNwL0wrV3NUNVp5cnNaN2NVSHN0aWIyY21tbHkxRHRkWEVzVWg3KzYz?=
 =?utf-8?Q?u+mWP+AsuHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnU2Z2xkTW5Rd1pzU1VETTY5blpVb2pYSDkzTituWDk2VVZTdDMySm1Ha1NX?=
 =?utf-8?B?dkR1TVBQVUtkZWpoZjZYd1Y2WHRSOUdtSDFYMmZGcjZ0c1Jvb3hjNEh3Z2c3?=
 =?utf-8?B?NEVNY0NnTUdRVHdPVkJNclM3SjBscEhFSllKOGc2b3EwdGthQTRpNjBHVEgx?=
 =?utf-8?B?alF6V1VpVkVwa2dleHF3cWhRRkFhMlFkVTZwMGdIckRjbElzNytWdUtFN1ZW?=
 =?utf-8?B?THNnbUZDb3pWaERId3ZicWNXeXpOZXpkWkQ3S0JwZGYrVVBCSS9YdUxtOHlJ?=
 =?utf-8?B?R1Z4bDI4dVM4cjR4b3F3V3JXQ3k4ZGd0cGZsQ3NtY1N4b1RVYmgxcmgzU2Yx?=
 =?utf-8?B?Y3IxSlRndEZ5MVRxTHloQmJ6eS8zL1NNa01FQmRKOUNTOWgxL2FveXpKUkJo?=
 =?utf-8?B?d1dFQk92ZlU4Qm9vV3hWSGlRVURkcVJPd092ZlhmNFhCM1NqVXBSdjlDKzl0?=
 =?utf-8?B?VEdNdHY4RENsZXM4MnVETWcwWmF3azNXaVQycE52NGRPbkRodTZaZXY5L0xJ?=
 =?utf-8?B?S2x6V0RUSHlaQWJvcHAxdVRIOVRUOUphUnVaV0UwTUpCMmszWjFNTGwwYUxh?=
 =?utf-8?B?c3lQVGsvcTNDaXJnOHhlZEFtWEgrS3hMcVRCeTVJZHlneUZGemlmdWp6REhT?=
 =?utf-8?B?WVBlYzRER1pJNVRZR3Fwa1FzNFRtZk1oRGFUbE1aaTB5SGUxbGI0QTl2UkpK?=
 =?utf-8?B?bE9KcUQzN3JDZkxWdktCQjZoMzdJQm9FRExTSEcyakxSMXY4Y0xIYzhtTUJ5?=
 =?utf-8?B?SndiUWNiS2l4bW4zaHZpWnJDeFVIck1nWEorODlzdWJrQkIyVXpHL0FpYnFy?=
 =?utf-8?B?SkxkUUxQT3lZUGdKK1FmRjd4WjdMWWdTcnJXNlkyamRZTE9LWWhzUkU1d1dx?=
 =?utf-8?B?eUM3UXROOUFqRlM5eWtjNHFzNFpZVmZ6dXhiVENIemJVd0h1ZXg3amtyM3ND?=
 =?utf-8?B?N3Rkb2g5b2JXdFNMUFhkbzB6ME5Bb3B2MksvVWJmc1phMVJSQmwrQjZPQ1p4?=
 =?utf-8?B?dEpwZ01oaVg0bHNCaDBuUkZZVmJaZFVJcExTYzZ0MGNqdTVGTm5rOWhRUnBP?=
 =?utf-8?B?SnRsTWJjWkc4QUR6TUhRZG13QllHbUFxcG1LcTA3SXFWS3FvL0NhY0h2ZnM4?=
 =?utf-8?B?M1lSYUM1WTU4RXM2REtETEJQZVFlVmp4SlZGMS9Wa3U0Ykw3MHIxcVFzZHk4?=
 =?utf-8?B?dXVVTWVJVkxVNXpiWDVWVXpkck5aZ3o1N0ljd082M3VLZGVKSGpudEptTHBO?=
 =?utf-8?B?QlpQWlNpcnBQcWNnb3FSSmlmcmxNNGJ5c1gxR1M3bGlWTUR1V0xEWnEzaXF6?=
 =?utf-8?B?SnRKZzgxTUcwczB6aEVhUFA4NlI0SUw4UHEzanNxUjBHbk1mWjlNSTljSWI1?=
 =?utf-8?B?UGtOU1FKVmp4T3dQNENvMTBNMGExSzN4ZUc1d1JidzJLS2p2a21xeVJsbEFH?=
 =?utf-8?B?a0FXOUJNMThXWjVzTjFzV09TWCtLSElCcFJHVm1zaXdwNldqRi94a3ZoUEdn?=
 =?utf-8?B?VUg1NndKNEY3MkdsZVBtR1hxbmxHK2Fja1RWZUF6a2hvTVB5cHUrSkR0b1hq?=
 =?utf-8?B?ZXNoSDFocXpOajBML3hVVlpEM0VERmJTckNlekE3N3d6dEVaekFPNENaK0Er?=
 =?utf-8?B?WW1tMzN0ME0rWUVhVVJJdy9IOFhvYkYybzIrVHluWnpuakRacDI1ODNyeTJp?=
 =?utf-8?B?SWdMWlhYOEYrL2RpNzBUakdOUWp6djQzVzh1ckpzTzdYYUJ4bDVVZGYrQk80?=
 =?utf-8?B?d09qa2xZcHQvZHdBS1U4M3NKTDF0em5sQzhMZHBhNlhmeGFUOXdoYTc3blhy?=
 =?utf-8?B?bDFIU3kzRW5QKzYvRkJuRTdUdFdJcm1hMDl0Mk9SRDA1andjYm0zcitsQzRW?=
 =?utf-8?B?WmxPS3FzRWpHZm51UXBWNER4UmFqS2UwTFBCK1NYc01hdkJFbUZwZjVFUUQ3?=
 =?utf-8?B?cUk2Vm5pME81azNKcWJXUUZWY0NxRDJ5Q0lZbVJaYU1WbEduN0kyYUJUQ2Rl?=
 =?utf-8?B?RDhMcGhqL0JkWFU3TmZTWWJFK0lXYjNSenRmYmhBZ0QveFRvb3ZIWFBsWG9H?=
 =?utf-8?B?R3ZSTEJQMXNOSnRPYjJLcXpSTHUwR3BXaDJSWDVjNzBGZTdDd0ZBenZkZ2R0?=
 =?utf-8?Q?cScV3ACAGU0Qy/jk0oy22TJaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d9800-3679-43c0-9fc9-08dd9c27b562
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:34:11.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cySv9SuaaztnUcZ2dJgFDODgeEIQ7OzL76R/5LeymUpXD/c4qQ1aRNrd1qEs1J2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434



On 5/26/25 08:06, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in
> use, sdhci_pltfm_free() is no longer needed.
> 
> Cc: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 8c29676ab662..42878474e56e 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1883,34 +1883,26 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
>   		of_node_put(node);
>   
> -		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
> -			ret = dev_err_probe(dev,
> +		if (IS_ERR(sdhci_arasan->soc_ctl_base))
> +			return dev_err_probe(dev,
>   					    PTR_ERR(sdhci_arasan->soc_ctl_base),
>   					    "Can't get syscon\n");
> -			goto err_pltfm_free;
> -		}
>   	}
>   
>   	sdhci_get_of_property(pdev);
>   
>   	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
> -	if (IS_ERR(sdhci_arasan->clk_ahb)) {
> -		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
> +	if (IS_ERR(sdhci_arasan->clk_ahb))
> +		return dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
>   				    "clk_ahb clock not found.\n");
> -		goto err_pltfm_free;
> -	}
>   
>   	clk_xin = devm_clk_get(dev, "clk_xin");
> -	if (IS_ERR(clk_xin)) {
> -		ret = dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
> -		goto err_pltfm_free;
> -	}
> +	if (IS_ERR(clk_xin))
> +		return dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
>   
>   	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
> -	if (ret) {
> -		dev_err(dev, "Unable to enable AHB clock.\n");
> -		goto err_pltfm_free;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to enable AHB clock.\n");
>   
>   	/* If clock-frequency property is set, use the provided value */
>   	if (pltfm_host->clock &&
> @@ -2029,8 +2021,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	clk_disable_unprepare(clk_xin);
>   clk_dis_ahb:
>   	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> -err_pltfm_free:
> -	sdhci_pltfm_free(pdev);
>   	return ret;
>   }
>   

I don't have problem with this change but your series is just wrong. Because
"mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()"
is just removing this function before you convert all drivers. It means you just 
break bisectability of tree which is clear NACK.

Thanks,
Michal

