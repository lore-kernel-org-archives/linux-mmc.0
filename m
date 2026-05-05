Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084935B631;
	Tue,  5 May 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985727; cv=fail; b=IR8MMTp4awju43MYNKqRfpGSthAWbukhTOTiuQE42vudLDfyWeRDUSKcTSjJeBnX9+mnUkEYwjO0cJkBf6uRjB0R0lvs7SVCLFJuAKT8MBbNSp4yH5wxYneipOAcE5IFROcVDSwDw/oW2PE0Q3sAvBlBkEqNXcZvo6m05li8MZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985727; c=relaxed/simple;
	bh=xWvyBUEOAuC619Fn7wsgzEUc0V/IlM22Yl49rt0IFTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eukbuowDu1qepruhSyHSFKqgR3ixb+wL2m1d6OydqcMmUHumagHM6aFwC8iwc0Ct2IHzhUAVtnzSzA9zd25tJZXY72BOE696IRbVedkWBNDn9c7BPOhg0d8m1hc9Udze5htX1IpJflmVFhOLHXhP9iGsw/r1OCHwEvu8ckvYBew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSGjNTZT; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSGjNTZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777985726; x=1809521726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xWvyBUEOAuC619Fn7wsgzEUc0V/IlM22Yl49rt0IFTo=;
  b=jSGjNTZThBp5u54GsB1cg+JxOxjJdyHPs6C3XU50oF844KqoQNFrLSH1
   u7YqzCEz7l7vAduxGWo53Vh9EPIAvyP75pnFoT7Tgx+ClUwyNa+Z5H4cp
   3GDLFKIIcj33DeGN+eFCC1ngK5g9IuJqY8Xzgm8vNrXqFRk0r15yQOBeH
   8f5c/8VnsGCxOes/Wb8/GpZemW3tFAOTrG0hXtJVpg2KpM3Qdxfg8R5SQ
   kJTLLEP3SkkNOzsE8VRlaYnTBTVg8gAyBfHL+TWAZQkmh4D5+scyBKOvM
   2HEjJEFNVPef41elKiNCa/qVSWp/HKmq6cMBoFxYJJREUh6pakxj/aaEM
   g==;
