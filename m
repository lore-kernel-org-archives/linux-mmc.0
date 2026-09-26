Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF93EC807;
	Sat, 26 Sep 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419566; cv=fail; b=srGpfinecfin3krhoCBOTKx3DZsm9Ognd0U12Rkrhdjksh0AvdRV+gYrptjvcXT5Vp9SUwNR6ZIOmQK4kUzuJ04UJyBWkk8E5WBFgUhI3A0k6qmsH+fti3oKi7m1Ma/nnlFwWuoAkEj7fkEhU9p6CHIKJLPWKRo55IkTkLOJ+gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419566; c=relaxed/simple;
	bh=g7LMWd/GF6v0fbQDiORlnMjQaZ1L6QfX0LPefwVAJeM=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmiIzZP6aQA0kVroVNA88vcsdNGB1mb2QMdeRrNGAn1ijQNFKa7jFaOmesky8AC0SjkysE8zpzEnSPwbRpZ473ASOuaJHM9KMD/qx9t4XSWUpo4yuBqcG1KqHC+mWDw43PF/HdChSkFRQpKiXhlVzrM3SbJUYjWWyqUspbc4XHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ABB6T+cG; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ABB6T+cG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=febVW9XtKcRkXlXeVO9mk2+o/QbDQhyuO0nfNpy27X/B5L8KTSYwuYvtWaD6sOGcO1DJathhZ0nP01ZTJ2JF+l1tPBZtkuKmtQRse6OKGRsijx5K8vhPMDCmw0wui/AVkcWeDBZ4fokROghN5Tlr4Lczqd19DjoeD6Hq0OSTTIahqdw1kyRQl/uOrP3Fs4zN3f9mGcdne0jQnIYL/CtTClWqoASZmQL1RTI/3RD8gYe4Fo/NM7lXTfsftBQGriogRirB3yqkvrn8bo8fU6GxCZG4SZ1E12XmGfKW6bEk0sH1HtWtpY2AyhbJqgINK3bFZHhqO687iv2tsrWN7atbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh/jkjq3ENm8T/uy+0WSrGRPeVJiQuF2RuPYpH3QB4o=;
 b=aTc8pl8EP3ap9hyy2pdTp4U6ks0mZhcykOjdrszxdciTT/FhVghO4cH7awlXQTGMxMsJpVNwIZ0i2E5JLfcj6SR9DvRazl0bPbeZi/64jHs2FVfg33zUlbitvIx1IFJ4Cte69ebXuuogpV8iYi4fbNT/3bDBc/kIYpJgFXxkRZT/LL5Zo5Mo4KgdDRLg+d1oJg3ow6+oIqU+vpOSoqPd1INGLbRuT29TNgG3HkpkCpoNQKeR3ypsFzHogNe0V5Y4iazvJzIfV4nDZ1nqPY0bZQJNMuPzqhJHwrJwfZYQhGv9PrQTmTPSa0f1S9ivv06uXjIRKo0KfSvBOHAT6gofpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh/jkjq3ENm8T/uy+0WSrGRPeVJiQuF2RuPYpH3QB4o=;
 b=ABB6T+cGeZIW6ep1oTgBKNudVF3DRhHTOPpjQG3BXjP88hSBZeFgKbf7Gx4XxZoSNlE8JoSJSSzFyb3qE1qqijFst78ZSXuI3GlfxEoiL0MnvG0Zufrb0QDEHTtaYDNDNQrg1S39upzV7meJZtQBjOV52D9I0lrCQTobaOMPPrTP8bxivR84TKX9VEUeAQgoKImfsqX2+S/dX1D3uBund1+fP/xIvKMeO8nmxh9WSvJ73Tb1P1EUQhFVvwEtjO7ltFFHIL//n+e8Kki5AnfjEN5MbRUhQo9KvH9rO2ER1uDycqaliKMn8Thi6fN52JdRYNY+T4yU/4LAzzMC3EU36g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 10:45:46 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 10:45:46 +0000
