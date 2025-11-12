Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4C35CBC5;
	Wed, 12 Nov 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930168; cv=fail; b=pJrrBwu8/ukNj7CPaS2LyibXj5Ks/o2jiBj37ti0SASNHCMIgc3/mA8lM91afI5x7IGpFJQnbB9+USO7upnqlX/NuGOGzrlzDm89Gtt8g7Lc97yCgOk0VK5sBnmEh0CAZbQowVa8lCIOBkxI5ieYBWcAIZDCMaGGwufQp8Q8O/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930168; c=relaxed/simple;
	bh=Jbsooar2X5zbM2jFBlJaS7gQpODEIOy8QLIhGhEjhyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+LqOT+dlEL/W1FYzA/T5WZmZScPvPu4rFgstghfGmHqp1/rgzCTv+J01/obJnIy1VQX7tPAWullp+kC6aFQCzVabg9iBaufJxm7GGwNVhVwtU1f80a2FvGxxxIgDhtUqh+9GHkTOOKdQrEkSUohE/quR+7ABLln4immF9GXjE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbtBUPfS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbtBUPfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762930167; x=1794466167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jbsooar2X5zbM2jFBlJaS7gQpODEIOy8QLIhGhEjhyw=;
  b=AbtBUPfS/t0sFzoXS0kVXuP20HdF+BnXoK3GJ36opu4V9xmTWO2tm2ox
   gAYiHb+dXes29Wh4Al9Up3vmjlT0TtfA4nUqw4hk8YV4LOrzLa4qObh8O
   FyOjVoQVp//VBTkZCd8nHXkvNAR9XnfEBsp6p5vsyuvtF0KD8BO3zdDyE
   g2WsPH0yN5GDaGpiGRhBfAUvjnTt9TffTTiEiC/Eg7GEHaibcGVp1fWIL
   JCMPKK4+HzkjzcGW0tBJDx4easy5+VPXCnHJYpCoAthuzGVdBIwGj125J
   EN1Jt3MMXhSjdlO065mXeXVFzI/4V5QRbbdnoLkPfYF3Q5BstyaYc8pCX
   A==;
X-CSE-ConnectionGUID: i6sxhs21TW6AM2gNfEQ1vQ==
X-CSE-MsgGUID: N1BfXx6hQM2lbd+3LPHXcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="67592667"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="67592667"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:49:26 -0800
X-CSE-ConnectionGUID: rAFdMyRuRF6+WUbbT4lipQ==
X-CSE-MsgGUID: W/W91jbETpaxWrdTd4jCvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188400241"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:49:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 22:49:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 22:49:25 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 22:49:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaLS7iyunrb4Bw0Zfv2VTbLi0AgZmcAorns9z+a5NF83ZDMtGH5P5OlR/v34qYkxxhJrt5Za/OKWZYiPCHW3fxnCVK+5GKVgz3IrnMQ+PkmGF3pj4pKsHzt13GPqsxp4Ws8yh0VTKRBdMpxNWIJ5YCD274CznTnLC+zItW9MBIeJttgagibNd7ALNClBh4/ud+sOwmN3BlN/CqdGvprd8UMQ4fpIhc+nG5pmK154mH4c2ElNhB2xY3vnNJPzDgVS6ntfvesmf5fhWIht/vsP3UrfBFOeFGSZSuxZObZiZtmYZL+U64NwjjWEKF47J9wb4ljpOELlaOb3mqzYfiRZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPLboZ7uwubkFeIyuQQOxxepS596a9aWGYlmyeEZUZA=;
 b=Aevn3VNSp6Kum5aO0QnV3zFPVsDLeSK1Xg+03dSxvFmeurGH5pTHOyW3YPq7EOZ1YrINd0H357l8NvFKVG2gVPE1OxD5HDj2gIH2mkFeyHIMsuDJeUVjM5jyW8iMew0vCtGSNl2IvcCibB3Tae3C7PEizjj7/5g9PsLwm2b6aUz9X44D0zkq606hulj1cSoJkfzZ5SgOhpPZUrMXac7RyoLZlcdwVnC0fLVKbobzxXnubdIQnKimj8YivyWEvGK5JJJk7LWM85zv5/H2tlj3cvyz/cbpj6NOXP4zwdUKp3d2OrM/DkzNqj4jealKNjhqGOQ28SlIZ9LqxjpdmCUWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 06:49:15 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:49:15 +0000
Message-ID: <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
Date: Wed, 12 Nov 2025 08:49:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>, Marco Crivellari
	<marco.crivellari@suse.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker
	<frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