X-CSE-ConnectionGUID: wwch5qGzS5eZZvlJCxMAlA==
X-CSE-MsgGUID: jmA422uIRgymhTO+a/Ni/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89447042"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89447042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:55:25 -0700
X-CSE-ConnectionGUID: Gv8dAgLQRr6qbeaJo/1qhw==
X-CSE-MsgGUID: 1BZZHqSXRQiJRxJiLQoozw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="266145006"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:55:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 05:55:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 05:55:24 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 05:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA57xthrmErjW+3lX4DT9SKs9pdloJ3HY+1LIDBCiCBf2j8uhOIKMYHE0nChYHzROxrqLUdDhP9r+7P5kUthbv7DYJQpVu7GSNDudEtIisrJUMfQTDHUKa1BdEjybGHIBcOzaDuUUQXUKTubGmFt+akIMuMIVRENzWeIJ+ISMqUxhhV2qILepVNdcolnSZWnnful4PNilEXcWzDx3Bx9tDwpIbxGUufyFb7Iz5zb3y3BnShKySmYV1yMyW97A8jgGXi4rYI+jUqUIw7LxA7RxkG+TnZo4pS2ozhsdtLQPTUBBLr+6Z+Rn62cHtj/JUCUEAHcjS9r2yUdPdX6lU/CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLbjCq2M3SPXBQpGl9QqIb1guGFD4q8EktL27GWqqMg=;
 b=gWEh/m+eJmLapOCIlAIkBuWB1F0HjV5TJXg8zGYA35Y+V6KGUM6mj2MInjSLr4vMbI0hmexWuK3ISCnEma6C5JbziQqCAFIEAsr1+5pOX2Ni40yns86HH2cELwNcLgzNJl77qk1/eQg0AGTxPsvl3zv7pTIKaC7vKn+bPzSPj1kzwwea2xjZbywJ6zreQkmV5OYRF08yVwf9d0j56O1qW1VaP55IRAKl7W2/TjX6jnTG0S+4VfiIdBRjq6qmRmb2yoEE0ayouN/wBVyiqCYoyGtDL3laBRboGsqAxIEAvYN8kQaheNW96wPZacjgUPOaR4xwxKh19OBmukrXqJekQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9394.namprd11.prod.outlook.com (2603:10b6:208:563::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:55:21 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:55:21 +0000
Message-ID: <1c3acc06-e9ff-4728-a4d7-2639e5dc4793@intel.com>
Date: Tue, 5 May 2026 15:55:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: Fix SDIO support for Eswin
 EIC7700
To: <hehuan1@eswincomputing.com>, <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>
References: <20260424070907.1422-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260424070907.1422-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fc14e0-fe02-444b-5731-08deaaa5912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JTywg/xjy6n1rRC2dW3x1REJosXg8GQD20OIo28wG18B1G65CpWYbSk3Kywtn7SrCi846C/PufQI1hwz/ptcbE+9FCD+UR7O9im40aqgTJ2Q2GuVsKYVgUenWFhXTTFLlBWZe4g26XqKuE47CSDod/HSN6yV4TTkmfSiqz2pFUG4/QyzC39Pvjm1ldgBFKL8ZRW8Y5LWqnSSDzfWlauYB5Cj49mY62reyIKJrk+81OV0o01xVqqDsZ4XmLI/gToSx/v/BoPhiqfJ6gabkD+ByS/XYUp6z9Mj96Cms+CvcTP8lRm5KIa0Ibq6yp14nG27B/IMHn3zY7aWzX4nZ8/rYPQm4KSwetXjwt60K/PM+UE1b5nkBv7wTWr2Cvsbu8reHqwGJ3OuFjdH3FPvq7xt6Wbxl0hxdhDmy7okT1l21dWLOm2pIHiz6PHtw2qZgEa9dx3BELCkoAD02byqGvUII3vJxWUYnRQX7YQja4WSMpfB0OKq2rgz2BZLEJKLH723yvp0tUsXSImoGz/QEUEY+RG8DTeQ9fj7jonruFTZFdsPw2ruiDo//8OuRJ0c+1cQjkKbCkcbjlbPmFMaq4G3+vqu4xQA83PZA5YIYx1FeAQawnuoC1G8JLoAlgD211e41daPK/7bsy6u9WM7lFv7F81THreBX7QdkejzDi0OuHodYBVBaiyEcsIEPzdHlqlb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjF2cmFGZVRlTFcwTmlIY24rdXBibzVTWElPR09ZQzhIQlB6TStKSXF0YmFv?=
 =?utf-8?B?TFZLTHlZblBTSVd3ZnhZZkp0SHk3SFBmc1dmK1BrbkpNMlpCNFlJMEd6SXlP?=
 =?utf-8?B?aVVQV3QzQzF0V3oxWkgzRFA3aXdZMjd6MHJsU1FPeVYzL3lCNFA5aUROS1lJ?=
 =?utf-8?B?MERxWXpUQTZUV0JPQmEwWHR5b0hTUC9ydkVqRHZoQWRyUjV0QXd3bnhxZi9R?=
 =?utf-8?B?eEV1SWsyc2JUSGlrQjRSYm81b25nZERvbllXc0pjb2dMY2pCY2pMTTB4cm9N?=
 =?utf-8?B?azJEdHN5SWJOOXlyUzljZzZXUzM0N3ZTSmgxWWx3eXo1WTZ1RHpwcDdENzNh?=
 =?utf-8?B?Z0NQWUREdmZlb28rTy85SmtRZnBOOVNxNkxqZTZGSDFNQitYT1NCaUFNOTV4?=
 =?utf-8?B?c2NXN1liRm43Z3hkUm11OWV2UHI1dFZVbnVZcFdWNnBRVzhQSFkzZ2VxNVR6?=
 =?utf-8?B?bHJuMDZWbmNSVHNwVzJVWHZnb3dHSWEraTlNUmhSQlNuTldwSnpxdnowMnY5?=
 =?utf-8?B?WFRjeU9SNjdDRWpsTmIwbW9GQkpIeHhnTTZURCtKSkkyZEdLMzNkQm5HU29z?=
 =?utf-8?B?V0RuaUQwNUFNVW5sN3VJSkU3UG8rRlJlTlBHU1E1dFNDNmxIR3JuSGxDaWk3?=
 =?utf-8?B?NFJLUCtKOGd6aWVNQkM1UE4xWVlQNDJWMDlBMEhSSHBRVUdXR21hYWNKWEFw?=
 =?utf-8?B?MHJhdC82NzhZWUhmbWRhTm91a1R1anFzZFludHJkalViZElaU1pWUGhBa25R?=
 =?utf-8?B?aVRjUk1WV2I2Ym1mQkNQUkxPb3g3TC96d1AweE9Hd1RySFhHQm8zeTRWYS8x?=
 =?utf-8?B?MlF2eDh4cjhrelQ0cFo2bDJobFRMYWt4bzVBQjlkUm9lK1VmV0k1SENWOS8r?=
 =?utf-8?B?OVVUY3dYaWRFT09mT2x6bklFVmRyclBEMCtONVVaSXZSSmM2RndSanNjem4w?=
 =?utf-8?B?WEV2U3NWcFRNbTc1SmNWN3FJcjZXRm1tT0JuL051UE9meHdWSVdQSzV2TmdS?=
 =?utf-8?B?UlFuM1crWmxCTmdhakVMNHAxNGZOQ3JWQ2JVOHNGOTlmMEZqdDUyN1FpNFg3?=
 =?utf-8?B?cVlFTlhYMzFGbWkrOHdMWm52aGs3YzlzL0NieTdxd3o5aW1Xa2tVc2FDR1hv?=
 =?utf-8?B?anA5SUhwYXdGT1BLQlNIQzY2QlR5dFkrcWxiRFBwWS9zYmlqNWZhb0tBdEdk?=
 =?utf-8?B?YU5lT0d5ZEtXUkxRTDhBT0ljWkRCNTZaL0RUWUZLZERVZFFDeTNTMTFKeGRy?=
 =?utf-8?B?MXcxT3hEc1NxQjQrOGhpWVhETmhwcEN0NUg0THA3MGg1WVpqeWw5WXEzcnRh?=
 =?utf-8?B?QlpiWGs0UVJQZTBFd0hTc1Z0bi9INTZod2lnR0FGTXZ1aVBkL3kwY2tRbC9t?=
 =?utf-8?B?RmdSMmlXZ0IrRTVoOFE5cStudU50eTBxdFNyNW9nZEdaeXR4dE1KRnFaaEh0?=
 =?utf-8?B?ZHJCUE12ZFNHTUhCL2l2TU5rellVOHBNbjV0K2lPR21aYTg0NlF2b2pTR0p3?=
 =?utf-8?B?eWJBRTQ1ckdNajdvczllUUZ0bmNEc0FleUpjZ1N2Y1kwL09HUG9XUnZ5cCtk?=
 =?utf-8?B?RzIxZlcyVjJmelRQaXNDR1NmSS9Zb0lEa25IbjVoWEhCR3gxN0VQTUNFTDdk?=
 =?utf-8?B?bTNvMXFwQStRdUNEZGJ4cWk4Z1U0RWpNK3VpWm9PN2xmOUNBRVkxNW9HOUly?=
 =?utf-8?B?SDBiU1JsKzhJcTZ5VzhsdXRIVTErWUFkRllWVzh2RExNMHczS28wVFZsNzlp?=
 =?utf-8?B?ZXliTEt1UWhvcVlFTTg0b3QzQ01WRjRqQ3NOUW53ZWZ0YXE2WGtRQUkrRjZL?=
 =?utf-8?B?UlVkRDNxcFdaSW5CS2JVOUgwWVFxOEc4Njh5N3pYV1RPRFk5WVBZUDRGUTBF?=
 =?utf-8?B?UGtFQTZKQTFmT2FYSXFaWWVTNVZUQ3krTlNGU01aYVBBTERJUzhVNXFMaDBh?=
 =?utf-8?B?ZitoRjFKQk1ZS2l0YzJXbzNUQ0EyQ3FiS1k3ZkV5L08xS0Y5dmcwb1lDSHdn?=
 =?utf-8?B?RXZlMXFGU2w1ZHdvSVRxQThXblI3OVBiaGt5STgyeWFrUVVrV0t3N2VBajJY?=
 =?utf-8?B?bStzWEI0L3R6NnhUbHgrT3ErUGZIVDQwNmZkZ01lamFnRDZXdEcrWUhETnRI?=
 =?utf-8?B?cjUyTGNsUUFqa09PVW9IaVlvRGJFOWFVbUFzY3VTSUZLMFRqYmF5S2swK2hX?=
 =?utf-8?B?UUIrdk1hemE3NWVtbTRUMGZSdDhtSjJ0K0UwZ0RycEFmcDBRT0p0MTlRQndF?=
 =?utf-8?B?K3p6VHhDZ3p6SEhlUkJ0eGVOcXJBdHJBaElsQmpvMUE1VnBGVy9makdqSnMv?=
 =?utf-8?B?aGN5eEZUMXJPSTMxSm40SlQxTnZ3WXovcjJGMGRFNFBsZGhXdEo4ajAvSGtl?=
 =?utf-8?Q?Ee03qGVD5lK6RWoc=3D?=
X-Exchange-RoutingPolicyChecked: rncttohKTziaXD0SzbUVrVLx1neYh+TTZA4dFT1WvsLOIgycY6Z2a7AA/BJ+8N1LlJpscdAYD7tF3+pBP9C4EzzpFWw9ySOdsz8R4pNd+lamQ9TmalshHwN5eY1ZMSUAh5knnWy2nVLztMFZn5HCaBHkP7JUhprvLLz0yus+KjGjiOSxHJbKhPu9ZAjjbqX8+BRLumqaYSekCvh7N3SF57q8brijXcFO5V9yeah7FWoqNVEjZE9UoArqwQE58ve/lNxGbsV3K1nn33rHVqp+BO8PxFIgta5olbV+fUWdwvPFCan/7+jqQzdIvwWeSQzwB6LijzAze0g6I3OzocquLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fc14e0-fe02-444b-5731-08deaaa5912c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:55:21.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvcVHyn1YQeLlLs6zmJg8Wd6NZEEUuhl1XGvmZoGHuBS3O0kvDx3eoryP1KCLecViQ+UpmiWq7zA8Kc9yUwWXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9394
X-OriginatorOrg: intel.com

On 24/04/2026 10:09, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> The EIC7700 code in sdhci-of-dwcmshc uses host->mmc->caps2 to select
> different configuration paths for different card types. The current logic
> distinguishes eMMC and SD, but does not handle SDIO separately.
> 
> Update the EIC7700 card-type checks so that eMMC, SD and SDIO are
> distinguished explicitly.
> 
> Switch the reset path to dwcmshc_reset() so that pending interrupt state
> is cleared consistently, and use sdhci_enable_clk() so the clock enable
> sequence follows the standard SDHCI flow.

The reset and clk changes seem like they are not only for SDIO, but
the subject only mentions SDIO.  Should the subject be more like below?

	Fix reset, clk, and SDIO support for Eswin EIC7700

> 
> Fixes: 32b2633219d3 ("mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700")
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 45 +++++++++++++++--------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0b2158a7e409..0c1b39d48502 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -277,6 +277,7 @@
>  #define PHY_DELAY_CODE_MAX		0x7f
>  #define PHY_DELAY_CODE_EMMC		0x17
>  #define PHY_DELAY_CODE_SD		0x55
> +#define PHY_DELAY_CODE_SDIO		0x29
>  
>  struct rk35xx_priv {
>  	struct reset_control *reset;
> @@ -1433,10 +1434,7 @@ static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
>  	clk_set_rate(pltfm_host->clk, clock);
>  
>  	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	clk |= SDHCI_CLOCK_INT_EN;
> -	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
> -	dwcmshc_enable_card_clk(host);
> +	sdhci_enable_clk(host, clk);
>  }
>  
>  static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int delay)
> @@ -1497,7 +1495,7 @@ static void sdhci_eic7700_config_phy(struct sdhci_host *host)
>  
>  static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
>  {
> -	sdhci_reset(host, mask);
> +	dwcmshc_reset(host, mask);
>  
>  	/* after reset all, the phy's config will be clear */
>  	if (mask == SDHCI_RESET_ALL)
> @@ -1594,18 +1592,18 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  	int phase_code = -1;
>  	int code_range = -1;
> -	bool is_sd = false;
> +	bool is_non_emmc = false;

It is nicer to avoid double negatives like !is_non_emmc
so prefer to use is_emmc

	is_emmc = (host->mmc->caps2 & emmc_caps) == emmc_caps;

>  	int code_min = -1;
>  	int code_max = -1;
>  	int cmd_error = 0;
>  	int ret = 0;
>  	int i = 0;
>  
> -	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> -		is_sd = true;
> +	if ((host->mmc->caps2 & emmc_caps) != emmc_caps)
> +		is_non_emmc = true;
>  
>  	for (i = 0; i <= MAX_PHASE_CODE; i++) {
>  		/* Centered Phase code */
> @@ -1614,8 +1612,8 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  
>  		if (ret) {
> -			/* SD specific range tracking */
> -			if (is_sd && code_min != -1 && code_max != -1) {
> +			/* SD/SDIO specific range tracking */
> +			if (is_non_emmc && code_min != -1 && code_max != -1) {
>  				if (code_max - code_min > code_range) {
>  					code_range = code_max - code_min;
>  					phase_code = (code_min + code_max) / 2;
> @@ -1626,17 +1624,17 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  				code_max = -1;
>  			}
>  			/* EMMC breaks after first valid range */
> -			if (!is_sd && code_min != -1 && code_max != -1)
> +			if (!is_non_emmc && code_min != -1 && code_max != -1)
>  				break;
>  		} else {
>  			/* Track valid phase code range */
>  			if (code_min == -1) {
>  				code_min = i;
> -				if (!is_sd)
> +				if (!is_non_emmc)
>  					continue;
>  			}
>  			code_max = i;
> -			if (is_sd && i == MAX_PHASE_CODE) {
> +			if (is_non_emmc && i == MAX_PHASE_CODE) {
>  				if (code_max - code_min > code_range) {
>  					code_range = code_max - code_min;
>  					phase_code = (code_min + code_max) / 2;
> @@ -1646,19 +1644,19 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  	}
>  
>  	/* Handle tuning failure case */
> -	if ((is_sd && phase_code == -1) ||
> -	    (!is_sd && code_min == -1 && code_max == -1)) {
> +	if ((is_non_emmc && phase_code == -1) ||
> +	    (!is_non_emmc && code_min == -1 && code_max == -1)) {
>  		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
>  		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
>  		return -EIO;
>  	}
> -	if (!is_sd)
> +	if (!is_non_emmc)
>  		phase_code = (code_min + code_max) / 2;
>  
>  	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
>  
> -	/* SD specific final verification */
> -	if (is_sd) {
> +	/* SD/SDIO specific final verification */
> +	if (is_non_emmc) {
>  		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
>  		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  		if (ret) {
> @@ -1756,9 +1754,9 @@ static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned in
>  
>  static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int timing)
>  {
> -	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  
> -	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +	if ((host->mmc->caps2 & emmc_caps) != emmc_caps)
>  		sdhci_set_uhs_signaling(host, timing);
>  	else
>  		sdhci_eic7700_set_uhs_signaling(host, timing);
> @@ -1767,6 +1765,7 @@ static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int
>  static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
>  	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
>  	static const char * const clk_ids[] = {"axi"};
>  	struct of_phandle_args args;
> @@ -1821,8 +1820,10 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  
>  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
>  		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
> -	else
> +	else if ((host->mmc->caps2 & sd_caps) == sd_caps)
>  		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
> +	else
> +		dwc_priv->delay_line = PHY_DELAY_CODE_SDIO;
>  
>  	if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-ohms", &val))
>  		priv->drive_impedance = eic7700_convert_drive_impedance_ohm(dev, val);

