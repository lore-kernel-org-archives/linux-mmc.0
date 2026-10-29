Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793254882;
	b=i7j7B8eY7yR9F1w2iL1cmFpWWzi8bBF0G+eCrUKpMdGMqD7Cf5sD6jCrWfP23Gi7wfCj
	 9GrLeyWTZ3PeOoWkpmIPYPdtBfmeIDLJxtx9NxFrK2+ghAAGFAv7Kr38x5yX2TFFbDlxf
	 5AkUJD2DT+ovgxheYWKRja3Sgn7tAtivS1PpJ3VOOOrt7ZK6HdtJKcqxc1nZWw4y12jHO
	 dKV0mxKeI7y70fyZftWVpkQHpZla8D5Wkf1a8mka8tHMJp9RHv99QKJulpTSTkYXWv3P4
	 gfGTxEpyCNGDLsJAbZqXObMGWuTGyP6gkVbT0yRPiRNEdH4BRJrJG1nu2fGS8UmgY7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254882;
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
	bh=wX4497+I/P0Z/hG42zUPoG/mKUdYeZggVG5PbwqdgLQ=;
	b=HPp4L+rEqG/TTCsR8t0e4onNsPPs4oJyKrhrwz4XSaHm+MfOAHi2LWW9ygU9vsNYJ/WI
	 g+XAZGT2eOc9iKKyqm81HTULwQxJdlrvki0N3tGgOM9ys27viLDq2jZnpbO6OjqdDqimx
	 kXwvvVtqbP8WwDkDdbrfkjR3/Wzb44zPcnO7+Pr9nYise5FjJ2h9tfP6GSIKJUe1fDmGw
	 JYFCZHi2Ab6zuWQ6W7BVb+aeZEZVftZlhtmDPLz8ps3MvGvK2lvcL0g1cs62f1w3JmLwa
	 MMn0QYC8y7YQG/HlMIfWiTQrnDe7CRBsXFF3G10f3GJrYksJkWEavwtszJg2vzO80gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="nz4a/UiM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.64
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DB606A31C;
	Thu, 29 Oct 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=nz4a/UiM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0Y5N+iZvz3GM3PK1C5MZBpWJoorhFF2alHQ1zyB5OF43ociTjk4sHwmAg5wu813p0EPniVrt04YaG8jNFW+YfOIZN9Dq77mBNQwXFk74ZsT/XHhcOGTL4mQsPbeia9ert+IX0S0XycXz8Me+wgU5mzwHTUuwJeOamdDHgq+/x7EEHhuFsaFqXS02j7QlCwfBw8XJPHKvhk25nFKKRt4mOWQEFkcFZnES69J6PTk/9qqjee2FBw/Bzz1vG0nA8xjnIiGejyAcxfizz4M6CwQ0rn7IVl8xhbGSsb9RKiY2byJX0eZakBBOcE975TvKA0CDatR+Sg8eUZzI/xxmzz0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX4497+I/P0Z/hG42zUPoG/mKUdYeZggVG5PbwqdgLQ=;
 b=LMW4tIJk29aysSYh+mbuV36GjkC7s0aKkZSgZbVV+Im985QeyJ8s7HOyABghdlggStaw8KMgrRy85Ch/El31N92K9TCMAFfPHQRpE76vuA1oaG3yEQ2y57UKEzehR/wS6/BDIU/Bkmsy6WngQ3DdTtc2tPNyadPfxKhdrGitYMikG7qZROFwe8hHEk8caIozHiKgYVJL1asaMiLpzf4cnrS67C0YUHKe2HxYv9QchD5zlibzEzR5ftcJPVBE97r5PWiUelPHJcd8WR4hg1DgnpqxqnNjp4IaGKGdlgWbycmaJMbWPE2EZBeqAbHKLyCGbhmPVogp3558iP3N56oRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX4497+I/P0Z/hG42zUPoG/mKUdYeZggVG5PbwqdgLQ=;
 b=nz4a/UiMz7xSlukY5kUwH2+lKb4m1o4B25w4ScV4yrDgiaqlNvMhhYjso8+XSAJxWKtsv0pffZ10JO3ZetwKiF5RnIRJqlj7MKEusR5MIBF+8qeyZOf24Jylkp3LiyzlKKltuauhNv+ubxNlRB66mnljXnRow43DBh86MPrHqxlFwdD6eEJ3hjQtsTk92a575u27diVgMbwnD7gv/Hf7HLGxDkwP+utUfUS72L8wTaufeC7j7D6qRrf6s3EPkizc/ceQoGbyCy/feYhZFWfBdAZGGLLIAdwDjUhrlQjt99oTAA05X5ZvUvLzFbzsiGefs5ooXFmdVANzfbaMJ7pC2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by BY5PR03MB5281.namprd03.prod.outlook.com (2603:10b6:a03:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 06:21:17 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0522.017; Thu, 29 Oct 2026
 06:21:17 +0000
Message-ID: <80fd1113-88a0-444c-ab2c-6ea880e39c87@altera.com>
Date: Thu, 29 Oct 2026 14:21:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50
 read-path tuning
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <5ea5d406b527cb9b7015693191c9bdeb9202a1bc.1791459448.git.tze.yee.ng@altera.com>
 <20261012-futuristic-worm-of-camouflage-cc2e3e@quoll>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <20261012-futuristic-worm-of-camouflage-cc2e3e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:4:297::11) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|BY5PR03MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e02ad1b-421f-4c69-62e9-08df3584d747
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|261021121427099003|261022105027099003|261021123027099003|10067099003|56012099006|261026140227099003|261028144727099003|18002099003|22082099003|55112099003|261026121527099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	NTq5gXAoGus91wh6apFmaW6jLBzjrLcJ2G7SR6PlMysQXPpRE5uv/ztxlfPhaG1+Yjabqk5adDC/rLYhtazUEQH+uIoxNCzk/hNF972gwxV1+hFUWj1XxQOl9HrgpoXFbrEFxOZqhboY2oQIfIE766umr9BmXyVfqrlF+XIMPTFQuT2QmhhfjkamtOHrBtPT5nyYgQnB4mdHu+z08hpuwR2eOpAuiYhHr7VWda2vsCD6+V17BpF2jBviKIHPPQ+gyQUZOXC5QF0GwhogqKTt/7D22tn4OL8XnUOK6RgQO3OOrxPibG2cFXmaaTiusdH3Uosl8nRsI3zZ1qaP5wQiM55RUInz3CnHNjHjQedUOkbjvP7t2IUpUO0YMtS00lcEWzqLZmx1d4ISt6w9t9eNTdWDg2hi0IPzJUCsFTGazO2kAt6WWZ7pmIsN9ZRRp9QpjDI1akjMHVJnAbOIubXbRkDlTZCA1xWEetJSSoIIB6N6aT9UghkEh2rm7+r3b2CyXLUPmNyKzBDtod/HrMJh5A9v8uDyoTOd+K95cuneENm7YVyTJMQcVHPPAc1Vmjwp/nNrCcThrsY48Rf4c3t0flrhbIXi7QisvZzO60CL+rSGROkkWAVt67xBjfpQKD4M/ZFmIUkN9f1vy1F2B5ZIllq707gBaWtgIDHrA1QhEEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(55112099003)(261026121527099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eklMNlhQenlJMGdxUlNtcVE3bHVyZkFmUW9mVWFvRjZqd1VDMVRndVlRQVNy?=
 =?utf-8?B?R2ozQVdMdzc5REhZQlFESTQ1dUNDQlo0azZFa0xwTjlZU1hOMFJpaVpwcWhp?=
 =?utf-8?B?SUQ3bWJwMGpmZXZiS1k0NUZvN0Q2c3lGZFFyZEJHakFKNzV0Mjk0VU12TWZW?=
 =?utf-8?B?T0lIa0RzZ1BLN1ZsT3hWQlNWU1hQY0tLa1I2MEhzWFErZk1wUjFFNDJEK1JC?=
 =?utf-8?B?dk10MzBiaWRLNEVkbWgvb2pWbEx6YlZrVXl4S1luNTgzYjlSOWRnNm1mYVVz?=
 =?utf-8?B?YnNwZnVmTlNHUVdETWlVaC8xenc1YktNTk5BdExNTkdLRDFmNDJBOURmQTJG?=
 =?utf-8?B?SVo3V2hZVWNndlIrYTAxWFVwbmFhUFE1MEtzOEZtUUMzVGZscTJTekRPNTlu?=
 =?utf-8?B?M2JZZ3ptUGNSUW9EQU03a0NMZ1Bld2o0Z3JRWnpFOHJibUVRNkpGU1NFTUdz?=
 =?utf-8?B?bWJYYVJzNzdXaGF1anFKV2hGd3pLTFlGTTZwWkZvRHd2bnJyNDgrejZrcHJQ?=
 =?utf-8?B?cHlCVmhHZ0lOOWNBYllhcFdvOE1heXFHSXR2OUl1TG0xK1NkZ2E4OWVRUnU5?=
 =?utf-8?B?M1YvNUYram0rNmQ4NXJqNUltbklYK0JtK0xqN2dkL3VWaWNSZXFTQlZxTTMr?=
 =?utf-8?B?ZkREYXdxTnNGeG9pQUZJTFZ6K2tMZDNtWVJTekxiaW4zV0hFUi9lZnc5cWNF?=
 =?utf-8?B?bm5qMFVIYndHdWFXWWxTTTVUTXBNaHA3VWNPaUJwNnV0U2lWUCtUNDVtMWtG?=
 =?utf-8?B?RjN4U0sxUmhXNGlyZzhuVlcyYTNLODdUaWJtRWN4MTMyb1RoZEhsZUVBMHds?=
 =?utf-8?B?Sm9oMkRPdlRDUjRsQ1JTTVNjb05XditoZlpzbUlQS1E4NVlETW5rMVBDNXN0?=
 =?utf-8?B?a0I2L1BjSXVUYjlPNEhvYUV3L3BhL2pFWCs1Y1A2WUxrZ0hHSTJmWFA5R2V5?=
 =?utf-8?B?UXMvcEthaWhJVzFUWXlZTnFkSTA3cTdmcy9XRWNlUVg3aFF4YlpERmlYMS9z?=
 =?utf-8?B?MkNMemlKMjUwaG43ekY5N0I0RTNzb0c0VXBLaHc1QWFzNUozNlE3dTdoS2JC?=
 =?utf-8?B?VGFEVmwzNmNMa3prQ0RlclBQTzN1cDhuQ3pYVVY1VnBPdTNFNmNuZTMxVW9y?=
 =?utf-8?B?MHFGQUpDMGZZZFpERmNYNWk2V0p6RFRYTGJQcFZZNzVzcFBzNVUrUTQyWDc5?=
 =?utf-8?B?ZlA3MUhGKzlZU1pGVzBLMEQ3MGVJVEZXNXhqYTl1eTFId20zaXdWNzc1R1R2?=
 =?utf-8?B?a1JSRS82c2VoMHJlaDVHYVJUV2hsTjhTTU94RFZibmZaR0xRS1N0NGJJN3hk?=
 =?utf-8?B?Y3htSG1RWWpGUCs4SXlQSjJFZGgvSVhadzgva2JERU95MUNHZUNGVE1qU0l4?=
 =?utf-8?B?ZE1xSUd4QU9UeUg0d0lWaHFuTFNvYlJGUnZFc2Q2bXE0bU9IaFpIZVlHZldW?=
 =?utf-8?B?U09BaXM4cHAvOUgreDBMcHJvQkYrMmVJRHVuODBGSDRkWisyc3ZCNFVnME0y?=
 =?utf-8?B?LzNCYWFLVCtrTjArSW9GLytyQ3UxS3FSK2l1UGJLSzdlOHh0QUpMS1AyRzkz?=
 =?utf-8?B?SC9iZGxWZjdNeVhPSFRJcG1zckVoVmZTaGwyTnFuRWFXM0FITUVVYkxJaGV0?=
 =?utf-8?B?cEJXdXRFdHNlUjZxQTlqeDVTN1h2WCtmdlUxRTIyaEZqS054Zm51UkxJUys0?=
 =?utf-8?B?Zm15WjFBZWVSNXU5QS8wRmNabUNvRTNZam1mRG5paTF6NnNLeDNvSTlPd3Fq?=
 =?utf-8?B?UTRhREpYREI0bXFWQ09PWGZpV1duVlhjSzFibVNqK3pZYitOaW14RndRQnU1?=
 =?utf-8?B?RHpJb1ZIQ2VsUVN3OHEwM0RhV3laK0ZBOHBaaXdCU3k0dm5abG1LVENtMlBa?=
 =?utf-8?B?cVBRYy9BT3A5cHdQWERuTW5iYnJ3NS8yZmNPSlVBQUVLMWFveGR2SjNDc2FY?=
 =?utf-8?B?YWdzamtrL0tIaXQvZmprVk9tbWpEMkZvbGhnZE1pK041Z240YnFNRHZNb0pB?=
 =?utf-8?B?L0xjVTNWeHkxMWlyeFhKcElpNy9LTXBOVDFKdllHalhqUXJ0eDlkdmtNeXlQ?=
 =?utf-8?B?NGk1RTJhK1FJWCtLa3AxZTRmeFFzcHJ1ZlhJZkw4a2V3M0JLU3VURWFJR09Q?=
 =?utf-8?B?amdEdmNldUFNTFV6MitHUFdiMjBnT1lBc2FCMlFobkhycFBaZm1WUXF0ZHZi?=
 =?utf-8?B?VzQ2UUQ2a0xBYWVwZDVUL2dyZU9xUm5ORXFqVno5UUtHQ0oyeTFaVktJYnQ3?=
 =?utf-8?B?K2pHa0NvcGxhSEw0bTJmL1BDRmk3bVErZUJhRml4RW1ubkdUVFRTbEM2bWt4?=
 =?utf-8?B?MTM4NW54QWpSWjJ4UzA5T0lURk9HRjdsM1IxTzAyZWowMG45YjZ5dz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e02ad1b-421f-4c69-62e9-08df3584d747
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 06:21:17.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWB8RMX1QXEwhcehVfl1qIJLdXi0OF79/jAIizf7GpVemusT1Rmw21n3AVgeKmG8QMzWRCEWS+IS7GyUf0pluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5281

Hi Krzysztof,

On 12/10/2026 4:48 pm, Krzysztof Kozlowski wrote:
> 
> Why aren't you using b4 to send patches? Why making it difficult for us?
> 

Sorry for the friction, that was my mistake. I'll switch to b4 for v3 so 
the series carries a stable change-id and the cover letter links back to 
the earlier versions, and b4 diff works for you.

>> ---
>>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 30 +++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> index d5ea2717904b..911ce58f8dab 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> @@ -74,6 +74,36 @@ properties:
>>       maximum: 1000
>>       default: 24
>>   
>> +  cdns,ddr-read-dqs-delay-ps:
>> +    description: >
>> +      Read-DQS delay (DLL_SLAVE[7:0]) in picoseconds that centres the read
>> +      eye in the extended-read DDR modes (SD DDR50, eMMC DDR52), which have
>> +      no CMD19 tuning. The PHY runs the DLL bypassed in these modes, so the
>> +      driver converts this to delay elements (divided by
>> +      cdns,delay-element-ps). The 8-bit field holds at most 255 elements;
>> +      larger values are clamped to that limit.
>> +    minimum: 0
> 
> Drop, 0 is the default.
> 

Will drop it in v3.

> Where is the maximum value?
> 

The value is in ps, but the register (DLL_SLAVE[7:0]) counts delay
elements, so the driver divides by cdns,delay-element-ps and clamps to
the 8-bit field. There is therefore no fixed ps maximum, the real limit
is 255 * cdns,delay-element-ps, which varies with that property.

Rather than pick an arbitrary ps cap, I'd prefer to express this 
property directly as the delay-element count the field holds:

   cdns,ddr-read-dqs-delay: 0..255 (DLL delay elements, each element
   cdns,delay-element-ps wide)

That maps 1:1 to the hardware field, gives a clean maximum: 255, and the
element size is already described by cdns,delay-element-ps. Would that 
be acceptable, or would you rather keep picoseconds with a fixed cap 
(e.g. ~one DDR50 bit period, 50MHz = 20ns = 20000 ps)?

>> +    default: 0
>> +
>> +  cdns,ddr-no-lpbk-dqs:
>> +    description: >
> 
> Drop > everywhere
> 

Will drop > in v3. I'll use plain "description:" on all three new 
properties.

> Best regards,
> Krzysztof

Thanks,
Tze Yee

