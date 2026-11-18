Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999720;
	b=gFW7mXDmKnzCfcJNFept8mWN1ZnL021cem1xnn02/wl3n+OiKg9KMn+cInDM+7GR3N8D
	 rNVA/DM4UGUnus5b30Gr+b1huVLuEUk7DHz9oudUVzvVxrwho2dHktg7D+B8FOuRo262h
	 G5gYjVYl1HNaasSOUrec4uMvexvbgdOmfjT2qqSWNgFrYXzC/NrAIfKVII4SNhehPAbSV
	 sGzX4lixMtgCWhn5WYMHUr/Cm+cVEANUxM7VJRbGtQBDHS8TnESRZEbCIZHw0T0qrCTqv
	 wbnCdWqSV0fEi/T8H0pDcdXSbUunZGy+d3msbX4B1vu7ztPEx5ITku/0nEnpqU2rFOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999720;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:References:Content-Language:In-Reply-To:
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
	bh=jJP6nPkrQ91OShhNJq+lQ7wFLVco/sh58XIPXEZpTb0=;
	b=PCllj58IdCU152oN3T0CCTezbfcVuzXCbTOUc6tQqKQj5cY+QbTG2av0Tc5YgUNGQC4n
	 XSu2q00H+I2vKDPBrKAg3KBsxtL9whkfP2WinkGWjUFuLHPOpQWPZHUhC1BnNczwzP1q2
	 yvg6w0OS0Vy7OBHxybKKsEGbbwWO9QYhckv/xOg/tmXRPw5YbbBm2iTxuyH3aC/qKmT3l
	 WlL5a0KWXD7vP5v0ZaErVUzdPfMBjYNkKekEuVMN8hn920iQ0demqk6Pzva5m7x3HL56/
	 2ksCCBIIGQ+wP6nSCvXCGFLmZsZtHTQCYEcA0ENTmd1vZLNaxbqkijhy6sJdphZz43w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=avMc4NQM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.2
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A30606A31C;
	Wed, 18 Nov 2026 11:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=avMc4NQM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH2WvMZW1OLWICwp4a8AfORf0JbITlXUxAuePV1UXE3Cx8t/diyHULc7LYokXMJwCzDByFmKqIRYIZcB66UhO0wF6UlPh2boQHYO8Ctfo+h1XVpMZovFj00AQ1zrZYok+zpQhIJiWZOCf+wvensezVFJiIrMieFeEtaGob3bxoJjJ00iSCu7QM46+JoAZCfhIgLnrTqJDMIe/4oo0I7Fdpq6a5NAQQcUGy+ACyzkZeI3yKSimVtTNpc+wQ7eEd5Ov89X2bzxBWck2jNXahk3/FV+52qNb7rlbo1sOZmkwHc58hgAjobT0PMk34QAjkXOmn6tKaEKnkVnz22iOao5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJP6nPkrQ91OShhNJq+lQ7wFLVco/sh58XIPXEZpTb0=;
 b=bhLEu3xxubUAIbnHiFWDHmMSKAQxyMyEnJI/8PYy5Bd8TnaSo6GLHzriS9u8SUsK2EL6iOKjznqUMLEh5egCV4BspaN+zNDMcIy4v89M0Mu6dAgfsXXoCuPqHfCQ0Sl+Jn36H3cRXEn5pftDOVef6hIf54showNpcF3uvH3NTUARnGf1XM6td5dAqIpuRCpxl74K7zxCV8bwmepLuKuiiN9HOWddwCHaRtTr2kKvS4pzSsdFYyZy3GymFqNZEsFBZ4dI4L+/iV4H+77g9WHbsg6ya3qIyzmm7s5eFDOzgMfbPoIww9oXP4GOjW7Y0E9gmwVMKEDeV6+sZmiKCpQGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJP6nPkrQ91OShhNJq+lQ7wFLVco/sh58XIPXEZpTb0=;
 b=avMc4NQMwRr8uDThxWRc7VtaAWGIT9ydNYywUIi74oH0xcpTE5fiRTHT2TjaDlLzfvFAxN1fBpjN0Z80erQNqBMICPBQWndsHa31R62q6cyl52583E0F8EyqAqWHTpGjSKNXtsv26SxBEUFjkU8BDDVkDM4KH0JpYrrLfHfWg3UAhxKfbJfwQ6h2jR3qgwVaag4S3/cMt4QOAZA7sJqUv9IcDti/eVRHXHHR1Vu3dowG+Oz/tvkUnUlx5MM0T7mFvXD8Z3L83dMExzjX/DVDY/cFw0Tb4i68aA+CMApAET9RIHuD/WMyUE+L33uQn5YhASfHK01/p7QG2y6QUMJJKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV5PR03MB8409.namprd03.prod.outlook.com (2603:10b6:408:35c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:01:57 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:01:56 +0000
Message-ID: <bb093f84-4cff-4bee-9156-17b954c86d71@altera.com>
Date: Wed, 18 Nov 2026 19:01:50 +0800
User-Agent: Mozilla Thunderbird
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from
 device tree
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-4-cb50afece614@altera.com>
 <9c1c80f9-2b86-46e2-a2fd-6ac79bb4cc2b@altera.com>
Content-Language: en-US
In-Reply-To: <9c1c80f9-2b86-46e2-a2fd-6ac79bb4cc2b@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|LV5PR03MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 653b9cf2-4033-4d74-2eee-08df45635c92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|55112099003|3023799007|921020|11063799006|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261022115727099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	7fNoSuqc2HnAE+OfmJtppl1QZEkaU4+gBeUz7QhZ0hGghTXYx2d9KmHIwU7jnSkE7c51YVXY2nFWyj+7e3s/sebkgG9bOWEhHWKKpWZYl0sENTRPX4BXXe53iKJlZzYNBYXF3zkaj6J7QyLOdbcZQEW11Kjz2MDZ6+JUMF+ZIbGZfXNmYar23ETVdY3LiMUuM6ELLBqOY/HumEsDApMU2ekd9enYThUxhuRyNGlUk64IMTlWGzLjR+RKQQ0BKcZ+2am1YX8yA0EnCwL8tRgPkRJmDMG3YLtzYDEZhTKmk6LkDrbdl3sjO76YnTVM037BNtK6bTe1i1vHPYLBNFO4wKPgglOk1UjBDF4FlO0bEn+R0H1lDm8DJaVeCx1w4v76GLcNQ+tYl6HDa+M55Ni6GoZfmpAOgMwrFjpflav45ZeKu5QfmuZ6dDa1KkY+9uE6XXKMUw97+GKb6+oMKJ0brhu+i1H7VqUFFNb4iAFFeL3XTaL0XuTQ/ogcluVYBYAF0AoatWlikbwWOrTU6lQKpDGAotYZEjndLbIo64SdTntrru+6dZinH199QcAD8snHHmA3kpAAfBDbofXKmdbyYuKUxyXhiQiV2qQGUpEeS/oJmKmRaS9+pNUHEb52RY3yi7oJP2/LLrvy+tj73WYGEf7ZZCGCJtXBGEkMzBYH8OXSu/tfqopnBF1nbaLK1HA7KKrkwpBeuj3N/gYQouo5uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(55112099003)(3023799007)(921020)(11063799006)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG1LY1FURVRUWFU0eDFscTF6OEVrSXBRMGd4QS9tazFoalNIdkhiRkdtanpK?=
 =?utf-8?B?bmd1czVDMmY5TjFxTVoxNk1nUFVXWndTSzBpSE1xNGxrNlVjVnFzUEx0bXB3?=
 =?utf-8?B?WENFNm9VN21CMHhyNnRKSU0zcVVhaDRRY2gvUGR2MDB5S0NhWW8xWlRBZVZB?=
 =?utf-8?B?N3NFblZyYWZ2dVc3N2NIVHpWbU94T1R5SGtBY3hhalZ2ZGpveFBtcGJYZjZD?=
 =?utf-8?B?aXE0aGtPYlBBRG40a2tSM0lGOXkvcE9yVjNTSHJXc2VuWXh6Wm5kZnk0Y2da?=
 =?utf-8?B?M2RoVGlDSURDdytwYThnanBGUUh6d0tRd0JEU0ttQUtXamhjbUdXdkZHdWUy?=
 =?utf-8?B?enlNazB1MzFOVmh1a0U2c2d2YjZUby9MK2RqODdpc3JScFNVdW93VGhSL21t?=
 =?utf-8?B?VmY1RzhDTWFYRmFJK0FVL1pRRENUbXVLcWpVaEhUQW5sOS9JbzJvd09SV0hj?=
 =?utf-8?B?TjZpb0Y2Q0VlN21JU3N6SENTeE9UL0pDUjlxR21Jd3V1YlBKbmJjbWtrMGlP?=
 =?utf-8?B?MHQzclBndzNyS1NzTXp1cHZEemZrT2g0Z1MyKytiWFJFZ0QvOFUxNUlHS2tE?=
 =?utf-8?B?bVEybXZlelBmcHRpaWpaTFpUdUZReGNqN0crY0IzeXdOZktBZ1p4bFZFeTFn?=
 =?utf-8?B?S2ZIWCtzZCtKSk91RldLVWY3Vi9tNHVBTHVCc0RJVS92Wms0WFhSbzViRjkr?=
 =?utf-8?B?WUJmdFdWQXJOTTgxVjZhNEVqOFVFTmxWYmtBWS9uUEdVQWRpTFpmeFhjSFI2?=
 =?utf-8?B?b0Y3aU1PT1F3TC84V0pJd0xHQldaaDdJaEsvOVAvR0VsMFE4UjhjRlR6ajNT?=
 =?utf-8?B?RTJES1prWEV0N1N6Vlg0eUI5S01wZEt1SklmNHJGUE5vOS9ySXRSY3JpRkg4?=
 =?utf-8?B?UXpPVFZmYk5jVkIvcys1UzdralN5M0xSaG02MzNwL2svSk5IblEvakdpSm12?=
 =?utf-8?B?QVNrTGdzYTVaa2xGa2wzQ0Fjd09URTZLWkI4RWVjM1dkRzhTNjdOaHJYL0x3?=
 =?utf-8?B?YjJvRW5XVTFoNXdETmtMOXJTWlF3QVd0Ui9UZXBYTGhRNDlzbWRJMlY5Mmly?=
 =?utf-8?B?dE0wczNkWHVmOGU1TFk3dmIxNnZsVk9hdHg5YTBNblAyU0lKeXpzaXFYNXBv?=
 =?utf-8?B?enk1Rm9iaWduTUNiTUxkUDdGdnE5b05jeDl5QVI4TFUwWDZ6MHRlU1pJYmVL?=
 =?utf-8?B?N0lGTzdsOGJiYUNkbmRudUx5QjR5SlNMTlNqVEJnam96UTJvYStLUUh2UUdy?=
 =?utf-8?B?TTViZGF3RkM2dUxWZWd5amo0K29ZTUJVZy9qM2NMY3ZuQUNmVi9ETFVROWlL?=
 =?utf-8?B?aUE5bnlPWmQ5dWNmMjNGQUVyREZpYU9ueWpuWGZSbExzNEpURDA2N2p0VVZP?=
 =?utf-8?B?NURSZ2R1dkRXVmI4ZjZaWHB6T3VVdzFFWEdHOENCdVRnZzNOVXM4THE1OENQ?=
 =?utf-8?B?Y29ta1B6ZTlnVDVuRlFwampOWEtYVkx4MzBwdW1zOFhjdVd3ZS9JeTJXTEJT?=
 =?utf-8?B?RzlVbkx1VFRhOFR0Y1FUMFhUZDJudUdmb2VramdpeUxXSFlQeGkzTzhJYTVQ?=
 =?utf-8?B?VWtUT3lyakVsalZYS0l1WlcyY1R5NzdnTFdHaktyVkRwSHhaMjdsa0xLNGZq?=
 =?utf-8?B?czZSbHVncVE5SU80VEI3bDd3UkpEVlVLTS9EQjlmRU1ibnF2aWp4NVBnU2dI?=
 =?utf-8?B?blBId21XL0tQc3NhbFBCTE9wTHZDaTVqSTNaZTF6QWVYV1JKY3VhWVB4bXg0?=
 =?utf-8?B?UGRDVnd1WlNyOFFsYVRCaitzUlN3bGd3bytuUVdiaDNsUDNneXVLNFBHeWZ5?=
 =?utf-8?B?RENVWFdKV2c5M0duQm13MjBuMjBuSyt3V0dSZEl6WnpFeUdBQ3VoNXBkZmwz?=
 =?utf-8?B?VnVBWFJaclhBZmZKSnlTSHRaRTRvcG5NZDdNV1NxYXlHQzFvR0drNDdBM3Fn?=
 =?utf-8?B?b2E1WWhZZXJ0TFZkUlR5QVlzM2dmTkw0cHZPYUVISXU4eUNJZkJ1TkxFUDMr?=
 =?utf-8?B?Q0FLdGFIOEhBQU1vZitlYUNua0p0ZlNTNytPdEc5c3dqcXRBVEtIT25YNzNy?=
 =?utf-8?B?QllFTkMxUXJKN3NJUGZlMWMzcDlUZ2lSZWJ6dEZDZ3dqc3pSakxSWWl3RnBG?=
 =?utf-8?B?Z2lKNFVWTGJJMFJ1TWRQQTh0clRLMXBrMFptb2NzTkV6V1A1QXhnUFNUczh4?=
 =?utf-8?B?Njd3enZjazM4LzlsRUJnUG1nRDBBL1BKQ3cydnNiYXdlb1ZhcnIvN0lGZFlT?=
 =?utf-8?B?L3FsZ1A2Z1I4blVUMFZQREVFM2IwMlJOcVQ3WVNQYndyUDFtOEZBUGIyVFNF?=
 =?utf-8?B?ZWVYYjRUZ2oxN2lkYTZycElYOHNtYUhaN0YvWGVQYlMybWVlNTZVQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b9cf2-4033-4d74-2eee-08df45635c92
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:01:56.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m8LXsuzkoc9a5gwDFTSuu3YxJrpL0i8m2ui8ewnBWUSQUKzbPZLJTAX+m3bznws0k7bLWhoeTwm/XxZ2Zvw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8409

Hi Tanmay,

Thanks for the review.

On 16/11/2026 2:47 am, Kathpalia, Tanmay wrote:
> 
> On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
>> settings that need board/SoC characterisation. Read the read-DQS delay,
> 
> Nit: the subject and this line say DDR50, but DDR52 is covered too.
> 

I will name both DDR50 and DDR52.

>> read-DQS source and phony DQS assertion timing from the new
>> cdns,ddr-read-dqs-delay, cdns,ddr-no-lpbk-dqs and
>> cdns,ddr-phony-dqs-timing DT properties at PHY probe and apply them in
>> the extended-read DDR modes (DDR50 and DDR52). The read-DQS delay is a
>> count of DLL delay elements (each cdns,delay-element-ps wide) written
>> directly to the 8-bit PHY field (0-255).
>>
>> Loopback DQS is the recommended read-capture path and stays the default;
>> cdns,ddr-no-lpbk-dqs lets a board fall back to the fabricated phony DQS.
>> When a property is absent the driver-computed value is kept - for the
>> phony DQS timing, the value derived from the RE# pulse width
>> (REBAR_PULSE_CYCLES-1).
> 
> The Cadence guide gives no rebar pulse width. It has only the formula 
> and an example
> of 4 (field value 3). The 2 is your measurement at SDMCLK 200 MHz and 
> SDCLK 50 MHz, so it should not
> be an unexplained constant in the common driver. Please see my comment 
> on the override below.
> 

Agreed. I wil drop the the SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES constant 
and derives the field from the live clocks instead:

	/*
	 * In extended-read mode the RE# pulse is held high for half an
	 * SDCLK period, so its width in SDMCLK cycles is half the
	 * SDCLK/SDMCLK divider; the field holds that width minus one.
	 */
	if (phy->sdhc_extended_rd_mode) {
		u32 rebar_cycles = phy->t_sdclk / (2 * phy->t_sdmclk);
		phy->cp_phony_dqs_timing = rebar_cycles ?
			min_t(u32, rebar_cycles - 1,
		  FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING)) : 0;
	} else {
		phy->cp_phony_dqs_timing = 0;
	}

