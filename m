Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073861;
	b=CX4ggvKnL8Fce808pnR2XiJ1o1+2sFqQo4YBXrRtYjBFuOinVrft6QYB0HIoDrG7BwQ2
	 /Sg9PX1WOeHvBa9edtLwmJU4QmINrowWNObz4XRGPy042+syW/ynnvGQuBTTmuDmfd055
	 QS0t2kG4e/UZRQLc5+NDTBCDnjx5zXkf8v+6FulR6jXLksOsnRW4udXS5DQJ0/AsEnBt9
	 qqWTP2Z54stbGQROYfqgwxY+3TVI4QL+qYICC+jPJ6mUmNJkzVVnO9L4b6XH/ND1Vdvlr
	 oxWcpBVYZPjeUULaQKEE9dS05g+k0Z+VHKF9oaHbwC1GptLWHxo6zkftcUQWEeWilTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073861;
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
	bh=u4GwWn/WurhtuypMhkUMR7EFcxOGDjtSFtvGkNNRUkM=;
	b=wtfDlWRMMx7H3HJflqOaq1E/yiXgvD+5tKAPjxMDoszmDoEHtF1UdH3VDw6tICXPIhAU
	 i3/tPO1ixXjngLlsEub2OTMnGchctbMkMIJ/4+QFaMSgtVhgmCp/jXWwllrSCYwXWkOoR
	 2LOIGO40+FzL1DjANjlIE8pKLbRSEEznNznsP3gsost0voLdYDyGbVVBljCNCIbfDRTcj
	 /rZzlqOYPvd+R6OANcCx/nCqlIUYZXdDD2h9tsCcx2w64OM4dHt+kdQ8uMpgdNnJ4Zjl5
	 g4rw/htDdx1Fa8I/JybjiEpN7vJf6N9e2uexmgOIxjrrAVxBPJYtUjR8w155clpK7Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=KBvmkx5O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.11
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF2606A320;
	Thu, 19 Nov 2026 07:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBF2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=KBvmkx5O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZBC+AqR0u7qNo4L7q8opz4q2Ot4CtPymy8fz3fQvPqaBUXuM8zVCaFUFLX35L6Hk/kvIzED9Axq2QOmIFgQzrvTnnGv16774XGh1JvBkWIzh31k00fW2vqnjpJ1BhqFUvdUGUf2K1hB5YhCd3FYGLyi+QwHH9De2io+jTRF3n7ccuzAwRCPZctVw5GaW6W22KxrLTykshYDChKnO4yVIv4QgWaBAnL1IbFIc1snWZYgDjPONom5qyQ40wGWvSWNNOujrQMV5sllAaEjQovlFTgiYpFdJEbkiZeB5SlP/o1jWnlrkPMTA1x/+SvIz9ASFEP6gVuv+wKLEWXA9LESWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4GwWn/WurhtuypMhkUMR7EFcxOGDjtSFtvGkNNRUkM=;
 b=pHMb2olxXOj3rwA6MbkZPhAnF1YQ8imYzuIGPaZsR02deAgqwlfPaEq6MxaZ6R6nrLfDfiTQlbd636mzi+nlU0eSD9jcopjDgcHo56Z6c0Ki2+0dDop+Y8m+c12hVl+suu3Lyg8T7U51Q7W1sNidQ1hU/A+WTodm37fGffsXVir81NTbXlRxpzfXCaFH8IKrN04MM5okESUOc3VM/Cu6zoYQH+RCn0OyPnm9A0oyE1wxnSyzLq50ISUFlhDZh48l05EdIYr/mVWzSAiHWVLY6wmRV9+uRcKrvhq67jjysD3JvFfHs4qCXUMnQGHEusx4qdRM2TZFqogUKkyPEgoYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4GwWn/WurhtuypMhkUMR7EFcxOGDjtSFtvGkNNRUkM=;
 b=KBvmkx5OfwpRRirb88G0kfUmIfnPLLS5b0X6qrAlF2WgKetf8HCm/GmVbD6ZXzDzcGVAUyJd68fJm6nlsmZQC3/BpfkaXX1YYrvmA5bp/u/sQH/LJsDgCGjnNWq9gjtRxWnOk5dLghCsR6M+shm3LlxLMf30RK9hj3QSk6c7OJd1gHW27o8rVfmv3su+IXMW0bHWMjLtl+ywE83A8Q+txtiZLqz7XzbgGl51Ch4b1e0yT5P3m4k69s/Rl5cgLipjdv2a2eyxTUVhgCixwwu+KSayyqUeIIi6kXlUuxMhEkBYcZDMfWyRv4F7IaZXh++fDjtfuG4eiOBVs9ChVjcSDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH7PR03MB7323.namprd03.prod.outlook.com (2603:10b6:510:2f6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:37:38 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 07:37:38 +0000
Message-ID: <c1d9ab38-1342-4fa2-948a-e8e8d1e312ba@altera.com>
Date: Thu, 19 Nov 2026 15:37:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-2-cb50afece614@altera.com>
 <da0da5ca-164e-45cf-8921-598d67d6a42b@altera.com>
 <7879888a-b4cd-4c45-bb92-8db776f10d8d@altera.com>
 <fa378079-aedc-4848-9e29-2d55c4a30d64@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <fa378079-aedc-4848-9e29-2d55c4a30d64@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH7PR03MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: cc380d1e-9d04-4b1b-f3bf-08df460ffc5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|921020|5023799004|261022105027099003|4143699003|261026121527099003|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003|261022115727099003|261026140227099003|261022113327099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g2lGI+oXnmK0nQGHODJ2uxeAsI/1f+flBlxmfY2HWGjMjyOPJwdtU3rersQjNuEBgG3pxMF7Ctl/olSnfUVwBtWLv+3yKdiV0FOnUsYBTW7TPFZx/ST7p/opevZXYbQBp2Jx0yZiDyL7/ah5cca8TMvZ3TR0hWG1Xu2pyvXe9HXEO6FLC2gekqAGZCLsoIe0CL2RkLOv7/4q5nsbs+SWEGOeMZ8zRrt0MHDgRGbfIxO6qKikas5pUrvhQ1RVDOvPxChOwGl1r1TFs5bM8WeDlcfT7nvliF+6PKJ60untXY48vEqqg0IzRjlsMG8aeXB5WF3n45SFtCI2HDbA+T9jJ4j8e4sQGk7CAruJ/1Nm7mAjtuiN6bXDeJIfR/SRxes8lBkFvjUDFXPngfxqRdy+F7yuCUCnhYvYLclL/zXDdo4oTEr7VSGCZehoyNzMBWB9lKpUQpqrc2WqLIAwULAV+pDyccvNvSr0RO5PaNd8Pt01uTh/1vrZGSvkUOIUIjHkLJljyOcbRygP44ZiU6HFaseS/hwwl5+zDfkT4Q8I+tEXPNEDvuJLWJelP1FQNXMHFD4wDCLoTIvF2oNYny0GIQMVZwLC8pdxKWowA6c7NYIXU5PPXQSoIU5+c11VnurFAOUN/FcgFUq0slPeWGL72hAEzWGfFcH5zg3oe3BbmDHeMg9GE9Joja9Chi7BGQVS6/osppmzq1tVbPz1oDsdoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(921020)(5023799004)(261022105027099003)(4143699003)(261026121527099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261022115727099003)(261026140227099003)(261022113327099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFLbHBMNlVhZkFkcXNvZWkyZGFaZHZnS3hkWHVjRFpPQlg4cHc5dTB3KzZz?=
 =?utf-8?B?Zm51ZC9TczhlYTBIaEZmTzkvUGFjdGN1TnRpT2ljVmUzQTBHN0YzZjNWMUZq?=
 =?utf-8?B?VGhBNCtRRThjanc4R1hNSG1pa0FVYS9PeWdnOXY3ZE1CQWh1WEo4QzZGYkN4?=
 =?utf-8?B?T1NUMzExS1VOMU9DeWRacWowNVdmV1gvb2w2N20rWHV4TnFUVE8rbWdNVHdZ?=
 =?utf-8?B?dXhOcEQ2SlY4dUJzaU01NkxONk94b0xIK0cvZlFuVEFZc3B1TzdzRXd4SC9C?=
 =?utf-8?B?Y0dnR29TeitPeHovazJxN1dGVWhpc3hRWFVQWFBYODJ5RUdlSDFrNjBSNHRI?=
 =?utf-8?B?d05LQXRtUVFLU2VyNWhpVUxhMEp1K0FaWW5kc0lzWVl5SjRBQXFCbGUrMGIr?=
 =?utf-8?B?eDZ0aitmUWN6UitxaDc1UTVCMExXWUxZSEFnYlJOeWJxejAyWDZ0NDBOYkd1?=
 =?utf-8?B?TC9WRXdIQTZ5MURReWsveTN5OTRDTlhreTVWMU5WdmM3MjFrSGw4dU1nL01Y?=
 =?utf-8?B?MU0xT0dMNVltU1NCUk1RQUVsTzVod0htNXRYRVB2aTd4MWNXQ3NpQ1dkNEVq?=
 =?utf-8?B?UTFBT2JYckNDanVtWW9aRGx2a2xjcG1FbEpzYW1QWkVFT1gvZkpEdmZ0c09P?=
 =?utf-8?B?K3FtNGRvMXoyTk5OMnI1NklFRC9xcHpPYSt3c3U4V2svaWIxVElFSGFUbTZo?=
 =?utf-8?B?V3M0ck04S2MzQmVEUjFER3JBOWkvV1VndU12aGJldHJmMlArZTQ0dFUvcTA1?=
 =?utf-8?B?WDBhLzVZeVByVXFZUGhCL0JQaGNmZ0lZbFN5eHFGcFRqakMwQURUTDJJcHBN?=
 =?utf-8?B?WjRJUXM4VGNadEQ5M1dnc0ZDcW4vbnVSYU85bTZ6ckgwQkNkelFuR2ZpL3NH?=
 =?utf-8?B?a2RHRFZ1WEYzZjQ2enBvM1FZR2llUWNYWEVBVE1oUU9CWTk5N1VlMFp4WTNk?=
 =?utf-8?B?RXhBdmVFUjFUbUpxTk1SYnovVGpDb3l3SUV0Q2crRXV4b0tFM3pzNHZDQmQ0?=
 =?utf-8?B?SDByakVWZjV1Q3NyMkdjZnU5ZTI1WXhvVk1LZ2JEWVNiNW9HeWYweFhjUlR3?=
 =?utf-8?B?Z3A2S01CalM1MStnWHJsckJWSG5UM1JuMTUrQnRPMHUzTXNIa1BHWVhhREdJ?=
 =?utf-8?B?Ymt0OGk5Ny9Pdml6NUcxUFpZRGJzS002d1Awdk1wMHJhUWoyR3VwYmU5VmJR?=
 =?utf-8?B?RTNUVkVoTmdLTUJnSWJIeEszb2llcGdWQWxGckxsWWJxdjAwK2hZZWF5QkJl?=
 =?utf-8?B?MWVHY1ZiNWQ2WUxZemFMMlRPcUJ6S3k0ME5rYitVRkJ0a2Ztc2ozeVNIdEdY?=
 =?utf-8?B?bmlvcElBUE1zOFJXKyttUXVQeU9PeW5OL3NKeC8yU3pzckVpMFIyMzcycUpk?=
 =?utf-8?B?MThaQ2hLN2xSQ2EwN0Y2WFlNNmltenE5M01JbVVNWklWZEVlN3dkSEhFWm9P?=
 =?utf-8?B?ckVrZE9sQm1tQ0Y1bHBxMmdFR0dDUFU3OEc4SWYzbmlIZGZlRXZzdGEzelhF?=
 =?utf-8?B?MGJYbzJuWkNLZFpzdkVGM3BGNWxLMWJ0bkVXSnBBM0VPVFd6V2xuTE1YdTRj?=
 =?utf-8?B?ZEtLbkFxenlUUVAwQlBqRnQvME51dnpMZHBxYXhGZHRyRFpLYmNCSSt5Uzdr?=
 =?utf-8?B?RXpwNWNkb3laaWlVa2QrN2pnVlp3d0VvcWc5ME41ZjI4WHg5YWdLQXNSZHVM?=
 =?utf-8?B?WDFCTWFMS2pYcnVNRkFtUE5sd3BaandqdzYxcWZjSGVFNmJyeFM3RmFLUDBJ?=
 =?utf-8?B?ZDFGQURwTHdSNDc0ZlI1YUxPNzdTaDVOb09CRGtCZXlnM1BlZEZmZUdFeHJ3?=
 =?utf-8?B?c3ZYV1VCaDN0QVdmUG9kSk5WK011cVhkZDhtdGdETnV6Y3crb2JmNlJzUzY5?=
 =?utf-8?B?K3NhTkUyd2RoWUJHSXNYZGVjR3dxL3pBZm5sdDlwNnc3VkI3RUZDTzZ3SDhR?=
 =?utf-8?B?ZmE5Tnd1cDdTRE5kVldZY1FYZ2cwY1pwM1l0dTBQT09ScFFFNmRadkEvdkZF?=
 =?utf-8?B?S1Q5WGkyS2t0bmVVajZScTZJK1dwVjB3TDVQWHdYeHJKVWc2VitNeTdwc3Av?=
 =?utf-8?B?bVZNa0NUMDljM01NUnhmRzdobHRPalA4U1FoYzZ6bmRkRjZwRkNTWGtjYkRU?=
 =?utf-8?B?T2FhcmU1S2hsK2ZIb2xpd3JBZ29GWUFXdlVtYnluNko2MUxXWGpnLzRRWWpj?=
 =?utf-8?B?K2dMYUx1T0xMN0FCUWFFUnFja3d3bDFzd0NiS1dTR3poRHJjTzl0VGs4dmdx?=
 =?utf-8?B?UEIyZ29sVjE3bURpZW9PN1B6ajduYmtjZG9QNU95bHhiNlY5UnN2T2NZNXNN?=
 =?utf-8?B?dUVtcGlwMkN0OStXeDNUdk8xWWxjdm9Nc1V2R2Z2Y2Nlc1hwb2w5Zz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc380d1e-9d04-4b1b-f3bf-08df460ffc5b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:37:38.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/yWTEcYk2L53IORhVIdgWYKWGTDKu5d6SJfvQusT9ka6uwS72t53lhV6tButp+2Pm5lm/FsdzBI6qzCE5HJbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7323

Hi Tanmay,

On 19/11/2026 3:04 am, Kathpalia, Tanmay wrote:
> 
> On 17-11-2026 13:27, NG, TZE YEE wrote:
>> Hi Tanmay,
>>
>> Thanks for the careful review, and sorry for the mixed signals between 
>> the two threads.
> 
> Hi Tze,
> 
> You're welcome, and thank you for staying on top of the review feedback.
> 
> Could you please confirm the document you cited for the rebar pulse 
> width as cdn_ip6185?
> 

Confirmed, with one correction: the "cdn_ip6185" label I quoted was an
internal filename shorthand and isn't an accurate document identifier —
my mistake. The rebar pulse width comes from Cadence's SD/eMMC
host-controller DFI/PHY documentation (the extended-clock-mode DAT-input
timing), where the rebar pulse spans half an SDCLK period.

These Cadence PHY documents are confidential and not publicly
accessible, so v4 will reference them only generically ("the Cadence PHY
documentation"). I can share the exact internal references with you
directly if you need them.

> I will be on annual leave until the first week of January and may not be 
> able to review during
> that time. Thank you for sending v4 with the feedback incorporated while 
> I am away. I will
> review it once I am back.
> 
> Thanks,
> Tanmay
> 

Will do. I'll post v4 with the feedback incorporated. Enjoy your leave.

Thanks,
Tze Yee

>>
>> On 15/11/2026 10:51 pm, Kathpalia, Tanmay wrote:
>>>
>>> On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
>>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>
>>>> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
>>>> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
>>>> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
>>>> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
>>>> (the silent odd/even edge-capture defect).
>>>>
>>>> On this integration the rebar pulse is 2 clk_phy cycles, so extended-
>>>
>>> In the U-Boot thread you said this width is documented in the Cadence 
>>> SD/eMMC DFI spec; in v1 here
>>> you said there is no IP-level document. Which is it? If documented, 
>>> please cite it here and in the
>>> macro comment. If it is Agilex5-specific, please take it from the 
>>> altr,agilex5-sd6hc match data
>>> instead of a constant for every cdns,sd6hc user.
>>>
>>
>> You're right the threads were inconsistent. At v1 I had no IP-level 
>> reference and used the characterised rebar width. While debugging the 
>> U-Boot side I found the Cadence documents that actually describe this, 
>> and I'll cite them from v4 on:
>>
>>   - COMBO DLL PHY User Guide (cdn_ip6182), phy_ctrl_reg (0x2080)
>>     bits[9:4] phony_dqs_timing: 0 when extended_read_mode is disabled,
>>     otherwise the rebar pulse width in clk_phy cycles minus 1 (its own
>>     example: width 4 -> 3).
>>   - SD/eMMC DFI Interface spec (cdn_ip6185) section 1.2.6.2, "DAT input
>>     in extended clock mode" (Fig 1.23 DDR, Fig 1.26 SDR): the rebar
>>     pulse spans half an SDCLK period.
>>
>> So the rule is IP-documented; what I didn't have at v1 was the 
>> reference, not a different rule.
>>
>>>> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
>>>
>>> In v1 you confirmed DDR52 was validated too and said you would name 
>>> both modes.
>>>
>>
>> Yes, DDR52 is validated too. I'll name both DDR50 and DDR52 in the 
>> commit message.
>>
>>>> corrupts reads). Derive it from the extended-read-mode state and apply
>>>> it only in DDR modes, since SDR extended-read samples a single edge and
>>>> is unaffected.
>>>
>>> In v1 you agreed this is not proof ("Agreed the single-edge argument 
>>> alone is not proof") and kept
>>> these modes at 0 because they pass there. On 5 Nov, in the U-Boot 
>>> thread, you wrote the opposite
>>> rule: by the PHY guide the value "is 1 in extended-read mode and 0 
>>> otherwise", and U-Boot v2 does
>>> set 1 for the divided SDR modes. This patch still leaves them at 0, 
>>> so the two trees disagree. The
>>> PHY guide is not limited to DDR: 0 when extended read is off, and the 
>>> rebar width minus 1 when it
>>> is on. With the rebar width of 2, that is 1 in every extended-read 
>>> mode. Please program 1 in these
>>> modes here as well.
>>>
>>
>> Combining the two docs: rebar width (in clk_phy cycles) = (SDCLK/2) / 
>> clk_phy = divider/2, hence phony_dqs_timing = divider/2 - 1. The "2" 
>> in v3 was just that evaluated at our clk_phy (~200 MHz -> divider 4 
>> for DDR50/DDR52).
>>
>> Rather than hard-code a number that silently assumes Agilex5's clock, 
>> or push it into the altr,agilex5-sd6hc match data, I'll derive it from 
>> the clock ratio the driver already has (t_sdclk / t_sdmclk). That is 
>> correct for any cdns,sd6hc instance and drops the magic constant, 
>> which also removes the "this integration" vs "this controller" wording 
>> mismatch, since there's no macro left to reconcile.
>>
>>>>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>>> ---
>>>> Changes in v3:
>>>> - No change; retains Adrian's Acked-by.
>>>>
>>>> Changes in v2:
>>>> - Added Adrian's Acked-by.
>>>> - Reworded the commit message to drop the "generic to any SD6HC-PHY 
>>>> SoC"
>>>>    framing. (Adrian Hunter)
>>>> ---
>>>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>>>>   1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>>>> host/sdhci-cadence-phy-v6.c
>>>> index 22d56bb46d75..8d6a9c26c139 100644
>>>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>>>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>>>> @@ -90,6 +90,9 @@
>>>>   #define SDHCI_CDNS6_PHY_CTRL_REG            0x2080
>>>>   #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING GENMASK(9, 4)
>>>> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
>>>> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES    2
>>>> +
>>>
>>> The commit says "this integration", the comment says "this 
>>> controller". Please make them match,
>>> with a source (see above).
>>>
>>
>> See my reply above. This macro and comment will be removed.
>>
>>>>   /* Default PHY settings */
>>>>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY        2500
>>>>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT        24
>>>> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>>>>       bool cp_use_phony_dqs;        /* bit [20] */
>>>>       bool cp_use_phony_dqs_cmd;    /* bit [19] */
>>>> +    /* PHY_CTRL register fields */
>>>> +    u32 cp_phony_dqs_timing;
>>>> +
>>>
>>> u8 with /* bits [9:4] */, similar to the other cp_* fields.
>>>
>>
>> Will change to u8 with a /* bits [9:4] */ comment, to match the other 
>> cp_* fields.
>>
>>>>       /* HRS07 register - IO delay Information */
>>>>       u8 sdhc_rw_compensate;        /* bits [20:16] */
>>>>       u8 sdhc_idelay_val;        /* bits [4:0] */
>>>> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct 
>>>> sdhci_cdns6_phy *phy)
>>>>       if (phy->mode == MMC_TIMING_MMC_HS200)
>>>>           phy->cp_read_dqs_delay = phy->hs200_tune_val;
>>>> +    if (phy->sdhc_extended_rd_mode &&
>>>> +        (phy->mode == MMC_TIMING_UHS_DDR50 ||
>>>> +         phy->mode == MMC_TIMING_MMC_DDR52))
>>>> +        phy->cp_phony_dqs_timing = 
>>>> SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
>>>> +    else
>>>> +        phy->cp_phony_dqs_timing = 0;
>>>> +
>>>
>>> The PHY guide asks for width - 1 whenever extended read is on, which 
>>> here also covers DS/HS/SDR
>>> modes. In U-Boot v2 you now do exactly that (1 in every extended-read 
>>> mode), and said it matches
>>> the Linux change, but this patch keeps those modes at 0. It's 
>>> confusing, I would suggest to follow
>>> the Cadence PHY user guide.
>>>
>>
>> Agreed. The guide keys the field on extended_read_mode, not on DDR, 
>> and U-Boot v2 already programs width-1 in every extended-read mode. 
>> The computed form does exactly that: phony_dqs_timing = divider/2 - 1 
>> whenever extended_read_mode is set, 0 otherwise. So the two trees will 
>> agree.
>>
>>>>       if (strobe_dat) {
>>>>           /* dqs loopback input via IO cell */
>>>>           hcsdclkadj += phy->iocell_input_delay;
>>>> @@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv 
>>>> *priv)
>>>>       reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>>>>       reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
>>>> +    reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
>>>> +              phy->cp_phony_dqs_timing);
>>>
>>> This write always runs with the loopback DQS selected. The setting 
>>> you tested was the phony DQS
>>> (use_lpbk_dqs = 0) and a read delay of 96. The PHY guide says this 
>>> field times the phony strobe,
>>> so with loopback it may change nothing. Does this patch by itself fix 
>>> the bad reads on the
>>> default loopback path? If not, please put it after patch 4, or merge 
>>> it into patch 4.
>>
>>
>> Agreed it has no standalone effect. The loopback is force‑selected 
>> until the opt‑in lands, so the write is muxed out. I'll fold the 
>> PHONY_DQS_TIMING programming into patch 4, so the phony‑DQS opt‑in and 
>> its correct timing land together and no commit can select phony DQS 
>> with phony_dqs_timing = 0.
>>
>> Thanks,
>> Tze Yee

