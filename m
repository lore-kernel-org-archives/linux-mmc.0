Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCCA377EA2;
	Wed, 30 Sep 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769938; cv=fail; b=X+WJ6JML3v7y6YyZe/BPrBsq7Is2f+TQt3YvEkmcYlEjHUOSw04comjlO3W3kBYsGNhtl9B62kwoxxjif2XLga1SthMDNf7n2Z8ewRy6wQyHl93VRoIg5W00Zs6SjKsF7PLzLX5z8wfhSo9UB/dZDqGU6mS9hKWN1G0GMbxvhTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769938; c=relaxed/simple;
	bh=S7B8koXjvtWpCPchbJDysisqr/hfdjVi220ttHThZwI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o/XLG8m0dk6MxbAbs1i696D6csXzQwXh+mCpTiVvO99lcNptSrFQxAz1gNWtYcm8xif+wKsQLOHXy5i7VGOzorpfEpHjetPVmLgK1uzuJBQGBFxRjmCCeXKrn4q+z7GP8IjHjK0P77ITxFBOBLqB7aRJZVJHIaUbfhgZS2V4NcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MYqW1ltO; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MYqW1ltO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6nd/zUjuLdpOzWY7vbN1hc77S9lLXdjkPN6RUAyU9ucko3l3QDEHglWX8738tqWQQsy7osSBw5tTFK6r9It7H5IumIGRzfECzTWDY9gMEHzqd/g5xNV9J474L6ZNWQNQPs4i6A2684MQieuWvqKCZ3oWBrDOeiiPUgxFFI97Cw6T5GET7vCixTRBkGQ8X3sDjn9wcK5tH75NchTEk7wZctat5586pottfhD/iE2D2p4EbTFQq697BPXjEmJYLSZXyz4EqPE18ZHFBgYWzTFM0nVD67tXdJxm/wngALOQL/B5XZMDDPWp04rfGdLlMIGrjsc7KlChv183S9yoU3b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTibImnNE3CnpGc5IHFlyuCxQV4GUE7rkjd7VscQIcw=;
 b=gkSn7UJFVVQJNOlgNPfcpiZsQkc4gXV8HBNd9maU9kb49XgtbQNTZPNg6ZT7dX+kTZRRSzX9jpa+bv1vbvCQzVlMLoXGkpFogaYAA5VtibobME7CEoQLoMDrVRYME1cm12Bdt3WThkI481KLujcxyvwgGJIlPOgGftxzCjTwXgHr5z+dv0Y7wL55G6lm1H/WU54QzBNz5T9lURDf0/o0Ti892JeAz2NkHQGOdj8xrj9DCk3dCQmWcFEVrLOaT214Jt7LkULJb/wBVgqxVovjG0VanATaN3lo4UyQa/dukqAJCyrMCPLU8x95LftoTl5pVpNbnfbBtKZd1TEnJXa23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTibImnNE3CnpGc5IHFlyuCxQV4GUE7rkjd7VscQIcw=;
 b=MYqW1ltOzOlgCL1Xe7hWB03cECnogXn71G6OVhZeFlq6ONFzZZohWEHpthNkWzoawTuDo6XwYWRbxxDUDMVHYVJXn//HQRZKNOiLIGtWCaJ1YBi9G4gPQaK7gyc/dW0MJFbPqRSlQgv2ju3M0Vj76KaRqJfNnOxBjdM6sKOs9WYu6gs/hQPd4QLQbdxxGVo8Q+f7CuRz+rxfeLKLXK6TN0fB/iTaXqjVeQX/2Vhx/6UWxj/5czPkyY9YcBah32lrOFdKfaCjMs2CPbHMCbtvCMqBKKruFOiORyhWwrgEZVbk1B9l/HQP+b48lJXAUuE0zSc/zx8Hc/69lltvC8VVww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6502.namprd03.prod.outlook.com (2603:10b6:a03:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 12:05:32 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 12:05:32 +0000
