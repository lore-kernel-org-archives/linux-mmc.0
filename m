Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F10408011;
	Tue, 19 May 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204602; cv=fail; b=lqmqm9+XDjfawgehio28/oWzJpQLi7WtKORXv0fwOymMCrQ0PIr/7tobaszKxpjuFQM2YlWdWSQ0FDQqaqsomMdAznSLK751eJKz6yCBVM4NH+YoD6g1ZAx57ZOToyl1WhXaSVd+9eXNZgqUYv7Y8bDy4Y6WsVC4tykINP6n0Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204602; c=relaxed/simple;
	bh=xFvoRkYsGo/FZd77p46yibI5Ieg/dE8xyFD3fT49ftI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoLw1kRSJTR8DcSv2PC/73ssnit3wcXFBoPn8F7mfJimCDkBaZO5jDCbGexmguAd0rMkC1mL3qOyPgg2GNHdZO1EoPT1MldvSFrdChAMQDrarEJZPWgNyHnB36U8IQIl9mCI6vbIuIyvpZQ3D4nuXyIeridzn+WY8E4yObfPRgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYB93Cxw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYB93Cxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779204601; x=1810740601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xFvoRkYsGo/FZd77p46yibI5Ieg/dE8xyFD3fT49ftI=;
  b=FYB93Cxw3c1uO6eRnV6vIkc05MTimabyAhQ4GGUz0vOejH28UUSYpSTb
   kKpR1bXWoM0b+WCS5CFajzqUrOftsrsopWkpuK+juwXsI9Vi6t+Iqs/W1
   rskSDF7IyHiJaQkb5qqGLIKOmgTcETchrNm95qk5SCH1A0oCNxnpZ0eF7
   DJQqfKPmVj4LrCmee4kAyc7ErF4iYziUap1f3ulkmnJx8GgX9r4b2ZtTz
   1lGJ2G6U4DbSYC8fW86mzlbyyIPCU7T9YaK6jpTlicman0e7tD3cpIdM5
   gVQ4UU7gSC2K7WLnA8hkFsr+0DEZv8znTmm0IOTEBbdIjyO7Puggz94a6
   A==;
X-CSE-ConnectionGUID: ub6iAvp9TtmD+hc1Nk6B9Q==
X-CSE-MsgGUID: Qb8198eCQja5MpEDLv4ZcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80116688"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80116688"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:30:00 -0700
X-CSE-ConnectionGUID: hfdX9CMYQemUbmFGyPiALA==
X-CSE-MsgGUID: n4DgVlRRT+uL88/UQg1FNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241632614"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:29:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:29:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 08:29:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMtxZJb34D/idK+JCnddXvA0+e8mJs3Y5jktxhoIRx6ovC4i/aTTvAMT+w+2QgH4b8Cs22+r45D09Mczp18q8RHBaUrSfFVpPJfLjUtp/6Gx2rSU6DkQXKJkSkyNS4f89Y6h0ER74eGjXEAtuA9s1c82mxsSZfOQRo3ARLqxmOJcvMAvYdPL/ZiDzRzxLpvp1+aOfriehiesp1VlcAKLTEMEQIPrALIdUD54yK9GcPcbwuP/LKBGz92Z25+L/ma3moFnoRIK0GyNa/csvJmsesToNWz53WtH1nX+geZVIqYsX6XDXAAS2yjAlS8GwCVRq9FW43UhmfN86Q3jny2Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWkEj8bZ9/J5fR+UP1At7Ep7ywUOLmjQii9sULVFT9U=;
 b=nDMQUZGRhYB0c1LetUSpQPHx+W69giUB42np71bspOz26lRbsvu7zc3YSJZZk0WIW/0xKidKPN5M/8ByR5VIQxnOhnF9eDz64Q7XEAJxr9RewGKk+K6YsAdfucbhqVdEQAqLA2r3aOM9zaX2yVVEtqQmSGGyC/zlUsz7lD3VdPhonGVo0Tnowt7vW+CXNH75aWNgot4ngwMk940DmPqocnlU7gTmbk5owtqMAhE/TMYE/ieIzBuUPyyMz4wIGiPAiwTrrp8xcK095ccjmVCWVJAboLT+SvKcstD0aFRRz1JgTZ7Wk07AoGmFkG3RxwyBuEs+c/3P5bujAPk1bm4iAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 15:29:52 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 15:29:52 +0000
Message-ID: <a02576b9-4068-4686-b59b-71cecd319f39@intel.com>
Date: Tue, 19 May 2026 18:29:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] mmc: sdhci-cadence: refactor driver structure for
 V6 controller support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-8-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260511202132.5597-8-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PPF6F32BC4DA:EE_
