Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733942FBDFE;
	Mon, 29 Sep 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152385; cv=fail; b=fJ5A9VPAYoLWE7zxY11hwQW/rGwRCBVuVIjmy0fH9oEXgzWW6S+tFaKoOAOtOHSnn6AikczQM/MdJ2+oAnQp6rQW5MCpXLKkEiHsFyKuaIv6M9waFdxDP4bxzkrMmtlvwQq56z6NDW4S5UZhB5u2wzUOcUXyQJeF+Nk8Cl7AEJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152385; c=relaxed/simple;
	bh=/18V4U5uWZgxT6Kp9+LYdAn/mIMhZxluqPKAUFcRVYI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iayvHkTNiLfOYaaW50tgIkD6IZqteHDpggDEidpXc8ILcy0tfGqvLDCf5TQ9u7LYeqS98koRu0xG3KCqWnuhisRR+R1xS1E3gK57H6CSjBT30BsSAW3KgnsUEoxr9dbFB8xE2o+sIl6YpJW6AM/XRWJ30VGDyVerV6y4fZqvESA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldTW+8fv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldTW+8fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759152382; x=1790688382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/18V4U5uWZgxT6Kp9+LYdAn/mIMhZxluqPKAUFcRVYI=;
  b=ldTW+8fvg8X/8qbW3N7CHrNGHYnbKOJlKOssHQZ7KlbUlcvZXpoOuRg+
   t4x+gXzrtaFC/MkIoVIYtX9r1V1KLpubyNCmvvSr1HuxRa+LwxdwR/UsK
   OdaiWc3RS37k7Rl4CXDNspOz/iDfJvyV8Gkz0+9L2SmwW5Z6Nxqzw/xPf
   vZSY+p/1THOQjMbzvVTfbNxV99pA0XHxrIjRx3M0b194c8Z8LE1oq/21G
   QbLk6foWJq3WNue2SFN0pg5w8uXpVnFH4OpEBqBe5ZBg3m64vczM7A+Zv
   jykuaPObLOZKJfTHa/jRynjZL864RHPu0BZu2IF9HlPfiyO2exLouFUJ1
   w==;
X-CSE-ConnectionGUID: fM/yEummQ5qHejrKoLLv1g==
X-CSE-MsgGUID: NMPUuq2lSc+mWOQA36HxeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65243762"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="65243762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:26:21 -0700
X-CSE-ConnectionGUID: ycCsGkNxQ6+5IB5sJlCI1w==
X-CSE-MsgGUID: Yz6o6WV3QI6KJiOXyRJi+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="215386166"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:26:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:26:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:26:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/rtUBlfIkoN/TJBhVD+uIeqca+Ve/xsS33k5w8Cm9w9ayPVKDZxTs2XBzHw89CWRc3MHbL/tk28JXSz8f+l4YWWWm2P7o1Og4AReV8SNpna+QAb/1czbPIbZfzMo5LgssterAOfKaqP7lVqGY4u7/Oud9xrbzhtCAr6bXs/YAvsrbsaM+N0CesdXUTSWi7DFx6bB+wQc7oTd5wJyyC3RPbD6B6TII0OEq+z3bLScHpjHZ/vtkq3jBFw8ISYhqcuA1CG6ln/LhnhZ0obq6gpQlUsgvYSRbqMGZksPzktchpdVl2nNZRAGs0/TxrEClctArH7u7Lru4CqL6N0zWXPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ldeV9WlFgEP4eDwF1ndg9lkVCc1UO2pWGTi0UP+l4E=;
 b=mkWmUr6uOBrc58Xy76aSD7QtaC2oGFJCmqW72MMl+ogFlvFJriIgM52lEY3vQFTTFXdQx8GXhf71EmjTx0b1hEqDcsvQpYCkjjNqkPy0VXqa4pgf8zz/cj/A6vxzW5MIXJuYC53zzZGGzxpDcVjwSS/NF6MCYwHDwVbEUjyGhmqo3XW6O3CEx/LEXIA8sxY+ZnzqKu//Kj06MOWgZm//HChlmBvQpMgoUJEXTZlcy8VhocExQCKR7+1u5C24b/YomtJ1WQE/8xvoA9qB5kn29AdoSrTkgsTAU5JXOGaFIAUwdiRfQBr+D3gdI7SJMyRAfVi4alIX3bGoKKuy7ssARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:26:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:26:16 +0000
