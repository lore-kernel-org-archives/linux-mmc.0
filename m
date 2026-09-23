Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2501535FAB;
	Wed, 23 Sep 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174119; cv=fail; b=aq1XImuwpZYE4gdtsi262N48kO8ANYD6F5IFg3mfNCTnOpX/e0pW3cRhILMydDj4vVy2FN4ZKmJMYWH0O9IvEjKmW2AEKUdjGOe/rIHUaSlxDuFPI/4aGN4grRHRcBMaBuN1uz8cwjAg1siLGBJMVst4QsNTz6xXmUfExuOcmYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174119; c=relaxed/simple;
	bh=/iVTcxhWmOUE4FxlBOskEgdx39anOFuoq+sjGWlE6LA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JERnkzq5VAJUZLztvJoCUX7ftYHHA9l1lx6mcFmM7Si7t131GDTRwurQACA+kUioKrC7kzEGZqvqbLyqUL7Su/hNFs5AHPAd6ppybxJjnMTY8ENijyOtm79DYXpgxXipJeeqcKg4ZNWCXy9HUjG6Cx53zmeBR/u/W9r1UVkYoFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaPPzzEw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaPPzzEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790174118; x=1821710118;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/iVTcxhWmOUE4FxlBOskEgdx39anOFuoq+sjGWlE6LA=;
  b=kaPPzzEwdeQgm0oCDae3ukilY94wntscTVcji1/2DowxAqmz5xq9tsAF
   EyXegDYicZbSmI1WwgvDi4+4gB6H+1yFeg+LMBOgM6UVVOmkTi3stW9su
   SyBI4Qe8bl/+9I/R7JO7DAVTb3Hq73+Xjq0wR/XhKQ153NgvMEQ/YKqXI
   3NesubZSoBfmRTEjWZ73EVX+e3Uo1wbG88+AYI7LxcWurWclYWzjLVX+V
   qD894GGzmT/Gq/Q4q35hYkBNEKNMVYGO70HuuPblYzmJVZ0wRu4smujov
   XJrZi7BD1Gaxgo7JBRUqBBpShtmHqQiW5T7pEVu4rp5Ii75HvfbDakfKv
   g==;
