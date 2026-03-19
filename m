Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAB370D51;
	Thu, 19 Mar 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914955; cv=fail; b=q5zqG1ugX6QZ9QMV7E99iNqZAb43Zg43qhJWTs+FKCzfxBpLyaOZ2TgauKxEKJ/UDk1dl43WcdUZF/wV58DTMMdEfwKB7En/1jlRQpAyiHx5i4XRPz0bYwe8tljFc3q3TnRGFfxFxZQcp63c2UBfCDFvAAwIuMbp+aHbUNR+1XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914955; c=relaxed/simple;
	bh=KzUB+TVbrZ6u+DEhw+6sz0slwCiNILolghxFpqbjFnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NruYATP+yKwJDEtUdMwkndSm8dh/f9FZj5tlDAgCM74ihV2rXb4NG8BO2xnfcvAdAaSvaqt0EdwbCn74pdUkq0QvOnRc1EoBaDkQJtshEED5XblAFhcZkHQTMf/1+LUXI4491BfI/5VBWzxoxrBK8aWHbAR5+IBi9CEQLoS7XKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8S8A5+I; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8S8A5+I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ1I5WwcPY0DDfngXs/kVFXJpQkQ7tycTF3w3u7xW2Vr5JieMSBgGMVkM4WiDHNj5tBTVv84C86i4ZFZM8EcTqVvZQlz7ZuClVBfkRE2FxL7Q9aClS1Dl31N+MT2rooxVyqsWqLgQKpC1iSll8zey8twZ6O8yJ8DyL6T5spdC3UPRgVaSwKDUOnWGkq2jJAjIhHXIFrmG+rGl+uKVr5i3vcULyZlVvME1lHa+3L4fa/0jglVHrs0pDzyMMRUkU+wit3uMA1HWRRKoKa+YmQMoLp1A8sQeJpg4GLoqoMLwtEiyOCim7Y9e00jUt32OrjSetiKL1peczE0aIez8a12zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnnWhYWVERpSKyDgFpdedevyuK8lATIDOgw0SsBwqkY=;
 b=Y4LlGaQG28NTBWG0D1MJ7nit6iy+2gopHRUPfy1dTlUUOeBydsxHp9JQCoFr1TnGTpmz4kOD9ik1w11OxHALz5Zfp9cKFVs0v43q7Ez8A9iZXf8NhALdQ5tvD3hO5OouIORi9MhOChT2uCTBfB1Jeq4D5zP/e7AZX/itj0MO5URs+Z8Zrb60M9Ff0sLN99D6g5+xuEDqvD0AfgoZecsXeEGVHqlhoQr8OkzXMzC2m03w9YFz2mPpc6M1yZGLz5bLE1UX2uqEBeASzfxeAXtgnHowDRGfgy+vmv90Bym266y+62DKbaReXhs+Y6molMwsPA5XpC88umRd3LWS0H7Hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnnWhYWVERpSKyDgFpdedevyuK8lATIDOgw0SsBwqkY=;
 b=Y8S8A5+Iyc4ApAmZMbb5bA/2YaEYZ5fWc+D8c6Mtqncqj7NEHPLJj7mV3IpL3wVqZ5sqE/rqy4ylz4Cb/DES6V8BgTv2Zua1gZQiHdYqqt65n5j9oCvdr+Kmpeqfwwe8/lA8sD1XjUs3FXMkjxlGNrwEINXSwY408eNsX4o9/JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 10:09:10 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 10:09:10 +0000
