Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071746E01D;
	Wed,  9 Sep 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944727; cv=fail; b=c7nfssRO+HV1iUfMMQCVEWlfVVmkOdUHjLLl73LLeMHhYGxxocMpOkOrs09FBRP/V0CyER11BThgW81XJiCGu0TundDzvUD1dI9f739Nnrg82pVV/4RF4zK9NESTFuu3r76ymViIEORgSY33Zr1QdR2om2QzIjGBGPlmCRJKv1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944727; c=relaxed/simple;
	bh=mITLhzJvekHYTAui5tUElBl8JzEnUIpVmAr3jbUn8rs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xe0oBMBegOGD/IJDEebLPdL6bEy5Jphx/NNJmvp2v0WMXjspI//yyng3ryiP/iTGkjLP3sVcjzJpwtsJbuwNmHqglUlDd0D6FAhKEmycbzXYfqRAxtEUaGSQcNlm2Pt7smjtYJpCMyibE6FsVoV26bmNY7eivRS7iuit+AUfv+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcWzQWsq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcWzQWsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788944724; x=1820480724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mITLhzJvekHYTAui5tUElBl8JzEnUIpVmAr3jbUn8rs=;
  b=VcWzQWsqHT+K/QkCVegeSq/imlH0qeq7bGh86lAkhjj9fpy5LKUfEAud
   vyU1btoZ01KNMY9BCp1Q2MKxd7GrPXVwldR+P8FYJNYoUCxcXtBIsLu9O
   6HlyXTcQA1mOsZ3uFaWfmehK4Ottsow/9mcliDRs30wwoFWnAJHGGnVMe
   E5DfAi8HZ2x4sRYBhe/VuOh3jotxhxa6mh63bucIdP5IFIa8laQDWK6xB
   lSNdMyq0tz8QsUKp5GkNkoCwcRjlX2gpXm364wu6jDVr210yePUjRwUCr
   lJoPn71SL4NVux//K/L41fDswvE7KYKYCgHO9i1jIRMgBJOrp0NnlCdvl
   g==;
X-CSE-ConnectionGUID: LOLVameGR8Kscc6Z4u+0HA==
X-CSE-MsgGUID: u5crrOkMQw6G1gppCA0wmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93182537"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="93182537"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 02:05:12 -0700
X-CSE-ConnectionGUID: 5y6SshHTSgmCpumuiGD8DQ==
X-CSE-MsgGUID: t6odpinaSvagnmg5zW0QtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="265049097"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 02:05:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 02:05:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 02:05:11 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 02:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB41MEt50QV9/io+nO9d850P8xU55BFe5atzOWO3zysTixVLjGZbgErK3PLC1a7VwGzJY1pBJSWX5JPRV9V5ZlQzAC4dX4kDUxONvsYF04xE22bnYdR/NhAaDMfnMekhCj8KOjj/6ZkKvQNp5Pz3pS0EH5oyEtVvXrGQq+EV7oE8UmTocD18qV61MHENSes8bgJpTH1axWFj6MVYDDbOdBi19lY16o7LZ9y6Y9xG2/MrpLyxvN/6fgZGmDMYH7QfkvS49gX7T22vXoWarJRhsP7uj5oqWoikBFRdEVNElWs4qPWvgNt9f7yCD1R+VdpL6lkMngh6qlkZfRQZQyuS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ictbG1nGj2HaBX/maUlPpkXZDPLoZmb/irdFulVY0mY=;
 b=hSt3HLKoYPaWnNvn3zT5Mhzy8qEpv/lwu/WL6Ry4kssh//Iz9DR2Ad/Bo5ZYX4tjeWL78k/dVSDcuuhWyOHgTPgNS799S6OsIFHDNfvDD4hSWii9BPa9Lxe9Br9Me47qZoi5LdYH4/+09LPwlJ43Npb0Af+XWGOzfURnT4siYZcLjzKQE98jCIz3MLrQoCxiCKvqlp7ATPROEA1OZ/9oEvl/wtUrbhP7EuJvGn17UuMVqmXif85y8Ss5BaRoYZomLhW70Nr9OQDDlC6IE08EXq7kVMLYx8wM3evr+tWc9rXljEr4KC+DFZ96MwVzk15dej9sLDqghAKPY4Boj/1dqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 09:05:03 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 09:05:03 +0000
