Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795588698;
	b=X71/PFORu9+1he8Gqau/oApM0J+F/elMVXzpPcU6l3Xj0AnK/YaBTdcrT7CzUq5XP5th
	 XMZvM1UOMgudp7SDRXtJeVxoA4fnIa3ThmbKjsNTrhY0FZJ1b2FihxDX5t+JPTGeDI7vw
	 o4c5g44dnC1UWICzo5zTjvpU+wSulrF0V3Bw4dSYYkVfSZmPpHGRNLZJtZH67VCb1WTTV
	 DiBe66DzZrBBj9to3bxsKtV+DiQHZzLgX+4qYMd8esJHsakpB2Q2sUjqYYqkDVQDSVL6X
	 CAVfttCLo8frpD0Ddz1475rcIJnawBmdzMDqaDGo25FBjfH3qMek/eWjGCPi5KxXVTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588698;
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
	bh=JigVW69DZBAAUuc+JQkQ23egBAmrCRg5mjuacsz4uus=;
	b=JNRHcs9+lP3tcMovobM+FJSCp+ROl2G5z6L8vpqgsK534TdTBeYHHtqRBdHR64mQgNho
	 vVZA9rZhzcJxOwBXbEcLpsBFJqBMgYdZM+wj54Eh9+SrFS1pqCOY0ksG6bxKmYxZKXnvT
	 4ZRkCYwQ7QMlOHmesKJV9wVZgIxqTHh+HW4RKf4yf98I6Us7r1H5Vb0ln4zGzZPtN++yD
	 bOJytPXJYXGz8/V67fWGc6eyLAp8r76qhuex0twYe1JlVCO+TeYbZcBcRkcp9kjnyq2oS
	 1Q/fdaFr9Wa5VtTdc+lhIFCRSCaiBKv1ZhL+lYD78mVwtt7L8zeiPCrGcerr+lMpv+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Bmdmc++N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.39
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE2606A323;
	Wed, 25 Nov 2026 06:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Bmdmc++N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdKvK2mdyEZNPFQHwVDsg615Uqj/nWHi2QInMNmapnkymusKFvWLd6dFfOV9pq9n7Seeu6xfiqek9HrMKFZaU+Gx8ZBD2xpu4575O+u5kcFkxS5D5m3MdJsUNEmuVEodhbZY7LKPkcvgPHC9kc8gjvAg4///OFftScfPtqH5s4l9BLcyUzZFxlAMqU5UoJ4NwMAL9d+KU241RCoGPdCSaSf9Eats8/GJGiBtdJqlYt6cWqkEnZLaevDqQdrjV4hgPRXc1TxnGyXW8FREUlL2ShLa8IXFuz1vHMSsdaYnlT9yfDF7RXKSUP993ELUEyz0ZmTKbR10iF7yb62CPK7j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JigVW69DZBAAUuc+JQkQ23egBAmrCRg5mjuacsz4uus=;
 b=cz4PR17zGPhSctb6aoUSQPhhVEllJU3k88VO17PpTVgE/cxM7o0GPVEAfzzq5m/I0DyRxJJwUWJlYDtUrWs3ABbkVBFKY4TIBlr75u4qiWIgb0nuHBrlPSBDgl0b44CB/nkC8iihIIyRXbXnzGtAdkPpOYr9GCfFL7XhCDBRbbu3JHkT6t6TFzlTAUHH2u/37dICzoiulEE3OiJj87fdPqb3lcW5XLrq+7J2Cpdm0wSnkFg185lmMEzfxi7ObLep7CxXwV+iP4JwfhuOlQ45ykcfQuz4ulXCEG3VuxKzPJ1KO944fnLWF9HJQF7bmoTZNhmAI/MOzKKyoc4L52Orvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JigVW69DZBAAUuc+JQkQ23egBAmrCRg5mjuacsz4uus=;
 b=Bmdmc++N0uA0wCruy4kvgWgqyq6vW/k40/K59GM+zXlM0oTKUvbvg5JD/2BbVfCbrLTgl639loKi/ik256m9cDCMNBmRGaQJoN3c2pQq9uu0738QY8RYkUu08PyzZVE7BDC2JBf8P2/TVOuus3ABXcHGpY1j8aF/WkDP/zPB5YYo9Jz9qRpugdYMnOM5DI6jWsO9upnmnJLJvAxIkPLK7Yc+taE3xfJsZ4EqapPmbs4N6YMUxFYvOICCI2rhmgwGWI9eC2jk0+wm6dwhd3lYGwptjnZMdQh+aOvNdcm+AbYG930VCa7mAHWHdKf33+cghhjpH6rmqOZqttaUsSY/GQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS0PR03MB989311.namprd03.prod.outlook.com (2603:10b6:8:396::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 06:38:16 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 06:38:16 +0000
Message-ID: <931f46d7-3396-4f3c-89dd-09fdb7032ed7@altera.com>
Date: Wed, 25 Nov 2026 14:38:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path
 tuning and fixes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
 <20261122-vague-chestnut-peacock-cc8b69@quoll>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <20261122-vague-chestnut-peacock-cc8b69@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI6PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:4:285::13) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DS0PR03MB989311:EE_
