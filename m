Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBA2253AB;
	Fri, 29 Aug 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447919; cv=fail; b=ebhpJjeAqwBEPWIF0fw/JiW4OJtMia5era8g20hIK2joMRL3QzNlOm4zZIsnJYYb3I8qztyYjiPjUrZBUsMEeuuHRaAyr1qzz/978a1aeK+C47+hU9IGC7/fut+O+RKa8V7jfyY0hB1zjNzdalY4D5TylOT7r2XWt7Ix3HW7TKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447919; c=relaxed/simple;
	bh=Au5k9zxr7xq9JWHR61K1bRMHu7aF34NnpKHXdIFrnb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DO8drB1+MZWfTV2/JhvMWKY6L55VykTGnUu7mmwBFRQTszdq3dEUjpNrNGTXfKrOYzDeqn8wm+qUrgR4TKmPxR8wFGDe0rfGfc4Ufqq7aTR5ZU/umVZQ4/uyjfAutVAaTVCploZk+x32Of1dgavui6WzNPFU+3jAPAtfc48BPdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoGf9Y+n; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoGf9Y+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756447918; x=1787983918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Au5k9zxr7xq9JWHR61K1bRMHu7aF34NnpKHXdIFrnb0=;
  b=BoGf9Y+n0zv3P8K8act6apndcbReOg7zUk9wOaaS4CREXBudE7n3F4ZG
   Fe+Dcmh+ObVYjhhPRN1J3wMYHeZ9jHCpuIb2HFPKR3e8+EMRqw+kl+cqw
   6x7cZ28uy8s8LlEGuKr15iS1z7RSEEqOZmqQoe7rWG5kDsujQLq2V0lE1
   Y+zzm3aE1zyYdo65ZlQovOISwRHTVVyg5exWqWvKws8X+us0gWFF21/Zw
   qtBQGO+wOYJ4FPJo5RfhuSR+ngpSSuMhHleXqPrU8NcfaotTirU+OvrT3
   bRiehbTxToiMeidk2sj70jSx2VjWULYVjK5RG7T2oKqL3ta9lp/6eum9u
   g==;
X-CSE-ConnectionGUID: /0l750ejTJ+yadgQO3IlrA==
X-CSE-MsgGUID: Z7ryrWUURvmxoTok8SU+3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69324326"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69324326"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:11:56 -0700
X-CSE-ConnectionGUID: i65iVVSDSGisp+CwWS6DSA==
X-CSE-MsgGUID: IqX0qy8XTLW3B8jmAZh7uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170693772"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:11:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:11:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:11:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSYjCWaaDX4MQf15iuK2Jsg6+0wHcJNORP4c12Kp4abJsGVUUNKV+fdBYyPE01XYJtJsMdWvO6/x3Fl+2O0B+9y5lEyiNiUW/m/TiZHKhV6dot1tiq4KsNV8B7QSPA9A+D4uAJ9jYeSldqs7D4IcPb1fnOHAxvusXbe0vP1X7PwXT6MmMdxTXPjzdYvky8wQmF0BK5Mwg5Jux+vyNWWpfMh8HedQ+xh0xiX4oOI9rE+m3io5q+U5QkN8PZWE1wPHd0hH2N+L6s7hlGZe65gT0FqdKU1IMM7wyCP+OL3mfGPNwp6eH+TvscaNJXlt3+3GVMBjf+Ku6savz3FTFMXyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7Fe62AJhsgTxhRVHOkbHseqMmJ8TWylBnXcc1WYtJY=;
 b=KTTAV4UwXcwkfbUaBz0dBC3ToiU0544Vm+lwTN4f12x44rAiNa1OGyoIpjo3BFZka+zPG5WsNNJicud0bD87rUm3JYN1GXlYTpy8LQgVUMhsancojdfERgHT7mexogKsDh9ZZLyme1OFj8c4mh0h4JZqH71cV23JlBw/FueTqfRf/ZNrjUolnxA977k0ikhYYjgYJPH5UE9git+gSDA6se8TWeDR6vPMZVOf7QYb2ZP10pXsOpTqNh+/s00s/qpb2Q21MotZNhAyeZgnfHzrvXUysVExdw7UW8dyA12sff+VA7CJAwdep77S23NKrQyQ05KL55d3beLKcvhCmxNxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:11:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 06:11:37 +0000
