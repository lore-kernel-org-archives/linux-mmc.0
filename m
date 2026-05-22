Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01436729F;
	Fri, 22 May 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434147; cv=fail; b=R1vKt2HTr7JkBr8bdojog5ykvsuA0IdmuaE/WYbQbNl1OqWScmiR3eJxsyRcxuhlqTKPmPjIYzIC+uKBocFnDTtYYP5K42MaCuGcCLOQa1phxzylfIJPrmZ2owMT0zVgnpX/S+oRdPMuXEQSAh5cKD8+e9n4zXAEvAA4RBLvdf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434147; c=relaxed/simple;
	bh=p+ktuWSj1K35haNcUfRASM0bKnnyut8QeTs6nmZGEXY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UW9qjNs+PfiEGV4fWroecKgWkCvl9c96O9seT3/NvqEWL6WPHI9ZIKvi0VlBxgbbcChw0Fp1PU2TtPkHtHo9LHUxNOV2QyzCTXL3v2CZLcyM7GX6o3LsL2HIPdqPUpuW3Ucb+Nxz6uYUbQxewYFrV2e8qi238TQwhVZQL01nOEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QryjTCFM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QryjTCFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779434145; x=1810970145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p+ktuWSj1K35haNcUfRASM0bKnnyut8QeTs6nmZGEXY=;
  b=QryjTCFMmDWdrVaR2885GWUFvk0IrEEExZVkVXwhmdGjuNmap/JF73LB
   0pcz6g6u4+AJ10B00FCApKXniS+qnAbcsO/A1tDQX5bg7QZdYhktlNaLm
   fBZVzBxEPY2NuXMIsHyvXYGkVAlvIX0HSqezl1aUyBRhGxjhBORws5V0X
   jA+IXAKQxqIC15ifcKkGHq3FvXNBBShnx8fDEyGou+tzQPzdjCf/iyBs7
   xowuzDDgre3HkmbFcNY2oE4aKIqTSkjKwsx34wUM1gpkWy57kt90ZqTnI
   3KpOZXy+K67qvP1zPSuEjujeD8+mWYZrNArxcbfUlHSciSYqG+uPLtMRQ
   w==;
