Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795764441;
	b=a0hXWq6yMO+q5XHebi4KyrCxRFQOcQ5HKOCwpW0+IAjYwTCzmJGj5CHzAdhD52otnM1Y
	 RifN8ygcNbVZjxvYRRhCobyUr1UUZ1j7R7/PzIOdNVwUyhbMNn+QzI7HuvHShillNUrDd
	 t2ePjrxYAGfWMPF0R/Tu3Taw6mGA5dHUepP6Pjo6SPBzXmul7ea7AYwLlcii0ZCFoJZWt
	 rdVnWQ8QFZPqYxZCIlERy0l1iunM86ONGZXrozFpiIeDNUlqbsTup0JRGjzN7Ydv0PLtU
	 /GJOKmXYynsUrPtLBF6to3RQKOBEiu+TJfY6JmUmaFTR29vYubDKUtBTWF9zIyPfX2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764441;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=7CsqdNjDzx5zyCogY3I8trVl/s5tHoC5lT7GPeJXlLs=;
	b=IQOs2L5e6U5YtVzPw0GhiQGgVvu3SnnhLn3SlIvV+R1RVd7261Jj4KLDycpUUDwsm0oS
	 LpFQVK+irTpcCPMgBnVutakD10AqX8OTb32ZYATT7BgHkU7LP8QRw7PeUZ8Y8kUKZZw4e
	 Amk+5Sze4dDc32xdTsnAh6eK4RLwiMgM3TukXJ860fBqNsgzJu09fsOlTFMzyCRt7Kne3
	 3ZqUirNcHBQQ+XEKle4JAHptunuvh+L0Ts4ZIUHR3OhaOvt56NgohHr4g3qMNYh9fpieG
	 i1hKYUBVnT3dj+FDOqM08+IUzwdp4EdgCSvhYmyi1zAfyYoO97na9VTd03WmVtTZImQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TGK0c6Qe;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=nWFvzgYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160A606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 07:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2160A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TGK0c6Qe;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=nWFvzgYv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795764442; x=1827300442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Waq77ClKw3pjIpI+FtVaX8g3NvkO6aZsmIbjtK/m2sw=;
  b=TGK0c6QeGhzwSeJEtVdi6WhS3kLMxn4wG8q0Iro7zXE/F9IypwEUiZos
   lBZwkfhGaGVCl6+FN2MfgiACGHDC8AzMcwLMZ7+2gvC0Ucx80WIayiQlv
   mZnbpk5R2LIWTOC5SgStavIRq/E64f3jVNRhz4Yi9qjG8OKkMlYOCfKbE
   59FEgK6JfE4zUQ+e1thXXB2FIUHsMrLm1u2Z8Muh6GN/6HksRE07y/SB6
   3Fs4ABk3rq0xHWmSwGhrA1bu7xaowMdVM4WRF8iJUSy0X52cHpL0t8P3/
   rlY/SmgyrNwMp2k9KONz2sNwtdU41QTKdA40ne2xj74sf5WSbEVnBv94k
   g==;