X-MS-Office365-Filtering-Correlation-Id: f60cf375-1784-4701-3fc3-08df4abeaf67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|55112099003|11063799006|56012099006|4143699003|261022105027099003|261022113327099003|261028144727099003|261022075727099003|261026121527099003|261026140227099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	txwpOXeN1XaIHP+99PnV1nwer5d906+v4vHr+n1L8Ry/xiZHHhE0gOYKKk8Y6wpoJl3WslI63RxR7Db7lAETX1zMHuOLpgbpGViSGFBSOxI88XH5/qwciABTVsm2oRkUmwWkcfl8GDIfIOVWvHSXBWknCXte8knopYZIojOFVpkIkROxkY9Eg1Q3DEZLbXSIvPGsods1/JjYP2BQbU47GKILjZc0rU6NNueKHJxcWos8GXrUCuLpR5T+jHJw0ks1Hrw+bFtG2vy7UzZDA4Sc4xmWhdxMt/ROyeDi0CvhqWXjmc/MSHSN2/IH8+Lan4btegdUKO8t/QNuM/Fycm/iyLyL3lj6IjpHuTAYlevk2vUa8mdq97qOn4+3p+FY+0RAauO1HuNNMHWKYyZxfcaaMbHD/EEVQto1Eh0T6XojSiR0hywu9JpHS20vKARLEZojPQ4a8+YZ0t/n/ITuy4ue9MtKf2SbtqwrDymYOb034URsLmRZfHAyefuGFKJUUksajLYutEarvHasm+sE98TUJxcJho4bVXXBq9m9UjNb6nJvLHpXOCAZ7a0FHwD8iiwwgxkweoRJaB/A5724WKqYxhFA0Y0YUjF1PBfnsAbXPFnNFGZ56R8F9aptyJLDKA20YL5f2C/90QYaFieph9h65n7p6qypJP5jfnSUKpTCAbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006)(4143699003)(261022105027099003)(261022113327099003)(261028144727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlU2TU95WW40QnY2emRKNGlXOXVCeGpYcndTdE5ycXRIKzM4eWdJSFJpc01p?=
 =?utf-8?B?eUg5V05BMGcxYnpqNlA1YjU3cVdFNEVHVk5EaWtpd1JRRmtFSCt4YmVQcURm?=
 =?utf-8?B?NG9mT2F0dTMxemdYOUtGYXYraVNMMDFRQUdjYTFmblIrMU5Xa3ZwV1N6bkln?=
 =?utf-8?B?c2h2bUNmYUowSnBxbXpHekM5OVI1L0N3L0FNOE9PSmVSb1B4RFNselFPSGZY?=
 =?utf-8?B?SlpjK0JiTVNENWFUWlRwZ05NWXo2YTAxUkJONXBQSjRVY2dUaCt1cmtSMWVD?=
 =?utf-8?B?dDd1SWlOK1kzNkR6OENBczlqR2d0eUVhSDdQQjEwVkZJUnNIUXMzdkI3TTV1?=
 =?utf-8?B?aFplQ0gwWHZnYi8rRXlMYVFET0N0WXc4NWNXVWdiVnZ2K3NmMmZUL2pHeENR?=
 =?utf-8?B?SFJ0amJWNTVrazRydlBuK0p1NWxDL3hac0x3bTFobE5HOVdNRTlIYmJZaFZ1?=
 =?utf-8?B?N01Lb1o0R3duQ1JnN2hDV1ZhaisyQWM0S2tqQ05Mek5WQmc0ZmNkMWZCRUxt?=
 =?utf-8?B?MDZxZ2RMdzJBYkwwNHJSL0RZaGRYTjlmNld3SEhBa042T0diTVdjMXUyeFY3?=
 =?utf-8?B?TjFpRXhmMVB0SVJOa3lSdEU1QzI1dEg5VTVyRDhOUWdhM1Mxb3RLMXRGLzJa?=
 =?utf-8?B?TGprRWNGZ0wxdU9GNXdFZG1IMHR0WlJkMGhvY013RHZXcUYxeXBlYlppTXY1?=
 =?utf-8?B?Y2YvbHNkQ0E5TjI3WGNpM2kxb3NndTI5ZFIxVmxyRHhsbjdTYWtrb1h4Y2tI?=
 =?utf-8?B?Tktja1QraVMzaUlWbHprK3FRY0hEdTA0blk3czFSa2UyV3YwUGRLZTlyRlRq?=
 =?utf-8?B?NnhuN1hEc1UwcmhzdWZvdlNLZlA5a3VrOTBaSWFPTHVLRVEvNkZLYnE5b0x6?=
 =?utf-8?B?YnpROXpza0N5ZGM2UEthUm1Yd2kxWVB2aUEwVjJDKzMrWEltMmpRaUJEKzF2?=
 =?utf-8?B?UjBST29NR0o0d1dDR0gyQ1B6aDhNak5YRGt2T0F1RG40UjY0a0Q3cENnZHVz?=
 =?utf-8?B?Z3lpbHJXLzJRUmJYOE10bEswTFhoRVhBQUpuV1RUVmJ6bnlWcGt6amsvZzg4?=
 =?utf-8?B?MzNOcUZqTGtLSlFkVE5waklGdEM3RUZTSzk0bWV5YkxFWWpFaDVHNjBkL3k5?=
 =?utf-8?B?a1A5cFBvUEs3UDZweVZmMmJ5QTBIYjRqV1JOL0NaSnA0b1lFSWhWVldvSHR3?=
 =?utf-8?B?RHFHczB6TTdZY0lwL2R6Z0RsYkdVTDZISm1UT1YvL3hTWGYzUUtJaHV2M2FV?=
 =?utf-8?B?ZjhKNHFaN09LNGFoN2NCeS96MzkxYVJzc0tKN3JObjk4ek95NmsvRzZ6aFI0?=
 =?utf-8?B?UGV2L1BHUlhSanZmc0Q4cENkWTVFZXNhcTZLMGdLTS9GOTU4ejV1Y3p6VUdE?=
 =?utf-8?B?cUprZkEvaDNUNjdSdCtadWo1NVcxSitzTGp4SFViU3psK3JadHc3a0cxTSsy?=
 =?utf-8?B?ODk5SUcyTWZOSHpROHNIaDJOR3JKdUpHaW5Xc2EvRFE5RHo3VFFiekNRYldB?=
 =?utf-8?B?L0FrdXRhQ2pxL05EVkw4bUNrS0w5QmcvRkpEVU4rMi9ZdVlmQkxERU1UVDdM?=
 =?utf-8?B?OTQzMDJiQ1ZLNVNpN1VORGI4djRjbWRQWk1OMG5mY0gyamNGNHdUSXhVYTdC?=
 =?utf-8?B?emd2cGg1V2VjOE5jKzJFVExkYnF2cmllQVRvc2xaZWR4QUhiZWRUV0tRZlAv?=
 =?utf-8?B?WWNxTVJSd0N3NVNZVmtYak0rRmtCY3h6SUU0a0ZmOE8xc2x0LzJtRHh1Y2pt?=
 =?utf-8?B?M3BCc3dONi85Und6WVNHUG1kRGpMZjNibEQ4aU5Kc0RrNHNwakFiOE50dGZt?=
 =?utf-8?B?YUZXRWtGcVB3RnQvd1F6cmp3R2lCcUFFWjZvN0djZnYwVkNUb1laZHMyMUhz?=
 =?utf-8?B?RDVFOGxaQ3NwY1ZzNmRvNU5VdEhBWnA1azZjY2d4Znl3dGJta0hSSnhPWEox?=
 =?utf-8?B?VWIyRkNlYVd3b1hFK1Z0aGJIRUF4aXJ5MEw4S0VNUE1TMXRQd1VMWWo2SHlQ?=
 =?utf-8?B?RisxNjBkeXZGYzV2N2U2a1RHeVovai85ZmlELzhuV0xhSklCNk1ITENyMSs0?=
 =?utf-8?B?MGRqbVlDdHpsRC9ESGdYTnJDZlpsZWVhNjR1NlU3dGNaVFhsZlJWYnc2Znpr?=
 =?utf-8?B?em11S2FDRm04MGpLSWJwcHkrMlN0cHpPdTZ3cXQzRVdkcGNkZ3JvTmtLbHN1?=
 =?utf-8?B?Umd2YjJXZ0tyV0RoVW8rS2Y4TlF6SjJybFoyTHN3b01qeTgwV0hsQ0owRjE3?=
 =?utf-8?B?b0UzeWRHT3gvcWNNL3hLRWp3ODlPM01TMzFGeDA1S3Brck5VM3JMMWl4MDJZ?=
 =?utf-8?B?L2tyelFocm9YUU1RMXpjT2l4N01XYW5LK3BoTENtMC9DYkhDTGJKZz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60cf375-1784-4701-3fc3-08df4abeaf67
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:38:16.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 834KctiVgxXFcC/2FF/Jki3zOyVZXQcM/0nqN+rTwPHF6uJXzt9LUJbbZIUn9qXzwBikIOpv+2K4a45OqtUvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989311



On 23/11/2026 12:03 am, Krzysztof Kozlowski wrote:
> On Thu, Nov 19, 2026 at 05:45:32PM +0800, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> This series enables the extended-read DDR modes - SD DDR50 and eMMC
>> DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
>> tuning sequence (CMD19/CMD21), so the read path must be centred by
>> static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
>> also exposed PHY issues affecting the existing tuned modes.
>>
>>    - Patch 1: abort a failed tuning command on SD6HC. The software tuning
>>      loop never aborted a command that errored, so after a CMD21 command
>>      error the eMMC could stay in the Data state and time out the CMD6
>>      that HS400 selection issues next; mmc_send_abort_tuning() clears it
>>      (a no-op for SD). Limited to SD6HC since the path is shared with the
>>      untested SD4HC.
>>    - Patch 2: document two optional SD6HC read-path properties for the
>>      extended-read DDR modes (SD DDR50, eMMC DDR52).
>>    - Patch 3: program PHONY_DQS_TIMING, which was left 0 in all modes; in
>>      extended-read mode it must be the rebar pulse width in clk_phy
>>      cycles minus 1, else one DDR beat is duplicated. The width is now
>>      derived from the SDCLK/sdmclk divider rather than hard-coded. The
>>      same patch reads the new properties at probe and applies them in
>>      DDR50 and DDR52, and makes the DQS_TIMING update clear USE_LPBK_DQS
>>      before reprogramming it so the loopback/phony selection takes
>>      effect.
>>
>> The new cdns,ddr-* properties are unused in this series; they will be
>> consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
>> device trees, submitted as a separate series.
>>
>> Tested on Agilex5 SoCDK: SD DDR50, eMMC DDR52 and eMMC HS400.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Changes in v4:
>> - Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
>>    device tree) into a single driver patch, now 3/3, and moved it after
>>    the binding patch. The series is now 3 patches. (Tanmay Kathpalia)
>> - Patch 1: limited the abort to SD6HC (host->version >= SDHCI_SPEC_420)
>>    because sdhci_cdns_execute_tuning() is shared with SD4HC, which has
>>    not been tested; reworded the commit message accordingly. Added Tanmay's
>>    Reviewed-by.
>> - Patch 2: dropped the cdns,ddr-phony-dqs-timing property; the phony DQS
>>    timing is always derived by the driver. (Tanmay Kathpalia)
>> - Patch 2: dropped Krzysztof's Reviewed-by since property set changed. The
>>    two remaining properties are unchanged from v3; Krzysztof, happy to
>>    carry your tag again if the reduced binding looks fine.
> 
> Not a reason to drop the tag, really. Why would less custom properties
> be something needing to be re-reviewed.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Fair point - going from three properties to two didn't change what you'd
already reviewed, so I shouldn't have dropped it. Thanks for re-adding
it.

I'll carry your Reviewed-by in the next revision; if v4 is final, I'll
resend with your tag applied.

Thanks,
Tze Yee