Message-ID: <36802c50-bcb1-468c-b5a9-53e8198163de@intel.com>
Date: Wed, 9 Sep 2026 12:04:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fail runtime resume on PLL timeout
To: =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?= <Ben.Chuang@genesyslogic.com.tw>,
	Pengpeng Hou <hppiscas@163.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?U2VhbkhZQ2hlblvpmbPlrqPku7Bd?= <SeanHY.Chen@genesyslogic.com.tw>
References: <20260906033947.85078-1-hppiscas@163.com>
 <TYZPR01MB42600B6DC2CDC47D42D8FA33D7B22@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <TYZPR01MB42600B6DC2CDC47D42D8FA33D7B22@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0236.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: a8188c74-dbac-43cc-b232-08df0e516f34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: G836EyoWnpFjHlR7d4xDSSwaRJOM46OObSsSjVt90JSRAbR71zqUp5c9LBKEN4WDYM/f1H2dqhM6vffvLHNfZkEWvlEDO7fJW8u2kFb++wir0K7P5W3BGKZTo8DkIwbvPD3H1MRxreUXEEfyGuqsyJJvB/lfhufjga4UGLfDSxJ4tfP8vaFb3uDhrLfAMzyNhafIqSmoPAuWvaE1CHFrIEsS0bgTb+2/+Ne47oRhU2TTOs8Ge2BnlKqxIHSyOVFnu2LLpZSjTtLvkjTnjImC2qH/Mum5BsTasnZx9JLY3RomSrFYPkfQ2UZc7XDQL7xYhGJ2Xo4kugutBb8EB9ryULv9N2CWAEVtVwgwSyK2SGCCxPmIJ1x7eSG9io3oIdWbvUT+fav7koE6BmnaBJT7f3y3u5mKdrusbvNI3E2XMI6iAR/cwYlrxCaKMhrVfNRjue2YeuRj2nBLFHl87Uoky9uqHRa0BSH3+RgJ9IXfYsS318JZJ2+0ww8/hT9iAR7nlHElTqcgDn36DWhNbtrhN+BIrNNWpCH77R2eGnKjJM8fC9RQS3zz1OaldZKCs3ZKlPp7AsDKZJ3fdDw+AM/EXMn3rU/Jp5QuL50qn8hPMGaPGNAkyF6OwqnHHjLGNU2A2DbXcR0c9vMLvJhJAhuZpjv1LLYtultbkt6fuyM2eO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRDbFovK3lUQ1dPdExhSmxjbUxmWDdnRHdjVElHQWdBVUplYUJ0cUJzcEFT?=
 =?utf-8?B?K2w2ZXdONU04RG5NdjJYSlFhQUVyaG1PSWxnUzJaS25rdTRWQVdMTVJXQ3Zi?=
 =?utf-8?B?RzZBaVNTbjRqRm5pWXlmc3lpWkhYdUlqOWNvckhKakp5d3RobCtGZnlubkxn?=
 =?utf-8?B?ZVV0RitqUklHSGE2WjhKNXUyZmJVMWdEMzlMcm5Lb3pFZjlBcWwyOWl4bmQy?=
 =?utf-8?B?bmQ1RmltYW1jK3J3amozVmRjNEFuNzQwekhBemlDenkzR1dIK1RSVkVYOElC?=
 =?utf-8?B?OHg1cEc2SFdxbkpyUVlMdXVZTWJTbGpCQyt1QUpZRy8yc2hJYy9IL2JMYXJr?=
 =?utf-8?B?RHlzYm9jNTc2OGY5eVpWaGdvak1rZDEyTDkxL0N6dUc3dG5SNmYrek16Q0Vv?=
 =?utf-8?B?UC9wWWJjdVZ0ZzJreGF6UlVKMm94ZXBhWVIycWs1elRLeEVwTW5xZ09IanZH?=
 =?utf-8?B?cnpCTVhJQnNJTGJ4UzdnTnNyQkpQOWpZcEZjSXRmVFF2TGt4L1J1c1lxLzhO?=
 =?utf-8?B?UzJkcXFUaHppcU5MeE1tYmE3Vng4ckliU1o1UE5lSHVUZStRVi8rMTd4Vitx?=
 =?utf-8?B?Y3RDRGlzMThycUZ3RWo4eHNka1FHU1RnRDMvY1RwK2RZSVI0STk1U2xBa2VG?=
 =?utf-8?B?czhaYWxVMDJaZlZPMThONy9IM3ZyUS8ra2dTOTFrSXQ5eUdtTHhEbUw4czds?=
 =?utf-8?B?Y29TNC9RQ3NVMXJpVU5FdTkyck1oaDB4TUJUQm1wa3lna3BFRE5tV0VpaEtn?=
 =?utf-8?B?dHhtaVgxTHBobHhuRFNXQWFGVEl0aWt2Q3dTaGQ5MytJSEhzSC8wOUVOSXNk?=
 =?utf-8?B?QnMrZGx0UmdvQ05jdUViOG43dG4xVC9pdmN3MVBCUFMrYXNoTnlHTHk5dCsw?=
 =?utf-8?B?N0FkYTJVTngyamxUdzNDc2J1eVI5SUVPM09aNWdDUVFNdHRQRldSQ1B4VFJF?=
 =?utf-8?B?RElHdU84WWNkZ3duQjFuVmZKTmVneERHU2NtNmNDc1JKRUdsNWQvR1RWK1By?=
 =?utf-8?B?Z0RWclFBRjU3eHpEakFLckVKTkRVZTN6ZVlVd1FkemNpTXduU3VndHQrM0tQ?=
 =?utf-8?B?U3V5STVuS2VubVlPTEdaaGhQUVpad2VVV1lSeDR3V3ZXZzRCQkFEZFRmZ3I0?=
 =?utf-8?B?czhCcHBTSzFlVTdXakdwcklvQTM4V3pIYzlJQzVNaVRIMzV3Zkk1a3pVY2ha?=
 =?utf-8?B?VGp2UmlwejFyV3FGM0JUYVRkT3o1ZG9LN2JSWFNqK0haK2E2bVlQMzUxVEdw?=
 =?utf-8?B?STN1VVI3d2wzRFdjVTgrUG9odldSUk15OUFBNUhjMTR3TTZUS1ZuU21EMnBP?=
 =?utf-8?B?YW5BZHAwRTJRd095S2J5MEFWVEdhZVkveXNXUUZzenQyVE03RnhsZS9EWXlm?=
 =?utf-8?B?UjA3S0IrNmRqT0FlRkZuYlV4MStIVWp1b25Ick92SVBQTXRyWXhkOThtT2M1?=
 =?utf-8?B?TndsanE2N0QxZkx4Vnd4OU4xRmxKUldwS0gvekpIdTdGNEk1NFo2ZE5mMWZY?=
 =?utf-8?B?SzdBZDM4UjZSanJmK2hMVzU5QkM5Sk8xclRzUWRISzc4Lzc4UnkxVmJzNUR4?=
 =?utf-8?B?YnJyWmRVMlo0YzR5Y1V1YllNMkpZc0p0TkQrL1ZFbXByRTNHd0RwOWppVlV1?=
 =?utf-8?B?Y2s2SDRTS0N3YkphMlRKV0FnTDROam96MWloM3ZzMmZiL3dBV1QrcElsNm5y?=
 =?utf-8?B?ZnZTeEdUUmN3YndPWWd3VkxwdnFSaS8xYXJlV2VOZllOelRwZnBVdVpCbVB0?=
 =?utf-8?B?Yk53VStkYXFGN3lLYUxEMUl5NDkydnRqeXlFdC93Rlo0ZlVPcXcwbmFGeVh6?=
 =?utf-8?B?cStFVU9TbW5DancxSlQvOUpMWVFxamJOVUJLZjdzL1JkTTB1eTM0N3RXeGxE?=
 =?utf-8?B?S1RVTlVoSFU3OVhXMjJnRVJ3c243ZzRTaC9MRzBVbGpHMHQ2TXo0ZUFDRlR4?=
 =?utf-8?B?allOVWdZQk4zcnFxZ3VUTzF6bjZ3MFY1aWNwdnU5VmFCRVlPcFNXZm1oTTlY?=
 =?utf-8?B?cU5nWndFRDN5NzU3ZEUvdnNyY2hlQjhmc2tCTHNES2ZEbzhPRkdDYzVqcjJM?=
 =?utf-8?B?b1diK2tLNjJWaWVBK1R4Mk9xWmk5c2hoSVB1bEsrRUdOZ3o4eHhSc2hubzI2?=
 =?utf-8?B?UXZFMzhUNnU0NGdxNmtkdS9lMWZXU0grKzRKbkdXZS9FMzZBMWlLRzNTL3N3?=
 =?utf-8?B?NEdtNDhpayszOG9jakxZc2F4Mlk3VkdDVVlPeXpqNkQ5bUFCMVJvZnM0ZFdL?=
 =?utf-8?B?ajFGaWhSMnFQRXBueXhFWXZWY2syeDJqU3VGU1JuNGtqVnFML3VzNmJORUhJ?=
 =?utf-8?B?cGJ3QitxYU5ySWlhN2tGbk1xZGVzd1JjMThIbjF5ajE4TFNkTDhhUHFjdEtm?=
 =?utf-8?Q?Tlm7sQYg8/HniW+w=3D?=
