Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2023.outbound.protection.outlook.com [40.92.102.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1F13C90E;
	Thu,  9 May 2024 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221085; cv=fail; b=nYuuuzVhJ4PsqkYQmUTw+c6Ao1bfX4Rc/aHHKaruJn5H/lzRkdYykpY/MIyj7tjRO7igv9xnmp86sr1TwR+7/Am0jydNLYAKOfES4x6v2l3O7aPn437q+0mU2ZFImX9D9Pn5UIcEenkQeTC9WuAyhX1Sg2wrZKXMDPfdj/AewrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221085; c=relaxed/simple;
	bh=foXiiuqWg+BdRt70QrNCGV+UVhrfBJaE+PPa2bhuyoo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uvBKPQYnm3N2ueBi5JOtICjIgTR/jvgRQCtOcTXCzJSb2v2NP4PZABn4kCd5oS/N5/O4S0Y6Ccx3C4kq1EpL9MUkkAxGVZnOdaZKlTuMnCZSerHlXdaVE9DwMjFmjVl+uxhR8sEMBBvoOs/ayv3I3W373SidaPkGvfIpFXsMC9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uXNPDxNP; arc=fail smtp.client-ip=40.92.102.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uXNPDxNP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF70x4d/22vtw9RSv5c7sDSuvm74H6LjHugl4XHWFwo4FZ+CpP77ta2VdtNwEkY8PQ08CW+2QRuc5YDMtzTiq2RCbf0dsZKqy5uv7tr0dOANPJXjNeo6cPTe3iJrSyKNUM1wiaZxX/L7IjOEsE74sFyqAPJkNdCrgWiPrdtRgj7mhuyZU20dJkFpbVlywTPORWMQtLeY+MhCiw8p+88i6tW2U4yKgnqa+vgneYzp8saNCqP0sbdPHmTPBwapuqUkGVYlrc4qJwqoWMIgtAk3JO6Hp/JlE2t0seOF1Bp+bMxL9pGWSvI6vFNK3pxaR3CVAbhvjtdtI5qYLeG5kp6oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfh7M8wA6dJghLsnv2o1EJjUKGIEmzflrttT1aqbLjo=;
 b=IYsc9mPudhCdHAnp9OGUJLJhy4GGOqhRV5AWqKazslAaixwHb8yqSgK4mBcjoeZieGztNF0rdm1J02L0QJJsx552bzeoBo1EizIvGOm2KVPyPsZcZj0u9at6eY1tAloiTcwLAcS3ea1iG5dMOUIz58ebXmr1AqEhyxJblC5BBIqMk/w3pEsQCRu/516ldxqKEsdINE9iN8nnZMIQdeDupbKHlouIE8DtvdLAA48YBmYhJpmsHNteTdhAClg/4Y0IX2l8F+t7fQSds8rIxT9FqCKD4HxjawxlNkzafVYTw0c3frY+Oeku/mkIuyC1hSEznwkOlvbMbSWe2QgxjVJ8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfh7M8wA6dJghLsnv2o1EJjUKGIEmzflrttT1aqbLjo=;
 b=uXNPDxNPo1pAHb9dr2s9MrW012zIuamNSB9+jvsvHnRwUPanGyHsHYE0isrHzNflAU7JN7rnxnmAdAStcoYnT4dCQ2iSkF7BUYKBo5cT201STZvIuB5RaCyEfwRYxMDjaz95GUw33e2f5RxlLN6jBEguZrRWZnkvF3FevF7dvG+W5eCQo5eZQmPI7MbCGWxEba2KV358Dt/SSVyhttsGE3Dr4YWg+bw6QFOfzvQ3vH5cflJ3xvUVI6TMgQrm+TmyGxSJKR9iopOjqAVJbwLcA2dDF39bif3IfN0/yNIrbC931tFL7rnGlqC6DOKKOSBSSDk8fMQoSXDcfgP6gOLzHw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0966.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 02:17:56 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 02:17:56 +0000
Message-ID:
 <MA0P287MB282273829FCBA4BE58BD9CC2FEE62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 9 May 2024 10:17:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
To: Adrian Hunter <adrian.hunter@intel.com>, Chen Wang <unicornxw@gmail.com>,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com, unicorn_wang@outlook.com
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
 <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [sgsrKTymjnuDZwdr2tTwb+NPP5XqQDhC]
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0475d918-f368-475b-a9f7-d11f8037f178@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0966:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a3e99-53f9-4c9b-afa1-08dc6fce3c4c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	S1tFPTJqskAu/Th89lKf5DYsTrSXCyzyfavhNMOa1WTn9UfD0khb0gJEWy/6Wp8gW3ASnMSD3xlLmh8NcnXMiT/6GOaaFzOl9Z1aaMBZWgW8/laPgmMgntGbYW5igQ/EZxOBAFnX786h2RNZTRzGENwIQrZc0wt4oXkMSeUCsBqIzgdTCu8y1bWaQpaPtyP6vALU+XccxK1Bq5CY8BcnpKioD3967hZVF01k+ySzHw9Q6PBYD4V/v25YdcLUIfCStXig7W5vc39+kvUAVJ5/UwGAaRhPbVInezY28Hg5MgnhbKlpeGpYbyskxlQM2Mnwd7EilaqHd3XT0KZzrbo27S4zUmq6d9LYS15CydToeVdHLne6LO942O8B/ly4CTNtRsBbAfL/C6uqZ2Q8bL/GCaazGdjASeSjhmw2fx1TJyrhMNG9SYPIMFnPcDb3sIDyhjsY4MN9VDOReUyDZuH6laT9OEzFlt0IeUySWkgdJzz7JiKWnr16FX4Bi2Fx3VEMkEAxExep/cIpSz/cE9Jcy1ZUKWY4QXuldQg35hsCyUrOn0iG5pSwg6T2PtktPryDzFad8einvgEBBerYsOLSYnQM9HQ8iWXr/y6fnVXpxCsjl0FLtiaTXBBhzuO++zgy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0d4OStoeFlDaGdUQmVIbmZONGtCZzc4bE1pUHd6cXhHVFpjTTV4UGUrRUVj?=
 =?utf-8?B?OXNDOXh1dDZaYmlJSUJ0YzlLdHdzTit2YmE5bTVkVXEvYkRrd2VCUHRLN3dx?=
 =?utf-8?B?SlZ2WnVGM3o5VG5NczdrNEhiYS9qN0hzUVM1cW8yQVpDd25xbWpDNmZBUlNi?=
 =?utf-8?B?c3JRZWdzUlp0akJTTHlJSkVHRnZMSEdScDRmOW5JbWxLRnV3Z2tlWHhlS3ZV?=
 =?utf-8?B?K0h3emVMWTZyam02QTJSWEZBb2Z4U0ZrMDNlUWpaUGxvUG1qR0lzMnpwSWpZ?=
 =?utf-8?B?L2JVN1pZVTI2UGJRQnpmRE9Gb2dsRnlxd01jY2xieHFURVZPejVpOHlXL1Rs?=
 =?utf-8?B?c2xwL3FpRitHcVlTOVJ4TjhUWUN1V1l3MDVkbzJCdmVnN0hpRmhpK1FTTS9q?=
 =?utf-8?B?N3h2eXk2c2ZqQkovNUNJNTUwcVpsT1djZUU5VTc0cmxXcit6SWxKS1gwZjl4?=
 =?utf-8?B?L3dsQkdCZkdvVFVXZWNaYlk4TEVkMVJLemsvOEY2LzMranNJUjNYSjBtRUtY?=
 =?utf-8?B?bmM1eHVLWlM3K1A0MEErdGZTNW5wdlVzamVER25KNE1QV1FaL3llakNZWnV4?=
 =?utf-8?B?WEthUk1lTkVSNTVtNXV1cXdtRVpLdUdKN3hJNGlTdnNwbDZnUi9uaG1rSmll?=
 =?utf-8?B?cm9ZaGo0MjJ6aVczOGt1UEdTV2VIaW1KK2dOaEtHRXJCYzhJWFNkbkExQlVG?=
 =?utf-8?B?TWxjNjRjWjFZQmJHQlRnbmY0Z3Q1ZmFSU3QvUkRIRDBXdEVYaGFmb3BuWkJt?=
 =?utf-8?B?M0NlOE1CQmoxYzV4V2l6WTh1UWNEZkVkK1M0VFRDa3UxV1pIcWV1WWtpSzFn?=
 =?utf-8?B?VzVNajRTUEpFL0hLbFVUOEFacGUyeGUwVVFad2hHMVRaL3JmZ0lSaktDRUJ6?=
 =?utf-8?B?b2VmYitFRjVBKzRzRnJhQTRZV0RyL25yTm1KWWd0ZVVNaGVLV3d2YlJIcFlN?=
 =?utf-8?B?OGZydklqczQ3amIweHcwZWRQcUd2RkZET1VMSHFXVno0L3N3NDlNbUE5Ymwz?=
 =?utf-8?B?R0Mxb2pPOE5KeDFmRWxhY29vK2lPMzhIV1JqU0ZQTGY4V3A3aE92T0hNaUhU?=
 =?utf-8?B?RG1WVTFpWFROZDBncUxzbVJjRGtvT1l0TXZ1SkViYkJJOENJbjU5RGsyTk8x?=
 =?utf-8?B?K1N0SWdVcDFpYkY0K3MxazJuaXRzZzBZeVVQTTh2QzYwT0hoMWlhejZPam84?=
 =?utf-8?B?cXNBejBLTnBFaVUxUGFqOU9saGx2Y1cwNkNETFUxNjR1TnNqdHMxVy95NThX?=
 =?utf-8?B?ajlZSUNDenZKZFozUXgwVFVjbzJXOUo3UlpNTFZsTGUySE9paEU1a2dETTJi?=
 =?utf-8?B?b0dnenFRU283cmhteHBHQkgwZDYrWVJqT2Q1NElhZS96TmpGanc2QTE1R0Nn?=
 =?utf-8?B?bDQxOFpWZkExWjJiQ1QzRDVQemh1NjRpRlpvbm5aYWZySUVEY0VKREUySnZF?=
 =?utf-8?B?VmhKYzJSSDlOS1FQYldWVFR1dDdpMTBQVk1sbDNHRndtcE5zSnMwL0tSbmlQ?=
 =?utf-8?B?RXlMek9WZnJ6S01YNDJEVURHZ2VLS0FNM0JTWDdFam9HZWdUK25NbUt5Q2Nw?=
 =?utf-8?B?WVJncEVkbTRIc0xUYzdITVJOQVZNcVFGN0Naa3ppQVJJZXdVY1VGalJrUW1x?=
 =?utf-8?B?b2tScXd4V25hR3JFc1hQcjd0MTdmZFJoWnd3Y0UrcFdYR1d6UWxtUDhGdzlk?=
 =?utf-8?Q?PTY074eCojiaQjgIOxEC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a3e99-53f9-4c9b-afa1-08dc6fce3c4c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 02:17:56.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0966


On 2024/4/29 15:08, Adrian Hunter wrote:
> On 28/04/24 05:32, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> The current framework is not easily extended to support new SOCs.
>> For example, in the current code we see that the SOC-level
>> structure `rk35xx_priv` and related logic are distributed in
>> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
>> which is inappropriate.
>>
>> The solution is to abstract some possible common operations of soc
>> into virtual members of `dwcmshc_priv`. Each soc implements its own
>> corresponding callback function and registers it in init function.
>> dwcmshc framework is responsible for calling these callback functions
>> in those dwcmshc_xxx functions.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
>>   1 file changed, 91 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 39edf04fedcf..525f954bcb65 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -214,6 +214,10 @@ struct dwcmshc_priv {
>>   	void *priv; /* pointer to SoC private stuff */
>>   	u16 delay_line;
>>   	u16 flags;
>> +
>> +	void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>> +	int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
>> +	void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);
> Normally the ops would be part of platform data.  For example,
> sdhci-of-arasan.c has:
>
> 	struct sdhci_arasan_of_data {
> 		const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> 		const struct sdhci_pltfm_data *pdata;
> 		const struct sdhci_arasan_clk_ops *clk_ops;
> 	};
>
> And then:
>
> 	static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> 		.soc_ctl_map = &rk3399_soc_ctl_map,
> 		.pdata = &sdhci_arasan_cqe_pdata,
> 		.clk_ops = &arasan_clk_ops,
> 	};
> 	etc
>
> 	static const struct of_device_id sdhci_arasan_of_match[] = {
> 		/* SoC-specific compatible strings w/ soc_ctl_map */
> 		{
> 			.compatible = "rockchip,rk3399-sdhci-5.1",
> 			.data = &sdhci_arasan_rk3399_data,
> 		},
> 		etc
>
> So, say:
>
> struct dwcmshc_pltfm_data {
> 	const struct sdhci_pltfm_data *pltfm_data;
> 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> 	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
> 	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
> }
>
> Or if the ops are mostly the same, it might be more convenient to
> have them in their own structure:
>
> struct dwcmshc_pltfm_data {
> 	const struct sdhci_pltfm_data *pltfm_data;
> 	const struct dwcmshc_ops *ops;
> }

hi, Adrian,

I thought about it for a while, and I would like to continue discussing 
this issue as follows.

I feel like it would be simpler to put it at the dwcmshc_priv level 
based on the ops involved in the code so far. Judging from the SOCs 
currently supported by dwcmshc, the ops I abstracted only operate data 
below the dwcmshc_priv level, and these ops are not used by most SOCs.
- postinit: only required by rk35xx
- init: involves rk35xx and th1520, and the new soc(sg2042) I want to add.
- clks_enable/clks_disable: only rk35xx and the sg2042 I want to add

In particular, for dwcmshc_suspend/dwcmshc_resume, we have already 
obtained dwcmshc_priv. If ops is to be placed at the platformdata level, 
we have to use device_get_match_data to obtain data again, which feels a 
bit unnecessary.

What do you think?

Thanks,

Chen

[......]


