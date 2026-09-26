Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299341442C;
	Sat, 26 Sep 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419479; cv=fail; b=gqjCvdx5WiDyESxo23peOD9Ldg96Xc0LT5bmJsm4H2HGDoRT5HKyvUw5nohcHaHPYFbYTtbDOLPtM2qzpAJrKQzRmW1gQPK5Vssti4lx0hnv4WoO3iJyTa0UMjXlXhr7gyvzCmvEBbIWHr/4D5W11ecXX8x7igJHk0htIHtOQIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419479; c=relaxed/simple;
	bh=2drU3Hn/MpZUptSqgoh2sEDvGqWVN6W/viChJ6fV55c=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=al7IS0eh/4jjp2a+eTAC1Kwg5NII7HehSR7cMBP4egImkUkk+Qb50daFgxujiphr4yGiCheSvZro55Lv4dWGlm8l5r6KgIr4SHOd/L48UMjVos1jko1LTPu+te7xgmN68UKoLKRoRjuAOKELhNQ7OHVj1ctLmz6HMOSWv5+//9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=svMLzco7; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="svMLzco7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFrcaH+B+TOcCV2EwOcvA+bVBP4EFX/0oRyv3AlxabNq0OqWaqQSgRkRreOHVSNQiyikGkwhogtZbyYU2ZMsdauFDtkDz3uG72K5SzE3GD3BRDH4uhn8uCbeP7Ddl5xNjKWxk0stMqd4oL8QqeVup70fHlQknFunI0PBDw7LDLMiwKjNXHyTKf2N0Yqe6MRqrEBI5IIR2r70enxgqUeHtBR2yJS7vwO735xR6K+UKx0m2UzxxHLNJOrxqBaYn7v9xDJTC7O7ydfZWCZ3aMxghWMtSoyvfJvjMnz+sjBS7yIY0gDGY8oZR+OmIsoC86y3Pp8XeHgDQN1e3UwgqU3J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Ez6GO180erU1fehwdT/Vz+C1mZKzHuk3/qDfouQXs=;
 b=Ckh7YJdHKpLcBljm4Yq7QK91GGX9PW0MCPx5uaaPp4cMh3v2MSP8C1rAf33KUZZeUJaQQAjIRtbIN/2jM+r3dVwPxtF8+nPF7BsQRtYnsUb7mVAcXPGNtSKHMYRAOAmOc/hcssRPF9z/gNSMDOhgkp9GUo2v+tNaNkj7qU2GdAfP8eg8ahQbxh+AlJmwVlePH1+oJuQU+lM7Y4E1Lxbo3zZnFH9RNV6Wptbr76e3gSb6bgbtHdDDw9x4CF333FOlrQc7cfrtDiAq9QYnnHObj1eH0OM1dSlOR6r3UEpjNHGQDrrnP82WjblGRPh/GvNvnfUwI17CKl/4QKhA3gyC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Ez6GO180erU1fehwdT/Vz+C1mZKzHuk3/qDfouQXs=;
 b=svMLzco7Q7aEGYSX6eSKYE29dHGeNxDnYelGdXvJltY1+s9kObMWTjKuX/8Lo/3MepwMk6BNedbWGXM8LuoX97K+2kvdtXvJJKc1FFYVPUo0iSSv+YmqAD9aau1QhoNy6iqV8V8YSV5IDaGPyjQm7rri7ofv4yZfgGXhcj16XLfcLs/vQlzjAFdDFsqfSsTaTo3iaJEOd3uEm2CcNbsIKcFCHDicjKGMzW/4em/4zOaGQWIZnX2J4jC3UKrgVtCqaBn8H49ItaHhABtqFePPhYEvYSUwsyOZ/bQXAh8H3vvDiYSPeTExLM5ZYmOEiA9TqQztViuRwSDKx+ixFcrpTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 10:44:15 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 10:44:15 +0000
