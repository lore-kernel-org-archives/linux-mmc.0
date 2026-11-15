Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794768459;
	b=MzT8Gt0zX1YzTVjJ+qRcc0JStR8vQnE5a1Xd9Fzxt0qTzU4ZgBCPrbz2pyF0lFv2xjqd
	 /UtXMGJfNN4VdYdVT5kc7I6GnBWOQTqaICKDKwGHzfyqqNiESeMjd76cJ4TMgDsn9Zu5x
	 knK/lPHs/dlPii5gaLvbd50dPKR8xmBVom3GXvmIDFPwni5dQ5niBUCBfrmJrw/CS/Slv
	 J2QKhFNxJZEAikKZbzbsgL4EAw83z7Dt478UsijDVJfG3F5YuYb932EpRLAfE4bmMJZ0K
	 ePzCUxRWClS9XJd1LWj4EeYVocC7zwvF3t8x/0hqWvkg6/+My3LAem5fZ9nVMsuKEVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768459;
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
	bh=MeDLOszd3cS62OXg/bRxM8jffo1IFfDAI1Z2WmL49NA=;
	b=xKBSgs4E/J2Uy0zctKPAC82EMeRPTxp161lqOwI8tOSlJfzk89ncSYwxbm0VYsd2jRxL
	 4EqcYi9svVnd8el8mNRdr94rkZM8/PT0+QUFx9fuq9FeU5rej21QB8dTpnfgogiq3wnXw
	 4T9WY22pCGk9F9coZCcVZil7TtSX/ly56erMurwXt9Ka11TflWQ/pjye7U9cjnrmP4+qV
	 4OsBzSSBS1lvJ5BUFP8UCFW5HTZQm+kEFZL/FL0XuTwhsidZuVCI9yKMsnlipbvjDEW/e
	 pkP2gVhA8KwwqYA8V+3p5LrrPIWlsJCRhSFps6yyVaYmhaTaSXm+RtNSWqG4ehOOjEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jjTDkl1T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.65
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE554606A31E;
	Sun, 15 Nov 2026 18:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE554606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=jjTDkl1T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbHWCHORyPsECRzoCiNDGmnc6ML8u/bBxMKXPj5QPxnHcOv4bfxt7heOKrAvUDX27UCP1pBAYpQB5Hc3rCCVKuvoxvlVcG+wCbtelX3pG8zrFlrU13dCpM4Dhxcle03XWUAJRyhpkP/0oGnahc+otqrBQsnG9tqewQ5ffQxa0GD2mkEfNuzUix9LfqyOC3hYWvAbAwHjHlp2JKNihqMLlb0rO9Np5puMILZXl6MYBT8On64rEwarfg5RPt1nPUjBtEzNourB878z42u3SIMGcrRT34qVBKmsFrCetlAW2QLEvAcfOf56oL/syI3Rdu+PTjegjcsyoR1MSED3Q9nYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeDLOszd3cS62OXg/bRxM8jffo1IFfDAI1Z2WmL49NA=;
 b=Ra1BF8kVNJnVmEf6VJeHCZSsSVkjS7WWCv8YIG7h6LPsVOfcZS0gaM/dWCf9xo3YrLeSiwuGyjgSbQktL+FLBBHSAOcokXkoKCuLWNyVpVAl2rgtXI2SNzg/na1BxjUJ5zrZ4yv+zt1chvp0KFe7YVkFkejzwvMsihMZfOaxiCdg/8F4WfTke94XJhcyxkOj2lnGRdUwY+NkoiHCAzcSNPRGSDyNlQjGO6KR0uu1/TY8QujiVG26KbT6y8Ei3qvCWlf6ZzDrg13Plh3+ubwoVrzO/SAicCK/aSqU9qtPqgOPLElgtvDPhSEmUXaU4A7NneP4wJlQKVX9st1BmLsFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeDLOszd3cS62OXg/bRxM8jffo1IFfDAI1Z2WmL49NA=;
 b=jjTDkl1TFQ0AW2WuD1BXDwrFaUcCln3oAEvRrItOXwaWuUgM2TxMg+Orb7g1Gv/G1U2Ogp7x6n9Ghe5Rfe3CVAw0Ouf1uK9qGHcw0U8l4FFNsfX9ioSpKkySSMN6aOv1HSDGOnhCgUD4YeSkDENwYrHy2drseEBPwExLLwPk6F5dqBDTWUehkK28YE1HqdiQ6T9mMX4m4xuF7A3peSrPMz+RD2nZaxR77pIgTLmw6UpGNeswxn/wOOfkvB7utlcGFt0KIoR4jc3Buni0Op0PZ19S3brL//2eC1k4e3M3rtbBKzMo+qq1NkQRkCYjwA+yJzN9RCeEAKPqPTm+Nf4eog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6455.namprd03.prod.outlook.com (2603:10b6:a03:38d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 18:47:35 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 18:47:34 +0000