X-CSE-ConnectionGUID: JZQ+DHxZR2ekinDwuTWrIw==
X-CSE-MsgGUID: jfqMobCqRIuvP7dF3bneeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101465066"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101465066"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:35:15 -0700
X-CSE-ConnectionGUID: 4+p9/PBjQauXRpOMCevOJQ==
X-CSE-MsgGUID: a0slGLLrTEG7pUNPEf7o4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301576270"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:35:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:35:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 07:35:14 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESbCi32vonkIm/VEqWZV0mIvtolbTCbU8q0t+qRi5i/JiJ7gYmSniHaseS+YL1zS9W4IVZQa6xzsGuNH5MGixfrEMkEK8sQfx2+3ib7b3XrRPezBPDI1yn+gF1BT1sR49QyUuJkQC93zqUQma8SRHBbEygHaGpJW6EDhyItxYePzj3vy4+uV7wIBNNuB6dROAPCerAEzXnz1wU+MZJaDdHa88dnmzhJc6LqGTyAXCAjHORpfUYRpOCuAOg7R23EcfCVH0yy/WxaOUhZTExNtG93oteNUCnHKIJ0NUpvBIKjl84pLLEWOd8L9TpttZFunj2mtQNuQAY6R+SvPpeTKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXWj5qz2JnTJGqEt1DLgeVc0Ip8EgPsnMe7knAjWhaA=;
 b=a+vZwBcZwmsY9L+HYRa42QJBiwDxFOXx5RzlnhnaRBU+SbDdBea9RbXoNN2x+avfxnsxVsoJ7vXBbLu6TjYXkRF/zseLgy0mm4K2M7LfRW4WPpb5NeO4R7me68IpmMJTDAE+V9v/DViB4o+kD/rZHSTLmqM7bMFzGiyTMIp4FW6zpySXIydRmNdAv+c4GvtWLJRNDwF6XWR5L3fcTm1hXb+5AeEggbsx95P4xMENV8ton6wyrsBCB/QDovQCj2xkeRFq0kHGlhqPg5hsW8TbM3QR1/KJ6Jkb/17R6dTEhffPHStdyCEx4AKR8letlTucVammrOlm6BhBK7HAY5IHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DS0PR11MB9502.namprd11.prod.outlook.com (2603:10b6:8:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 14:35:12 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:35:12 +0000
Message-ID: <e75041b4-8450-43f6-bf6d-35a31812f8e1@intel.com>
Date: Wed, 23 Sep 2026 17:35:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-at91: disable selectively clocks on pm
 runtime
To: Aubin Constans <aubin.constans@microchip.com>, Ulf Hansson
	<ulfh@kernel.org>, Eugen Hristev <ehristev@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Romain Sioen <romain.sioen@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Robert Marko <robert.marko@sartura.hr>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260918153414.909333-1-aubin.constans@microchip.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260918153414.909333-1-aubin.constans@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::21) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DS0PR11MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e5a2e1-560a-4413-dc1f-08df197fdff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: BSBNqmoTO6qfY+6H3Uwua3QStjK+d4uF7UJ1+pOHtde7bLMSqUp7iQEou8Q0Pif6sqjFeb6m1TS969uLarejI0hsUXwcX7aBnMmH2pWflmlnKLUIfN5TqwQIY0tyQbDRj+1Tf/T+fZdUbhH/vUv/B50ZHQ97DlLxc8IGrE7Kwco14TJa+xPx5ES2MAMgJe+1SMKP4kcwov2cuEIyAS3NAY+sTb7j/Tmip0pA6A+31W4UMLhBE5BKs1l0xQWsvx4+GIve7wifIZvgrM3Lah+49ND+36OcaPQrAGFNoHk6qM0EvdhDsj3S0mipGTLs93BAnGhA7uqnjKG8Zv3pwB1lYEI5CsR4qwPvtAJRgEhSfhJUWCp2OKvrvMiQ/6X212bHopwJMO5nWIrSbLoxX3XhgV9ux0/z+ZzSnGklAe9rPwhKM/wrCifgTF7ioZxT+IVPDsYMBRsHyo4Dfv4g43tyXW/HA0jXMYfOt5EyK6FtBNwsyEOqqhzaB3G5xB1CGGWUuj8khupDDsaPsUtPdgL/sHLkzANFHoGQLFUs1WZKfvXqmkuzn/enw+mZcvPMVgluVH4WPwUbh2lrjI5W+L7heXEDWSJz4ajDVSIL+QO+CPHorJLrcewH3FsuSCr2l2KY3jgA7E0nsV2K8uFHwyOMG/aqSEdtfdV/4k5M4eNLJx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlIzWW5Ca0pXU1dLVjVrbmQzdWZPSFk1WXhFRWFSeTkyU0pQU2FGQVJvZmkv?=
 =?utf-8?B?VkhFbEovK3c0a2loT0RReE5hVWhQU0xVRUhrS1Q2T1VqRDNnaVk5eVNxblpS?=
 =?utf-8?B?d0N5UTZyS1VkOWpmT0xnYVJCYWdzSDViRVc0S2xVMjNsQmhrcmNVMFB1c1Fm?=
 =?utf-8?B?djRXU20zRndoUk1sUU1vWVlSK0FjeFUvRXBUS21wWDN2NWJZYjYzSUdaRzk4?=
 =?utf-8?B?c212T0FmUWh1UUJpTWNDcUJRVnRjVFE3eGt1R01xRzFtL0xEWllQZWFHcWRB?=
 =?utf-8?B?cHZaWXpHMnZ6SitkWWVJcUdKWmRodTlldHNpN3hTeU1lMEQzL285L2VhNmxk?=
 =?utf-8?B?TGpoRWpzalV3eUxlS1B0cVQ0Z1dUeG1QWDV0N1BLTi9jMVNBSnAwSkl0emNj?=
 =?utf-8?B?dHBGd2ZhUVI1WEJqQ1czc3hhMHV1NVBNYWxlbWhtMGJLVUtWSW53V1JHcm5U?=
 =?utf-8?B?NnhZdCtHUUNtTnV5QXdxbERMbnljbGxhRkpWN2dMajJBaUdMc05oU3Exc3Vp?=
 =?utf-8?B?OVpJK0c2bkFLZk5xcFRydHgraHUyM3o1N3dmTGlxbUVTUm5uSDZlakNHMGV6?=
 =?utf-8?B?ajBFeGpFRmlmeGpaT1FyaWN5QytZckFoOXlmeTN3cSs0MHB3TXZtRnpuLzVQ?=
 =?utf-8?B?MzYzREVjZytzWHhCWDhtd3hhU0RTb1VKSUpQQ08zd3loSFM5ZU9iK25iSjhT?=
 =?utf-8?B?VUtOMnhleGdxMmN3Ukl2MUtEdDdiZ1BraWljbG8xRitGUTJCcksyZEs4N0dX?=
 =?utf-8?B?OE16c1FqVWxRWGFBYVpZM3NCbHQxVmdpUkhqQUo4SDFINlI4YmMzYnVlNXNo?=
 =?utf-8?B?VmwzZHppc3ZXOUs4VysyNjJUT0o1UEJtVWR6M3Z1dGNoSjZRYjg3WDV1Ykx4?=
 =?utf-8?B?NzRPK3ROeE8xMThuV1I5YjV3aThTODVvV3BkYWpqckdZZDZhandjMHZ0NXd0?=
 =?utf-8?B?WWxUZXNUV1hPUi9PN0ZoRnZraUJFSG9FMjdHNGFSRGVkazF6WnE4bk1GbGsv?=
 =?utf-8?B?RktZZXZsSnpoTVEyWTR4amZrQjBJaTJmYk15VzFNRlh3cmpwNk0yd29WUHlx?=
 =?utf-8?B?MXlLeFVhL0Zxa0toRFJIVEE4ZVRXbjF1VHRQSnh4L1Z0UmdtcWRTOUJ6eGxW?=
 =?utf-8?B?SkFsd1UwdUJBbEM2dHVFcFg4NitqdnVTYXhOS0pSZ2tCaWJxZ0s0RlVvbE1P?=
 =?utf-8?B?Z2NUVGFJaURGV2pWc01sWUR3L0VITTZZeUxmejVUSW9vM3VzMkt1V1ZYalBB?=
 =?utf-8?B?d0lHUXdScjhnb20rMGJ5NkpNQ214dE5xK2NWWVczZXlkaVdjRXVpbkVUcEZJ?=
 =?utf-8?B?ekNOSVpueWt6ek1SdTZxa1hiZ0pGZmh0L1ZGWmV1VzF2SzhaQ0hBaUZDb0cr?=
 =?utf-8?B?Szl3cW1wUER2cW1icmdKUlpjNFkxRWxCMDU2OFN4ZXRCSXh6R254a2RyTGpk?=
 =?utf-8?B?c1NCTnhmZ1IwVUdkMmExakRTRmUxUm1LUWp2ZktLREhBQzZMSDU2OGx3Zndw?=
 =?utf-8?B?aUwrK1I1cjhNNjRNS2hxYWZJTWg2ZHB2UDE4MVRSMFlrQS9VQVE4SjNCdTYx?=
 =?utf-8?B?a0VDNHNjeHZTNmRhdm0zcERmREpGWEdwNlZmMTExS250M1IyMGJXQzhaWHcr?=
 =?utf-8?B?R3VJdTljMk5RTjJ5V1h0T2tVYzY1R3laOGxCcXYyY3Zndm1Obi9OSlRxN01C?=
 =?utf-8?B?WWdOZHNIVkxCY0JWQjJDekRLbGxUa1AzYjVKWkE4cmFyUWk2M2ZLMzhjajZ1?=
 =?utf-8?B?VmRRWFh3WTVnb2ppdGFndy85RzZTa09MKzJqYlFDMTg2OE5MSnJvWGVCMmVT?=
 =?utf-8?B?K2xIV0ZEZGJjdVpZbVJqc3dLU1o0QW5MTVkxU0tvMzhBTys3a2Z0WlYwRzg3?=
 =?utf-8?B?WXgxNSthMXRBYXhoSzFSdkR0Tm1QRVc3RmplWENNY29ycExsdXVEeXRRZlY2?=
 =?utf-8?B?UkRYdG5Xb0haTDVDUkM4RThyR05Ha2pnYzJORVBtNFlVbFl3bXdqVXNRaFBu?=
 =?utf-8?B?Rm1qaVBmd05PSUEwSDYxV3BNWE8wZldINldvVzRvK09rTXhvcEtlSFJKTTBu?=
 =?utf-8?B?MVBhUnFlSkhNakhsSCtVbVRubFhzaFhmMThxeGdobk5wbVlnTXlGcjhxN1BF?=
 =?utf-8?B?NUpwRlErWTc5UjE2Yk9WZm1PVVFPcFgyRjdxQTBIbXpmMW1yd2JrWUdFUGQ4?=
 =?utf-8?B?dGJsS0FOdnFwdjRwN1Z3c2tOaVZSRk9jVTc2LzdQdjJwK0JGWUw4OFJndlhC?=
 =?utf-8?B?OXl3dVhKUWV5bFhwOUE2c2lsY29SQUo1bGpYNHZ4SGNvRXZxaVFDVWhESVFm?=
 =?utf-8?B?Y0lDVkp5Kytha242M0oyL2xGN2V0U2puQWljbklDcER4d2NOdVBjeHM3MnRp?=
 =?utf-8?Q?92uGOLwnPzCyYuiY=3D?=
