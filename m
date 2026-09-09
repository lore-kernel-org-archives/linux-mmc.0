Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6544C648;
	Wed,  9 Sep 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940296; cv=fail; b=UhKCYCmU2kBO2Gn7VVvBJt5kKtUzH3w2hOWBvbgP4qi5z4wCKHVUw52UuJSej1l7gRH2sCpOd0gsYPu6CaHL9QQThP4EDuM4D3MbFspRZKG2ryxrEUmPyUm/ZfjHQAlUcXZw7OuACU5j5Jw2OPaLNt7yq9ql3LwGAJKl/rPoLtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940296; c=relaxed/simple;
	bh=jmgZYhQDPr7JwmNa9Dv9RTLkX41UGBRIh6bOoh1Fc6w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7rJUTl7OPuslyjSKz8s+R/dotiVgUTowDY74bW+pVUSMDITv35s1kK25LbyFZWGlzL5p8oLIpwHG/6oECi8i9XJxdJY3YQVHbd7YayfLnWpGV+0b6/B6to17sBUiwO+BfCSsQ73XH34HdjYkyC8r9rjbzykIeV8nxM9uC1JFwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqX9RGAV; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqX9RGAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940292; x=1820476292;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jmgZYhQDPr7JwmNa9Dv9RTLkX41UGBRIh6bOoh1Fc6w=;
  b=cqX9RGAVWu+sbpUNEvCyDh1M0cS+5TaVzTE2NSCqKemguRtHMA0vj6Vw
   ETLUU3jqMBvmMsX2wogPCpSj9iXteYaGQUJAx8dIW4f8tz5juAIjTasuV
   xrdY22GIGgvjBG6paJkstKPM1lwQHU2myYIUGR3UnZEFTHiaTJqZ8fOoI
   POchC4vzJjRSsBHqzOdYeD51A1KjqSu/ODUHxcPqI+x4XKD9RxqeTD3rA
   X/l9OzCaomTTiYFajjKV6RkTPERHSnYeQrSV5ovR8VHxzt7ok0PXPdful
   /GK/CcXZloieM/q/J9HZnaGMk7C2ZWjftoxZarzA3HYfKCaUQTbamIIjw
   A==;
X-CSE-ConnectionGUID: WoXZsoJeQEG8ezWnRTUhVA==
X-CSE-MsgGUID: guEOkh1vRHKK5IfoUMOSRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106725313"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106725313"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:51:31 -0700
X-CSE-ConnectionGUID: F2lM0lNNSAiu2pZfZ+0rFA==
X-CSE-MsgGUID: 30tMjCTHQcSoKjfbQ+iGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="266942297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:51:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 00:51:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 00:51:30 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 00:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/y9anfCo47uC8+kLdzVmCw2hOSGQbY/Sud3bezLQUlcH40PqChKAvOfAk4Jk73nvD84xQzjjJbinJN8FMBrDCpKHZlYDzkpwZ4Ghenh72GzjSaCaLj4jsVEHU1l6yrq43jq8UX1ewaMAdl9E+vtsIe4pel7CYT00tMrjUUWy2uxi1ZIQM/r8Uhn2wQkO/h07YXi+1lVicqhIhIL8XhTmwVSpPimCkTMf6J/NwrGbRgrZD2HGOzW04rKO++kLXjO7lDcN2DGALvvkocuC7mpRYti74AD/IlUvZS/z+lQdW6yxLuCV7XBdY7r3x4YcuxXU5FMoih9A8qaPiC/llHyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHGYHf+xxWE+x7SqyDmfR5701oGeZs62izqP9MCZitU=;
 b=vgKGdbOCjUAzlNgypPM6SQx7xRakbLSaR5Kae6QW6P1KFsAMYsGRChZWW2zojXW1q2r59Ba6SMEr3oscXwx8g7Ys3tVcMJjG+ieMsD4vho1AHuMUkzTnEjzepWtbuwZ/BbARjPxo9DyBht/rn8+9XhIRWoib1fBaP3q+Nor48ASf8GoRXC2I14CI/ymsIMGDZGfePk1TlqEXU6d6RT/hr3PXr1P9RCwqZ9y2DqsMe66ib++iil2O/1RUdp70vDy7r+6MydtJr7tZomqfUon6Jy6XI3Bj4lJgJEfm2u+qROrIM6z4hMO3SEQkGJ7iW+5zHuZbXqK6+W6DDa1n+BB7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 07:51:22 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:51:22 +0000
Message-ID: <890a971a-49cc-46e9-83ee-7df6d892f65c@intel.com>
Date: Wed, 9 Sep 2026 10:51:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pxav3: use managed clock enablement
To: Rosen Penev <rosenp@gmail.com>, <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulfh@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Karel Balej <balejk@matfyz.cz>, =?UTF-8?Q?Duje_Mihanovi=C4=87?=
	<duje@dujemihanovic.xyz>