There is no magic number now: the field value comes from the phony DQS 
timing formula in the Cadence PHY guide (cdn_ip6185) applied to the live 
clocks. The guide defines the RE# pulse as half an SDCLK period, so its 
width in SDMCLK cycles is half the SDCLK/SDMCLK divider and the
field holds that width minus one. The guide's own worked example (pulse 
width 4 -> field 3) is the divide-by-8 case; the divide-by-4 case at 
SDMCLK 200 MHz / SDCLK 50 MHz gives width 2 -> field 1, which is also 
what we saw on hardware (field 1 captures both DDR beats, 0 corrupts 
reads). Both lie on width = divider / 2, so the driver derives the field 
from t_sdclk / t_sdmclk rather than carrying a fixed value.

>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Changes in v3:
>> - Read cdns,ddr-read-dqs-delay directly as the delay-element count and
>>    write it to the 8-bit PHY field; dropped the ps->element conversion
>>    (divide by cdns,delay-element-ps) and the FIELD_MAX() clamp.
>>    (Krzysztof Kozlowski)
>> - Hoisted the repeated DDR-mode test to a local bool. (Adrian Hunter)
>> - Removed the probe-time dev_warn() that validated the firmware value.
>>    (Adrian Hunter)
>> - Unwrapped the of_property_read_u32() call to 100 columns.
>>    (Adrian Hunter)
>>
>> Changes in v2:
>> - Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
>>    v6 PHY.
>> - Renamed the properties to cdns,ddr-*.
>> - Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
>>    (dividing by cdns,delay-element-ps), clamping that quotient to the 
>> 8-bit
>>    PHY field. (Krzysztof Kozlowski)
>> - Read cdns,ddr-no-lpbk-dqs via of_property_read_bool().
>>    (Krzysztof Kozlowski)
>> - Dropped the v1 per-property range checks and redundant FIELD_MAX() 
>> write
>>    masks. (Adrian Hunter)
>> - Apply the overrides in both DDR50 and DDR52.
>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 48 +++++++++++++++++++++++ 
>> +++++++---
>>   1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>> host/sdhci-cadence-phy-v6.c
>> index 8d6a9c26c139..d905e39d4b6f 100644
>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> @@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
>>       /* Active delay element (ps); doubled when one SDMCLK requires > 
>> 256 steps */
>>       u32 delay_element;
>> +    /* DDR read-path overrides (SoC-specific) */
>> +    u32 ddr_read_dqs_delay;
>> +    bool ddr_no_lpbk_dqs;
>> +    s32 ddr_phony_dqs_timing;
>> +
> 
> ddr_read_dqs_delay should be u8 (it maps to cp_read_dqs_delay, u8 bits 
> [7:0]).
> Same for ddr_phony_dqs_timing.
> 

