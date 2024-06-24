Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2011.outbound.protection.outlook.com [40.92.103.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594191B964;
	Mon, 24 Jun 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209921; cv=fail; b=gw5CrSaM2gqLjZi3ncoucFR4O4OY/gCN+QQG7NXhQC9mtdQze6oTqH6wlTYud9qxUL9v1MtFukECEAPqjJR5eZuCEmf9w2eurV3TkNqjVtEbZZRhQVSfTg0RjyEgO1WiJimjV/7YsGLrh0ukEJGwyx9mjpJsaMBHXBj6eXs2aOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209921; c=relaxed/simple;
	bh=oigBsLUKCt64VNyb660WA1uzBgsBXZ3mE6pBqbW6Z4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXdNjhXKSY7daxIbfCA2I9R2WmfBT4ALKTanYh/N64n0GuVnEeblM0YHfEFvlFheVQ+mbu9kr2tXgvSHXqsIYSGiLiSSpNSgDKSOPiy/IrtRUAzehm2V9yWjuP6g1Jrg82d0ocaH/Un2rqVM5iZZiluo2ZDg90zoVCf/T49YefE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XJelGkza; arc=fail smtp.client-ip=40.92.103.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XJelGkza"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPRzhxCKFmvAKJhdfy+awC/7e0JcIa+z2VbzjKjRLXwFceaKy2ODTq5ayVeRWKkX8Ya6r88HOluMMutXVue3uBt8xIy86hrL9BFOEyXN6L6HCHgjpB7tLxxuyawje6ue5B5ij2kV6s4ysn52jZygcW+/tBEzrMbMZTD55MBVHQVzcght+OJqMmwSIxZUaOJrDRfKoTx1jJtPpSl3MR7aRl7Ehz5x89S1OvGSjlcraCvamAZv3V3NGTrJCT/a27+oqq1P7eto8JuLDP8uvg0JiEVd3IehuDXvBRgtE+oM4GXPFxPgHK3B//xdfxwIuvjyBIM5Ge0tkS8YkYzscagROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMpxtLq1uACX48KRZXvxIm9ebdjdm2ZZlVEt4RWT6+0=;
 b=NgzkLh9tklfWlRxj0E369VazjHuYPWWOImVaW1DT5hV86/7K5F3nR+rBvYqv11uP8yaHCzya6GTRGolkjjan7m/rgy+eVRogSk0L3/ul1we+of8Lav9iqo5I7/eMgQYZJcpOXp1R0XF1cZdqt/YZ4bka6je2o6rHkRx+lSE5m8glLcPZZjtde7TnxXsMKvZaH9p5YcByiiyCJLetb5lugb0JgrQYgGERkqXgWTqd38V65UBECnwzq3idFA8FUiiOuc198ypYthUVLeoLAwzgAKscInHdWnQTMg7s2gIYA5WIEFQH89NV7nK5aNRnPEY4fzF/9F1D6Z+to5R2bjSKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMpxtLq1uACX48KRZXvxIm9ebdjdm2ZZlVEt4RWT6+0=;
 b=XJelGkzaSTSHO+i3g/u7aBE3oBZVxZqysvFNzdP0EBEHpcsc+InBMMHl3DQfSDPzptUhSzgWkuuExjWbDAKdaLxWXnG1ywBfE1dx6wEXmbghhNhUM6KQr1UVSuKBcSH7DCOb7OS8sDL0W4sOCPQHm+mqSHRcXeR10OU0BrHzDmWm49m9vx3cMph4SEMKHGB0oAeGRvKwMkpTbtX8dw8jg4W/XtMZuiPrQWEseYDsJMmmK1Fx5g87uhUPl4gRsbtRO954GpQP7U3v52CDvVLxTKf2FcmjJb987EdTNQ/HlVSLynWQ79Zfeek1nfXeJbQEIJzbuDKM0qsw8ugvFFN25Q==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1617.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:18:30 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:18:30 +0000
Message-ID:
 <MA0P287MB28222A858B3AEE69925505E3FED42@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 24 Jun 2024 14:18:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
To: Jisheng Zhang <jszhang@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>
 <ZnRVkPy5akurmi_D@xhacker>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ZnRVkPy5akurmi_D@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [L5wF9kl8CJPAy4EeB0CRP3JxcisOqSrf]
X-ClientProxiedBy: TYBP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::31) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <dd4f176e-817c-4713-8893-c0c7d001abe5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf8b0b5-c355-40bd-4d88-08dc9415768b
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	8l660ChnYY3yzO7/8qdsxJF7bLaUtfBqWmIrDbD9dos9Eb2h1OB4X/Rr/k9Ywa/MYKMa3yAEB4BQnoGLTqih6blpKSlqiHLsqEK2P6WW465vZDVSEfAHMXJg2HF2O14kEC4To9nt+TgVYCqSHa9IwrUYwtkYy4m8ZjcTPo8aAQSQ8VZkQBjd2FhTRoR4jDXnP7XY3fMLflw96ncGUx2tbbGy8EgCs5+sb4ZQnQ6aD4K4y3UJuBLucsZQ1cUO3ul3S5Mb+WKV36o8yu0zlbuZ/Ik7PT3+XWSWA5+sf+fD+fBhhqxmhuJPC4fqmXBxafYvD5H2k3ypgyb6xM9h8lACnyAgXbO5JXgunkobjuDWvP1a3A3IKaBVZZE5obmnlznquie/8KliQbK9mE0OtcvsBlfgoRvmSZ622N0KsMLMMPO2QQYeXzWjoonENTvXoNYluV5/97isT5oT9LS1+Sk5opZzCppgsFgUKZHw9prOgqkgPmDnUPAxc79+JC7OddmiWdHd56pmc8AOKPC85muE9EyFq54Q19Bub4Kbc9pibqW74Jan7oMiH2M+TT3TNbTd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElwS0NycG5YRlQ3aVZNUTVGZWIxd3o0cFpPU2N3N2NWNGM0eGhnbk5lWVFM?=
 =?utf-8?B?SzZsbmw0ZFI1bHpYdlI4aW5kSG95RjNGMko5czVnc1htVWY1Z2kwbVdKRVkr?=
 =?utf-8?B?M2hoVUtWTlZzYnhpR0VpeEVJRHkvM1M1TFRLUmxWZXFtK3ZvSXdXeHFhV21D?=
 =?utf-8?B?LzlLTWw4SldUdzZ4SVJ2SS80eUlBV1krOVlPZkpXTnpHazJXYTRhUDh4OVJp?=
 =?utf-8?B?YlFSSmJSVnA5bnBJN21YSHVIc280L0lSeG10R3pUTXpEVWYrbmZQT2gxZjF1?=
 =?utf-8?B?eFhpQTRqUW9ONEZDUzROMlNDczRTK0JiZWNmWFF6UlRDYlBvMkY4SWNoZE1t?=
 =?utf-8?B?M24zUVIyVEFSenpkeVRxbWNGdG9SWGIzbnBXNjVHeHdiUUM4L2QyK2wwaE5R?=
 =?utf-8?B?R09lVUpDSTYrZ1NrWVY1WEF6MlM1R0ZqMlhxSHRqSmk2UDhJY2g2K2JTcGJY?=
 =?utf-8?B?cTBTV0NCMGR3VHVjUUQ2d0Z1ZmExY2wxd2xnUWhxemEyeW5WYVEwTFduMG1W?=
 =?utf-8?B?cmZpczcxTXFMc2Z6U09WRFVaK2JBWUN2MXdtOW83N2lLQnpncXEyWStKWHVZ?=
 =?utf-8?B?eHhSRXZSdElBWFBqSkhDZkFFM3pkdGlUUGU1c0srTHpIMDBtdEI2TUplWGFz?=
 =?utf-8?B?anVzTnMya1lzQTVmQXFZUFgxSW1Zb0Z2RmQwSUVieUJWanV5ZS9oSWFobnNT?=
 =?utf-8?B?YVhSbDQrYjdVbVN5K1o1U1BhNjNQMHhEOWwwR3hPTkw0MHEyYzRTQm5tSXdl?=
 =?utf-8?B?bzFnalNtKzdON09tS2xva29wSVNjcVRDdCtYQ3BCQjYwbTNrRFIrTUJFL2pp?=
 =?utf-8?B?MTFKY0VnK1NPaXpqY1ZwbzhDamNNd3JORFltVVFlRWZkU004cXRvQ0ZIOHZO?=
 =?utf-8?B?cDExTGhFL3VXTDR3QVloa2pFUXBnQURDQ3dSemZXSURMTFRlTEZCNG1zN0hq?=
 =?utf-8?B?cTRMZ2tQMjF2T21Td0FocW9UMlFZWDZmUEpJbHNyMFFjMGpQa05aTVFDN0dv?=
 =?utf-8?B?d3prSmRaZWxMUmJKRE1mODFVV3ljbVV2ZGV2Z1E0R01XNFJuelZ0aWRFbUZZ?=
 =?utf-8?B?Uk5IL3pzK2hqcyt2VUNwUW4yT1ZYOTNmVFhPdTZVb2pDcWV2Z25qcS9tZGhE?=
 =?utf-8?B?YmZTNFpXcVhSZzFFZnRjUkdoS1MzSmhKOTBIQjlkMmZjcld3MjBweHRMRmk5?=
 =?utf-8?B?bVI0aTc5OVpaWjEycmpmVTJDN29FUC9xRmI4QU1NNEJBMnBIaDN0RC84QXMx?=
 =?utf-8?B?eWQ2S1NNSGYzTVdMMU5sVDBCWHBQbzlDM2xCSTdBbktNekUrTStCQlVEaEtq?=
 =?utf-8?B?U1lkYWF6MUh0WEROMlJtanlDKzBEUk1zc0E4VWYrbnI1YUdsTDZ4NTd0SVRq?=
 =?utf-8?B?YXNJK2J6azJNaGFycVY3dXFxNzhRdzY5bEZQcXZEVXphQTFYclRCUlhWdzR2?=
 =?utf-8?B?U1ltQkNyZk12V3NsNy82RmZqYXFORHhvWVh2amJBUndGVHgrL3d6ZmRiL0VJ?=
 =?utf-8?B?WDJINGRrUDY2VnUvMmlvTkZONVcrcktlbXpSdis5VE1pZnFnZzR1SkZ0azJz?=
 =?utf-8?B?V0l6Z3doQlZBclcxdHVpOHVoOVNnRnVaMUFVNkIweS9xNjUzNXdBU1hJUXJp?=
 =?utf-8?B?M3dlTnBtOTdiRGo5NWlTWk1SYk5DblhVRis4NDZKK3ZCUlFnSWlDY1FlTHB1?=
 =?utf-8?Q?KJmnP8gZM9Sp6AvEfwZE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8b0b5-c355-40bd-4d88-08dc9415768b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:18:29.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1617


On 2024/6/21 0:15, Jisheng Zhang wrote:
> On Tue, Jun 18, 2024 at 04:38:30PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
>>
>> SG2042 defines 3 clocks for SD/eMMC controllers.
>> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>>    and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>>    source, so reuse existing "core".
> No, this seems not correct. This should be the "bus" clk, and your above
> sentence "aclk/hclk(Bus interface clocks in DWC_mshc)" implies this clk is
> for bus
>
>> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>>    existing "timer" which was added for rockchip specified.
>> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".
> I think this is "core" clk, no? Plz check which internal clks' clock
> source is the so called EMMC_100M/SD_100M.

hi, Jisheng,

Just want to double-confirm, corresponding to the definition of clock in 
the dwc-mshc specification, what's the "core" clock in the 
snps,dwcmshc-sdhci.yaml?

I get following clock definitions in user-guide of dwc-mshc 
specification, in section 1.8 "Speed and Clock Requirements"

- 1.8.1 Bus Interface Clocks，which are aclk and m_hclk/hclk
- 1.8.2 Timer Clocks，which are tmclk，cqetmclk
- 1.8.3 Card Clocks， whichi is cclk
- 1.8.4 Core Base Clock，which is bclk

I used to think "core" is "Core Base Clock".

[......]

