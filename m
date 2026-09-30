Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CD4C9DF4;
	Wed, 30 Sep 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771498; cv=fail; b=XiQsVkGq2Sln/moyMzx3Jowuz95/KFyLYaaSYvQpKd7LdevXspwPJ+t51mrcl+fIaFNH21KMKmT0p1SHIJx5RXS2HpqSeWTuJxUw6xHRoISvnuOeYxPsVu/DaXc784T7vdWC32pWzmAW2IftQlSLISIKZzsoYGzQ6ZfqMsZgrLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771498; c=relaxed/simple;
	bh=QDlFTjS/lx+j7AKAVqbRO5YRYFPr8IQAhCN/Mr+0Ot8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9XLqE/FQyINTmp6qwrji3OtitImivMazadbJJCKX3lN5rPPYzQqxkeSX9fztOxAYn6gvKPjb/eQlNRqitdZNuh6Tbqmjyx4+CNvOoptTVlcMUDsqfUqkZ//Emjal0MaN0jsg2lP5v/9Pd3VDfrnnh4RFOUvY9drxrkxSFutves=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mq9VHQ9e; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mq9VHQ9e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJSAfFAKuat7NnTnjSe/DzVDXdWq0QlwLQOHHUFcqtYRhN3A0ToBcsC06YAqCVSkFo2Knm6npZsHo8WkDzSKQARcMY4fC/AUtDtIpCSWhKbRUn9oaYvh+RM2/MRBml1D++xDOQ09k/oMSv+QAJSRBtv+yfUnMZKRnVLVw7ZIViMuhzBCL76vNXPhJ0u+b8t+5gAO9eMrdXdi4T8xBnlDP++trfgj5ES+5aGZdtF7aRMxWt8Qt+DnCRplm40WkUEK4PoxBKBk0LYqYjmu3LIjDbBm4I7R71w+5PjKs2TWTMcn8tYpqOUrf9WcGSwsiG8GyNVv/WS9XJRIX3YYDC0LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MnCcoKaDVKcf26aZm3By3f4np5SLYZGKa2Ux+x/9M4=;
 b=ywFx0CppzlchuxEtKRAZRokMZgNcD6wtRwJrjHRDcqW6Qri3FhRYhCxPtolNDWmOCX46VTZqxFu1P0GsDCytD7lNhMV8p80v6Kk5Ct1klvMkd5C5Gp4H9vzp2zLmt7hFC/ChaticqXJlQVvxPMkxduT85rXFpj/K9ifXfLwy63cKqnTAOPtl8gbmp4BIzqs2TQkaqt/e3uN4yGYisYsFFWKUIJ92L/0tS8Mqyubc+jK4fGPYPMjuepy1b0aXaa7ELFr9eUoT6xU5iXoy1+h8DbhvhGlqdOtum9nWADQIa0b1F+Q0aBTy3/Gy74cswmYomIon3qpbvg3Co0WLOnipGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MnCcoKaDVKcf26aZm3By3f4np5SLYZGKa2Ux+x/9M4=;
 b=mq9VHQ9eqgY8SuJzOWoSUmkH6L/bHjbXwuROUNzd376495S0wQ2VskuCZSG9LaEthSMVUsaqXElUX4fPxUXCFfrLBlucTQhNIUZ3Q3fA9tDLOb2V/pLn6ODcrzPChAIqGNHKtWo6Zxo+uVZ6VApmkvNTbAFbTkSwQ352YgpWiSxfofHz9nWE8XFtPe+a/f6LAz2/70Njfbz0qZQXw/3Wjg4iPm29fu/UWs2yOZtC7AUy1RoL58WNbfOBDMUuz3nAySQWBwhGwQtHS+SB6LxlYDoVN8VjWAhK7g7bn1lZ2pm4EYbE2FmzRAmzvEmKiXCx/X2MpKon4V3luG4KwOcHHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DSM1PF8757F2DB2.namprd03.prod.outlook.com (2603:10b6:f:fc02::551) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 12:31:34 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 12:31:34 +0000
Message-ID: <4ac6068c-3df8-4286-80ef-aa9a9ed9b648@altera.com>
Date: Wed, 30 Sep 2026 20:31:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50
 read-path tuning
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
 <9c6b0248-f3d5-4bcb-937f-18c11dd7f368@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <9c6b0248-f3d5-4bcb-937f-18c11dd7f368@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DSM1PF8757F2DB2:EE_
