Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1E4F0538;
	Wed, 30 Sep 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774685; cv=fail; b=ouRJwrXmiNiMFRSw9eHrhFRxWw3AeZmpb6AlRpzdZeE+mhmSwU6pkoCF94MlpzNPT9Tuuf+GqhplREvn9fTaeo7921k1y0QU+gldORYDcIO+XxukzfMEADcja8Uwryd0PS3cOKQ9glPv9lX4UWP3rC09Gz5vFDEST3twtVSmg0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774685; c=relaxed/simple;
	bh=2hn08wvMSEcpGdIGDW8ExmWc2DuT5sLoI8Ys7rc3AUQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfokfZicnCzl4969gbNuYWvL7Bv6uHFl+kfDXLGW5aypBK6QJJHWQ2sXuF1ZDPWdFmIf1vmwdUfvUss12PW45V/djwZkHRExF+FmqMRmaXIQu5RI/52P8L7uFfrB0RlTf2NcHCHj7L6kESqWTE8QC5H7YqH46Gvbs4xxDxyqPHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ReA5FgRw; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ReA5FgRw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2h4BBdj38xhemsT4wvjzBEBTGD5qRm+sIA94Ks9od95LgVKPWdANGNwBp0Fl2auEOfrfypcwf5ZF1qI3eA4/osgtwkb9NKxs/Egfvo9TQchPF2XegdXHujo6reu7ACVT2YbVx/11Etwpqo1wqwb6NiM5PxWhzT/yxKlyq2hbSO9mNpo6oAFHGREK3kLJCvB75gTn8RaRgt3trFqfS4NsmdQA1ud1KR67TaCNJSJteTl439tcE7BsNUKnqMFGV/XnogmC7out6XtpJLQwqWxoGiByJiTemmvuAi9PGIGi3VQpPtXPoo4Qv2l7l/7/DncwzaJk1cbsn13RD1j1SzQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9yY2OblgFHFkqyTo7KB3eJnN0CLC/NHkFDgVvtMGSI=;
 b=xSYKeMFezrxgSUI1IBWvJrkbgCHB5Yyqp5n/+LXjsiWssDbwANgqkvqgawrkNsBuQqZmOh2Onv0UFPdemLMg1i8WqGOKO3LfuQ0PV6AaPYjhZ5crbz7GfbKui8PLo1G8EzYHNmFgWvzI3De5q3BFlInS5HrxOZrh4uj8xwpi6p14l048lxb++yqoolB5eXp3ZtnwCFRUViB0lvjN+LyZnXTUtnZ+L2u3AnT0MkosLcxoezn/IZcVqulRPOySzq9dffOU7yJAhxUV/sOxlhqidS8WOtd4dm9G3qSs3idIq7E/j0JaxOC+ok8QpYEiAJHir6d+QFC3Kg1k9Wy9ftTrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9yY2OblgFHFkqyTo7KB3eJnN0CLC/NHkFDgVvtMGSI=;
 b=ReA5FgRwm6Qb8ZY+exI6vM84jBV45YueRqtpoXMoCDPujP2ryns06x8lJSwEK64Fz0P3m2jlKgzrX4jkKJZ4Un1Z1YT6r69P3vTOznxOwkRYrLReQ06ftUc2JOnrGvDNDzJo7nV3SxSAcMVMsuqyZ7V+AczcmuoOJvLIehiMRZ641UV5dJxFh7Soqo6TDc8f1x/aUk398eJkSriGvvJ7MWgnIwxgQ/VyZT4Vb1OZe37i+s+Ouml2uYl2N7emsEgezjzBxNGXnJa2CCOMhTF5z8TwwhoXsyrwZ3ktXPL33NN4I20T+fopszzov+sjSPBZYIMXHjNTd5leEELg/C8f7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by BY5PR03MB4949.namprd03.prod.outlook.com (2603:10b6:a03:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 13:24:19 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 13:24:19 +0000
Message-ID: <6502547b-4f83-49c1-b622-9b6d7bf982de@altera.com>
Date: Wed, 30 Sep 2026 21:24:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mmc: sdhci-cadence: read SD6HC DDR50 tuning from
 device tree
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <9440b973966df50c9f6c79055ec83ef3b634335a.1790074790.git.tze.yee.ng@altera.com>
 <4aafce14-2be7-46a6-9d5b-8df35646dc0a@intel.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <4aafce14-2be7-46a6-9d5b-8df35646dc0a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|BY5PR03MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6e8731-26c6-44e7-47ef-08df1ef621ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|5023799004|10067099003|3023799007|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2dxB8u6NyJ7hjMaSjGYfb7eS6k1JHFckW2/eKyji7UXTLGjbF/TiwvNNm9XVpL+O3kwxUbbKvAE/ZJB5jmxnjhLe4wPt67aanc29moHr988LuVtabstC/w56bs5SulMju8DN46bJZQw9BMFYh5ADJD37AEGYbt2uVnyTOcdbpb693rYVFPWPA2/l0BkHMk+ZJz4LP8fBwX1PFeh4O8AOloi3ZUye164uBUw/Aq7h1y31dlfSF6V3/uASr9cj0oqSJQvHInOrp8GRqUUZMW24fUFbDzxDSKm1pa2De/dEbDr/V5JS1XFAyH/96cwWDI3rlth1ohZhNJxrJ7wtI1aO0js+cTVPf7xrFrCdMSt24GZ5NtCDZyCuhGY5JNOfAZcLVQAd/QeX8Dszgg2ZnDqI7HfU06tBvlbfJKZ4BFKogGOVzMn2Fej6L5BsNNUPYZOEDArgd7g1UYolZPYK2y5NPrphFi5uivFOsvvhOJTczAWYWKUxQjfS8OJ5O1HNQ3j+Q4j14IsXq05UE3tEr5ejGCsdx1yJR8TF7JnB3WxsApqOkI3g+vpGTltcgh13xTqsWJKnoed3guRUCvG06xdzbeglLiFVLCDkFUOOhFDCvr5AA+JfxJ+VMT8Vz/SMoVwoSJ/VztPX3odK+htwgvQ8IPWPFCVyQTAp1viKxelQZOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(5023799004)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVpNUJxQlBqT0ZJNDQyWDlRLzNnbHBxcFlHQ0RjVWxtRnhLa1ovQ3gxTnRL?=
 =?utf-8?B?Q05lSVBJejV5Yzg3T09ZZ1ljQVVlanVZbjZsRklrZVRPLzJOeDBCdXhRZmh1?=
 =?utf-8?B?ZUNaQnJWNG5sMXc1VU0ybE82N2lwNHM4Y21ybURuMDQvRGYySEgrSm05UEI4?=
 =?utf-8?B?T2lacThiTCttcDA1dzlGWkJqMHJQdHY4eVRjYnJVTzdQOXNZWnEwRFZEUjV6?=
 =?utf-8?B?V3E3L3RHQ3RrVURRdzUvWENHQW5sVlJWR2cxQlpZQk9EbnVOUXFYc0RGalpD?=
 =?utf-8?B?VFBCQlFiUnZXajNKb0p3clZhU01vK01rYXJEVk1RWkI0S29rb3RVeG1BRmpZ?=
 =?utf-8?B?WlY1ajdrdGlGZTJKN09CVkJ2dlFMbFE5eGpGVlppQjRWSklqTTNYTFZNR0pt?=
 =?utf-8?B?dlNlTWtuK25yMG1uQ01aOWhwVGZ6ZEUzdmxhUmYvZllrWWc0ZklORlBzQ2Z4?=
 =?utf-8?B?RUhvSDB1cW5qRUVIaTRyd2c2Ry9OSjdjZkFYMnhSVkpOUW1ZMEJsckJ6VzVh?=
 =?utf-8?B?cWxOOW4zMnlIaTVTanZ0bUpPSWpYRnRwSUR0c1hIL21waUdqTWI3SU50SVY2?=
 =?utf-8?B?b1ZjaTltckQyRFRkeEJqckpLUVYzRzJaRjJIMGRUM2djdW5RcXE0TkV5M0R3?=
 =?utf-8?B?NlM3SjlhUlhNNi9EaUJXRjhVVXJBT0RpclVMWVY4dDFYbEVoLzMvMnRvWG1B?=
 =?utf-8?B?VmtxS2w5UWFaY2c1VkxFdnU5VTluZ1lza091ODF1MHFBbHdGc3lDS2hSNnBw?=
 =?utf-8?B?cWNHTExUTHYzTnRpNmhnMlhsR296dktkZWJMVjNTazhhSDBBTDdjWXNqT2M1?=
 =?utf-8?B?NG1kMk8za0dvNFZ0QXREWms4YXlWN3ZPZkZwcjN4RG5QclI0MnFLVFhDSjNy?=
 =?utf-8?B?L29zUm05SkpwTk5jM1gxa3lZRTh3Y1NNZDJZdndTYmcvUHM4Vm0zNlQyK1lX?=
 =?utf-8?B?bkVxN1NVSjBCVXc3WmxwdEhMcjdiNkltcFIvNDM3dUZQcldYalNFQVlXREJj?=
 =?utf-8?B?T2x4K2tRK3h6a1pYUmtqaDIydlVLSWVzajhSakRIMGtFZEw1K1QweXJPbEpT?=
 =?utf-8?B?bzJTUXM4ajJQanJBeVFLTzFDQVVQQ25jeG01aTRVcDFFYU1FTUNEMnhXQ09W?=
 =?utf-8?B?NDNCa0ZOdTFRNEE5bUdXZC9oQWcyR3VLYkR0cHpYcklMWHNJeGZ6MFlwTmV3?=
 =?utf-8?B?aUpXcm13RWFKYU5FcmNBMGxaRStnSldXa2pVYWFUMzBWekRMVG1jaTVKNTQ5?=
 =?utf-8?B?dFlMcHVaTmZxbnlGbDlOSi8yOWg4UVdrRndlU3RSMUJDY2Eydlp0bTFWRTRS?=
 =?utf-8?B?bkZnSFI1c0orYW1uMEE2UkJIYnEwaDlwbGMxNWtLc0laUzkxSmxFbWhURWsw?=
 =?utf-8?B?UTRiVkRXQnBONE10SEZjQmh4dVhRUjlKclVtdUJMaVB2VGJXRFdyK0JzbDdm?=
 =?utf-8?B?eDNLS0kwN2h6K25sOWNzZnpUSk5nNzg1WU9QaVhBTE4zZk9HVVBHejN0SkIz?=
 =?utf-8?B?T09EUkpGY1ZNdmNVaGVOamFYVUNhRnpEc05SYnZ0NDN4OExEMmNiQjR6NHJa?=
 =?utf-8?B?T0ZBUWRoU2Vpc3VsTm5RY3YxWGdMaG1oVXZnWlZld0R1M1JMcmNncXk5WUlG?=
 =?utf-8?B?NFZqeGtDOU13K1czK2cwdCtTOE9CQ3kzMCtLN3hBRWROOGNIRlNueFpnTVBj?=
 =?utf-8?B?aFJ0UFhHTFVtaE54V29NbHY4dUk5RXkwcEFwVUd2ekg3Y2xpTkY3SVhIVkRw?=
 =?utf-8?B?WTdjR2FvUDc4c2xBRHIxa1NIZ3l6Q2thVFJ6Ymt5R2lMYkxxWi9xaE1hUXdl?=
 =?utf-8?B?bnZPbFpIckkvTk9yY0g3TkRFRWhFNENINmtHQk9xZ3UzajJneWJkT1A2bmVK?=
 =?utf-8?B?T0dlRzZNNG9wV014bjJRaHViK2dYRWgrbXZGYllIRjFxaGN5TlJ6cGhXZ1hT?=
 =?utf-8?B?T0RIUllySEdqdFNCYjhmS2xseUV5R1duNU5DV0RSV2hBeDB4Q0NHSlBoMDJ6?=
 =?utf-8?B?NnVVRlhnWmxJdUl2OUVMMFlqSGIzZ2RqNW4rY2FBa2c2TjB0MkkyeFptcUNC?=
 =?utf-8?B?YVRySzBXU1lqUmZVMXlwYUNWNmNMVkF4eVcrbWZqN0U5TnpNb3dMY01QcFA3?=
 =?utf-8?B?K04rTkl5R2ozSmoxenZzb29NT1RUclZ5UWtyVHRxNjQvOXhmOXhjZW10VXdI?=
 =?utf-8?B?TldtWExHTTd3YnNHNUk5eXlrVWNINW9NNitjRDk1dDEwRENadGZrZHRVTVZu?=
 =?utf-8?B?K0lVR2RYcE5rSTNCRU9wQWtnSW1uRi9uQmwyWHJTYlZZREtsWms1eTdVVTFI?=
 =?utf-8?B?N0VLNEwxQUZkUVRXeThVNUFiV3cxV09kOEVtTXdZWGRwdEFyMXBlZz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6e8731-26c6-44e7-47ef-08df1ef621ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:24:18.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPlSQrGl7EKlPBI1kfna1c4RzTwjGdGPQ7WpmvaWopM9Kb3cFY8HClsbTFHG94dv2UUR9JiFe9ZgxkexKwLUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4949



On 24/9/2026 2:40 pm, Adrian Hunter wrote:
> On 22/09/2026 14:12,tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng<tze.yee.ng@altera.com>
>>
>> DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
>> settings that need board/SoC characterisation. Read the read-DQS delay,
>> read-DQS source and phony DQS assertion timing from the new
>> cdns,ddr50-read-dqs-delay, cdns,ddr50-use-lpbk-dqs and
>> cdns,ddr50-phony-dqs-timing DT properties at PHY probe, range-check them,
> Firmware values are expected to be correct, and so are not validated.
> >> and apply them only in DDR50. When a property is absent the existing
>> driver default is kept - for the phony DQS timing, the derived
>> REBAR_PULSE_CYCLES-1.
>>
>> Signed-off-by: Tze Yee Ng<tze.yee.ng@altera.com>
>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 72 ++++++++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> index 84592ae42762..0f47fa62d894 100644
>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> @@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
>>   	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
>>   	u32 delay_element;
>>   
>> +	/* DDR read-path overrides (SoC-specific) */
>> +	s32 ddr_read_dqs_delay;
>> +	s32 ddr_use_lpbk_dqs;
>> +	s32 ddr_phony_dqs_timing;
>> +
>>   	/* PHY_DLL_SLAVE_CTRL register fields */
>>   	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
>>   	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
>> @@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
>>   	/* PHY_DQS_TIMING register fields */
>>   	bool cp_use_phony_dqs;		/* bit [20] */
>>   	bool cp_use_phony_dqs_cmd;	/* bit [19] */
>> +	bool cp_use_lpbk_dqs;		/* bit [21] */
>>   
>>   	/* PHY_CTRL register fields */
>>   	u32 cp_phony_dqs_timing;
>> @@ -523,6 +529,12 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>>   	if (phy->mode == MMC_TIMING_MMC_HS200)
>>   		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>>   
>> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_read_dqs_delay >= 0)
>> +		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay &
>> +			SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;
> So here is unnecessarily assuming DT is providing a bad value.  It could just be:
> 
> 	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_read_dqs_delay >= 0)
> 		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;
> 
>> +
>> +	phy->cp_use_lpbk_dqs = 1;
>> +
>>   	if (phy->sdhc_extended_rd_mode &&
>>   	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
>>   	     phy->mode == MMC_TIMING_MMC_DDR52))
>> @@ -530,6 +542,18 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>>   	else
>>   		phy->cp_phony_dqs_timing = 0;
>>   
>> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_use_lpbk_dqs >= 0)
>> +		phy->cp_use_lpbk_dqs = phy->ddr_use_lpbk_dqs &
>> +			FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS);
> Ditto
> 
>> +
>> +	/*
>> +	 * The phony DQS timing derived above depends on the board's SD flight
>> +	 * time, so allow a DT override to re-position the fabricated strobe.
>> +	 */
>> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_phony_dqs_timing >= 0)
>> +		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing &
>> +			FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING);
> Ditto
> 
>> +
>>   	if (strobe_dat) {
>>   		/* dqs loopback input via IO cell */
>>   		hcsdclkadj += phy->iocell_input_delay;
>> @@ -693,10 +717,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>>   	sdhci_cdns6_dll_reset(priv, true);
>>   
>>   	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
>> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>>   	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>>   	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>>   	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
>> -	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
>>   	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
>>   	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
>>   	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
>> @@ -881,6 +906,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct sdhci_cdns6_phy *phy;
>>   	unsigned long val;
>> +	u32 prop;
>>   	int ret;
>>   
>>   	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> @@ -919,6 +945,50 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>>   
>>   	phy->delay_element_org = phy->delay_element;
>>   
>> +	/*
>> +	 * Optional DDR50 read-path tuning. These are board/card-characterised
>> +	 * values with no CMD19 tuning in DDR50; absence keeps the driver
>> +	 * default (-1 => not overridden).
>> +	 */
>> +	phy->ddr_read_dqs_delay = -1;
>> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-read-dqs-delay",
>> +				  &prop)) {
>> +		if (prop > SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY) {
>> +			dev_warn(dev,
>> +				 "cdns,ddr50-read-dqs-delay %u out of range, clamping to %lu\n",
>> +				 prop,
>> +				 (unsigned long)SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY);
>> +			prop = SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;
>> +		}
>> +		phy->ddr_read_dqs_delay = prop;
>> +	}
> If the unnecessary validation is dropped:
> 
> 	phy->ddr_read_dqs_delay = -1;
> 	of_property_read_u32(dev->of_node, "cdns,ddr50-read-dqs-delay", &phy->ddr_read_dqs_delay);
> 
> etc

Agreed on all of them. I'll drop the range checks, the clamps and the
& FIELD_MAX() masks. FIELD_PREP() already masks on write, so those masks 
were redundant anyway.

Two of these also change form in v2 after Krzysztof's review, which 
removes the validation naturally:

- read-dqs-delay becomes ps (cdns,ddr-read-dqs-delay-ps): probe is just
of_property_read_u32() into a u32 defaulting to 0; calc converts ps -> 
delay elements. No clamp.

- use-lpbk-dqs becomes a boolean (cdns,ddr-use-lpbk-dqs): 
of_property_read_bool(), so there's nothing to validate.

- phony-dqs-timing stays a u32, and I'll drop its clamp/mask too.

I'll also reword the commit message to drop "range-check them".

Thanks,
Tze Yee


