Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794770767;
	b=MxMp0Zl4kdy6l9BedWS0b8n/4kju9x58ahANz1qlwd/NY24sRb0OzcFo9kvQwsVtXHW1
	 PKPbFNjCJ0h7SnSTnrv04e8bby+9ViiB5S+2BmfCWVI7EaS0bBcmNPULEpTQwOT2/j4xF
	 /1doxdqn1jqAVkKBCDZvMOlF2z0ZSEi0SolPzvNIcsc5C5wtrJEZxiwDVVxYxN1lhU3rF
	 SXaljac5QwfL+gjT6mmwtlKZEKsImgPw+c5HStNiDcDPzzs2YEbLE2EPPlLPucFpf0fFp
	 ZZaxHjHrZshutWqt0UogMeNz4HoOtRx3snDgqGUTdyFGE0PDNlzNNS41KJvjCiORXNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770767;
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
	bh=BVzHNmUxGU6hGw2W7R8kFl19hz7cHsdpnl70rPDRG7k=;
	b=K+wJvEW2on1x6jDZMjyYtGouc2hx/qVv/ApC2TTfanhjGOo/fyr88vhAp5ormJXbxZAo
	 cbaefOO1wZBouke2T1iwd4ngUSzV1qNdieje7uz3yBIUHQRxx8prloVRd8niUpJOd69pm
	 UnmBlATlOKZ9NgFp+FsutyumMvWoPSFvyaG1XkhNNkg3NxODdCWSWfzU2cUvqYVLDkV1U
	 3Upowz+wBSvdmo39BYE0jnU/9OEWxF7VEyEzAySBg2W7UhsjKQeGlDsNK8VZ3ShcCf5Fj
	 QfN++uKzOoJGyoqSpQp2DMI0J2NdT2K05KGPNLvuiCMQa1++F2cun12jBG2Kqqxtwig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=FcYHDz9E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE0606A334;
	Sun, 15 Nov 2026 19:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5FE0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=FcYHDz9E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVfd1maYiqJE8AkSH2ufmHhbgKN9RsjcvVu22kfHiFZdr/y78AXxuk52TX7YSeMmKZJ0gFAu/JTWbPY3ZutE3if7TCfpAY7r+gb1goc63nUsM3kpp/s+6wNMzmQDzhjzHg+sLFNn8KErNVWKgdLV1kHREonR+QBbMyFr32fQL4iQh8lRlina9STZl62TePNHMqFFeCbmnqfI8ev7wozu3/IYdkbXdRI7dDjg4BhBumPdqfJb/+6Eftzq1cw6KUnXgZ5F0YjLhVeJm3dUGMg36tNyCRsSua2bxUfZNF5rBrNVW5e1d8M9z+X3jdcHwhmrERj7x5+wKkA0s08fckuYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzHNmUxGU6hGw2W7R8kFl19hz7cHsdpnl70rPDRG7k=;
 b=GuuqdCeZ+THPbkV4QndUVYinxAfn7LNyz4msqONPc/7IfFC2RV7M4m95k1/LZFeYMcEQIi7//lIa2wrrFO57oQvs/3bRW9+WoURA4DCb85PUGHg/PKGoe1W4WmJGCkMNQTwPHD0A8zCMscg6ONYiC387hxAz1u1CpZN+QaL5N+D5chXk4qEg2pAzVvK5rJYWesg/bhK9+1p0RPYmkIOOpyInce44N3lawdeYsppq8oTqAWPa9tW2t1kk6NrxUMqCwBnRh8V34io8u/k2k7xYxdhOmbzrg/G0j7cIvoBhwPWsQEW/wOwffMu0ySRjBYh8ca5EgI4NpNqnutKIibnpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzHNmUxGU6hGw2W7R8kFl19hz7cHsdpnl70rPDRG7k=;
 b=FcYHDz9EJrss6uaGn+46DM6JhthZTCNcU4EFE4y9ALC0HdCk9qID8faLadBD3kZWUeCbROHodacnOBQHnJ3paCQ1Pp+06oHZUgIeCXMulk96HMScYfDO41KCSH5QmDpC0lTioQWoZOqfeX9MZpeZgHgyk5F6kKk9+wSe5nsqsGsZqMfyx8e41LalxOFuEs5lHo3AVh/G+nUKGcCMpx4mjDHwqIMsrEwDokRktRUwv4fWK99ffYmSylZ2HXKo5Omyn3dkWwqkYuYrMF+jaYGeV3iX3Lih5dCAKN5X4LwIBMe3AFjDgskTuZC3AqlUUL96wDsVmvCzwvx7c5TBourLVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB6542.namprd03.prod.outlook.com (2603:10b6:510:bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 19:25:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 19:25:02 +0000
Message-ID: <8fd95a2f-6320-4c52-8e5c-6e26c8aa46fd@altera.com>
Date: Mon, 16 Nov 2026 00:54:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mmc: sdhci-cadence: abort failed tuning command on
 SD6HC
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-1-cb50afece614@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-1-cb50afece614@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1e1dce-2309-4d4f-37b2-08df434e2569
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zjRwVufHCu8yDB++G2v54maBPgtBTDC/Ydx0Kcc3oPOVYseOr/pw0R1KgHEAp4CwWzBGHO7NAMv3uPAqFzs2n57D8cCT97thBRuupjZHGaa1lLE4co+THjMaAJIUultQFLw5es5bY+DXOkL9/XkPGGz7Ad3b8w+bZTPpJfmo2tYnMgc/Jk/yVXFIBewtu6bbj4HwIovvb9HTv0BKAtht6O/qjrpdb2aCxZLXgYP7FOz4g4jMg8gkoEZRK/YN5+JxBRjyL8jA0hU9CW8261/W6us1NOxVnE5D/o6Ds0mzHi4VuMmCXWJv3+h+MamUddjVrNMcLiysZp/G+VVwPqf+T9o4ijv7hmN0ge3jfVNMd+oewSu51ZrG6+3COuhTAFM6WVX4cHrZgTr5ziHVMFeBhb3eGU6WMtbdHvXahUoNScYSNLJKzW6bG1N3aF2dXZMb3YFUA0ibucb20yr0uptwgZogXhsy6plq1sAyoPu72Mer4xQg3u+mSPaQYtlvNt1Zplvxhy8Yq5/dL2/VImx2GAii9G0xe+wjpKQDBye2tDfNPYb9lGo4UuP1vADSjJJjQ6uRWQtrZv+51w3/lDQ/GGohekbV8TVawYGa9oUrvBqEWWElT3pDuWBPZrqiS1Jvm7k/MQkupqtC3izhcmpc5kI0AqRa4h/SqMDR/0uyYVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bi9GSDZDYUhwaG1Fcm9TdlNVS21aVDVrN0YxZlNsT2ZTYzBQVEFKRElRUmFI?=
 =?utf-8?B?c2hCczl1NFZlWDNxUDk4a1doeFNRa2Y3cFFNSEZ3bFBoYjdXU2M5UzhiU0U1?=
 =?utf-8?B?emM4Q0N5eWNEV09zZHB0dFNTS25PTEdYV0pTWmJNcG54RXBMbzZQT2k1RFBr?=
 =?utf-8?B?UTMzT1dISkN0WTc5RSttaVZFUm5peWFQV0ZXR3F5cWxna0d4YzdoOE5xNFVY?=
 =?utf-8?B?NUg5VXNsY0Qwc0MrWDRGalN0dUpaV0l6cVdGRHAxUGQ5Z2NvTFJmemVzbldD?=
 =?utf-8?B?T0U2R2l1bHZ3d3RSdXE2a1JSL1VSK3JORGhGZlBxL0U5aHNqYW13MnAvWmE0?=
 =?utf-8?B?Y1l4QjJ5NEVneFBrTHhNc0srTER0ckJsaDB0QjVUNmkvd2JGbXdhRnlKRnV0?=
 =?utf-8?B?TjBLZEVESWZXTm0yVjhnU2lPODIzTHRpZjBuYkk0NmtMZ0hERXVjNElPRXJV?=
 =?utf-8?B?dVRER3ZKYzk1a3NyZjdBMWxBcGRtVUhEVEpuamVZbmZEaTBHZVE3WndOWFFD?=
 =?utf-8?B?VGVmQzFZSG42VzkwVkczdnZwVFhncUNDV2hKSzJ4dzZPMHYvTzg5QVcyYTFz?=
 =?utf-8?B?K0c4RlBiRVltQXJJemlSYzJ1RDVKWmY0ZEIxamVXTWRZbmtuYUg4L1FEK0ts?=
 =?utf-8?B?dXcxc2R4c0d4aUxNYTM1Y1pzUjRkalgvQTlPSldIa1VEYkNUanh1N3VwQVUr?=
 =?utf-8?B?RzN2T0pUNFY3WUI5VkdxY3lHZHVHTGR4UVEwbGlxbW4zSERZcmNMNWxNU3dt?=
 =?utf-8?B?MmgyRlFtelN3NDA2QTZobkdEa0VOUytHSVV3ZXVaRjNGZTJTZUFHWEF6OTRR?=
 =?utf-8?B?WlRhdTF6cENNQSs4MFp2NlQ4SHFYazNOVGJEL1gxa2puSmVjQUZiMTZtY2d4?=
 =?utf-8?B?aWY1OWxqV25FSy9RZVBzQ2tDUjZ6Yi9WVlFJeE5LWjhEOTdKQkUyZmRpdzBo?=
 =?utf-8?B?VXAzMWhLOFVidTZPZ3A4NHg5eXRnQk1HR3RSZDM3dCtUdWRScWFQcEtxMU5H?=
 =?utf-8?B?UUhONEhuZDgrTHJaRm5jYkpCb1hmS0xyakpLdm0xcGhuNWFDZWRjQlBRK1hz?=
 =?utf-8?B?aGZ5WlNyRGRGUEZGcFFnK3RHc2VDTzY4bytUOWFibyszNS9VZ0hhbHFNNTlZ?=
 =?utf-8?B?ZDhKQjFLN3hMVXYxdWNiTEFrdmZyZ2Q3Yll5UE16YTI1eWNqUkkxOXRGakV6?=
 =?utf-8?B?S3pDcStiaGZNamxxc2VZRU5rTm5vL2RCS3N0VlJsOG44aEJNcWdCUW8xdFYz?=
 =?utf-8?B?VUM1WmRqc21Ca1FXVk9hVkU1OXZUeG9LV2Nma1hJMVE0T3k4Y21heVkzOGpY?=
 =?utf-8?B?SDRKdjFMMWNTUGUrcUY2S0MzZkdRc2pHS0dOUDZLcS9NcURsK25KeW9MeFhD?=
 =?utf-8?B?QTdpUkt2SnZoUEpuQ09BTnFOYkdtaWVlK1JsM01DV04zR3VYbGoyODU1L29O?=
 =?utf-8?B?STNuZVhnRHpiUEpxS2p3M2Z5VmhSSlVoYy9RSWU2dlZLcXREVTBkOGMxVnVu?=
 =?utf-8?B?Y0k2eDYyUFU5VmZwRkZXOEFtQ3N0SGhvcU9uUXFLL0tSMENONlVrZTZSQmZY?=
 =?utf-8?B?NEZNZDFCZFpTazQ5cStYWjh6TW50eDVYSFVTMlpNMVlkeVQyeFYvM0s1V2hs?=
 =?utf-8?B?OVJUQnhQc3M1aTZKQ2E4UThSSkVrZ2lMNitHaXY2RmN3K2U1dHArdGNDRHV0?=
 =?utf-8?B?ZXVWcStqS2plYVVHUElRTTNXQlJFZlJaeExValgyaUhIbVF2clBOS3VHM2ww?=
 =?utf-8?B?NmNNL09pQjVVcUQ5dWlqMEhDcE13VmRDZVRVOURJWnBjcjlLam1XRFlWd2pl?=
 =?utf-8?B?dkZLa2ZDQm5MUkVicVk3M3cxbmlibjFVc1NYM1FKL3BxaGppRCsvUVNneFF0?=
 =?utf-8?B?WmdrNTIwY0lmY0dwUmR1TFVXN0tzMDY3NGFKUDh2M1NUVEpkYm1LeEZwRWg1?=
 =?utf-8?B?OHpxZ3dCQURyNTRWTlhlanc5VXplc0hackJVeHNkMHhHcTVPc3JNWXpGSEZX?=
 =?utf-8?B?bnVTdnc3TlUvVGJ2RS8vbWtTeE9zakVDS2FOMXp5bXRyb2RjWFBzVjE3Vmht?=
 =?utf-8?B?bWdMb2VaMjFPdk00TnZLSG1kUHc1N0crZVJPSzZhQVEvcDlNWEJQa05EditD?=
 =?utf-8?B?TEtBMGdzdk9sdDYzcVZEMUpwelVwSCtwanozT2VOc0Z2ZFJCU3dQVnBGRnYx?=
 =?utf-8?B?cWlHV3hpL0gwSEUvMThMcVFlblN0OGpPUFQ0U1I0MG42NHJidWY3M1Y1ckdE?=
 =?utf-8?B?U080c2FsM0gxaDNUV3YyWFk1OW5NTElxNXEwSXVFMXVqWDVQdWlWbk53eGU0?=
 =?utf-8?B?YkU3RW05a0pqZUVuS2tmUXRSWEFqOWpOR05MNWZOS09GT1hDTEZiKzdqc0lN?=
 =?utf-8?Q?6FuYtEO0JRqHHu4w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1e1dce-2309-4d4f-37b2-08df434e2569
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 19:25:02.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBgyEEQ1VcNXx9psEG8VkoTxcQs7AyM3O55XgpE1Mgit63SQSeHAd6GoECECMueQSHqw+BtXhS2MyeOdIyr2cjgSt6sZ37CwN3E7wNUY2Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6542


On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> SD6HC uses a software tuning loop that calls mmc_send_tuning() for every
> tap but never aborts a command that fails. When a CMD21 fails with a
> command error the eMMC can remain in the Data state and reject the next
> command, so the CMD6 that mmc_select_hs400() issues right after tuning
> times out. SD is not affected because CMD12 cannot abort CMD19.

Nit: The SD state diagram (Fig 4-13) shows CMD12 leaving the data state 
after CMD19; the
tuning section just doesn't use it. Instead we can use that SD is 
unchanged because
mmc_send_abort_tuning() only acts on CMD21.

>
> Request the command error from mmc_send_tuning() and, on a command
> error, abort the tuning command with mmc_send_abort_tuning(), which is a
> no-op for SD. This matches the generic sdhci tuning path.
>
> Suggested-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:
> - New patch replacing the v2 1/4 PHY settle: abort the failed tuning
>    command (mmc_send_abort_tuning(), a no-op for SD) instead of masking
>    the post-tuning command timeout with a settle delay. (Tanmay Kathpalia)
> ---
>   drivers/mmc/host/sdhci-cadence-core.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
> index 745455743b01..a94296cebf47 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -330,9 +330,18 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>   	}
>   
>   	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
> +		int cmd_error = 0;
> +
>   		if (sdhci_cdns_set_tune_val(host, i) ||
> -		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
> +		    mmc_send_tuning(host->mmc, opcode, &cmd_error)) { /* bad */
>   			cur_streak = 0;
> +			/*
> +			 * Abort a failed tuning command so an eMMC does not
> +			 * stay in the Data state and reject the next command;
> +			 * a no-op for SD.
> +			 */
> +			if (cmd_error)
> +				mmc_send_abort_tuning(host->mmc, opcode);

sdhci_cdns_execute_tuning() is shared with SD4HC, so this changes those 
too, and only SD6HC was
tested. Please limit the abort to SD6HC:

     if (cmd_error && host->version >= SDHCI_SPEC_420)
         mmc_send_abort_tuning(host->mmc, opcode);

If SD4HC should get it too, that can be a follow-up once it has been 
tested on EyeQ or UniPhier.

With the SD6HC guard and the commit message fix:
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

>
