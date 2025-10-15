Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE28321430;
	Wed, 15 Oct 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533791; cv=fail; b=WY3z9d5NPCJQgBglApsaI9W9cAJgd7/dPEce4DmdSiv4hS6lehmkXaS7M9dCSuE8GJYsdaW+88cLzDbNHo0lltjZI/9bwl3Y4bwCh4QwuunKhH5vuzRsW408A+PZZsioOkacir+gYN6EMgIIoJxqNZ9uFV15YAudylBu5hTHZtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533791; c=relaxed/simple;
	bh=na2l/gNPQvm4DUFdGy2hriJk3YH3ELqcMDC2XzggauA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q1a4rT9oh8hiWxdamp83b1sJqRf9lRXiDDDL5TCM13yPC5pst8Aiwe0ePRUbeduxOQTTG0rbWWmsFz1cqLq8DShcBuqTsEAp3rjRBhv0bCDCBZVFCaqPVL9Kf7zDQMZGuYK4WWYi5LOMi1cWqPTO3Gd7xdjpgAoUWXa/UqlXbPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjwLzKVS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjwLzKVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760533788; x=1792069788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=na2l/gNPQvm4DUFdGy2hriJk3YH3ELqcMDC2XzggauA=;
  b=ZjwLzKVS2DJRhShtQP+3uekLvOj4ZL0Oq3OGM8/kVDCCL6PL0/buXy6E
   OZ+OscwZc5/HnJhSwQ6RNPYKmo54Dgr4qybGA1z0TrfrnlsXhMkuitJkD
   h8/DwejwJKipIBPAi2qClThBGYRs5NY44NLgGYU8bg4YI4EiWMh74yaaa
   rHxaiztJunlPBU2q3cb/xsgE5tKv1/b9L2gvKHruKgO5WJoV4gqlY4GR4
   cX42nr8A9bMnVclBaFyBs/kJ7ScpZGnRybcqHnH6OABGPWsy2ouEEcUXu
   HUnpOKucD1QYasSyQsF+KUTwPNp77rvK7sxB1Vd+mjGeIfJDhI4HJuEsF
   w==;
X-CSE-ConnectionGUID: mJ/vlDLGRfODKKPQSXgTSg==
X-CSE-MsgGUID: xN5mgzQlTfasrYSMdP47FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80143950"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="80143950"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:09:48 -0700
X-CSE-ConnectionGUID: eE4KQ9jTTOKSo5hDBdQ5Ag==
X-CSE-MsgGUID: 9DL7TljfRVmEV/7jneUF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="187257711"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:09:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 06:09:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 06:09:47 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 06:09:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXoskUynxwPRBTi71FxOj4YUoG1A/rpVHQneWVTHHyXqd6h+cPFR8WN0DHDt3PXTMWDeQanfROTdHGAoEquadPV1679kpgoI9jdEbNyIMCaudKd0IzTG7P089m4WvZpigNmOjo7F7p3joyVG/gaWBU47kEuRPWrEVa/M68jOXLsSqKdmvvyYWJDIm472InElrFfmoiKxhw6LpYjtJxeggZV2ywEbKcxGCRGbc8nwSHb8/1xkqrSGXSgg+I9KPpruUWoZ6WB8HE3g+AWRkeTOevjLjV8N0UwAOybvooqe/DwtiN9RWDzsOjtwdjz6OcTK6H/2D5aCG2eydwYIp0INDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbNuAnDv1M8BRUYQUPQlYgmQ2h4bNiK/AwxcWyiFKqA=;
 b=uIFSUfBztxGzkqc5Mihak89hJ32xmXIHGLuwUhRufar6PmJhacHxIVAAANawDcmDAd5sY+kgptYoy9LJTK5nQvyZWSEKOLOOABiJs5KYcGtmUEkojEfVDP8jdoqizsygxNVnImECPqJJSQ5x+F6zKTul/AKjJ1HIlwS6Z1JZWbsMyobZbRTeIAxCMmBgWR5/+5c9bRlqXbHwR1YjV/G1T9ytrHuJt1smxvieIaNogvA/KaRma2Rd+DFF6QAktDsb0vCVEf5YYwrM+w/dn4dUjt83dNtzwd5o9ehPQtp7g914AICw9Br6kiXOyt7bVoZlPOJjk9491WSx7RaKB+uEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:09:44 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 13:09:43 +0000