Message-ID: <acd73e05-fb8d-46f4-aa8e-e475685e5a18@intel.com>
Date: Mon, 29 Sep 2025 16:26:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] mmc: sdhci: allow drivers to pre-allocate bounce
 buffer
To: Albert Yang <yangzh0906@thundersoft.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>, BST Linux Kernel Upstream Group
	<bst-upstream@bstai.top>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<soc@lists.linux.dev>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
 <20250923-v4-patch-final-v1-6-2283ad7cbf88@thundersoft.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250923-v4-patch-final-v1-6-2283ad7cbf88@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0423.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::27) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 20107599-d32f-44ba-100e-08ddff5bc4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGJFRUhrQWNTRGtPT1R5VjVmV2l5NjdXaU10NjNsU3QyMUJ1cTBVUWIxc0E2?=
 =?utf-8?B?VVY3OEMwT0hpUEZTcjV1RGx5eXpvRU9MR3ZFVk1jRFpQNWRyaXRnZTkwTEYv?=
 =?utf-8?B?bXNzaitPM1lBc2hWcFVkTmRoRmR1YnRWMmdSa2ViNGJ2NGhkek4xNk9jQ0FQ?=
 =?utf-8?B?UEhvQUQzVXN4djJVRWxkUFRXNUdIS04xNE5rN1ZEUVYvc2RFSUl0blA1d1hT?=
 =?utf-8?B?QU5Qb1lsb09aTTFXRlliQTdLek9SSWo0SkI2MmJtbFN2Q1BCZUhPTUdEVkV2?=
 =?utf-8?B?L2RKMFNJVjRlZ0RUT0huRElwVmtreVYzNm1yTkJBc0hiRDcyRTkwUDljZWlS?=
 =?utf-8?B?eFFXK2xBSWgzb2Y5NU1jaW9heURQYzNyN2owang4ZGVZRXNyTUNRVk0xUThG?=
 =?utf-8?B?bVlKQ1NMTG9aRjJOWmMrOFk2dDZ0YVhTVFY3dXVIMFdlQkhwaFlOdk5hWU5l?=
 =?utf-8?B?UGtONzNPV2J6TXpQLzhINFJSNVJ0clFqM0dRK0xRRnNNM29WWlpYL1hYWEl5?=
 =?utf-8?B?bS9MNjQvV0padHRZNTlBZTA0WUQ0NXFNeldFanI0UTFyMEtHWlhhRlFrZ3Qv?=
 =?utf-8?B?MVMvNkw0N28vTFFmb28zTHp6akVwMTUxOTg5ZEhhRXFpVUNEVmJMbXByVmky?=
 =?utf-8?B?QTZUS3F2R3VkQ2E4a0JyWG5UZzRSNUk4ZXhYblZOUWhWVS8rNGpDbDNxUkNL?=
 =?utf-8?B?VFY1VDB5VVduN0hYWFhzNTdVZS9EZ2FLWmd0enI4UlRvTm8wazRtV3lpMyts?=
 =?utf-8?B?bUxENDF5K0N2Tmg1bVAySzY2ZHgzNlViU0kyWU1WaS9uTktoa0k2VHF4VU1s?=
 =?utf-8?B?L0t0N1FRTFc3Uk9vM21sekxjSkdlWHlpTWMrYlc3Zmk1VUNacjBxNm45dndl?=
 =?utf-8?B?d1QvQnNVN0xHK29PT1lUeUlacVhqcU0xbGMrVG1SM1pCNFprS0s2QXdmNUIr?=
 =?utf-8?B?bFNZZTB1Skd2SmVRNEZVNTdiUkN6SW1CeDZBYlFLN2llSlJMem1WVXNXQkNS?=
 =?utf-8?B?ZGRzTmVKTlNDSC8xekZJUmJnNEVBUWlWNmZMZmlieWlXMGhhUGtGOHlqYVhJ?=
 =?utf-8?B?OVM3NTlqMzhrQkNYWnFzTHlRVEQ5MVJwWU9Ydmd6ckhHOVRIVkNkZXRWOFdz?=
 =?utf-8?B?SWNMUUtZb1FCaXZ3ZHhyNWxGK1AvK0UvY1RFL0ZuZHNBUU9IRjB4bTVxUHRx?=
 =?utf-8?B?L3c3SEtIY0tYcVBxd2hOQ0J0L2ZJSFNBcnliZkw5MlNkcWcrdUNHeWZPSDZS?=
 =?utf-8?B?Y2E4VTRNV3NHME9aYUp0S2dXaE9FVitabXQ2aEk4VWM2WFE5RlBIRlVtZTRE?=
 =?utf-8?B?REZVb0NiSDVTR3d2M0N5b0hIbDB6NmdBN1ZtVGdPQzd0T2c2MWRYaGo5ZTVJ?=
 =?utf-8?B?d2V2WklndVdKQk94T2JMb1Erai9GU0FMTEkxTFlQT1cyMWVOa25OTEloMGcz?=
 =?utf-8?B?VDRXNVhRRXBrSEVpbnR0aFZzbHlHc3BJclF6NzhueE8yaEVhTWtndzIrZ0JF?=
 =?utf-8?B?RU9haE9ybDF5ZEVicmVQSFpNak1hMzZIeVBDRGRCaExFdkJUZ2JWSXFMTU02?=
 =?utf-8?B?L2FCSHN2NjR3Ui85cjJSYlJvZjhVRkhtZUhwQm1HVWU2Zmo5WmZNcHNjQnh2?=
 =?utf-8?B?eGFuOWtVOW11cHM5S2RCYkRCQkx2WjlOejVDYnQrREVFK0ZPNEw2TVZENUFD?=
 =?utf-8?B?SnNYUGNUWjRMckNlbHhNUVBuQ0RLbXljb0lJa3BpNFJWdk1IclRtTURLZUdK?=
 =?utf-8?B?dnJuVXRqRGoxbEZuVW5zR1JjbjhSaHA0amt4OFlYVVRra2dCakZiUUhnYnVU?=
 =?utf-8?B?dVovZDFSL0VscHlyalMvdGs3OUFYWHNwWUVSb1NJNDY5MXR0OW1VVlZacUFp?=
 =?utf-8?B?aFlaNCs2NUMzRlZmcXYrL0U5cXZFOHc2bERCdFl3ekZqdmNIc0tyOHhMTk1D?=
 =?utf-8?B?WmxFYWxHNTdHUTEwNGJKR2hNY2FKM0NjNVBsNG5FZzc1WjVLWDJWYzlhaHdl?=
 =?utf-8?Q?ifCA/3W4qgpiUZbZapQsvW/uGLOo2s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTR6cjBJNGVVYzcwaWNXb2htdkEwa1VqeVNHQVhaRHAvN1dpcmRhMHF3ZEln?=
 =?utf-8?B?R2tWcnR1ZGFDK1VkUDJCcWZTNUxFVXFTRlN4OHVNcmRlS0NpTEdRNXpnNnUy?=
 =?utf-8?B?b1JMZHd3VXo4UktiYlYzaStyZm0vWTJyNVRmditPYTJSd3BJc3I1SGRPNlM1?=
 =?utf-8?B?M1lkVlhTNy9OM1BIZmRTQUlkc21OcXBwQVBqcHVBMHJ0ZmtIMmJ6bzdqSXEv?=
 =?utf-8?B?YVFSVGRsVW9DVm5XVDNuNStCY2ZmUHNudjJtYTV3VVVBWGw1MC8reVdsV01a?=
 =?utf-8?B?c2NTSGNMT05jTzI5dFlaRDROay9qNGdpNW81bzdCQkRKNDg5bnZ5WWxrdEFu?=
 =?utf-8?B?SVdiQjhLb0R0dnlwdVUrUGsySkRxaUZMYUE3ZmllY2Z5eXlmeGwzOFRLUHlv?=
 =?utf-8?B?OVZhL24zNGhmUWJja29QL0xwSjcxNEY4dlFMTVJyanBDaWxVRUdwaEUxaGZI?=
 =?utf-8?B?eXoyNTRPSEszU3d4Znd5OU1mS1NIbG1LR3RsREhVcmgwQ2kxUzdGS2pnL29l?=
 =?utf-8?B?dFNUVEhXbytvaW91dzlFWTdYaUg3ME5oT1cxQmk1cFB2WmIraWs5OGV2NVRQ?=
 =?utf-8?B?bkFBMk5RUnBkWUhyOVJ1UWRhYjhyVXlDeVE3U3RCd002MnFiREVSdmhLdm94?=
 =?utf-8?B?T2FmaHNEUU1NKzdFc3ZOTndqbUNLWWNBWkViMVhSQkpUNlZ3SzY1cTYyYlJh?=
 =?utf-8?B?Y01NMUl0cHhWQXVkYzVQWGlIcGh0ekhUcFJPNkR3bUJScDRGVzQ2bkZwdytp?=
 =?utf-8?B?RXFXK0dFdEpzRGVYVHZ3WXZ3U3pXMEJUbndSalBmcVNlUno2RjZMcDFOZzZ2?=
 =?utf-8?B?ZjMrb3Q5dm9vNnVrUm8vWFJNcE8xNk5waXd3cUtaNE8zZXA5djdjOG51Qyt3?=
 =?utf-8?B?U2h0YVpENklJMEJKTzRqaHUyWHk0Y011Nk15eGRTVmdiS3R0T3hjazZuNFhq?=
 =?utf-8?B?WXBZVXQxSy9ERW80eXFiVmxWUDBwL0dKV3BTUjBiSWp1c1hJemJKUFp2NmdD?=
 =?utf-8?B?YlA5a2NScWJ5bHRINm9jYVVVNEVpTXJKZWQ3NkRIc1hwVWZITDYrajh3Qnhw?=
 =?utf-8?B?Vm9uNlNHUk1BK1c1S2JiV1NGYWczUm9qc2FiM3EyaTY5RWtuUkJZVEJ6UEZ0?=
 =?utf-8?B?QjBma0VOM0ZOM3J3cWlDb2ZSd1FoS1NvcUNuc0ZGamFtT2w3RnVwVWVOOGpt?=
 =?utf-8?B?YzkrQ2JQRzFsc2xLN0pHOG12Zll5Q1owWUhFNmVibzhpVHczYkNFd3VsVmtM?=
 =?utf-8?B?Y29JalBCZmhpZzlJemR6ZFV4cUxTbE1TbTJnbXA2R3U0ZlpTcW9ZQzFSVkpP?=
 =?utf-8?B?TnJHMUV0emtzRjA2TE1BMlcxak5EVkRKRGM0Vmg1QVdiNVU2d1oxLytJU21z?=
 =?utf-8?B?VGR1QVhXUjNyU05MWDR2NHh3SFZnV3Z6WEJPcVUyWXMwWmh0ZGUvZGJxcDdT?=
 =?utf-8?B?cU5uY3ZNeUtYMUtXVExDdWx5enJYTkh0TTVCU0FITnR3NVVvSS9JTFg0SmVR?=
 =?utf-8?B?V3YzYktFV0FLaU5IS1c4T2JDUVVFN09zaDFqYkR1eDRSNFZ0SWpDWWV6NGNy?=
 =?utf-8?B?cUZ4UkNkTFBvbk00bk5HeHRkZTE4clBhUTZHSHJRQWo1WlUwUVc0NWhkM0xt?=
 =?utf-8?B?bTR3OHZaRXQrbmlhVTV5VVBUUzk5Q01zcUpIZzkrZWJtUkNoTVhNQWUvcDhC?=
 =?utf-8?B?M3NLK052MERLdWV0UGl4bVVFblVsSDNuVGRDdmQzVnFnN3JFNDdncWQ5d2Q4?=
 =?utf-8?B?eWMyOHMzWFVSWFpuYUJXeHRGTzR0azNkSUFIWUZmTWJLbnNPdHJKMzd2WTVX?=
 =?utf-8?B?ek9EbDZhNHJkaG5IYVM4bDZCaFBVMUNxdE0xRGN6SkRzYzZ3bEtxcFNlSEwx?=
 =?utf-8?B?Y2dwa0ZiZGxWbCtTQ0R1VmQvZkZ3bk5HVEl6dysydlZkeTVNN0FiZzNURHUv?=
 =?utf-8?B?dG9kZCs2bFZVTndoUnN1WVNwaXpaTTViWHByeVJIZkJNZE81Ry9VbVhOSUt4?=
 =?utf-8?B?bDJtbm5Ea2NoZTV5aDYwTmk0YXhxbkRiZWtOVkNoaFliUk1wa09DUDg5eW1y?=
 =?utf-8?B?TEF4MG1GcEcxbE9JNCtpS1U1MEJOUnJBRlRFRDNINFkrMjhXZndDN1U2N3Vk?=
 =?utf-8?B?bEVpMk5kR2tuZWdWRUdLTUNBaHFkaUorV3RFS2tFWHQ1YWtjQjZReml2SlVN?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20107599-d32f-44ba-100e-08ddff5bc4a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:26:16.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq/dNLxG+GhpUS4yMANexO0jajogNwvp457KSiym0VOOFkphXBQpoxkkFnetXZpNfKlgDfpb345tUh57HE6ZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