X-CSE-ConnectionGUID: o/Ho4sVkRkaHAuPkt6wc0w==
X-CSE-MsgGUID: B54ff8fwQhSS53dFwh6ggw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4759507"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4759507"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:27:21 -0800
X-CSE-ConnectionGUID: Gau0tBmCSsqTjNRMWMk1Pg==
X-CSE-MsgGUID: KbyO7/KLQ5OcHOjD/HIoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12677948"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:27:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:27:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:27:20 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:27:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqss6VBqkJKFG5g0Yt2t4luPJ11K9R6zNvjRmEXDVIb82i6yRASo9oE7VpIOEEOiqxtgotdcOjDBiMcN8zrpH4TrtmqASiPqKa+uXGhRmSj79+AmOJ6356O2WkRgOHmoLiNr3rF0O0Wbz5tRlgR38tEAgCgVUnNzqdX6TOYGT6n2HlTz2o8bl0owzpHvF8nsCgyvBWgMJyS4cyevYQE20Uu1MtIS0YO2MwPEEwwXh+Q/oQ5L1wLI9WzyRu0MQDpKJj6ZK4UNYsLL17Z0fCJw0Z1KYrBCfQBtrKGtUlpIUiLT8BFLrExCkKoUv7ANgzfbk+N+LqQyAg5gPSlC7JKFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CsqdNjDzx5zyCogY3I8trVl/s5tHoC5lT7GPeJXlLs=;
 b=mCz9pazIKSGG3ScmEkuifAUh9ui0+O4HMefoZD+M3k/LwsvntjTtUOCFal5iWkEfz6T0yLPI1H2yFm+flwj3O24mJ2VP7KH5VSutb+5vIyqt42sfQbuyRFrZGx+nXgMfWb3AzTJEtDqo5Wgt8Jzb+BWcil9BE9SdEdz//6IcoYVLK/2eIcfw6SeqBRietLaikcqgsHUCV8Vi6TnqL7H2bitzHMUl84WwtSz5x0h4iZ3rpkHM3TcFDoYMd3kmdYHreVoxeLr29ohCaM3KgE9O4Cz4WdOllBKKmdBkrhSQDLnDOrZK7dErw8nt62A/sPXqBVUSG8bqv8HlnoZky2q0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CsqdNjDzx5zyCogY3I8trVl/s5tHoC5lT7GPeJXlLs=;
 b=nWFvzgYv12cjqX/wD9iXU7loOFX6VVsAB/rsQ+2qGSsZgqghN8qEIiP+fAe2I4G2QcGGavniZaOaRGpb9O4JbrOPfAcGIOZow7pPMQvG89HVMZJLnGlQdUdmTtKU7Xa77X41p9Ur9NdRsyhdKRS9N4bKKn9oJQrI4VlAiYSDMDI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DS4PR11MB086599.namprd11.prod.outlook.com (2603:10b6:8:507::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:27:17 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:27:17 +0000
Message-ID: <78f4fbdd-5cd5-4d15-8434-a71b2501113a@intel.com>
Date: Fri, 27 Nov 2026 09:27:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is
 enabled
To: wisdomwebman <wisdomwebman@proton.me>, "ulfh@kernel.org" <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"nyanpasu256@gmail.com" <nyanpasu256@gmail.com>
References: <MiymQuzpi87stsM7XA5bfyMV6n_W41wNq15OMA_RnicheHtlyXzpdRw6_hg8wwrkFdSclRgrh6ZqKLg1xpBSUA7cBxO6sX0eIPHg3Mx2tw0=@proton.me>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <MiymQuzpi87stsM7XA5bfyMV6n_W41wNq15OMA_RnicheHtlyXzpdRw6_hg8wwrkFdSclRgrh6ZqKLg1xpBSUA7cBxO6sX0eIPHg3Mx2tw0=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0295.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::30) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DS4PR11MB086599:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b05fff-cbec-41bc-f1b4-08df4c57dd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XJgBc1qlofCKuwR0Ae0+FAWRoq5pSynZOmptxmnBEiACMBvsBNxKUyqaZhGzUv75SbXTArD7875zLGFu8P53eXilLD8oFD119YmcGN6wAR8XpFJHQ8Qpmx9A6cxUDEOyvlObxvJcQ5vfjLN0/W4nspSb40/wk+nQh+K2SCRjdv4KUgN9WmMGlbS9rdbQfwn8q98bNUv6v6GKjtcldNC1Y6SqlpC4ZiLsXRyg42xshyj988+0I/+oPUvWtcjr2AGN4sj35JxGJg37/bWp7sWPCjOET4pTrcaPk5UPv/Cwv5qn8CQ1W4P1yBWfddlfFI5TzBvda4f5An9H7msetXgZz+9vWGH52KKR4krYu+pIi59vi1QtX776e59poNJj5vBdgblljS6fdLuPV4p7rfIBDHzS20GKDG6Z2kz3V2w0TNGq6y7btlGSnjBuC4rmqXOTtXO/2FT9l9o8qtyhpeYrRuIWWuC+jw+kDpVk5PC4HfrvOfoJ1+p7DGSpfwSyTmjMqpjfNHozcXGZEX0tA6AhR2ZXJ+27ul/BZaw5Y1U6pGAYqWemvPqWPHDXx9PPIsOQv5bzbdOJZCsNzqwFZ76KUpFK9p4gNZEq9LzxCjFhprBFooLFnhAqulCsBUORLxkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2J3aWU3clBSUnNoQTQ1cVg4d2hoMmZLTldXOGlhbENYRnVjQ0tsb2F5bGpj?=
 =?utf-8?B?clAwdHdOekhTQ3kzcUg3SzU0SEVNNWdRUVN2ZzloY3BNdTlOenRRbU14azdp?=
 =?utf-8?B?QlFqQUxwbVljUjRpREY5L094RWpFeHB1STdhak1lUEZwT28rSmd1dFZ1ajhD?=
 =?utf-8?B?d1NmOGJicnB3UGtRNlg4S3VMdHgwdUNQenA4cFFrcnZlM1AvSUkvSkNMeGxX?=
 =?utf-8?B?aG12TVdiWGMwN1BvTWp5YnNmd3A4T2FmOHNxc3F3cUlMQXhEOHFsUEJVUnMw?=
 =?utf-8?B?S3BURkRYZVpBVDU3SlNkQjc0UUQ2OEsxQzRxbjFyRFJ0d3Fqd3UzWTlDb2Y2?=
 =?utf-8?B?bTArZm81NDdraVBPNUVRR3B0dDNEMFdUQVA3ZDIxeVNEZUgySUIwQzNRZEtT?=
 =?utf-8?B?WlBrODAxcmJhWmFETlJiazB1SEIvb3JvYjN5ait5L1hMaXdtV1VOcE1sd0h1?=
 =?utf-8?B?VWNHem1VUk5Nb2RRZXZCaGxCSUg3RkdQV3VpdVhEc2wrRjBueGx1VU5mTUVy?=
 =?utf-8?B?YlNPZHB0K0Q3Uks4Y0U2eldBT293L09tWEpITkk2TjBZdmVUbVpwdCtFZ2ta?=
 =?utf-8?B?VEFheHNrM0ZabjkwcVRGTDVPeWIxQTd0d3c1ME5hK3JvL2taV2xtV0M4U0gr?=
 =?utf-8?B?SDJtbXNkdWVzNFArL0tWRGlTM1MwVU1ja2FieVYzWTVZZk5jcmlCY044NkNw?=
 =?utf-8?B?dTlUMGR1VjdIdW9NT0xQNkJBMVlLSDhpUnJyT09RSElCMkMyZUNSYkVXM1FY?=
 =?utf-8?B?OXdDZmg5SlZnZHFiU3V5SXoyTlVlTXd1R0tKMUMzNHNsQy93Uk5lai9UNCtT?=
 =?utf-8?B?a0VlN3g1QkQxR29lOW1jVnVWS3NZUlllcUNvTG4wbDhPcUpiQzNqZERvVzkr?=
 =?utf-8?B?ZFJ5Q3JwMVN0WDhpNWc5L1o5V3hHOUlBRHhFd3Z6Z1lKeXFiVTlhdVk1WCtV?=
 =?utf-8?B?TXg1YTJZYnlEMEV2cUM0MDF2VGNhY1JWeXh4ejZrRFFBcjI5NXljSFJLWHN0?=
 =?utf-8?B?RVZNV0NZcmFmNXV2djc5RFlyWnZqUXVLSnFwQ3cvK0M2em9wYkdsalhqbk9N?=
 =?utf-8?B?MTlpZ1RZTGZROEdid2tNQW8yWmE5bHpiL3VpZm43bTFDbmg5cVBrUmw5VXhE?=
 =?utf-8?B?NWtTUmdIUW9XSHhaSzdLdFZzTjlHSktmL093ZUxReDNpNkxuNkZMRURjT2RM?=
 =?utf-8?B?akpjbWVGZ3ZBTEx4ditFT0ppcC8wc255ak5BNHE0QkdsbjJqdkI1M3pVbHV0?=
 =?utf-8?B?S2w2ZzlvVHVCVnRqS1l5Tml5bUtSR0Z6SUwxR1NJSHZOZzRvdjhsWVpJcVU4?=
 =?utf-8?B?Wlc0WFNsSkdHTkk5a0MwUHUyTE5ZcUR2bzZlRmFzTFVoMVY2bEkrckk5VFB1?=
 =?utf-8?B?bVZTOWN0a05GQmVpYVZTcURvdC9jbE52bXlKQXBhd2s1WGZpeU12akdtQTYx?=
 =?utf-8?B?TXZqTVVGY2dOQkxSQ3RvdE1TRVRLNllORGZ1bWtULzVPWlFRZTE2SWRuYk1U?=
 =?utf-8?B?SUg0ZjBwR213M2Z5RnBIOUF6Y25rV3RFWHdHYjEvc3RWZFdaZ0NoNGlzbDZY?=
 =?utf-8?B?S3hhMEdIQzNrTHMrZDdsL3lLbnJkSUg0dUZTeUxJTlQ5R2hzZ2psNmFKVzc2?=
 =?utf-8?B?blJQQU1HM0RlTGI4RXZqQVZKakxSUHJWUzIvRVNDMmhyaUp5bU9VUURPMEtl?=
 =?utf-8?B?VC9tb1ExN3N2OGxrY2FreHE3ajE3TlN3ajc2cjdiYkVwNlpSU0NaRDc0KzZZ?=
 =?utf-8?B?S1ZYQjFheE5iMDA0c1BrUmY5MGdiZzJXNnIvVUVUMFlJVmlWTDFFRzQ2eith?=
 =?utf-8?B?aVhYSUl0eG1QU2VORHFrZjhKTlFoVFR5SzNsbk10MVA5NnVzc2VlOVg2Z0VJ?=
 =?utf-8?B?STl3WHVHdU44dHVjOVN5MnZSQ2NPM3VDSVN6RmJGbE9NckI5L0ZKUnV4eGR6?=
 =?utf-8?B?bXFsQ3hOTHhSWnFtanY2cnZDV0tWYVNoSUNqdW5HZy9JeEo1aXRCd2JNTW01?=
 =?utf-8?B?dU0vRW0rbytRU0ZtenI2cVhsQkdRRTZvNk9DbFV4SS9YTTdIV3RKS0N0cnUr?=
 =?utf-8?B?UkNPSEpYR0JlYnJIbWIxV2VMaUlHeC81RXB2WjdWN2c0UlpUVTR1Tkl4S0tK?=
 =?utf-8?B?N1RNRHVjc3VnZm5Pa1F0dGUzRHNQbGZ2bkZNeUw4Y1BhTEhHMFdvTzEyaVlY?=
 =?utf-8?B?emhQUXE2QW9Bd05XbFB5RVlLejErd1VJOXp2YXlQcVpldWhiY01POHMrYTcr?=
 =?utf-8?B?ZWRPTEprc1ltb24wZEJxckY2M21UT3Vwczh6OXNLekFyV2c5dEJGWDNReFcr?=
 =?utf-8?B?bXVIMU0rMDFFN2JnS0hDYklSNER2Y2NIbmlBeVhZb1NuTytPdkVydDFCWTN1?=
 =?utf-8?Q?TYXyo/q/cwlqOMUY=3D?=
