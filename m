Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C467260D
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240852; cv=fail; b=YvJTmF7qOLydNgeznjK8ZY/ZTndXiINiA/3HYoChWLYnOxZHHIQjkg/l9i5luXU5Qc7OEoNlrY4vvksjB+yOIU81Cvh5D/GFKc4ZttcO+glKV+3FEz8UnuA84JLTGYgLtlJ8O4bw9LbIJRmKNFcxVRs1uK7W8H0NNDVSGJRImkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240852; c=relaxed/simple;
	bh=Okz70BerljbXNKkdpN9ASmFvI7e3DYIFWGkjfxjjXoM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NaBMI6eaQ/zxf+IgPZuB5Rtn8TAgn2aYDbXGoK+oYJznpqsHaV+2zZwalvZEfv+ZQvsVMN1JgFwOMEm9wTbyuWYhurzI4/CUuRWYPi8gaqAzlY2Zzrs1fGO6y9krwSLKqSCs2Xfq+h+4Fe+rU8AJu6X7Y4wBUR7oHoiU8fP+kQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KS72vN50; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KS72vN50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748240851; x=1779776851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Okz70BerljbXNKkdpN9ASmFvI7e3DYIFWGkjfxjjXoM=;
  b=KS72vN507rcWTkPoY1oWkShf/LGRvsPzjWh5Zf6+v34Q0V69bnZTv1e5
   98fkCtfbR2VTgj3//jYNGEm96WkRe5hKgt2fGOe2VhESImvQwS25e4Ky2
   NM402rpofYZQRKytcL9ESYUtSaVEFqzWYUy0m0ldAl3TrTOG/WeYsBd7S
   2OPGCqzuV/Wm0RySwCWP/Sti82Jy1LFGgUco79rQZxdZfgY3nVV1JzDWP
   VQm2xWR/w8axzss3JLx1s8x9+MLwCXhOIwyCt6sgtnQAv8tL1WwUDL6xG
   uCiDndQ9X8R5oCBOW4g8DAiVZ33pwSWyyPpz3Z/KCxODnbaAYWBQYdzqX
   A==;
X-CSE-ConnectionGUID: hBzdNdjlTQ+Z0a6fDlvZaA==
X-CSE-MsgGUID: yunwGM18R4WyhcoHvsmDbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="60864140"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="60864140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 23:27:30 -0700
X-CSE-ConnectionGUID: oeZil1jXT9ehoPORr2vCEA==
X-CSE-MsgGUID: U4JyXwDVR8aBWKfWYA9VRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="142151446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 23:27:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 23:27:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 23:27:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.79)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 23:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvGZkO7jWbGvEF6DJI0xCa0eKCCSkR7GRPVszMngDx0sm8isDBiuxGQRYakX/tuVaUG+764Zi5//JDe0B4XQb/Vopz+lRXM3QnbUHJ+oIUWvuJMxfEPeXPAMJACTFBbLypZooqYPZy2iHWf2qNGuI+mlU+uPFq45BiWZPakE+e9u7RoXKQd/vfjRT+e/Pq5QfsIIqjOF4Lyw+JsOw/gO2jCEnh0HIiGxkyCb/Ztt2mLB6b1wqKRgedAOVSZz+vvkQT3cKJwf8Pp+x8if8JV6b77lqnDSUxem2p5CS51qDAySPMVzz8EZEZTr/1EzUeH67XzV3n9BwxndHA95mD3BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqjuL8AGGvO/8DPMhBYkvNG1tIN4QAvWOOuD95wfuEA=;
 b=MwX5TjTaEgD27fofBEVPx9jTp3nKREYOH6xLJRYfhp7MaaFRZSQ4Ra6DfsBWRmVryPAcxRJXanUv8uCGoYsTUo4yeucizi3pJbH6wrNDWY6U5DBVoaF9dLdiGW6sdcBueFFxRrQPfSi3rtWG3QzHPTzaLDr9/srl4Y2UXLsbrzJ14cmFYdyIbu1IS9uPzCOyGGADl78koq8LHHe7gw7dUQg1q14QG7NpK+QEYK3jgCZ0QrVa8QnGoPgbCkn+mCIGgFPvKii1OLT4SVSIAgF0Hxxbijk32KT9QAMvaZzCWgKa0tv1S5Sf0av4LayRm2C+TEHpM0XgTZLK7G6nEeIWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 06:27:27 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.019; Mon, 26 May 2025
 06:27:27 +0000