On 23/09/2025 09:10, Albert Yang wrote:
> In sdhci_allocate_bounce_buffer(), add an early path that respects a
> driver-provided pre-allocated bounce buffer (host->bounce_buffer).
> 
> If the buffer is already allocated by the driver (e.g. coherent/SRAM
> buffer needed for platforms with 32-bit DMA constraints), just compute
> max_blocks from host->bounce_buffer_size and jump to the common "out"
> path to set mmc->max_*.
> 
> This enables platform drivers to allocate the bounce buffer before
> sdhci_add_host(), avoiding starting the host without the buffer ready
> and aligning with the guidance from review.
> 
> No functional change for drivers that do not pre-allocate the buffer.
> 
> drivers/mmc/host/sdhci.c (sdhci_allocate_bounce_buffer): Handle
> pre-allocated bounce buffer and fall through to set mmc->max_*.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/lkml/2b23bcb9-abc7-4667-b939-a19ecae935a2@intel.com/
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

This patch needs to come before patch 5 because patch 5 depends on it.
Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> Changes for v4:
> - Add new patch by Suggested-by: Adrian Hunter
> ---
>  drivers/mmc/host/sdhci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3a17821efa5ca92c6c29141d8fcb9ebf58355cc7..03fbe30cb205e16b924481caa44f0979d230f380 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4193,6 +4193,12 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  	unsigned int bounce_size;
>  	int ret;
>  
> +	/* Drivers may have already allocated the buffer */
> +	if (host->bounce_buffer) {
> +		bounce_size = host->bounce_buffer_size;
> +		max_blocks = bounce_size / 512;
> +		goto out;
> +	}
>  	/*
>  	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
>  	 * has diminishing returns, this is probably because SD/MMC
> @@ -4241,6 +4247,7 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  
>  	host->bounce_buffer_size = bounce_size;
>  
> +out:
>  	/* Lie about this since we're bouncing */
>  	mmc->max_segs = max_blocks;
>  	mmc->max_seg_size = bounce_size;
> 

