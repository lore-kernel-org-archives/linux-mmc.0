Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793986596;
	b=eDLdOhW+9Ato9yb1Yl4XVbEple8/XAcANUJFIKuMid8VZF3BDxHpapy1Zp07gEc8+P8s
	 OJP4/U5XrlpJp2wu2f3GoThxzJ1bHG7dBydxo7h/dsfW77Y4RzNUabTQZ8tflsdck3hfC
	 E+friKzyaU1OBTF5VALvfXan7lj53lA8KIRvnLH+w2Qqbl2QH93hTKX4y3vYZrfKtKmPM
	 sja5nKl/7uAqtI7ryIgfF77qBZzOqUh6NyNeU0itq80Bi4uS16yNvHFx+bmd4Q+N5H+BJ
	 YCTYrPS+z2vuo6KotrWNsxRm6WXyvKEqX8Z4x8Zu0lcrUNxmaTvTUZN049Rv3pHtIUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986596;
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
	bh=/BtyBSO4DwtnyQKP+pYaqsMV8o2UVKLeOPGnq/nxUII=;
	b=CFWJqaiijAjg0hRiL87exzU7W4OqRkav6IXI/jppClzuZQjmFrR2SkA4uHRrMACtIehG
	 Feyla8SpcLY1bPzzJn2JPo8YCPATLyB2kPPRuPwaO7RYvWQhE0Q3U0v0TWQVjh86XIxeh
	 kRVpLy99Fju0nWbO/5Kym1IuFEy4bpGUOOq/35smWXQkFnNSxEedLMLuF1hZE7SLegaBN
	 G9cb+zuSw5BrdzJO/poF697KVUgPwU3S6SBPRVR4cEzS46d9VvooL5jnPbFHYo4uq6IkT
	 IoQaDFZ8dy9L9ATaYXSqfonmr1lAiq4r8eEByWWi88vAn+cR1rhdCf6eKabIXKkkPGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="B/0fVHTh";
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731D606A326;
	Fri,  6 Nov 2026 17:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5731D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/0fVHTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793986595; x=1825522595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i6VsSKM5W0bmpkLWcg0wPZ413mID17OncxWo/4pFBcI=;
  b=B/0fVHThIq3tS/ecS1XpIIIMwwds7CW7ZZgal7GmokgJuKs/N5JEpt/r
   NOnrg5lTC5n/Ls/ZPed1v3RDA+2qQ1T5jx7K9iKIHv8lnvBJSpDnshoYt
   f+p7jh7TzrutaS+WrIsafRn5iloQ//RThUCMSUSbcb7nS9VhZgHIcekWG
   wkAvJ762XXS5+vqrkcvpBNOhek7PxWf4FZ8Rye+8rr5tOwBJAlMYeMZfn
   YcyQvbI+u8uoElzgjmwzIbZUrqVuzJJoEEKixiplf2pQwSv51j2XV1pkF
   yuPLTgEilZo5oN1t7eysn+uc4u0Wfeyr/XjakG6Ql48bIBrK289fSzXUm
   g==;
