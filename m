Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3881FC3
	for <linux-mmc@vger.kernel.org>; Fri, 25 Jul 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433666; cv=fail; b=VlcRtuQqcWhc9u98hjqCNinRNyFQrYbRvCwVrfcMIYBSCr5pPf+T/Cah9cxEOPbp/CMR8bpamYrIxNKpcGP4rthsHykN4WJVfUabiCCeb+bVafVHuxvTZPCMkhAXw7Zufew6parVvHKxYw7dKeCkrno4rzIi6GeD44OK75Kjuhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433666; c=relaxed/simple;
	bh=/asYG4uPmGkId/Fbs7cOW+DcJjEPAJj30TtfQrJvwQ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rocGBwLbWBeEnbuuR/lyjLeFtxtDNhWCfq78a7ovcNrpOOs2NpOVX1H0dxNO6eLjeJNFtUNLeO8puyVTjIe0EV3pCgBxZSRpYPFEhYwU3p+d3BY+4HDU6BT8/Jn9njjydwhL+hycGpy/QP+TjOGjveCvQ/DZwq2+byKBB7f2OXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPaurWKW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPaurWKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753433665; x=1784969665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/asYG4uPmGkId/Fbs7cOW+DcJjEPAJj30TtfQrJvwQ8=;
  b=gPaurWKWbCBuElewbfGxVMMM/qYfn+hbgO77nkHIm8cgj4WOOEAEsss8
   sKhfrjwCQw9HS+6vgvVjDEQuDd01wRMT/D8d7tRfjuZQ/bKAIQ7AVmvyB
   MkVudhCAUqW1qXlO2guFPrWleEDLKrnk0akFdLHQOt5sc9e4lVBWLfcww
   ZdNcw6MWXlFjoiT+bAKEzyiLHHH4ObxTWsZ3hmrX/w1DqFr8StJhxZ3ap
   FqZ1rTVPiBZXLeeLjrzdW29WFZb7zmCybpAFI6/Fir2aVLbFJkzBdj57m
   p0tSJ9gKkEqsDXDt7JixjL/bizReqZGJY8k/3jLWilVgyRGf2DPz/1MJj
   A==;
X-CSE-ConnectionGUID: n5VwbdboQUitHRdi/dMDOQ==
X-CSE-MsgGUID: QPePryfpTTOsAcs3TvFP/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59418879"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59418879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:54:24 -0700
X-CSE-ConnectionGUID: f+ElWkCCS1i1vYVauLZi9A==
X-CSE-MsgGUID: 9k7+qWr4TF+4wYV0c1ddEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166323090"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:54:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 01:54:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 01:54:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 01:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK2Ml7CwU513SXSIKFu5L0M90AkWS7E+9OdTgP1x/MYwrZONDoPiLV48MQUn/YG6u6J8R129MCJSRVQW3WgL9MO02wbvO46AzTYIH3KuKt2Bp8Xp3TeXfYN6ROyJ4knH1Ig45pkuJMgqa/CmkmjqhoWd7K2V/wix/xK/iuNMUdNnicdv/MhK47m2EahShrFnPijaKODIIwFAoJDCsPYqKkl1SUKkN8KP4QlgCT/GGeUDGNpuxXZ3y/6gpiO2xuLXKxZkquxQcsJt4ARAPMCQQ1rFsDOzhslrh//f58AnmbyO0h/ZJgbRNywwhPqFz/NJsPZs9yVASpBu7bfC8W2Sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTGaJJy4LpoWw80mI5C8i4gaXrDfrAo30CYUiIcI+UQ=;
 b=JAWXkGg2CQbvF7ArwOvbhuovTs6qSpVknCKts96sr/dMsZqUxK5m+7gqFnFzbSfmrlpO+RmjFmE9foC6cvs20oBdrylvsRw4Tnw2MO+RBUHAAnkwJbp0IYPPL65v7P/a3DoMW9a3Tfn9K1PtZpNky/4Fnmgi3R3LUNIZ4NERBnJ0Y2vRsT5bY9gwMhFBsK+6JaxQ/Fx5S61kAl6k20FlkloboeiDaxcIwOvzZPU7QBMxkVMddEij3QdaX2pN6t+iQ9NdDocKrYF48pSxrqp5yHLFW7Aa0yvdGaD82hSev3P3rbmv9pknpqkCjRaRss1TBbyLvIUFoageDx3aoC4MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 08:53:47 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 08:53:47 +0000
Message-ID: <b038317f-d7da-4539-831a-77c5863e9ea1@intel.com>
Date: Fri, 25 Jul 2025 11:53:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing
 parameters
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <kyle.roeschley@ni.com>,
	<linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