References: <20260901004243.50052-1-rosenp@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260901004243.50052-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL1PR11MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bd7b57-ade3-4e49-6f25-08df0e472455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DCjRiB8VHRznQZ1YTHRrvnv8FHWhASRG+wFYuwdRd4sbQQ0GD8qHjx+R2YNmG56fnmrv69Y+blOUHg0K/bQ9PkeFZ9cK/efSmdXomnDiXa6LqExmpXc9jKG4tfxHFdSouBwBEZSsM1KjAV5Fg8kV9CnNZpYPhhHM5e7XYB+ym5+sZ1oV0XZZ28I9VF4KlZ6EOOq+WVmeyPG/WhMrv5ofc3iFp27vMyqB/o4Gh9btQSA93LTf01AqWnjc5QqJNF/PHEYwtl+m1L/9w3JXhiiRpgmlM8YswmHYPVw2B3ZPc2E4s491d/jqlNsVKzM3J/fde+7h7PtTwMpOu/mPUEboalsbBPZ5jOYnYsPZvnJIJLVNxNYXXpbsPBZHcue9FP6NnfpGWyd5TGGPzR6DRB7cnlGvoCTibiJaAgNoJXIPVPs3PrG+rI94xZN3l6gsFiYBubaqzFafXFrVYhrfp2Z89GmbXu7BUMhufxy/vhLg7qJgFaGQk0qk14gXJJGpnzmGkkjM58hRWShe09Op4fN3Bt57k+cZ9nax9rhGX5JxBuHDakjlU49o/+/5VLT6mHu0LkoC+rWAJBxk5uLu3GfS8bXDi+KmzEA0iijdCEIft90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pGOW5KUE1BRksvakQ0dWc3RHREVW9yNlROTU01T1p2djYyRHVGTlczdU1M?=
 =?utf-8?B?KzQ5dXN2KzVqRVFQS0VxWUU3QnNvOW15U0d5YlBmTllnUHdCTnJQNzNUZEtv?=
 =?utf-8?B?RjFQWEIrT05KOWhiTkhIVzgyVEdiVWFIakVPSDFmYWluMGt2dUM4WFR2TFAv?=
 =?utf-8?B?VWRpLy9oYUJRdWpad1BTWlFsN2dOMEl3cmc1Zi85UnEvcmtVbUVHUEF3TVZS?=
 =?utf-8?B?bTl2dm84OFYwZTl2RTE0ZnRwTXNPSlAranBqdTN2ajBGdEd5bXZKbm1EN2J0?=
 =?utf-8?B?QXd6OTJLRlI0b0Y4YUFjVzJqajF5QjduU1NrRFJjNC9WYWYvdzJNaUJqd0Vy?=
 =?utf-8?B?MUpNYTFxcEJoTVNnK1JOdnlwcXlrbHY3R1J5dytxeWhpc0RtV2c1cjdKcjRm?=
 =?utf-8?B?bVJrWVQwVFdyUXBZNlZFaWdXQmdTMTlTbExVN3dVUndocTJadnkzaGEvTmUy?=
 =?utf-8?B?cGpjQk5ieEYyTjY1Sk1ScSt1ZE05N09pb2FwcmtOSGIzektwdUZ5Q3hFOE9G?=
 =?utf-8?B?N1NaNjlJSzVNUVdldTFkdFJERHU0ekFCSEt6Z3c4R1pTU3pKMzRIZ1JkcFRY?=
 =?utf-8?B?WjdwLyt3ZkY0SnBRUUZHdFJLN3RBenlZeE9JQWtrTmZNUGVLZDhFWFN1aU5K?=
 =?utf-8?B?Z2tNWkpjZlgySW5rZmJ5NmJqQnFaU2l3WFFUMzZHTVh5U2xWU0FrcnZyMFhy?=
 =?utf-8?B?dE4vSWczeGI5UkRLRzhCRTJIcXIxZUwzNlQyZTB5TmdDT3lNWEdXQUlKcXc1?=
 =?utf-8?B?UVAxOXd2TUE4di82amN3K09TU0dqRmV5Rnp1R0NpclA0aVVpdVFFNGNjNjN4?=
 =?utf-8?B?WGt2bWZQMll3b3N4dWhCZUp5ekxLbkhzRkgvdlA5eWswN1UwRmw2dTBqQjFT?=
 =?utf-8?B?TDBaYVdVZEl1UHpLSmcwUXVreDVjRTE4cC9SM1ZxNTlKSVUvdFI0SlRqak8x?=
 =?utf-8?B?amRsNDFQMFZQckJuRmJTRWtTWStjVEV5WEJuSlI5c0czd0wrSFFCRTFzRDFq?=
 =?utf-8?B?THpUL0xyNzdCUGJIWjB2aDJsVndSK2I1ZVJIOWkvWlBwNmh0VnVPMGNSZy93?=
 =?utf-8?B?Vmw1VGQ4aWg0d3VSTlE1NUU3Q0YrQytRSG5uTEtpY1lhQ200d3BwVkY2NFFM?=
 =?utf-8?B?eVBWZGczVk1YSWYxNlZjRlArdXJSZUF3S1k3SEg3SG04aVhQN2ZTMlBXK3Bz?=
 =?utf-8?B?WEtlbXg2dFFqTXFQNXBCS0NFQlZ4RjhnSlAvdVM4UnJRWGRjL2dFMlMzR0sx?=
 =?utf-8?B?NzlVc3NJZkhmdm5YYlQ1elgzMnBER3dIOHNvalY3N0FleTdMdzhqT1Q4NnFk?=
 =?utf-8?B?dGsrbFBKQk1TUTZFVGNoVnU3R1ZUVmNWcG5BRkpmM3FuYWtMeWJsMlRObk10?=
 =?utf-8?B?WWIyWEllRUZpU3o1SDNZb0EvcWt4V0lYTEZzaE55YTYvbXdBV0NnbjVNQjNw?=
 =?utf-8?B?NzNGUzl6WVQrZ3oyUDNqZjB3bDJ5MGxRVHk1c0kvUmhhUjBmeDJUblJuUDJm?=
 =?utf-8?B?WUtvelVUYk1kQXVHMElkbXJYS1RvYk40cHlpN21KaXZudkNicXpkKzc1MjVl?=
 =?utf-8?B?VkhYY3JSaHJtVGhYenhWMEpIUmRvWjFKbEpJZGpVb2N3RERrMzg3UTBKSEhF?=
 =?utf-8?B?NStrTVpXNnZJcEVrbjVMNzIrQit1L09OTWx3cWMrS2hOaTZpUU5kZGJjbVFo?=
 =?utf-8?B?aVpGUU9SVXB3L3JSYmo5NDlDQ2EzVzBiWVhCTyt1RC8xZUtKOWhnQWY4ZEFz?=
 =?utf-8?B?TXFoWEJRejg3VW02Zmg1c0tycWNmRHlVUzJJV0RhU1pZY1Z5SkQ1dEUxWmU0?=
 =?utf-8?B?U0ZzTXdYNytabWdQK1J5TDZKSWx2VXV4TFRUVzJkNHBKRG0yTjFRVVROdit6?=
 =?utf-8?B?VWpWdTB0SlJoR3BrSitXUHFIbGM4NlNGRElRMkVjM21vakRRMDlDcmVyaW1E?=
 =?utf-8?B?S0lPR3U2U3BIOFF1VnRlS0VzRTJ3OFIrN1FYTGdCR2tpc1VuR1Q4UG40dEVK?=
 =?utf-8?B?Smt4Q0ZKaEk5Q2JPS2wxZkZFS1FiRUJtRFhuTGNDLzBJVVBGQUZlK0t1Q0Zu?=
 =?utf-8?B?YkQ0ZGc3ak94KzVzY2lCSDRrQW9ZVnVTVlFXaEhXRlgwZnNiZE5Ma1dhblZD?=
 =?utf-8?B?cjc4a3crV01ZSlE1cTVBWDdIMm5ydTdwZHdNUkxJbktRczNhc3pqOFZnT3VV?=
 =?utf-8?B?NWZKNjVYSGpMQkNNTnYxUGVvR0JiRUI2am5jVUhRQmR6cjNPQ3A3MW5JYTNF?=
 =?utf-8?B?WTlmVmx1RjBGdGl2c3dZbmdqODN0RkNIVDgvSDZPM1FLdTM4RTJZUitHc0xY?=
 =?utf-8?B?SkJ2VHFnYmYySC90WEZndHp2QnVJdDY3YnpJRVBQNE5WQi9SR01IM29TTTVP?=
 =?utf-8?Q?oRw5gMLg+SwZ1Law=3D?=