Message-ID: <460f183c-8d88-48e3-b8c9-37d0184e1a33@intel.com>
Date: Fri, 29 Aug 2025 09:11:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: use regulator_get_optional() and
 reuse pbias in sdhci_omap_regulator_get_caps()
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren
	<tony@atomide.com>
CC: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
 <20250825122149.2169502-2-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250825122149.2169502-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:10:234::30) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d69c0c-4b68-47c2-21ca-08dde6c2e9ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1dWQnFRb1p5Rmlyc1ZiSnhtQ2g5UDFEbjY1UngwdnVPRTluejcyU1NZQU9W?=
 =?utf-8?B?c0dvM04zVEhRNHE3SE9oMGFaQmt6Q2NPcWxvUDNKN0R6a2V0V3BQNUFWK1ZM?=
 =?utf-8?B?a012RUxqMzhOajdDejVsTkdOOGlVSXBleUNNeVRCalVBZVNiWDM1eG5GNU9m?=
 =?utf-8?B?RFNGZXBIT284QzNPbk5DTXExREVSOXJtbFBINXpVK0RNOWFKeTNFYVhzWE1r?=
 =?utf-8?B?ald1NkxkT3J2WFFZempESUxyWmVoZExsYjQ4T3FudlRncjN1QjVrRkJ2cXc0?=
 =?utf-8?B?bWFwVGpZdFlpd3Z3RXFKWmRLemxBNzBoRWlZdmtFS1djZEhlSi9QWWUvWU13?=
 =?utf-8?B?d2l1a2laNTUrVHZvOFBWMWlYKzV1ZklKL0hZU2Vzc3JLbW8xWHdrakhCbi9j?=
 =?utf-8?B?MXZZOXNJajloSW9JTm9maFVUSllOR3ZrcFh6NFVaZjgrQmYvNzV1VDlkZnJF?=
 =?utf-8?B?b3hzb2Y0ellFWVUvMFBhTzh4dzZhVllPZmlQZ2FCdm05RTJNellUTUZ0aU5U?=
 =?utf-8?B?QXlXSVphMXNmbHdJSnlnTGdTV2dyOFByTXFjRFdlcEgzWEtVOFlHVGd0OUlu?=
 =?utf-8?B?cUM3LzVXWks5UUVTUjhFVlhVaFFhajN1b2twY1hTQzgzMkpWUDkvVmxpeHBa?=
 =?utf-8?B?aFVyai9ZdFhZM1EyWW9JTXlrTXVOdlpleWdvNkYxYm56eElLK09kalhFditz?=
 =?utf-8?B?Z2MxaFNrcWNRQW5abVFldisyMnJhMWdQYWF0YVhJNTUxbGlOWlVoai9ESFVi?=
 =?utf-8?B?R2dJVjhzbERVc1pqWm1xdWNlNmRFYjBMaFUyWDRxSnF6bThYZWljb0xnUGpR?=
 =?utf-8?B?U3M5SUpFU243WnNDQlNlMEVIc0diYVpiNzA2VnNkbFlUb0JXSUREVVkxOUoy?=
 =?utf-8?B?Q3ZMKy9PNnN2cVBEeVVEK251YnQwWTByL1VWMXpZUXpSOFZYdmRYZVF4Smxx?=
 =?utf-8?B?dXhEempEcmdRdTNqM01tVkJCdjdVcjlQRzFwSzk3NkVqSVB2cHhsTElIanNG?=
 =?utf-8?B?NkUxWGpaT202c05sKzExOFlPS28rbG9NUFYyY1cwYTZhWTVPam93ekJLSGdV?=
 =?utf-8?B?OEc2RWtuWU9aanJVbENDTjRoMENjREdoTlRCUWVueldZVGdyZHBKaDd3QTVZ?=
 =?utf-8?B?ZndBcWZieVZ1ek9FTUUyOFFXditsT3ZrNzZXV0hXTHlwMHV6aDMvclE5Wjd4?=
 =?utf-8?B?dHBMSzRBeGVNWTdpdnpZbEFOK3BxNUlPcW9ISzFjNEZvSXRCdG5OcGNhTy80?=
 =?utf-8?B?R2ljRkhBR0xVdHF1V0lqSnV2eGhrcEdvd2hUQURVWHVSalNBN2Z3WVZ4Q0Vs?=
 =?utf-8?B?SExPYVVFTTdBK3lwSHp4QThBYzdhd1o5VjRwTE1TNTZpelRsdmkxY2g0TFR6?=
 =?utf-8?B?cUwxOHQ4QTBKb3VqMCtDMGo4MWVoOFppNUhtN1lkQ3RNVk9ZTithWS9sQTlW?=
 =?utf-8?B?VVV4THd3cUdQNTRDd0ZXM2psVWxla2tZT1k4Y2J4VnVyVkhtWjBXV1QvRVVB?=
 =?utf-8?B?Y21TQWl6Y09OWlR3dWE3c0E2K0lpamVKYjNKQUdlODlPVy9Obk1Ib0c0M25M?=
 =?utf-8?B?UkprWHJKa2hVYzBxMFBCbVhQQmsvblVySXhhc2RWYzgzZmdWVWRhMFBPRUk3?=
 =?utf-8?B?NmdyZ013MTBaYU8rYmkvV2hEKzJSOGJPQnpVdS83eFRvRlhUM3E2a3lJWW9k?=
 =?utf-8?B?c3pHb3dqZnoyOFkzNjJldGxtRXdOVk5aVno2OEdpL2cwVnA0TWM0MHBnWEd2?=
 =?utf-8?B?ZXMwRkFEeTVoZlAxeGdLaU51QnpFTk50cUM1Q1ExSURjMjEzZEdpUVlZbjdE?=
 =?utf-8?B?ZFQvVjJOTUx6UUFKUk44MVYvdHJnYXpmM3FsOUlwS1pRUEh5bEpLcENmV3JQ?=
 =?utf-8?B?QnpBOU1vU05UZTZJUHBpY1oxRkVYeXZmWFNRYVNZYlNiM2JqWU5pYUNyeThF?=
 =?utf-8?Q?kK5Wl571Vxw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBEdHpwbnZjTU9sRWY1b1JhZkp4Z3NvRHQxZkZ3NjRYRWoxZ3lZejVyWjVy?=
 =?utf-8?B?NjRCcERvN1BCNDRkWVB1SXpUMmRTcUdKOTYvMkl4Q0ZKMm5McHhjRHgrU2NV?=
 =?utf-8?B?MFB3cjJIZG1yd1g4MW85MmlidUd5cWNOS3dPbVhiKzUwUzNpTVNJdW9TcmEr?=
 =?utf-8?B?TWRXWVVrNHlsQnVTRDg2M0pHQ2s4R254RG9pWmtFdmxPckYzT3NaaDZaNjY1?=
 =?utf-8?B?UFRvYkhZQy9uQ29SZGt4QnZCaDV6WHc5YWgxd3doa0VjVkxlY3VmMWRPUitW?=
 =?utf-8?B?T05LcUszY3l0aml2NGpUYURWOFF0N0VUajhpNXozeEI4K0pNYWVGVzZOUG5m?=
 =?utf-8?B?bkxoWjdCN0JoMU5VWWJaYUhzRTc2M2dVdXJLMWx5RU9jT3B1MFF0a1k5R2Zq?=
 =?utf-8?B?eGVGV1NuREgza2hqZkMvRlVmY2RheEUrSGxzblhPdWJocm53VlpseDMyZFkw?=
 =?utf-8?B?Y3JjNzZ3N0RVTE5reEhVZjBPZ1c5Ky9weDcyWUdGQWdpZEZvc0NBMm9LQS81?=
 =?utf-8?B?WVN0RWRMUUpGZE1pQVUwSG1ZMHliWmE2L0RUV1h6ejROc3dSWnRVaTd2dXFK?=
 =?utf-8?B?Wlc1ZU1xeW90Q21VUG9UR3RreGFoY1padzVUL2dYZGhueFhycUYwcDRmVHpt?=
 =?utf-8?B?OHRIZjhPaEFLM0dCWGRJYW5adzVYRTF1MnBERTFFTG1ubXY4OENBR2pxYzRV?=
 =?utf-8?B?a0c5cjd3ZjAzYXdtVndlWmxjQlhqRkE3QXN2Rm4rSXYvMnYyWWZWa1ZsTlNn?=
 =?utf-8?B?QkNPbUtKYzRiRGtVV2F3aWRlQ3dkbGJpaU1nUUh5YzFUbnVsZVI2Qit5QWhD?=
 =?utf-8?B?bjgwemJaNHpaUFQvMWV4QmtVMlFLLzFsRnhDRzFZdXQ0QnZlTE5hakV4N09B?=
 =?utf-8?B?eGd3QWZpOStxT05iN1Z4TGZTZjg1dW1NMVpYMkQzOWVoUXdLVlp4Y3hqSnMy?=
 =?utf-8?B?eExZTWFDaitoSk9nb3pnMlJoeEowWTJlRVd0ZzhQaTF1OTJVTTNUdzZvd3NY?=
 =?utf-8?B?eUUwL09WUmxJbEVGN1BJNlh5SkdiWEt1NHpqZzErT3Bsa2NZeFZxczFhN1ZI?=
 =?utf-8?B?bG9qbTBOdXZtalVDaHdnczMzbUtQMEpOUXFxbHB6WjVvS2dCS25Xajl2U1RZ?=
 =?utf-8?B?aXhyalRaTFk1N25CbGd2R0UrTkhHQ1NycitVZnQwOGoyVEtqM2tzVW04U21S?=
 =?utf-8?B?dDE1aFF4SW4xcGNGTjhiSmV0N0ZHQUNEUTgrcGVlUUhtdnBBN3RCbmdnQ1Z2?=
 =?utf-8?B?NklCVm9kWDI3SmFkN0EwNE44Qy9JL0FXQmVrMnJPdU9sbC9uTVllNDh2R2Fs?=
 =?utf-8?B?RGg5U1hUVkV3eEZneFNNMkNYWlZoaklhM21RVXNkeE9hREFGRFNKNVVlbzVo?=
 =?utf-8?B?bnBjWnZCWnV2SXJ3TFFQMXVUeXhFZVo3QTFmendiNTI2dG9hRTB0b2RiNXZZ?=
 =?utf-8?B?WW9HcGxtS0RiUlM3ei95ZWpzZ3Q2Sk9JbFhEem1ISnZBOGczTVFvN0NBK2RT?=
 =?utf-8?B?bUs4N1RpMDVDaVh2aFJYMTRKQVBzYjJDSXhPVEZrK1ZHUEVJeGxGem5GYWgz?=
 =?utf-8?B?QU5Ca1I4Z2E4b3prZGRmVGpzallrQkVNSXM1QThDZXNVYUxhZTFoY1NiNEh1?=
 =?utf-8?B?d09iMjZ2ZmFWclVacStzckhhdndhSytBUmk5aThHU3psVXpYNHkyKzVlTGJl?=
 =?utf-8?B?RTdtTjVFRDZlZzZ5Nmw3d3lQNi9SVVkzcmdqVFFLK01PSzIvZ0Y2bGo1bjNT?=
 =?utf-8?B?ME1zRWZtRHVlMWFNTjZxbCs1ZzVOVFdMSXV4RXd6S3FRaE1NMjBhaW1DSW1r?=
 =?utf-8?B?TlBBT3NYUEFWNnpIUjFpR0YzMEdtK0ZVa1pTTTZMVUZtcXhHZWhzaFk1d3hE?=
 =?utf-8?B?bGxpZ01RRkc5VG9rcExla0FOajBuU1o5VVpaL2JKK1YrQk1FVkw0R3hwWHlM?=
 =?utf-8?B?TXRUM1J5T3FhUlRjamtnZG1SVmNVY1BLNno1TFlsTTFBMGpvclpseXVySVNX?=
 =?utf-8?B?cW5rWjVLTFVqeWpBR2pkaW1RckxOWUdxa2hDeGo1VHdrVkExMHNTNXZqWlUw?=
 =?utf-8?B?OStKRDI2SVhuTkxvMjVnQ3FYb2JKVS84OHRNNENHbUJsVnBqSTBhcFNxRXMv?=
 =?utf-8?B?RStJWmtUNHF1ZWxZOUNCLzJ5bTBDTGdKUmVLMTNjNmp0QVA0aVJYbTlVZ3hR?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d69c0c-4b68-47c2-21ca-08dde6c2e9ae
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:11:37.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP6VqjkxwKYRD/PIdpOxIwcdJ61FLsxwLSfPS8n+sLzxFw1gsLI7pPR8bEz4JWplxHossAtMhD2vu/dRVyJ0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
X-OriginatorOrg: intel.com

