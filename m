Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878F377AA5;
	Wed, 23 Sep 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181155; cv=fail; b=Hn7s2JCyc9LdUhzTmnYDfiM6YNRYGzx5OoTTpM/yPvX+uj7wCwCV2J8SXBSpnR6Rw6E0THrN0fOz57KMmvoznq66Hiee/LwX+sKP9bnnrZ5l5m0RdOSpyCGQREcUOG8/zB/qmslxwjYKTAOXgjQN0aDVlPjIO+BbrWsO7v7sx+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181155; c=relaxed/simple;
	bh=37NRBavz4QcJtrqT+SVMS2nsps7oQzbME3er7hireAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMPHe81OCcjMWJhKpKaJzmhzb4Uk0hMB6L5zYKZXvCvEh7h3qQ8cJoRPKy8/tPXiAxRnaWkpXPctcI9rK+HTQy7nh3+WzqtTO6F2cRSw1Dy+oHB1XjF0QNgoGIj5yHs+hcDFXaFeN1B8GVtGrPJIFfi7C4Tj/gwaUZjUtV5ALsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0DFdxvv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0DFdxvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790181153; x=1821717153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=37NRBavz4QcJtrqT+SVMS2nsps7oQzbME3er7hireAU=;
  b=B0DFdxvvdxC4Mp+Jo0Cp7JrwWnoum5Exy746pmxSZspI6eruFE15mtP5
   40JVXL2oJ4k96L/0l/ziXkqqNVsrYLxZLrzOD9YiMQOKNbxiDei3XcAYW
   3h6FBfTnlzS/KGIJ26LfHQmAW9wxC4jo8oQuaxAeP17Z9gNJEB0SesXBg
   U1ImrPTQ6yS24SqTZoVIxPzeYXTSfiKegNf2669odhnHtE64ChVE2hSzw
   4gA2OKlQdtmFRRwktxOWt8nZNKNyqjBX6J+9MuR/giGPF3eVidLr9hxBv
   qhTPWJ4MxuFu9v2gj1CyDy3bHKLaQjt5L5yI3jG/j3i47j7fhNfynTCsF
   Q==;
X-CSE-ConnectionGUID: lPSU6C3lTSW4s80SHShpLw==
X-CSE-MsgGUID: uTnjqRqDQsepk2SQFX99fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="108394786"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="108394786"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:32:07 -0700
X-CSE-ConnectionGUID: xghb4q44QW+qnRZDAVSwTQ==
X-CSE-MsgGUID: qLGtu0RnSOOOapZ9nwOirw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="281746265"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:32:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:32:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:32:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7Ial8Tt7yU2Rmp2RoXbm1X3NHjNYM8vRg6j6wNnjjdRXTeVP26CioKMhM0SIRPECYs1refJP0Sk4eEvcHwLkb6FVoao15nCc+fRNezDl6ILDpVk1gd0HCTKPy99CalPsjOpajYbd7HAGZtKhTcWLU4mHdPGH82nKSY7k2WlTD4FEY9ttFeqrB/KhIp0yDs3HHSkGrSr9KFGoV63wNafi7x8rY/QTZkwKvLPVPQznBocqiezol9qHUYoxPziwFxWqzTi7fRF9sib9R0MSo8kDbR2BoZ7Fdi2n8jTqvNXUbMoNtMEgI0VR4HVIEdMVoo2wCUUPsk8l3gTJhXmN+ZYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXON/E3sosxNIYCYKAWCMJgNGQ7J79jnJSRyEtLmhnU=;
 b=JE6X8wp1kFjDc6uDxq9TXnvAhKLeKs3AXLEr088CSijGOQLBPAW3crDnB+5xrBtLPfXeRZ5AeXnZCgCTRabBB0Iop4nt8nqb/pV4uVjKU+y9wYuz1mWETLKY2UiKRuZiL/4PqlOK1EpZ16R79ntI2kMaCcwHM+20XIPs5/jGM3DabDv+E/RTBgZ7vcYPv4jEeBxBd3k/jXT6n/81DtJCDmMz00KK1ro4k7Wom2onKEiD9VqtoJmoZ71SvQ2MrdNTaJvsBjd5DgSBqmEVbPUeqK11bFrdbyuE+UzSaOFS/+gV3HFK/2/AEtqUtv1V67X86y/K5s40hJZFD4RLdM4MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ5PPF77ABF615C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::836) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 16:31:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:31:55 +0000