X-CSE-ConnectionGUID: 1T5dOv7PQDmnFRJ9OEmKDQ==
X-CSE-MsgGUID: RByavtcARAmfaF6PRHAgRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80262130"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80262130"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:15:45 -0700
X-CSE-ConnectionGUID: ojFKDXfmR/22tKjwNMo9PA==
X-CSE-MsgGUID: R7nQUpyETZiKF7il6i6VPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245892785"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:15:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:15:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 00:15:44 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:15:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2Aug8TTaaozcBtMSNgUGUmovgWQJgG9S4TUj35AgYAzEE4yWshY3Gyj4lGoojrb5VUspZN4WgiMh+hqxg+3Si8hdlwnIPwONndTaz17g/4Y0BmMZH4Bq4hdF8WLRo5UJcJQeAV1kR/nkJyvGBJpRnz3I2aEjrbNaRKlDZmKA8ClGBw1xlnQ4Z6wI58MT43WRIeivtZcLkiDOtq/jDnq9zPWrOCRt9yYGpA87Wr0PSniZh1IsTpC8ytCplVn22oqZyZcEwX1Ys+toUjxPG/7nCJsHE2W7JyVf9hwppvF8MZ8oonNWtaDyG3AzGAOHVoM29r27jDqk8r50XPS305/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbIJYk4CTiIQEkprkcWSVnMOyooA9gHrNeXgrtQQMoI=;
 b=n/VYTRt22fTv0yxJh1ycoVadVPj2MOvehIZPOHNX3Ak7kJbFTPudqJDWQeBI04Fmec4TXo6WF2pmI+8SbIB/VWY23s9Q1YzUiSJ1c7cbLsoYZi7+h8mgFBhRDDGLAfR4GcF968y1B5PvaSm9g+sj2HBd6xnOb4ABmdJchG2xwudmJo0ZvOH4HltIP/KaQXAMaGHc7UADqhQ6V/zKcCJmVOxdPAe8/rSpwszGtUfCB4ZYogadpty+IGC3z8bpkGvHLjXO+3X+aZ/TjOOiPd6XuoIxZ3WDNkIZWI2XmcqMWmCOmfyrw7OfXJXxBL/LtIegqYlKFo+ze+QDlz6diqV9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DSWPR11MB9692.namprd11.prod.outlook.com (2603:10b6:8:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:15:40 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 07:15:40 +0000
Message-ID: <6fa3b80c-5b1e-47ae-9866-b64a893f633d@intel.com>
Date: Fri, 22 May 2026 10:15:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: add signal voltage switch in
 sdhci_resume_host
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260520133758.14427-1-jszhang@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260520133758.14427-1-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0208.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::33) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DSWPR11MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9e6233-434d-40c6-a05f-08deb7d1edee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: ocEhaZUmkF0I0mW0II1EOuBenW1Cocr+nSWZl218uUPtHjDefwNj1tvGTdD2+5DxMoOK+mv13AS4ew+Ee4GAruhePx3IOTSrAe65hH/11ZRyeGncvtgbhvJSUojGG4IshoK6irtky/4M1uXLZZenk0J6ao9ZbTnMqUcGhabPeC6PoCmCLXI7rxsEfCqw0kiG2FuZcU0ThQwNqq8Qk/VeuA12R2GcNYC2IAuKDvy171cIaL2UPjqacY9vkeYRQm0cdNeUaA3/V+nK1U1MhddPpiTtcEc9oMBliUTiieZdvw4LKDV3mH2cyW83q8B07+OcbfnAebRsNX4H1KDEQz6UhFip5K2c5ZTYS8orHGNWcMw6CEk89hPG1J6BIyJleuMqPHwEMlmuChCu7ER0oAKP9M2QtrNFt7fzZyyjZBkXiJlX6+HrajS0zncBXKuh1jJgszuo/6H1sa7Qw6gbLIMw+r8zKmbk2R3wTlx9k7jmGPbPpMLJw5f5DXHFvEsC6BFQeXZklnSrC/Jt1/VC6tlgsa0aH07CuXkABdo8CfiD6+2kzLydCSLxU+Ggob5z6on0PiN9Uzy32WX2S80avwqc8NuG5b5EMuxg+ZIDKmbp7drlPJCDlBOPf2esOez8cmr+mV28iNQUiEHYp3g4PMhEfyqwAGDwlu/IkhaqHj12/guo3WMBjmD/Sb3Ckj+kN/2D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDBlbTRhSXg3Y1Y3MGlmTXRiMVllWGIxWlJURGdkRHZDWmNrU1hmWndlMHpo?=
 =?utf-8?B?OTNJdS96bkdmWHZHSXo2TDF5YmFSZGtxdUJTRHJIWSthZXZuTFFVWUxMcHM3?=
 =?utf-8?B?WjNuVWlxVE1IakFkOVlCc3dDeXJORlM4TDh2bXhaZHZhWDE4WDdhTDlaVm12?=
 =?utf-8?B?Tm5tTnVMMHU3Z0FXYXJQR3hGM1p2N3JnRlA4VkZNZlJ6VU8xc1AydzZaRHhz?=
 =?utf-8?B?T3BIcGJpTnpuNDBtS0ZXY21CeGUwaHNkblAyT014cTJoQ1ppNEVOSndkTytw?=
 =?utf-8?B?aGcxaEFQdFZJdEdUTzZ5UWZidk12OXNOSGw5V1RyZytURmNwdVVCM1dmQzY0?=
 =?utf-8?B?cEUzWUwwVGs2OFdpY0dXaEs0OUxrdm1aUkcrOTRyZ1pab2F5eFJ5Rmh5U1pM?=
 =?utf-8?B?Y3ozNXYrdVZ5bnR4Q2hJY1czb3ZFNkZyN01HUm0vemZKdkRIUWlsK1ZKRVda?=
 =?utf-8?B?V1VBWlJyWDU2ZWFkalVHK3ZyazlWNkpIVktadktCZlpIODhHYjRGUkNvZC9X?=
 =?utf-8?B?bFlXTVlVYUJ4aDRwZnFjdE5NWU0yT2xnZ0NRY0hPeTM4NUxTR0hSZnNYbGVm?=
 =?utf-8?B?dUxPVEp5bVZyRXRVWTJjeGh6dk9JL3Z4Y2c4MHl6dExITjZqVS9xZzlEN29K?=
 =?utf-8?B?OXE4c3F2UGoxblVqdUNpU0tJN1RYTm9SOStRQVc1ZE5QWllmUzZTa2hhZWxP?=
 =?utf-8?B?VHRWcFd6VGJDd001bDd1MWY2SHRiOGhSRUNidTNlZlVWT20vWERFdjJLL0FJ?=
 =?utf-8?B?QlZIdWEvdjBqbFlEb0RPVWtUK2dPU2FqcUo3S1FQS215WU1aUjE1ZlhPVUpX?=
 =?utf-8?B?VjJNaUFUcWZRbUtIaHJ2QnNIOEYwRE5WSGZzYnZlaEhITjVMN2NTam10c1lD?=
 =?utf-8?B?YTA0U3gwR1V6TXVkK0I3bVo0M3JQdVVLeDljTlQ1cTJCcEg4ZlE4VERQU1NU?=
 =?utf-8?B?eUp0MGM5OFJOM2pqc2NRd1ZZZXJ5RkVXN1pRWkRMbFprVUoySzVwaGZRNXJG?=
 =?utf-8?B?TFRQc1BqMUFIelBFaG5SSm1PZjFNVGFRbkZSa3JERkRHRkM0RExZbzdDeWw3?=
 =?utf-8?B?UHFvbksyekxmUU4zVGFOelRXUDh6Tk5vd2xRVlZwcmRuY2JnR0ZjM0xJZEJt?=
 =?utf-8?B?MTN6b3dvekZQVlorUE0waVN4cnk5TXB4UHlHT3VZN09SUElKZTNTU0M0S2VD?=
 =?utf-8?B?RFYvWjhndUdTbmcyMVFVY1AwREt2T29ieGZxZ3BkRk1PNjhzdDdjWFBQcUg0?=
 =?utf-8?B?Wm1WVEx3NWxPaXJPcXMvWlp6SjQ0dGN1UkFsaW8rdko4QmZ1emE1aU9uaktq?=
 =?utf-8?B?UE15NmE0NkhtTHR6amx2YnpQaVlmZzJTdzhBeEJSeTBPZXpVQmpnOTIvamFG?=
 =?utf-8?B?b0pINnFZbzlxVm9XQ08rMGtyL3ByRTVkd2xSVHFiOVZhSy9wTmpqRzZDbktq?=
 =?utf-8?B?MEM5QzcrMGpBYU1kVG5tVjBuUTV3SjNkVENBbWp5NTVDN1VxSjZqZzd2OGlF?=
 =?utf-8?B?M2VMLzhFb2tjcko0UktFOVEveFUwbkcwOU5ZUmg4a0xvNlk2bnFjNElZeTYy?=
 =?utf-8?B?OEMvWVBqb0FaMW4xZzFPMTYvUzhvVGkrTjlJTTA4U1RKWFAvY2x1bm42WElD?=
 =?utf-8?B?bThpZEdCbDBKT3hmb2tXOTZjaTQzNWFIb3NVTnFGejdFb1p6Mkp3bG1TTWpT?=
 =?utf-8?B?ZUJZbHhOM0R2VFlJdVFIeXFYU1p6RWc4Y0w3d3pVUzVXY09LUG9qRTM5YjBG?=
 =?utf-8?B?ck84SnREK1JXTkRNc0tXc3kwVlNwbiticHNrNEdNMExjbXR1djhSYjgvR1E0?=
 =?utf-8?B?YzJBNWM2eGRBS0J3cDY0SGYveDhhTUFiUnVmTTZja0s1amVrWkRlS01WSHBs?=
 =?utf-8?B?ei9LM3VJbVNqZ0wxTkxjVmg3SFRTWTVJYmNXUWQydW95clZEcnRyTVZkdnFq?=
 =?utf-8?B?NitYbGpic0p4allBRDRsKzdNbHpQc2dwZng3TVZlN0d2SXpibXZxYXp0M0JQ?=
 =?utf-8?B?UzFWR2lZRCtkOTVIRFpMOXBMUG5KQXVaTkMzelp0dWZjN0xxeGowKzFkOWdP?=
 =?utf-8?B?VU9EVXgwcTkxU1BCN0s5YmFrMUdwbE9uRmU1YkFZV0x2WGRzQ2dicnZleU1O?=
 =?utf-8?B?NUpPM3REQUEvWHlHZ0JNdzZMdGFGRWh6TE5SakZ5MEl6YVpqajBrOTN3V1ha?=
 =?utf-8?B?NlR6Wm5lZEZzSjN5WFpIWitUN3ZTc25taU55K0owWTIyWXVyR1dxcGVvcTFt?=
 =?utf-8?B?dFF4YjRTVVNkTUxETWpSdSt2Z3V4S2cvZDBkdFU0V0pZZ3VMTmtTNkdyZVY0?=
 =?utf-8?B?cXZJei9qQ1Y5KzZraGtBUUlCT3YyOVJDYUNacUdPd1BKYTVWRWlXVlU0Y0E2?=
 =?utf-8?Q?rT4lVVDJoUAiKizg=3D?=
