Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6064E4C30;
	Wed, 30 Sep 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774053; cv=fail; b=U8zc7VVpY9qczRTlhHRyfH+f+W6HXevKnAAim/fIYEhFusZi6rSs8kH07a3SBzuEVPhN9IN/7at99Fe+wgZZlQW+VRiVYGSCLG7EurvfFmcofZCujuhR5Y7wFz9SYTYByWXT/m3BejNkSOLa4TZiT2uqBUUavqo4p9aW2MKefOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774053; c=relaxed/simple;
	bh=7lZlF+daOyLeRyweKf6eroq3QMQu2jPHNgVIKay+D5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sr5i6fynvzfSG7Wl4X9y+BfE1IPyRxGpyXDGS+WVwMY6EDc9EI/xeWJZubax2Cm1SXksJlQVLnA2OcO5K8+NxDWr6Fq+DSRhPpic1mdqjfxemZDhWq+bBCasxYQC5aixu2FR7I9PuISuIEf5CI0kZ3d6xZ5nAhPPYa/Kp+0Qft4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=n7O6RuDD; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="n7O6RuDD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH+3u/ySwbrdk1t1NbsyRXLReQF/FXgQXefS1aScojGQtWHL9iMGXwEvfbdKRPf9UINMj6LFpV3swWocSMvAdv2qx7Lfd3JfkiKExdk1g2WBgFN9793msFEvR7mPUPChaI4c5fj7EjCFWAqruG0iUhCTQzE571mr0l3/qnL1zZ9zEhDbCV2f1nI5ySafgZh1h7BQf1HaNZFcQtjtS5aH4qs1J9MhX5EgKQ4fs28mFFByV2grt0Q7tN/MTbPoe497PlR8FFl9oAbQL4YYD71SUuA4PvizHAuozdDcq/TDYYXnedPiUsj3N6s7xQgmqNqZomrV4XPiT8grDtkxj0nr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/uzadWuX9yTmhSl/zhgZjgDEvIU/Wn44MhDRZI8ORE=;
 b=TLgXSoNe9IH5ahA0lB1k9DTDheFTkOkXeWEoKUEt+cZaEWjQDrD4EGJmEyBmHmlxTeNZVIkYnjVKtsQq1GoVlaVS/gyRNkYluh4enkr7bZdW2VlWoWU8R1//2T/8bR+4sCqImgXJq5M4u+49G9BPxW+Ft9pKfSlL+rsHjf9yHxfrtFWiO4vmWs0ZimCHjMZYsE8me5YmspEPsdkEWfcvbegnt3gx7FX84Gh8wfNeHF38OuUsuafbhC+eevFhfwStntbJhqHwRyArjVvX4hZKC21w7ZWxhcQ4TM2SePcwahFUgmQS48nPr/86TM+T4VDmE8UNeSKJ9SJgTaGH1swwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/uzadWuX9yTmhSl/zhgZjgDEvIU/Wn44MhDRZI8ORE=;
 b=n7O6RuDDHwIQ0OADWhWtAZjwz787Af/OFeEQitD71yatGJug4Ao/TgdhVIdsG+3r30DsigY7ASJgxv9FSz/ROPdmI6/Vo2heZ1pc84wPqGAblub9A9WTd47z5bUX6P6TKtfaAR5QxpL2BDHrALU8Aa86uluVFdMG62EVT7umoMvbkbubfj4HjxBtQBs+uQvIkfJt+OpT9e4qALEn6GV5D8AvHoveDA/ooQpWYV3duFcfBBiaonokFeZp/03/A99TkSm/swVPDmHE1daTxfPO7aVwh5X6skKXU2O6W2Urn6Ixf1s3rK1CB1AtLiCUeqGvK4SWCdrzvUMQ4rDRSqE8AA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB5632.namprd03.prod.outlook.com (2603:10b6:a03:28a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 13:13:47 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 13:13:47 +0000
Message-ID: <b0284a32-0ecf-4d0a-be8f-5cbc952e02a4@altera.com>
Date: Wed, 30 Sep 2026 21:13:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50
 read-path tuning
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
 <20260928-thoughtful-firefly-of-science-7fe3f5@quoll>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <20260928-thoughtful-firefly-of-science-7fe3f5@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3a6b4c-fbd3-4fe9-d5bd-08df1ef4a921
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	YO1F1tW/KyKRIIuY5KXppsZYdReVsNIBNdgdJ2ZCByc8SEkk1yyzMR6YPRUl+d5x7a6/GD20JvnNCkqqx0cKeK7U0LDjovVUzbstceAUJxmweAW+7KVep+wruE8ZpV8T39dMFK4JhyG1sumYwJMqB4EoC6ACn0k976dwsqWijdzh715jji+moh0VDHCNAjwec1Hxz9qSIUP0kB2CwYfubTRegmOsdZuVHAMvYaI/BNJ9cJnTwKcYpGUMG814/hwisoTmsTxG78K9BrzavEK6MnWIJ45bOuH78aGcHo0Od1VOUh0UeszEjgvYX6Sc4eY0BhViRIc7IFrdrKlKSswiigkh7PQtSyoximg/P5+8TUIdJl6wpxxiHHDrV1QRm9mcqdMKlqYYZazgB8an0lmzz7wUj1qYUXl4DeYLnpSVLLteYc5CgY0tirdToWRSl/2tVsUdNPdxsmTxXTnNfiUab0fu9FKoP3mF+3fkcLe/H8Qt+B4/c8smb6B1V54o/zmoF2uoinDHl+zUH5ty29gdHdVoDVYTBIzRZ4IWsN5zWmtI77Kmvj/rjGd3H/QsWMoYCa4HMV611xb9qmzfDmttf0zkSu8atSLFmchR49tcmJxYZIuYbekhaPGdFrWjSa/xxEYCi2PvPC9lz9S52AXyD4oI21hf1x+MnZr0N7GvY00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdheGpPb1E4eklLcVRRVU5CTFliN3laYjAwSjNXRUhWMk05VUoyamJ2SHJU?=
 =?utf-8?B?MzNZSXRrS3c5eXBMUVBIZmViSDFkMjRhdFRFRVNUTTg2YzVRa2kzcHZvVjha?=
 =?utf-8?B?cEVUaUFaWnVvM25kaTcvbFNZT3Q2akpWLzlZeCtueVJZbEhxMkNTNWY5UEtD?=
 =?utf-8?B?MHBzN2lyMlNmN2ZSc1ZHS2g3enNUNS95OWxtR3RjYmNZRGNCM25SQnVLY1lQ?=
 =?utf-8?B?S2xJZ1E3S0dFbVh3aTh0WnVWUHNUajJOOE5mZy91c2RHUFhtbXRkd2drc2wv?=
 =?utf-8?B?ODRERm14aXdWSjN0ZDh3bEJjMFU0Tlc2RlRyVjhBekNWait4ejI4VzJSZS9t?=
 =?utf-8?B?OWN6bmE2dUk0eDM2WHNlNmtVN0c1eG0xREkzejNjb3R0YnBqQjBzS2RMT0Rn?=
 =?utf-8?B?UGw3Z05WamFEM0VaTDFDMnRLTk90UmdPRXlvbXhRWCtqM2dzdXVBem5URjJU?=
 =?utf-8?B?V3FDY2ZEQVZSQUhvSVBodmdoMjFZaGRLMjdJbGFHemdaUWNJSGNlaVd4Wk9H?=
 =?utf-8?B?NDVnYmVGQi9ZMm5MdmMyRjNyU3gveVJnRmFWemZ0d1BpMFZtNVp3VzRhSVZZ?=
 =?utf-8?B?cnVsRFhIQ0VTQm52Yi9sZzE5aFk4eUx2c3FjSUFwaXZ1VkFPQXZpeXg4a3Nu?=
 =?utf-8?B?bHIxSE96M0FMMEV2NmRDRE5ZNFVBUERqNnZNRHc0ZFNVcVF0ajZyZ1ZEbzhh?=
 =?utf-8?B?ZTZHWmc1NHJKcnVhb0YreEZqbmY3ZGJWTWJ6NmpEcWtSNm45eGEyNWVOVUFZ?=
 =?utf-8?B?NDdjTHNPWEtJOW1CM0YvN0VLdi9PZGlvQTUzcTRkNTBCM0QyNkxBUWhURGRK?=
 =?utf-8?B?Z1lySUZKT2YrSkpMNkM4c1NIOHdJVEhJUUtMTWRtbUhoajVSTzkxNFhGSVFJ?=
 =?utf-8?B?eHFMU1NDN081bFR5NWp1M3RkNGplZkdGTGN0cDBIZmc4RCtLcUUzOG1WRVRa?=
 =?utf-8?B?YUwrd28zUDQrSnptY1VtTjVvWGIwRURxSkxULzgza1B6cHVYdk5xL2xRSnhC?=
 =?utf-8?B?U1hodEJsNkVGRXcrY0F4M1lMd3crRjBhQ045bG43di93QndETm9ibmZ5bnpE?=
 =?utf-8?B?YnNQQVpiWnFLeFE4VXBLa01jclJyT1oxZjc3a0wzN2FDa0dpMmw5OGY4MUlj?=
 =?utf-8?B?emhRRE5FNFNkYitOeU5EOHc2UlJPR1dzVDh0WlpHN1FJa0tSRkZ6eHlGSVUv?=
 =?utf-8?B?QjlqdVVrSWxodlROZnlXVS9YMGIyWFh0UjBaMTBmYUkzRWwwNjVadlZ0Qm9k?=
 =?utf-8?B?dGxRUWh3MlNlaDhreDQ1cXdmVVFuZU9ieGRZZ2FnVjBhenVjSm5ydjFqYWZn?=
 =?utf-8?B?QjJoQWNnQWlrWWQvcVFDWjMxLzUrMHE2d1dGdzBiWVdwMmo1SU5uVkxvQWd2?=
 =?utf-8?B?TCtyNGQ1aHlZQnhDTDJnNHk5Y3c3ODBnRWpwWEFacDM1YkJJS0ltUzBXTndk?=
 =?utf-8?B?MFNoaGlHNHAxNkgreGNqdUlrTlpmSklyY015SERpSHBJVkhwOHlBeHFrNks4?=
 =?utf-8?B?NENISWpoRVI2Tm1HeXRXaE9oRWphbmNRazVINFNRcmlhamhWeVdGNUVtOVN3?=
 =?utf-8?B?Y2hvVHFGMWNmSURraE1COXMyelNsZy9DYTlpeDJ1dlMwdmhWU1d0eGpJcjRi?=
 =?utf-8?B?L3BiUmlrRlk0SGQxOVgrUVhVU2xCK0JCTVN0S3FKZTNGOUthOTRXeU9CblRa?=
 =?utf-8?B?a2xLdE9MWUIyc0FsQkhnZ0g5MVNUbDVXMkVMWFlUSExUdVpHN01vY01ya2lv?=
 =?utf-8?B?UlJueGNJTjVVR1BYM3g0WkxlaW9yWkxUcVhSMytheGl2VkpDZ0FqaWFidFR1?=
 =?utf-8?B?d3lhMmFjdEJmcHE5UVFvdzFFSUFSZUl0Ykg1UEdmV0VpVkdpZ0kxSWczaTJ2?=
 =?utf-8?B?dnBBVURiN0Qrc2FtemYrYm0xZE5pbmRaOGozSVNOVFF2blQyaDUxNFNtL3Z6?=
 =?utf-8?B?N2FPUlVReHpUeTdWbzcvc0VMeXV4TDZaVG1BUlVJOGdycGZWRzd3UytZaFQ2?=
 =?utf-8?B?cndOaDAvR3cvUFMyZmpXakxYM1FCTFlHMGcvY2Q0R2xFNjExMk5TeGRnZC9M?=
 =?utf-8?B?eG1ycVU5QmdXWWh3eVl3cndiYi9aVVl3TFFLWDlkYjl5QXprLy9HZ2xpTkg2?=
 =?utf-8?B?RzRhcjcvaHFOSEJZZkJXc3RwVG5tSytKT1RkcnQzaXlxbHFYSkVKMGM4T2dN?=
 =?utf-8?B?YWpscXB0YklLTnlGeWhqTG1ZaUxOaHV5VHRHNmRPR1ZGWk5EZWt5RnNUWWQr?=
 =?utf-8?B?SmhRSEFzS3NGTXVnUXVidTRQMGdBMFVoZ1BlV09EZmxNQ2s4TVdYRGxWMkpM?=
 =?utf-8?B?TDhTbnVnU2VZdkp1b2x6NU9UUE1FRzhLUTZhWnp5UFg3OEk0Z0w2UT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3a6b4c-fbd3-4fe9-d5bd-08df1ef4a921
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:13:47.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLfMB8YSjqYw9apGVYovkBeq3KYn4sL63saHaxj9/nEXFHcNqkYoYfBCPmKLIF4vNN9DcLlBW2icsyp1J+vczg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5632



On 28/9/2026 4:05 pm, Krzysztof Kozlowski wrote:
> On Tue, Sep 22, 2026 at 07:12:37PM +0800, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
>> static, board/SoC-characterised PHY settings. Add three optional SD6HC
>> properties:
>>
>>    - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that centres
>>      the read eye (0-255).
>>    - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
>>      (0 = phony, 1 = loopback).
>>    - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion timing
>>      (0-63) that positions the fabricated strobe relative to the returning
>>      DDR data; not produced by the Cadence timing calculation.
>>
>> All three are disallowed for the SD4HC variant.
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> index d5ea2717904b..df86872603d0 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>> @@ -74,6 +74,33 @@ properties:
>>       maximum: 1000
>>       default: 24
>>   
>> +  cdns,ddr50-read-dqs-delay:
>> +    description: |
>> +      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the read
>> +      eye. DDR50 has no CMD19 tuning, so this is a board/SoC-characterised
>> +      value. If absent, the driver default is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 0xff
> 
> default: ...
> 

Hi Krysztof,

Thanks for your review.

No fixed constant. When the property is absent, the driver keeps the
value it computes for the mode. I'll reword the descriptions to say that.

> Also, look at the existing bindings. How are the delays represented? ps.
> Why is this different?
> 
> 

In the modes this targets (DDR50/DDR52) the PHY runs the DLL
bypassed, where this field is a count of delay elements - so it maps to 
time via cdns,delay-element-ps just like the existing delay. I'll 
express it in ps:

cdns,ddr-read-dqs-delay-ps, convert in the driver (count = ps / 
delay-element-ps), default 0.

>> +
>> +  cdns,ddr50-use-lpbk-dqs:
>> +    description: |
>> +      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
>> +      1 = loopback DQS. If absent, the driver default is used.
> 
> Then this is just type: boolean
> 

Agreed. I'll make it a boolean.

Note: v2 also renames these cdns,ddr50-* -> cdns,ddr-* and applies them 
in both SD DDR50 and eMMC DDR52 (per Tanmay's review).

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +
>> +  cdns,ddr50-phony-dqs-timing:
>> +    description: |
>> +      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). Positions the
>> +      fabricated read strobe relative to the returning DDR data; the correct
>> +      value depends on the board's SD flight time and is not produced by the
>> +      Cadence timing calculation. If absent, the driver default
>> +      (REBAR_PULSE_CYCLES-1) is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 0x3f
> 
> Best regards,
> Krzysztof

