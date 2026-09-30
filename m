Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD54F4723;
	Wed, 30 Sep 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774236; cv=fail; b=MmRsQzStXwCkkeLXJbUWpCps+bHehNxg8Mi41xeF0lfdAna06apO1oN+wZhJw/9NokH1vRYyjVz82DVlyfr+3rat1nRFxwlIgPB8PcHjtsK7JULb3few6v2AC1G/rRl0XRtDnUC3TIFAhwCYMkPS5FLMZRp4RGsYfhQQjv286KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774236; c=relaxed/simple;
	bh=I/06HeOU+NMiECpTzDA4fDz11kct2drsHKPQi5w2AEo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJNjGq3eUN1Ez12es/jFn+D4hguXmUJysvtJUNuM2mXsWVU+ANYggiLmJjIpvNF9Z6iSfp9T8NH9z2iMZdPoE6YEeLjYwL7aZsV6y1GbtT0PH9SWFwz0RBOseR4EuYVa8M3T6yXKLh1UT/eACFeCjj3nQmrmqwQiLMUOY/QPti0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QCR0wVMO; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QCR0wVMO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixDaIJbYVXYOJw/qqNmZLPlatSghXRetl7SHOq3SSgicnoCdeldy7W7kl9apXcxbzpk/ZzZh9WF7l4xeZSQ/LozznHcEV/Lwu3uedjlVzhogsfrdfFsyR7yN2TkfN3EqpFO5B0zkMXyqVKZSOl9/UI8nwGfFUK8rQ4HCfewErh7Pyw/E9q6Tyh/aUs+eWF2rA5E81l8fag2G4IB+scSxdc9cH8FFuFWY8Xbsc2wecMnBp7AcPEUzKh8RHBcGsFgKmTwFPaqBh4tNwf9NYcyVA7phhx3EPALOz7sKaw1Lbt1HflBbG9rrLuR13Zhhgnn484VJrFypMk1euOAKt0XL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tejryvMrXl72/uGnq5Dj8qiijuljvBG+a8+rI4DXup0=;
 b=GFOgtoFW8Mk2Ol3DH610SSta+b9tXnKNUTeMDb4kt7kAZt4YmWx7nmReRE+ZkFJsxAU52hTv6z65+AzmAqOLFdrrwgtlkjnkzqXqFFeZz0YD/qb8V29H+NC3HTRU0T/Yz50SUdwNgPVzC8KFdfP8BHAU9knuHa/Ila/wPHnfZB881h47jKmnAL2DHdEwKUus0yTZoRBbGYzy8TVE9ZoQHm1wrOOhZrp0m+n68ZSJc26pICWkIM2y384ZqCRhkhTrWzZuxjHZO5JFdKFZkT3qcEKdkQma4Xx9Ey/rqPV0YaNHGd+t/2ytR9IWF/aMnYOTmpCYkYCHHLfeMmKaxu4vYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tejryvMrXl72/uGnq5Dj8qiijuljvBG+a8+rI4DXup0=;
 b=QCR0wVMO5/CNkH5QXPJwgq0DQ+Oji3ALWihgSOF4bpNc8EuVkKaK//WsVbGlLTRuckTjHrTBEtAluLIl7NacMqFG1/JrZlhDehUgcLtLiZZ7c9hkdiggUR/4XUKys2gxOZOEu9/it+v74WTYTvGWQuFqMsNUAjxmxWnf42BlwrPsfc8TnppNEYg9oklL5sCLkzEm67aLWbBflc19Zu9PgBtO/79nxEozlvNMaMXBxPZKtRQ0IDuVGTzyRFcKhiFXkiXbxJcxbWcxhH0/OcudoaZJBgx8QINan1td/SieL2aUWlEMIp2uUjVViE6OWyBi0iHyDE3LNAtyqd6/+Syhpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA1PR03MB7148.namprd03.prod.outlook.com (2603:10b6:806:33f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 13:17:02 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 13:17:02 +0000