X-Exchange-RoutingPolicyChecked: uGRuSqCNYVgtpQN3rxM+N+KvcvBpiaO97CkrTvLCJRJ0Qm59K9lk5QTVKsrH2/ncDy4OZtg3RH/nf2VsGgTblmrzEN1rzniq7dhHyjXG/SohFGjBJQ7wlQ+RloBlQJitnoLO7uzqKJ7TQn6j81ou8OnqyNzUmA4RJXZrKNTBjy6ptk0exGPdgv5mI10NM7+PGEFsMojOcKcjNuvV1mSDsOnCXNU1cpMfGmNxTN9KsUMbfP4g2xN8Z8pbIRn03FU6Nxi61q6LUizkqSNtNTS1BqU34XJlKzE9Qq2dh4v57kUMN/lhi++p8EYBa2TI3+azotJ8vJUrmRqd/D04QCLlpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bd7b57-ade3-4e49-6f25-08df0e472455
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:51:22.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1dwKSWKZ7V2wsYCMu6F9bsQZsz05A6nJi6TCobiAFnT9NTqcnlTedIrRNykA9sPzF8G4JO9qpsU1GLC/hf+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com

On 01/09/2026 03:42, Rosen Penev wrote:
> Replace devm_clk_get() plus clk_prepare_enable() with the managed
> variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
> The core clock becomes optional, which removes the IS_ERR() guards
> in runtime suspend/resume and lets devms unwind the clocks, so the
> manual clk_disable_unprepare() calls in the probe error paths and
> remove are dropped.
> 
> clk_prepare_enable() and friends are NULL safe, so no need to check if
> the optional clock is present.
> 
> Also handle failures of clk_prepare_enable() in runtime resume instead
> of ignoring them: a failed enable would leave controller register
> accesses hitting unclocked hardware. Bail out before resuming the host
> and unwind clk_io when enabling clk_core fails. This also drops the
> now unused pltfm_host variable from remove().
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 42 +++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index d082c4e21aa9..db9dfa92cb57 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -414,19 +414,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	pxa = sdhci_pltfm_priv(pltfm_host);
>  
> -	pxa->clk_io = devm_clk_get(dev, "io");
> +	pxa->clk_io = devm_clk_get_enabled(dev, "io");
>  	if (IS_ERR(pxa->clk_io))
> -		pxa->clk_io = devm_clk_get(dev, NULL);
> +		pxa->clk_io = devm_clk_get_enabled(dev, NULL);

