Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776B3C553A;
	Thu,  2 Jul 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982918; cv=fail; b=XyAhAqkyI5/I0X085UiSRActdu/5yCq3Sk2x5jU4mx8CiDaTM7SQdABv0lnHUkMKj+8qieP1Q6AkoL+XRZ34OKsbdNqIceMTr3LTAIrMkM2CGaY2s+GPTADCFFvPduVvxfuSnTLkprBELMHgKoL4INVyBudZq7/hgdAW4II4Azk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982918; c=relaxed/simple;
	bh=Ve91TDkcw99b8sY8I5OHTNgIxVEOS0viFt64hBw9K2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueUMkx2Lk6vVxcULeJCX2D5SrwH1oEFgWOqP7nhFY46AC3DR1Ud9shzDNjrZAhmQNZqXH7hNFiF1FQEsUyUR0Ot2em9dICH9i/TgSBU8EoCPgMFRUzuc8JS70LZt/nnAY0ocVBbM0d/epsd4TRF3MUuwkUfxT3WDLYuCh9dvLYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YjxRnEF/; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YjxRnEF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbZ1iWkW9d1fKqHJJhoikoOeBJ+yQ3Gbdoe8TM876riu6XM30RBJbhJCfdO7TGgUbzslJ+xON9pH4HSZty0mjiqudwi5FpbWiM/EevRgit7cFFjlziqqR3vj5KACEAFiDjRnc4ir+lFy4uG34cO5uD6O0dIqtfB4YxE9hJbi2p/yR3wgqrvgnprj/lzHd+qayjGotWNYkXnKMks8vH24NLRDwW1lsnxleR8gdI53cYxddgTFQrxB6q/WUtNf3uIF7MBKNA5al3TRFCkokYB5BwfgvtiewtxCZDf18WpZ7c6+RfOaTwVXFbBXsYzGNVQCNt6L37uor0k4jv4w+bp+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAxX866RjjgBy535U7fJoDE7Xy9RM0RScEzeozAtMb8=;
 b=m3dQ5PhRIYLRjZqeH6uhKR36ieaEBs/Qkfh+Yo1p+74iVVlInCK62Y+F7QnlEqbHGIPN9kc2hM6M83rP3Xz1/BSGlLQZlTUXQWO0iMxS21qzA+dlIllFrEBRiCDCjUfGFCcrhgs7pTcleEzxsm5C9CeTtNMQy6wuYoWdfFZ10whcyrB6tYLDvgvvdYCjraBd/qFvU0VP78bh9mSaTpkWLZxrl/0VFGF8J3b+juNTd0WparleD0GAFdIF6Gz+4bPU6tw4YJvdNRfLLUug8QjeD+Tu2vM42rH/eCw5wbyoh8mDhlGYe9MdIqqbmSdOVnYl3F6meJO6OGk4e9pfGtLoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAxX866RjjgBy535U7fJoDE7Xy9RM0RScEzeozAtMb8=;
 b=YjxRnEF/tFzz2M4ByjYWoK7AE5TV2vpjk7KzYE4JW4pkcCpWK6tdEBgT6vXF2PJEGsLmDIHpt0DE2OLvVgYZVkxOm1BCIS/i/iudUt7X87ecAcawB+GPBA84X206ImhP7t1rm7JjI2BFaNIcs9yORuVfQJhhyxH/Qv1Lck4FETQqGdKfiQmIA89Xr47CnAhIkgkuTKbTtfbU7D7Z1e2WqUUaHx07/3IAgLXOmOMKXvcpt4m8wOfqzI8rQhUfFIf/tS2GU21hmPPTuWiOP0O/Sq2lUh2JpFO+Qpf+xhglNq2wzoRnRoIwd1CsE0EyQt3IC7rMCKl2KzmrsvK5EV800Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6489.namprd03.prod.outlook.com (2603:10b6:303:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 09:01:52 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:01:51 +0000
Message-ID: <be1238e0-4bf3-4416-b2ca-cae4532b82e3@altera.com>
Date: Thu, 2 Jul 2026 14:31:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arm64: dts: agilex5: add Cadence SD6HC controller
 and SOCDK enablement
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-4-tanmay.kathpalia@altera.com>
 <20260629-tireless-hippo-of-innovation-eb5e27@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260629-tireless-hippo-of-innovation-eb5e27@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 609e7878-078f-4e5b-95c2-08ded8188e43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	gR8DTwRuom5UAfrvFyGJ3DXtQjux9s67mkhDIe2DDCBy1+k+2Ek86N7oKjR4SK6XVMfmZNlR4+qVJHElASR8hSV6EXLJUcsgQkASuDxnKpIY1lQqIsCs81DW8G4C/j1H7ohoAOgdFAttjWyteacDtCBpJwRevETdEAqORwWoZ6KmzkF058KZoiFSahUU25xDJZrQ9+Zht8g0JwDDhLFTm7y1uUf4of9cjJjjVp8gN4SuFtqUJaOHxD5OC7v3qd3cjFVVXbNa8vktHW/+N6Gsqm0WdMXfwAUso8zVNXBIOB72IZ971jmWpIbxevZfyPqO90XDeXKVC9u8aws9oCzFQbUJsMIr2MziosJe/umBwXucP6UnsczyYDVs0l/rXgyPRRbrGG7Sr8+la3QZatkcWOMofp1uLmCJ6fxg7RJc1AbGAk+7p3XOrMzYKdOsCBG8xW+rVnOafarU2pNFAoOz/lc33VfixPPfDVOCXe9KnT+oDWC10MsI2n1J/+OT/ufePwMYGWj+278wngwOQegLgJBuPwbxyXmWpeB67UvQMupLtk5WJycwzzlM+G54sDzKLfyBAcVb7h/OkFV2c/EMEu0+4oCffxlAzjyh62nFmhQIFl3JZWM/474LFy+0HNPHfCnK3ihaiz3TRI6yMf9Jn6kwTWq6qHibkBXkU4M8qpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWczUTB1UEd1QThJK1d4SWpnMWxUSzNRVDdnZG12TnpXRlBmNUk2ZUFLR0ox?=
 =?utf-8?B?aFh6UHl2Z0xkaVFVeTc4Z05oUnNYL1lyNWFhalBvZjBONVZoZ1NBbElYZDM5?=
 =?utf-8?B?WXRCdW9QOXZ5SVRWRFhYQ3BkN3NXdkd4SUZyVHdpSXdjNGtIQWtpYWRpRHoz?=
 =?utf-8?B?VVdSRFFQbWxNYmN4WVltTWVkZnBSdGJJaDVmaXM1T3F2T1hLZ25HbktmM21a?=
 =?utf-8?B?M2NYUjlPWUphNWdUSmRpa1JZbzg3KzU5cGkrUWlYV1FRNFl0SXFLaGlZZXpE?=
 =?utf-8?B?VWI4NWpHOUxjNVltdmxvcVJxWEN6QlJnVnJIVnBIb2pkVzQvK1l4V2NMRTlP?=
 =?utf-8?B?ckJ3RjQ2QkhHRlY1UzRDQndCdjlJZmMzUWV2aFlUdHhQU01FeU00dks2SEMw?=
 =?utf-8?B?Y1BzWVhxZFltRnZ6SVRkNlhyb1JTQVUxS0VCWVZBS2FYTzFpY3FFeWRyTHhh?=
 =?utf-8?B?WkxGMDVZcUFtREpCWTdhcm41clBzUHJwVkdwUmFaWlkvb1J2U3FzQ2FObHFj?=
 =?utf-8?B?MzIxbGF0WHFyUDRkaXVVdit0K2krUXdRWW1FZ2FQRi9EZUhhWWg4dTBUZkFC?=
 =?utf-8?B?SlVCN1JGZVNxNVZQd2Fkc3hOWTU1c2p5Y0c4K2hSVWRjcHBKZiszb2lrY29K?=
 =?utf-8?B?ZUkxT3JmdXN5YUFZRUIzejRKL2lRQTRUcExzejl5OXpMMnZ3SS9PenVneUFl?=
 =?utf-8?B?dUNrcENua1RQNzhhOHExRFVpdndDVisrQjE0ZlBVbGlaQzZWbndTM1E5RnY0?=
 =?utf-8?B?VTNxWitpSXdlWk8rZmJuNTl6WHdzY3N3LzBYcStVcGkzT1NBdWxHQWlFMHhj?=
 =?utf-8?B?NXJaT3ZjN3FSL05MR0ZGVm02ZDlwWnFQUDJSMngvK2hDeG02TTI3Z2cvc3dP?=
 =?utf-8?B?WW00b1VFUlNaME5Vbk4zbys4endJc2FzZjVaWldPcFZ5aTY3WitEaU1LMDVG?=
 =?utf-8?B?OHlFWnpsT2hYekZUWGFzYmNYZ2tzUUgxbDFDbnhsd0tlNTRGeFZJVWtoZXdr?=
 =?utf-8?B?c0ZmSmhvaVZjZjJhbWJTdVZDTFJFaXhiNTlHVWxpTHhDK2RqS2NVZC9RMG4w?=
 =?utf-8?B?UGRBMmRpbU1aQW9qL3NMMzU4ZmxvbHo5c24xMUExTWZGQ0lQZk8ybmszZ2cw?=
 =?utf-8?B?Y3ZPQ0h1ajVYam5nMG51NG1XMDdZUXlBcHJmdVZYK09vUmpUTWhKK3M5NzNJ?=
 =?utf-8?B?bTB6YjlidkgvNXMrOEc3bllmaWdsaXVTU2pjMjErNEF0ZEVZNU84R1hyUFpF?=
 =?utf-8?B?YWppOGU2MUJ2T2lOdWZFTUlMU3Q4MzRYbFJsSW5jenREYTBzQ0ZzbTR3bU9O?=
 =?utf-8?B?SUVPTWtYTGlRazUyeWk2T2hpTzNKV3B1RlY0UFk3YjF3NWlDcC93Z3A4Ukxz?=
 =?utf-8?B?ZTFzY3NLYVZWSi9PdmhseXZydnlYSUs2QWpLdDdBajZIUEhxeUdpTVNhNmI1?=
 =?utf-8?B?ak9vK04zZitpWktsT0JVZ0s3UHBsKzNEODRkNUg0WktmejdMV0dEV3JDM1Jt?=
 =?utf-8?B?N1I2Q3JuWktka2FxVUkzNmdsZ2NybVg0MTBieFpQY2hJWm9zL2F4K3kxdVhj?=
 =?utf-8?B?VXZpRE5sb0h3ZWtnSTQ2b3Z4WENodDc2aVh6U0JTTU5vcDhOazNKSm43T0tL?=
 =?utf-8?B?eENNVkxCMCtBa3NsOEV5cTcxdTZIOGpSekFHWE1PSWNqaFZCS1FKSCtwbjJL?=
 =?utf-8?B?QjZYVWZieG5LUWxwT0gzT3NIcVk1QWxkakVzRTBVTXFKUUwxNUpmcVpCNEJG?=
 =?utf-8?B?MWQ0OVVsZEVMQkcvSU00N0p6ZUErVGdMRDB6U29CWnBEN3UrbWZpUUF5OFV6?=
 =?utf-8?B?NnFUY05qOHRnb05Na2dPVlRVZGtJbWdoekpLQU9vVXB5dXJXYStwVmZOVXRJ?=
 =?utf-8?B?QXpQL1dmKzVydDJJOEdVbnNmUGJYUnM3cjU4ZHhoWnJxSzdSYXhUdkg2cWFX?=
 =?utf-8?B?c04xUHlyWHlTMEY0VUZWaDNjZUxUNkRtZjh1bUJhbmFIU0FBeHNxOXhLVzN6?=
 =?utf-8?B?bUp1U3g4aFBIbmdoY1ZETWUxTHdXWVVWVGtVbWpMd25mRXJVUEh3cXpEbllC?=
 =?utf-8?B?VHdKSXJoMkgyMVF3aHFjMTFCVHAyM3hVVk4rcnpLVjNYVjBsUm1Zb2FsanhR?=
 =?utf-8?B?M3JEMjc5S2hyMmhtRDE5MWN4TllGRGkzTGJnMUN4MVpXTFJISUVCWXBid0ZI?=
 =?utf-8?B?UkIzUHpLRFBNNytHZW5DTzNDVFpKajlHaUl0NlVYaGt6ZlUyY0E4L01HdTlW?=
 =?utf-8?B?emx3d3dET2JUeVdNRWsyS1JWR2I3aEVXU0ZPQjZHdW9TTWFlcElmcWxBQkh4?=
 =?utf-8?B?cjQ3UXZjeEEreUhDZlVUMy8vR0p2ZTBJNnFKOFhwMkNPNUd5T1EzSjlXT3Vj?=
 =?utf-8?Q?09t3m4YyK+kZbNRo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e7878-078f-4e5b-95c2-08ded8188e43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:01:51.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUgHRgVVfItlsQj6CjkKRyvhD2fNulot4CjldyWhXJhrnL/NFcZFvYCthUkUiZhcmSDf9imkrlUqaH1X5ZLxFpkNJOjxoZXR+cQDmD1Mp3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6489

Hi Krzysztof,

Thanks for the review.

On 6/29/2026 12:36 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 27, 2026 at 01:14:48PM -0700, Tanmay Kathpalia wrote:
>> Add the Cadence SD6HC controller node to the Agilex5 SoC DTSI as a
>> shared SD/eMMC node, disabled by default. The controller integrates
>> with the system SMMU for IOMMU support and uses SDMCLK as the primary
>> clock source for PHY timing.
>>
>> On the SOCDK board, add a fixed 3.3V regulator for card power and a
>> GPIO-controlled regulator for I/O voltage switching between 1.8V and
>> 3.3V. Enable the controller for SD-only operation in 4-bit bus width
>> with high-speed and SDR104 UHS-I modes at 200 MHz.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 +++++++++++++++
>>   .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 31 +++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> index 02e62d954e94..f552aa0c1faa 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> @@ -300,6 +300,31 @@ portb: gpio-controller@0 {
>>   			};
>>   		};
>>   
>> +		/*
>> +		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
>> +		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
>> +		 * it is configured for eMMC.
>> +		 */
>> +		emmc: mmc@10808000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
> Please follow DTS coding style for new code.

