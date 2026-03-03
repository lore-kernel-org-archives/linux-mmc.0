Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE738C40A;
	Tue,  3 Mar 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530159; cv=fail; b=ojKJ2z0Q/Q1Z7oxK6QArhqLwsaaHm/kfInL/N/XeYYEJjF//lpbzLZjvs49+VT7Bs+DgC8H6kiH4MQyrEbJ1/mxpFkprxIMP3HEpPyA9i850XH5u4RXg5Cg9GI4yceZ3KtTIrKiok32IUOwk+nYZToTC/66fuh2hdtQH588lb+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530159; c=relaxed/simple;
	bh=wj79aqywq18NKndx/+iSkSZtSRlVGchwZUSkE/Ipz30=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5qr6bGeAXM11MfDnK2bm+BxxMz56FNi7i6r3afF/4fLfLLI0BngjSRGzivCnIux8Sv6HB2sSVeIMDZlQOnbZnEop1/550ZAGknGQ5W/aJDqNuUW9v1AWuNZxd5aOsGRrCv7HjVL/Efy5acCWClMTivFU1syCzB6mXCEglM8hME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrpduWXS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrpduWXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772530157; x=1804066157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wj79aqywq18NKndx/+iSkSZtSRlVGchwZUSkE/Ipz30=;
  b=NrpduWXS5KqO+2H47KKLv9XF6XTxG8whBZXb09IC+SkLWIGUNVy9UVv4
   8cWGHhizfAfno+PHPQlHmcMLUy1hpLs6C73yUVnzVVeZG2EJ5urV3O2fd
   V36tggSIfGtULBzejsVn8eKqZ1LkDq8qRTVyj0gq0tHw3iPL+6uebAN+w
   nyi2H0dywUaHd3pEMqUUtDnRu2Zu3zl6oPKDxbXBf5/2pS4saxt8FOLf9
   1RKRF3vgPnp9MfoEb1QUJKva5fidGKyGnxGu2OZXUyvmUbMroj90sfnVk
   g3fvtmrPQni1TresF+x0+T4IWO72Hus1QQfDu1Rz41f4HTlPgTv/H4bmE
   g==;
X-CSE-ConnectionGUID: lE9GCrLLTsi8npgJZ0SKfA==
X-CSE-MsgGUID: jpWFcXRWRXutudlA2DbWsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84195688"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="84195688"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 01:29:17 -0800
X-CSE-ConnectionGUID: OxRy1q11Tyev89AxQTm+dA==
X-CSE-MsgGUID: 3Xr6ZBPdS4KOFfgMnq1E1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="248432028"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 01:29:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 01:29:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 01:29:16 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 01:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgwdTixQoKMP0BbT3AVwe7MJFrp+1h4dedQ4J53A3aFMA09ZwuHTJmwqoh+z2SdQxL3TeJAZgJ7YyViO2HYbkcOfBf7PCeHZq++8uVBAglHk72Ly5R3b6P/l58Rjp7Ag7kplRJMgUm5qgD0icORO72SYQVdXb/uNKJB7hn7NflO431mytoaKK/JewLC8kkETyxaRr8eetVYuQeVsPQTPeNBEkqO704kCn42RBb3KfCqcZqbSsbbk3gyTIwwaGtri2sJpVhCCHKyLvMI9V1sQSx5rjoQRWnDc7fG2e2M40I8fX0IEtngV58AwqFT/fOD8JTSoaFMXLmCf+I2mBbfNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltDRCL/5gTj+rBckPqHy3rwimMZ56bFtCO66iYma3Ww=;
 b=tvAERKNMRZHe6hZt8C/xFAcTC+0CWQIIX1cLJowk0lmdkEwb7RnQZ7bWZ4KRWTOjTnBN1H7cvxxEdTT+tafCUC3GTbj1KewtWnC3DYI4mGCnTA+eOkQ6fWUeprCkTJuKrxBdqWfCoSE2iN6I0gFwBYvJmwkW9UpYZL6tAr+VOlU/pqE/WaN6uaYiSxqY1SetROZlcMinUkZc+N/aBlcTz9ofIFq1gCEiRtcsObLiOk8Qn/4uv6MAc5Em/wT50cza5B75WW2W1ih6ROZGC4h0dEvGWZXhaU2KeGzZ8BI68vR++fMljIdoXo07kzh1AjhiqVgKpIcMkIOuXLkGAz1AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 09:29:13 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 09:29:13 +0000
