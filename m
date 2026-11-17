Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794902280;
	b=jQL55n+55G7QPi52pnM4TgUFtYFpF1ebpxrmbOvZ5AasU8DZqx+a7ARlorsxFqUb97SY
	 xfRwWY7Zx/bdi9zuJNJzA96tmYteEBihcCUKW3pRXbHGkxCVd5e8EIUChK+P6ifuPwLph
	 +5I9KqKCpHfh7Pl9HEcXNyX0kb0P+iHDLhJjuDgGcX2vBngwEBTpt9Yo+ddTiWWivBc80
	 d2wFHyE0TBjkbAZEWQbBBsZ0bbjFEdsDhErgRS7wTH371Ac/InzVtSmuJMQAqVjTjC6B9
	 i69uGsaNy4nT5u5W1/xRG3r4zQBPvP4kFa0K8UrD+Qfs2g4zeuobbXrDJib663KC88w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902280;
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
	bh=I6ZVvxzP42QJL1VNvTn29pfFBBLITfHouALdrfODbDw=;
	b=Uu8onjIix1mJe8VChK7M652W+rVKJtFz/5DLTfnoax0mHk3HHfAg7mrV5V72Y6YQ76WN
	 48RCxgGc1eqZnWNzdxDQ2m/AeM/RNSpFBjcEbuvdufCC0G/94brg85+0d0O2xloqWqJQX
	 ykd4ZouTkAhMpFKYmU/VvS42y33qkfrkm38QQtawfy2F/YK6R2p04as/wqmCRCLpnRv/K
	 P3pMxTnI6oLW6Et+J97mrIqRUbX3DTGvO6Id/EuWLqWtubM1vc85eZaZp9E2tLTTtqAIX
	 ANeo8u1dyfu3+oqIbD0PPR2wVsVYU8Bpxkly3ZJbtVQGpcoFmBuTOaMApA9K/pI7sog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=clNmSBc8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53962606A31C;
	Tue, 17 Nov 2026 07:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53962606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=clNmSBc8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLe32/xyNaFnUyxLFdzRqcWze4m+v+9vNzOTmskAp4KkTOxPfk1MV6LnYfRJf9nUW1Levm5eeKq5YOTQG8U3IAFeH5ub/sbkBsxC2JFQ6RR3ktauehmcFTVUU53V05ewTe+NCNIvQnEhkoisaP847YKQjXryQ+M1+wcTA/5mQhLyK0RdwLsWoqE0hQYSSshlLle4X/JFL6yQ8iyIGIpl5yqUJKXq0byrhwVQk36hBs3EjE8DPH6k40Kq1QihDuiO+TsHphJ/Wrpf3kqY/WT6dfCq/FyQDGLKLQlEBMwwNtqyvkx3904RNmcci0g1CJEmQkf8Y50lK5owDyzMDEm+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6ZVvxzP42QJL1VNvTn29pfFBBLITfHouALdrfODbDw=;
 b=ubVf225rU9QVPp0jE4lDVp04GD4B9IzSMrPicWsUYbnuSTObOpmye83zCzsaU8k23H2qKP8Y1xflFDm6nApUaGOOxl/f8bixvbFIgmd9Kb2+H/T4nk9f410N+UrGGJrXNcoQZp8I1tlVrGpzD5tKgQJkK/H29qF1/3lv4rswO6G049b5i3lAuf+nn5qLhg5debNtr7LEjVcHEsM4ZZlMV6J0TZ/ytLja0fAnlbn6tl6ET1J07UOtlqhO0SruVEt3A3Lk+faQFDqNiLj2X2KP2CsLWJ6st46h4hfBzxHvW/w8F1D3zIv3+zeSoru+/Qlf+oB1Y29QAoQOrBFXstIxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6ZVvxzP42QJL1VNvTn29pfFBBLITfHouALdrfODbDw=;
 b=clNmSBc8V+2LX0UtfhJfxzOCvsjh1CuxPLumqAFxsZLiiAjb05vT1MHlV5iXtIaF6FFrT6spM2sCLN5BXXviMnnmXha/V+GHngYIyfv5XE5GOa4VzQ2J1XXlz3yw74rblBsXbMFDyV4J5kPS+lp+wqyOSS9HCcw+n80gRoyfjQV+QXVvg3i2m00r0rzziEQiDVjfU+Zod/LoIjZ1eoW5DfHQgENLmpZdDqpti0n4DPE9x8vgxnu++mqrs9g1fIC70QCn+FU3EsyB4gyJP2z52I7z+Ya5zZnvu315pay6b9zY17eeKZsYe+1ThzXmy/s2V2TO3kVG5FcxJwxaBJUp0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EAYPR03MB989324.namprd03.prod.outlook.com (2603:10b6:303:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:57:57 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:57:57 +0000
Message-ID: <7879888a-b4cd-4c45-bb92-8db776f10d8d@altera.com>
Date: Tue, 17 Nov 2026 15:57:49 +0800
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
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <da0da5ca-164e-45cf-8921-598d67d6a42b@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|EAYPR03MB989324:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ca30dd-2933-4af3-985e-08df44807ddc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|10067099003|11063799006|56012099006|5023799004|4143699003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261021123027099003|261022113327099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y9yEgyO8jt/AFi7mPEnDhkt9kvikfQrVBE4OYh1+e7vkx6TRdJMFOhppNulFd/YkYn7Vt5P0SzxifJ6v6URW2rrmPz+QjtHOngcecaNAsbJYjJm3b+V43/UEdVCJcAJA86vpGjQO6nAbxPT/fKVKRr6W5/SoIge9qVm594UYLq/heVlFfEBZTDlR6Uaw2Fmw+nPt+o2g4Ah2GXJYDKs43GXTWnqVzrYBagr1cNFIuGsNcxrcuyH2B3DI1z7tVvt+jQ5u3SWOR9qOHe+FYR7VEYGXb5kNlD2h6ZDl8/vKNjlYbIFj8Ch/SwBlCyKmIZQlK5MosJ2M8ZLwB1ZIcGJuJCpJ7cimGcwKZEUNVfjbS7Xl3efCLr9lKZe+G12TztF4uErWrS5O5/YeJmSbxLg+eRMfMEics7jAWdboaIlsSiUrWRNgEx5YNw7Ysp9UJ2jiyc+EJ7f293+JU1UzAEzr3X3RbYxrwshtRcVsOFYp78jzogAnw0sWlxSZC6xHujncrnTVAnrqqoHQ4NMibbhd27IyFi4zHQ5cGacQv6f1Vvhn1/9epnY83+pEKgIeuyCmkTLuVw6e8Ftgcm6b8AU7/cVBslQWwXRNpjaqCMulnuuatBwhJtlM2NOIaqmUVGYGfcvjGob1SyCcbIjTdpwSpjqn66uYmH0vS8rFnMyJl1fEgTkx10x0FY5m4C9MuvfxtZycq62X8hvUonrn6kwgCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2ZxTG5uSU1UOXpYbitFeUtrN2V5Y1Q3Y1U1Y1FTUWcrVUU2VVdVajY5bFhD?=
 =?utf-8?B?ZWtLS1VyeXVlZTlpUVg2WjRhQkROQ20wSFNXSE1wOXBpQUZpVDJtc0M2RTk0?=
 =?utf-8?B?TWtVSzNBRm9GVTk3WlpMcC92MC9LNmlmaEhzblQ2NERwS0tUeVlpaGUvN1RM?=
 =?utf-8?B?ZnFhc2QwZDArNDNmSm5ndFpvdXFmekY5UFFiTHV6UVF5UE9UT1VWY3dVeVc0?=
 =?utf-8?B?VS9ZelBBMXNMdjdYSnd1SysvSlE0bG1rNU1DYXZ5VFdlb1l0TTQzQVBJNUZ5?=
 =?utf-8?B?Wnl4Mi9HZTdxaTJmZDdYU0YzQ0N4a1U1ZEVFTkZ2ZWNhSE5CUFhFT2tVSUE0?=
 =?utf-8?B?bVpHWjVtMG5BcTdSY1FzeThTNUZ2Q0IvTHdwUWFEUHZVK2xna1dabWR0V1hh?=
 =?utf-8?B?UXIvbXhEYmN6SHZWb3BHcEEzVzV6Rm9Bd1hwb2pSUmFodGNqZjZmVVpEQ3Vr?=
 =?utf-8?B?R0N5ZWZOaC9qQ1FFWXo1VVEzd1p1L284U0dGU3lYYUVJdFgxMC80YSt4aEo3?=
 =?utf-8?B?NkVnVWt5Q0dXSURmVTVtZnJjNUpMQUlmOWpGNWR4c3M3UDBad1h5dlNoeXov?=
 =?utf-8?B?dWxpb1U0SWhBN2h2NEpXWThlVUVYKzV4MzMvTFNXeFl6UmFBbkpXcldLdG5H?=
 =?utf-8?B?SWdGcGF1R29BbnQvSG41cXVYNm1sd1RpUjJqQ3dhR3dqZEJRcTVzVjlaSDFz?=
 =?utf-8?B?SUVKbmFVK280eGN3WkRpNEVTbW9nMGdpT0VIZzBRNHlUWGJDbFMzSlNTR2Ju?=
 =?utf-8?B?YzB2QXBMRncvRWxGQTVVS0FVekNyNFZnOWdhRGF3OFZEczNQLzZTWkNkTzRz?=
 =?utf-8?B?U0xiek4yL3RvVGlSUG5sZXBXZEdwSTlacEU4aU5WQ0xzRGMrNzAralpjV3dn?=
 =?utf-8?B?ckowbEY4TzZwUW9rNjVyWitCTE9YUyt4c2NCRFptcVBmTTdvOWxDblBSeFlJ?=
 =?utf-8?B?TXN4d2Y2WFpVVTFkZWxZMklGKzBQNllDTEN0V3pFRlFJK1Jxb3RINFdXeGRh?=
 =?utf-8?B?WlJaeTl3aTRMZTRMRTY0WGlMQVlRYW84cW5PQmR2aW0waEdBTXVJK0Z5Yit4?=
 =?utf-8?B?N0tySzJ1cHVmSDRQS3dqN013UGdZaWZoQWNVbllPSDM5UWV0L0I3YmxXazM4?=
 =?utf-8?B?Q25RMlE1bVN2UE55Tm0yNXNaZytvRExIMzdaK0wveTZZcEVEK0N2UlEyM05v?=
 =?utf-8?B?UlBnbnhjL1ZJNDFjN0RzU3Z0ZFZRTit6MTJUb0RqdUlOQVAvQXZVUEVRNklL?=
 =?utf-8?B?K2Z1VUdXSFkzS3NtRS9VbTFaSU5xQVBqRlhKVGFrR0htaEJGMWpPcmdvRWJJ?=
 =?utf-8?B?L0pnWlZJZXkrTG0waXE3U2tZM1ltVG9qWk5WSGF5WGpKTVBJSzJMMzRjdFpt?=
 =?utf-8?B?amFjalVWNVJTZHFBbnplNDRKRFh2UExmNEpaR0VUMzVoSXc5RW5kK25aSW5Q?=
 =?utf-8?B?K0NFR0pua0FTRlVkTXBwS0haZGc5OGthbWR4QlpoWnQ3djA1TDFFTjRnQ2Nt?=
 =?utf-8?B?aHBXdU9CN2Z6UXNVSEl0ZG8rRTN4UjAyNXI1anJKY3VEVmkyUFI2OCtCY3BC?=
 =?utf-8?B?eUYvNHB5ZldRazgrL0dpVlBCVThCTVlxdGdFanp1K0pBdDR3RDlrRHdMNkli?=
 =?utf-8?B?Y3RLUWhRaVR3dEIyVEVWY1AwY0g2bFFHRUpNcWMzYisxU0R0azhhNGl0RlBF?=
 =?utf-8?B?Z2RUT0xha1NaeEZCOVUxZkg4b3c5RzMwUlYrRGJuUld2dEgzQ25UT0NURHBX?=
 =?utf-8?B?V3ZId2t3NzdKeEpJdldmdXJ3WXpyeWs0clpsVEZwWmFubVlLbCtkbmRodGRv?=
 =?utf-8?B?VjRhNU1yVlRxYmRRa2tSSlJzTi84QkdpZlFBQ2FtYnFIYUVDYnYyNWkrRWJW?=
 =?utf-8?B?Y0RWN25DekF0Y1laNzNCWTRvWGNSMkEwV0pUK3V0WUdJSGhOSE1DaHFueVgx?=
 =?utf-8?B?TXduNHVnRm9kZlp0QWNVQmhuK2NXTFRZRkovMU9UUmtrcHZCRGdQTUF0Yk1v?=
 =?utf-8?B?OEN0Q1Q2b2JuaUdYbmRPU2d1ZE5IRnhkU3gzYzVxYWhhUldDVERiWU5tK3Zy?=
 =?utf-8?B?VmtPTHNsY2dGU05iaXd1dUVJaVloZGVBbjd6dlgzNW96VDkyTHdwYWw1YUxI?=
 =?utf-8?B?aDJ1aEIrRjFScmt6VFU4NzdWTldBSDBvSWVHY1RaYjdlZUEyVlArWVUyRW9n?=
 =?utf-8?B?blIza2dHT1gxTFlPVzRzU0g1OTFpOThzT0tiMndVTjE0bkc0WUtocGdJTVdW?=
 =?utf-8?B?YjRMSnpLalAwY0xKemVHaENCeHFsMG41d2dQV3NIMFZ2T1dScmRGK3FwUlBq?=
 =?utf-8?B?ckJDTFhjTzNnUGd5UEhsRWJqSlByTjF6SEhoeXFoV3RZaHZMeTdsdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ca30dd-2933-4af3-985e-08df44807ddc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:57:57.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbPvIt+HAR3spKN7y7S/izvOhEEttqFEWv4sON//8YwNU7JPfaEI1q8QWO3wh6B0u+E0iCQ1Clha4S70B0HFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR03MB989324

Hi Tanmay,

Thanks for the careful review, and sorry for the mixed signals between 
the two threads.

On 15/11/2026 10:51 pm, Kathpalia, Tanmay wrote:
> 
> On 06-11-2026 11:46, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
>> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
>> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
>> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
>> (the silent odd/even edge-capture defect).
>>
>> On this integration the rebar pulse is 2 clk_phy cycles, so extended-
> 
> In the U-Boot thread you said this width is documented in the Cadence 
> SD/eMMC DFI spec; in v1 here
> you said there is no IP-level document. Which is it? If documented, 
> please cite it here and in the
> macro comment. If it is Agilex5-specific, please take it from the 
> altr,agilex5-sd6hc match data
> instead of a constant for every cdns,sd6hc user.
> 

You're right the threads were inconsistent. At v1 I had no IP-level 
reference and used the characterised rebar width. While debugging the 
U-Boot side I found the Cadence documents that actually describe this, 
and I'll cite them from v4 on:

   - COMBO DLL PHY User Guide (cdn_ip6182), phy_ctrl_reg (0x2080)
     bits[9:4] phony_dqs_timing: 0 when extended_read_mode is disabled,
     otherwise the rebar pulse width in clk_phy cycles minus 1 (its own
     example: width 4 -> 3).
   - SD/eMMC DFI Interface spec (cdn_ip6185) section 1.2.6.2, "DAT input
     in extended clock mode" (Fig 1.23 DDR, Fig 1.26 SDR): the rebar
     pulse spans half an SDCLK period.

So the rule is IP-documented; what I didn't have at v1 was the 
reference, not a different rule.

>> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
> 
> In v1 you confirmed DDR52 was validated too and said you would name both 
> modes.
> 

Yes, DDR52 is validated too. I'll name both DDR50 and DDR52 in the 
commit message.

>> corrupts reads). Derive it from the extended-read-mode state and apply
>> it only in DDR modes, since SDR extended-read samples a single edge and
>> is unaffected.
> 
> In v1 you agreed this is not proof ("Agreed the single-edge argument 
> alone is not proof") and kept
> these modes at 0 because they pass there. On 5 Nov, in the U-Boot 
> thread, you wrote the opposite
> rule: by the PHY guide the value "is 1 in extended-read mode and 0 
> otherwise", and U-Boot v2 does
> set 1 for the divided SDR modes. This patch still leaves them at 0, so 
> the two trees disagree. The
> PHY guide is not limited to DDR: 0 when extended read is off, and the 
> rebar width minus 1 when it
> is on. With the rebar width of 2, that is 1 in every extended-read mode. 
> Please program 1 in these
> modes here as well.
> 

Combining the two docs: rebar width (in clk_phy cycles) = (SDCLK/2) / 
clk_phy = divider/2, hence phony_dqs_timing = divider/2 - 1. The "2" in 
v3 was just that evaluated at our clk_phy (~200 MHz -> divider 4 for 
DDR50/DDR52).

Rather than hard-code a number that silently assumes Agilex5's clock, or 
push it into the altr,agilex5-sd6hc match data, I'll derive it from the 
clock ratio the driver already has (t_sdclk / t_sdmclk). That is correct 
for any cdns,sd6hc instance and drops the magic constant, which also 
removes the "this integration" vs "this controller" wording mismatch, 
since there's no macro left to reconcile.

>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Changes in v3:
>> - No change; retains Adrian's Acked-by.
>>
>> Changes in v2:
>> - Added Adrian's Acked-by.
>> - Reworded the commit message to drop the "generic to any SD6HC-PHY SoC"
>>    framing. (Adrian Hunter)
>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>> host/sdhci-cadence-phy-v6.c
>> index 22d56bb46d75..8d6a9c26c139 100644
>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> @@ -90,6 +90,9 @@
>>   #define SDHCI_CDNS6_PHY_CTRL_REG            0x2080
>>   #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING            
>> GENMASK(9, 4)
>> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
>> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES    2
>> +
> 
> The commit says "this integration", the comment says "this controller". 
> Please make them match,
> with a source (see above).
> 

See my reply above. This macro and comment will be removed.

>>   /* Default PHY settings */
>>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY        2500
>>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT        24
>> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>>       bool cp_use_phony_dqs;        /* bit [20] */
>>       bool cp_use_phony_dqs_cmd;    /* bit [19] */
>> +    /* PHY_CTRL register fields */
>> +    u32 cp_phony_dqs_timing;
>> +
> 
> u8 with /* bits [9:4] */, similar to the other cp_* fields.
> 

Will change to u8 with a /* bits [9:4] */ comment, to match the other 
cp_* fields.

>>       /* HRS07 register - IO delay Information */
>>       u8 sdhc_rw_compensate;        /* bits [20:16] */
>>       u8 sdhc_idelay_val;        /* bits [4:0] */
>> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct 
>> sdhci_cdns6_phy *phy)
>>       if (phy->mode == MMC_TIMING_MMC_HS200)
>>           phy->cp_read_dqs_delay = phy->hs200_tune_val;
>> +    if (phy->sdhc_extended_rd_mode &&
>> +        (phy->mode == MMC_TIMING_UHS_DDR50 ||
>> +         phy->mode == MMC_TIMING_MMC_DDR52))
>> +        phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES 
>> - 1;
>> +    else
>> +        phy->cp_phony_dqs_timing = 0;
>> +
> 
> The PHY guide asks for width - 1 whenever extended read is on, which 
> here also covers DS/HS/SDR
> modes. In U-Boot v2 you now do exactly that (1 in every extended-read 
> mode), and said it matches
> the Linux change, but this patch keeps those modes at 0. It's confusing, 
> I would suggest to follow
> the Cadence PHY user guide.
> 