References: <7b124fe1-4f7b-4218-b564-e16ad2c3882f@intel.com>
 <20250724185354.815888-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250724185354.815888-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0195.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: eb79b0b8-f1f5-4eff-8304-08ddcb58c4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW03d1FuREtpOEQ4SUl6N2ZNUlJwSFYyNmJZRkFkSHYrbmJMSGZSZ3hvQ2Jq?=
 =?utf-8?B?bzFvempuMkJoeU1MU2p6YkRJcGJiNXlTT1FHQVBoWnpkU1ZGRk1KMFB5YWdM?=
 =?utf-8?B?U0JRU1M5alJ5dkNUMXNRVUp3VkQzdmxKSnpkVUdzVHM0OXEzQVBzN3lITDNG?=
 =?utf-8?B?MEFxWnNraldoaUlUdi8vbVZIbUp5SUszNGZ5MFJWNFpxajVaM0tlS1hYYmJM?=
 =?utf-8?B?eTN0SmtXVmRzYXRuYlNhQjVBckowN1ByQ3BNek16bkVIVW9tVUZXQUFZZU1h?=
 =?utf-8?B?Y3lYVFYzTVVHRFhxTFVzTnpZZEhNeno0Mlcva2F6V1A0RnJYRk8zaHJxY0Iz?=
 =?utf-8?B?RWxkYklQRG9qQXBDeHE4bW5XOVhYRnU1UHhRR1JOelVyVk1jbmtrcis2SW9W?=
 =?utf-8?B?bnUxSEtycDg0QmdtRldjeFBBSFd6a042RlpTcFkwQlBBQzlkeVFJUW03WGc3?=
 =?utf-8?B?YW4rM1E4TStIb2QxNUgraGY1RlJNNkhSdXNoUVRPSGJwUVJiV0JHM0Rvc1Br?=
 =?utf-8?B?ZWppVUZVczI4UmEzOVVmTGFGWjkvRXRNekRzVTNmazVtWVRYK0h5enV1dnZC?=
 =?utf-8?B?dG40UkpUTWVybGx1dERaWlRkVmNuREZuT0NTWWR2MTY3V2crOXljZlZWR3V0?=
 =?utf-8?B?WWh3V3lLeGdsN21QeHNVcEllSHJxNHhpdHAyUU1HSE96cUlPQjJ1YmptL09P?=
 =?utf-8?B?Ri9rVXJ6QmtkLzNRRjZ6VDl0emZtUHlOd2cyYXZ1dHZpc0V1UnNxd054N0pW?=
 =?utf-8?B?QnM3RVM4cXFLclFNWUhRSm1kQ2ZObXhtNXJpQU1NaTJTTWFucGZTN25BKyts?=
 =?utf-8?B?dU13YW9CL2VRL2JzVEp4akh1V3I4Q1M3cjhPbURkcFJ4cngrV1poY3Fla2h2?=
 =?utf-8?B?cTg5QUx6dkI0YXVKeEhYQ1V1UDZLeWJOR1hCdndiRTltMm82L3B3KytMTkZ1?=
 =?utf-8?B?bzAxdnhFNkR1ZTRFZkkxaEN6RVdzUTd0bDVNTWhXWWJXSkVvK1Q2TmFaQm56?=
 =?utf-8?B?WkNrRm5JRWJ2Rmw0YzRCRXVnaXBCYkNiUnpDN3BnZ1JKeHFwd2lrUTlVWUFq?=
 =?utf-8?B?bHNCeXZZM3dCWXdoaW9tcjBQNk4zTVVmdTQ3ZG1oUnB6OXRQOFNMNm1pRytv?=
 =?utf-8?B?UWxObklRRDRxU3lEV05IY2ZKUGlqQVRVUmlUM0ZJUjU3OS9VeVdmVCtrQS9s?=
 =?utf-8?B?Z1BWYXQ0dmVqU1FqcVlETzkxS2hiekVqM2w4UGFJTWpNWTlvdlFCVkFZeVNF?=
 =?utf-8?B?UEF2eTdwdWtCakdHcEwrUjYwU1Zyc1NkRGRKQThDd0VkQ3c5dCttV0J0L3JM?=
 =?utf-8?B?V0Z4ME95dHNnNyt4VmtpNTQ0RHFYN0pNcUxjczNlNHJWZUhnSWJzaGZtQ01s?=
 =?utf-8?B?ZStnMUxrUTNpWEt2WWoyV3dObWJ1QS9DdjJlUHcwc3FmRUtCSk9ueTJzZ1ha?=
 =?utf-8?B?K3VtN3lodEU5V2trRG9vWndkY3ZmUDBhMzBDS3NKTWI1SmFRcklOSWNqWncv?=
 =?utf-8?B?R01tem90YmZvUFNGZFZLWjcybW9kNDlOTGdLRnR5SmdCYVc5L0tOZXIyOEJS?=
 =?utf-8?B?ektUMmdKWStCUlZuSFIyQnBsVzAwUlJONHBaV2tDdUMycXdrK285NDBVVHkz?=
 =?utf-8?B?Mm5Gc3VqbkFRMmlqelQ5REplTkU1RkhGQnQwbVUrWTZ3MW4zRllPenpybXJw?=
 =?utf-8?B?UHYvTUFhY1JRTmF3YnVCODY2ZXlkeG9rRndESnFJOEtpbnREMDhQenlyV2pr?=
 =?utf-8?B?ZlA0aStNbVZDbW5VSUtjSU9jc2tmM2pOeDlMeFJKNlRlSWRKODBGMHgvWTlC?=
 =?utf-8?B?YkRMeGtGUjFVSGVPaW1ScDM2WHphRjlDZU1LZzdZV2tzRXhHcUQwRlAzdEVn?=
 =?utf-8?B?dUl1TUdteVY4ZVc4RWxqclZSblg0cS9Sb1dFVmQ5RVI4a0NXWUJ6Rm13TUJS?=
 =?utf-8?Q?cVxqiwcJWDQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VHMUhRWnNrSldzYU9oTU0zRUNUZ0xBZ0tKYjdmb3FyVW0wWk1xenlWMk16?=
 =?utf-8?B?clhEbVdESzhWS2pWN2pNNzhUWXVsdzFHaGdsTWJhOWZtK24zNHkwYU1MSEhx?=
 =?utf-8?B?TEZiV21JNXJpVFZPTzlnWDZrelRlUUlFMjZsRlNNQjZIaUhHaG1yNDBiYXZs?=
 =?utf-8?B?MDdKbWwyOEhWQWFCV3N3dzNhMzFZeUxablh5V1JDdzFiSGF0U29hdXZVci9t?=
 =?utf-8?B?bFJyMk1YZFZXcXd3bmJEMjd4cUFxV1M0ZWhHSmkyMlNkUVJ0VnB4a01ibUlI?=
 =?utf-8?B?S0dQeU5sUk5ueS9DV1loblJ4c1dUbVQ2cHVLT3UrRGtaTmhtZGcvNW1WTlhq?=
 =?utf-8?B?eVM4N2pKNFZobTFERk1tV0srRWxTNnl3R0xUc1ozMnNvNmxsYWJCa293ZUtu?=
 =?utf-8?B?MlBmam9GeW5KTVF3VThyTDFxNG9zR2IyNVAzN0dRYnNZd2w2OHQ4SXJCdW5s?=
 =?utf-8?B?OGFJd0tiSkZER0lkbnFNeGo5ZEZhM1JRRGlHU294ZnlSS2RSeHJsQk4wbVdo?=
 =?utf-8?B?M2NiNWJpZmU0YzRNWnRkems3NGRuTWlTUVdZRUduWE8yNFpNdE5BYm9FVG8w?=
 =?utf-8?B?N1dRZmNpSWc3NkprOWE4WWwrQTh2UmU2L3JEUGU0ajA2Y2IzMTg5V0cyTHpH?=
 =?utf-8?B?cStGRDk0NUU3QnZDSXYzUTBNb1FwLzFzU0RvM3Zic0EvY1FJaVVHQU9nSW5R?=
 =?utf-8?B?aGpzbzJLUXRDcHF6dXNNQ2FEZ3QvT2w5VGhMMjlncnRDYzdQRHRkQlFxcjAw?=
 =?utf-8?B?cVozRWpIWDA2cE1CYWJlUkloK2ZuWEhjNnNhYTlmcTIybHI5dzJQdmRhN2ZR?=
 =?utf-8?B?ci9aeEJoaGNmS051UWZ5d3hveDZENWJ4TExpdFNieFBKNVFtUGY3eVNCVTNy?=
 =?utf-8?B?NXNmMXRnWVBJZVduOHJyNmpYZ3h4aHhjbjRRL1h1Qjc2cHl5d3BxRDBhVmFl?=
 =?utf-8?B?d0Y1TGlrWVBEdXFta3FISnJ4UjNhY0hUeUxENXNZNjRLeFBFTlV4WndCWlkx?=
 =?utf-8?B?STVWMmdnUm91dzdCNXVSRnQ1ZUNJMzFvcXpEVUkxNS9wQTNGcG1yTm0yQzlv?=
 =?utf-8?B?Y3VqdGVITmQ0SEpsL1RTc3hVNzFZc3ZNd2I1cWx1YWhHaU9EY0ZmL1ZhMHVX?=
 =?utf-8?B?RzRiajJEY2dVZ2xFeTVWUk5lMUsycFBWWkwvcHUydk1IUlc0ZVdOMnJ2MGdF?=
 =?utf-8?B?TzFMNTJhaWNrbFJ0YUN5NzBtZnVDYXZOaTRFWlZiMFNUbm4rdW94dUhHN2M1?=
 =?utf-8?B?S2ttdU9hOFFuZEtiMVJQOUtsN3dTNTl0TGo0WHdqZW9RU1ZKNXlPZHF5M0J4?=
 =?utf-8?B?cVBSK1BkRzJDaHFlcHU2dHNOOEx0SmpaNGdJaFVZWjd1cC9WUkZWRFYreXFI?=
 =?utf-8?B?QVZIblZhTjMxTkRxeEJDVEdKSmFGdkpvSmpOYXBveWl5aDRwWVlzTHVKRlh3?=
 =?utf-8?B?TmtXck96Mm1wMnJiRjh6UitCOUVnMk1YblAyZFltMlVHZGhWRW9LK2JEUEsz?=
 =?utf-8?B?Y3BRTGdVbVFhZ2xEeHpyTEZFbWR1MVVnSWtTNGM3dGN0VEpnZGdzV21KZE1S?=
 =?utf-8?B?VFJGZWpjSUR1YlB4b0tVeVl0OWlQNVdzMHhMU3RMNWFucGJHSm5MZmlCU1Rs?=
 =?utf-8?B?Q2pZVnl4OU04K0xRcDVRVFhVanhIWjdRRUFnZ3F1Qi9Nc0FKUmt5ZlBhZDFB?=
 =?utf-8?B?NEpnMzVpdzdpNmpOOXA2blpXSjNxb2tQZS9DRlN3d0Y0dEozQk1WMXZReUF2?=
 =?utf-8?B?OFp6a0hKZFcrOUVyeTEyZWlzN2FEbDhxbGtqT1dWbjB2dXpCK3djSTg1V1JC?=
 =?utf-8?B?M1ZYNFVtR0IwVVdmK0VINGVtemRkTEwzUy80R0doTmpweWN6NDIyalRabkR4?=
 =?utf-8?B?SGNWYW5hOGxtbC9ISnAyNlVUTmkxSVNoMGUzTkNtV1pJczRqQWFMSVVYWklx?=
 =?utf-8?B?R29naXluY2l4TXc3bkxtbTZSUkN4UVJjM3gwQXVIVFc4aDlPcHpvcXNFeWxw?=
 =?utf-8?B?UlE5bzYzNUNjSFM1ZVhkN20rOHc4d2pwaVpJaWlYRFI3WG1HMGJDTTBCbEoz?=
 =?utf-8?B?cXZkMVJkRmFhdjR1NWZzc04yK0JCbjV6V2pTMG9PZk1oWmt5VDM4WFdmUWVV?=
 =?utf-8?B?M21SRGlEUDBBNnVONnMvMTEzVld2SUFidXNtaGZkOHQycEQ1elR2ZDJYSm5M?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb79b0b8-f1f5-4eff-8304-08ddcb58c4ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:53:47.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYo+2fosVXfc76+v2ZRqBqbXrjhPYrKDOP0fgUmbOVGcTdailJ6q27w1Y1wGZz8RaiUBTDIgouZRywl1rC0Uow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com

On 24/07/2025 21:53, Erick Shepherd wrote:
> Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
> the SD card clock parameters only after first disabling the external card
> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
> SD controllers which otherwise breaks voltage switching with a specific
> Swissbit SD card. This change is limited to Intel host controllers to
> avoid an issue reported on ARM64 devices.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b0b1d403f352..7ef821d16d39 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -689,8 +689,19 @@ static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return 0;
>  }
>  
> +static void sdhci_intel_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	/* Stop card clock separately to avoid glitches on clock line */
> +	if (clk & SDHCI_CLOCK_CARD_EN)
> +		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN, SDHCI_CLOCK_CONTROL);
> +
> +	sdhci_set_clock(host, clock);
> +}
> +
>  static const struct sdhci_ops sdhci_intel_byt_ops = {
> -	.set_clock		= sdhci_set_clock,
> +	.set_clock		= sdhci_intel_set_clock,
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -700,7 +711,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
>  };
>  
>  static const struct sdhci_ops sdhci_intel_glk_ops = {
> -	.set_clock		= sdhci_set_clock,
> +	.set_clock		= sdhci_intel_set_clock,
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,

