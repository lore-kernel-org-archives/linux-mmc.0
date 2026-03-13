Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4630BF66;
	Fri, 13 Mar 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407082; cv=fail; b=OXzOZs2f2hDp1tsUxZQQKqhqWPChttVbAZISmt3kLsyBlehihc6u++g4NoSClWOVjF6Z7EqTUQJDjvmTIUk1Bxs5lMIfO+uPFsLSIVhRkf4HXRmOS1dOW2fR2DAsu5hSsW3D71f6wRMRewhzknbqEI/exECFizTMD8pfD2+CfI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407082; c=relaxed/simple;
	bh=MHb7IrMkLcYyAPqdlhWhe4LeUtKRmCPYQ3/34Ve4vhY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTGaF4v2p+PumXElKRmv59MKiaJUzelCch+SO4CBB/ad6w2+lOhK9Oc9BJClGKdCa3M7Tx2u09jSS3ZsN301hlDyt9DMmykLvDZuuLmUr/Z2Iij3zJiOOLaxHEaQrGd56/e+KiiZ79ficST86+qGQASvXVjdmb2nRCrkqRLapnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbnjxaxO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbnjxaxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773407081; x=1804943081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHb7IrMkLcYyAPqdlhWhe4LeUtKRmCPYQ3/34Ve4vhY=;
  b=dbnjxaxOpR8o/yZ7gzqfuc55vux7/Y7PP10qXL5Tsn9kN6uvqstBbScv
   vimwYAAjB6kUTqAJzHgD2fYZqCAxj8TJiTP6bCS31MCKTMX6VE1As0xCF
   GcYMr98QRiaNs/BihhlahEnuA69CIPkkRBvx6uWDAufVGDhb+Vo0fLAio
   eFq4wM617Iun1gklJN27rkdorQcQ2DFuMX6EexGgQE0yFY+xm/W0FaLC9
   7oWm93AQX6tJEeIkVfeLYog9DvY46T0YzFjEuneOOFHGcbI2YSfZzBMVt
   +i/Eus/rJCzZGtCsIfz6+nqdwQY6/xwDidQ7rV6Nh7WjRurhErzec4ZPK
   Q==;
X-CSE-ConnectionGUID: OHQj45NzTrGVk8D9ZHG3iQ==
X-CSE-MsgGUID: hKVhJRKeQe+zN9RDeQWQgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74592487"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74592487"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:39 -0700
X-CSE-ConnectionGUID: fWjJBpW4TaqMmYnTq9rNWA==
X-CSE-MsgGUID: fiSss4O7RGG67Lp4RpWNDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225845958"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:04:38 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxFsMAg+69otCrA8mm5n3S0sXpX0/p9thPzx2wloL2jXYSwV4qwFj9MsbcXpa860r1ySsWZCTpldkdpLNE5T4GkF8d9pbdp34VM80XkSXZwycvUPFlzyFFfElPx031nFp4F5ancktdyvbzAyV5CopKjnPLEpGWCzJZXm/okPnQZSMfxiLVWbfq9MMQ9188+m1A/m263sxSW2eL16jHIqzFZ++Ij0eHqR+TrRnZyNlLL6hZC0HVGnPpT4vf7qBBddEUJK70mO7v8LqvQR1R5HFTKyRdagK0JD+M/X8WHu9a9mjD6kZb+WUTR+5eJwSFH8uEv6Qf0Auit0WwENH5WsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LyA5U7YRSd6WpyEG/CN8fmnkdvjDWmVqMeYai8BBxs=;
 b=H2s+CXAk9/Vx5dVGt0RUlea4QvomS2epRrXEURcn7lFYC66x28Vk2kIE0LHz9xbCEcFvYbJVxGqs6jPlMHSRAs5RW88wHPpuZbM6Nqx/YuOeyvsFPPa+p+Cwwzk3CItr0EMXXHq0j7OdV9p7+7IFmIDr48wkcWCV8FpIyOoMvQN3702PfXVI2lqViUinGp5Gou9PYAteGBVbVtYxM5qMNEyOQO8b0IMnLr/Jt5Z2nkYDv91clxe3S0dwcEz0Ed6j8PeYbT+rHyV76oLT6Fxbgsa9o+E7HxsK23bW8BJK3XWE1XxG3msM2XCi8DzWoObHmD0MDOO5G6ANFtPwQXXiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:04:35 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 13:04:35 +0000
