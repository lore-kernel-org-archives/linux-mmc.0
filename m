Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793991892;
	b=GIoo242aILCz6jRJfsR3deHGylT7oBfvUse3iWSRbgtS3s2KU6vV0i8x94dp4Lz5Q3cQ
	 KZTrwDrkS/Nw8MalJBNXWxvvXKO35PTM+sAcn59D8VRPwxecyCGNmbiM10DSrBiFUyxhp
	 ue3JpFB7c5Wcmc6SMTtPljsJ0w9Du4TdGp2xo5QU60AEpROTA0o/3zmndQrhBP+isEWfv
	 rJyazPQ6n6qsW5N3+Z8ygBw9llCwm7FQzas+aMJhz0QktN2BrFloe0a7RzcpEHLfD09dY
	 2WyCoPZITANWA4L3UmjIfXTwQDggahOr8WxpBMIz0eUiTJDqbA3huT+W01ZDNtdBOIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=V47Bsx2pb/Dq9yJGe28O3AbwSEsR61Gl4zn0w9zeRvU=;
	b=iP3/LfPJ4JhbrK0kCKIMI3SuDaCcMawZYHSvpBL2/e6osDEZ49AdIAefN6lbwmL2Chun
	 ftH+iY60vd+Vg/SXB0zMlVOE9GU5tBZgnqgHX3EHiwrFneqDTcR66KssTRg6+tmPPlcSQ
	 WWlIS8X4qaJecR0NjWLo6n/184VTBGaw/ufgRbLFVi+dUl9lJpG1W5zk2N8Qblbos0zAJ
	 r/HCQCehKybKhLKD0a866B8ibc3RWuJ57Ihm0IlM302YZ2iJwapj5lg93Xc7aa3HmDB43
	 nA0Hcxen/2nnKH7mO/+d0+cGlRCs3UonKz58F0uBeXOLVl+FGBR4RTLUzlp/SBClMUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=EfmrpPHU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C7606A326;
	Fri,  6 Nov 2026 19:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=EfmrpPHU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVLEmk5PAZN7A50HErjJcQibsGURSEJhZQ4bb6fZmanCULyLM4FRA9LsJWEd2MdJC41et+LqkyWQDO9VKcNZxI//8DWAbyKUj47upCDLSiCeYcJbWP8FaGh+fjnI0/dArvpiQQv0y4l9NYXdWdgnOp1yCFlqPLWY9VOFEVEcvqIFJLjNV+mJBPwDEWE49NzfALE+3qyNjO7INeVNZ3FOVGYSqyAXk0BvgDXVLeta0/eGEaZEyd2iKRyVWd5YSxMG42uNRYzUeaGRT8mAXse98nR1CZiZbH5MTTKgYhYk8KfZ1zuY7y9xQhXF5wlVPSwMVD2sDRclHFORCtTuUyyyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V47Bsx2pb/Dq9yJGe28O3AbwSEsR61Gl4zn0w9zeRvU=;
 b=CXwnt+4zy4sZlaa8OZLTTyeLMFhwhPxPZVqDTn6kF3kAUD/gf2sKK3ZKI4EPHasq7d2k05du17TrAgUJFuBVfa0RjqI9wX4/DxV6nYEZ3dd2oNi/J8ejESwDNzQJoL+a+lIfENF1iPAjeANx4Ds90ztOJvRQn3+L9sUkyKF0d814nJcGHNSNlHzzVifS9OEONie2aW7PyDq9IzGbFTPjKNDX22FFTrgildo/vdMI2apswDVVvMR47wcNSBH1NlA9Bwn9+SXjYu2+EbLBLBDcrTUdly4hPvEI40FEzrl624EOQgrg2iIxuw5FaCI64MzItIJ+B5H3TXpfSBdAZ7MrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V47Bsx2pb/Dq9yJGe28O3AbwSEsR61Gl4zn0w9zeRvU=;
 b=EfmrpPHUWalFPd/RWisdy2KmFffeySfaJN7cu6bGTcOtPl9fh1f3ZLSeAu67B8Hah3xSPS4ii9xnuJ1968yuo/MnVFzbDgoQt2AinOcO1wg7J8Tuv9F+FHuEoz+MxuSZRuiC78vrWvG+eNJBQri9raZqAmzhyoye8g8bYRTAildQXvYhBgfbgcceRMInXRldp0XCGUOoobrjdSi2xXiFyz2vJ2japoyehTu8wq6Uv2JADC6CTnrN06RFsS6od94wyHk0ZTgbrJm/s6gzuwl3DKUxAxAeoqB+b6LWzlAUlwB1RFA15C7u0nUSnvzLLeIYownc+7ZXQZdoexoAekzubA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6474.namprd03.prod.outlook.com (2603:10b6:303:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 19:04:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 19:04:44 +0000
Message-ID: <e98f0478-1b8b-4296-81c5-92dd4a4fc2f8@altera.com>
Date: Sat, 7 Nov 2026 00:34:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
To: Paul Cercueil <paul.cercueil@bootlin.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
 <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
 <21015d0ab9c99bbe8b187792836ecd267e02d4dd.camel@bootlin.com>
 <d9a9f45c-931f-4799-8c17-3f39bf4dc50d@intel.com>
 <5496704ade7e7f2ea2d7bedf2a68e31daa76518c.camel@bootlin.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <5496704ade7e7f2ea2d7bedf2a68e31daa76518c.camel@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: b23eb1b9-72e6-4e48-bdb8-08df3c38d174
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|261026121527099003|4143699003|261009223027099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|11063799006|10067099003|22082099003|55112099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	PG3xvWBW6mFw8EianpyEMfGYxZWp0SqfWVMJehPUj/pB2i6aPaXUW2ESeczfQS/oqi6oAUMMN2T6N5WXTwatz0BQVuOpCS01WR5y2BV67VX0N/JKb2shoi/OsCJS5JbikJSsDsagMZid0KFp9JNmcptHZ3RM+z/Ld1ryN1/DDoqFHNGRhRweFu2gbo9h/fSAH7pQ0d3xasVvKQpL8mDI7tkaNV+GC+eZLfIFdSGpnjHJ9x+xURlFpfRer2uLDd0sVSbq/f2sT8txswixsk/xPE+yIho1cyTA0LZiofLdK3FbCaaCO9qsMm914IiQUyGO9dbufuwY8U5a8qjUDDwsqm0PqxdbPmna1Em1X3VsQhi/0tbRAmfbDp7dvfsXYe4C/IyLtIRh+Z6Tnq2gEbWsMKI5yptLSicgibNGf7OwRkW2eUtbITFeNiLVka8jnGQsp/FHZI+qIUftJhlFAAbdSlDAtG+WOQXV6kkDVHLijK3VEQM99z2+i7tf/B3eZB0CI4AyBhBQZ35bLBQtkzWNCRIFQuxuyPZ9blEZ4Rx7O8Ky+QYASDm+hI3J7/Q4ADhN8LCK6+woj+L4KTbKxXVH5CFE7lYJzbvezvKDn4NVlUTShAnqq1b5uilMMcS5M+z1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(261026121527099003)(4143699003)(261009223027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTNhblZNM28ybFNnRTY3Yy9nZ0ppTUdFcXdYZDhRUzhLU1k1aEcySkR4VFdU?=
 =?utf-8?B?YXNXdklsOEhqTGNNZElkeDFsTzZjMDBNOFNieHNyQzVxbG5FN3YyMUU1OFNX?=
 =?utf-8?B?REZpSlVmMjVkNU1tS3NQRGlReXVsaFdueG4xMzZuV3FURGxLU3RDQTJ2V1VY?=
 =?utf-8?B?SEVhaXgrZG9BYUdHaTV6Vzg3VTFhVTBYb25hQmhXdnk3RHlpSElRcStad3NI?=
 =?utf-8?B?cWlwMnd2MVZoTy9pSXpJNWc3bWxHcEJYZ0swZ0d5bEpPdEhBSDUxbkFuRkZo?=
 =?utf-8?B?c09yS3c3M284YjRLV3FmOE9FamErcGcyajFCcXBwU2g3RjNZeFFrTEEyYys0?=
 =?utf-8?B?YnhNRUhQREJhMVE5MWtmSjlSdkpUY3VaMzYyaCswdjVGcUdUenlIOFVpRHZv?=
 =?utf-8?B?MWt4c0dXUVVHdklXRnFiL0lzZnZ3OWY2b0RoZ2ZCS2JySWdMSHppNmxNVSty?=
 =?utf-8?B?eHIvMEZDT3h2MWV2SVVwcU9tMlpPbG11VUwralEwUy9pRTlQN25Vc2dwL1pW?=
 =?utf-8?B?cXMxTmZqSTB1RitwV0oxa0lEaDRYQ2xpNFdwQ1U4MkNocmoyTUJWTXVPT0hG?=
 =?utf-8?B?dUN4RXRZL2lCVE00ZEN3RmVNSW5aZFY2Q1BGbjJ1RWNnWW44RXdPanhmNHpp?=
 =?utf-8?B?d0RoSkRFVUtLRkZOLzQxNzNrSEt3NGpaTzN0ejQ4TElJWlBNYXpIQjVwVytl?=
 =?utf-8?B?RFB2UTZyTDNsdUVUMGpjM2taOFBiTFIxdGI3OFEvekR6d0cyMktpaExkWjhw?=
 =?utf-8?B?ZkxwcjdCcDNxRWVEdUszU3VIQzdqalQ2SjU0MzZKVDJuZzRINDdTSURkZVd1?=
 =?utf-8?B?OXpHaTAxREVKOEN5ZWtMaHVhcDR4MitnUDE4dHQ4Q3RrVDZYU2VqODlMTm52?=
 =?utf-8?B?cE82dFN5RjhZelgydEpxTFJMUjMvM1Vvb1BzQTRhS3pjZ2M0OVhtbHI1MTVy?=
 =?utf-8?B?Q3oxMkF4cnVTRXl3dTJGbDJCL2Q1TUdCaFpPNldoYWpPblFhSEFweEZlU3cw?=
 =?utf-8?B?WUJURnVvYWRiWmF2Q0QrM3o0Q2l3QVFTdnE1blYwekNvUzRuekJqTmIvKzkz?=
 =?utf-8?B?L3A5MjFsd1JtdkRzWW1OTlV1cU8yZVFHQUJuWnVNZXFjN1RrZ0ppaDRZK0la?=
 =?utf-8?B?OHdDcXZxNW1WSWllMXNvVkNCMTQ2TDlienpsWGhpZDhUZ1prYzdhRnAveVRt?=
 =?utf-8?B?aGNjTVdnZUwzd3IyNWFvTk1MaUsrbWtQOTRFOG51RnlRc3AvdWxacnF3RFE2?=
 =?utf-8?B?K3RMNHRJYUlWa2xQNFAwSjk0ckJuVUIwM0toZ3U2cDV3ZFRHalA3Mld3ZVVv?=
 =?utf-8?B?SUtzbTZmR09Jd0llc3l5VytmK3J2a2ZEbEhzZjB6YTEvZDNsMG1JUmxUcjJI?=
 =?utf-8?B?YXYwUS8yMXRsYTAxUlhQai9iVk9PVTZrbGxiN0NhejNCWnVRYjBKcmZ6MWhJ?=
 =?utf-8?B?bW1FNGdYUis3czlVWWZOOCt2TmV2TkhlY05iS01yd25TejNHNVNHZUkxUU5F?=
 =?utf-8?B?Yzk5MkxmVS9DaHQ4SE4vM1c5MUFaeUdHOG55OWRIUFlXc2NVcTZUWjNla01D?=
 =?utf-8?B?Vy9ZVEREbTd6Yk1XM2RLRzZyUVZZMXUvOFVIR21OQi9lZzRadWxXVGoySlI1?=
 =?utf-8?B?Z2dDVjBVMDdoWk92RExpVmo2WFBPR09xMWk1WkZQYW41NVJURTh0eURGNEdB?=
 =?utf-8?B?NWV3MHNMdTBYclBETHJIdURMcmRMOWRRaEpGTFVWWkl2UEVqNmNSZFFtNU4y?=
 =?utf-8?B?QWR3MDB3d0o2RVJ2SjZ6a3FLRlhSaEYxY0RHd1pNNUVWK0l5WnNCZkUxTWhX?=
 =?utf-8?B?R0FCajNmYVJ0UmJtMng0dks3YjZXa1FXWHBsMzJDRzZWa3lmaDN3ZTZVUERN?=
 =?utf-8?B?cmoyUnEvaVRPeE5iTnJuVnN5RWlKODJSQzZEdkdIcjNHQU1HbTVlWDI3b1or?=
 =?utf-8?B?cU1ETFczQ1F2RU0wTkVWYitwbVVLajUzQ2tVclJLaFdFME9TdUNkQ0Fwd2Fo?=
 =?utf-8?B?UHlBSHZtN0ZKUnlONktWYTMwTXNyZ0pzZEovNTB0R3BGVEMyMTRIM2swUHFV?=
 =?utf-8?B?aTJuaFhSakh5WWRoT1ZjQjhCYkJBT3h1dlNFMTUxVlBxNVpjVUpCcDRkblVs?=
 =?utf-8?B?cHF4Tk1tY0RiNk5nL0YrRnhXWm1kTnBvam5ZMWsrVGxVNnVsM2QyYVY4S0RT?=
 =?utf-8?B?NGlIYW1Yc1FudkZsSXlCODFTR3drSzNCWjVOYTlmdERvcWxFdHNJd3VVR3dl?=
 =?utf-8?B?UkdRQS9GQXYxV05nZHV0NncxUmg5eUlSUFhoK0VHNmRPQ2RSbHcyc04rRmhn?=
 =?utf-8?B?R0VmYVdvSDFUWVJwQmNIR0U5NzBXSStkZm9kTFhsWlJyQ1loMDE3aU1JcWR1?=
 =?utf-8?Q?XbjvLw5INwUYp+1c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23eb1b9-72e6-4e48-bdb8-08df3c38d174
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:04:44.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AEXefaYFnhIDNiumAdEp8JmtXlelnKGnDny0Gu4XoPvR3eOJWmY82k4mj22jkmBpV2z/HORrS6VYNrqUA6spGtRbX1gnVAHnl3fp4kt0t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6474


On 04-11-2026 21:48, Paul Cercueil wrote:
> Le mercredi 04 novembre 2026 à 18:05 +0200, Adrian Hunter a écrit :
>> On 04/11/2026 16:38, Paul Cercueil wrote:
>>> Hi Adrian,
>>>
>>> Le mercredi 04 novembre 2026 à 16:30 +0200, Adrian Hunter a écrit :
>>>> On 03/11/2026 11:35, Paul Cercueil wrote:
>>>>> Use the device property API instead of the OF-specific property API.
>>>>> This way, the driver will also probe from ACPI.
>>>>>
>>>>> Note the change in the core's probe function for SD6HC. We can't have
>>>>> named clocks in ACPI.
>>>> Do you mean in the future?  ACPI does not provide clocks at all
>>>> at the moment does it?  Otherwise, clocks registered directly by
>>>> clk_register_clkdev() can have names.  Maybe I misunderstand,
>>>> but perhaps clarify the commit message.
>>> I sent another patch in parallel of this one, that adds basic support for
>>> clock
>>> resources introduced in ACPI 6.5:
>>>
>>> https://lore.kernel.org/linux-acpi/20261103084718.8222-1-paul.cercueil@bootlin.com/T/#u
>>>
>> Would have been worth mentioning that in a cover letter.
>>
>> Seems like it gives the clock a name
>>
>> +		snprintf(name, sizeof(name), "%s-clk%u", dev_name(dev), data-
>>> idx++);
>> +
>> +		err = devm_clk_hw_register_clkdev(dev, clk, name,
>> dev_name(dev));
>>
>>   but clk_find() doesn't look like it would match then - the comment says:
>>   *  An entry with a NULL ID is assumed to be a wildcard.
>>   *  If an entry has a device ID, it must match
>>   *  If an entry has a connection ID, it must match	<------
> You're missing part 3 ;)
>
> https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercueil@bootlin.com/T/#u
>
> I also considered not giving them a name (which wouldn't require the clkdev
> patch), but thought that there's probably some ACPI tables out there that
> provide more than one fixed clock for the same device, so it felt like the
> safest option.
Note that on ACPI the driver requests a single unnamed clock and uses
it as "ciu"; with the proposed clkdev change this resolves to the first
clock registered for the device. The "biu" bus clock is not requested
and is expected to be kept enabled by firmware.

Acked-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

