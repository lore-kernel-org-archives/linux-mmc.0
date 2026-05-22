Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465592BF3F4;
	Fri, 22 May 2026 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427951; cv=fail; b=PgwBgSkjeyKZBzivcs/lMnf2afma3HEB/Tx0LzvtzjY5ivTby8+aCx+SKGdBzY6rPUoSJtkpBEUBk7+hVmTOSV/hqgVKGAZt3dxyBDxbeyggrZGYp9saj+CsYbcEETTbl7TkoJ0Dc4TaSza2+U5KACrBK2WpW82/LblHyq4YI1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427951; c=relaxed/simple;
	bh=/0qEJLvZVeT10norvm5oOhjtDGXErxNJ7VxVjUcv7uY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNEbSY3q9+Mghoci/VWi9poMVqXoBngsJOKTMbklO/AER8FmuXky51/Nq7fYLsSNoiyxVj/ctHuUXrtHr9UUDke7qpKAlJ4IYkXfGI6zPedjRpEIfo2rk0toUHXujpvOJkt65fy6OO2sS81CHniGXZmDJ2iQmsfNBXonlayEwJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz2PIhu3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz2PIhu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779427949; x=1810963949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0qEJLvZVeT10norvm5oOhjtDGXErxNJ7VxVjUcv7uY=;
  b=Vz2PIhu3tmLYd+UDfvvvxpIADKkm8Dx5boUw3WECC+IngiYD0+kRG+qW
   RQZjpu+Fvt/MN21gJekhTnHMdL8gnoOe5eldCDgsCj2IMOHkjGl/dE9l7
   sDTJNcF3Gt6ywOdsjXJNq6fAO6rlocxWKevRKsUA6SPZS+onA1GpRjeD0
   n+81NnkokJldft06rUYoX7LQPYTlCqMtE9hFGQ7r7FKN+cm5Kn4EMoxr8
   05yY0xtkrJZW7PDtROT0iHTnF4i+Gxx2hqIQHMV0Hj8ND4iv9b2nQdbK9
   S6nbkXiPaVX/8AlKM3MUnUL7ZqR4dE2TmG4E3ViDAtQSy7HI68t3bewEh
   w==;