X-MS-Office365-Filtering-Correlation-Id: abb14404-df5d-4214-6f0d-08deb5bb7874
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|56012099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vdsCKz/OHGPKGK9jJOh7WVEGbR06jxxRJ9Fd0oyP4AO9ADt9PmRx9isoelwSylddmpbTbw+1Cb5q+sD2URiOKxfe75/33pk+84sj2I6p2FgrA0RW7Q8c919sbUzpALIOMZ7pZKJ6Qwj1+DOkTJ2LTJyY2io1RicPTbfLihkyiSlwsAlIpMsJXIkU8nox0rUssQAri25SyjDyVgP6Gc0y8vBBLDxOjzLehn2sRQbUB97lHAh9N5Ib9YsAf32TdJ6BG73rfjI9PNq9ndODmo48QBoY/84HIoTg31kLm4q/MzuF9ptA6d5NbDiz8S0JGaQQsgaYBzYSbBo67tQuTd+JtjBD0X8SUeRUszFKY2wuqvtHUdkUmC1VSM7nTB7SZQ42nMsWW6z99VNZUzInJGVpl+ZLx/D8OBprdj0a0ESMvIShOxv8kogicWZ67VLoxU5sCKuD5zexw3GNcYLNDwIYaU2xbKi3U1FGX5jR83avds7oWjSi0LRcy7pgku9NolNTygsylW7dGr+ggNyEJzyrHYtrpjyX5LMRVHgcs3DwCgPJbMFyGzAs0Tc/SoEAooPBl1pzAESvYhz0nSmEagL7/FjS+F7q4v6aWOHiSK79tmxi5WNiMQ1ZhtpnXTjy4vL0uotcqr49T4R4joh6bOdJ0J7Z5vyrdzfNXuPGwTWbSdZkmKt+y3MMZpVFptN+Ur+e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2x0UnQ3S2ZpVHVGZHZrM3NCR28vWllURDJ3ZjRhV1g0ZXdjd3FJZk9WdHNz?=
 =?utf-8?B?ditSUHMxYklNUkN1clkzMHdnRGk4alp1aEdldnBhek5saUZMRmxYa05FVnZU?=
 =?utf-8?B?S3Z0eGxnZVIreXArWG5jUTgxajhNS2NrakQyeGRYS0M4RDlqRTVZdlNIMjdP?=
 =?utf-8?B?Y0N0am96ZzdRekxXamV5SXBMQnpXUkdYUFRMMXBQWGFjUitBditoak1UL0pW?=
 =?utf-8?B?YjQ0N3FFamQyWjZQa1pteWFVcDlhSkY4VVNZZFpVY0VidHIvOUwvSkI4RW1I?=
 =?utf-8?B?M2orUDl1SEpZR1dndlE4ZEpMZzkwSHJZc3JzbFpkeVdjeGNnZ2xrR2t0M0NY?=
 =?utf-8?B?V0hma081MmcxWGI5VE95U0l3ZkxxQmNHcEV4SE5wdVVnbUVGOEJ1WFVWcUkr?=
 =?utf-8?B?TFpVc0VTZ3B3MWRoQVRrQURpdEFKSkFmNXVrSGxGZmpIMGJscHA1ek53T2pO?=
 =?utf-8?B?aXNHTHV6SjY5WEFERWRBcG1OY09DM01hWmlNem82VVY3bmFtbHBrRk1FanRZ?=
 =?utf-8?B?VnZWbTFHOUEyVVhwcE5IYmtpUmFVR1VqdnFYdXRrREdwZGhXZHpncVFrZkFt?=
 =?utf-8?B?ZndaK1ZVdVhKQkxxV2RIQ0FOallHOHRmRXpPVlp1YTRuVndEN0ZCeDQrUEdK?=
 =?utf-8?B?Tk5PblZpTVpXKy9oZVAwRGxRUnZNTVpZU2hIMlBPT0pybDZwelNjRXBXWnV0?=
 =?utf-8?B?ZEwzOHZoNjdLbHlJVkQ1R1I3OFhsVWFYc0dlTGdCM3JuOWdrNm1rUVZadHc2?=
 =?utf-8?B?dGQxNm9PNHBNeTR5bzNjSVlqRzFwakdzUnFycDdNWXBxNDB3OGhqRitMMjla?=
 =?utf-8?B?TW4zZW8wTTZsUUVTcFJJTE5GaUFWUEN2ZWg3OWtRSmxtVE52enlEUWx6c2FK?=
 =?utf-8?B?bDFReUlKWUhITC9sK0xyOG1OZ2pYT3JvZEdhZEo3SmRwTzJwc1FNT1NOV2dj?=
 =?utf-8?B?Zit5TXdEd01IY1ZLZ2NzYXRGSWpNbk1maWh6dnJFS2czdkdORDJtNXFpaDgw?=
 =?utf-8?B?TnhreVFtLzQyZTFnSGFYUjYxK1RSOEZ6aW5zMlUzdFpIcVZlVFpBeVFob3Zq?=
 =?utf-8?B?dEswcjdDSldIWFZ5YThaa3hTUEZUZlJTMEpjL2dWYnVoZGR4WXRITERrV29x?=
 =?utf-8?B?ckJCT1hqc3JUT2lSci9Kb2RPRFV6dlFFL1YzdjNIR1ZnYXozS3pPL1dxSC85?=
 =?utf-8?B?dE1RWFRpS2FQRmNNcjJWMzJnd29hQ2RZVWg4c0gzNXNMbXJRYlg2L0lCMHJ6?=
 =?utf-8?B?dWtrVVNpbUN4MXhMaGdadTVFVndvZ01JZ041ekdHRytGNHlaM0g0ZU9QMkdu?=
 =?utf-8?B?ZWZXbTRUdWxUc21FQzRrZHYxRW9UZ2p0cklOWHllQ3NlREt0dkRXVlJ3TGZU?=
 =?utf-8?B?MEZmaVBhN01rQ29MZUNBQWNHUEovcHB3cUhTbzdZS1FCNjlGcW1DUklNVWh4?=
 =?utf-8?B?OFFTKzROSWdhT2tXd3NRN3crdHlGYXc5N3BtTEtJVlAyWkswS0d3WVNsbHdh?=
 =?utf-8?B?WFJXU1czbU0zNGhUNU9Od29ZcVVwSlpNMDBOeDgyS2pjT2VYRi8wUjh3NmFo?=
 =?utf-8?B?QWkxRjBidHR4eG90ZEZDZ1RuaDh1SlhUdjEzU3FJaUlaQ3pXc0RyaXJVOFdC?=
 =?utf-8?B?UGQ0WTA2Nm5TQWtINjR6TVppbzl4dGVaUUlLenFOSyttc1dsVk8yRXM1OVgr?=
 =?utf-8?B?ZS9FN3lXNno5ZWF5aTlYOWV4ODNIanVYNVJISUxyR0lYSDlLdWdYOTRmYzN4?=
 =?utf-8?B?aE5BT0FBc0Z1NktnekNpd1k0M2hYaHd1RUxON29za3E0YmlFQ29BMmRpMEo0?=
 =?utf-8?B?TStFTjVRS1FMcHVaZnUxa3NxNy9xMmw2N0tNRzVGMS9WbnBSVDBocUpsNHN3?=
 =?utf-8?B?akgzbXVRVTdHWHg5cklOQUMzOFI3UHZ6dS9kZEdqcFZTZU9qRU9vVWE3d0xN?=
 =?utf-8?B?SnhMZlFJZEhnSS9TNThGZFBrR0RVTXViazJJa3orZXpQcU5qV0twdEJNU0Jk?=
 =?utf-8?B?R1JQcjJxTTFiNWkwSmdDVzBKU1M3SzFFYTFmZ1UvVnI4ZnFRckVhYjJWUGNO?=
 =?utf-8?B?cWZaT3hRUWI2dWJ1V0RsTnlmVm9sKzl2U0RSZ0l1ditLWi9EM1hPODVpK2tY?=
 =?utf-8?B?a09lQjJVb2FCU25HZ2NFaEpYTTgvbkNMNWtZVmZIV2UyalpLNG4zNkdZVTQ4?=
 =?utf-8?B?WFdYNTVzUHlndll5dG5pTmpOVEhRR3M2WnpNV2ovV0hvYUlmY0lZMGZCdjFE?=
 =?utf-8?B?VUhUYkt1QUwzYTFLYlovaGFTUUtNTFczZjg0NVJjRngyWnVpd2ltQitxdFhJ?=
 =?utf-8?B?dWxBUVFGeVRYTWhTc2QyVWV5V3BGd1FTNXdSZEh3MldGOEUrcFV3TW9OSnZP?=
 =?utf-8?Q?5PaLgsSvAQgknBjk=3D?=