X-MS-Office365-Filtering-Correlation-Id: df52e4ba-e5c9-4b5f-da90-08df1eeec34f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|4143699003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zeuLty9VWzAJJQDOltyygZVI1JrRBKTE3NireJ/OMwVIgI5+FMf7WwwlWDYufPPLmeAfMKHSNTS5PO3nZftukFDkGmDE75oPs6y0TXhoU8jt2yTBlgFlpWRy7Uro/g0DjBwgWWYNy9EzNur1PFIKIka7W4QsS540jgl3p7Jgmi6oA12pfNIF59fUfdXM1oKa5PY2qqsPMCWvcwcvar1h+8+eJu2zCxwaSdRykDnQSJwxIOjqzj2bX8PG/iPvdn9jGeKwtv1bQnVusgKIhBwTDsM/k2nS4agh8uh6tC3hxWjsePK1HZM/zZeHE/JkzM6oSHz1Ajp5boneuhNjDF1B7d9mDYVlBVf3B26ZTvrwlKtSkqEdd548GXbDOussAyUoNZ7sy9h4v/ky4zXQ61bDDS2VUHy7S/TJrRmTubiqaX/cwFQT6g1oGaUskmBENhMraJKdEYhFTMzlLv14+DWlqRcyQxpyFaORB7zsHb/NO83pCwJmG0bzZVTg04oArUiHjDSHmPfsL+NR4440DVQK37xEcMaqYPXtyQN/TG8eg3WK1Xfn0mINHHdRxxHZvjvuGx7WT8YXi0Rvwb++yM6rlPNZ7/n5Wwx1/DW/sg2ILUd8O/iWQQcik5EQJ980pugn5/woaeNQSRO3UXI8LFyt36bXrgb3dYwae6iTAcqJelSusFdbg9D80ASyaIKEDh63KFx0HSFjTsZ0droo4+FCEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFibGxNVXAyTmNGbE1MZ1o4WDRCZmRBWWJtQXUwbkFTNHNPaTNkb2kxVTVX?=
 =?utf-8?B?OEk1cVZpTEVnL3ZKdW5WRmt5QTdLZGxtTStSOHZvd0lxZU1nZ3pPdVRIRjJG?=
 =?utf-8?B?UnFxa2RtaWwwR0Q5SnpOekxrVDg5a082QSs5WkdxSGY2eVNvM0xHYzFnenND?=
 =?utf-8?B?M3YyN2tJRDN6Q0gwUXNFdFRKY2VmK1QreXRsblRpQzkvaG5SYzVpeEl0WWp1?=
 =?utf-8?B?WTIyekd6S0padHFRb0VhMEl1enowOFJJcWx4bkpTZEwxSmoxTzZhWFR6UXZy?=
 =?utf-8?B?WUVuNEJIaEtlTEhaVThxYnFDRUJDaHhsUzAyL05LMGxsMWp0dWc3amJIYWh1?=
 =?utf-8?B?QzdPRGVjMmJacThnU3REamJ4dG84RVMrWG1wR3A2M1o0TUo2VVJkUy91R3lu?=
 =?utf-8?B?cTNLbzk3bkpXc3JySGhoNDJ3dmcwQk0xdnJPQWdyY3F4KzArOXlHZHlFTkd3?=
 =?utf-8?B?elVYSHdMa3lvYTduSWh3MmVYT04yQ3BnVGFZeDcyY2tueElwQU1Jdm9uQ1FP?=
 =?utf-8?B?OWRITHQzVUxZUG5sZmYyN0hZWWs2ZGJXWlZpejBMaHJ1bzZJaExiazBIdytt?=
 =?utf-8?B?L0diTno5ZXJLdWF5UGF1VWl3d2s3cUJCZlpOTjNJM2VFSDRhOEg3WDRyWkNC?=
 =?utf-8?B?cVVkNlRJREQzMGx3dG5qcmFpZ25YSk1SZ1lFR0MxUy93cHBtazJ5K3JGQU8w?=
 =?utf-8?B?bkwwZ3NFQUd6TUQ3blJGM1FLR2hMa1N4RE1YUjRXTVczbVJXaHhjRWxiYWpS?=
 =?utf-8?B?RVN1MWZOR0xaN3ArV1UxZGhEQ25CTXVFaEllMHhIVTdDUmUyUVBtZy9WSUE4?=
 =?utf-8?B?OGtjKzdONjZxOHNVNTVUcDFaVEJwa21xR2U0czE3VGlDK09KTHc0L0UzRFdw?=
 =?utf-8?B?MkRYZEJyc3pPUTNpQjZ4d2pMOXhMdU5NazR6UEtYYWJ2Sm55MkZUMzJJaC82?=
 =?utf-8?B?a2FuOWFBNFFwVXVNQnptelVzY2dVRnpMdTEwait2SVAzVmc0b2d2MkVXTUNo?=
 =?utf-8?B?a21vSlVEUE1PVWtGNXZVQ2NEZmNiMjJjSkRDQXQ4aWhOYkM4UDNIYlc1RHhX?=
 =?utf-8?B?RGF6eVZqQW5wbFpNL280WEw0YnpDeHZwei9ONzY5M2sxTkNwdXFwWFpoV1ps?=
 =?utf-8?B?T1NRMUY2MjE4Yzkyd0R3Rlkzd2o1ZkhqemZJdjZJVStPWGxabWppNlYzU0Fv?=
 =?utf-8?B?ZFVPVzJnRWtYSUlwcmZDUFg3K05yVEt6OXZzZkdLQyt0bUwvcnV5UnRzTnZz?=
 =?utf-8?B?K2tENXNXYVNXR09ibE5zcWI2VHdscDU2d2I2Wk1KZEdzaTIxNThibDBoeC83?=
 =?utf-8?B?NloxRTRkM1dKV2toNHFjNytIYzNGS05hTlVDT3VPRTI2MTJQRGNEYnpSQnd4?=
 =?utf-8?B?K3JlM25HdWdLTVEyUndaZ1NPc2UvUVk1UmJ6ZkJ0RkdWUGQ3cEN1a0Nha3NY?=
 =?utf-8?B?UTRUOXVmUGY1YnE0M2NFa3JYYmpoQlpoa0kydlQ1b2drZ3BNa1RYL0tMZGli?=
 =?utf-8?B?RTJndzdpenVrcUdCZHV5Q3hkc2cxcjZja01NSDJNYWNaMGZpRkh2bGQvR3JN?=
 =?utf-8?B?dlhCNnRYeXV1TjdMWk54bFk3VTNjOVhyL0xXSGdvcWczdS9XVGEwbEg3b1Zi?=
 =?utf-8?B?T3VPZGNnTVFTcnUydXYrVVg3cVo1a2xMM2xVU0lRTXRXVDVBc3ZEZ0txdk0y?=
 =?utf-8?B?K21PSk5wRGJ2NjA2VjY2WUtHMHF6blgyWkp6UWtFR1dWWGlWQzdad2MvY0NF?=
 =?utf-8?B?K0V1UnpPV1pzOFNCUGI2UEY4cDVhYXEvMVFIdmoyVFJNRkxSYmJsRXhmK2w3?=
 =?utf-8?B?R3Jqdi9BTkwxbDAvKzJMamFXMkxFNU4rdXpNWEVpR0FZSytkY3pBYmtCb2RD?=
 =?utf-8?B?WVdlMUUwYWttUTVWcHBXR21vZWIzczV2d2tJMEJDaUVvZWVUN2F0Y2F3QTBi?=
 =?utf-8?B?U1ZCTFNHSVZuSlBFRjMvOTd6NnRkQitZdllZV2UwVGw1anU2cXE2OFlVYk1y?=
 =?utf-8?B?d2IwVkZUUER4aFpTOTlZWWRhVmdTM0hWR2xNcFVLM0E3NnBHUWZCZTVQSG1s?=
 =?utf-8?B?QXN2QzFneWh3alBBUWRNVGl4L1NJeDk1OVFqd25ubk5JeDVlNnM4QlZUMUEz?=
 =?utf-8?B?ZFFKVVVabUFpVGtINXZrSTRJNWV3TVI5STdIeTNTTDJwNkNuU1NuOHh4amZ2?=
 =?utf-8?B?SDdLVEw5WVlOTFk4aStvRWtObW9Ta1hUZE9zWnNnNTgzSDF5alJMZ0hzL3gx?=
 =?utf-8?B?M2lQYWhzUGJBMTd0Z0RkVjNRZ1R1emJtWTZlZnAwUEZwL0NPZGZjT1BidE83?=
 =?utf-8?B?ODY3dEZjbXVKRVAvS2twQ2dFTGF5WnF4RkMrcm5yM3Y0RkFBclViUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df52e4ba-e5c9-4b5f-da90-08df1eeec34f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:31:34.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra6z6RlMaMQhto6HRDz1FC9OLRQotEUnJk+U1PT2M3XOiKDSAyAcAiTdl2g/HVDy09f70FIzXTDD1zBOXqi5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF8757F2DB2



