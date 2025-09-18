Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCF199934;
	Thu, 18 Sep 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217026; cv=fail; b=e/PxkQYT1hB8DcLF9v8IHYkCDl4uDp7Ymjw9q0q3slrZjSfQE2mufddDom0MBLmH0N44+OcosiR6ju1oeO0KeDNSAcrMbSga5gBIW8joz0o7+OyDlo9xjOVKqh96DaFGIl2/QX4v8+fk0gZSXRh5BGHOBig1SdFthz8C+CuNlB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217026; c=relaxed/simple;
	bh=xZetzugRUa0F8cp3IgSzgxZT4l4h+bm5ZeBDI5LtIzM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USTAk3ykJvJxeZALXry7ELVIe+m8/FfLwg5C3krDuKS1AY7HqGFbbQJvRKjaVYfWsy9VD6AveJw7d9jFA3NkyrH65j1zCoV7p00xIww/gDctECSVhuGKmqqrCzJOqH5Y2jA/o3GvWxqO7U7Fk4ajMXuKbe0z/PQEaw7LNcixWzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2c3v7A1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2c3v7A1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758217024; x=1789753024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZetzugRUa0F8cp3IgSzgxZT4l4h+bm5ZeBDI5LtIzM=;
  b=G2c3v7A1wZH+3SXwj5coUiG4uQjr7lxI7UAOoiQp18l5CzG/cEV3rdK4
   RzCd98nMvLVkQuO91DGMB/iXOmd2yotVGQHxzyN7DvTX6IbinuCziiLFb
   UlKxDqs4nbzqSa6Czn1GWIZFuVlQNyh2iQexQtphP4UxOqVCFIpBXDI/t
   FBlAtAVtIP3GCpUB06wQ9tfnuMiFnGYKRmLxEOTUVWVOUdALr7jiSARQM
   Z257Kx5WQbwCKF9KafLCP8crjv37qanoLtFiaEYe2jHAiGxMl4YISg5Ia
   2I5ZEZR7FZW6L0kMbPnrNHfom1J3nuTRBB83pEbnzyNRnM6YwF2448Nqw
   A==;
X-CSE-ConnectionGUID: xix9EzNORdKFqmxyihmeVQ==
X-CSE-MsgGUID: GKj++sJvQ02P4PUanf6hLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60506421"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60506421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 10:37:02 -0700
X-CSE-ConnectionGUID: HAdJ8ixESGu5HSZWDyePRw==
X-CSE-MsgGUID: UIuQ/zQcTfim9cIRyJ7tgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175204491"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 10:37:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 10:37:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 10:37:00 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 10:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ/Cm2QnkpX9+b8HchO2uABau1V/pdTYAvBmzzf76CvdoBJZpDuqBpSjDUhQNpfdGshayIk9xY5QNkUfflrXALwO9+24/YlQAp+HgCY6SOgjoX9XhCfViNxhVqRfbZrvWeq8ZNWZU5JDG1Of6iKu75rFwXGY5GMVW8xc3T/49RHmgxVZLJdbgOUFlcmqaKtQLU3+XpKHVSDClJVboDx+8kckuU1A+R7hi8ti3074A8WWQ2icG6InPac8Yl6MjRJ38mdP80yI7vkTzszJnDFLf11+skkA/HaEBxRj2zU+OO0iEVI28NuKjAWwzZRYCdycECW+PMPid5ldh6335R/ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/GajYj/kyJjSO6WFl2YA4+P+2fENzwc+m0il0m+tYI=;
 b=OpjM3YZZzcqmmUcHS3OmeHUC+WmPERwNTsXaF9UybAWklFWNvR5c6rN3AtqtZJIRqPQL0X9l8iMTqAIPRjgp9vBXSyuvrIFGWcIzXcz3M6W/8zJVNA4naxr9fq0tvikOKGqrh3s5XSxPwoHrHNO3/zEXo4+v6ufJDc/fQcGrTQQWrF+4K3YsijsL/S+NhyPTSXZ2bpV9lc9JfeEgySOuA1wj22TshNbu6PW0DPuoZOBF9gITlxsR4+74dGbKnKrNAKqp+ZDSTa8tnmxT6l+OrHZHMQF3S0G4NKEhH60LkNhtrPEfhQiFJwDgib9qPdgezqxzsv3MeIlDz4lkQ2PA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:36:53 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:36:53 +0000
Message-ID: <e528c975-e2da-4e09-8af7-4e14e7dddadb@intel.com>
Date: Thu, 18 Sep 2025 20:36:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
To: <hehuan1@eswincomputing.com>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jszhang@kernel.org>,
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>,
	<luyulin@eswincomputing.com>, <dongxuyang@eswincomputing.com>,
	<zhangsenchuan@eswincomputing.com>, <weishangjuan@eswincomputing.com>,
	<lizhi2@eswincomputing.com>, <caohang@eswincomputing.com>