Message-ID: <4d7e5bc3-b8dc-4678-9fa4-3bca5dcd32c8@altera.com>
Date: Wed, 30 Sep 2026 21:16:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: mmc: cdns,sdhci: add SD6HC DDR50
 read-path tuning
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com>
 <9c6b0248-f3d5-4bcb-937f-18c11dd7f368@altera.com>
 <4ac6068c-3df8-4286-80ef-aa9a9ed9b648@altera.com>
Content-Language: en-US
In-Reply-To: <4ac6068c-3df8-4286-80ef-aa9a9ed9b648@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA1PR03MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 417c777b-027e-40ef-4436-08df1ef51d7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|4143699003|56012099006|3023799007|55112099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	odxgoQ6DNfdfxv/Uik6gKimw9eLbT+kZ6mqv5xrXXXW2R++xpEM7jsIIGW7nfDjLWwvHK38/sd53V66COx6jwhNIzJ0aL/rsOZaOI9UrvMfyFlQEwIWjvYZ4P46OlVXOKD3CI6Aa93osrLQgFRSznh+20QWYFWtR/8Rz/GFuApmBlSMmJaLX7VV1HOY+XiPG7B8O99I0KCVCuiCqQKi5gzfkc4ejmQR/nWKHvTHemcTsR7kq+uhvbTYKNCCREhSO8loZ9fSGqeX32kUSPrfqsP1TW7eteTTYbzKptFZi3Odw3siEKeRUHNYVz0b/6pcfGqgsBIRqETF4RlRg+dghi+h8T0kGTg0iCn9mUz6pDGSPC9DibKWfYmwL3sndp26nMXItoXVmiDN6s+9TTw0KLok8EsMYULHs5hZjoNoDd3mPMb6LO2jbN76aCtW7IEgmiaP3a650YO6UMSJmb+YPtnOYB5eddqX+6qW34s9bLSL+pHys6i4fqqczgVFQt6xQRB43Mhra5voiabkjosqEycu3/kdluvBW8wtiU23PV16jllZ2AvloDVbg40I3We0HJV68LmP4dr1YlFMsEBoNlkSm3SgTbSPxatyvX9tkFUiREGMQGILgM93aCdvLK3amNg5cRxRUSIvXder/NXJtkeUaN9biyvb/pskg03QF2U3oRSb7rGsHApVy5167bwUciDngV1WduH40O/OHmuh6QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(55112099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVUODZjbFZvVWdmQXNaTkdIYkZZNUFXOEJ6Z3loMUFnZTN5UUtUMVNSZlM3?=
 =?utf-8?B?c2Y2WHVEY0JHR3ZqdFRXNWllRjY2cVVEVXIwR1VLUmt0Y1BaZ2Y2b1EvRk9y?=
 =?utf-8?B?aEVuaWVqZTUyRExKbzVqNS9TbXcrcThkWDBTZVpPUlVpR0EvNEg1WUl0NnZO?=
 =?utf-8?B?RkNDWktzTG1ZdzhBR1ZqSUQwSU83MktQdG5GZmNqL1F1QkVib05GSGE3cklu?=
 =?utf-8?B?SDRiMXYzc1cxbjdNQ2wzQk5nR0d6NDNnMFhIcW9uOWh0aiswQjQ5cE4xeE1U?=
 =?utf-8?B?YjZ4ZmtJUmZKanROY29HS29GdjcrUXpMVTJnUU13aldBdTF3VDBWWm1mTVpY?=
 =?utf-8?B?dDZDNDBOb0RFdlEzdkdTVVhMTnZIYXZubVNoWXRTZXhYNHhnSUNTcWxsVloy?=
 =?utf-8?B?RFVaWlFUdHF6QVMrMUxRYmh0eG0xVkJnd1VOL1pOUWtmb1JYWmRueUptUDNu?=
 =?utf-8?B?Mk5qSjU1WC9EYlBNVXNqWGpvckdWY3o5VTd0K1duL0NZMkVDcnptaFBMZFBL?=
 =?utf-8?B?bWFhRnVQcXlTWXI2N1pXbkxvaVdSbEFmeDY0c1cybmNIN1FjWjAyQlFSTUxn?=
 =?utf-8?B?Y2hGQ2VTOHhvY2xBb1AxREVpaW0yOU5aUE15L3ZSdE1CTVd0Yk1QM2MxSjZy?=
 =?utf-8?B?NzJ3Tkt0QjFNQVlCcXpMaGQ1dUhvNkZMMElidDhpNlV5RFR1MFZFS3hBMzc2?=
 =?utf-8?B?Q0RKRjhuSTdqRVNkYVVJRkZHNTlPVzNSZlBaWVpYQjErbjVOcHN0c0puTEFO?=
 =?utf-8?B?RzdPQ1JpOXl2UE4yb0Z5amZxc1RqTmlYMmoxclRMd0h5YmdDOWZHcmFpY1NF?=
 =?utf-8?B?dVFTTHIzcjFRNzJKUUp5ZnY1ZkdUdmhXZlcrNUExR05JRXRJYmdJQUdxRm9F?=
 =?utf-8?B?ci9qenRkV1dXN3ArSENuZE4rOUkwcnEvK1dkcVl5eE4zVzJ6aGlyVmZOWnkr?=
 =?utf-8?B?aGVWeUExMUpBd3I1OWxPMDlWMVZFeUQxWmxUM251dHlFWkNCR2ZNOG4vSTJ0?=
 =?utf-8?B?R3FvdHczcXI2K3l5TFdLeDVEdmtaTXFZSHhEZXBPYnh1ZHZCOTEwYm9xbmts?=
 =?utf-8?B?MFhXdS9mM01rNjl6NFh6bFhlakFnR1hrckZqSUFEVUpUNnpGdytjUkJIUjE0?=
 =?utf-8?B?bVZ4K0xucXpvMzRkVWl3ZGVHMmFxRVQ5RkFFbzZheEhUYjZyRUcvanNxWnVW?=
 =?utf-8?B?SnVPWHJUanZUNFlsUi9JN1QyKy8wSWVhaFc0cjVaVmNKRE1Ja1EzcGgvVVMr?=
 =?utf-8?B?ZnlZOXFBSnp2NjhsYmJOb0RKcVJUQWRMcDhMRUx5MmZJdE1RSDc2RkRKc1Rv?=
 =?utf-8?B?SXlzSkUrckNZakorejVWZFBaYjNmcFFBVTcyUWtZYnNMRER4Q0NtUzJBekN5?=
 =?utf-8?B?RlpEZHZzL0thOVFIbFdjVkp3UjRzY3d0MVZaUnR0aTJuYnF1eVRLMUhubFlZ?=
 =?utf-8?B?b2JxaHFSMHZ1VmZNZ1I3eWt6LzlNcjEwM0FvWGhGRGpiMFo0SHVXTnk2OGp4?=
 =?utf-8?B?d0V5M2lZa1hTSGdUWVh3MEdjemJjbU5aQkdKbDJWU2l6dEdyWHlHSEQ2V3Jm?=
 =?utf-8?B?M3Vvc3NNOHlwSWpjazlGakVPMmF2NE83NlVZQXpmRnJqZlRCcVZ2aUU3MUJu?=
 =?utf-8?B?WGZPaExYS3JwNG1hNWluL3NGaUU3M2xjZ0pYTjhXNnhRUkZiMEV3alBKRmN1?=
 =?utf-8?B?aElXUU94eTg4eWIvTXpoSDI0QVZpakJkZ3JiRXBncG9wcGpFamh2bmtidUV6?=
 =?utf-8?B?VUVIc3BLeVhaZEQ2clBlU3pVQU12OVlFdnB6RllDQTJBRUYyamI2TGJkTkdP?=
 =?utf-8?B?R3JyMlpzcGV5SlY0c1FtM3ZaYlo4elQ3bkFpT3VNYzJOMFA2ZDhvbHJVTmtm?=
 =?utf-8?B?Vi96aVB5V1dzK0R3QmNlN1VkeDczUkZZb3VDd0NXZEMzaUZvVVFabFp0REh5?=
 =?utf-8?B?YWllYW9VUXppRjJlQW51YnR5dHlxV0tqVkg2NUFkQlhxWDA0UHFyK3orOE1O?=
 =?utf-8?B?czN1TDNDeFBUaE5IdFd3T00zV0NxTkQxUTBnQlJ4ajkrQWZmSk1FY3F4L1U4?=
 =?utf-8?B?WTJnWCtvRTR6TnRnWWtlUldSc1ZKWXAvazE5cUwrUGhOQkd4aXhpa3Bic1lJ?=
 =?utf-8?B?eXNrZDNIZ1JrVWtSMVlWUGpDR2UvZlB6SllJYmk3SFVzdzQxQjJNUlZ0YUcx?=
 =?utf-8?B?TGR0Z2x1VmZxdlBGeEhMeU5XSDk1cmYrMC9td1hJbU1vS3Y1cEhxUjlkb09V?=
 =?utf-8?B?TWZrRHZ0aEU1cjlGcGRGWEt1bXlvYWJkNUxpR3Bjam9QTVNrazByMEhpd3lv?=
 =?utf-8?B?RXlaSGQ3VXdoR2hQWWdPL1N0UlQwbzdWN1lUV082WWxuWHVXQkMxdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417c777b-027e-40ef-4436-08df1ef51d7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:17:02.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLgoJBchNMKcTvavUY7M85tUGGA5ejy2iHmIikSRUSZR8Y8UsbInY/dB4wOiOadOqsPwIl7bX1NZLebAg00A1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7148



On 30/9/2026 8:31 pm, NG, TZE YEE wrote:
> 
> 
> On 26/9/2026 6:48 pm, Kathpalia, Tanmay wrote:
>> The subject should use cdns,sd6hc because that is the binding changed 
>> by this
>> patch. cdns,sdhci refers to the SD4HC binding.
>>
> 
> Agreed. I will change to "dt-bindings: mmc: cdns,sd6hc:" in v2.
> 
>> On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>
>>> DDR50 has no CMD19 tuning, so the SD6HC read path must be centred by
>>> static, board/SoC-characterised PHY settings. Add three optional SD6HC
>>> properties:
>>
>> The properties are specific to SD UHS DDR50, but the cover letter says 
>> they will
>> also be used by socfpga_agilex5_socdk_emmc. Since eMMC uses modes such 
>> as DDR52
>> rather than UHS DDR50, please clarify this and correct either the 
>> cover letter or
>> the property names and driver handling as appropriate.
>>
> 
> They're meant for both SD DDR50 and eMMC DDR52 - both are extended-read 
> DDR modes with no CMD19 tuning. You're right the naming and handling 
> didn't match that. In v2, I'll rename them from cdns,ddr50-* -> 
> cdns,ddr-* and apply them in DDR52 as well, and fix the cover
> letter to say both modes.
> 
>>>    - cdns,ddr50-read-dqs-delay:   DLL_SLAVE[7:0] read-DQS delay that 
>>> centres
>>>      the read eye (0-255).
>>>    - cdns,ddr50-use-lpbk-dqs:     DQS_TIMING[21] read-DQS source
>>>      (0 = phony, 1 = loopback).
>>>    - cdns,ddr50-phony-dqs-timing: PHY_CTRL[9:4] phony DQS assertion 
>>> timing
>>>      (0-63) that positions the fabricated strobe relative to the 
>>> returning
>>>      DDR data; not produced by the Cadence timing calculation.
>>
>> Please drop cdns,ddr50-phony-dqs-timing. The PHY guide defines this 
>> field from
>> extended_read_mode and the RE# pulse width. It is not a board flight-time
>> setting, and patch 2 already calculates it.
>>
> 
> I'd prefer to keep it with reworded. Patch 2 computes the nominal value 
> from the RE# pulse width per the guide, which is correct for direct- 
> attach boards. But the fabricated strobe still has to line up with when 
> the DDR data actually returns, and that depends on board flight time: on 
> Agilex5 modular devkit the computed value mis-samples and phony=0 is 
> required - characterised on hardware. So this is a board override on top 
> of patch 2's computed default, in the same class as read-dqs-delay. I'll 
> reword the description so it no longer contradicts the guide:
> 
> default = value computed from the RE# pulse width; the property 
> overrides it   for boards whose flight time shifts the DDR data return.
> 
>>> All three are disallowed for the SD4HC variant.
>>
>> This patch does not add an explicit SD4HC restriction. SD4HC and SD6HC 
>> use
>> separate schemas, and the SD4HC schema already rejects unknown 
>> properties. I
>> suggest dropping this sentence.
>>
> 
> Agreed, will drop.
> 
>>>
>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>> ---
>>>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 27 +++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/ 
>>> Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>>> index d5ea2717904b..df86872603d0 100644
>>> --- a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
>>> @@ -74,6 +74,33 @@ properties:
>>>       maximum: 1000
>>>       default: 24
>>> +  cdns,ddr50-read-dqs-delay:
>>> +    description: |
>>> +      SD6HC DDR50 read-DQS delay (DLL_SLAVE[7:0]) used to centre the 
>>> read
>>> +      eye. DDR50 has no CMD19 tuning, so this is a board/SoC- 
>>> characterised
>>> +      value. If absent, the driver default is used.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 0
>>> +    maximum: 0xff
>>
>> default value?
>>
> 
> No fixed constant. When the property is absent, the driver keeps the 
> value it computes for the mode. I'll reword the descriptions to say that.
> 
>>> +
>>> +  cdns,ddr50-use-lpbk-dqs:
>>> +    description: |
>>> +      SD6HC DDR50 read-DQS source (DQS_TIMING[21]): 0 = phony DQS,
>>> +      1 = loopback DQS. If absent, the driver default is used.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1]
>>> +
>>
>> default value?
>>
> 
> No fixed constant. When the property is absent, the driver keeps the 
> value it computes for the mode. I'll reword the descriptions to say that.
> 