Message-ID: <78ffbae6-1c75-46ac-a5d7-bbc07bca1fd0@intel.com>
Date: Mon, 26 May 2025 09:27:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/34] mmc: sdhci: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Huacai Chen <chenhuacai@kernel.org>, <linux-mmc@vger.kernel.org>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
 <6fd5afb003982bb5edbf95f76b605686223730e0.1747792905.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6fd5afb003982bb5edbf95f76b605686223730e0.1747792905.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:10:be::48) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d12336-0408-4c60-55f8-08dd9c1e6244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K04yTWJDak4zM09RU0M3M3JlcFlEUVJSYTUzOEpRdFhGR3Rra2Q4OVN3Qkdm?=
 =?utf-8?B?ZlZVMUFzS0JXbUxCQW50Z0ZlZjZIazFoNHZTcW4ybER1dVFxZ05HbFdDYVhG?=
 =?utf-8?B?T211Zy80aDFORTVHMFFmQS9BdlYrWG5FN04xTXZjUHdUSGlPWFpmdXFPcWlh?=
 =?utf-8?B?QWY5MnROL1dYbVJyMzJSaGphSXRsZTZkU2FEK214aFZFRlpQVkxwN3ZUUnMz?=
 =?utf-8?B?YWhvOE5zcXpvVnlCRXI5dnlmdkNURzVVZmd6dDF2aXF4RUpFanFkL0hTUFV3?=
 =?utf-8?B?N2N6Z09OcWl4U05ORlY2V3N6VHc5Nmk4KzEzamlFTy9JQ0k2OWw0UzBobDBT?=
 =?utf-8?B?cGt6R1UrZGp6eWpLNWxKa3V6UlcwZ1VKV3AxRFJxODZtNFlIc2lPSTNQbjBP?=
 =?utf-8?B?ZlFIcWRQdDhKYmIxbjdIQmRURE1vZldKNmxiaFhESjFiQmhGdXVjWlJZS0dl?=
 =?utf-8?B?SVRhSUZsRG81OEliTFVhSnJmRzNQLzlmcVZUMFQyak1CYlVla2YwdGRPd3F3?=
 =?utf-8?B?RmNLN0pPRWNZdVNuYUVRZFdqUjhDMzhqMTY5WGZKcTNZb1JiREgzTHJRV1VD?=
 =?utf-8?B?MDdQWmxxc2Vnd1g3NkU5ZHpTejFsWUJhNHh3Njh3Z09HVUg1T2pIM0d5NDA3?=
 =?utf-8?B?V3VwL1NUbXQ1a29uSnJLNzNZVDZUcWlTV3QyeC82TG92Q1RnSkVvYmVzUkl2?=
 =?utf-8?B?TGx5NHJ2T09jMlhsdE8zUUhpUENZTEVyd1NCU3licGdVcVFtU09hVmxMVGs3?=
 =?utf-8?B?eE5jRVF0RlQrWVlibDBQS0t3WVpDRTZCR2x6VGpUUjladHBzRVFkdXNzaW14?=
 =?utf-8?B?T2dpSmFndUtsUUVFM3JzZGt6cEtwOUxVN0lHMTJvVXpsYlpwbE1MOEVuaU1Q?=
 =?utf-8?B?dUVXbXg4cENOVUhjWFNBMjdzaklpMjkrQzV5ZmRzRWVQRkg0YTNFZXBHZVA3?=
 =?utf-8?B?YVVaVm1OMzc0UTR1ME1iTEsxNDUyZWNFblJXbHhNTTU3WUFoMUk5YzRhMHFK?=
 =?utf-8?B?ejhlT0htYzZ4VDNZWmVKRk5CNEtaQjNmTHplcXNVdUorQVpocUdjTUhtaGwv?=
 =?utf-8?B?T2p2dUkwTjFyY2k1dzd3Q1VLOFgxR1FuTnpzZjRFVXR2SCtDUkZoTnp2T1E2?=
 =?utf-8?B?dnNWVGNyQnlpL01Gejl4NTZLYjd4QnB0SlQwUXBkVzhrOXhNeTcwWlhSNkUw?=
 =?utf-8?B?NGVqcDlYbi9lREtTWE5WMlRkd21pM3UycXBDdUdVdDNVcnhDLzh2aENnbVFr?=
 =?utf-8?B?Vm5jblRFQmE0c0VsenVVSUFRUk1RRVA4b0U5Nkh3eFkwaHA0cjNISFFtWFBD?=
 =?utf-8?B?R3cyZU9aVkZIYVpGUnVCaGUrQzEyTnE4Yks0Y3lBVXp4cWFaSlBjaTBhR0g2?=
 =?utf-8?B?dEc5MytJcDllYjZyS0ZNRnJFRG1sSXNxcUlvTmNVU0VZNktTN1M4aExHMWtj?=
 =?utf-8?B?MnFIcW1sc0JjVzdqZnlUVnZIdlJtUnk1K0dVS3JlWitGdDJkeDFNd040OWhy?=
 =?utf-8?B?Q2xBSVIySCs2dENRZWdrZUVEM08xVFFJaTF1SzIwbDU5aXhRT0c0bis0QlJU?=
 =?utf-8?B?RzZvR0lZUHovV1hmbnkxRDdueEk3cFJwSWZWaHBLUjJ1WDkydTE3b204UUl6?=
 =?utf-8?B?Y3ZGa2xzelpZQTV1a1VFMFRUd082YTN5czBSSGJYMW11Q0dWMHFWK3BPLzdR?=
 =?utf-8?B?SE51a0lHYlVQM3orNUNZODZpcDZTTGU1QlZYTzBNWVVXMGJrQTNSaVJjRVJx?=
 =?utf-8?B?c0tXeld5c05HbmRpMGF4Snp2ME5yVnM3NkRQK0hUTEptT0V5d0VWa2JTL3d5?=
 =?utf-8?B?STlXU1dDaEgzdHNDMnJhM242V0hEd05wSjJQRzZDamFVQkVQV1VMRWNVeTRO?=
 =?utf-8?B?MENLVFZSbUdpT1ZXQ1JUZ0pqa2pXNTJnS2dNWXpNOGdsSjB2TjRaUTJxNUhM?=
 =?utf-8?Q?xsk2DMU/BYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTE5TGR5NjFZSWg5ZEVIc0hocVR1bWVPVnc4ZVF6UUJDa3c1SkRMeTRLLzIy?=
 =?utf-8?B?T2tHeFdBSHB2ZFAyUzB3eERNaVlWeW9GOWFPbVE4QTVDMGRuYVdJd0I1Rk1D?=
 =?utf-8?B?Ui82cmxUd0ZodzFid0JDemVzTXN6SkNwdXZ4SVlJTWVxMWMzRUV0RkZCK3Ez?=
 =?utf-8?B?d3QweS9QaHNkZGRySHFZZnhFVThHaG9XeThXVFJDZ2E1MzBCOWQ3Y0dNdytx?=
 =?utf-8?B?SUFJWlVtdGdNMm1ORnZrWmczaHBoUlF2NVpWdzI2amhCN0puMkdnVnQ0ZGxN?=
 =?utf-8?B?cVM2Wm05MWVrSlY0bllUdENxWHNLTnY1UzFiN2tQS1AvMUExU2JnTWw3TnBn?=
 =?utf-8?B?MlZXYXI1c1FwaUdMeDZEVUdId0hvUnJqYW1hZkNpcmlYT2dTL1ltRU5ZSFB6?=
 =?utf-8?B?NGVkRDhvcDJTK004ek9qU2xFQ1NaOG14bGtGT29CNTZuVUhtZ2NDbWhYa1BJ?=
 =?utf-8?B?SzNrVGEyOHN5SEhjeW5IbDRIeFZWand0ZHFzcTlUOGlMWWdPZGZvYTdkYlQx?=
 =?utf-8?B?aXlJUHI1cVhRVjFBR1llTDBqQy9DZFdFZ0s2Ky9kNzhEb2lSRzc4R3BKamFT?=
 =?utf-8?B?alBZcWpWMFUyeE12a1lUSXg5UzR0Q0g3LzZpRXVOcTZzTlVjdklCaWY0UjZD?=
 =?utf-8?B?bytmdnJZNytBazFyS0IwRG9EdFFYdzNwZE10R3NYMm1vcjJ1MnlUaDhGOS9h?=
 =?utf-8?B?dTRBSHpTUmVMcGVWTEczNE8rM2dOMHJBdWE4LzJRbVJLY2VFbDQrUVgwQUNh?=
 =?utf-8?B?QzEzZ2xGSFRPRmF0T21HOHZwSmo2K1VKcUc3UENkdWptTUg2MmtNc1BjWEI2?=
 =?utf-8?B?YlFka3Z6RHVOK0huVm0wVk9FdTYwUGVvSVgvWW9EY2JrUnMvbmtUdFR4OVNU?=
 =?utf-8?B?Zk82YnpTU1FhcklqMHlHd0gvWElYaHlzcG1CTWNVRUlPa1B5Y21pQi9Pc2Nz?=
 =?utf-8?B?UllrVTJKd01OVGUwVjNpbENERS9BeWJWN2xyK0N0aVhOeHhOQzVkclIwd2cy?=
 =?utf-8?B?NHpyV3ZURVliWjQ1VEYwZFZKOFd0bEp4TmNDczBncUF5RFY4bkFJTmFKVjVL?=
 =?utf-8?B?REVZQ0hDd2VvdDRaV2RmeDg3a1RJanlUNGZlNnNrQXpFSUdxV29jeGYrZlF1?=
 =?utf-8?B?R3hkb1h5S0tsMUJFalR0WUlkanpVc0hRc0ltanY5d2xZajJBaWVpbVlSd05s?=
 =?utf-8?B?UmNwRGp0dGVvdllxUGVhNitCMHhTeVU5eWYzeWF6UVZsM3NaOTBrdHhGT2Z3?=
 =?utf-8?B?LzcrS2tqdVEvYUFHTjd6TFJyenRySjhXWmFQQTAyTzJOVlU3OTBNYnd3VkNX?=
 =?utf-8?B?U3ZrSXp3VnQ2K0NqSWdkNmw1R3AyVi9BRy9tWCtiNFlPNVVDT0xDOXUrQXNn?=
 =?utf-8?B?aHAxM1BqVmdoNFc3aldSNUJJZWVSa1kxQkIyWkRoWEVNT2ZFRUNSV0g4NzNM?=
 =?utf-8?B?U1B4MUdtdW9jc0U5Z2JOc0lKallOTVdIRlhDemJmTi80NUtHaC9LOXVrVjdE?=
 =?utf-8?B?ZE1HVllDVkdWWFRhRGhFWkVyNzFsZm1hL00rKy9wbjNCSjRna2h0QTUzZlpN?=
 =?utf-8?B?bCszMENQOUw5NGMvUG52UVZCZjBHNk05TncrQTc1UEFaTmRhNjE1VWtXM0dV?=
 =?utf-8?B?MkxlZWRrbkdScVJsaU5IWWNCWmhPZm9mSk52ZWtGbkIwTkFMWHoxMk5Ra2cx?=
 =?utf-8?B?SUFTZjFnTnBmdVIzazBHNUR5Z3Z2aFl5anV6ZjR6QWZpV1p2VGF1SGZlTUkr?=
 =?utf-8?B?N0pzTUtzNmpjU3pNc0s0bHZ5dUhkRjBzRVVoVzdmOHZBV3VlOU41VmNOelZR?=
 =?utf-8?B?TmlZYXduZ0NNOXdsZWlGVFF6R0xnS0VBeGNxVzBWbjF3UEFoWXZIQzVMbjFx?=
 =?utf-8?B?aFN2VWY5MEd6UGg1aloxNkIySGZDZE82dldNVVJaclFzOW9QQ0FWRytXUDdW?=
 =?utf-8?B?ejhGTVNkUk1RWWd0MW9zS1ViZm5uZDVqV3l2Sy9zbDNWTEovVSt2YmlkYkpO?=
 =?utf-8?B?dTV2Y2FHL2FqbFgvNnZLc2c0bUFZeXRuVDVKOE40TEJVN3NNOXZadXdONnlo?=
 =?utf-8?B?V0Rjb2t2dEk5dFQ3dDF1OTJyQnp4cWlEaGFNSXRPT2IwRmhIY1UvYXNtN1RV?=
 =?utf-8?B?cjRmaCt5WTE3dFVaSFhrY29KMmhtV0EwSU9pYU1SZXEzc0pIRFVjU3RBdTNv?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d12336-0408-4c60-55f8-08dd9c1e6244
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 06:27:27.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +i21g2ERZxk5gWr/tZ4Q9Ub+KwKV/7UsPzoxqL33Gr1XmMmELJAJpyg5Sfzg2G2Y8Kyf9UFb9VC+bZ3aA5r/cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
X-OriginatorOrg: intel.com

