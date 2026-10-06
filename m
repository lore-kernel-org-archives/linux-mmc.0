Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B342A173;
	Tue,  6 Oct 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290764; cv=fail; b=t9hCZ5BljJXmGgyiHVYaJdshixTV1rrgepbYRZV1CSNk0SY/7ccopHRVKYItENSNqqmp+S3dEsZyIBWUD63EpGrYtt/IORdSLxl6nVADPAF/HodvfygEue8kitkopN5/Eem0M4bOlXpsS5ul2am0e7G2Umvl2o2npLVytXDO+U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290764; c=relaxed/simple;
	bh=e81VnYjLfhg5l8+lG3VYTfr8GULMdDEz2XISbvysTqY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDvbjlVVNceOgrnbxq7cy/tcSQ7byIue1N85WoZAkaDcjo+8f4KeYHhA2GtuW/eXrFqjgKm/OkXMNA6ZYTeSZE66yWw61qDABqc3UZmSfQDfZfq5CHF9RK9u38/t8aAp4DqaD7anCax1lNBDAoaChx5CIj85YEDo+zAhb+qgvsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixxtkG+V; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixxtkG+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791290759; x=1822826759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e81VnYjLfhg5l8+lG3VYTfr8GULMdDEz2XISbvysTqY=;
  b=ixxtkG+VA4+IeaCuDzVYXT07xDovCpFxOsYXyBgk+MLD6T5koP46k5jA
   H7DA9ohmtWIR+uSpvO6iFmPwJKzKmpIjIZ8i0+xeusTSlqATTIBfemWEZ
   pg56bMn/PI59bqAvGGD1qz0C9ywi0O3O67OAwY6TM9xlSGCVXxYKq1ory
   fufgPuO+q9aQK5ocySpCmrA2U5o2XIFPaYNRF4NxpiGQCED/hsf/+SG6o
   Bbvw3BosZfoLsXJ8byrAK60dhI61B/huJwQlBigcXqjBKxLA9C5DY9opa
   3+TbrEvUPlFTmetm3ClBjFHKehgDt679O0BGg6TqgFwUhFg9B9k0UK7Si
   Q==;
X-CSE-ConnectionGUID: LSgucJ5OTE2ScO8Q9u8c9A==
X-CSE-MsgGUID: fc6NH6DDTA2yWyuhUcP0uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="95796003"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="95796003"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 05:45:49 -0700
X-CSE-ConnectionGUID: YB9iq+L6Q/mzS7V4KHl61Q==
X-CSE-MsgGUID: w3EOe/vQSbWCSLyf9NSb4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="273511601"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 05:45:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 05:45:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 05:45:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 05:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2OMMp/tLfXAhRL6uCc527fZzFWRr421OFqBZoYSMwSHohnL5+LSdi0gASHFICNa+V+5ihe7m4JwwN+K0bmqChfCa2budUV8WWrspySj431R8/acyFvXf0uulfe05296v9fQFIIsYgc5se/cCbxkU15XMUzwOhRquC+ynVKF3+yzLD5tT5qAxZ5Ku9ywN/DVJoAZX61mH1qwtrJghQUXGuh8OqNGw8wJ78JcnymAt+Xhn+H0zn1QC6DhxHkvTlmRRP1sYbALLSrssZ0AGWsQp7OG3JBk9jHRpTxQ5TalncBp7igGxSkzmCStrsPgKron/D0lA4EgCiGxsjKNAlfx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLlGQe/P/yaig2J2UwNHBNRAqESH0quzb1+UsqXDuI0=;
 b=ElV084Uu2rgFF/tagmW/vtalyLi9FkbTFce5whm0tI1M1zRt/6BER6I8X/0AsKGqFIir/YxPL5+yejDLmRzwdteYuHrx2CXabkbD51djo6mex2t/HjnlXlLZDAaWUYHSyoNAZbN/5A/25i550k+psJS9eDT72w33UXD9GSZt4gCvXBLEDFFNV//bE6qwJAvsQG0TMw2ndopqJImOqhqrqJVCzzVh63r2CHIEMaEOFqcqKTm3arlMYR74h2Kog1D8M4dnfTkN5I3f+/0Vk5akzFyLTSaAWh+VeWsPYUrsMWMZjrKynJwW/lVeW7YbkN1x8YtiblgpJyWsSYFZGuxafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 12:45:44 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 12:45:41 +0000
