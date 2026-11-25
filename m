Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795591583;
	b=yXcHoNIZSA/Qt6X/MJO3LrZMhyCDj8WmUZpeddxODEDpOHtg763rntohzGhX0BQa/S4U
	 DZGfSb3Ona0CoyAOWoh/cPgSmL9aIMhCmJ9Mu9mJudvxV7FVU4NnQ/of7wEFdw4h9dCTu
	 A2aqVfOl+8jLHcNjIxjBDkc5IZC4HD4sFvqkHA7BoL5FBb+RA1moNhxGSdJaDxZ+ovJbL
	 tSUlhjS9OBYH4dBW+vVnSsSXkOTsBvWn6I5Mrc76b0ypTQt05f3XV/rhQvdwYkGR3xdqc
	 hdtRUQaH0W5wh6+4Yi2OhloUdgNslnIWCcSjSsi0tCm7D60DWen7Lcu/J+IphpxuQeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591583;
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
	bh=3wJMCCTSJrYwQ9biP4gZD2sN/P0osrstDSJEYWxorz4=;
	b=PkmXenrmH2aOVJi3ar2dI7LM/GpY5wiNIYqCCp4pPnrvGHyS+TSVlDXfQirEhzJmLfAc
	 cOHRMNb/kZRLK69UpOrn8jHz5LH8xbxN3yNE6XQDajG6iTj5ggwmuBdmCDZBNbkODFzI3
	 A4ONv/79BfRejt8yzWxb2ncB9mAzSXr1TxYrsEF7OLWxyYjf9pk2vunm6uaTBGbdRxkc6
	 mTdH4MVtHTeq0PNIGQFkiWdU4S6dT4AMJ3XqRxvpUqyf0AxKpGSk3vlps1gE3zvj3yROk
	 RnBz9Getrn7D2xSkkk+8g0aB2xf3xb6DpBpH3sHPPOVJU49fh6tDZrMMYFCDgjvyOYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=CmA3ZvKa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619B606A31E;
	Wed, 25 Nov 2026 07:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4619B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=CmA3ZvKa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYF2PjSPEIo3jSqEjBih4XVPLq6ZVLZyWblxSdVJeY/w/+JpWFTPCyGYiXkkB5CS685oEFm0hedqxYK5H/Xv86nYIG4CvOnlVUFpFpevIAq0NjV6yt03plo3gn7YVlaPd05VeCPM4t1MleYTo8ticc34jD6+OWl3Q3ZFF9ymMdk0L1AQIxGAPuqkmGyAYADMNbTb0ebeX09J0OXmDDI4NXw19dHY4lKkufgJRESYI3kkI7pU86iK13QpAQQdARwO/bLfdG0JXM5bmjnZEi98wy+U38mouyDAwvxNUCh6SDjU/fUqZm6m8QsAl4AVdWjN3XxV/qZDil+Tp+NRwirQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wJMCCTSJrYwQ9biP4gZD2sN/P0osrstDSJEYWxorz4=;
 b=y0qdIMUgbK+Ool86fm2eTCqkIiZwERA4fzgmyiycPVBqyLme3l32eEWxsBf7UH+cWxgTywj9YM1yQNBDPQsBLA0i4x1mPhtrTUpRzpgr9DiG/IJOk1qbYUE0Grz3L3d70n7ljvuJe+1fIU/5znV35moworPfzy8VhxJsxsPYIHWVHCC9DXMW27UjyxNu9B/S4Xgwsi7krJfQ/lQz6WcBnp1k9nZvQmbx/WGC4UhY7rQkxgdubMANprf6ZERgqBAlbyVe9pROdLXdi2y8Y/ZvgWhs6q7iWBmPRKWJKMYcGAeAhV/NWD4gTW3FjYJ6Qx79Xt35DHBXn4EM31UJ1aq0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wJMCCTSJrYwQ9biP4gZD2sN/P0osrstDSJEYWxorz4=;
 b=CmA3ZvKamVCZIOG95qiUhbOOgmntjJEYxcVMh7Cg8MZWIU5phXlbkSIYTPVp8vHdmWptwjBSBV28kf7yXhOGwIJ4tZUKhysQq1otqpOckM8EbmmF1X7EycUy+Yq2Y12FEik+yqV4RTZarIOgmE15+HfTS2WZJcI/4AHBM1in7bGAUUVi5Jrj5Tzp0N4+cWfFQ4oMwEHaLlAL0664KLW3N4pqbxxXtr+DyN/Ufxf4gCCmGadRA+88p/KGaDjY/zEVW5mgIAAy912cRj4ZAzPKbn28bAdE4Mul7hgDRugHTja8QzbCaFFfvoT13q2kLS1++6XuA231EOSbvdBgEDMyZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA2PR03MB5819.namprd03.prod.outlook.com (2603:10b6:806:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Wed, 25 Nov
 2026 07:26:18 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:26:18 +0000
Message-ID: <8bf3eddc-305b-4538-a49a-60e2da2f9b8e@altera.com>
Date: Wed, 25 Nov 2026 15:26:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261119-sd_cadence_ddr50_v3-v4-2-95a94a0aaaf3@altera.com>
 <5de1ad0d-ef89-49e4-9195-195be48d57bf@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <5de1ad0d-ef89-49e4-9195-195be48d57bf@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA2PR03MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cfdc8d-05fa-44fc-5ab8-08df4ac56556
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|921020|4143699003|10067099003|261026140227099003|261026121527099003|56012099006|11063799006|261028144727099003|261022105027099003|261022113327099003|261022075727099003|261021123027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vL1ayOmnyegEGYuEhcUeqaGdYFauh1w25nRXHi/6xnNsloI2pF7QG1fT2meJncRXhYxybcdpxCeR0WtJGGkC9rXWtxtAenxti9PqvIi1ACeZMk7koR3pcQT6n4eZaWl0PrLD3p1KUeJxEHmhwVS5OtLsucQV18HXvBKve+XiurSGMsZD3tTpCN2VLMzsoP3t73nmOBnE1JRx8oxBbOZ3vEWCJ0o1E0pbNWpKql/r0LZw3mQPlzkt6RY/2rF4svXx/8GYSLHFqM72bBPDGP4tbDeQmORvIFtvp8cZnnvLB5roLNHQqvWJ06TwblPbTaCCPc4kuMMrKTL/XTWkFH8MgJeiJAAXu5+uzu39wFm7bBfv5GCXNSvso+6pLUOcI07F9sfQs1FiQ8l2uK+S6bj+65FuPjrrd6oPBsSAEVXu2hNRRTmtggxer7t0mf/9P5CtQX+pXWE9giVFguyQyphsgiKli22bNiNdgOfSWkxdLSRM4281/IczpQol2MZ0WLKIXEevN69nj/eK98XE4dO/SzAe7PVMIdtLlBC7KZ4JwHBoe1IodCMqn6YSqZHVwMTiKhb31BfTqKOJbgJD2mZUddltGBe1ZDb7nX6TUGit7wARWNlp9HLTGxaWMTmPm6R2ugdOEwRbiHiN8rENxI8fPyPP7/BqNN9JQvyn7ZYTwr5q1wGT1+HpExUCveF+fTr6Gdgde5H9cqa7xUY1Ze+ddw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(921020)(4143699003)(10067099003)(261026140227099003)(261026121527099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021123027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE04RXlsaUFtcUNpa2VpL1AzVzBXRzQzL1BiK2dZWVR0WmxXZXl0UDVFbkI3?=
 =?utf-8?B?Qy9XWVRyWjBUUkFZRVViaUozSmhqY1JPSDlsMVZZRXdveFprS3N6L2gwRGd5?=
 =?utf-8?B?V1g0OWM1QjdzeGZ5dllud3Y2RmlBaGFKS01zN3JMT3U2QnhQOExJbzJxS2k4?=
 =?utf-8?B?RlpaWUNYRStvZFd4ZnhyRkNPQnh1S08zaXVKcGNVRUpNL21mb0lTUmcvaWlK?=
 =?utf-8?B?TEZXSitWaXpUREJTWjd6YnFNRmwzc0V0bjJ4bUwvZTVHMXhSbGE5YlhJUDl0?=
 =?utf-8?B?NXFYT1FlNnZzV1RaanFETlJiOENEMGdXV0ttUm4ybndDanF2U0ttWnhVMnB5?=
 =?utf-8?B?NC9rckJuQng4QVJWZXErZ2M3L2xVM2RRZnN5M01wbFZLRWc0LzVZVE9XTWVD?=
 =?utf-8?B?blhsb3FNb2FKTUt3MVg2Q0FPc2tsYWpuUUExYlAxbzYzVDloeFJoN1loZzR6?=
 =?utf-8?B?ZitjMFd3d1dQaCsyNVpHS3l3Z2g5dTFmMlE1d3dVZVZOL0dsRkpheUVJMUs0?=
 =?utf-8?B?Y3BhY1ZFc0U2ZFpDOWZUdFVXejUrVm9qc0dXOWhvU0h1SDB2eFNzaTZyUWRF?=
 =?utf-8?B?b1FsSTNOaERjK2pCdVdJNjgxY2tTRFdrK004VWwvcm9ZWWlJSEtoNVBaQ25N?=
 =?utf-8?B?eXdaNG5pK3hyTmd2YllBSFJRWmw5MlpzbHkvaWNBZ2tIQXRjN0E2eG1wR3g5?=
 =?utf-8?B?MStGUUV1RzhVVVR2a21pa3JxblJxa0NNKzRHYS8zcjIwUVQ2bDBLNWY0U1FC?=
 =?utf-8?B?dHV1OWdwc2dFMnM4bS9XK0twZG9NSkNQOUZlZ3RiTXJpWTdDUGdlTytqazFW?=
 =?utf-8?B?UjZKQkxJNWlta09OMERsSVhCUC9GVVJSWWNCbWNTNUtNZUtnbyt2NjdlR2dk?=
 =?utf-8?B?NjJOaVJ0K1Q3Zjg1d1FpMkp5VXlnSWVqejRKR1pPT2Z2K2xkUUt5c3ppZFhr?=
 =?utf-8?B?VStJYUgwVU5ZQk50ZDBIZ3AzYWljS3lnL0cvNU5aSVpYSnRGaUd6VkR5cUk3?=
 =?utf-8?B?bEMwMlJxOEZHdVF4ODJ2T01tdVFZMGJVMVNQYTkvV00xaUxmVDZpNUoxZ2NI?=
 =?utf-8?B?WGdZY1c3VFlkN2xFek9aKzBmTWFOSWk2WVlSLzdGMmVZZVAweXMwcElsV3Zp?=
 =?utf-8?B?Y0VETTBzMGdIYUZ6UGpwUVByTGI1c1hzOUNNV1hhMjZocWFFUldvT25uZFgy?=
 =?utf-8?B?cjE4K0k2L0o3alZLUFhmVmkvaFFHR1hTTHFVQyt1dml0WGUvUmhvNElqd2Vh?=
 =?utf-8?B?dFA2Mktud2dja2xHY0NkVXlQQkg5OHI4U0M2NHNWTUw1cjBuNUlmWHB2dmFy?=
 =?utf-8?B?SXA0OHpmd1JsdmpYcjlYZC9tYWpwTzdsUEFDRnhUZTRiTE5tYkRXQkovNGFN?=
 =?utf-8?B?RmV2L1A5WHlHWnJkdHBWMXhWMUxjSERXS3BzT3hrZE02bzI2dWpIR0xIZis5?=
 =?utf-8?B?dmRjMHF0UjJxaVF1bWRQb2V5UGN2bTZZbkE1L1VLMThKZVlZdzZQSThVaEMv?=
 =?utf-8?B?ZEFqTjhnL3FDcWFicWpPZ1prdFovNkhQUWRsT3d6SWRJbFVDdDNBUGI4MFNT?=
 =?utf-8?B?dUljb3BmS2Q3MzNKaGFkVFNUMFdmWmJoVGhtTWNTUUV2R1VIc1U5cnJaMmRj?=
 =?utf-8?B?S1ZqZ1g1L3grLzkyWTFzdlovcG9VN0RYT0xya3QyaWdvTWF1MG4wUXhLcFFD?=
 =?utf-8?B?OFBqbzdsYkU5N0MvSTEyVmdqUzN0OERidStYQ3I0MTN4Z2xpNHlXQlBuMlJy?=
 =?utf-8?B?dW5ueE1sSk9idW5OWWJyR0FjQUZzaU04ZEkwK083cVBWTkwzQ0k2K3RMQ3Nn?=
 =?utf-8?B?b2N4eGFpYzArNmw2VUdDSDdFVVRPYktOWTJkQnlEblBiY291YWZ4RWg0NFk2?=
 =?utf-8?B?Z2NnSU50MnA3VTBXRnNQRUM5WTRQejRueXpyQnZEdUVjSkt1SUVpY0N0dVZo?=
 =?utf-8?B?cFdGc3l0OUxJT3NBZ3VFRms0dG9BYnNpbnhDKzJ6NGtHS1hUSnl2emVJcWNn?=
 =?utf-8?B?cURMdzM4cGhyZTNUNll1cERwMXI1ejd2eUZoV1RPSUx4azl0VUlmcys3Q0VZ?=
 =?utf-8?B?ODVaaUZiUDdhWUMrb2RucWtkd1JTNVZ0WWlpSlUwZndpWnE0aGVheWtlQ01D?=
 =?utf-8?B?cGI0OXpoYk1ta09ZTnpYaUNkMnMyOTVnWlZDRElQNzUxR3kwR2JKYUFNblpw?=
 =?utf-8?B?akMyWVR6Y2ZjWFZpcFV6M0kwdFNHVGp6bEN0bDdrMlRCbmF4STVmYmZydEFa?=
 =?utf-8?B?MGVwTGFEZDhEbS8xaHFaOEJIMGx4M3Zydm56TnVLa1dNalJXZ1ZzaVZYaXNN?=
 =?utf-8?B?Wmd1Zy9yRVNIT2VOWGRjMnoxZFZJa3k0eW5YamNVRzd4ekc3Q2lodz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cfdc8d-05fa-44fc-5ab8-08df4ac56556
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:26:18.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7qZtInTWk4uQeRpmWEoYgvFbVqwEPHDp5mqoEgy5YHcBEV9xxhfSDakCa/6QsY7DWpLRyGXCFHXDZzzaVKJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5819



On 23/11/2026 3:05 am, Kathpalia, Tanmay wrote:
> 
> On 19-11-2026 15:15, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
>> static, board/SoC-characterised PHY settings. Add two optional SD6HC
>> properties for the extended-read DDR modes (SD DDR50 and eMMC DDR52):
>>
> 
> I went through the Cadence SD/eMMC DLL PHY IP user guide (IP6185,
> rev 1.03) to understand how the delay applies to each of the read
> strobes, so that is why this comes up on v4.
> 
> The guide marks phony DQS "not used for SD/eMMC" (Fig 2.1), lists
> use_lpbk_dqs and use_ext_lpbk_dqs as "Mandatory setting for SD/eMMC",
> and says external loopback needs no 1/4 cycle delay on the slave DLL.
> 
> Either strobe can capture a DDR read if its edge lands inside the
> card's valid data window, but the delay has to be chosen for that
> strobe. The delay is what moves the edge into the window, and the two
> strobes should not take the same value.
> 
> External loopback goes out through the pads and the board and comes
> back, so most of the round-trip delay is already in the strobe. It
> should need little or no extra delay.
> 
> Phony DQS is generated inside the PHY, so none of that round trip is
> in it. It likely needs a larger delay to meet data that did travel
> through the pads, the board and the card.
> 
> Questions:
> 1. Do DDR50 and DDR52 work with the defaults (loopback DQS, read
>     delay 0)? If not, what fails?
> 2. Did you sweep the read DQS delay with loopback selected?

Hi Tanmay,

Your model of the two strobes is right and matches what we measured: the
delay has to be chosen per strobe, and the two strobes don't share a
value. Loopback carries most of the round-trip, so its eye sits high in
the delay range; the fabricated phony strobe carries none of it and
centres much lower. So I'm not disputing the guide, which loopback stays 
the driver default, and cdns,ddr-no-lpbk-dqs is only a per-board opt-out 
for boards where loopback isn't usable. To your two questions:

1) Defaults (loopback, read delay 0): no, DDR50/DDR52 don't work on the
    Agilex5 SoCDK. Uncentred, the strobe times out on reads, and the
    write CRC-status token (sampled on the same read strobe) mis-samples
    too. Centring via cdns,ddr-read-dqs-delay is mandatory regardless of
    source.

2) Yes, I swept read_dqs_delay with loopback selected before choosing
    phony:

    - Soldered-down (013b/b0): loopback passes only in a narrow window at
      the top of the delay line (~[208,255], ceiling-clipped) and hangs
      below it. Phony passes across a wide mid-range window (~[64,128])
      and fails gracefully. Loopback works but has no margin, so phony
      was chosen for robustness.

    - Modular SoM (longer SD flight time): with loopback, reads time out
      across the whole sweep - the strobe never gates, so more delay
      can't fix it. Only phony, with its assertion timing re-centred for
      the SoM flight time, passes cleanly and survives a cold power
      cycle.

So loopback isn't broken in general and I'm keeping it as the default;
the DT properties exist because these boards' IO either gives loopback
no margin (soldered) or can't gate it at all (modular), so they select
the phony read path and centre it with read_dqs_delay.

Thanks,
Tze Yee
