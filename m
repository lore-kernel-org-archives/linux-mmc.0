Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E734CFC7;
	Tue, 24 Mar 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338388; cv=fail; b=BuZSIp47+Nl+zZfprGfEnkvoR66+Zhsxm/HWMc2QGEDgMGShBWzMu7zNTJVBbwsUySntwCyLidno95NXUTvrKFqEQcqnWrRSceGbpUeACXQSVFhDpIspQZzXmibf2OprdkCVUXP+JiK6jnAW0BtB0dee5tEr25dMsck5sKqIknA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338388; c=relaxed/simple;
	bh=WMrp7yWo2b2zLD+Z2P7FKVAtvjVkjpr7TKHF/K2iPPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHhWXV8+J5tVwxHaTmy3ZOhnq3n2kWjRPYc9O01J4I/h6HksOXsmGAO5uxpL3al76/NyYBQygNgpV/DsrmR591hkr6Fdd2KiACNNXvNVnuu0EwKA0VZssU4g/+onZwIxSS4Idn343frS/G6U5ee+Es/+nHdoPTN9oa4WoNcoJgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jo7B4fp6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jo7B4fp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774338378; x=1805874378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMrp7yWo2b2zLD+Z2P7FKVAtvjVkjpr7TKHF/K2iPPY=;
  b=jo7B4fp67lTMnZ0qysFbRoYKalztNf/A4ZDDMlJkj1TiqVM58nVp/vWv
   mfx1UeFymi4ZnWDuD2neV6XoPgukFoQMFaSnPSRzgT1hC9HmVz1dsmRI2
   0KFPKhB2z2cER1xyTan5JbkLn13zEFU5hK8tPuixLD5qydYFNHr4uO9cD
   THeatifiU3JpOvQw8iqHZzRJ1hnsqTTHebXDOahQSCF5UyqYqqxHrS2U5
   HhB/F1+d5M0pGlvOTG2lJYZSEFCDtPNXtQa3kkZpXmvO1FuymiQzegcJY
   EvZ0P31gqFm05G92Am8hmfivdN1sNl2be7K+U7UvqEaaPidfPx763SdJK
   g==;
X-CSE-ConnectionGUID: 2ItyARrpRb+BCgiJKR3mig==
X-CSE-MsgGUID: rOS1JT5ZQnS6kpCCOSvSLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75228224"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75228224"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:46:16 -0700
X-CSE-ConnectionGUID: kpER+ZUHQvOkVencvUprWQ==
X-CSE-MsgGUID: ggiBvS+bQEerlg3FLxttCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223492703"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:46:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:46:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:46:16 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:46:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezk0qcWQfrXgoMKaBe/LJTcNZtVfB/+hd659+S6Z+YmUS0FOYR3hPuCDDOcYTCxgyQrE+Go5cQmzAzGZ7LGphkYy8+Wp7+bSneHNeffmXbTq9y6H+Fe2ShISQ9XInP2c7so3ZVsUvpjx68bf2NSVPxeUAZXDfjpHE1y7LJHrYE/062Jb6ZRN6FYvC/9k6Pt4rxhEc4xzgFlPC3oB0VKpIhIjNiWPZYDUoPc7/EWMsa2dmqQ/GaIpWUV5RnXYWMAE3iOfK25GDMIxhMhFkMH1YpSe7tMKogRkixraLJdR/7MuVzvskTy25ohFj+A3RvJ0Q/nW38VNEj+8WzyBnMRUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcwEVjjO7xuIYhgbKZzYe1EcMex837KeHk6KcIwRX1U=;
 b=nOrU8FU2ZzS8+Mt4ZTzg8Mlwn81IWVr/9lNePZHlY+15m1SIXdIoq6tBqMAC8u6EAoNVla9TCL+MJst67zTueiC1Fr0ULa2MIqe2jpqQCF4aXN7VOsHjBBgakyCkNYheP2oZzjykN62iC/NN4+UZoNZbQddeaCzlCn3Siu2GfVsOCZYHJW86T00JjpHVxw3Ja95MjbPxT8gbEpuXpqLjQbk+wxRo7EoOvkI9+fRKfdjH6tqNsyfO3VL9n0QNnvV6+qb8/e6pbjvz/I9Gy/xEz4xqWZ1taJuwXCqIMQZKf90wMQrC8949AE1nnOltiMmBA3L6cxYLahlssRi/FJCbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:46:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 07:46:11 +0000
