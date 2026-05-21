Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E47368D41;
	Thu, 21 May 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378802; cv=fail; b=o2zrgSDO0E+AjXw28yBGQ6Wi/wnfs2kpZ2hyA0n1SryzaANIQlTF2DbUolSdJQuCI8KKQ0ZmyrjJhKr0m1kO96X5Bz+Vnqcis2jKnTC+FaGqY1peFPv9fVH4cSCllvUFhjV9WkG/5/Ch1T/+wgn3PHrBMurnvX0ahdwt1uGnLkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378802; c=relaxed/simple;
	bh=/Prvi/bT2oL+Kcc5ylLyHSbOUigLQ85PQBJcBAdfTMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=naD17fmKrLJpMwnF658piYSCaRsq5pByE2NmGqrmVRIr5CZyh5YF7/qNIG5Bm8vgbJbDUdC0xJR9huzHcMmTkmlWmOJgdUhL8B1Ksz4Dk6ArZ8U5eN9Umi17IN8vzBWeqzmvAYigPckm0sHJkPGRVtO/rKESGZTR7Knt4oomifo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=d/GFb7G5; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="d/GFb7G5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frxkLDbVJF+cnDzLsedXhGMHsyZhjh4ikDPBNuHKvX867pIv33axk7hvZ2RY+qeeVV5BQlN3rS9E+8a1/L6mpKSjQ6efMhJ7TvUw/NGf1N113uTC0hAUP1ouTV94zbc2wfe1NpwgPN5gCoNYiUBxgrMqaCPjWikVCtbJ/e10QGTcs4lYAdODZuQpAu/A/X8EFlB5DH6pRRJW4H3Ena6fIB5eADmSxlk6TANr48fYs855kh9yBcat2amhUev6zzIk2xXipW6MxESpFnW9hUhhSCzl7aIaIZepj2elXXxUrNTWjGc49/xNkp6SIRMjgngqYkOBh7pOFjbYs1L0M39GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBksvyaFLNDXhceLiZiycDnG7Mgk05thOZFCkN0bELQ=;
 b=Qgw7dV3txuaMLSRcqj7AbBPXB4+lLByOu0dM2H4PLtjoXDXjIPYa3NkXwZHUn7CTH8eXW8mXYt0QtDBod64NLjaePfuqSIioY5D5bXcpWPvGXt1MAYx63Dx8Rdub1oXEus1f1iJxUwZU4HD5aEfwOLcvayG0pfhkNot0ySuxRGLYJLsQZ9lmYc2xXGPW2skkPj/SwG6ljdp6eBhrXWwk2w+pSCm4iTKzoQ/1n3br/Ih0eD2/KRBYTA1esPGjT4DVz3NICASrj/yv5Of+DLqANqLLjkbITKwuWavqfR+K6dJZQDe7NHLz++6RXRi/AzCqZBqUtHcf5E0Avw07NQAS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBksvyaFLNDXhceLiZiycDnG7Mgk05thOZFCkN0bELQ=;
 b=d/GFb7G5CT7CAO90CY5Ib03GY3wT+US6ygN270MzHnIUoGBGKrN7AZifzT03a1kBEaxgau+JgEQJoxteof70iucawPSEwPVvghJsEhpTDtyBH0s6ZjoDNG7Cpr+QGaiN9ZKszOADySWjy7o0zL/LtRUJLnlPlHEuKTuhiPn84c1/IfdjjLgeL7ayM38mQtfP8azNVSvgC2++CWQ33/GN/B3eEBC2dfMi9b064817bTFakrKvuso62Te1G1+5djvAZuHWdVVeaynBwBWEsAHuzlVCE3spGDoHh33pRpqKhNxEyERrLU7BwUEBAsrs9YCjTEXvuaHvMim4yuvmuHz+DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6358.namprd03.prod.outlook.com (2603:10b6:a03:390::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:53:17 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 15:53:15 +0000
Message-ID: <9f8fc7a6-11ee-4b09-83e2-449f24a26b99@altera.com>
Date: Thu, 21 May 2026 21:23:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mmc: sdhci-cadence: rename V4 functions for V6
 controller groundwork
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-7-tanmay.kathpalia@altera.com>
 <7e4300b6-c54c-4161-8af6-8fa1ce172dd1@intel.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <7e4300b6-c54c-4161-8af6-8fa1ce172dd1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0118.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: c9faa8df-1955-449a-e25d-08deb75111e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|11063799006|6133799003|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tOJhqhvlOmr7XN9lHo1Qyh2QZQoLl93KtHnkut15ACH5A2YshV44gJ+Oyl9carD4ad9hVb1IqYhpQIYwblA4lTQwrzk5hV5oiEU+FNsOktqZal187y9Vta15nug5+M8ZG0Fb1nfUwc/DCBj5SxJ09TsFTpdoNdGcEB1BrN8ZCVZ98ix7gVNTOmyqqE9q6CbxalCqVl5CthVUtvRINzGTl1sXusTWKNd+faHJ3wE1bZ9sIMHaPbYRrlGQrWqL4ksatZV1Hb21WoEbl/VKaMGDIIVJU+7qVyx9ZeAu23VfETnK96vbIDaJO363IsKbqkQRZKzliDlImBC8XcjQzm9JmT+rYHb5l1t6wdKm6EHbS8vX8p1usFxECmKbXuD6OfDwBU6e0nW97/ySMJrI9o4QmCM4VCcQAZFLHiwiQzpUDdN9AQYrF9QmzuY5bt2gJjHCQ/qS9szoFMA3VmCoViqowddGaXbmgowHMMrj67ZYP7VIPp/HZkjVib194k8ULwKCj5sdBdcVeu1Z+J/HRp8E6RfgY9xqLTmw6g+YGSVzaIt3IYY7O7zm52/xPvsqeLCgxd3QAEPWGOVnHucJXntg1TW8VNUmzuVTsq9OWD6fXPe82h1Uq/wXYOs9n7E2w961UhRBTNkwqPfq1LoeFxJJqrvkfVPsX6IryYzqTI6m3lO5k7nIopqd5tPH/boFq9Tn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUY1UHZ5SVdqaG00UXdDMmxEcTF5R1RLZ1F0aWtwajFCME9GdGFueTVWVEJw?=
 =?utf-8?B?bmZFb2Y5bXNQTC9mOEluZjNQck5qVEl6MFNjd1VGK2pWYnRpa0FsUDVTVEta?=
 =?utf-8?B?aU8rTVFmWXNMNE82UWxUbHZWMzlna21SMzlwSzg3eGgzay9OWThhdTVvTzFz?=
 =?utf-8?B?QmFpaDJxQnhLRTR1dXZrSGtybmpmcERMMXV3SUZOd0tPL3VjV3B4QzFQQ0ZR?=
 =?utf-8?B?dWI5NFlFTTRCSk0zaGlQRmhOSXVONmliN1RqMnZqRk9pV0VIZjZxWXVMeDhk?=
 =?utf-8?B?MzYwOCszbnFubzVyTkNzNkZCQVRtbHltb0Jobmc1SGhNVFdNZ1VVODdZT1FV?=
 =?utf-8?B?RnFRa1d3bUgwMkNzbFlDMkxWRXBwcGNDeTkwUDlvVHRnM0hLcHZocjNsa3Ft?=
 =?utf-8?B?UjFwQ2VlYTV3aktFa0dyUGhOK2RSdTAwYUxLaDNuU04wOEMxZGgxcjFXQUs4?=
 =?utf-8?B?MnJ1VllYWXdjMDE1NmtRbW1OQnJEVHZhV2dLYjMvakZoa0Vqa0l6VTY1Vksv?=
 =?utf-8?B?bUxhUWdnUDA5OWltMFVqWlpWVldJQUhtZytnZHRxbUpMSllvUVFTUktlS3o4?=
 =?utf-8?B?Q0p0WFgrbDBHVHN1bHNCbEFzelY4a0JUQnM0VldWOXdzWHNUV0t6bGhrandB?=
 =?utf-8?B?NTJod3I0TDZlSkRvekxla3JIOC9mb0xaVUpUR0JmV2hGbkw2Q3NMQitXalJO?=
 =?utf-8?B?Umh5a2dvVkNibHFMR3g3NFgyYjRqZkJZZldPVEx0MXVDRW41VU81dVNacnFV?=
 =?utf-8?B?VnlFSGljQ1NPWmhNWkxXVDFqS2M1V1BBRnNobkNaS1FJRzN3bUMyRmJvZ3BO?=
 =?utf-8?B?MTVGbndrcUFkdlJLNlVHbzNDWGRZL25UaXhxT0gwRmlVeWRlUlVxdys0c0lw?=
 =?utf-8?B?NW0wSEgwc2hPUHNkWUZDZnFQUkJlbHFyYmNxOVdKTjRpdlQ4QmFSVlp5Y3pu?=
 =?utf-8?B?TTJDUzJNQ2FwM3JkMHY4Z1I1SzR1M2hpRCsyam9KWmlzY0c5SytLSWhoUTVT?=
 =?utf-8?B?WmcydCt0UHg4cE9QcnM4cHNMd2M4Y2oyR0d5NTJrTkxaZm03cm4wZDJxQ25C?=
 =?utf-8?B?U1FUUXpvMTZKZkpkam5Wb2ZQZklnclRINGM4WFEyK1JpajAwMUpxam5OVnB2?=
 =?utf-8?B?MzU1TkFxUlpjK1QxNTN2ZEZOTU1NT0VpUFFtcnUyOGZPKytpRkw5akkvTUFo?=
 =?utf-8?B?L21PS01KMVJPY0JXanFhWitHQUgwcXpzdjBMZjZtcGRuNXluWHpYY3dsNFdy?=
 =?utf-8?B?M2s4dTMyWmhDUXc2alhtN2JsSWlZVUlZb3lEZW9uOWd1ZDBxQzVYZDlaalFP?=
 =?utf-8?B?aGNRa3duM1JTNExXZXdYbUt0U1N4K1NabDdiVkhWekROaVl1cVdrUDFzWlUy?=
 =?utf-8?B?Vzh4ZDBwamdrRTUwOWxtRG9sWDZ5aEJ4elE0V2gwTzczRGxJa2FJaEZpZWdP?=
 =?utf-8?B?VDZyTWNiWU9vUkNlcWJwenllUjNuVkt3YUtLckNwTjRKVFl6ZHVSOThTWUZk?=
 =?utf-8?B?cnREVW8yN2dmQVRidTh1WFo0a3VZTUE3VzBWaWFUT3ZCZ3I2K1M1MkswQy93?=
 =?utf-8?B?NWs2a0ppMFRnbUx5clBLYzBWU1BIdHU5QkZTelgzV0JrVTVUQUp0Ty9kNDc2?=
 =?utf-8?B?V0ZqbTNEM24zVmtNM09xN3BCOVFuYTBQTmlPOFYxbWt1N1locUgxaU5sWUlx?=
 =?utf-8?B?aFU2QVVFWDRzZWVPNjN6ODFWZDFXU1BMa1ZPdWh3d1FZcTNZNVNOUTdTb1FK?=
 =?utf-8?B?d0NPRnBLbzg5dU9PeVRDTTl0ODJHK0laMlhEVkF3TkZSZXQrVzJBckROOHBF?=
 =?utf-8?B?cGhVdzVsWFNkc2xvSFZiNHduWFVSc3BmUmZwMTJHVU0veEdqM3paMzB4cVRi?=
 =?utf-8?B?SGVVK1daUEF3dlhqbWorUXdRZlJTTTFHblkySTZQbDFzZ1hjc1B0bWVhcmRS?=
 =?utf-8?B?R1NJeVFpTHBEZlg0Y0dBS3hiMHE0QlFRRGFQUzZkZ2N5YVlZbFQ4N0hGM0x0?=
 =?utf-8?B?SSs4eFFTMDRreE5iWHp4WDFPNlZSdjZkaVBPOEF2V0gxNXB4WjVWYzVGV216?=
 =?utf-8?B?V1ZsWnl4eEErTFd0b2ZzRWhsZDFwU0FtSXV1TGJpR0l6SHlUT0l6OGZaNWFI?=
 =?utf-8?B?VTgwTlNNbU5TQzl6UjdxbnVvRG9hNmh2RFlPRThpcFJXQXRjbGs5cVhZbWht?=
 =?utf-8?B?UE1FNHppdDNTTHFhVFhzZUpxWnVlVGI1UVRIaWdiM0xubG5US0JOSmc5UzRa?=
 =?utf-8?B?d2hLOGJFWWpDZ1MxYnhGTDRJSVY5Q3FXWlNGcEsrWlpkaFBLTXBIS1QwQXFV?=
 =?utf-8?B?UlJCU2M1VzNrUHI2ajg5WFpEdTYxMVYxRDZkclE1VnRhckFYNUUrNTBWUW1N?=
 =?utf-8?Q?FQ061KeZevsRHdO8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9faa8df-1955-449a-e25d-08deb75111e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:53:15.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtRHpqwgg9kgtM03p7zitB54u/oROWI5qYJTMiMWkAB4G6NukBDy1XCWDWqFvUZaucS8dydMaIVAI7qvrLu0vcfSme7HGrmZxdVdmsV1LKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6358

Hi Adrian,

On 5/19/2026 8:59 PM, Adrian Hunter wrote:
> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>> PHY-related functions and data structures in the driver are not
>> explicitly scoped to the SD4HC (V4) controller, making it unclear
>> which code is shared and which is version-specific.
>>
>> Rename them with a "cdns4" prefix to distinguish SD4HC-specific
>> implementation from the shared driver core, and to avoid naming
>> conflicts when SD6HC (V6) support is introduced.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> One minor comment below

Thanks for reviewing.

>
>> ---
>>   drivers/mmc/host/sdhci-cadence.c | 74 ++++++++++++++++----------------
>>   1 file changed, 37 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>> index 435603c8c00b..47690a52a221 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence.c
>> @@ -78,7 +78,7 @@
>>    */
>>   #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>>   
>> -struct sdhci_cdns_phy_param {
>> +struct sdhci_cdns4_phy_param {
>>   	u8 addr;
>>   	u8 data;
>>   };
>> @@ -91,10 +91,10 @@ struct sdhci_cdns_priv {
>>   	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>>   	struct reset_control *rst_hw;
>>   	unsigned int nr_phy_params;
>> -	struct sdhci_cdns_phy_param phy_params[];
>> +	struct sdhci_cdns4_phy_param phy_params[];
>>   };
>>   
>> -struct sdhci_cdns_phy_cfg {
>> +struct sdhci_cdns4_phy_cfg {
>>   	const char *property;
>>   	u8 addr;
>>   };
>> @@ -104,7 +104,7 @@ struct sdhci_cdns_drv_data {
>>   	const struct sdhci_pltfm_data pltfm_data;
>>   };
>>   
>> -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>> +static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
>>   	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>>   	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>>   	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
>> @@ -124,8 +124,8 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>>   	writel(val, reg);
>>   }
>>   
>> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>> -				    u8 addr, u8 data)
>> +static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv,
>> +				     u8 addr, u8 data)
>>   {
>>   	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>>   	u32 tmp;
>> @@ -156,44 +156,44 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>>   	return ret;
>>   }
>>   
>> -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
>> +static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>>   {
>>   	unsigned int count = 0;
>>   	int i;
>>   
>> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
>> -		if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
>> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
>> +		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
>>   			count++;
>>   
>>   	return count;
>>   }
>>   
>> -static void sdhci_cdns_phy_param_parse(struct device_node *np,
>> -				       struct sdhci_cdns_priv *priv)
>> +static void sdhci_cdns4_phy_param_parse(struct device_node *np,
>> +					struct sdhci_cdns_priv *priv)
>>   {
>> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
>> +	struct sdhci_cdns4_phy_param *p = priv->phy_params;
>>   	u32 val;
>>   	int ret, i;
>>   
>> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
>> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
>> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
>> +		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property,
>>   					   &val);
>>   		if (ret)
>>   			continue;
>>   
>> -		p->addr = sdhci_cdns_phy_cfgs[i].addr;
>> +		p->addr = sdhci_cdns4_phy_cfgs[i].addr;
>>   		p->data = val;
>>   		p++;
>>   	}
>>   }
>>   
>> -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>> +static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>>   {
>>   	int ret, i;
>>   
>>   	for (i = 0; i < priv->nr_phy_params; i++) {
>> -		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
>> -					       priv->phy_params[i].data);
>> +		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
>> +						priv->phy_params[i].data);
>>   		if (ret)
>>   			return ret;
>>   	}
>> @@ -201,7 +201,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>>   	return 0;
>>   }
>>   
>> -static void *sdhci_cdns_priv(struct sdhci_host *host)
>> +static void *sdhci_cdns_get_priv(struct sdhci_host *host)
> Why rename this?  It seems to just create churn.