X-Exchange-RoutingPolicyChecked: ENWaSh6ZBw9IoxBOsn0T83mjSmrYyjMNXyQnCgzUYiwobcQQ6qKmbeCEtkNkLQlP5fKZl1ija+LLcuKrRL3gZO8xgz0peffw8EmrCjLCcZtsDpvXfN9jlp651RdiC+P6A19AzDOlsXv6upqQfprLknOCYvUKtD5cf7jONSTJ7UNS6k3IwR1xdJL3blsSCj3WLBq7AgYKDKpCEaIzEbLdas6KxtRzAPo958DTUiMgEVmb2M4F/O4FSBq8+tDzYwabBYLrVjYQGMUkkk785wMb1kGhnQuq5eNe1Oa8thllfY1Hi8FmXgU6cH37JjqAPY9xygii8CXeWhkM73K3+48TeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: abb14404-df5d-4214-6f0d-08deb5bb7874
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:29:51.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp0IifLi9vNKFkedhc2OoxitPCOHL7+XK4Grb22junE5amr87PnKXUuotTRi5Y/ULHPsBx7Qax1YxdVYOflvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

On 11/05/2026 23:21, Tanmay Kathpalia wrote:
> Refactor the sdhci-cadence driver in preparation for adding SD6HC
> (V6 controller) support. Separate PHY parameter handling into a
> dedicated sdhci_cdns4_phy structure and move PHY initialization
> logic into a dedicated sdhci_cdns4_phy_probe() function. This
> allows different controller versions to manage their PHY
> configurations independently while keeping shared logic in the
> main driver.
> 
> Each compatible entry now carries its own driver data, so drop the
> silent fallback to sdhci_cdns4_drv_data and return an error if
> platform data is missing.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

