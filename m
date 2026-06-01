Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25363CF66E
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325714; cv=fail; b=qb+YR8cEGmKeZYLdlHbFuCtuJz3mG0cnOShhYkRkkvUNqhzPeIY1oSDMDYRcA5QmSgcXPKIbdByaJe6q/P3wvdmWX6CrLj4VK4tu7jY+QjMQPrDYIf/ugyoEIVi3MsgaGAAl48HhgF/h39ro51hWoz1uwgKNKGSebxs9j6XrPD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325714; c=relaxed/simple;
	bh=qk9m47EYE0bcPZ3X9ObtoOMAkSDtnoeoUXyvviSbOok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uY4OyYwUgPceDezrTBQEglGDgnLu432MvuOcYx8ja+jClT3whqiUmDou0pPhpP26ytGz53iQbunqnBFopYB32WOm1tGtl+fpc9E72N8oJQuDScEOarpVSzK1uB3osWXXzIs4V0DzSKASJ4WnIjLYe8syH569iqALFG8tOXOanU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J45PMLZq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J45PMLZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780325712; x=1811861712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qk9m47EYE0bcPZ3X9ObtoOMAkSDtnoeoUXyvviSbOok=;
  b=J45PMLZqhzaCqojlDsP8W6LPepXhgFPqf38K7k6qCfkpih1JVJQ36hH2
   W+77KyR/V28hY+o2abkrv69/kkupOAt2N282l+nSe4VdwlcpUhlq3tHoR
   xFKHyRmORDYN3rL1NVZ4cL+IkOUHN7977PI0HVCBUqi1kJAI9HW8kSWln
   IYaGvdUmvQJlj1m7HhV8ygTbXm/3/WmB085sKZAjkLnfGRW/zIq2FTurB
   Abyr9uTuftPSkUpBDoIqEfOSxK6HT+yL4m4sqlDzWrajT8bxGcYdszwyC
   B5wz5ZWdmYHzorX5d08tObQDAnxFM5PVzIxVDpG/8I1R3RJRsTq0UTF+I
   Q==;