Message-ID: <a1e4f4fd-18b6-4bc0-a504-919d81dd4842@intel.com>
Date: Fri, 13 Mar 2026 15:04:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mmc: sdhci-of-k1: add comprehensive SDR tuning
 support
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-4-5bb2b574df5d@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-4-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc91807-58f4-427c-4cf5-08de81011327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: nzNm2lnQfrCho/QpO3J5X1a93zI/UnAX/zAnZ3E4vRBxIpa7gl4JGeyNRJfM4uUMxgw+qbHbNjCCjghJNbbBlkdKCGwExHzT/JO1ek1dUHOMbK5IkFEuRIxLm7uQSI+gPz74XigxJ8Gj0WIBxK7OYNdPQIcgBmhnvokt7Rfj84c5hjc66umFaJLGf8KpY//Ei9AYywtje5fqKxkFqWCb0+FqAzPYOEC0b62VATxy+88AN4RK2zbZ7XTPZdtwzhc2oYMpASoz2fvdhOiO25kShLKRbZL5AwcXSRauv7jvQ3VHWRClt+W9PBKY838GIjPEsS84s1kVSNouzOXh61AHoYbQZiokpvXfsFvXcMY/scJtxAMz8uwnsI8MYS8LrXpUTgIw6Ukqf910giW3aJn+UKxoIedmH508Fjq3ub90fX0QGj+3UNsKPvjyXGU4sfd6EDZ6F3hjl2+DpH6S6+gMxyRKwp5dQ8W2uRtG+CwitE1J5wLj2+OmdtqE3pedu9L7hksW5AOWWQnmoL81V6CM+jVUyED+cGM3KHdfDgmY/nWrEaXZYI1lCECdUm/6yJ/s1AbtIeUArQWN54AV0Rw3kdBW2b7Ve1pMhanUmzTCekAm/Bt4M2V+kQjYXPOq5rV3thC8/T1aC/gdOmRcG/fnxcJy+fwvHpN5pe5ARaytZc3ahuNA1VUMLUdPlMSXmKiinuADze1j+L5rRaISQA6waROwK6GCEHNuovbhZRRiXMYoeAzWTuSFc9IwTR0VkuOv6NgVLEAfoYnuDsCP0UdFgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlZVUMzbW13NjViNFV2VlRVVEFLTUNmcmZvMlhUSTlXZER1VEl6L1dRNFVE?=
 =?utf-8?B?YWh2dnpCeXNTdWxaNTU4RndNZzA2TDAwNjkvbVRRTDlGT3I0cjNvaWFtMHZQ?=
 =?utf-8?B?enZ0bEo3bmE4R0JjWnhiMExRc2ZnaXZXT2tJbGQwcng0a1N4Qm1ZYWEvZEpI?=
 =?utf-8?B?Zi9TMit0STNrZFJxcFlRSER6QjE3Mnc1N01Qd05OUGRWMGdVKzN2NG1uREI5?=
 =?utf-8?B?bndqc0NFcUpTK0VDUksvSzd5NTJHTUVzaFhvSXRNK0VOK2hRLzFaMXFSelBx?=
 =?utf-8?B?ZloxckxJVEM3M3pRVDZERkVFdXl3K0NMRmtHRnJRQzFSM2hWNnlqUjJqUFRw?=
 =?utf-8?B?U25VRjVWMXNlTXNWRExFUW54UjhISTBHR2NFWHNUNk1hRXl2amRrbFdPaFE4?=
 =?utf-8?B?eHgyWjJTTHc3aVBOaGE1d21LakFpeDVDQXhHNkZhWDVwQU9nQVVRRlZZeTlq?=
 =?utf-8?B?MCtwRURHM0NPQmlwWW8vQWl3bFRiZ1hMZTZIb1UzbnVVRkJkMGpOZG5SZ01N?=
 =?utf-8?B?bDBRSHo3NjdFUnBFK1A1anF3K0NNWHcyblpPc2lCVzZYQmw2ZWIxa0hjTzVK?=
 =?utf-8?B?cGFublp5MUVzb0h3b2ttS0hMSVdpV1diRHByRWJESnBiTXZTTmNLdDN2QUJT?=
 =?utf-8?B?VkFTR1V4WFJyV2dDMG1vdXlyOFF1VUdlMml2dUZrTDhJRFNmQURqeHZVeDdJ?=
 =?utf-8?B?TDRLcDM4R2dZZllmZ2lwNUtKTFVWekN0ZWlXcXBiakZ3VmExUHNyTEVaU0RS?=
 =?utf-8?B?TEhnR3JjYjZteG5jWGtnbWhpaFhodXBldFFLTHAyL1BuQ0J5bEtvQkpPN3hi?=
 =?utf-8?B?YTdrSWhER2dydVNWWUo4eWExMkdiQVFLRHpPU0MxcFhqYUsrVHNrVkJLaVhR?=
 =?utf-8?B?SkROMXVGQVFBM0dZUnYyNCtqQnVVMVJLYk4yNmYxclNncStLUENHZmxnNnJV?=
 =?utf-8?B?N2FOYXZkRFB6M3JmMGJCUzVmc0Q2Sm90UmlZVW4wYm5yb1BRUnI3Z3pPNFNv?=
 =?utf-8?B?VXZmREtCUk9CN2F2VXN6S0dJQUZERUR5dVNPbjFsOUdlSW5KSWh5cTNVa0Vm?=
 =?utf-8?B?QmdRZ0RPcVV0RXdzQkVpR2s3Q2FJV1lFYm5URUkxOHVpWmlOMnBud1diN0NM?=
 =?utf-8?B?RERGa0REeVdTeUEzczZQbzFjaDd2RTJWY3hJMXdtUTRHemRwL0VHaGYrd2Jo?=
 =?utf-8?B?ejdTTEM0SFhLM1dXY1hyUUMvWEUzQVhSck8zQkhJaDBaMzFoSEFia0ErR1Mv?=
 =?utf-8?B?d0N0N2NwZ21UTXZ0ckptLzFrWGNjaG5QL0pMYTdtWlVMc1JiRFBKL0FXRU5y?=
 =?utf-8?B?aEJKTTRDNFRkZEx5eG43c25vVXBmdVI2cHhEVUMzMHoyMmp5MUNQY1JxWXow?=
 =?utf-8?B?emdDdnBRSkx5M1hyelRmdEhoTytJY2xFVlNEeGNpS2Y5OW1QQytYaEtkZzU3?=
 =?utf-8?B?aFNFWjc1SWJLVHppbjZSYkhNU2RyYlhrSjFvRVNBSkkzV2Z4U1BGUmsyQU5N?=
 =?utf-8?B?U0c3YjFGMFJHUnlkWXNobXozSUVhcWJxYi95c2NyZnNXZVVTcFBUR1JPTVhr?=
 =?utf-8?B?b2lieGFRRkZJb3VaVlN2dEI3dHpVeGNRZVQyT1FWZUFBMGZVbkFmTFZNQW1L?=
 =?utf-8?B?WEEvN08rb0s2WTFwWThlTVhhdWFPREcySkJ6aW5icmxaRFN0dHBrZllQejRR?=
 =?utf-8?B?elVPUVBLMUkxYkI2NS84RDZ5STRsNXh3Q3p4c3RBVE1yc0VPa0kwek1ybEtr?=
 =?utf-8?B?OFlpaStGcG10SGpTUmxRMTdrMnBJaTVUbnlaVVRIWUhqbkc5eWNKVmd2OG5Q?=
 =?utf-8?B?R0pkdDRqWnFEOHVudHhNU2hRQmNjMHlUbHdBcGhLU1MwcXJUOWNlWGpNUkZG?=
 =?utf-8?B?NDB3WTUrdHZvcEYyVnZjYlhjL0kvWmJpbkEyWUFwWHJoRUJ0TjdqV09HVldT?=
 =?utf-8?B?MWFmL0xKYVlZUmNWNVNUOWdTd3UrZVVtK3lpbzVveENMV3VuQ3hxQkJzOUtw?=
 =?utf-8?B?TXF2V3p3UGc5cWd6NjYzUXJXbXJRd002QjVjczBDQyt2QmlLQVh1T2NlRlov?=
 =?utf-8?B?M0ZxbmlEU0dmaXpqcGJkL3dscnRVblJ5YU93MnJPMjhwTjlIeUN2WlNSK2w5?=
 =?utf-8?B?cno2MGpQNlYxeXpTR2pxazVkUkVScGg3a3RUNmJ6UGc2T3RZVjNERnhVY2RO?=
 =?utf-8?B?NC9CRThWaHNKUC9BWmhTbXNGUWZzN1pEb2VXV1J2NjY1eUR0dmdOSXRZRi82?=
 =?utf-8?B?aDdWSVc3UVFGRHVhUTVjRzAzZUc2YXhLU0xabEJTNGxoUnM1YVc2V2k1TjNi?=
 =?utf-8?B?L1ExZHlKSks2d1FidW5WbGlnZGZSTERtSGtIVGtZOGo3SWt6U0dtVTFEc09N?=
 =?utf-8?Q?IHFQ4z86VlfEHlNQ=3D?=
