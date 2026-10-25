Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792959466;
	b=3tsPUSRQZNVI7VJdX7sblyUMiuRcyr/ieEOIbN2UquowAlXaCwncb+/C+XH7gmHRC06+
	 ymmWyT42C/yd9eKv5/NJWDGos0m6FV1KWhQTZaCTHoGFTyiiSBLW08uFiNrDK0qSHSN8l
	 JzfzfLPu8nj0WXLe+yDcUWc7KxJCNi3l/EwbbeV+Urj6UI7daqkpTUNrKgkk+BkX7NomL
	 NlLRnlJnGmjFPs5v0u5rQedpctKB7gkVgE3yvXe9oQjn6IAGKR7TRNr5V9Odjq9dPAU9P
	 J2hHBn4jI5MObk/6GEr9yedJyqMJGEWv2j3MijSbthn/9vmWW7Be2RDmPtQS6Cc5Duw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959466;
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
	bh=eDe8QWYIcWpTx/SuEAWwTBzENf2Pj+roRmj0ZMAT6T0=;
	b=1wDeDG9xqvXoF5AKCO5nTUkKPpBH3rS99EBV31FzgRiVlNl3kqoUAPcR4s8nVwpPdSnF
	 X0ZtmSIjxBS7+YK08BR7bPEMwMisLXgpmKERnz96rKLrFkLF6d5o3x5E8IR/M+X0WhAxN
	 wZAjU4U2MrjY4ydzbYCK14p7WKK8aygkRyW0xG9JNtRwmNGIWW5VnAN+joKhRAnmasR34
	 C9WsyAalxxXacCagHa7G35MJw/YwZwI8CLiOo6jkiBdwzbvywd58k0PPgSCIweIpdHtrz
	 sUR2rRMB/73KDbcn8f5GWrGteO8fEWVG0kOr/9LqH3ZY01gdPsbrboTKmEo9UdtEe4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QJexpRZy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.5
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BB606A31B;
	Sun, 25 Oct 2026 20:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 872BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QJexpRZy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmlU+i7sqEC1Iz0jj2PkU+XpZChCzzF62BF2HAAk+d1l4r2I3trxKCRbs5g8M554uV/BH0MCq4ilEpMU+LLlVSDDWSHGekIzdUZIChobJdCgtIP71Iim1FtRQNoU+LXLMT/KJ9M86bpI/0iwzLs+RgdJiNjp2fa9mCBWTcuUwKywj12g6XG6Hlaou/7/9NzyANBPT/viFqmqgmWJSe28Z7eozxaUsGgOyF1X+TM98QKVDj1BrY7pdbUpCa5Ay87W6kUletX5Qf7reONk248DnmmvaBlh7ttOeTaYGp5xm080igayfkjg8OTfw1wMJ8hw7TzlQ1pWyeSPKRB4S9i4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDe8QWYIcWpTx/SuEAWwTBzENf2Pj+roRmj0ZMAT6T0=;
 b=APb+51wXjzXHbMFuWIfDgMFzvrhiUAmnukDFWht+nWBLQ8gz/NzaPGylezKZ2qK66P8oKLB21GfMhmpy7p8nZgIYyyIZABPoC4O5HPSwq0mdps0Lc6wHL+0tKLuhblZ/NsJ/LKmEKcS1E+IEmuv5r2WjdAq54UbyFLjIcahpDEP+5lOs85iFaVBCzgYKio1JiAQR1yZMFjpRUJe2RIZwAkXHZp4TLTeFc3Jru6g6PJhCEND3XTSQPydL6MtZQcSJVXMXK4qxukEXOHo16fkLpml6XTPOCTVY6wCkHxee2zctCW4NMSiAWF3bw/wSIKTD5aqdFbW1vvLHGtuLI4TE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDe8QWYIcWpTx/SuEAWwTBzENf2Pj+roRmj0ZMAT6T0=;
 b=QJexpRZy3Cjv7QAx3N80GOki8wZvZzn1pkVIjEigadVFmpasJRzVpDLfUzaxMMRZCOSlCXf7pba69+Nns5a5dKiSp0x7SKNSvEVRxfurfQvdxmDOcs7srRZnawXwoZpeC6d6JY8/wJxQwl2nWeoK7Nng+1k/06SMiOM5yIHrxvW7iu7dszaSfDyz3S4XGc6zvde95ZFskTMYL9hjm5QEt6uYe5+t361Yr6VIlKRdohLomQ9oVWNU0YFQ5afHN2sOaC1V5m1tqbL+SdA9WpfDkXYj+vkuWgOGh2k4xeIz71rU0BqHm1EvDLTiP4fG2vhZb5tlX7dPaKhD/jo2KbwHlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by EAYPR03MB989302.namprd03.prod.outlook.com (2603:10b6:303:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 20:17:41 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 20:17:40 +0000
Message-ID: <dab17adc-1691-463f-bb85-7d1276fbf28f@altera.com>
Date: Mon, 26 Oct 2026 01:47:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci-cadence: add PHY settle after tuning
 for SD6HC
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::16) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|EAYPR03MB989302:EE_
X-MS-Office365-Filtering-Correlation-Id: 13052a5f-d07f-41fd-9673-08df32d50506
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cNrSMgwsfFUPgREkz3dWwzLjP8AxVf+0sbg9llDTcCI0xpe8TIpCg27IeTS6iDZzM65wwv2V1I9yr9ks6TYsv1ffHK/apNklNUoUbdRPB1cMJKT5JA9eMRIWSX+1QKQo1BULOUdK06E5EyuNC94yV9ihK1LjsbIDGgiLJUwja4ryQsJ9XdOTfgAB8aoyendPMOPl38gFKh4hwXCv0ot//YMJJnG46Jsz+2h+QNR1nvckAQ0TFQ2tLILdZ8sIb3iTEgvzklr73UMe2zaflTmXPkS+sk/9oB7Al9ipAlUo3E/iBnAYtHFZCu1Lznk+SZzjt4ifHDeHPaBlrZNA77VRKW6dh6MdOCtElXsupm79gPrLkCU5+YMAJ4LSrtcmk4XtiVsLoYWdxYpgt9ggSj74OaPkM9F0fLTCrcUsjE1i+2g4X9k5vq5RJfe9aCXaZ4UHtprKabFMQUMExVFD6hvYTuy4loR3SfxSlcUm/7+SB1yHehtKK2zGUKR4WrBpTNbyh4im8G/LcRTJh2GXFdRYh5lAD6039unmIslA2OcNx6+vG9KirVdpyeirRGb5aX7F/eaRh9aaLFLAAnBsvC4tUgR7Yx2Hz8tO8A0d8fqgKMXKDwS0l06Jlc4GMZ4qogFPm9Qhiut4O3FdGlF7T+CZbq5WOwWz/7vJ4BU/+qTpMM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGxlREYrQTl2RDg0a3pIVTl3SHlWZDZmK3VKSmk2cVIxZ2lRT3EyUnpYei9W?=
 =?utf-8?B?Q2RhMXBmbG5pQ3JZd2xkazdybzFLS2R4RWxFNWwrVzFOd0FNZWVMTzhrMXVq?=
 =?utf-8?B?L2V4YVc5WEtENEZJM0RVOVoxTVExSDdNYU80SjhuRFJCTGpzbnB3Y3pML0xj?=
 =?utf-8?B?RVRsOFdsOGhJZzJzeGVGNEJaWjFuM01rdWJVakwwdTdIbFhsYzVKSnlJbHFr?=
 =?utf-8?B?eGtEUXBBdE40aGdHOFRtZUNSSlJqSFM3OHRSUFV3VjM4QTZYN0dSc1NiQXN0?=
 =?utf-8?B?SklTdGl4SXJBK2UrZUhvTXNoRnRIVUNmYVdiQ1BmcGVpMmhrWjV6Q3hJUWx2?=
 =?utf-8?B?aDZVT2JiOG1sSjQ4RHRpS0dMYmxmZzlTeEl1VXpyekViVWJvbTNDZ3oxV3lh?=
 =?utf-8?B?amZzNVlpVmNyZndJNHVnYzZRTW5aU1hYK1hGNzlZMExtbFVWb3AxZmxUVzdX?=
 =?utf-8?B?TEUvRDVZUFpCSnNkWjk4U1dGUmQ4Tk15ZlBRbUVHYmt4Z295Skp5ZVI2RDhm?=
 =?utf-8?B?T2F6SDU5U2VQYkZIQyt0L2JUL05WYkpmclJvT3Zab3NPTEsvcXczS3k0Vkdq?=
 =?utf-8?B?WE9Wdmk4YUpuQXd5am93WVd0Mjg2b0dZdzZ5a1RGYk9vU0VpSlhNMC9iVXZR?=
 =?utf-8?B?ZGxmVXkxZmJQaUErNXdTSW1UQkcwZ1g3ZGdDalR3U1YyaE1LUnhCNTBXSWgz?=
 =?utf-8?B?aThLVUdxaEdBK01yOHVkUzFielAzdmdxNFBSQXR1VlAwc3hDL2thcFhnS1VB?=
 =?utf-8?B?WFdYM0xqemZHa3RJK0hxWVRjeHZWQlZ6RGxhcElKN0F2OWp3YkJmQmlIZkpq?=
 =?utf-8?B?Z3Rvdi95UHNRZExNOS8zbTBvSGZiMWU4cGJxb3JYSjVabjA2Smc4R3VZSXBY?=
 =?utf-8?B?L1BaR0szNXN5UTlBQ0dMczcwWEVhbVJSQWY0Y0pjdnRoOFVGWC9QQzF6dWNm?=
 =?utf-8?B?aGU0ZkNHWFc0aURrOGtiQmI2MUpUelp2T0JseUtEcXFEWThZSHlvbHVaZkow?=
 =?utf-8?B?c2pUejhENmM1QXl5R0tzUUc0bkxWZDlrWGluUzhaR25PbGkxWWI4RFhoU05N?=
 =?utf-8?B?UFpWUFVMMHlTQkk3b1pSSE90UWMyVWpYd1pzY2ZHOWxSYzlOazNtRzhUeHJW?=
 =?utf-8?B?ajdWeVJWSEJCYVVzOE43VkFrS2hWTStya1VWVHNSMjlGUjBheTBoZG1uNmJj?=
 =?utf-8?B?VGxEY3gzYnJFQWlJODN0TTR4cnZRSllZRmJ0YWVoMTBUTzVndkQ4bHlnYzM2?=
 =?utf-8?B?T05NdG84YWprc21NekJ6TFhVVFBGVGRkbEJ5U3g3RDZLZE5Cd3U5WHlxQVpC?=
 =?utf-8?B?VWdGbU12N1hPMk9LeFFUNWpWQlpRZHFJRVR6Q244Y0dRcUFiSFgwS3B5Tlov?=
 =?utf-8?B?U2FwZWd5UGpWS2Vhd3drcHlCRjFoSjBFU08vYUR0UXM3dTVDZC9aUWpLR0dZ?=
 =?utf-8?B?Q0xvUS8wWTloZ2F1Nnd4dnBRTTZhNWlaK1hCLzNsR1RMaUFWZzNmTzVGZENz?=
 =?utf-8?B?Z2U3aWJQQ2VzdmI5am55WWozNXlCTi85Uld2QlhlVnNvMVNnUkxIR3NRQUVh?=
 =?utf-8?B?TDh4RVQrVW1KRi9mdHdJcVJNYlJmNUF0LzNQNCs2aDM5b3lNRCt6V3VOa1VR?=
 =?utf-8?B?QUM4Zi8rM1BORHQ2Q1NIZi9WU2l3Mkd6MUFFdmwveUhRSm5HR0c2cHJybUMz?=
 =?utf-8?B?bE8rRGE4Zkp6eWVud2JVQnZWL2JpZjVvZkNqTE5vTEYyM1htbEpPTzJMbFZs?=
 =?utf-8?B?aStzSU1lb2hPQU10SnA3R0ZVTFFtTlluN1IyZHhhaHUyV0J0WVJtR2VGMHNP?=
 =?utf-8?B?M3B6RG05cUczUEdSMGFlVUJ6OEZwL3ZUNkhrQ0RNeXc2U00yeUpZbU1uMzNL?=
 =?utf-8?B?WVAxeUtFcEluajIrRjFwUElTMklHMXZuMmMzeWl1OXhqdEdnOGtkaEp0cWRm?=
 =?utf-8?B?ajV3UHZxUUF0M3lHaHF1YkhBVTZKOWdPVEs2cTJoeTVla2Rqa1U2dFdHcXl0?=
 =?utf-8?B?dDhFelNUR284K1Fram4zdGNVb3RteDRoWU90UjhqZ1dwcDRmQWpzTFFUeWVK?=
 =?utf-8?B?WUFwYis3T3haajhiaDZyODR6SGI1SDI2dHpucjAyQVhqb0FqQXBkTDBtNnJU?=
 =?utf-8?B?eTYwcHByM2s4bVlWeHlLVFAzRG9LbkNDUmlJWi9ncWhkRnc4cUl1cHBleTBu?=
 =?utf-8?B?TVdNckxqcWNMcldCd1NVY0Q3UTZoS2JYVWZIaVljMjV6dGt1bFF4TnllbDUw?=
 =?utf-8?B?cElFalIxZGlDT3Evc1RyUTdVbDBJRGcyaGl2cmdheTgrMVRSWDRmdXNVUnV4?=
 =?utf-8?B?NFpzYWliY2xrMUpGbENUbGErbUJmVVJlTWNVbHN5RnhqVE9vN05wT210OTVa?=
 =?utf-8?Q?tiX0jxy23WlEc+lg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13052a5f-d07f-41fd-9673-08df32d50506
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 20:17:40.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNDZVnEjSUAB3sjJgEdZOquqaLzoPX+r/UddoZCAttWS7J3kxCCgVPSTdDHi5BNjo8R7fPIB58uUGTuNAd6izF0t4EPOE1UpyhvBx5Uzse4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR03MB989302