Message-ID: <9c1c80f9-2b86-46e2-a2fd-6ac79bb4cc2b@altera.com>
Date: Mon, 16 Nov 2026 00:17:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from
 device tree
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-4-cb50afece614@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-4-cb50afece614@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0201.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::9) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: c01c5621-3fc4-4384-70c2-08df4348e908
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NffN8VKKfdUgiiUTy3vrP5LAbKf3BYDu+MMhRMmd7FNZA2vw2ylAVmYhayh4ygK6UDsO0WUBMV6kig+38RiD9PVgJnBoFm7MoAGVdHjnYGEE3s2cWi+ZmzVW/3l5CJEg8hSze9QYzuTB9my3wumBCq7VVCofENMppOAO9AECvehipJvIwQNCmNS2khnPLrsX/JWQlzL+IBYMHBKx2dFBtG5B2iwNBRy1HfxKJounFg3dqj7JIoxlrs0XAPDLt3RLUvZNrYAtFfbUpifNDm2xZTi2wg90h+4OAZaV12Nj1tojjHB4S9kgNm3yxr7HF1t1oYfFiaYVQNk8eLQGnyNwvZ+PlUqrNmK6BAnX7Ph/ZPcP6VsMz7Ap/euDOc8Q5LY53+vtQ7La4fAB3787+BupG3CTA4VR35E2aKP5G6+2AcKlLNCua5Uji0I2350nqBWr4HqXFtwHFheb5ng1eO6ZOeiO2OYGWbTgibvbTD61NA1HAZMVGQP2AiLW0bzh0VawxJliiifsJDoa+OO/WfxnU/bl0RVRET589GfPn3JVkcpX7YEIG/DhfM34OG0y2FlSiJO05LqBJMYzZQphxzCJYuJp9zcNwkYhy6xWL2iMJ9JclfCE19HrPAkMWOAJwYLsJKneVKUWZzmxQMBeqIecWW3QZoGZU1ofccyjbLXYthY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFJKU1UyeXhXN0dSUVpxYTAzUVhsVitaV0Q4QmRnUi9SR2pmSU0wcnRHbVNZ?=
 =?utf-8?B?bkpDM21KUGhMSGxMMGZEVWs5aTB5d1NzbnE5Rzk4a1Q2QUczTWt1QjBVc2tG?=
 =?utf-8?B?S1R0cnQ4SFk3RzlCRlJERkVUMk9vQ2d2STFYMjQ5alJpUGxHZFRKOGdLa3pS?=
 =?utf-8?B?TkhvdmJrcUlFU050S3VKY2Nyd1ZCeXlkTnM2Z3F2TFo5RlBQa2VTck1qeis2?=
 =?utf-8?B?ZFpSQk5YSElqU3dSdkE5OVErYW05czZKV1NRYXhHQkZXWDlOL1lYamU2amts?=
 =?utf-8?B?ZjFBdEZRVTZRMnJnRTRScFFCb3BKWDdHWjhVZzgvblRRWm1MaGJ2cENwc0Ew?=
 =?utf-8?B?Q0x5bm10KzQwMEF5SzBTMm1ZSlZTNERiZitEOWdPbXY2K1J4RjVXNm5hN0NQ?=
 =?utf-8?B?Z1FXUUMvYW5BNk96TlJGbXcyMjJ3cDdsQU05bW5HZjFTTzRBaDQwWk5RTFI2?=
 =?utf-8?B?WDZIRkYvZzBpcDNSY0F3SUhPSERZaDNsRThQM1Y1WEQ5dVlQRE5qMzdTM3li?=
 =?utf-8?B?OU8xRVh0S1lveG9FdTM0cVh1dG5KMjVRbW9HL3hmMGFkTnVPbmhUemFFRU92?=
 =?utf-8?B?MEFGK0NpN3VGYis2STJRN1dGZUtJODM1a2gwTGh2dmJ6QkJQUWs0TTczMHNo?=
 =?utf-8?B?RTh0bFJxbHhzai9IL09hOTBLbFlxenFGdEJTbGhxZlcwbHFUclBRS0NjZjB6?=
 =?utf-8?B?bDFxb1NXMmdJaWpRcWVYUjhuS1NveG1nc21KcDlza2VqL2xHTjFhdlg3bEs5?=
 =?utf-8?B?aHFnM1p6NE5hRmhqZXFZKzFPRDdaU1kxRkhKMm41TWIwREFLVW1XVzA3cmpy?=
 =?utf-8?B?M2phTERsTkNENi93aXJTOGRKRnFIcDBDVmNIWXlsbkllSmRHaHFnQUV6THIv?=
 =?utf-8?B?NzRFbTJtUXAraGRMaHV5M2NDTUdPVlNtS0t3SVNNMi9wTlh1MUhSTDRRUHVI?=
 =?utf-8?B?UWwvTTNVN0NjVFRyZnh5OU4wK2h6NGtnYWxEZmdsdS8vK01ia2JkN1RoNitK?=
 =?utf-8?B?Z1ZhQ21LVnJGdi9VekFOWTlWRGhLVWF2RlFuZkpDakFzUTlaWWdINENORjdZ?=
 =?utf-8?B?ZWdKeWNrNWxtY3ArajZVRUh6eW1PT2lYdU9hMjJ0dWh0MWZ4d3pNc1hUMnNU?=
 =?utf-8?B?NExpSUxjS2JPOGgrMW1nendTaklkQ3VTWmRoOGlicU1WVGxOZ1pXT1RZc3I0?=
 =?utf-8?B?c05ENXQ4REFKdVRRZ29YZllDQlVEVkEzT3NUNEl3amUrL3RHdGYvWndjS0s1?=
 =?utf-8?B?UndjU3k0WjJtV0w2Uk9SUEZ4eDl4RkMwME5YelRSMG5rYXBIZnV6YTNMOUF2?=
 =?utf-8?B?OUR6UTRwT0REa1VJUHlpVi82Ymh1dVFUcThzdElFbDFwUlRydEhXTHljR3ZB?=
 =?utf-8?B?UWJtQzZyNVFGa0JUN25FeCtNRG1Ycm13MkJNMnlXSEhDRElNaVlmNXZvanhp?=
 =?utf-8?B?eUFURFZGREp1SGF1VWZTVkJPY1piajlyWHdURDdTbzQ4M1FDeXdxNldvTHN5?=
 =?utf-8?B?MTZKT2dJdmpIRjB6NldjTkJJQWhuTnN6ekNvSGtXVjJ6RjdHZGxvbDJuRnlv?=
 =?utf-8?B?RFZvZE9nK3RQRThSY1R3Q1ZXUFJKRnk2VFpSWWRCRCtFVENWb1hxSXlQTlJE?=
 =?utf-8?B?bU1EYlZQTFV2eTlxVEZWeXVERlVwUm5YZXZPMnN1RUtnRG1QbGRibnQwS0RE?=
 =?utf-8?B?TFk5ZXdLQUtIYkt0b2RtREVqL3praWZmMHBra3ZYTmU1dDlicFNieXl4RWd0?=
 =?utf-8?B?VGRUWFBaUzJES1FNQlRsM056VGNZczQ5TzEyaHVoaFhPZFdVNDA4M1dIcVpF?=
 =?utf-8?B?WDh6SGRFbWFiMGJhSkJKN2pPalJTR0lmTzJIb1Z2SUQyWWFhVEhLckVkZXhx?=
 =?utf-8?B?dDZCWEFXWkN0ZnBIM1VtTjgzL0owTHNWM2lmUXU3aDV5dkFuTFp6SjYxTjVM?=
 =?utf-8?B?U1U2MldIU0RiZHUyd3dNbTRjYVZrVFBYYm0rT3FrWU5LenplN2lnbEdwR1B2?=
 =?utf-8?B?SGRtZi9yWFdvVmJSalQwR3RYZXRQbGNrY1ErS3NoaGhaUTM5a2tteElYRHhw?=
 =?utf-8?B?cG42T2FINkdKdGgvUGhvZGdNUzJMdjRqYXhpQmF1N0tBUDJNVTJNYWpFTTBo?=
 =?utf-8?B?OEJTUXZOT2c3N3BiWUwvTk1JRUdsNFdFbEZHV2RPWkV2TDJTbTZFUUloMTZJ?=
 =?utf-8?B?SU9vZDY4aEI0K1JlcHZyOVVIblRWMXhGSkk3U1BMMVRBZXVCMk1rVnplWFFJ?=
 =?utf-8?B?OGpmVXhsYndyb1RuMy9pYm0yTHhTWXlRdS9DZ0FtbGd3U3VGKzMwODUyTUxj?=
 =?utf-8?B?WjZtWWZtbWh3RU5XWDY2cDZvdTdZYkpZM3hXWWtNQlc2K3RhdGR1d0V1dEJz?=
 =?utf-8?Q?8wcyiMK7Sz6wIb38=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01c5621-3fc4-4384-70c2-08df4348e908
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 18:47:33.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj2n+B41VBgs034mF9yMeJ7Ii5ozez/NDhJkareWL143yfoiFwGhzmidB0XTM2H1q5J4oYLv16lGR6Ve7nMRRyJAGBbAh6AiQmkHUsApt4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6455


