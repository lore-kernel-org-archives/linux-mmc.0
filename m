Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2792D877A;
	Sun,  5 Jul 2026 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241423; cv=fail; b=fLH2bQMyyDzelx4t7xT9LGNbwaspPN6DdC3fJHEdX9bji/oFh/MAWds5tl/FNzrD3+xSmI7YU+mlzACzjqJ/iVj5M7yx0KggnoBmpGHrE9RUIqEfQVhgZ/acQouvcZeP7fasomKruxei7mReT/l3l5JQ255BFdUfod6kucvUxSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241423; c=relaxed/simple;
	bh=D5199TZcR8KO6fEH152CrUvW1LIU5lXjNqkSuizjFrE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WWF+mym+8xQZJC8JBeuPOHjwcJC9exzI6MP/MKbNKaQIOXH7siKduMQVkzVM6jO/wGKZfZ+160B4Jj3YsaU9irehwT++JDJmuRu7lORnJKReAhLHK6/rL8Tvs2w7fG4/JeLPIGpguQSzUo63lzeUfsIvKzkDY1Jeo6GeCJc4J1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQFt6Dwq; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQFt6Dwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783241420; x=1814777420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D5199TZcR8KO6fEH152CrUvW1LIU5lXjNqkSuizjFrE=;
  b=ZQFt6Dwqyg875N42lqKXKQ0S3KMZgMiG9urDMQurCKCVUMpDCDOJ1NMu
   j8qG1VVrFJ4f5v3Krglymkn0x25uEEGbHcTMFw/xDOhXkrxFv9Blbl0Xa
   bHxiRHFS/dea+Ew9/jE6J4vO+2QZC8moZu8zloHt1K5OAbrt46I8H5Rnu
   nw61mURfSOoOQaHeO1Ge+w1RG5VTRPIBwc74kGaVTrvuteqlyopov4PJ4
   ipbMUmaKMkoCQUaUHKluSR65sQSvrorwEeNInWU1FXHFsnehtiZt/0eyo
   0u9f9gB96MO14TiQmJiG0uEHIUVGqKyBEL6t4T2iKvDeXv3l2QEGN5J2A
   A==;
X-CSE-ConnectionGUID: 87fJujmcRiu+8RO1MnM6lg==
X-CSE-MsgGUID: kxdxAWG1Sdu0oQPpIC5FMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="95408795"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95408795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:50:19 -0700
X-CSE-ConnectionGUID: ZQIEKdYSR1u/J211xxG0Kg==
X-CSE-MsgGUID: 8C+DmSqsSuiIOslYvPqHaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253586399"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:50:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:50:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 01:50:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRSBBjo31F0ttuu8900ldmi2w6tHZBaaX8iw+BPJaS/+1FJGL0Su0dv96mgd4D2K7JK7hwyuIz6BWqo4Ck7Vxqn5QDR4d4PJhsOp1Xm8dXYcq1ekmYgda/PK0yEvnBEkPDfTDeG1KRkXgAG1ssI1iOBBRRWWZbX52Yc/nNiqeVFKralkqWDmRZfvNCVHTm4LkcZDGeWGU3Y21wL7WRA8NeVbe9NEpKy2i/tzo7Ya3bUR6a1oE49erfLl2boWdM6VUSy2rM8nzXyvC2YZj0gPHgvZD0hg+adwTKXYsdiFf2Cq74uMYSfKpQHG/CXMh4716VNRgiYzcCd9Ix7oVNKm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fUIUEKkWJEpLDQni13gfVpAhhXu/lrfp4FwkviCXQ8=;
 b=tB5MpbNlx1AkzYKGSusukDJLlc6NnGHpmtwJEmGqRRj0wa5N2wx5lqKwKbNh5cU9/3F0YGQ6eRbTWYShH6UGhfN55tlrbRahoaRE3g1AUpAMMyTBSvc2NEaOJ8IgWMjXxHViTE5jIshzFtwxmpimQsQlc92hNgpHhzrk61Mhvz7j1k+EV1YL+i7WrcNFX709DK3MSQJ7zZ2DxIdLHuExvKQcmbt9R4yS9nhQfohUPkEObX2+RoWOhvMrDRsKq0/TO9Zyy+AHnk3iTRT04YI909WTpKp12dOMDg9/sbNMIvfZ1aUcMJJ53WPv/wFnFQhBN3ufYnwpQeZSziBA5xkoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 5 Jul 2026
 08:49:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 08:49:16 +0000
