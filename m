Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852237106A;
	Thu, 21 May 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384525; cv=fail; b=diIBGnChbT4wndKEkYl3G/csbgLDXNJ17Gwlrvvrv8IhJbWxj0w5mNk+ERTV7kLbL+9CaiK7QLYlvW/EjK9omGY4BcgFmnp5KZ72lKh602wSzmkfeoDc1C4nm47TRVjpYXCG8kl8ZOtfrZGeMAGyRpO/Fb+ldevpNVGnnCf42CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384525; c=relaxed/simple;
	bh=evUdHZXXQNCZtzsYGL1UDXegKFMqoKgpJGl0irE3oVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ON6bi+5CtipAiLg7uMqme3HcGjLuqwljUt5hhAQX8vxfG3qugEPEe05+DI32BTtz21BAij0YwsqPLbW2lpzPhHzP2PuDJjI8JZkBSpfo5sv2HhGFwnSaI1MrvYAJYF50NtBjebuuJYP5HcVEd26AAT3PCpqTgFVKiSjuWuVNUds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XokDkgQ1; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XokDkgQ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag0ppVYgpuEHikcnjOP4yHAW4qLjpvOrxe7zN76Dk8Bb0rFcIiv6yvlH9ZZN8gDL2r0xPlaruBbzZ3cxRJfLXDq7cxLBX9u9b8y3ffOq4LwBo4b96SgFF0cWn1XKAL8cblSAQVcrGI6Y4yY58cuLOsYRXXwY7xI5dfzJHRaXcX2NS+KITMGPlRh4rO/EQUVRcQqEHxTowfPawHx2eYNegaVfDH5MYvoun71SF1W1ceaaEuwJTqbQ2UZFfK+pz7OichM4S8w7XbR2Yj+JmndgAHYROrVG9gKMTX3knMWKxVXipOU0CsyW0Ilf9q2180VjAwm816E6i6noF8qkQ1LRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SKC6wI2XisWVieo+NES9yWRlleMQnrxeSJx8DYFw50=;
 b=f4+ElqvZp0ebILBIDoaK/5h1pPfpD0k9fzdi9h5e0VVKjrvTl9p1MmcvlsW3cukf/c+WHEo6MvBoypwk0qrTLLBiTAjC+8ejtksTqD2+Govpuy5NNtgxKUk7Abj9d5RckFSv8+Gr9khuUteE0lTwqtR2cpTyVZa7nyUGkikeTVEPSzuLCtv50qpo9renic9wHjtt9pvN0ls98pAIA1KV3RRyNAePRnfS/bQbCOsQRb1dOkfLX/kMlfwCinDT88WjxPVr4pvdiqJnn0oQhBCpqn33xQZT24TYfH1syR60IfSbZhiZWyF87ojIRJ4JBik1eRZ4iZjvp3yJPbr/2DfUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SKC6wI2XisWVieo+NES9yWRlleMQnrxeSJx8DYFw50=;
 b=XokDkgQ17unFbSYsOT4Vid/VqaaHrdodu1EEn4vrYb2hA8nZ5rmLxuf3K3+ePVSu8A2ZN9xpCXPhhvLjNBtWoS0OYVWlkCZh1/MG3ziDqK1WiJBgL/kXadDVQSub/qrDyJjbitdNkg2smiTF10S6MjMQpOzr8tGccvoM3kIPCqXeMQLQ0c8Z+v6qLZncZp2ha5qiXWeQToUcpckh2nb2xczPCubvQmjgs5dLBpgIyFfSKe2kaUK3k2z7GW38wFKBMY3v8KyhRyVSQnNiNfy/I3n0/CB7iEkti2Rwy52ifBkEOelwTqHcDO1dIQTjMk4NYd7D9EZz73gvi2LTQChK8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7568.namprd03.prod.outlook.com (2603:10b6:806:43a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 17:28:36 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:28:35 +0000
Message-ID: <3934027d-a865-40f9-8350-0027865a3682@altera.com>
Date: Thu, 21 May 2026 22:58:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] mmc: sdhci-cadence: add Cadence SD6HC support
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-9-tanmay.kathpalia@altera.com>
 <6736df61-0adf-41d4-ba45-f1fa08998a58@intel.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <6736df61-0adf-41d4-ba45-f1fa08998a58@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5a3759-5a19-494c-0e77-08deb75e630d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|4143699003|18002099003|56012099003|3023799007|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kgD3pBtop/W1ZWCg67+a8JAtmoS8gz5br2HteZV69oRLHIrmsZEJJKiOovkBPsowUak8RzkWZHEFET4M7NpdIKvad7e+U85Rs8sulj30W95QtaHDbt6vMK8Q3e3SMNQriLaQRwkE282+Mr6Jqk7IkV2siAQ0kKiFP7OB6ajhyXdXar+lHcFJIhK7Fo6WZZbiyJdCgTJgzo2Lu1+pg6xAG7pYoa4hOS/i7nWuq5yJiZLv5CqWJkKFgu62qPlLIg57Tb2FX+JSxXSjQ8D6Ii7ohh89o2NgBENqYUw4IJ0JBY/FP0JWdn1fADBRpdnRrgd71IEzOdGePk397xVoz60dnlyjXuJupY8ZYu5i/3TS6fpy29tCgAFquXQ/0YFSkcn0K/NCt3lB25W6Nq3++o766br6QHeaPNrhbVpXixPE5Ec3V3GMpDelUONxiw/lQSvgpHFWnLQmuXtZo/0U5IYYPRuyb7hqM5vZ/MhQdIAkUW928rM0zVVQJMbTTdH5eYPw6W88Yu4Q73Hvbdyv6Ft02eRqNqLvD0nKpPZ0jInbVsNaEuAMuZ6D9j4n9LB1erU9nmhUMijJTskBVV3jBUrFvJnZBdbRWH60R8YEnXqKL+O7JDQfpgL/lElDKDRe3zQaCcbikqB1cSEtYfrmlnoiBy88OyVLNQPoxNnGm3Roudyc8z8okXumwBdYOyO5GNIC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(4143699003)(18002099003)(56012099003)(3023799007)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGNEVjdWSzRaT1VoOE9qQ3d0MlI3aENldVA0bU8zL0JVcnFxOElzYmN4T0tl?=
 =?utf-8?B?RjFCcnllTUVLVUVuelowZGJicHBmeDVVWTUzY2dnU3ZQT3VNNGdmeFhZSDRp?=
 =?utf-8?B?K0h2clpodHlYVHJPcXB6OWptcHJFT3JCd1UyZEZWMkdhWHN1Z3o3dlJjT1hn?=
 =?utf-8?B?d2pvbzdvTSsvRnViU1AwaGwxZkNZYzJEMWFWeXRMNG1seUlFMVJ1TVBUZHVr?=
 =?utf-8?B?KzZFdXNZRlR1cHBrU3dleWRSdEV4Q0wrNVNqbWFHSXVGRUNxTW1oLzArWm1z?=
 =?utf-8?B?Q2tkOGlQNGNFZkpDa21IMTJDR3N1OHNKbVVjQmdZdjRLU24zdEtQTEhYanpP?=
 =?utf-8?B?VmgwOVpKZG9UQXhaRmlvTGdCa3VmMXdGRm11Ui9BNHR2bW8yNWdTQk92cVow?=
 =?utf-8?B?bGUwKzlSdjlWVU9RTFdtN09sTDdsa1UvdVM5alZvVldXOWlFWTJWd2tEQ3l4?=
 =?utf-8?B?Ync1U0FLdXI3OU1NaWVRL1B2cGQxKy9hcUdEcE8rYVlDZm8zUVovZDE3Y3RJ?=
 =?utf-8?B?YnZTdENheW9SZWxOZ2FnUzNtY3VKeFMrUlk5bDJsenQ3Sm1vTXJBLzdQMUFk?=
 =?utf-8?B?bVRObXk1V25rYkE4R1dJWWR0S2kxUHZGM3M1cHlEZXdETlRXWDBUOU5XQ0xM?=
 =?utf-8?B?OVhFajRsb1ZlRjRLU3ZYVHk3ZjZrSW9kOTVaNVp4b2IvOUMzUEgwZmFOZTBS?=
 =?utf-8?B?aW9ySnY2KzJuemR3bWxFRFBybTQrRU5KVXZXYTJwbzJUaUY2UXJkSUowUkVS?=
 =?utf-8?B?ZGsxZ2hISFN4V1FxcVZzWDc1U093Rko5RzhORVU0bUVVUlZrYzhIamMrdS82?=
 =?utf-8?B?dUl6bkpadzYyM3BIV2o1UXBERm5rdEg5RkJ2YXNralBxRi9jcXo0QUJGQ0pi?=
 =?utf-8?B?NUxMWDBxZFYxZUNmMUtxM1hjM2hIWmkvYk5tbndFUEJWTjJLd1NHaklUWkVR?=
 =?utf-8?B?RW55VkhEZklTRityY0V3TVFBZUMyUkVUREZWcXl3RndvYnNZZ0VPUzZJL2xa?=
 =?utf-8?B?ZzVKNTA4U2Y3OUZqZDhORXFLMVBvVGVlNXhjMmhJclFpVHcxakQ4YUNTaVVR?=
 =?utf-8?B?YmdLSEJDMXhHaDZ4eUM0RUJJK2pFOFRsMExkN0F6SkpKdmk0Wm9rVmViT0Z6?=
 =?utf-8?B?a2RSaTlabHhJUVR2aVZjdzV6b0wwZlhsaUg5aFc4NW4vbVhZcklYR2t5Q0Vi?=
 =?utf-8?B?ZkQxaEhGM1JHLzExejM0bzdXR2R3QUVmczFYQUIwUmRXU0FJOVVoVEk1bTZG?=
 =?utf-8?B?blR3NnF0d0M1UmovaTFLZlZKOVJEanRha3BlYXhHZWhKTm1iei9oS2p4ZCt4?=
 =?utf-8?B?aWdxUHpvRndYQm5VRkgvU1UxRVFFVDg0V2YrUUhQMHpoU2JXR1lsaDRFRlow?=
 =?utf-8?B?QzM4Q0w4VkdrZFVhb2JtaGZqSExOQ3dLNnRlbElieDdkUzAyMW13ZDNRNU04?=
 =?utf-8?B?MWlQR1gvTk51eXJvUi9odklNaUxXTVhvRFpHY1UvYUM1OUxCTllOVGYwb3k1?=
 =?utf-8?B?SjNZMFc5dnljNDZobDFGTWcwcjR0aVc4VHdCVDcvOEdGVXNVNVZ4NnFlcHlm?=
 =?utf-8?B?R0cxTkZrQzBDWnNheFJIK2dNRTZqSWNVZys0a3dCbVg0OTBhM1duYjM3ak44?=
 =?utf-8?B?cEQrSitRTTNaRW5Oa3FvcklMbStPSzF4NEN0SVpodElvV1ZDcmFoQmd1Mkp0?=
 =?utf-8?B?NkMwODQrNnVEMjRBQlF0OW1VbFo5V1VZbGZMUDFlQ0c1R3VmSzY2OElNcnlq?=
 =?utf-8?B?WUNTVktnakJOY2FZeG1zWEpVakp2RHZPaU84R1cvVmlkdWMvUFg3dXRuWmZM?=
 =?utf-8?B?WU41M25nM1U2azRHeEFGUm15ckQreWd0djVRclJvWFRNRXYrQWtXMVJWWDJW?=
 =?utf-8?B?eU9hK1RJS0xXVS93STJCWHQzS2JDd1Zia1lCS3FCOWJtTUZ4R0Z3dmpnUjF5?=
 =?utf-8?B?ZTN6UUVwSm92OHpPU1d4eDVjZmFZTUZ3S1EwRFdDNksyZTBDeHZzbDF6d3Rr?=
 =?utf-8?B?SXU1aXNtY1FWYnFwU0dHb2RaRjB1V2RWV2tJLzFFVFYxU1RGNFlrK1VZeTBQ?=
 =?utf-8?B?SUFuSXFwWkpSV01VKzREOVV1NkZCU0lQV0s0OGRlZ2p3WVFja1pKSXdDUVdF?=
 =?utf-8?B?b3JzRVVBZjlaNkQ1cHUzQVpUbHQyQk95azdKSGlINXkvNkwzNEkzby9tMjVp?=
 =?utf-8?B?ZVE0RnZOaHlSU042b2Y0QjFKV3o4T29kUW5meFROMzZITjhRbG5BVFczTXdJ?=
 =?utf-8?B?Tm80em5lcEtkcUFjOHhZOENYZHZBb1FEM3hSbno4ZVoyRk00UnN0V1poZm1n?=
 =?utf-8?B?cGpFV1hVMU1Mc1Z1c09ka0xQenZ0bXJsUzNDMEJCMDFOQXhKTE9aQ1NKVGha?=
 =?utf-8?Q?1/go1QYfl3GiZYUg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5a3759-5a19-494c-0e77-08deb75e630d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:28:35.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeqT+MXgGlMypa90dm+Uz+S9V6SBkG+1Pna2/KjMVM7kCRp0//AfsS0DqBqdc8gQEl5hjHog4t8XmT2V2+7d9iNUP1JLt6toJvNkF60pynM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7568

