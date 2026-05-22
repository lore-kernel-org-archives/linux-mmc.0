Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3435A3AD;
	Fri, 22 May 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431697; cv=fail; b=nmzBnJiQNfTAiY5ICpf42FpM5aBSKwzKpwHZzqOwZ1d+8QeNytlgo0+fwz3c41VIiiYFC4N9v2kaSzupX+XglGq36e+1br1nmTmvPw+uFJGhoVbce568BPc589fLp9JHJisPmLN5N+MtoDTnPVFQ9vTkUC+RAqoFhdUsog1tqtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431697; c=relaxed/simple;
	bh=bbWQsDWgPlfu1Z32FDl6XtOSadfOv1Npjk6VeRV3iIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=es7SfTfWKSmpunxwJF6bxJ9qXZyis9MCZhFuxKmlLK+atnWDRgQInV0SpXuCFCQ9I/C+7ooBdwIlzTfc5oMb8lsK8RmPAJ0b7Uh82kUysm3kPVShIYnQi0qGEvkcZn71KGSJVMr3tnMAZpsT9OAMvvHnsC7yXFMVHB4vA6kZ7L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LEideaVT; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LEideaVT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyTomuLYCtFTfvUyNnS8ggyJQbUE3OUzHo72Zum3qP0cj0pFJESLHg8g3HiAyK5fpsUJDOtNKAZMkRoVqDnsC2wuYpgnTbszCiZVSXrVieNsch4KCMzCT4yy9yvrgd59ZxBqpn+9wJd4ZkRa2w6Eaz30BScIhMIfZTBRAWi3uxSvWDiiFJUj291redCfIPxA7VP59pKFlv+w0wpbQMbv8vzGPlc+HBe3cCnJfceeL25FjiF5tLzCBBU+kWcpoQD9fi9PNYtWHRrqaVwmiFU1fSTAoL5HJYy6E7+pWkpJQWvI6nNA4O/oRausM5aPIzFzPyknwLhldi4H7kLHyH0WLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCd7BfqGkhBJC8ZSwIc1DJV5ELszOUu4M1a3qtwfGqY=;
 b=H98+PvtxedDX6zDfHZbgnbkPGhe7iCs0V9Sg/Ylf5vKJ1KnKgqsBIBmM+rlupGkpfEUByg4yTOpzisoBLVqG5Vb7uSDi1wpSPQnZgKlk01vbdC/ZuaL0Tgx692sw7BL4B4jdQqR8Rq6skE84m2TPizpSPaOpTqj0GursAi7FVZDtc1JZkXFDgxcletcbXlt6GXd7BpqVu62X0XFVwhJ5frBv0FqPI+22OF9tKpzc/93VtN1P1BfqyB01kZ0+awlb062zSYzV2vizKDhoPxgEHThzDhNxLms3DYBS104mQDwOHsxTUm16H5iQobue6OnSfh528nLeeQGbPl8BR1x4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCd7BfqGkhBJC8ZSwIc1DJV5ELszOUu4M1a3qtwfGqY=;
 b=LEideaVTWJHGO93szdoIKYuZgw4fh7iXCp/q6T+f3kj2qxVfK73Uj6+77t1crXD8PMziOgPR7tM1xK37JTY2Rgefe03GAPuLLUx71qTLVhBz6GCrQ1tqT3QWplELNqcn1uxe4mUTTTSPi0qoZSxj+4TA8HYNbCdTbCuX6kZI1ngbRV+5gXTRyJbLVP+PPcb7ONZCl3qM5YaQ7IuniCDj2fkp+UHiQJX4ORgI8A4ktEztLOsceSqn1x6DppIheQR/3IF2SZoHckvvBCAe+Hu5H8Y3ntjNH7eopk6mGh+aeXfX5ferSK1tzexzCsa7OicxVbGcYs8BOSk8baeqwqtUdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS1PR03MB7918.namprd03.prod.outlook.com (2603:10b6:8:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:34:54 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:34:54 +0000
Message-ID: <b89ee69b-6a5f-45bd-bb7c-c4eef0bb8a7a@altera.com>
Date: Fri, 22 May 2026 12:04:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] mmc: sdhci-cadence: add Cadence SD6HC support
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-9-tanmay.kathpalia@altera.com>
 <6736df61-0adf-41d4-ba45-f1fa08998a58@intel.com>
 <3934027d-a865-40f9-8350-0027865a3682@altera.com>
 <d6ed9186-3081-40b5-aec3-9f3f61e6e80b@intel.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <d6ed9186-3081-40b5-aec3-9f3f61e6e80b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS1PR03MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: d55e9c31-ce3c-46ea-feec-08deb7cc3be5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|3023799007|4143699003|11063799006|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	gMfMUIRRVB5GdDwhKlZnlvoO3XJ9te3YDTEdHdckUg0TaPQ5JOBv4amYUCOLZyRcPi4mYRqu1DxKF9G7dvQUu/PXXzC6IvJkycPQPJLDZZ4vpY48SxkX0fPJLrNcwhskSywMYHxO6Y7reLhbwC3htBdPDAlO+I91RxIxvniZ/mRbtUQPt9Lp9W/16uXRSF9CPaVYV1r3x8j//srYxgJCuVPBC3dXjq6GJHQipGUp4F5QsI7X8U6P7Hl1wlRfBB5uDgPUKswHjIcFIhWPAh5V1fj70eL2GdSEFbKnbEVCe8D/coUZ8lUDouJtsthni6YGrgqtY/nZMqaAGm5LYf7caUY+1V3OaWCixDjy6UKxPCuJADNYypjaHKE5KVX6r03f3zYCC0ikQjdRH8LIxDX16BanwTkhjkyjx0dEB8sRJgBoW54/jXQR3MWh4myvtqyTC/dl6413o1XHAzmGB7CkwXxCQpuDsw/qrCOGcKEhIz0/iRvnG5uO4yCrJhh2Qk9ns8GjdM2wmLRieDpkSg+FaLdIeOGvxLZaU2bUJByWCXRvRBtsGpfvVfPmI1iE4WTdNkrG6ZoLiyYFympOLJt4aKUoPZdNSqa+a7sBevwbfdCjo/NCoHjPtbq+IB/wE6e6tFHLc5QNYY43Y5GuG8vI9tR+BU8STETYn+0HR4nUZt6o2IgfS03b5ol6VyF2kfOM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(3023799007)(4143699003)(11063799006)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFN1Y3F5Vm83VXRzdE5Lc2JGcmQ0NER6UzRvT1gvRitoZFdsSENyRGM2M1dv?=
 =?utf-8?B?R3ZvV0Nqd1lyTHEwOTR1bVhwK3Q5RTBPVERyNjIwMGZqc3BlYUY4ZHJhWUZW?=
 =?utf-8?B?N1d5VkVIK3lGYzNOWml4dWdUTFlVc1AxMXlDR3RtSXVKNy9zL3cva3RTd21v?=
 =?utf-8?B?Vy9hNmtWdGd1bEV5RldTVzNuUXBWT25tbVNpYUp6OHI2MlEzbVpDOUw0OVZm?=
 =?utf-8?B?aHFYeUtwWVN3UHJsbHJ1ZzdWR3VFU0FFdHpEWVF4RVZEd0M5NEFhUnMyQmd4?=
 =?utf-8?B?RTdYcnZvR3JmcldNOHdSZlB6enIvaGx5TzRWcFh0UCtrVU1yVDVLWVFPSFFE?=
 =?utf-8?B?N292aWk0VXJlNWdTVGRkVFZtTjZTYi85cCtCMU9VbkpTang5U3VHQlYwZWVZ?=
 =?utf-8?B?ejRJM1hxcDdacXRlbXBpZUtUVk5Vd1M2cGVtRW9rbTlFbGxSMzhlbTkybXVu?=
 =?utf-8?B?elRsSnlnb1ptWTdCcmhVRTh4OHg2MmhvTk1wY1dCalR4OFladVBxbmdFNVJO?=
 =?utf-8?B?WEFEYXpQUmtlUUNsbUI5NFh2Mm1waklCZ2dnTkxaQ05pRGhodStmczlSdXpq?=
 =?utf-8?B?bTFVYjNmSTB2REhVUGtMcTRtcHltclRyZ1VHRmRjQVJINzNyOWY4ZWQrL0pQ?=
 =?utf-8?B?L0lFSWl0M2RpT204NkZmSHdHS2JaV3FPMGhvMjlrdWlpTVRKeEF5TkdlNDR0?=
 =?utf-8?B?QmRJMzdvSmgrWVBqQ050UXluRkxMQzQ2aW1BZFNNQkhPbWFUNEROV3pqeVJJ?=
 =?utf-8?B?cGNaQ3EyRmdJTTVJTU01REgxT3dROFZYOVFReVVXbWxJbm9oT2MyS2hKYzZl?=
 =?utf-8?B?UFRZdTlFRDhCUk05VjM0cXZTL0NVNk84ei8yZGpRMllPUVhSY2JHdHlGcy8y?=
 =?utf-8?B?SWwwMXlTZUw1V0d1WHJBLzRuYjVwSUN2d05IVGpESXVZMmEvbHdqQWhVdmRX?=
 =?utf-8?B?eTNSZm9ZbjZqZzlXamRzTFdrNE1rRXN2Sko2U3BzK2xpM3E1YUpCMXRmWVlY?=
 =?utf-8?B?T1RXQWFoT096YUp4RXRDN1ZZZy9hd014dGk5Wm0yTysrNE16ZVI0S3RPeFZK?=
 =?utf-8?B?WVgyWnN3Rkd0M1d0VUxnMUYrVllDYkV3d0VMK1JYQVJtZlVLaENUbVFhV2Y2?=
 =?utf-8?B?UmFsaWZGbEF2WmhPOUlZZFN6cGJUaVJUNHhiMmY4V1lQQUhXUVBjdzhLeUx4?=
 =?utf-8?B?SUt3bDh4U1pTRVNnOEVTUXZta1JTeGtibEhQYzYwdnJZb2hpQStrRkNDeW5l?=
 =?utf-8?B?U1U1TDlNZ28rYjRZcG5zT2hKSFY2M05CWmpFNnpnL1ZxUGROWWJUSU1zSkxh?=
 =?utf-8?B?UiszOXpkOFA1OGhITmx4eFhOQkpFQjIzKzY5cFA3QktkL0hGQ0ZuVHBvekNy?=
 =?utf-8?B?SkNVbEVmRW1XbDIwaFI5SEZHWldTYVE3aWJXYlE1SWZHQ1QrT1B6dGxEWU5O?=
 =?utf-8?B?bVNmclNvcFlnOWgzMEJlUlZ3UTB0S0tXeTFGQkJjNE5EU1VuSENNbEhoQlRi?=
 =?utf-8?B?L2ZReVZVbkN2amo1SFg3UnpDbHlRWHR5SXQrSnJvUU1WdmpzbXdMQ2xXUXVG?=
 =?utf-8?B?OXVmQWRab094Q1JubDdQUEVNMFpJNUR6Y2lYTWxMcE03M3ZsQkQ2S3JrZ3Yx?=
 =?utf-8?B?UlJ5VkhlVEtYYnFuSDlhMmZ1dDJGcHFvcUg1Qm1aOVlJd0JpWEdNTkZoK214?=
 =?utf-8?B?NjNhU0YxNHhRU0xaWk5qVkNVYW5Jd1Vhd2p1NStMcGpIeEdaenNONDV5R2hn?=
 =?utf-8?B?QmJmS1luSmlSUHIyYmNJZ01obnhuejI2UkxwNEYzL2dKYkhtQWNjZlR4bXNt?=
 =?utf-8?B?YlpBeVdlSytMTXZmWU5Sbkx5NEFOSTdPRlNrb01nZm1NK1c0SXhoaWUwMTNP?=
 =?utf-8?B?ZzEzcEowdDJtemtvTDVoMnUxais1aU12TU9aL3ZReVdqSTNzTDI5RFlLeEhG?=
 =?utf-8?B?WTVjcVFYaUk5SUIwRnIyMC9XWTlyMUd4cGpxenR1dkI2T2JFY3NDWkM4Zkh0?=
 =?utf-8?B?UDNNUW01ZFhuR0hEQk5WZVlpQmJ1N0NzcHBJcFlIRTk1OVNaN091QkJWVW9I?=
 =?utf-8?B?d1VRY0E1b0RmdWRueW1PeE1VY0FZcHhlVVVyN2hxaWtLRkdUZlRnL0t4Rllh?=
 =?utf-8?B?RHpoVWtrNWZQNnFwTkZHczZiL2xpcXFKNkpjOUZudUFzQVNkZXZ0QVBVeEVO?=
 =?utf-8?B?ZG1PN3c1NDlMckNVa01UNDF3b0JTdktJRDNtTHkwOXpZUHlyQUU4VHVEcUEz?=
 =?utf-8?B?UUVBdDV1TjA3UkZxK01VUld0c0lMcEhsWXJydEZ1Tml5bEdjb3JvS2h6RWZx?=
 =?utf-8?B?VE41Y21jczU4TUo5ZFMwK0ViT1lUVjB4bGV0TDM4c0NtbWhQZFJscEMwcmgz?=
 =?utf-8?Q?x4hyhTbF/B8cTsSg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e9c31-ce3c-46ea-feec-08deb7cc3be5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:34:54.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aHawOwu7JBJ8J3ozDA/WinKi0Iy9pPQCFVvjRdgT+vNEhQSyDuv0BcjNBUOTUGjqHSwZ3O4xKYoX9lXo5aU5QtFAqk+cYGHQohc9WaXlPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7918


