Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE614248BB;
	Sat, 26 Sep 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419751; cv=fail; b=TZFlsEHkAogR8fSJowD25HGiuUnyoGFKEbnHbCyzeUQihBs3od3v2GhiqaWlCdH1Fq5t+4na4dydbK4D9J2QYjSn/QcM00piWNCJDOYzeJ0sZ1eYWa0lHVc6Mv+UyDVQ8YJJviuR19JNmY4fH7u3fQj4xUIvGkturrpRMxv43hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419751; c=relaxed/simple;
	bh=iOdBUM64R2m0mEMRj8ZwSaHzeXkB0+i5nqtl2zackgw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlEDwpE+Q/XTf/mP8w61r8DIDXdK8QdpBM9MCeZbCN+wzwckXn6m3YBY9tgTp0OC3Hbgwkq4jLE7X9Ad1J6fCj+swLYtAuAiNnvMdiHeMtezs+wJwWqG7kyXAvApAAiVLkln1RH0H96Gq8HmP9AD1mb95uQEr4ICY2AzTi7niCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=X7wuOe+q; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="X7wuOe+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQZrFiBKWp/0XTHJntLyVbG9XN9iVLkDOAbEdfpPa1KLAD4xtdim1c50gviAO74bUSbJARx6VKUHCT3UMOrEudcM9Q5JLu20j1FiAf8tXIG43zx4A+D2JFbmimwiYaWg+w1Qrm/g0WA8NSQkwNJaV1ni2HPN+9pQZ2iO5QAucW8hb1SIRyXbtBsnvcoiEUwC8VOH8TOc13jsZxGqrSWcob/B6RoiwRCYETrvNWZqVvjM/p5g2rpq47Prfvg77UafmaZR2bb3M8gi/omsK/ApBjcHlWfvvemA6JELtE35xWfYgb+VDtqEm9hawAe2VRir36IY+nSFmLVakZuyL34S0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iFN3pwevA4fnvwGscKwjkF9hkd8n2er6WUmXiU+qxc=;
 b=b6E5xmPE3k5Y8ttuTeNSG3XSbwEk4lMg5kDt+2MszRp5n6PEBYmcZSj6hn/nJ+vhqbBePKPp0rWOf7sJT8H2l+4HBUu0g+QxFuaG6pDWkaDVVIbEXCH4wxI8n0sVF189WgdtKxoG+IDWFP+bOblh80lEYs8szVG/lJl5lsJilWBubcLoknKU2wMI2IAKA3/tp1OKiwZfDdEcW4GiOtqEEguvVk9CIbOKiEZ7yUJ3+j2Ix8ZsxWAyQQjtb+CsXGIGax4E2/ZqhBb/oRZZj3v1Ua8wOuCj8nAsRK6c0ZByswsS5NqortCmaILq3RxtqbFqwfEBM9F9n9saaKX6CV2jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iFN3pwevA4fnvwGscKwjkF9hkd8n2er6WUmXiU+qxc=;
 b=X7wuOe+qClkTvNNKkAoIyh0ouWp0PzDuW8ftJCOpWNNILr8zRx5YV3hFic4cYWFtpOHshXQMWeLwbOzkwk1wErL+/1jSY+BjvNZw+QhaxH0KRZyF++TXC9DclZ6AN0kBj8OmvEEMLAD1jWofzqhfUZ2FZQLJFcLLp0uYLWG3lgYQloTRbLiq1IKfFXi4H8Qt5MImppkXDxwUYt9pEcI7BRwUstmwDEDe2b7QlaKzAyOxJR5ouBDWVhR9RQ3zfzu0rt94KP9lh/4VFAcBHw6JXDQhBYgnafMnvIQHLNn3kIpRQkf6biKZy8mhpDoOfQ0Fk781SuYlq1vUxAdaZMwMMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 10:49:05 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 10:49:05 +0000
