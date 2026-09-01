Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28449DB8D;
	Tue,  1 Sep 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287553; cv=fail; b=V3THTyjw95kO0dnxCYdq40U84xIZn7xH+sbdgDSYPVcnbZadBMQBC35hAAsddtXarRJyaFa78eZTWM6caUcrKtJydZ9AKGGRLyCPCc/9IyFyPYlKqVUeoKhUkybWXmR6Uw+q/qiN1sl320ki51borViTkhPb0Ai55ncXFj9KANc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287553; c=relaxed/simple;
	bh=2NpHF08y2phTW1NJ8N/HIEbLhz/VIoOHzUdAucJnYrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZgf6a1E/5h8BLPjbhQfg5xxamY3E29g/o6vRUlqljev+IErRAzKout5O6v3Omx+eOEIotNdD9l4etvmobWpRnPlhVFd1Y95ncfPLNA2eZ4ec3sgdeXTZQK4odekSbTmqUiZGapMXtdMZYzvmvNL4x2R61y9E+UnKq5JAcWeJnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LQj8MvNn; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LQj8MvNn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqwu5ysBpymhB4iaAkmNxlmfqjxbE7SDVN4PB4zbJ6d3ROgMSPvZhOtmtrtfp2E9GtEqphgD3N0Jyl9yXPFOKj2rgNuEjs/kpkEHBqzaQH9x5eoT6FZdYHXIXsHdNQooObbxtd0C5nWG6PHShoe07sU4kop/PAEGd2uTngQ945JCx3DwAqhcetngP+FEsj4UKwXfdxSOgQIXfC0tqA/9CVUbgbBLurt+HeecIOAdqLfgtyEYxNGDSpz/RSkvpUtR1q+1fVpmltqDJXHq6AoJgyNoAsYCa5opTPjNzdZLoUDgUVlmAskunpWjKnYHO0kOnUTEpEOD4QYJqxACLMmbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUQLt+k2PYK5PljI2vlh7GvQgPRMrkUCk5EUROUNO0U=;
 b=SgYIBTUqtrCLCuWUTb9NH/ZdStAqxDmgQY/noPWBYuDO6ERZDNvCoLWXxlPMaI6FgAYaylpb74Y9y4/3mgJpQbKjYab5gfVdijdtUcUvIG01mpoFb3tWwsOBTEvmUQjWa00lLMMMLSv3JE5yggWJPu83e/Kk+ZaNgtHegP/+C6rbO2qcXoJsRtuxtYh0xdvbKItuSvVqXnEGaHWn7PIJhY/ZIOmy5xP2KefazhrQmgbi3WM2LVu+aFpIdgDlfBbkjQBmWD4yJ+PNidIb4rVBpHyBRelHIulrs0zFEAt6FfqsBCiQvQVcubty9SxvazL78wBbRM/psM5PnsV+zep/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUQLt+k2PYK5PljI2vlh7GvQgPRMrkUCk5EUROUNO0U=;
 b=LQj8MvNnn0aa1PTtnC7M1IMS5cTnBzvvaIc4qc9wPOXb29b7ewxdBU6JyMzx4nZgE97MMyxt+s1V7rPyk/IHz/SR2Xh1Ka2SFuTbQBtPSMqLWXz2AiEwbl8MjosApT+gQqOufYdYRBSlzDm02nfeubMb6MSTKzxEmgIR4v3hSkijgCk4ENGvwfXiiehbioSYBnJF+2ncsHvGkErIooTtqzfix6a5tOMFVLFufy5AOBKuIJNyVbP87wa94kHfgcX23cjqDNjoF8xJpN5inY4lvLw1156DoCHuDkCeYP+4/rEnj8OTw2XOo9dHuBbHXAz2lS4MEG1ZoXZKecQYSxD8Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS2PR03MB8465.namprd03.prod.outlook.com (2603:10b6:8:32b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:32:30 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:32:30 +0000
Message-ID: <cebd7511-784e-40c8-a893-a7de4a56a147@altera.com>
Date: Wed, 2 Sep 2026 00:02:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] arm64: dts: agilex5: add SD/eMMC host controller
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dinguyen@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
 <20260829184252.27644-3-tanmay.kathpalia@altera.com>
 <apaQX_bHpEcP4Tp5@pengutronix.de>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <apaQX_bHpEcP4Tp5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS2PR03MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5a85fc-bd4a-42dd-55ea-08df08576156
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9hYWVuA8PjbTpTU4Dvp0jU8rnyhxL85h7C0raihJT2pbOnsgwefMQ4Rj/Ilu83Fcln7ZMR9G63c6oZ18vTdjq9lBeluiv1/VQV8XyEb68KPJoSgY+PsJKjuui0vrr3Z7C6VbzNrG/kYUqug6A/mrLGW9YzVBTOhf3qONftx4dML2f+z+pkikA2bt2VUJEZtPUqKPnRzlFTa1gNOZar3Snps1OkGWhXidvYcr/WKdxoOjL1QjOdNKU7l9sk4+BrutR+yQrDigHJ9i80LwwMwa6kZ44UcnYYvHseR493s2Cr1jqnenTkWTX43Zi2RyOcOach+GN+w4A/rwX2IpB4iHYSlRrizxG+1yL0huz2/WLgWfJ/N8q6iO7MfEZ8lsD2brcJP6fgoDH2/jko0m6GWJoLpXpvQnXPe4p58bp3nQXp4oqcUn03iiv4DK/+oR7okDEjrEiA033i9nEqflyE6SO5FCsIcw/6zW3orpnetstulck89pl86yfw8cCutxb13ziY+wSzHOC4e4c79UCS9KRqdOVBM9yovfr88oer6cnNO2w/g6HajxUCGWj7fqyutP3dmigV3leM8hsHRLQ9graNNQDwe2+3dNn7aWxI3qm8h0JNDBkoWu7H9SA2BFnBTUQjBVDLsWKhinS/mslnVpxHMZzUC/9JI/4KQ7EZ/57S8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21Yb0lIdEQzVVljZjhjQnlmaHYwMEo5dGg3My8xUXVzanpkSVVVTlpHbmhF?=
 =?utf-8?B?RnpmRU14OU1kRkJqU1ZXWGs2QThoMkxEZytTb0F6c2NMNlhkV04rSXBYVnp4?=
 =?utf-8?B?Q2M4b2kxNnAxczZmSmpiZVRKTUxjQTlRREJJVmpDeldxeHFjR0dMODBrd2R3?=
 =?utf-8?B?TnMzQWdQZ3M4eFJLU2ZjNlJTNjloOUR6TlY4aE96ekFSRTVRTWhPNlF3bVdh?=
 =?utf-8?B?alNKZkZiYytkbEg4YjNKYjFheitoVGpsK2Vlamh6dWVjV3lzMmVCYXlhRE9t?=
 =?utf-8?B?RmZRMHd1dU03V1hkZzZ5aGo2QnI5T3ZFRkRrWDNFYVFhZFkvN2gvcks2dDZ3?=
 =?utf-8?B?c29TRlRwVFMyQWhnV25FQkVOc3liNU43OEFmYng2YXFpYTEzbEZZcHNRR3dD?=
 =?utf-8?B?NzdNSFhSKzU1clVNajVmaUxnRU1OOGdHK0dFRUFEb0Z2cG16N2VWdTNjOXEx?=
 =?utf-8?B?aDBKWUxKN1VZemlPNXg0b3l1dG1keHJBSXNVd3hhN0VJZGdTNlp0dU9LRWd4?=
 =?utf-8?B?QlpBaUxFSDczeHlmK3lIK204NU5pdXNXVGdVUWVYS0wwNG5NZW9FalovMkNG?=
 =?utf-8?B?ZFlCVWgxRUNBQXEyNy9WMUVuQ1l1VURXQ3RFZmU2QWYvQXBDTFpRWVZSZytn?=
 =?utf-8?B?Rm10ZUlJbU9Fa0RHbVJCQUU1c1VJQldQdFZ0KzNNaUdjbktHdDJxUFhIUTV0?=
 =?utf-8?B?aExBZUVLOXlwZUpTM0d0cURCNGhaVlFKVmZZRnlTQnZRNlRwYU53NnczWDNP?=
 =?utf-8?B?Zjk5Zjg5TmZOYUNDbEZXbkdXdlUwQTVQclBrR1JhV2ZXanNPM3VIVjJIcThN?=
 =?utf-8?B?Zkw2MjJGNUp0blFCS3d5S2hCZzZWN1JQZUxCVnIvN2I5ZlRnOTFYYjhMcTJw?=
 =?utf-8?B?UkRWd0xJRzQ1bjZOTmp3RG5XdU1rYUdWQWNhVGhDUTVaa0h2OU1jTjQwc1BC?=
 =?utf-8?B?NUdjc3pwMlZMb2RSRTB0dW5NUE1pVkRKNzZaOVRFTWxma1h3RmZ1Vy9wdTJ6?=
 =?utf-8?B?MGhMejM2NlRwaGlZYlVrYkF0emJqQnhKRUNYbC9RM2J2Sko3dUFDUkZBRnJD?=
 =?utf-8?B?ZHdSTU1kV0h4L3plZXlBMWV6bkMrLzdGb2dodk5rMTZkMjRqNGljUVNkNzJS?=
 =?utf-8?B?QUZraXNhODFTREQ4OG1QNTdVcHlNelhvWTRoeUQwM2xCUmZCSk5KOFhUUDdp?=
 =?utf-8?B?enpBdnpjTlltd3k4N3JHRjhvbUFZQmk3bkpPRkVqOGZaRFU5ajY2UE9jclpk?=
 =?utf-8?B?RG4rMTdWSDRlUmIxNHMwejJpUHB5aDdlRlZCRGxrSEhZVHpnTjB5N21KVVFT?=
 =?utf-8?B?UkZ3KzVQRlZsUTBJOURwK1cycEZjTnZra0RMdHJOWkkzMVZOT0p1MitLeUtT?=
 =?utf-8?B?UVFIc1JTN1BHaXZKcDdvSFVFamxRMDcvM1QxVmZSc3JFdTVLVmxiWDdQNEZ2?=
 =?utf-8?B?MzVlR1FLbW1kd0tiby9Ha3RiZ1g0Q3Z1QkFYT3N5b2NsUE9ueEVFaXFrTlZF?=
 =?utf-8?B?NUpVZGhFbWcrSzJiajZTbS9KVndzSUVWQ2hwZGFMRGRiTXZoTURZYnUvOEJh?=
 =?utf-8?B?TFRhUE5CbStQcnAvNmRPQUxkcVhzZnBPMTFNeXpzaDd4SUFPbThpNlJpU04v?=
 =?utf-8?B?VTZSZjR6b0FWMk9YRVRmYzJubEQ3cFpBdG1qOFBLOXJHQ25SUjlTODFlZmN6?=
 =?utf-8?B?ZmZhTy9iOHR2bTVETlllYlBNaE9aUnFCRjdBOTZEckpWQ2NtTTBldXdJcnlz?=
 =?utf-8?B?MGVWZWFVZ2NpemtEaUxlQTdFNUFia0ZZV1pVYXVkUmM4dk50VUhSTzdETVFI?=
 =?utf-8?B?RG1MLzZOamxaeW9FUlczVStpMXg5TEg5bGFCVVcvdzY1cEtuRy9mWnlYUmJ2?=
 =?utf-8?B?S2VuVlhDYzhBTys4UlBuVWttYzVRQzRKL0llWDFuUUo4Zk0zQTBWK1JkRU1M?=
 =?utf-8?B?RDFTTUk0eDFydmRWc1d4VnBRaEpNbHlDcXQxUjRKNUZOcTcxaFZiTytyRW1K?=
 =?utf-8?B?Vm1wTGs2VFpXYmsxRkUzRytQQTZ4MHFwelUrV0paMW95Nk00UlNyNlBsaTNZ?=
 =?utf-8?B?SW02SVlsQ2tCRmJJR2piNE9GQ3F6UUdlQ2JMNWRicTVVREJtTDdBZG1HTDdV?=
 =?utf-8?B?cVFYWTRIQnphYmhFQ2dtZytmWEJScW1YV2haSnkraHo3WXdGMlpjNm9vTWRl?=
 =?utf-8?B?NWcvYXhId0RyMW54VlRFK0l4cUsvL1g1QVpNYTNaeWR4QTF5TEpDSmtSTE54?=
 =?utf-8?B?d0pJS2Zub1JzR1NZWklZZnNvRFJ2RGhVNXF0TWlLdm9BS1h5bk10YVZDS1Vp?=
 =?utf-8?B?d3BqWXFrWFRNK0tWQ1BSUGkvc2tZR1RVTCt5dm5xTS8ybVNab1dCN0twcVox?=
 =?utf-8?Q?8cb2U4cTBCVZBTAk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5a85fc-bd4a-42dd-55ea-08df08576156
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:32:30.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOuft/u6mF70qBRakmxbFI7avZbSajKIagIIRz/tHK05k6oIRpDvEwY+7MiV959b28/rNnmDuNjMj0nT9okZSlmFVDY7LSyG69BOka5SJ2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8465

