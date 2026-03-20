Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833C346E43;
	Fri, 20 Mar 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013255; cv=fail; b=hiufoGD6RGEgU8fzC1oJA4eHjofqhOi4f2Szay2nbUYOjLC183r8uaprtONu6vdibhIOTQydLEhk7BMC1yOOFAghDR1QObdpzGx+sxEpXpbVtIviCDMMOHf5yPdLqCmQSovoMbX6P8WaREOAT0AalDh5XNajzjsSiG4lQ42okvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013255; c=relaxed/simple;
	bh=R89SxNG7wHgm2dcjSKpj/8uti3GLURJPoA5IFv115/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lThjY2gDxi9tcT+RIbhNyioakh4cQVzaZSTka+sK6OehlQbx+t/grNCyWZMsnXzhnakJHVWK3ewzy1DE7AP3QFMJ5XCR204gW7s9m7Rj+RXxtFj0Ihwu3q138uLzXcwlLzsZmy4JwY0JE6hvMpFgfo2qMYuR2GnxM2k2L0TGzyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZsbLvWz; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZsbLvWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774013254; x=1805549254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R89SxNG7wHgm2dcjSKpj/8uti3GLURJPoA5IFv115/g=;
  b=dZsbLvWzh9t8wc9H0GfTBIc9QNRyAKHHXevYI1fZnXAS0UcLg0MH8rk4
   ueHmN8VcGF7F2qtUja97qIny2ozo2ZHPQZCHICIO8EAOnAjEOKHrtAXgM
   zN4TPuz1E+ySKJaJJProdQskl13t1c0RJHf4H/vfmn9hJHWolhtS8H49j
   wu/COecz52cd79eQMKTtQ97BLc6oMct+AGyqfsSSXuAm+Y+Yh3C5Qu/BS
   U/e111JhRVH5jOIW5DVyx52cw6e+pNP0mgByAjsJzAxQRWjsQ4EnZmsUT
   6oalCHwokAWdNYlkECwejP/Q/yvJ+JCzWy1a57ypr+4uMCBphgBzDzj/U
   g==;
X-CSE-ConnectionGUID: YV8KWLocR72wz7+idHfwEA==
X-CSE-MsgGUID: hwXQr/CcSTOcnRDjTUSCJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79002510"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="79002510"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:27:34 -0700
X-CSE-ConnectionGUID: yc4ZZ+/xS62pp4e5vEylXA==
X-CSE-MsgGUID: t3bAn9WXTCWbaxLx+zIcHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246315527"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 06:27:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 06:27:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 06:27:33 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 06:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccebZFe5fWCutVfMMb/KGdLFsQQL+Mu8AircfislzAb1WuXZUsrsIch/RbULVf8Lw3Dbf1SWF/WayBrJ+bRuFzzcCTxX1NLTBbBSSxLxcZR3IefX1rZZo67MCXVrVoucz8fHgL5zvpQaDBGj+y7xTZtpL6np6H7TLelpuF7IRPrBsviyAa8SyFmqiUANg713oMh7EcewbtpG8SXd9WEpahMjRzf5J8us/8iZkdYoBZbEKQ0kQt620niSciqdA13pBk+bm9QOJXtauoxitZYDL+ERbeiDVTp3APpoUK7uQRNkfzcEJEfIp6PltDIG0dyFTgqJ0nJ8eO+5GH7n81quOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnluL1kt7Q3D405j0nt4AzmYOa6ouCv1rFVzMmcLUZE=;
 b=R5sWiQul6Fv3y7dFjbAQLwfFRBc3bUbBuAytfFHD8GCTs0KmnDWGff05CE3fsh95buSWyztQgcY5gIzOzu7DfXBWAv2Ju38iIG0OZnzJNXc8i49WU1W4t8a6BVOXQURKIQKL6atuBu5HtcA+z8okWXG2wuYcKxY/iDve/bKxNvefpIY4UP5tNvgQIZ/x2mbHVq3KUV2c9yBQLY2wTVbNg2/v7f4Z3Q/2ffSQrxXhkj2lFCNWO3R3BQe4C73ODGeLALxONZXCLdFf68jI/ssYFgqib6n3AhxHGiqyYv0QbXL7O2AHAr3Rwya804YCQS4as42D3IBystcs/PRqpRellQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 13:27:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 13:27:30 +0000