Message-ID: <00bf0bb1-f769-4102-aa1b-e2804e62ccb3@intel.com>
Date: Tue, 24 Mar 2026 09:46:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Anand Moon
	<linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
 <20260323-orangepi-sd-card-uhs-v4-2-567c9775fd0e@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-2-567c9775fd0e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::35) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b657516-b8a8-43bd-4af5-08de89796b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|18002099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: tDZEntDjRMc9uMX6eKvYPKvcqma0jFWoBIxFGP56ccsvMD6YfkEjHg6U4v1k+pyJ4lwRRZZsnlRD99Dhe0qgM59yHyNquaudCHj2GxbqYZ3tvqZoBqUchzYrOYPxwm/tGpmB6GvIk6cwO2JAWwgmDivN6r4u74GCbjkH//kEELgcEDxnpN7ch8RgfP4mVAJCGwQRTqhYHIyE6DFfQ/jmBoO982hxbAw7epS3H3FRX6gi9eDj/vTRB6q5Tm09MrFqJgk3RYd9rvf5CmYrwn5ijO+qawwR1vhOnaof6aErO8QjwYJtc35ZfwESMWX+v6F1/z8Kag3za84g5kfEd6IlWCWnzYAU7sJYyRga8YhdnwjrLwn7tCgrvQt7mkttDo9HMTOkkEACIbrC7FUrwT1FcqZD3zzfrTXXiJzVS6FmPkUGBCG+g+951ip/1XlU8t8zzWMXr+DlILZXyyQEimUPYuAYsgLOaMba5RVHN0sdndxSUyLfuHZfDIr46UZGBT+VNB2Ps+TpO2jNBE98DMC7wQ4+uhWrW4G5WD0GYF04Go6pAS2UgKYiHfg3vU7ybWXGHwJoe9Fk3Q/fcc9PSmgzPRJD7pph8pN2hr/UeprhXDnJ9A6BwEnUwCQSNGDE2+ouYLQUVabmmTql+1NoeQPeRP5nKLFqHtgVU0I7GwI5sY3iC0Yua6LL+/9rH9N+5lG6QwKoHtuShjQ/q//rgmhgRrbgH7L0CJh2Lqe/QIEEIs+KCtv5UCpwTVPAWJfjezV0C9bKcCRD011E5wJejJJduQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(18002099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlMRnVsTHQvR1crMXZmNGQ3d3pNV2hwV2tCSEVXQkdIM3IwbS9aWjI3TExq?=
 =?utf-8?B?Q245QTFZc0k1LyswR2ZSQWoyeS9wd2UyTVBEbVpFRVcwTSt1NmtRTFJJQURt?=
 =?utf-8?B?VVJzUUVkbjJMOGpWRW91QkJpaGhraDZaUFhoN0lSd3FMMkhYNVhkVTdhU2hz?=
 =?utf-8?B?Nmd3anBCUWpjYVZ6ZEJxallBRjY4TGdOUW1tWUNyVG44VlQ1MThwWnF2NEFK?=
 =?utf-8?B?UGRPMUI1UWJMNTNxRXdYRzZzWFdCdjJ4T3FyY3N2YmRkMDNEUys0N2d3ZHlp?=
 =?utf-8?B?b051WExCOTJYZ1JxVXN6eHRsZ1JFRTYzOWhRY0dDTlhMaEN2NHJxdmNVRDV4?=
 =?utf-8?B?REw0U0NGeENqTUhiSGRsVWFKQ3VWanU2eVRpZnI2VWVqMTVTb1V1WG9sVkI1?=
 =?utf-8?B?ZEVGMCt1eS9NS2tuRytPY0ppaWdoTnY0ZEpCQS9ncmdzeGVpVFVieVl0QmEv?=
 =?utf-8?B?T2dURGQwUUx0b0VpSjZWNzNrYlR1aGZIeDRldDVJVWl3cmRDaUZvdXlRV1Vu?=
 =?utf-8?B?UklYcmNDZU9aMEtydldtbWFqcHJzdzhxeW9VdEFpMm9vZDArUFB2WjZUZHFC?=
 =?utf-8?B?VjZiOUVBbHdwRmRLMlI0dERqLzJLcmkxb0syc1hETXlVVndTVGVJemMxc1Zo?=
 =?utf-8?B?ekFNMlQ2MU8rSG40aHplbWYrNzlYejVDc241NnhPS014YTdwSE1TUVBRZTNs?=
 =?utf-8?B?d0pVSlAzNTlTUnJqVXhpcGxwbHE1N0tMbTFWSmNBOEdqd1VNZEhXaEZ1MUpq?=
 =?utf-8?B?Y21kdVJ2L2FCelJrcVY0UGYrUlFhMkpXMDNOdEFBK1RQd3BZQVF5ZENOTDVM?=
 =?utf-8?B?R2drc3U0VzRPVllrdjd0dVJHclo3TGJZR1k0VHNyOC9SRTVianBEWUc0Ny9Z?=
 =?utf-8?B?T3RJS2pCdlAzdzlQK0JDV0REL3lqYitDRkRCS3VKeGFCYVg5SUlramFTTTJM?=
 =?utf-8?B?UjNjWmQzZFRMN2FZU0RYbU51cnZEeTUxdTRtcm10K0ZFN1QwMnViSldUY2tY?=
 =?utf-8?B?QXZjTlZUWk1seUJNRklVN0YyM0NlTDNFcnB0dFAyZDdMOGRUWnI4WVVCZGsr?=
 =?utf-8?B?aG9DVGtveTc5cThnY1RWem8zUnBScjNrNWQ4bjN3WVcxcTdXTm9kT2pvSHNx?=
 =?utf-8?B?aEVvdVNPWXV1L1FMNkFXT2Jhcyt4T0FiS0srTW44Z1l6OTFpNC9NY2ViMnY2?=
 =?utf-8?B?WnNWWHkvckYzTXl3UDRBdnZPVnBpNHBQNEtvOTNOSG9mQWtyaFNpR3FsdUVx?=
 =?utf-8?B?NUlwZDFHUUZHNXhvRVVsVGJiTXREWEFaVUNOdUxURzVwSDkxV0xEUHduczc3?=
 =?utf-8?B?cFZ5ZUZRZlJXTDRNbXZ5U3ZtK0tKZDJXK0EvcjVHWmExaFh0OFAvY005T1o1?=
 =?utf-8?B?ZExJbDREMlRpbUJpY0FieFpQbzA4NTZQTzJ6Vng2NXpqcFdUYnFGNHVFK2h4?=
 =?utf-8?B?U2twVGl0ZEExcmxQb3MzMThRMi9peWxjaHBOT1BQcC94QlYxUTN4R3lVZGky?=
 =?utf-8?B?cGlKSTRZZXhwT0kzNEFBKzgyODFYQzBDUWF5OGx1VTBlN2JPZG9mcGRYWExM?=
 =?utf-8?B?UzdrUHBHMVBKa2ozcVBrQVV0RjNpSnlFWHoyTVE0VFVKT3hHS21IUGdhVVlh?=
 =?utf-8?B?T2NwMXlhWjh0UlJ6bUhtMjl6SWFWYmh1V0UxUE5LNjBsWUM4eFBNRWpKNWlv?=
 =?utf-8?B?MnBsYjZGM1RiOFlZcGZkYnVqVGI3V09WMjNTak5HZDNnUUdPaElFWXI3b000?=
 =?utf-8?B?a2NYUGFkU1NHbkFHOUc3OXQxRUF3ME1EYTlKcnVsd21HTnZoeldobDc5QklG?=
 =?utf-8?B?SnlwRjFqTytJSnpjVkpzTS9FUWEyeXFFSFRUdGNXaGhyUUJTdk9Vby9PNHc2?=
 =?utf-8?B?eUkwUWZnY2FGMm8wRlV6V0dvNG95d1FTRnQzdFpmd3ZuczJWZUlIdm5LZnQv?=
 =?utf-8?B?SkExcDBiaEc2SXo0cE03UXdYbU9UTDdoVTgxalZlL3BTM2h1Vis5M1NPdjhK?=
 =?utf-8?B?ZEY4S1dBc3JDWGdoNi8xREc3L0FXT0k4V3pWeDROUVBnRksrbE9tRXFybU81?=
 =?utf-8?B?cmVyMFdMYndKT09PNlhMMi9BYmM0blNmWVp3dzBDbXhRY2FZODZGVzBBRUhr?=
 =?utf-8?B?aENoS2RoMWNYTjk5MlkwYmkyaDJ6MGx6RWhKeEQ1OTVQckFZSU52SWprakds?=
 =?utf-8?B?M3ZXZ3R0T21jWmlHZ1ZCSXU0Yi84dFV5dzNTTExiRk9weEU3WVlPOXVzWWMv?=
 =?utf-8?B?ZTJzNVlRSE55ZGtyK0tiZ0k5MEJraVNodmEvWFY0SjZYZ2JSQVJBZzM0TWo0?=
 =?utf-8?B?akticDdXTThJUWRRYUNEY0d2c2N6S0xDN1RNNFVGRTVpYjZHOFhhVVhzVHdk?=
 =?utf-8?Q?6mvulqKpSpUk7ei8=3D?=