The reason was to resolve a name collision: in the original code
both the data structure and the accessor function were named
sdhci_cdns_priv, which can reduce readability. Renaming the
accessor to sdhci_cdns_get_priv() makes the intent clearer and
avoids this ambiguity.
If you would prefer to keep the original name and avoid the churn,
I will revert this rename in v2.

>
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   
>> @@ -238,7 +238,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>>   
>>   static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>>   {
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>>   	u32 tmp;
>>   	int i, ret;
>> @@ -354,7 +354,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>>   static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>>   					 unsigned int timing)
>>   {
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	u32 mode;
>>   
>>   	switch (timing) {
>> @@ -407,12 +407,12 @@ static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
>>   
>>   static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
>>   {
>> -	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
>> +	elba_priv_writel(sdhci_cdns_get_priv(host), val, host->ioaddr + reg);
>>   }
>>   
>>   static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>>   {
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	u32 shift = reg & GENMASK(1, 0);
>>   	unsigned long flags;
>>   	u32 byte_enables;
>> @@ -426,7 +426,7 @@ static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>>   
>>   static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
>>   {
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	u32 shift = reg & GENMASK(1, 0);
>>   	unsigned long flags;
>>   	u32 byte_enables;
>> @@ -452,7 +452,7 @@ static const struct sdhci_ops sdhci_elba_ops = {
>>   static int elba_drv_init(struct platform_device *pdev)
>>   {
>>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	void __iomem *ioaddr;
>>   
>>   	host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
>> @@ -470,7 +470,7 @@ static int elba_drv_init(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static const struct sdhci_ops sdhci_cdns_ops = {
>> +static const struct sdhci_ops sdhci_cdns4_ops = {
>>   	.set_clock = sdhci_set_clock,
>>   	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>>   	.set_bus_width = sdhci_set_bus_width,
>> @@ -481,7 +481,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>>   
>>   static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>>   	.pltfm_data = {
>> -		.ops = &sdhci_cdns_ops,
>> +		.ops = &sdhci_cdns4_ops,
>>   		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>   	},
>>   };
>> @@ -495,14 +495,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>>   
>>   static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
>>   	.pltfm_data = {
>> -		.ops = &sdhci_cdns_ops,
>> +		.ops = &sdhci_cdns4_ops,
>>   		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>   	},
>>   };
>>   
>> -static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
>> +static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>>   	.pltfm_data = {
>> -		.ops = &sdhci_cdns_ops,
>> +		.ops = &sdhci_cdns4_ops,
>>   	},
>>   };
>>   
>> @@ -510,7 +510,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>   					     struct mmc_ios *ios)
>>   {
>>   	struct sdhci_host *host = mmc_priv(mmc);
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   	u32 mode;
>>   
>>   	priv->enhanced_strobe = ios->enhanced_strobe;
>> @@ -529,7 +529,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>   static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>>   {
>>   	struct sdhci_host *host = mmc_priv(mmc);
>> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>   
>>   	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
>>   
>> @@ -560,9 +560,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   
>>   	data = of_device_get_match_data(dev);
>>   	if (!data)
>> -		data = &sdhci_cdns_drv_data;
>> +		data = &sdhci_cdns4_drv_data;
>>   
>> -	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
>> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>>   	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>>   				struct_size(priv, phy_params, nr_phy_params));
>>   	if (IS_ERR(host))
>> @@ -593,9 +593,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	sdhci_cdns_phy_param_parse(dev->of_node, priv);
>> +	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
>>   
>> -	ret = sdhci_cdns_phy_init(priv);
>> +	ret = sdhci_cdns4_phy_init(priv);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -622,7 +622,7 @@ static int sdhci_cdns_resume(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = sdhci_cdns_phy_init(priv);
>> +	ret = sdhci_cdns4_phy_init(priv);
>>   	if (ret)
>>   		goto disable_clk;
>>   