Following up on the default question. I need to correct what I said earlier.

After Krzysztof's review I'm changing how two of these are represented, 
which also settles the defaults:

- read-dqs-delay: I said "no fixed constant", but that's wrong. When 
absent the driver uses 0 in these modes. It's now expressed in ps 
(cdns,ddr-read-dqs-delay-ps) with default: 0. (In the DDR modes the DLL 
is bypassed, where this field is a delay-element count, so ps is 
well-defined.)
- use-lpbk-dqs: now a boolean (cdns,ddr-use-lpbk-dqs); absent = phony, 
so there's no default to document.
- phony-dqs-timing: this is the only one with no fixed default. When 
absent the driver uses the value computed from the RE# pulse width 
(patch 2); that's described in the text rather than a schema default.

Thanks,
Tze Yee


>>> +  cdns,ddr50-phony-dqs-timing:
>>> +    description: |
>>> +      SD6HC DDR50 phony DQS assertion timing (PHY_CTRL[9:4]). 
>>> Positions the
>>> +      fabricated read strobe relative to the returning DDR data; the 
>>> correct
>>> +      value depends on the board's SD flight time and is not 
>>> produced by the
>>> +      Cadence timing calculation. If absent, the driver default
>>> +      (REBAR_PULSE_CYCLES-1) is used.
>>
>> The description conflicts with the PHY guide, which derives this value 
>> from the
>> RE# pulse width rather than PCB flight time.
> 
> I will reword the description in v2 to say the driver derives the value 
> from the RE# pulse width per the guide, and the property only overrides 
> that computed value for boards whose DDR data return is shifted (e.g. 
> modular/SoM flight time). No static default is documented since the 
> fallback is the computed value.
> 
> Thanks,
> Tze Yee

