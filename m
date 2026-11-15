Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754314;
	b=0RlfXLqkEQeBS+/BQgUAA1sfmpLAO7pVPkHq4mESnc1d2U+o0k+q3Jh8nE7pyhc0h35z
	 IKmQg3DmbCYKK8z7TwG/GayJf66NiTkVEi9dkGMCGV5ajQBMdzg+WZhh7CzmJDc5fCjd0
	 QfWxa0DL/e2RI8WP1RRO3Y4hkkdn186N+GR8nDHgNXQUUTSm+oZab4g+5Y+fseRrpPvCv
	 OsfNcILQ7SkkWw/uULoGkziNGgS48iyRgV7Hqolhv8mnwJnnuUNpQ3g+drhAMK/i/9ZnS
	 HUKXPT3Q3YL0iY3Fch2RaY5tIKT7QGVHDp4bsrJFBFC94ebUKHOjMMFBoxPXEl3S3cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754314;
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
	bh=XwbjOJwY60mjRyC6k9De/KYkPNE9S2BAcjjyMo1dLvs=;
	b=dCi+nsZNwQM3uCCA0AviAQ57W2XvYhPIVcnsZgY7l+v7UgJTO8Ao2Jbxpe5EnffCwHp7
	 VtdHgqysv6NEUcHvU5xfX60AlSB3nYr5PD7yEdhAD4QAsa4tHOaaEXS3IBDEbh+ngPVVB
	 x5NNCHZKhTs/2dgBSXkcLFfP/42GeeuAkDPVoDHPNIpjngpyyyo2dr5kpgdST7yUw6ZKT
	 O8VoJl+ceo2xR2r68p3yYk56Gm7I+QhQoKJtIKqy44HJMsbkFc9vIw+5XGwxzzfxp7kW0
	 oW+SUj+HXF4pzmQToEmgvrtkKKZuvg03lckQx+jbwo4MP0V8tfldWvTf7XHOBZP3Jlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Lp+lwA5K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.19
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E3606A31A;
	Sun, 15 Nov 2026 14:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D0E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Lp+lwA5K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYbpWsh6yukvodFEtv7mdMKIjIYNm9gRMPLXIn9z3Su7TxWC7pIsSl3e7MtzPfdyIXcx9Ody0fQhLW6Oos1KS5NF+gpdmXKK6UoGMdMY9BYvRBVOd6VtWMGCPjDfPwnQYUGe/8KVt39lsy9tL0TeDrR1tx3Ze9jUrLdh2Iw/AgW5l1SsuJXIYwXtouvfR+7w422v7ARGqRB7nFQXwpKSB4vLL4GNw+7PNdVScg/BIyWNIMlLKasB07GiMcA6mpekuVj1JIEedLhtPlCrxOs5vDYYe+vOuqJUkWAN8yhQuzvzCetpULyk/1Hl/dtMhYwtk+jKJSzWG/2ayMHkn3DHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwbjOJwY60mjRyC6k9De/KYkPNE9S2BAcjjyMo1dLvs=;
 b=ErUPW6OnVR9uv0dohTwrstRjkfUrx4S5Q1Ui2RgLZYQ79+iviQ+MoqCK5uPwGfQOPC+2zx+E4j/KOMhjL7L2qr84zxuvNSV43M9wGkSaywvSpyGxttjRfQEQNAzYw0Vp6KhXA6m71LXsZjvHPkw5tADCzKtVOixjZaHvp6Nm9gyKg+018WwN+B7VgWpTCLkkdncaQqcIAjpDx4jIYnSYDgSryktQqSBrpw9i7GLJMD/Wb/lMCGB19nVXUDtwOJ/xqG2NXjn7UD4kQjiDfKz8GQKPJDXgiIUxDHdzPk4k2wnVu45DexvMP0CmKkf6hlKLcPigsPUbBgPUB8KO4HAVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwbjOJwY60mjRyC6k9De/KYkPNE9S2BAcjjyMo1dLvs=;
 b=Lp+lwA5Kho53ezv6SynZTUcGkPgprsuryK1plnumgEk3u5OgNeJJkYyabuie6rpQt3ba4RyqC6ttteiubuSqPKJOla26gz+Xt6ZMpkffpUb84LJiEpUslVrGYxUxdXy0gaXS8QH/PaHjPazzbvpHXdZTS/VZ98gmT+vFIpsE/UCa5j0WKLyg4GNNiKG6s6hvkxgrQb1ekZ8xEvQHEZe79gsqdKgD0By5hvSopmiIEBMaUGoPdPaXQmBybxQJXlxsPYAlHiYygUvsqAkpS5gZiXDE0DLKI8HbSl0+WGgsrfe21zL2ko1kYYwT//4wDRbcdC15vw8jaupbnhqGDISjxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV8PR03MB7326.namprd03.prod.outlook.com (2603:10b6:408:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 14:51:47 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 14:51:47 +0000