Message-ID: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
Date: Fri, 20 Mar 2026 15:27:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
To: Nelson Johnson <nzjfr547@gmail.com>
CC: <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, "Shevchenko, Andriy"
	<andriy.shevchenko@intel.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260316212325.4207-1-nzjfr547@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: ed41451f-1cdf-482a-ebcd-08de86846f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FkLl5FTgpgpc37Vo89nA95cGMmLgfLsmkEceXHFGukNZhzXtNUpcTnUE2U7+UHDC8c80n3zIV3ScGRALEnzGRQRUeIWhFVqa20zXKY46wryT0olQMRvS8hSKQlurc9RxYoOCZ+hz3LUhFi/hpXekCtkTl50gRz39gnVkM4aA8zU9FtArIYclxjhP5l9cASouRm0PLfxBbnfYuKffAddO+3FpXVExWREvynXgBYiaQVc1Ixj+WWQaTj0r8SdVs60BxSqR5AgAhXii4gGREE1flg1iLoLxzOwzQNUh4ixo92goKpkiPPXAPdX6WmXqWhqjQxgnAsHx5XOlLZd7Fdyi1ugBF/gMC59tQ+Kc8vpSUeSLpR7bVEo1X5IXuUAYGJissWi4nXB+sDoS9fM4WhW+bEI/1zdKNvQbXDrmt1SfKGQ+an1Lx7bOwceoXIDyOiyHclQQY7zdugmATvjHfs0+LrFbAwioUhE94yNOaB8FpSu6otq2BfOoPsRY+Pk0EGr4tGgUqePRLGDG875Hry0FvN27pmoIsbzhGFyE8XnR1K8K9xnFtc0uSQiCm8l/IsHaJeOXwPkSserHlVb+HbD3r67vdSwVLR9a8lw4qYooJ1Pk9xCvd5ln/F3DUuCAwK6TzNb39sl2KwYk0OzyVBhhp/IoJmtVblTQd/iD4hfbBdvxcFvl46Usx445YSlnClMvI5aJrY9MgaZjaZiVYZB1ZfaO7/3HHVFVpFdNeCh4MhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNBQ0t1Tk9UZVVBV3VnZTdpZnVXbnJCRm1KYk45VmRwbHU3VSsrajVqdG1L?=
 =?utf-8?B?ekdsQ3JuOFYrU2lnWlNwTnZteUhqT0QraVZKUUY3dUFIZ1ZlazV3WXZtSHln?=
 =?utf-8?B?MXFCeDByTEY2S21hNnVWWDFQYk5ZemdLTzdNdXd3cTZvVGtST21RejY2eVEr?=
 =?utf-8?B?MjhxZ1V1MGdPaThlM1BVaWtoZkd0QXpENFJoZ1dSTGo3NTM0NHQvZHpxRktk?=
 =?utf-8?B?RktwNGg5cXdKSHhIY3N5N1dkSlNib1hBaXc2dGgyRjdabXlFS1VmTFB3Ky91?=
 =?utf-8?B?L1FQK0x0bDNuL3FpUTkrUzhVcjM2Mms5RlB5ZnoyWm5MWGVlOExwM3Nuc2M1?=
 =?utf-8?B?MW9GOVJObFI4M2JiaHZLcnVRKzhWRzEzcEIxNmYwRVlCekhhVk15Y0p6WE94?=
 =?utf-8?B?TWF5RjFBTEhraFp0b0ZDOEpsbXlUTFVrY0M3NnlaL3pLVlBIZldCNGFZa3FD?=
 =?utf-8?B?ZitSZm54TjU5bnNwMG8zay9adEsxWlltcUFJczFSSG5yUmczQjdqTlpmSXFl?=
 =?utf-8?B?VmRmblZKMDVkc2ZndllhKzRENzUySWhYQW5rWk5TdGZqQ3VnMnlwZG5HWG1Z?=
 =?utf-8?B?eWFsL0NMdXBETXpsWmNlV21UUTc2T3Y1aDZiajYyb25NbjR1aWlxZ2FNV0d5?=
 =?utf-8?B?V3V6Q3pQK2owZjczN0RVdFFUTHVjZWNQajdmaGkxOURMMkE1Mm1uKy9wRUpv?=
 =?utf-8?B?ZmlmWXo5TWluTEQ0T0FOSWxwTVduMmpBaDdPUDBYMm50MjBuWlAyTnFUSzRD?=
 =?utf-8?B?c1FNa0w3TGJDVFVFREYwZ3JXMER1bFdhZm04bW95cWRzeUpvanRMb1ZFQWJJ?=
 =?utf-8?B?THJSWTArNVNqQXVhcEhyalQ0aVhLc0lqVENFL1QwMS9IL2lweUF5SW94T1Fq?=
 =?utf-8?B?d1daeGl6YTZhWEZFUHR4WGtFWWFXMW16clRFRlEycHVYb1NTb0ZRR2FmU0VH?=
 =?utf-8?B?K3VRaC9TVHdmTUpRbGRoUS9BQW5IQm1GNU5XMU5xMmlYQ3FNcGFIS0dhQ0Rj?=
 =?utf-8?B?SUpPY2ovVnFYUzdFQlRyU1gyTGxFR29VRFlaam40NFpzTWxkYTQ5Q3NQTXlW?=
 =?utf-8?B?WFVmZGZidXhjWG9NMnRHdlZObVNpRG1waWFBK0RuT2QwQUNIdmdXcTdQSkx6?=
 =?utf-8?B?U0RnVzdxSHkxS3lXRmo0YktJamxqTGluQ0Y5WVNaenVsTWdWWUVKOGhLMnNj?=
 =?utf-8?B?RjFlRFI2dnk3WEgxZzUzWHVjbWpudElvdDJ3MzY3UDN6QWVnREc0M2p2c0Zx?=
 =?utf-8?B?RTJmeXQ3N0oyTlhaWlFDVGNScFExUVE3NENvRFR0dHV6NFhlekVwNC9RZzNV?=
 =?utf-8?B?SE5rZUZvazF2TXRhcE11ZlZYbmNpT1RYc1ZOZU8rR3I5LzlWVnpwKy9Ya2M3?=
 =?utf-8?B?NXp2aEhQRFJ3U2p1QzBURENoSkUrbWg5SENXN213ZEVRdjY0M0dGa21Jd2Y5?=
 =?utf-8?B?b1RZaloxeFE4SS9iTEd4dVoyYWtTYm9nbWFMUDVDUFhJRjd3QVdicW5LQXBC?=
 =?utf-8?B?Mk9Va0t3bXBTUmhjVEplSnhKOEFDdW9maEFwNmxYQmZ4dWVNd0lrb280Z25U?=
 =?utf-8?B?M095TU42UVNwQlVwWjFRR3Rqa01pYVAvMEp2OWF0Sm4yOHdKTTVNK0czMjAr?=
 =?utf-8?B?dnNnTjFzdEs5NndTbEtJMU10eWxkd0IvVWhXaTFHM0duLzl0emZ1bzJkRWg0?=
 =?utf-8?B?KzI1WDRBVmo1TC9QTjN2TEpzUFQ2YXBLa0dZbGZQNFVSd3JCSjI2aURiMXlm?=
 =?utf-8?B?TnUvQ1I2MTRicEo0S3F6czBGZUdHb2lzVitLZ3dvSm1scThXUWpnQUJJbzRN?=
 =?utf-8?B?Z1QrVDdVR3Bqd3FoN2pUUEJUZVdEL3JYUjRzTEZIMTFwajlpL1JQZTRUaGNm?=
 =?utf-8?B?YVBxUjR3TUhLZm96TzVwTnZaTHg4WGt6aTM1dSs4T21Ea2Q2dWFTRDBkN0Ux?=
 =?utf-8?B?UkNDL0FDZHg3Rndaa1I3anh5RU9oZVRRRXRNYTgwUE1seEJ5VEx1dWVaK2pi?=
 =?utf-8?B?NU1yYVdKUk1QSWQyWDVWRDN0cTlISlJmVHhKcklGRHZram81SVJVa2twSDho?=
 =?utf-8?B?RUM1WDlWaDk3anBvbENORE1FZDg1RnpMcnh4SGE1akw5VlhGckdCaDRDWjVw?=
 =?utf-8?B?b1RDT1dHeHNGSEhxNjlmQW5Vc3NQeitRTWhhaFBzMDVNVWxxT1QySlN5Y3Vv?=
 =?utf-8?B?OFdWZnVHM2FyenZSUTJId3p4eHA3TEt6T1dGTlJLODZERmFQWWp1VXRsUXV0?=
 =?utf-8?B?am9TYnZMZ294dlVvVFhWT1gyQSt0ZnRYeCttTFpZZ1Q0ZzBJcFhMN2Z3TVZ1?=
 =?utf-8?B?dDFlM2pxTnJYaWxhRTlhdCtGT1RGQVFIZTlnc05QZFlaVUhzZVZOcG1mVWpJ?=
 =?utf-8?Q?4qu+uRJTPz6YjcMg=3D?=