Message-ID: <3bc7e290-dcd3-4398-abba-d5e74f6e7090@intel.com>
Date: Tue, 6 Oct 2026 15:45:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] mmc: sdhci-pxav3: use managed clock enablement
To: Rosen Penev <rosenp@gmail.com>, <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulfh@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260923182711.10301-1-rosenp@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260923182711.10301-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bae13c9-4873-4727-cf41-08df23a7bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Sg/wo0b0kl1oMfNfaUNZzdF95NRBGmauxc4wNBcFLm1TMW87nOgxZNdJOD9k+IQW0jJ+GJRPVJH45IPzMahggsxCHglpvOYBE3NAc09bKl3Y6OIAUTUgRXMPsb9lMp/ZBCOeaCcXx7HgBASXiA8mzqfUBFNlk5gfnQT7eGkT4cy2Jt6zhzZB96u+xTeIGZGFptaGSfuFW36l80eRIXV6O3v7wf16uMUuPV/MA3KPo75NDQYJ8J+TAaO2oOqqsOLIXrR00NO4umNIK/nUJlrwxnuaVVJz2OQKWenuG2OhxgvpoVU+MRmtHpr5LH3dlWkBtx733fweSZa3IPOnCxDCkt2aB9KpZPSKR+c0zd1PpvF4s3grhoyr1mxinffLZsP5MJ9CMlBEon2PGsTkvUGUDuFdHqv+YLE30HmzvRxJB8BRG93fhit82XW8BPTXbBLcMAeMENJkkbGCywQljyCRHHDxmHDhrqKxGpqFdpyycKPAHNhBnRkrON1Urq5iNHyzFRw8tsXbSBE5P5HTtLiHX+ObizM8zorcobzWkKHMUPSSjwu++FrkyIV6Rk3DCJUmHgQpFNjJhHQS3AYUgA3mD2ZGj5n22x2os/671tTAcrqF4D5PTP4FdWhxXa3ZM5Sf5zbzVpf/3PwDVmJZfTSrh7PPsBPtK3jXD6Wi83ocY8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJUN3pDZkpld2R0WUxndHJVRVl2YXFlVDlraFljZERzeldsdXc3NnNLK0xR?=
 =?utf-8?B?enRKTkdOWVpPTXlHdHFReWtuUVpiekpHakhZSzhCcGxWamt4KzYyaHlWV2pO?=
 =?utf-8?B?SWhlVGlrVnhDcHQ5SC92bjFXZWwvU2w5VXJFenVMM0tpUFVBY1JIcjgwaEww?=
 =?utf-8?B?U1M4aW4xY0ltR2hoZmc2S0JVSk5aTVZCbHgzTEVGNXBncGM1eHFjeEw4aGRv?=
 =?utf-8?B?NEt3Z2JHV2JpRjZ0aTdVQ0xVNDNPKzJ2cFVmTCtGZ1h4d284b0tGN1lINTNC?=
 =?utf-8?B?eDZoT2tRU0liQXRwT1hRT0E0RmwzQ05xYXhvdmw2S1R4dTRxUnNBUW54SEx4?=
 =?utf-8?B?cllRUllrUEpuSDNzcTBaMVUyOEFTelczTzNUNFlIWVY4emxjNC9Zb2V5TXo0?=
 =?utf-8?B?ci9HbUVMWGZrM0tYeDRJeWRhRkZVNTJhRmwzVEVwSGtmQ1oxb05VY2Y2clE5?=
 =?utf-8?B?WEI3eHJoeFVMQklZUlVYUEYwM2RaZmJSVHdQUHpESWN1dTJFTzlSaDdkTHNG?=
 =?utf-8?B?dDZFaVlWWEg0eGF1Q1hvek5zanZGVEJ2bEg2TUY3MGIzMitHcGJZQzE1Y1hn?=
 =?utf-8?B?citsNGtpcUxwWm1KbHoxSXlqS2txMWJUNXpKblJ3U0krNk5ZQW5MZkRRQktO?=
 =?utf-8?B?ZjJXRGUyTktocTBubnRXNk8vTzBNK2JTY2Z4RDVwNGVlS1hPVVFsakF2S3RE?=
 =?utf-8?B?eXAvVlVBbHhDMUtPclhjY2FGK1Z4UDI4dEFOQURCMkQ2enRxSmYydlBkWEk5?=
 =?utf-8?B?UkJFOEwxdkNmeUlaU2VacW9DQytBV1BuTEFVL1ExR2gzN2M1aUxNMjNrYlhz?=
 =?utf-8?B?eThCUjFPdFRTd2ZvNHA5NFV0QU1KYXFSWlJKSHVrOUljb3UxWWZrb25FNUFZ?=
 =?utf-8?B?MTdPOHJINXNwWlRpeWhTQTJLdmJxL1JtREtxQU55NmhyVmNqNmFPMlFwNzly?=
 =?utf-8?B?S1hBLzBTUjhkc0w2WTNYWEhtdjVLRFl3SGNEZCtkdEs0elAyZ29DNGpGS2R2?=
 =?utf-8?B?Ky9Tbm4ySUJxcnlQaGRXMEVFVDR3QUNDSm9sa3lMSTZPaS9Zb2JneGRBd2N3?=
 =?utf-8?B?SEZXN2VFY2U5Sit5bnJjNG1FUVVYeW94aWNXdnRjb3ZJaVlkVnhlLzkxUkxS?=
 =?utf-8?B?UFBuTm1tRTNBRjhwUCtBSHhyNEFhR2xOeU52VjhUL1RwRGxwOWFZcllVRm8z?=
 =?utf-8?B?a01aR1dYb0p6NDB6SHVubG1lUTIwaW9wcW5PUGRvZU91Q2Q1NExVeVpNNk8v?=
 =?utf-8?B?MmNRTzd4TURncVRMRHlGZTBaeG5NbTRocE5zZnJzc0psT2lJT2NxSGdZREZ4?=
 =?utf-8?B?RVdvTnpScmJCcHFZRDFncEtvcXFhUkJYUng0RkxpM3RZbDNlcDhiSTdOdGR6?=
 =?utf-8?B?THZKczFEZFNZVGVJMjBvZnp3WHp3ejlOR3h0dDR0VTlNYU9haHY0WUQwcE1Y?=
 =?utf-8?B?SzNaN2FxOENsMlI1NHhwd3lHRXloUjAvQzlUY09iUGVJTVBTMWJXdG9Bdkdp?=
 =?utf-8?B?bFRqZitIT1k4NFgrSW5GYUJTQmxoaXhnU3NrdFIwTnB3WVZJZ3VzSVUzbHdr?=
 =?utf-8?B?THZIVkFHam5GVDkyK2lQckdkUElxOUNhNlozY1dHN0U1L2QyMUdpWUFwaXQ5?=
 =?utf-8?B?eDZIbnJDMmk5OXIxT2oyaVhVWi9xWmlTZGZZMHA0NC9JQlNQcGcrWkpXS1By?=
 =?utf-8?B?MUJhR2Y2a0wwMWZCWG1TMC9pM1lQNFBlSXdhcm5adG1sdjFqeHVNWTRHeTRJ?=
 =?utf-8?B?S0ZSNVRSZ1cvWTg2bDNHd1lQaWFIUEFZaDVtQUowdkFmYVpsaHJTSHVCT0J5?=
 =?utf-8?B?aDJmYS9JVm5LVEl3Q29FeldMcGVKMTdvWGhZNHUxSXl3UHFaci9zY1NpOTNE?=
 =?utf-8?B?N3lKRzNBdWMvUHNpSzB6cjRWOFZ5ZGYzREhKK0wrYVBTd3l0QU9pQjJvU0xS?=
 =?utf-8?B?anQ0Z3BrZzFFWm4yYWQwTUZLamdydjlSdjBDZkJPRGh2QldJeW1sSTd2SjRO?=
 =?utf-8?B?R1N1Z3gwNkFZdEN2RUxNVjQ1UkJMRGhJT29aRkJaS1RiOVhBZVRxQjhDVm12?=
 =?utf-8?B?c2w2ZzMrb0JGbzVjUXFaNk9HNnBrbEhMdjZBQm02Y1VmY210WWw1aW9wVVhl?=
 =?utf-8?B?YzJJZUE2eWxrdHRIeCtmd052UnFSVEdQYjBjWFB4WjJ2V2luNFE5TTVFNWdq?=
 =?utf-8?B?RjNiSDhkMngrU29HcTZ5d0I5TGd5VVFIbGIxN3lFaldXWmlEcDJIZUMwb2xE?=
 =?utf-8?B?d09mR0FKQ2pTSWZyc2RENGt6RnliRnc1bitoTmlEaHBIcGt4anRLRHdmaTZw?=
 =?utf-8?B?OGVPVVY1eTJFZUhUZUR6dml5M2N2Y3BXNWhNYXBCMUFZM091SHBOeUY4ZnQ1?=
 =?utf-8?Q?zxSFIVp+ms1o6bOU=3D?=