On 5/22/2026 11:02 AM, Adrian Hunter wrote:
> On 21/05/2026 20:28, Kathpalia, Tanmay wrote:
>> Hi Adrian,
>>
>> Thanks for your feedback.
>>
>> On 5/19/2026 8:59 PM, Adrian Hunter wrote:
>>> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>>>> The Cadence SD6HC is the sixth-generation SD Host Controller used in
>>>> Agilex5 SoCs. Its PHY differs substantially from the SD4HC: it
>>>> requires per-speed-mode IO cell timing parameters and a DLL-based
>>>> delay line to achieve correct signal margins across all speed grades
>>>> from Default Speed to HS400.
>>>>
>>>> Support is implemented in a new sdhci-cadence6.c alongside the
>>>> existing v4 code, now in sdhci-cadence4.c. Shared structures and the
>>>> v6 function interface are declared in a new sdhci-cadence.h header.
>>>> The common driver paths select between v4 and v6 PHY operations based
>>>> on the SDHCI specification version reported by the controller.
>>>>
>>>> The new compatible string "cdns,sd6hc" identifies SD6HC hardware in
>>>> device tree.
>>>>
>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>> ---
>>>>    MAINTAINERS                                   |    7 +
>>>>    drivers/mmc/host/Makefile                     |    3 +-
>>>>    drivers/mmc/host/sdhci-cadence.h              |  113 ++
>>>>    .../{sdhci-cadence.c => sdhci-cadence4.c}     |   92 +-
>>>>    drivers/mmc/host/sdhci-cadence6.c             | 1051 +++++++++++++++++
>>>>    5 files changed, 1228 insertions(+), 38 deletions(-)
>>>>    create mode 100644 drivers/mmc/host/sdhci-cadence.h
>>>>    rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence4.c} (91%)
>>>>    create mode 100644 drivers/mmc/host/sdhci-cadence6.c
>>> The new file names seem slightly misleading since sdhci-cadence4.c
>>> is the main driver as well as supporting V4, whereas sdhci-cadence6.c
>>> is most of V6 support.
>>>
>>> There doesn't seem much to gain from having a separate sdhci-cadence6.c.
>>> Isn't it simpler to just put it all in 1 source file.
>> I believe keeping them separate improves maintainability for the
>> following reasons:
>>
>> 1. V4 and V6 PHY programming models are fundamentally different:
>>      a. SD4HC reads pre-computed delay values directly from DT and
>>      writes them one-to-one into PHY registers.
>>      b. SD6HC takes only a few timing parameters (IO cell delay, delay
>>      element size) from DT and derives all PHY and SDHC register
>>      programming values inside the driver through a calibration
>>      sequence.
>> 2. The V6 PHY logic alone is more than 1000 lines. Merging it into
>> the existing file would make sdhci-cadence4.c significantly harder
>> to review, and maintain.
>> 3. Keep code structure aligned with U-Boot, where V6 handling is
>> also separated.
>>
>> That said, I am open to merging into one file if you think that is
>> better for maintainability in this driver. I can do that in v2.
> At the very least, the file names need to be more explicit:
>
>    The core part of the driver:	sdhci-cadence-core.c
>    The V6 PHY implementation:	sdhci-cadence-phy-v6.c

Ack. I will rename the files accordingly in V2.