X-CSE-ConnectionGUID: yNzRZYnyRAiHJp5ncIHngg==
X-CSE-MsgGUID: y7MNhN48SYGSrtVCvvV7Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97929853"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="97929853"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 22:32:29 -0700
X-CSE-ConnectionGUID: q2y+TBLdQD+5O/8ou1CWRw==
X-CSE-MsgGUID: +i5WVpUFRdub4KVoAdg5Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="236386072"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 22:32:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:32:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:32:28 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0WhJqwvDs15pKzr4mnP404EZ/yrTWXf+DEwdTYojVQkR5LlBVQn1IQfyS+I1auP96FawCKe/MLHFgaERsp2P7YVyqgbB2lNYNkJuMOFdYuZObGzrlyAv6Rx8hT8KHDtpBqtWT+DqIH10Vd0ZklMvbuxXk//udIxBl9WCxklhdrmU82bzjAV7PhfH5sFYXCFvAZ1Wmknh6pWnXeuWZKly1HjlA9hrBANSZ3IuQojet415oFRRWs6B9JeTz3NyWPOUS0Tg+zVlq9HmpMx5fRbGr0W6hztcZ4e4Qhq0mRp8NloQ9tkH1XiazdcZZ78kiwd7iR1jdjsDdJoNZPMcDvEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRSunV0qPHuYvzfqm4EmGiK4fHGMm5JLYSK5IDzbKl8=;
 b=cFFzz5fji8jeMy6NZ0KqOig7biP6gq1Zpm8U3wsNgsmy3dijtS8NDnl/XuoxlgS3QboO5O/Wg+u9ntNCrVvlPi1LSgx/na3Wy/7a5oVugVEeSZX+T2j0Nqk9ZMnoOMuCNx6RcKZ6AH0H+r9xy9zUmM3aFvFbQ5E2tttpQOfaSEN3xsfuIR5UG6VfjhJK2bFZsIKxkaAMCaC+SK+YEtuepinZKjUmYeLCFo/Nkjmb6MuhXYLa++2q0YRc8nqiE48MXEFRhdNex57b47H250+N3LSL4my4h1yNWXt+ruf4CoFqUEyiYogvOqdbdKOBt3hPjCudRSRSr3x2IU5h+C3AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7216.namprd11.prod.outlook.com (2603:10b6:8:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:32:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:32:24 +0000
Message-ID: <d6ed9186-3081-40b5-aec3-9f3f61e6e80b@intel.com>
Date: Fri, 22 May 2026 08:32:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] mmc: sdhci-cadence: add Cadence SD6HC support
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-9-tanmay.kathpalia@altera.com>
 <6736df61-0adf-41d4-ba45-f1fa08998a58@intel.com>
 <3934027d-a865-40f9-8350-0027865a3682@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <3934027d-a865-40f9-8350-0027865a3682@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0221.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed65472-7498-46fc-2b79-08deb7c380aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: uVdR3JPAcr6+ehB3qA5onBP2+BoT76Vqo/C6ibzKUWFxcERr4ZM61Tt2y5YF+pNnZiPAtEAtG6hry+P/2DVXITBTkzZMJD7uKauF60+2vmDoKy26spDqD3Xem9HNLS3SM6IPOxowYFRyBG3ZNzSmG3wvKzIwUGMOOt4dRB/mzOVRJ01lNBRlaVU5dcc7nNxUPVYVcK7GmJdS9QNCdkEK7cS8W+HWBt+1lmDhPck+PW5ZOX4GDyLqcvykUsawtKTDI6sXvb/Gvx5SBKMTCjd5eeayOymAnISSiM1WkOkzr9dY5UKVbbf4Xkf6bhzea78IG18CS3KGOpas9kLUoXAAdcjyi9CdVMtDUMnXwc8RzZclnEJwdqXsLPMC9XeVmR5XSSL2yMt2ABTUmzSivVaTnO66lJRXzz5TAgEKagl4cPaSzXRjBQEor+ZXJbg3HrG5p9dlVGR4BES3FclWOuEbL4tEhFx20sXpULi9jGtDrKVkNTNGlF5sWC3O94uVpEFn6EMvvQVKtwBLVMBpvaKPOS4l8ZMOlSPRS/ZG+lty+WuYfNIVhj/DCJVokWG42VcOrgVMnalHTmvBntPJ14M/2RvqiSVnvG7fCHvDnarUk7CCyAlgRXLZpZ2upK5tetxEbiItkDAlvbIsZyw60Iy0XKbLyDfkuRs0hAKhtRaSHY35m0osBs8sgNohIRx+nRvx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjF4aDBTNHpHeEZveVkxZC9RZ1AzVWlFRzh4K01weFcvN0Y0UkpST2s2eVRY?=
 =?utf-8?B?TGwzUWk1V0VteXVZSytBNHJHT1FEVEZpMkNFa01MZWI1OGxDamx0bVRuOSs1?=
 =?utf-8?B?WUdNVXZoOUZKcnAxMlpHb3pIL0pSeW1oVU5JY2Qra0ZLcEJmdHc5YzZLMmZJ?=
 =?utf-8?B?cFZDUExBMjRZTGpiVXZ4TWIzNDd3eHZaZEk4N0QrY0c2cFlzSmI5aC85eXZE?=
 =?utf-8?B?ZkVoOTJUT3laeFBVOUxDZGNyWDkvSmlmYVFIcW5TNzdDaGZkWEtYTGxDVmw1?=
 =?utf-8?B?eVFieklUMjF1czVUdGV4TWR3NXRubWtBbGYxelROSE9kaEJ5aDF4Sk5PS1ZF?=
 =?utf-8?B?RFNuTThmbTNPcEtoS2JCS0NjQmk3cmlBQ0pSK1RsR2ZoQUJjeVpTbmx5am13?=
 =?utf-8?B?aE8wdFpwRGtKMDBqUWF4OXNFWFNyV3R5U1owL0MzdWhnRUhmK2hPL3ZKV1Mw?=
 =?utf-8?B?ZjdseEl5cjk0RlRQbjF3M3dTY0gvVGYvOEpXcHB4VE04SzFxU1VEdm5QeXFJ?=
 =?utf-8?B?NG9lbHZReXZJK1lhYTBlSG1NcWhadVM3M2dvK0hyL0kvRDJUTXZUREIrZldu?=
 =?utf-8?B?S1REdFdJQnZQRnkvS1BOVm1HWUFFbjZtS1o2bHlBalFDV0FISFUwZGlRWFNq?=
 =?utf-8?B?dVJaZ2FRMjRqNmM1b21KS0U1T0JRdDIzanRpWTNaV2E3cnFvZWVWUkhNeWZs?=
 =?utf-8?B?OTlhcnhiRTZ1dko5MnM1T0tsNFNlcUhUbDBldWZ3c21nampxa2JwbGc3dHBD?=
 =?utf-8?B?anBpN1ByTEtaaU92cndkSTJHMThMMWZJaHJIZURLUjhLcHYrUWNreWsvZXp2?=
 =?utf-8?B?R3ZOOG9lSzExRldjRWRWZnhDZFVoYko4Y1Z3OUJYV29xemxtZVhKNXdwYkJK?=
 =?utf-8?B?M3NpTTh6dmZEVjFuNllpWnQ0blJjRTQ4TDg5SlRmNVZ4ckxDd0dFbFBoYVFX?=
 =?utf-8?B?L3hteWtpSU0yZ1RvbXVCQUpoWWUxVW9XZnlWZURTRWZMd1VCeFIwOXBKellK?=
 =?utf-8?B?dDRQWU9laWpyVjNOYS9JR1A4cjZqN2JLU2JRR05MdStIdCtiUGFxVy9aOE5s?=
 =?utf-8?B?NkpmT01HWFVqSm1JMGxLTGJNS1JXQVBqUXFxeU85Ujh6ajR5a3c3QlZJSjBH?=
 =?utf-8?B?WnZVL01RWENxSGU0RTdRQ3dMOWk1RGZDYm84ZWdrUUZoOUF3THA5cXgyZkdS?=
 =?utf-8?B?QTVRYkN4cnZkWGkrWmNQZjNwY0ZmMUVOYmdzUFlPTEt1Z3c1MnQrelRlL2R6?=
 =?utf-8?B?alphdnlOKzVtWnRBYkpCZ092Zkh6RUI5NnlIdlEzUG9ES2t0dVlKc3ZkbTg0?=
 =?utf-8?B?R2xzQTl2UE80QXR0a2NPajVWeno0YXZvN1hpTzBjY2RpT3FEU2pDSjRZYWRC?=
 =?utf-8?B?ZVZ4dEFnR2orVi83MDA5V0dFUnA3djZkdjRZaFNPYWNqL3NyeHZDZWZERXU3?=
 =?utf-8?B?RFpkckx4bVJ6a2JNcU1TUGk4Rk5sOGs5WUtRS2k2dmYza0pka2ZLcG9OYmhs?=
 =?utf-8?B?ZXBQYWU4NC9oYk91ZDJzK3AwRnluSVJCdmpsSmQ3RzRSV0ZudkZvbFRHdGNh?=
 =?utf-8?B?WXRlTnVSMXBQSjA1MzFvKzJxQktodTRrakFaWFUxd0JDM09GOFZTK3grSUJm?=
 =?utf-8?B?RzdCR0hWNHZNZ0dSb0hGbUtmVEJGV1ZqeWhkVE9qbDB5Qm15a0t4dW52ejc3?=
 =?utf-8?B?dTh5Lzhwei9QWnNRQ1B0eXFkeFUyYjAwK0ZkMkhNRStLZnpGcWo2YVlvUGQx?=
 =?utf-8?B?VU9PWnl1WWJOc2oyVlRRT0c3WGdvNmFaZDEwTFEzUWlWMDBjNWQ4N1RycXha?=
 =?utf-8?B?YlAyVVFLeUdNVll1dEpPb0hncmYvOFBWNzdjbDl0WXMvRUFYSmQ1bzNhd0NQ?=
 =?utf-8?B?RThScEY1OXIwblVYZ0F1WkVPaWFnNWZOenlCY3hSL0JoUGc2T1VsOHpJQjB4?=
 =?utf-8?B?Z3M4T2RMTHZhTTdCUCtjR0Y1dXZGSVZvSi83MktVVjNQcG5xN3p0cnA0dmtD?=
 =?utf-8?B?S1lTWDZ1N01MM2Fuc2xVU0s5OXhTSU41SWdhYUM0OU5EUXBhYkprQUtVYmJ6?=
 =?utf-8?B?WE1VZnFZVWh3ZitjUmJtMUd0SFIvaE5CT2RKaUg0YzF3SFozOFlWZTZSSzdW?=
 =?utf-8?B?MHhmc2dCTDAyZWZvMnlwSDJIOEcvMUlDeHJsVUtSRzhxeXV3ZGM4UlA5ZXBa?=
 =?utf-8?B?aXUrbC9xZ1ZRNmhUWTZOaiszZG1FdVYzTjZGbG80OFcwaDhKUEJrYXhrKzky?=
 =?utf-8?B?WXhZME1KMTVoUFhMUHFwR1gzVWVuVTdYTExjdlVia3lCTlEwQzJWTXZDWDFn?=
 =?utf-8?B?NXZ2QTRBL0ord2NCSExzSVV3c0ZiU3FzN2xPaWdydVdsOEJpYWlFTzRhSmF5?=
 =?utf-8?Q?7JLpa66YBp6WHb/M=3D?=