X-Exchange-RoutingPolicyChecked: DhWPg3ZjmpvMINualFpzZ/8tRLn9s/2hMk7OFzxFK3pHUpAEaLM6CjFf7G+ut8aZk16lxBXhxCaL6VDmGJrCC5/WKUa08RyO6x1YEd+3vNX9VzUQjJlbSkuOjisOZgtnt60/Bl2/aRTYOtcsH2aNdrVHAmY8YyRk1l7WBIBYmmxn7JaHoBtG3hdxQG4GR1kD7SAWO+908f0Er3gtqNz+Z6dbbYGCbvHJrhtY/2Y6ok305QcjOrdvXb7EXjt+rwuEEukv/x1fXd4nHulBDeT83uKoEIFeSkFf6w1t4VUMUbCvVXcl1ZqpZU1HAsm/91JkhXniqPkdR5sFvgbdmTGJfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bae13c9-4873-4727-cf41-08df23a7bab5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:45:41.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MibDMtkTCAH/4sm48d6m8V1weZBzR70C8X1e3iH3PDcficl3jqp3t5Y2Vo3lbQhnN4CofR6c4+YnIA61VnGlnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
X-OriginatorOrg: intel.com

On 23/09/2026 21:27, Rosen Penev wrote:
> Replace devm_clk_get() plus clk_prepare_enable() with the managed
> variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
> The core clock becomes optional, which removes the IS_ERR() guards
> in runtime suspend/resume and lets devms unwind the clocks, so the
> manual clk_disable_unprepare() calls in the probe error paths and
> remove are dropped. The NULL version of clk_io was removed as all dts
> files that use sdhci-pxav3 specify io as a clock name. Strictly speaking
> that could break pdata users but all of that is slated for removal.
> 
> clk_prepare_enable() and friends are NULL safe, so no need to check if
> the optional clock is present.
> 
> Handle failures of clk_prepare_enable() in runtime resume instead
> of ignoring them: a failed enable would leave controller register
> accesses hitting unclocked hardware. Bail out before resuming the host
> and unwind clk_io when enabling clk_core fails. This also drops the
> now unused pltfm_host variable from remove().
> 
> Handle result of the forced resumes in remove(), suspend() and resume().
> Use pm_runtime_resume_and_get(), which does not bump the usage counter on
> error.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