Message-ID: <83b14304-995a-46d2-a6fe-c7c88dafbea9@intel.com>
Date: Wed, 15 Oct 2025 16:09:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
To: <hehuan1@eswincomputing.com>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jszhang@kernel.org>,
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>,
	<luyulin@eswincomputing.com>, <dongxuyang@eswincomputing.com>,
	<zhangsenchuan@eswincomputing.com>, <weishangjuan@eswincomputing.com>,
	<lizhi2@eswincomputing.com>, <caohang@eswincomputing.com>, kernel test robot
	<lkp@intel.com>
References: <20251011111039.533-1-hehuan1@eswincomputing.com>
 <20251011111216.570-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251011111216.570-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eab2444-07b4-485f-5fd1-08de0bec1b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0ZpdmpZNTVwYmVFMmZhbDFMSFpENmREMFBnMGljWFFHb1RCV2RrYzU2L3Iv?=
 =?utf-8?B?TkJGQUtlRU1TcmI4L2xNVGUwZmdxME1uSGlzbU9abHdSaFllRXRjNWhGRWJs?=
 =?utf-8?B?YXhCWjQzZk1LVkVDNlRxbUNLTlpWaStIbGRwN2o3dHZJNHZlMm80cEJoN2ta?=
 =?utf-8?B?cmRQYVhPQXdNNzQzNllsaDFMd1RlS054cDd4WGg3QXJ1UWNKK0tSc2x2QmNN?=
 =?utf-8?B?c2lhUzN3d3FWOFB3Wk12aU1EcEYxVlhWcHFoS090K0lzdnBuaUoya0NmdHNy?=
 =?utf-8?B?YXR5ejFHY0tlcUdXV0JNWmZ2NEk2Tk5obU1oTEFBR2VRVjUwQWh5ZWd0THla?=
 =?utf-8?B?Zm9QaFNBSGh4d21jd0t6TG9oMXhnMk0vR2ovZWwxWE5EWnhvK1ZuK0lZaG5h?=
 =?utf-8?B?eVcrRTZueU1UYnVzd3p0eVE4cDY1SGRZdkhvUVlENGl2OHRQemdMUDNDNHB5?=
 =?utf-8?B?VGpZVWRaM1BTM1RSY2YxblhRMlNBMEU2Mjc5ODBjWGZCdTYyWk1kYXA3cGUy?=
 =?utf-8?B?dGlCUEpjUmpNQW1RYXpJd2ZDbThHTlVTaHpicytUTzlhR3R2cEdTdUdzbk5K?=
 =?utf-8?B?YkRsNjEybklYSGJzUUN3TmY2WWFEaUh1Y2xuSDZldFRscjBvenlLQkpmUFVs?=
 =?utf-8?B?dnN1QnM3RlFKQlExYXd0Sm9CNHJMa3kyM3F2YnNGTUZYZ05yZFM1T0YzV2Q3?=
 =?utf-8?B?M0x0UHJ3TUY1cnU5NFV2Z3pNU2luc2diRnhWeGhvT3RvZTk1WUpTbWV1am5n?=
 =?utf-8?B?RFZaWGVlbDd5OURmd3krM3FnaDhCT0YvTlVvSnN3UFY1QjBlYmtXVW0vYWFh?=
 =?utf-8?B?OURXb2pvY1R1TytKcGF4ckQvbnNMc3FSb2c4M2l3R012WUhwcWJnait2TDJL?=
 =?utf-8?B?YUM3R200SGEwTFdJTit3UStJM1A5RXJVLzR1K08wWWVFSGlONDhCaWJzek45?=
 =?utf-8?B?bVJjeERpSFJ1RUltb1FKOVlMcENIa0VCQWxobFpBYXJHMmw5L2plZE1KbTN2?=
 =?utf-8?B?dXVUZHowbXZNNVU0dlEySkhSRnc1THlqNS80cFJsZk10WndVZGlud05ycFIx?=
 =?utf-8?B?NzFGMmVDRFJFRWc5K2d4UnA0c3Q1bzN4NUU1SDlyT09qV3B5M2hPTmVOSUJD?=
 =?utf-8?B?K1lVZGpXRDEzZkZkblRKcmJqUHBLVjVvMzc3MlFDanlvc0M4VGdDVjh0TjZy?=
 =?utf-8?B?T0d3SkhJbGRTWng5NFZkZ1ZTOWVwdkNxTmFSSFhiZGZWVDdnbnNpNFVHdjRk?=
 =?utf-8?B?emJOSmhTMzZ2dkE5ZkcrVFNQUUp3cmxIbU1XVHNueTJ0UHdNdmNKVjIzenpU?=
 =?utf-8?B?clZIQU1xTlI1Zkg4TWFIZFFnRDJGZklqR3lTemxqLzNITTBhd1Qza1RiZ21l?=
 =?utf-8?B?UW93SXhhVGZSQ05rbkU4c3VLL3QweVVDYmhDdlE4RnBMaHdBNWp2UklMNzdj?=
 =?utf-8?B?ckRSYTgxYTl6QWVlazZJWWZ3Q2JYVkNBTlAxTForaXBtRzY3OUk5cGk3RnV4?=
 =?utf-8?B?WUxGTGpqOXlNajNVRWg5dmR0dk5vT1RPZHgwWm9NTmdxK2srWVp5Y2dXOGlx?=
 =?utf-8?B?QSt5TER3ZjExS0hZOHNidlhyK2p2ODJLY29rSGFHeXlsRkx2MExHT0VaV2Nw?=
 =?utf-8?B?anJzVEdsZzBaT3E1V2sxaDdNcWpTVk4xS0t2ekxCNkllUjQwN0N6SVYxZ1R3?=
 =?utf-8?B?c05aZkZkaEpaYmtXVVQ4cHlOTDYwZjNTNFhaMm5EYXdTQTUzUzZ3cGN5NU1i?=
 =?utf-8?B?dEhBRXNIWUM4a3FBd05rWC9NMlJDMjJwR1c0QTd2Z2xNRmNteWZNMHE1WDVt?=
 =?utf-8?B?WnZkRGhvV3U4UTFaak1BMkVveWRtcFpxcU5hTkY3WEpQNmhrRG4waE1FaWVT?=
 =?utf-8?B?blZzNHhGL2x0c0x0a01OaSt2N2pjVkhvUGtQL29RNXp6Q1VnWGdoaDVnUmJz?=
 =?utf-8?B?bkEyaWtIcjhCWkVyYnN1UUZGN0VxdXlsM0FieUFHR2JrMDhsRUQ2eTJkb0Vt?=
 =?utf-8?B?VmE0UXpuZzVZaTZkODhwVFp6YWdIYjlZRFJFS0RKajlrdFBZMXZqV2xSdDNU?=
 =?utf-8?Q?OKZx5d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRjdWt2c1NPSDU1Tmp2ZTlObUFOVmxPTW5ndHFRREtxeUNqYjllaHlRYVA4?=
 =?utf-8?B?dG9TcjJ4UmNjZnk0WWtuQkdOeWpmdWlDc0RCb0tlRHVTeHlQR1A4ZW9TMk9M?=
 =?utf-8?B?dDZpVUNTRldoUzBNUlpZa0pGSlA5K3BhbDgwTlFRWEJBdUJ5dVBnVGZmdjJx?=
 =?utf-8?B?eHo2dTFYUFJFakc3K0R5WllFM0JjY1YzUWs4THdvM1RmVGlaSjE0TlZ5WHBE?=
 =?utf-8?B?MG8rc2hRSGxYcmJTY0lWYlFURWo1ZFdrMUUvbGpUTmNSOC94WWtWMjNaQ20w?=
 =?utf-8?B?SENVaENMQWRiOUVYVEU4ZU1laXJKWGVQQ2drYUVRaTBOc2p2TmFMc0VtOUNn?=
 =?utf-8?B?dXZFSXM2cG9SR051WXVQNlljemtPR0RQWUtJdkhUeHpueis0RXRYRUFJdlpm?=
 =?utf-8?B?RVRRQkdEODVncHNndWV1OVJURU15aEJaN2VpMTBUejZIdlpBaGQ1YTFROXlj?=
 =?utf-8?B?N1kvTEFrd2NSbHpPUGVFWlhiVTEvWU13SnFWV3BxTXl0WGlEWWlQL2dDMUxL?=
 =?utf-8?B?NS9aQ2RBU3NQZlJzdVhnZkNvaWRleEw2ajVET0czcWMxcTBHTVRYdzE1YjVI?=
 =?utf-8?B?UnU5aVJkalZMVXhHTGNaM2tScFIzQm9pV1hpNWo2QTRVdlJwc0d5ZjNER3dE?=
 =?utf-8?B?TC9tSUJyemFPSHhZNlVZNHNOSjhRdHhlV2Zwc3k5VjNqcUxjQjVtdk5YKzZX?=
 =?utf-8?B?NmNIMDMxd3hGV0N4RWN6aWp6TDI2MTlJU3lscWxJS1BuQXIvUFdvYzUrNGhN?=
 =?utf-8?B?OXRhb0d6VUIydnBVKzhIYXlqNHhCdlAwM1RzK0R3alJBOXV6WU5WS1hnTTNB?=
 =?utf-8?B?Vm9lRkNKMWIxdGZrdVFrbkUyZkt3SkRhNkRIR215VkZxdGl6SGlKWFdmN1VV?=
 =?utf-8?B?YlBkQjNUanVDaXBwUTBhUWZGemVXZE5jVXlXbjZaK1RKazZYQ0R4WSt5bWNo?=
 =?utf-8?B?UVErSE96UDNhNTNXZTJwZm9XdzA4c0RxTVA5VjllOHIrWGFsSnE3UjIzKzcx?=
 =?utf-8?B?ZlFSU3lOaGk1NEJET3N5WUpET2JiOWdaeTQvVGkzRUEvWlBBUVhydVJGckt3?=
 =?utf-8?B?Q2dvaXF5dGVYS2pDckRXekI5cEU3dTJPQ05OaHArbWJGTWdlQUJ6QjJmM2Qz?=
 =?utf-8?B?M3VwR2d6YzlVUzdqbGhENyt5dHRCeCtWNjBmS25PbnNYL3k1MURrTnV5Zm1M?=
 =?utf-8?B?Nmt5TTRQa2lEcUEvRlZUM2k1eitWOU55MDVGMThHcXFsaytDV01zS0ZPRE1x?=
 =?utf-8?B?M3ppYWwyWnkwdW16RlFuRjNYOHhDemF6Si9YeGErMm44bURNSmI4WU5SYnZj?=
 =?utf-8?B?YW1pTEk4QmxYWC94eXh6YWtRZXVCZitzQS9oc2lTOWFYdjJtV1Z6UlVHaFdR?=
 =?utf-8?B?ZTlpSll0cmtIWFBQZ0t4emdkOUN0Y3hrd3h4QmZ2OElzcEhwMlJobTJIQklv?=
 =?utf-8?B?c3dmQVhRRVRZekJWVW8vSTkvMHhMSjlQaklTUjZncVZIcWFnT2swVjVWRHhM?=
 =?utf-8?B?MGxjTThUQzNYOXk2RG9WWFNsaVgrZDNpMnZmMXo4di9UN1JSQW40OG8zdU9I?=
 =?utf-8?B?eEFOZ25QR2J0T0dpdHI1S3BWVDNoS1RJZDRQSjZQbFRIdDZ0cUdtWkNsQ2lS?=
 =?utf-8?B?dHBlazVtdjllRHpxaFlQTTlvcU14czlISnBHWEpHMkxsSGFRMGlJWmNJc0pI?=
 =?utf-8?B?Mk4zZ2R2ZGJ1aG9UUnBMaDBHeldZLzY2Q3k5a2EzSlZQYW9jUS9uU2pJTXdn?=
 =?utf-8?B?aGRJS3pjYThFd3VvVkZkeWNIcjFNcWFlU3kxVnZGRWxBQ1lTc1lXekhUdG50?=
 =?utf-8?B?RzlSZG5laExYei81dWhzelQ2QjlmSERQdkVhZzI0RjBBSVNETUNOSFlpNDF3?=
 =?utf-8?B?TlBOOHVsblRmdEJ4SmhkdUhEbXdnRXArTkxsZmZsN3dxKzY5K1lvaUx0VHVU?=
 =?utf-8?B?TGZKSVRLclJhRnJqRW1WU2xOMlFNdWhqb21wWEl4ajZZNFljOEpEQ3lRNGJG?=
 =?utf-8?B?RStuMmhXdjZhMng2T2toVUU0UHgyQWpMQzBaeVdTN2xHbTNML3NicGp4VkJ3?=
 =?utf-8?B?MTV5dFk3NXVxWWUrdGxLaUx5bGY4UnlGT2c5UHVLd0RtZnpKQXNaZ2JqSXpT?=
 =?utf-8?B?N3g4dFl3QWhoeWgvbXR6aDBCcmMvNW4rR2VQeEdCOC9HNXBrYTdXYVF3NkdM?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eab2444-07b4-485f-5fd1-08de0bec1b5a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 13:09:43.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQvHVoe0+yJ4rznSOxXEIkS8hLztXN0djAlE6HIIE1uAgh7UBg/HcnstI4aIgVgyyqkSbMY4hPmgEp8AWaZ65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com

