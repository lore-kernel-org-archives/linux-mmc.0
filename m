Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2097.outbound.protection.outlook.com [40.92.103.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73621360;
	Tue, 18 Jun 2024 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669244; cv=fail; b=TjGXTzGhXlR34PfrgsG6Nm/iW4ugQyIxRTXD0BLLGfvNA2h5A14P96/sIpoh6gD86ZNW61BSuZ5+EzvaTpXAl+wRbgkpIBfOsQNgBy2PwHJb+/ECwNuQ2730otF7ialleSZaYnv/UmfhH9PK0VnQP6dKNePSnSFcgu17GDwqZuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669244; c=relaxed/simple;
	bh=U6EspUi7wLAy43xNGvC2P6nSw12GmSeA8vKUsD1KfTM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GzQ5XJKXB72YFOp/srLu6b/oMP5wOr4dPpHW82SKd2CKu40b3K7T89KefZ9onJ/Sl0bgJeYAo2pM7La4hNOtW9fK2JjYl4eBWcN9tONBAJ4wCVfZa4JR6AJQjyEcwjqD1OU1WPZS4gEBja7HiitU9V9ljo+2U6/EjqYiNFCunPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QLXj+MfL; arc=fail smtp.client-ip=40.92.103.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QLXj+MfL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUyI1Vzxc+Noj5mVTcA4msNjqHkm/Jras7HbfJy7jszr4nDdHzT0irCV+RrSF+V6K4fu1kIX9z7SqibMI8CwJslbgkqR1sCHTGMuz8U8jdnQfo5LeeGqc6vRa9WnloBs5IcDCiINBHRZFSm9s0CsHR8yWiJAI7vS3rZJh2qPgmFFkFJAsYGAlNCZOG3R3Y51Z2TW1Xz4gvXeQF4bAFJHJYCiBtXkn/SlYDxwnUa/1trMa4ALt+bjs6C/Z3i3QuhmgsLw4MwOnlaSlYHLcUC6/6keBU9Hbx6xdrHiM71lhRo1vd/0R5qAMhkKKvcUccnCUXXBcX/G0yGA1eiOM2OPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nWBrC2KOZ86IBZ5sIGM6c8XPSRGqcWnHVSatjJunGg=;
 b=bS6uWXdXQ3kBn8Ljwsy/MDK3Vvu8HDuE45TFYhRBe/h6yJBTIwRQUbKkXB/iVrlO6VBmAxhY9wSynCkKSjWb1XEiBh/ObGx6uIphlXYCaPw547YTFsivlXd6RCRtsXgPDhsP11z0nm79Wjompn100CRtTi60FBuXZaiT84ZeKInGdX8duLMbbVjPAgs7JeZyQbS73M5mCePof4dwX2kyOtq1A6Z/fngFlovROcg0EhVTsjr/BDcHbQnl+vI8EdZaGFVit2E+nMco8hZ8FBBrZTJXxRG4x75BVT0cZMCdg/MKDX+69xUlKxVVOJFkaVWKOHuqAKI7c8lZMUx2//pytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nWBrC2KOZ86IBZ5sIGM6c8XPSRGqcWnHVSatjJunGg=;
 b=QLXj+MfL3WCwdIjWTKXVBG0HoOlu5Q4PCCxrzSrR+eGKgNQ5BRHPpHlxl/2UMFtZzaCSlgbKNQKFjBlASF5as/EnN5PNyG1DYh0YYk8m8IMkM2XLdKP5GSJcuWugLJgvjbek6Q2Wlq5MbQ4Pg1X6IhfCUO8TEggoanl41CAEvxk2JvLTkDzIis152PnMwlBxu1SyAjcLE/DE9zdPULBe2Hse/KuS2F5XgLmjlX6sd4L89+7FElQRsunLyrGHH6UdsbqAic4fQADelS43q069jbabVsi6GsgPs/vj6jQ8P/rq16hifcrGohM8GDemJjvP3X2DZ03Vj4tDo7M2DIgVsA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1497.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:07:14 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:07:13 +0000
Message-ID:
 <MA0P287MB2822C2A2798A812FE1F26E04FECE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 18 Jun 2024 08:07:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc
To: Adrian Hunter <adrian.hunter@intel.com>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <2182f65bad83e394a7ffb9259b2c1aa130912961.1718241495.git.unicorn_wang@outlook.com>
 <25910cae-b29e-49a5-86d2-6da571664b4a@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <25910cae-b29e-49a5-86d2-6da571664b4a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [sdOYO6Ep82Np+TdUNaMhRiRhJh5zU2Xe]
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <96fa0ded-7477-4af3-b400-ada4551b3af0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c94b9d-206f-4bcf-aba2-08dc8f2a9b2c
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	dr8ccTYyiovBnZ11xbwJRqIgDry1IBjrEIouEpZZfAqr8n31c82OsBxgN0qeRTCMcrcU092jEvhL3j8VIWRtQ7sWnpCjDVt6tXZ6NhjvBC4kk/WJJwykrGgDfkFfHcniPENJ1OWkpLS+0w5YrwQUc/A8MzAgRtMiyzpWdd9K46NmV7lM1ECaTjzA4zjOInQ0cd/CcAkj1lNs31zeDBbPYe8YPT2nmsJw1pOt8ceVlDTkktHiVAt9LbjvKFuUIqdNFm0DuYvDm4V1zYq6QtDrQS+1FaRvnUbRXunCGnPeCmQ3KVVyqTTKrsr35eTw3SP8VJBxKL6gOCY98i68QY70cbM4NPOhs9vdG/fmR3qQnlAe0mBk2aukGpmsyqLPKfgwdXCJ2X5qiQxlZjMzfK1CSwBEeCS1vqAm3dNrHbyFFarVgVuWsZtotuybcml1khIfjgqVq+XaJcot8aUYMORpjdiXFvchmEbC7rv0YimsWf2Vkr9hb2lMbW1DMWcjmaXIvp1xpzd0yiNziBNyFlwjZq4jCqcG0LRt4nTVN3OC2iIcOeNGfjvhpib0uK6gAJPJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhJU0xaZHJZRXZLc08wK1BxbnhITDNPcGJaYUw0V3NmeEF2c1h1c2dTU1J1?=
 =?utf-8?B?SVl2bEJlUU1HSWJ6eHJFdDVwZERnM1BscDVnUXVFdHB5bFJLbWtNMnplYjBz?=
 =?utf-8?B?WG9BNDRXY3pJclRoZkFWWFVxMkF5SmhLSFZvenZJT2IweEpuM2kycEtTdXpK?=
 =?utf-8?B?Zm0xd0ZKeHM4aFhjL3FkWSt3ZVFNLzA4K1VOZFFCTVVLQ2NDN0FWMlBOeHBR?=
 =?utf-8?B?bHdQZXQza2p5TDFscmRkWGZiZWVDM2x1TjFmQ2JxSmlRcUVtZWlZZGlORkQ0?=
 =?utf-8?B?akZ4OW5uVmxubTVOSkllK2lVS3ZhUDZaOUx4TkxuWDVqeHZUTWE3Rzg3R05u?=
 =?utf-8?B?VVFXZm41MVhyVDU0K1VXMmFWUFhoSlRzWkEzZWc0cHhodHpWSHowMWtlUXNj?=
 =?utf-8?B?eG5hRzlIKzVWV3Eya2ZMZ2dsTDNiUDEyTTcwbG1jRHRWdWd4c2FJMkZuSnVS?=
 =?utf-8?B?QVo2NWtEUWVYeEtQL2N2dW5ubXRDeVp4SGd0c0ZZUEY5OTRQekFzM0dTbk1E?=
 =?utf-8?B?Z0VhSkd2dUN2THFWbWQrR1BaWDhCQ3BFc29OYXVRU0VrNGpWWjJrNFU0K0kx?=
 =?utf-8?B?eGZsdEJNaWhkbWkyaXhNKzBlRVZieEt3TUpNY0VhUFk4U3VjejdDWUhqUzhW?=
 =?utf-8?B?Y2h5OFpvZVZDaXhiZ3NPSEJ5dGVuWnFBbDByUW10OHBTclY0SzlSWW4zOXNl?=
 =?utf-8?B?OHArT2QrNlZUSzhGMG9scTl3eXFWSTZIQUVrejF0MTlXOUtaa2dhUHZsaGtL?=
 =?utf-8?B?blNHemRrTGVBV0Uzbm1zaWk4c3dnRXNmcGJpK3FFR3V4SGRFcG55OWk4QjdK?=
 =?utf-8?B?Mkp5OGlXOVRQZE9RMFErVDNRWFJCRm9oTHBrRytQZWw3Y0tINmZNMm5EaDNu?=
 =?utf-8?B?bEhxSmZXdi9HRVNtRXJOZEw2V0FtMXkwVldxQkxlRWZXRnNtbFNrTk5VaVhn?=
 =?utf-8?B?KzdScnVTcWxLTnhQTTVDbkhjZmV4akI1SFF5Y2lUdWh2ZXMwU2tOZFoxT3Vo?=
 =?utf-8?B?d0R6bFM5Q1IzNC9CUGE4M0ZBQmEwV1NPQU1SMk9yWWpYdkpuMXVHVklDNVVl?=
 =?utf-8?B?SmxKSTE4R0ExWXRIREo5RmJwZkRoWjhzWXBKMk1sTUlzdGJkTURtNzRFM0hJ?=
 =?utf-8?B?Wlh2RnZDRStEUERHODBWNkFJMk5icmd2RnlhS0lqY0c5Wm1IalgxMnFoVTFN?=
 =?utf-8?B?RmVydVZ0bldhZUV1Y0RJYXR3a0E5Nmx3UGd2UGFyam1QMytKTHlXd1hJd3ZP?=
 =?utf-8?B?cEtsWVJzVThHSnc3Q080VCsyQ014MEpaU1FwMTBpZ2FVN2tvZEJaUi8vTUwv?=
 =?utf-8?B?WHNkaTRCQUFDdVJMSXkyUHZRNllGVFNPYzkrRlZOeXQwa0hBcXRDMUthUytY?=
 =?utf-8?B?TUZReGQ5TkxSb0drV2w5ZlhIa3hYd00wQ1ZhQ0xZRmhETVhSanVpejJqNVZK?=
 =?utf-8?B?WTBZK3VFYzcrZ2ozSTFLNS9wUjZIOHU2UnhsWkVPa0EydGN5VTdLbFRCVWl5?=
 =?utf-8?B?ajVhZ1ZXamlCaWlCWlNML3pqWUpUN1kzdlRiUEh0KzVRVC9ZeTlxMWhoWjc3?=
 =?utf-8?B?eGZjRHdyOWE3citWVG5MSHQ5eTdldEFUWUs4NXpPNDlnRURrbGk2WjhVU2FV?=
 =?utf-8?B?Q29ybU13QU5UdHhRNFdCTERKd28wQytyam1jaUlIUmNPYTVFYzNYQXZ2Z0pI?=
 =?utf-8?Q?/O3nlkcqVWr4Kwq23gSq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c94b9d-206f-4bcf-aba2-08dc8f2a9b2c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:07:13.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1497


On 2024/6/14 18:52, Adrian Hunter wrote:
> On 13/06/24 04:43, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> The current framework is not easily extended to support new SOCs.
>> For example, in the current code we see that the SOC-level
>> structure `rk35xx_priv` and related logic are distributed in
>> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
>> which is inappropriate.
>>
>> The solution is to abstract some possible common operations of soc
>> as dwcmshc platform data. Each soc implements the corresponding callback
>> function according to its own needs.
>> dwcmshc framework is responsible for calling these callback functions
>> in those dwcmshc_xxx functions at proper positions.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 143 +++++++++++++++++++---------
>>   1 file changed, 99 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 38ab755aa044..ebae461019f9 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -206,6 +206,7 @@ struct rk35xx_priv {
>>   	u8 txclk_tapnum;
>>   };
>>   
>> +struct dwcmshc_ops;
>>   struct dwcmshc_priv {
>>   	struct clk	*bus_clk;
>>   	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>> @@ -214,6 +215,20 @@ struct dwcmshc_priv {
>>   	void *priv; /* pointer to SoC private stuff */
>>   	u16 delay_line;
>>   	u16 flags;
>> +
>> +	const struct dwcmshc_ops *ops;
> 	const struct dwcmshc_data *data;
>
>> +};
>> +
>> +struct dwcmshc_ops {
>> +	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>> +	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>> +	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
>> +	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
>> +};
>> +
>> +struct dwcmshc_data {
>> +	const struct sdhci_pltfm_data *pdata;
>> +	const struct dwcmshc_ops *ops;
>>   };
> Currently, ops and pdata values are unique to an individual
> dwcmshc_data, so it is simpler to put it altogether i.e.
>
> struct dwcmshc_data {
> 	const struct sdhci_pltfm_data pdata;
> 	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> 	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
> 	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
> };

Agree, I will change the code like this.

Thanks,

Chen

>>   /*******************************************************************************
>> @@ -815,6 +830,25 @@ static void rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_pr
>>   	}
>>   }
>>   
>> +static int rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
>> +{
>> +	struct rk35xx_priv *priv = dwc_priv->priv;
>> +	int ret = 0;
>> +
>> +	if (priv)
>> +		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
>> +	return ret;
>> +}
>> +
>> +static void rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
>> +{
>> +	struct rk35xx_priv *priv = dwc_priv->priv;
>> +
>> +	if (priv)
>> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> +					   priv->rockchip_clks);
>> +}
>> +
>>   static void th1520_sdhci_set_phy(struct sdhci_host *host)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -1167,30 +1201,65 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
>>   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>   };
>>   
>> +static const struct dwcmshc_ops dwcmshc_rk35xx_ops = {
>> +	.init = rk35xx_init,
>> +	.postinit = rk35xx_postinit,
>> +	.clks_enable = rk35xx_clks_enable,
>> +	.clks_disable = rk35xx_clks_disable,
>> +};
> So this becomes:
>
> static const struct dwcmshc_data sdhci_dwcmshc_rk35xx_pdata = {
> 	.pdata = {
> 		.ops = &sdhci_dwcmshc_rk35xx_ops,
> 		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> 			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> 	},
> 	.init = rk35xx_init,
> 	.postinit = rk35xx_postinit,
> 	.clks_enable = rk35xx_clks_enable,
> 	.clks_disable = rk35xx_clks_disable,
> };
>
> etc
>
>> +
>> +static const struct dwcmshc_ops dwcmshc_th1520_ops = {
>> +	.init = th1520_init,
>> +};
>> +
>> +static const struct dwcmshc_data dwcmshc_cv18xx_data = {
>> +	.pdata = &sdhci_dwcmshc_cv18xx_pdata,
>> +};
>> +
>> +static const struct dwcmshc_data dwcmshc_generic_data = {
>> +	.pdata = &sdhci_dwcmshc_pdata,
>> +};
>> +
>> +static const struct dwcmshc_data dwcmshc_rk35xx_data = {
>> +	.pdata = &sdhci_dwcmshc_rk35xx_pdata,
>> +	.ops = &dwcmshc_rk35xx_ops,
>> +};
>> +
>> +static const struct dwcmshc_data dwcmshc_th1520_data = {
>> +	.pdata = &sdhci_dwcmshc_th1520_pdata,
>> +	.ops = &dwcmshc_th1520_ops,
>> +};
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct dwcmshc_data dwcmshc_bf3_data = {
>> +	.pdata = &sdhci_dwcmshc_bf3_pdata,
>> +};
>> +#endif
>> +
>>   static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>>   	{
>>   		.compatible = "rockchip,rk3588-dwcmshc",
>> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
>> +		.data = &dwcmshc_rk35xx_data,
>>   	},
>>   	{
>>   		.compatible = "rockchip,rk3568-dwcmshc",
>> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
>> +		.data = &dwcmshc_rk35xx_data,
>>   	},
>>   	{
>>   		.compatible = "snps,dwcmshc-sdhci",
>> -		.data = &sdhci_dwcmshc_pdata,
>> +		.data = &dwcmshc_generic_data,
>>   	},
>>   	{
>>   		.compatible = "sophgo,cv1800b-dwcmshc",
>> -		.data = &sdhci_dwcmshc_cv18xx_pdata,
>> +		.data = &dwcmshc_cv18xx_data,
>>   	},
>>   	{
>>   		.compatible = "sophgo,sg2002-dwcmshc",
>> -		.data = &sdhci_dwcmshc_cv18xx_pdata,
>> +		.data = &dwcmshc_cv18xx_data,
>>   	},
>>   	{
>>   		.compatible = "thead,th1520-dwcmshc",
>> -		.data = &sdhci_dwcmshc_th1520_pdata,
>> +		.data = &dwcmshc_th1520_data,
>>   	},
>>   	{},
>>   };
>> @@ -1200,7 +1269,7 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>>   static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
>>   	{
>>   		.id = "MLNXBF30",
>> -		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
>> +		.driver_data = (kernel_ulong_t)&dwcmshc_bf3_data,
>>   	},
>>   	{}
>>   };
>> @@ -1213,18 +1282,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   	struct sdhci_pltfm_host *pltfm_host;
>>   	struct sdhci_host *host;
>>   	struct dwcmshc_priv *priv;
>> -	struct rk35xx_priv *rk_priv = NULL;
>> -	const struct sdhci_pltfm_data *pltfm_data;
>> +	const struct dwcmshc_data *data;
>>   	int err;
>>   	u32 extra, caps;
>>   
>> -	pltfm_data = device_get_match_data(&pdev->dev);
>> -	if (!pltfm_data) {
>> +	data = device_get_match_data(&pdev->dev);
>> +	if (!data) {
>>   		dev_err(&pdev->dev, "Error: No device match data found\n");
>>   		return -ENODEV;
>>   	}
>>   
>> -	host = sdhci_pltfm_init(pdev, pltfm_data,
>> +	host = sdhci_pltfm_init(pdev, data->pdata,
>>   				sizeof(struct dwcmshc_priv));
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>> @@ -1239,6 +1307,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   
>>   	pltfm_host = sdhci_priv(host);
>>   	priv = sdhci_pltfm_priv(pltfm_host);
>> +	priv->ops = data->ops;
> Becomes:
>
> 	priv->data = data;
>
>>   
>>   	if (dev->of_node) {
>>   		pltfm_host->clk = devm_clk_get(dev, "core");
>> @@ -1269,20 +1338,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>>   	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>>   
>> -	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
>> -		err = rk35xx_init(&pdev->dev, host, priv);
>> -		if (err)
>> -			goto err_clk;
>> -	}
>> -
>> -	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
>> -		err = th1520_init(&pdev->dev, host, priv);
>> +	if (data->ops && data->ops->init) {
> Becomes:
>
> 	if (data->init) {
>
> etc
>
>> +		err = data->ops->init(&pdev->dev, host, priv);
>>   		if (err)
>>   			goto err_clk;
>>   	}
>>   
>>   #ifdef CONFIG_ACPI
>> -	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
>> +	if (data == &dwcmshc_bf3_data)
>>   		sdhci_enable_v4_mode(host);
>>   #endif
>>   
>> @@ -1308,8 +1371,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   		dwcmshc_cqhci_init(host, pdev);
>>   	}
>>   
>> -	if (rk_priv)
>> -		rk35xx_postinit(host, priv);
>> +	if (data->ops && data->ops->postinit)
>> +		data->ops->postinit(host, priv);
>>   
>>   	err = __sdhci_add_host(host);
>>   	if (err)
>> @@ -1327,9 +1390,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   err_clk:
>>   	clk_disable_unprepare(pltfm_host->clk);
>>   	clk_disable_unprepare(priv->bus_clk);
>> -	if (rk_priv)
>> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> -					   rk_priv->rockchip_clks);
>> +	if (data->ops && data->ops->clks_disable)
>> +		data->ops->clks_disable(priv);
>>   free_pltfm:
>>   	sdhci_pltfm_free(pdev);
>>   	return err;
>> @@ -1340,7 +1402,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> -	struct rk35xx_priv *rk_priv = priv->priv;
>>   
>>   	pm_runtime_get_sync(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
>> @@ -1352,9 +1413,8 @@ static void dwcmshc_remove(struct platform_device *pdev)
>>   
>>   	clk_disable_unprepare(pltfm_host->clk);
>>   	clk_disable_unprepare(priv->bus_clk);
>> -	if (rk_priv)
>> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> -					   rk_priv->rockchip_clks);
>> +	if (priv->ops && priv->ops->clks_disable)
>> +		priv->ops->clks_disable(priv);
>>   	sdhci_pltfm_free(pdev);
>>   }
>>   
>> @@ -1364,7 +1424,6 @@ static int dwcmshc_suspend(struct device *dev)
>>   	struct sdhci_host *host = dev_get_drvdata(dev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> -	struct rk35xx_priv *rk_priv = priv->priv;
>>   	int ret;
>>   
>>   	pm_runtime_resume(dev);
>> @@ -1383,9 +1442,8 @@ static int dwcmshc_suspend(struct device *dev)
>>   	if (!IS_ERR(priv->bus_clk))
>>   		clk_disable_unprepare(priv->bus_clk);
>>   
>> -	if (rk_priv)
>> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> -					   rk_priv->rockchip_clks);
>> +	if (priv->ops && priv->ops->clks_disable)
>> +		priv->ops->clks_disable(priv);
>>   
>>   	return ret;
>>   }
>> @@ -1395,7 +1453,6 @@ static int dwcmshc_resume(struct device *dev)
>>   	struct sdhci_host *host = dev_get_drvdata(dev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> -	struct rk35xx_priv *rk_priv = priv->priv;
>>   	int ret;
>>   
>>   	ret = clk_prepare_enable(pltfm_host->clk);
>> @@ -1408,29 +1465,27 @@ static int dwcmshc_resume(struct device *dev)
>>   			goto disable_clk;
>>   	}
>>   
>> -	if (rk_priv) {
>> -		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>> -					      rk_priv->rockchip_clks);
>> +	if (priv->ops && priv->ops->clks_enable) {
>> +		ret = priv->ops->clks_enable(priv);
>>   		if (ret)
>>   			goto disable_bus_clk;
>>   	}
>>   
>>   	ret = sdhci_resume_host(host);
>>   	if (ret)
>> -		goto disable_rockchip_clks;
>> +		goto disable_soc_clks;
>>   
>>   	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>>   		ret = cqhci_resume(host->mmc);
>>   		if (ret)
>> -			goto disable_rockchip_clks;
>> +			goto disable_soc_clks;
>>   	}
>>   
>>   	return 0;
>>   
>> -disable_rockchip_clks:
>> -	if (rk_priv)
>> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>> -					   rk_priv->rockchip_clks);
>> +disable_soc_clks:
>> +	if (priv->ops && priv->ops->clks_disable)
>> +		priv->ops->clks_disable(priv);
>>   disable_bus_clk:
>>   	if (!IS_ERR(priv->bus_clk))
>>   		clk_disable_unprepare(priv->bus_clk);
