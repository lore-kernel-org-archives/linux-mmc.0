Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794815993;
	b=LJWxJrIr7+HGZF5GXDj2iWGqCKcjFXsRDX5pn0MaOD9wSFnUhCMXwDlwtI6e0g/uZLn+
	 TNhLy7bZ/XrUFPeRXn2XhHOtc0QJc7ZbzdqQavkgfoCsqIiuJu+fxF7f/DUMa7aJepPz7
	 qkS8XnnWWACfEXwlrSK7f+PLrM8B1dCps8zhrnYgA4PlmuqB9JSeBChI16Cs9sQHFgSfU
	 8fkyxEI/07Sa+ghq/fPUuvDEaS7JbBcj8xDCd0gAJzOo7Jppgnrve2TNQfDlAK5khRk1s
	 fw+g34G51uCiC5R4YvAwrTaP9mV3CCa7zME6JlLto1CS1+RNQOtdTCTCySi/JjGBmYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815993;
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
	bh=P+Wm7cjDKOm3DIQ7p5v0NSz7AYaoFjDxbg3+XOnk7mw=;
	b=Dzke6ISUcd4YcZyniZfTU3xnRn/XTwMjH0wcETofg8tAuPDLORVhVldFIcHRzNzSRE8s
	 EiOUiVGchW5pzLzMYJsIGyqcU93V+tEdMj+VPHto69xr7eck8uv+tkE1UZDKZDScHAOJA
	 ik4VvPrea0S4ztD8a38I4D78cwOS7jDpiT55249xezmSM68aRrPZW/vqdRQRYbUEr928L
	 lR6MECTTYThVGUTk6qz6XY2+FxcX5X8pMt7E/nkjPpicxWisIMmb3FNKW/0xeNLKhoJyo
	 09Z0/aucian8M/C166viCxVQik4Hxf7eMbxBXI9G5dPAuSJVS7qq2cDp56exy8TK4cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vmiBeJv5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.14
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAC606A32A;
	Mon, 16 Nov 2026 07:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADBAC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=vmiBeJv5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlWn9SNZlMgjb2fp01HjNfM7Nc4iUgTbhRTN5nOr+nDTahmx9moRIZCS0Ju3cU4uwL2jZn2TcHz603lkN6iVsin8ZyWSvD9daRiFzcqWDXPe8qf8fNoEz+WruCu7cdSjjLfqtbVx/FTxVh1Hr5oDD4LuAr9Dawwfft6uUm9V7xKE7fd5fY1iK6AcOYvsp5l9XocDVpxmVfTFkZVZdBFL7VA8UDYMEXiXZJpv7eIy8Oyj6E7o4WtE7RNljN3bkE560qYEK0igJhFdYio5KQb9+2SEEzRP05aQfq3CsI0oEbFwa3ujE3wcMHNEuN1qgC69hq4kXWqapT+VJ8kFRT+44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Wm7cjDKOm3DIQ7p5v0NSz7AYaoFjDxbg3+XOnk7mw=;
 b=fPepojhhiNMGle5fUVlvu77bNurWTY4/PzOxzDV1tpdEcbcHuV/W9EhpVJFC7SLf6jRO81ySgTAwBqCrRZKrlMeGcs02D6Pujl9RKDenKZclAJ+hiaL6V6OxWnZKAX2dcFHEdGoUKCdUwAlq6eF5cuZPkj5FZAlBM7kZOr7m8L8+FqYoRdx0bgxGUkj3NmPoTaT4Kyl5mbZKgUImyNrBfjlG6MKJRgHPg3gFlbs0njhAmTxVxk+dh3FeZHCEcTUWDLC7joDm6mc+9V8n8VpB9ZUbjc3/qT6gzy1pIkck7dMd/P3VdPjrgC0U41MEttUApnNO1FQuW+HJyrDi+z15ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+Wm7cjDKOm3DIQ7p5v0NSz7AYaoFjDxbg3+XOnk7mw=;
 b=vmiBeJv5+MlCjJS+ybFXpmwx+hGI6z43FyKjDVStVAMjb88QkM9IimzEa6NfZ9piBUYhLvqP8lMklccIM2Vc3AyDkvfxJ4w4IpBEkyqf0i5jtkN1cxPGKsHMf9+thwr7Pqk41Y4GBJELSssdExPqLy81YHWfa82Yl72k8Hp9XN0QJLg666rIabNj7AhkXSz3SLhQpiYHU8VWDoy2PuV1VNS2ZW2jRpxB7t6OWsWj0rqg5picCyzKkQj3cjQojGjrqm9wmibUQjHoDp7BzcrjoLQU+4Yna/YtV7YsaZcSz6jpxJGHYNgZM1NPZ91XEULGN6JyAut8xiQIFqGWR0bCwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MN6PR03MB7719.namprd03.prod.outlook.com (2603:10b6:208:4f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 07:59:49 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 07:59:48 +0000
Message-ID: <a8383dc1-1e6d-4559-a636-8e1f445bdb46@altera.com>
Date: Mon, 16 Nov 2026 15:59:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mmc: sdhci-cadence: abort failed tuning command on
 SD6HC
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
 <20261106-sd_cadence_ddr50_v3-v3-1-cb50afece614@altera.com>
 <74458f24-9380-4c90-8f6e-6a6f345cc676@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <74458f24-9380-4c90-8f6e-6a6f345cc676@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MN6PR03MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: a48ecedb-b72f-4b24-f8de-08df43b795a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|921020|10067099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NLVY6LdCnobBF3Cx+kizrYGyc/yoDO8Td1v2qDSKPN1dX8ncizJ5FxEnIkNnzqel+l1SvjbQZOJ9w4q2MTwmig8wMFXEMsgKWsi27NCLqJmhHOK69u6S6Q9rbE9RNgBeTg9nKNKso94Az4hSTK5jxkZYx0WxByYEBNy1qWaJeCRnJKpbjSTV/5BGMdnq0nicRuPYL8O6SqNauSh5AYpabFXFfHV1H4TobJlKIO/Z3N4LHlUZLOr/T4rD9ifO4DPUAlMmbmkk+Q8EG/N00LfDP7iF4eDIAv9TOPfSZ/J1tYIulWimiUzzz/VNdSCMpUzCLds3OO6WQf3zLV0MDjgZaiaUdvJ5oONF6eLZmOlsPocLSLDnf3X0J04z8og6p3cTQ1mkekKKyonb2GxFWlrApMhrrn64c+a3gvwuSwifPuTXKJel52yq9JaeQ+XqabBpgGydm/9s+cg9WI8VU9ueZ7PDvhc8A94osZOYWKPHxd3WvNl+l9rf1pNDWvp8gT1fvDJOgeAG/TzgE6HGRlnwkvUrUgJffMt6LvrzzFUtPUWo7ePdqorIGwpkVm7kRQqZAcwbAV0tRctbZ/QWZ/XkVUeKbL0DX7qlDkDaMiokuP51a8AD1vT+pbS5eahCU5VdyZSvpxV+PoTr5VF3CHKrizTosDM4ZUyBgNjPLLstD3lglMmy43DHXytTbFLpTDk6d0UEYG1MmRECs4b0MkAa1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUppTXdtMFROYlUzR0J5TDJ0bDh4QVBUTllneloxbndWay8xakpHK3RTbG81?=
 =?utf-8?B?R1NUdVJCaFVhNEkrL1VEUHFoS0EvQUdWaGVSSjFSb0d5RmJTV0tOQVFEU2pW?=
 =?utf-8?B?emV2emtqaVIrY25ab214aGh3bmtndjBRNHhOOFVVL3FJK2tJS1FvK1VMRnR1?=
 =?utf-8?B?c1lGZ01EUW8yL2lpV2V5bk94dVpPa0svS09ucEtRTlBLb3ZXOTU4MndQK21C?=
 =?utf-8?B?Z3BvTDltTDhUK3dJZ3dSS0dPSm82UW1jVlBZMlFSMFhHZ2VYMVl4aDRMa05I?=
 =?utf-8?B?dWYzbDl2a0ZzRnh3RWltaHFRQVZKb3pSWml4SlBoM1dNd0FZUi9uVzh4N0VK?=
 =?utf-8?B?YnpHT0dHQUt0NU02UUlDLzN5amp3bmlRNTd4OTdudUcvTFowT3BITWhxZU1m?=
 =?utf-8?B?NE55NkEvQW1mdzlYUkQ0clhMcUxwT2gwTTN3K21tNnQ1ckNaSWU0aEljQzlr?=
 =?utf-8?B?ZzVJSk15SUhvS3RyNGdLeUcxYXVJRUdTalFxODc2TExRSnZ0UEwxaEJyWkln?=
 =?utf-8?B?RW0rb1pLME0rUWxOWHVma29KZHRWYlErZVIrZmRUblFhZzhaSUs4NmtyWXZR?=
 =?utf-8?B?U2h2VlBYVGhKSmk3UFNkOTF2YkNod0FNSTRvdW9TK2p5T0YwZG4yWDlmRHF3?=
 =?utf-8?B?V09KeFVjU0NOdlRyVWFPTURlajB3NlkzYXhNcitoY2p6bi8zdmhVeE9QMnB4?=
 =?utf-8?B?UVFnUk94WlRvZHQzaEJNaWpiN2ZJQWZ6MmlUZmNXYm1lK3ZRTW1mMEcva0Vn?=
 =?utf-8?B?S0pQNGZxRmtyN2J3TUZtL2NTeFRYdjJqQzJpZFJ5OW45dHVMVnNDeDFWNXQr?=
 =?utf-8?B?WG9pd2ZnNG1CcmhQNWpQbkRQaEdYYm9qY05RNTYyWTlLZkxJUDlhMzVna0dZ?=
 =?utf-8?B?S2QzNWhUQlRSdVNxa3QzRStMaExtbVQvbEg0ZElRZzY1andQN205MUlVc1F1?=
 =?utf-8?B?SjNRNGJ6TlRpYkJERGhiRmVXaU1QcExXU2RyVzRTb3RzQzFPdGdxRCtlUHZv?=
 =?utf-8?B?d2dZaWJUYUFna2hwNGtIbVI1QUNzZWJOQ0RzVnptek5FQnhValFaODVOUkRU?=
 =?utf-8?B?YVo3TXpFVUlRc3poYUJPNDhUWk1rSEswMkJzTUh5VW8yRjFtMmoyVGRDc0xv?=
 =?utf-8?B?Y1BpMi9NQ3B6OGxYcHhmSFRHcGNORUE0bGw4eU9hNkwvWTJaekRyaGxreFZG?=
 =?utf-8?B?S2xnaXN3cWZIY1lZa21qTFh5OG1jcFlsTmtFbjA5ZW9FNzg5UDZRTlpzb3pE?=
 =?utf-8?B?VUpNSHp6emNReXYvVlZKTEZXYVBpUE02em82T2w2cXNRYkpEdlZxU1lGRzh0?=
 =?utf-8?B?MEJidmJOTHcxUmswK0FCRTJiT2NLdHlJUXZ2VTdhU3B0MVdQSUd4WWxKd3Vq?=
 =?utf-8?B?TE0zZzVMUitPeUk3dE5TaUJDVW1Fd3JzSzRPRGM3T0lWdnFUdzRpeFdHL1o4?=
 =?utf-8?B?Zkw2ZlNVYzhwSVVYTEZQZVBJMzdaWFZJclFQR2NGcitSUXJ0TERIdnhtaFpm?=
 =?utf-8?B?S282Sk8vU3N0cEdwU2JrNUhlVnZLQ1ZydXpvRUQ5NFlENmlpYVdIZENtcmZ5?=
 =?utf-8?B?cWhocjN3dGwrdjhyaU1iVEtaQk5qdTBRN05XelZ3OWNTZ243OUFIak9hUVJJ?=
 =?utf-8?B?VFRhSXozT04zd0VkRFdzcFQ1dUxSTkV6YmhMb2pPanhFQ3VQc3Zack1XUVBt?=
 =?utf-8?B?YWovQ2ZTeXJMc0QrRDRhMldEWjFocklFdDBjL05Oa09EeG1RL05sNnNxWTFn?=
 =?utf-8?B?UEtoTTNUU0h6RkswaHd4RnRiV2hLSkd0UTBiOWczVS9BWXJTSVB0TEg0a2hx?=
 =?utf-8?B?NDhwelVKelFwenZ3TXV1b3hxOXd3Q1dvcHQ5VUExZGgwdFU3WFVDT1RwdlZV?=
 =?utf-8?B?YWhkTkdZMkttYkFMMGlqbWxqK1VpZHFZcG9kRjZaYmRZSmpaOExBY2RZSDE2?=
 =?utf-8?B?cE9qUkoxaWg4SFRqMXZSd0F6TXNsNmpvTXlZaEVrL2hwZTU2OWp5UEVSdWNJ?=
 =?utf-8?B?UWRvSnNCblZ1aEYzak9LaDY1MzJSZGJIQXY1K1JVeVYzTHVlU05wRktjU0xI?=
 =?utf-8?B?QmxVbUF6bzgxTEhmVTB3SndFcFYwbDZ3RkE1NkpNMWJQWmlEYUZOcGFWZks4?=
 =?utf-8?B?ME8rZEM2T0dadS84SmRIb2F5bG9NRUlQNUlhOE5udUE3cm55ejArTGFaQzlT?=
 =?utf-8?B?YVJhTUwreDgvVytZcjAzd1BsOUFKUzd1aHgxMFo5bGR6ZkN0R3VnL0VQcXRj?=
 =?utf-8?B?RCtuSXNETVdDNU93cWdYTnlKWTlrellFU2tRNUs3TkRoWlRMYm9TSlJaMDVV?=
 =?utf-8?B?aDVPenBoTkY2VkxSR2pzZDY0aVZYQTV0dTFtSXFqNm00R3hDYVRkUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ecedb-b72f-4b24-f8de-08df43b795a9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:59:48.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4IgLin5ZYD0iK68Jz9USTf5hjTmLZNzbDqa+uYLSmmtOPqrK1Z3/gj49GLoGg8YK4pktLYiN7h8SRiftEPxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7719



On 16/11/2026 3:21 am, Kathpalia, Tanmay wrote:
> 
> On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng<tze.yee.ng@altera.com>
>>
>> SD6HC uses a software tuning loop that calls mmc_send_tuning() for every
>> tap but never aborts a command that fails. When a CMD21 fails with a
>> command error the eMMC can remain in the Data state and reject the next
>> command, so the CMD6 that mmc_select_hs400() issues right after tuning
>> times out. SD is not affected because CMD12 cannot abort CMD19.
> 
> Nit: The SD state diagram (Fig 4-13) shows CMD12 leaving the data state 
> after CMD19; the
> tuning section just doesn't use it. Instead we can use that SD is 
> unchanged because
> mmc_send_abort_tuning() only acts on CMD21.
> 

Thanks Tanmay. Good catch on Fig 4-13. You are right that CMD12 does 
leave the Data state after CMD19; the real reason SD is unaffected is 
that mmc_send_abort_tuning() is a no-op for CMD19 and only aborts CMD21. 
Reworded the commit message accordingly.

>> Request the command error from mmc_send_tuning() and, on a command
>> error, abort the tuning command with mmc_send_abort_tuning(), which is a
>> no-op for SD. This matches the generic sdhci tuning path.
>>
>> Suggested-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
>> Signed-off-by: Tze Yee Ng<tze.yee.ng@altera.com>
>> ---
>> Changes in v3:
>> - New patch replacing the v2 1/4 PHY settle: abort the failed tuning
>>    command (mmc_send_abort_tuning(), a no-op for SD) instead of masking
>>    the post-tuning command timeout with a settle delay. (Tanmay Kathpalia)
>> ---
>>   drivers/mmc/host/sdhci-cadence-core.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
>> index 745455743b01..a94296cebf47 100644
>> --- a/drivers/mmc/host/sdhci-cadence-core.c
>> +++ b/drivers/mmc/host/sdhci-cadence-core.c
>> @@ -330,9 +330,18 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>>   	}
>>   
>>   	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
>> +		int cmd_error = 0;
>> +
>>   		if (sdhci_cdns_set_tune_val(host, i) ||
>> -		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
>> +		    mmc_send_tuning(host->mmc, opcode, &cmd_error)) { /* bad */
>>   			cur_streak = 0;
>> +			/*
>> +			 * Abort a failed tuning command so an eMMC does not
>> +			 * stay in the Data state and reject the next command;
>> +			 * a no-op for SD.
>> +			 */
>> +			if (cmd_error)
>> +				mmc_send_abort_tuning(host->mmc, opcode);
> 
> sdhci_cdns_execute_tuning() is shared with SD4HC, so this changes those 
> too, and only SD6HC was
> tested. Please limit the abort to SD6HC:
> 
>      if (cmd_error && host->version >= SDHCI_SPEC_420)
>          mmc_send_abort_tuning(host->mmc, opcode);
> 
> If SD4HC should get it too, that can be a follow-up once it has been 
> tested on EyeQ or UniPhier.
> 
> With the SD6HC guard and the commit message fix:
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 

Agreed. I will add the SD6HC guard so the shared 
sdhci_cdns_execute_tuning() only aborts on SD6HC. SD4HC can opt in as a 
follow-up once it's tested on EyeQ/UniPhier. Will carry your Reviewed-by 
in v4.

Thanks for the review!
Tze Yee