Message-ID: <de3e3c56-f4ce-40ba-99fa-3ea0eeebaf89@intel.com>
Date: Sun, 5 Jul 2026 11:49:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] mmc: sdhci-esdhc-imx: restore DLL override for DDR
 modes on resume
To: <ziniu.wang_1@oss.nxp.com>, <ulfh@kernel.org>, <haibo.chen@nxp.com>,
	<Frank.Li@nxp.com>
CC: <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-3-ziniu.wang_1@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260703104208.3426374-3-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0304.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bd7f95-d465-460e-bf27-08deda724b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: nA0FyL9QvdZVLq7A7CMBdjAs2S3KhdHsRWlGtiX9ifgF3ocUjJiD0denxJGlsRLKOeMMYhmSPVV7aUqxJNhedoZzFWLe3iXxiY3gUyFxk6VVM8pS5fS11NfZPT7GAv0So/KF6Lw/tKA+w5V//M+GEGJYt5Q+fgLLXXtjXXFRbp9C2dZadUlYzLBrqycMpMsRiKJnefF3i/hG1Mk3zGx3IQA8eTszslzafUFceqR3sIeqjSULnDNSS+2yUI6XC1eChcQ9MjXRaexmnhxBf/xhNGUDnKmiOCCyvFjI2eFee3lhaM3iZF6RS87YezQpK1jaUEdF8h6TiNkVGGaysFci1oTOM25h9Y6SexjllYoRb59WBLoXckFsEwpu6WAUnJvXo9pAQcTt7TGZpXG7eSlowtbRKTLpeMrIit4Mw5hhieXlhw7qJS+Lpn5s5bm+WyuTzrol8rQnUlJSfsrqG8gEcGHZP0lr93J8TtOy7ivJ5MUaQLOF9hCAXqUV4J3B72hKclfeFXU089k6G7Nf2PxezqeKLqRUaBFt70GCXK1PRVMpBkIXkXPwz8wXB0Up0SjWqnBe4zYtLvZkdLGhgCZL3CIYvNSIVJooxjEhm6ZzvLs+PlQJbh/gd7xAWCypfWhELAXtqckPSCrOmdC7Nd3Gq/Jcuow0me6tiWhqv+jAggM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDUwM0pqb0dQZXg4dkVZOW5JaE9ncjZpMDNnWWNVWStvbWRnb3dsODV4N2ZN?=
 =?utf-8?B?WG95U2d0OSttMCtLMWwyMkJ5cnhGNWpYQnVyU2JZVDhjTjM2azVIWUFZNzJo?=
 =?utf-8?B?MUZJN1hHNzR0NFAxTTVOdGt1Z1d6TDgvNWQwWjlaemJwTWwyV09HWkdSRmMz?=
 =?utf-8?B?cHM4VDZxWVpwNDVGVTZXSnBUb1ZBQzRIMm42WkM1a3JDSitOOVQ4SFprMCtH?=
 =?utf-8?B?Zjd5c2RaMFlaOEJSdG1DYXdJdUJ3YisybEVZMjcxSVZ2VHNKRmhsREZGeGM0?=
 =?utf-8?B?dU9talozZ0tkWmtkL1RIU2sxN3pYbzM5Q1U1aFNycEdCZHRyZ0pSeS9zZjc0?=
 =?utf-8?B?QjRsODkraVM3V3hrcWlFMFFHSGt4TlpZT2lhTlZtVDh2eWRvTFZpUFlGN1p0?=
 =?utf-8?B?bWVPWld2TVh6Q2p0QkJPSlJtNzNDc1cyYWxTejVlRGpDSGpodU5BZGIza0hj?=
 =?utf-8?B?U3BDU0ZiNWQ0Vi92K0IrQ29pbFk3N0kvbitwa3A4b1N1OE1LK0hKQlU1ZThV?=
 =?utf-8?B?cHFjSG9EemFkZWFIUm5Zd1luemhKKzhXT3BzN3N6Q0lHWFdqWktZbk8yN205?=
 =?utf-8?B?YkNrN1BvV1orekFPSk53emQzTWxLVVdGQ1d3VmU4azI3ZmJNVTNMTndkaVVu?=
 =?utf-8?B?TktyeFlOWWMwNUM0bmVhVkxsVmlaTVJQdmJWQVpoc200c1h6NUQ3U2NxMHlo?=
 =?utf-8?B?Qjc1Vi9hQ1ZaVXJqQ3h3bVRXWVVNOGsyclNOUlJZSk02eWhQSityRHJJNG5F?=
 =?utf-8?B?WlpjWlFWV0pRNEc3QzM4TSs1Q1Z1NHhNeVZtZ28ramphbzJ4QVJaNFlaOGZE?=
 =?utf-8?B?cmZYcFpCWVljWC9hSmNkeVplMVIwNE05T0NoQXNJVDNhbk1Fb0Y0Tjg3NE40?=
 =?utf-8?B?NW1kdy81OTR4QWJlTlV3R2VlSWs1a2ZzdFdpZmFZRE9CeFFEdzJ1TDVVb2RV?=
 =?utf-8?B?YjhweEkyb3FnSVBCYmJTTjY5TWNNR3JFdUE5S2dNUFdDaUpvR3lXVmJZckEv?=
 =?utf-8?B?cTBHLzBTNjRRTVRDa2NudmtwbElUbitBbG5Gc0lUdG1iRThvS0swMXRYaS9Y?=
 =?utf-8?B?OXI2OHNiVU5CRC9VZUxuNUVGakRwUlBCMTZmQmh4M3ZkMkQzcmVndTk2Nysw?=
 =?utf-8?B?VlNSNkhoR05yaUZSMGkrWHE1RkFkS3QvcWx1S09HT3YxaWw3VUJWNXF3bFVV?=
 =?utf-8?B?YzFrcXRPMjVmWDBNVXBCQXplZ2JhR0ZNUXVPYUJQQ2grUzhOS3hqZ2dGNHBn?=
 =?utf-8?B?ZE9OeGlyY1ZGRmJUcHo2cHVKb3gxSHl1dkRIM1FnRVMzbVU0SGZwL09iMUU0?=
 =?utf-8?B?ZGYvYzVxdlZObjluemVnS3dhdUw5N29INWNYelRQYUlDRXNhTHpQbmtsbUlz?=
 =?utf-8?B?YWFpN29jSTZyS0NLdWxhcEZnOEd2ZDVJdC9SY0JiK1VpZ1ZrVjBEZFlqK2dH?=
 =?utf-8?B?WThpZCtvbUlCem9qVHZkaUpLdHVqN01ZaCs4bXpBQ25xQjU4Q29FTU1KVGh6?=
 =?utf-8?B?QTVJUG04eEZVOE1UdWo4d3BRV1hNenpnb3R0NEwvSXAwbjFVdk83empMazdi?=
 =?utf-8?B?SkQ0NkJueEJXdW16VXFEeGpJbGFISHBCWUEvRUNDWDh6Z3lBNGN1VmJRZjFz?=
 =?utf-8?B?YTQvdXpPWGhOeHByTFNhVXdaOGh1ZDVJVVBtSTN5c2trMzRiQW5wWTZ0TkdL?=
 =?utf-8?B?dzV0cXJZRWdpSWFBZlgzSW5aYURrTzdyclVXT0VaRUdRNmdvU1FibzFIV0xE?=
 =?utf-8?B?YWZjWjBIVkpzSmF6WlBGakFaOHNST2tCWnVyZ2pFVDR4TXdLYzV6cGxKemxC?=
 =?utf-8?B?NDhSNUVmWjlYUkhXUTNGUHVPbWJ0QklwWnplaXNydGNXbXhLMWI3Wml4Wkpy?=
 =?utf-8?B?aDAySWdQQ2RuNWdiODJ0eXZxQU1yQ01INlE2aTgxcm96V0RuaGNjcGFnMUJO?=
 =?utf-8?B?amU0OXZBUE9KS3oxTkoyRmRKK0dFTjRHSVJEd1ZSbXB1WTdDaXQreDNmeFFv?=
 =?utf-8?B?eWxrSVM4am4wM2lQVVNNYTlBa1lMZmYzTDRodzhoRzUvbTZzZWFYMXlWK1Bo?=
 =?utf-8?B?UzEvM2pwNlJZbGdRTmxITDJEQUwrUG90eFFPMVJwQ0wzVEtyOElaSW1RS1Qv?=
 =?utf-8?B?WXIya1ZPUFB1SGpDYzNyQVQzMGdhd1JTYVBWby9MVW5GY0RJZVp5Sk5RYVEz?=
 =?utf-8?B?OVRyajkyaXJlWVU3TTA0b0tqSkxQVWJyc0JFTVFzOGttSjZPQjZwTkdIZjhR?=
 =?utf-8?B?OW15cWNVdFpiZUd0WHY3aWlURWNXYkIxNDdCcFE0dEN3TDdDNW5uaHZLcm52?=
 =?utf-8?B?cU43UlRUY1FiMFVKRjhSWlNOVFVpVDdpanIyclhiVkJmZW8yblF6dz09?=