X-Exchange-RoutingPolicyChecked: uHXWIsDRbKPzd2sKUJP3SIdPAgksnVDyksF7n2JpGXKA3royldQQrzdcB/86/njKeDeooXASWg8XpHIt1WtcxxUB/uCio7FFatfAFCvX5pasan+b+zRolSH3vXMq/WEHRFnHuClESLaU4JzvtwVWzsTZQAUnAM6sIhWc38IRRXu4F6JN9p8YPuULd2vrwvBRNNA0fSDWI+yu+KvtqEbWjS7m7/OiFURqz0xdrdhvMQgxXk+kmkelMTD2IeQ7NBSW0BPXfywVWjDgbKYPtsmZm0hlpZTD2ldbl57D8EUxiO4lSrxA+ZNoGgLpssk5oksNkj44hE7oFRyXklcEdFm+zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b657516-b8a8-43bd-4af5-08de89796b07
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 07:46:11.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD3giygGinFSSpzfyfzNNpxLdeo+LfSu1bE4MqR8ej9hLSS3NZ/2q3K+Dhf+osd5JqATvHp6G0zNp3YLjLel0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com

On 23/03/2026 12:19, Iker Pedrosa wrote:
> Add voltage switching infrastructure for UHS-I modes by integrating both
> regulator framework (for supply voltage control) and pinctrl state
> switching (for pin drive strength optimization).
> 
> - Add regulator supply parsing and voltage switching callback
> - Add optional pinctrl state switching between "default" (3.3V) and
>   "state_uhs" (1.8V) configurations
> - Enable coordinated voltage and pin configuration changes for UHS modes
> 
> This provides complete voltage switching support while maintaining
> backward compatibility when pinctrl states are not defined.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770..234e258af25996e7bbcd0b70366c7480bf62bee7 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/reset.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  #include "sdhci.h"
> @@ -71,6 +72,9 @@
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
>  	struct clk *clk_io;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_default;
> +	struct pinctrl_state *pinctrl_uhs;
>  };
>  
>  /* All helper functions will update clr/set while preserve rest bits */
> @@ -219,6 +223,46 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
>  			       SPACEMIT_SDHC_PHY_CTRL_REG);
>  }
>  
> +static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +						      struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +	struct pinctrl_state *state;
> +	int ret;
> +
> +	ret = sdhci_start_signal_voltage_switch(mmc, ios);
> +	if (ret)
> +		return ret;
> +
> +	if (!sdhst->pinctrl)
> +		return 0;
> +
> +	/* Select appropriate pinctrl state based on signal voltage */
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		state = sdhst->pinctrl_default;
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		state = sdhst->pinctrl_uhs;
> +		break;
> +	default:
> +		dev_warn(mmc_dev(mmc), "unsupported voltage %d\n", ios->signal_voltage);
> +		return 0;
> +	}
> +
> +	ret = pinctrl_select_state(sdhst->pinctrl, state);
> +	if (ret) {
> +		dev_warn(mmc_dev(mmc), "failed to select pinctrl state: %d\n", ret);
> +		return 0;
> +	}
> +	dev_dbg(mmc_dev(mmc), "switched to %s pinctrl state\n",
> +		ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 ? "UHS" : "default");
> +
> +	return 0;
> +}
> +
>  static inline int spacemit_sdhci_get_clocks(struct device *dev,
>  					    struct sdhci_pltfm_host *pltfm_host)
>  {
> @@ -252,6 +296,30 @@ static inline int spacemit_sdhci_get_resets(struct device *dev)
>  	return 0;
>  }
>  
> +static inline void spacemit_sdhci_get_pins(struct device *dev,
> +					   struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhst->pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(sdhst->pinctrl)) {
> +		sdhst->pinctrl = NULL;
> +		dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
> +		return;
> +	}
> +
> +	sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
> +	if (IS_ERR(sdhst->pinctrl_default))
> +		sdhst->pinctrl_default = NULL;
> +
> +	sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
> +	if (IS_ERR(sdhst->pinctrl_uhs))
> +		sdhst->pinctrl_uhs = NULL;
> +
> +	dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
> +		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
> +}
> +
>  static const struct sdhci_ops spacemit_sdhci_ops = {
>  	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
>  	.reset			= spacemit_sdhci_reset,
> @@ -324,6 +392,10 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> +	spacemit_sdhci_get_pins(dev, pltfm_host);
> +
> +	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
> +
>  	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
>  		goto err_pltfm;
> 

