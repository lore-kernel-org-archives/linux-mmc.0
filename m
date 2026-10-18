Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85B320CD3;
	Sun, 18 Oct 2026 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358398; cv=fail; b=TZasYvKg8KZPKewsWO0/rCAagWXY6spFE9noOHEXAnDMOTTkSvpSMlNu4ZGSVPiafHmY37vVudoFtrmPLADzonRA0c6Jm+SNmxNEnaj6rVIBiKCgbuHkMrH/zbd0fjNuye9TI2Sh/oymfJoIheXVdhFiFuAu+5e429mWV3CFpbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358398; c=relaxed/simple;
	bh=z6ORGSsUT5ZuBkdCcYjHOzf4q6GRH+YlJza/RwylAlg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=moyVOJGz7HbxdvtODYsfPdfgaJyj82ApsLeT4VvKQxaQQ9scqgoKBW1JuJUehXWfdNvwyuzYG+8ysLTyjlAIpb3PToyq4MvrtBlLwQRFwbG/kdf9JI6DCEfC3+qKv3vpNEN+uZ3bsoi8Tcj/kQ6fwEAdC3BTC7jE6qynMij6ofg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sOBaxOq0; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sOBaxOq0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr7pGpMO0u1qrE8IUmqWSNdZ6abaRbZnUYDKIdohQmQEOfm10Zbd05L1/upJ+O0MDoCg34uJY5ey2LdQSZP6tYMpaZ26kYc0g21r1qN7kvYBRGkS33j7xN4VwkqD4QNWSMBgy2hRvOXwn+2KGt+2mDGs0+cgN4a1nWJAM33rrBjcDhbZeMA3evY2ZLl+kRhB1WVDAMpcYRw0MsIlRVKUmhvatWxjUbf/2DQg4eBVAU1gHu1L93eIJwIRqfgBG5xD9jBYPMrXBfUfWecmLZmhWGhK7HQgpGDv7QOlsChuu/fKL4X8UxMKAKAitwi0HLj2j0iBPIFfaLShbLV2zMBzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xAgJc6zAzlD7l8vFRTBNTdpA7qFTeclUDAhLz9BdKQ=;
 b=WhpYpgprQUGneMFmiLEzhRz0qZ/aILJZuhiA7OazRHlqKfoPpZWGZjJ2jXdTL5lc2b+schTRZGCk7IPol/2ckhzdWzQBi3c5mrybKSkutROLR0Y9fReY3UDw+oDPqsTSmtdK+leyTOr9u9vRHGkotQNcE39fZdRPw/+nzHObemULwnyFymzhdU/gLP9STOPSHH/s3bWpCpSok+VKy4In62022lSb9+yGWl/vC41I1dXgyuJ0w1IKcRx498p9LltoVLNBdWNkmL5dHSgqvOzUG1/NwIwDjSALqS+GQwlbIyn/qFPSHmLm1xaJs9X1HX9hbjO0H6Tq/TbLURW6AJTulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xAgJc6zAzlD7l8vFRTBNTdpA7qFTeclUDAhLz9BdKQ=;
 b=sOBaxOq0j3tyKwUQ5JEZovPpFErWpQKKk7bKXdYTFl5L7F6wMceqYfYduRUkARU2CW8Zq8Zq6V61uEUvoBp+xDwpTVSQtLo7NmHe/DSJEBWat9jKhN7/nidOho1rk1rtF40+HjN+sokDS4yyqu2xBjNDvl0Bh4Owz7Mi4QcR3EPagghlVrYC8wQ9tfvTtBMLIOZkN8TocAHtBiroac7T8Sz4TtH2MoaYCoURmFH46oEWb8xXnWVUspv6SU6sMtS2RJvtQpMm8vurEBmeVtnhUCI8nNcGTCKmmGLoKgCOOlYjkZ9VW9D947aaKjzySzS3rOuM6ziRJ2Gn7J1q4fkjDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH2PR03MB8086.namprd03.prod.outlook.com (2603:10b6:610:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 21:19:53 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 21:19:53 +0000
Message-ID: <0318a6ab-35c5-4d8f-9a6b-d048b76d6381@altera.com>
Date: Mon, 19 Oct 2026 02:49:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path
 tuning and fixes
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <cover.1791459448.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0039.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH2PR03MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: afd6282a-7f46-4c17-7bee-08df2d5d8bfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|261009223027099003|11063799006|22082099003|10067099003|18002099003|3023799007|6133799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	4NXKBBmn0NU8inn9LxbuayXBhhS4iLaroagrZIAZxS8VY1k2SutCeUMG0s0fTofWvDYXCRYyGp1f4EyXxpuwnFdVr3SyKwQeiU0HtXp0g17VgVU28oZTLrJAWtUqJ7dqio2fD+dqDhjnu3AqqjVrFCqxbI3G5nFgnW3RgIiTJgyoBQ+wIAU6I0zm36gfekkU+IutYJkTzP7730wqPry7gwznqNeqvwpOpQ12D1jyVObjDgMQ/6mSySP2qUxrgA+pQ9SSFnFVTwJpvz+wiasfxVnU6BgPkYkIS6KL5MqxjfdVBz2P+gN+DxCBXNq1maN01evDKKA2VTTJdPoxzaqupgZPg4PJQ+N4NyVb++5vTGrSbENE65ZW4AgnsxDM7Kufd5EiRxaVOhw5b59byPa8KBtxRcoOyVySp1OoIUmVUmWjTtDsiOohm3t3lRYU0KWrhKvWwK+0KHTR2PtMsBQMXkCtpRfu29ConJxbXCG1H1NAvO/Gr7vu0xuRhw6VACOi6jqZ8cAviBHYyqP9+VsNQseqbMiP9ZH/knOJd7fwuY7GX++uoGeikf/mInlRzDkxHZ6wcut2jv8Nif0NOJzkd5RqEoGhqWn+vCcsHQYn6zNfXBdvfzdPGC8d0yoxOUS/ExeTGg3JvzBnA+BG4t1ndWckWWpjS2C53d5tfrRaVNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(261009223027099003)(11063799006)(22082099003)(10067099003)(18002099003)(3023799007)(6133799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZVZTVEV05qdE9DOGNBRmFsZHBVWWR4MWt2YksrYUNTQXJiSTQ0Vy92Qkt2?=
 =?utf-8?B?bjY3NGlYQWVhZEVNUUJYZmZLY3ZUY2JOTFFHMnhzNVphckpzdmtFRTd5K2pm?=
 =?utf-8?B?aU40aFdCamI1aDNPNE9BejZjN0pqRHdJME43a2FaYTFmTDIzLzZBMm01Qk1Q?=
 =?utf-8?B?ODFFWXZwQzNpbVJ6dUt4OUJTYW9tdW8xdlZrOHZ4aW1rSDhLbDdNNU5LNG1z?=
 =?utf-8?B?M29zUS9Da09NdmlSUDZQNlByZDA1L3g3VmdVYmIxSjNyOUxaSitVSkZDWm5K?=
 =?utf-8?B?NGRsbmoyNzNHNklpZFBMVktpVjFnQldlZk5NUngxOEtDNm1qU2NmQTV0bWE1?=
 =?utf-8?B?Z04vMHBtZUgrMC9HSWZ2eE1zTUg2c2FmSUZzMnRKSUFibGlZbnBMeHM2VW94?=
 =?utf-8?B?SE5IcGxVVmhIbXJaOXpmL21wdzl2ZmNZTkhSaExGejBVMit2MEJOVTEva1pT?=
 =?utf-8?B?dC9VV1RJZGlVNW5zK2VkT2t4OHQ0VnBJYUs2ZGhWRml0a2o2YkNnZVdzSVFw?=
 =?utf-8?B?WnJtaWNCWFhRTFY3d2xrZC9qK2UwY1AySUg2MEwzRndBLytVNk5veEJoMjV0?=
 =?utf-8?B?ckMvWUhSTlh2SDNzQVRqV0dPakZVcnJSeWhFZzJxYzdaenFFcURsTHljRVJW?=
 =?utf-8?B?M1M3anVmeGNCRzFLQWJWVUd3QXRGT1ZWdlY0djZEdG5ERThPUlAyS1lLTzcz?=
 =?utf-8?B?cnoyVTIrNzZJTklwa0dNb3VjVlFNM2lSbkFaMnlZd0s4Vkx2MFBJWDFuMlla?=
 =?utf-8?B?dm0rdHRiN2tuZzJHSWRkTTdCVUpTUzR5T0x2Rk5wZ3pXOUNleXFaN1o4TmtX?=
 =?utf-8?B?bGpHNkxma2Q0WDFNSm9PQ1VXVjY1YWJvc3BNR01raWkvdXhQV1hxbnVpazYw?=
 =?utf-8?B?S2QwY1dSSlAyZEt4dmoydGYzRDRDNDJYZm9FaDF1OVBQSjQzUnF4cDQ0OURQ?=
 =?utf-8?B?Ui91TXNoODZrK2tJMHpEeVlTMm4vMk1EcDlQK3V6MUJTdzJEZkNpdmRJT1lX?=
 =?utf-8?B?K1EraXdpKzM2QUM5RjB4TFZORGtiZmV4Yi9qMTVtREFGNkZXRUdqd2t0YThz?=
 =?utf-8?B?cVZWS0FBSjBtWmxGM1lJaElUcnhBWjMvb3k3SnR6c2lOK3Q0S2dqNi9aRjcr?=
 =?utf-8?B?VS90LzVyRm55NEpEOEJtR3djbk9nQzI2dXVLTDlnQ3U4UEVVU21ZYnFLcGMx?=
 =?utf-8?B?c1poM3JlcUZjWmVQWFNHWStpQXV1MFI0QzIwT2JrSVV5OU5WcWs0b2tzNnFz?=
 =?utf-8?B?NHdzZ3c4MUFjbDRVRlZPK0plT3NZVjNIKzUzOCtWZDg5dVROdnNOOTA2Kyt3?=
 =?utf-8?B?SXZIMis2TWpMTnhkcU9hVnBBR3ZRNGh3SmY1SEpiNmF0S0hDRndHWlNlRnN0?=
 =?utf-8?B?T2JkTU9ocXYvSFhrZk1vUG5sNFVSc3Z0K0lnS2F2Z0Z2SFUyaFdHa0ZrdVlP?=
 =?utf-8?B?dkxYMlAxZm41WCtEOUw1MGt6ZkozOWhQMzViemhUTmdrSzZDYUp4Tmc5alNW?=
 =?utf-8?B?QjZiWUR5WlE5b1dhbi80c3NzaFVOWHZnSThLeU05dHhRWHVpV1lZT05YQXR1?=
 =?utf-8?B?cXJoMHEvN3pzNmlIRDJDazhWdnJxUTB5L3NYT2dyMHRSRlBkY3dDbGxxSEhj?=
 =?utf-8?B?dTJiYmFSRG11UVYxSUNGWkREN3VKSXBwMk50Z0dOdUw3cVd6M1lCd1dua3dI?=
 =?utf-8?B?azZDMzVPMGZ5T3VINElidDBlUFM3aThhRHlBcDNiMGdQSSs0TytFS29SdFhi?=
 =?utf-8?B?NzNicDFob0pRMmpoN1FTTXRCOG1XamZGWDZ1cmlPcnA0clNoV3VmdEFDWnV0?=
 =?utf-8?B?V2FicUdzSmNEc0FmeU1nbVJjcWwwYkkyYlNYd2lpUDU5OXlCQ0owOC9iY1Yy?=
 =?utf-8?B?bkpXdHcxb1BhQkVicmQ2eUR4RXlMaXIvZkkydDQ1NUJVaHZCS0d1Wnlzenl0?=
 =?utf-8?B?bGpyc29vdkZoOE9ndHVsVmpsTkxmZXByY3VySU0xUE1HMU9xRFdjZGZSd0dY?=
 =?utf-8?B?RTgwdUZjMng1VWtpN0tLZ09UaHlVVmJKSmkwN0UrdHlXazhVZDVPSjcyL0Fr?=
 =?utf-8?B?UjRIQXpMRDlSc3FDRVRzQ2lEaEVsN2ZraXNHZWNwQlIyS3FEbkp0cWE2OFJG?=
 =?utf-8?B?dmdUd3h4Y2d4UXEyQkJITTE1VEVNSU1vMTd4TTVGR2JNbVRKNG5ZTDN1Vlh3?=
 =?utf-8?B?UCs3Si9vZ2NObTRFRy9zU2psN2Y2ckRDbWVCeW91UldZcmRnaGxVS09xTTRu?=
 =?utf-8?B?enRUTE5FTWx4aG42MS8rMk4rVytGSUd2Z1FxV0xTdVArTEwzRXE0Y3NWUVhq?=
 =?utf-8?B?ZThnUVA4YkVIOG1mY2NwcWN1NGlkcmEyWHlaNkNrK2RkZlgzRSsydWwxcDBS?=
 =?utf-8?Q?youM7RvpSFfMwfbU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd6282a-7f46-4c17-7bee-08df2d5d8bfb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:19:53.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSrYdoZ0QIPdN2fiGm6s1YrB3UuXCZYD5hOAOz65zpWM+qu6iMtyWkT+s9+Vwwz0dXxIaGPLuxRpDw36/BH8M2pEzZVCkXj+hntWkqk/On8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8086

Hi Tze,

I have been tied up with other work. Thanks for your patience. I
plan to complete my review of v2 by next week.

Regards,
Tanmay

On 09-10-2026 07:44, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> This series enables the extended-read DDR modes - SD DDR50 and eMMC
> DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
> tuning sequence (CMD19/CMD21), so the read path must be centred by
> static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
> also exposed PHY issues affecting the existing tuned modes.
>
>    - Patch 1: settle the PHY once after the final tuning tap, before the
>      first post-tuning command (an R1b CMD6 during HS400 selection can
>      otherwise time out); matches sdhci_cdns6_phy_init().
>    - Patch 2: program PHONY_DQS_TIMING (left 0 in all modes); in the
>      extended-read DDR modes it must be the rebar pulse width in clk_phy
>      cycles minus 1, else one DDR beat is duplicated.
>    - Patch 3: document three optional SD6HC read-path properties for the
>      extended-read DDR modes (SD DDR50, eMMC DDR52).
>    - Patch 4: read those properties at probe and apply them in DDR50 and
>      DDR52, and make the DQS_TIMING update clear USE_LPBK_DQS before
>      reprogramming it so the loopback/phony selection takes effect.
>
> The new cdns,ddr-* properties are unused in this series; they will be
> consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
> device trees, submitted as a separate series.
>
> Tested on Agilex5 SoCDK: SD DDR50 and eMMC DDR52.
>
> Changes in v2:
>    - Patch 1: moved the 5 ms PHY settle out of the per-tap tuning loop to
>      a single settle after the winning tap, on the success path only, and
>      rewrote the comment to explain this specific call site. (Adrian
>      Hunter, Tanmay Kathpalia)
>    - Patch 2: added Adrian's Acked-by; reworded the commit message to drop
>      the "generic to any SD6HC-PHY SoC" framing. (Adrian Hunter)
>    - Patch 3: retitled to "dt-bindings: mmc: cdns,sd6hc:"; renamed
>      cdns,ddr50-* -> cdns,ddr-*; cdns,ddr-read-dqs-delay-ps is now in
>      picoseconds; replaced the read-DQS source selector with a
>      cdns,ddr-no-lpbk-dqs boolean; reworded the phony-dqs-timing text;
>      dropped the SD4HC note. (Krzysztof Kozlowski, Tanmay Kathpalia)
>    - Patch 4: renamed the properties to cdns,ddr-*; read
>      cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
>      (dividing by cdns,delay-element-ps), clamping that quotient to the
>      8-bit PHY field so a small delay element cannot make it wrap; read
>      cdns,ddr-no-lpbk-dqs via of_property_read_bool() to opt out of the
>      default loopback DQS read path; dropped the v1 per-property range
>      checks and redundant FIELD_MAX() write masks; apply the overrides in
>      both DDR50 and DDR52. Also retitled to "mmc: sdhci-cadence6:" since it
>      touches only the v6 PHY. (Krzysztof Kozlowski, Adrian Hunter,
>      Tanmay Kathpalia)
>
> Tze Yee Ng (4):
>    mmc: sdhci-cadence: add PHY settle after tuning for SD6HC
>    mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
>    dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
>    mmc: sdhci-cadence6: read SD6HC DDR50 tuning from device tree
>
>   .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 30 ++++++++
>   drivers/mmc/host/sdhci-cadence-core.c         |  6 +-
>   drivers/mmc/host/sdhci-cadence-phy-v6.c       | 74 ++++++++++++++++++-
>   3 files changed, 108 insertions(+), 2 deletions(-)
>
>
> base-commit: 2d2431cf24dda7303d59e47b7d116be8beda66b1
