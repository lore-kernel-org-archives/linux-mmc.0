Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2031.outbound.protection.outlook.com [40.92.102.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183DA21;
	Mon,  5 Aug 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826372; cv=fail; b=m9xQ/U6VYpByG1Tru3UiodxGV+RAu01kXO7jLlX0uceZYjUahE0s38e7Sq4kJBQLGHFUPhAN5kwM1OJPha9JIDa/GxFRpKcQFzpBq8xgNf3LALDehf6XbjBUqxNnuunsUEDxvKpTT83QpxKdAXv949jfwjV0YIyMH6sbfvqgF6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826372; c=relaxed/simple;
	bh=OGgV8dLfuCfFI9y+jBZZfZw/8Ucz/OtnG5DNjnyMdyE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svOyr5qQWgCgInqf7kaijyKfWzJ0olkhEMhEew3ev+ie7LMqbNiw5hHkp3vpI87DDn7xaN46Qqz9pba5Uv4nV41FHWP32s1aR7Ld1vPsVFtXvwfLfB3xSIfbgDgAXxXUElrBpIjR26wO5KsmiAnC2DrbfLxc0xOcPRVIoEAc4Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DqeLqC0M; arc=fail smtp.client-ip=40.92.102.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DqeLqC0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS1LHEn+b4FrwawUAa95D7SCHPx04qi9XCWiKYOGxt/iwLGlWKUWM1xwkNM9k2CxXJg9cU58/E0Y0M/QTo12wF428Dh4qE4gOz49dgQ8BVYnR+/C7wsCL4SmKQJxAuGZ1VR8lBSouATy175oUl6ea8qf9eMYzTnTjzB4UpLqVa4wMb7WIXphZOS/PLaXjC85ySGXAZb8txZSIHHfHvLgMARmttEePmFfzTHz/vEKWw+J2mwq9qmxw5p6bu/nj8yKkNxCf+UOGNxEEuLSMapKOWM7xn89ScSXtKEPIcYbyBVlUtqs77uIECytrH6lEhJgJe3a686hMDPtNhC+cf08NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR4/FPXiXXwdPn1/78BXjuLjGXIOI9zJD8v+c9SP3FE=;
 b=g7XHcOopfEUHRkeUScdeLRvXf3qRdaEQp1EcfTxvz4hNgc/78Fsb52SB1BprelZFOLSucy/ojWfc29L1IaoDHEjDI0pM0LtPNfNH+eNr70/qwJ0S/a7KBRVNsz7H5VHenReJH+MCl7A0FA6B9+KBMLSxY/dieGXXOHGOomSBIqInWzaVqgtBwylg61ycCtKqKSVzExKUIeDeeGCxIVMhGqo1FwZCbDN8aAN579w7RaeF3sLxOsS1OnxvVJulOuHQ4oHFugcWhRgawiH2ixsSQwl/QVD0qzGw1R1lZazitfcHfeClGAx3UpZ6OpqdpdVd6Pi3jICPjpW7k7Q+Gcs6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR4/FPXiXXwdPn1/78BXjuLjGXIOI9zJD8v+c9SP3FE=;
 b=DqeLqC0MpkXvXwuO7Abf+47ok9Y9+BxruYwaDF0mHWy6hsj6iUxE1UT/JLFjg0wGzQ50A+gbfRNrKYOTqhh04oRYU9ZLzCdXd1z1Uz39rtLJgFSOnK5PBgpzxnqJk2KOzYwBDYnojKtR9/BmqeCvLu9IKTT+rr2KA/pJ4GI/m2JZHsJXXUmgXYRJHg68+k1avHy0yjxzFEFtG1/BoT5T0Ym5rv5ByiWAM2r6jbWNlj3yXNrVZpV4xMVHiGgNsEmRkZUnWY7EXrMvJLXF3yQfypvpkE7jzzFBZGWojPsu1lURu8PEhbzIPtQ6ngo3kBZfYubpfNEmtsOkabW84KZlgA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1476.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 5 Aug
 2024 02:52:38 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 02:52:38 +0000
Message-ID:
 <MA0P287MB282294AE4A26D4D49565CF05FEBE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 5 Aug 2024 10:52:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] riscv: sophgo: dts: add mmc controllers for SG2042
 SoC
