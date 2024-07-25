Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2062.outbound.protection.outlook.com [40.92.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24120EB;
	Thu, 25 Jul 2024 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871389; cv=fail; b=AQmixh6G7vG5mn6S4xmnEShf/3QXmK2n9H1w1oFshqV5ho+UCuTWRQkP6MoX6jrVBsmauf7i2fhpqzJyoqzKEdD74oJlg1KPrHFw8Jp6sfMqwLhNizFzA5YO85vtCLz+fCND1+JIyDjXr65EC/3eE9Mkevky0r6XosJlW5U+o0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871389; c=relaxed/simple;
	bh=hNLQV1XRxqsrVRBvyJZx2OpGqeUlY8DQZGbvukwiYXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jdt3wR9fQxqjIKr54pUGcBhl5VJhW3BHaSFlPjggzDhAXQ3vhdshlkKLVODlpZys8qjTzsCvUdppMBlf1O+6N53uHujs2GJTkaukx9H/xPxaOjpKXMVTEgx2EOHAWElAlaUEhlVo5a3kOR9mwWbd7cfOvQuRi553aKIHP9wmB8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X0y962t9; arc=fail smtp.client-ip=40.92.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X0y962t9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0andETyCfF9DbI/CUvfwRkgAx6rTLvsa4OTt0++5Tc0K8WQoajxvHdaqJOb3fr3mB+Ihb3rhW+vjcN37C4S8OkNYvwtghlJG/nDQ/oXqfijESOl5opSmf4dLNpVGN7eVjB7lOHZyJaZYN4ut/fEN3ShPQaokHPBICyw9qK0D16aV9jhpNJZMP1+lEoQVbZ3FwBJ2B1K3MJTP6LTG6H33vbHlLUVXqp/GMwPOLgeOY9PkPM0s90svumDhkmRabbTickEzSFBigt8xaj2PPiPnOXwEWIsOOMioQ0JEaiCJVsw1RwZg0wIldF3q/aIrD+3hfEQN1AGp3+O5Cwn/JQOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWBmIMvfSBptJwrZshjGIiQHwknJvw1TZAruUiKWRFU=;
 b=xxFSsK5/wdlTt7i4g2rCEb0Zlf/OEfglGL7ADiIY0zWkAGZonw6zso7XM5NKhyCRUdB50eb2sWA6rrGQ7hOiwtBFIp2AqQ90F39Tq0IU6hWZQ7BzNte4Q0CMg8jY/L7MBcceSrb//DvRY3JWw1mSEcb4gPuYb2mcpKdVqCUcQBs058xmL3Tj4YMHfc0eIxCX0yM+JjyRO1FDIXRl3vfJRcxeDbXI8hxZ5zLNlqV9wR12bf/i57Pos57NTc7stqaDihXtshU6INYifXku8IMmMKdCNH28CzSEJYCwoiGqCN4aki62Cv/5/yWHbev4fIW6RTnBTY2BefzryFPc+VeIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWBmIMvfSBptJwrZshjGIiQHwknJvw1TZAruUiKWRFU=;
 b=X0y962t93Akf881DCFFBLJdwmDzUctsglHJbov7dsUIw+XO1rlYWTGIiC59tc2oDi3MkYGeC8o8sICBsrQeiLDQ4ZplnJLIMSMJOXJztVLeodZh5uVJnq2Dzycg/5nPhWeG/iNwiqN32uGuII4VWgxCNSOpk6eQHGFUlrXoey4fOD9RDA8r3WasxDEFO1IlohHZBtxlOmcUbpilHbBDqSujWg/+wpu/AK75geRynDRJn6FNUBgALw0dXFL0g0ItgorcuWiZuk6ubftxrCYUrf0beIIpm9PNqK4y9IsZKm7fi48jFpgRU5Z0ZR/qNyTUffljJ+YWQbxFMkDVPx87CIA==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN3P287MB1446.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 01:36:18 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%3]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 01:36:18 +0000
Message-ID:
 <PN1P287MB281813D2CE721D2D8E697A52FEAB2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 25 Jul 2024 09:36:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