X-Exchange-RoutingPolicyChecked: AA13/dmRcXUW+AnWzN9bn4QYU54OI8If0nEo9in9GZndz9jt6CnF0um1JfV5Kz+A496Xwcl0mjfZEfMaOkvt+hn5B/0bA+9iKyGvcDtr523yEDFknUrJw4V+sY9+Gh/Gx1qH3o4P79E21A4IVtI5hW/LPO8fd/r7mllHpC3W7bdv2SHh81HrFkzmsZCWjj/jcyMqX80bVSOthppaXYH82OuqEcJmifttbLo08BgAoMryBgadx9uv8qN+BWbrj0U18lEQp/7eqNkBJyak6yeUtxjadeK3xY+A3aLxElvrRe4z4IU5UC/WjwKQwxMhh3u3qjkZzvTWbqgsSD9UcGwTwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed41451f-1cdf-482a-ebcd-08de86846f6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:27:30.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3iL5nc4VAEvU2G9KCYJj+MXbCvQBR4uX79zxeBC8BM79vMJUsEOm9595+6OhMjBzOEHj11XCeJWBvCFo68AcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com

On 16/03/2026 23:23, Nelson Johnson wrote:
> This series fixes the long-broken SD slot on the Lenovo N22
> (Model 80S6 / MTM 80S60001US) with Intel Celeron N3050 Braswell
> hardware running Debian 13 and Linux 6.19.6.
> 
> The regression goes back to kernel 4.14. The Braswell SD controller
> (PCI ID 8086:2296) is exposed by firmware through both PCI
> 0000:00:12.0 and ACPI INT33BB:00 at \_SB_.PCI0.SDHB.
> 
> On this machine the newer runtime PM and card-detect handling no
> longer works reliably, and the ACPI path permanently defers because
> its dependency never becomes available. That leaves the slot unusable
> unless the controller is forced back onto the working PCI path with
> machine-specific quirks.
> 
> This series does three things, all scoped to the Lenovo N22 DMI
> match:
> 
> 1. Disable the aggressive runtime PM/card-detect wake path for the
>    Braswell PCI SD controller.
> 2. Bypass the broken firmware card-detect GPIO path and use polling
>    for card insertion detection.
> 3. Prevent the competing ACPI INT33BB:00 node from binding on this
>    machine so the PCI SDHCI driver can own the controller.

