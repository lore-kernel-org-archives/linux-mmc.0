Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A21378803;
	Thu, 21 May 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386224; cv=fail; b=lBpR5FFAFhoV32YMgRQkik2ADNlExuFtGRqy56JzeswzedP9Ziv5mfOUlhHRq2BAQshviCx/U5jptfnMSWy+uld+gWcAIO8XkIE6gNBoCnRRDt1RimVYrl4OOVzz8dIpucJybySF7ISMJdoTZhM59d0xp5Bdd+h2/sHOeVMPxVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386224; c=relaxed/simple;
	bh=hFxEXSdwvsD5rl6jYvYjwMLlMgWRsdTjzBh9OWlRe74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iny6la3+LKMmQV34hK8Lt5d2ACbU3BuXBav2vxafBrF5kSV3wMn5D04DfU8oie4UJEJ2C87vx5yg2ZzjyZcKnFTwkyLWaxzFj9I+1TglACm72zeOBYrKgErBcHxwdxw9RodBxOZ1i9LQHlpH0vcVmgk/381vCKDdgfrdeWXTBtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wZkZwyPC; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wZkZwyPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRC5RmnC6lX/NVoYRX/yF6bJWL2kj3/2HQCmw6+ZT/GkNC23C5DMO2Rc5awIcFb/27Tke+m99YaoL1/cC1xtsYqiObMe28kF2vCLcUIQj496eu4TnifP1P44ePoApWps0ccJQx2mrYW4yllHf4uCTf+iEPnXrJJukGgC8hzmUlltduUywoaiIOAPLGaTgEZkvvoSFHuISc+90c0+iQU8OXN1atC+Dh6oz75f9BtGN5DTkbTz9kSsENrSzLgnCJr8iYoFVLw/+rehoM3cwL/7zW90noCwD01Kle/ZBApRSBv8j7+QyIMPdZeoRssNN0Q5pGMUplRxnxwuZqrGjvwq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu1XFCx7lmzN8NFXXFb64IQ+8/6qoRQqfg26MrPpub8=;
 b=PgQj9GS0GTOrdAn3kf2t9Zol5aekSMUS79265oIUFbs/nT4fyRZqwmRDtia+rveg9kk0x7ND6eSuMNou9Sgvu2lj79NLpkHmeSgYPKnMmiS4H8fhZUrexHiFPAtB7dYaTrjTWSqSHi+qUsYcWAETOhXr3MouWN5R+zu3Hoz7AMVoXqIwhKICEJvLarsP2rRbi7jM7yjoPitlRsl0gZpVR0F8/VBN5ohlX7FBfAspsYEzlR1z6h3dOdd65X8HaW5IcPikAR8J3xOuMmN0QP+zMiUL9shIdjFSv3FnatG3ZHC+MdlUSmAEHZ3Bm8yaBVMFs0c3alaEB4H6sTfYC2/xuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu1XFCx7lmzN8NFXXFb64IQ+8/6qoRQqfg26MrPpub8=;
 b=wZkZwyPCrW2hot1vba5Al5Ew0kL41WC62UM39nXmHLcbK9TX/T1s4HxWGB/YmO3i1W9btppJ+RuKKufmL+lAdHOyk5F5EEQTUrrjvnsbzaypkRBayaOu+320ieXNRWAeuCTKjHhLFkvqsm/m0G/wRbJwJhoj4qsXdE+zUUk4jnjGZ/H/asqHU7p6a5ZHAwG2dsdWvtauUiS9raEz+vwIPii6CqR6D+wltgqoPzDhWdcPj833tyyUIHgeaIr2gCPl/aiwhMUN+ccfI7Nuew88hSsHmM1jaTv2xwTsIaL2yO1hcosaO9nmidor5r5sP3MZrEKbAd/kJSVMKB+KOAX0ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7995.namprd03.prod.outlook.com (2603:10b6:a03:5b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:56:56 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:56:55 +0000
Message-ID: <5401fcc1-c89d-41e5-9df2-460e4d7a4ad8@altera.com>
Date: Thu, 21 May 2026 23:26:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] arm64: dts: agilex5: add Cadence SD6HC controller
 and SOCDK enablement
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-4-tanmay.kathpalia@altera.com>
 <20260515-tuscan-spider-of-realization-ffafdf@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260515-tuscan-spider-of-realization-ffafdf@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: d14c9183-9208-42ee-4a46-08deb76257c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|4143699003|11063799006|3023799007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZrO8yxbm20C5+x7AWGdU/fRBTzQ3tWtALexEu/IiIsk2DOvXlZkvrXC6KszzbKGtV2Xi4IqShlI4Tre7PEO9ZleJrUvc1e69pX7X6FweHc24GdfQGjjw8PrNeiCRWZnAgDlHoYfRMfjJQj9V6zcrxP8lR36YFMvF6Jp/QCbwUnyNZPnfugQPvdp3UrmLno+qplyYL9r8wqvx5NtUB0zYVk2znh7QWA3S8cQaCuu0xU1zya0iLYVSgHATh8dxQXZzHDPGVcGrzvoivwovpK+HVxp4EsI+Do5223jP1LV1IAV6OCoXOzjqQU0g6LigJ4W7DSba0mHG1JfZKHW/P4p2N3wTlABptjtLCZzVjnxPftTEMHJClsyKDt2DqMWpL5MZHeGdgfDu71uC9JuD6xepVPWiolGJ0Psc8KSgUXI7QYABkNfSqU253WC3YuZk0ArlPiavtjCpkFZmECALNNouW29wxZ5zuVHV2izEIQP2yPNKAmlkSYpr+w/rJHrx0TWo1AUENP4wmAPiMU0My8HLty+UnxLxr+IZnciYZPu5UKkWusy5LToGpmOaqSyNkkv9S2ZoKJFfzADpRNaP3B9Vrs0tVwUejCT5WhDkEfLA5nQCa/6nX1BBsoCVmz4Dz6TPGgxoJQX5SA8OLYhBt+9zx4D4/JKUibKalybrIf+HYqPOH3LW3NJyELqggbHv8oXA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(4143699003)(11063799006)(3023799007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdLK05BT01TZXFyTCtPQ0Y5cWVSQzhmRWtscTJCbnJBWWE5eGhHWS9LblE3?=
 =?utf-8?B?UzdTaWtPTEN5d21mWkYwRXZWZnVlQi9EWjdqUSs3TFFMNWRuZGFlNjN2SFcz?=
 =?utf-8?B?a3kvRUxjSFdWcXpUTlowUWJsVnJuS2hieGhPUTNXQStESFdBVkh5dSt0Uldx?=
 =?utf-8?B?V3FyOG5uRjR5STNPS2E0NzJkc1FyWFNLUWcrd2I5Q0VzUHU3NWYyQVVPLzhB?=
 =?utf-8?B?TkZvVHlDcHlxbGo1Z2NiZ0tvRXhZMjhVZWErTXZLZzV1TnhPS0MzVE5IYVZq?=
 =?utf-8?B?V2dkRXhMM1A1YjdmcnBEbGVyTVZ5eEJMRlJYSTFNSG42Nm8xbkY2VHBBSGtz?=
 =?utf-8?B?ZzUveWdvN1BBZXpVZEQyenc5Sm4wa0t1R1NGbXVXUU1YUkF2d29IYktOSnlh?=
 =?utf-8?B?V1NFam9BNG83K1NWa2M2aHBFRzA5MVVUZDFhWGlVNXhJbFQyclRuM3JHR0pF?=
 =?utf-8?B?SFZjSlZGWUttOFlja3k2S0daenlQcEJRV3ZhTnAyRlhHVUI1cnFyNTZRZzdx?=
 =?utf-8?B?WWhIdWtrTHlJRzBsS3A1Uy92Wko5L1lTOElrSzNSNFdaaWxnYW9BeEJJSFkw?=
 =?utf-8?B?TnRjOTgvRlFXS0RtN3NiM3o0eVBGSFpBTGFvNkpuSWFTL1VJODhwZUZ2bHR4?=
 =?utf-8?B?Z01wTFhUNmlkME1mbGd2UE1pV2F0cEhtOUVVVFphT2s5KzFrNmR5Skw5dnNK?=
 =?utf-8?B?SmF0Y24zVXd6UmVYRUNtQTN2TjBLdXYxRVF1amRMLzl5Z0MyZDNzdWJsVkl6?=
 =?utf-8?B?ZFpXcko0Rno1cVc0RDZXOTgvV1JkMzhxV3RJam9MUHErMUdhS2c3SnNVTG1L?=
 =?utf-8?B?SHFvN3k3UkpYaEk3R3VoL1JLemZBL1ZNR0ROeDR4U3dlL21iSCsycUIxQitD?=
 =?utf-8?B?VFdaOHhRWEpYcUlNNnl4MGY4MHdadDBHMVZPTjVYcFN0ZG4zNUc0TDhPVGds?=
 =?utf-8?B?WUg0dHd0QUFBT3IwekhVMlF5eXVjc1dVL2h0dlF3STczT1BmclhTb1lVWk84?=
 =?utf-8?B?Q1ZPRnFRS2szV29JQWZFUjVHODlqejdPYUdHdWhPOGgyRkNzVDZiTE91b1c1?=
 =?utf-8?B?RXpZd0RnLzFVOVZGVDR1dEQzaW9vS0U2eFFJRFBxK1lnUk9GemJBMllhNU93?=
 =?utf-8?B?eGJHRXBDOFBSZnNKTGdwWlRHenloUGN2MEF6dFczTHAvRkY4c1NLR2xhUjc1?=
 =?utf-8?B?dUIyUVpOR3Z5MUdsdW43WFFRYjU3dFBVNUlTdUEwQWJ0Q2lYSDNqeWZvRUNF?=
 =?utf-8?B?UGptYVdhamJSbHYydld2MVhjTlZBVXp1TkZ6UFBjcmpoaFBVRDFRWi96TDhl?=
 =?utf-8?B?WDBjRVZlamEzUVpYZVpNdVo4Wk9xZUFpNmU3L1Y4MHRtT0plY2hURFMrdzVC?=
 =?utf-8?B?VjMyNEt2djZsdTMvNFo5Z0tTWjJLQTFtT0owV1d2VzFPWG5OdGF5WCtPVjk4?=
 =?utf-8?B?c2dINWl0VCtDOGVIRUdLalROci92N2lpa0YxY3pGUW5kazkyOTVyajdFSnla?=
 =?utf-8?B?VkxFRGJsQkFqVkVkOUFhS2QyTTFpc0MvOEtFNGpDUmM4OFF1aHlYd0hJYXdx?=
 =?utf-8?B?MmFTNFZHT2UxdVl2Z3B2UFE5RFFQUTdQL1VvWGN0R3krbDdkRUVoR0w3K2JV?=
 =?utf-8?B?dW5YYU54TUVIRTY1RnQzNkZrdjU4cjRyZ3YzclA0VEhqVWhKTFBGVDFlWlZP?=
 =?utf-8?B?TFdrYU9IU0YvM0xXb0tLTlo5eHpkMkRJRG8rV1FUMHM0Z053WTJlWTZYVXJR?=
 =?utf-8?B?b0Q4TUxCbFZpZ1NTQjYyQU1KQkYwbzhOcmV2Zm4wRUp5Vm5jUHZUWHFFRllX?=
 =?utf-8?B?dUl3YjJBdVFucUxzNHNBRDBoMzIweXpQMXNqTVNxS0x2dWdWWElwc05zUzRD?=
 =?utf-8?B?ZDdUYkZZcGtuMmk5Q3loeGdzS2pvMFdzdkxmUmtFdmVEY0pDQlNtcitKeDhT?=
 =?utf-8?B?U3BXYnNxOVdjN0hwUEJjUkl2MVJXMktQVVlpUGVzc2hGeDlJQnFQV09QRTR2?=
 =?utf-8?B?M2VtUHhvVm5GRk56azNSMS9ER1ljdElxV0l2Yi8xcCtDSERscm0wU01GdlE4?=
 =?utf-8?B?czVFNk1oc0loZ01hMlhtOGU0Sy9FZGdmaXhJTmtPenRzTUNCdmM2aEEzSHJs?=
 =?utf-8?B?R0VvTGRqZ01tZ3dPd1AzQm04MldhOWVlWXdMR3hEVnY0YTlpRGdGM2tkMkFp?=
 =?utf-8?B?Z2tuKzRzWHkvcCtmMTF5MFJ1L3ZybTMzU2pneStzQjRUaXN3blFVZU01UzJE?=
 =?utf-8?B?WC9adVFTaHZNTUc0SXdrTUsvSVd3aUZnL0ZQVUZJQ2FZRThWdWwzdGVtZEdv?=
 =?utf-8?B?Y0pncjBZZnFuSjVFNDdCbW1mWUxBc0xXZFUvMVVSMGxpTkdEL0VNd00zYUsz?=
 =?utf-8?Q?yX5B+eaC2/rLSXEM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c9183-9208-42ee-4a46-08deb76257c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:56:55.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pny5tMzE0INyWsjFGkboFV/qWXAY2kRMILRS48MUCYpf2QzExRSBzIOLYXhzYYd1iEpz1LOg52TmqRg2rTYzIR9+eRkuxKKKxGgJdR2Hy+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7995

Hi K

Thanks for your feedback.

On 5/15/2026 2:08 PM, Krzysztof Kozlowski wrote:
> On Mon, May 11, 2026 at 01:21:25PM -0700, Tanmay Kathpalia wrote:
>> The Agilex5 SoC device tree gains an SD/MMC controller node backed by
>> the Cadence SD6HC, with IOMMU integration via the system SMMU. Card
>> power is supplied by a fixed 3.3V regulator and I/O voltage switching
>> between 1.8V and 3.3V is handled by a GPIO-controlled regulator.
>>
>> The SOCDK board enables the controller for SD-only operation in 4-bit
>> bus width with high-speed and SDR104 UHS-I modes at 200 MHz maximum
>> clock. SDHCI capability overrides clear the SDR50 tuning flag and
>> override the clock base mask to report 200 MHz.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 38 +++++++++++++++++++
>>   .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 26 +++++++++++++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> index 352c96d144a8..7e080f13166f 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> @@ -300,6 +300,44 @@ portb: gpio-controller@0 {
>>   			};
>>   		};
>>   
>> +		sd_emmc_power: regulator-fixed-3p3v {
> NAK, this fails basic rules of organizing DTS/DTSI and the nodes. This
> is simple-bus, so how could you have here a regulator which is non MMIO?
>
> Plus, explain me how these regulators managed to appear on the SoC
> die/silicon?
>
> Best regards,
> Krzysztof


Apologies, you are right on both counts.

In v2 this will be fixed:
1. sd_emmc_power and sd_io_1v8_reg will be moved to the root level
of socfpga_agilex5_socdk.dts where they belong.
2. emmc_io_1v8_reg will be moved to the root level of
socfpga_agilex5_socdk_emmc.dts.
3. The shared socfpga_agilex5.dtsi will carry only the SoC-level
emmc controller node with no board-specific regulators.

Regards,
Tanmay
