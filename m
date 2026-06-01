Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344F35F615;
	Mon,  1 Jun 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314873; cv=fail; b=hSsST+1yu3GKQi9r/GNyEEofVlIpIIhZWZ23vf4vU3ELoE8oytWG6J6U9JjNDdSFJ4hWUgEzvjd7xKAMM/y1YMpcQdIpUCF2SN47l27OxK+xg/GFtX7jWN+l3IQ2ESBN1IZ34skuCaswbt7vPpJaJNeuc7PetMw79Bub4fG2kyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314873; c=relaxed/simple;
	bh=9iOuElU3ta0oQumnD4vZBH6pG/XM3lmQVzVhu4Z9UVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uFJAFSeznGY4G2piD6/KP/IqpZocJ2eMuyQq7+Ile1CC+UQFHVbPhI4m/s6JPLMzFx04O0TrMn09zG4S+frib89epSpNRbliY1DiWW8sIZrPBZ5bAjhF6sWqcsEwTSCqWMXIH3IgHUeva1gOjZPM6FYm3pBBQfUba41zDAJibVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MIc21KKs; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MIc21KKs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq/7cZif6IeggbrjKBUdsrbhLEU2TwbZzIj7z48yphD+TEUbgEybZPC5U280cca0vc2H4NLNgGe0IxmmHFM4lKEP4LM1hBns4CX9R2ox3IrYcv4niIdgQ+/ooD6QGL4PhGlZSoKjvgLCTXt7FXkCk9ZBMyzpcHjoexuRlhDbykIezjRaliNDDdw9EG7nJV/muH7GaJHSsIidiCrYwxNFVjom9YxkL/RgKcfrcXQy9XI1Ahh/aNzJ/bbs0uwpAD61w15GfWKXBex5x/7rAMGFDyn0KuOCquh1PDRyF0x+WcdTdn/kmzshVvEutmK/Jn5cVE2NI/YHY26kNnmZdDZsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sx8129ZjiI6DqEjt0FVV+4M/Jfi7Op7TPV15lv/Z/8=;
 b=SImfvxnlo+mGuS5l1nayt3r8L+eMyxSJSW1jquPTHYBMIG6SXZ6v2MFe9mIeb+5AqBI+D1gzl9hgZcN4BUlH2M9wQ4PGWEAs8EqCxQwzijaQ6bZsSV2IMBhE3IpimqpTqEMRnIOyFSJ7uOlZP7+jizuHOisI2odtX7uVzGHCwbqtBSuzNKcCm6+qF0pLQ5BgXzALbWDGawHX/JGXYS7XcbQN3pkaNj6UcIuSQJmfjV+ZRBelkRV+3gPzJJX8YjW49zo89AgCreco+3yYtQVd6eAHYN5b6rUdnBini2cBS0CgjLsWtyohM0eZ7yt9gaJ3OsQly4ifIjPMoCT424WFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sx8129ZjiI6DqEjt0FVV+4M/Jfi7Op7TPV15lv/Z/8=;
 b=MIc21KKszZUSUoB0SK5XrmO4M4t4O9AwwjgAjWBjAS0nNLPaO3yS1oWB2fW3tlz0cZ5vqwT9ITU691QW8hhDUJkPfbm3VBiEMbKmPUe5D0dxdKqbWKakhfJe7+fVRoJeP0TYpfVmFcabi+tDYTgpxMFY2dCcyozd8EUr2KxaizdvJimVdLyum/U4HabcoH5ODzD7I0CzCu6fYQnnqXexolPI1Eyn5/wbW87FmZxIcArg0BuoGuNdUk9fsMoL7s2eXgsgG2NLfLjYpa1dly8/KZ5UgYZnfywp6I/eZivv4gSAxze3gJtrXFWZJ3Y1uua8Od81Ta+XzUcdkOEYoilI9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5470.namprd03.prod.outlook.com (2603:10b6:a03:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:54:30 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 11:54:29 +0000
Message-ID: <7669b7a1-5255-48c8-b3a9-2aef2ecb6031@altera.com>
Date: Mon, 1 Jun 2026 17:24:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
To: Zach Miller <zmiller@criticallink.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-10-tanmay.kathpalia@altera.com>
 <20260527210112.GB27846@criticallink.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260527210112.GB27846@criticallink.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa26f20-befc-4c16-55a9-08debfd48985
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	fOZjArFNmjk1nyBmChkXx+S8eM52Dt3yZLh2tsMJA6pwqz0Z3PpMdarwCv1Qn/q271AVVxBBqvMZJAuZ34Lxv8+UcRgBQP1Hbvxi4EKg9GeLiAnl7gKXgEcCj3HrOWQQcBcsK9ySdqQ4SDfNn0OGXvEMTvYvEcIZazc0F4WzrhuzyUY+MWVB/Sfd1k77j2Gko3fh5MyIaPyj2zi9zm8O6SNnl3Z8pc1rYa6rV+UF2JTfkhmhuRU6nwNo0sdhC7iGFo7g4MYrAw1v2LhJ3qPndrrLz1se960+Ox5ri/I/JcT4Hf54p5iFBg2p3yl0XUp47HvuujNnnDWbmosLDWxNEXd6GzQc9IT9Bwhu1ry58RUbKzEHq0h7KEr2nNilkWLvU0FzIHsksfnlgUouVTYABLNKAmszyG+VWv+pqaiIleG0Hs57tToHR8aKckfsoD5up+XbwyYuGA5Wmlm+IjJqQk7JtAUahBY1wZupyzXejaJchqaXJ0HmoRa7gzfvJCBeXKTeTBc2q0DyQp4Cx7cjv6NRwZ8OaLFFPW9Bc1JVZqlmx9PrGGe+C9MoZ8CQZcGMHl2TKvhrJKTIzd1IO05e9R+if0nUjpVj7JD3SYX2l9zml3gwHbfsB3RbBJraSYb9GhRD/MbWOzdl4+npifliSYUXXANoysuwbr8WB0q1IpM0n1du69He43u6Fz/StZTk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZmQ21nSWJ1SjJVeno3ZGRxZ3pTVXJVM2piSWwxWWJMbXcrTzZvSWNaOW1r?=
 =?utf-8?B?QzFra0RhemwzdlI5ejUvOHZmZXJYVitpbmkwdCtjbnpIT2wwZ1dJRFMvUWp2?=
 =?utf-8?B?UFZrUzk1OFRNWHQxN0hWWnY3bzlSZlNBYmRUeE51bmVVaGIveTF0WUQ1NUl0?=
 =?utf-8?B?T0N3alBDM0dXY1NuczJkN3liMCtaclBjYUVVb2F4Y3Mzd1U4TUtQR1VTM2h2?=
 =?utf-8?B?K0F0cURKNUhnN3E1b2RHR09nZVNVVTMwbVRUcThyS2VEdGtua0ZmSklHSm1L?=
 =?utf-8?B?WDBEOEZUcDJaeVA5TzQzTzdDejJmSGdHTzlNV1A5Vkx1Q2FLRFNhYVZPa1BR?=
 =?utf-8?B?TzhxKyswMjNKZVpBWUk3bit0QmY2eExNN1poanhEWXZUSjg5UmpWQzg5SElT?=
 =?utf-8?B?WGF0ZW13L00xZ0VheTQxa3JXUTRkNnU2anZCOE8vNm5FZ0RKNk5qRFNZY3Ns?=
 =?utf-8?B?QTQ1SmpVSXZ2eVBkeitQTi9aSmY3Q0x6d1JxWXZCemlIYksvcFk5SGd4YXJW?=
 =?utf-8?B?Z05QeFkrSDA1cVJIOWtCMmE0WkpXd01PWmtkeDQ2MzZQbGwwa3NIRjlLVkpa?=
 =?utf-8?B?M3JRN3FTRnZNUUpvRmxtZmtENndjakllSXFhWUtSUk84RGEzaWlycGNRdkFp?=
 =?utf-8?B?eDRSY1FOcUxDY0NoaUdqWlc3U2dzSHBvNXNqWVJ0OEFsK290MDNGbmtka2x2?=
 =?utf-8?B?Zmk2T3g1WDNpeGVJa0ZJd2RuTDA2RHIzMk01eWNGeHBqaW5WQjJNWnRtcExu?=
 =?utf-8?B?M2dUZGhOWWNZd1R2UXk1blFMY3NZSnFPUkk2aGRHNml2TGh4L2lNWEF4TC9D?=
 =?utf-8?B?NkkxdFNGZ00xVXY1SDNyekpKb0RQZGJWNmFVK3o3U1lQV21HbURYNytJZ2pO?=
 =?utf-8?B?aGtXbXY4Z0VWU2xwcFQ0dVZYaXM0ZlBjU29SbEVkYUF4SzZqZGl0K0JyWHda?=
 =?utf-8?B?VytkUFNPa05FbmhSY1RNZVBhRGhMbHFyOEhOSDdSeDVUSVhRbWZYUFNNMzJW?=
 =?utf-8?B?SklhdWVkZklOOStJa0gzaVZsREtpUGpaemcvZFZmSXpMQy92Tlk0YnJjWjRO?=
 =?utf-8?B?YmVYL1JPWGJ0eWx3MHBWSkdJQmIvdStzRzA2N3R4RXBVS0JvcEV0aC9XUWNh?=
 =?utf-8?B?YitEYjZXVlI1UXVRYVF4amROd1ZteS91NXZZRFhUQW9VYUlsWjloSUw5UTJS?=
 =?utf-8?B?UUx3enlLbzFpLzdubHlrQVJVdUJRNDhWVndFT3F4YTFyVTc0SUk3MzlRb1Mz?=
 =?utf-8?B?NVg0eEFqZC9xb2pWa1lmSFZoaHhPR3R6OWdST25RSEdBbk1rNGw2eXQxT1lE?=
 =?utf-8?B?OFQxemxLS1FNRkpROWtWT0ZNM0dVSUgzdDNOdkczOUY3K1ZxNHVYQTI3RXhO?=
 =?utf-8?B?YzgvelUzTEtiaHhONDZaQWU0bGpFcTNhRENhUnRZYTArR2ZoVVc1Sm5xbE5J?=
 =?utf-8?B?NEJyYkw0WWtXOTRIU1UwalBaU1NGRnZqQ3VwVWlrRzhnczNFZ25JOHFReHlE?=
 =?utf-8?B?c2tKOXFrY0ZObGc0d2pZSWRrUDQ4ZHBxMk1YWXhPT0NRbVQrVXI4MVlpdFh3?=
 =?utf-8?B?TmxMOXZ3cm0xQVdMS3RYNzluY0hvbHZBaGliRUx1NW96enBGMGN5RHNjd0l1?=
 =?utf-8?B?bW1iTmJXTUk2SXZ1ak1uaXNmUmZNSDZtMExHZXQxUE9YSGpCNVFEZUF5QlVH?=
 =?utf-8?B?OCtYcUtMM0RseElWZFdMdURDS3R5eFhvd3c5WDFVbHRyUldpcitpRFZsMDhl?=
 =?utf-8?B?NHJkYjc3WUs5T3FHL0JtKzZ6ZkYxTlFMVDNyOGQzQ28xdDVCd3hlOThOT3Yv?=
 =?utf-8?B?YmFIbHlQNTJBcmp0NzdrV1dKZVI1c09MbTNvME55dVpRaE9hUkUyV0JVd0hM?=
 =?utf-8?B?anF5MG81MmdEVTVtRk1xSndYUFRyZ2F5ajE3bm1HRmtObkRYNlh5bm5ZZXZp?=
 =?utf-8?B?RHIxTnFEUmk3R3VheTA3WEVCSDRkYzluREhtT0ZmVEtHWlNvSU9DNVRKRE0y?=
 =?utf-8?B?VkE3V1k1Y2xhcS9LUklGSGp1WkF0YVNCTzhSTWNmOXBoWHBqcDBtekIwTnJu?=
 =?utf-8?B?SmwwNlVoWHp2UFFPVm1lTFVXeXI5OEZuN2FMTEgvZlFQWDJhd0F1NjE0SGRV?=
 =?utf-8?B?dWxhWnpZQy9VT3dXRnFIL21UN295MnNXOWI0WXdqNWJjblVGaGJLOGQ3UjEz?=
 =?utf-8?B?T1pIR05vaFRCVWNKMVhlbDhEeTA0LzB5M2JlbWlCYU1mL0JyWnJVVnEva2lx?=
 =?utf-8?B?czRHQURORG1wVUdialJBL3NmVGhxOXNOMTlXSHhxNlo0WWNON1lpbGJSemFN?=
 =?utf-8?B?dlBtb2VPa1hNemZlanJMcTBadlc3WEZVQTEvanRibWtwMGJReDVJaTBwTjBB?=
 =?utf-8?Q?D5W06uobPOo0RDf8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa26f20-befc-4c16-55a9-08debfd48985
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:54:29.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0Hd6JNzz8cNyau5n00AnxiEDyT6u/U4UAyInzpOrgQ7riCgHVp9gZf318wOkviH/EaXYzyDkOgI8EWYmltkg0FPB2Dc/+c1MLUuJiXgYqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5470

Hi Zach,

Thanks for your feedback.

On 5/28/2026 2:31 AM, Zach Miller wrote:
> On Mon, May 11, 2026 at 01:21:31PM -0700, Tanmay Kathpalia wrote:
>> +static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
>> +	.set_clock = sdhci_set_clock,
>> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>> +	.set_bus_width = sdhci_set_bus_width,
>> +	.reset = sdhci_reset,
>> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
>> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>> +	.hw_reset = sdhci_cdns6_hw_reset,
>> +	.set_dma_mask = sdhci_cdns_set_dma_mask,
>> +};
>> +
>>   static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>>   	.pltfm_data = {
>>   		.ops = &sdhci_cdns4_ops,
>> @@ -506,6 +544,16 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>>   	},
>>   };
>>   
>> +static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
>> +	.pltfm_data = {
>> +		.ops = &sdhci_cdns6_agilex5_ops,
>> +		.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>> +			   SDHCI_QUIRK2_ACMD23_BROKEN,
>> +	},
>> +	.dma_mask = DMA_BIT_MASK(40),
>> +};
> Would it make sense to add SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and set
> sdhci_pltfm_clk_get_max_clock() as the get_max_clock() op?
>
> The clock rate that function returns is already the one being overridden
> via sdhci-caps in device tree in patches 3 and 5. Since the
> infrastructure is there, it seems nicer to have this managed by the
> driver rather than requiring users to do it in device tree, especially
> because the clock rate is user-selectable via their FPGA design (so it's
> also a bit different from other caps which may need to be overridden).
>

Agreed. I've added SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and wired up
.get_max_clock = sdhci_pltfm_clk_get_max_clock in sdhci_cdns6_agilex5_ops,
so the driver now owns the clock-base handling directly. The sdhci-caps 
clock-base
overrides in both socfpga_agilex5_socdk.dts and 
socfpga_agilex5_socdk_emmc.dts
have been dropped accordingly.

Regards,
Tanmay
