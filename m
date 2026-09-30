Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8753384CE5;
	Wed, 30 Sep 2026 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763888; cv=fail; b=oXucWywrAZF982R1MpMPg2U+eBUAXn8bdGgmWlVfJ3tyF2HISSiyNrvctZsT97Yxuh/ajEWTp0j7BISwRTZIcB3bKcf6taja3u96K+tr7i5dQuDGqWyfZtNGPxXuaDsaHEh8xl5pezPryCGc9ouvTm/bjhGCiuxisBhvsQVlr+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763888; c=relaxed/simple;
	bh=WVW7SyqQZnBndZpXqJrILC0GSq1UBO17Ud7ZMoQynmo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTDQPoAtC7mFJ7Kz97qg++ctPZcNYYJYFJMDLZJwO3kPpqO8JU0ZBcQhG+e/PJD1W2f1RGptqdHvcZ/E+yuSD8IdmDGIiR8KttdK/viqLo/wUTVcQGxiv2arlWt8+HYSiYCnCncv+H+UdXtoWK2T5i6mJbVTaQafKW8NPyojy8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XhjKPYWA; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XhjKPYWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZFwSoG9SYn0zAqkQrp7+7H6s8YiF9mL0wk7lkw1m0469TITqFRZoM/XLyIaRcEreD6aVdDfVWZCnrnns9YmykF6pdoCI76tCmxqHkuve5qAaD5bjUyl5eZcz41ZUstf95nZwN9GQ/a3gc9WEsG3LmT2EPGIH5ovEbQGl5zcYVtRlHAQ0wPoIs6fBwyk5MD0S3BT4hIK1pm3qasZciM9dzLx7oETl0w5daIdvxGsVHQiiikIpGiu3JswsLAxS9HxKSCY9R3dmt3Taf4K2MlNr7fX8kJHEgckrIdTC/9csmILW6BPVNkYkj4B4roHEfyECQCSqflwK3M9B4bX6ruIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlp+5QeHtGhU6OtMa/ZMbfShUsCqAswU0sjOsoZw+ro=;
 b=jh2blFaXCODQx4Zxfs/QmnW+7s/nZbo5FfzvO0SX3OwJq9Tm8MTUHGSHxqQcczexVHd805I6JmCynPFwDJa/eXm0v2OIJNwEydCeDWf2ULM+won3KtU71cty7W/GTXsAmlIm2+PC7NLZxxaU8zYoShPBPSnI4QXcnBgWpA/koChb3mu54CIC8qo1EjngKvHPJZgF2fFEr0uVGWrRdztBtfjB9ozyZ3aBSunVSCiYh2j3TGHQqoNIr+vWO2f+pXOiWToB0iozic82zDBdfsupO/76F+j61SpHBKevVh9E31OMFVh5WfGUjI0ErZo+hKvO6Zsf8pBCMWuBAXi4pl9Dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlp+5QeHtGhU6OtMa/ZMbfShUsCqAswU0sjOsoZw+ro=;
 b=XhjKPYWAys2aGjPRbOdsy2E01pgpmr0c7d5C0YMFBMZgmjZpNDeTy8QATMRM/XVmLSzlgjl2An5z4TXR1uTGS9T9v8JrO5NGT0QgSioJLb3MhhAEEw2BAlnn5sPMF92l1ohMfTJ2kclKAWdBuggBcZ9n6GBGAn7rcdCWwuMleI4W9f08K3tfr6FXbrEuOJsOwVkpJBjF+JTsz5Mlb/52QsweYHiESCtd52wzKqGgGrGeQWj/kWXgq+yt5wYYG5QmMSy2A+ra71mxkg033Bo5rVUAErYoWylyxO7hkL1F0f1n/gTBTvJI7QFgMfZtOWubKa/QCUhAca0MhjletpUusQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB7667.namprd03.prod.outlook.com (2603:10b6:208:503::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:24:20 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:24:20 +0000
Message-ID: <de0c63de-952e-482d-81f9-405453275da5@altera.com>
Date: Wed, 30 Sep 2026 18:24:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
 <5c11f8eb-567b-4c1c-98ad-6704659e3fe5@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <5c11f8eb-567b-4c1c-98ad-6704659e3fe5@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: c1692b9f-460e-4977-06c0-08df1edcfbea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|921020|3023799007|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JTZ3TG1FKYa92j825wuoOlsuiw+f35n1UdCfrxoLpynXZXu/Gx3/9XeFnmd91tuE/QiTbQV/jjv/u6l2M7ZLwAvV3JO99RodB/mdVfhCy8PcPIKBNQQbH4pc7x1VunW2/s5qBuInRHa++dL48u0j6ThjrHVpngiTNmBRv2+ZWTUzMY1UuTJLf6uSCq18AxhxQON2VyJPjMHq8/isGCMtll/vCZN16wGGmztQmY+M+JzmKKWjLzBc8cOFYAXVmISDDVoQVw1gdEmsfD+8LAOjg19kI/Oz+FoNDfCMnA8vs+QL5f4dy+l9aeUJtnil630Af5reyUqfdm6e+R3XR2O/jEYYgxidiLrAUFaxrfdERcPttYXgnS1DsemzNMgoeTZNqi/mpr/QdNYO1jp622bAU4MwnExtjwXoQ+pF6k6jxarQM7U5/S3kcFod/ictHENGnyyFd10d0mfBJmT+0Jy8ThnJfGGJg3FWy1F4QObv62gcFE2X+NMTA0oKnN8/xasxzuHkEJozMLrp6ztsOeVE8qkaV3qOVfXrE2g3PoTatUU5QylBo/YC09Izw+Iq3ZPGhSQfaBuJF0zXQXrp/gbybpvtabcS1/gzeIuWT4n+jYR+hbkdu6Opy94dPXAMaJh3zvFcJXDn/JUjSBgXXGsJn0feh8r2O/ixnAYVBRZHSTA1nimMMMpFJop6hn/08uN3P2cujq6NmYDYYG+LlgZc1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(921020)(3023799007)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGVBUmx6U1BJVE5SN0ZkVzRpNGtqdGJGK0ZMZXVkamR6MkdidW9lMDNMd3lP?=
 =?utf-8?B?TXpLZWRXc3lJbkpCZkZVZmpFUFhvai9WTElXYW8rVWFXQ3I4bm5NaGxuWFBE?=
 =?utf-8?B?eFVQRTllZG5vTUJxcExKWWprVjNUSy8zOEtSYVdRT0ZTNUQvSGtldWhHZHpr?=
 =?utf-8?B?UWVudzY4NEVwYjI2WDRrSFp4Y0JWdnU0SFVuWmhSMEo5N2tWVUoxTkhYdFZm?=
 =?utf-8?B?M3JKYVczYnpWZ1FHU0JpRlYrRVlXbUx1WWkwV0dzVWRZSHZBc0FqSmZrT1B4?=
 =?utf-8?B?V2c0V2dMWllGZVNyNW53dkQ4K2ZsS0hoTFYxalNkUVhvSzVoVFNTREYyeUp0?=
 =?utf-8?B?UzhxcE5wY0tPSEtWa2Zta1MrUkwrMlVaZjBsOGZDenBWNnl1RHVNVDN1M2h4?=
 =?utf-8?B?bWpHZTBmRDZaMytFQkhwZnc1MXVxejA3MWVEbEh6MmxYODVjczdmeGlDUXUr?=
 =?utf-8?B?Z0lUTnpiTDZwU0s0SHJvMFBya25Id3ExUEVWenZiR3hDRFNDYjA0U3ZOaE1j?=
 =?utf-8?B?RllMVm1RRDBYSFlrbDVnQTBKWnpKc1htRFdiYVp6UzRBYUdCTnY0NzdpYlVD?=
 =?utf-8?B?TWFvcWJDUXpvUjJsV2I4ZUlUdVF4Y2NSOUlsRzRMM1RIbEc2WUtydUMzMW01?=
 =?utf-8?B?Z3BUNU1CejNVQjVoV1cyUnVvWWhPUjBPK3UwZG51WUN2d1NROHdDcUxuUUpr?=
 =?utf-8?B?bGcySXMzMktyQVVtUkxWSXA0bCtGVERtVE5BYjBWbjBrN09tUUFMN0hISFQw?=
 =?utf-8?B?MVFYeUxWc2VMWEFGTjFydkVXQzBkMGV4Q1k2OVc4TGlFamRLRW5GVldjejlG?=
 =?utf-8?B?cGtYY3RFelNYN09ObUdaUEtqQmhndndJc0Q1VmZBVlBiM1FwVmlUMXZyaXh5?=
 =?utf-8?B?Y1IrYlR0OTUxSlJWQWl4TFM3emRJNThKVGZ0dlRHcVltYkxXakJWekovTmRY?=
 =?utf-8?B?dTduRzYrRGM0dVNmK25yZmY4L2R2WnBYWjBUaHc3TXFSRUMxL0piRTVLZ3Q1?=
 =?utf-8?B?YVJvQ2p4cTRpK0NYZnlMeUZEVkFBdXJONGZaWTZFVWNZYnlYN2ZyMEF6bnVj?=
 =?utf-8?B?RTBnb3RYRmJlSUpLNXlFVk11N3hPd2orSE1TYnBad3M0YmppdHJhNjVSYlYz?=
 =?utf-8?B?T1pMZ3l0eEJzeEg3d2VhOFNhSHlXdW1MQUVGeGZvMjFFRGpBOCtyVWMxdlNY?=
 =?utf-8?B?TmJOR3lCOE9zcHpvMC9YQWEzNGNGSmUycUtHYTRvYm1XaEd2ekt2MVF1RWF1?=
 =?utf-8?B?TlFZZ2srWVRIRndHWTVQUUpXUUxjaTRFNkJMeHhMaVhiMnFEQ0hEVU1VZ0li?=
 =?utf-8?B?RVBSR1QzSUwycEtTK0Y1YXVzVHRkMXQ1c2t0L3RjS2tyRzFaVFFJV08veWlB?=
 =?utf-8?B?WjllZFE3SlgwZ05saUoyWjhzeG9YZElvdk9BdlRidi94enczYXFNbzdqSXhZ?=
 =?utf-8?B?VG9ib2R3b21mdGZaVkVYZ05mUVgySDRTUzh0b1lqRVVxL0ZTV0VwMXRiY3Zs?=
 =?utf-8?B?SkRkWFdkZVd5emcvdjRLbXBubVBQb0l1Y29OQzBuellpRXVRYzF6OXd2S2sz?=
 =?utf-8?B?eXRTTHNnN0F0L1RIUXZoNXMwWDdYamZPK2pMWE45WmRXdG9QczF0aDVlS3dL?=
 =?utf-8?B?bHZrN0FkWFlhTWVKMFV2aGtBazA0VDE5eklzMm0vTFBMdFlic3R6WVdldk44?=
 =?utf-8?B?UnhhNU5nVnBFd3E0K2U3QTd5WUthaEFiVmg5amFRcUUweWFTQzZ3dEhkSCtT?=
 =?utf-8?B?WEVEaWVzQVQzanB5YklFdHNyQXRlMFBXek5YS0lhRzFQSVltTFVsbmtBb3dC?=
 =?utf-8?B?aVpjQUl0NUJGQkpoQTJvSS9QUTZRL1B0WEh1Z25jajJDWTFiWVpiMmxpRkZw?=
 =?utf-8?B?b1ZmQzVlQ3VDY1N3c3VKN01rMUd4ODNVNFUxdzU4dXVIdjlRcEVuNGYwYzZ4?=
 =?utf-8?B?Ky9mMnNjK1MyaUNjNTZzNkp3bTR6WGhBNTAxd0l1cDBqMUNvRGpVNzJxcXZv?=
 =?utf-8?B?NnFLeFdEbmJ6NU5MSDVMK1RwUHI0dW5JM29UQUxzOHlvNmdZcnZxcXhuNWZL?=
 =?utf-8?B?akkxL2czbEZEQWk5djZpaWlYSXUyN0FYZTZDZXdyRFFmbmNKUVBtUC9uNmxG?=
 =?utf-8?B?dzV3Y2dTRUhFK1FkOXVielFRSi83aVhGWkFPR2VmdUtEdWRJZ1YzL2xaV1Ax?=
 =?utf-8?B?U0lpblF3ZzNxYlU3dlAxM012ajFlcHpQWUYyYUtxKzdEd01haWJlYlo4QTNy?=
 =?utf-8?B?Nlh0QkxxMXM3bG5YblEwNDY0Qnlnb0JlUzMvTUdzNDZhTTNXSVI0NlJaTnVQ?=
 =?utf-8?B?cWpUMS9IaDA2amkzc082c0Q5amo1SDR3T0NrTFpZRnFSZzI1VVpNZz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1692b9f-460e-4977-06c0-08df1edcfbea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:24:20.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQcV+6SIgnuDOF41epgfywDngfa37EXDeFC6Z/Q1rsuNAQh/sh0dtlRgJq0VFU0DY/30sJ48PqVk4rd4sAMrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7667



On 26/9/2026 6:45 pm, Kathpalia, Tanmay wrote:
> 
> On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng<tze.yee.ng@altera.com>
>>
>> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
>> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
>> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
>> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
>> (the silent odd/even edge-capture defect).
>>
>> This controller's rebar pulse is a fixed 2 clk_phy cycles, so extended-
>> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
> 
> The code also applies this value to eMMC DDR52. Was the same behavior 
> verified in
> DDR52? If so, please mention both modes; otherwise, please test DDR52 as 
> well.
> 

Yes. The final setting (phony_dqs_timing=1, use_lpbk_dqs=0, 
read_dqs_delay=96) was validated on Agilex5 eMMC DDR52 as well as 
Agilex5 SD UHS-I DDR50, in both U-Boot SPL and Linux, read + write with 
byte-exact read-back. I will reword the commit message to name both modes.
> Also, please provide a reference showing that the SD6HC REBAR pulse is 
> fixed at
> two clk_phy cycles. The PHY guide defines the formula, but not the two- 
> cycle
> pulse width.
> 
> 

You are right. The formula (value = rebar pulse width - 1 while extended 
read is active) is from the Cadence DLL PHY guide. The "2 clk_phy 
cycles" is this controller integration's pulse. I don't have an IP-level 
document stating it generically. It is bracketed empirically:

- phony_dqs_timing=0 produces a silent odd/even read duplication (every 
odd byte replaced by a copy of the preceding even byte, zero controller CRC)

- phony_dqs_timing=1 captures both DDR beats cleanly on every card/board

- phony_dqs_timing=2 shifts the strobe a full clk_phy cycle and 
re-corrupts.

So the pulse is 2 and the correct value is 1. I will drop "generic to 
any SD6HC-PHY SoC" and describe it as this integration's value - it is 
not even SoC-generic, as the same SoC's modular SoM variant needs 0 due 
to its longer SD flight time (handled by a follow-up device-tree override).

>> corrupts reads). Derive it from the extended-read-mode state and apply
>> it only in DDR modes, since SDR extended-read samples a single edge and
>> is unaffected.
> 
> The driver sets sdhc_extended_rd_mode whenever t_sdclk != t_sdmclk, so 
> extended
> read is also on for divided SDR modes. Sampling only one edge may 
> explain why the
> corruption was observed in DDR, but it does not establish that zero is the
> correct value for extended-read SDR.
> 
> 