X-CSE-ConnectionGUID: UuDM/QKSRnqc8BATocvA5A==
X-CSE-MsgGUID: T59s223FS3Gh1DwBfThskw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2681248"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2681248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:36:34 -0800
X-CSE-ConnectionGUID: k95fX93fSUWUanFbh9w4wA==
X-CSE-MsgGUID: a++ElpIERuKoX9VF/1ZgAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7360719"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:36:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 09:36:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 09:36:33 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 09:36:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBt/aNHXk8iCnCFUbtsG4iBBx5S4NlSEMk8N/hYfksB22i8vljEjeGjeUkpdoz/38z+3klv6aj7AFKjIGaeYvBTHiHWHzKObJ8xW1TC0FjhABu6GSiMxFc87CXxbD0wUyRqcpZLBEijc6cPg6vmVm41+KVHvudnvddU+m8gooF+hCcNWc79YlilAFJqItaDzOXg2ppKHZOCiIT+iSfsfBRwhP1A5E7pzlRTWXyX/vlerHiRywzhb1ic+pM/qQlIXeYqK5rWmGgahfpuHwMdGkLvvIRzEROZPGCM+lmFqs7Q3jsXvgMeO/iMmUnH3hKlvoHMa9DERraC/WDpHP1baoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BtyBSO4DwtnyQKP+pYaqsMV8o2UVKLeOPGnq/nxUII=;
 b=Oxi88JKuZAr8DzmXd5ElH4QjC7XImtyrLegAmtQJ7IrPxABD/expeQQzvDfcGt5MCG4AUw9FjZRuBATdJRiDoL39uft+u87IsvZ65N32yfSm1u9EeFZQ10Pg27WifSBqMYxX61SmV8tHjo4uZvcK3bpXoK6cMio6YTpAaqKXPz6HwM0uVhglewpI0Gi2oMWhDdovKFA1ZatIjPR5Y/G6ucO1fq3Mn/xu1RGdaT0SeFnQjZsHdJdZY2vKi7i7wAh+1HDuI4OGE6rP5eB3Vf9Oqp27ya3uiv4otnYoPoeUV/UPYMK8peWm1FiGvlq2eEc7rDOb6XO+pHQZunPCtAjvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 17:36:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 17:36:30 +0000