Hi Tze,

Sorry for the slow reply. I spent some time going through the tuning
path against the eMMC specification before answering.

On 09-10-2026 07:44, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> On SD6HC the first command after tuning may be an R1b busy command (e.g.
> the HS200->HS CMD6 during HS400 selection) that can time out on some eMMC
> unless the PHY is given a brief settle after the final tap and DLL
> re-lock.
>
> Add a single 5 to 5.5 ms settle at the end of the SD6HC tuning path,
> after the winning tap is applied, rather than on every set_tune_val()
> call in the scan.
>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v2:
> - Moved the 5ms PHY settle out of the per-tap tuning loop to a single
>    settle after the winning tap, on the success path only.
>    (Adrian Hunter, Tanmay Kathpalia)
> - Rewrote the comment to explain this specific call site.
>    (Tanmay Kathpalia)
> ---
>   drivers/mmc/host/sdhci-cadence-core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
> index 745455743b01..c25b235ee909 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/iopoll.h>
>   #include <linux/module.h>
> @@ -352,8 +353,11 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>   		return ret;
>   
>   	/* Block gap tuning is only required for SD4HC, not for SD6HC */
> -	if (host->version >= SDHCI_SPEC_420)
> +	if (host->version >= SDHCI_SPEC_420) {
> +		/* Let the PHY settle after the final tap and DLL re-lock. */
> +		usleep_range(5000, 5500);
>   		return 0;
> +	}
>   

Every scan step re-locks the DLL and immediately issues CMD21, which
carries an R1 response on the CMD line, with no delay. The eMMC
specification moves the card to the Data state for CMD21 and treats
any command issued from that state as illegal. If a tap fails with a
command error, the card can remain in the Data state, so the next
command - the CMD6 that mmc_select_hs400() sends straight after
tuning gets no response and the host reports a response timeout.

Adrian added mmc_abort_tuning() in commit e711f0309109 ("mmc: mmc:
Introduce mmc_abort_tuning()") for exactly this case: a timed-out
tuning command can leave the card still processing it, and the eMMC
specification allows CMD12 to stop CMD21.

This also fits with your report that SD SDR104 never fails: CMD12
isn't defined for CMD19, which is why mmc_send_abort_tuning() is a
no-op for it. So this theory is consistent with the SD/eMMC split
you observed.

I'll test aborting each CMD21 that fails with a command error, and
also a single abort after tuning completes, to see whether that
removes the CMD6 failure. If you can test the same, that would help.
I would prefer that fix over an unconditional sleep.

Regards,
Tanmay