Message-ID: <da0da5ca-164e-45cf-8921-598d67d6a42b@altera.com>
Date: Sun, 15 Nov 2026 20:21:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-2-cb50afece614@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-2-cb50afece614@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To DM4PR03MB6208.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV8PR03MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3208cbef-e6a2-444d-221c-08df4327f919
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|5023799004|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/eabaM4K3lTSI9bW5j11b6Cn6hDbe7zot3WwgWnBKjxIEB9VJdlTsZRcB0J9noy2GokxBF8BVEyXSKRjpx6ewGiIOs+/nAxLY7vU09NXZ6b5GoRnIcDEeB5MjIr3OREvKnUuobRBUKT8qTeBl0iuqq3aktxf4dwrjeH6VQn0H9K+uaeIwyjYzYbVliNtAAn9cvKSDEMIUC95VQNmFfxu3R06uoPgefU+pB2AHN0RvcKjHX+/AjiHSW5tqsPfOfPZ8y978KQe9ECTAYKjuH8Ol4CDA0cjU4NclgrUCrDx7v9cSyPeA9VgmVHxKp2vcchZjCgyBP2krsRV7ErhbBEiRe97/rUXLVHx3voKwX9Yo5YSls3XjGpy91H5IOzTKLpaCfZNKyzBmuvZoTCCxFg+MGbfkqlpCFJaoEF7En70hKBg195TCAdIsO2p6goS8pUMreT3Zzn+uobTxIuF72YuYzElS0IO0534ruZGWOEvc618AevYJLc+t0nYLcnZqSfMDXgE7xYaZRZw7kp79hmBGihzoVJKAWQ+Li9uR1QnTXeRlFAuJ5o0CPYHqvygpGlZUwrfNi0kKN7kvk0RrUBx4dw3apA86hOlnkBt3pVXJu/WLZa0x6+32ThLi/1C/RSN1ACbmQEG4tkOS/zi4QSaOid4Km8qmEteWESrltnitrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0JYb1lQbkNTNXdqcnNJcXc1L0w4d2FmaUM0THF6azZHc3RNZG1ZRzVXV3Vn?=
 =?utf-8?B?WFdEUjhmSkNNeWw1VG9mL2I5ZS9MN1d2OHRiTTU1ajA2ZTFLb1A1MFk0cnN1?=
 =?utf-8?B?YnR1cGJocStBWS9jNXJLaFFabGVoYjV5UStQR2trOWJaYVpLaWxBaHY1S1JB?=
 =?utf-8?B?aHV4NlMzOGd4bTMvUmlkUmVRbFozUUNNdG0xTUNDR2s2NmlmUmRCYXlHakZ1?=
 =?utf-8?B?eHQvQXhMQlRqL0l5Q0xwLzR2dWpSMDhHazcxQmF3TUUwK3dsWTdvM3Juc0ND?=
 =?utf-8?B?VjYvOGxXV0JXTFpjZlYva1QyWWoxS0FKMGtNRFlKT29JV3J0cDRhMHNZd1dn?=
 =?utf-8?B?TlhRVDJuanQ1NWtWcmJNalV2TVlSNmhkK2xLU2phQVNYWTVNdGVGN3ZiRW1z?=
 =?utf-8?B?VTZxeWp6TU1VK3JQYjlNTTRZMnZUOG4wQTFkVmc0TE5ZUWtyaWsvdWRHdy8r?=
 =?utf-8?B?MWZJdEhoVkw5SzJWZW9ZOHgxVGZ4WFFPNnY2YzB6UCtsU3laUDdqOWdVK1hU?=
 =?utf-8?B?MmhKUzh3alcrNmxZUi9kRUhac1VjTGMxWGcrekNNQnUwWUcrQ1pKdW1IRVBE?=
 =?utf-8?B?MzgzdSs4RWdrWWtzcDVPZFRSOFJUYkdtOG1CbmtKRzcrWm04T0pwMmJaRzVZ?=
 =?utf-8?B?alUvcVkwK2NhcnRxeXc1TUxuOXBsWDNmM2h5citRTnhoVnEzbCtEcUkrN293?=
 =?utf-8?B?d3hzZkRqYytUa01PSi92cFovRG52a0hZcDhuK3o1dUxDL1o1TFRuRGQwRTVE?=
 =?utf-8?B?QTh1UEc4ZHNJVzlGamVrdjg4Snh5OEhvc1BYTGg2allGNUQ0V1l2Y0ZxaG1N?=
 =?utf-8?B?TjVOekV0Tkphd1lFWDFtNkhQTWpEQVJaeDVwSXMzamFWRzFocXlQbCtQSHBI?=
 =?utf-8?B?MkZncUo4V0M5YnhWbTdlNEo3RmY0SFZiNFRSTTViU2I5RWh6dExDWm11VlR2?=
 =?utf-8?B?M3ZlNFJ1aXg3SFhmUWhPSFZEa0p2bFMwQURKL1duTmZ3N2pER0dGbDdWKzFJ?=
 =?utf-8?B?LzNmSTdIQkdxN1hEWi96MUhmakhPZ1JxTFVjSFdFMUg0TUtzS3huT3RiNnBN?=
 =?utf-8?B?MWNNK0NvclhXUG1qUGtXL3B3emZFUytOaVFOdzI1TU9ISmV0Mno4TTZVcGo5?=
 =?utf-8?B?eVNyU21PeUs0eVJrVzFhemRXMW1pUHd5aFhTQUYwbGNPR0ovSFd5L0ZFcHY4?=
 =?utf-8?B?c09DVDJ4RU1WcTZNZ25tVDhhUGZ6US9pNk9FTmtKaXVNa2Q0T3ZmVGFpbkRX?=
 =?utf-8?B?VVptOFlMUXU1UWgwWlk5NnpLcTJKMkRSeWhEdnNiREdyamZRZnB4bGphbXFV?=
 =?utf-8?B?VXZkcm9wRVZKODB3alB3dUpMNVlzNVpMVERZdDd2LzdhOE5EMkFsYnd0bWhQ?=
 =?utf-8?B?OUVMVkRpa01UZXZkemlZVFkrWmNPKzBLWkU5eDY1OG8xTzZ0N2dBQjdGbmhB?=
 =?utf-8?B?ZWQzd2M1bTN1ZlVIREtNR2R6RExFYkhIVTgxbUt3Uk5FQ2p0cXpBZWN5SzZE?=
 =?utf-8?B?NHZDMlF5NHNYZGE2bko2d01RdUxNeTZtM255VFJSUHhNamhvU21TQW1wb1A0?=
 =?utf-8?B?L3QxZUkzekJGQlV4WHJ4Sy8vZWorS3EzdDNLbXBlTnU5Z1RCMkVDZ2kzVHpO?=
 =?utf-8?B?VmFYOGp4TjM2M0dOVkZBcXZJWXBhcEtmYTkwbEREUE1aK0xjdFNUTXNKajZi?=
 =?utf-8?B?S1VER3BJMjJZR0xOZlNVOUZLSFg5UE1FZ2Z5SEtGWlpWNG9rOENaa0szMDdL?=
 =?utf-8?B?bEszUFBVeDRJUFZieTlCSVkxYXBWVG9tWHVBZnJ3dUJCdC9Vcm9OQ2FTajYy?=
 =?utf-8?B?WHhoTmR5L3V2WFBDcnpaUTU0cXFhV1RxK3lOdTRXbzJtUWdBdkp6UzZZbWFz?=
 =?utf-8?B?MjBFRkUvVG1hdGxuWlB2bHRDaVlqdm5SODRDQSs1c21BUUlHWCtmeFNlUUpR?=
 =?utf-8?B?cWJUdUw2LzhROWNwT042YUp1Yis3WHRQb3FKVTZJS1VQL05nK1dnY3VnSjF3?=
 =?utf-8?B?Z254RW5hYUI1VEtpamEvcThtU09jdTM5dVFRZU8vdFYrdFl6RlRCRnlueWd4?=
 =?utf-8?B?SkVKY05UMWRiWTFqdngxWWcwM3J2NjloU0lya0xPbDZ0eGZmZU1Yd0xlUmxM?=
 =?utf-8?B?MHRZcU44K1NXbDd6UUlzQ0tQRkkzK3RRTUdsN3NnN2tTb2J0QTJEaHJtdEJs?=
 =?utf-8?B?d20xcC83OCsxRVJZdCtGYUlLK09rM2JocCs2Y1N0bmdERWFNMGlYamVRbkdj?=
 =?utf-8?B?c2h5NnUySEo0czlMWFllMElialhmaXR6eFdDU0tsWWVPN0pPRS95UUhnc1Zv?=
 =?utf-8?B?Q3JVQzNyaThSQWNQaHpwZFFUaEQ4S0JxUWFCSDlvb29WYlBuMkN0NE9NUmFp?=
 =?utf-8?Q?twFILK67nOGOFjTs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3208cbef-e6a2-444d-221c-08df4327f919
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 14:51:47.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvAD1dKKttIYIVmXDpY8/CD9iX4coTgGvXKi5zga/Dp9pSnKdYmmLpW1JBYSrOAKK/8lRu/23jL9vEdyYqWSA5EwgZiZaHGb8GFRSdQUBc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7326