X-Exchange-RoutingPolicyChecked: CFqpLnSIZK29MqMjc+GBx8UjEQRn21tUftj3xtmL30kMY8AF0uL9KkoYBAfsAkeVvauOToe7/l8IOLsdqFFyg94u2eYhiCTXbK/aJiJrH5fWC4LxNeqm5ddjVXYYgLWr6ch0ZACLLxKLLiEH2+UAFfAzGSzNYYIFTQl/2CA7WeLY3QYyxaUMCTGZMt4MbSROfK+GjhQAl2X5JCirjnoucVMFmA2zWSNE+gaaf1A1q4sCdr1fZTauaaqgXp0Wdv4S0UPROsLIlXX+E24FTvd3PmdACaUAyUOV9DmKFpysN8lpHcCLtefWWwCzAKKtyvo0akoSQ3rqF8BXPmqYIfXQPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b05fff-cbec-41bc-f1b4-08df4c57dd11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:27:17.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky1QbqmtP3d1PLxod/aQ9NMhcwtWGwRcWjF6ZVIvJUHavvcqVVhe3LfBRvzsJUJU0NegwX8m55c3VTJNX6VZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB086599
X-OriginatorOrg: intel.com

On 14/10/2026 23:47, wisdomwebman wrote:
> Hi,
> 
> Following up on this thread [1] with another affected machine, since
> it looks like the fix hasn't been merged yet.
> 
> I'm seeing the same thing on an HP ProBook 450 G8 with KDE Plasma
> (so wakeup_count is written before suspend). The SD slot is empty.
> 
> - Realtek RTS522A [10ec:522a] rev 01, subsystem [103c:87e1]
> - HP BIOS T70 Ver. 01.22.00
> - 7.2.9-arch1-1, s2idle, systemd 262, KDE Plasma 6.7.5
> 
> The first suspend after closing the lid gets aborted, and userspace
> retries successfully right after. In one boot 8 suspends were aborted
> (failed_suspend=8, last_failed_errno=-16), with mmc0 wakeup_count=8.
> 
> With pm_debug_messages=1:
> 
> [  165.254293] PM: suspend entry (s2idle)
> [  165.625762] PM: Wakeup pending, aborting suspend
> [  165.625893] PM: active wakeup source: mmc0
> [  165.625900] PM: suspend of devices aborted after 178.421 msecs
> [  165.626031] PM: Some devices failed to suspend, or early wake event detected
> [  165.695020] PM: suspend exit
> [  165.695161] PM: suspend entry (s2idle)
> [  169.376798] PM: suspend-to-idle
> 
> mmc0 wakeup source afterwards: event_count=1, expire_count=1,
> max_time_ms=5181. That's the 5 s hold from _mmc_detect_change().
> 
> As far as I can tell, current mainline rtsx_pci_runtime_resume() still
> calls card_event() unconditionally, so the pm_suspend_target_state
> check Adrian suggested isn't in yet.
> 
> I'm happy to test that change on this machine. I can run repeated
> lid-close suspend cycles with and without the patch and report
> whether the abort goes away.

Please see:

	https://lore.kernel.org/linux-mmc/20261127064922.13791-1-adrian.hunter@intel.com/

> 
> [1] https://lore.kernel.org/linux-mmc/b6ddabc6-dd9c-4230-b19c-b2b1f5192635@intel.com/
> 
> Thanks,
> WisdomWebMan
> 

