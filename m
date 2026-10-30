Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793343878;
	b=OqYkhgKh2QcwJBKolWqZ2P8RgJywOyyzl7skkBYtS5GYWD9sLUdO40r5qd06auvEZ8P+
	 ljq02cGVCwA7PZXTNaDndaZ3AEswWV0CmFIlfxRfWNC+tMrw38O8f5aT72mg8BqxlWZbc
	 0wbY0Z7Z/QSNwrgsGdslejnZjGhI1SUhffzMb1u17DFnrTjlwo5mW7UA5AFrr+SNuDaCd
	 j93KmEtwsKbIecml2GvRDg6eA5kXa5QOrm+r4JEiuVHnHXvj0Jgv6bd+r3I5o9H0OmVN4
	 +6cb3SIWHwP+OsLyLUjn2hHv43zF4IVeRQWvvIH+tEhklsnW2QyLDh7hJXAC9a2jh+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343878;
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
	bh=n9JSutIA6orKanmW5jULk4mHcvWR69vKLqdK02WZ5As=;
	b=26E7D7Z5jfVOXMggydgzEKvE6+h/e1+4dn68Ny5Eu7MY8UzoUKVunEvyP3P+rZBstCvO
	 gyqD9h/6Cj9h2XcWpw716klovPIL28PyIQ6HPzu7WqZQeVpWycHmaWmGuHVwYahPexdHV
	 ExoRGl9RHBK5Mzdp5YQC0o4kwShpEaXzKQqiT2S15zpqYdrrno0R25M8bcBBWLiELS/nW
	 OW0x1c/MFLsrpPdzHdg2QiMnHvBXzdL96+Io2o5sxA0K7mCUaXVNEIAcZ3ZS2T/zO7n+V
	 Uapz57fSXVDevJePm16KJeapHWES+VQzqLfeH9vnk3S3riborLNA6hnvy+wrkD2RjyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QbA1EwG6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D7606A31A;
	Fri, 30 Oct 2026 07:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QbA1EwG6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Koxqw46aXbO0g8hmZhPCQswkvbl8mAF9vsHB+ejUyRiHYxRpLjY5Tw0bk/MNNp3grjzkzeENNyVRCW2uyKnHlBldeuVT0QqkJcpWIrmSZA5h99siv4ZqzyyVkt98UIY9Vc9HanMVRVdlcBljVy758fxotK766gk+sZSP+Ea6SMYMq4SUEPrpg/F/URaFboJwOko0JpY/0pJqGUBuG1rbMDPwK8AkdfZQvW3QEWH1+1WescCYRBxgbbzp0URJMlOe6aM7eWC2z2KkUowQ4AjLIcZCckJwaP3JX9DkWiJfEg4opeViYOd0+li1IH4PUTcDbXELtpWkl94dGfvRT0e7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9JSutIA6orKanmW5jULk4mHcvWR69vKLqdK02WZ5As=;
 b=sugvu8sP9OtbitK/GBAqRgeAwVAgg2LCailPnHke2MEAWFtEPKmDrH1eHdCh6CmRy5vjm+iyuBjEgzaqyjzSXs5e+vJnh2zATfn9VkGjIvqIimX6EofluWg+KjBW670Tb/Dg+XpD7VYvyNar6NbV6/0wfDZgucBB2CsSeofQYvQ1Qtxw6Z7EOUm1c3gECg90bqpfQ0Q/NZ5+co9H01c8s3wzMuL1uBvReN8AxuWsMg1tcpaAPxN1/wQhMPeOCtqCvIBwZUHBvtP42hVJu7DnBHAFGuchbdRQPKFrAz+fmLIGvWkZFwNgrnD4O3rTtvkGuDMvlffdYbNOAbM2rWIa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9JSutIA6orKanmW5jULk4mHcvWR69vKLqdK02WZ5As=;
 b=QbA1EwG6sTFq+jiR3hIqJIVGDOfvLAIHOBr3SUZjydKJzLo+FM7N0ouUi4ECN6kLLSTa/mwUqJdgfFXHcYYMniE9f6N3Aegir8vpXq7yBwEZ8Oy1rwnLKSSqmoX7dCjak+kuZqZ7XThc8Fgl99JilNLQa1que53yv9ZrrwRWyv08zMLEN3jZvjcwjdyP2iWOvVhyyXRNSq6KbPqhv/4hZGsWmHBpRKlpuMAt0sgSZMTzF6IS5bOqNVJoDO55hCivjfkovEgNJCW3eKWaYWi/mwc6bOpwhu7IoVVSTbCGJI+NrlI3Uoat4JATJjc6CM/PoxLRaKA89VB/ulS9+YyGig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by SJ0PR03MB5472.namprd03.prod.outlook.com (2603:10b6:a03:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:04:33 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 07:04:33 +0000
Message-ID: <f22270ec-a44b-4836-a0a1-5c7c3b10ce5f@altera.com>
Date: Fri, 30 Oct 2026 12:34:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci-cadence: add PHY settle after tuning
 for SD6HC
To: "NG, TZE YEE" <tze.yee.ng@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
 <dab17adc-1691-463f-bb85-7d1276fbf28f@altera.com>
 <2723bf11-8477-4f52-a95c-4ede190ecbd5@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <2723bf11-8477-4f52-a95c-4ede190ecbd5@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::9) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|SJ0PR03MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: b25a13c0-901c-44cd-8cf1-08df36540c7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IS5f9wmw43G4jNfMVlMI1/WRXJEIBuoz+Z8zEm6sS8qchvDMuul7IR70NOKkDHCev3mPT2Hv6Sp0EHs7nYtSTc9FEAPJKK1K5HvYMHL3em0ZpIgpFTZEOGUDopZc5T69L7H/8lnFOqyhUXBaAY+rD+69P7ezG6bDoiNeZYXvYVIl8SeHEO7Qx+Q6mmn2k6eO4aiubtCoZufOZhaZdFfq7m9c1yiMxF3Uwg0yvQCauHbF1YpE5+9u3SC1+WVgTO88LZulVX+Azp7YcVAv3y2+elmxXAmhq6Pee1uCkjB/t3TtczIabdt8hIa4ibQZfZNyJPfl/kGGKP4XMQUOKI7DYAxEeNnf1v49SGgmTt4U2I2ifrWAXtRILuTToz8oKll30FOGhYh4VofRyCxAEIR+vfoStnG31YpK2OWKNVi5RTF2D0PfN3XkCCM4JUnF4YqI95YkqbM0H73mserFyEvsu/eT4Bs61veHSiqm086uwCkPcRDN6N7XELDW5gaZBosXvjdyEhQ1dpxusQujGp/9tens0Kk3KydEGoG6V3Bl2TiZTTfwjSYcSK9naHUyHCclAg2+EZbcImtRusNzbUOSZTyF/b9k+tfvvqdOGCg1Atsc8uX2S4IegPrBctDkxBWDHbX5E7rGWjXzlBhDoMCuDsAofl0vx4ny4PvYO8Ju8Dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6204.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXFTVXE3azhRT0hrcjUwVmxFeEgrWDBBaTBibFlPaFFjenpqZE5VRWkyNzhu?=
 =?utf-8?B?TVd5TWE0ck9BR25JV2FYMmVscTBnOW5LaEx3Vkw3MjVkeklqWkowYmFjZ3Qz?=
 =?utf-8?B?c015bm5hQVJEdjBORnM3L29XY0xUVVV2UEpCTVJTRXQyR21pdkdRWUIwVmh4?=
 =?utf-8?B?bGZ2QWhyRGxMYXFUTjg5cFJmN2RCZVloS0lDd1BabERwVDQyRGVCOWNMWDFZ?=
 =?utf-8?B?QXdMcmozMDQ0di9WZzZ1YmF6WDZjS0FtUkZiMHZaNit6QmhMVDNqbTYra2dy?=
 =?utf-8?B?R3dqQnlBeTZMc3E2eDJZUS9kT3M0MjZJNGlQQ3NPa3Z0eHVINFRQK1lPODRP?=
 =?utf-8?B?WWk4aEpHaFhmTmFrVGFuYW9wTWMwSVgvYnVWRkZkM3RlMEtMT3p2Nzkvdi9o?=
 =?utf-8?B?dVFBbzlJQ0VwMmw4Tm9iSUwxYTRNd0ZnTFJqTTE2WGVhQVV4WkQzT2V1Ym50?=
 =?utf-8?B?YlVBM3FZY2VsYmRkaHZNWTdzZVRDNDNGVlJFbWxNb21ERk5MdGJqWkhDSS9n?=
 =?utf-8?B?Y0NQVksxNVdBZStBak0vUnM2MmxtREZ6dVB1MGlvRFViSkt2Zk5VSHN0TkYx?=
 =?utf-8?B?VGlDTklzU1dWb0I0OUdabGVnaitNZ3ZQdzFLNzdVcFFnNnFSaTN2U2lKSWpX?=
 =?utf-8?B?U0VpYitZUXZ4SUxKMXVhU2xFS1B2dVY1RW1mT0lZWUVmOHZMK3JEaXh3TFJh?=
 =?utf-8?B?Y1g5R1VXblQ2clpQU3VwSnEvRmZQUWxBblMyU3BXN1hkTldxYnJDYzU2eFZY?=
 =?utf-8?B?Uk01dUJaeUVUdE9iNDBJSm9PcFM2U0IxMFFGdEt5c2tmc1J4ZVlvd1d6amh2?=
 =?utf-8?B?S25mQWVuVkxKeTZmaWFzdERRVFhBL0QrbG1aMFk2WXhBQnhEdEluRXdEUUN2?=
 =?utf-8?B?N0FGOXVxOVVLRkZ3a2hESEx3RnA3ZCs4YzE3ODk3OU1nLzcxbERrSFNabjlU?=
 =?utf-8?B?K01WUmkxWHNPM2ZiLzI1dWNsV1J6N1lsWUZpc1lLbEp6SGdpWFZ1ZWhXVEkz?=
 =?utf-8?B?VlIvWjVNZlA1dFlZdHc1Q2NzRU5JZ2VlTS9mdjQxTHY2OFU2MGVlbTVUVzY4?=
 =?utf-8?B?SHdKeG5WL3JNMGJQZFM5MVdLNUVzMlVkVmY5WGZQSlZhQmI2dFNNckFMUFFN?=
 =?utf-8?B?aFNEMUdEWWFISHZHTGdyRTdkNHJkQXFaSjZxbnVQNDZoVFRSQlJ3UGVkSERj?=
 =?utf-8?B?MHk0bDhWajB4OERTRExoa3ovMGo0T1NwTUZzMXphb2FJeVNrMmg3VVd4ZnJI?=
 =?utf-8?B?VVZ4TXZrTVNIK2pzZUlWVlpERG0yRUtpUlR4SG5QMVZKdEdCQTgyM05uR3dL?=
 =?utf-8?B?UFN4SUJOMGp5UjBUclpva242eDRQQ0psdE5hOFlzdmM4VURDRC83RDliOVpT?=
 =?utf-8?B?SnZEK2psN0VFMnNlQzR2SjB6ZkpDMmUyYXg4ZkNrYVJSVTJRcFNFUTJkWEJ4?=
 =?utf-8?B?ZUE0VFFSMDByL2pub3B4R2xyamsyeHhEVnlkbnVMVkk2R1ZWcXRzUzQreHlK?=
 =?utf-8?B?TitmVHorL1dNZStnS0hKQitLNFE2OVNXNVhIWWJ0NlRUK1AwazF6K2o5R09U?=
 =?utf-8?B?TFdUSEdjVmJZTEliTHludjZhR2xXYTh5TmtDTUtST3Z5OVVpZFJUbXNyZ0ww?=
 =?utf-8?B?TjZVUU54Si9WMFFWN3AvNW9LNWx5b0REMS9KNXdzdnY2L3BMbTE5T2FFZjEz?=
 =?utf-8?B?eGYrWTgxTTJETDVoT2pNY3J1ZzB1VUhHN1VJbk1jT2hrT0M3VTh3Y0Z5anUw?=
 =?utf-8?B?Wmk1NlRJejJLLy9RNXp3aE1XRWhoZHhjRnk2ZWlJR2FUNWJYTC85Smk4WGtn?=
 =?utf-8?B?SUFzV1EyZEsxeUFmK1ZjcFArc25GaUFEVVhkam4yOS8zaVNFU1M5Ym5jV05M?=
 =?utf-8?B?TVBEY1RiYVA2UzVTRDc5ZEZVU1V0aFVZZTVTMWc5QWYrMGFjWnYxdUF0M053?=
 =?utf-8?B?ZENoRFpzUWM5RVRWUFcyUWVjcG8vQTFqU3pmT0NQR05wbXdDcVpkNlN3dmdL?=
 =?utf-8?B?TUxIWjZ2Y0ZSNDc1dG54d2l4d2Z0M2Y5UzRudkNjTU1EVTk5VFlqZFNuaGdM?=
 =?utf-8?B?Y01mVlBYL2Y0MWpUNndaT2tuT2duZXc2SEdSVFl4L2pGMHNzalFJNlBzN0Nl?=
 =?utf-8?B?TWZPak8yQnk5dzhJZWJLaTJRTE5qVU1SMk9LK1M0NEZBNjhKNUZadGpMTlNs?=
 =?utf-8?B?TGQ0U29XaE9uT0ptdzNpS25yY2g0QWV4cmtOaEFSR3psN3RWcmc0R0FPR0RX?=
 =?utf-8?B?V2htTzBveVhuRFhaRGdZdEhrbXRPc1Y1M21kSy9aeWlRbVBEZlFRQ1l4NlJY?=
 =?utf-8?B?RHJjalpzUExFNHVGNlFaSm5kYVR2bFhIaU0yNHl5ZFFBUS8wYUx6VkFSQUxv?=
 =?utf-8?Q?+Uwcx5n1iC8Q/Etc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25a13c0-901c-44cd-8cf1-08df36540c7b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:04:33.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8vBZK5KcU8QoeIdOmovC+JrrxoHg4DRvRl1+2WQcvlptT9kiiJF7Ab6BRabytYwj6ecuVfRl4OoM5xTCQL6gQq7oOkmcSUE1s7e4axAmAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5472


On 30-10-2026 10:55, NG, TZE YEE wrote:
> Hi Tanmay,
>
> Thanks for the detailed walk-through against the spec, it matches what
> I see on the hardware.
>
>

Hi Tze,

Thanks for testing this, and I'm glad the abort approach worked on your
board. The HS400 and SDR104 results, and the ftrace showing CMD12 after
the failing CMD21, are exactly the confirmation I was looking for.

I had already written this change while going through the tuning path,
and I was planning to send it over the weekend once the remaining
checks were done. Since you may already be folding the same fix into
v3, how would you like to proceed? I'm happy to send the patch, or
if you would rather carry it yourself, please add a Suggested-by tag.

Regards,
Tanmay