A few minor style comments below

> ---
>  drivers/mmc/host/sdhci-cadence.c | 57 ++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 47690a52a221..fe3f7c5109fc 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -83,6 +83,11 @@ struct sdhci_cdns4_phy_param {
>  	u8 data;
>  };
>  
> +struct sdhci_cdns4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns4_phy_param phy_params[];
> +};
> +
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	void __iomem *ctl_addr;	/* write control */
> @@ -90,8 +95,7 @@ struct sdhci_cdns_priv {
>  	bool enhanced_strobe;
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
> -	unsigned int nr_phy_params;
> -	struct sdhci_cdns4_phy_param phy_params[];
> +	struct sdhci_cdns4_phy *phy;
>  };
>  
>  struct sdhci_cdns4_phy_cfg {
> @@ -169,9 +173,9 @@ static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>  }
>  
>  static void sdhci_cdns4_phy_param_parse(struct device_node *np,
> -					struct sdhci_cdns_priv *priv)
> +					struct sdhci_cdns4_phy *phy)
>  {
> -	struct sdhci_cdns4_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> @@ -190,10 +194,11 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np,
>  static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
> +	struct sdhci_cdns4_phy *phy = priv->phy;

Nicer to place locals in reverse order of line length e.g.

+	struct sdhci_cdns4_phy *phy = priv->phy;
	int ret, i;

>  
> -	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
> -						priv->phy_params[i].data);
> +	for (i = 0; i < phy->nr_phy_params; i++) {
> +		ret = sdhci_cdns4_write_phy_reg(priv, phy->phy_params[i].addr,
> +						phy->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -542,6 +547,26 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>  	usleep_range(300, 1000);
>  }
>  
> +static int sdhci_cdns4_phy_probe(struct platform_device *pdev,
> +				 struct sdhci_cdns_priv *priv)

Please wrap after 100 columns not 80

> +{
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns4_phy *phy;
> +	struct device *dev = &pdev->dev;

Nicer to place locals in reverse order of line length e.g.

+	struct device *dev = &pdev->dev;
+	struct sdhci_cdns4_phy *phy;
+	unsigned int nr_phy_params;

> +
> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
> +			   GFP_KERNEL);

Please wrap after 100 columns not 80

> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->nr_phy_params = nr_phy_params;
> +	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
> +	priv->phy = phy;
> +
> +	return sdhci_cdns4_phy_init(priv);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> @@ -549,7 +574,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -560,11 +584,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns4_drv_data;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "missing platform driver data\n");

Please wrap after 100 columns not 80

>  
> -	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
> -				struct_size(priv, phy_params, nr_phy_params));
> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> @@ -572,7 +595,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host->clk = clk;
>  
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
>  	priv->priv_writel = cdns_writel;
> @@ -593,9 +615,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
> -
> -	ret = sdhci_cdns4_phy_init(priv);
> +	ret = sdhci_cdns4_phy_probe(pdev, priv);
>  	if (ret)
>  		return ret;
>  
> @@ -653,7 +673,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "mobileye,eyeq-sd4hc",
>  		.data = &sdhci_eyeq_drv_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns4_drv_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