Agreed the single-edge argument alone is not proof. Empirically, the
divided-SDR extended-read modes pass with the field left at 0: on this
hardware only DDR50 ever exhibited the defect (SDR12/25/50/104 and HS 
all pass). So 0 is the verified-good value for the extended-read SDR 
modes, and I scope the non-zero value to DDR to avoid moving modes that 
already pass onto an untested value. I can switch to the simpler
`if (extended_rd_mode) ... else 0` form if you prefer, but that would 
put the SDR modes on an unvalidated setting. I would rather keep the DDR 
gate unless you feel strongly.

>> This is generic to any SD6HC-PHY SoC, so it is kept
>> separate from the per-SoC read-path tuning.
> 
> Also, "this controller" and "generic to any SD6HC-PHY SoC" are not the same
> claim. The PHY guide's example is a 4-cycle RE# pulse, programmed as 3. 
> I do not
> see a statement that this pulse is fixed at 2 clk_phy cycles. Please 
> cite where 2
> comes from, and whether that width is SD6HC IP behavior or specific to this
> integration.
> 
>>
>> Signed-off-by: Tze Yee Ng<tze.yee.ng@altera.com>
>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>> host/sdhci-cadence-phy-v6.c
>> index 35f35ef9c710..84592ae42762 100644
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
> Same question as above. Please cite the source of 2, and make the 
> comment match
> whether this is SD6HC-generic or SoC-specific.
> 
>>   /* Default PHY settings */
>>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY        2500
>>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT        24
>> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>>       bool cp_use_phony_dqs;        /* bit [20] */
>>       bool cp_use_phony_dqs_cmd;    /* bit [19] */
>> +    /* PHY_CTRL register fields */
>> +    u32 cp_phony_dqs_timing;
>> +
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
> Based on the register description, I would expect:
> if (phy->sdhc_extended_rd_mode)
>      phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
> else
>      phy->cp_phony_dqs_timing = 0;

