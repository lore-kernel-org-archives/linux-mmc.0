Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094A3BC67E;
	Wed, 25 Mar 2026 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435293; cv=fail; b=bJF83xsG4asUq1N1hLlxvpqE4RIB26KQP09vmwTHWOm5uuZh9Nvvae2zgPdj8Vhsk6W4oiPGyB4tlOpJykklA6/FEIhsEcXeggwhssdU1YmniqSJfiuwuveCnwpnUfRL7RRIKgvZyDRQNzIiHbngXgcHYmjgEhPdfdNXhvryCn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435293; c=relaxed/simple;
	bh=5Jm+ESKJun0etaD5UvzfwjvyYXcqsk2zJiUKDIQ7DX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JfssVJMnpAGQysvu3LpBiyCSLVvoy9tembKp69vyki9qvbp5TbsahWITAmStsOWkIpNoWsrDVgRteaYwMaWCsU7+s3WrJcoDuPUOQYoxjjyJZ1bivXukDmnJKZhtx+ckDx118Y3NsguD6dU2I5FI1oL2/6bjPCkGE5V+RjPULn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E2faberv; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E2faberv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySUtnyGYeT2Sj5MPFjj+SBxZCU8zCP13Z4Eumq24XaWX3PrsFfWAzq7btv6nAojpDJIFsQQTIo3wcFeAlC6m12UfXGtiDE3xzaVQvh17w9+EWfmCyecdzaFm98sFMxJ7mYeDzvrLFdDDUOqOd+hiSc79AMVUsENlQd8nrwvLjmYE/HQWVrTB0AobT8DebAOzmlIcExhQyQnkOi6/lecEG4YjlZzVlUkdOv/0ifpoOvj3MGpZBVjEXw8PYfPd+ocBXFT8TjEzmKR/3bQf4dQc14Sib0w2CmgAeozjCXRjpZVPT27275ep3jIQ7v6nvO5hxzVGOTd/CN5g/RAJeFlFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM5YnSTNaJaDLLiESBUjgCSQKvYIh5/Eeu5Jsf4d0ys=;
 b=sXU7rJbrFO4epEn1hw+NgHIAtvYxbl0zgKAO8CFxuhkRLsLo0LBTo2Yi7G3zu9fK1iwda/uPX3EbyCsewHmIyfD44rJ4q6VEY42jERafVs3/Hrl8EWo8JMj4VEOGDO4Pho0nW217lOA14WP/GwOLy3Mzr2H+rJV75fHDihykDbQudOFQm79y8MZ7LSk798ArzPDhZy7RoSJ32jca+pbkPJHQ4mB/7ml4L4S1LldhwSxDt+2n63UZ7r4J0qKwauk9s1gt+ox03qQ80tvEDAhHu3Q/Mn4eYctW5bYa76PU1d/7lSW2hukOC4bOaUY7aTVaWIZOzoQSu0CHZhO7nkXSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM5YnSTNaJaDLLiESBUjgCSQKvYIh5/Eeu5Jsf4d0ys=;
 b=E2fabervEFf89TkxkTJ6LIinFzpitfQZ7ZDD04vsGhR8Y301Iz0api4x4k6EH5rkS96rr1+mjHmgdSUQBshS7XheZo/PvQzJfgqJ3yPDMM8wVvpRCeUVo0e4SJVNkYBqF2N+SvnrAbsRMazD0y3qF5fTqqS4tSjVkBwdCezliz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:41:29 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:41:29 +0000