I will change it to u8 bits.

>>       /* PHY_DLL_SLAVE_CTRL register fields */
>>       u8 cp_read_dqs_cmd_delay;    /* bits [31:24] */
>>       u8 cp_clk_wrdqs_delay;        /* bits [23:16] */
>> @@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
>>       /* PHY_DQS_TIMING register fields */
>>       bool cp_use_phony_dqs;        /* bit [20] */
>>       bool cp_use_phony_dqs_cmd;    /* bit [19] */
>> +    bool cp_use_lpbk_dqs;        /* bit [21] */
>>       /* PHY_CTRL register fields */
>>       u32 cp_phony_dqs_timing;
>> @@ -511,6 +517,7 @@ static void sdhci_cdns6_phy_calc_dat_in(struct 
>> sdhci_cdns6_phy *phy)
>>   {
>>       u32 hcsdclkadj = 0;
>>       bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
>> +    bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == 
>> MMC_TIMING_MMC_DDR52);
> 
> Patch 2 already tests the DDR modes, so please add this local in patch 2.
> Then patch 4 does not rewrite lines that patch 2 added.
> 

I'll fold patch 2 (the PHONY_DQS_TIMING programming) into this patch. It 
has no standalone effect, where loopback DQS is force-selected until 
this patch adds the opt-out, so the field is muxed out on its own. 
Merging keeps the DDR local and the timing programming in one patch with 
no cross-patch rewrite.

