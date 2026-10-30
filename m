Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793340213;
	b=cv8Af6F/XN0+D+rvg9TekA0ag3nyxs1nTwcQVfDiONSTBNbnnLu1J6UudBex45peZUf5
	 RFaCalF9pOYkPMKhgDo0SCuN3hexSw5/pMCS6vaLj3srS1v44i13+/GXLIuXukaZUjJNH
	 2WD6dI6YfcQvOETC7QR1G5DTTaiBAJNVXBw01Upaq2aFlXzrpv4OISu7ZQDnQkJfJLtjG
	 StW7gPN4Qqw8N/9RZL3ViVYBWj8JJeCH3jt2NuxtiyWP54O4c9pmh0sEVNLkFb7KfEUQh
	 91ERE8EyqUaM7iUbLilkiC0J+CZLfnbS5KibSm8r51lF1KmlaqdmhVJZxDMrnFQRCQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340213;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0p/dMeX9PUqnWJEGKFoHoxEj+FFHnbwvnUPcoZGJU4c=;
	b=d87qXVVf1SjxU8JTIV++iBLacqUQQj7GANJzoVmgJlUHf+u5ULoQzyA4I5bb9QbgVCsL
	 lkGWQaUSmibYUviJNMFs0EORXnTfVnK20Rb9QeMmK+vdzWHvr8V4YoEWSHL02dLUa5jrJ
	 R5731oWZvBswOiVXbgtPIAzvqEx7A6ypyuAH7SszT6nR1txEbZqb9QUKd4G2AGGiq6+1X
	 PUGPoeGqXyd+VbmDfF7Uy6yRmA66Y2Er+NJThSDm4Zao34Ss5qRyXAXM5NxgGf4guAADL
	 QspkN55jLHL8U0xUfIKJWwuDX7lmoDbqLGhWKz5aKCDBYVBqV8IL84oFtgG0GKLFanQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="e7DL/G1N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.32
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C7606A31C;
	Fri, 30 Oct 2026 06:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=e7DL/G1N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbc+Vrfayjj0vGV73NMGbac2pBOfwiK1RDCdi4J0w8qT9oLHjDyhXqogJDnNF2iDBzV29efnyr57R9lj8QJxfprEcuXdI22X9hK7jXuO/AyO0PEKbNmT4VaGwN84NfUFMuZ5kmuWDvRrslsUszJYXelwaCvR5WbFhxpwvuHFVmVqcT/+nRpqGSM/dhKG0lk1Gg5Kx5J11saml2cE/3t2p3VY7LBPQywVi8uLfrGyuo9QLrycGCG0e6liHppOc3VhGEJiSzy8ABwjPxXS5mjJKOLnh8cGuEdpOr+PUXTjYrtsazWLyf+J61o2xw2XJ/Z0Tq+F2kJR/c6meqOcDyRbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p/dMeX9PUqnWJEGKFoHoxEj+FFHnbwvnUPcoZGJU4c=;
 b=m1Zc6f0BmOLPCfTxl8Cxs3J+Ec5K15Az/aPrKju4gR15urXUwsCKzuGDZsRnPXzPndun8P9m9+3EMMGnSD30uuIOMeVU7SaQSyf7M9sNn5DDi/3SehskxvQakhBES3qpv+ulNh+FQ4fZmGc7kHz4cAvuo/xG5jk07szULY2tA/mVXv0Vl3G7cT6XDg4rK9VluWMSx2KUtJln+mQypQF7bK26inO3fjqh2HyOt/tulrNuWf8/HQUeOYq66XA8pp7KB1EIxRLED0HTFylt6hONlzjo/gelu+KLkBuTwR0QGtzhk8RQlvlZGwLbeAwGOeASZbpWmUxslMzH4rpxgvzu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p/dMeX9PUqnWJEGKFoHoxEj+FFHnbwvnUPcoZGJU4c=;
 b=e7DL/G1NqBfmdlK9LeA0qOIDL2I5QrnbFKx23aZe69kIaAdWWnI0blpR4YP9tyqNILKtqHAWafa3HFaT0K1VxG1c78fBirdJFCI10Jcsff7O+0JxV+Zr2VbthfmU0+nUKy+1JFwScxqzOFXsKMvzjfZ4H5OjTa8YS4W5FLXdquriPK19Zrat3tCbygDIH7gFRVgdcizs5X0jErX6GRQ9NonmYnvMthnYQR18GxNsy7A6quQ10ooc6FPJQQ4SaryoE6rEuJEbRtK7PV5mMkEMqYrfqtIuc0KRkLc7Va/VSvOhEZC8pQBm7qLxc29ShgrFAd0OnLQ0SUmibqnL0H/bpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by DS2PR03MB8466.namprd03.prod.outlook.com (2603:10b6:8:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:03:28 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3%4]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 06:03:28 +0000