X-Exchange-RoutingPolicyChecked: Bm3FNwpc3nlKRdJ7pe1/X36A1eGT4Xo17WmOqtVC+jkvWj+z73culTx0ShtDGhx08mOnzQS9fXWCYEtkNXHjjZ39HbNY8HuHTazBdsraNiHmxblKRHtkExgf9tnOUUu2YLKFur67zvDuqkxXpvqE6HsOt9F1+y3rr9g/8EsbPmH8U3q/bNOdcjNg9Apl4AY1q2jEiVfg5Xfd1RP4ekZCIyX+STCwJIQfqsuF+Z8P8EU861BNaXOjzgTsIT7RqnrJvopQWPPbFwVX2vk6vvEUXeg0YQ6ExzO41j13l1IaIwYsE53oxxGtlfaWtGA18ndLtcXRoRimbGrehMIxG6/vFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e5a2e1-560a-4413-dc1f-08df197fdff1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:35:12.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+qglA4os4S1QTydQL+cQFKChgwviV8a5VWJ/SHHYvzua75DVvFD3Jqp6dJTrRyV0jgjKQvgvrgrtPQnENGmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9502
X-OriginatorOrg: intel.com

On 18/09/2026 18:34, Aubin Constans wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> SAMA7G5's SDMMC run-time clock disabling is not supported.
> Add support to avoid this scenario for SAMA7G5.
> 
> [Amended with a fix from Romain Sioen below this line]
> 
> Sama7 boards are impacted by an unbalanced prepare/unprepare
> and enable/disable clock management in sdhci driver due to
> the lack of support for SDMMC clock runtime disabling,
> managed instead by the PMC driver.
> 
> Add conditions in the preset function to manage clock
> depending on if the board support runtime clock disabling
> and if we come from the probing or restoring procedure.
> 
> Add boolean start_clks variable to manage condition
> in preset function.

