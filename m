Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795592935;
	b=M49s1rgfz3MBLLoHMKvHh8Sz30b+ktvJt7hdXS119rvk1Mrf7Yudfb0QOLGiYJsDIHS+
	 BSkFOTuVPkhMCyVxXdza7BplcHYEyOB0JzDe28MzmMhMLBThe9K15Ngy7Mp8DPscvX3mv
	 9gs7heO3jI1wAh/+ZbrJx1PhXYEUwuizIBzoS9WFZu7pTtrRW+PHMWsh3/yiMfG7RGjXG
	 Tgxq9rFJprArCW1HTpmv6G/hdAcVFoNAHmcKvlr5T5ye0P97752+7EhDqbbukhVqvJ1iI
	 fv8e2OBZ06x8VT1VSTSvoWQhfCWdLbf39UyvkiwRJ1k2REHsiHct1bDmmUNZWNWBjvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592935;
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
	bh=b6TWe2klrU/oct26Q/Ycvy7uhcwarsY3CCBTS4JOFC8=;
	b=2TG6UXFkkVPE7+quCizMaMhr4p/NBcq1FSjWCIa2N9b/pLf3VdaU2iTVqBh2GVuBSgcr
	 vqwzE5Smeot8ZP3x6Q1yW+vZaQnYmy0b2vsbfbZlpIwdQrvSErn870N6VEADfLVCgr15Z
	 4Z5lAKAvAvlA8D59qX/jfPKayPjCWow/JvrUqpEP+5aT3Ft8kPKz6Edf7aGEEA6P0dqnj
	 NtkGGEM2WE8HRdA4Qz8xyTMhXaY68XfKl+OlOUXNzOT8H0lqPV8zq8yB27g3hEYx40UQi
	 6Og90OhEVL42SpqGD3aj/R9Xk8Lgg7Ysl3tFvRBW57JJsMGXBsVYyMhKNS53VRNotWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ufmYLL8P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.56
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4B606A31E;
	Wed, 25 Nov 2026 07:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A4B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ufmYLL8P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0n5X0/ikCfL146HwM9qRP/RDHa7vbUjv+a/ix8F7e3V7vWIw+EGnmvPn76ciAqgjRg26HuPxnE/i+66lVbdMXajRGr+csKPuhEy0McCl/zOYiC9B21Nthd24N9q9g0GzCvc3pui77iyKGCEpQ0Bsx1q90yKCHgsJKOix8w7tvbzmuY9AVhzEOXkkRi1SxpzT6bVtqcdfOI03yfjI8kdKUtQMyzUGUX5Bg71zFeokmutuLzFZrbJKiEKVRW/YZ3syxo5+q6Jro/aaU2CFWYwqR6iDYb0TlA6eO8h5+jWMsGT74SASjeyZXCCr53exoWiVt8y/BM8N6eoqbDX8vPOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6TWe2klrU/oct26Q/Ycvy7uhcwarsY3CCBTS4JOFC8=;
 b=CeTZ3Zg8Zk5AvE7u9U4X6xhtgH6gAFXEJS+pFQj8xZhnkkx7jjJb9m/Vxh7+v9gTad8dKvazTdYrnlcS27QkGdmaO76DlpHzA4KzA06AXkdkD1Ml1421unlomv2fu4OjPXvV2imScyF8bq2OXIbzb3wQ8Lhrk2/RA42wGlf0nyhurgA/LVYZiLa07EdC+dpUDyTgkT2Sy8xWs6MX1a82oCEyfTsLMwAZ3vxMfpmO6FAu1y6cNXFghv+NlU6KbK414nfAv0m7vbsUdlcUO6h9hDd1Wc/VAIjT4SzZPq3S7XeP/+bV1zwgWRZNdjV+JhplAa7Ctzj80Y4D5V/zd0yeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6TWe2klrU/oct26Q/Ycvy7uhcwarsY3CCBTS4JOFC8=;
 b=ufmYLL8PkD9ErAajSB8nIiYBq33cTirzo7Jw1pf2BqdqSy+708TzGq+kHHJVTuxwOiW0nJ6CQrGX2u3zhvxSBZkOKfiLY8K2ssZtQPBnk7UuL/Ugil31uIYEeZ0HcXL59bXhsxqToMAl3czQJmhfvBp8OmkEghCM9IEOGofE705lyFA75brHlzA4YSD4ZICj059R79jMOcJiTL4lrVqAGhgeGS9k8dD0C7h28ROLxfXwMe3ZfqCfI+c0UZO+y+4aOIIWCAdqpf5Ar1+tehND9KY2SDri10QBtTrlsv9xAsXqCUc2JzxZGXoEJhGNL1LcC67sizv+BTC5hBmx6fqA3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by CO1PR03MB5827.namprd03.prod.outlook.com (2603:10b6:303:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:48:52 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:48:52 +0000
Message-ID: <60757981-b7fd-4c61-862a-d224047a33d1@altera.com>
Date: Wed, 25 Nov 2026 15:48:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mmc: sdhci-cadence6: tune SD6HC DDR50/DDR52 read
 path
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261119-sd_cadence_ddr50_v3-v4-3-95a94a0aaaf3@altera.com>
 <0163d3d3-432b-478b-90bc-22d6c3f03656@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <0163d3d3-432b-478b-90bc-22d6c3f03656@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|CO1PR03MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 004a6235-bd24-4c6d-d5f0-08df4ac88c95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|921020|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|4143699003|22082099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AXnbwHJbePciVO56qLjSS7mPKM+CBn4lZPf2LQ3NO8mx3bbWDVXBxnPw2VRVfW54LlTJvaZrHFtn2n3rKc72YC97idCytYKyIhvv8dglp6UHHX4U3KRke2Mhv2Tk1M/Ws9nBU6pUPJzEJ120jQBBJ9D7SPbfTA9oK83hces2BgwTfaVPTg1PSL9ec7HVjEVozvYEUQAnYEyXogcDgoNJBeob7wBu8To/Zn57TU4MX3XL665bPsw+2yI+ZSpWAhZtSOS7dlmhl3Bjmg7RoHsLVDl9kKSoBn+yKU5NYY2UoBpsZaNSwDF16Ae/QEyxP2v3yaaq84X7+EhV9C5uU1195b35t76t2EAwpEIvyVGlo3rcRE/KhwQZ5eBhQ6yRE+10glfDx6qIdfGzH6ZoZ+Mw1WglIcuiBaVNet+M9RKY2KyzZuWe+0YucMhzVJNGq0g4JgqLJ9dv6jF2IvZ5rYjlQ1/Qw4XOsWFqqHf3t4HGGYrXaRbpcRhBvr2L1b+rjy9EcOfDF0Se/qprXCoC5PlMTeR69O8RYqRWe+cy9H6dHobDeG7R7NjUJChBWtlPptHvzC98ckQvJBBUEv8VMrJ+baaUR2zE8dwbIWevH14nRm5EQvQvFG4BcAqHNh4nsk2zWor20zAYmnwBAUL0jR2gDZenkBN2LLOTscOb4kXchune+g5o3CD93b/6g3Vuc3HPW5W33rzRPcGmZRhQC0kjiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(4143699003)(22082099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGMyTCtBZ1kxUi9RK3BVMXR5bzY1RzlkZXVZdkdFSTFmS2VVajVNY2NHWDF1?=
 =?utf-8?B?QWF3VVRMbXlTQVVLOVJTMWdrRngvUnFta0JDUzJiMVl5alNmRzdWZzZwTExi?=
 =?utf-8?B?Y1lvajBMT2kzWVdTNVp3MHFEQWZtaVNrSWZ5c0k3WXdmeGZBTlJjdnR0TG1x?=
 =?utf-8?B?Z2NhR1o1SlJ6TG85R29ZbWNOOU13K0FHbWQ0dDdCTG5VSm9WbUhwSGdybkZ0?=
 =?utf-8?B?NjdaNzRhWGlhb2dxRjd1Vlpzc1pGSUdTUW10YlZqUFJuKy9TU29mc3YvdVRz?=
 =?utf-8?B?WWVSLy9TLzd2dVlUVWZmZDdnNjEzOGthdnVuL1NLdTNVQlJEaDZsZEtRelkx?=
 =?utf-8?B?UC9VYlpPUGs5aUU4UElMRmM2QzFENlZrcjZpNHROMVZaRVF0ekF5VjdJS0ll?=
 =?utf-8?B?SzRWc21DdjJDZXJsQXBYODhxZDdkZmNYaWpqbjNDYzFacjAvL0tKeUNuODlH?=
 =?utf-8?B?RHo4cGM0aVBvcnVac1FVT054cTNZUStHNjFjKy9GT0lYeDFiWG1QakpIT1lu?=
 =?utf-8?B?L0owZW5Eb1dITmtvTUJNakJlVEwwajZBaDJ6MU84K3I0NDFENlY4eFM5cFBF?=
 =?utf-8?B?SXJWR254dG1nVnZGLy94MStEbkdZVnM1QVRydFFKa2FCVGlFREthYWw2N3Y1?=
 =?utf-8?B?TEF3dUR2ZVplZU5UbXdJVUJIaUxUM3VvVWZUVTVtUGYvYmRCK1JlcFNWUWFK?=
 =?utf-8?B?bjZOWmE0RW5idExiYUcrdks4OCtGYkI3MzJaWU1uUVJXQW1ROUcvRTA4SzRn?=
 =?utf-8?B?WkpnVDVPNmRSRERmVnVPOHF3WVF3V29MRVo5K0xGVTZ3WUJKTWF0NUNTT0p6?=
 =?utf-8?B?Z001emVsMytmWHNuMjErWWw2VE1yOUs5cWN6VCtYT0Y2ck5EZm9Ob3JlWGFI?=
 =?utf-8?B?WVJqWW1zWTI0RTF0NnJWMElqWUFNTktVVkZuT1YyakFwTXZrUmdvZjRDRDFq?=
 =?utf-8?B?eitCNFp0Y1AyUFc4UFNIaU1JU2xub3NTMkdXR0h0SmNiOXhrVHdnNXdPMzVD?=
 =?utf-8?B?Z0dZY051bTBCUS8wcnkxMkhTM0V1MnNlOGptQjd6TFoyMXZWSFpkTittQUxO?=
 =?utf-8?B?QXUvWUtaMXF0cnpvelpsZEhTZ3RQMzh6Tzc3VHJ1N01vckdHcGxXUFp3RzVR?=
 =?utf-8?B?b2Y2WDh3RGc5ZUVDZmorcUN3dG5XdGtRNmVwOEZHQTY3TU1RdEdTcm83dzNC?=
 =?utf-8?B?Q09NMkgvLys5MVhOZ1hLaHc2S1lHMzMzL0xaZ0hna0ZhN093TUIvazkwR01G?=
 =?utf-8?B?MVlZOWRva1ZqTmJKTmptUmtMUnpOaVNpZitsKy9QbGxKVWZDR1FFRWhham96?=
 =?utf-8?B?NDVIbGtFUjYwRXJIbEJvdENOd1JscGxGb2VDRlNtVHhFbjgwOWNaaEJHS21Y?=
 =?utf-8?B?YUp5SVNHTHdVYzdEQlZKcFhkUGVKMUlUa0hxRk10eXUyZThyQ0tDc3ovTmNQ?=
 =?utf-8?B?QnZYdHkwRXJ1TlhFa0pqblZhMDJDaHZ1c05lQUFVTXdLbUZ2ZjN0c0VuWkZK?=
 =?utf-8?B?cmVlVllTTkdyVFB6bzFnS212MEpOZm9seVVmQVhDYzd1MEo1K3FJbWFIWmFx?=
 =?utf-8?B?Q04rcis1eVZCY29mQi9jQ3hsa1FrWCtkdm8zWUdBYTVUYW9jWkdBM3JncGdu?=
 =?utf-8?B?OGF4L1NneGxhT0NGTG5RaStndWRRTlJTY1hzVUIxMXdyWVBrNXUrRk9oMFdn?=
 =?utf-8?B?S2hYU1pBWEI5WmROSk03K2VwWHE2R1phRTR4NGRXSlNRRGJEdVJOSU9RQXFD?=
 =?utf-8?B?dHFZaDNLTDlHaHFIampiWThsamFVNmxPT3JiLzZuOHNkZEkwaG5jTWxuSVI2?=
 =?utf-8?B?a3hJMG0zNGRZalh5RXNiT01MN3R4ZHZZTEJqZUVSZ3VzaGluMXZFTVdEMmhM?=
 =?utf-8?B?SUdmOFRUT0I3Y3ZSa3NaMkhuaWdIVG5CR2dXSnlDQjNsd3k3REtIT3prNnFl?=
 =?utf-8?B?T0ZzMUpOY2RDWVllOEFiUjc5dXU1SFUwcHpvL1BvOFkvYkxVc0pRWW11SHg1?=
 =?utf-8?B?WnhiRHdYOVgyQWV1SFhyN0lEUUFmaTlZRTNFY3V1TUdzbUhFUzNrUy9Qbndt?=
 =?utf-8?B?VzUwSmg5anltdnB6KzBsVGFQUUE5OVdkZFl3dVFsR3FocDhCMTlwb09md1Vh?=
 =?utf-8?B?WEpJTkgvM0lwMWVJRFRXMVozazZEcjJZdHM4Y3dIZDR5N1hPYTJIU05uelZH?=
 =?utf-8?B?bVF5RXN2S2pmMEtnOC83R2tMa0lLMkNCL3drMEVWbGZibVVKbTRlT251Sytu?=
 =?utf-8?B?dDE3OHkwbkZrMWJRNTRDSUY4a05JNmhYSWR1dld1NnFVeU5mNWxtN3F6UE9w?=
 =?utf-8?B?LzlneXZlbFN6M1hNYXBiVmgxa3pMdnJKVjlIVVgzWnBvWTNhOFhWdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004a6235-bd24-4c6d-d5f0-08df4ac88c95
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:48:52.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwEWMCJA2t83xNiZcwnqnmMyAtqcR5DwXZP9mE7QjF9yB6SkYSCWEziV2aKBTiaKEaJWX7qTK9uFnJagn2H0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5827



On 23/11/2026 3:06 am, Kathpalia, Tanmay wrote:
> 
> On 19-11-2026 15:15, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> DDR50 and DDR52 have no CMD19 tuning, so the SD6HC extended-read path
>> relies on static PHY settings. Two things are needed to make it work.
>>
>> First, PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) was left at 0 in every mode.
>> In extended-read mode the RE# (rebar) pulse is held high for half an
>> SDCLK period, so its width in clk_phy (sdmclk) cycles is the SDCLK/sdmclk
>> divider / 2, and the field must hold that width minus 1 (0 otherwise).
>> Leaving it at 0 in extended-read DDR duplicates one DDR edge and corrupts
>> reads. Derive the width from the clock divider so it tracks the
>> integration rather than a hard-coded value: e.g. 1 at divide-by-4,
>> confirmed on DDR50 hardware where 1 captures both beats and 0 corrupts
>> reads. The field only takes effect when the fabricated phony DQS is
>> selected, so the computed value is written in every extended-read mode
>> and clamped to the 6-bit field. This timing model follows the Cadence
>> SD6HC PHY documentation.
>>
>> Second, the remaining read-path knobs need board/SoC characterisation, so
>> read them from device tree at PHY probe and apply them in the
>> extended-read DDR modes (DDR50 and DDR52):
>>
>>    - cdns,ddr-read-dqs-delay: read-DQS delay as a count of DLL delay
>>      elements (each cdns,delay-element-ps wide), written to the 8-bit PHY
>>      field (0-255);
>>    - cdns,ddr-no-lpbk-dqs: fall back from the recommended loopback DQS to
>>      the fabricated phony DQS.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Changes in v4:
>> - Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
>>    device tree)
>> - Derive the PHONY_DQS_TIMING rebar pulse width from the
>>    SDCLK/sdmclk divider (t_sdclk / (2 * t_sdmclk) - 1, clamped to the 
>> 6-bit
>>    field) instead of the hard-coded 2 clk_phy cycles, and apply it in 
>> every
>>    extended-read mode instead of only DDR50/DDR52.
>> - Dropped the cdns,ddr-phony-dqs-timing override.
> 
> In v1 you mentioned that the modular SoM needs ddr-phony-dqs-timing
> at 0. With the override gone the driver writes 1 there at 50 MHz.
> Does DDR still work on the SoM with v4?
> 
> 

Hi Tanmay,

Yes, DDR50 still works on the modular SoM in v4. Dropping the
cdns,ddr-phony-dqs-timing override leaves phony_dqs_timing at the
derived 1 on the SoM (same as the other Agilex5 variants). At the
soldered-board read delay (96) that does hang the SoM on the first read,
but the SoM's phony read eye sits at a much lower read_dqs_delay, so it
only needs a smaller cdns,ddr-read-dqs-delay. Sweeping it on the SoM
(phony, phony_dqs_timing=1):

     read_dqs_delay   result
     0                pass
     12               pass
     24               pass
     36               pass, 2 data-CRC (marginal)
     48               data-CRC errors
     96               hang (first read)

So now the modular DTS uses cdns,ddr-read-dqs-delay = <24>. In v1 I 
centred the SoM by shifting the phony strobe (phony_dqs_timing=0) at 
delay 96 (follows other Agilex5 variants); v4 reaches a valid capture 
point on the SoM with the read_dqs_delay knob alone, so the extra 
phony_dqs_timing override was no longer needed.

Thanks,
Tze Yee