Message-ID: <2ba59618-e537-4593-a840-744b2f26eb4b@intel.com>
Date: Fri, 6 Nov 2026 19:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Use named initializers for acpi_device_id
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, Ulf Hansson
	<ulfh@kernel.org>, Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Hu Ziji <huziji@marvell.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20261106-acpi-mmc-v1-1-00934babd69e@thegoodpenguin.co.uk>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261106-acpi-mmc-v1-1-00934babd69e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0326.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::25) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PPF30373102B:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c71271-d759-45bd-d20d-08df3c2c7dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|10067099003|261102123227099003|56012099006|261009223027099003|261022105027099003|261022075727099003|261026140227099003|11063799006|261028144727099003|260925021311599003|261021121427099003|260925021911599003|261026121527099003|261021123027099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: e+dpGFDa0c4Y2P5AwheAHbVs+Ua5ekuAeJQRZqv6Gkzsyci6AK34GJTreNESfOO4kr5aVCMA6d44qMHVr7oZoqadDodPupecBbG2dqflri346HR8W7a8fkdZ1G9VSj2O9FmWAUubtQkcY/hep/geGRiS18PEjots5fUK6KSRbutYoL0EX4MMcmE03zl255rbRKflwGmaQbXAwU2tUyUuSne4ORGcyVFCedFT9am6VYD4dlQZ029+1P8jVe+zCZDsE5yGS/OBwWiIBM3ojTvE9LV0rolxWsMMtYH+ntf4DqqOXYRTj6ePR23TTgpbaT7pTY/Yd/OIWAG2iWXnnjLENmAm3Hm3gn/SmwLhrTgmPHKQ6Wu9gcjGrPnEE17J7LcTQJkbPuFpcg47+87/1b/Kh0kqf9+2i3vmlntBMG0BkEgZB2v+Y3nR3cxPN+KU50laYMXaskEJGmiJq6ziNP+dGPRgb4Z2gPerfD95oDmPbFRA2lzhDBfGK7L3Zhh93EV3ULon3/PTSFNmW229dSQgUJa1pXmwAz1Gw9VqtmSXeIDnvuJy47/9wlEpLqhkQHk8BpAjjaZp+DEemduUHvL4dKGyQcIkQPzzgQ10aE1KJKnEpBOK7Dv5DpC4JeOuDZqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003)(11063799006)(261028144727099003)(260925021311599003)(261021121427099003)(260925021911599003)(261026121527099003)(261021123027099003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1xYmNiTnE5WDFEc2JucnJHaGxMbTFBUm0reWV3T1BCaHppamNYQWRQbE4z?=
 =?utf-8?B?a1dIdnErZXBGbGFKLzAxZkx2YTZ5Q2JNV25ZSU9BbGRDSWNtekZwdVJ1OHVR?=
 =?utf-8?B?RWZMV3JlZmZNYXB3RGhIazExQTcvT3BtRmFCNlRpOHl1RzB5TWZmc3E2YUs3?=
 =?utf-8?B?ejBqZmUvMVV1VUtBVy9NVjhKMDdmMlBQVkEvekl1YlNOa0R3MDhqd3VScVNS?=
 =?utf-8?B?cjJjNkhpREdvNUFkc3RDZVYyWE1ESFJVT1IweUVvSzVqak9xNTJPVG9TS0V2?=
 =?utf-8?B?Qk5pUW1TOEJBNlFCeWUzU0M1YlkvSzdUenRMckZENU45Um16aDYzakxtTDNl?=
 =?utf-8?B?TENvM3hBcGVwUm40Qmo3VDhZeTByemhxb0JpU2hwV21uQW9nRDJnYUFJZ2VC?=
 =?utf-8?B?bUMwM2ZIcmZBRGIzNTY1UW5xdjlYZE1zS04xYzZkYWp3VVFMVlMwQXpNa0tk?=
 =?utf-8?B?RDFzeTVHa29idWtLaWluUXdkMmM5bUdBeGhHbmNPRUxWUTZEdUtIRGxhT3Ja?=
 =?utf-8?B?TEZzRTRiWTVGWjQ4MTNnNTZ1YmUwNXNWbHR0K2ZHSm83TmJ2MXVacjRhcU92?=
 =?utf-8?B?dWo0RVdZaHJwb0VraWFoMkY0Wm9EKytyNjEwczV3bWpRcWhqTWh4aHp3QytC?=
 =?utf-8?B?TVZrT05PVWVlcnF6bWtuY01BY0NQL3IyYTh4NHB5OHBVVUtVVUhWWDBGRC9H?=
 =?utf-8?B?S3V1N2pZUFhFZlhkMmppWE1vaTlEVjZGRGRGb24wTm1oNVpKMndLU1hicXZG?=
 =?utf-8?B?SE13bjFYOTlXcStpdkE2TEdmd0I0ZXZZZG13NmQvOC9wZDRoK1RsN3VjTUFU?=
 =?utf-8?B?YmRCb09ub0l4eDl5M0tJSU84Y0VXZ3kxRWtDblMydVUwK2I2Y3ZnUW9nTVNM?=
 =?utf-8?B?b29WdE03SlBKUlFvQXZveHc4NkVnbTlQY2VhdUlmSkh4dmlqUysyaDI2Y2hu?=
 =?utf-8?B?b1RlQU05b090OUM5TjBJOURiU1pOOWJ5ampwbkg3aDhyNWVLYS9pbmtqbEo5?=
 =?utf-8?B?NmpaVUxzT0hSL09ZYUsrOXRBQkVDSm94YXkwOVgrb2JVd2pTYXpucDQralhj?=
 =?utf-8?B?Q2V5ZnFSTlpXUDNjejFlY3d4Zlo4R2VlZG5xcGdodnoySXNkdnNYaXNaU0Fi?=
 =?utf-8?B?YmdXakYxNEVOcnZpdStFSFcxT00yOUtMQ3pTdWtnVCs1U3FzMEtaL1h0eUIz?=
 =?utf-8?B?WHVZakdTL3MwWWNsNE9pK1pUVDhBdzkxYVBHVzZ3dzJaOEI1YlRlVWR4aHp3?=
 =?utf-8?B?OC9aWCtPTTlEUUg2d0kyU01maU92bG1NZm1pOFR3alFORmZxbStLcGlpdmha?=
 =?utf-8?B?cTdBQWRkRDZXVmE5c2psMjVSRnJUdjJDZTB0d2h0ZFp2T2Y1MlR6Qk1ob1F4?=
 =?utf-8?B?SlozTGhUQ3o4eFJvSjEvb1g4MGJDdFkwdWtlR3ZmeS9QQXEza3Y1YzNIeFhj?=
 =?utf-8?B?UUxYdjBxdUpqazNLWWFQNC9mcFNSQk9FZ3FRdjlyN09rL3F5NjhVWU54QnpR?=
 =?utf-8?B?L01YeTV0a0dhT1gyYTR2RU9VOUlmeDIvRGhoSVpFVWE4bitBZjRzbkVLM2tp?=
 =?utf-8?B?QlkwSFZuZ0Rla0NyYjZJK0tkMWN3Q2VCeDlhUzlyOTFpclpCWlJVd0d4WjB4?=
 =?utf-8?B?K29xVmVYeHFFTWljZ0Q5UUQzZVI3VCswN3ovUzhiQTdIQTVQclZNZ3Y5aWo4?=
 =?utf-8?B?UGNpeW1UZ09ONXAyVmdSZ1F3VEttbTU1SDB5TXdMbThIdG5GcVFYSTBRTWpu?=
 =?utf-8?B?KzFQMWhwaGw1ZjFqMlJQM0FKRFpESXNzUEJnWW1KWGk1NWROZFpZNzNBKzRa?=
 =?utf-8?B?VjNJSXBreDJMQStZdTQveUdOSUNMQnMxaXUxQjZuWlJJbjB6bU9US0Yra2hM?=
 =?utf-8?B?V1p6RW54aDRVVTlGcS84eFFpL0lQMVN1RUZCL3ZOU0ZRamZNV0x5WEI3K2xp?=
 =?utf-8?B?azg2SGh0WGdGQ2prVTRYM2poU1NMU3d2bitvbmFyalp3QlRvdGpuZVRhMTMw?=
 =?utf-8?B?Z2JQamk0TTRxUHVWWWJ1eXJmdlVpMzRPb0Z5bnZKbkQwakNGZ3J6SnhBNUxp?=
 =?utf-8?B?bjFiZTlFU0FmTUE4WSt0dytkWHRIVHVGUkQ3SEJDVGIyVmtsaHljbTBBb1po?=
 =?utf-8?B?bktJV25seThHRW1zNEdrZnE3Z2xzN1k0ZVNpeDYyaWNOaWtkdUYwa0VoRjl2?=
 =?utf-8?B?cW9xK2lCbGRySXZ0S25DWDgvek8zMU05NCtMb0JxekQzTGhJOUEzSVUrS1By?=
 =?utf-8?B?dVhsTDdId21JNGRTZ0hibG02SVArOXliS3cxQ1VNWWlnNTFZbkF0VjNBdG1O?=
 =?utf-8?B?c0NGWjVBR0xuWlVxNTNOeXIwVlpSNHlZa1NjaEJRaFBoN3RKTzhzUkRlbERI?=
 =?utf-8?Q?Z4alQ6v7x9T62pmQ=3D?=
X-Exchange-RoutingPolicyChecked: XLk5oPvsCceOBYI+0dr+wZwyxY5Upgz6Wnb3OKDD8WcHfRILhb+mlHJVqMspyebDlVJbZ0ni4+5NOCtwYmJ/VB8QHi1DUpkwRIzkl1hZJBHBJO4QnwIaWC97c78KMziDuKANRjt15p79x1Yu2o2sqqQxVxt4TyNBFyM4gyOsXPh3Fok8Jx3s1GFXLlvTJuh7TAX0ZhQYMzHptxl0RQbbxiP8bDap5B28AfSEjdEqqJhlrMgTY7eV5Q7+XNtDCKNsZ9f2DtQxREiuBkpFLWXaeBSZd62duerS3+cdgwLVq1Kwx9OwCrYdmvKW9Z7IvHNVKcq8umdiEm5J9jgoBLTqgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c71271-d759-45bd-d20d-08df3c2c7dc9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:36:30.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSPNP33izPJO4kSAgW5OsdO3HMHRNlZFVWYQ3x+XaIZVSwDQWexxZI+iDJ6iguvByI+hczpB9RFHgsfMNFQp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-OriginatorOrg: intel.com

On 06/11/2026 17:55, Pawel Zalewski wrote:
> Use a designated initializer for the acpi_device_id fields which makes the
> code more readable and consistent with how lists are initialized in the
> rest of the kernel code base.

Why is there a different explanation above the "---" than below "---" ?

> 
> Unify the list terminator to have a single space between the brackets and
> no trailing comma.

Why?

> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> ---
> This series is converting lists that contain the acpi_device_id struct,
> which is defined in the include/linux/device-id/acpi.h to make use of named
> initializers (which they do not use currently). This work is part of the on
> going effort in the kernel associated with device-ids [1]
> 
> The plan is to convert acpi_device_id::driver_data to have an anonymous
> union, similarly to what was introduced for PCI and I2C device ID tables.
> The goal is to increase type-safety (most of the existing casts are gone),
> to improve readability and to make use intent a bit more clear:
> 
> ```
> union {
> 	kernel_ulong_t driver_data;
> 	const void *driver_data_ptr;
> }
> ```
> 
> But for that to work all lists containing the structs need to use named
> initializers first to avoid triggering -Wmissing-braces. I already have
> patches that implement this and touching a lot of kernel subsystmes that
> use the acpi_device_id struct and that list keeps on growing. Therefore,
> I have decided to split the series per every subsystem into:
> - pre-clean-ups that convert the lists to use named initializers
>   (which is this series)
> - actual implementations that make some of the modules use the new
>   driver_data_ptr member
> 
> That way the task can be fragmented into manageable and independent chunks
> of work and makes this effort easier to review.
> 
> [1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> ---
>  drivers/mmc/host/sdhci-acpi.c       | 30 +++++++++++++++---------------
>  drivers/mmc/host/sdhci-iproc.c      |  2 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c |  2 +-
>  drivers/mmc/host/sdhci-xenon.c      |  8 ++++----
>  drivers/mmc/host/sdhci_f_sdh30.c    |  4 ++--
>  5 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 84c7054607fc..e97c33614fd1 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -704,21 +704,21 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>  };
>  
>  static const struct acpi_device_id sdhci_acpi_ids[] = {
> -	{ "80865ACA" },
> -	{ "80865ACC" },
> -	{ "80865AD0" },
> -	{ "80860F14" },
> -	{ "80860F16" },
> -	{ "INT33BB"  },
> -	{ "INT33C6"  },
> -	{ "INT3436"  },
> -	{ "INT344D"  },
> -	{ "PNP0D40"  },
> -	{ "QCOM8051" },
> -	{ "QCOM8052" },
> -	{ "AMDI0040" },
> -	{ "AMDI0041" },
> -	{ },
> +	{ .id = "80865ACA" },
> +	{ .id = "80865ACC" },
> +	{ .id = "80865AD0" },
> +	{ .id = "80860F14" },
> +	{ .id = "80860F16" },
> +	{ .id = "INT33BB" },
> +	{ .id = "INT33C6" },
> +	{ .id = "INT3436" },
> +	{ .id = "INT344D" },
> +	{ .id = "PNP0D40" },
> +	{ .id = "QCOM8051" },
> +	{ .id = "QCOM8052" },
> +	{ .id = "AMDI0040" },
> +	{ .id = "AMDI0041" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 35ef5c5f5146..db5bed2397f6 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -350,7 +350,7 @@ static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>  	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>  	{ .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
>  	{ .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
> -	{ /* sentinel */ }
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
>  #endif
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 09702022e708..113a9399d7dc 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2400,7 +2400,7 @@ static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
>  		.id = "MLNXBF30",
>  		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
>  	},
> -	{}
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_dwcmshc_acpi_ids);
>  #endif
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 046e8100dd08..2e4926e722f3 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -700,10 +700,10 @@ MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
> -	{ .id = "MRVL0002", XENON_AP806},
> -	{ .id = "MRVL0003", XENON_AP807},
> -	{ .id = "MRVL0004", XENON_CP110},
> -	{}
> +	{ .id = "MRVL0002", .driver_data = XENON_AP806 },
> +	{ .id = "MRVL0003", .driver_data = XENON_AP807 },
> +	{ .id = "MRVL0004", .driver_data = XENON_CP110 },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
>  #endif
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index e9b934e159ad..f3d0a50d1a6f 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -227,8 +227,8 @@ MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id f_sdh30_acpi_ids[] = {
> -	{ "SCX0002" },
> -	{ /* sentinel */ }
> +	{ .id = "SCX0002" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, f_sdh30_acpi_ids);
>  #endif
> 
> ---
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
> change-id: 20261102-acpi-mmc-7bbb96467dd8
> 
> Best regards,
> --  
> Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> 