Hi Michael,

Thanks for your feedback.

>>   			};
>>   		};
>>   
>> +		/*
>> +		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
>> +		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
>> +		 * it is configured for eMMC.
>> +		 */
> The documentation about the daughter-card configuration belongs into the
> device trees of the daughter-cards and not in the SoC device tree.

Agreed. The comment is dropped from the SoC DTSI in v7.

>> +		emmc: mmc@10808000 {
> The HPS register address map uses the name "sdmmc" for this group. Maybe
> that's a better label than emmc, if the controller may be used for eMMC
> or SD card.

Agreed. v7 renames the label to sdmmc.

>> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
>> +			reg = <0x10808000 0x1000>;
>> +			/*
>> +			 * "ciu" (SDMCLK) is listed first so it is selected as the
>> +			 * primary clock by the SDHCI platform layer; the SD6HC PHY
>> +			 * timing calculations are derived from this clock rate.
>> +			 */
> This is surprising to me and I can't find where the first clock is
> selected as primary clock by the SDHCI platform layer.
>
> Could you point me to the code that relies on the order of clocks in the
> device tree?

The comment was wrong: it is not the SDHCI platform layer. v6 did
   clk = devm_clk_get_enabled(dev, NULL);
in sdhci_cdns_probe().
SD6HC now requests the clocks by
name:
   clk = devm_clk_get_enabled(dev, "ciu");
   biu_clk = devm_clk_get_enabled(dev, "biu");
SD4HC still uses the unnamed lookup because its binding has no
clock-names. The DTS clock-order comment is also removed.

>
>
> -&gpio0 {
> +&emmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <200000000>;
> +	no-mmc;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vmmc_reg>;
> +	vqmmc-supply = <&vqmmc_io_reg>;
> +
>   	status = "okay";
> I'd have split the addition of the controller to the SoC device tree and
> the enabling for the board in two separate patches, but that's probably
> just personal taste.
>

Done in v7: SoC node in one patch, SOCDK SD enablement in the next.

Thanks again for the review, it improved the series.

Tanmay
