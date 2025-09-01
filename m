Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD230E824
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718774; cv=fail; b=Sg3jPVUsSFrfbYmMsWQHnj4GnwVUnepAKlZBT2QsKFf3i38cA8I6ghPYuQ7Ci6y1sxbRTHwEoaRsBAcPI+8XlWQptgHANhVsCR88NLr8/Z5C+oJiJqjlxwFDcnmKNuP/yURxBVcPyvV2U+9wdwUai1rS3BBVKhMxyNX8ToIN8cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718774; c=relaxed/simple;
	bh=bvGK1/oT+71NS1cUV1k7MkG3iBtN5NhD9fiD51zm/V8=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=gz3GeGkh0ANLPgEUXMToz/7+URwmn3Mh/87sS50t/eOrcxhayHrKttY1oFIxpw6sFJcXf+QFXsTEEasN24OXGcllRQTx9pfSUa+dj+Js7HpdgcnmuQrdFrpQoHnFAIZt4+PWPqkbKTiAFh6xzVA5ZC46X+Z/RgQ45b8KDpNlPU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KZz4YpwY; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KZz4YpwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJpseFkJQwHLmPgaj3/8VSODxMGyFeOIKfON0umZTW4mGlrWxymRNj7kdsOkAYvRJM+ShOYzq0KIg/XfwG4u19o/zV23O6QTx6UAmP2FiLUPf5uh56P9WXJsPp7DTiod/v4hQkfD1F7vyrGxFwuBQVtJEV4bRtwDNJXocvIrdsUbQ5wcq0G44nCtSyEGCGLRxu+ZYp08zF8jJWfvdcirZRzuHmG1dvi6+bOkRAqjLvnKI8Q+FaOFE0+dJ1b3Oq0PUkXeZ0kV6ZfGns8jMmhFBHDWGZ1lEdJno+QKLn0NvTHOlY1+SqVUJnLAXq668YyVx8ZAwsCmafHi8ovSlNXFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+P/tZhA6mWoX9A59kaXaDdpccffXhNQ/Te+BHx85NE=;
 b=YnLG9KFi5oHodr5k6FJPZUmr3M8q0foUp7wLT7xJ64Y2olwkwdNYDzVulAqnU/a3V+0qSq/ssjYobHCw2NRG6OMLiYYZZtDnzyOzDhyExYsTQ1AFyqt3mx0rr6pGQXR5fzhPeyI8ImQKLiFWYvBAOxe9yrhgRkryJMhGpcZEcy/Ww23ihxklGePOK30e1l1sUtPausQVS6jUyVTBj2uDEiCIzmzrQk1+GqKlFZv22NNJITFDJbR5pqKuaybvMX3DMUdz6tsYjEGnu4f+xPBwtfT27Ty659HezzG/T1dV++QgJCpKXHCZLMtzupivDxgxosPJ4hkNIkGYZT5jaRY1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+P/tZhA6mWoX9A59kaXaDdpccffXhNQ/Te+BHx85NE=;
 b=KZz4YpwYsbJV0c+cZIZ+OrzuzXSyvjEmzJS9weCSNbgwtYoTy44yVo/4Pj74PLv5IHDP5LdDGzGVqI1ruTIaEci5OJzP3yk3mobZOJywhv96fe0FEoHdY6UoPuAO5005mBfc6skbALKjPqKzTBegnDpoFKQ/K9MPlysKrdGTy5FXR5smxz6aFk5Kv7cYGyK/MceXsNQrkAojiBFxR8UrwYC9+7y4ebVG2cJXQ4EX8hEFCj3/v1ox3wZdWR3MlnUw5watJrnW0jnw0/aMgkEAG6oI9zHj+1PMSaBOW7o7RdKObrx+mNhsuoI59VNQXjbtBHt8W97wepn3lMhBlC4leg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 1 Sep
 2025 09:26:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:26:06 +0000