Message-ID: <eb7f3122-7792-4cd1-929d-d181fc23359d@intel.com>
Date: Tue, 3 Mar 2026 11:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width
 support
To: Luke Wang <ziniu.wang_1@nxp.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
 <6c7cadff-f078-4b02-97c5-b7f0635501c6@intel.com>
 <DU2PR04MB8567C32F1ECAA3AF45D4DA79ED7FA@DU2PR04MB8567.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <DU2PR04MB8567C32F1ECAA3AF45D4DA79ED7FA@DU2PR04MB8567.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7870bc-df99-4882-624a-08de790754e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: jIr5metqLoRF829QVURhz7nzxgPQVamnDfMezuh8/sDOq+sF4atWAD8XldjfUfj8qi2nAOi3v3BI/ONSnaj7YAf+MUQBwBo/J6PUzYfItNYoc1SmQJDAH/ow6oFNaOY2fbCOZv9GO+5ncJHOIlQO0iH/M5nVl05dGbuVgci9Kpd76sh6MQNh4cI+qbGrMtsR9foeDD1+jOmKFmhgH17gZSulerfUlWlsAkRJTHHH5Wigg9vVvqQ/co8+68zGL8heR0aZhyu9HCAZLAxBzltipaIhuqaGikTJOdS2jXFahBQ4sfzEgGpiV5/yyxOfOll5SMiyYD1kcOS+M6hrMnuTVlLD59OfpKO31zJG66ZKG53jYEhWjiFbFMJwZ9f0Ow7D2W0NAdVN9e90yiBoNidjYZDfjbzcWkVYfrJwtguiNgECzsdMLZLNGD881fnKd/HEIIUlSt2SPjNQv/ikTubpEkI+RR4Z/Z7st/IWmg/l0dGxB2kY8Ez1UyjFCYYagk692r49YiYeFjzC1aCC9yZkRyeHvVe43vxcdzD8kqJg2WPOUyL+TwNovkzhtExk6kdO7WMycUflzI3vnOOTItp6y6/YjjU/5/tyTjEZe3Jqq2ueZ3F5aDQ4jkUcIZCM9zWXhl9CLZssWsko6u8/jOFcY7hq9KS3nxk293+C9tydqgNBj77eL19XtTQJD+dyeQrol3BJIV4rXMZwUawX01kAdSsYWCSDa+vxBh6P7F5B2nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STYvc2pFMGJXOElUSVMzSWw4eUI3a0pJYmpUY1Vsd2NBOFZpeW5kUGtHc09l?=
 =?utf-8?B?cFU0V21CTGd3SWdxeGZaT0xUQ1lyV2IvTVNQREFNWkQ3ZEVZUno4SW5yZ05B?=
 =?utf-8?B?RW9qQU1hZHgya1VFdnJxdzZUVUxpUlZnVVBubXZyZldCUVNsRUt0cS9zUG16?=
 =?utf-8?B?MCtVakdkTWlVSVI5b0p4MUJHYVRBT0lVOWEvQkZ3OVlLQW5WR0Fqa3l1allM?=
 =?utf-8?B?OWZtcnVjakt3SUhzckR4RS9seG54QXJCa1hlRUVhQTYrbTQxblpPSHdOWlZL?=
 =?utf-8?B?SEVQbFNTcVJUWW9aOUhOSEhqOFpKcUhteSsrZWEwOVBZbHl0ZWw0OU1zejU4?=
 =?utf-8?B?RklET1JpaThYUTZORVVFSU9VOTNXb29VNDRYemlJaEtKL2J6dDVJNkJvazZs?=
 =?utf-8?B?MXVrdUhTN0NKM0NHZVR3OE1RVFQ4eHVGVnVDZWtmNkFVSERyY21vUHB6Q1Ax?=
 =?utf-8?B?VnNGNjc4UXoyallRdG1Jb0I1RjVMTWVLQ2tUWHhGbFY2UnlUbkxCYWFEaFNt?=
 =?utf-8?B?aXRGeTc2KzRsWjN6YkpFQVIxaXdiV0xlMzJUV1MzYVpaZXBXYVVJL1hONzEv?=
 =?utf-8?B?YW1mNUtlV1AzTk1WNjVlcFl0M2Q5UVE4bjl2UHRPcFBGTEhWVjUwTld4UkI1?=
 =?utf-8?B?anNJV0pSZGdwWmVhdmkxU0FacmtReXhsYWRHMlVWWlcwWm8vQ3RXQWdUUTBV?=
 =?utf-8?B?dFJVYVdYN3hHRUtRMUpFQnBSSFpWN0U4OXI5ZlRBUSt5R1dlc1M5NnNBd0dr?=
 =?utf-8?B?K3ZWL0I4UE5XT3NrMEp5Q1F4eEZnaUVHTUtOZjFxcU1MekhmWUpSS2t1cm1Z?=
 =?utf-8?B?Wkk2aVZuTEwrdFdoNHlUQzFiMUN2a3JZVzQyekMyVFR0WXJQTmhiVElUNDNa?=
 =?utf-8?B?bzhtN2p2ZzZwWmU0a3JxYjRGdUUzemFnRXZhWXhZekJsckdtZVAxbDVTbUhP?=
 =?utf-8?B?QjhEdkJ3YlJvZFFBSlFLMHk0Wmk4eW8xN1lSUnlTNHc3TTl1a0xvQTgwdzgx?=
 =?utf-8?B?OFdaL2w4T3pqWWpCNlkyY2UvUGNhcFJvSHNZUFJvd3RUU1VMbWNCSEdKR3RR?=
 =?utf-8?B?emprNitiQzlKYnJUaThhRkozWkZoSmRsTUpCdmdwSUE3eU9qWTBEN3BTUmEv?=
 =?utf-8?B?dE52N1N2T0dqMkJ0Zzl5TmN1dmw5RExCOElUVHVJUjh1M1JHUnV4OGcvS01n?=
 =?utf-8?B?TVN1VG93TUNPZTh3Qno1R1p0bUJTVE9LR284b05LUG1QWGh1VFh2QklhQ3dG?=
 =?utf-8?B?WGNJQmtEdlR2TVZaRSswNWVzbmRET0lHNVV4MVdQdENFZ3NKYjlHQzA3NCt6?=
 =?utf-8?B?MFJrQjl2a2hubmh3Wm8xL0pBZUl2Mmx3Ym5meWlDVGY1T25HT3lWNXFOU2Np?=
 =?utf-8?B?Tks0TTdQSys2UW01VU9IaEpQdnRKTms5d3BjTUFpZzY4KzhFclUrM3d3Wjl1?=
 =?utf-8?B?WnduYVE0dXdqaEw2NnU3bDhGT25aWUhDa2crTlVYcmx5bnE1cGZXdGFGdTRB?=
 =?utf-8?B?MlMyR2VkNHJ3OWFBRmFlZjg5VzZkaHByQi8yZWtZeVR6VDVoVlMwOENKNE1P?=
 =?utf-8?B?VmhwelE1c05ibmozWTl5MmIzWk95cGJkTVpYSy91NW5aMlBSZFZZNDNRK2do?=
 =?utf-8?B?QnBmWkdjT0ovdnluSlBuRzVhN3MxRGJVdU1pWmdhR0ozWSsrTnRENVZ0NjJv?=
 =?utf-8?B?amg0N0pGeGh3aDRCSzVxMTBzb3VwNnJPRzVTVzRmZGxWWE9IWU9OOFUvb3hP?=
 =?utf-8?B?cHdFcFV3N3h2V2FMd29NQXlvOWc2NTlJaU03V0E1d2w3Rm93N1VhZUVGSXBE?=
 =?utf-8?B?VkJUVEdQNW5QZnZNcUVBTUpUajdUemN0ZHp3dG9ZVlRsT1FBN2JDVmc3OVBx?=
 =?utf-8?B?c3owK3kxdWtpZ2NuVTJCRW8zK21EZGd1QlBzNEVGVmlBUXhSMHhydkdJeTlI?=
 =?utf-8?B?d0ZhNGlveFBzZU1aWUZwWER0RktURHZ3dk9kMS9ybVdudW55MHFDQ1EvT1Mw?=
 =?utf-8?B?cXowSU5xa2VaSmZUbGNXZlZ3WFh6NUJraVJGMzQrQUFsUFd4YVQ1Yk5VK0tt?=
 =?utf-8?B?aStaZGwrb24wNjFOTHM3QmlaZi9GSFZCTHgyb3EzQ3dkMktMR3hUVXRMSFV6?=
 =?utf-8?B?c09kc243V1JTdTFyYzJETGt5clNLY2RGL2lGbW1DeUUxQnpsMkpiSzVkNHI4?=
 =?utf-8?B?QnlwVnFuVUhENVlhcG9ZVndDbjhtdkpyR1luSisrUVBWcjUwR2swRmp4ZGpo?=
 =?utf-8?B?MDRZYU1uNElsaUFwanE4K3J2MzRGTHkvdk1GaG90SUpzSFVxQUNraEc1TUhl?=
 =?utf-8?B?Z3IwWjdHNTdPVTcraUxYSm5BUStkVVhRKy9vdi9zZGRIck1NcURPM2pEOHBj?=
 =?utf-8?Q?P1e3ois8EGVig1gU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7870bc-df99-4882-624a-08de790754e5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:29:13.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s59nnUjLqxaMN8Nv2mqL20ts+SChWy2ZItxEqR9/3lccFLKu9s15yqBkm9voZUKtGpCjlTUPmAofYoD16SC28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com

