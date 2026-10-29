Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793280661;
	b=zW5GNJXeTtdItisWHdRW5Xe0eQfdKGKSykYyxasgROZ3/ypFraoR1jsuwXnI7pIEJMlS
	 IKSsZqXcwZj21aDhPWB7APo2EF1OrFa6OEkJZ++r/PkmIRQOR6TQmDAkMciYwbGIidmyn
	 yO9tWYtaKWMDMAj3xD+pYZ+zBGAlPkUHvfB62K8e5aFqVfLm/LFk9o16uxZNBnZ+k/Og9
	 bQXBReVehtvkNqGrLXthDbC/LLpJmGeb6mc4HcfUcOZTBuxSAJ+/J+ZN0cN8zfUkQQcqC
	 RdNN5Lu4J+41NmCN9s3/42PUTMVam4YQUtaXM/ewJxgYmBcEhalqmWpQE4i6xa3WEDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280661;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=V7aW5LIr7L2GSPUjs+x9CLXGgo94k6NyizG3TKtWNlo=;
	b=uONB8xRGGPm2qkgPsfiZHVX37yYGsUwYbWmJuDNyAkrkwG6szuoJFqgAXiBICSzcODoU
	 4q+VyQRItB/qxxfAbimtkaWS33/RVneggjTedLHUthmUGOjCI3xKwLrhG8G7XJq3aSTAy
	 APayIBtVEWvCuuwJkJXkKqre4KPIJIzWKAYIw5nNmkZH82UkKK9x7Gicn4YNQuZpqU3dE
	 NPKKYbjDIhhCswRRynu72pePYFsCRyXk1adB3pfBcPVRNfK9Nf17qXJLj3Yhqmmw4VSG4
	 wVIqm25QeClcfIU8IjumqZxbcm1Qu0WbPJHlPP0NTHgQI0c3P3alauGwZX4CJhDxEnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HWP0nN1O;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE317606A31D;
	Thu, 29 Oct 2026 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE317606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HWP0nN1O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280660; x=1824816660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kN8+DTSEMxnSJyTGYiBrObVCvaziliWm95xvXbAJUA4=;
  b=HWP0nN1OkLdajRFzsT664jcUU2gLzDHr7L0isERwhYclgXyCF4MRF5kX
   hK1qnZrgBrSWClQmwPqWxYxA4P1zYPr5SegefY2Of4kLgGGsoXUmckVb/
   ZvdU38K0FRFGX0dcwgtRAh4RkwntVFBWun/nLe4uKjRjF0St0soJcTIOW
   A6MHk3qUdg4KvHl2D/0BAdtq0DM5m/Xw5hWdh7uUlhe+eEoLWa6sBAZKQ
   bRZ4Thj/OlP5jPnj1WXBzWwgZNSLbmtPVqG/e71KK8jdk/Pdn+PrLXur8
   gKmGDkdZKBB1T8nI2Afu0eC0QFJQCUIghbQgBkVSDfNMlIsENJZvf5Ydy
   g==;