These changes seem more like they work around the problem rather
than fix the problem, but you say it worked OK in v4.14?  I see also
mention of v4.9 in patch 1?  When it was working, was it using the ACPI
driver or the PCI driver?

In patch 3, you say the SDHCI APCI driver repeatedly defers.  Is that
because it is waiting for the GPIO driver for the Card Detect GPIO?

Note Lenovo N22 seems to date back to 2017.  Is it really worth
spending time on something that old, especially as no one seems
to have worried about it before?


> 
> With these changes applied, the SD slot binds through sdhci-pci and
> detects and mounts SD cards again on the Lenovo N22.
> 
> Tested on:
>   Lenovo N22 Model 80S6 / MTM 80S60001US
>   Intel Celeron N3050 (Braswell)
>   Debian 13
>   Linux 6.19.6
> 
> Nelson Johnson (3):
>   mmc: sdhci-pci: disable aggressive runtime PM for Braswell SD on
>     Lenovo N22
>   mmc: sdhci-pci: force polling card detect for Braswell SD on Lenovo
>     N22
>   mmc: sdhci-acpi: exclude INT33BB:00 from ACPI binding on Lenovo N22
> 
>  drivers/mmc/host/sdhci-acpi.c     | 10 ++++++++++
>  drivers/mmc/host/sdhci-pci-core.c | 33 ++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 5 deletions(-)
> 