On 26/9/2026 6:48 pm, Kathpalia, Tanmay wrote:
> The subject should use cdns,sd6hc because that is the binding changed by 
> this
> patch. cdns,sdhci refers to the SD4HC binding.
> 

Agreed. I will change to "dt-bindings: mmc: cdns,sd6hc:" in v2.

> On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
>> static, board/SoC-characterised PHY settings. Add three optional SD6HC
>> properties:
> 
> The properties are specific to SD UHS DDR50, but the cover letter says 
> they will
> also be used by socfpga_agilex5_socdk_emmc. Since eMMC uses modes such 
> as DDR52
> rather than UHS DDR50, please clarify this and correct either the cover 
> letter or
> the property names and driver handling as appropriate.
> 

They're meant for both SD DDR50 and eMMC DDR52 - both are extended-read 
DDR modes with no CMD19 tuning. You're right the naming and handling 
didn't match that. In v2, I'll rename them from cdns,ddr50-* -> 
cdns,ddr-* and apply them in DDR52 as well, and fix the cover
letter to say both modes.

>>    - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that 
>> centres
>>      the read eye (0-255).
>>    - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
>>      (0 = phony, 1 = loopback).
>>    - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion 
>> timing
>>      (0-63) that positions the fabricated strobe relative to the 
>> returning
>>      DDR data; not produced by the Cadence timing calculation.
> 
> Please drop cdns,ddr50-phony-dqs-timing. The PHY guide defines this 
> field from
> extended_read_mode and the RE# pulse width. It is not a board flight-time
> setting, and patch 2 already calculates it.
> 