Hi Adrian,

Thanks for your feedback.

On 5/19/2026 8:59 PM, Adrian Hunter wrote:
> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>> The Cadence SD6HC is the sixth-generation SD Host Controller used in
>> Agilex5 SoCs. Its PHY differs substantially from the SD4HC: it
>> requires per-speed-mode IO cell timing parameters and a DLL-based
>> delay line to achieve correct signal margins across all speed grades
>> from Default Speed to HS400.
>>
>> Support is implemented in a new sdhci-cadence6.c alongside the
>> existing v4 code, now in sdhci-cadence4.c. Shared structures and the
>> v6 function interface are declared in a new sdhci-cadence.h header.
>> The common driver paths select between v4 and v6 PHY operations based
>> on the SDHCI specification version reported by the controller.
>>
>> The new compatible string "cdns,sd6hc" identifies SD6HC hardware in
>> device tree.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   MAINTAINERS                                   |    7 +
>>   drivers/mmc/host/Makefile                     |    3 +-
>>   drivers/mmc/host/sdhci-cadence.h              |  113 ++
>>   .../{sdhci-cadence.c => sdhci-cadence4.c}     |   92 +-
>>   drivers/mmc/host/sdhci-cadence6.c             | 1051 +++++++++++++++++
>>   5 files changed, 1228 insertions(+), 38 deletions(-)
>>   create mode 100644 drivers/mmc/host/sdhci-cadence.h
>>   rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence4.c} (91%)
>>   create mode 100644 drivers/mmc/host/sdhci-cadence6.c
> The new file names seem slightly misleading since sdhci-cadence4.c
> is the main driver as well as supporting V4, whereas sdhci-cadence6.c
> is most of V6 support.
>
> There doesn't seem much to gain from having a separate sdhci-cadence6.c.
> Isn't it simpler to just put it all in 1 source file.

I believe keeping them separate improves maintainability for the
following reasons:

1. V4 and V6 PHY programming models are fundamentally different:
     a. SD4HC reads pre-computed delay values directly from DT and
     writes them one-to-one into PHY registers.
     b. SD6HC takes only a few timing parameters (IO cell delay, delay
     element size) from DT and derives all PHY and SDHC register
     programming values inside the driver through a calibration
     sequence.
2. The V6 PHY logic alone is more than 1000 lines. Merging it into
the existing file would make sdhci-cadence4.c significantly harder
to review, and maintain.
3. Keep code structure aligned with U-Boot, where V6 handling is
also separated.

That said, I am open to merging into one file if you think that is
better for maintainability in this driver. I can do that in v2.