>>       if (strobe_dat) {
>>           phy->cp_use_phony_dqs = false;
>> @@ -523,13 +530,31 @@ static void sdhci_cdns6_phy_calc_dat_in(struct 
>> sdhci_cdns6_phy *phy)
>>       if (phy->mode == MMC_TIMING_MMC_HS200)
>>           phy->cp_read_dqs_delay = phy->hs200_tune_val;
>> -    if (phy->sdhc_extended_rd_mode &&
>> -        (phy->mode == MMC_TIMING_UHS_DDR50 ||
>> -         phy->mode == MMC_TIMING_MMC_DDR52))
>> +    if (ddr && phy->ddr_read_dqs_delay)
>> +        phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;
>> +
>> +    phy->cp_use_lpbk_dqs = 1;
>> +
>> +    if (phy->sdhc_extended_rd_mode && ddr)
>>           phy->cp_phony_dqs_timing = 
>> SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
>>       else
>>           phy->cp_phony_dqs_timing = 0;
>> +    /*
>> +     * Loopback DQS is the recommended read-capture path; allow 
>> boards that
>> +     * need the fabricated phony DQS instead to opt out in the DDR 
>> modes.
>> +     */
>> +    if (ddr && phy->ddr_no_lpbk_dqs)
>> +        phy->cp_use_lpbk_dqs = 0;
> 
> Nit: true/false, like the other cp_use_* fields (also for the = 0 below).
> 

Will use true/false.

>> +
>> +    /*
>> +     * The computed phony DQS timing above is derived from the RE# pulse
>> +     * width. Allow a DT override for boards whose flight time shifts 
>> the
>> +     * returning DDR data relative to the fabricated strobe.
>> +     */
> 
> Please drop phony DQS timing override. The PHY guide sets this field 
> from the rebar pulse
> width, not from the board flight time. Board delay belongs in the read 
> DQS delay. This
> property also puts a raw register value in the device tree.
> 

Agreed. v4 removes the cdns,ddr-phony-dqs-timing property and its driver
override from both the driver and the binding. Board flight time is 
centred through cdns,ddr-read-dqs-delay, and the phony DQS timing is 
computed as above.

> The open question is the width itself. The PHY guide gives no number, 
> only the formula and an
> example of 4. Your 2 is a measurement at 50 MHz. Please try 
> phony_dqs_timing from 0 to 4 in DDR,
> with the phony DQS selected, at 50 MHz and again at a lower card clock 
> (about 25 MHz, by
> lowering max-frequency; please check the actual clock). Compare the data 
> byte for byte.
> 
> If the best value changes with the clock, compute the width in the 
> driver from the two clocks. If
> it stays the same, take the width from the SoC data, or from one device 
> tree property for the width
> in clock cycles. Not a register value, and not a fixed number in the 
> common driver.
> 
> Also, I do not expect the pulse width itself to differ between boards of 
> the same SoC, since the
> controller generates it. I would suggest to open a ticket with Cadence 
> to ask what sets this width.
> 

See my reply above regarding the phony_dqs_timing formula and the 
example in Cadence document. Since they are from that Cadence document, 
I don't think a separate Cadence ticket is needed.

>> +    if (ddr && phy->ddr_phony_dqs_timing >= 0)
>> +        phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing;
>> +
> 
> If it stays, this must also check phy->sdhc_extended_rd_mode: the guide 
> requires 0 when extended
> read is off.
> 

It is dropped, so this is moot; the computed value already returns 0 
when extended read is off (the else branch above).

Thanks,
Tze Yee

>>       if (strobe_dat) {
>>           /* dqs loopback input via IO cell */
>>           hcsdclkadj += phy->iocell_input_delay;
>> @@ -693,10 +718,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv 
>> *priv)
>>       sdhci_cdns6_dll_reset(priv, true);
>>       reg = sdhci_cdns6_read_phy_reg(priv, 
>> SDHCI_CDNS6_PHY_DQS_TIMING_REG);
>> +    reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>>       reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>>       reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>>       reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
>> -    reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>> +    reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy- 
>> >cp_use_lpbk_dqs);
>>       reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy- 
>> >cp_use_phony_dqs);
>>       reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, 
>> phy->cp_use_phony_dqs_cmd);
>>       sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, 
>> reg);
>> @@ -878,6 +904,7 @@ int sdhci_cdns6_phy_probe(struct platform_device 
>> *pdev, struct sdhci_cdns_priv *
>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>       struct sdhci_cdns6_phy *phy;
>>       unsigned long val;
>> +    u32 prop;
>>       int ret;
>>       phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> @@ -916,6 +943,19 @@ int sdhci_cdns6_phy_probe(struct platform_device 
>> *pdev, struct sdhci_cdns_priv *
>>       phy->delay_element_org = phy->delay_element;
>> +    /*
>> +     * Optional read-path tuning for the extended-read DDR modes (SD 
>> DDR50,
>> +     * eMMC DDR52).
>> +     */
>> +    phy->ddr_read_dqs_delay = 0;
>> +    of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay", 
>> &phy->ddr_read_dqs_delay);
>> +
>> +    phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node, 
>> "cdns,ddr-no-lpbk-dqs");
>> +
>> +    phy->ddr_phony_dqs_timing = -1;
>> +    if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs- 
>> timing", &prop))
>> +        phy->ddr_phony_dqs_timing = prop;
>> +
>>       priv->phy = phy;
>>       return 0;
>>

