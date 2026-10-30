Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793346652;
	b=cfeHPM1XCX+vgkuIfDh0HQWFRjDuNFKdcSGl3RXSp6bw0SevxvGsBrA53voyrxV8Zumt
	 hMDXe/NUbNALi1i9xFKx/E+iFrPwQjhCw1dRM5l/K2dmmRd3QcUCOojdM/MtNz30VDbuC
	 C0fSaNvvvkX89BDukZiwZT24exTUcJIhxQ7aw69RuJBmHpDvX0Q7/x0inEtcDNc+1/JhY
	 eaHD4TybFMc9eEU+CjqQcdrkp095MLvncCwp4WRXpUGcKAyqBQkZq+K1rpRF8DTG6+rk+
	 j5GLCHcQJPTssqnI6PkUUUJ0OG0sKjC4LhxeW2YGd8QPfA5XWf+aIihAMuDuJc+8Fow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346652;
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
	bh=cmruTk+Waw3ny+TF7JdiUBX9+gHzjUfnrYO+u3bdflU=;
	b=OkQwzSjAcRl9e8Ng7kUj2BcjdTYuzo8d+dRPnQuYlgNJaSG/yNNdOHIkDBIqkFe/Vbvn
	 OU27Ubvn3jBL8UwZA+kk8xtPaRhNK9NhvDnQDfvCjnwNIaxQJaQ0viaZzFLO24IzW7Uqy
	 NueLiMsy2ZByy/PeImrHZXPZG8h6QzvNOLZPJ8A9yPlfgrCNGU9iybiZBXgBgk2rta4By
	 vIuN3mypkokMXpE5kqGvb9w9s61IeQJZrHJaeWJ70E3OaPVyS4LS4/l2B1mXyPTWb5Tjf
	 JVs99x9viA2ZKtsje5a+9k5ZgrQAw+RYBUT+U1Hcts2gEp1wswctPFxAcPLGE6/FSkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=w9JKOOjV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.15
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A048606A31C;
	Fri, 30 Oct 2026 07:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A048606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=w9JKOOjV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwJNaFPjYnofVcRrAgLWNT56C3CLE8Z6ExBYQvu9PG0uY6mkFM6eGWdnwakh6N2Dkfid0PcDazA0eQ3JAUXSpQ8PqosK1CUVWZFBfw8qgHFPCA2xKaC1MG4JiXnsBh5Y4mlK7i4H9zTfqTjByqo6obv35NRoUFpraggJNFrzEpXSVyNBUV1BsbCDP57j6Zw7sXJEjZu6wIp/iGzI+UZIKmd7fB9uTbmHnhyMw1uUcPEN9tShSld3lAtXQq9Hn/l6i8n1odWmaHWVnBRalf79dSVfNMhDbt0PQVnAwYmj+doigNBjS5UmGuoqivW1/HB9Qv8zwS5RYtaraHlUVdjfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmruTk+Waw3ny+TF7JdiUBX9+gHzjUfnrYO+u3bdflU=;
 b=yLR147ilZSvQWNsN0zTvwpsPMJw5imUBtRg3PHSNuLWr8VrZtRTTdqcPoMM66JzaqhvPWe2+FQK6mOI86pYJpADJ+R9yZqah7Y3r935mEqQ6ucpHrXblE3+0xp8ieLPkZtw4eKEz8BxU7g3mwpfv3iT9qEThK/Eh6/qGuSx61F/qJUS7fBNgygsg0+ZijwjPjxPpfSORusQSg2fYjg5hgUR0P1/RBOjYG5tn9VIr1gLps4TD9kW4ZBBrhYatDbFfMVGY/dkS1y0MCxBo5VGOG1Iq3lhxo/RhU68S5aqjxVlluU+ozBW3Vn1qRKdiY9cSArxSxdK3uOqU4OcSFSEcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmruTk+Waw3ny+TF7JdiUBX9+gHzjUfnrYO+u3bdflU=;
 b=w9JKOOjVPuoE34t5c2GSnw0WZoB5srPRVJVyRXLtlI6uebtbhK+21gzFRyX95YDHsTvBW02Uw22RwVF3eYsyLzKBJXkvsvXWWkpbTaodngNa9yVtTi6lWZZQD/WxaXTBmt92llU/plL9mVe8OS6LOs8+Lqy3LgWsECej4IX4OM9aEs8ryB8enO3KbAnH3k9T0dYeXIdK2VKs9F9fTnKR3I5jGbOxgRhJPn4PLRwYS4HEQbiUz/bjbEQS5HHeT0WYEHXRR7esui3hA1vuPEyczBu6UHinitf+MnNx5i6PrZgre1ef8GtiENT0VTneUsXMm5pZ3BmO+EN41jUML3f8nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by SA1PR03MB6337.namprd03.prod.outlook.com (2603:10b6:806:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 07:50:48 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3%4]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 07:50:48 +0000
