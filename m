Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4E1CAA78;
	Tue,  6 Oct 2026 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266304; cv=fail; b=efX6XjxUfqAEaqKax3r5HkAxczDu9kYckMPzXvecGiP3syFozykdXP+9ZZSJbDwWsjnXpfOKhzcFURXD6DXJ56pxS5/lqV9ku0aiVndW4g7/ZBCmoBJWOA9me13t1TM20Y5tDcYa9dql4IEGr/k9qve8tRzt+InqjFiYgATVews=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266304; c=relaxed/simple;
	bh=uov0evW/Om3WwgMq8a6Gxqp4Lq0BioCHqzirLVMuKjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QYoM2Jf3boQKSI2hwgo5CMpse5FwluJFU7thlP3Sv6GyFdh+mIBn4H8ZBXhk6vMAKiQnRUVm0xJG+EJU/fFO/BWJ2w5fhdJFCqbqgMdeTied5+7L/J2IzbOTFAGt1+uP6ycD2IoDpYWFMOE6OQk9Npk1Zk3YbUgR27zhoSNEw5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd3h0z1g; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd3h0z1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791266303; x=1822802303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uov0evW/Om3WwgMq8a6Gxqp4Lq0BioCHqzirLVMuKjY=;
  b=bd3h0z1guaojOQ+qrvGt8y8UW8tFfw2LU5PQlUAPzgBmHMNqDuygi5s8
   8pltZHTG3mbTNprLLjVsjzNpHSduno75L1G2iCt/6CmaUY/wyFZAlphbe
   a+/UmHf5fmMjnBRgSlmD5IQm7zlLMjBMCK9Mcz8MViRuOVamffHVPIw37
   RAOd3TlNeYWxlOKe/9v5e0DIUXkSeUXALlzjhwJYNttdgf0mrZNCZIuMM
   IbnKB7hhweb+MxvueDszQgAx68SSDawQze6gWNbJcRkrSarCb/jinfpFH
   DUL0F7naIGS7MLhMRarhj4NjQP9FdA900RG4I6PF6fQalhdVBk2Cosbbb
   g==;