To: Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
References: <cover.1721377374.git.unicorn_wang@outlook.com>
 <5110a64d513390c01daf3b4a6a6fc5560baf77a8.1721377374.git.unicorn_wang@outlook.com>
 <IA1PR20MB4953350D2A8084D53362785FBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953350D2A8084D53362785FBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [D4V+lEVzVrC8jXBpmlyGwTtxvI2XP1Me]
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <dce618cc-79a5-4edd-aa55-3fa861ab1a04@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1476:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fd593f-6082-4e6a-adbf-08dcb4f9aaba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	wKnn38Xifyh4YgDkhDNiLtI7OCe92juhmvGD6nsLN+IkLYSS1V3r+CzJZZggPYpCbvTQBRtzkMkEz3nEYgdsBWIe/wNBk7UXja1MegW3ysuScLA61PxDQEg1aC15Re4TA1nLI+mNsyGb5Aebzu4cQj4kjW0AF1la4fBMVXj/IXSKd5ieKRuHpbbaY+nca4AullTUtQw5Ss5yK//4BZeKTK3NgW1z0BLbvwK3j2bYO1kKoc+J9W+h1U8ckvFPTz2mF8T6u0Fjvth8IQ1vH921uEC+Fqy+K9Z5v9eZgo279pZtVvClnhZgxi5k/g7G8wz/MAAPMqkwQ3LzEuJ7adUXWisAS7UiDlN4YTZM5lAUc5f0j52EJOsJ5o7loqNRu70tqgpeqcf5Ra4SRUwKpgWTABgMmaC88vJQqQO7cKmomvkF6O6GMGtV/VIIqm/6f8tJcdm4deQnzvj3I8u0IW1LLl5aN0h8zPQlo9RA4nU04ZeqkrtsRJqQP29ZaFSY5XatXjfsuKscuyIhZP9xAThfyVBCfYLcEN8Oa4/IjcoNH1f8Oqw75KRf1Df9CHalRLUCj/WbhNWMN84PkJBCI21XTFEDFJEfTxjHhmcQu3JOdd3XwLolUNGbdoCoKjdos6FnpznEXj7Zzmpb1eIPF26GdyHRxoAZVxyi9jusVlXxmedwcUflXQk/J/Lsbt3/vaaQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTRFQitBVXZmc3d4cndMRm1DQ3RYR0toUUowSUw2NEdOM3NKelFzakpmT2or?=
 =?utf-8?B?T0c0YUN2RE5ISlh0anVNeWREYThHTFJ3TmpwNldxUE9NaStOQjJHQ3lyalQv?=
 =?utf-8?B?ZHNSa01laUpIWFBET2NSVUwzMXhtK1k4WGJhZVpHVE5nREFCcXphZXppSUlh?=
 =?utf-8?B?VFpueXM1VlRLWFRQR0Q5TitMU0ZWZjdwYXdjdTMwazJ3TkNVeGhJQzhhSGxG?=
 =?utf-8?B?dTEvYUJYeVdvVmNTOHJCYXAwdXRScFg0TWEwOXJybUhySUM4QkVpTndiZnk1?=
 =?utf-8?B?MXA1NEc0U2hpYmZWa28vcjBpVm83S0RhalFON3cyRmVOczZDVHYrVjBJSEY4?=
 =?utf-8?B?Q2FtSFAyd0pDL1dVY1BVQVd4TnhNMGJnMUNmYnNoWXBhaHdkUTM5ZWtlMTA2?=
 =?utf-8?B?clc4ZTJnV3FqTS92U0NxYnhYSE9aV1dFd2NKcVFvZmpxdkI3K0FrWjEzUmN4?=
 =?utf-8?B?S1FocWt0dWxJSFFNM0Y5N25nRlZ1YjRHZlZyM1p0M2c5ZEMrVnFYMG5kbDhz?=
 =?utf-8?B?RldEVmdtWTIya3Rlczk2MWhZbm1oZkhrRWQ1c3E3Sm5XMGIrbVVQaHdtOUhm?=
 =?utf-8?B?bU9UdDZIWks4YjNKYVBnaFFDamFMbnF6TWIxbHp4NEM4a2tsaEljOGxPWnhN?=
 =?utf-8?B?SitzaGxVbS9mUHVQTHJNODg4R2laWVR4MC9mN1BQblhQUkxwUDRneUhBeG10?=
 =?utf-8?B?QXFnT1JtVW5BZEtlSTVrOFVmY0wzYmVyVmVBTExMNE5sZWVtZWVpT0ZON001?=
 =?utf-8?B?Y0xNSVgyRE9xZGZjL0lBVHBPVzdjMjE2SXMxb0I1S1FwRUpqdXgySWcxZTly?=
 =?utf-8?B?L1RUak9NZFRKaFQzeDEzcko3MUV6b0tzUVoxM2ljNzg3c0Y0YmVxL1FVa2px?=
 =?utf-8?B?Z3Rxa01OdDJ4K0xtZ09BNFNBeFZkZzNJWlJVd0dGU1AyQmNvaldBRUVQWmIx?=
 =?utf-8?B?SmNlWWZHMHFmblZlSHMvQ3orQ1M4Y3JualdkV2VoRUtGUnZJWTJOcFdXNlVK?=
 =?utf-8?B?MHp3akllV2VDSjBPTGlybHZWb1dHSXJkRzZBbVhZSzRJRTVlNXhCNmRaWnhQ?=
 =?utf-8?B?VmtqL05kdkVObmhMcUp1Ym5tU0UyTnpXUm15dlkvbXR5MFY0YVNheHFWcHJV?=
 =?utf-8?B?L1BISmgvWkcvVGZSWFFTRDJsUlYyeTVtbTNSYndYRC9tdW1ESVZUQTIrNEpE?=
 =?utf-8?B?VHhQQS9wSDcwRFo5OCt0Z2Y1blJYRjdxVDBNV05CRXBmWnBnQmRmcDhOK3RC?=
 =?utf-8?B?ck5DNmwyaUtCT0s2TExKN2M5SitUcDZxNlYrY0hYSUZDRkJKK2dxYjdEMEor?=
 =?utf-8?B?NHBMWXNRdmEwMEJZNDJ1Y24yN1cyYyt6OWlNVmIxU3F4Zis3WGY0K0dnZjJ5?=
 =?utf-8?B?Yzl0QWNUb0RadXM0NlZtc2FVMDdWVy91ZjJtYU1HSUZSTXV1Y1BHOE90QlZO?=
 =?utf-8?B?bGlHdnJFRnY3TnhKc1M4emlMTUtXNlRwR0VDejFQUHArellFL0V1TmtVcmRC?=
 =?utf-8?B?TVd2eEdLbklJckgrZG1ZU2pJWEhwZDFzbzFnZXlwNnVWZjArdzFtS0dOSVAv?=
 =?utf-8?B?SllxdjVkWFhFeGsxRUQ1MWsyaGZUeHJIQXBuNEVNRUlra1VpbTk5K0pNZVc1?=
 =?utf-8?B?bUo4Q2FNTkN5R3BnMGRBaVk2MnRXWFV5bWNjSWUzbzU5c3RHRmlIR0I5TlZG?=
 =?utf-8?Q?1VLpCn6SYVRcLGTaqxF5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd593f-6082-4e6a-adbf-08dcb4f9aaba
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 02:52:38.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1476


On 2024/7/31 15:58, Inochi Amaoto wrote:
> On Fri, Jul 19, 2024 at 04:47:22PM GMT, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> SG2042 has two MMC controller, one for emmc, another for sd-card.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Please rebase your patch based on sophgo/for-next.
>
> Regards,
> Inochi

As per request from Adrian when reviewing in the first version of this 
patchset, I was always posting patches based on the latest mmc/next.

So I'd like to trouble you to do a rebase when picking to 
sophgo/for-next, but I don't think the conflict should be too big.

BTW, I will send version 6 soon later due to some minor changes after 
some comments from reviewers.

Thanks,

Chen