References: <20251107141654.226947-1-marco.crivellari@suse.com>
 <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::17) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b413f0d-b9c5-4a02-987e-08de21b79875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGhVMUNZWGFGcU1xTWkxeXk5S3ZseEd0bDYvVGo3c3N4N2JMaHNzbnE2QTdG?=
 =?utf-8?B?UnRCUE5PUzhFaXhBU1NLTGZ5REJUSjFobi8wTEFZckk3cnpyTXhqR292VDNz?=
 =?utf-8?B?NXVaY2tqaTE2OGU4dEd2MVdDeTE3NHBnaG1BYzRaTkdGUUViaC9ML2xaU1Fk?=
 =?utf-8?B?SmVtenJlSWxESkovajk3QUM2emIyODY3NlFLSG9PcGt3SWZsdDNacW85RTdn?=
 =?utf-8?B?UGtuQk1RTmM4MHEvQ054Qml4OTNxSTE5a2l0NHkwRXF2elJCRFhZamxyQ2tL?=
 =?utf-8?B?MERDa2loTnJDaFdTcTF4RExFTjFCemVReEV3OXBLdGJYbXBrWHNzT2x4SFJm?=
 =?utf-8?B?cU5ndWJuaFhENDV3RHMxM3BQRXRpbUNXbit6Z2dIRVZnWnVDbHJqOTFiNVcz?=
 =?utf-8?B?NEUzYVZMTHZQYmxRZDFFZ0tlR05HNnBxdXJ1SnAvMkJ1RGFudmFXRjlJYUFD?=
 =?utf-8?B?c2xLbkpYUGtrZnJpaG5qN2tFS1hzZ0FyNWpYY1ZKYTJ6ZkxicVBkNnFHOWFD?=
 =?utf-8?B?K05sbm45aG1iRXN1S0lxa1dBYkI2VVNHZEtRc0tzK3RDcDB1Mm5rNGo2bEZS?=
 =?utf-8?B?ZXZYeTlGbFo3d2RkQXJUMGZTZXdNMTBUSDBna21Dbk4zb1pjdVgxcy9CTlht?=
 =?utf-8?B?MUYxaXF5eFZWa0ttbjUrNVppQTNVTjZhL2kyenJReFc2dnlQNTlRb082Y2I1?=
 =?utf-8?B?aGZFVy9tTGhVczJuYTdNemswVml6YkFVZm5lK3BIS05EWlBTTFJ4VFFRSll3?=
 =?utf-8?B?eitwNFVRVVFWanNXc01pQ3U4WUgzc2pSY3Fad2pDZ2ZYWGxTMG9xUHJrSlRo?=
 =?utf-8?B?Zkpzd2xmb2pkNzQ4dXpuK3dKelVMMjAxdDlNb2hpSVhoUVZOYjhkN1FUZTQw?=
 =?utf-8?B?aTJVNWhYY2FtejFwRmtjV3BnZlkvaEc0aW5jdW0zZzJDRE9PTlN0OG5BTC9w?=
 =?utf-8?B?cUZFNlQ5ZFVMVkRIb0p0NG1nK1lTbFdNa2grMmdITHNDTlVMcWN5VndObEo1?=
 =?utf-8?B?aEVPY1JISm5wY2NIU2tLZGhyNmRPY2F4ZE93dmxzWmNvdXRuOXcwN2V5V05j?=
 =?utf-8?B?K0JBejVjeWV6YmVaNnFHUlhmd1FsUWVFODJTbzhhVjhqTmRIRm5LQkVPWWdy?=
 =?utf-8?B?eHdTS3lxZ0llTWJ1d1JXNXFVTTFKSE5BQTRyUExlKzNXNWxLWFJBZzVLcjZ1?=
 =?utf-8?B?UXhwNlVmNyt4S3VlUXdvK3p1bXM4KzB3dFo1ZEdOam5vUTNVSS9CZmtLVWxX?=
 =?utf-8?B?UVBTWHRoWUVMRzNXSWZiMXAvZndrR2ZvY3o4R1pJaE0yKzk3WGN5YSt6RVNV?=
 =?utf-8?B?OE5lR3NTVkpOUThoUTZicmE1clJXTHc3TnpKS1BYcWcyWjZLZzlDRVlBblha?=
 =?utf-8?B?cEhyWWZ3MnhjSzRyL2lPb0puWm1oSlozNFNYMS9SVnlMYTVHeUpyZ2J3OHRx?=
 =?utf-8?B?MWg3TXlIY2RtbGtrWklZdTVYdUlGWENnVTlmWk1kTm40MmFtMS94aTh3Y3JL?=
 =?utf-8?B?OExDcDJ1amE5NGdEdGZwaGdBVjNraEp1VUVHSUpuMlUyYXg4RXRINWdkSjlx?=
 =?utf-8?B?N0V4cU9Ud3BKQTlmazU0YS9BRWNyUFpnemY2OG1rQ3Y0eCswQVEwZ0NtWkJ4?=
 =?utf-8?B?VUFzRU5sSmpDR3NYVGZnYXRUVlczd3JWb0VnTmdNUDgvYWJSNUFUTjcyTzBn?=
 =?utf-8?B?Sm1xeW1Pa0Zhb0lYRTN5ZERmdkhxV0ZtQXpQTElqeDEvbTNVSkszRW1HSXlC?=
 =?utf-8?B?MSt1WDczcDg4ajZwMEMrTE9tbnBWTEQvRDBYK0owZTB5TnBzaFNZb21HTWRZ?=
 =?utf-8?B?bGsvUFZXR00zVUlwUkpTQ25EUVFOTXkxVG5YOFR6cm1iWlpTZUF1M2RuQTA5?=
 =?utf-8?B?RnJXWTlkdyt4bFg3N0lvQ0VkcC9kdWlxZXdXdXlJS3Z2enU0MTZ5Z09kM0k3?=
 =?utf-8?Q?Eo3DbsfHBDF5+gGJd4W9vQikdMkPaCs2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ppWVZhYUlzY2ZVTHhFdzlLY3R5NW5tMmMxbWdzdnB3L25ScVhsRlFTZHo1?=
 =?utf-8?B?dzd2ODgrSEZDdy9KaGk3dTRvUk81UnRHYzdnVjVRd0tMWXAxVjYxRGVsWWhu?=
 =?utf-8?B?SVNxakpVNkZPbjFQZE9lNEQ5aUxKNkNvVE9PNG9hRkVtZU5ud0pmU1B5Sks0?=
 =?utf-8?B?YVRGRUc2S0dTMWZJQ3phdEZhNDJoZlE4YW4xWThHMVVPbFlab3BvRkZobVhk?=
 =?utf-8?B?ZjBqRkZpQ1hxMmU4WjQ2Y0pISFl3TEF0YndJMk9URjhrbFlLenBMUXZESjJs?=
 =?utf-8?B?a0kxa1A5Rk4weTV4VXg3d0lvcXVpR0ZhUWJsKzdkWENHYmF5OTA3OG9OZFRl?=
 =?utf-8?B?YkZSNDEyT3pNLzVIbFlwaEx6T1BWVmRMUlRob1V3WFM4Ni9uT1FSUjB2T2Fr?=
 =?utf-8?B?WE9UU3RMa2UzdDNVcVkzSHBabUNMaStxZ3NENmpBRENiVWRERWhkZm1SK25z?=
 =?utf-8?B?czNSWFpWSEtnUnFaWnAwTlZQTmNGTHFYZEtEa2dHVzc1d0NOSEt4RnRZUWJq?=
 =?utf-8?B?Y29aZVhhMmlLakxDNE9lN1FqSEJLNWtFMVVkVmhXTXBZYnRQWmJYdHFZVkFE?=
 =?utf-8?B?MjR2Y0N1eHZmN2twRFJkazdqR1lSSCtteVpHOTJEQUtYV0tNL2ZhTllIY1Yr?=
 =?utf-8?B?RTdZRjFHR2hsRlpOR3JDb0RvdEtiVG1XNmJUcUd6NHB6UjB5eG52WVNoUVlG?=
 =?utf-8?B?SSt6WTNXalF6cW9LaGxpa2RzS2NaVmlvVng1ZjYzOHVFUUlZWVdxc2FPRllQ?=
 =?utf-8?B?ZStwY3laWlo2WkdyL2YzU3ZKQjNuRTZTQi9HRzhOQTM4eStXbmxGZGZSNXFJ?=
 =?utf-8?B?T2NvQ1dETWlkN0xVamdWQ3VTWldudkczK2NkU0pWcUwwM2NnL2dWWVRZTjh5?=
 =?utf-8?B?bnA0ZHJQUEtiVGVVU3lsZ2p4RnZmTlRodDNLQnN3NFl4NU10UTB0Z3EyLzE4?=
 =?utf-8?B?U0RpSlNDNXBDeWFIVUNWOUJybEd1RmF1R2RSbmJXYUZieDJLemlOdWFlZWw3?=
 =?utf-8?B?djNJWU1HNmE3bEYzSmEveEFyZ2EzUDc5ak9uY0lmbTlIdXRyVkRWTFpPUEQw?=
 =?utf-8?B?cVg0M2p0RTltYXU5K1o3VVd2a2FydW9Ob0ExdS9mMzJnS3dYeTIvNXhZdFAv?=
 =?utf-8?B?OUN1T25pNFlHcDV4RENVYmpPRmJoWFFMNXRDMmxIbSt1WGN3My8vSy9qVGt0?=
 =?utf-8?B?U3k1ODZrd0tWQXZydFAwcFFVN3ZMb2xlT0dleGlSM1lHWFBraVdZUnFYS2I1?=
 =?utf-8?B?Vkp3UVhmTHAwMG1tdUtWTk9JT2M4cTdwWDBsajVZN0pxZE5qNG9Fek9KY2xw?=
 =?utf-8?B?Tm85aDFNWGdvTm5IdVRYYUg5eVdacENtbkQrWTR2Q0x5L1daQmcrSWVBUFdh?=
 =?utf-8?B?S0JHSUUyVjRWbEJpWllQNjV0eHlHcEszaWxBZDNkcGdKWFp6SDQ4QURTN2p6?=
 =?utf-8?B?S09aWkNkRXI3cWd1K1R1WW1DQ3J1VkdEZGFNT2hNU0MwYjVORHpLbUg4UkdE?=
 =?utf-8?B?b0FMWmpsbmtGbHpNS3RmOEZNUmFreW4wcHdSUVp4dER5cDF0bE1rc0sweDMx?=
 =?utf-8?B?UGxkcWhQWFg2U1ZQbmR4SmgzeVFrNzArLzdmd2JiZTlMc2h1N08rZlVRR1E2?=
 =?utf-8?B?SG1ndklDNTlDa1ZRSkZZd1RuclNiMWE4aTUxNHBTejhKQS9nK01zRHR6V1ZC?=
 =?utf-8?B?WDBScE43R3owT1ViMGJTOUNxU0RFQk9GbVhZTWh0NXNPL0tSNjB0UlNvb0l5?=
 =?utf-8?B?TFBYRGdGNkFYenRlMkxLem9HVThxUDRGZ0lTUlNneWZqcng5bllZQWVzNU12?=
 =?utf-8?B?SUNhZlQzYzR2bHZoV2pnYXVlbUdOZGpybmdrTEdKOGtCblJHbGl2bi80bjVz?=
 =?utf-8?B?MW9PSE81SkIvcWx1SzlHcFY1ZE91Y3BBOUhMWDBuQ0VJNXB0OFRnaEFZMGFT?=
 =?utf-8?B?dXdkV0NkWWVXK3plZVpMamMzUy8rTHRsQmljVk5HZmxTU0VteUVJWVNDd3lI?=
 =?utf-8?B?TUR0WUluSGZhU1BPL28rdVMzNTFjRTl2TXZ0REpsUDBxMnU0azdjdnFDQ21L?=
 =?utf-8?B?RWFDN2s4OEsxWE13c0xmcW9FTzFOVnFRR3VWSkFOUElrWEpSMDRXWDRxWFJq?=
 =?utf-8?B?N3ZWdTVKeW9udzgxcTNiR29qRGpxSCt6aVZJT3V0RElFbVYrc1gvZG5pQU1v?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b413f0d-b9c5-4a02-987e-08de21b79875
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:49:15.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQdkDnhKsqhBaNnBjxU2WlW6tLjccIhCe/mQeMoLn8yp/3eMAOLGcFaVKvXMtfLFa+dtOJrfCY5XE7MRO0yDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