Message-ID: <9c6b0248-f3d5-4bcb-937f-18c11dd7f368@altera.com>
Date: Sat, 26 Sep 2026 16:18:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50
 read-path tuning
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 916ef6a0-a3ac-4bcf-ba52-08df1bbbc901
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|55112099003|18002099003|56012099006|4143699003|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+QPxXqFYzaZV48z2ut9ORKKlh/iJRoS7K8J2KgDmeaPCcANA2yTfzWyfB5H2DltCjLzAfeoN6mjlAxQk8+5XdFptq5Zrj+s8b91F5xLtpPrDyu+xGbbS8aYJ2zfbhLFzuWmeEPxkprdDx0NIj/TwRri7YFQlkT6YE5cfMiFiEhThk8Qd21nlQKzgzsdkuDEx6P1PJwg/dOzmPGEzheUxubRA3C0o/FLjdaoE3Qj2MABcWAzpZ8zSohAQu7NKSKRF9Ov4ZCuNDKtmeQ5EBKejdsGNXxEG8slRwu30vh9R/Qhk4IAfLhgmFfthPrj+x0uqn9jrgcroA9uprSrA2Ab9iuNtfuJRo5ZnpI/VuG3X2hP38SbXuJwmQSE5M1mgUKiR7qxOxghhg3QmKYvOMDGumnNbw2gUXHWSxBVz7YY7fIMLraWqYtbXm1UhfUgUoi18LcB7JFigD79i2mSVx8ccoCL94ggJeYS3NpYPhyAkhdN8FZhLf3nMLIkGlkZPVVi5XqZuUZDvqxCBZzF+RgLgxXtgUfpYsO2stajvIwJUMWwK1p28Zu3zffKcWt25vnTf7iCa7JCeaZskmlkAt/+/UwAMGYf+Sl9OFIo5sP2HOABDyFjBzLLGkvY0D+beNa8EQsXORAihxkiuIdytjOZfXDtAp6QrRxHePWY7YCc8W4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(55112099003)(18002099003)(56012099006)(4143699003)(3023799007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk4vZ3B0UjFueXl1VG1NZWFrTEh3L2ZNdVlYa0hJZ3RzOUhFa202Q3VjUy9q?=
 =?utf-8?B?d2c4N0lWcW81WEhuc1lMQjhIaWk5dHl3WGJQVHBra1ZYQWVpN3V1VFVoRWR4?=
 =?utf-8?B?Uzd5Sk5NdG5JVWxKYXp4UWFQWWJ0TjBFK0JBdEtBMVFmM3FtbkN5S0VveXZp?=
 =?utf-8?B?a3p2QXU5YWRvMUszcUJSU0ZUNGNQMk9DODdiT1RzMVFMZU85ZTNLY1M2eW84?=
 =?utf-8?B?YWswTkpwNWRIc2tzeEdlU0g0MElnNmFZdytUamNEaS9FLzBNUWtqL25SRWgv?=
 =?utf-8?B?Z2V5SXlOVjNuN2NyeHpIa0xtd0VFL3RpY1plQWtMdDM2TitUd1NESzRnQXNh?=
 =?utf-8?B?ZnduclZFc0RRdFBrY3I4VTFxMExOcVBLWjkvMkd1YUJNSlFmeS8ySDJXWUl2?=
 =?utf-8?B?TldyU1FRNkZRWGRGbEMzeHNTcXBsOEJpMU85OEcxU3lPT1Rid0p3UG5rV05q?=
 =?utf-8?B?cGdaTkhqM283MDR6eXdKL2doa0RrRGJpWDVSd055dHV0am9pbWZydGUxVVdS?=
 =?utf-8?B?YkpMSVpEdENDTmNYdWdJMGJoNEtTWUsvQnljN05YUkNjSW84VllYNS9qMUF6?=
 =?utf-8?B?ZlJXZlNoVnR6TWFjOFRHUE5TUDd1QmpKeHBKTTE1aUtPQW8weUxiY2FRRFg1?=
 =?utf-8?B?Yjg0SVY1VlNHc0VsNXVZTDJjdDh1cGxtTmc3Ti9oZ0FRZFRJMGtFdG4rdlMx?=
 =?utf-8?B?UEVTdmU0dG93d0dwMnQ5OVc3RDE4S2RkUEx1NExwTGJXbmwxU0Z6OUZzVDlr?=
 =?utf-8?B?dHFEK0tkazdkaG04OFpDQkh1UzVvZjEyM25wRThYNUNYUDN3WU5QeC9GaEhl?=
 =?utf-8?B?UkRyTVU2RStGSFpYR0ZSazFCa2YzTThmWEV5QStCcU1FUzJZemF1Q1pnOWRi?=
 =?utf-8?B?VVlvNzBuTlNXTGtRVGJibzFqMnJDbHdQamRwdnBaZEJybjVuQzVocG5pdXI5?=
 =?utf-8?B?YmkraU02UkVWVDczUVlJMlZkaWp5aUl2K2M4cE5LMjRFV1hVTW9NS1FlcGxO?=
 =?utf-8?B?MmhXczBwUGlPak1pc1V0ZEdTblF3TVQwTk1UU3YvQld1ZXBoWU1VZHR3QUUr?=
 =?utf-8?B?UXdyc3NCbGltVTdrWDdRejVqSkk3REdaWnZKTWEwT1I3RlFEQkNyRjRERlVi?=
 =?utf-8?B?eU9YR3licHpULzNLclJueTcvaGFUOXByNVcvczVBR1hQWkgwYUVjbkJjYysy?=
 =?utf-8?B?aStaMVJmVlhhNlBtYVN5c1VoL0xYUUpwcmszQ2x6czJoK3d3Z3lQVmN1eDU1?=
 =?utf-8?B?c3AxZlkwei96YVg2TDQ0bWxVKzZDM0J6MVFLY0FxY3hXM2NWeFJ6TUJVdGlo?=
 =?utf-8?B?NXhwSE5rcVN5V1BTaXNKV01sS1JOcHRtOEp6eWNhZnpTUmxQTTAyQ0t0VXdE?=
 =?utf-8?B?Z0xxUlJyWUo1a0V4NmQxbmg0aDJxUjBHc3ZmUXJyWU16QnZFRUNTRlpOMlBH?=
 =?utf-8?B?YkJ6VmFSNVZrbWJLOUw1QTd0L0c3QjRyQ00zMVlVWkRGbldaMS9SM05KRytx?=
 =?utf-8?B?M1YvYUFZemE1THBCQ2FhVFNNVFBUbGtONFU4K1RHZ2daRGVXUjRJVzBNWEtn?=
 =?utf-8?B?YXp3NGpTSklLeXpoaERKMUhJZUpVQjFkM3hqcnpocHdlSXJ1SGNQbXcyUDZT?=
 =?utf-8?B?ZktoN21MM0ZkT3FBZFpkUEliMGpmRDdreWJIWm5VRnFTSjRDSXQxekZ2TlRC?=
 =?utf-8?B?ak9MaE5CMUhBdXlBWGFFQ3V3OEtvd2I5czlPMllpSEZ4SW84L1p4R0xDaVBr?=
 =?utf-8?B?aThBQW9tTG9XeGw2djhBQkcrUGQ5WWRnMmduUFVTTzJZdElFMVhhQ3lpbndS?=
 =?utf-8?B?THFUdkIyOUFMOUlwd1JQakVDOUoyWTFlTyt3ZG5wSlBETmNhOE9zZi93Q1Jm?=
 =?utf-8?B?Szlsb3BkdDFjZURlRksvM0RNd1FScUhDWEU1bG5vZ0FBR0tGRGJNUlk0OEN6?=
 =?utf-8?B?OCt4d0xjTjFJY1dsR25naGxWQ0s2UHFKQW4wMlJMSjJOTlJ6N3lYbWJHRjd3?=
 =?utf-8?B?WG1sejBTMGtRNTJSRnUwYWU3WlVqWWtVNCs1TjhVeHd4NDdTNU14Lzh5dTRE?=
 =?utf-8?B?WUJsYnNaRVFrTXhwMTAya0g5dW5PTUZZK01yMnpESmNSQklEMGw2L1JBNE9Z?=
 =?utf-8?B?L1VFcEgyQUJKaUk4aitZZ2FVK2Z3VHd5dFBsaG5yN3hTais5ZWpoUGFucnBy?=
 =?utf-8?B?SmNZN3l2NThhTFBFY0pXL2I3aVZIeERlbitBMmlUUjJiR2hDY3pNdzBGV3Z5?=
 =?utf-8?B?eGRrdnYxOTg3aTVGeHQ3citueERvVlVEOG16YWhhcWptWHd3MlB6bUhzS3JF?=
 =?utf-8?B?MUJpd09JVm5lQnhySXJDWWNRUzAxYUNFUVVENi9CTjVZV3llUEtNK2ZKYlR4?=
 =?utf-8?Q?vhhDLOm9FFwm+vws=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ef6a0-a3ac-4bcf-ba52-08df1bbbc901
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 10:49:05.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvwSg8cbYSRdKy+qibWbI2glXDrkn3GVJTqpCsMYy7WRwY1/J7gnIH/4rkuaqCEJdlrerX4sa6IrdTGWse4usapwVFO24Fu0bCL4kgwRbSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132

The subject should use cdns,sd6hc because that is the binding changed by 
this
patch. cdns,sdhci refers to the SD4HC binding.

On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add three optional SD6HC
> properties:

The properties are specific to SD UHS DDR50, but the cover letter says 
they will
also be used by socfpga_agilex5_socdk_emmc. Since eMMC uses modes such 
as DDR52
rather than UHS DDR50, please clarify this and correct either the cover 
letter or
the property names and driver handling as appropriate.

>    - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that centres
>      the read eye (0-255).
>    - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
>      (0 = phony, 1 = loopback).
>    - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion timing
>      (0-63) that positions the fabricated strobe relative to the returning
>      DDR data; not produced by the Cadence timing calculation.

Please drop cdns,ddr50-phony-dqs-timing. The PHY guide defines this 
field from
extended_read_mode and the RE# pulse width. It is not a board flight-time
setting, and patch 2 already calculates it.

> All three are disallowed for the SD4HC variant.

This patch does not add an explicit SD4HC restriction. SD4HC and SD6HC use
separate schemas, and the SD4HC schema already rejects unknown properties. I
suggest dropping this sentence.

>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> index d5ea2717904b..df86872603d0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> @@ -74,6 +74,33 @@ properties:
>       maximum: 1000
>       default: 24
>   
> +  cdns,ddr50-read-dqs-delay:
> +    description: |
> +      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the read
> +      eye. DDR50 has no CMD19 tuning, so this is a board/SoC-characterised
> +      value. If absent, the driver default is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xff

default value?

> +
> +  cdns,ddr50-use-lpbk-dqs:
> +    description: |
> +      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
> +      1 = loopback DQS. If absent, the driver default is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +

default value?

> +  cdns,ddr50-phony-dqs-timing:
> +    description: |
> +      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). Positions the
> +      fabricated read strobe relative to the returning DDR data; the correct
> +      value depends on the board's SD flight time and is not produced by the
> +      Cadence timing calculation. If absent, the driver default
> +      (REBAR_PULSE_CYCLES-1) is used.

The description conflicts with the PHY guide, which derives this value 
from the
RE# pulse width rather than PCB flight time.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0x3f
> +
>   required:
>     - compatible
>     - reg