On 26/05/2025 09:05, Binbin Zhou wrote:
> Use new function devm_mmc_alloc_host() to simplify the code.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/sdhci.c | 9 +--------
>  drivers/mmc/host/sdhci.h | 1 -
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 32fa0b2bb912..c40caa3f003f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4076,7 +4076,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	WARN_ON(dev == NULL);
>  
> -	mmc = mmc_alloc_host(sizeof(struct sdhci_host) + priv_size, dev);
> +	mmc = devm_mmc_alloc_host(dev, sizeof(struct sdhci_host) + priv_size);
>  	if (!mmc)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -5000,13 +5000,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  
>  EXPORT_SYMBOL_GPL(sdhci_remove_host);
>  
> -void sdhci_free_host(struct sdhci_host *host)
> -{
> -	mmc_free_host(host->mmc);
> -}
> -
> -EXPORT_SYMBOL_GPL(sdhci_free_host);

Doesn't that break the compile for everything still using sdhci_free_host()?

You probably need to make it like this:

	void sdhci_free_host(struct sdhci_host *host)
	{
	}
	EXPORT_SYMBOL_GPL(sdhci_free_host);

and then remove sdhci_free_host() at the end when there are no callers
left.


> -
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f9d65dd0f2b2..58291a6f093d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -811,7 +811,6 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
>  #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
>  
>  struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_size);
> -void sdhci_free_host(struct sdhci_host *host);
>  
>  static inline void *sdhci_priv(struct sdhci_host *host)
>  {