>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 27fefd92744c..4856450bfd36 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23863,6 +23863,13 @@ L:	linux-mmc@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/mmc/host/sdhci-brcmstb*
>>   
>> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) CADENCE DRIVER
>> +M:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> +L:	linux-mmc@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> +F:	drivers/mmc/host/sdhci-cadence*
>> +
>>   SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
>>   M:	Adrian Hunter <adrian.hunter@intel.com>
>>   L:	linux-mmc@vger.kernel.org
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index ee412e6b84d6..f3b2f43e751e 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -80,7 +80,8 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
>>   
>>   obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
>>   obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
>> -obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
>> +sdhci-cadence-y				+= sdhci-cadence4.o sdhci-cadence6.o
>> +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)	+= sdhci-esdhc-mcf.o
>>   obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
>>   obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>>   obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
>> diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
>> new file mode 100644
>> index 000000000000..05b8d8f16543
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-cadence.h
>> @@ -0,0 +1,113 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2026 Altera Corporation
>> + *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> + *
>> + * Cadence SD/SDIO/eMMC Host Controller driver - common header
>> + * Shared definitions and structures for the Cadence SDHCI driver.
>> + * Contains private data and declarations for SD6HC-specific functions
>> + * called by the main driver in sdhci-cadence4.c.
>> + */
>> +
>> +#ifndef _MMC_HOST_SDHCI_CADENCE_H
>> +#define _MMC_HOST_SDHCI_CADENCE_H
>> +
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/clk.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mmc/host.h>
>> +
>> +#include "sdhci-pltfm.h"
>> +
>> +/* HRS - Host Register Set (specific to Cadence) */
>> +#define SDHCI_CDNS_HRS04		0x10		/* PHY access: address port */
>> +#define SDHCI_CDNS_HRS05		0x14		/* PHY access: data port */
>> +
>> +/*
>> + * The tuned val register is 6 bit-wide, but not the whole of the range is
>> + * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
>> + * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
>> + */
>> +#define SDHCI_CDNS_MAX_TUNING_LOOP	40
>> +
>> +/**
>> + * struct sdhci_cdns_priv - Cadence SDHCI private controller data
>> + * @hrs_addr: Base address of Cadence Host Register Set (HRS) registers.
>> + * @ctl_addr: Base address for write control registers.
>> + *            Used only for "amd,pensando-elba-sd4hc" compatible controllers
>> + *            to enable byte-lane writes.
>> + * @wrlock: Spinlock for protecting register writes (Elba only).
>> + * @enhanced_strobe: Flag indicating if Enhanced Strobe (HS400ES) is enabled.
>> + * @priv_writel: Optional SoC-specific write function for register access.
>> + *               Used for Elba to ensure correct byte-lane enable.
>> + * @rst_hw: Hardware reset control for the controller.
>> + * @phy: Opaque pointer to variant-specific PHY data.
>> + *       For SD4HC: points to struct sdhci_cdns4_phy.
>> + *       For SD6HC: points to struct sdhci_cdns6_phy.
>> + */
>> +struct sdhci_cdns_priv {
>> +	void __iomem *hrs_addr;
>> +	void __iomem *ctl_addr; /* write control */
>> +	spinlock_t wrlock; /* write lock */
>> +	bool enhanced_strobe;
>> +	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val,
>> +			    void __iomem *reg);
>> +	struct reset_control *rst_hw;
>> +	void *phy;
>> +};
>> +
>> +/*
>> + * sdhci_cdns_get_priv - Helper to retrieve Cadence private data from sdhci_host
>> + * @host: Pointer to struct sdhci_host.
>> + *
>> + * Return: Pointer to struct sdhci_cdns_priv.
>> + */
>> +static inline void *sdhci_cdns_get_priv(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +
>> +	return sdhci_pltfm_priv(pltfm_host);
>> +}
>> +
>> +/**
>> + * sdhci_cdns6_set_uhs_signaling - Program PHY registers for a specific timing mode.
>> + * @host: Pointer to struct sdhci_host.
>> + * @timing: MMC timing mode (MMC_TIMING_*).
>> + */
>> +void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing);
>> +
>> +/**
>> + * sdhci_cdns6_set_tune_val - Set the PHY tuning value.
>> + * @host: Pointer to struct sdhci_host.
>> + * @val: Tuning value to program.
>> + *
>> + * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
>> + */
>> +int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val);
>> +
>> +/**
>> + * sdhci_cdns6_phy_probe - Probe and initialize Cadence SD6HC PHY parameters
>> + * @pdev: Platform device pointer
>> + * @priv: Pointer to Cadence private data structure
>> + *
>> + * Return: 0 on success or a negative error code.
>> + */
>> +int sdhci_cdns6_phy_probe(struct platform_device *pdev,
>> +			  struct sdhci_cdns_priv *priv);
>> +/**
>> + * sdhci_cdns6_hw_reset - Perform hardware reset of the Cadence SDHCI controller.
>> + * @host: Pointer to struct sdhci_host.
>> + */
>> +void sdhci_cdns6_hw_reset(struct sdhci_host *host);
>> +
>> +/**
>> + * sdhci_cdns6_phy_init - Initialize the SD6HC PHY with current settings.
>> + * @priv: Pointer to Cadence private data structure.
>> + *
>> + * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
>> + */
>> +int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv);
>> +
>> +#endif /* _MMC_HOST_SDHCI_CADENCE_H */
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence4.c
>> similarity index 91%
>> rename from drivers/mmc/host/sdhci-cadence.c
>> rename to drivers/mmc/host/sdhci-cadence4.c
>> index fe3f7c5109fc..283d22328248 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence4.c
>> @@ -2,22 +2,17 @@
>>   /*
>>    * Copyright (C) 2016 Socionext Inc.
>>    *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>> + * Copyright (C) 2026 Altera Corporation
>>    */
>>   
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> -#include <linux/iopoll.h>
>>   #include <linux/module.h>
>> -#include <linux/mmc/host.h>
>> -#include <linux/mmc/mmc.h>
>> -#include <linux/of.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/reset.h>
>>   
>> -#include "sdhci-pltfm.h"
>> +#include "sdhci-cadence.h"
>>   
>>   /* HRS - Host Register Set (specific to Cadence) */
>> -#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
>> +/* HRS04 (PHY access) bitfields (SD4HC) */
>>   #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
>>   #define   SDHCI_CDNS_HRS04_RD			BIT(25)
>>   #define   SDHCI_CDNS_HRS04_WR			BIT(24)
>> @@ -71,13 +66,6 @@
>>   #define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
>>   #define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
>>   
>> -/*
>> - * The tuned val register is 6 bit-wide, but not the whole of the range is
>> - * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
>> - * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
>> - */
>> -#define SDHCI_CDNS_MAX_TUNING_LOOP	40
>> -
>>   struct sdhci_cdns4_phy_param {
>>   	u8 addr;
>>   	u8 data;
>> @@ -88,16 +76,6 @@ struct sdhci_cdns4_phy {
>>   	struct sdhci_cdns4_phy_param phy_params[];
>>   };
>>   
>> -struct sdhci_cdns_priv {
>> -	void __iomem *hrs_addr;
>> -	void __iomem *ctl_addr;	/* write control */
>> -	spinlock_t wrlock;	/* write lock */
>> -	bool enhanced_strobe;
>> -	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>> -	struct reset_control *rst_hw;
>> -	struct sdhci_cdns4_phy *phy;
>> -};
>> -
>>   struct sdhci_cdns4_phy_cfg {
>>   	const char *property;
>>   	u8 addr;
>> @@ -206,13 +184,6 @@ static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>>   	return 0;
>>   }
>>   
>> -static void *sdhci_cdns_get_priv(struct sdhci_host *host)
>> -{
>> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -
>> -	return sdhci_pltfm_priv(pltfm_host);
>> -}
>> -
>>   static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>>   {
>>   	/*
>> @@ -248,6 +219,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>>   	u32 tmp;
>>   	int i, ret;
>>   
>> +	if (host->version >= SDHCI_SPEC_420)
>> +		return sdhci_cdns6_set_tune_val(host, val);
>> +
>>   	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
>>   		return -EINVAL;
>>   
>> @@ -328,8 +302,11 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>>   	 * The delay is set by probe, based on the DT properties.
>>   	 */
>>   	if (host->timing != MMC_TIMING_MMC_HS200 &&
>> -	    host->timing != MMC_TIMING_UHS_SDR104)
>> +	    host->timing != MMC_TIMING_UHS_SDR104) {
>> +		dev_dbg(mmc_dev(host->mmc), "Tuning skipped (timing: %d)\n",
>> +			host->timing);
>>   		return 0;
>> +	}
>>   
>>   	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
>>   		if (sdhci_cdns_set_tune_val(host, i) ||
>> @@ -353,6 +330,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/* Block gap tuning is only required for SD4HC, not for SD6HC */
>> +	if (host->version >= SDHCI_SPEC_420)
>> +		return 0;
>> +
>>   	return sdhci_cdns_tune_blkgap(host->mmc);
>>   }
>>   
>> @@ -388,6 +369,10 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>>   	/* For SD, fall back to the default handler */
>>   	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
>>   		sdhci_set_uhs_signaling(host, timing);
>> +
>> +	/* For host controller V6, set SDHCI and PHY registers for UHS signaling */
>> +	if (host->version >= SDHCI_SPEC_420)
>> +		sdhci_cdns6_set_uhs_signaling(host, timing);
>>   }
>>   
>>   /* Elba control register bits [6:3] are byte-lane enables */
>> @@ -484,6 +469,16 @@ static const struct sdhci_ops sdhci_cdns4_ops = {
>>   	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>>   };
>>   
>> +static const struct sdhci_ops sdhci_cdns6_ops = {
>> +	.set_clock = sdhci_set_clock,
>> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>> +	.set_bus_width = sdhci_set_bus_width,
>> +	.reset = sdhci_reset,
>> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
>> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>> +	.hw_reset = sdhci_cdns6_hw_reset,
>> +};
>> +
>>   static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>>   	.pltfm_data = {
>>   		.ops = &sdhci_cdns4_ops,
>> @@ -511,6 +506,12 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>>   	},
>>   };
>>   
>> +static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
>> +	.pltfm_data = {
>> +		.ops = &sdhci_cdns6_ops,
>> +	},
>> +};
>> +
>>   static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>   					     struct mmc_ios *ios)
>>   {
>> @@ -607,15 +608,24 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   			return ret;
>>   	}
>>   	sdhci_enable_v4_mode(host);
>> -	__sdhci_read_caps(host, &version, NULL, NULL);
>> -
>>   	sdhci_get_of_property(pdev);
>>   
>>   	ret = mmc_of_parse(host->mmc);
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = sdhci_cdns4_phy_probe(pdev, priv);
>> +	/*
>> +	 * For SD4HC, read capabilities with fixed version override.
>> +	 * For SD6HC, sdhci_add_host() will automatically read capabilities
>> +	 * and version from the host controller registers.
>> +	 */
>> +	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
>> +		__sdhci_read_caps(host, &version, NULL, NULL);
>> +		ret = sdhci_cdns4_phy_probe(pdev, priv);
>> +	} else {
>> +		ret = sdhci_cdns6_phy_probe(pdev, priv);
>> +	}
>> +
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -642,7 +652,11 @@ static int sdhci_cdns_resume(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = sdhci_cdns4_phy_init(priv);
>> +	if (host->version >= SDHCI_SPEC_420)
>> +		ret = sdhci_cdns6_phy_init(priv);
>> +	else
>> +		ret = sdhci_cdns4_phy_init(priv);
>> +
>>   	if (ret)
>>   		goto disable_clk;
>>   
>> @@ -677,6 +691,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>>   		.compatible = "cdns,sd4hc",
>>   		.data = &sdhci_cdns4_drv_data,
>>   	},
>> +	{
>> +		.compatible = "cdns,sd6hc",
>> +		.data = &sdhci_cdns6_drv_data,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
>> diff --git a/drivers/mmc/host/sdhci-cadence6.c b/drivers/mmc/host/sdhci-cadence6.c
>> new file mode 100644
>> index 000000000000..34d3570a0bbb
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-cadence6.c
>> @@ -0,0 +1,1051 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * PHY and host controller support for Cadence SD6HC SDHCI
>> + *
>> + * This file provides comprehensive support for Cadence's sixth-generation
>> + * SDHCI controller (SD6HC), handling both low-level PHY operations and
>> + * high-level host controller programming. The implementation includes PHY
>> + * initialization and timing calculations, DLL (Delay-Locked Loop)
>> + * management and configuration, host controller register programming for
>> + * IO delay compensation and signal timing optimization.
>> + *
>> + * Copyright (C) 2026 Altera Corporation
>> + *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> + */
>> +
>> +#include "sdhci-cadence.h"
>> +
>> +/* IO Delay Information */
>> +#define SDHCI_CDNS_HRS07		0x1c
>> +#define   SDHCI_CDNS_HRS07_RW_COMPENSATE	GENMASK(20, 16)
>> +#define   SDHCI_CDNS_HRS07_IDELAY_VAL		GENMASK(4, 0)
>> +
>> +/* PHY Control and Status */
>> +#define SDHCI_CDNS_HRS09		0x24
>> +#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
>> +#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
>> +#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
>> +#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
>> +#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
>> +#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
>> +
>> +/* SDCLK start point adjustment */
>> +#define SDHCI_CDNS_HRS10		0x28
>> +#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
>> +
>> +/* eMMC Control */
>> +#define SDHCI_CDNS_HRS11		0x2c
>> +#define   SDHCI_CDNS_HRS11_EMMC_RST		BIT(0) /* eMMC reset */
>> +
>> +/* CMD/DAT output delay */
>> +#define SDHCI_CDNS_HRS16		0x40
>> +#define   SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY	GENMASK(31, 28)
>> +#define   SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY	GENMASK(27, 24)
>> +#define   SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY	GENMASK(23, 20)
>> +#define   SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY	GENMASK(19, 16)
>> +#define   SDHCI_CDNS_HRS16_WRDATA1_DLY		GENMASK(15, 12)
>> +#define   SDHCI_CDNS_HRS16_WRDATA0_DLY		GENMASK(11, 8)
>> +#define   SDHCI_CDNS_HRS16_WRCMD1_DLY		GENMASK(7, 4)
>> +#define   SDHCI_CDNS_HRS16_WRCMD0_DLY		GENMASK(3, 0)
>> +
>> +/* PHY Special Function Registers */
>> +/* DQ timing */
>> +#define SDHCI_CDNS6_PHY_DQ_TIMING_REG			0x2000
>> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON		BIT(31)
>> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END			GENMASK(29, 27)
>> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START		GENMASK(26, 24)
>> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END		GENMASK(2, 0)
>> +
>> +/* DQS timing */
>> +#define SDHCI_CDNS6_PHY_DQS_TIMING_REG			0x2004
>> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS		BIT(22)
>> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS		BIT(21)
>> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS		BIT(20)
>> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD		BIT(19)
>> +
>> +/* Gate and loopback control */
>> +#define SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG		0x2008
>> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD		BIT(31)
>> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT	BIT(28)
>> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL		GENMASK(24, 19)
>> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS	BIT(18)
>> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON	BIT(6)
>> +
>> +/* Master DLL logic */
>> +#define SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG		0x200c
>> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE		BIT(23)
>> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL	GENMASK(22, 20)
>> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM		GENMASK(18, 16)
>> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT	GENMASK(7, 0)
>> +
>> +/* Slave DLL logic */
>> +#define SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG		0x2010
>> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY	GENMASK(31, 24)
>> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY	GENMASK(23, 16)
>> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY		GENMASK(15, 8)
>> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY		GENMASK(7, 0)
>> +
>> +/* Global control settings */
>> +#define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
>> +#define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
>> +
>> +/* Default PHY settings */
>> +#define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY	2500
>> +#define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT	24
>> +#define SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL	52
>> +#define SDHCI_CDNS6_PHY_DEFAULT_DLL_START	4
>> +
>> +/* Scale tuning tap (0..39) to 8-bit PHY DLL delay field (0..255) */
>> +#define SDHCI_CDNS6_PHY_DLL_FIELD_SIZE		256
>> +
>> +struct sdhci_cdns6_phy {
>> +	/*
>> +	 * Mode-specific timing constraints (in picoseconds)
>> +	 * These define valid output/input windows per SD/eMMC spec
>> +	 */
>> +	u32 t_cmd_output_min;
>> +	u32 t_cmd_output_max;
>> +	u32 t_dat_output_min;
>> +	u32 t_dat_output_max;
>> +	u32 t_cmd_input_min;
>> +	u32 t_cmd_input_max;
>> +	u32 t_dat_input_min;
>> +	u32 t_dat_input_max;
>> +
>> +	/*
>> +	 * PHY delay configuration (in picoseconds)
>> +	 * Derived from clock period and board-level IO cell delays
>> +	 */
>> +	u32 phy_sdclk_delay;
>> +	u32 phy_cmd_o_delay;
>> +	u32 phy_dat_o_delay;
>> +	u32 iocell_input_delay;
>> +	u32 iocell_output_delay;
>> +	u32 delay_element_org;	/* Original delay element from DT */
>> +	u32 delay_element;	/* Current delay element (may be doubled) */
>> +
>> +	/* PHY_DLL_SLAVE_CTRL register fields */
>> +	u32 cp_read_dqs_cmd_delay;
>> +	u32 cp_read_dqs_delay;
>> +	u32 cp_clk_wr_delay;
>> +	u32 cp_clk_wrdqs_delay;
>> +
>> +	/* PHY_DLL_MASTER_CTRL register fields */
>> +	u32 cp_dll_bypass_mode;
>> +	u32 cp_dll_start_point;
>> +
>> +	/* PHY_GATE_LPBK_CTRL register fields */
>> +	u32 cp_gate_cfg_always_on;
>> +	u32 cp_sync_method;
>> +	u32 cp_rd_del_sel;
>> +	u32 cp_sw_half_cycle_shift;
>> +	u32 cp_underrun_suppress;
>> +
>> +	/* PHY_DQ_TIMING register fields */
>> +	u32 cp_io_mask_always_on;
>> +	u32 cp_io_mask_end;
>> +	u32 cp_io_mask_start;
>> +	u32 cp_data_select_oe_end;
>> +
>> +	/* PHY_DQS_TIMING register fields */
>> +	u32 cp_use_ext_lpbk_dqs;
>> +	u32 cp_use_lpbk_dqs;
>> +	u8 cp_use_phony_dqs;
>> +	u8 cp_use_phony_dqs_cmd;
>> +
>> +	/* HRS09 register fields - PHY control and Status */
>> +	u8 sdhc_extended_rd_mode;
>> +	u8 sdhc_extended_wr_mode;
>> +	u32 sdhc_rdcmd_en;
>> +	u32 sdhc_rddata_en;
>> +
>> +	/* HRS10 register - SDCLK start point adjustment */
>> +	u32 sdhc_hcsdclkadj;
>> +
>> +	/* HRS07 register - IO delay Information */
>> +	u32 sdhc_idelay_val;
>> +	u32 sdhc_rw_compensate;
>> +
>> +	/* HRS16 register fields - CMD/DAT output delay control */
>> +	u32 sdhc_wrcmd0_dly;
>> +	u32 sdhc_wrcmd0_sdclk_dly;
>> +	u32 sdhc_wrcmd1_dly;
>> +	u32 sdhc_wrcmd1_sdclk_dly;
>> +	u32 sdhc_wrdata0_dly;
>> +	u32 sdhc_wrdata0_sdclk_dly;
>> +	u32 sdhc_wrdata1_dly;
>> +	u32 sdhc_wrdata1_sdclk_dly;
>> +
>> +	/*
>> +	 * DLL calculation intermediate values
>> +	 * Used during PHY timing calculations
>> +	 */
>> +	u32 t_sdmclk_calc;	/* Calculated SDMCLK period for DLL */
>> +	u32 dll_max_value;	/* Max DLL delay value (127/255/256) */
>> +
>> +	/* Tuning value for HS200/HS400 modes */
>> +	u32 hs200_tune_val;
>> +
>> +	/* Clock periods (in picoseconds) */
>> +	u32 t_sdmclk;		/* Master clock period */
>> +	u32 t_sdclk;		/* SD card clock period */
>> +
>> +	/* Current operating state */
>> +	bool strobe_cmd;	/* Enhanced strobe for CMD line */
>> +	unsigned int mode;	/* Current MMC_TIMING_* mode */
>> +};
>> +
>> +/**
>> + * init_ds() - Initialize PHY timing for Default Speed mode (up to 25 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_ds(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 5000;
>> +	phy->t_cmd_output_max = t_sdclk - 5000;
>> +	phy->t_dat_output_min = 5000;
>> +	phy->t_dat_output_max = t_sdclk - 5000;
>> +	phy->t_cmd_input_min = t_sdclk / 2 + 14000;
>> +	phy->t_cmd_input_max = t_sdclk + t_sdclk / 2;
>> +	phy->t_dat_input_min = t_sdclk / 2 + 14000;
>> +	phy->t_dat_input_max = t_sdclk + t_sdclk / 2;
>> +}
>> +
>> +/**
>> + * init_hs() - Initialize PHY timing for High Speed mode (up to 50 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_hs(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 2000;
>> +	phy->t_cmd_output_max = t_sdclk - 6000;
>> +	phy->t_dat_output_min = 2000;
>> +	phy->t_dat_output_max = t_sdclk - 6000;
>> +	phy->t_cmd_input_min = 14000;
>> +	phy->t_cmd_input_max = t_sdclk + 2500;
>> +	phy->t_dat_input_min = 14000;
>> +	phy->t_dat_input_max = t_sdclk + 2500;
>> +}
>> +
>> +/**
>> + * init_uhs_sdr12() - Initialize PHY timing for UHS SDR12 mode (up to 25 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_uhs_sdr12(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 3000;
>> +	phy->t_cmd_input_min = 14000;
>> +	phy->t_cmd_input_max = t_sdclk + 1500;
>> +	phy->t_dat_input_min = 14000;
>> +	phy->t_dat_input_max = t_sdclk + 1500;
>> +}
>> +
>> +/**
>> + * init_uhs_sdr25() - Initialize PHY timing for UHS SDR25 mode (up to 50 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_uhs_sdr25(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 3000;
>> +	phy->t_cmd_input_min = 14000;
>> +	phy->t_cmd_input_max = t_sdclk + 1500;
>> +	phy->t_dat_input_min = 14000;
>> +	phy->t_dat_input_max = t_sdclk + 1500;
>> +}
>> +
>> +/**
>> + * init_uhs_sdr50() - Initialize PHY timing for UHS SDR50 mode (up to 100 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_uhs_sdr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 3000;
>> +	phy->t_cmd_input_min = 7500;
>> +	phy->t_cmd_input_max = t_sdclk + 1500;
>> +	phy->t_dat_input_min = 7500;
>> +	phy->t_dat_input_max = t_sdclk + 1500;
>> +}
>> +
>> +/**
>> + * init_uhs_sdr104() - Initialize PHY timing for UHS SDR104 mode (up to 208 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_uhs_sdr104(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 1400;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 1400;
>> +	phy->t_cmd_input_min = 1000;
>> +	phy->t_cmd_input_max = t_sdclk + 1000;
>> +	phy->t_dat_input_min = 1000;
>> +	phy->t_dat_input_max = t_sdclk + 1000;
>> +}
>> +
>> +/**
>> + * init_uhs_ddr50() - Initialize PHY timing for UHS DDR50 mode (up to 50 MHz DDR).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_uhs_ddr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 3000;
>> +	phy->t_cmd_input_min = 13700;
>> +	phy->t_cmd_input_max = t_sdclk + 1500;
>> +	phy->t_dat_input_min = 7000;
>> +	phy->t_dat_input_max = t_sdclk + 1500;
>> +}
>> +
>> +/**
>> + * init_emmc_sdr() - Initialize PHY timing for eMMC legacy/SDR mode.
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_emmc_sdr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 3000;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 3000;
>> +	phy->t_dat_output_max = t_sdclk - 3000;
>> +	phy->t_cmd_input_min = 13700;
>> +	phy->t_cmd_input_max = t_sdclk + 2500;
>> +	phy->t_dat_input_min = 13700;
>> +	phy->t_dat_input_max = t_sdclk + 2500;
>> +}
>> +
>> +/**
>> + * init_emmc_ddr() - Initialize PHY timing for eMMC DDR52 mode.
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_emmc_ddr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 3000;
>> +	phy->t_cmd_output_max = t_sdclk - 3000;
>> +	phy->t_dat_output_min = 2500;
>> +	phy->t_dat_output_max = t_sdclk - 2500;
>> +	phy->t_cmd_input_min = 13700;
>> +	phy->t_cmd_input_max = t_sdclk + 2500;
>> +	phy->t_dat_input_min = 7000;
>> +	phy->t_dat_input_max = t_sdclk + 1500;
>> +}
>> +
>> +/**
>> + * init_emmc_hs200() - Initialize PHY timing for eMMC HS200 mode (up to 200 MHz).
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_emmc_hs200(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 1400;
>> +	phy->t_dat_output_min = 800;
>> +	phy->t_dat_output_max = t_sdclk - 1400;
>> +	phy->t_cmd_input_min = 1000;
>> +	phy->t_cmd_input_max = t_sdclk + 1000;
>> +	phy->t_dat_input_min = 1000;
>> +	phy->t_dat_input_max = t_sdclk + 1000;
>> +}
>> +
>> +/**
>> + * init_emmc_hs400() - Initialize PHY timing for eMMC HS400/HS400ES mode.
>> + * @phy: Pointer to SD6HC PHY state.
>> + * @t_sdclk: SD clock period in picoseconds.
>> + */
>> +static void init_emmc_hs400(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
>> +{
>> +	phy->t_cmd_output_min = 800;
>> +	phy->t_cmd_output_max = t_sdclk - 1400;
>> +	phy->t_dat_output_min = 400;
>> +	phy->t_dat_output_max = t_sdclk - 400;
>> +	phy->t_cmd_input_min = 1000;
>> +	phy->t_cmd_input_max = t_sdclk + 1000;
>> +	phy->t_dat_input_min = 1000;
>> +	phy->t_dat_input_max = t_sdclk + 1000;
>> +}
>> +
>> +/*
>> + * init_timings - PHY timing initializers indexed by MMC_TIMING_* value.
>> + *
>> + * Each entry corresponds to a MMC_TIMING_* constant and sets the
>> + * appropriate cmd/dat output and input timing windows in the PHY
>> + * state struct. Must stay in sync with the MMC_TIMING_* definitions
>> + * in include/linux/mmc/host.h.
>> + */
>> +static void (*init_timings[])(struct sdhci_cdns6_phy *, u32) = {
>> +	&init_ds,
>> +	&init_emmc_sdr,
>> +	&init_hs,
>> +	&init_uhs_sdr12,
>> +	&init_uhs_sdr25,
>> +	&init_uhs_sdr50,
>> +	&init_uhs_sdr104,
>> +	&init_uhs_ddr50,
>> +	&init_emmc_ddr,
>> +	&init_emmc_hs200,
>> +	&init_emmc_hs400,
>> +};
>> +
>> +static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_priv *priv,
>> +					     const u32 address)
>> +{
>> +	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
>> +	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
>> +}
>> +
>> +static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_priv *priv,
>> +				      const u32 address, const u32 value)
>> +{
>> +	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
>> +	writel(value, priv->hrs_addr + SDHCI_CDNS_HRS05);
>> +}
>> +
>> +static int sdhci_cdns6_phy_lock_dll(struct sdhci_cdns6_phy *phy)
>> +{
>> +	u32 delay_element = phy->delay_element_org;
>> +	u32 delay_elements_in_sdmclk;
>> +
>> +	delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
>> +	if (delay_elements_in_sdmclk > 256) {
>> +		delay_element *= 2;
>> +		delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk,
>> +							delay_element);
>> +
>> +		if (delay_elements_in_sdmclk > 256)
>> +			return -EINVAL;
>> +
>> +		phy->dll_max_value = 127;
>> +	} else {
>> +		phy->dll_max_value = 255;
>> +	}
>> +
>> +	phy->t_sdmclk_calc = delay_element * delay_elements_in_sdmclk;
>> +	phy->delay_element = delay_element;
>> +	phy->cp_dll_bypass_mode = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static void sdhci_cdns6_phy_dll_bypass(struct sdhci_cdns6_phy *phy)
>> +{
>> +	phy->dll_max_value = 256;
>> +	phy->cp_dll_bypass_mode = 1;
>> +}
>> +
>> +static void sdhci_cdns6_phy_configure_dll(struct sdhci_cdns6_phy *phy)
>> +{
>> +	if (phy->sdhc_extended_wr_mode == 0) {
>> +		if (sdhci_cdns6_phy_lock_dll(phy) == 0)
>> +			return;
>> +	}
>> +	sdhci_cdns6_phy_dll_bypass(phy);
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_out(struct sdhci_cdns6_phy *phy,
>> +				     bool cmd_not_dat)
>> +{
>> +	u32 wr0_dly = 0, wr1_dly = 0, output_min, output_max, phy_o_delay,
>> +	    clk_wr_delay = 0, wr0_sdclk_dly = 0, wr1_sdclk_dly = 0;
>> +	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50) ||
>> +			(phy->mode == MMC_TIMING_MMC_DDR52) ||
>> +			(phy->mode == MMC_TIMING_MMC_HS400);
>> +	bool data_ddr = ddr && !cmd_not_dat;
>> +	int t;
>> +
>> +	if (cmd_not_dat) {
>> +		output_min = phy->t_cmd_output_min;
>> +		output_max = phy->t_cmd_output_max;
>> +		phy_o_delay = phy->phy_cmd_o_delay;
>> +	} else {
>> +		output_min = phy->t_dat_output_min;
>> +		output_max = phy->t_dat_output_max;
>> +		phy_o_delay = phy->phy_dat_o_delay;
>> +	}
>> +
>> +	if (data_ddr) {
>> +		wr0_sdclk_dly = 1;
>> +		wr1_sdclk_dly = 1;
>> +	}
>> +
>> +	t = phy_o_delay - phy->phy_sdclk_delay - output_min;
>> +	if (t < 0 && phy->sdhc_extended_wr_mode == 1) {
>> +		u32 n_half_cycle = DIV_ROUND_UP(-t * 2, phy->t_sdmclk);
>> +
>> +		wr0_dly = (n_half_cycle + 1) / 2;
>> +		if (data_ddr)
>> +			wr1_dly = (n_half_cycle + 1) / 2;
>> +		else
>> +			wr1_dly = (n_half_cycle + 1) % 2 + wr0_dly - 1;
>> +	}
>> +
>> +	if (phy->sdhc_extended_wr_mode == 0) {
>> +		u32 out_hold, out_setup, out_hold_margin;
>> +		u32 n;
>> +
>> +		if (!data_ddr)
>> +			wr0_dly = 1;
>> +
>> +		out_setup = output_max;
>> +		out_hold = output_min;
>> +		out_hold_margin = DIV_ROUND_UP(out_setup - out_hold, 4);
>> +		out_hold += out_hold_margin;
>> +
>> +		if (phy->cp_dll_bypass_mode == 0)
>> +			n = DIV_ROUND_UP(256 * out_hold, phy->t_sdmclk_calc);
>> +		else
>> +			n = DIV_ROUND_UP(out_hold, phy->delay_element) - 1;
>> +
>> +		if (n <= phy->dll_max_value)
>> +			clk_wr_delay = n;
>> +		else
>> +			clk_wr_delay = 255;
>> +	} else {
>> +		/*  sdhc_extended_wr_mode = 1 => PHY IO cell work in SDR mode */
>> +		clk_wr_delay = 0;
>> +	}
>> +
>> +	if (cmd_not_dat) {
>> +		phy->sdhc_wrcmd0_dly = wr0_dly;
>> +		phy->sdhc_wrcmd1_dly = wr1_dly;
>> +		phy->cp_clk_wrdqs_delay = clk_wr_delay;
>> +		phy->sdhc_wrcmd0_sdclk_dly = wr0_sdclk_dly;
>> +		phy->sdhc_wrcmd1_sdclk_dly = wr1_sdclk_dly;
>> +	} else {
>> +		phy->sdhc_wrdata0_dly = wr0_dly;
>> +		phy->sdhc_wrdata1_dly = wr1_dly;
>> +		phy->cp_clk_wr_delay = clk_wr_delay;
>> +		phy->sdhc_wrdata0_sdclk_dly = wr0_sdclk_dly;
>> +		phy->sdhc_wrdata1_sdclk_dly = wr1_sdclk_dly;
>> +	}
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_cmd_out(struct sdhci_cdns6_phy *phy)
>> +{
>> +	sdhci_cdns6_phy_calc_out(phy, true);
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_cmd_in(struct sdhci_cdns6_phy *phy)
>> +{
>> +	phy->cp_io_mask_end =
>> +		((phy->iocell_output_delay + phy->iocell_input_delay) * 2)
>> +		/ phy->t_sdmclk;
>> +
>> +	/* cp_io_mask_end is a 3-bit field, clamp to max value of 7 */
>> +	phy->cp_io_mask_end = min_t(u32, phy->cp_io_mask_end, 7);
>> +
>> +	if (phy->strobe_cmd && phy->cp_io_mask_end > 0)
>> +		phy->cp_io_mask_end--;
>> +
>> +	if (phy->strobe_cmd) {
>> +		phy->cp_use_phony_dqs_cmd = 0;
>> +		phy->cp_read_dqs_cmd_delay = 64;
>> +	} else {
>> +		phy->cp_use_phony_dqs_cmd = 1;
>> +		phy->cp_read_dqs_cmd_delay = 0;
>> +	}
>> +
>> +	if ((phy->mode == MMC_TIMING_MMC_HS400 && !phy->strobe_cmd) ||
>> +	    phy->mode == MMC_TIMING_MMC_HS200)
>> +		phy->cp_read_dqs_cmd_delay =
>> +			phy->hs200_tune_val;
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>> +{
>> +	u32 hcsdclkadj = 0;
>> +	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
>> +
>> +	if (strobe_dat) {
>> +		phy->cp_use_phony_dqs = 0;
>> +		phy->cp_read_dqs_delay = 64;
>> +	} else {
>> +		phy->cp_use_phony_dqs = 1;
>> +		phy->cp_read_dqs_delay = 0;
>> +	}
>> +
>> +	if (phy->mode == MMC_TIMING_MMC_HS200)
>> +		phy->cp_read_dqs_delay =
>> +			phy->hs200_tune_val;
>> +
>> +	if (strobe_dat) {
>> +		/* dqs loopback input via IO cell */
>> +		hcsdclkadj += phy->iocell_input_delay;
>> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod; delay of hic_dll_dqs_nand2 */
>> +		hcsdclkadj += phy->delay_element / 2;
>> +		/* delay line */
>> +		hcsdclkadj += phy->t_sdclk / 2;
>> +		/* PHY FIFO write pointer */
>> +		hcsdclkadj += phy->t_sdclk / 2 + phy->delay_element;
>> +		/* 1st synchronizer */
>> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
>> +			* phy->t_sdmclk - hcsdclkadj;
>> +		/*
>> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
>> +		 * + PHY rddata registered, + FIFO 1st ciu_en
>> +		 */
>> +		hcsdclkadj += 5 * phy->t_sdmclk;
>> +		/* FIFO 2nd ciu_en */
>> +		hcsdclkadj += phy->t_sdclk;
>> +
>> +		hcsdclkadj /= phy->t_sdclk;
>> +	} else {
>> +		u32 n;
>> +
>> +		/* rebar PHY delay */
>> +		hcsdclkadj += 2 * phy->t_sdmclk;
>> +		/* rebar output via IO cell */
>> +		hcsdclkadj += phy->iocell_output_delay;
>> +		/* dqs loopback input via IO cell */
>> +		hcsdclkadj += phy->iocell_input_delay;
>> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod delay of hic_dll_dqs_nand2 */
>> +		hcsdclkadj += phy->delay_element / 2;
>> +		/* dll: one delay element between SIGI_0 and SIGO_0 */
>> +		hcsdclkadj += phy->delay_element;
>> +		/* dfi_dqs_in: mem_dqs_delayed -> clk_dqs delay of hic_dll_dqs_nand2 */
>> +		hcsdclkadj += phy->delay_element / 2;
>> +		/* deskew DLL: clk_dqs -> clk_dqN: one delay element */
>> +		hcsdclkadj += phy->delay_element;
>> +
>> +		if (phy->t_sdclk == phy->t_sdmclk)
>> +			n = (hcsdclkadj - 2 * phy->t_sdmclk) / phy->t_sdclk;
>> +		else
>> +			n = hcsdclkadj / phy->t_sdclk;
>> +
>> +		/* phase shift within one t_sdclk clock cycle caused by rebar - lbk dqs delay */
>> +		hcsdclkadj = hcsdclkadj % phy->t_sdclk;
>> +		/* PHY FIFO write pointer */
>> +		hcsdclkadj += phy->t_sdclk / 2;
>> +		/* 1st synchronizer */
>> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk)
>> +			* phy->t_sdmclk - hcsdclkadj;
>> +		/*
>> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
>> +		 * + PHY rddata registered
>> +		 */
>> +		hcsdclkadj += 4 * phy->t_sdmclk;
>> +
>> +		if ((phy->t_sdclk / phy->t_sdmclk) > 1) {
>> +			u32 tmp1, tmp2;
>> +
>> +			tmp1 = hcsdclkadj;
>> +			tmp2 = (hcsdclkadj / phy->t_sdclk) * phy->t_sdclk
>> +				+ phy->t_sdclk - phy->t_sdmclk;
>> +			if (tmp1 == tmp2)
>> +				tmp2 += phy->t_sdclk;
>> +
>> +			/* FIFO aligns to clock cycle before ciu_en */
>> +			hcsdclkadj += tmp2 - tmp1;
>> +		}
>> +
>> +		/* FIFO 1st ciu_en */
>> +		hcsdclkadj += phy->t_sdmclk;
>> +		/* FIFO 2nd ciu_en */
>> +		hcsdclkadj += phy->t_sdclk;
>> +
>> +		hcsdclkadj /= phy->t_sdclk;
>> +
>> +		hcsdclkadj += n;
>> +
>> +		if ((phy->t_sdclk / phy->t_sdmclk) >= 2) {
>> +			if (phy->mode == MMC_TIMING_UHS_DDR50 ||
>> +			    phy->mode == MMC_TIMING_MMC_DDR52)
>> +				hcsdclkadj -= 2;
>> +			else
>> +				hcsdclkadj -= 1;
>> +		} else if ((phy->t_sdclk / phy->t_sdmclk) == 1) {
>> +			hcsdclkadj += 2;
>> +		}
>> +
>> +		if (phy->mode == MMC_TIMING_UHS_SDR104 || phy->mode == MMC_TIMING_MMC_HS200)
>> +			hcsdclkadj -= 1;
>> +	}
>> +
>> +	/* hcsdclkadj is a 4-bit field, clamp to max value of 15 */
>> +	if (hcsdclkadj > 15)
>> +		hcsdclkadj = 15;
>> +
>> +	phy->sdhc_hcsdclkadj = hcsdclkadj;
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_dat_out(struct sdhci_cdns6_phy *phy)
>> +{
>> +	sdhci_cdns6_phy_calc_out(phy, false);
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_io(struct sdhci_cdns6_phy *phy)
>> +{
>> +	u32 rw_compensate;
>> +
>> +	rw_compensate = ((phy->iocell_input_delay + phy->iocell_output_delay)
>> +		/ phy->t_sdmclk) + phy->sdhc_wrdata0_dly + 5 + 3;
>> +
>> +	phy->sdhc_idelay_val = (2 * phy->iocell_input_delay)
>> +		/ phy->t_sdmclk;
>> +
>> +	phy->cp_io_mask_start = 0;
>> +	if (phy->t_sdclk == phy->t_sdmclk && rw_compensate > 10)
>> +		phy->cp_io_mask_start = 2 * (rw_compensate - 10);
>> +
>> +	if (phy->mode == MMC_TIMING_UHS_SDR104)
>> +		phy->cp_io_mask_start++;
>> +
>> +	if (phy->t_sdclk == phy->t_sdmclk && phy->mode == MMC_TIMING_UHS_SDR50)
>> +		phy->cp_io_mask_start++;
>> +
>> +	phy->sdhc_rw_compensate = rw_compensate;
>> +}
>> +
>> +static void sdhci_cdns6_phy_calc_settings(struct sdhci_cdns6_phy *phy)
>> +{
>> +	sdhci_cdns6_phy_calc_cmd_out(phy);
>> +	sdhci_cdns6_phy_calc_cmd_in(phy);
>> +	sdhci_cdns6_phy_calc_dat_out(phy);
>> +	sdhci_cdns6_phy_calc_dat_in(phy);
>> +	sdhci_cdns6_phy_calc_io(phy);
>> +}
>> +
>> +static int sdhci_cdns6_dll_reset(struct sdhci_cdns_priv *priv, bool reset)
>> +{
>> +	u32 reg;
>> +	int ret = 0;
>> +
>> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
>> +	if (reset)
>> +		reg &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
>> +	else
>> +		reg |= SDHCI_CDNS_HRS09_PHY_SW_RESET;
>> +
>> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
>> +
>> +	/* After reset, wait until HRS09.PHY_INIT_COMPLETE is set to 1 within 3000us*/
>> +	if (!reset) {
>> +		ret = readl_poll_timeout(priv->hrs_addr + SDHCI_CDNS_HRS09, reg,
>> +					 (reg & SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE),
>> +					 0, 3000);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>> +{
>> +	int ret;
>> +	u32 reg;
>> +	struct sdhci_cdns6_phy *phy = priv->phy;
>> +
>> +	sdhci_cdns6_dll_reset(priv, true);
>> +
>> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
>> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS,
>> +			phy->cp_use_ext_lpbk_dqs);
> drivers/mmc/host/sdhci-cadence6.c: In function ‘sdhci_cdns6_phy_init’:
> drivers/mmc/host/sdhci-cadence6.c:761:16: error: implicit declaration of function ‘FIELD_PREP’ [-Wimplicit-function-declaration]
>    761 |         reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS,
>        |                ^~~~~~~~~~

I will fix this in V2 by adding the required include and rerun build 
validation
before re-sending.
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS,
>> +			phy->cp_use_lpbk_dqs);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS,
>> +			  phy->cp_use_phony_dqs);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD,
>> +			  phy->cp_use_phony_dqs_cmd);
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
>> +
>> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG);
>> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD;
>> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT;
>> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL;
>> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS;
>> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON;
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD,
>> +			phy->cp_sync_method);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SW_HALF_CYCLE_SHIFT,
>> +			phy->cp_sw_half_cycle_shift);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL,
>> +			phy->cp_rd_del_sel);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS,
>> +			phy->cp_underrun_suppress);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON,
>> +			phy->cp_gate_cfg_always_on);
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG, reg);
>> +
>> +	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE,
>> +			 phy->cp_dll_bypass_mode);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL, 2);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM, 0);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT,
>> +			phy->cp_dll_start_point);
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG, reg);
>> +
>> +	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY,
>> +			 phy->cp_read_dqs_cmd_delay);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY,
>> +			  phy->cp_clk_wrdqs_delay);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY,
>> +			  phy->cp_clk_wr_delay);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY,
>> +			  phy->cp_read_dqs_delay);
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG, reg);
>> +
>> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>> +	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
>> +
>> +	/*
>> +	 * Ensure all preceding PHY register writes complete and reach the
>> +	 * controller before releasing the PHY from reset. Without this,
>> +	 * SDR104 has been observed to fail intermittently on some boards.
>> +	 */
>> +	wmb();
>> +
>> +	ret = sdhci_cdns6_dll_reset(priv, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG);
>> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START;
>> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END;
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON,
>> +			phy->cp_io_mask_always_on);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END,
>> +			  phy->cp_io_mask_end);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START,
>> +			  phy->cp_io_mask_start);
>> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END,
>> +			phy->cp_data_select_oe_end);
>> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG, reg);
>> +
>> +	/* Ensure DQ timing programming is visible before HRS09 follow-up writes */
>> +	wmb();
>> +
>> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
>> +	if (phy->sdhc_extended_wr_mode)
>> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
>> +	else
>> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
>> +
>> +	if (phy->sdhc_extended_rd_mode)
>> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
>> +	else
>> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
>> +
>> +	if (phy->sdhc_rddata_en)
>> +		reg |= SDHCI_CDNS_HRS09_RDDATA_EN;
>> +	else
>> +		reg &= ~SDHCI_CDNS_HRS09_RDDATA_EN;
>> +
>> +	if (phy->sdhc_rdcmd_en)
>> +		reg |= SDHCI_CDNS_HRS09_RDCMD_EN;
>> +	else
>> +		reg &= ~SDHCI_CDNS_HRS09_RDCMD_EN;
>> +
>> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
>> +
>> +	reg = FIELD_PREP(SDHCI_CDNS_HRS10_HCSDCLKADJ, phy->sdhc_hcsdclkadj);
>> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS10);
>> +
>> +	reg = FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY,
>> +			 phy->sdhc_wrdata1_sdclk_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY,
>> +			  phy->sdhc_wrdata0_sdclk_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY,
>> +			  phy->sdhc_wrcmd1_sdclk_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY,
>> +			  phy->sdhc_wrcmd0_sdclk_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_DLY,
>> +			  phy->sdhc_wrdata1_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_DLY,
>> +			  phy->sdhc_wrdata0_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_DLY,
>> +			  phy->sdhc_wrcmd1_dly);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_DLY,
>> +			  phy->sdhc_wrcmd0_dly);
>> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS16);
>> +
>> +	reg = FIELD_PREP(SDHCI_CDNS_HRS07_RW_COMPENSATE,
>> +			 phy->sdhc_rw_compensate);
>> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS07_IDELAY_VAL,
>> +			  phy->sdhc_idelay_val);
>> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS07);
>> +
>> +	/* Allow 5ms for clock and PHY signals to stabilize after configuration */
>> +	usleep_range(5000, 5500);
>> +
>> +	return 0;
>> +}
>> +
>> +int sdhci_cdns6_set_tune_val(struct sdhci_host *host,
>> +			     unsigned int val)
>> +{
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>> +	struct sdhci_cdns6_phy *phy = priv->phy;
>> +	u32 tuneval;
>> +
>> +	/*
>> +	 * Scale tuning tap (val in [0, SDHCI_CDNS_MAX_TUNING_LOOP-1]) to the
>> +	 * 8-bit PHY DLL slave delay field [0, 255]. With MAX_TUNING_LOOP=40
>> +	 * and FIELD_SIZE=256, the result fits in 8 bits.
>> +	 */
>> +	tuneval = (val * SDHCI_CDNS6_PHY_DLL_FIELD_SIZE) /
>> +		  SDHCI_CDNS_MAX_TUNING_LOOP;
>> +
>> +	phy->hs200_tune_val = tuneval;
>> +	phy->cp_read_dqs_cmd_delay = tuneval;
>> +	phy->cp_read_dqs_delay = tuneval;
>> +
>> +	return sdhci_cdns6_phy_init(priv);
>> +}
>> +
>> +static int sdhci_cdns6_phy_update_timings(struct sdhci_host *host)
>> +{
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>> +	struct sdhci_cdns6_phy *phy = priv->phy;
>> +	u32 t_sdmclk = phy->t_sdmclk;
>> +
>> +	/* Validate mode is within supported range */
>> +	if (phy->mode >= ARRAY_SIZE(init_timings))
>> +		return -EINVAL;
>> +
>> +	/* initialize input */
>> +	init_timings[phy->mode](phy, phy->t_sdclk);
>> +
>> +	phy->strobe_cmd = false;
>> +
>> +	if (priv->enhanced_strobe)
>> +		phy->strobe_cmd = true;
>> +
>> +	phy->phy_sdclk_delay = 2 * t_sdmclk;
>> +
>> +	/*
>> +	 * CMD and DAT output delays are currently identical, but kept separate
>> +	 * to allow independent tuning for specific modes (e.g., HS400) or
>> +	 * board-specific optimizations in the future.
>> +	 */
>> +	phy->phy_cmd_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
>> +	phy->phy_dat_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
>> +
>> +	if (phy->t_sdclk == phy->t_sdmclk) {
>> +		phy->sdhc_extended_wr_mode = 0;
>> +		phy->sdhc_extended_rd_mode = 0;
>> +	} else {
>> +		phy->sdhc_extended_wr_mode = 1;
>> +		phy->sdhc_extended_rd_mode = 1;
>> +	}
>> +
>> +	phy->cp_gate_cfg_always_on = 1;
>> +
>> +	sdhci_cdns6_phy_configure_dll(phy);
>> +
>> +	sdhci_cdns6_phy_calc_settings(phy);
>> +
>> +	return 0;
>> +}
>> +
>> +int sdhci_cdns6_phy_probe(struct platform_device *pdev,
>> +			  struct sdhci_cdns_priv *priv)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_cdns6_phy *phy;
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	val = clk_get_rate(pltfm_host->clk);
>> +	if (!val)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "failed to get controller clock rate\n");
>> +
>> +	phy->t_sdmclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, val);
>> +
>> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay",
>> +				   &phy->iocell_input_delay);
>> +	if (ret)
>> +		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
>> +
>> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay",
>> +				   &phy->iocell_output_delay);
>> +	if (ret)
>> +		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
>> +
>> +	ret = of_property_read_u32(dev->of_node, "cdns,delay-element",
>> +				   &phy->delay_element);
>> +	if (ret)
>> +		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
>> +
>> +	phy->delay_element_org = phy->delay_element;
>> +
>> +	priv->phy = phy;
>> +
>> +	/* default settings */
>> +	phy->sdhc_rdcmd_en = 1;
>> +	phy->sdhc_rddata_en = 1;
>> +	phy->cp_use_ext_lpbk_dqs = 1;
>> +	phy->cp_use_lpbk_dqs = 1;
>> +	phy->cp_sync_method = 1;
>> +	phy->cp_rd_del_sel = SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL;
>> +	phy->cp_dll_start_point = SDHCI_CDNS6_PHY_DEFAULT_DLL_START;
>> +	phy->cp_data_select_oe_end = 1;
>> +	phy->cp_io_mask_always_on = 0;
>> +	phy->cp_underrun_suppress = 1;
>> +
>> +	return 0;
>> +}
>> +
>> +void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
>> +{
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>> +	struct sdhci_cdns6_phy *phy = priv->phy;
>> +
>> +	/* Clock may be 0 during initial ios setup; skip PHY update */
>> +	if (!host->mmc->ios.clock)
>> +		return;
>> +
>> +	phy->t_sdclk = DIV_ROUND_DOWN_ULL(1000000000000ULL,
>> +					  host->mmc->ios.clock);
>> +	phy->mode = timing;
>> +
>> +	if (sdhci_cdns6_phy_update_timings(host))
>> +		dev_warn(mmc_dev(host->mmc), "%s: update timings failed\n",
>> +			 __func__);
>> +
>> +	if (sdhci_cdns6_phy_init(priv))
>> +		dev_warn(mmc_dev(host->mmc), "%s: phy init failed\n",
>> +			 __func__);
>> +}
>> +
>> +void sdhci_cdns6_hw_reset(struct sdhci_host *host)
>> +{
>> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>> +	void __iomem *reg;
>> +
>> +	reg = priv->hrs_addr + SDHCI_CDNS_HRS11;
>> +	writel(SDHCI_CDNS_HRS11_EMMC_RST, reg);
>> +	/* eMMC HW reset assertion: spec requires >= 1us, give margin */
>> +	usleep_range(10, 20);
>> +	writel(0, reg);
>> +	usleep_range(300, 1000);
>> +}