X-Exchange-RoutingPolicyChecked: b6b+96ef24J2YPPD4QbCQQWmzeAC5Y4dBZaYQV1mu558p3fuiNoMcVLIcOr8CUydUKhIDialmykqrqHQDFY1BRbBnWK2TnYAWE5L4nZxAhPwPzw6mV1IJB4PpwT5uVFSPcMZmIDGsfrwHxWyXZ/rFM1cdCHneolaviswjjv1LuSVFwmlg167C+uVlJ1ai8PSA7Gfbo4t3wVtvEhy1lYL9Z4qeZHXFZo+dAbBAYvqQTlvcIvKUkEBZidTzYg/IAYXUqBNgcBGgKE6O8iI44F0N3xik66CYjx/iIdIcsntLLHWxReroTWqSJSZzN2JfsrVRdLR5mgqf7pT+M8JuiHJzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd7f95-d465-460e-bf27-08deda724b9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 08:49:16.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lHW+1O0RmpuL1gAiS/4yoTIL5vCin2OOHc57UjdQdsinBnF5/SmVvH+9f6trmFaV/KGVmWhkTQbiXOhunWifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

On 03/07/2026 13:42, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
> writing zero. For SDIO devices that keep power during system suspend
> and operate in DDR mode, the card remains in DDR timing while the host
> DLL override configuration is lost.
> 
> Extract the DLL override setup from esdhc_set_uhs_signaling() into
> a helper esdhc_set_dll_override(), and call it on the resume path
> when the card kept power and is using a DDR timing mode.
> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6526d65538de..7230d70e02ae 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1349,6 +1349,23 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>  	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
>  }
>  
> +static void esdhc_set_dll_override(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
> +	u32 v;
> +
> +	if (!boarddata->delay_line)
> +		return;
> +
> +	v = boarddata->delay_line << ESDHC_DLL_OVERRIDE_VAL_SHIFT |
> +	    (1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
> +	if (is_imx53_esdhc(imx_data))
> +		v <<= 1;
> +	writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> +}
> +
>  /*
>   * For HS400 eMMC, there is a data_strobe line. This signal is generated
>   * by the device and used for data output and CRC status response output
> @@ -1404,7 +1421,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  	u32 m;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  
>  	/* disable ddr mode and disable HS400 mode */
>  	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> @@ -1425,15 +1441,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		m |= ESDHC_MIX_CTRL_DDREN;
>  		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  		imx_data->is_ddr = 1;
> -		if (boarddata->delay_line) {
> -			u32 v;
> -			v = boarddata->delay_line <<
> -				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
> -				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
> -			if (is_imx53_esdhc(imx_data))
> -				v <<= 1;
> -			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
> -		}
> +		esdhc_set_dll_override(host);
>  		break;
>  	case MMC_TIMING_MMC_HS400:
>  		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
> @@ -2123,9 +2131,18 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	 * restore the saved tuning delay value for the device which keep
>  	 * power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data)) {
>  		sdhc_esdhc_tuning_restore(host);
>  
> +		/*
> +		 * Restore DLL override for DDR modes. hwinit unconditionally
> +		 * clears ESDHC_DLL_CTRL, but the card is still in DDR mode.
> +		 */
> +		if (host->timing == MMC_TIMING_UHS_DDR50 ||
> +		    host->timing == MMC_TIMING_MMC_DDR52)
> +			esdhc_set_dll_override(host);
> +	}
> +
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;