X-Exchange-RoutingPolicyChecked: tNdQ5Yci+GweRArwISZDam10yBIx3aJwKBUigOx11tkzcAjCnzcnv3hX/tfneyjKznoEC2wZEZoMYjz88lCh3iRj8m5sq2S9Bg45cgSG45EzOnLYeYz9bfWmtcg25J3N64omxxNkllMOMtWvBU++5DLovtpC0IljGmybXiuh2q44N5j2cmtjsSeAY6SX1HuMnt6pu5Jixy6KfUJz3T1zTboWAxeDH9Lrg0GdEOq2AIJdNxX9VQw3MCUXrz7JunAVCjWul+shd0ev5fMRQdb3VTeCiTLPDJgqBIWOm020wM7hhYbeof3Ur80QwUW6iAO4Xdze+rrRl62BRTqWIFTSjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc91807-58f4-427c-4cf5-08de81011327
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:04:35.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjiN/qYOhCwIXt+RJqQj5h4icg/FkEbcMx1NnWaGXf/ukVuRBWe5e73/wfUeqPsBL+dLX9fxQSs8B72lIdmcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
X-OriginatorOrg: intel.com

On 09/03/2026 13:40, Iker Pedrosa wrote:
> Implement software tuning algorithm to enable UHS-I SDR modes for SD
> card operation. This adds both TX and RX delay line tuning based on the
> SpacemiT K1 controller capabilities.