Message-ID: <556594fa-9408-4c4c-b92e-8881c17bbba1@altera.com>
Date: Wed, 30 Sep 2026 20:05:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
 <eb04492f-fecc-4470-974c-8417613a2278@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <eb04492f-fecc-4470-974c-8417613a2278@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b69473-a731-4e01-b84c-08df1eeb204d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|921020|6133799003|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BIOat1sa9uxJOj7Wip3iYO/17zVU5pitT3mXOS+hQdoD2lIPduD9/daDLOMM8tVF/+JupXOWcP9bl3fCAE0G5MU6uDUlQQOn/Fd+30xTNqIns+i1W6jC5G8nXj8byvvkNEoS1MVXxV6gBqJ08qRLalzLHdNPz9KlcyqOcV3F9cVbnYBx6a8WKvCBLPdhJ2jTxX6E7Z9YXnvkrz320/Te+AHY3FpY7HkYlPPqcmt0abn312V8coZHV1b9fjUbEO0CMEYCn1od6u7aej3fyKJEjlgYZc5BOU35jkhEX3mnM8b1QQWtH88r4r2E1fXZas/2sg+FmtLuqVAQxzmdshbRe62U1LrarS3Kh8x/nGRz7CO5bjy8qkwTdVxwba+STCKidG/WtOoFgsq7k8hKTpsFcArknUUsu8u1B2v8efwjZ1QvZ2CLpItAx357Nt5CxVPRsrLan7eXa+QEspPjyz/CpaEQr8JFBviFQUmes/F1zRzBg58ml9fF0M0iucG6MhjnQGSY5DhnbE+QXNoB8H2bdJi//gP9w+v76mYrDzsiHWLmvg8rEuEN2dLiqqpS3egUwF5Ek2UfHBMueSGY2LhKzrtvdIhrONz+9VjA/6J/23C5qnBlnVUpJYcZqhYl1ViBcoYqqujAbOdjqhR0jpPVQGaLeETrc8grsFvaYOmz+OP6ErooXA3WbXyRC3ZF20Roxa/lNat7mSIh31gJ0uIqww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(921020)(6133799003)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2lCaHFST2FITlArTFpiUnFCOFBHWEFoaHZpUmRDY2tBengwNEo2U3ZCdmZY?=
 =?utf-8?B?WWRrMUxQdWdkaGp5Z2Q4MWpHYXk0OE9tU1pjRmF3K01heW9JV3FkaVMzN1lp?=
 =?utf-8?B?eWhFcmtkc1B4eVdZNkg2aGFnbGgrL05xb2x1SVlMWUJPd3Eya3pSQlhYMmNz?=
 =?utf-8?B?eVV2Z3JrNHc1ekVzL3ZxZDc1VlN5UnJwSEgzTmUyUjZpUFJDNVo1TzZHVWVs?=
 =?utf-8?B?YmpHV0ZFK29vMzQ3RHpRMm84K2RBdTI3dnEwTDJOeUlJaWZFKzQrWUR3c1po?=
 =?utf-8?B?M2ExcWRLalZVYW1ITWpwUThVWHI1enF6NEx1WFBWNGNjMitCWHcveTZsanQ4?=
 =?utf-8?B?Q3ZudnhNVGREa3A1ZGhMTUI4N2ZPNjJYcVo5bGpzK0ZTbHBENWpoTTRuWkxF?=
 =?utf-8?B?TSsrVXM4REtMQyttaGFKWjhSVlJWaHorK1kyNDFyeUVIdVltcGdJcENQSHAy?=
 =?utf-8?B?SEVmQ1dWdVhOSmg3YXBNVXZZN3Yza2NXTVNTUHRhUmJmaG5NU0ozeDJpT0RB?=
 =?utf-8?B?RVJjWXhQRDRIUmphRGNnU3JwcVkxc25vQnpFQXVlVlBoYTgwQkg4WllvaTJn?=
 =?utf-8?B?Z2dsRElyR0ZJdndaSFlHbnZkT3RpSkRUaUFMNlU0aEdaVEYxZmY0SDA3SHlj?=
 =?utf-8?B?RVBNZzhmWlBKZ3BHTjc1NmFTQktsWS9MREx3UCs1YUpFUmVoS2RIbEJPb3ZR?=
 =?utf-8?B?M0UxeVhOYURvb2hkQWVtbndLL1RmRHlDU05DTjNmUWs2bDg5a0I1Q21sUnRt?=
 =?utf-8?B?dE5WZi9WTWxxN2Nqa2t5S3NpemdYb2ZsV05uYXRCV1loMjhXcVlENnVDRG1m?=
 =?utf-8?B?UDZJTjM4UytHaXowaW9KTWVWdk1yejVnUmxuNFVXYkZhVnhlNTM1cUxmcVN5?=
 =?utf-8?B?QmZPWWUwVGtIdWdTOTlMYSt3N2M2Q2lsUGxSYloyR2pjNHdNTmd0OFJwRFpw?=
 =?utf-8?B?WmVYYkpmQnlhQlBQbS9FNkZBZ0ZuVU5pdXQ4WjJHdE1xU0tHSnJ0NWdLeVky?=
 =?utf-8?B?U0F0UUQreWpBTk5KS09KNWlVaUcrTFdCMVk1MzRxbFAzQTUyaVZaQjFWMGYv?=
 =?utf-8?B?SGlYQ3N2ZGVpUUZQMW01Mys3elozUm51L0lGK3N0V05xbDZzOFNGNFdYejBD?=
 =?utf-8?B?NldWc09MWEl3dDhsUnpTM0gyWEtvSFFETDhTcHhKYVN6RG83TjRaS09DRWcv?=
 =?utf-8?B?N0hZRWxVVHZMbXRlemxEU3BRcDVtTHU2b0ozUWp6VUZFclFoYkZCdkkxK2hK?=
 =?utf-8?B?WWJ2WmZ6YWM4UDVzYStzL3BjSUhjb1kreE51bVJsSmdNSS9Iejg5UTN3Zmlp?=
 =?utf-8?B?NnZNMkM1eUgzOEVQajQzekYxbjVFcWk2aDV2aXMxdWFXOUJhOEgwYW1HMnZ5?=
 =?utf-8?B?Z0o0WTExNFV4VUVyU2JMazBPaVA3MG1kMnRhQURUQzZ4SDc2OXRmR29vVzlW?=
 =?utf-8?B?QTJGQkUzaGFLc21xa0JXNDk2SmxRNTB3NmE5eTRHRi95NFRvQXB4V2JucDMy?=
 =?utf-8?B?QW0veHJjdnhDNTdzNkxMR21EaTgwTVhqQmpTb1cxM1E5S2Z0a0VrUC91SFhY?=
 =?utf-8?B?ODNWVXJhWWJhQ2Q3b1lGZzliSFlhTFh0bkdsSmNxb0x1MjRzYm85V0NsM3Fo?=
 =?utf-8?B?eTZpS1NGQ01OTXplaW5CcWZLMDlZakw3TWZiUXhhZ0JYamxoRWJvcm9aU1Q4?=
 =?utf-8?B?Vm9ZckNZblZKODErUmwzUzRzSE1nYzMwL3NYY0JHVVNVYVlqbFo2aHZNTFhu?=
 =?utf-8?B?NjhNM3AxSTNCUTVPdE5ralhrKytzSjNuZnVNYjFkdGdESVREL3NRRC9xMkw2?=
 =?utf-8?B?VkpsR0pKbjA0emdaRE55TEdZNDVtRGxIVVdsTEtYUE9iYWR0YlJEZ25SUkdC?=
 =?utf-8?B?Yy90NG0rczlUQ3lpcGFRMnJMWEhKazdHdzhaZzBJVUQvUzhmOFZjeXBlbnNP?=
 =?utf-8?B?b0pjNDNaa1MwTHZXLzY0SmZiR3ZQc0czSVI3dUFwV29TL0NkYytCVWplYmdS?=
 =?utf-8?B?M2prZXZtRldRa0xRTmRWUUJFV3pMS1cvdFN5d3ZmeDJtK1Vid1ZhQmRWb3I0?=
 =?utf-8?B?S0Y0L2xSbHQ0ZjJ5OVNySWwrRGMvS2pJQTBrL3VGdUZYY1RNWG5GN0Rjc2Ix?=
 =?utf-8?B?YVJIU09XYm1UTlVzbjAvMnBwQThwanNsWCtSQzI1b29laVlYbGpPZSs3YkVl?=
 =?utf-8?B?OWhmOGFXSzJoOU9Ra05zOXBieHk2OExFdGowRHJYc2l2VWFIQm9sSlpDV3oy?=
 =?utf-8?B?VjJJajBJZnBmTkcrQUhFSjRNV2x6dlhnMjFBMWJmWXBJMG5xeUFwanFUMTFH?=
 =?utf-8?B?eUZyRmZOU1dhR0wvRDZtbVIvaU5pdlY0QzVlUjFXZkNkTFd2ZUovQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b69473-a731-4e01-b84c-08df1eeb204d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:05:31.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZOQdXBFsc9H0g/zPc1COg/hvKlOWCBhktW/BnvUMnemR8lbLD15Q3NG0l54zvOSy8M7UDlkKnXt7lfbjDROsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6502



On 26/9/2026 6:44 pm, Kathpalia, Tanmay wrote:
> 
> On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng<tze.yee.ng@altera.com>
>>
>> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
>> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
>> settle time the command issued immediately after tuning (e.g. the R1b
>> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
>> can time out.
> 
> One additional concern is that the testing listed in the cover letter 
> does not
> exercise the paths described here. The series reports testing SD DDR50 
> and eMMC
> DDR52, but neither mode performs tuning through sdhci_cdns6_set_tune_val().
> 

Correct. DDR50/DDR52 don't run execute_tuning(). This path is only hit 
by eMMC HS200/HS400 and SD SDR104, so I'll rescope the cover letter.

> Please test this change with eMMC HS200 and HS400. The same function is 
> also
> used during SD SDR104 tuning, so SDR104 should be covered as well.

eMMC HS200/HS400 is covered: HS400 selection runs HS200 tuning first, 
and the retest goes through that path - "mmc0: new HS400 MMC card", with 
the HS200->HS CMD6 that used to return -110 now passing.

Thanks,
Tze Yee