Message-ID: <eb04492f-fecc-4470-974c-8417613a2278@altera.com>
Date: Sat, 26 Sep 2026 16:14:06 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
In-Reply-To: <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 3562144a-5f8e-49b0-7b18-08df1bbb1b3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|56012099006|18002099003|55112099003|22082099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	W1cRtohdsb+9Ss+iRKUtWnJIkZrJu2OuRM8m9tOk7UmOuL94AJiJgPYz3MZdIbNNKw4laXEYbKGC9Up7Ii99HmePoOJCxioEdqEMaFH0cVBwmhuhqaQl0sIXWL12BInMRCyCyHY4rQI+6Z+6OZMSIZG2tmna5VtOPt4V8nilpEoTJPe0V+/O5K22BtTAfOuWB8LI0NXp4ft+alVd3ryX/5AKoWsW6/kPK080qRpLpFwqCd0VJRVpHEHokGQzjvnJfMXktuJzhbprWrrxh2OpbPPN01Awsl9QnlDY4QamsB7IRAvc2PDbgmZlrHo0qHMgupxXvuazsDZiB6gQoWocOfxgA7bq94akAGhzAiInU6Avqez5VFoLIE1sFAqcQpsJuxXbA7lhowexs1yHqY9iNcY4yWPrVNTBv96lsCfMzBsbdpYwosweEBydbiVCnLB2jCvUmtY/5Usv+MwIXidalz352lFzB4uFnuLYyFcY1MlCZIT63KYjERdu7hpclwezJE0p/05xryXAcEyZTtI2W2AcuDJAFVZMiv9i7payXFGcl+Fc0BLT1HYLG2K1n5yo0F+sxbUogVIJFDV32hBZR7RHo0CbNaCHWQSuhm7CECxcupQrG64ZU86XKLdvD6WM/6XYyxPrmJVBUP80nuUC6wv6Duz6UfqOXTHj6sSUO3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(56012099006)(18002099003)(55112099003)(22082099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVRYSzBEL1NiaEkwdjB1MWtaN1pCUmlUem5IVy9iZUZFdzVmNmNhR3NIZ21T?=
 =?utf-8?B?R2FxUTJzS0hWc1huRitxUTg2RHF0TXJuamR1NFhwb1RRSU9TM0ZPb21wcTkz?=
 =?utf-8?B?YVZjaEZQMEpWYnFhbGU4QkVoTWVzMzZDMWxMdFIwc1Z5ckZQNXNBWTN6OUVk?=
 =?utf-8?B?TmhJMkd1V2EweFQzd3RuZ0k0QXZJeTNpMEhOYU9NaDBCSzA3NGd3eVZUSU83?=
 =?utf-8?B?QzB4MnBlbEJ0T1BBSGlJR0Q1VGZDNlhnOWVtVU9EcjQ1RXNMRDhRSVJ0STJQ?=
 =?utf-8?B?NWdxSEFVN2daOHdseC9SRGNjdHk0eEhGZjZmWmF5RTRvK2o1SUhLTFdTclFk?=
 =?utf-8?B?VUtRWS9GelhMU2dSM2NqT3hxS01CVHdSdDBUUDgvbGMrbTBWa3ZWamlzVER2?=
 =?utf-8?B?MXBiM2NRNEZRMGsxUWQzbGs2SllDakxET3Z2ZENsTXN3dXlPVXpQZGQyVXJH?=
 =?utf-8?B?SVYydkwzZjlkeGZCMmtoU25acGZ4cHJlQmtzRXZaSXlrWVBNTU1rSy80UkVK?=
 =?utf-8?B?SmNXMEkwVjFLY3Fyd2FWNitqUU11QWRNcFlXQ3N2YjlTRXAySGx3KzNNcGRY?=
 =?utf-8?B?dm5kcDI2ejlRTlF2L09tRFh3Q1JwenVVOW1jbEx1MEhZU216RTNrb1AzdW4r?=
 =?utf-8?B?cDVBbWQzdFp2OFlTVnZDOWN3bWJ4SFNiM1dwbWhMQkE2anZqZTUzZVpuaXpk?=
 =?utf-8?B?TEVqOFJHeTkzaW1iQUJZUUpFMW9MRENKck9qNC9ZVVJGa3ltZFBKdWxBdldS?=
 =?utf-8?B?S3c3anZFdEd1amJ6d21IYzQ2eUttQVcxaWRjWnZYcEtBaFRZN1dJU0pjcm53?=
 =?utf-8?B?YVc2dDdSYmVhTWlwYVFNMHgwSlg4NDIzNjRwYUMxbUNBNnJnV1ZNbUhOcTho?=
 =?utf-8?B?NzN4ZDY5VzNLQ0htK2t3UzlJY0VuZnJOM2xqVExiSVBmV2ZDbnZqMXRIMkt4?=
 =?utf-8?B?THZUNmNKQnFhS3ZOcFFOeVBTdTJTbmFDNk9CWVlzTmxYQlhHeHp3VCtFUStk?=
 =?utf-8?B?eDR5V2luRUZOcVMyV2IrSDFKMFJJVWJVd2x0b1ZmdVhoekJxaGFLL2I1OXJY?=
 =?utf-8?B?cmY3TlN2cTRBYkYvdjVUenM0d0pCUU1tRFl0WlpDdERmd2Y2TGJ1dTRCdnhj?=
 =?utf-8?B?WFpHMklGbVljQkRuY0pUbmMyb3hGM3kvQkpxaWg0UHhxeDlSRlZFdDIzbExB?=
 =?utf-8?B?aXhhQlJZRjZPakZoQ3JiQjJOd2dpMlZiVFRxWHlqa1lCcG92T3dKVVloSDJG?=
 =?utf-8?B?ZmV3Mk83T3RBL0diRi9xVTJka0RqSks0a3ZNdVF3cEUvbHdyek9CdEt3M3B3?=
 =?utf-8?B?NXE0NFJ3ZDJVbFh1Mnd5QjFFaGhaaGlNZU1aOG1IWnprZVcrSGZBdFZRWmRM?=
 =?utf-8?B?Qk0wTXdSL1NjbnhTbnpqYTlLQ3Z6cDhQOEV0V2NIS2tXUGs2V3JZZnBtYW5M?=
 =?utf-8?B?cjhRNHRxREZXbHJOaUVGZFN5cGRlZnFyVEhWSi80NDNZVXhWNmNlaDhnNVRW?=
 =?utf-8?B?TGNnWGFzaFlsL1FzNXBBelhGVGVRWDlKWnpCSWJGMHhwdEkwUXNpb3dDcFlT?=
 =?utf-8?B?VGRUR1ZkYWdmOEI2OEJ0RHM4S2t1MHY1c0RIOVFtSUlaSEZPM1RvNEkyY3dh?=
 =?utf-8?B?UVZqdFhUcWFyS2RkTVgvYkhtelh6VEZiU1l2TzRPVFRVYTBjTjVnQS8ycEZB?=
 =?utf-8?B?MjBFdyt4Z2tnUWQ3U3drUGgxcmRlR1F4R2xYeldKQWMzK1FXQlhDTnBhY3hl?=
 =?utf-8?B?d3RkeWV2QmFHZjZJcllqMGR3bk4rWkdRQWdFZTg0aENpb0lhUEhwNnVLZldE?=
 =?utf-8?B?SDlSQ0lUWlM0WFN0WGx4R2E0cVNObk1YUGF5TVR2MXRIRUI4K2Ryai8yNnR2?=
 =?utf-8?B?cDZxeExnVkJPNGI5VEVpTkxJdVovdEdtekhZYUc1MjlhS1AwUFVUT09qa1l0?=
 =?utf-8?B?OWIxTllxTGw5TWNLQ0VUd2c1QkZ5VyttUE5DMWM5VlcvTHRPQzFlYUo3NzVD?=
 =?utf-8?B?bitBUm1OdWxPVGh4ODRVWkZpcm1kdHpjZE5WQS9TN21RYXdSSHpCcXJVRkxw?=
 =?utf-8?B?Z1EyamdjK3NESks4VVljckdBNzhYZlNweDlvaW44ZExQY2VscEYzeXpDdGdE?=
 =?utf-8?B?Wmo4Vm5MM1pHZlBMTkk4c1pNQ1R0UjkwVnJhNTFDTS9BYmIrUWc5cFJMUDZB?=
 =?utf-8?B?RVEzbUpRL0p0aEQ2TFBmdW9CQm54MlFhTVpHTHc3aGlYbHZNaFlDaTF1MVg4?=
 =?utf-8?B?alViNE0zUGozVmNkaHA4NjJHSTlxaEYxODQ5ZHRBOHZ6dU9yQnFhOUdHbjND?=
 =?utf-8?B?aG9PZXFzNVpNeU1xMkNhb2t4QjZmaTJTYWpiNFdzci9pUTlTZ1hVb2gvMVdx?=
 =?utf-8?Q?+65/6rjFGdbYf9yw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3562144a-5f8e-49b0-7b18-08df1bbb1b3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 10:44:15.5902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Nxo2QKbgJielP9SZ5UUms4BYx8Ev7lrRq7bmMTl1BVLfbwidOHEr1RZsgTRN9e0PxwDzQyH/+aQBl5ZMhFO68wWvtpPSRT/3f4ZwYvFsbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132


On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng<tze.yee.ng@altera.com>
>
> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
> settle time the command issued immediately after tuning (e.g. the R1b
> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
> can time out.

One additional concern is that the testing listed in the cover letter 
does not
exercise the paths described here. The series reports testing SD DDR50 
and eMMC
DDR52, but neither mode performs tuning through sdhci_cdns6_set_tune_val().

Please test this change with eMMC HS200 and HS400. The same function is also
used during SD SDR104 tuning, so SDR104 should be covered as well.