To: Drew Fustini <drew@pdp7.com>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1721377374.git.unicorn_wang@outlook.com>
 <ZqFtjpxXv7pRpZHV@x1>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ZqFtjpxXv7pRpZHV@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [3nD3x9RLGdE9FTv8MBdkQqQWN0wWl3Kq]
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <c8364838-598a-4fe9-a8d4-711cf0b9a5bd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN3P287MB1446:EE_
X-MS-Office365-Filtering-Correlation-Id: 06904d1b-3e1b-4ca2-168e-08dcac4a2d39
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	h2U3y7jt8jMWABEVOJRfFd4yAAkd9qqV+2vW1Eu1jV4X7mDANp9sSwee3sk/5kekLViWoiU+V+UrWt5QCzj0EMAAyWc/nP+vauHaFjN0jKSKCnKDhEIv6XTjuT2UyVkyJxzHLOq9yWewz4fUooyDl3Nc7u7RYrfrBDmyVZknaqmNu1tw9txRhD6l7mpaZzBCyFnPDuqkFSHsDrDABUk1Xq1MEupsy2XMNK2J/IpvguGLWt15/qMzTapNa+sB8e42rYEuFPcqT1emATNk5QwzzqHlk5opi+6Jdxa8GLzJp+az2iHwvQyIoQu0ZkKcODAR1rGqxm9LD5PEkPAvQxwt29j6sdn7mbcTFTwajW6IZjqsF8nZy9M51Rk3Zb9bww1KRz6jXeqMbYFGWlEnP2gPoIuVxnphK7VO8I+OMq05dJHL+vYN4CnLNNsGozGEf0225uCtPFbkroLl0lz31YEv1TFzmjgob8imewfUNEYVFOVBeYTu5pBOf1yRQBktNKGe/EoBIncuT89jk3v/moBpqhhqz83NsjvLCZhJZ3k8tBHZ/cvME0D24CkC/4GKAwVkk51O2gWFazk9uw/FvBnSvO3CQV5RhVFBPNR6b14Wtb94vxoiv1I6V62v8Gs+d25A+zCdhHUXChY/EKw3/Wnxnw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eS9Yby9Ec0V4cnVpTXZHY3VZSVc5aFYzbVBxMVBYZklTMlBxNjY1a1VpSU1m?=
 =?utf-8?B?YzZGZ3BYcFp5Q3V1UGQwc08zbGNob28yOVNFSU9PV3poSE1NMStwN0tlTTJl?=
 =?utf-8?B?bUtYRXRxRnJEYmVFQXNCWlA5d0Y0RzRueGhKTjN6bFBBR1BhZkZpM2hvTTVD?=
 =?utf-8?B?QlpSY3ZEY3E1UWpydVlwTWJWZmNIZzhRTHNhWDFKWGc4dGdtdTBDR245ZUpU?=
 =?utf-8?B?YjdrNTZqZ3lDWTkrSVZIQ0dZZDdybTV6WDl1bDhjcTNRandkOUlmTHltZVhy?=
 =?utf-8?B?RGVXaUt6eXRwZUtlVzFHV1NuUE9VWTJOMmwreHI4RE1TVVAyOUtMa3YrS1NT?=
 =?utf-8?B?cjFVTWRKOUpSNXJTZ2JuSVFiZDI2N1V5UXY2bGtQTEhHQWJzZEduTEsyT1pk?=
 =?utf-8?B?TWJlYXBoTUJNM3BSNHE2aWdpdmFiRUNhUjNMRnphRWVXaVFtNldlbjJva2N0?=
 =?utf-8?B?ZkcrRzVBeFlOdGdYRHVnMGVVanR5ZzRiamZBb1hGQXhnK3NhMjQxdG92ZWR5?=
 =?utf-8?B?bHkrVVVBdUF1L3QxeDIvYkFDLzFQNEZ5UElSUVFlVElVVTJSdEZtWERXeHRZ?=
 =?utf-8?B?R3RWejNzaEVnUjg5LzNJVTd3RUZqRU0vNlRtem02T3pIOFZ0eTY4Zm1NNXdQ?=
 =?utf-8?B?QVBaMDNhNWJEZVpSSEpxbytnWDJhU3NLeEJ6dFJMeVdDMnBLUmxUK2pVMjZh?=
 =?utf-8?B?anJlQkswT1BhL1haWXdSOWV3YUtKb1ZvUXAyVkpyS0xmWGg4WWRveDljYXZL?=
 =?utf-8?B?VGpGcit2WUw5VHB4Mmt2ZFRSdzVCYW9KWDFKb2dqL09qVkVDOWlrMnVKOFV3?=
 =?utf-8?B?aEpyaFMya2w3SlV5V3BlcVBFazdnTnZ3N3lmbUFwNkdMclc0RDVvQzB6blpr?=
 =?utf-8?B?MkZEbEsyN01sMkJjckhVcXA0dHFzdUdGcTBHMzB6TGRZVnkvejVtbW9LaEh2?=
 =?utf-8?B?b2VLVEhZVHFuUExqZ210a3lTVzBhaFFUYzdScXVsZlNlTDNKRll4UlhxVFE3?=
 =?utf-8?B?Y0tJaTBULzg0d3Jma0V6UXNMdk9CQ2JyMlNlLzRybTVGejNLbW50MHZOT29y?=
 =?utf-8?B?MElXeFZDc2JTbXJiTjU5TmY4ZUhsc2ttY0JjZnQ1bk05YmZQN3FRa0hsSE84?=
 =?utf-8?B?QWUrVVpnbFFkRU1SWW4wZmVhU0xUZ25NSzB1dmtyUkdkWURSVzJwa2RHSWZk?=
 =?utf-8?B?clU5RndESXlPUUNKMWdFQ1Y2ZlZhaWM0emJVeGVLdzJROGVrWFBUZmZSZk4x?=
 =?utf-8?B?T3lkQi8yV3FSa0VoT1Fla2FWOU9hWW9UNlREblYzY1RqL3hEbkMvZDdlY3Vh?=
 =?utf-8?B?K3NiTk0xVkZ0aXlsRUdxcHdGdlAwblpCY3IwdDJBSFhmQW05cjVaNlRqQ0Vk?=
 =?utf-8?B?N1NHZFFiSFp3YkxBaGpzQjVSYmMyTTJ5K1hzbTE2UFFEY2luVEJlNVpRanph?=
 =?utf-8?B?VmF6Mnp6TkgxOS80Qm84a1RRejJobGRsK2o0bXdETWl1ajlhR000OStRY0dR?=
 =?utf-8?B?TUFFMUZIa3pHZFlKeXhMaGN2YUlvc3FmWUJRVExxclJpdC9BY1FSa2UwZDZ0?=
 =?utf-8?B?L3JKQWZjaW5EdlRhKzVYcmdWSnhaU3hBNTVDRU4wZ0taK1pYUVJjQzNzcnBU?=
 =?utf-8?B?MVRBdGpNcHkyMDNjeGIrbmRJdDNnVE4wSHpXeFpWUVY0ejFacE9la2xucVA4?=
 =?utf-8?Q?P5XuT3afC20U1W2wb4Rq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06904d1b-3e1b-4ca2-168e-08dcac4a2d39
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 01:36:18.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1446