References: <20250912093451.125-1-hehuan1@eswincomputing.com>
 <20250912093803.159-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250912093803.159-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a9105e-d873-4181-14d0-08ddf6d9f4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1N2TXA5RXpLTjVVK3hFbDJnOUFxSVQ0b2ZlWnpnMlB5c0d0bkZvRUYrQlk0?=
 =?utf-8?B?V0x5S3NLUGJPTWpPSWMwbTlOQkNycDRwUVd1SjBzdWlRdVVoZUxaUVFrdnMx?=
 =?utf-8?B?VXhJdkZFVlp0MFExT0YrUXkwSTZaWi9sUitobXRDcGs0REh6NnYvT1FZZ0tE?=
 =?utf-8?B?SVhIWUVFdWhXMVFUTFVwVEFvalRMd3RrME1BdzdBVzlrUzU3OGVFbzQ0SXF2?=
 =?utf-8?B?Qk0zOTVMY3lnN0xHWVNLZjRJczU0d3V1RWhLd0dmVFhuNFp3T20zZUhueThC?=
 =?utf-8?B?QjRMUXdxVFVZUENrSmdDRmhwU2Nub1lVWU1tVzNRdzFycktIYXF4Sk4zVHlH?=
 =?utf-8?B?WmhMeDJaZm03RU9LQS9PdVVWTzhKNmd6dW5FMUVVdkZIakVLWlFoMWlFaUpy?=
 =?utf-8?B?MzUvUTJudUcxY2lidWdYbktyQWluZEpydjBCbzg3YzNJY05BWlRnQ1IxRW5M?=
 =?utf-8?B?WGxYc2h5anhRdXFObUZVL2VkL3NYQk50Q0tQTUVSQ3BJZzlLTTFRZ3hyNHhF?=
 =?utf-8?B?ekJ6YlFkeC9TK3JBWlNRSFo2WERuTTFqY2NDZGI5aXNTdlNKL0hSdXNkMDFr?=
 =?utf-8?B?b1h6TlI5ZGVsL1c2TTJCdFMxVkVXSEJUUjB6VlowWTU1K3A4UFZCeE5kb3d5?=
 =?utf-8?B?aTJkODdCWG5iZzIwYXNhL1YxazBlRWtkU0dGUEZjazFNa2k2dTJYNnovNlhQ?=
 =?utf-8?B?SkZKaWdmQWtUblF1RlhzTUN6S2pJS1M5T0hYLzZBRnNxNkxPcDA2ek5jNEt5?=
 =?utf-8?B?bzdmRVQ2SkRvQ0J1N2w0RnVtNEZqaCtjbUhIK0x0eS9iNG1rZlVldmhaN1dG?=
 =?utf-8?B?MDVWSDU3ejFVaHkvMU43K2NSUFlBNzlxKzkxcUVQWDZZdWpTUTlLNEtTamlX?=
 =?utf-8?B?RHZOVTlNdTJqRHpLeVZQSHdLNE8wTXJuWnlYYzdPbityNDcvSkdHQ1Y0US9w?=
 =?utf-8?B?bVVVaDlidmdXNFgvbDlEUk1aYjlLQWN4bjhnT0xPMVVKVThwME9PTE5vOFdS?=
 =?utf-8?B?RXVDTXA1dG9lYS9YSGhDWCttYVJOY05mWkFPRnNNMWhGYVZHc2JlcUFXUEVi?=
 =?utf-8?B?VGlQZnZUUlZwWGVFUndvQWpMSy9ET0o3VERaQU54bUlNdiswT3NVOGpXYWlx?=
 =?utf-8?B?bVNlekFXS1hGNzBhWTZNeDdkRlNEV2swR1JMd3I2eGFOaEErdmhIQTl2N0Vn?=
 =?utf-8?B?SnRRSm16TW51b0FQZEtEbjYrSmEyNlgvWU1FSDNaZFZjNDFoK0hVMm0rZDFX?=
 =?utf-8?B?YTVSSDR3MHVPNzJoa3o2ckVuTFdPOFNKV0prL0s0eTIvUzFhOFY4Unl4ckFZ?=
 =?utf-8?B?MjdoclNoc2E0Nk1WQ09zaTRMTTBzcHNNN0Q0dE5BRVY0b0NoTEFBVEhTdDF4?=
 =?utf-8?B?Qjd6aU5MNHdWclVxMTlCMGx0cUFZTm91M2J6MEJxZGJxeGFlME16UldFTkRw?=
 =?utf-8?B?dWRpZGJKMFZxbnVlMW9GZWtrbTlxWGZiY2p5WHBKQTBtd2V0WG1EV1NCNVlH?=
 =?utf-8?B?SHZiTGRZbGh6UjkyVk52cVdZVkVRVEdiaEVCK1lGSjJycUxhUnhPNmtCelkx?=
 =?utf-8?B?aWYwWW9JV2ErRm1oVzk2MEpmcXZSR0tuZS84dThxaWFkQnVHNmVxTHZyc29J?=
 =?utf-8?B?YW9ocDRpd0lxWGJ6dzIxS052RUQ4cWlHWndWa0h2dTltZ0J1T01PV2loNnpW?=
 =?utf-8?B?Z0VqRFRlWUcvTlFUVjNybnN1UitjRnIwbEY4WjBWbll3Z3pMa3AwanhLWW02?=
 =?utf-8?B?bkYxSGtGS1IzRWE4TVZXTmtGSFN1VHFVT1pKMlg4Qmd5cHkxK0FvQkZpVEk4?=
 =?utf-8?B?ZHF1cG1OelVheEY2alQxc1FCRGx0NHVCbW1XNmgrZDM3ZVk0bTBENjFTWU5q?=
 =?utf-8?B?Ni80VUlQVEJkWTFsTEh2dFd5RjM4WkxTZ2FqQjJ5elhudi8wRUxmYUNMbjFH?=
 =?utf-8?B?RXA2RC8xQlR5Skx4bFJSbEs2S3ZXYnZGQ0VlbFZXek9CQTBkaGtxQWExNnVC?=
 =?utf-8?B?OUxpTmZBajNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnEyQjE1cDlRUEhVTVVwRWtDSmxtbFNXQUpBTEZqY3VCeFkzbmQ3T2lxMDJi?=
 =?utf-8?B?aFh1UkRNaVd3VVM2aVBJYWFwU1dPa2plN0g1ai9LUXVta1ZxSEkwUVZVS2pr?=
 =?utf-8?B?MGxKVHI0dHVLbDc0ajUrZGxNRXRHM3l6SHhOL3cwZTVWY2k3Vkt4d3VsTEJi?=
 =?utf-8?B?QTBEWmNXU0NXMU82RGxKa3hESDBVYWVNNnYvOHZ2QytkR3VWRmJEMHVxWDQ3?=
 =?utf-8?B?dzUvamxrYnlkOGh3b1ozSzdDZ1cwRHV6WkhQVkN6SmhQREtpb0s2dHQrRGNS?=
 =?utf-8?B?Y1p4a2IyY2FhMHR3TXM2anh5WFNrTERCaGQzNm1tQ2NtcEF1ZDdyRjBTMnhX?=
 =?utf-8?B?dndpUzZvU0xtcVJVTHJ4Vk9jWGsyUTNONExwdnozMWZWVGxGdUlDL21yeTRq?=
 =?utf-8?B?cndJYlJGM3VvVDM3UXlIVmhSUDU1OUs5ZzY0bjZ5K2pxTTNSdFZhSS8vMUpB?=
 =?utf-8?B?V05NOXE1eThTbnBIM1h4STlwdjd4L2tZNTR6ME42WjhJL1lDRzl2MjIzUE5M?=
 =?utf-8?B?UDZIM0F2M3k0UzdUMHhKQ09NcXhxM1IyZFphRHpWMFRaaDU1dis2UGltajNK?=
 =?utf-8?B?N3JObjNNTWFrckdWMDhySWtjQndOYjlyQXlDc1V4U2Y2bjJjQzlxT2hSWVor?=
 =?utf-8?B?QlNkSFpldG4zckNOa3h5V1dJSnZaZjJIT00reEFjUnlqcUtaeS81WDdyMEdU?=
 =?utf-8?B?TWlSZmRMcU9CTjB6K29WTmp6clM5d1N3S3VueDlsY3dBWGx3WnlleFNXamtp?=
 =?utf-8?B?M2Zyb1AvaG91OWhiREYwV1FGUmo5UXpSamlsYXVVNVllUXBIaHpQenp2ZGZL?=
 =?utf-8?B?aHo0MGlvdjA0RXlWeVlIYmZHZ3kza2pKczhLNndDVDlyaW9INC9XNThiT1N6?=
 =?utf-8?B?dDJXYVVxN1FYTC8wcU9NYjNrT1R2ZENmcnpZTmUwc2k4dzF6MDBhWjFXQnhw?=
 =?utf-8?B?R1lSb2JubkI3L3Y4ZlNrd3hKcXRJMXkxRnkvQTdyNm9JL0d5dUp0V05RbjNt?=
 =?utf-8?B?dEF4dkk0cWpKVndtbGpLN01pSFpsL1ZZZWVETmR2UDYvN3AycXFLbWEwRExI?=
 =?utf-8?B?N2VNdXN5WjVkOENlZ1luRjNnVWxRKzl1N20rWE1VNHZzME8ySzJwNXQ1ZEtx?=
 =?utf-8?B?dUtReHdvNkw4M0ZsZWJEU3ZyMGt5aFZUOC93TFowYVh1U0xUODFVdlpQMnFX?=
 =?utf-8?B?bFhZM1Urb3NqM2dQdy8xTnJjcEpWTzlQUWFiQmpzTStxa2lYSVFIWFUvR2ky?=
 =?utf-8?B?bDBURG5IT09GSGs4RVVQREg3MHkyN0FyYmthTGQvQ2l2STVCZFkxaWNTcTFt?=
 =?utf-8?B?alpQT0EyMWIzeW5INWxtc21FS2k4c1ZpVzdOOGJ4RUZRNHlmdHRKTlNMb05l?=
 =?utf-8?B?dlJDVnRwRUJGWGhmUHMzTTJyUzAvbVorMmtTSVFDaGp1VW11WmhxRXNBMnI3?=
 =?utf-8?B?SlQ1OEJ1UGQ0MnZDNjZKSHF0bFFIQ3J6RUlWcExDaWU1WlVMYTB5UWg5bDlj?=
 =?utf-8?B?NUhFcFI5U3hSWEl0K0FVbFBSR25Xd21LYXh2V2NxazZWeWUyTlVHaTdOL2VC?=
 =?utf-8?B?VVNEd0Eva1Yyakw0cTl2a2gxeS9lTUtYL2ZHRlFxZTJ0cDVycUJYZXViUERr?=
 =?utf-8?B?UEFEYnN6bTBZK0lEdmJTUCtkSmVSVlJWWHJxemx3Q0pjZjZldG1VVXQwcUJ1?=
 =?utf-8?B?Ukx2MkNIR0ttSUtmM0JIUHdYdEpKZ0NrMUdOVWVaMlYyeWZhanoza3FiMkVj?=
 =?utf-8?B?NjJjUXJrcGErb3p6NlJXR3dDdklzZ2U2ODVSc28xNzFkT2tlVTFMOXFxc0c5?=
 =?utf-8?B?cnpZNngxWFpTYStQQjBlT2RTeTVaQUJWTVpKd3F3ZGdpS3E2TjA2ZmRQWXJX?=
 =?utf-8?B?T0pWaUMweUJkcUJ2RjZyVFlFQWwrOUZpdHhHa0MrTUxnVktwakY5Sk1idmN6?=
 =?utf-8?B?d1QrdDZUcXNYWEV2bHU4K2VCNFdRbm1rOFZTL05oa1pXbm4vTExtWkV5c1FB?=
 =?utf-8?B?cVE4T3hZa2w1aTVQTk5OUndMNjZrV25BaXFjMzJnSEo2MkhjTDVyc1RiUkFG?=
 =?utf-8?B?U29CN1pqNWpIbUIxb0VMVkVPQ3UyUWt6ZmhQcU8xRnBUa0VaOGNzQnlIRkhO?=
 =?utf-8?B?N1I1aTE4ZHZPZzZlUjRtVVVienJXVVVzc1N4aGx0NVIzQ2hoTmRLRzBGRjNX?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a9105e-d873-4181-14d0-08ddf6d9f4b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:36:53.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VSXA4DisLx3IAb0Zr+SIbW4u/NZhoukbalNbIsmDig1tLI0+RxgkpqZoJeiZmT46Nkx/jtMgPSm0hhzxz8zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com