On 25/08/2025 15:21, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 
> We actually want to get an error return instead of a dummy regulator
> when a supply is not set.

Please explain why here.

> Change regulator_get() to
> regulator_get_optional() for the vqmmc supply and reuse omap_host->pbias,
> which is already initialized at this point.

Probably better to make "reuse omap_host->pbias" a separate patch

> 
> This change also avoids warning messages:
> 
>     sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
>     sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
> 
> Fixes: de5ccd2af71f ("mmc: sdhci-omap: Handle voltages to add support omap4")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 08d5a82b7d01b..4623781adba7b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -939,16 +939,10 @@ static const struct sdhci_ops sdhci_omap_ops = {
>  	.set_timeout = sdhci_omap_set_timeout,
>  };
>  
> -static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
> -						  const char *name)
> +static unsigned int sdhci_omap_regulator_get_caps(struct regulator *reg)
>  {
> -	struct regulator *reg;
>  	unsigned int caps = 0;
>  
> -	reg = regulator_get(dev, name);
> -	if (IS_ERR(reg))
> -		return ~0U;
> -
>  	if (regulator_is_supported_voltage(reg, 1700000, 1950000) > 0)
>  		caps |= SDHCI_CAN_VDD_180;
>  	if (regulator_is_supported_voltage(reg, 2700000, 3150000) > 0)
> @@ -956,8 +950,6 @@ static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
>  	if (regulator_is_supported_voltage(reg, 3150000, 3600000) > 0)
>  		caps |= SDHCI_CAN_VDD_330;
>  
> -	regulator_put(reg);
> -
>  	return caps;
>  }
>  
> @@ -967,11 +959,20 @@ static int sdhci_omap_set_capabilities(struct sdhci_host *host)
>  	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>  	struct device *dev = omap_host->dev;
>  	const u32 mask = SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_300 | SDHCI_CAN_VDD_330;
> -	unsigned int pbias, vqmmc, caps = 0;
> +	unsigned int pbias = ~0U, vqmmc = ~0U, caps = 0;
> +	struct	regulator *reg_vqmmc;
>  	u32 reg;
>  
> -	pbias = sdhci_omap_regulator_get_caps(dev, "pbias");
> -	vqmmc = sdhci_omap_regulator_get_caps(dev, "vqmmc");
> +	if (!IS_ERR(omap_host->pbias))
> +		pbias = sdhci_omap_regulator_get_caps(omap_host->pbias);
> +
> +	/* mmc->supply.vqmmc is not initialized yet */
> +	reg_vqmmc = regulator_get_optional(dev, "vqmmc");
> +	if (!IS_ERR(reg_vqmmc)) {
> +		vqmmc = sdhci_omap_regulator_get_caps(reg_vqmmc);
> +		regulator_put(reg_vqmmc);
> +	}
> +
>  	caps = pbias & vqmmc;
>  
>  	if (pbias != ~0U && vqmmc == ~0U)