X-Exchange-RoutingPolicyChecked: Rop0Uuf3zssG7rLpt0srxvEqRms3sTVFeOgyKs9deORuM55mrySyJWXvYiT+QEU6B/LR0sm7IqUPJoB0gNvjGQo7Z2kC3q3Y+PQtZ5Qv0MvMOASVSuq78t7D61HTEmQZYUyVIeP/SzWDlpesGb86BBR9I4wtvOYooTeMbZwJ+3WmTxosXf+9E2C3e1gwprc3eEru4ioB+EPcyShOB1mRi13EOzGA89NFslpRYZoHjMJQqBGecMED2M8jCPHIimcSvqhM4uv0BXjNMMsxuICcA122XYrgG1L38u0CyLzxfeuRL7u98CfTjqdd7yG2ww0CJAbh5x5wajAqPfu+W8GwWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8188c74-dbac-43cc-b232-08df0e516f34
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:05:03.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARRWoal7L6VN11Bye1J9OB3IdWwLlfBeUoFRd6bmxI33JmrD6dG98s1vR1Uu3YS1qps0CpGxfeh7+flWcDYyzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com

On 07/09/2026 12:16, BenChuang[莊智量] wrote:
> 
>> -----Original Message-----
>> From: Pengpeng Hou <hppiscas@163.com>
>> Sent: Sunday, September 6, 2026 11:40 AM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson <ulfh@kernel.org>
>> Cc: Pengpeng Hou <hppiscas@163.com>; linux-mmc@vger.kernel.org; BenChuang[莊智量]
>> <Ben.Chuang@genesyslogic.com.tw>; linux-kernel@vger.kernel.org
>> Subject: [PATCH] mmc: sdhci-pci-gli: Fail runtime resume on PLL timeout
>>
>> [You don't often get email from hppiscas@163.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> gl9763e_runtime_resume() logs when the internal clock never becomes
>> stable but still enables the card clock and reports runtime-resume
>> success.
>>
>> Return the poll timeout before enabling the card clock. Clear the
>> PLL-enable bit so a failed resume leaves the clock state matching runtime
>> suspend. Low-power negotiation remains enabled for the suspended device.
>>
>> The issue was found by our static-analysis tool and manually reviewed.
>>
> 
> Hi Pengpeng,
> 
> Thanks for the patch.
> 
> Recently, no new Chromebooks use the GL9763E chip. This driver is old and we only want to keep it stable.
> 
> This modification comes from a static-analysis tool, not a real bug report from a user. On our side, we only
> have the generic EVB board and we do not have the real Chromebook machines to test this change.
> Changing the return value from 0 to a non-zero error like -ETIMEOUT might bring unknown risks to old machines,
> so we think it is safer to keep the original code.
> 
> At this stage, we want to see what the maintainers think about this. Thanks!

Currently, the mmc subsystem does not handle runtime resume
errors, so returning an error isn't helpful.  In this case,
returning 0 is a better option, so the existing code is better.

> 
> Best regards,
> Ben Chuang
> 
>> Fixes: d607667bb8fa ("mmc: sdhci-pci-gli: Add runtime PM for GL9763E")
>> Assisted-by: gpt 5
>> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index b55618566d65..17717b54e08c 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -1888,6 +1888,7 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>>         struct sdhci_pci_slot *slot = chip->slots[0];
>>         struct sdhci_host *host = slot->host;
>>         u16 clock;
>> +       int ret;
>>
>>         if (host->mmc->ios.power_mode != MMC_POWER_ON)
>>                 return 0;
>> @@ -1899,11 +1900,18 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>>         sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>>
>>         /* Wait max 150 ms */
>> -       if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
>> -                             1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
>> +       ret = read_poll_timeout(sdhci_readw, clock,
>> +                               (clock & SDHCI_CLOCK_INT_STABLE),
>> +                               1000, 150000, false, host,
>> +                               SDHCI_CLOCK_CONTROL);
>> +       if (ret) {
>>                 pr_err("%s: PLL clock never stabilised.\n",
>>                        mmc_hostname(host->mmc));
>>                 sdhci_dumpregs(host);
>> +
>> +               clock &= ~SDHCI_CLOCK_PLL_EN;
>> +               sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
>> +               return ret;
>>         }
>>
>>         clock |= SDHCI_CLOCK_CARD_EN;
>> --
>> 2.50.1 (Apple Git-155)