On 2024/7/25 5:09, Drew Fustini wrote:
> On Fri, Jul 19, 2024 at 04:44:38PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> This patchset is composed of two parts:
>> - one is the improvement of the sdhci-of-dwcmshc framework,
>> - the other is the support for sg2042 based on the improvement of the
>>    framework.
>> The reason for merging the two parts into one patchset is mainly to
>> facilitate review, especially to facilitate viewing why we need to
>> improve the framework and what benefits it will bring to us.
>>
>> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
>> that the existing driver code could be optimized to facilitate expansion
>> for the new soc. Patch 1 ~ Patch 5 is for this.
>>
>> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
>> Adding corresponding new compatible strings, and implement
>> custom callbacks for SG2042 based on new framework.
>>
>> Patch 8 is the change for DTS.
>>
>> By the way, although I believe this patch only optimizes the framework
>> of the code and does not change the specific logic, simple verification
>> is certainly better. Since I don't have rk35xx/th1520 related hardware,
>> it would be greatly appreciated if someone could help verify it.
>> Note, the DTS change has dependency on clock changes for SG2042, which
>> has not been merged in master/upstream, so if you want to test this
>> new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
>> pick patch 8.
> I have tested this on the LicheePi 4a and found no issues.
>
> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
>
> -Drew

Thank you Drew，you are always the best! :)

Regards,

Chen