On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
> settings that need board/SoC characterisation. Read the read-DQS delay,

Nit: the subject and this line say DDR50, but DDR52 is covered too.

> read-DQS source and phony DQS assertion timing from the new
> cdns,ddr-read-dqs-delay, cdns,ddr-no-lpbk-dqs and
> cdns,ddr-phony-dqs-timing DT properties at PHY probe and apply them in
> the extended-read DDR modes (DDR50 and DDR52). The read-DQS delay is a
> count of DLL delay elements (each cdns,delay-element-ps wide) written
> directly to the 8-bit PHY field (0-255).
>
> Loopback DQS is the recommended read-capture path and stays the default;
> cdns,ddr-no-lpbk-dqs lets a board fall back to the fabricated phony DQS.
> When a property is absent the driver-computed value is kept - for the
> phony DQS timing, the value derived from the RE# pulse width
> (REBAR_PULSE_CYCLES-1).

The Cadence guide gives no rebar pulse width. It has only the formula 
and an example
of 4 (field value 3). The 2 is your measurement at SDMCLK 200 MHz and 
SDCLK 50 MHz, so it should not
be an unexplained constant in the common driver. Please see my comment 
on the override below.

>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:
> - Read cdns,ddr-read-dqs-delay directly as the delay-element count and
>    write it to the 8-bit PHY field; dropped the ps->element conversion
>    (divide by cdns,delay-element-ps) and the FIELD_MAX() clamp.
>    (Krzysztof Kozlowski)
> - Hoisted the repeated DDR-mode test to a local bool. (Adrian Hunter)
> - Removed the probe-time dev_warn() that validated the firmware value.
>    (Adrian Hunter)
> - Unwrapped the of_property_read_u32() call to 100 columns.
>    (Adrian Hunter)
>
> Changes in v2:
> - Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
>    v6 PHY.
> - Renamed the properties to cdns,ddr-*.
> - Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
>    (dividing by cdns,delay-element-ps), clamping that quotient to the 8-bit
>    PHY field. (Krzysztof Kozlowski)
> - Read cdns,ddr-no-lpbk-dqs via of_property_read_bool().
>    (Krzysztof Kozlowski)
> - Dropped the v1 per-property range checks and redundant FIELD_MAX() write
>    masks. (Adrian Hunter)
> - Apply the overrides in both DDR50 and DDR52.
> ---
>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 48 ++++++++++++++++++++++++++++++---
>   1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 8d6a9c26c139..d905e39d4b6f 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
>   	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
>   	u32 delay_element;
>   
> +	/* DDR read-path overrides (SoC-specific) */
> +	u32 ddr_read_dqs_delay;
> +	bool ddr_no_lpbk_dqs;
> +	s32 ddr_phony_dqs_timing;
> +