Message-ID: <5be09eae-0287-4746-a2cf-4050fa719f64@amd.com>
Date: Wed, 25 Mar 2026 16:11:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map
 infrastructure
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, "Simek, Michal"
 <michal.simek@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1774341736-229127-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <1774341736-229127-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::11) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3426756a-b887-4a3a-caff-08de8a5b1253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	REbLKrFu2Eplt4ZcfDbtaIfQYLRONUq3FqfRBRi717iWjwbMVH6hbfOyNZRd+gPNm7ShJnl/3M8ybxJERf3j+9oPppz41HaLdMuAea1zKvPXNtEwNVJctslpzZSdAPIFgHHN7t9Bk/GQVJ1LHRDLsdFkAqgH36Mev7Qj960LIva9hZ3wfPSC6iR8iYP146EllKLBk+jwAnjRruU5GZg7mALruRggJrIyw2qTZ5GvaMvWYeYipvTOnOXb1ON2cghJqE+BXTxOAdLq0xosbaGaQw54NcV7f+cMEI7tPXXVajAcoeOBA/K/iQAAeFdS+2V6TsLEf3DP2ANekR0miV8J4JjiyatLEVOwZSym1QU3/qZx5t7Q1YemDV9hqHCkeXdLFe/57dBFbKAcgyRZiJsoAGzz2xLRdJ0+t7VgsVK/c1sMJsuO/Ib5cYaX7yS1jdQ14iEehO2lM2zPF6VmGkBavKX//IPUFiBoMmmDg2Xm0rMfNmjYkTwGWUkHXM4jHOO2O2OZhOd7IHjViHZJTkmWHa6RDidSiJOTGFn+ttzRdX9N9h5rfRUiHISNJEVLQ8p6qowe6vAtcvMb+q1RlELSkvsqYSpGiQ729yssO9fbkwOWdj7y8+lF1J3MBA1MLEqgDmzGEaehN0+mnFwCTOSeRR2LL39bSeRI3g1TsjbSKM9r5z1XV6ZJ1f3Rs4OXbSCYt4jWmdirC9amRq9abn2ZLLeMsdyU1UK0pdas8N5z6dA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDRxdE1WdGJjWTI3M0ZQQnR4QnBGVVhGNHRGcUlPWXBXUUdsTmpRRVNDNG9s?=
 =?utf-8?B?M0JnQjZXUVBDR0JUTy9XTlVQN2dxdlFwTVVFT3E5aXd1Z2Z2SXc4NVpaYW5K?=
 =?utf-8?B?a3RiNTI2WmNKbkswbWwyNEFmcDNoZnVTZlNOUTBYeWlZZWlYNlVDNkpDQjJh?=
 =?utf-8?B?YkZtSjRBeEZ5M2lhazBBaTFEbXVYRWFLY25KU0FKaCszUVBLRmNPNzRBSXZk?=
 =?utf-8?B?K1dOQmxCQzl6M0srYlFpcENScy8wNTBlZnJSVzFxRXdiMmtrVnV0TnZranNl?=
 =?utf-8?B?TkF3TzdidHlVNzZscEd4S1ZsdXVBM2M4SnNHTE5TcWEzdmVHdVpqTWJpSTZ5?=
 =?utf-8?B?aldZODdhL3Azb1dRV1hxMitUZkpUTjk0dXQwNnR3elNHMGJ0aFgwd1JLSDVN?=
 =?utf-8?B?cXpSNmJHL2RJb0d5bHZ1NCtINndiT2ZHaEo3dkFHVjQwOXF4ZGFCTjFyNWdo?=
 =?utf-8?B?NW9qSHQzeW16SEpQTHhnNDJwbVEzc21VUWtxNTBDc3EybjRjY1Q1MW95cW90?=
 =?utf-8?B?RWxGcDc4Z3R1WTE2c0xVTTNWNXBBdFhBV3JHTDRJMFRaMVovSHd3L3J0S0Jo?=
 =?utf-8?B?ZER4eGY3UnUvby9COVZXUEpIOTE2MGl3ZGdKanhBemJFVU90YnNrenFxYktW?=
 =?utf-8?B?Qkg1Qm5UcUZDS0VRVFBVNWduNEN0TW1Tb253VVVzNDlZMTB0NmFGY1pMQ0Nn?=
 =?utf-8?B?WFpnTGUvUmhmaW5OUGdFbWlKSDVmd3cvWWN1M2NwaVdFMlBmUjdkUWdMTTJl?=
 =?utf-8?B?L3VxZHU3SStsUktvS1RWZHVmVmpxM2grWGpqUEZwTHJ1eE5mcWsrM25hOHo5?=
 =?utf-8?B?ckxKbXgxZjArckoxaUNmSUtZS1Fnc3EySVpBNll4UG5Jck41WW9ZMGJ0SG4x?=
 =?utf-8?B?a3VSNWxwNk52SzFXVGlFeTVFMWdjbUhkTkVEa21TTFpweHJOVDRTNkhyVlBX?=
 =?utf-8?B?ODlPdUt0ZXZYSXhYL1VYZkxNb2hKMnhNdVEwTzhaM2lzQ1lEWkV5S2NrNVNT?=
 =?utf-8?B?cWpNL0xZdkh0QUpzVWtteGtkZUdqQ1RqTUdqUHJzTWJjN0ZTdFBSaUxaZ2lC?=
 =?utf-8?B?aTEraDUwL28zOWczWldwRDdHUTNMTlhINU8zSDJ0a2tBSFBjdGhkYnMzb3V0?=
 =?utf-8?B?UXFCQk1zMHFZQXBkRFdrZDdiakYxZ0lCN2taVndjT25Ydm95bUdYTlJIZE5y?=
 =?utf-8?B?Y3k3VjBBd3BmTC8rbjV1cjhQUFg3ZE01MmM2U0hQSktRcnJRRWV2VSsrM0Er?=
 =?utf-8?B?T3V6WEdjaG5GbVVqMHFDc0FrbUFBL2NLc3Q1NVJaSWJUekZEaDFOWDdLZDRT?=
 =?utf-8?B?TVI2UnYybzZ3Qm9tYkdTLzV0bUxWeXdPaEJ4eFZVTmFXeCtGbHUwMVJTTW40?=
 =?utf-8?B?ODJwY3FUSlliWVliUUxUMU0xMzd0Vzh2UDVKaXZZSTJVMXMrRGpwbnRYNXFj?=
 =?utf-8?B?dDRpeGVnK21VK2tLR2k3cy9OTTdzV3pFR2dVbWNNZzhaUkxmdGlPM1JmWU5E?=
 =?utf-8?B?WUJpdnNLOU02UkRVZmJMYk0yektHS3RsTzhHZ21raGFsbEFTbk9MK1p6MTE0?=
 =?utf-8?B?RVRmQzRzSWE2V1k3clU2ZUJLc2VoREdDNjgvc1o3WUdzc0ZFVjV2OU9VTkVE?=
 =?utf-8?B?bjBTTVhOQmJmelpOT1c4dUxuS3hkeisrMTRsMWdkampSTVM2SXlUdUVEaE9s?=
 =?utf-8?B?WU13cDhaUEV2YThzTVV2UHRXeE0zTFpGUGZVNHRFTDJpVDJVOFBUWkFHYi8v?=
 =?utf-8?B?TWQyblRSQ3lPc2sxYlM1MFVOR2g5TmJRV3gzUVJtdGF2U1pDbmROSGF0NFda?=
 =?utf-8?B?ZXllc0tQV0paKzNZTDlJVFNJcjQzUDY1RHMyZ3Y3NVVWUExpdkNXNy81NlFq?=
 =?utf-8?B?eGZwdTlWZG9UUTQzOWpLREh3TmRYelUreDZLMFE4TXhCUUdncEltR0s4dWFS?=
 =?utf-8?B?bXFIMVFiZzZPL2NjSGI5dGh3eEltNGhVc0YvYklqOGJWLy9BWjVIKzY0akJB?=
 =?utf-8?B?ZGRsdFVDVXJvazBHNmltdFFiOHJQc0VZOGV6Rm1nYklGVkhvUmxLeGdKc05p?=
 =?utf-8?B?YU9RbEN0L2RIWEp6OFZMSkcvSVVqenJSU2M4aTN1ZThQSHNlL2g3bmk2RGZa?=
 =?utf-8?B?SXVzQWNwdE9jSklpeE55L3VvMWtmbjBXd0U2cXI4anUycitVS3VkM1dWTm5j?=
 =?utf-8?B?U25YK0ZVQWh4T3hkYkEzUGwwOGVSS0dIVmFjNzVPTHRveFFQM25Cc0xEWlpv?=
 =?utf-8?B?cGFrUStReVZQM0ZCdy9PUEVzNC8wMGFkQ2tCcklzQi9ObEd3N0NScjNudlBQ?=
 =?utf-8?B?ZTNrQnVEakttNGwwbmZtMjhESnkyRkh2dkJHS2dSU0puYnplVkw4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3426756a-b887-4a3a-caff-08de8a5b1253
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:41:29.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCcDEOXaTzTqHBnru9rXBJqpQy6k9yLBb9TVniTll2cfuI/TLOSqOBKdf5lo3joIFLjqQaZrRplZVzDgB2nNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463