On 11/11/2025 19:12, Ulf Hansson wrote:
> + Adrian
> 
> On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.com> wrote:
>>
>> Currently if a user enqueues a work item using schedule_delayed_work() the
>> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
>> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
>> schedule_work() that is using system_wq and queue_work(), that makes use
>> again of WORK_CPU_UNBOUND.
>> This lack of consistency cannot be addressed without refactoring the API.
>>
>> alloc_workqueue() treats all queues as per-CPU by default, while unbound
>> workqueues must opt-in via WQ_UNBOUND.
>>
>> This default is suboptimal: most workloads benefit from unbound queues,
>> allowing the scheduler to place worker threads where they’re needed and
>> reducing noise when CPUs are isolated.
>>
>> This continues the effort to refactor workqueue APIs, which began with
>> the introduction of new workqueues and a new alloc_workqueue flag in:
>>
>> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>>
>> This change adds a new WQ_PERCPU flag to explicitly request
>> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>>
>> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
>> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
>> must now use WQ_PERCPU.
>>
>> Once migration is complete, WQ_UNBOUND can be removed and unbound will
>> become the implicit default.
>>
>> Suggested-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>> ---
>>  drivers/mmc/core/block.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index c0ffe0817fd4..6a651ddccf28 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>>         mmc_fixup_device(card, mmc_blk_fixups);
>>
>>         card->complete_wq = alloc_workqueue("mmc_complete",
>> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
>> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
>> +                                       0);
> 
> I guess we prefer to keep the existing behaviour to avoid breaking
> anything, before continuing with the refactoring. Although I think it
> should be fine to use WQ_UNBOUND here.
> 
> Looping in Adrian to get his opinion around this.

Typically the work is being queued from the CPU that received the
interrupt.  I'd assume, running the work on that CPU, as we do now,
has some merit.