Message-ID: <fa3971ce-57ef-4c93-9020-ddb02d625ef0@intel.com>
Date: Wed, 23 Sep 2026 19:31:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci: Replace deprecated PCI functions
To: Alper Ak <alperyasinak1@gmail.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260917111336.1102829-1-alperyasinak1@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260917111336.1102829-1-alperyasinak1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ5PPF77ABF615C:EE_
X-MS-Office365-Filtering-Correlation-Id: 50656b15-f030-4dc4-a2e4-08df19902e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RJvY+mMgXlTbmcs1i4RigO92qQAPZOOGnQRgxQcmlXglk6/Mdyd8GVW971nCNRCmeNQK0ZwFXkmmmwZu5snW6SZ4bvZTyguAcGvCu7GrVusYGPF4LX+Txr2Fw378lNUs7Y1wSvIkHq5PE7nWHZ0rCTb0mLt1pSOjQhrH1K7wX+D3/MKNVggYdXHAE+XgGYW435jL61PZIoBYQP/zL1QirQN4zEeC/A8ENrYhnjxV3vlrYTDpJoqtORIucdH9td033vZiEF7CDn8GX2YsZwa9S4tk1gHc5LRxcMwtYFCqVjK/xkRbh77zN1sIlYsfAgTay6VZHgCIC0OlWIwf6RMyLg2IJcc8y1+9JN7Jn3d4MtT+Zll/DCx+murCXKiZb8/R37MpBa22S7ZEplTWLSBthIEVYHTYaypLxp46fqe7znl1L5arDMVBjCstacTtQsTnVsvpMkfOMPjZW7/u9UtRiOiyLpBx5Z5j/JO/jLait9Fap8wQV3Yf1Y8JEj/m3AVFpC3WoTe6BFz0UTP6MCFR0RDlDB8zw8H54+Oo4ZzVKPN/PEVNL5HdZNmYt/g0GEyehoMFZRwa9CQQG/tF66o8VlnYCkZ4F9NNqTWZk0+4fSX5wCPvorNk+03xrZkxc2PYW47RO3d1K6JkFe/yhMyRTAujXOpX9mLdPg6VVRmYahw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUR3ck9qSHVVN2FoZUJKWCtzTUIyeUFleTRIMEQvZ3FBdWxTb1pFeGxxbWo0?=
 =?utf-8?B?M2lybU1HaFIzdkxCeWpoVEw1amVNckJlZEwvMjNoa1ZNQm9qM1JFM1NGOXY0?=
 =?utf-8?B?SmYwVVN5TEs2TUtZTEdJR1EwcVFoY2swdDMzOVdLL1hTdDg4RlJnNUlXU0VH?=
 =?utf-8?B?cjlJbXNJSnhFU0Y3UUQwNi9zb0duam54amxxa0NRMlErcE1xYkovVHNoTEJW?=
 =?utf-8?B?c2xJaFhiSTRsSHpTZmRJa2lmclFYK0o5Y3Q3OU9OVGtKK1JHZlJrdksvQllj?=
 =?utf-8?B?NjQ5THdtRGN5NksvM0g2RkhKeHhRbXJibzQrdldGNG9rMHlrNHdNU3ZobkJN?=
 =?utf-8?B?ZFd6bmQwSS9XSTMybmtaakwyV0ExaWJvZ0d6NmRORVUxN2JUWGJicDB5WUhU?=
 =?utf-8?B?bWNwK25BQmQ3VHhkSXArOGN0WnVEcUtpMWxXT0VKS3FDTXQ2dElUL2R6TSsx?=
 =?utf-8?B?Z1Z4ZGZQaU5rd05RY1NGQmZPRmFGMVFkcUhqYk9ETTB1a3pxSHMzZTQrSHl4?=
 =?utf-8?B?OUdRWUwxYS9naVhoMXp0RDdsYnNKNk9pVVpvWnVqK0YzbGcrQW9POVF4ZUo3?=
 =?utf-8?B?Szc5dmhGNlp3TjIzTXZBWVVyT2F1Mi9qamc5ZVB2d3FESVhDRGZVYVpWQUZj?=
 =?utf-8?B?cE1rS2lLY2NiQjlqcmFJaTlKVzM4dVZ6WnU2clVNNVNQNTdzNTdNUjlQZDg2?=
 =?utf-8?B?Q09Sblo4OUdlc01iYlFUMWFhU2xadUdpUjd5bFJuQWJNUlRjZ2Q2TVBidEd5?=
 =?utf-8?B?cWdFMXM3dngwU0c0MHZQWFE2UkgzSDlsNjY1cGdoUzI4c2lyWFN2YUFuQ0dL?=
 =?utf-8?B?UVFST0ZqL3FEc2Ezc0gwTE9teXFGZHlaaTA0Tkc3TU9LQ0JuL1ZZaUUwZysw?=
 =?utf-8?B?QzFRL2drUXY5aTNzNk9EdVIrSXRsSnZDV3hnUHNHdTF4L0RmZlpyTnk4R3gx?=
 =?utf-8?B?eFc1NnQvM2NLRDlGZGxRSzE3eG1xa0lVSHZjNnAwc0p5R1BmaDM5cnByNG5X?=
 =?utf-8?B?RDdqMzlrTjU5RHppdjloeVN4aW5jKzEvOXdiZVlqL2Y0LzlkNXNvMmRQMkNs?=
 =?utf-8?B?UXFrclJhV0JIMm8zTlB2MTdLUjVCcU5IK0w3NnhtZS8xbDFJbGNDY3JaaFVz?=
 =?utf-8?B?T0ZkalluQm1WYjFjbmkrTVV2TDR5UlVPOThVRHNDaUY4N0tPTEFCam5YcVVO?=
 =?utf-8?B?alRuNlczdjdYbzFlRVFKczNINVpXM1VnYy8wRXVBZ0gza3paejJRRkN6M2Nz?=
 =?utf-8?B?YTMwVG1hS0crcE1iVXMzRTdWeG9HWnJXYjlLYjg4QU40Ry8zNUtMUGErMHFq?=
 =?utf-8?B?VHRDUjEybjhOQXpoOE9NVEZ4dnhrZVJiK0ZMN2t1a0h0blVCcndpME5PS0F2?=
 =?utf-8?B?SUZaTnBRM2dVL2FFZVYzUEtrMHFRUXBRSEsxTlVLdEIvNHN6UGFTMnJ2TGx2?=
 =?utf-8?B?ZjFyWGd5L2V5N0o3Wi8yWjJjU3NxZDJnMWdGbEtBd0hydk90RTNsK25kNGl6?=
 =?utf-8?B?cGJna0VYQU40ajdKWE5lbndSdW8vZzkrbWRuaXVSYVlYdC9XbGsvcHFoRzVB?=
 =?utf-8?B?N2FMWnNwTlFNb25NQytidUFZcE1CcTJjNGtxZC95WWdIMTBRbGEyV0ltUGUv?=
 =?utf-8?B?ckRPV3FiQkoyM09IaVVFZENiWWtUekJTQnBOa0ZJNmlpYjVGYWxaWDZqWFlM?=
 =?utf-8?B?eDBjbVB4MmxuZURuUE8vcnFicHVJbEkzaUV3SHJKa1hkYUgyN1c1NG5nOVFq?=
 =?utf-8?B?N0JXa1NXTmhLdmJZYWxHS3BsRkE0WDNUeFNJM3huWFk3bXVTSXp0K1Vhbzcx?=
 =?utf-8?B?ampyYk5WRWRUZ0Vvb1FybWFqQXk2anArTEtmbnEvajZWNE1rQjA3eFFwNGNI?=
 =?utf-8?B?cUU5Qng0NWt2YStZcXFUNlJWZ0UySkZwRnhtdnltUEd5VThwcWFtcmZ3cUNQ?=
 =?utf-8?B?bGxjUm1uZlNXRU9tNUtLM0xjUXlSMnFxS0l6Uys5SFIrTW9RWWhKajNXUkQx?=
 =?utf-8?B?bFoxSjNKM0N4ZHJjODQwRnZLc1NSWkI4WHlDRkxrUVNFV1pnSlA5aTdFMXJ0?=
 =?utf-8?B?RnRHSDVLWlJpb1MvSExyMFZrRU40Q0JOYzJuejRVMm56cHo2Q2lqb2tZNTZO?=
 =?utf-8?B?SkxxaUR4czJGQWlVS0VzK3QrRThoUllEV0IzWlhzZXJXWGhKM0FCSXNWQzdi?=
 =?utf-8?B?eS9IaWs1U3Y4aEhkTGlOUHB1RWpVTVRaRVQ2S3h3V0RPMHBjTmVBU1JSRXJr?=
 =?utf-8?B?SmZpOGR3VGJ4bWxkUjAyS2JXUmw1Qnp2TGtET3JjaE1ZVXk3RFQyR3lOdEoz?=
 =?utf-8?B?V1BZdUMyRmlWWDd6bktqQUQvYVU5eC91U1VwWHgwaDJmeVpDSGpnQ21ZbTRH?=
 =?utf-8?Q?eZWO8ppUE01sLIBY=3D?=