On 11/10/2025 14:12, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Add support for the mmc controller in the Eswin EIC7700 with the new
> compatible "eswin,eic7700-dwcmshc". Implement custom sdhci_ops for
> set_clock, reset, set_uhs_signaling, platform_execute_tuning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510110904.0H6EStUB-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202510110829.1yKzYvIP-lkp@intel.com/

The test robot tags are only really meaningful if the issue is fixed
in a separate patch/commit (i.e. not just a new version of
the same patch/commit)

> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Looks good.  A few minor comments further below.

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 526 ++++++++++++++++++++++++++--
>  1 file changed, 504 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..28bb2067f945 100644
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
> @@ -39,6 +43,7 @@
>  #define DWCMSHC_CARD_IS_EMMC		BIT(0)
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
> +#define DWCMSHC_AT_STAT			0x44
>  /* Tuning and auto-tuning fields in AT_CTRL_R control register */
>  #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
>  #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
> @@ -194,6 +199,19 @@
>  #define PHY_DLLDL_CNFG_SLV_INPSEL_MASK	GENMASK(6, 5) /* bits [6:5] */
>  #define PHY_DLLDL_CNFG_SLV_INPSEL	0x3 /* clock source select for slave DL */
>  
> +/* PHY DLL offset setting register */
> +#define PHY_DLL_OFFST_R			(DWC_MSHC_PTR_PHY_R + 0x29)
> +/* DLL LBT setting register */
> +#define PHY_DLLBT_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x2c)
> +/* DLL Status register */
> +#define PHY_DLL_STATUS_R		(DWC_MSHC_PTR_PHY_R + 0x2e)
> +#define DLL_LOCK_STS			BIT(0)/* DLL is locked and ready */
> +/*
> + * Captures the value of DLL's lock error status information. Value is valid
> + * only when LOCK_STS is set.
> + */
> +#define DLL_ERROR_STS			BIT(1)
> +
>  #define FLAG_IO_FIXED_1V8	BIT(0)
>  
>  #define BOUNDARY_OK(addr, len) \
> @@ -206,6 +224,31 @@
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
> +
> +/* strength definition */
> +#define PHYCTRL_DR_33OHM		0xee
> +#define PHYCTRL_DR_40OHM		0xcc
> +#define PHYCTRL_DR_50OHM		0x88
> +#define PHYCTRL_DR_66OHM		0x44
> +#define PHYCTRL_DR_100OHM		0x00
> +
> +#define MAX_PHASE_CODE			0xff
> +#define TUNING_RANGE_THRESHOLD		40
> +#define PHY_CLK_MAX_DELAY_MASK		0x7f
> +#define PHY_DELAY_CODE_MAX		0x7f
> +#define PHY_DELAY_CODE_EMMC		0x17
> +#define PHY_DELAY_CODE_SD		0x55
> +
>  enum dwcmshc_rk_type {
>  	DWCMSHC_RK3568,
>  	DWCMSHC_RK3588,
> @@ -217,6 +260,11 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +struct eic7700_priv {
> +	struct reset_control *reset;
> +	unsigned int drive_impedance;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -238,6 +286,28 @@ struct dwcmshc_pltfm_data {
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +		ctrl |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
>  static int dwcmshc_get_enable_other_clks(struct device *dev,
>  					 struct dwcmshc_priv *priv,
>  					 int num_clks,
> @@ -1095,6 +1165,413 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>  					     ARRAY_SIZE(clk_ids), clk_ids);
>  }
>  
> +static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	u16 clk;
> +
> +	host->mmc->actual_clock = clock;
> +
> +	if (clock == 0) {
> +		sdhci_set_clock(host, clock);
> +		return;
> +	}
> +	dwcmshc_disable_card_clk(host);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_set_rate(pltfm_host->clk, clock);
> +	clk_prepare_enable(pltfm_host->clk);

Seems unusual to have to disable and re-enable a clock
to change the rate.

> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	dwcmshc_enable_card_clk(host);
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
> +	drv = FIELD_PREP(PHY_CNFG_PAD_SP_MASK, priv->drive_impedance & 0xF);
> +	drv |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, (priv->drive_impedance >> 4) & 0xF);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +		val |= DWCMSHC_CARD_IS_EMMC;
> +		sdhci_writew(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	}
> +
> +	/* reset phy, config phy's pad */
> +	sdhci_writel(host, drv | (~PHY_CNFG_RSTN_DEASSERT), PHY_CNFG_R);

() not needed around ~PHY_CNFG_RSTN_DEASSERT

> +
> +	/* configure phy pads */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +	val |= PHY_PAD_RXSEL_1V8;
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	/* Clock PAD Setting */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	/* PHY strobe PAD setting (EMMC only) */
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= PHY_PAD_RXSEL_1V8;
> +		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +	}
> +	usleep_range(2000, 3000);
> +	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
> +	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
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
> +static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *priv)
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
> +static unsigned int eic7700_convert_drive_impedance_ohm(struct device *dev, unsigned int dr_ohm)
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
> +	dev_warn(dev, "Invalid value %u for drive-impedance-ohms.\n", dr_ohm);
> +	return PHYCTRL_DR_50OHM;
> +}
> +
> +static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	int delay_min = -1;
> +	int delay_max = -1;
> +	int cmd_error = 0;
> +	int delay = 0;
> +	int i = 0;
> +	int ret;
> +
> +	for (i = 0; i <= PHY_DELAY_CODE_MAX; i++) {
> +		sdhci_eic7700_config_phy_delay(host, i);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		if (ret) {
> +			host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
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
> +		pr_err("%s: delay code tuning failed!\n", mmc_hostname(host->mmc));
> +		sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
> +		return ret;
> +	}
> +
> +	delay = (delay_min + delay_max) / 2;
> +	sdhci_eic7700_config_phy_delay(host, delay);
> +
> +	return 0;
> +}
> +
> +static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	int phase_code = -1;
> +	int code_range = -1;
> +	bool is_sd = false;
> +	int code_min = -1;
> +	int code_max = -1;
> +	int cmd_error = 0;
> +	int ret = 0;
> +	int i = 0;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		is_sd = true;
> +
> +	for (i = 0; i <= MAX_PHASE_CODE; i++) {
> +		/* Centered Phase code */
> +		sdhci_writew(host, i, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +		if (ret) {
> +			/* SDIO specific range tracking */

This is includes the MMC_CAP2_NO_SDIO case so the comment
is contradictory.  Could just say "SD" instead of "SDIO"

> +			if (is_sd && code_min != -1 && code_max != -1) {
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
> +			if (!is_sd && code_min != -1 && code_max != -1)
> +				break;
> +		} else {
> +			/* Track valid phase code range */
> +			if (code_min == -1) {
> +				code_min = i;
> +				if (!is_sd)
> +					continue;
> +			}
> +			code_max = i;
> +			if (is_sd && i == MAX_PHASE_CODE) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Handle tuning failure case */
> +	if ((is_sd && phase_code == -1) ||
> +	    (!is_sd && code_min == -1 && code_max == -1)) {
> +		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
> +		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +		return -EIO;
> +	}
> +	if (!is_sd)
> +		phase_code = (code_min + code_max) / 2;
> +
> +	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +
> +	/* SDIO specific final verification */

Ditto

> +	if (is_sd) {
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
> +	int ret = 0;
> +	u16 ctrl;
> +	u32 val;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_SW_TUNE_EN;
> +	sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +
> +	sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
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
> +static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
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
> +		val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +		val &= ~(FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY));
> +		/* 2-cycle latency */
> +		val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, 0x2);
> +		sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +
> +		sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
> +			     0x3, PHY_DLL_CNFG1_R);/* DLL wait cycle input */
> +		/* DLL jump step input */
> +		sdhci_writeb(host, 0x02, PHY_DLL_CNFG2_R);
> +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
> +					      PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
> +		/* Sets the value of DLL's offset input */
> +		sdhci_writeb(host, 0x00, PHY_DLL_OFFST_R);
> +		/* Sets the value of DLL's olbt loadval input. Controls the Ibt
> +		 * timer's timeout value at which DLL runs a revalidation cycle.
> +		 */

Prefer multi-line comment style like this:

		/*
		 * Sets the value of DLL's olbt loadval input. Controls the Ibt
		 * timer's timeout value at which DLL runs a revalidation cycle.
		 */

> +		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
> +		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +		usleep_range(100, 110);
> +
> +		ret = read_poll_timeout(sdhci_readb, status, status & DLL_LOCK_STS, 100, 1000000,
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
> +static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int timing)
> +{
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		sdhci_set_uhs_signaling(host, timing);
> +	else
> +		sdhci_eic7700_set_uhs_signaling(host, timing);
> +}
> +
> +static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
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
> +	dwc_priv->priv = priv;
> +
> +	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
> +	if (ret) {
> +		dev_err(dev, "failed to reset\n");
> +		return ret;
> +	}
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	hsp_regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(hsp_regmap)) {
> +		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
> +		of_node_put(args.np);
> +		return ret;

As the robot pointed out:

		return PTR_ERR(hsp_regmap);

> +	}
> +	hsp_int_status = args.args[0];
> +	hsp_pwr_ctrl = args.args[1];
> +	of_node_put(args.np);
> +	/*
> +	 * Assert clock stability: write EIC7700_INT_CLK_STABLE to hsp_int_status.
> +	 * This signals to the eMMC controller that platform clocks (card, ACLK,
> +	 * BCLK, TMCLK) are enabled and stable.
> +	 */
> +	regmap_write(hsp_regmap, hsp_int_status, EIC7700_INT_CLK_STABLE);
> +	/*
> +	 * Assert voltage stability: write EIC7700_HOST_VAL_STABLE to hsp_pwr_ctrl.
> +	 * This signals that VDD is stable and permits transition to high-speed
> +	 * modes (e.g., UHS-I).
> +	 */
> +	regmap_write(hsp_regmap, hsp_pwr_ctrl, EIC7700_HOST_VAL_STABLE);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
> +		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
> +	else
> +		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
> +
> +	if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-ohms", &val))
> +		priv->drive_impedance = eic7700_convert_drive_impedance_ohm(dev, val);
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1169,6 +1646,18 @@ static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
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
> @@ -1238,6 +1727,17 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
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
> @@ -1338,6 +1838,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
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
> @@ -1469,17 +1973,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> -{
> -	u16 ctrl;
> -
> -	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> -		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -	}
> -}
> -
>  static void dwcmshc_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> @@ -1570,17 +2063,6 @@ static int dwcmshc_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> -{
> -	u16 ctrl;
> -
> -	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> -		ctrl |= SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -	}
> -}
> -
>  static int dwcmshc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);

