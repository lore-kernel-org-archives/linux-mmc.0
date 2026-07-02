Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A43A7198;
	Thu,  2 Jul 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983262; cv=fail; b=kvgjkWJ2sabYje8T8Z+lfRBEQG1qmr5FFvXA0itR5ZiwK0y5ru91eqV+9sddjVuANeDKIVWnfdCF8+VakUa2JE0JwUQNQgTlYxT4QpemDLgwI/qPHTNjYB/68BzDTTCcMgQSlspdJleqe4nYw61bH/jhZs06nl5ZXKRHK1t0mZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983262; c=relaxed/simple;
	bh=7+FbUKpXTW/NBLcU7nF5nXIFOrtOGV4JTos5x9rWQe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F021ff+rCcPsFdWwVqdnrCTU0+0f2BAuKskNnr5eXPDCl7jpohjc71uTYK52REdSU9h+Z45y1PjxpFZk2VKEn7pUv+d1uAB1HhjIEv7bpKh7Uk/R78SE/vRZY5MOBviLUGTQl5T4Wj5tVXWt6hQSCzzPcnm/3wmFfne7LGLl6xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VFsk3c6P; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VFsk3c6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6Urkj0BXPwxYfqKVs5MIt1tQigm5ldnaJuWDn5V96TRZhnzP6Vy8IBLVLPnuB+NFg33ou0SpaT8IsmyLmboxKNTSQ1uH10eCNDRxQIHNrtxiPCfbjvtBa4bnXFCjFJEy5npnVT3FzOSUe2MhTUUgUHx+Ebo59zh5Bc9e9dSo/3bvBePYDGDs1YmDjG2RGSeuw3UrlKuw1Rvw9xBsu3AhKEv41WxGH8RrXsjLDQDFyJga6exFcsqjbwX5OCidtpvEP+Qse6FZtFrONVIuIXJtFjHg/9ZU6fGdB1MPbSxkz+uG8qw9IZxo89SjsC9+QPk5s/14qnAgrouyfUvjIXEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jVGKQZM/Er/Ahf5j1pCkOWX+BfiaQ400CRSNdOIEE0=;
 b=lwwOX4pr19luWxSHzix1muMzJymkJ/BgVCFVzOne1CpMnZlnWKEEGCGBm3NY8esUWCZb6nCVztUGpO4rQmsHzvCKe2UULqHQdDPcAnwt7+O/z5cyRfLnxw9QC4FYaeo8e+wq3MiDBBLHuGWBv6d+JJ0eNOBRDiWKQYgAmaY0KF2pShZ3srtcQ7hZq3gCci8936Ug4gbwDb3LLJBYoPE+fxQeEKEK75le+FHYcDz1JVNy7XpVdM7XN51D7Je34r6DIHH1264pTnC5oVz9jnx3PMD+fSjQj+ozoKrDkaIn4HqP+XE7SC7t1D4sfe5VAp4oiJkj0AzeCrahFlb7pxSW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jVGKQZM/Er/Ahf5j1pCkOWX+BfiaQ400CRSNdOIEE0=;
 b=VFsk3c6P2l9FEsU2z9YWhs5RQMmDeYNj9wqHWlKa3+MUVu8KiLa08M/A3Z+8Dvf2XPzEfZFrhLCbjR6bBShv8kmZNhN7QCB7zCc89upGIqh8nk2HL8YZfA65FYFzUxUY9wlBK1+fsdrjT5AM+4LJbBeONFkat1ymGeSyK6j1dHNlY1noAmmMzfSL6Ttt2EOm8sIWC4AkZ6fXmQQxPijs06K7Wpff5rBehhR8u8befGcJ7GAR95eLHiy3G5LeD6LX3s+aR2r/PR1OgliVmFw1jj1BxoNKQMto2CQhaZrJXONYkPY5lMYZ3v6BvS6e2+dyD5noIUkLgWINEdifVz/MLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH0PR03MB6050.namprd03.prod.outlook.com (2603:10b6:610:bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 09:07:39 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:07:39 +0000
Message-ID: <75f7416b-c75a-4785-a310-b3ce2638aa2d@altera.com>
Date: Thu, 2 Jul 2026 14:37:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter board
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-6-tanmay.kathpalia@altera.com>
 <20260629-wild-dramatic-clam-80eb5c@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260629-wild-dramatic-clam-80eb5c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH0PR03MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 620fb3ce-269b-4edf-1a33-08ded8195de7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Wm6FejMUXkEhnlvmCRKbJwoO8lyJvpCSxl/GZkrQkLdYoQgIe16+Z3hDZ2iM0s9pbfigBKGV7pYI/OlG7M61wgcjvRKaKawuhIO9yvrIm9Q3kYWlH6oDwfs2MjXVg7p26ifKHx2X7tLdni046vtD5O4T1eObnrEPCAfxfPzd/2r91GFt3NxRPQ+KJ46EVTxQ18tf0tLHYv/3qGpLmIqLDPezG+bj5Lvn0FLQUU951XevkX9IF0AvD1VqthBYTnxEPKJCc1RwaS7huwti07blC6Yel9aU3EVivR3NjSc3Pil3uBqnNbMIYlupC+j1k7prdJmydejAZQonGQLOwaplWjiA8w6A+lT/5XIFpM8BmGOQ0XxrKgIGDCDhE5VGOu61g9Oli/AX3nBmDKQmMY8sCyVnKHZ35OU0r8lAxGrPHbL33NRlEawPJtkHX1OSaFttKumRW5AQwO3EQ//YnXAvivX3NPHwM8Unr/N9HNP5hRtfc/dvQti0IaqY74VVU3O/wF5RsCRVo/+RdSm2/IUWBU55AUfkd0UADrfPZt81nNLz1fSdzdw2KOThJNB8daYgjcAP1ttvBHzIp/wD+5zVi0NqSkW5iRsXa6b93uy3EKwojfKbKohIwGle/lkp9j4lvnm7afrjkqlB5nhYMNxTRL1KO6LFqJGooot1jAjFGUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aS93Kyt2d2pLd3V4OVFIVk84dVZGSFN4WTY2YU9MeWxvVTRMRkdMVHFpTWlI?=
 =?utf-8?B?dE1qZ3lCMk1BS0toZ1Rpck9OQnpoYkNuMWRJSlRjMkFEVW41M3RkQmFEcUcx?=
 =?utf-8?B?Q0dCZXdaVk5xK2JPZnc1UUljalpmY3FRaW0wdHNtNzlUMUZNbmlDOVJISnNN?=
 =?utf-8?B?eGE1TXFZbis5ZU5FVmxWZVlLVDBjY1JiNnkyNU5MT0g4OU1pbHVsdWVYeXBO?=
 =?utf-8?B?dG02NmN1T2dDNWRTbGxPY3VqWWNnck51b0NEaG5qUXpwbFRORkhOMUxsQUIz?=
 =?utf-8?B?WWExRDJXNGkvZmphR0puOUZmbk10TGQzS2ZOMnVMMytyNjBGUEZNUW5XcEZo?=
 =?utf-8?B?VmM0enRPdUFpMlBSZ0NQc3pueTg2T3FoRHRyUEkzMmVNSForS2Nac01sV1pu?=
 =?utf-8?B?aGo5bWRXdVRDcDBGT0hYWE9lSmhNM05FeklGV0lUeWNMRHJYVy9vQ0wvNHRa?=
 =?utf-8?B?OXJHMWhBRG84UTZkUkRHa3NNenZQQjJnclRGemRTaEMrWDVMbUFwSGhMTytp?=
 =?utf-8?B?d3J3Nlk4cUlmaWdyL1NmenIwczMyN1ZackJudythcFE2M0w5R2RjVkU5L295?=
 =?utf-8?B?a3lFOHV0c0lZVExoWUtzNjEvTEF1Qmdpa01GMWdRR1FFWG5UbnVjTkxzU1Ir?=
 =?utf-8?B?bTlzNmhtWEVwdDRndTZhaTFvUlVHdHFqWlZUUUU4cmIvRi9QTTJNdmxMQXZ4?=
 =?utf-8?B?a3dObkR5eEQxRUFlZml1VkwwTVhYZGZ6K2Z6ZnNKTWVtcWhtd292cUpWeVQ4?=
 =?utf-8?B?dDAwOTdDMzNVbEp0Z3o1K2xVVExqeG5hVUkrWU5OTnNZbFZhT3dQV2FvMmYy?=
 =?utf-8?B?R3lYTm05OE9UaldPNXNVOFIrWC9qMkRGZjZzaTJHRTNoZEtPSnQ0Y0VoYlNp?=
 =?utf-8?B?Qm5pc2cwOUc0UXNmOUU5a3V3dVRNaWltRkNIK29ZRWpSU01XNWk5c0tzVmV3?=
 =?utf-8?B?RCtRV1lkdW9ienNMMXVUQlBsMGN3OTZvR2g4WVVGYjErS2NpQlR2UG1yVXFW?=
 =?utf-8?B?ZDRjZFZmN0ZVckF1L0U4V1ZpSjNhTU9KRml1bUZJWFdvc0IwL0cxdllQRllp?=
 =?utf-8?B?Ry9McVhRYWNsT0R6cExWTUI5elQ0K002OGtGVWRkanlKQ0ZxUVF3WWE3UkM1?=
 =?utf-8?B?bjBFL3JOV3crZGpyMlJUdjFxNVpnNW42MjQ3Qkg2NnN5R1lxbkszbWhTNTVH?=
 =?utf-8?B?NTBGTTI4akl1SzNRQ2FwSmhCMjVpdGFHd0RSdUt4WnR1UUxIbmh6THYvKzgz?=
 =?utf-8?B?ODZ5Sy9xbE8xMlNRZi91Zm84Y1hISXVWYzZZZktlMFV6N2J5RGZtQkFXMDJ1?=
 =?utf-8?B?YTFvZ1UxLzhOSEVUVEVlVU5ETERTYVgxMzhWWFJaaE9qSFEvTjViR0hkZ3FD?=
 =?utf-8?B?NjZyMzdjMkZHeCtISmUzK0t2UU42N1lOdWZiQXVYeXBBWSs3dk1aUmNVRkgx?=
 =?utf-8?B?Vm1ITXJFdnFyempXR3ltb0wzUVBSNlJsTWJkTHFHRW9lV2dzWUM3cXliTFQ2?=
 =?utf-8?B?QzhuanBqZHQrQzU0b2M5eGx1czlvOThVbER2aWJGS3ZiaUVZeDcwUkFtcjEx?=
 =?utf-8?B?NFpNQ3lRaGpOakR5VDFZdm5NN2xWM09JWjdKRHE1UUxpaUcwZnZjMStRYUI3?=
 =?utf-8?B?ZE9xS2hVR3haM2hWQnlNNFlSU04vV3hOblc1TTdPT2M4RW9aSkZDektQaTR3?=
 =?utf-8?B?YXRvU0NRNjNhczF1SWJNN1dCR1BjZXZxcGhaNmUyUnBsS29aa2dUTzU3cDFK?=
 =?utf-8?B?RE9IRzczVmhMZEJDTC9zVERiUWZTc2pxSXg5Q2tYeHhjVC9HZHZ2WCtya1dQ?=
 =?utf-8?B?ZGFML253TXp1NzhITDBwNnV4Y29NZTdSMzh6bExlOGZ5QzRKY3o2cHBLVHRU?=
 =?utf-8?B?MGJQQVUrTmpFV3Z0OGhndVNTL3YvVXRTblRpcWVKNFoyeHpjNDVnbmw5cE9q?=
 =?utf-8?B?NTFzL2Uwa05WRitlOWZrdGsrYWlUai9od3Axd21LSFppVkdENWZqNFFTZHBM?=
 =?utf-8?B?SVViU1hCV2JNRkZFV0xiZXV0b0owRm1sMkkxSjFvNTJ3cTNJcnVWV0VCK21t?=
 =?utf-8?B?U1N4bHA5Y0JwQSt3UjJ1bFY5N2JUTldkUE81WFhIQzhlb2hSQ3laeFVqZTRv?=
 =?utf-8?B?YnIrcCs0RkFLeURlYkVlMWVUNXgzQ21IR1ZlWm5FTG5wR2dwUTFxOC9RSDc0?=
 =?utf-8?B?YjRYT2FXcHQyWjgzS1pHaEE1UkptMHBmYlJjL3ZYcDJrVnZtMHBqc3VmT2M1?=
 =?utf-8?B?UjBBa2N1VmR6dmNJRHM5ek1vQXllMUJ6d25jVFNDVW9wOENCRDh3LzJkeDdp?=
 =?utf-8?B?eG4vSzFnYy8yaVd3TExMRHQ4clRob1FpdjRpV09vWnJKaXFlTHM4eVZQTVBy?=
 =?utf-8?Q?LtSAzFbuoZp7xFKo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620fb3ce-269b-4edf-1a33-08ded8195de7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:07:39.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nOM8wbMuELXlrKwywJ0yktLgDUhbcpvoCmVGWfXvn7LvzqOy53eyursz1bcpFahab/5uRYe/B4r1F5x9YXhYaXHDWrbubrSgn6Tsv7ffOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6050


On 6/29/2026 12:37 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 27, 2026 at 01:14:50PM -0700, Tanmay Kathpalia wrote:
>> Add socfpga_agilex5_socdk_emmc.dts for the Agilex5 SoCDK eMMC daughter
>> board variant. Define board-specific regulators at the DTS root: a
>> fixed 3.3V supply for card power and a fixed 1.8V supply for eMMC I/O
>> voltage.
>>
>> Enable the shared SD/eMMC controller for eMMC-only operation with an
>> 8-bit bus, HS200 and HS400 modes at 1.8V signaling, and a 200 MHz
>> maximum clock frequency.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>>   .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 120 ++++++++++++++++++
>>   2 files changed, 121 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
>>
>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>> index 33fcc55d0cb9..5bbbcfda1f48 100644
>> --- a/arch/arm64/boot/dts/intel/Makefile
>> +++ b/arch/arm64/boot/dts/intel/Makefile
>> @@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>   				socfpga_agilex5_socdk_013b.dtb \
>>   				socfpga_agilex5_socdk_modular.dtb \
>>   				socfpga_agilex5_socdk_nand.dtb \
>> +				socfpga_agilex5_socdk_emmc.dtb \
> Same mistakes... Do not introduce random order.

Ack.

>
>