Ack, I'll update the DTS formatting to follow the coding style in v3.

>
>> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
>> +			reg = <0x10808000 0x1000>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>, <&rst SDMMC_OCP_RESET>;
>> +			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
>> +			/*
>> +			 * "ciu" (SDMCLK) is listed first so it is selected as the
>> +			 * primary clock by the SDHCI platform layer; the SD6HC PHY
>> +			 * timing calculations are derived from this clock rate.
>> +			 */
>> +			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
>> +			clock-names = "ciu", "biu";
>> +			iommus = <&smmu 5>;
>> +			dma-coherent;
>> +			status = "disabled";
>> +		};
>> +
>>   		nand: nand-controller@10b80000 {
>>   			compatible = "cdns,hp-nfc";
>>   			reg = <0x10b80000 0x10000>,
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
>> index 262bb3e8e5c7..c56f46721bb0 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
>> @@ -34,6 +34,24 @@ memory@80000000 {
>>   		/* We expect the bootloader to fill in the reg */
>>   		reg = <0x0 0x80000000 0x0 0x0>;
>>   	};
>> +
>> +	vmmc_reg: regulator-fixed-3p3v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-sd";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	vqmmc_io_reg: regulator-1p8v {
>> +		compatible = "regulator-gpio";
>> +		regulator-name = "vqmmc-io";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		states =	<1800000 0x1>,
> There is only one space after '='.

I'll fix the formatting in v3.

>
>> +				<3300000 0x0>;
>> +		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
>> +	};
>>   };
> Best regards,
> Krzysztof
>