On 12/09/2025 12:38, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Add support for the mmc controller in the Eswin EIC7700 with the new
> compatible "eswin,eic7700-dwcmshc". Implement custom sdhci_ops for
> set_clock, reset, set_uhs_signaling, platform_execute_tuning.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 770 ++++++++++++++++++++++++++++
>  1 file changed, 770 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ee6b1096f709..dd16c7a3bda7 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -11,6 +11,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -19,8 +20,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/units.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -194,6 +198,10 @@
>  #define PHY_DLLDL_CNFG_SLV_INPSEL_MASK	GENMASK(6, 5) /* bits [6:5] */
>  #define PHY_DLLDL_CNFG_SLV_INPSEL	0x3 /* clock source select for slave DL */
>  
> +#define PHY_DLL_OFFST_R			(DWC_MSHC_PTR_PHY_R + 0x29)
> +#define PHY_DLLBT_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x2c)
> +#define PHY_DLL_STATUS_R		(DWC_MSHC_PTR_PHY_R + 0x2e)

Other PHY registers are introuced with a comment followed by
field definitions and values

> +
>  #define FLAG_IO_FIXED_1V8	BIT(0)
>  
>  #define BOUNDARY_OK(addr, len) \
> @@ -206,6 +214,48 @@
>  /* SMC call for BlueField-3 eMMC RST_N */
>  #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
>  
> +/* Eswin specific Registers */
> +#define EIC7700_CARD_CLK_STABLE		BIT(28)
> +#define EIC7700_INT_BCLK_STABLE		BIT(16)
> +#define EIC7700_INT_ACLK_STABLE		BIT(8)
> +#define EIC7700_INT_TMCLK_STABLE	BIT(0)
> +#define EIC7700_INT_CLK_STABLE		(EIC7700_CARD_CLK_STABLE | \
> +					 EIC7700_INT_ACLK_STABLE | \
> +					 EIC7700_INT_BCLK_STABLE | \
> +					 EIC7700_INT_TMCLK_STABLE)
> +#define EIC7700_HOST_VAL_STABLE		BIT(0)
> +#define EIC7700_CORE_CLK_ENABLE		BIT(16)
> +#define EIC7700_CORE_CLK_FREQ_SHIFT	4
> +#define EIC7700_CORE_CLK_FREQ_MASK	0xfffu
> +#define EIC7700_CORE_CLK_SEL_BIT	BIT(0)
> +
> +/* strength definition */
> +#define PHYCTRL_DR_33OHM		0xee
> +#define PHYCTRL_DR_40OHM		0xcc
> +#define PHYCTRL_DR_50OHM		0x88
> +#define PHYCTRL_DR_66OHM		0x44
> +#define PHYCTRL_DR_100OHM		0x00
> +
> +#define LATENCY_LT_BIT_OFFSET		19
> +#define LATENCY_LT_MASK			0x3