Message-ID: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
Date: Mon, 1 Sep 2025 11:26:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] mmc-utils: Correctly handle write counter overflow status
Content-Language: en-US
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: a340c6ca-91b4-4f56-a436-08dde9399407
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9hSGVtWlF5ZmNvVTZ1SW1QRm1hMVZ0OTZITkpLczJTVVd2U0VXWTBnRVVS?=
 =?utf-8?B?MmZIUFpOTVY1c2pvMVhhOFVkTmh4cjliRFllVVZzZkRXZTQ3Wm9JdEwvMWtJ?=
 =?utf-8?B?N2wxdzFkdGZCUGN3amR2ZHd5QlNiTDV5QUdaYmFpRVVPZzcyeUZNOG9LaXAv?=
 =?utf-8?B?NFlrUEtOajZQNDFXY0h4cXowbHZpa1FSWE5LVEtoSzA0M2NtbkllU0JYT2hk?=
 =?utf-8?B?bGR2M3dyaHR4aW5ZNWhsZDVKUnBVR3VqbUFRYkpOdWRQUUllU1U3Wm93Uk56?=
 =?utf-8?B?Tm9ydHRoYnUyRXRBU2I0QUN5eHJkUXAvc2dZcjZOZzR3c08rNEFackVieThk?=
 =?utf-8?B?b3kvdVJ2azN5YUUxS3pYSjRrZkZxT1dLMGVNNU1kb054VXQveHBaemRPT1No?=
 =?utf-8?B?VFcyVkNMRVBKVFkwTWxabVcrazBiY0YxaHlaQUJkNFFZeXZQbkNUVEt6Kzd2?=
 =?utf-8?B?aXhwWGt5U0w0dVRSN0hqeW1MSWxwbjhTOHJzN2h1aVU0dmQvR3Y5Y0tjQlhs?=
 =?utf-8?B?eG1Ba0p5cVVueFFXUk41SFBXRUIzNVhLMitqR0pONmMxd240R2NaQlNCVnNn?=
 =?utf-8?B?RkpHRHN3ZDAwVTB1d25SSWtESjRQQmRWbVp1L3o2SzdmSDl6WXdsQmlJQVND?=
 =?utf-8?B?STRHelVIeHpTMDJXNDIrS2V4clRKazRBeFhKcERWTzl3QmFOdDZuSDBuL3Ix?=
 =?utf-8?B?Q3hSS1k5SmZGYUZzNnREV1gwb21oUjY4Nk9zL0hQVlY1N2NocW5PSFdiaXZh?=
 =?utf-8?B?djN2YzJIalF5MzFiTW5MK2VnSTBSU3Y2aGNQMlpicmlBbzB5V29GNW5VVm9N?=
 =?utf-8?B?Z1BNdmVqekFtUTNSV0U1SGhoWXNYeUo0RWxoZjArM2d4Vy9jYXN6ZllZMlFM?=
 =?utf-8?B?UVlsVVI4OTdac2JpY2drdjA0WXJDS0pWRThSMW5XcE4xVngxTGNKU29ncW1C?=
 =?utf-8?B?d01ZNWVFelFPT0lFeDlvVmUxd3NibVVaOEJyTEc3Zld5eXpualJ1QmlFQVVj?=
 =?utf-8?B?Vmptb1UrTSs2V0QwbnNWTDlDZC9vcCtzQ09xaC9yZ1ozbEtkY0JiTjhaOWFx?=
 =?utf-8?B?U3NKRGFLVzBVWEVKWHB3YzF6QzlHcFBzNFlvcnB2SWJoVmRSZ0lBQTdGOC9O?=
 =?utf-8?B?UmVpdXlHQ0hocmtGem5kbkx2Wmt4TFBHeWdiZ3Y2Wk9jTnlkM244R1JRckF5?=
 =?utf-8?B?L0FFRi9CM0tYeEpaODRGZjdnbEhlajhOalJCN0RpS0k3NGtuSXQ0RldaaVlj?=
 =?utf-8?B?bjNFK3RuTkVxUCtRMWdwM1Y3UEI0ZG5sa21FWUpTeUllYm42YXJGeE93a0w4?=
 =?utf-8?B?aHdFVjBNZmgzZG5SbUhzdWl4WWFBZW9ueTdNY0c0LzdHbWpBUzZLSzZiUHcv?=
 =?utf-8?B?ZXE0WEN3aWFwTUlpaTlmOXVTT0U5TUxDOFZJYlFhQlRxVHF3aUNadlRQQjFM?=
 =?utf-8?B?OFRxWWR0RGhKNzlubVJxUUNLTWkzcnB2Q3NjZEFnamhrd3dGRmVaRGVjbjFQ?=
 =?utf-8?B?V2lQOUoySzBKdDFzdnFYU3BiVUoxalBkSmluNjZlRW51UlRnZHFuWW5SUHlT?=
 =?utf-8?B?STVRLzdFVU5iUC9WMzhUTzBnN29QQXU2WFBMOUxSZDZxRmRBd0NZbjdvOVZY?=
 =?utf-8?B?eUZOOUg0bDVlZ1F2WHZGZnBKY0VHd3A4MklpUktjbDlvOEFNNnpVYTdHRFdV?=
 =?utf-8?B?cnJScHlWeTVvdjdvNHo3Y3dPRDEzdEVBQ2dzemJRNzNaMm1meDNSNE96Y3ln?=
 =?utf-8?B?aEQwTUNidHNqMGRhcnhtM1ZORHRrSnQwUVhTdVBxdjkxd0FIMnRQV2JBUUNJ?=
 =?utf-8?B?T2hJK3lTbVl6c2J6a2FqVGRPZmxIeUhmZE82d2lFOUdYbVYyYzBucHNWMTk0?=
 =?utf-8?B?WHRIWTUvVHI4anZRQ2tBeGIyaUt3cTBtMTF6R3NtUjl4ejZLUk91OG5kbEtE?=
 =?utf-8?Q?L3nuJOWwGMU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWNEcDd4ZHI1MnVFcFBHaGVFOGhmeFFFQW93bWdLMjBueHlsdkwrZzFxTFRV?=
 =?utf-8?B?U0V3THdra3I1RnVUQW5IdEo5QXN6QkFKMERHYVFER0ZZWXpiZDNjUk9KYjZu?=
 =?utf-8?B?VDZZU1dLMU90blo4T01CZWRiNThDVEFhL2VGSSt1cVFDdnV6SVFNb2VHamxG?=
 =?utf-8?B?elhNZ3Z0ZlpuVWJvNEx6Q0Q1M2ptVEo5T3k2VjVmV2x6c1N1NEVxb3BTYlZD?=
 =?utf-8?B?RUxpSHV2dUxJRkNybCtmNmhSQ3k5ZjhNYndBUFVTWUNZZU5FVUdzMkZsMkY0?=
 =?utf-8?B?LzFwR3ZsRlozUGtQZXlYek8yS3drWnhNYmk2WmVsbDh6ZXRJRldrQUdxQTIr?=
 =?utf-8?B?THgvQVhtb2FjZFlsNDQ0VXllNnFNTEdYdGsyU3gyUUhyVnJndnk5WFdwN1Yv?=
 =?utf-8?B?dXEvc1FpWkh3L2s3UVVEZDVmM0kxYVFPTTQreEkyTVBCSjA0aDV0dmV2MlpQ?=
 =?utf-8?B?WmJ5ZTV4MUI0aFpxSDdISFllenhsTVRKWmpGZDZyV29hSWtKVjFIZEpvR0R2?=
 =?utf-8?B?ZGhuU09GQnVjNFRaMXV5dnFhL0ExR3RGaTNDNkwyNlBXei8zUHZGZTRaNGVY?=
 =?utf-8?B?VmlBNHVvNFZET1B3NEMrL3kwRU0rbnNrTmdmWDdGZ2h5cmJCNVhnOXh6TjJy?=
 =?utf-8?B?QnZoMjY0WVByUmhRSkpxc1JLZ3lsSmh3TG5ENS9zcnNxYlAxemJVdlhxZnJa?=
 =?utf-8?B?eHdVbGg5QVFuWE5mZXMrVGU4SXMwbG4xSTJWamJFa0MwbGR2ZEdKb1BNQlo3?=
 =?utf-8?B?TjI4VnBRUWh2bng1bHJSTE1KV2xlR3ZoaDBuZDBMb0YyZDZpcG94OXJZdnRL?=
 =?utf-8?B?SVljWTltdUdTSGh4Tzc3YVVGaGU4RmRPaERlZXhtUHNxMlJlSHJrbWFuRWxq?=
 =?utf-8?B?Z3VjWS9yMnFDUmlVWXpueE1JYmVuL2ltdjRqLzlTRlI4aWx6RGdTeWU5dlNQ?=
 =?utf-8?B?bDQrbS9rQldHaU0zTXdDSDErNXZPd2xiNk9uMUhZZ1oyZERtM05oODM2bC9E?=
 =?utf-8?B?eE5LRi9Kc1Y2V1BvdVR2STRjN1JWZ2h6TzE2blNaNGFrNk55ZnI0aVowVmdz?=
 =?utf-8?B?MXdwcXdMakFxV2U5NGpZdUpEZWUyZGFndVY5MkdHTzlIKzQ1Qk5OVjFOdHhw?=
 =?utf-8?B?NVVlUm4zY2lvcGJJSzV5SFZ3UkVicmxTbjhDZWJuWU1oRGtsbEZiVEtPdllG?=
 =?utf-8?B?d3J1cXUxVlByNHZvRTBtejZSVVdPdUQ0RHFqVkJRR2RnYk5mZlVMUW1rSFVs?=
 =?utf-8?B?UTdJRENRRHZNczFlVithVFB5aUtLV3plZkppZXpzb3lyMUczWDhaejdGR2V0?=
 =?utf-8?B?Vkg4NEF0SEM2TlVxUlptTllqY2VrU3hEcEVaMEFKQ0dQbFN1UEQzTjE4c1Vn?=
 =?utf-8?B?TzhSYXZMZ0R1anZZQlE0Mm10b0dvWWpQeEZ1QlBiOWMrRkJYcXdOeTBqOTA4?=
 =?utf-8?B?S2FQTUZMVmtYRWN3ZHFKVmdGczJkQ04wT0l3T25weGc1bVppRStEYVR2MjU2?=
 =?utf-8?B?cjQ1djAwNitmL0RtelArd1F1WTRjWEswQldnbnJLTFVCV2orZ3dHVlJON010?=
 =?utf-8?B?ODRsemc0TENRYVd3L0xpcGZIdGx6NVJvRGZ5M2U5YWdGS0FiSCtUdlZjd1Np?=
 =?utf-8?B?QUtBWEEvVG0zdHhtS2o3YnhUWmpTaHVhWGkwWndycXQxeEFEK01kQzRxclZz?=
 =?utf-8?B?ZXpoZ2FoZVp1bWh2WmdJa1RXTXFhN29YaFg5OGpxaStkVWdJMk44enVMbXg1?=
 =?utf-8?B?OXlka2VjS0RrTnV4VVBPMG5kRmRmb3lVcHhDYlNET3BlZkxPMTVEcUFlZTZP?=
 =?utf-8?B?eGtkM0ZTZ0RTVSt4TWprZW9NQVVQK0ZlNnA0TFMrakI3Nk9sMHNwVGxCY0RR?=
 =?utf-8?B?aTJGc0hiOFJYR0lVYUJsTzhtVWpnM3VaUmZZSWNCNVFZVkNPQzl1UzcxbjZS?=
 =?utf-8?B?SjVNSXJ2ZjhvREZ3OTlOMXVjdlRWa0luNENBaFJVT2Z4d1ZzdWZhSXZNVUkr?=
 =?utf-8?B?WjY3RFFyN2cxRSthUHBrNklsdUtkSmNteEkxUTk2cklVZElIYXlBV1dkRG4v?=
 =?utf-8?B?MWhEUTJSYVEzZFJtV2VONXdpbWZPdmd6WE4rOXJkQ1ExRlUyd25UeTVCbVBM?=
 =?utf-8?Q?EnnARL80MIp0mo3BIiKa5heyc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a340c6ca-91b4-4f56-a436-08dde9399407
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:26:06.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHEPX9iBXVFpngLp2t6BNAiCXRN9TaXjpQw1Y6H1hQXRWdqhWHdbGucjyQxEGaMHo0x3JRS93n/4c9M6y4sEEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6118

