Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795374434;
	b=FK6c9LBejMad+xHlb/LrlCpthrA4uULNRwEeVLBU2cmYVsgFBTJxaoCCbAa6PDjEGqEn
	 w7rFh4KqhexDN1Jv+5ohcXHs+qCpmjETPQi5IJPWMfkn3SYcptjjCuXvc3B0i+e3VbGNs
	 mEJAGKC78gkHojCRuTfLANMn9E8y6aQo6MtHe3xSp6i61qePfXYFpx/Kxe+CuY569prpa
	 tv7NOWmgz25IL8Bv1lnrBEiVaA1huywydiuO2AuTcb+HsvlXIUx6ufDYYSL+JdCzqqzLn
	 a/m5/LaGQJ9u2zYyybjSWzA8G8c1lYDyAexXdJDbSJPuHqhBRreZmXMHqqbwZUF0GDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374434;
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
	bh=xCDII+JmNvitSkQAypsWN8boJh361dJR0aTB4An7gLw=;
	b=M/qXjmQj8CHMg64ojcFJ+wzTnDLB2yTPxk0rRoV4a3WPKrUTlEdyYuDolt3m7s9Rf9eQ
	 7p8oYXh+T2ZDAemvoWKHmvllMc8+LsC2qHxqzgZRf+PA7CL29riG3vbeH39IxUi8jUT+d
	 K+XSDw+q0WzKFcL2nwDQdJ8/svnYFK9Kcpm2FOBBmleG2A+xa0rb91IdN5qUaccqcsrKb
	 f4qi7ku4n09kOtic03drrE1boIBar0wJisdSbdqunc0/UICtMpwTrgSddZoMFwOyBzhMd
	 y494TdkDjo+q8PxwXxshayt5TX69KmXzheOdEJAc2kuht7/hpdmucQJXCoevPb8CZDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=HoOAwny9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.10
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A89606A320;
	Sun, 22 Nov 2026 19:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A89606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=HoOAwny9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vapNYQhDDUYIsq1vmeDZcG9Aube+UCJXmcXSe0/x9qAJY/hAgAMwBWKXIe7VWmCvybjWrfJliccmByyeWXfyBHaSsGpmpK13NLb4WZSvIw0e9B9fLQbB1O5LSSJT5ndR7JO7LuTU0klII6eaLJTT+4p0c4oCdACIWHVPnj0Th55r54DwyshsHlLJy58oTGypcD1iAbOdCr70C0AcuOIjVIfjErwomFAdFusEiO0NPB76sPm6n/g1FA4do8gLWevZR+7Q9D9w+8ATSCAPzbI1x+2b3WKvGJGduqDSfTqhXUXXAIHFgE26Nzed+NbPfE842U9kAspOaL0gFlsPrG2peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCDII+JmNvitSkQAypsWN8boJh361dJR0aTB4An7gLw=;
 b=iiWtUULlQM5e2BNTPYlQAr9vuqXGRhWZ/cvsR3HTAWO5l02JuTPSc7aJBhewosPjSdHpvZHUZ07hGe2ZO4OBav9i+XwwZDWEDioKdfGYAtohUKksbOdNJhCN5huSMEgdZqxSK/qNGUIgyjWiyS9Jg+qei0t399MMMawDH8anPUv/E5xSw82nFROLzr7TqBm1tXScwf3lfaJydlSVHWo66CyAr8wFAXRc44vQJraBvDkAvxa10AH6Cp2BlJgRTdXy12yruKtxgWzAqr8fuxMFk2Opi5Gyu45YYIs39jtegKWQHFk10NSE2WUo6oGfHp/FdfbSZE2d7ZA/XaH6aiqhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCDII+JmNvitSkQAypsWN8boJh361dJR0aTB4An7gLw=;
 b=HoOAwny9RA51A2wITJIluvM/vOkXbwAwKaccTpohPxxv0Xbwx6Gw1eUhAjvAIVgdPsXQTB9Bb8baiF/dEVegGzt9Mp7scFYqlcZmAHZfzKKUNdIvHLKXIryMkf5ufLdc6xqBmIV83aOazVl0hjJy404XaiP9sqaAgoOdXahvMT09pbR8WVc55ZH8UzUr5LUPF7DEqjSd1kHgRr0VTTXf7ameVzuWnHnojC7aWXMUydn4pZ9YP164W86nCuve2QAfnlEQDOcMFkhSllrLYnZPazqpZJyRknj+J5t9kQm0NBHCIXioFNaTXGyy6GJ1hzJ3usj9XFgMhFbS+p8Z9Rjn/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN6PR03MB7575.namprd03.prod.outlook.com (2603:10b6:208:500::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 19:06:18 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0639.011; Sun, 22 Nov 2026
 19:06:18 +0000
Message-ID: <0163d3d3-432b-478b-90bc-22d6c3f03656@altera.com>
Date: Mon, 23 Nov 2026 00:36:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mmc: sdhci-cadence6: tune SD6HC DDR50/DDR52 read
 path
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261119-sd_cadence_ddr50_v3-v4-3-95a94a0aaaf3@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-3-95a94a0aaaf3@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::12) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN6PR03MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 80acd922-b4c1-4e87-0f26-08df48cbb021
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2OoxdK9bYQezPqZCOX1UNGhZxoPeH4tOv4qjEPlAV0Iu8SUeFNJQKCjhHc8fGAv1w9kMpHhmGEt5N76HjXqGzhgLtCsqDP+9MVClG8VwOUow+NYPSpSvQ+uwFe9My4HddeZf+/j9h32sBXRqBrr8RZ9f/8NQDPp1Wm4sumjHDpIWKqxbUjPIOz0y/70pQwjzgs9v7xMctSjEwn6SL0PGrI51EH5yGnKBT5aui4EHaIWj2UKFQHZeJSXKou6FUk3LY0nAApn7mhwRd/r+/IY30UrCve40M3ytrBesGu6lzCrVGQR+caRbwM6WWLom/i2umzBOEwLXZuIFBHsYetWbkyYzUkfgxvmettFs2JXxvRS0RJrRfd9en+tBCYsgHJFe7cgx4rsO27AYQ/7LYwBFY4/NLGOvMe0rMZwMJ1atLcuWNAR/a1MiD+gDkhJZcOB/LCha5l4ZKbfC/DmtwvzXp23rg8T1Y9W7TPR02tD/O03BZ/rFMg3Dk5MDb21hcbu6xAGLCR+7VPbNL2dObVHcaKO4z+bgvANkUndyGp+vbvYAfFZgtDr6opx/ARHAdHXEsf7VgtZKjRtnAsh9DezEckjVpH7KA0/0FE5XZ6XWl4Vnpn8Pe66kPc4+LsTMCw6JLqdzKAdemFHtGQtyTGprSIaFopYpuf235pcXx9kpUo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHNKMCtNTWZtSEZrL0xybSttVG5jSEZLckxYeCs0Ukxzbksxb1NHa08wWkJL?=
 =?utf-8?B?OGJVRCtUbGNBNVJjWW4vS2RUWFlLY3JCUWhQKzNxZll1aXFsNGNMekhWdFdO?=
 =?utf-8?B?cU5rRExmVERReFZYQThJcWFLZmZ3Wmtod0tuNm5KeUtSN3RrYUdReVQ2R0xj?=
 =?utf-8?B?RklkQjJjZnRZaXNoRkZaRDdKbUs5Rm0xamtCdXk4K3djeFlUcUNuZW42bnZH?=
 =?utf-8?B?Tm5TWm40b2Erc3M0SkxIMG5IQ3FKVmlwNzZPSjFuZDFZMGF0aFdrcHg0SUc2?=
 =?utf-8?B?VVJZV3lnVWZvaGFoS0RsTjBMRzY1QS9HTW80V0tOMi9HZ3crSXRmc0FGNlJD?=
 =?utf-8?B?S01MQlNnUlpwVWRHQlZ3TzM3YlhxVy9ocE5BM2tselNnMDZpS29mZCswSGJp?=
 =?utf-8?B?N3FQa1NJbGp0Snd0SEpBVmdCTDhUQU50SHhmYzFDVHN1WGoxd1JDRjdYdjZj?=
 =?utf-8?B?WUp1ZjVRcFN1S3Z3OCtVbjBrYXJtQTVqaVhJeDNOWit3ZG5ISE93T2Y5Qy9i?=
 =?utf-8?B?QjAvcTZsa2ZOY2RBTUZVMUpKV1Z3bW9tak1vcFpnS2I2cXJobXQ2dWFkeTNV?=
 =?utf-8?B?empwREhFYzRKVTlQT1VKd3hYVGdrekxORysyemp3Ym9hZUwrc2U3TjNQN1pX?=
 =?utf-8?B?ZGNkR3FIRGk4SzBPVzhKeDFhemRSYnlrdG1tUjAyMnhEdmdqeGdHWnhmSW5y?=
 =?utf-8?B?TFJ1OERsaUpRSE9veHphOXR5UjhVQzNpaklHSVVPem1RbFpkZWNQN21uVjZt?=
 =?utf-8?B?RWE5NHNYR3EzTDViTTJoWG1QeVl1d1VzTEwyU2phaDlrdWRxYUI5ajA4Q042?=
 =?utf-8?B?Z0dXa1F2WG44WFNqOUQxMXZMcnpuVmhDcWwrbHc1cnFkY0VPb3JkTkc3MUFJ?=
 =?utf-8?B?ZSsxRzBBaUZ5bzdFUUZsYUZWVUdUNWgxL05HSnVSUWhNTlQ0WUkzZU9SdEJm?=
 =?utf-8?B?QmsyRVFFTTNHU0o4QUlpTFVYRS9JYVFVaE1WTGd2bEVIZHF1TXJ0VDlNcVVQ?=
 =?utf-8?B?TmhTcjNLSjJwQ3BjbC9NR1dnRWpsUkc4cnJjVk44QXpMMmE1NHVrV01kYjh4?=
 =?utf-8?B?MFBOa1JjZjFQbXJBOUthdlFhazZNK2thVlovOWV1Wk8wTSsyYzlxSnF0bEl2?=
 =?utf-8?B?OE9PYW9pcC9BT3FaUHE4bnk3bEpkcjhaWjNaL3JFWms4NGJEdHRQK1ZUTW9T?=
 =?utf-8?B?RnNCQVNUVHRSbVJxQzN1MjRNTzQyY3o3OGo4UjBXWndqYjdyaFNPbU5lUUwx?=
 =?utf-8?B?VFRuR0pTVFB5a2QzbEVCcjVtenJRbzYrZHJlUUpnVWFpaEVCcTRkR3Jsd0Jh?=
 =?utf-8?B?RlZvVUdaSDlUdk1rQUE2VkVhb2RjcXowcUl0Vk51ZU9rWnJqajBUUGNQOG4z?=
 =?utf-8?B?VWt3WjM0S05rSXdNU0lVUjdlcFJsalhESWtpRnVqYkVhdVNheTlkblRiaVM4?=
 =?utf-8?B?dGV3K2VzMnFpR2lsKyt3QjN5ZlF0YVRScC9IbmY0b1FlZnN6Mk50Vi8xbkRT?=
 =?utf-8?B?dFdJNm5Eall1U0lsNnlmcC9HaUswbnoyZGJlUmRmZDRiRHdqSFBRMlRQZExS?=
 =?utf-8?B?eHZGK1hPUXBIVllMMGRrWE5xR3lOZTRRT1BDM2tzd25RSVZIQytEK1FFSS9R?=
 =?utf-8?B?Q01PR2k1ZlR1NmVROXFwbUx6bEVpK1ZiM1dLM2tDZDdyQVk4Z2UzRUJsSEVP?=
 =?utf-8?B?WFo5NjZwUS9PUThFQXd1azNmRi9OdHQ5QUs1SkE1YlpINVpsbUVBTHh1RlpK?=
 =?utf-8?B?Z1JFSjdQbGd3YmsvQnRHZ0lXSjE4aEhmd0IxUFdmd21NZk9FOVV4c1ZZUUN1?=
 =?utf-8?B?T1M5WGlzNmQ0K1Evem8xR0NJYVhmNnIvT3MxbHZ2c0RoM2tGOGVVblNPQ1BS?=
 =?utf-8?B?SnBodFFKT1M2WUxRUnNxanFrNVNpY3phcUhISE9qYjZ1UktHaGMzQWVhMXdj?=
 =?utf-8?B?TENuSFNhUjZHMDh2bjF2UW01OW90UDZncDdFOWN0eHVsWnBDMUZaNE1kbWlN?=
 =?utf-8?B?QlI1UWhDcGowY3ZVVXRjNkRnYWVkUHJrT1Q5Wm16bzQ2ditzaHFaU0FSTHRC?=
 =?utf-8?B?RzR3RXN5bFFqcFl5bUFBNWhMcWJsLzJKdFU1LzZZYnIxMmRmUlNFZmszUXhG?=
 =?utf-8?B?b0t5V1VidHFBcnl6czgxRjRzY3FKVU4vRnd2OENxQzBTZnRWUlZrbDhFQVVE?=
 =?utf-8?B?Z0FZcVZzRnA0QmcxS2dEdk5Kak16RmtOTjczUFN0NmFLMVo0YlJNT1RldmJO?=
 =?utf-8?B?bWNuTzF4OStMek5BbUNiOFNjd2FrWmZtdHdGWTZHeTc0NkdHMnVpRE43cUVt?=
 =?utf-8?B?VzI0a1FnRWVaTTRTR3c0MEIvZTQ5VlVYbjMrSUUvOEtiWDZWc1crNy9yUzNE?=
 =?utf-8?Q?/8wU0WyvEgCzSLtw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80acd922-b4c1-4e87-0f26-08df48cbb021
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 19:06:18.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuJuFPvK5PqEcnYDNxWUJr9e/hyychqa7GTNA7PVM6t/pWbF8lS010iqhyPE3iwush0HiFqgQjP410ctlgZ5YAxmU4dJZITAAmAzaeX/Ahw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7575