Message-ID: <dbeaa75f-7ba3-4dfe-b4e6-1395ea699d65@amd.com>
Date: Thu, 19 Mar 2026 11:09:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map
 infrastructure
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org
References: <1773713843-118137-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <1773713843-118137-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 691d8a45-34c9-4932-95ec-08de859f9060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	hGDr7sxAwzbCo/rcUFHVep97zyELiGcRD3YijEfbiK8KVW3mXduZWrFywDDVYVmB3mmImGOJSsm8Zq2+Vsj0lld1bTVa8Q+qhtmOs8VKdHu6/20M2JciOeTkOAs/1VJpvqZURC21lqLamMxy9laJwVg32+eZuncx8vSilj4WgLsqXR4JFACvq8gArSxjrZXZHFodoiO2LnWK+nxNrLIyI+fNGuRgNZgMLr3fMxxKVxqy2QWTOJDhAZhDhWrY5kevgwyKdAj2YPE5Pnar0mjSbwjVxn7f7TF9MSnb/Nwj7h4VrlVgSdO4Dj0W7O5mQZZrvR2XYq961qMtiMmlwdVUe445zKB8wMv6wM5wPUtsDpo4p6p3njYAzC0QP6L4ILjqg5uy/4CgDT6Xs9xoHRDhJ4f4gGt2fF0bHWSSwus6reJjE2HGixJ5vyVXTMlIP/dhSB+RVeI32miwsL5jB5KUNttzv4QPK04KMrlfR6XHktj8raBcA3ht66v/bK3kTBS3n/IfZATRMduHcM+MGmZlYA4tw0+piHDE/F7eA7VBoRYsfzW119iuxK7y6yOj2orlgA7dGurTsP9XmGsIu/J1SeRoKI8Ngd6fn9vqucC2MjjuRlk9hz0a2l5DR/AkJm6ZGuekg7hHIXd0yydgj+rikMRkT51GoaYenOP1amWDU74Wck5hCSNns6qBIviaydFNZ9ZT5isoF9boow3C+cn5qtmOQX4kgMt2JmBtzKzgmSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2RsUmREYnZtY2liVFNkR0NucW1MeEpvV3JuWTVzbEpIeVpyemxZOW43aXZV?=
 =?utf-8?B?TERMZFVuQS9nSFJ5RHB3a1FaSmVPdUV4dTZRSUlndXpGN2NIUC84czdZUDZy?=
 =?utf-8?B?WmxqZjU2QUo1cTJwRENwK3llVzNleU12UnJCbFl6b3dLYjErWEh4dVNxWWlP?=
 =?utf-8?B?RVFWQThOOG1HK2VwSTgwMzJVdFRLd3ZTS25UMmJZYWFwWEIzZ1o1MHpxS0VB?=
 =?utf-8?B?V1dXWFByTWlwc1VyWTFsMkRlUlExUDRyNTlrd0tiT0cyWGhJS0U5RWh5N0Jv?=
 =?utf-8?B?VnZBUWpQSmF5K0NzMzlZbDlQM3NSa3FEem5YVkNwc0NYRWwrdEs4a1RUSEpW?=
 =?utf-8?B?MTBEbExKS3BOcndwRzNwUGhvdGs5SnlFTDlmT1p6VmxNQjlubDhuZVV3L1pz?=
 =?utf-8?B?ZW52bmJnQW10MC9DU1dvL0ZDY0tnc3hjTjdXSjZpTEVFblNnYTRIMHVJajhD?=
 =?utf-8?B?N09qc01saEJ3aUF1dHpsUWVSMnhYd2xMelNRSVpFNld3TnNxUEpXcnNJTTZI?=
 =?utf-8?B?SnhlZVFFODNXQngzamM5elJBcGFraFhkVEYwcGRLU1VYREphODJxeER4TmFP?=
 =?utf-8?B?Zk80c3EySlNPS3Z6QmZncnI5dzV5K1JTL29zamU2TEJqbVpCRUk0UDMyZmwv?=
 =?utf-8?B?bC8wWkIwWmsycEg5REk3YmFLSjhPMkUzK2JUZGZoNFlLWUl0V1phUkl4MHJp?=
 =?utf-8?B?bll1MUk5L1FhcFZiZmc3UnJBTjNqMTNQamxvNU5hV2JBZHRrUjdjemZXdE5k?=
 =?utf-8?B?RlhQSktucmRJV25uTUhTSDFBemxsM2NJcVdOdVQzWTFBZ3FoRnpBSUpCc2Vm?=
 =?utf-8?B?aDRpa2FtZHdYWEx1RXhIUmZvbTJsZmdxMUFSeWF3dU9VNGlhM0pOeUtBWEdN?=
 =?utf-8?B?aFNRZFlJdGxLU1NBQndWL1FtSkllS25NZzhNREp5RUpDT05vUyt0SUQ4WFFw?=
 =?utf-8?B?dFUvTmdVcUhJckV3Wjl4WjVRYU9taXNXTnVYYUc4QUFMK3VEeE5PZDFuS0tB?=
 =?utf-8?B?YmxTVDRxdFBXcTJjQldXcDlOSXViSG5FQnNMZEhWQy9sTW1rRS9LZTE5U1hK?=
 =?utf-8?B?Tms2dy9qaTlMTk9kVEo5SzlPUkdtNUtwSEFTRldRYkZMOHRwSUt5cGduQkhN?=
 =?utf-8?B?eEZjVjdTa05maUJmOGo5K2lMWHJOK1RXNUFFaGNVNFp2eGFuaXk2SEg1Qi96?=
 =?utf-8?B?YU1XWXloRE4yaVZwYVA0UnhGY25rRnZnNDF3WmNhZjlSVWJGaGcraGM1bWxl?=
 =?utf-8?B?Uk5LVW80VE91RW5FVlk2YXhZbWR2Mm9lZFdwUjVGd1diU3QyMVE1bEpZZmVC?=
 =?utf-8?B?UlZKbmI5dUpOU2YvOXhJOXVSNWxnWm1rZEcyLzJONXBETVVhMzJzUkxBWk0r?=
 =?utf-8?B?Y0syV3JFd3dJbWY4QTMwazI1Qm93UElHY1U3WXBaQTVzbGwzRXpVdERKQSth?=
 =?utf-8?B?ZThSeTFXWk5sdWxLVW1rN0lBTktHTy9uSzRPTElpYVl5WFRndjYyK21IQUlF?=
 =?utf-8?B?VHRXREtOTGkyUTJWOUcvNGlYbjhTeUUvWUFYelJTS3VFVUoxck91c0FlVDl4?=
 =?utf-8?B?cUYrS1BiQTBDOURuMjNPZG4zV3p1anlvbEdRZXVpcFluTEY2WGpWNlpqaThi?=
 =?utf-8?B?YXdNMFRhYnlSSFNWWUdSVVZEVHhybVhHODRSeU5pNU1zYXMxcEhUbTlVNXd1?=
 =?utf-8?B?LzhGOUVxSUhZZkQ3clBEamJydHJWRmRteGVzbFhDVUU2TnB4ODlVZmtiZTBJ?=
 =?utf-8?B?MHB5OXhnaHAvUXJ4ZG9qVTQ1Y05ibllzZExybjFJbGIyaHdQbzJHeVY3Umtt?=
 =?utf-8?B?dmFEcXRZMldlcTFhTzZzSmh4T3R6NjB4RlNLMUFTenhKbmI2QVlvRHhJMXZo?=
 =?utf-8?B?a05YTEFUT3RIcGprR3YycmxhMVA0VkdCdVVUM3JQQXpyZ1RodWlUS0JZM3F6?=
 =?utf-8?B?T0JCeElSY2F3bjVHYlB5MEkxVm56aXlYM0k2U0ZKVTNLL0QxNlptTXpuYm5s?=
 =?utf-8?B?dmpOQ0lqUGFZMFR2dExTRnB5ZDdMRmxpeTNCZFZ3MVN2RVVCbjFKSm9IcGN1?=
 =?utf-8?B?MkpGL0w4RmhXcW9xd2ZIejBpSWN2enpnY0hMMzRlcUpLL044T1ZxZ3RyV2Jn?=
 =?utf-8?B?eW1FbFJOTmZ4WUgxSkVLR3p1Y1FuQUNrWWJvQVVhS281ZnhYbjZiRmx1VWlo?=
 =?utf-8?B?alFqNlJETFJOQ05TUFErLzF0NlQxNGMrYUU3Mkd3ZnpMcWdWTGNWaVB5L3o5?=
 =?utf-8?B?Rm96dnVQMEU0dk1oVmxqS09wemZkSS9jeTBPNnBPeXZtcE1ybTJseTgxb2lU?=
 =?utf-8?B?MGl2Z3lWa0VXbXV1TmNVK0I2aHRBMTRuVlhqQlI4cXNhT3ZjZDZWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d8a45-34c9-4932-95ec-08de859f9060
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:09:10.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2itOjS7cowyZ8WgkURYuNCepwzbX0ji2Kb0gWTzTHLe1Ac+uTjXZ97wM/MANk176
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

