Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2031.outbound.protection.outlook.com [40.92.103.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023C1367;
	Tue, 18 Jun 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669351; cv=fail; b=rfxz6Cf1AobLPhd4UhDp3BmZ6MNQBljrJDqZuxsPISXXdVyh7y63unRstnK46zfaKA0Y+nghbqTtnc6+H0ngmOuqwSFADyLWGCqyw4js2yS+KwnwbX8iiOjpBNPrPpxn5IvppA/MrnaU6rHNOQVseT+tpi4V3vhmCf3tYZ+39Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669351; c=relaxed/simple;
	bh=BYz/2oaKD7NTQ+SNa2dn+XhCoVUwa2hPA6dDxgE9hi8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZfk5T3h7Z7HP1xwlVunZ6g+Br/8hES0FeB8DWcau562i191bjzHNmlSeTQmjsnMBZo9/Z570bTm+XZzjuPGfsq3ccVm/qTVHTnP8vRkCN/NM2phX0KIypWC/TZoP1tg5LqS5ojBkFeObfdG0w6h1HN2O0giIcVu2mpzCjy1IW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NCcovWaK; arc=fail smtp.client-ip=40.92.103.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NCcovWaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF3pLVFMzfl8ZgAgC6lHBvzxUhm2Cmkm/IlC1nMGNn7knd2GGQwSkzibV1fXLhkaCfLTzSS+TW13GIwb2P2poW0Pnd1Cu0wA8TxXO2T0K4yeikP2N1lsLgn+N2IRXKpQ1opWbZG227Cmlq7kpQ6OmWJcbFRjFEePUohvk7lH5NwNHu8zNAaIXkqLN+lhtQYTqlgHXD7Ha53Kl5iBiL6700XKsHKs5nsHeKH+E10RqjJKhLN/c1aBsRCzTtXD0FMUoF51wTuK7Md3TYX/ksrHDqB+ES75l1kX3cXWUOMV3ObntNbvxsiVEcxlMUmkVLTLnz8Hiy1C1CWf625kTB1yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnA5P3qDAH+fqK/ueMY2TXU2K0iPm0phm3CIX3vY5HU=;
 b=AAMbIwJKpZDadcvbnzp9GwMQxkEh3/1BiE8ELSjVbq1oeIp+CDFA2j0Tmskgz7x6SAHyn7sGxJDw6wtw03UT09d2iJsV8CBDZReDgFUL+Zo32ZNZAG3eYAIl+Xc/jJeIvh1AHrve14kTTSet1RTfbRAgdG0SLZrWaxqZfX+4dyB25wusr6JBzqM6ju2uzos9jKJt5EIZ8tGHpyUnuYKRi4ymUpOnlxLQWbkz7UFEqZsCvZWNTf5dXuzz+nE3dUcEV3ALhb92seK+hPzQF4PAGQZe647T9aWpOJnnc5XKxCzsdSXhd5tkVW7TBN41nJLnp1Op8r3nKGJRYUoR1NYDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnA5P3qDAH+fqK/ueMY2TXU2K0iPm0phm3CIX3vY5HU=;
 b=NCcovWaKh5ixbT4qmE4l7tdd/SBJnYwhp4rkklO+aZbVLSh7A09k6Ux2/mEDJiNTytaFcjAGDVyBjfqKWJdF5+LqRY2UH8X47fRuy4+j4fh6OJI5Vo3DGyjSg3i/8FvGwhYuGr1anHCf8lERlwK83cfFHhI/ixyZLgso2M4IbXAZnE61eHasyvhtuhPeHdnL/8iFe/Sgama7IvFUjZZyU18flYOLVjmLe79YeXmYj9VQ0nygpPnjSuqYmHAiA8VTvuR4zPlz1CVNvRcEtfl3A6o7c/cnBySvok0tCqF2SPj9vzvPgDqT2QL42JWmfTYl7vAYB12JERY1IiCYB4r9uA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1497.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:09:01 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:09:01 +0000
Message-ID:
 <MA0P287MB2822FA0D5E803B0C91A0E19FFECE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 18 Jun 2024 08:08:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mmc: sdhci-of-dwcmshc: enhance framework
To: Jisheng Zhang <jszhang@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <ZnBFsLFJdi5TMA2e@xhacker>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ZnBFsLFJdi5TMA2e@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [SnAmz4zYLvP/EpSWIT7jXPI9dEsd6maz]
X-ClientProxiedBy: TYCP286CA0255.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <04243d53-765e-470e-80a8-62371886542f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: de746c9e-1c92-4f00-d7f5-08dc8f2adb33
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	XgJAc0yWCoWG0SdZXt1JsXOjVEUnIh6n3kuREiN3eTDcdZgeRNmNjys9Ia3w1nui3QnSM0djkdL0oo43tJ1k2MmWZiMZlvz+gF160UVedr/t/HObZp0ghVYsH3PmgTkXh8ylYEy+tMIjdUa1yJF+TDbtG6mTwBRkdnuJ13PzFj5llJ+qG5vj75Pbi713Kf0ZwzBQvfSgo7bofhQ5ObB6Kdb2LyLcifjhfu2oETOMbjTL9Vb2g1GVEcbXc/iMDD9pSp1D1iNv+wFSim2Zk9tkXJEeXvYW1FApLziKzIS594MnnHpmtYg9bNslv+pq1mZ+/u0dz8tGnlC6dztqVIR/+aXCrzrpQOtL2FSbULS4J65eMDd0qIEDgPOWT6x4vctUOqX64tV6YGmuiZ45Xtupwfq2OIzZZYdUNSKFGq6tPA6lSvd9Jp2fHJhodETAbkioJDUrJUwsd8ZF2BB+ap6vOduNl46e39CsF0IkKwdaeoQdEb6LoVvpjp63kL6AreLKBxLxLX7sBHsHZauCrwL+K9Zih3WEDnV6myS3fSSpFxIY++qCBp3Hb0mq5ZxXMg6+mv/cvaMTv3+k+5LyZIBPq1I+m4NqAjbz3Ar0S2Ztu8lD0SHykNHI8NHRXM2wWvqqKCtWlZxJ0sY8R18n5Ru1l+dI1InnQzfBq/sHwxY3DcEYYHYkfNG/n8keHWOcsOL0JLveK7u7lbMT7qTI3MSwAw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEY0MEZ2MDRaazZzVUFwK1dCNldSc2xLTEtrSVFjV0FLZTNuV1hnMkdDSUZi?=
 =?utf-8?B?eFNBVmtIaCtrZFBZNDZtb1NBNTBrSTg3UHFFam5vZ2hUdHpvVEFGUDQ5U0ww?=
 =?utf-8?B?MUxMQVZCQ1BudmoyZUZSNGYrclJtU1VRNzdRMDRzN2tvVzJDWDFaRzMwYmtx?=
 =?utf-8?B?U2lJdXBKOFg3YWNqYWRTbHl6RlFwTENBUHYxUXJpNHB6Z2NVVGtoQmoyaExK?=
 =?utf-8?B?amRyL091SHVscXNwWFZRbUg1N0t3c09JNU9FYkhub3dmMkF1bk0ydGEzbS94?=
 =?utf-8?B?di9icU92Ri9MY0tHa2JPK3FaN25aVUFKMUZVM2ZoVVRobXRWSWhJWE93Um82?=
 =?utf-8?B?TFBtWUZCSXBIdlYwMGZUd21ISFB3RERVQy9MR1pBeGlETU5ZRFFNVnBNcFI5?=
 =?utf-8?B?VkNTK200ajB1M2pYWWhBVzFldnV3N3BCVjR3dkI3RXJvMWRGdVBGQkZOTE8w?=
 =?utf-8?B?dXpiTWEzNktHNEhmYnlpQUZXUEtxaVdubUlaY1pkSEV5b0R3QUVIeU1sUkZO?=
 =?utf-8?B?YW5YWHUwY1VBYmpONDhOa3dXc0FaVGdXQlMyQ0J2dDFWWUlXcGtyKzRhVGVN?=
 =?utf-8?B?bXNsRktOYWFBUXNka3g1OE4wVGtRTTdyUUt4YVh4ZW1BeERkNXlBc2dBRkxn?=
 =?utf-8?B?b2F4TWtwY2lERERrT3ptL2hiZm92NXoxVEowLzBxY0pzUlVBdXJnZHJkTkZP?=
 =?utf-8?B?Z3NCUWV3VC9uUnhlSEY5cGNpdWhBbWtXa0FYRWk1TTdETW1WQ1BiTE9PbEF5?=
 =?utf-8?B?R0VEajZLbm1BczkrdnNWVDBZR2NiMXQ1blFtWlpBdnVEaXR1YzByOFc4ZGxt?=
 =?utf-8?B?enVEMWVQNjVySmJtK29INWVIc1k4anZuc09OSmVNdy81MTM0M3c4WGdjR1VO?=
 =?utf-8?B?eUswQWFoeURrYUUwaTRBWlVPdWc1RWUwRE9EODNhT0x2WVlWY2R5U3JPUlVq?=
 =?utf-8?B?NkxseWR3TUtPRU5jUG5tSHJhUjh5NnlJdGV6Q05MWEF6bHFkdXR3RnlqUEhC?=
 =?utf-8?B?NDVpL2grcXlkZW5pekltb0k2dXpnWUtwYjNXVG1xaUxlZWs2cmdsL3l4blpZ?=
 =?utf-8?B?QnlPVnlTNXBneUhyd01LZ1pMbE5DemI3ZTVOY09TSmxGQ1ByUm10WnhJTWVJ?=
 =?utf-8?B?ODhIR2dWaFhZRmxtYXVUaDVkalIxYTA0LzlVdDFZSDY2L21ySE5XRlFEbGtn?=
 =?utf-8?B?U1hRVWx6SStmVnNiTW9JQVpqb0gzTHJXRkkzUkJoQ0tJTStQdURRRFVWUVZO?=
 =?utf-8?B?RHJuS1Ewd2hybDFUdDVyVU4xNHorV2ljRHNNeFQyQktNSHRBMGhqOVRIWTJN?=
 =?utf-8?B?anJvZG5UcjJLb083M1M3M0xiZThjRWF3Wmt3R2NnYzdVS2hZN054Q0pFL1lK?=
 =?utf-8?B?TUVMYWIvNmx0Qml2SUFYamJUa0ZsaEwwV1I0eWZubitKYS9QNFNtVlFiREJQ?=
 =?utf-8?B?TjJaSk1zcUd0NmJNRURHazhNYkZYTjc4QjN6K2FUamZkbCsrRk5vMzJIT2JR?=
 =?utf-8?B?Ymkvd3NRZmI2bnZlQndFdFdlaTdpcDdMSWdLUVkwNmt6eExJOEF4cTJPNjEv?=
 =?utf-8?B?N1hzN0hqTXkyQW40NWlselh4eVphTnVzNmtZZlkrcG5YU1gwK0pSUy9lV2hp?=
 =?utf-8?B?djN1OTd3VEVYN0lWUWZvUFZSZFpEYnJRUE4xcEgxTytKKzlNYVZ0RmErZ2xv?=
 =?utf-8?Q?q0nVmQqhs0y6WSKNQiI+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de746c9e-1c92-4f00-d7f5-08dc8f2adb33
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:09:01.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1497


On 2024/6/17 22:18, Jisheng Zhang wrote:
> On Thu, Jun 13, 2024 at 09:42:03AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
>> existing driver code could be optimized to facilitate expansion for
>> the new soc. You can see another patch [sg2042-dwcmshc], which I am
>> working on to add SG2042 to sdhci-of-dwcmshc.
> Hi Chen,
>
> IMHO, you'd better put the sg2042 support as the last patch of this
> series, we want to see why the enhancement is necessary and how does
> it help sg2042 upstreaming.
>
> thanks

OK, I will consider this in next revision.

Thanks,

Chen

>> By the way, although I believe this patch only optimizes the framework
>> of the code and does not change the specific logic, simple verification
>> is certainly better. Since I don't have rk35xx/th1520 related hardware,
>> it would be greatly appreciated if someone could help verify it.
>>
>> ---
>>
>> Changes in v3:
>>    
>>    The patch series is based on latest 'next' branch of [mmc-git].
>>
>>    Improved the dirvier code as per comments from Adrian Hunter.
>>    Define new structure for dwcmshc platform data/ops. In addition, I organized
>>    the code and classified the helper functions.
>>
>>    Since the file changes were relatively large (though the functional logic did
>>    not change much), I split the original patch into four for the convenience of
>>    review.
>>
>> Changes in v2:
>>
>>    Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
>>    patches at the link [2].
>>
>> Changes in v1:
>>
>>    The patch series is based on v6.9-rc1. You can simply review or test the
>>    patches at the link [1].
>>
>> Link: https://lore.kernel.org/linux-mmc/cover.1713258948.git.unicorn_wang@outlook.com/ [sg2042-dwcmshc]
>> Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
>> Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
>> Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
>>
>> ---
>>
>> Chen Wang (4):
>>    mmc: sdhci-of-dwcmshc: adjust positions of helper routines
>>    mmc: sdhci-of-dwcmshc: unify the naming of soc helper functions
>>    mmc: sdhci-of-dwcmshc: extract init function for rk35xx/th1520
>>    mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc
>>
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 598 ++++++++++++++++------------
>>   1 file changed, 339 insertions(+), 259 deletions(-)
>>
>>
>> base-commit: d6cd1206ffaaa890e81f5d1134856d9edd406ec6
>> -- 
>> 2.25.1
>>