X-CSE-ConnectionGUID: 3dGDdP1ETlWK9o9Iqz0RMw==
X-CSE-MsgGUID: f/5Ulj5nTe2k6mUBl3TdzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2126919"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2126919"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:30:59 -0700
X-CSE-ConnectionGUID: AVvL9TA7R62OgzEQAM4yyg==
X-CSE-MsgGUID: j3BauZ51ST64KyOoe9QCtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5282789"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:30:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 06:30:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 06:30:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 06:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu8Kyv/M6b7Bz4RGViPcVArT5waTlTJN86ztCPZ2DvdxqPecNqDmF3WvOqXTO4az8MgsY/TwGzir6G68GhVGn2DggiZlHINLFbYh3HBNbiHjNx1S2SlOGLZoh/laaCwxBmTjJu21CpjO8gCjw4pZ8stlzv34dCWbK+UA82op83Z39iPmFQRk5LAMhWdIJwTgtE3yrDhogEz1rYYYlFfft2VXae1IIT+2mRI/ShJE+pfw5Wy6RXACDCRcTvzL8lqXXYaWDpqNJxnizk74gsSLMXLgSLb1F5b1CJeQ6bCJ9e9ds0CkJZ6gHRFe5Zu6UQfegPmyON6lY6kWPFO5tAi+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7aW5LIr7L2GSPUjs+x9CLXGgo94k6NyizG3TKtWNlo=;
 b=gTPkM49NAQhyj5dMMDzKjxfEX2Ly8dAzaha9Y9dgMjoGChcOc6we6cOe/Iz3ZeTwtV8Ices8xqAzwmDU+hpFZL0CNHFFInLp3Nm7wUx38I4Z4hvqYiqsGWyJBpz/Wbkiie9mTdBHZ2kt87Hx5Ynms40au95FXL0OViqy170K0qgSoMXDde3o0/6g9B63ETHG/4jrTXTmie0ZHAWvUyn6qtJ0hLnwy7BOvA4RTRM5KhkOUM013ywv/Qb7pGvx8Jhf0NMooBRYsTgjrr9Ru5RWbMnFnl20VQu7w0MyjKv9JBzkCEloLChG8WEPmtnC1NQCgtn93YJ4EcA5QrjOLlRnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH2PR11MB8814.namprd11.prod.outlook.com (2603:10b6:610:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 13:30:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:30:55 +0000
Message-ID: <ae75bad6-ed8c-4510-9650-888bfce423f7@intel.com>
Date: Thu, 29 Oct 2026 15:30:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: downgrade HS200/HS400 clock-reduce
 message to dev_dbg
To: Jun Yan <jerrysteve1101@gmail.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261009084604.385664-1-jerrysteve1101@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261009084604.385664-1-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH2PR11MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ce3683-bb65-4ae8-d82c-08df35c0dbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261028144727099003|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261026140227099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ul+l6gFrFVSfs2eH31pWYuGh6q5ALVUqGfkEwV/6xoyOOkf/Nu8r+lTixzGD5123mX95vSh74KoZbVs6Pfd4/nsC9EFD+AVa+gyco5PqkwuweW0o3BHMwPBHZ4xt8wgXRHrUdPJ9ETroBfw+Rxm1ADY+bOlDVbGzqoHoztcIP6NpOhCpT9IcPtMG8tLCEvyJIc6CC4BkZ4bOfo1KSdk3fVKiwMKqlSl2/CdpYPzOmC/ejrRtz/yJsVa5N0NjuWhVdkmO2CIVTwrllyUaoULMLo1M2KL0YecKH8x5AOjEFpTrnHbaas61YIwA4jqDoxRxL6+4xHOtuT4TqDzqzssC1iZgy+UzeABAjdS82jxQe4JFf/zpspmd//7DNTBBGUKPUp+VR2BWgH595qe1jFMJYbiaB/i3i+nUkw4mQlIIOln4+kZ2WIdJogn54VQ5c5Q1oXCNtGU3cWmNdDyqf4AQSAeNGf3fTOOFiRx5GMF3HezBNAWrmjtwONkRaoY6oWriloQEmwYM4AMn9yYX+hT2XDOg/whthz7BSLYD/2q08Mla0kTm7hNKsnO39+CyHSXymvuEcV9W1/1FbYpZmCK9LhYP9EZAyCotCu3ddTQc9NL6ldgEVfZPn7hhgPJdtedo4Kt9PGrupc72JUpyeCNk6nqyezf8JhsYEsIAtIfoLM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261028144727099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026140227099003)(10067099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTR3TFVWK1FZcU4wblJRSG5yZWxzdmgvVEt6amtqc0IyZWRjNXZ0THI1QUFG?=
 =?utf-8?B?YTNsZFBpTjZJVnVhelpZajRKd2JVL0xuQTgrMis0YitlVS9UZW0zb0RpanNC?=
 =?utf-8?B?MDVDbC9wSHdubGlXSDYwdi9uVUNZc2NMdENhM3B4dlRpOVZkZkRZTkJzK2dJ?=
 =?utf-8?B?MFVoSjUzclZHYStEdG1sMHluQXFaQjY2dzVQTVI4L2FvMEF4L2krZENlbUsv?=
 =?utf-8?B?Z3l1eWM0aVR3RCtGZUhPcDFmazBpcFM2YmZpb1RvRUNRdTBZNEVSYmFaMVVU?=
 =?utf-8?B?VEhmVVdlVVpqWVJQSGliZEtWSE9KcG9UZnpyMkt2dElGR2lka1pMTGJraWVK?=
 =?utf-8?B?WmdFVGFPMWh2bnR1NWNJVjZ4cXJrL1dBaENMT3FiL0FCcWtndVhickZ2UlRB?=
 =?utf-8?B?TWxGYWIzZG4wVzhnK25YbzVLR2w4OGYxY2ErQUlka3F3Z2MzMFhFdzlGYWl0?=
 =?utf-8?B?KzlsUmo5akRWUVJKdUM1N24xenI2c3lnNWpWQUw2NkNFeW0wVGZOUjRDRmhx?=
 =?utf-8?B?WmxiWUcvMmU3L0NQNUNGZWF4bUsvdXFwKzRqRTg2Z3JpeThWZlFtdnRZZWdz?=
 =?utf-8?B?UTliaTBua0hHNUorQkNYUTMySnpHSVd0S0dmMnpwWW10NjVuOWhXVjZDd3oz?=
 =?utf-8?B?NXovT0UvV05vZkthaXdXK2NVN3dLSTZjR1VEK0RVNVl2LzZnbWQ1RURuaFpW?=
 =?utf-8?B?SUJ5eWtCMmRoUlF2WkpjMGFJTjkxNWpwT0tTZHpsZHJXOFpURjNDR3FlT3FR?=
 =?utf-8?B?Mk1PU2VkSHo1SVdEdnJRaW9xaXBadlFaandJSHNsR1c5bDVQWG16RUxScjJL?=
 =?utf-8?B?eGtHNkU1UktnZ2xpYmpJZ0N0cWNhVjE5VldCNmlTR05uNnNTWW5vY1Ywazlj?=
 =?utf-8?B?WGl0czR4U0wrOEticmFWNVdFVTN4QXl5ZlEyUEQ4b3E0SUtXN28rNHhwbmgv?=
 =?utf-8?B?aTRCOEQ5NzE3OTJZK2ZFd2J5aTUrZEx6eDAwVExLU3pQL3hWVEc0a3grRWFx?=
 =?utf-8?B?QzFMSXZCQS81MlpXT1lwUllYMndDaDJ0M1NBc0FublNQWUgrUVFUTmxnMVRk?=
 =?utf-8?B?aHZMYUJUdkMwNysvc3M1NHFnQk9JSmt2U1hMUTdaMnUrV21UM3Y3aldaL3E2?=
 =?utf-8?B?U3lVK1c2ZE1oZkQycmJWOGIvM1g5S0JtK04zM2l2RHpvYksyajc0b0EzaFRQ?=
 =?utf-8?B?MEUrbWNkVnR4V01xTFg0ZWMvZ1J6ZTFJVTRmNFJqOCtqeHhyU0ZpN1QwNjFs?=
 =?utf-8?B?WVl5Uyszb1JJQklaL2RoeHpaM3hwdzNjcDFVTGRUSlZTQ0gzZzdHYnNmZGd6?=
 =?utf-8?B?OWlZTW9QamxJWER3NHVPblFMSi84aWd0WWRzZllkaWoxUWJsVTVyQlhibzlt?=
 =?utf-8?B?d0R6Y2UwRDk5bGpDVnNseG5hY0NEdkVIZFRDalRrcmNOU2RwSnM5RzNaR2pO?=
 =?utf-8?B?NWpzcHp1ajhrV2U0RmUxT0ZpbU9YVE1VaTJqTmRLTStQUzk5SyswMjZKSVZk?=
 =?utf-8?B?MC9EaFc3Y0w0bkQ5cGJMQXhMTnVObnlXWDM5S3RzL3RrNytFT0ZTRGF2dUdE?=
 =?utf-8?B?T09LM1hyM0taTUQvbkZaakhEOUlGVkVwZmhNalBrcy9vT0txbjdSYmJRNkc2?=
 =?utf-8?B?emFkWDEraHVzcWJqQWNKUkZjb2Z5d1ZTRXQxWHpVMHlNcGQ5OEQ3dE5KM3ho?=
 =?utf-8?B?d2xvbE84eExOWHBwcUlNUjdvb0dHdVQybmFxeEoxb0RWc3ptSTdBcmtlb0Zz?=
 =?utf-8?B?Ri9vRjMwUTJNcWpvTHNGYm8wMTBPSm9XZXp3Y2ZRKzFvTnRoU1FndTRXTDF1?=
 =?utf-8?B?YU1Jc3NGZDNZaXMyYlo0VUR1TjFhU2dJMytUd2w5WlN5WENoeHhSdWdQY016?=
 =?utf-8?B?SjU5TXU0Q2pCUis1czRTV1FIeVAra0xQS2JZK1NxemlleWdCU1VYZHdteTM2?=
 =?utf-8?B?Zi9QU3NVY1ROVjRzMkdCQWJ6SW1ucnVYZnc1VGgwdzl3b3F4ZDZtRGVMRXBI?=
 =?utf-8?B?QXlFWldyVU1HYTN0MjcvcmRxaUZRc1k3Z2l5NzVFaUsremFNTUkyVHlVMWVo?=
 =?utf-8?B?clp2a3dTQzJqc3pZbEp2Q3pwUkZuTDZvMXZadzNzUW1YdW5ORWx5V2JBSUJH?=
 =?utf-8?B?VnZwVlEyYkNTMU1XdHFGVVV3ODAzUi9lNzBHaHRHSHZiNm0rRHlsOXlSQ1d1?=
 =?utf-8?B?eW9qU01sSk9KUmtIRzZHV3cwc1IycEtSNmlXZGdTVC9ORHVERFl1Z3k2azR3?=
 =?utf-8?B?QjJMMGZJR3FMUXo0NWhwRmFwVHlJY1NSRGtJRGJxU1ZNdldMeFBKY1ZlQTZV?=
 =?utf-8?B?MnJLekdMcDNiQTRCOUtja1E5R1V0RTNqMC9ua1BsVWJ4VU9zY010ZTdsRnNh?=
 =?utf-8?Q?cjsMnx47joaS+CWc=3D?=
X-Exchange-RoutingPolicyChecked: v6LxELiBzOmVT3J3YRKvgrvzEY9u6pYjAO8/lI5YEOTxBED6cy5d6sH9OF8vEaq/I2SmaFeZVeuuOZkY8Ndh3Fwvivo7iWywZwaVyQ6I6NxpHihkKEO5ObBCFA7z1N0lRCLW08LplszjfqQ0DucZ9z93si2QhkpyC8k+8ZkGbf1jh4QRSx8d7ejLSbXmatVXAlSHv29/FRviI8pBr1edeMyZ7OD5B+EgjXF6wgkLDgPKiQzPveFPuxwzp/VNi6Ra9sGvpO3JX1bldKwDauFhRbE/smCHAkX+2KUzIsd8e1tLDDIJgebtIHUONaA/a+Z/lB7a5gMasP6RqcpvmL890w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ce3683-bb65-4ae8-d82c-08df35c0dbc6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:30:55.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuqLmDU7wFxiDTBMApu8iDDYy5VzmPpfk2nfKj1YL14CLdAUrYAPyaKRhCUUc11ACq2/hDHT3fQFrQqLqV6YSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8814
X-OriginatorOrg: intel.com

On 09/10/2026 11:46, Jun Yan wrote:
> dwcmshc_rk3568_set_clock() refuses to lower the bus clock below 52 MHz
> when the eMMC is in HS200/HS400 mode, since those modes require a
> minimum 52 MHz bus clock.  This is expected behaviour, but it is
> currently reported at dev_err level and therefore fires on every boot
> and on every suspend/resume cycle, cluttering the kernel log.
> 
> Demote the message to dev_dbg so it stays out of the default log while
> remaining available via dynamic debug.
> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index c688f3eaf468..b4fb1c1e6d99 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -790,7 +790,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	if (clock <= 52000000) {
>  		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>  		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> -			dev_err(mmc_dev(host->mmc),
> +			dev_dbg(mmc_dev(host->mmc),
>  				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
>  			goto enable_clk;
>  		}