From: Jan Kiszka <jan.kiszka@siemens.com>

The result field of an RPMB frame will have bit 7 set as soon as the
write counter reached its limit (0xffffffff) - even if the operation was
successful. Handle that correctly to avoid false error reports.

This was found and fixed over the RPMB model of QEMU after adjusting it 
to expire earlier.

Fixes: c6cb053ec59e ("mmc-utils: RPMB: add support for 4 rpmb operations")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use operation result mask, rather than masking out the counter status
 - handle all result evaluation equally, even if not practically needed
 - massage commit message

 mmc_cmds.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 16c6b2e..429a9c7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2103,6 +2103,8 @@ enum rpmb_op_type {
 	MMC_RPMB_READ_RESP = 0x05
 };
 
+#define RPMB_OP_RESULT_MASK		0x7f
+
 struct rpmb_frame {
 	u_int8_t  stuff[196];           /* Bytes 511 - 316 */
 	u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
@@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 			   be16toh(frame_out.result));
 		exit(1);
@@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		*cnt = 0;
 		return be16toh(frame_out.result);
 	}
@@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out_p[blocks_cnt - 1].result != 0) {
+	if ((frame_out_p[blocks_cnt - 1].result &
+	     htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 			   be16toh(frame_out_p[blocks_cnt - 1].result));
 		exit(1);
@@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 		       be16toh(frame_out.result));
 	}
@@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n", be16toh(frame_out.result));
 		goto out;
 	}
@@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	}
 
 	/* Check RPMB response */
-	if (frame_out.result != 0) {
+	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
 		printf("RPMB operation failed, retcode 0x%04x\n",
 			   be16toh(frame_out.result));
 		exit(1);
-- 
2.43.0