I'd prefer to keep it with reworded. Patch 2 computes the nominal value 
from the RE# pulse width per the guide, which is correct for 
direct-attach boards. But the fabricated strobe still has to line up 
with when the DDR data actually returns, and that depends on board 
flight time: on Agilex5 modular devkit the computed value mis-samples 
and phony=0 is required - characterised on hardware. So this is a board 
override on top of patch 2's computed default, in the same class as 
read-dqs-delay. I'll reword the description so it no longer contradicts 
the guide:

default = value computed from the RE# pulse width; the property 
overrides it   for boards whose flight time shifts the DDR data return.

>> All three are disallowed for the SD4HC variant.
> 
> This patch does not add an explicit SD4HC restriction. SD4HC and SD6HC use
> separate schemas, and the SD4HC schema already rejects unknown 
> properties. I
> suggest dropping this sentence.
> 

Agreed, will drop.

>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/ 
>> Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> index d5ea2717904b..df86872603d0 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> @@ -74,6 +74,33 @@ properties:
>>       maximum: 1000
>>       default: 24
>> +  cdns,ddr50-read-dqs-delay:
>> +    description: |
>> +      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the 
>> read
>> +      eye. DDR50 has no CMD19 tuning, so this is a board/SoC- 
>> characterised
>> +      value. If absent, the driver default is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 0xff
> 
> default value?
> 

No fixed constant. When the property is absent, the driver keeps the 
value it computes for the mode. I'll reword the descriptions to say that.

>> +
>> +  cdns,ddr50-use-lpbk-dqs:
>> +    description: |
>> +      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
>> +      1 = loopback DQS. If absent, the driver default is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +
> 
> default value?
> 

No fixed constant. When the property is absent, the driver keeps the 
value it computes for the mode. I'll reword the descriptions to say that.

>> +  cdns,ddr50-phony-dqs-timing:
>> +    description: |
>> +      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). 
>> Positions the
>> +      fabricated read strobe relative to the returning DDR data; the 
>> correct
>> +      value depends on the board's SD flight time and is not produced 
>> by the
>> +      Cadence timing calculation. If absent, the driver default
>> +      (REBAR_PULSE_CYCLES-1) is used.
> 
> The description conflicts with the PHY guide, which derives this value 
> from the
> RE# pulse width rather than PCB flight time.

I will reword the description in v2 to say the driver derives the value 
from the RE# pulse width per the guide, and the property only overrides 
that computed value for boards whose DDR data return is shifted (e.g. 
modular/SoM flight time). No static default is documented since the 
fallback is the computed value.

Thanks,
Tze Yee