ddr_read_dqs_delay should be u8 (it maps to cp_read_dqs_delay, u8 bits 
[7:0]).
Same for ddr_phony_dqs_timing.

>   	/* PHY_DLL_SLAVE_CTRL register fields */
>   	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
>   	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
> @@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
>   	/* PHY_DQS_TIMING register fields */
>   	bool cp_use_phony_dqs;		/* bit [20] */
>   	bool cp_use_phony_dqs_cmd;	/* bit [19] */
> +	bool cp_use_lpbk_dqs;		/* bit [21] */
>   
>   	/* PHY_CTRL register fields */
>   	u32 cp_phony_dqs_timing;
> @@ -511,6 +517,7 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>   {
>   	u32 hcsdclkadj = 0;
>   	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
> +	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52);

Patch 2 already tests the DDR modes, so please add this local in patch 2.
Then patch 4 does not rewrite lines that patch 2 added.

>   
>   	if (strobe_dat) {
>   		phy->cp_use_phony_dqs = false;
> @@ -523,13 +530,31 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>   	if (phy->mode == MMC_TIMING_MMC_HS200)
>   		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>   
> -	if (phy->sdhc_extended_rd_mode &&
> -	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
> -	     phy->mode == MMC_TIMING_MMC_DDR52))
> +	if (ddr && phy->ddr_read_dqs_delay)
> +		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;
> +
> +	phy->cp_use_lpbk_dqs = 1;
> +
> +	if (phy->sdhc_extended_rd_mode && ddr)
>   		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
>   	else
>   		phy->cp_phony_dqs_timing = 0;
>   
> +	/*
> +	 * Loopback DQS is the recommended read-capture path; allow boards that
> +	 * need the fabricated phony DQS instead to opt out in the DDR modes.
> +	 */
> +	if (ddr && phy->ddr_no_lpbk_dqs)
> +		phy->cp_use_lpbk_dqs = 0;