On 19-11-2026 15:15, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> DDR50 and DDR52 have no CMD19 tuning, so the SD6HC extended-read path
> relies on static PHY settings. Two things are needed to make it work.
>
> First, PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) was left at 0 in every mode.
> In extended-read mode the RE# (rebar) pulse is held high for half an
> SDCLK period, so its width in clk_phy (sdmclk) cycles is the SDCLK/sdmclk
> divider / 2, and the field must hold that width minus 1 (0 otherwise).
> Leaving it at 0 in extended-read DDR duplicates one DDR edge and corrupts
> reads. Derive the width from the clock divider so it tracks the
> integration rather than a hard-coded value: e.g. 1 at divide-by-4,
> confirmed on DDR50 hardware where 1 captures both beats and 0 corrupts
> reads. The field only takes effect when the fabricated phony DQS is
> selected, so the computed value is written in every extended-read mode
> and clamped to the 6-bit field. This timing model follows the Cadence
> SD6HC PHY documentation.
>
> Second, the remaining read-path knobs need board/SoC characterisation, so
> read them from device tree at PHY probe and apply them in the
> extended-read DDR modes (DDR50 and DDR52):
>
>    - cdns,ddr-read-dqs-delay: read-DQS delay as a count of DLL delay
>      elements (each cdns,delay-element-ps wide), written to the 8-bit PHY
>      field (0-255);
>    - cdns,ddr-no-lpbk-dqs: fall back from the recommended loopback DQS to
>      the fabricated phony DQS.
>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v4:
> - Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
>    device tree)
> - Derive the PHONY_DQS_TIMING rebar pulse width from the
>    SDCLK/sdmclk divider (t_sdclk / (2 * t_sdmclk) - 1, clamped to the 6-bit
>    field) instead of the hard-coded 2 clk_phy cycles, and apply it in every
>    extended-read mode instead of only DDR50/DDR52.
> - Dropped the cdns,ddr-phony-dqs-timing override.

In v1 you mentioned that the modular SoM needs ddr-phony-dqs-timing
at 0. With the override gone the driver writes 1 there at 50 MHz.
Does DDR still work on the SoM with v4?


>