Prefer GENMASK() and then use FIELD_PREP()

> +#define LATENCY_LT_3			0x2
> +#define VENDOR_AT_SATA_R		0x544
> +
> +#define MAX_PHASE_CODE			0xff
> +#define TUNING_RANGE_THRESHOLD		40
> +
> +#define PHY_CLK_MAX_DELAY_MASK		0x7f
> +#define PHY_PAD_SP_DRIVE_SHIF		16

Prefer GENMASK() and then use FIELD_PREP()

> +
> +#define EIC7700_CORE_CLK_SRC_208MHZ	(208 * HZ_PER_MHZ)
> +#define EIC7700_CORE_CLK_SRC_200MHZ	(200 * HZ_PER_MHZ)
> +#define MAX_CORE_CLK_DIV		0xfff
> +#define DLL_LOCK_STS			BIT(0)
> +#define DLL_ERROR_STS			BIT(1)
> +#define PHY_DELAY_CODE_MAX		0x7f
> +#define PHY_DELAY_CODE_EMMC		0x17
> +#define PHY_DELAY_CODE_SD		0x55
> +
>  enum dwcmshc_rk_type {
>  	DWCMSHC_RK3568,
>  	DWCMSHC_RK3588,
> @@ -217,6 +267,18 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +struct eic7700_priv {
> +	struct sdhci_host *host;
> +	struct clk_hw sdcardclk_hw;
> +	struct clk *sdcardclk;
> +	int clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> +	void (*set_clk_delays)(struct sdhci_host *host);
> +	struct reset_control *reset;
> +	struct regmap *crg_regmap;
> +	unsigned int crg_core_clk;
> +	unsigned int drive_impedance;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -238,6 +300,8 @@ struct dwcmshc_pltfm_data {
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host);

Move the function rather than create a forward declaration

> +
>  static int dwcmshc_get_enable_other_clks(struct device *dev,
>  					 struct dwcmshc_priv *priv,
>  					 int num_clks,
> @@ -1095,6 +1159,685 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>  					     ARRAY_SIZE(clk_ids), clk_ids);
>  }
>  
> +static void sdhci_eic7700_enable_card_clk(struct sdhci_host *host)

This is being paired with dwcmshc_disable_card_clk(), so maybe
dwcmshc_enable_card_clk() is a more readable name

> +{
> +	u16 clk;
> +	int ret;
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 150 ms */
> +	ret = read_poll_timeout(sdhci_readw, clk, clk & SDHCI_CLOCK_INT_STABLE,
> +				10, 150000, false, host, SDHCI_CLOCK_CONTROL);
> +	if (ret) {
> +		pr_err("%s: Internal clock never stabilised.\n",
> +		       mmc_hostname(host->mmc));
> +		return;
> +	}
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	usleep_range(1000, 2000);
> +}
> +
> +static void eic7700_mshc_coreclk_disable(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +	u32 val;
> +
> +	regmap_read(priv->crg_regmap, priv->crg_core_clk, &val);
> +	val &= ~EIC7700_CORE_CLK_ENABLE;
> +	regmap_write(priv->crg_regmap, priv->crg_core_clk, val);
> +}
> +
> +static void eic7700_mshc_coreclk_config(struct sdhci_host *host,
> +					u16 divisor, unsigned int flag_sel)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +	u32 val;
> +
> +	regmap_read(priv->crg_regmap, priv->crg_core_clk, &val);
> +	val &= ~EIC7700_CORE_CLK_ENABLE;
> +	regmap_write(priv->crg_regmap, priv->crg_core_clk, val);
> +	usleep_range(10, 20);
> +
> +	val &= ~(EIC7700_CORE_CLK_FREQ_MASK << EIC7700_CORE_CLK_FREQ_SHIFT);
> +	val |= (divisor & EIC7700_CORE_CLK_FREQ_MASK) <<
> +		EIC7700_CORE_CLK_FREQ_SHIFT;
> +	val &= ~(EIC7700_CORE_CLK_SEL_BIT);
> +	val |= flag_sel;
> +	regmap_write(priv->crg_regmap, priv->crg_core_clk, val);
> +
> +	usleep_range(50, 60);
> +	val |= EIC7700_CORE_CLK_ENABLE;
> +	regmap_write(priv->crg_regmap, priv->crg_core_clk, val);
> +	usleep_range(1000, 1100);
> +}

