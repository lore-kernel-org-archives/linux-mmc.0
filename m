Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795374361;
	b=I+Yo6ZOoOVcjfZ1ikg/iv4F5dDN8VIktdii/EPry2DbJYV2V7118+yShbA9q/dnlSwmc
	 TLHZ+xwLgfQ0InFmmCjnyugBPhXBjQq8Jyzhg7fvoj4YN1MkofLvJ4X4LNqQ0mBle8jo9
	 3HYIEMRDS9d0x1G5Sjeh32HRmM3IdxcB6jRN0OxKqneulGXOhutqoNS3eTxwUlpYmy7kQ
	 klkhmSgMHcq5n5qUoCEFlIEoGGu/1likdJVe4+us4u9em/Gqf9EiRz1rHQCTe7louCynm
	 FTdOMczniowY3C0P8tREz74NT/eHVQ2UnTt/snXpwDN8MxPervksW3P/rehPkwJgEIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374361;
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
	bh=CgCRyOx1AVHQEPyNaJ6YCvgdpkkxZZGiDgwP/XJnt+Y=;
	b=rBh48x2e+umLn6sdnRJVzb0xo3U3QO/ZWanOWnjVg5GSdYuVmalBSichTvQpMFyk8Ss/
	 Y1IA8xJ38Xo3KLlNh+cIXQJCS94ifQokPawiPukScqfQv/abgxSOUcWViGF8W4nliR6fc
	 OLYthHa8i6aC5F9adtJ7M69XF9s/SLmjGzHLyPlfzglYO+uoorERI4xnDqLTRD+0Gl3Ei
	 Mfk+VJhImL6zbUj3wMLMSc/SsQ0fpYPcZUBhbxw9z2obxX0kGfFCkK3RJBCMJPNqOBt1I
	 Oaqe2FSJQO8M1CoBQsUqp3lp0rO06kDeYMhSw+7coxeufikTuMvzXER1tBRBpAtCcGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=AS4qwreD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.18
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C8606A32A;
	Sun, 22 Nov 2026 19:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5C8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=AS4qwreD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FObtbRyKDtSBetkaOOZvwxylwK0kvRAZf5F+lnfXk2R7L0ViJWxtvcg7VWa5bCSIEVfiH5UgTmLbF9t7Q2oY6los8c7qWoYTJYRpV6qjZ2KpklNAI5f1sPADgpOqsT6/4loz//wFQRn2GIz/6qqtpAQQ8s8HMcw7r9asY9nTU6LoYFZlqRA6VbEoaWUCQel75/6KuCnKvzm7+qWpI/Sz0ouDs3JdrhZP0IaZoYY8yp0v1iudRoq2B7k9qpbomXZV/ErKIZNPD/qOEbgfBaxqZnij/X01ySAnrIjcowe0gZlI/LM36Wj+Z8Pnq4Z/Kb4kE4lYdHAbQm4raoSspoTvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgCRyOx1AVHQEPyNaJ6YCvgdpkkxZZGiDgwP/XJnt+Y=;
 b=jIz/1LtDIN8Idte+y5tgnhFZVQX05NOHgAowU8QslaokEtAk5WVgnn9tESchlSJcF0bYuzYTVm1dVL6hj43idNNmV1YWwehT+msXyymIzIiM8/Yk8q3I4bl9vZrPlz81tryIHoga9SstrgShI8y4sxAnKug6WDY01UvfdkHk/wQ/gwfMY1DcATY5wcioZSa6qwn4JZxLk8QBtBvnIu5RQL7Y7R4aCGEhdoA7cwxSRRrEgMgXBzkqgLYsKh270Lv0zUPqaEWmwLnzXZsYzdL7384GHJSIsBkgwO6saSBVclvCtHTJRJgFxnAwn3ZmNmP6tu9+svCZj64Y7rIHgRIhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgCRyOx1AVHQEPyNaJ6YCvgdpkkxZZGiDgwP/XJnt+Y=;
 b=AS4qwreDWrVUrqV9De+mbFAooL7CPODy3tf9kFIJOjYAwoGTACZEGdNq7XJ5tV0aSw2huGzTXOaD8/qqgqWKNk7xhdmE0hmtSi0ei4IhyzkVR/1pU2e4GKWxAuZNrmbWcuxQdbHVNrrYhoo1n6UBqjS8d7cCm6wDXk/w8zLIBgB4sp8i9T+XjWfBpXnKeYlpXTA32Hi1op6zxAgS7ZG7O0T019C7IVxMtrCzpROnOeLe3Y5aSS0CSD/Tz3MM3mldBi4LOwUCMKgqewe2Q6EbWD/5JiaJQszXgxMAKT1bbF7NoWFqGtyLdKN4nlShgeG5BG8TMwapoNlg9lfrdH/btw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN6PR03MB7575.namprd03.prod.outlook.com (2603:10b6:208:500::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 19:05:56 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0639.011; Sun, 22 Nov 2026
 19:05:56 +0000
Message-ID: <5de1ad0d-ef89-49e4-9195-195be48d57bf@altera.com>
Date: Mon, 23 Nov 2026 00:35:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a96433a2-0274-41a4-01dd-08df48cba306
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	j2vgFdxgZyB9k2V3/h+pphUGIJ/Jyh24pw2MMjPjW9vbdrUCv9MAYG8jkIiFNS5urJFReLtzRrojkcEJ3URCDMlV+tLF+XfuOVYChXi3S9b9imx2j7gMEIi9in/JhDrY++5wHowjz/O7V0l6WQarBAh8jx+VYiVIJRVjtbeW1Xp5Nau7qIRgNIpPN9fLFwWOrhPUyr15KM5VVSRjjuTZk38kzLgFJd2JkJtS/3+jdH59v9ewZ6xGyiIENTPywOJIjj4okPz7/rFtUzPROmJAAkRqErkBITwan2CNuqbB6U3ODcU7y4KEhHlH2VfOx7KKnbWimyJG9fL+E4hktFOBFWAZaRpa7jZQljjSr8w/smGJ3dbxhZItf+XIJGyvMWq5/QH/xDPp8pLveCKVta91ICQM6Bs4bAR1yAoAAoxKDvFKI52pZla3J+m2+Z6UyKSjdOfzPItraBWRXpovFj487/yNVuCFYXT8vjcwRIhxvVQ9baRghwpbHMtWcH5t92+3Xf1glccOMesn7hPW+OnUNcESgto2GxLI87hFi1ziiHO7bEdTf60WvKixwCP+d+OLZScBOGuina0UlVc70A99SCrD/D+U9kS9B0QT9v/HXG2AB6v22C+aXqkLfel1LcWjE2/NTmLL4bTfhuPZeoFkFubgD6Dr9JBFwn0AC0764Y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytNSDRpVUg2YnVyeDRFL21XQXhkemxabitLOTkvWTBjT3RIQTkrcTNQeUMv?=
 =?utf-8?B?NmpCR3VSTTJXenZCazBIYXRZV0FIeUpONG9yVm1ST0pIeDVrQzRRMTRuY0ZO?=
 =?utf-8?B?a1c3WG9jbzIzVy9WeEZtQStXeURzcktRcEpMSGhyM0p5cld2SmJrdzl4RGwr?=
 =?utf-8?B?YXVNS2hqTUV1VnpxY1AzYnJlckJjS3IyR1dCMGJkVFJWOEE1azZrMG5QczFQ?=
 =?utf-8?B?SFRtYk8yeDVKQUZnZ3R5VkRKaWlCcUZsVEdYYnkvVjBMd0M0Z211THQ1UFdl?=
 =?utf-8?B?SHZyNWRzRCswM3FjdlVtS0dxVXhpYTh1L3dEWmFlM0V0WC9BQUFzcUNTdGU3?=
 =?utf-8?B?R3B4SVhacllRd21GL2xIQW1yeHBBVEc2bnRxS2thLzUxeXd1OW5BU3AxTzN5?=
 =?utf-8?B?blRxVFZSSjV5Z1puS3pTKy9HVHplZElIaExRak5xSlFaQm5aYWpmYXl0V0VZ?=
 =?utf-8?B?VUZ0cmI4Yk9mQ0U0Yjc1UkVCWm9KTGxsWlB2VlNsTmxEWlY5MjBMZnQweVZB?=
 =?utf-8?B?eEdlUDdkRGFNK0JRZGo0OWEyV0xKVjB0M0w5WUZTZXVwTTNiZTdGTWJzVHhq?=
 =?utf-8?B?ZHdOaUhMaVRjbGFHSjE2TW1SUkNaU3JVS1I1OE84ZjFxRENTdFdYOEIxVnVS?=
 =?utf-8?B?aWE3b2Mzb3dkV0JuK0ViVUlIT3BrVTV2YnlucldzR3E4dlpudUdHNkJrbWwv?=
 =?utf-8?B?amQrRnpuMG9XRklZWGRFN0VnZ0pZc1gyazlMNTZPMzJGNy9uR0cyYzkzcGFq?=
 =?utf-8?B?TzkvQzhxYWJTZjdBOW95T24wNnA0bzNNbHZUcDA3Z2ZiU0hJSnRLSDAzNjV5?=
 =?utf-8?B?MnYxVEpxMEsycnFnYnMyWUJjVkdzaUZCbXhJWE5sMmhtbjlyZUYwbThOY3do?=
 =?utf-8?B?Qi9rc1lGdkV2cHRuSDduTG01TDVLc1E2REMwK2QraVJRTmJlVjFHcGFHL2hH?=
 =?utf-8?B?ZzVOa3E3emtlbHFCQUhleHFrUVNLdzZnNkxxN3hwc0FtdEhJSnBzdW1TVDFH?=
 =?utf-8?B?Q0R3R2haSS91MkxES0JKNXJmSzB6SVZCcWFQV0VTUXJOT2RyQkdveFFteG9F?=
 =?utf-8?B?b1kxdzhqOHh3TExhcDBVZGh0NTZackFyZlViZHpxVmZmejVTY1E2TmNidFFW?=
 =?utf-8?B?SjViQUlIK0FQUWgvWWNjYkFoSmErMWhNOVVqTVBYOUdzVm5JYkoxSkE0QVZp?=
 =?utf-8?B?N1FvUUtzbEs5YTRaWWZMcUt6ZHl3V1E5K2V6MDNaaUwzWHdQak9MQXRQeHhU?=
 =?utf-8?B?QzZlNnJVR3JlUENPR2pIUjdxK0R1SlhFVG9MUHgwMEJML2hWWnBrVmpHUFpR?=
 =?utf-8?B?YkM5ZFk5c2JoRzJCZ2p1b2FMNmFGeVBFbHZnNmRHMlBzN2hKdlNMWTg5M0lQ?=
 =?utf-8?B?d0k4N3N1d1NiUUNXRm5Mck5XcDR6L2tDaTJCUEdqV2MzVjZjRnRScWpJY0Nu?=
 =?utf-8?B?cERtUEtDSnN5MjM5TlE5T3EvTXIvamNpTS93Mk5Yb2tOb0dqdEJ3TDBHWk1z?=
 =?utf-8?B?RndMZ1dIbnVuQmh6aDBtS1Q3RFBJMFBtbjltdlFjUzlTWnBYK2g3VTFQUEo1?=
 =?utf-8?B?ZC9DNEVJUHFuL3FqNFkwSzNlMmVOUnZsNDl1cXJkcUdYTC9GU0pEVTdob2lO?=
 =?utf-8?B?VEdFV1RqdFcwalErSVRBQ1FqUTVEYTdUVGI2Y1FIcW4vdEpKQ1JJdnliY2dD?=
 =?utf-8?B?UllndmpaMjNJY2lVbmx5VUdBZDdteEhHbWFBdzRTbGlCR1FwOHFaVklDWXlL?=
 =?utf-8?B?S0lTZnlENDlPWjB3TG42a3o3L2w0VHpZRG9jQ2JrZTY4Z1VKamEzRTRmMEZk?=
 =?utf-8?B?Uzc1UFRuUjBjMTJRQ0RSWEwwR3V5VFhLTGh1QmwxM3AwME9yOGZzMkNwbEhq?=
 =?utf-8?B?S3VUSEY0VFRMMVl6cGdQQVZ2WmttazVmS1RxWmNVSnkySmpaYnYrb3FHVUVz?=
 =?utf-8?B?dEt4NDlvTERONVc3dERvTzhXVGlBa2NqWEhjQlJDd0FySEprQi9ZMEJXclZT?=
 =?utf-8?B?MFhJNWRkdXN6SzBvUVFzUnJZL21POFZ3RmNYMGtmUDJrZk1mckJ1Y2VrMFdp?=
 =?utf-8?B?blVNSmphVmc3MjdNbHRzU29Rd1p6UXdsT0NHdUVZd2VDUG8wL1c2eWFHc2tL?=
 =?utf-8?B?dTFwOWZDYU93NlhjdU5zbEJXZjJhdlhIeEZNUDE5bXF2L3NEd011SmJ4QXdR?=
 =?utf-8?B?TEhHVGp6OHBmY2QrYjRoRU5OT1NtQzZqYklwMlVVV1QwSmxBVkttV1F3WHJC?=
 =?utf-8?B?R3ZYTFVpV05CMUZDSy9vbU5RSlUrMGZOUVk0RzBLMHN6bGp1ejliTW8yL0RL?=
 =?utf-8?B?N3dhbFdxN042U2ladkVsMnFiSHJiWmpsaTJSQW9uN2MrZ1hqZTMrYWFReUFp?=
 =?utf-8?Q?QwPfFnb3f6SfAVxk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96433a2-0274-41a4-01dd-08df48cba306
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 19:05:56.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBEyxjibDnwIgCiO3rCM7uTf5H5ftfyxKyTLs9xYqdSW5loBQPMJeYZJ0OdjuIXxAGNOtnEfuOMN8hZBgwHxwmI+ipRVYIjHmWZji6jL0vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7575


On 19-11-2026 15:15, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
> static, board/SoC-characterised PHY settings. Add two optional SD6HC
> properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):
>

I went through the Cadence SD/eMMC DLL PHY IP user guide (IP6185,
rev 1.03) to understand how the delay applies to each of the read
strobes, so that is why this comes up on v4.

The guide marks phony DQS "not used for SD/eMMC" (Fig 2.1), lists
use_lpbk_dqs and use_ext_lpbk_dqs as "Mandatory setting for SD/eMMC",
and says external loopback needs no 1/4 cycle delay on the slave DLL.

Either strobe can capture a DDR read if its edge lands inside the
card's valid data window, but the delay has to be chosen for that
strobe. The delay is what moves the edge into the window, and the two
strobes should not take the same value.

External loopback goes out through the pads and the board and comes
back, so most of the round-trip delay is already in the strobe. It
should need little or no extra delay.

Phony DQS is generated inside the PHY, so none of that round trip is
in it. It likely needs a larger delay to meet data that did travel
through the pads, the board and the card.

Questions:
1. Do DDR50 and DDR52 work with the defaults (loopback DQS, read
    delay 0)? If not, what fails?
2. Did you sweep the read DQS delay with loopback selected?