mmc core and SDHCI do not withstand runtime resume failure anyway.
Of the changes outside sdhci_pxav3_probe(), only the ones that follow
directly from devm and the optional core clock are worth keeping.
So more like v1 plus the sdhci-pxav2-style io clock lookup.

> ---
>  v3: fix sashiko errors.
>  v2: fix resume paths.
>  drivers/mmc/host/sdhci-pxav3.c | 91 ++++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index f39764ffd4a0..fda1eafe5685 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -413,19 +413,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	pxa = sdhci_pltfm_priv(pltfm_host);
>  
> -	pxa->clk_io = devm_clk_get(dev, "io");
> +	pxa->clk_io = devm_clk_get_optional_enabled(dev, "io");
> +	if (!pxa->clk_io)
> +		pxa->clk_io = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(pxa->clk_io))
> -		pxa->clk_io = devm_clk_get(dev, NULL);
> -	if (IS_ERR(pxa->clk_io)) {
> -		dev_err(dev, "failed to get io clock\n");
> -		return PTR_ERR(pxa->clk_io);
> -	}
> +		return dev_err_probe(dev, PTR_ERR(pxa->clk_io), "failed to get io clock\n");
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
> @@ -434,17 +431,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
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
> @@ -499,35 +496,56 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
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
> +	struct device *dev = &pdev->dev;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>  
> -	pm_runtime_get_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_put_noidle(&pdev->dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	pm_runtime_disable(dev);
> +	if (ret) {
> +		/*
> +		 * Runtime resume failed, so the controller may still be
> +		 * unclocked.  Restore the clocks so the register accesses in
> +		 * sdhci_remove_host() do not hit unclocked hardware.
> +		 */
> +		dev_warn(dev, "failed to resume controller, %pe\n",
> +			 ERR_PTR(ret));
> +		ret = clk_prepare_enable(pxa->clk_io);
> +		if (ret) {
> +			dev_warn(dev, "failed to re-enable io clock, %pe\n",
> +				 ERR_PTR(ret));
> +			return;
> +		}
> +		ret = clk_prepare_enable(pxa->clk_core);
> +		if (ret) {
> +			clk_disable_unprepare(pxa->clk_io);
> +			dev_warn(dev, "failed to re-enable core clock, %pe\n",
> +				 ERR_PTR(ret));
> +			return;
> +		}
> +	} else {
> +		pm_runtime_put_noidle(dev);
> +	}
>  
>  	sdhci_remove_host(host, 1);
> -
> -	clk_disable_unprepare(pxa->clk_io);
> -	clk_disable_unprepare(pxa->clk_core);
>  }
>  
>  static int sdhci_pxav3_suspend(struct device *dev)
>  {
> -	int ret;
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
>  
> -	pm_runtime_get_sync(dev);
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  	ret = sdhci_suspend_host(host);
> @@ -538,10 +556,13 @@ static int sdhci_pxav3_suspend(struct device *dev)
>  
>  static int sdhci_pxav3_resume(struct device *dev)
>  {
> -	int ret;
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
>  
> -	pm_runtime_get_sync(dev);
>  	ret = sdhci_resume_host(host);
>  	pm_runtime_put_autosuspend(dev);
>  
> @@ -560,8 +581,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>  		mmc_retune_needed(host->mmc);
>  
>  	clk_disable_unprepare(pxa->clk_io);
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_disable_unprepare(pxa->clk_core);
> +	clk_disable_unprepare(pxa->clk_core);
>  
>  	return 0;
>  }
> @@ -571,10 +591,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
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