Message-ID: <5c11f8eb-567b-4c1c-98ad-6704659e3fe5@altera.com>
Date: Sat, 26 Sep 2026 16:15:39 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
In-Reply-To: <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfecb99-73f1-4595-bd3f-08df1bbb520d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|56012099006|18002099003|55112099003|22082099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	L8HkWrdN/84rj4aiOVW1HIGBY7/FKxZ70F3/GwU99UvjJIWvKUkHK4vZ+cQqKEaUD6kCPVpHETJyHzb1CY/KMXFMwy/2tIPZwMEgndJDE0vc0BR0rILTO0Akze/PhGqSlZ7aRp1iYJxTBqPtBd2qFK3cGV2gliYmBuKwelCBIOj/FjTbAiMEIFKQBPZp1EqV/o6HWTOpPw/QRz8S98kQ4wECtM8pgLtxiRmF+u2JnLnps4WPXXB9mGfRthn/GY2DiR/u6TX7yLJ/GX5ocM4vDKOOQuq8eebTyM7xmq2Xcl/buxIZozYCpZKggC7k4MZMBo6R1Wpvkjtk+IOX+lcssd1sCHCzLWh+Ul4/0dt5wuqWxwL+8i/zljzOoIqZxq/a8Q/1r8uSxxK1H7CJTbX3XnYc0jCb7dQGXtv33FkkDRsH9+3AaKQw9utuoeqqEepd7hpWvOvPiVBTByVGMdo/XqmtWvAD/T3STAn06TGVNDUFUbnUjnvsk9AWmIHRDVPsLCAeY8qK3pItw79UNaAMeKwLJEfrcxO5/5a8gP2Uq7hud8+2RSbDQrUnGLZGoKOhU+KO4Rj2drmSvHGK0mXUhh7dU8r6DFApDROXYygJ/2wIcbgteeEWHIGSLLJvrKYD+vIkDHJthb0YQjeugXTM5S4TvkjLjEpEl/zz2VEAzqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(56012099006)(18002099003)(55112099003)(22082099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlpyY3N4emo3dmRQM2JWTitaMmUyYkN6aEtDaGEvaXllaFdadU9wYTltSlNQ?=
 =?utf-8?B?a3lETnBEL0IxOGsraVlIYXY3OWcrV2RyanlXa3laZWwxWlZKT0pMZEtONEt5?=
 =?utf-8?B?d3pzMzQzMHh6cTBLOUU5bFNGejJ5V2xJVDBJSXNTRmJwOGxRL25TQ0VCQ3Nz?=
 =?utf-8?B?Q1ZsSG01MWNBNUlab1NGTmpkak9xYngxQzI2RDNmZlFmeHFoblB3emlpcExY?=
 =?utf-8?B?VlNwVWtzdTVYSHVjS0dzT2ZCNlJqUzBQQnZyb04rSjVRaHJ4UllHMHBuN0Fi?=
 =?utf-8?B?L3ZhdG11cjlGQ0ozdXRQMGI4RGR0U2lIZ1VjUjZuZ0ZURW9BdElWczF6V0FE?=
 =?utf-8?B?MkZhRUExUjJ3bXBoMUljeWJhUVVqLzk2SmN6VVNLVEZFdUJWVDI1Vm1aSngv?=
 =?utf-8?B?bnl4bnVtdnIreU5vcFU5VThNT29HUnIyZUh6R1ZFMzNzT1JPOVdGZlFLckRD?=
 =?utf-8?B?alJDZzZ1em8vVUlGTi9ib0o3clhLQzk5WHY3SHdxWEVpTnlwSk9BOXRUQWtj?=
 =?utf-8?B?cFdqQjY4cEROQWhPc1gyeWp2YUFhaXJOeC9xUDB5NXZIay9vVXAzaUZJS2Fx?=
 =?utf-8?B?SVRiQlJGK3RjOUIvazZzVTd3VFgzTnViRHpYZ3FZTFNBWldXSGpOUm5uZTJM?=
 =?utf-8?B?Z3B1bXdDUDRleFlzNkFQeUJjWFZsUWw2bitXRW11QXRWN1hBMVFuU09DazMz?=
 =?utf-8?B?Z3NQS1pialB1OTBWNWJIYmNDeGNUbjEvQ2JNVjBzYlcyNDdZbHowbDYwOWhY?=
 =?utf-8?B?Yk9lT0s1dTlVamRjSjZLWEdDQlo5aVg0YzYreVpRdXFSdnNtbDRVeTNubUh4?=
 =?utf-8?B?KzRtUHJCOGpxd0NpYndHcmJCV2VHMXhldHl6NGJZM0F5U3R5T1VZMFJWYUN1?=
 =?utf-8?B?RmNQaW40SjJTVjdGZFU1YUU4eVpOUUozVEQ3TG9ZcnlYSzlZbENmTmI3SUNI?=
 =?utf-8?B?YmhBeVM3TFd5ankvMWNDVWd1VVVWTmM1bXh0MnVvR2kyeUEyTVNvUlNZemUv?=
 =?utf-8?B?TmFOUkNiZmNQL0dWT3FLc2I2YVEzeUpFMWlscTJvVGVVT1lqMVVUdmJEOVR2?=
 =?utf-8?B?Sm1aNGwzbHhNNFo1ZkdoNTUxZ0Z4UEdzSG02emhJR2FFMnJGSE10Sml2V1VY?=
 =?utf-8?B?dm1tV3p5TkpZMEtYQVl0T3dHSlo4YnViS2l5ZndXWnNITFZLMmFoWnBvN2d1?=
 =?utf-8?B?eTBnbEwycVh5MWU5V1c2dEltL1dEeTFoU2ZZTHN3c3psRU56WUkxTTBxdmcr?=
 =?utf-8?B?RWRoc21TRC9mdGxGYmRoaWtVRDBhR1JvWWJUTXE1dUtQUXZmalRXdUxGU2xT?=
 =?utf-8?B?a1EvUTNWbVhsT2VTSnVwRktDNHgyMk53NU45VFV2QWVCeEV3dlpDMXorbmI0?=
 =?utf-8?B?RXRtY2hJYmh6Z3RXWjJpWFpTaEVTK2xnLzhSVGdpd1lxbFRua0g2RW9zdjln?=
 =?utf-8?B?cThrUUxOV1p2blcwZnBQZm9oS0hzSGpST1BPaVV2VWFORkZLTlc0L2xjcS9Y?=
 =?utf-8?B?V1o3aDdVUmRrSkNlZnZrRVdZemUvS2dxM1dHNUJqdU5WbDBvdDZBMjI1QWs0?=
 =?utf-8?B?LzdHSjJpR25wejF4QzdodXR1ckh6M2JoejFOUW5DNG1Ia1U5aFBWSm0wbEVF?=
 =?utf-8?B?Zkt2V08vMVlnU0ZHUGhPM2srSUtxaFpGdGhFSnpvcGoxRFlDSmhzZVB0eUJN?=
 =?utf-8?B?ekcwYkJ4YkhoR3VRUGo4UnM0UStXRXZKWjZhcjczZjJGZCtyRzlrb0NLMkZy?=
 =?utf-8?B?TFRMQmZOdzJ2aVI3alJJUmk5WTJGMFpWY2ladzErSzB3K3E4MVpJV3NPZ1k2?=
 =?utf-8?B?d1Y2VDE5MUJxZnJkanJHR1lGSTFPZndJTmZjbURIU2V5L3pEMUNxY0VCU1p4?=
 =?utf-8?B?aGkxL0l0cHlVVFdIYjYxNXovMTlyMkZ5QVY5TEROdi90RDRhamsxLzVaa1FX?=
 =?utf-8?B?cXBzWFI3WlhGQkhsQmdHRnVnRnlGTFVDYTBjS2MxdWJNV1p3S0RwNVZSaHl3?=
 =?utf-8?B?UVdVeTVCRFRKVE93UndVQkE5MUpncFMxZUJsMDhMaWtlMGRFSmR0bWdaQU1z?=
 =?utf-8?B?b3VEazBvMC9kdHE1Ym9GRDVveEgyakg5eHlaMWdYdVN4MHZESElaMFVUaFdV?=
 =?utf-8?B?a004UlEvZ3h0VGJTVEJJNkdtcFFmZ3pQelZwNzRrYlAvUDMrMHl6Q3B0OE8x?=
 =?utf-8?B?TmZQVjMrekFKTFdlaUFRYUV2amVNWnZJYkQ2dUNwRnRjaWhSUFVEOC8yWFlo?=
 =?utf-8?B?YXhYK0pYYTl4MXJJNGhTQ2YxUU9XRFdGUERRZ0VBMjljbk8ySTlXUFk3UlV0?=
 =?utf-8?B?TElGNXI1bGVUQ08rTlp2VllLZkF1aEs2eHFwdlAvY0dIWWpOZEk3Y3Z1YUE5?=
 =?utf-8?Q?vMzSr+wCYT3TiBMk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfecb99-73f1-4595-bd3f-08df1bbb520d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 10:45:46.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHt2GOC3VP7XwHMLMClLlzn1GfMVe2m/xIzswuCHaWlL9TCqOSm/FeNsMmT8sNEXIM/V08sClFTyJIBAhwzZZnorvNApNmhQD5G7bEKXFcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132


On 22-09-2026 16:42, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng<tze.yee.ng@altera.com>
>
> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
> (the silent odd/even edge-capture defect).
>
> This controller's rebar pulse is a fixed 2 clk_phy cycles, so extended-
> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2

The code also applies this value to eMMC DDR52. Was the same behavior 
verified in
DDR52? If so, please mention both modes; otherwise, please test DDR52 as 
well.

Also, please provide a reference showing that the SD6HC REBAR pulse is 
fixed at
two clk_phy cycles. The PHY guide defines the formula, but not the two-cycle
pulse width.


> corrupts reads). Derive it from the extended-read-mode state and apply
> it only in DDR modes, since SDR extended-read samples a single edge and
> is unaffected.

