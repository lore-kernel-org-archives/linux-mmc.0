Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795028666;
	b=1jHGGW8qyT6EkQnMlxuOp+I9hovHqcam/sP65AIQhUAP5Cn5axtZFhGWMBBErDzbmMi3
	 1TtNIEyEv2T8FXQSh1jvrG15c/8mSSQSgKjdX0rKtp3gXr0Xit+CyDI8pUp9NO/raZ/i8
	 2A4IHKydQp4A0hC7U4Tn40nvv+FFiRw4PxlnP0/6hI3ORMLZGqU7rJi4nNSgc0DfZJZbA
	 tcj27VQ0nwwAV9XUPiSRufgBh1TQ0cZD3bf3Cuye7mKNCxlS39eUDW4xCo/J14tmAin+L
	 B5EE41wxuEjRmfP9roLnkKvvw3a7sfRO3HwgDcJc3Zbs1NxmJeYBacbLlv/ZN3kjUOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028666;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nNTiQb3hJAH4VjObkNGYKaEmtJf1kDcUhX5Hvo9k3tg=;
	b=I2u87H8pMcKniTUYKwGmVu6nBvhfTj8h10uAInGQ5sWrnpMhsaZfr2Mle7e8L8opRfFg
	 9H/ybrUSn0GtXCPRS3LgCS/JqjLeIY+Bpz5+LlDn+MhKdtq80VYsSZX3GGefdoZMHEmE2
	 WCRaa9gZuvjoDwd546yiE9z3hQOv3JTqcVeQ5lZV0CjriQV9j/BldWqhZByhE5uxmRsgG
	 mebypZ/r/tMyqJXrn0H8cw2YaaHioLuFE2UKo1pUQK75J7DYNTeiirofN5l+7Ea4Uf0+M
	 djh/pZhZVkgO54uD+uZF6+VTI9nBM2tS+Y6ne5r2g4PCIzlZO2KF5WMREQPaB2v7kJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jR7pcpMT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.52
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2133606A32C;
	Wed, 18 Nov 2026 19:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2133606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jR7pcpMT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAG4dBFVmKqTC3FMDs+Qm/TIVkMIjfzTfwUQMULV7gTLMB33sqPDbMgiUNeGJqdZBjBpzwUDF7W0IDb2H9kZsq8FgbOJj2F3oLoJVdu6teSsMyPC+PRqYfKpGyoymNfYA8kt7OG2Jxo9aU05PE0ckN6JzMa4lxv3XEUw4F6TBdazJlDjsw2ssqcdbgffwE/Wzrigh7APa0UQDn4uxfdWHZhmk+i1pf7Uwqt57j3Rm/bn18pyIwuVixhz0AeQpD7rntCq6x0GIk54lcrGafMEpnnkosff9KiXCuhEFfxhdIPJt+FaZletb9lyhVW8a0wXYvA/6IDZbd1B9XIq1pQfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNTiQb3hJAH4VjObkNGYKaEmtJf1kDcUhX5Hvo9k3tg=;
 b=Jr/3vmGaBRVzxw0ZSNPj153b3OsbagaomJyLF4+0wkRzis4Zrl8+35s2k1+ZOY4rMg5bmQ4ZCFkrrXv0RZxWkDH6kHHHPYdufJLIoYhW19FB3/AI+WF11h1aWv9o48Rwl0i9cf3n7OYGgd3NxYuCib8q679JitQLguU95LBXRUMLJMWgdJg7+IW72gWHabuzbd/3hVjYkWjDl80pUigen8kMdHcsl1J9vzooZYd242Hqeox5O3Q+xp0STn7x9RWS0/YG7PcIPXwGD0ci1D4qQZFpKqt+dSSxTRhCFJsm0WRAVte05gFUbeZQlfIyVQIm/x3kl8c73/yTkWa784YrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNTiQb3hJAH4VjObkNGYKaEmtJf1kDcUhX5Hvo9k3tg=;
 b=jR7pcpMTj0FZGsV8RrfI9d0vcPtwzJDMmrt1AIarUupEEiRErixZ9RSslZRiTK4I+w3G9f6mrIUgWSvqgRRW2sXj153GAjw/fKzoFnc9tyraKo9TaBbvSILIE2SGcMBwj6sPkp8edn8/yk5v++lqIojOhFwexi/KoWzzsGrggg4wKebrNtGvWS7VPfvpK2Vo5fylQSpiEcTZ6zq0cvnPegm3Y26cjFERIOGudfbcRmybJnKi+4c806wSWbTrqDZT0dJGyDPW/wEbMgL0PddV+IBR/HUiIVmmwrQsfSNbnbploKEU5Hm86nsQbaY2EAUMU8+z4H2i1tuWLcAdDsMfhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5907.namprd03.prod.outlook.com (2603:10b6:303:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:04:20 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 19:04:19 +0000
Message-ID: <fa378079-aedc-4848-9e29-2d55c4a30d64@altera.com>
Date: Thu, 19 Nov 2026 00:34:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: "NG, TZE YEE" <tze.yee.ng@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-2-cb50afece614@altera.com>
 <da0da5ca-164e-45cf-8921-598d67d6a42b@altera.com>
 <7879888a-b4cd-4c45-bb92-8db776f10d8d@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <7879888a-b4cd-4c45-bb92-8db776f10d8d@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc46e24-e66b-4adc-1b7c-08df45a6bf6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|261022113327099003|261022075727099003|261021123027099003|10067099003|11063799006|56012099006|4143699003|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|5023799004|261009223027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ofy+No+oi1zDGNGjgUetfV4mUl0WDlwiwEK8rWmW+dwWX1FCX87csU6NZ4QjNYNWRc4w+/M5ct7L7f5zdlb2RVvTBOFWe44U+mwDRxMsXwnAOZ2GU6eV08e2lLg4R0/b6lZ4CQnFCGBHsKV5rWMAkxKWRUJzz8REtI2g8F+gucrzxw98FZdEZpU6UivRVewrMlYjo3zo3gsxYUrm44pnuXHwl9awZ3mHwGo3sUjpPE6C7WBiXLXcdwhhmDTO8FGtsKArXMqFXiyyb7h6BzUa3olZSm8oqSLnej5zq3Z/BYdSPWRfXhR3k4hcuATVyxISHo3ziyOZ0NZOxdlTMLS08698JifJGIadKX7vDUMnFEVvqt6bRuys+02j8K2bPc/yfl0ZP69vag0gjQI8s02v+evJZt3rKt3KkSf6U0h1TINjgCAvullJ24JU3/t7lZ9ZKZ4nRencgVfgjifSZeCAotCU/cRmQi3p7TYafqmSNKvPZWhiBuU6BJNEAVtqfNIZ82d9VL8XIVBruBOduHdIFiwLNo6LILhnz6jDAeCoxX7ee9bzb37AtiMA8WRqW5aDY8kVW9FwZKBWe4ryf9gkWmrt1CMsHdv9pAw+lrlevxQ6x0d7TldBSl42vlgESU35YHiyhCPdQO1iwyKfByB3w76k1ox1J1I4hnF1GGgLh7/u+jwjqkuPFNZMVioJljQwq09YbdsFnxt8Vo6U/lkRjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(261022113327099003)(261022075727099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(5023799004)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUYvM2k2dGtsbEp3T0dreEFrQnd2MXl0TkpkbDRsSVhlVWlERzFtUG5JVjJL?=
 =?utf-8?B?SHJaZVdtSkhiNysxSTM4azF2RkkzZHJhNmNDYm16SmVsZmlPK3VYMXBQcms2?=
 =?utf-8?B?dWowNGswMVRjY2FKLy9JdzVQSUd2Q0RwT01uUHh4NG0xVzZpM1pKdzJvV29E?=
 =?utf-8?B?bFduLzJ5UHhoQTdiRGIrVkRNa25pTm1uZ0hieDQ3ZWZwaVhsNFFlSzIweExz?=
 =?utf-8?B?WmR0a2hCeTYrd3BRb2FaMU9Pd01lNVlnT0dkZ1hmNVN5NkFBczlmUUlNcENY?=
 =?utf-8?B?VU8yUTVLOTNYTFArU1lzbTAreXBSNURNcUwwbkx6WVJwNE1TTkZ6T0hnSWs0?=
 =?utf-8?B?ejBrc2VPQ2xEN1lINnhnYWJXMzJHeTZKaTdCTVVBU1R4Vmt5MG5RMDQycjg1?=
 =?utf-8?B?K0htUjljOXNpR3FOQUkyd1UyQjlTQ0hYNmdIU2MzYXczM2N2c2hXL1NGRVZx?=
 =?utf-8?B?b21GME5oV28zOW1TVUE1YUhkWmg3VjRmYi9KZmdZWGlOcjFLYjArQ0lPSU5Z?=
 =?utf-8?B?ckMzeUcvMXBnbE1oU3Z1M3duTlQ4dE5FSXFEREZTQTk4WFlaQTlOVnJxZTZs?=
 =?utf-8?B?TytPWXdwN2NEcDU1QXdCU0ZTemtHMk5JcmVxejFHd2ZZR3E2RmZoMUY4am9q?=
 =?utf-8?B?OHFpRjlraVJMcFJOajlCNzJPYXI3RldMeWxvbTR4dk1vQ2pNbHNRY2xJTVM4?=
 =?utf-8?B?Vnh3S1pEUzJyWWlQanNXTG9abEIxRnRIY0dROUJiVWk3RGNmQ1MvNExUUWJ4?=
 =?utf-8?B?dW8rUko2dTNlNkgrTEw0TktKU1ZnLzNDemlQUlptbm1pLzZlTXB1Ny9leVFy?=
 =?utf-8?B?RGhZY1pLL1YwdlVZLzJKRWhEcTdXZitTdVBnWnFjMDNWWWZ6K2dVd1RLQXps?=
 =?utf-8?B?THh0SEl5dUt1RGRQa3V4Nmc5dFJTdGdmSlcxZS81R2VpUnBUVFZ6dWwrb3ND?=
 =?utf-8?B?RGhNZVBZOC9tbEh5am9JNXBySnhvUFFQN25sQm5yR05oUEFjVERGOFpMUE9y?=
 =?utf-8?B?YXM4bnBGT2FZUEMyWi9RVXhQb0UvdGl3ZVdaa25GSXdZQVVsUlBXVGduNDdT?=
 =?utf-8?B?WmdxUWcvQmFzN0x3NkFiSHBUSXdsU2RzbnI4dXh1TStaZjlGRnFabEVURUlK?=
 =?utf-8?B?QnFBeERwa3VOSGJkUEpTcGNpaXlILzRJbEhCVHFlY1BWZFlVbkVnU1czME5x?=
 =?utf-8?B?YlhINHdCUjhXV3pDU25wWDkvbkE4YnRUU3ZNLytEVWp5dWNBeVE1VzhheDBL?=
 =?utf-8?B?ZjB3Z3BiVlFiYlFKMTluM1FWTUFUWDYvUlR1NnVDb1hoNGZRTGdXUm8vaVhY?=
 =?utf-8?B?UWNBUU4zYnFxNit1WStZVnhpem1GZXdyc1Y5L0JQWlZIZ3JxdDlWVnZ6K1ht?=
 =?utf-8?B?ZHNHVlBKNFpsV21LM242bElUQTdCM0djaUtYdndRclY5KzhjMHhhanNpaW9Q?=
 =?utf-8?B?UXNSWWkxWEh1K29oZUFJQ1JZdVFQcGNQckJuV3JST0V6SWhsWHhOa09LWGNo?=
 =?utf-8?B?djFzYitqOXpCSEs3MkVuR0NBalNIQ2N5RlFXelMvRTJYaUlaU3dScHpKL3E3?=
 =?utf-8?B?aHJCQnhIYVRYT1pyb29JU0FhY0YwZStzUnc1WVA1K20xQTZkMEhKRWY0c21R?=
 =?utf-8?B?QVdEalg3U0xVaHJma1p1S2lXbU8yVEhzNXhDNGpjbE1scm01UUdmWWFFUWc1?=
 =?utf-8?B?N0FGWTE0cVpsanFyUytTdkFXVlhjREFTZWNZNmpJVk9rQ2lPZkVVNkd2RVFN?=
 =?utf-8?B?S1BiT2JpUmZvb3JkYW9nRTZ3OGdJZWp2aVpKRCtWYjRLT3h5eUdSMXN1VEVT?=
 =?utf-8?B?UjVsSG85aStNVHU2SFd5VEJxdnFFeVlQNTlzSDU5QlpQdnBzcVNmdjZYOHNy?=
 =?utf-8?B?Z1hzVk1lMEtHd05rMERkOCtKK1lkYnJ4SVNvV1hTbVZoeWRlenRvWnRPaTJJ?=
 =?utf-8?B?eEJQUFZvN1YwNGQ3ck1hQWlseE51dFQzMmJGZzlXWCtVQVVrc1V6ZXo4em1w?=
 =?utf-8?B?K2RFK0gvWWpQU2dNejliUUVLM1RhVU16N1BnRXVtbWFBTWRxTXRCdmR1WFRE?=
 =?utf-8?B?RHE3bXNveVQ1T0podGhPejBLV0VoY3BONVVUQ3g4eHpjbSt2WEM4S0t6cGl3?=
 =?utf-8?B?bUgrRHRDM3RHaHJ5MDdNNHhVZWVWaGxjR3Q3eXFHQTdjMVJKMlpBZzlmYkc3?=
 =?utf-8?B?VGJ2Q1pmbkJzdTVSbVFsT25iejJqTXlXR1ZPYTFzTktiZitDVGFqZUxJUzVG?=
 =?utf-8?B?U3R6dmxMZmZvaG9nUXhXZUk1b2xUZ0NOejNoN1Q0L1QrTllVTXNyNzQwSWx5?=
 =?utf-8?B?aW4wWGRmTFVHS1JTTkZiRkp4L2xZUTFEditGdWx3cG9NbTMzK0JJei9IdDRu?=
 =?utf-8?Q?9XQNYJYZSieY0FEQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc46e24-e66b-4adc-1b7c-08df45a6bf6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:04:19.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zc0d+KTJiYIj1zS7AhMdnO9Zx+DHba0n1zaTsXSiRgcBJP9pkUrvDApeFoQCqJGkycDwR8EGp0DCRIq2Jiob+O0L15Cn1p+s3oNi0ZFbmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5907


On 17-11-2026 13:27, NG, TZE YEE wrote:
> Hi Tanmay,
>
> Thanks for the careful review, and sorry for the mixed signals between 
> the two threads.

Hi Tze,

You're welcome, and thank you for staying on top of the review feedback.

Could you please confirm the document you cited for the rebar pulse 
width as cdn_ip6185?

I will be on annual leave until the first week of January and may not be 
able to review during
that time. Thank you for sending v4 with the feedback incorporated while 
I am away. I will
review it once I am back.

Thanks,
Tanmay

>
> On 15/11/2026 10:51 pm, Kathpalia, Tanmay wrote:
>>
>> On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>
>>> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
>>> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
>>> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
>>> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
>>> (the silent odd/even edge-capture defect).
>>>
>>> On this integration the rebar pulse is 2 clk_phy cycles, so extended-
>>
>> In the U-Boot thread you said this width is documented in the Cadence 
>> SD/eMMC DFI spec; in v1 here
>> you said there is no IP-level document. Which is it? If documented, 
>> please cite it here and in the
>> macro comment. If it is Agilex5-specific, please take it from the 
>> altr,agilex5-sd6hc match data
>> instead of a constant for every cdns,sd6hc user.
>>
>
> You're right the threads were inconsistent. At v1 I had no IP-level 
> reference and used the characterised rebar width. While debugging the 
> U-Boot side I found the Cadence documents that actually describe this, 
> and I'll cite them from v4 on:
>
>   - COMBO DLL PHY User Guide (cdn_ip6182), phy_ctrl_reg (0x2080)
>     bits[9:4] phony_dqs_timing: 0 when extended_read_mode is disabled,
>     otherwise the rebar pulse width in clk_phy cycles minus 1 (its own
>     example: width 4 -> 3).
>   - SD/eMMC DFI Interface spec (cdn_ip6185) section 1.2.6.2, "DAT input
>     in extended clock mode" (Fig 1.23 DDR, Fig 1.26 SDR): the rebar
>     pulse spans half an SDCLK period.
>
> So the rule is IP-documented; what I didn't have at v1 was the 
> reference, not a different rule.
>
>>> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
>>
>> In v1 you confirmed DDR52 was validated too and said you would name 
>> both modes.
>>
>
> Yes, DDR52 is validated too. I'll name both DDR50 and DDR52 in the 
> commit message.
>
>>> corrupts reads). Derive it from the extended-read-mode state and apply
>>> it only in DDR modes, since SDR extended-read samples a single edge and
>>> is unaffected.
>>
>> In v1 you agreed this is not proof ("Agreed the single-edge argument 
>> alone is not proof") and kept
>> these modes at 0 because they pass there. On 5 Nov, in the U-Boot 
>> thread, you wrote the opposite
>> rule: by the PHY guide the value "is 1 in extended-read mode and 0 
>> otherwise", and U-Boot v2 does
>> set 1 for the divided SDR modes. This patch still leaves them at 0, 
>> so the two trees disagree. The
>> PHY guide is not limited to DDR: 0 when extended read is off, and the 
>> rebar width minus 1 when it
>> is on. With the rebar width of 2, that is 1 in every extended-read 
>> mode. Please program 1 in these
>> modes here as well.
>>
>
> Combining the two docs: rebar width (in clk_phy cycles) = (SDCLK/2) / 
> clk_phy = divider/2, hence phony_dqs_timing = divider/2 - 1. The "2" 
> in v3 was just that evaluated at our clk_phy (~200 MHz -> divider 4 
> for DDR50/DDR52).
>
> Rather than hard-code a number that silently assumes Agilex5's clock, 
> or push it into the altr,agilex5-sd6hc match data, I'll derive it from 
> the clock ratio the driver already has (t_sdclk / t_sdmclk). That is 
> correct for any cdns,sd6hc instance and drops the magic constant, 
> which also removes the "this integration" vs "this controller" wording 
> mismatch, since there's no macro left to reconcile.
>
>>>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>> ---
>>> Changes in v3:
>>> - No change; retains Adrian's Acked-by.
>>>
>>> Changes in v2:
>>> - Added Adrian's Acked-by.
>>> - Reworded the commit message to drop the "generic to any SD6HC-PHY 
>>> SoC"
>>>    framing. (Adrian Hunter)
>>> ---
>>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>>> host/sdhci-cadence-phy-v6.c
>>> index 22d56bb46d75..8d6a9c26c139 100644
>>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>>> @@ -90,6 +90,9 @@
>>>   #define SDHCI_CDNS6_PHY_CTRL_REG            0x2080
>>>   #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING GENMASK(9, 4)
>>> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
>>> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES    2
>>> +
>>
>> The commit says "this integration", the comment says "this 
>> controller". Please make them match,
>> with a source (see above).
>>
>
> See my reply above. This macro and comment will be removed.
>
>>>   /* Default PHY settings */
>>>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY        2500
>>>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT        24
>>> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>>>       bool cp_use_phony_dqs;        /* bit [20] */
>>>       bool cp_use_phony_dqs_cmd;    /* bit [19] */
>>> +    /* PHY_CTRL register fields */
>>> +    u32 cp_phony_dqs_timing;
>>> +
>>
>> u8 with /* bits [9:4] */, similar to the other cp_* fields.
>>
>
> Will change to u8 with a /* bits [9:4] */ comment, to match the other 
> cp_* fields.
>
>>>       /* HRS07 register - IO delay Information */
>>>       u8 sdhc_rw_compensate;        /* bits [20:16] */
>>>       u8 sdhc_idelay_val;        /* bits [4:0] */
>>> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct 
>>> sdhci_cdns6_phy *phy)
>>>       if (phy->mode == MMC_TIMING_MMC_HS200)
>>>           phy->cp_read_dqs_delay = phy->hs200_tune_val;
>>> +    if (phy->sdhc_extended_rd_mode &&
>>> +        (phy->mode == MMC_TIMING_UHS_DDR50 ||
>>> +         phy->mode == MMC_TIMING_MMC_DDR52))
>>> +        phy->cp_phony_dqs_timing = 
>>> SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
>>> +    else
>>> +        phy->cp_phony_dqs_timing = 0;
>>> +
>>
>> The PHY guide asks for width - 1 whenever extended read is on, which 
>> here also covers DS/HS/SDR
>> modes. In U-Boot v2 you now do exactly that (1 in every extended-read 
>> mode), and said it matches
>> the Linux change, but this patch keeps those modes at 0. It's 
>> confusing, I would suggest to follow
>> the Cadence PHY user guide.
>>
>
> Agreed. The guide keys the field on extended_read_mode, not on DDR, 
> and U-Boot v2 already programs width-1 in every extended-read mode. 
> The computed form does exactly that: phony_dqs_timing = divider/2 - 1 
> whenever extended_read_mode is set, 0 otherwise. So the two trees will 
> agree.
>
>>>       if (strobe_dat) {
>>>           /* dqs loopback input via IO cell */
>>>           hcsdclkadj += phy->iocell_input_delay;
>>> @@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv 
>>> *priv)
>>>       reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>>>       reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
>>> +    reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
>>> +              phy->cp_phony_dqs_timing);
>>
>> This write always runs with the loopback DQS selected. The setting 
>> you tested was the phony DQS
>> (use_lpbk_dqs = 0) and a read delay of 96. The PHY guide says this 
>> field times the phony strobe,
>> so with loopback it may change nothing. Does this patch by itself fix 
>> the bad reads on the
>> default loopback path? If not, please put it after patch 4, or merge 
>> it into patch 4.
>
>
> Agreed it has no standalone effect. The loopback is force‑selected 
> until the opt‑in lands, so the write is muxed out. I'll fold the 
> PHONY_DQS_TIMING programming into patch 4, so the phony‑DQS opt‑in and 
> its correct timing land together and no commit can select phony DQS 
> with phony_dqs_timing = 0.
>
> Thanks,
> Tze Yee