On 03/03/2026 05:39, Luke Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Monday, March 2, 2026 9:45 PM
>> To: Luke Wang <ziniu.wang_1@nxp.com>; ulf.hansson@linaro.org; Bough
>> Chen <haibo.chen@nxp.com>
>> Cc: Frank Li <frank.li@nxp.com>; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev; linux-
>> mmc@vger.kernel.org; dl-S32 <S32@nxp.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width
>> support
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 02/03/2026 10:00, ziniu.wang_1@nxp.com wrote:
>>> From: Luke Wang <ziniu.wang_1@nxp.com>
>>>
>>> This series adds 1-bit bus width support for sdhci-esdhc-imx driver.
>>>
>>> Currently sdhci-esdhc-imx doesn't support 1-bit width because it
>>> doesn't call sdhci_get_property() to parse "bus-width = <1>" and
>>> set SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.
>>>
>>> After adding sdhci_get_property(), another issue is exposed:
>>> mmc_select_hs200() returns 0 without switching when 1-bit bus is
>>> used, causing mmc_select_timing() to skip mmc_select_hs(). This
>>> leaves eMMC in legacy mode (26MHz) instead of High Speed (52MHz).
>>
>> How do you end up with incompatible caps?  If sdhci is adding
>> them, then maybe stop that instead of removing them later?
> 
> The incompatible caps come from sdhci_setup_host() in sdhci.c, where
> UHS/DDR/HS200/HS400 caps are added based on hardware capability registers
> without checking bus width.
> 
> I can add bus width check directly in the condition, like:
> 
>     /* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
> +   /* UHS modes require at least 4-bit bus width */
> -   if (host->caps1 & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> -                      SDHCI_SUPPORT_DDR50))
> +   if ((mmc->caps & MMC_CAP_4_BIT_DATA) &&
> +       (host->caps1 & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +                       SDHCI_SUPPORT_DDR50)))
>         mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> 
> Similar changes for SDR104/HS200/DDR50/HS400 settings.
> 
> Is this the right approach?