Message-ID: <28350860-199c-41af-a1df-54face030045@altera.com>
Date: Fri, 30 Oct 2026 15:50:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci-cadence: add PHY settle after tuning
 for SD6HC
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
 <dab17adc-1691-463f-bb85-7d1276fbf28f@altera.com>
 <2723bf11-8477-4f52-a95c-4ede190ecbd5@altera.com>
 <f22270ec-a44b-4836-a0a1-5c7c3b10ce5f@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <f22270ec-a44b-4836-a0a1-5c7c3b10ce5f@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To CO1PR03MB5937.namprd03.prod.outlook.com
 (2603:10b6:303:6e::18)
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
X-MS-TrafficTypeDiagnostic: CO1PR03MB5937:EE_|SA1PR03MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: e968a56c-117b-43de-7a1f-08df365a8312
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|55112099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261028144727099003|10067099003|261022105027099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	5vRCjQ14wQvR04UBbb6CHQOVYEXwjCZXftplfgEZz4FQ2GBYo6E4iSu/IxUx/RhecHBuGHC35ejkneHAuFBJu1u0DM+ZZVuwBDtAAeAN2Fc+zCA3/9ZYjwXqOPVde8Qr3+F82XzB7zelgs8uZwaqK7xQWiIqAefklsQ914TGxW9r1q93QV1UhNIxYAt8dFxRO6lh4Ic9M4rOqto8kenKaLsKkYe4xi2J87C5znzvlR2KAizyLe9cBHX6qIwkBb4CHXYOxHMY6vvS/l6XnLnlXPZZf7CRviDKQrTQhFfvSPXoanvpKgHqs94OEt/658pFmZpNHzktFHsNoo03MXDdOoxh7qL+V7DUHbLQN51bB3AwfNP7ZSQjFMLBS0+NUJg4QJMQ/6wU76CDHcgg1ZkfYvHExklgSg85k3753qhOQY3jefgx+dFQSRLoLnjQF8oeqhGszzXCg9okxxpjaNfhjz1Fcqc7SFlWbExPwf1swHkR9bvWTSkdw/T4cpkNbAghOZheRQX40cs+n5U9HbNlzfMR+1J3Bx9Z/YfTPvE+WyopXlwcGDfIJQqvMDWiVmiK7wg3j9FLPME81HEjQKGVGzdUAsbj4IfVd0dQU9pgo2+iEvJdhR3O7YF1VN7+pEa8h9gWaXImI+WwLBeadlBGTsz7tkY6uJxR+TBw9nvmci8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5937.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(55112099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWN0c2RPKzEvVFloUjE2QXk1SlovVkxPd085N1BESWgyL1YyM2ZGbHIzOVdS?=
 =?utf-8?B?bGVUTXVVUlRkK1JrUk5ydmZiSjhVYkkwdzNGNWlFUHUzc0RsWjF5NEJ5NUJU?=
 =?utf-8?B?cUxUTTFMa2xRWVdKUFdNTFBxRkErY3lMUWN5V1d3bXFJcGEyVTMxZHNTVVgy?=
 =?utf-8?B?OG9RdEZqQTZ0M0YzVVkvVW5xaGZxdUtDdW84dWFsc1lzeG43bU95YmtsZmoy?=
 =?utf-8?B?Y1NJMFJBTkZaK0taWGxCUk5FdGF3cCtrMUJuNDlIdHRMRHBkeVFGMmh5SVpP?=
 =?utf-8?B?RTZvVUlKYzJNcDhCM29vbExVbTRIVk14bVFVS1lOeFN1d3F0QWh1TkNpM1lq?=
 =?utf-8?B?MytOTE16bCt0dGhFVlhxODVsZlgzalRDc2czcFN2Slc0MXVneHNuMVhVNytk?=
 =?utf-8?B?TXgzT0wwL2dnZHRPOWtjRCtnSnJ0MDd5NVMxT3psVThTekJuanJQd2pGMnVN?=
 =?utf-8?B?bUZ3T3NSekxaZ2tKSUtwdWZuMDlCdHVlY2JkOHZMa0dhUHV0V1ZnMzlUeEJy?=
 =?utf-8?B?cEhORVdZczh6VjkyWXgvblhZQjlMenhWRVBmK1QwWjJkRlN1N3hXMXlNYy9m?=
 =?utf-8?B?Vk1ucGtmRGdoczRzSkRPVlVQRXpnMG5mbXRQWDVkT2g3ZWZCeE5XRTJOOFMx?=
 =?utf-8?B?YmFEekRwVkRCbjVyUEZORklzWUtKaVRHbFZmRWhhdCtYSjYxenNhbThqUDY2?=
 =?utf-8?B?TU01enFMMDZtUHFaQisrUXZvNTQzN3lsUGh6aUxRTllIOGZYVHhwU3YvUER4?=
 =?utf-8?B?bTcvU0svVHB1Y2ZvektGSEVCcHc3bjVsSWNzZll1dnF3eTRidkM5bGNYZStj?=
 =?utf-8?B?MGlDTStjWENha2E3MUVOV1V5MTNMdkRTQW9FekthOHBVMkhCOVZ0VW1QdnRo?=
 =?utf-8?B?dCtoQjRhWm81bFJVNkRRTkxRbnNOc3B1L1J1K3ovT0Jiai95SXhzUk1mVGhJ?=
 =?utf-8?B?d1JpRnNuR1hocHVubjlTT0NYM2tFZGlWVmxLRk1lQzZscDJTYmkxSHV0SDU1?=
 =?utf-8?B?MElIL3Q3akJzN0E3aWV0TTY4RENjUE5RTXpPMlY3Y2kzVzlYMFhla1BaZ3NF?=
 =?utf-8?B?TmxmMWZHSi94Smtxa3d6SFJhUmRzM2hxVnQ1NXNIdmRZK1JDUEZ3bnI2R3Zj?=
 =?utf-8?B?Rm1yQTc3Y2owWXZUOUhmS3hlTTBidmI3VU5leHlteHFRenBBRVdFaVlXb3Za?=
 =?utf-8?B?bkI4MnVGT3FXOXBGUVhZM2ZaTFBJdkJrazdERXJUSFE0dE14d0tKaXYrK3pI?=
 =?utf-8?B?UDczbjkrSkJIekZ0WlRrR05HQldZd2VIRmJHdFBJODBualh1MER5RCtvS2Ny?=
 =?utf-8?B?MC8zejE4S0JDRXlXcG40RTUxRVVXcXo5cksvQjZkOVllQmluMVk2aU1ZMTFo?=
 =?utf-8?B?V3NSRnVmdGZzak1pNmNMU2FBN0VtTlBCVXpXNVhMOEFCQ2ZDOEJWSkNwMWhD?=
 =?utf-8?B?OEQ0RlpmWTM2Z3RyUWUra2NuRUdqcGd1NlhIQ1JyOEVPa3FicmRNeHVibzZ6?=
 =?utf-8?B?ZGh4bHpLdW9GRklxSWZRSGZ6OFIzTjhRS3JaaHd4bnBvZnJTRFZUaTZBL2p1?=
 =?utf-8?B?SVo0RFhMN2xVTzkwN20zL1ZyZjlKaVNvQUw4Qzl6N014WnFSRjJpOVhFQWdi?=
 =?utf-8?B?RTdGZi9lenBrUXA1NG9DTzdQaVpXeUpLVVlMcTJFVG1iMWpiNTlHZ0loYXkr?=
 =?utf-8?B?TEthaUZzWDRIVlU4OG5TZk0xWVB1SHJnb05IRjBESVNDOE1GbW1QcnZZek5p?=
 =?utf-8?B?MGVVZk91dkk4SlI5UW5ZV2tkYnJocXFwcGhzT0NYQkhGV1hLSW5WTnFYZVpP?=
 =?utf-8?B?Z05qY1pubU84THVJQm1DSml3T25TVnhhZi9NdXBKTllSYzFkVzQ5ckh6dTVV?=
 =?utf-8?B?TUJyNDY2VlFwMmhDUWROZDFOcVVBbFNMNmpNeEZFaVdXNmQ2blR0d2pHVmho?=
 =?utf-8?B?TjVwTElrRUJ5QlgrejBHeGUveUdQRDhuT3ZhM0NaZHU2dU9yb0pXRnFXYktY?=
 =?utf-8?B?ckJ0ZW1KYjlMWGJQS283UVdWZHYwaEZreWNnSEpWSjlkdm5hTGNVanQ3dUFw?=
 =?utf-8?B?NHNzT1AvSk5MRGNwU05pTE5zZUNtQ1NWU3V2RWszVnI0VGg4cGpxcU0vOVpV?=
 =?utf-8?B?RnB1cUZYRDBWdmliMEZuOVhzaGxlSE5xQ1d4alpodE5YMzZmRDNqeSthQ0lR?=
 =?utf-8?B?WjJPMVovV3pXaWFtMW1LbXpNT2g2SDh4aUhISmNoTEtHOFRYbThCaFpKNkdW?=
 =?utf-8?B?cTBUZEZEbXdWZ2FYdUZGOXJTb3B4eFBtRkdTL2ZqVHU0OVhGTEF0UWJFVlU0?=
 =?utf-8?B?akZPS0xGNGl6bWNKRG1kL1NBU0duVUVtSnkwd245dFkzekJJU1ROUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e968a56c-117b-43de-7a1f-08df365a8312
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:50:48.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE3lK6ELHgawbhCgaJQfetYSreKV2GBwlzI4Q80/E+sixfIH7PAAOkUQVsfIUGTo3Fo3ZNGdMnASFKv4zmCeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6337



On 30/10/2026 3:04 pm, Kathpalia, Tanmay wrote:
> 
> On 30-10-2026 10:55, NG, TZE YEE wrote:
>> Hi Tanmay,
>>
>> Thanks for the detailed walk-through against the spec, it matches what
>> I see on the hardware.
>>
>>
> 
> Hi Tze,
> 
> Thanks for testing this, and I'm glad the abort approach worked on your
> board. The HS400 and SDR104 results, and the ftrace showing CMD12 after
> the failing CMD21, are exactly the confirmation I was looking for.
> 
> I had already written this change while going through the tuning path,
> and I was planning to send it over the weekend once the remaining
> checks were done. Since you may already be folding the same fix into
> v3, how would you like to proceed? I'm happy to send the patch, or
> if you would rather carry it yourself, please add a Suggested-by tag.
> 
> Regards,
> Tanmay

Hi Tanmay,

I'd like to carry it in my series. Patch 1 there currently adds the 
unconditional PHY settle, so I'll replace that patch with the 
abort-on-command-error change and credit you with:

   Suggested-by: Tanmay Kathpalia tanmay.kathpalia@altera.com

It'll go in as patch 1 of v3. Once I've confirmed the ps-vs-count 
question on cdns,ddr-read-dqs-delay with Krzysztof, I'll send out v3.

Thanks again,
Tze Yee