Message-ID: <b71ef5bb-aafb-4360-a402-aac8f48f2b16@altera.com>
Date: Fri, 30 Oct 2026 14:03:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from
 device tree
To: Adrian Hunter <adrian.hunter@intel.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <295b570ed26d727c4bd4ce943b723c6cc959ca71.1791459448.git.tze.yee.ng@altera.com>
 <16c32323-0869-40b2-aabe-81727c87bf35@intel.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <16c32323-0869-40b2-aabe-81727c87bf35@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To CO1PR03MB5937.namprd03.prod.outlook.com
 (2603:10b6:303:6e::18)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR03MB5937:EE_|DS2PR03MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b302c7a-ed81-4cc8-92bd-08df364b8478
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|4143699003|11063799006|261009223027099003|261021123027099003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	A21uxkB7DE1NGrsUMeeOf+6Ck1OLOGSXWfCQi1z0mUKEt5wPTjpVsoZk1M/947q0XiRThMAm+QuLb2uPS/LtnzrpqWYdFnBP6j9NsPqqQF9eejKxx4BXA0zZ/nWX9p+hfWRIq2EJUeNu1ZKohlu3TQxjQoPHhBt1boNrCe47ycY8ywJcnamg6eClhpic6f/qIDQilOf4zxpx/k6ZsKCmcLueWLiG4RQzPe4Sxq6agSDJr9VAoqiVlDRj7HHB6OmKhZSiYpOxN93OQqzbSPgUzPU4foqHx7JrWlyUc6pT/79uwXhly9eRi3F4pBTFJDbqJUG1IRJPw6gcRmlNTzJFvfmI9vTZxmHSATO3oDm3DygHQNIE8Pdiph6kIdetni2yaEctXKb/VTgPgkzDLYpr7lMbBTls/4JvTDNW3N6wlzwwFklsI8XrwBDafw4jRqEv1zDJ42AQ07d/d96Vy+75tZMQugKWaH7eTMtQDOJ/a2uUxr7LC26Hv1FiDZ1JvVTtHky2v/YnXdOl1dYza8WeBHmk3LkMl9/AObnpz7XX/q0Q5ZbFl5E393HrZ6+K8opyE90LCtnVGksigoEDts+uKTfykl7Gsw2JPDU+cpvpyWSVYXj7rugT7FHug5Ygn6wMdPW1BdQa+EeIC8iUeQeFiDCPOyBfuvKQg8LeeyugXsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5937.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xkNlFiV0w5RnE1ZW9SSnVtakF6bXJKcjJLT2o5ZDVDK3huVy8wYkUyQ2dH?=
 =?utf-8?B?eXVteFZFN3NTNXNlcmNDeUhEaHA4eGZtRTYzODd5ZUdVOVRyVG42ZnFSMFRZ?=
 =?utf-8?B?Skx0blNtWGUvWU1kUlo2Q001aWNKY3pzU1lzN1JnT0pzaVFINVo0WUZyWlR1?=
 =?utf-8?B?SGd1TFJyc1dyUTJod2hMWDJ1enRlR3ZoblNyaXJheGpYZlNRM1ZuQVhPcC93?=
 =?utf-8?B?dmtqcE9zZVJlVWxOL2x6SThCN2daQmhDN3QyczFKNitNbWlRUjBQak1jbThi?=
 =?utf-8?B?aEZKRXZZNVVwNWhhRy9JYWJGazJpTzJ0ZWVRbjNiY0Rqa0p2WTNId053L2RX?=
 =?utf-8?B?ZWFnRWhVS1E2Tlhza3FYV0F4bHZnL3R1UnRxTG1FRER2T1cvYWNxSVcyN2Nu?=
 =?utf-8?B?VXo1WW1NOEFNWlZEK1h3VHJlYlVyUUJQRDB0dk5oT1NqU09IZnR3ZmQxRFQ3?=
 =?utf-8?B?T2ZGRHh0YkRiVmI1R3grQnZkU3V4cTlUUDBRNVdYaGliUllGdW9MeG0vOHVR?=
 =?utf-8?B?UFNxK3dPWGpNUzkwMGEzdVJBcUhwRzBPcllOYmc2Wkh3amFWOHlyZHFvSVpF?=
 =?utf-8?B?Zyt5Q1Azem1NV2crdU5rWGlHMXZPc3RQTzE2VmZkZi9jRjJkUHhnU2llUjlX?=
 =?utf-8?B?Z2ZwblhNS1JiUlVoRGtnRjRBTEJKZjlpUkhVaGxqckRnNG1pNTE4TkNHbldR?=
 =?utf-8?B?OFVRQmNielN5QlBqMlZLNTRUdXRPVjdGdkptbDU2N1prVzNUYVBMUjVENGZr?=
 =?utf-8?B?NDlwa0Q4SHM1bkY3ekY4ZWZFYlp1bUdUNktNVCtpZDV5VDFYMktVRVNVQkU1?=
 =?utf-8?B?S0dPM3N2NjdqTm5WdS9WVXRwM3l3MXR5WlJ4cFY0UmgvVnFXdC9RM2IxU1Nh?=
 =?utf-8?B?TjRjSmNoZVhvUGhrWmN3dmROQitKdGdaaEh3VGI5S0t1VlhLYnNxWWl0UjV6?=
 =?utf-8?B?Y2xjUEk2ZXFLc01hc0lpaE9ISHhuVDVyUjU3ajd5NU9Qc3NvN1JPeUFMTmZ4?=
 =?utf-8?B?M2ZXWjJmV0FmZUs3T3BWVEt4UVJaaGtSQ0xCYWpMUEVNMjVwa0NrU3BRUnlU?=
 =?utf-8?B?cW11K3llSkxsYTNUTnJISTFrMTZUc2t5T1kyVmx1VElvQjFSZlRFczlwb1JB?=
 =?utf-8?B?NmhwZ1RuSjVINWpHQjJTUWNoTWVoVkd1bWlXRUI4UEpRazdsaCtpMENTb3p3?=
 =?utf-8?B?UGNJYWZlcHpDcDlaR1JUOWJvTWNTRThaN3ZBcTVQWEdGTEdPeVlPVjNkUXFD?=
 =?utf-8?B?cDlPM3JObFBXTkRjR1JGdS95N1hXZUQ2ZG96Z0JiakFkdGxBNEQzZFpscVA4?=
 =?utf-8?B?ZkdzdzJGcXRSRnRtMTRlWVRPU1lYSFp3M0FoWmpSV1k2Rlg2WDV2cG1jWGEv?=
 =?utf-8?B?Qi9pSncvWC9lejBWOFBLQUJYYXd2SGYrSnhVUWJFdG9NMjZieHJHVncvdTc1?=
 =?utf-8?B?NmZQZng2aHBHbEdVM1Q1M24yS1pWZmRnZG1Ud0szZ1k4WXBqZTZVUG1Kc0o5?=
 =?utf-8?B?RkllSU1IRFl4VUZyWHgvRSt2bmRMSmdHVXJPRDdRVlRrWGk1emZ3N3hzOVly?=
 =?utf-8?B?WTR2dnZFeGM3MTl4c2kwS2JocnlXMEJCZ2dmQlM4TmdNVUpoWDhqWHpUN3FC?=
 =?utf-8?B?QXV6YTdUWEd1WklhL2FiUHJ0UHRWeUxQd0UwOCs0c1dBMHpjVVoyd25UbFQz?=
 =?utf-8?B?TUY4a3NLVVNyYW0wMzJCdzU0Zk16a2ZCZFNmREVZUHlsYmVwbmJkd3JRYTZw?=
 =?utf-8?B?c1gyU0tvdndyT1o0UkIwbnY3WnRad2ozMmQ0ZGVaQ2c1ckJyR2cvR3c1cTdk?=
 =?utf-8?B?MUdEcldqdmpHY2hvVFFQWTdWRDBDQ1N3Q0ZPcFNqb1pUeUdJYm00R2xJb0lG?=
 =?utf-8?B?VldEV2wwbTlsUkV5MTlBMDBFYndHMjN6SnltYWcrdXduRTVjYlIxQ0taSEdO?=
 =?utf-8?B?dXdFelJqMTBzc2hTMm42b0FBSElCaDlQVVJBOFFkTHFqd3U2OHpkMFZKOWtO?=
 =?utf-8?B?Q3ZWOWVnejhRcUtxcUpyNWdNT3UyaUxVODVQbnArVC9vSHFIUUx1MnV6M2hP?=
 =?utf-8?B?MnlieS9vZFErZEJyV3BsalF1S0daVVIzU2JZbWdod2Zma1NLM0w5QlpRalA5?=
 =?utf-8?B?WVNHT0tNWERPcE51LzcxV1NyQzJ2RGZEM2FWSTZBaFQ0Mm9MSkxLMVM1WUF3?=
 =?utf-8?B?OVVJa0JmN2RieVc0YXhkOWQ0a3AxcjNaNFZSL1lSb1NPcmowcEUweE1nTFpG?=
 =?utf-8?B?QmEzZjZiQ0FlcTllU3dNWmdSeWdQWC9IdGo4Syt0VllabEJXcUNZNDM3UHBh?=
 =?utf-8?B?SFJoQmo4ZzVrUEVhTWRxK1AweXJoS2dKSlV4OFpNUDZZbWZNOXQ4QT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b302c7a-ed81-4cc8-92bd-08df364b8478
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:03:28.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0CKTS8BqNyQ0kSXl0GG8L2bcni4P5lPGiAo0/JBIjnKwsuYIAs0RoX/uQ9xM98XczQCluoO5ScFxAdDzMB5qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8466