The driver sets sdhc_extended_rd_mode whenever t_sdclk != t_sdmclk, so 
extended
read is also on for divided SDR modes. Sampling only one edge may 
explain why the
corruption was observed in DDR, but it does not establish that zero is the
correct value for extended-read SDR.


> This is generic to any SD6HC-PHY SoC, so it is kept
> separate from the per-SoC read-path tuning.

Also, "this controller" and "generic to any SD6HC-PHY SoC" are not the same
claim. The PHY guide's example is a 4-cycle RE# pulse, programmed as 3. 
I do not
see a statement that this pulse is fixed at 2 clk_phy cycles. Please 
cite where 2
comes from, and whether that width is SD6HC IP behavior or specific to this
integration.

>
> Signed-off-by: Tze Yee Ng<tze.yee.ng@altera.com>
> ---
>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 35f35ef9c710..84592ae42762 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -90,6 +90,9 @@
>   #define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
>   #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
>   
> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES	2
> +

Same question as above. Please cite the source of 2, and make the 
comment match
whether this is SD6HC-generic or SoC-specific.

>   /* Default PHY settings */
>   #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
>   #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>   	bool cp_use_phony_dqs;		/* bit [20] */
>   	bool cp_use_phony_dqs_cmd;	/* bit [19] */
>   
> +	/* PHY_CTRL register fields */
> +	u32 cp_phony_dqs_timing;
> +
>   	/* HRS07 register - IO delay Information */
>   	u8 sdhc_rw_compensate;		/* bits [20:16] */
>   	u8 sdhc_idelay_val;		/* bits [4:0] */
> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>   	if (phy->mode == MMC_TIMING_MMC_HS200)
>   		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>   
> +	if (phy->sdhc_extended_rd_mode &&
> +	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52))
> +		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
> +	else
> +		phy->cp_phony_dqs_timing = 0;
> +

Based on the register description, I would expect:
if (phy->sdhc_extended_rd_mode)
     phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
else
     phy->cp_phony_dqs_timing = 0;