So the host controller is not configuring the card clock.
Shouldn't the eic7700 clock driver provide this clock?

> +
> +static void sdhci_eic7700_set_core_clock(struct sdhci_host *host,
> +					 unsigned int clock)
> +{
> +	unsigned int flag_sel, max_clk;
> +	unsigned int div, divide;
> +
> +	host->mmc->actual_clock = clock;
> +
> +	if (clock == 0) {
> +		eic7700_mshc_coreclk_disable(host);
> +		return;
> +	}
> +
> +	if (EIC7700_CORE_CLK_SRC_208MHZ % clock == 0) {
> +		flag_sel = 1;
> +		max_clk = EIC7700_CORE_CLK_SRC_208MHZ;
> +	} else {
> +		flag_sel = 0;
> +		max_clk = EIC7700_CORE_CLK_SRC_200MHZ;
> +	}
> +
> +	for (div = 1; div <= MAX_CORE_CLK_DIV; div++) {
> +		if ((max_clk / div) <= clock)
> +			break;
> +	}
> +	div--;
> +
> +	if (div == 0 || div == 1)
> +		divide = 2;
> +	else
> +		divide = (div + 1) * 2;
> +
> +	dwcmshc_disable_card_clk(host);
> +	eic7700_mshc_coreclk_config(host, divide, flag_sel);
> +	sdhci_eic7700_enable_card_clk(host);
> +	usleep_range(2000, 3000);
> +}
> +
> +static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +
> +	/* Set the Input and Output Clock Phase Delays */
> +	if (priv->set_clk_delays)
> +		priv->set_clk_delays(host);
> +
> +	sdhci_eic7700_set_core_clock(host, clock);
> +}
> +
> +static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int delay)
> +{
> +	delay &= PHY_CLK_MAX_DELAY_MASK;
> +
> +	/* phy clk delay line config */
> +	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, delay, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +}
> +
> +static void sdhci_eic7700_config_phy(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +	unsigned int val, drv;
> +
> +	drv = priv->drive_impedance << PHY_PAD_SP_DRIVE_SHIF;
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = sdhci_readw(host, dwc_priv->vendor_specific_area1 +
> +				  DWCMSHC_EMMC_CONTROL);
> +		val |= DWCMSHC_CARD_IS_EMMC;
> +		sdhci_writew(host, val, dwc_priv->vendor_specific_area1 +
> +			     DWCMSHC_EMMC_CONTROL);
> +	}
> +
> +	dwcmshc_disable_card_clk(host);
> +
> +	/* reset phy, config phy's pad */
> +	sdhci_writel(host, drv | (~PHY_CNFG_RSTN_DEASSERT), PHY_CNFG_R);
> +
> +	/* configure phy pads */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK,
> +			 PHY_PAD_TXSLEW_CTRL_N_SG2042);