+Sai,

On 3/17/26 03:17, Shawn Lin wrote:
> Convert the Arasan SDHCI driver to use the mainline standard
> mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
> arrays as well as arasan_dt_read_clk_phase().
> 
> The phase values for ZynqMP, Versal, and Versal-NET platforms are
> still initialized from the predefined tables, but now follow the
> standard phase_map format with valid flag.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/mmc/host/sdhci-of-arasan.c | 79 +++++++++-----------------------------
>   1 file changed, 18 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index caf9723..b97d27c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
>    * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
>    * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
>    * @sampleclk:		Pointer to normal 'struct clock' for sampleclk_hw.
> - * @clk_phase_in:	Array of Input Clock Phase Delays for all speed modes
> - * @clk_phase_out:	Array of Output Clock Phase Delays for all speed modes
> + * @phase_map:		Struct for mmc_clk_phase_map provided.
>    * @set_clk_delays:	Function pointer for setting Clock Delays
>    * @clk_of_data:	Platform specific runtime clock data storage pointer
>    */
> @@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
>   	struct clk      *sdcardclk;
>   	struct clk_hw	sampleclk_hw;
>   	struct clk      *sampleclk;
> -	int		clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
> -	int		clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> +	struct mmc_clk_phase_map phase_map;
>   	void		(*set_clk_delays)(struct sdhci_host *host);
>   	void		*clk_of_data;
>   };
> @@ -1248,37 +1246,13 @@ static void sdhci_arasan_set_clk_delays(struct sdhci_host *host)
>   	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>   	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
>   
> -	clk_set_phase(clk_data->sampleclk,
> -		      clk_data->clk_phase_in[host->timing]);
> -	clk_set_phase(clk_data->sdcardclk,
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
> -		dev_dbg(dev, "Using predefined clock phase for %s = %d %d\n",
> -			prop, clk_data->clk_phase_in[timing],
> -			clk_data->clk_phase_out[timing]);
> +	if (!clk_data->phase_map.phase[host->timing].valid)
>   		return;
> -	}
>   
> -	/* The values read are Input and Output Clock Delays in order */
> -	clk_data->clk_phase_in[timing] = clk_phase[0];
> -	clk_data->clk_phase_out[timing] = clk_phase[1];
> +	clk_set_phase(clk_data->sampleclk,
> +		      clk_data->phase_map.phase[host->timing].in_deg);
> +	clk_set_phase(clk_data->sdcardclk,
> +		      clk_data->phase_map.phase[host->timing].out_deg);
>   }
>   
>   /**
> @@ -1315,8 +1289,9 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>   		}
>   
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
> -			clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg = zynqmp_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg = zynqmp_oclk_phase[i];
> +			clk_data->phase_map.phase[i].valid = true;
>   		}
>   	}
>   
> @@ -1327,8 +1302,9 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>   			VERSAL_OCLK_PHASE;
>   
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = versal_iclk_phase[i];
> -			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg = versal_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg = versal_oclk_phase[i];
> +			clk_data->phase_map.phase[i].valid = true;
>   		}
>   	}
>   	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
> @@ -1338,32 +1314,13 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>   			VERSAL_NET_EMMC_OCLK_PHASE;
>   
>   		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
> -			clk_data->clk_phase_out[i] = versal_net_oclk_phase[i];
> +			clk_data->phase_map.phase[i].in_deg = versal_net_iclk_phase[i];
> +			clk_data->phase_map.phase[i].out_deg = versal_net_oclk_phase[i];
> +			clk_data->phase_map.phase[i].valid = true;
>   		}
>   	}
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
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR104,
> -				 "clk-phase-uhs-sdr104");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_DDR50,
> -				 "clk-phase-uhs-ddr50");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_DDR52,
> -				 "clk-phase-mmc-ddr52");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS200,
> -				 "clk-phase-mmc-hs200");
> -	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS400,
> -				 "clk-phase-mmc-hs400");
> +
> +	mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
>   }
>   
>   static const struct sdhci_pltfm_data sdhci_arasan_pdata = {

please take a look at this patch.
I was talking to him yesterday and he needs to finish two things before he has 
time to look at it. That's why please give him some time.

Thanks,
Michal