> -----Original Message-----
> From: Shawn Lin <shawn.lin@rock-chips.com>
> Sent: Tuesday, March 24, 2026 2:12 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> Simek, Michal <michal.simek@amd.com>; linux-kernel@vger.kernel.org;
> Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Shawn Lin
> <shawn.lin@rock-chips.com>
> Subject: [PATCH v2] mmc: sdhci-of-arasan: Use standard
> mmc_clk_phase_map infrastructure
> 
> Convert the Arasan SDHCI driver to use the mainline standard
> mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
> arrays as well as arasan_dt_read_clk_phase().
> 
> The phase values for ZynqMP, Versal, and Versal-NET platforms are still
> initialized from the predefined tables.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Regards
Sai Krishna

> ---
> 
> Changes in v2:
> - remove check in sdhci_arasan_set_clk_delays() (Sai Krishna Potthuri)
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 73 +++++++-------------------------------
>  1 file changed, 12 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-
> arasan.c
> index caf9723..785d3ac 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
>   * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
>   * @sampleclk:		Pointer to normal 'struct clock' for sampleclk_hw.
> - * @clk_phase_in:	Array of Input Clock Phase Delays for all speed modes
> - * @clk_phase_out:	Array of Output Clock Phase Delays for all speed
> modes
> + * @phase_map:		Struct for mmc_clk_phase_map provided.
>   * @set_clk_delays:	Function pointer for setting Clock Delays
>   * @clk_of_data:	Platform specific runtime clock data storage pointer
>   */
> @@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
>  	struct clk      *sdcardclk;
>  	struct clk_hw	sampleclk_hw;
>  	struct clk      *sampleclk;
> -	int		clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
> -	int		clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> +	struct mmc_clk_phase_map phase_map;
>  	void		(*set_clk_delays)(struct sdhci_host *host);
>  	void		*clk_of_data;
>  };
> @@ -1249,36 +1247,9 @@ static void sdhci_arasan_set_clk_delays(struct
> sdhci_host *host)
>  	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
> 
>  	clk_set_phase(clk_data->sampleclk,
> -		      clk_data->clk_phase_in[host->timing]);
> +		      clk_data->phase_map.phase[host->timing].in_deg);
>  	clk_set_phase(clk_data->sdcardclk,
> -		      clk_data->clk_phase_out[host->timing]);
> -}
> -
> -static void arasan_dt_read_clk_phase(struct device *dev,
> -				     struct sdhci_arasan_clk_data *clk_data,
> -				     unsigned int timing, const char *prop)
> -{
> -	struct device_node *np = dev->of_node;
> -
> -	u32 clk_phase[2] = {0};
> -	int ret;
> -
> -	/*
> -	 * Read Tap Delay values from DT, if the DT does not contain the
> -	 * Tap Values then use the pre-defined values.
> -	 */
> -	ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
> -						  2, 0);
> -	if (ret < 0) {
> -		dev_dbg(dev, "Using predefined clock phase for %s = %d
> %d\n",
> -			prop, clk_data->clk_phase_in[timing],
> -			clk_data->clk_phase_out[timing]);
> -		return;
> -	}
> -
> -	/* The values read are Input and Output Clock Delays in order */
> -	clk_data->clk_phase_in[timing] = clk_phase[0];
> -	clk_data->clk_phase_out[timing] = clk_phase[1];
> +		      clk_data->phase_map.phase[host->timing].out_deg);
>  }
> 
>  /**
> @@ -1315,8 +1286,8 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
>  		}
> 
>  		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
> -			clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg =
> zynqmp_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg =
> zynqmp_oclk_phase[i];
>  		}
>  	}
> 
> @@ -1327,8 +1298,8 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
>  			VERSAL_OCLK_PHASE;
> 
>  		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = versal_iclk_phase[i];
> -			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg =
> versal_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg =
> versal_oclk_phase[i];
>  		}
>  	}
>  	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
> @@ -1338,32 +1309,12 @@ static void arasan_dt_parse_clk_phases(struct
> device *dev,
>  			VERSAL_NET_EMMC_OCLK_PHASE;
> 
>  		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
> -			clk_data->clk_phase_out[i] =
> versal_net_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg =
> versal_net_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg =
> versal_net_oclk_phase[i];
>  		}
>  	}
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
> -				 "clk-phase-legacy");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> -				 "clk-phase-mmc-hs");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
> -				 "clk-phase-sd-hs");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
> -				 "clk-phase-uhs-sdr12");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
> -				 "clk-phase-uhs-sdr25");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
> -				 "clk-phase-uhs-sdr50");
> -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_UHS_SDR104,
> -				 "clk-phase-uhs-sdr104");
> -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_UHS_DDR50,
> -				 "clk-phase-uhs-ddr50");
> -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_DDR52,
> -				 "clk-phase-mmc-ddr52");
> -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_HS200,
> -				 "clk-phase-mmc-hs200");
> -	arasan_dt_read_clk_phase(dev, clk_data,
> MMC_TIMING_MMC_HS400,
> -				 "clk-phase-mmc-hs400");
> +
> +	mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
>  }
> 
>  static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
> --
> 2.7.4