Here are elsewhere, avoid wrapping lines if they fit in 100 columns.

> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK,
> +			  PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK,
> +			  PHY_PAD_WEAKPULL_PULLUP);
> +	val |= PHY_PAD_RXSEL_1V8;
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	/* Clock PAD Setting */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK,
> +			 PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK,
> +			  PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	/* PHY strobe PAD setting (EMMC only) */
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK,
> +				 PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK,
> +				  PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= PHY_PAD_RXSEL_1V8;
> +		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +	}
> +	usleep_range(2000, 3000);
> +	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
> +	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
> +	sdhci_eic7700_enable_card_clk(host);
> +}
> +
> +static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +
> +	/* after reset all, the phy's config will be clear */
> +	if (mask == SDHCI_RESET_ALL)
> +		sdhci_eic7700_config_phy(host);
> +}
> +
> +static unsigned long
> +sdhci_eic7700_sdcardclk_recalc_rate(struct clk_hw *hw,
> +				    unsigned long parent_rate)
> +{
> +	struct eic7700_priv *priv =
> +		 container_of(hw, struct eic7700_priv, sdcardclk_hw);
> +
> +	return priv->host->mmc->actual_clock;
> +}
> +
> +static const struct clk_ops eic7700_sdcardclk_ops = {
> +	.recalc_rate = sdhci_eic7700_sdcardclk_recalc_rate,
> +};

An sdcardclk like this can be created to communicate the
frequency to a PHY driver, but the PHY configuration seems
to be in this driver.  Is sdcardclk really needed?

Also it would seem to be in conflict with having the clock
driver provide the clock.

