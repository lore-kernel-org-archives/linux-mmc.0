Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD246D09B;
	Wed, 30 Sep 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766691; cv=fail; b=Ztp2bW66pDAm34oSKdOebWZUlIdtnU9yxW5YTk+ikiv13T7mhKHoiAYno/1LS2f7Qh9YQUuYHJ/4RRD3FOq2X+XCsU3JzTW6zOPzBUuVY4y9JN1i02pl9E+c3aSRoOgP/+0EVJ1JddiqsZD3ltnYLWxAYRraIMQSj2q6RVGVr6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766691; c=relaxed/simple;
	bh=osaINSYc+K0Zq+WSkaGdv2tZsCxLo47RApCEPJ2En3U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J9Bkn2p2qDxT8JxYVfXh0Vz/Hf19ljhR8GYFsNnCZ4HRPVSSKNPpplScPPZbVyQlbjOlste4onWOjrmXNinN2UFg2w07Fprbugl7fOieYxLgftYkK1GuBppJ/YFdLTabuFQimEbfXyttntin9rKroIVTkAcKrfcBURROkPV8l6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Zi1uCjn6; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Zi1uCjn6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bcn2nkVEhXxN/rCvqZqN8fulzMs/EhVrJapIWU2EmH1RgusRsEoRkvb9QMtoBv25vl6hkHyXEoOhGBkKxZPoXQwF7amQxQwKS/ZLGPYjjFmRZQGQ8kasw0JLMpQofva5kqbWhmetYoCrpnFIQCm6bj8T+trpXonnplBDzMW3vRN+ip4PfNT9FItCR+pSCQqErttatiaArQNsedqYSIxEfPoCrZIrOcQRqMyTc7N0gjCtKExcsZIyFxrkL5vJkZMTN0kuMKyQjolPjnii5nEw7RVUQb0RK2ER+mEEJmzj5U7vr2ZQK9qpBgUnV2rSCyoPzvRuroYhSJHkzNuS8loejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNacCT5SZK/pjcYOvJ2se7RI1CEWG5HJUn97YO83swo=;
 b=EDJGyPjIOxGzclvRC+7Yr1Kvj5iesoDv/ol+rf+WdOIdMBVk2JUScZ+zsZkXqfhJQd6Tzu+Ja2aPMzvfNvtAmCsMSijUioG/wmPm3Rp/6SONWh5kDjZibO2BopDVWKOzm9Fkpey4DeVL/HXHV/tQRcaBjQXB2YRHRzhglqDYgd2Ul4Mwr+K6mXEZEUzsclJRJRbO0YOD8CXOgDv5MiHd2joumcagSMGwYnQF9pyrtjrN9CVaglzAzINDc6kSDIoo2adyx4Ff9BoLj0zazUgtuUvV2mMhAm7FP9UMXMdN93bN8JvDxGI2PPrL6lb4fdOJbjHh57kDYOdnNjQ4WyJQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNacCT5SZK/pjcYOvJ2se7RI1CEWG5HJUn97YO83swo=;
 b=Zi1uCjn6/pPU9BP4z1vctxflOvtkyRcBljWlv6HF+cF7X1c/1ATdNDnrqjKkNrrk7ojI7RjpzPCJp42lOt+8y1qtrr98lFxB1v+s7R/1P17u3++eA7xod1iW7FtIEM5exHLUWw3A1uIfyVjCTjtv0a7A3IAy2s63+Gqze2ltVd7hzkuYQnv66ZAMOU1bhexQ8ZYgUvageIletVNMfijVzDwkAqCN4sHIZqYELj+Y3eLb0Xo+oPlCabeBngAGgVE2Mxdg9Bppz9Tw31RoA2IECpR1NQkideqzb+hjBxvQrSsfU8Adhp7ZAbosZ12bk3fhLxvJAq8D2HVhaHbdRiHiaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA2PR03MB5882.namprd03.prod.outlook.com (2603:10b6:806:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:11:27 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:11:27 +0000
Message-ID: <ed2edadd-dbac-4e0c-b1fb-fa779e4d43bf@altera.com>
Date: Wed, 30 Sep 2026 19:11:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
 <aa327f2c-5db9-413c-a846-4d74cffd4a53@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <aa327f2c-5db9-413c-a846-4d74cffd4a53@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA2PR03MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: db112efd-ad1e-435b-66a4-08df1ee39248
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|4143699003|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EC2KIzPM+LX8T9B+I/Q5ko09cUlkqAldpEN1SgBnmtDlO0+h6QoiuTux2APzD1Q7cqRG6HH2zmx+MOJGnNpw+flXdlPHks0KnFh60Tn5/3AXGR3h1alGxKls6FocQYpEmjrJFMczgwvMLqekoCKXXsNNYm6GjNFey2qtcuVLv2L50J92M/Wh3rpqJIgfN/nQpNNzu/7ktSwVokXLWxFp854eBrLhDUeQMIpFD9G3LuRV/iD/mzOSgRm5RVUFztiU44brqHkHO0zlegG35BwEKy/NyqybApZOYWSE3BzWLWgeLsRKVJX4Adrq3dhejLoeSQuWebkDSg/rhSB90oMcXrA9JiRK2nuiqyLAGohQqLv8iBHzA7gUhXZbk3tJyaT1dgwPCCYodNCjrmb50Q1OGY2QKcuz6T97QTGRfC56cqeXntXI9040FXMJGZOJ63Lxf1FAfz8muDEapb7w38f94B35mJRV26LlNg7I7Xz7k6COJznUQQuQ3tRCowE+DesG/D6Wtrn2fIR03n0rV7U8q4IykakvBibQj8thc5zjU1BgFvuWb7fhf9RxdovgQZIRkwxsGF+c7gXp7NuN5F1tcdewRB713WfggSH6f6kso1Ch0IAtU5OUJjKgKIWCgSy4eiUwrjwsnoLjfDsQg5LxTAWytMwnrfdK5v1rS5DBDy7tdBHB3TyCK44W0hlSwmr34lzxyueXfXbYBeJ/z3ZZhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(4143699003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JvTFFZYnBZODI5S2Z5L3BQZGtiSXNoY2dTcTBwNlN6MmZIcTZOQ3FzWmpV?=
 =?utf-8?B?WE9RY0MxTXlPSlZaTmY0UFkycWRhS3AxcmpDNDFKSmhlY2VKdkJxN2RWWEtK?=
 =?utf-8?B?SW5zSFJ0WjNobFBKSmxxZkRvZGszclFiWUIyWC9BMHUvWkVyTm4yTnMyMWhC?=
 =?utf-8?B?bUduVWN4K0RjaGJkbnRLM2dNTjNRU3pndDZpN3FKb2lVSXYxd2JRR3QwSnlZ?=
 =?utf-8?B?U0pXUXQ5YWkvYmNKOVhVUllvWnZiSmFGZ3pCODBpZDRmZys2QzhvK0hERXB1?=
 =?utf-8?B?bTM1MjJaR0xwTCtyU1Y1LzdjWW9TUTRFbHF0SVJzSGwzRlE0RDlzeldFMkN5?=
 =?utf-8?B?ZytRTGhsdk5SdWdTUTJUdTh0UndnejRwMTdVNFlCNU1udUo1Y2FLR3RtY21a?=
 =?utf-8?B?T3ZrN21DZXJRTnpFd1c5elhxS3lQZE0vM0xXVmJUU1RyaEdsZEY4Y3Rud0pk?=
 =?utf-8?B?TStGL0FqWlg5Njh3WlVNa1lCU091ejBVSVd1NnBFcXB0S29UMmMwNjRaMU9n?=
 =?utf-8?B?MGVtdThDZzNYeW9Pay85RDF2c3d3U0t1N3prMmFoWmsxTzVrWGJOWlVqN29z?=
 =?utf-8?B?TkZqYkpmQjJsK2ZiZ0k4bGRyNnBBN0dyUXNKbXVEeHJOOWFaZzJIYmxBaHJI?=
 =?utf-8?B?TklxdTVkTlR0WU9RbmxIL3NUV3dIaTRNNmFINWdBSjc1OWZKcnliaC9yREVv?=
 =?utf-8?B?cmM1VWNQSVIvNDl3aG9KbUlyVXRHTDVaVmdhWndDM08wMHpWOEc2OXlISnJG?=
 =?utf-8?B?eStKSW9Pakd4M0NtMDY5aE12bUxMQ2lmRnZyOFNLeHUrc3NCRnYyMVU2YUsv?=
 =?utf-8?B?TXoxb3JQZjdMbkZlQm1iUndtZzRQSnQrZlEzRFB6SzhaOHdzdUtoNHg0ZFlm?=
 =?utf-8?B?aWI1dXNidnFKU0FDYVNxb1gyZTZ6U1FRQytjdW9yRytPQmlucTlsMVFYclJ6?=
 =?utf-8?B?cTVqUnNtZ2oxTGlnRndnVXJVd0JySnpQMnpBaTljb2U0MTNWRU4xYkhudUdJ?=
 =?utf-8?B?dnlkbWJuOHpHQzQ1aW5Vd2Y3aURrMytTSzZ3TWl3ajBwUXk4ODJWdUU1TzRO?=
 =?utf-8?B?Ump1SU4xVTRuVDM3bW5TRUlwRkRRUlBaRjJNaVdLbmlpclowbXdVbXM0VDBt?=
 =?utf-8?B?NnJEbTU4MEE4YWJjcWw5TWc2YXJTbmVnd1ZVUDJsaGdNbExUYTJWdlVEaHdY?=
 =?utf-8?B?VlRKYkRTNkp3ajF2YWFNNHlwakhqajhyQVMxVkpUeFdJQnpHWEExL1NlQWRI?=
 =?utf-8?B?ZzhVZVJkdGJxalpybjc1bUFHK29pb0JZNHFCTmZ1dWJScUUxeXkzdmtQQTlD?=
 =?utf-8?B?R0haWnZpL1BjQUpGMzFIWjE5WE5HSGt0Zno4N0ZPZnhkNEdUUGVXdXR1d3Z0?=
 =?utf-8?B?ZzBOQkxuSnRrakZ4UkFWNjA1a1VtWFh3YVZ2Skl4cnd3Q3YwWkdnOXkxZTU1?=
 =?utf-8?B?KzlLSHVhVFBNOTRZalkzOXhsVGNQdCt3enNuRjFnUkxrdUdDeTlTc1FES1Uy?=
 =?utf-8?B?WjBZb1k0MzRMWmVheStsZE1VckdTSSt0ekI0VUVPNjYrQ3V3NUpNRDNHUG5V?=
 =?utf-8?B?aFI3S2JaTVlWU2Q4TTJiZ3RkbHhLM1BJNmpmbDluNXZXZVFvK1QwY2x0WnNj?=
 =?utf-8?B?WjcyZWFsd05ibU1RM3Z3d1B3V3ZCUkNlV253SUpxOHhyRkFPUGNpZ2RKWm52?=
 =?utf-8?B?OHpTRjd5YVVmWUR3MGt1S1ZKdSsycy95UHNYYU9TNU1mUXJTV2RGeGpkZDNO?=
 =?utf-8?B?RVpMMUh0bllhOG5BU0Z0aGxwNDhXeWNacDV2ck5BYmQ0YktORytqMWNnbkpy?=
 =?utf-8?B?U29vQVBVODIrYlQ4ZTV6WlFacUtPQkhBbnQzaHNwQ25zUEt1SVpPNkZLcldG?=
 =?utf-8?B?NHJJVmROK1lrTG0yVGVZOWRnVUNpdTFWeDdjc2xLNjYxamMrSFZCbEw1OGFs?=
 =?utf-8?B?SlVnZHZialIzUUUveENKMWtSTk91L3FpeUYrTjlYdzFXekJrcHdBZCtjTUxy?=
 =?utf-8?B?WDF0blZzZXdrOXNSNlVtUURoTFFGRk1VYlcxa2Z6a2FVazVwWjNwajF5TUR0?=
 =?utf-8?B?ZlFRalZaRmkxTG03RGpCSEphS1ZSRlpkN3JOMzYvODM4R3cxclg4SHA2Tmsr?=
 =?utf-8?B?clVXYlJ2Um9TQTZUZVZ5NHpwMjRMMXFSVUpBZ2xkaHNjdWc5NWplN3llVXhS?=
 =?utf-8?B?RU1meFNxK1RCV2lrVFJoV2FlcEV3dHJWd3k5MFlBVGdZV0NsSWJDa1RYOGVI?=
 =?utf-8?B?SzZHM2pDOVlYYzBjbkVsazV1azJvMFJBdUNjbnZ5MU5NN3JmVGRlbUpMNDJ3?=
 =?utf-8?B?VXpjSzhMTjQ5dUhZaVZsOEp5N1ZaTUpXZzFaK0MySSsxZkFTVHk4UT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db112efd-ad1e-435b-66a4-08df1ee39248
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:11:27.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dLr+xhG4NjU5Tx5ky2QY5nPsM28P5JLD1wwYOjgvc6oiDFebdal/IR4CSrNNqRp6sxCNRfopeuKVvbpdNsZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5882



On 24/9/2026 4:49 pm, Kathpalia, Tanmay wrote:
> Hi Tze,
> 
> On 9/22/2026 4:42 PM, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
>> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
> 
> I do not think the comparison with sdhci_cdns6_phy_init() holds. That
> 5 ms comes after a full PHY and host reprogram, including HRS writes
> that happen after PHY_INIT_COMPLETE, and that path is only used after
> SDCLK or the speed mode changes. set_tune_val() only updates two
> phy_dll_slave_ctrl_reg fields and re-locks the DLL; it does not touch
> HRS, clock, or mode.
> 

Hi Tanmay,

Agreed. The two paths don't do the same work, so justifying the delay
by analogy to phy_init() was wrong. I'll drop that claim from the commit
message.

>> settle time the command issued immediately after tuning (e.g. the R1b
>> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
>> can time out.
> 
> Do you have a log for this? Which mode, which card, and how often it
> reproduces. I ran a long regression on eMMC and on SD cards from
> several vendors and sizes, and never hit a post-tuning CMD6 timeout
> without this delay. I would prefer to see the failure before we add an
> unconditional 5 ms.
> 

Yes, Agilex5 eMMC in HS400 selection path. The failing command is the 
HS200->HS CM6 (R1b) the core issues in mmc_select_hs400():

   mmc0: switch to high-speed from hs200 failed, err:-110
   mmc0: error -110 whilst initialising MMC card
   mmc0: Failed to initialize a non-removable card

It reproduces on every init on this board without the settle delay. SD 
SDR104 on the same board is unaffected.


>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/ 
>> host/sdhci-cadence-phy-v6.c
>> index 22d56bb46d75..35f35ef9c710 100644
>> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
>> @@ -811,6 +811,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_host 
>> *host, unsigned int val)
>>       if (ret)
>>           dev_warn(mmc_dev(host->mmc), "%s: DLL reset release failed: 
>> %d\n", __func__, ret);
>> +    /* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after 
>> configuration */
> 
> The comment is copied from phy_init() and says "after configuration",
> but here we only reprogrammed the slave delay taps and re-locked the
> DLL. Please reword it for this call site.
> 

I will fix the comment in v2 to remove the phy_init() or "configuration 
references.

>> +    usleep_range(5000, 5500);
>> +
> 
> I think the placement also contradicts the rationale. After
> sdhci_cdns6_dll_reset(priv, false), PHY_INIT_COMPLETE is already polled,
> and per the Cadence DLL PHY user guide section 1.2 that means the master
> DLLs have locked and the PHY is ready to accept commands. If a command
> still cannot be issued for 5 ms after that, then all 40 scan commands
> were sent on an unsettled PHY before this patch, and the real bug is a
> wrongly chosen tap rather than a slow CMD6. If the scan was reliable, the
> delay is only needed once, after the final tap is programmed.
> > Also, the sleep is placed after the "DLL reset release failed" warning,
> so we also wait 5 ms when the DLL did not re-lock and we are about to
> return an error. Skip it when ret is non-zero.
> 

Agreed. The scan issues only data read commands, which sample reliably 
once PHY_INIT_COMPLETE is set.  The command that fails is the first one 
the caller issues after tuning, which in the HS400 path is the R1b busy 
CMD6 rather than a data read. So the settle should be done once, after 
the final tap.

In v2, the settle delay will sits after the set_tune_val() error return, 
so it only runs when tuning succeeds; a tuning failure returns before it.

This also answers Adrian's cost observation: it's a single 5 ms after
the winning tap now, not ~40x during the scan.

Thanks,
Tze Yee

>>       return ret;
>>   }
> Thanks Adrian - I'd appreciate your view on the comments I posted, given
> your experience with this subsystem. I'd like to hold the patch until the
> mechanism and the cost are clarified, and happy to go with whatever you
> think is right once those points are answered.