Agreed. The guide keys the field on extended_read_mode, not on DDR, and 
U-Boot v2 already programs width-1 in every extended-read mode. The 
computed form does exactly that: phony_dqs_timing = divider/2 - 1 
whenever extended_read_mode is set, 0 otherwise. So the two trees will 
agree.

>>       if (strobe_dat) {
>>           /* dqs loopback input via IO cell */
>>           hcsdclkadj += phy->iocell_input_delay;
>> @@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv 
>> *priv)
>>       reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>>       reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
>> +    reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
>> +              phy->cp_phony_dqs_timing);
> 
> This write always runs with the loopback DQS selected. The setting you 
> tested was the phony DQS
> (use_lpbk_dqs = 0) and a read delay of 96. The PHY guide says this field 
> times the phony strobe,
> so with loopback it may change nothing. Does this patch by itself fix 
> the bad reads on the
> default loopback path? If not, please put it after patch 4, or merge it 
> into patch 4.


Agreed it has no standalone effect. The loopback is force‑selected until 
the opt‑in lands, so the write is muxed out. I'll fold the 
PHONY_DQS_TIMING programming into patch 4, so the phony‑DQS opt‑in and 
its correct timing land together and no commit can select phony DQS with 
phony_dqs_timing = 0.

Thanks,
Tze Yee