> +
> +static int sdhci_eic7700_register_sdcardclk(struct eic7700_priv *priv,
> +					    struct clk *clk, struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data sdcardclk_init;
> +	const char *parent_clk_name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 0,
> +					    &sdcardclk_init.name);
> +	if (ret) {
> +		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
> +		return ret;
> +	}
> +
> +	parent_clk_name = __clk_get_name(clk);
> +	sdcardclk_init.parent_names = &parent_clk_name;
> +	sdcardclk_init.num_parents = 1;
> +	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
> +	sdcardclk_init.ops = &eic7700_sdcardclk_ops;
> +
> +	priv->sdcardclk_hw.init = &sdcardclk_init;
> +	priv->sdcardclk = devm_clk_register(dev, &priv->sdcardclk_hw);
> +	if (IS_ERR(priv->sdcardclk))
> +		return PTR_ERR(priv->sdcardclk);
> +	priv->sdcardclk_hw.init = NULL;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get,
> +				  priv->sdcardclk);
> +	if (ret)
> +		dev_err(dev, "Failed to add sdcard clock provider\n");
> +
> +	return ret;
> +}
> +
> +static int sdhci_eic7700_register_sdclk(struct dwcmshc_priv *dwc_priv,
> +					struct clk *clk, struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	/* Providing a clock to the PHY is optional; no error if missing */
> +	if (!of_property_present(np, "#clock-cells"))
> +		return 0;
> +
> +	ret = sdhci_eic7700_register_sdcardclk(dwc_priv->priv, clk, dev);
> +
> +	return ret;
> +}
> +
> +static int sdhci_eic7700_reset_init(struct device *dev,
> +				    struct eic7700_priv *priv)
> +{
> +	int ret;
> +
> +	priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
> +	if (IS_ERR(priv->reset)) {
> +		ret = PTR_ERR(priv->reset);
> +		dev_err(dev, "failed to get reset control %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(priv->reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
> +		return ret;
> +	}
> +	usleep_range(2000, 2100);
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void sdhci_eic7700_set_clk_delays(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +
> +	clk_set_phase(priv->sdcardclk,
> +		      priv->clk_phase_out[host->timing]);
> +}
> +
> +static void sdhci_eic7700_dt_read_clk_phase(struct device *dev,
> +					    struct eic7700_priv *priv,
> +					    unsigned int timing,
> +					    const char *prop)
> +{
> +	struct device_node *np = dev->of_node;
> +	int clk_phase[2] = {0};
> +
> +	/*
> +	 * Read Tap Delay values from DT, if the DT does not contain the Tap
> +	 * Values then use the pre-defined values.
> +	 */
> +	if (of_property_read_variable_u32_array(np, prop, &clk_phase[0], 2,

of_property_read_variable_u32_array() returns a positive value on success,
negative on error, so this error condition looks wrong.

> +						0)) {
> +		dev_dbg(dev, "Using predefined clock phase for %s = %d\n",
> +			prop, priv->clk_phase_out[timing]);
> +		return;
> +	}
> +
> +	/* Only use the output clock delays in order */
> +	priv->clk_phase_out[timing] = clk_phase[1];
> +}
> +
> +static void sdhci_eic7700_dt_parse_clk_phases(struct device *dev,
> +					      struct dwcmshc_priv *dwc_priv)
> +{
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +
> +	priv->set_clk_delays = sdhci_eic7700_set_clk_delays;
> +
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_LEGACY,
> +					"clk-phase-legacy");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_MMC_HS,
> +					"clk-phase-mmc-hs");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_SD_HS,
> +					"clk-phase-sd-hs");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_UHS_SDR12,
> +					"clk-phase-uhs-sdr12");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_UHS_SDR25,
> +					"clk-phase-uhs-sdr25");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_UHS_SDR50,
> +					"clk-phase-uhs-sdr50");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_UHS_SDR104,
> +					"clk-phase-uhs-sdr104");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_UHS_DDR50,
> +					"clk-phase-uhs-ddr50");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_MMC_DDR52,
> +					"clk-phase-mmc-ddr52");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_MMC_HS200,
> +					"clk-phase-mmc-hs200");
> +	sdhci_eic7700_dt_read_clk_phase(dev, priv, MMC_TIMING_MMC_HS400,
> +					"clk-phase-mmc-hs400");
> +}
> +
> +static unsigned int eic7700_convert_drive_impedance_ohm(struct device *dev,
> +							unsigned int dr_ohm)
> +{
> +	switch (dr_ohm) {
> +	case 100:
> +		return PHYCTRL_DR_100OHM;
> +	case 66:
> +		return PHYCTRL_DR_66OHM;
> +	case 50:
> +		return PHYCTRL_DR_50OHM;
> +	case 40:
> +		return PHYCTRL_DR_40OHM;
> +	case 33:
> +		return PHYCTRL_DR_33OHM;
> +	}
> +
> +	dev_warn(dev, "Invalid value %u for drive-impedance-ohm.\n", dr_ohm);
> +	return PHYCTRL_DR_50OHM;
> +}
> +
> +static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	int cmd_error, delay, ret, i;
> +	int delay_min = -1;
> +	int delay_max = -1;
> +
> +	for (i = 0; i <= PHY_DELAY_CODE_MAX; i++) {
> +		dwcmshc_disable_card_clk(host);
> +		sdhci_eic7700_config_phy_delay(host, i);
> +		sdhci_eic7700_enable_card_clk(host);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		if (ret) {
> +			host->ops->reset(host,
> +					 SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +			usleep_range(200, 210);
> +			if (delay_min != -1 && delay_max != -1)
> +				break;
> +		} else {
> +			if (delay_min == -1) {
> +				delay_min = i;
> +				continue;
> +			} else {
> +				delay_max = i;
> +				continue;
> +			}
> +		}
> +	}
> +	if (delay_min == -1 && delay_max == -1) {
> +		pr_err("%s: delay code tuning failed!\n",
> +		       mmc_hostname(host->mmc));
> +		dwcmshc_disable_card_clk(host);
> +		sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
> +		sdhci_eic7700_enable_card_clk(host);
> +
> +		return ret;
> +	}
> +
> +	delay = (delay_min + delay_max) / 2;
> +	dwcmshc_disable_card_clk(host);
> +	sdhci_eic7700_config_phy_delay(host, delay);
> +	sdhci_eic7700_enable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	int cmd_error, ret, i;
> +	bool is_sdio = false;
> +	int phase_code = -1;
> +	int code_range = -1;
> +	int code_min = -1;
> +	int code_max = -1;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		is_sdio = true;

SDIO is excluded (MMC_CAP2_NO_SDIO), so 'is_sdio' is not an
ideal name.  Maybe just 'is_sd'

> +
> +	for (i = 0; i <= MAX_PHASE_CODE; i++) {
> +		dwcmshc_disable_card_clk(host);
> +		sdhci_writew(host, i, VENDOR_AT_SATA_R);
> +		sdhci_eic7700_enable_card_clk(host);
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +		if (ret) {
> +			/* SDIO specific range tracking */
> +			if (is_sdio && code_min != -1 && code_max != -1) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +					if (code_range > TUNING_RANGE_THRESHOLD)
> +						break;
> +				}
> +				code_min = -1;
> +				code_max = -1;
> +			}
> +			/* EMMC breaks after first valid range */
> +			if (!is_sdio && code_min != -1 && code_max != -1)
> +				break;
> +		} else {
> +			/* Track valid phase code range */
> +			if (code_min == -1) {
> +				code_min = i;
> +				if (!is_sdio)
> +					continue;
> +			}
> +			code_max = i;
> +			if (is_sdio && i == MAX_PHASE_CODE) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Handle tuning failure case */
> +	if ((is_sdio && phase_code == -1) ||
> +	    (!is_sdio && code_min == -1 && code_max == -1)) {
> +		pr_err("%s: phase code tuning failed!\n",
> +		       mmc_hostname(host->mmc));
> +		dwcmshc_disable_card_clk(host);
> +		sdhci_writew(host, 0, VENDOR_AT_SATA_R);

What is VENDOR_AT_SATA_R?

> +		sdhci_eic7700_enable_card_clk(host);
> +		return -EIO;
> +	}
> +	if (!is_sdio)
> +		phase_code = (code_min + code_max) / 2;
> +
> +	dwcmshc_disable_card_clk(host);
> +	sdhci_writew(host, phase_code, VENDOR_AT_SATA_R);
> +	sdhci_eic7700_enable_card_clk(host);
> +
> +	/* SDIO specific final verification */
> +	if (is_sdio) {
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		if (ret) {
> +			pr_err("%s: Final phase code 0x%x verification failed!\n",
> +			       mmc_hostname(host->mmc), phase_code);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_eic7700_executing_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	u16 ctrl;
> +	u32 val;
> +	int ret;
> +
> +	dwcmshc_disable_card_clk(host);
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readl(host, priv->vendor_specific_area1 +
> +			  DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_SW_TUNE_EN;
> +	sdhci_writew(host, val, priv->vendor_specific_area1 +
> +		     DWCMSHC_EMMC_ATCTRL);
> +
> +	sdhci_writew(host, 0, VENDOR_AT_SATA_R);
> +
> +	sdhci_eic7700_enable_card_clk(host);
> +
> +	sdhci_writew(host, 0x0, SDHCI_CMD_DATA);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		ret = sdhci_eic7700_delay_tuning(host, opcode);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = sdhci_eic7700_phase_code_tuning(host, opcode);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host,
> +					    unsigned int timing)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u8 status;
> +	u32 val;
> +	int ret;
> +
> +	dwcmshc_set_uhs_signaling(host, timing);
> +
> +	/* here need make dll locked when in hs400 at 200MHz */
> +	if (timing == MMC_TIMING_MMC_HS400 && host->clock == 200000000) {
> +		dwcmshc_disable_card_clk(host);
> +
> +		val = sdhci_readl(host, priv->vendor_specific_area1 +
> +				  DWCMSHC_EMMC_ATCTRL);
> +		val &= ~(LATENCY_LT_MASK << LATENCY_LT_BIT_OFFSET);
> +		val |= (LATENCY_LT_3 << LATENCY_LT_MASK);

Is the use of LATENCY_LT_MASK correct here.
Also, prefer GENMASK() and FIELD_PREP()

> +		sdhci_writew(host, val, priv->vendor_specific_area1 +
> +			     DWCMSHC_EMMC_ATCTRL);
> +
> +		sdhci_writeb(host, 0x23, PHY_DLL_CNFG1_R);
> +		sdhci_writeb(host, 0x02, PHY_DLL_CNFG2_R);
> +		sdhci_writeb(host, 0x60, PHY_DLLDL_CNFG_R);
> +		sdhci_writeb(host, 0x00, PHY_DLL_OFFST_R);
> +		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);

It would be nicer to have defines for the fields and values
instead of magic numbers.

> +
> +		sdhci_eic7700_enable_card_clk(host);
> +		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +		usleep_range(100, 110);
> +
> +		ret = read_poll_timeout(sdhci_readb, status,
> +					status & DLL_LOCK_STS, 100, 1000000,
> +					false, host, PHY_DLL_STATUS_R);
> +		if (ret) {
> +			pr_err("%s: DLL lock timeout! status: 0x%x\n",
> +			       mmc_hostname(host->mmc), status);
> +			return;
> +		}
> +
> +		status = sdhci_readb(host, PHY_DLL_STATUS_R);
> +		if (status & DLL_ERROR_STS) {
> +			pr_err("%s: DLL lock failed!err_status:0x%x\n",
> +			       mmc_hostname(host->mmc), status);
> +		}
> +	}
> +}
> +
> +static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host,
> +					  unsigned int timing)
> +{
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		sdhci_set_uhs_signaling(host, timing);
> +	else
> +		sdhci_eic7700_set_uhs_signaling(host, timing);
> +}
> +
> +static int eic7700_init(struct device *dev, struct sdhci_host *host,
> +			struct dwcmshc_priv *dwc_priv)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
> +	struct of_phandle_args args;
> +	struct eic7700_priv *priv;
> +	struct regmap *hsp_regmap;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct eic7700_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->host = host;
> +	dwc_priv->priv = priv;
> +
> +	ret = sdhci_eic7700_register_sdclk(dwc_priv, pltfm_host->clk, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
> +	if (ret) {
> +		dev_err(dev, "failed to reset\n");
> +		return ret;
> +	}
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +					       "eswin,syscrg-csr", 1, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Fail to parse 'eswin,syscrg-csr' phandle (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +	priv->crg_regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(priv->crg_regmap)) {
> +		dev_err(dev, "Failed to get regmap for 'eswin,syscrg-csr'\n");
> +		of_node_put(args.np);
> +		return ret;
> +	}
> +
> +	priv->crg_core_clk = args.args[0];
> +	of_node_put(args.np);
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node,
> +					       "eswin,hsp-sp-csr", 2, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	hsp_regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(hsp_regmap)) {
> +		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
> +		of_node_put(args.np);
> +		return ret;
> +	}
> +	hsp_int_status = args.args[0];
> +	hsp_pwr_ctrl = args.args[1];
> +	of_node_put(args.np);

Could use some comments here about what the following
regmap_write()s actually do and why.

> +	regmap_write(hsp_regmap, hsp_int_status,
> +		     EIC7700_INT_CLK_STABLE);
> +	regmap_write(hsp_regmap, hsp_pwr_ctrl,
> +		     EIC7700_HOST_VAL_STABLE);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
> +		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
> +	else
> +		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
> +
> +	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
> +		priv->drive_impedance =
> +			eic7700_convert_drive_impedance_ohm(dev, val);
> +
> +	sdhci_eic7700_dt_parse_clk_phases(dev, dwc_priv);
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1169,6 +1912,18 @@ static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
> +	.set_clock = sdhci_eic7700_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_eic7700_reset,
> +	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.irq = dwcmshc_cqe_irq_handler,
> +	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_ops,
> @@ -1238,6 +1993,17 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
>  	.init = sg2042_init,
>  };
>  
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_eic7700_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	},
> +	.init = eic7700_init,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1338,6 +2104,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "sophgo,sg2042-dwcmshc",
>  		.data = &sdhci_dwcmshc_sg2042_pdata,
>  	},
> +	{
> +		.compatible = "eswin,eic7700-dwcmshc",
> +		.data = &sdhci_dwcmshc_eic7700_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);