Hi Adrian,

Thanks for the review. All three will be addressed in v3:

On 29/10/2026 9:25 pm, Adrian Hunter wrote:
> On 09/10/2026 05:14, tze.yee.ng@altera.com wrote:
>> +	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
>> +	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_read_dqs_delay_ps) {
> 
> The same (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52)
> appears 4 times.  Might be neater to assign it to a local variable.
> 

Agreed. I will move this check to a local "bool ddr" and used in all 
four places.

>> +	/*
>> +	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
>> +	 * eMMC DDR52).
>> +	 */
>> +	phy->ddr_read_dqs_delay_ps = 0;
>> +	of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay-ps",
>> +			     &phy->ddr_read_dqs_delay_ps);
>> +	if (phy->ddr_read_dqs_delay_ps / phy->delay_element_org >
>> +	    FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY))
> 
> This is still effectively validating the firmware values
> 

I will drop the probe-time range check and dev_warn entirely.

>> +		dev_warn(dev,
>> +			 "cdns,ddr-read-dqs-delay-ps %u too large, clamping to %lu elements\n",
>> +			 phy->ddr_read_dqs_delay_ps,
>> +			 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY));
>> +
>> +	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node,
>> +						     "cdns,ddr-no-lpbk-dqs");
> 
> Unneeded line wrapping - can use 100 cols
> 

I will change both of_property_read*() calls in single line.

>> +
>> +	phy->ddr_phony_dqs_timing = -1;
>> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs-timing",
>> +				  &prop))
> 
> Unneeded line wrapping - can use 100 cols
> 
>> +		phy->ddr_phony_dqs_timing = prop;
>> +
>>   	priv->phy = phy;
>>   
>>   	return 0;
> 

Thanks,
Tze Yee