On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
> (the silent odd/even edge-capture defect).
>
> On this integration the rebar pulse is 2 clk_phy cycles, so extended-

In the U-Boot thread you said this width is documented in the Cadence 
SD/eMMC DFI spec; in v1 here
you said there is no IP-level document. Which is it? If documented, 
please cite it here and in the
macro comment. If it is Agilex5-specific, please take it from the 
altr,agilex5-sd6hc match data
instead of a constant for every cdns,sd6hc user.

> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2

In v1 you confirmed DDR52 was validated too and said you would name both 
modes.

> corrupts reads). Derive it from the extended-read-mode state and apply
> it only in DDR modes, since SDR extended-read samples a single edge and
> is unaffected.

In v1 you agreed this is not proof ("Agreed the single-edge argument 
alone is not proof") and kept
these modes at 0 because they pass there. On 5 Nov, in the U-Boot 
thread, you wrote the opposite
rule: by the PHY guide the value "is 1 in extended-read mode and 0 
otherwise", and U-Boot v2 does
set 1 for the divided SDR modes. This patch still leaves them at 0, so 
the two trees disagree. The
PHY guide is not limited to DDR: 0 when extended read is off, and the 
rebar width minus 1 when it
is on. With the rebar width of 2, that is 1 in every extended-read mode. 
Please program 1 in these
modes here as well.

>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:
> - No change; retains Adrian's Acked-by.
>
> Changes in v2:
> - Added Adrian's Acked-by.
> - Reworded the commit message to drop the "generic to any SD6HC-PHY SoC"
>    framing. (Adrian Hunter)
> ---
>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 22d56bb46d75..8d6a9c26c139 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -90,6 +90,9 @@
>   #define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
>   #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
>   
> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES	2
> +

The commit says "this integration", the comment says "this controller". 
Please make them match,
with a source (see above).

>   /* Default PHY settings */
>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>   	bool cp_use_phony_dqs;		/* bit [20] */
>   	bool cp_use_phony_dqs_cmd;	/* bit [19] */
>   
> +	/* PHY_CTRL register fields */
> +	u32 cp_phony_dqs_timing;
> +

u8 with /* bits [9:4] */, similar to the other cp_* fields.

>   	/* HRS07 register - IO delay Information */
>   	u8 sdhc_rw_compensate;		/* bits [20:16] */
>   	u8 sdhc_idelay_val;		/* bits [4:0] */
> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>   	if (phy->mode == MMC_TIMING_MMC_HS200)
>   		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>   
> +	if (phy->sdhc_extended_rd_mode &&
> +	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52))
> +		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
> +	else
> +		phy->cp_phony_dqs_timing = 0;
> +

The PHY guide asks for width - 1 whenever extended read is on, which 
here also covers DS/HS/SDR
modes. In U-Boot v2 you now do exactly that (1 in every extended-read 
mode), and said it matches
the Linux change, but this patch keeps those modes at 0. It's confusing, 
I would suggest to follow
the Cadence PHY user guide.

>   	if (strobe_dat) {
>   		/* dqs loopback input via IO cell */
>   		hcsdclkadj += phy->iocell_input_delay;
> @@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>   
>   	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>   	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
> +			  phy->cp_phony_dqs_timing);

This write always runs with the loopback DQS selected. The setting you 
tested was the phony DQS
(use_lpbk_dqs = 0) and a read delay of 96. The PHY guide says this field 
times the phony strobe,
so with loopback it may change nothing. Does this patch by itself fix 
the bad reads on the
default loopback path? If not, please put it after patch 4, or merge it 
into patch 4.