I think SDHCI_QUIRK_FORCE_1_BIT_DATA should override the hardware
capabilities, similar to SDHCI_QUIRK2_NO_1_8_V.  So something like:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b1a3cd574c84..605be55f8d2d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4539,8 +4539,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * their platform code before calling sdhci_add_host(), and we
 	 * won't assume 8-bit width for hosts without that CAP.
 	 */
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+		if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400)
+			host->caps1 &= ~SDHCI_SUPPORT_HS400;
+		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
+	} else {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;


> 
> Thanks,
> Luke
> 
>>
>>>
>>> Fix by dropping incompatible UHS/DDR/HS200/HS400 caps in
>>> mmc_validate_host_caps() for 1-bit width, and clean up duplicate
>>> code now handled by common framework.
>>>
>>> Luke Wang (4):
>>>   mmc: core: fix timing selection for 1-bit bus width
>>>   mmc: sdhci-esdhc-imx: add 1-bit bus width support
>>>   mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
>>>   mmc: sdhci-pltfm: remove duplicate DTS property parsing
>>>
>>>  drivers/mmc/core/host.c            | 19 ++++++++++++++-----
>>>  drivers/mmc/host/sdhci-esdhc-imx.c |  6 +-----
>>>  drivers/mmc/host/sdhci-pltfm.c     |  7 -------
>>>  3 files changed, 15 insertions(+), 17 deletions(-)
>>>
> 