X-CSE-ConnectionGUID: vOFKLFCdTSy/NK208DOoyw==
X-CSE-MsgGUID: b/mKoNszQDeIHBBmh1rT3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91156749"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="91156749"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:58:22 -0700
X-CSE-ConnectionGUID: MpbkfgOTQoS9+4LYgmFthw==
X-CSE-MsgGUID: LcIs0JIuQNOCDEpT95/ybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="277189890"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:58:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 22:58:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 22:58:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 22:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssx6JpK0CUglOROhl3U/c2PO0/XdQEIXC++NueQiDXZmGf1PoCj4VF7OsgOBjsTfKk5oD0g0Mb5SXMv5cOoBNOI1r3N55O7cJI6wmx3ZY+iWbGJvP4CELuvKearjEebTRdh/o/fhpad4c0Da3NMpxKxSb9Vmt54gnVbtgIr81sv4NuJSirx/7e3ZC/azpFbgKv8CuH7LgLIvb8WCS56PGWpyJo2jhgIJqi4DjkVxUZz55RagnTiFIzDOpN3si8tNLFrq5LUmdDAH4r11OUq429wTgwTeQwrrrTcDjE2Q4JBLJKHi1pT7Sz+lMxOYvSaEM0Ag4xtQ9lD9HlWUj8NVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v06BQG7FwD9AfvJtgK2nXe2jhSaQXULswTy2sgl9KI=;
 b=vOKevZftdGZUCfsNck68WBakxR3OcXqnl1pXfWoLe3b0s05gSWbf4/BqYysxsxEcmNLaqLP6n6loZ8QPEhJl0j6XPv7C9OrXkTO2AF+MrVMcYS4z+RoXKhKOTH5txltfrJvLV8YOdqhWg7mEfKRkbqweus2mOilN+0ihGLRitvPFCmpwoYNvsmYsFH5XKTq1z0CXl8Jk/okhW+17zDsz5CwJcMDH2dDM8bUJ0OuTAvOj+hzrKw+TF1kRa8q9/yrPlZrtppBxi+4aSW7D+0nq/7zIoDuNmvGtkHAUix56ao5zv1vj7bYqM6cra0ZH4/abA1Fvb1lcMRebGQgRvXjfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9322.namprd11.prod.outlook.com (2603:10b6:208:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 05:58:18 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 05:58:18 +0000
Message-ID: <6748e0f0-a098-46a7-ba16-af82f07a2739@intel.com>
Date: Tue, 6 Oct 2026 08:58:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-msm: Initialize the local ios in
 msm_toggle_vqmmc()
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
 <1790742751-245571-2-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1790742751-245571-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: fea580f8-c525-4030-4daf-08df236ed1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|10067099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gcw0FCtMCKE+VkQeFUFe0QQ/P1kRNIX4uhrpt/P4wjdivU9ykhfRmU2HTAGlVCSyA93w29W3Y+HBGJJv45xVPYKGxbk4r/JcQLo+JHCJ6AbL72DrXSvnNT0u4FMkp8EOD6VdC+EuFIqDbIYAJoRfGo7sYYAMQ3kLdTCIShHNQrlbecmW4yXAV+hdeJEgzBYkFRu0kQr9F8GVlfSvBytPGnj8Xw7QTOwDXkezIVi+5FODs6EBgCUA3LsT7nvVYn5qhQBR+5CYJ3TOpdDH10O/yeDWcz025GkL0fmV7ePjE7UJfnLf5DPJe56odtxrFtJW1GxYmyHGPRCQdJHaY4mCWNs6RpiXmb9A7NV2nY+cNlyzUtG/3wcjKTgt9cLxg0qVth2IgnYXfgxw01zfPqBCMBYIhlfEz6GCkIPSuG7AqGijmDtPwCNFNMET/ml1Gu0kn6ZQfUqDU8e2/Gh/LwoGQ0pezjMHpb07cxT4FB0Bsey3ErQpCP1mhk74PBT8nhtkFP/O1+P1sRPm2UXDDh6AU/4EBptjGdOH073pAwNGd7VpcZHK88pclp3jzyMumPeoYdvZ9/0KPm/tZ61th2xQdS2cNF6Fw0ltg/6upv1goRP9RjCaf8wDDHC44M+7Yr5zCZ7T545erBKum2EY1eZLFGcBQSXn0/x/PtlxPJUkxfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uml4YUFKMElHQXBGZ3RWQWZXQmJZQ2JlQjFtbTNnbC8xZkNLclBXN3A4SXVz?=
 =?utf-8?B?Qzc3ZlQ4UVRJb2E2aHNPUTBNU2V6OWxSYnNjc1lMTXBuTTFwcmoyWjJ0NWND?=
 =?utf-8?B?cExkSzhSYWZLTUNEeFFCaTlsbGUyaW9RaFdSWW5TWWFibjV4ay9iaENzSFd1?=
 =?utf-8?B?VDB3b2g0dkZraFMxbXAwVUl3MmZ6djFnR0lCRUdlbDVjbVNrdnI5SGJIL1BM?=
 =?utf-8?B?cTFVQ0dyMW5MdHRzTm9yQ0Nod0JQY1RHbll1Yk40TFhyME9NWTY5V0ZVcUtM?=
 =?utf-8?B?Si85VWxBcURqRmJjc1BlQVMvNU1lZ1IzNmFtWkttOUlmd21TcVVzbGNnaDN6?=
 =?utf-8?B?MnRkTnhlWGFoYk9Ib2JZTm9qNkg2dlVEdDBvVjhDMEdoK25PNnhGcTBJbDlo?=
 =?utf-8?B?NHI3UXNDNHFRTFZ1ak1nYXdmTm1nUExmQWtjelptdHd6RzBpS1JhMmE1ZXpk?=
 =?utf-8?B?RzZ4aEs5amg1MFAwbEVMYW8vN2pqaUMybUZEeHJBbEkzK3R1SDZ3NUJVWVND?=
 =?utf-8?B?ZHJ1SU02NEwxSjkvNnMyZFdyT3huN1d0UzBrbmF1TEV6RllOQXg2Z3pCMDZZ?=
 =?utf-8?B?SFJFZ0Q1bGlZcVZja3lHTDJNb2ZpV0xLZ1FBUG5PMktwcHIyZ0dNL3U0dXVw?=
 =?utf-8?B?dzgvUkl5MEwyLy82T29Qc0RyakxtRndBTk1MLzcxc3FvS1pLbVU3NU1QU0sx?=
 =?utf-8?B?Z0dGTngzZUd0Y3p1ZExjVys3MlFkaCtkeDV5bisyT216dnYvTVFmeVFQYmo4?=
 =?utf-8?B?NG92dW9rKzV1OGdWRWh6eW8zbnJmamw4OFJNMzhYbGhHcFRLYm5ONWFubnpT?=
 =?utf-8?B?ZWszRWJxa1UwZ1Bka1hDWnBtMHlVMDExRFBTZzg1d3E1S3IxK1U3MUxGQm9K?=
 =?utf-8?B?aFZnTkwzeVo5MVNDZmlKdEpXR05Ha2xrdjRkRGVJM1BkM3kxNGJTdXhlRHBM?=
 =?utf-8?B?ejB0aTVDNTJobzJDZThoSkkzUFRHRVRhQzlSdGp4SUM5YzYrRG1XVkR2NmRq?=
 =?utf-8?B?WmxsS1ZVUG9aUmNxaEJGYjlTK2lUenl5aW5za3VXMFdPUzNvODhWVjBKa1Nk?=
 =?utf-8?B?Tnh1WUJHdU1yM3EvckhzeXNiU3BnTVlkQlIzaWZsV1JmVTdIMHJqVkRPcWw1?=
 =?utf-8?B?QjE3bElrQ2txSzRSNkVGdFBnMzdaRWdsVk0zT2xkRXhXME1CdEtiY3lPeHFI?=
 =?utf-8?B?cHVJR29abFE3RGJSYXMyMXRjajVrK082M3E2dkVUOGsrbyszbFBIODR0RmtO?=
 =?utf-8?B?WmFhK1JRNFRKRFFDSkV0OGFIK3U1T3ZHL21RdWJneDgxUjc1V2hQZVlhMDQz?=
 =?utf-8?B?YkV6QWJUUjJicnBsdy9pbC9TNVhEWTJwT3E0U1d5ZGsyNzhJekxVM2RTZ3Fm?=
 =?utf-8?B?Y2pLN2JGdzVSZ1NyTTNwM2QyNEdSdThiT2xVdWpKY1JycjdUSzMxWkU5VVh1?=
 =?utf-8?B?aTJ4ek1BOU9RUkxhR1E1NUZNMlI4ZGJRdVNDdEN2djYxWDB0eTdZT1kvTVBr?=
 =?utf-8?B?Zm0wTmVaQnZVZmlCNVBoYlpXcTd4R0lwbVZvSVRQa0NnQWVpUEkweE9KZEdi?=
 =?utf-8?B?enc2QnpxV3RSdmNDWGI2RXdBMlBOdDkxZTNUNWZBcGR4VjRlbnhjWHFzY3NJ?=
 =?utf-8?B?ZEpZVUd2Y1pXaU51MnBOZmZYUEpLTmd0ZmxPUTQ5TkVLQXR0aUo3WUhDbFZD?=
 =?utf-8?B?VzBzaFBVNm43clBwQllhSUp2ZWhoOE5Uc2J3b3dRWFV5dkdodGdXZFNDaU1F?=
 =?utf-8?B?c0w2ZUpRNG9Xa08wN3o3eG4xTkExaGhtNC96REl2WWZ3aUpxaURLZmZtWWVZ?=
 =?utf-8?B?c01JYit2RS9NY1JGSldNT0swWFFQRVdQakphVFVpZG1ndWJhUUFuUFIvMW0r?=
 =?utf-8?B?QkFQanJXRHZxM0FQL2RIQmcrRXBPaWNVVWZNamViWkZnd3lsQ1gvOE5wbGZm?=
 =?utf-8?B?ak8wdWpPczEvbEE4TmM1QUQ1QUhtOGNkNmJIcThwc0hReWNwQzFsSjJJc3hX?=
 =?utf-8?B?SEs1emxpOHdoYi8yamxnSDgxQmtrdjhKMFBuYnMvTTVrZFJwTVE0V0JyaG9k?=
 =?utf-8?B?L3NORnZtTTFudnV5SFQ2aERJQytNc3VBRDY3aHB2LzhiUWRzQ0hpTVhlazU3?=
 =?utf-8?B?ZHRTSDVWNnB0bHcwZkgrMUx2MCtHNDRzSzlhc3pvVDRsem5QTWU3NThxVlhF?=
 =?utf-8?B?ODRpSHNTWGlxWEhDT3BwMnJvZmd5cUc1a0M5cHpSRmV0YitFdDlJb1RwRXNh?=
 =?utf-8?B?Z3dpczlHbm9DMS9zellnWFBsRm5jN1RvaGo1cHlPZXdTQ0lqelZBUXZlVnJJ?=
 =?utf-8?B?OFpqajVwSDRBelNUcW5KbEVEeG8ySWZDenFoUVFXc0puQUdJejBaT0EzYXhV?=
 =?utf-8?Q?qaFhTa2HheFKowqs=3D?=
X-Exchange-RoutingPolicyChecked: 4EtMQ4DsaCHZYW3+WNuvJ0OVlsXXlyMt9So7zu5rTJniV8KquzVQIrxE4c1p8p2xQjDNv/mOIFrFzkauknrWusY8V6uifRwZu7vjUXmCiBNc7UN2T8y36ZSo6QLK5VAIcFZwvHGbx4HICwKkl4YbEa2d97eeD8cfDkr3NqPmRIup7nDSTxDXuctOTcWXf5/OSxjuQxZY3203UdfeLr9MUaclaBwb+fJ7oKi3vc/dYo9gxLy6nQEwtqFA7tND6WYxILhCySLO60tNgGYSVN6HLLGXcy94CMjbPJLWmbWAB+2u+IRmNzpKr/sUOEvAdBEYVjS2aVv6GTojX0vGb9G3mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fea580f8-c525-4030-4daf-08df236ed1a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:58:18.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqHT2ar7c5f2POwAAIO1XLaH02FkNJJXjapphUWkzE89rRsSMpy/oS47WvJsMhbAJVbyx0q38RR2QgqTk7e9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9322
X-OriginatorOrg: intel.com

On 30/09/2026 07:32, Shawn Lin wrote:
> msm_toggle_vqmmc() builds a local struct mmc_ios and only initializes
> its signal_voltage, leaving vdd and the other members uninitialized
> when passing it to mmc_regulator_set_vqmmc(). It happens to work
> because the function only looks at signal_voltage today, but the next
> patch makes mmc_regulator_set_vqmmc() honor ios->vdd when calculating
> the 3.3V voltage range, which would read the uninitialized member.
> 
> Start the local ios from mmc->ios so that all members are valid.
> 
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index aecd425..32b1bcb 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1490,7 +1490,7 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
>  			      struct mmc_host *mmc, bool level)
>  {
>  	int ret;
> -	struct mmc_ios ios;
> +	struct mmc_ios ios = mmc->ios;
>  
>  	if (msm_host->vqmmc_enabled == level)
>  		return 0;