X-Exchange-RoutingPolicyChecked: FruWabSxqBM/aK4vxNk1iPW8nd1OD3HRyLPXFSV1ANAQ1htFFaYs89DviQiBhunXFZGzB/HmOGmd59gOHGB5rDdLAqNTLAdc/TqE1wt9zm+eQD9HU/twJC5g120U9JvZn7YM5EVzx3Z7GwxJDI7GcYrtgv7as86xMGOzXO7jNuW5EVCfjoLcRtcs04H3pY3ENMv12WucG9DYLPl0Pce2+tOWrazfqKX8rxAxO9TRgrD6YWUFeDX2QC71vHrxfVZLk7ENtQt7a0dgdi2mtwlJg8a2rO9jnS+UMyy+HhjHnt3dQ3IuNiAgvfY/4QyWwEooM2xMMKgsTSv3pNeLQrk77Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed65472-7498-46fc-2b79-08deb7c380aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:32:24.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05Prps3zVge4wg9Bwz6oY1+M/IGlT0ug2sPGQYIvfWxWz7XH0IasSYwuUYeo39JzY/3aLFWZ/Yqgg9uaPDPRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7216
X-OriginatorOrg: intel.com

On 21/05/2026 20:28, Kathpalia, Tanmay wrote:
> Hi Adrian,
> 
> Thanks for your feedback.
> 
> On 5/19/2026 8:59 PM, Adrian Hunter wrote:
>> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>>> The Cadence SD6HC is the sixth-generation SD Host Controller used in
>>> Agilex5 SoCs. Its PHY differs substantially from the SD4HC: it
>>> requires per-speed-mode IO cell timing parameters and a DLL-based
>>> delay line to achieve correct signal margins across all speed grades
>>> from Default Speed to HS400.
>>>
>>> Support is implemented in a new sdhci-cadence6.c alongside the
>>> existing v4 code, now in sdhci-cadence4.c. Shared structures and the
>>> v6 function interface are declared in a new sdhci-cadence.h header.
>>> The common driver paths select between v4 and v6 PHY operations based
>>> on the SDHCI specification version reported by the controller.
>>>
>>> The new compatible string "cdns,sd6hc" identifies SD6HC hardware in
>>> device tree.
>>>
>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>> ---
>>>   MAINTAINERS                                   |    7 +
>>>   drivers/mmc/host/Makefile                     |    3 +-
>>>   drivers/mmc/host/sdhci-cadence.h              |  113 ++
>>>   .../{sdhci-cadence.c => sdhci-cadence4.c}     |   92 +-
>>>   drivers/mmc/host/sdhci-cadence6.c             | 1051 +++++++++++++++++
>>>   5 files changed, 1228 insertions(+), 38 deletions(-)
>>>   create mode 100644 drivers/mmc/host/sdhci-cadence.h
>>>   rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence4.c} (91%)
>>>   create mode 100644 drivers/mmc/host/sdhci-cadence6.c
>> The new file names seem slightly misleading since sdhci-cadence4.c
>> is the main driver as well as supporting V4, whereas sdhci-cadence6.c
>> is most of V6 support.
>>
>> There doesn't seem much to gain from having a separate sdhci-cadence6.c.
>> Isn't it simpler to just put it all in 1 source file.
> 
> I believe keeping them separate improves maintainability for the
> following reasons:
> 
> 1. V4 and V6 PHY programming models are fundamentally different:
>     a. SD4HC reads pre-computed delay values directly from DT and
>     writes them one-to-one into PHY registers.
>     b. SD6HC takes only a few timing parameters (IO cell delay, delay
>     element size) from DT and derives all PHY and SDHC register
>     programming values inside the driver through a calibration
>     sequence.
> 2. The V6 PHY logic alone is more than 1000 lines. Merging it into
> the existing file would make sdhci-cadence4.c significantly harder
> to review, and maintain.
> 3. Keep code structure aligned with U-Boot, where V6 handling is
> also separated.
> 
> That said, I am open to merging into one file if you think that is
> better for maintainability in this driver. I can do that in v2.

At the very least, the file names need to be more explicit:

  The core part of the driver:	sdhci-cadence-core.c
  The V6 PHY implementation:	sdhci-cadence-phy-v6.c