Nit: true/false, like the other cp_use_* fields (also for the = 0 below).

> +
> +	/*
> +	 * The computed phony DQS timing above is derived from the RE# pulse
> +	 * width. Allow a DT override for boards whose flight time shifts the
> +	 * returning DDR data relative to the fabricated strobe.
> +	 */

Please drop phony DQS timing override. The PHY guide sets this field 
from the rebar pulse
width, not from the board flight time. Board delay belongs in the read 
DQS delay. This
property also puts a raw register value in the device tree.

The open question is the width itself. The PHY guide gives no number, 
only the formula and an
example of 4. Your 2 is a measurement at 50 MHz. Please try 
phony_dqs_timing from 0 to 4 in DDR,
with the phony DQS selected, at 50 MHz and again at a lower card clock 
(about 25 MHz, by
lowering max-frequency; please check the actual clock). Compare the data 
byte for byte.

If the best value changes with the clock, compute the width in the 
driver from the two clocks. If
it stays the same, take the width from the SoC data, or from one device 
tree property for the width
in clock cycles. Not a register value, and not a fixed number in the 
common driver.

Also, I do not expect the pulse width itself to differ between boards of 
the same SoC, since the
controller generates it. I would suggest to open a ticket with Cadence 
to ask what sets this width.

> +	if (ddr && phy->ddr_phony_dqs_timing >= 0)
> +		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing;
> +

If it stays, this must also check phy->sdhc_extended_rd_mode: the guide 
requires 0 when extended
read is off.

>   	if (strobe_dat) {
>   		/* dqs loopback input via IO cell */
>   		hcsdclkadj += phy->iocell_input_delay;
> @@ -693,10 +718,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>   	sdhci_cdns6_dll_reset(priv, true);
>   
>   	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>   	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>   	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>   	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
> -	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
>   	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
>   	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
>   	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
> @@ -878,6 +904,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_cdns6_phy *phy;
>   	unsigned long val;
> +	u32 prop;
>   	int ret;
>   
>   	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> @@ -916,6 +943,19 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>   
>   	phy->delay_element_org = phy->delay_element;
>   
> +	/*
> +	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
> +	 * eMMC DDR52).
> +	 */
> +	phy->ddr_read_dqs_delay = 0;
> +	of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay", &phy->ddr_read_dqs_delay);
> +
> +	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node, "cdns,ddr-no-lpbk-dqs");
> +
> +	phy->ddr_phony_dqs_timing = -1;
> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs-timing", &prop))
> +		phy->ddr_phony_dqs_timing = prop;
> +
>   	priv->phy = phy;
>   
>   	return 0;
>