X-Exchange-RoutingPolicyChecked: BfECg3wmIZLjzqrmf2K7G9UgvuE2EHGB4MLlM9SXYD1VLir03/hBn4S9lR6C68+Eq2Y0NHnntfeqhIpvJHDDx6ii30f3JRcvKpRxRZYPTqj8yEdyBPB/MWFrIfK8MoIs+vJWkgmHKqa27NQx9r84loYTmOjYrq8Vb1EAS5xrWPVDMFyydi6q0HaYb/xIF0Ldy2DX+Yb+i8g1Nb0muxN4E+LxRW1I83X/md0SJsQoYyJ5cIlFRvodUh24uKW5hxQDn9UwqxjYov1wntWtlXJK+/X3RNor3/OfHi6j/amhfaKuN1lWFHJlkfCsV+0lxzFviyV38Y8vpWkXPTmQ01KCtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50656b15-f030-4dc4-a2e4-08df19902e79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:31:55.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV3ClYKFeNDaRqRGD/ZN76WFI43VQr/QHNojHjuOzFmfWLc9QNy4mhetTgwAJJrZHUDzwLUFdzWaDVtbvXnkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77ABF615C
X-OriginatorOrg: intel.com

On 17/09/2026 14:13, Alper Ak wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated.
> Replace them with pcim_iomap_region(), which requests and maps a single
> BAR and returns the mapping directly.
> 
> pcim_iomap_region() returns an IOMEM_ERR_PTR() on failure, so check the
> result with IS_ERR() and propagate the error with ERR_CAST().
> 
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b121d896a804..a9000f3bd419 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2170,14 +2170,12 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  
>  	host->irq = pdev->irq;
>  
> -	ret = pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc));
> -	if (ret) {
> +	host->ioaddr = pcim_iomap_region(pdev, bar, mmc_hostname(host->mmc));
> +	if (IS_ERR(host->ioaddr)) {
>  		dev_err(&pdev->dev, "cannot request region\n");
> -		return ERR_PTR(ret);
> +		return ERR_CAST(host->ioaddr);
>  	}
>  
> -	host->ioaddr = pcim_iomap_table(pdev)[bar];
> -
>  	if (chip->fixes && chip->fixes->probe_slot) {
>  		ret = chip->fixes->probe_slot(slot);
>  		if (ret)