The commit message is a little confusing.  There is no functional
change yet - this is just preparation, right?  But it reads like
it is making it work for SAMA7G5.  Please make that clearer in
the commit message.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7c4ac65f247d..399856643e57 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	bool baseclk_is_generated_internally;
>  	unsigned int divider_for_baseclk;
> +	bool pm_runtime_disable_clks;
>  };
>  
>  struct sdhci_at91_priv {
> @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
>  static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
>  	.pdata = &sdhci_sama5d2_pdata,
>  	.baseclk_is_generated_internally = false,
> +	.pm_runtime_disable_clks = true,
>  };
>  
>  static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
>  	.pdata = &sdhci_sama5d2_pdata,
>  	.baseclk_is_generated_internally = true,
>  	.divider_for_baseclk = 2,
> +	.pm_runtime_disable_clks = true,
>  };
>  
>  static const struct of_device_id sdhci_at91_dt_match[] = {
> @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>  
> -static int sdhci_at91_set_clks_presets(struct device *dev)
> +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_clks)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	unsigned int			gck_rate, clk_base_rate;
>  	unsigned int			preset_div;
>  
> -	clk_prepare_enable(priv->hclock);
> +	/*
> +	 * Manage clock prepare/enable procedure depending on if the board
> +	 * support runtime clock disabling and if we come from the probing
> +	 * or restoring procedure (for backup+self refresh).
> +	 */
> +	if (start_clks)
> +		clk_prepare_enable(priv->hclock);
> +
>  	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>  	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>  
> @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>  
> -	clk_prepare_enable(priv->mainck);
> -	clk_prepare_enable(priv->gck);
> +	/* Same clock management as for hclock */
> +	if (start_clks) {
> +		clk_prepare_enable(priv->mainck);
> +		clk_prepare_enable(priv->gck);
> +	}
>  
>  	return 0;
>  }
> @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	clk_disable_unprepare(priv->gck);
> -	clk_disable_unprepare(priv->hclock);
> -	clk_disable_unprepare(priv->mainck);
> +	if (priv->soc_data->pm_runtime_disable_clks) {
> +		clk_disable_unprepare(priv->gck);
> +		clk_disable_unprepare(priv->hclock);
> +		clk_disable_unprepare(priv->mainck);
> +	}
>  
>  	return 0;
>  }
> @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>  	int ret;
>  
>  	if (priv->restore_needed) {
> -		ret = sdhci_at91_set_clks_presets(dev);
> +		ret = sdhci_at91_set_clks_presets(dev, priv->soc_data->pm_runtime_disable_clks);
>  		if (ret)
>  			return ret;
>  
> @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>  		goto out;
>  	}
>  
> +	if (!priv->soc_data->pm_runtime_disable_clks)
> +		goto out;
> +
>  	ret = clk_prepare_enable(priv->mainck);
>  	if (ret) {
>  		dev_err(dev, "can't enable mainck\n");
> @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>  				     "failed to get multclk\n");
>  
> -	ret = sdhci_at91_set_clks_presets(&pdev->dev);
> +	ret = sdhci_at91_set_clks_presets(&pdev->dev, true);
>  	if (ret)
>  		return ret;
>  