Sashiko has a point about getting the wrong clock:

	https://sashiko.dev/#/patchset/20260901004243.50052-1-rosenp%40gmail.com?part=1

>  	if (IS_ERR(pxa->clk_io)) {
>  		dev_err(dev, "failed to get io clock\n");
>  		return PTR_ERR(pxa->clk_io);
>  	}
>  	pltfm_host->clk = pxa->clk_io;
> -	clk_prepare_enable(pxa->clk_io);
>  
> -	pxa->clk_core = devm_clk_get(dev, "core");
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_prepare_enable(pxa->clk_core);
> +	pxa->clk_core = devm_clk_get_optional_enabled(dev, "core");
> +	if (IS_ERR(pxa->clk_core))
> +		return PTR_ERR(pxa->clk_core);
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  	/* enable 1/8V DDR capable */
> @@ -435,17 +434,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>  		ret = armada_38x_quirks(pdev, host);
>  		if (ret < 0)
> -			goto err_mbus_win;
> +			return ret;
>  		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>  		if (ret < 0)
> -			goto err_mbus_win;
> +			return ret;
>  	}
>  
>  	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>  	if (match) {
>  		ret = mmc_of_parse(host->mmc);
>  		if (ret)
> -			goto err_of_parse;
> +			return ret;
>  		sdhci_get_of_property(pdev);
>  		pdata = pxav3_get_mmc_pdata(dev);
>  		pdev->dev.platform_data = pdata;
> @@ -500,27 +499,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  err_add_host:
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> -err_of_parse:
> -err_mbus_win:
> -	clk_disable_unprepare(pxa->clk_io);
> -	clk_disable_unprepare(pxa->clk_core);
>  	return ret;
>  }
>  
>  static void sdhci_pxav3_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  
>  	sdhci_remove_host(host, 1);
> -
> -	clk_disable_unprepare(pxa->clk_io);
> -	clk_disable_unprepare(pxa->clk_core);
>  }
>  
>  static int sdhci_pxav3_suspend(struct device *dev)
> @@ -561,8 +551,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>  		mmc_retune_needed(host->mmc);
>  
>  	clk_disable_unprepare(pxa->clk_io);
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_disable_unprepare(pxa->clk_core);
> +	clk_disable_unprepare(pxa->clk_core);
>  
>  	return 0;
>  }
> @@ -572,10 +561,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>  
> -	clk_prepare_enable(pxa->clk_io);
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_prepare_enable(pxa->clk_core);
> +	ret = clk_prepare_enable(pxa->clk_io);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pxa->clk_core);
> +	if (ret) {
> +		clk_disable_unprepare(pxa->clk_io);
> +		return ret;
> +	}
>  
>  	sdhci_runtime_resume_host(host, 0);
>  	return 0;