X-CSE-ConnectionGUID: 7A54Y/dCS8uMoMDFSS1BOg==
X-CSE-MsgGUID: vdxxPQHeSfuWyqICstxztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84972863"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84972863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 07:55:11 -0700
X-CSE-ConnectionGUID: yMsL5rtGQGyIPuASyadTZA==
X-CSE-MsgGUID: BukUGECcShu5wUuclEGhsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247555983"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 07:55:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 07:55:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 07:55:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 07:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH8D7J6/cL2yZ0K1gpWkp16tyAmjkKQDxEBW9mkNtraEme+GlKyh+VNMmRWmCkKEnIngLWXCSf+VziZsxQVQgbUglEocYa24RP25CagIi4ZQdx1PfgmbJ4y4tb+RL4GL0e71Mm628f2AiDKFhsQ8kYOZ9iDseDCzLK3FvyGd0rmXZ3GlwgGgx/jN35nxJQh7MECc4epJgbWAcLTH5XrD0Q86bm8zB/+SfAZdBFIGMUT9A/5RmZB0tUD0cyPlZCyewbGAA4uWnZCTnNNAzzXJ7RzmC/cD02PsJt7LbdIfmpSxs2XTe1K84NhsM3YGUjbqZyaaaK70Wrc3C2WaizY0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLAQ974MjK4dVUr1jxPeBF+XPiaV5Dj1Pi9AsaEAOxI=;
 b=GF1mrxY53Jgw7+JjBpYAAiwkOxm9jvcqVhvxZmcaJ6bVHfZGQWFTpt2z9OHNw2Fw9s+La1psl9Ga144vpBUUm2rOTWiMY1EdbkGj4T0Wnqdxo92jRAQ9If6rkXzG8MIk5CSDogMXpLAu8j0a8vD8Tci/Hqv0c0w+8/DaztPMJXh2nsrPeT0qW3znkloDB0Eu1nQzkGp0xkrD/9IHBfhU0G7EjEo0aDukMIsYsVadKeUFlcJOpFNYWKQRg7ZpP/8SOdX0EGQoM8N7DmyBiea26UHnrGioLGEvPXSy/nKUyUIyqk4RT67wCmvFiqYVg/plyqgqwJ/vmM08MuAy1rKOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH3PPF7A88A980A.namprd11.prod.outlook.com (2603:10b6:518:1::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:55:05 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 14:55:05 +0000
Message-ID: <ed075232-69a9-4f93-95d9-0e2a815a041b@intel.com>
Date: Mon, 1 Jun 2026 17:55:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the probe() method
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <dd3aa530-d06f-4733-ba5a-ccc95d8fa91a@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH3PPF7A88A980A:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f9b755-1198-4ccd-4385-08debfedc44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zuuQ5yGdqr65/kq2P3tYz5yJmR5hYTMLIacuWhyQ4eaJ9ICnOrzK8fgrq/9spJQaIgmgGVuhERrDt5zeq8P40f2PTXZ+lUEkDNJMECTFI57y8tn39a+VBfxuIftA/yGKLfVGHuCmOIEcyN1wGVnOwmzogXp7uvYXVRPxz5Rqu9j/ik97qT0VtJhI6eZxa35ZKeSx7iwPiAOObYgFgot4wf9RzMbhIhbg+CES9X4RaNpG+Rzx0eediH0cFm7huc+mtUC1E3rGbac2A0r8UioSs1PSu+VUbo43AC5xDhc8+dNBj9iKLDWTA5PuMM0BvbiuwKUvPjh8aW0BNcVpvdLvvu5rVdXfbIjvrz9s6j/IkKMhxCKEcXLsvYeMxN+LSWfdbnDT/d5iImwO/zWbkS974I0enlUXlWLrnYd71W0IzUAquyd9TP5KwUsuAEUMp04FUpB9H5rmww6dBY8jR3ASqGq3Y29eiXQFhIu/4gac6un+a9ZS6rqsrjbDx4ELxk9HEmJC3OzdA8Oy88aH8GVPahkd0Idm+W2VONzV+tgs0p6JSbSZhFmDDrbrJ1xcLFvw6+haO0XVO+sRv7TH5/LIVocUiO2hrwKWahSAC/mi09piX1u4mcvq/hlAfqXkdM+ybboD8nag7cW1EPa3pgDjPEqGLdhoTLI94mjM4HD6BIbEpbC0qRA3eYOXOBxoFyqO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhGQlFtOWZsWkRYeDZ1V3ZENThRdmwwN1lPQnBpU1ZPek9xU0VscDg0RCth?=
 =?utf-8?B?SEpKRlNJTFIyYlZmZ3R4d3NMZDYwN21VZDhUZUpiVkorbnFIUlA1Q2tDOUFa?=
 =?utf-8?B?RWRhWnN6TGNNaFpVR3BXekJ4U29lTkp1cWl1M2RnV0l2VXd0NUlkejFSSTlT?=
 =?utf-8?B?S3ZSYkxRRmp6YjZWQkxhQUF3RnJHVTZJeUVlSEFaTVhSMVdwb2MzSWZDTjJo?=
 =?utf-8?B?UnAwZVVEZkFxMGZKTk81ZGxYc3BHbnRoRWwycEtHTk9pQmxFSGhyK2hTdlVr?=
 =?utf-8?B?UyswSWtqc2xGMXNxTmRPR0dXbm9lT2xDQ3h6RGtzaXVwSUlNYzBtem14dE5Q?=
 =?utf-8?B?dEVuRWtOSlJqOWJ1cFQ2QzlvNFJNcDN2amR6cXA5a2JxeWlwYnBCN3pnRlFL?=
 =?utf-8?B?QW1oSW54UGdIVCtvRG1BOTJXeXpwcTlBcC91ME1hd2VtVVZiZ3JNQU1uVjc1?=
 =?utf-8?B?VHJvRjVkUUQ1MGNkME84VHRVUW5MTnkrMWtlWXQvc2VqN1BVSXZoZmpnSytC?=
 =?utf-8?B?T0t5N1I4TnQ1TFpycE1xcmhkTGIvd0FWWTVkWm5YaTliYUI4OUloTWhLT3Nx?=
 =?utf-8?B?K2lKdlo5M3FobEk3OFJZODN0YlA3bWVxSllnU3R5QlVGTkhHWDh5czc5eUQ4?=
 =?utf-8?B?TDhMcmJvSHBBU0g2cFB4M3pBaCt2TmtZbVQ3U1AxYnNMeWpFaHVQRTl6UXhO?=
 =?utf-8?B?TmVtUkZic2prc3JFMDBodWJtTVAzcmRwUGdlUCtlRjNJWGtWKzdVWkRIQkdw?=
 =?utf-8?B?U3hXbUMvOGo4aU1LOXJuenVRd3UyWUlMaHllTW9DNWFKSklBSjVsbUtpT09o?=
 =?utf-8?B?WUV0NVE5ZnMxeTRVeE1LOG8vdmI3LzRNaU9wbUt3eU1FNDZFa3paVlh6eHda?=
 =?utf-8?B?VXBsRGgyTHlhQTl1VEdGZ2lsZWRwZ2FCaDVUU0ROYnN2eUZwZW9TZVBMMDRK?=
 =?utf-8?B?OTBpTG9FTWlxTnZJSUFzSHJFMDVVN0pYLzlhWFJnQXpiejY4Zmt1QmdmWHlq?=
 =?utf-8?B?YmNFcWxaN3F0enBEeVhNT0RSdmlSejBGaC9RWkFPTlE2WTNHZE5MTTFGOWM1?=
 =?utf-8?B?cklocUJFUFpCVWtxZVIzc0loSFR1eGlhV0djcEdUVkI2ZnROQzRENEp4ajE4?=
 =?utf-8?B?cVZkSzIvQ0xRUTU0bnBaSXJDYkluUi9jbEJDR2FpMm1iSlNHZVQ1aXVEVFlo?=
 =?utf-8?B?TDRYVW1WalAwcDIvYjBqSzJsK1dGT21TRTR2K0xUQm5QUVBhbEYxSTFRMWty?=
 =?utf-8?B?U2FVYktWeTNMbGM3cjhKMDh0WldXNDFPWGpkTXYyNVkrbStPV2J0VWJvbW1i?=
 =?utf-8?B?T29Xbzc4RDlMY2ZUNGo3a09SNlFqa3hRNTlOc0kxYVlXZHVXaHgzUkdqQk5I?=
 =?utf-8?B?OXdNRUc0THA2RFNoMnhmM3dMUCtnSFpYaEx6ZlZpblpDanNUZlBrcmtVaHhZ?=
 =?utf-8?B?OTh0Q3Q2dGdXamg1YUpTVGJ4K2FyY2hiaEJQRTc5emkyNHd4QTdVWkhmZm9L?=
 =?utf-8?B?cmhsRXZVTUloQjNGWDZGQlFvelZJT3pkUEVmSE9ldGRQVEhETFBuTG95TnNu?=
 =?utf-8?B?TU0zZnBtWU5NUTdxYjF2VnFtbmZNVmpzdmhYQWtwUEVVZDJ5Z3NMTE9QaVZ1?=
 =?utf-8?B?OUxqMmpxR0tNZUh6RDdYMndyR2grVUo5ZlNFR05WU0trL0pXUHVsSjQvVTd4?=
 =?utf-8?B?OXIzeDl2Q2g4QnZCOGxsM3FVK0JYU2hVZnVQVmRGS3pCQ0hzczVRazZ6YnpC?=
 =?utf-8?B?VFhzM1p5Zzc4aUtOZFl5SWEzalYxQXFlZWRyS25jOUZJU2VzTWdOYzdaWlN3?=
 =?utf-8?B?Q1U0UFJ6d0s1MjVDV01VbXFNL0VnMndKa0RSWWVvM1lNYlFPN2RhNEIyWlg2?=
 =?utf-8?B?WFVTTlBaRTV5TzhRdE1UNVBwK0d3VmJNdkVnZkRHNXUvbGZtaUlZQk5TOWYz?=
 =?utf-8?B?T2VyU0xFcUpTZmJ0Qmx0MnhoOHUzTEpOdzBpWVJRMXZtcERFQ1hCS0pWZ0lK?=
 =?utf-8?B?UVVPWlIyREQzLzBJN1F0UkRjOXRBUDhLOWFzMVhxN092MTJETEw0THUySUdx?=
 =?utf-8?B?K1VyazkyV2NNWmpGejkwUXB4MkphZkpkVWR1Qzl3Y1BTOVhZQjZGOFMxTnh2?=
 =?utf-8?B?cHpEVUNtYXBaTEIvME5ZWXVVTkZmNlRiQXBCa29TejE2dHdIQkI1QlNGZk1m?=
 =?utf-8?B?R2dqbUN6SWxhZnU2VWVESVE3TWJzVEFNbyswaUxoV3NxMWI0MWVTQXh2bTQ5?=
 =?utf-8?B?MEJqQ2d3L2ZSNGczbHhqbSthaFVYUngrMWxYdWRJU05rbjhqUDR5MU1JbkxT?=
 =?utf-8?B?ZGl2VXM0RjBweXBwWFVyNXVpeStuWTFIMWFyNWRBSk1KR1g1c1NpMXdLOXFR?=
 =?utf-8?Q?qUlynmYRq5Uacmis=3D?=
X-Exchange-RoutingPolicyChecked: XbgZr1gsM9OAfWAMjovNw9KJYxEGxQNZlT53jcB7egqGYhZtCDmvAvGqIYU1z4fc6d6/fVHW/ROjmQT1nXdTRwnw+eXE13d4Yn5DlgNc5LU51RmK/yO4uoXMozTcbkXcm/6hIRlUoXLrAED7wZudKQ8eMxcOpaT/hPUfO6dizY+7K4TMmVHbkk9nLMsng5M0BrbH6KPzwJDrTwg83u2xD478mQkYFtj3ZSDlFC8xEQXpUgzIw6WEkAWdE78zVeN8/zQoxp6nTknW8fmuzgXC0ZXfsLPCN54pSlr/ZiGwZNpmRCVKLSwCURthDfyzwDpWLdJ5kuG+6eMyKvtrreqsBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f9b755-1198-4ccd-4385-08debfedc44a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:55:05.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIR3S2ZhgdySEtQ0+Tk2ZEdfOypINQAvrKYXrV9rfoepZLIMCQvqeR/QbolSwuCZTJhMsLSxaJPKFSqJuRegAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7A88A980A
X-OriginatorOrg: intel.com

On 01/06/2026 17:49, Sergey Shtylyov wrote:
> In the driver's probe() method, clk_disable_unprepare() for the bus clock
> is called on the error path even if the prior clk_prepare_enable() call has
> failed (and the same thing happens in the remove() method as well) -- that
> would cause the prepare/enable counter imbalance.  Also, the same problem
> can happen in the driver's suspend() method; note that the resume() method
> does check the clk_prepare_enable()'s result -- let's be consistent and do
> that in probe() method as well.  BTW, I don't know for sure what does the
> bus clock control -- if it affects the register accesses, the driver will
> likely cause (e.g. on ARM) a kernel oops if it fails to prepare/enable the
> bus clock in the probe() method...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Try to remember to add tags from previous submissions, like:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> This patch is against the fixes branch of Ulf Hansson's mmc.git repo.
> 
> Changes in version 3:
> - dropped stray comma in the subject;
> - dropped unneeded word in the description.
> 
> Changes in version 2:
> - mentioned the problem in the remove() method as well, somewhat rephrased
>   the patch description.
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index b9ecd91f44ad..29af07561a86 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2441,13 +2441,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			return err;
>  
>  		priv->bus_clk = devm_clk_get(dev, "bus");
> -		if (!IS_ERR(priv->bus_clk))
> -			clk_prepare_enable(priv->bus_clk);
> +		if (!IS_ERR(priv->bus_clk)) {
> +			err = clk_prepare_enable(priv->bus_clk);
> +			if (err)
> +				goto err_clk;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
> -		goto err_clk;
> +		goto err_bus_clk;
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -2461,7 +2464,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (pltfm_data->init) {
>  		err = pltfm_data->init(&pdev->dev, host, priv);
>  		if (err)
> -			goto err_clk;
> +			goto err_bus_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI
> @@ -2507,9 +2510,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_rpm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> +err_bus_clk:
> +	clk_disable_unprepare(priv->bus_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> -	clk_disable_unprepare(priv->bus_clk);
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  	return err;
>  }

