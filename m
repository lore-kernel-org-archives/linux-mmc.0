Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B33BED42;
	Wed, 30 Sep 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766686; cv=fail; b=JtT6wJn0whFxut9PgeICSR3AQI1wyF2chw6E3N9Z3PWHNKk1rCsCzIOaBkku5NS+TXzBuI/Awu5goll+lEhdF6TCIDA+Vys77ZH+8CdEQLhYp05osbmslNT3sk4QQR0bZAd+8aMX+XpeWN1vNFqQFPI55pPWwJJNGg60KHxhLtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766686; c=relaxed/simple;
	bh=7uPKOVhItQ+gHgZpnX4SgCh0UPiBHc16LUHlo7933EA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wg52DrWYawRB+wBtOHPJajzFIj0Siu5glpu87j9UBAsyaISkPW9hELviI61E5QdizKkbHpNcrDM+fzafeu6k1X6/OL2ag16V84KMhOIyho5kMQfhcwM6Hb37x4M4daw/to0jTjqquGSEdjDZR5LHk4P0pJQ3qFI3xqRWGLs9Zjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vXp/iMNI; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vXp/iMNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBzRVs4g6Xn85ktdWLp5u7qWPvnKL1jH+mvUgD4/Am5RQ5BwoFko/6P27SCQAUgQ2hXXfD8OvOe+k6rtFDHzlAHE+2cEkWlDc0th3p4tYWMHu3PPH3ySggP0u7vpbJyHwCUAT5XLZUIir8eL+us14BFhtEb5rM+515+UuOHuX/zNLEfJ3F8QzE8FIU+C36f24PGe5rUMhGP/WaqUFR4osWCQ2dB3WafN5gI3RqBDCL10/uFp3fDkS4e1IfWnLImIdm7fUqqFYW6zFSJRGWvZfVqOXf/XD1DW1M3a9kgYm8TEhGbgY60aXDUHL4/ZasKCNsAlTd7sXiZIo1deYtg/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSC0l904o9yGKdk15V9eQLHwr6aR5PLrKllpjPXn4YM=;
 b=Iv9UDhBqFe5vpCusXA3EggcNpkQ1fe7JtOeiUr1rDkPtVHk3P3zJc0cddj0oZtWOhdY5bprvRadL7UqzJV8zE0Pa9+ILnMXGAn9K9Sw0fBMCp3UWugf9Y5Cn4EmEOg5fu+6euEx631Nv0fDLwzJ3lAinCdtPQV8ZQsKKtj9UW72IQRuE4cVdISu7/PxB9rxaZi5ij68Uf0CiOOvV5+RCNGZ6aYJpxEcxUGOqGW+QwgGHLMUEHN8+LtsjNObpQh3J6ADuZeZJ7a+jUN8j12vBM16k0egtX9Kci11Nq3EFxlmx3x8XttgwwTI36CX0yqRCZ/gHpejW0ytUuOwawAgamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSC0l904o9yGKdk15V9eQLHwr6aR5PLrKllpjPXn4YM=;
 b=vXp/iMNIDPNyb71U+nGQa7JeuLHVYNEhqeo2QvAu0SYtvs27pZctbq4F4mKQYe4B+Srv89holclQXgq6r7G8AVaZlMCE/q+Cn9dDq2UoeRgtPE71zHm9UMUCqUVXDRSpNHQZEj0gS6a8Oj2CwMAg/7MrIsOXxhnLCA4O/LVg1686AZIRM0/ITL3hyt6zlxan4YgFfFqCASKJv0rPTEo9lXIEGvGuAKY6NDPHFmPU/csSApZX73gVBcT2BV5kfQjhrQo2HnyYKRPcmH5E04wZenh723eklOGFryjA8WanmkE+UR5h2XJ6LzOzAdbB7BBTOD1Uj1PowacZhCVfKYb5oA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA2PR03MB5882.namprd03.prod.outlook.com (2603:10b6:806:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:11:21 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:11:21 +0000
Message-ID: <215a7598-ba5d-4fb2-aa1d-3eab751382d8@altera.com>
Date: Wed, 30 Sep 2026 19:11:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
 <d6066aa0-417c-49f0-82b5-745bd798706b@intel.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <d6066aa0-417c-49f0-82b5-745bd798706b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA2PR03MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d33491-c59b-424d-f60c-08df1ee38ed9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J4KBtOfTs3eGzIQto0Mr/WcIoUjzQbbWqHwz/0zA0+TGP6kNYbaUNX5TOGUomAXvjEWGXT4xoSNWzx0UrtPlqfAUAM64R93xXsdVlc27EH4A2EZAqC7pY9FzXkXhxVJh8XtZP3q2ivD0HX6haJdeSA6PPYkcScdku/NuvEKhynJjRwMXgF/u1dqE/OQgu+KCUr6OUS2rhfNf8bX+5sc5pDGFM12Rt1mItZeBFbEizYzlTk0ZipVP+F3cQTxcWdtdoAiA8RL8zcwQ50y8Uux52uE63IZgQNjROBHyKdY6b0Fv8bxaOPn00uXLMcWLjif40eZicIjMQ1CJ3tvd3TH83mDYDACDoPfahe3e/Not4capZZv0M5phRq6nWA+AQeQRRjX6zvnjjz+VjSP5hjDDt9sezMYAO8zjTBm9Q0FWUb+EjhpAO6YJI+fIBmazr5VzGfpLQ7Lh3t7v4un80wxMfLhAq9FA7d6Jlb8Mv2sftCPDtbuuchW/rjnRIdr+E6l7kVAQFc7rqthKOWBhM77SqHy5SrIiHsYQiz9zhHx9SOWyKPYtHtWoseFZTHJyOvf4I98kgEvPUu96mVU8gtrLYZ4/ZjCMnMmPmg7U0I9cmCYlXkiGOMkm1WMS2aSuwznXY3t7HqhLT5RJt8JqevgCVKmmITeKiD95vPZJ5qxNfJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1FvdUNuK1RXbHFJdlA4aVJvdVhWTndDTjBTMXBKSitHZExaTGNYcndScHk1?=
 =?utf-8?B?ay9BM2RpWitzVEtKUm12Qjg5OHpWNExWazU0YjYvM2N1bW4wQzN5SVJJYlUy?=
 =?utf-8?B?dFVEdTJPOFZpY2hIZGtVT01CNU9wNGNkMUc5a3U3ZEs3MkxMR0JRWHg0QXBZ?=
 =?utf-8?B?dWxMVkE4NUpmZUFoUlc5bFl1Vi8vZE40OGNHRURmNVlJcnhlMlFndkhQa0pT?=
 =?utf-8?B?aUJzTVJmTGZoT0UxV2R4Z3hPMC9DNmtiVTI3UVh5ZE0zMkVhcS9GTlVaY1RF?=
 =?utf-8?B?MUdyK25UdzUySFErTzVWWkgzNk94TEhBK2FjNEp2OGNzL0VVY0tpd202dWxJ?=
 =?utf-8?B?T1hGQU5QRDVPaXlySnpnSWRjZFlPVVl1OXRjWTZ3QmcvRkhUQ1lSVVJKV2Vs?=
 =?utf-8?B?VlFpdUVsdGd1NC95b1cxVGlncmt6TW5ad3VyTXU1WjhrbVZQZjVnQUpYM2Zk?=
 =?utf-8?B?bThzcGZlTktJUW1peDJ0WnY2bTZpSzc1eEpYeUZrLzZ4bFYvM3owYkFiMGVa?=
 =?utf-8?B?UDNUakI5QWovSGlSeXF3eDg5SEZzRHFUR1VOeVVDYnYxbWlNWnBKRUJWT0pV?=
 =?utf-8?B?eENsS0RNNzJSd1k4NkJ1YTFEdjA2MCtNWVdNU1VKTTh1L0ZCb2toMWNxZCtw?=
 =?utf-8?B?NnE1akRXZFNsZkhnTlNIelZOYnowTm9FVGw3dzd0Sjltd1FCd1huendTZ2tG?=
 =?utf-8?B?NWt1NWY1ZUlPSFhKdjF5SnBHaEVlVndKZDBuTFZ2cDc2MzM2ZUlNcUgzeHVz?=
 =?utf-8?B?QkpXSDVOcVFJZW1JOXEyOVVJMlRSNXlQM0RnTlpMOE9xZkpFTEZ5U28yeE9y?=
 =?utf-8?B?TE1JcW54RkNGYVJiRFU0SXE2bHBUbWxXUWk0LzRzL3gyNzFZWjRYSjd3V2V1?=
 =?utf-8?B?Z2h3NkQyWEJRTWd5S295Ri92eXpGSUFiN0tGbXNKUjNnSVUxYXJCamVyRnN3?=
 =?utf-8?B?RE1jMkNGajdLVEQwNXNnZUhxcitOTmxBWW1NeElsTTFweG1iZzZIdkNadVAx?=
 =?utf-8?B?VlNJT2djUUJhQkFzcmpDc2sxS0FzbmNIRk1HVTA2SlNKMlIzUWtLK2pYRDlT?=
 =?utf-8?B?MjVoOHBiWjRTWWVlaGV1VnRhYVhMQWZQTzJwSEN4MDlOUWVKZVZTYjR3UzJ5?=
 =?utf-8?B?MzE0UWNkSDdwQ2haQ0doNldKWXVLcStGQVZ3UFpBL2VvVkcrb1JqYmJlUTcw?=
 =?utf-8?B?NFIwWXhqd3Y5NEZ4cTJ1ZW8rQXdlbHNZbnNLZk9IRjRRMGRBMm9ZZGh2NDVy?=
 =?utf-8?B?TXcyMVhRNGZJcDhCOE1uVTl3UlRxa3dkcDBBSlFONFlocDRCUDRHVG5kazZD?=
 =?utf-8?B?ZGIvK0R2N2FCYUhicUdzcE5WVjZzU0ljWGY5QVRXTTA3ZXRQVDFFTWhaSnZY?=
 =?utf-8?B?WkFSL01mOE95Y1VlQ2UxQnNtdW1vZVhTRlppSERqV25OZWphTXpWdDA4ZnVp?=
 =?utf-8?B?Y2FtcnNwQkNuZ1FCbktkZVE2My9TTWUzRDA4RU5penR4R2tNNXl2SHBIOVhk?=
 =?utf-8?B?RGdSUXFoNFIzSXJJS0ZMYkdla2ZLcjJmTVc0eXE5Vng5dVVMcDFZem14bUhi?=
 =?utf-8?B?VDdPTXVUZ1RVTU5RanJQNFhUekxsRSs0ZTAwQTUyd3kzZW80OVMzNzRleCtS?=
 =?utf-8?B?ZFhnSHczR055RmZLc3VtVEtreW5GZ0tyUWVmRFBLOEJYL0w0UmRPbDZSNC9h?=
 =?utf-8?B?TXBsV3NReVZWck5OTlhsK2UxeUdid3kxVEdFNDUrZ2F2c0pzdTdBTXYwclVh?=
 =?utf-8?B?WDBHT1M0RlBIOVpmZmxGSFpqZ1VMeEN3T3hWSGYzdUtmMHYrMCtFTzRNRFY1?=
 =?utf-8?B?cTZoa3JURlZTTlZaN3BDamRWcldnVzVsaHprSVZUeWFuUnZkd3ZCb25KVmk4?=
 =?utf-8?B?V1R6S3JNYjdWbVh0NTNwTldmTzNwRy84OTJyR2FBOWgzTGc1cUwydDJncHA3?=
 =?utf-8?B?eTF1RGRib2FRL0ZNVkdqTDRUaWVUL2ZJa2dwcDlWNTJLT1BQWmhXV2tTYlpJ?=
 =?utf-8?B?bGJoaVZacC8rSXZZNC9OY05yd0FaWjUrOGZpUG1HTUYvVEp6K1FRS1BvUnVI?=
 =?utf-8?B?QUlkK2E3TTlGQmtwYW5zUlZReUE2Z3pNRjFQZkhIeDlacmpmWngvNnNjWFdQ?=
 =?utf-8?B?T2lJQjRJcm4zeW14cStGcFVPeTdFNHUxYUxtNzN1UWxMKzZiUno3Z2xQZHo3?=
 =?utf-8?B?ODNVV3dHbHRMSnF4L1pIL1M2elJJOS9VTU1ucW1BNUdsajZyVmVTOFZIcG9y?=
 =?utf-8?B?dE5qdlFkMFZHUjNnMXRVN3lWYjBaWnZoZjZCcVlkZUNPNlhMODk2RWJCczNi?=
 =?utf-8?B?NUdnZlZBY3B2d1d4bzNzKzZKejl3QXlJSW4xNUVQUmE4NDk1UzRMQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d33491-c59b-424d-f60c-08df1ee38ed9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:11:21.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vimuXJXqORUy86UqFKVIlSxyfcDcK6meDCGndFdmgQrGxvLWYBdnKvc+Bq3xLhN2mgMcDJb6LaDE33eFEhqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5882



On 24/9/2026 2:41 pm, Adrian Hunter wrote:
> On 22/09/2026 14:12, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
>> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
>> settle time the command issued immediately after tuning (e.g. the R1b
>> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
>> can time out.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> Presume you realize the delay is inside the tuning loop, so 40x 5ms
> is 200ms total.
> 
> Nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Thanks for the Ack, and you are right about the cost. The v1 placement 
put the 5 ms inside the tuning scan, so ~40x ≈ 200 ms. In v2, I will 
move it to a single settle after the winning tap in 
sdhci_cdns_execute_tuning() (5 ms once, success path only) and reworks 
the rationale per Tanmay's comments.

Since v2 changes both the placement and the file it touches, I won't
carry your Acked-by forward automatically - please let me know if it
still stands on the reworked patch.

Thanks,
Tze Yee

>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> index 22d56bb46d75..35f35ef9c710 100644
>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> @@ -811,6 +811,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
>>   	if (ret)
>>   		dev_warn(mmc_dev(host->mmc), "%s: DLL reset release failed: %d\n", __func__, ret);
>>   
>> +	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */
>> +	usleep_range(5000, 5500);
>> +
>>   	return ret;
>>   }
>>   
> 