Need to say something about the HS200 support since it is
eMMC only

> 
> Key features:
> - Conditional tuning: only tune when SD card is present and for
>   high-speed modes (≥100MHz)
> - TX tuning: configure transmit delay line with default values
>   (dline_reg=0, delaycode=127) to ensure optimal signal output timing
> - RX tuning: test full delay range (0-255) with window detection
>   algorithm to find optimal receive timing
> - Retry mechanism: multiple fallback delays within optimal window for
>   improved reliability
> - Complete register support: add delay line control and configuration
>   register definitions for fine-grained timing control
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 119 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 79cb7c8d0b6d9c4206bf01721651c8efe8a173c9..d903851b9be0e1d21a2b30636f5e63a52cad0dc2 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -84,6 +84,12 @@
>  #define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
>  
>  #define SPACEMIT_RX_DLINE_REG		9
> +#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
> +#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
> +#define SPACEMIT_RX_TUNE_DELAY_STEP	0x1
> +
> +#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
> +#define SPACEMIT_TX_TUNING_DELAYCODE	127
>  
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
> @@ -251,6 +257,118 @@ static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
>  	return clk_get_rate(pltfm_host->clk);
>  }
>  
> +static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int ret = 0;
> +	int i;
> +	bool pass_window[SPACEMIT_RX_TUNE_DELAY_MAX + 1] = {false};
> +	int pass_len = 0, pass_start = 0, max_pass_len = 0, max_pass_start = 0;
> +	u8 final_delay;
> +	struct mmc_host *mmc = host->mmc;
> +	struct mmc_ios ios = mmc->ios;