X-Exchange-RoutingPolicyChecked: c174M7bmqrD6B242SQ3alYMdX4IqBYbWuFezWEL+600lVb7pKi0NAQJJ1/+HIHz0Qit9wzrqJ8jqxSXT/D2SRPef04lDheMFlnTQIAEHG9WkIfzUhZETlBqzl0VEx/JwM2Rcfb7BVu9HZx1PT3eW5h846ci5BXuU+S1j8MPALRtNFCoXDQfRqqxrsQrur3EWVlTyaVpUx3aJe2w5eAa7xop9tcKuoRwvH3VLrO5LucHGA26sI5o75JE5fCOb2tQnGgKU8tBM+JfnGyNxYhjAobmEO0EkdHYa2M7Pjop2B1GmyPtRjXzuGZcAku4X2PrgV77ZRCDt0sYaf8+3/5b7TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e6233-434d-40c6-a05f-08deb7d1edee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:15:40.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFtFb+no9AwVM8dcOf72DxSGEFgkEt9gX6iAvdRQKADMOIEvB5Q14f0bmTR3SPFfeSNBmvnyBCwlwNUMnKsUHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9692
X-OriginatorOrg: intel.com

On 20/05/2026 16:37, Jisheng Zhang wrote:
> I met one suspend/resume issue with sdr104 capable sdio wifi card (with
> "keep-power-in-suspend" set in DT property):
> After resuming from suspend to ram, the sdio wifi card stops working.
> Further debug shows that although ios shows the sdio card is at sdr104
> mode, the voltage is still at 3V3. This is due to missing the calling
> of ->start_signal_voltage_switch() in sdhci_resume_host().
> 
> Fix this issue by adding ->start_signal_voltage_switch() in
> sdhci_resume_host(). This also matches what we do for
> sdhci_runtime_resume_host().
> 
> Then the question is: why this issue hasn't reported and fixed for so
> long time. IMHO, several reasons: Some host controllers just kicks off
> the runtime resume for system resume, so it benefits from the well
> supported runtime pm code; Some platforms just use the old sdio wifi
> card which doesn't need signal voltage switch at all, the default
> voltage is 3v3 after resuming.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Needs a fixes tag, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 605be55f8d2d..e3bf901b10aa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3836,6 +3836,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>  		host->pwr = 0;
>  		host->clock = 0;
>  		host->reinit_uhs = true;
> +		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
>  		mmc->ops->set_ios(mmc, &mmc->ios);
>  	} else {
>  		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));