Prefer to arrange local definitions/declarations in order of
descending line length e.g.

	int pass_len = 0, pass_start = 0, max_pass_len = 0, max_pass_start = 0;
	bool pass_window[SPACEMIT_RX_TUNE_DELAY_MAX + 1] = {false};
	struct mmc_host *mmc = host->mmc;
	struct mmc_ios ios = mmc->ios;
	u8 final_delay;
	int ret = 0;
	int i;

> +
> +	/*
> +	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock < 100 * 1000 * 1000 ||
> +	    !(ios.timing == MMC_TIMING_MMC_HS200 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR50 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR104))
> +		return 0;
> +
> +	if (!(mmc->caps2 & MMC_CAP2_NO_SD) && !mmc->ops->get_cd(mmc))
> +		return 0;
> +
> +	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
> +		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
> +		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
> +		spacemit_sdhci_tx_tuning_prepare(host);
> +
> +		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
> +			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
> +	}
> +
> +	spacemit_sdhci_prepare_tuning(host);
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
> +	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {
> +		spacemit_sdhci_set_rx_delay(host, i);
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +		pass_window[i] = (ret == 0);
> +
> +		dev_dbg(mmc_dev(host->mmc), "RX delay %d: %s\n",
> +			i, pass_window[i] ? "pass" : "fail");
> +	}
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
> +	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {
> +		if (pass_window[i]) {
> +			if (pass_len == 0)
> +				pass_start = i;
> +			pass_len++;
> +		} else {
> +			if (pass_len > max_pass_len) {
> +				max_pass_len = pass_len;
> +				max_pass_start = pass_start;
> +			}
> +			pass_len = 0;
> +		}
> +	}
> +
> +	if (pass_len > max_pass_len) {
> +		max_pass_len = pass_len;
> +		max_pass_start = pass_start;
> +	}
> +
> +	if (max_pass_len < 3) {
> +		dev_err(mmc_dev(host->mmc), "Tuning failed: no stable window found\n");
> +		return -EIO;
> +	}
> +
> +	final_delay = max_pass_start + max_pass_len / 2;
> +	spacemit_sdhci_set_rx_delay(host, final_delay);
> +	ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +	if (ret) {
> +		u8 retry_delays[] = {
> +			max_pass_start + max_pass_len / 4,
> +			max_pass_start + (3 * max_pass_len) / 4,
> +			max_pass_start,
> +			max_pass_start + max_pass_len - 1
> +		};
> +		int retry_count = ARRAY_SIZE(retry_delays);
> +
> +		dev_warn(mmc_dev(mmc), "Primary delay %d failed, trying alternatives\n",
> +			 final_delay);
> +
> +		for (i = 0; i < retry_count; i++) {
> +			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
> +			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
> +				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
> +				ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +				if (!ret) {
> +					final_delay = retry_delays[i];
> +					dev_info(mmc_dev(mmc), "Retry successful with delay %d\n",
> +						 final_delay);
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (ret) {
> +			dev_err(mmc_dev(mmc), "All retry attempts failed\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc),
> +		"Tuning successful: window %d-%d, using delay %d\n",
> +		max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
> +
> +	return 0;
> +}
> +
>  static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -344,6 +462,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
>  	.set_clock		= spacemit_sdhci_set_clock,
>  	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
>  	.voltage_switch         = spacemit_sdhci_voltage_switch,
> +	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
>  };
>  
>  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> 

