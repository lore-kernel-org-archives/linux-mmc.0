Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59541F5D9;
	Fri,  7 Aug 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106456; cv=fail; b=UiN+5fvKwlFC7HbLFj9NMNxJ1HcoO2VvTdnd/vAY0ajtqcvjiAAG7dPUzQhImkZ+HfssjIXkDJDgy1Xl6OPxS9ycEJh4WCGlamtfJx2pJPbTSWoA69cfqrJS03V2nWYQSGG9WYlz2++RarZXuT4x69puQ7gAgabId7EOdpRHfvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106456; c=relaxed/simple;
	bh=FnPIcxQSPm3TJHm5vU4K2qo2z3H+DDDU2D5jlYrMZBE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEgmcjQ2skxjD/aJtJyU0ulJs7Y2MksHa625FqXsjjRKchTrfL53E9uC7Xskboscf4fBHcWt4ttCHSjdF0yfkaZdZw8PEnevuBDt2bDsd+K5ARToC0OHyhYXWN6tiftMWDPFS6BQNDJHMeiVmAfIUblNLDJNkNJq9XFiz/VOm60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBs8/SLm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBs8/SLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786106436; x=1817642436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FnPIcxQSPm3TJHm5vU4K2qo2z3H+DDDU2D5jlYrMZBE=;
  b=gBs8/SLmL+V7iAEz6ZQXnNSsvJcO2oMZsSF+nKo65yPShAix14qhN9e7
   DF6u2IBAtT9fTJqf2mcw55kZBc9N5sHxp1YLtaZ9flw/K9c88TKcdpqhf
   tTugV/85rWSMh1KaB+VRPvsbq6UX5TkDwFr8zmZw+h+pjQXJyNF1OhZPj
   7NH+yTmeJAOcNT0VkA17OCaWOjzzVmydlxwO/WWvtu0fdseHp4ln3POqx
   S4xieQccKC/glThytJ5Pwm4Qlw8UnM3xQEn5nw7Ytw1Qt6w4+Z//rtRd1
   ghBHvq7HxU9kkO+u4VySN7zzNF8AcXclpJ2B5t+Sf6t05nyx9KSibXZMB
   g==;
X-CSE-ConnectionGUID: 7XBfGIrxSeeW7PfId1Lqcw==
X-CSE-MsgGUID: BbTV8vAITuCh9/tIvYFa1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86565590"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86565590"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:40:29 -0700
X-CSE-ConnectionGUID: sJn4H4xqTrWbMA/hr+zllw==
X-CSE-MsgGUID: Jm7kjPumRh2JGsBhuYbkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261100532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:40:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:40:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 05:40:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXjJalU43/m4rBVQd883tDTUt4mEUwPovmTuDXmxdzNDVGF5HmSZWUj+9zXsJ+R5bdyAt+Ep8Z/gQIu79LZOsvZEObxnZd7JHOdAMpjHaKmvYGcgfvqfE3FKEWq8v9FlmVU4yiwxv1QNn/YR4mvLfw6SFHulK0V0+e/it2tr7IbdHI/Pbh6epC4dx4CjlBd7SUq3fQc+iypnrBYk69BmeuoidY0r7qYdAQ2u6Nv3zfsqmL8chtNngC7PbZrFNIRaKQuj/RYbHg6s2L/xpaMdX1U0ScmXn6QOx9NsgQGbQCrUR0dhA0sGbsV+Ex/PPBti6MLUZhcOZtgmsNaqmWm24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c4JqRBjZ8PM10DV+pZUQWcGMsEEpBaf72LJC/aww9E=;
 b=D0pdXh3/3otspfWoFxMtrF0+bSXcDRyzARd1hW5e4frLR2BZs/HLf/TdDBDT3iiW5WQzevyEHn/EjFvHbn4HiIHBJRgl1vDQF9JP4k93Otcy9VJYjLCfzXwuaeFpYfNspiKVNYkrXvq2at3Jz3HuZGWxKL3X1e3S6nAicy7aACZYhOqLjHUdECqVl5kqD1DYVLTtjWK1ir0PwlXJD4FsQMmSFYitzAyg3lG3IteIZMTqYkh8Y4OHt5zUGFj8AQEikNGYIqegAawB7ZWwbCfwuKK+Q7R3QV8De3l80mwVQxeZxO4sPbf5tuad7oxBH29KWg6pzG3dbwoJGeRBfhnaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 12:40:17 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 12:40:17 +0000
Message-ID: <92d5cad1-a805-4cf9-bd24-8b0b2bde93a1@intel.com>
Date: Fri, 7 Aug 2026 15:40:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] mmc: sdhci-cadence: add Cadence SD6HC support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
 <20260724145009.7456-7-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260724145009.7456-7-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:10:234::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc2fec8-6008-4575-b1e5-08def48108b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: /ptoCZms5LQZW7LXcfsnQQD0YZtTgggjL0aAqaMPQzByMTqwlkASM0sknjWJtmwGBB2C5dkhGxnPc3IGGdHH7u6bg/vj2nk8guETjynbL2AxS6mHGSIDnpXPi2z/dR7NbBuC9JVRaPqySKyrZls7yeJg0b6Mk1Uzx9HXAfKqD62/vuNGSXIII+AdkUBluL67PVjSwcK0ijRJ1OHi3ebSKBx12Ruly7PjbyTouC2rWhpZ8XrgG9ZI4jbjchBy5toTNHhOASg7xY0ShXYH1BUrmCKKwy4TkPGw5bjfzsMSMA5HODvKDHXae0N0QAxkx1HkZjS66dU0ojYS9HashE11WSDDEmvGZTtUMTWJEncjIiMJ82RZV3QTS6uUoRu1qrwkMb4iApH7WAtezgqzY3KKMqUu7ZhUyYsHEQTv2AL7sjJxbza4zJG8WbBBf/54Fe6XHiHBpnBhczZ4TTnjA77lABED5xL4sRAYpQPQJKrRT/B9PI7x8EYJgr+m6HP1DofYGApur4AroCuE2tjwgObigUFccQm2cKTUOGWuexKP88EPQgqWgMwfc2IkGB/jNMisIFvSnWIYR/rNQqGjv9yvgNViMph6R3qCwPOks4Z1a6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allGTnh3VStIKzBxOUo0QUFtN0VreDNxUC9wenZSWURna0VSbnE0VXVveldq?=
 =?utf-8?B?ejdVcW11ZHkzNDRyTkw1WFg3UnhZMk1iVWdRSm9iOVlXWElxN1RJQW54c2JN?=
 =?utf-8?B?SVprL1dLaGMvaXhZd2ZKcS9WUVJmY3p3SElRNTJ0djZwVjdDNVZEYTBKNWRi?=
 =?utf-8?B?eXhQMitnMDN4S0lRUitrZlk3dngrRURmOEFJMEtEblRnYXNyL00zODBQR0xT?=
 =?utf-8?B?YkZmajBYRHduTE1OOGlvNmREbzloQUtUN0Vma2sweFBKSnhMS3JveDBFTGl4?=
 =?utf-8?B?L0FFY0F1bVNaZDdwNy8yaHcwNU1weStib0k3ZCtWblpUc29XblI2Q3JHSzNa?=
 =?utf-8?B?K0w1UDlRRE5WVFF5NjZaY1FnK3FuVnoyRThTaFNGRmZtR3AxT1c3TS9ST0hj?=
 =?utf-8?B?VzBvdk1nWEpxam9ZbEFmR1N5aTlOUm5NNld6dnZyZTB3NXZMYU11UURKaE9T?=
 =?utf-8?B?c2ZHN2RQS0FSUnYwS1lTTWo2VnRoVXRVczNXQnRnN2NocndLM0IxWk9hRVZn?=
 =?utf-8?B?bXVoYzVmVDlGTG1yL2ZOVGxOQU5YZ29CMUtsNlVHdWQ2cWpZWnpTTFo4V0Jj?=
 =?utf-8?B?cU9CYjYzZUFWeDM3S1hoNno3U1ZQZHZyMFJZYzBnbjN2Q0FrUEkxMUJPSUY0?=
 =?utf-8?B?aHZKWWdLdlRkdXB3ckhwRlpxWUU3QXM0cEo3dFBFbUJySmpuUHFaeHd6MCtn?=
 =?utf-8?B?d0p1Q1ZwVWNyTWNEb0JKV0RoMnBjSklQUkpsQ1lZRDNIMGFhQnRmYXdHbG56?=
 =?utf-8?B?a1F5ZmRoeFUvRG05dGRhWER3cnVFeFdkSHBzbzdZYksrOHpEaHJWNTRaWVZz?=
 =?utf-8?B?eGZuU2ZpZFRpbzc4SzdxbUZrbjY4THVaMDdiY3E5RCszam1ET1NLRmlUN3Jm?=
 =?utf-8?B?RnB2UVJVdHo3bjZNc1N1c2E1N1JBYm1hZ21ENURTcWIrY21pa0Z3M01BR2Qz?=
 =?utf-8?B?YWh5Q1pGT3FRL1IrU3o5YXlRSi95NXFOa2VhYkRBQkNKcXVhY2h3c2UwTFV4?=
 =?utf-8?B?TExMQm9VRG1Id1QvejRRWFc0Q1Qrd2c3ejE4bVMvTW5rZ1ZDcGtqVnlzQVds?=
 =?utf-8?B?WWcrVmZocFdwb1Yybjlaa29sNUFTZGNZcm1UZkJoRVhkU0JNZjR2bStheDJy?=
 =?utf-8?B?UC94dmVkc0hqNms5RnhTbmhDRDF6alo4RzB1NW5xUTh2UlJiWUZ5WVc2RnVR?=
 =?utf-8?B?ZVVBUDZ6QTB2eDBDNTVyT0x2Q2lXTlpWVVRzMnJwYkVRSE8yc2NyRi9QRXdI?=
 =?utf-8?B?UEI4ZXlCdEJnWGZPbzZqaldmbEcrMnEyOTZHL2VpcUlZanVJRy9ocDFqb09P?=
 =?utf-8?B?ZEs3M3ZYQzdreFp3MXU0UEhCc3hHaGNLNU42VE9SZ0U4ei9NVEpvaDNSa1dL?=
 =?utf-8?B?b09iS1dSWlB3STN2U0lONVBuSWViTDJXTTZIMlRsaWVuOWJsSm5Ka2pBR25i?=
 =?utf-8?B?L3I4OTI5cXNpcmlFVnZwMEFtdEpYSnZxWG1rbkc4TldBQk0rNk9QSUZuZFl1?=
 =?utf-8?B?bExVM3F1RGx6ZDBMVW92ZlFPNWNuczROMW1oaFBmb1p3SVZHbjBydHZVZkhB?=
 =?utf-8?B?cXhnTnhVU0prSlBPMEFYcGJsUXQ2TmpNRUV3ckFweUJ4UHg2dGZXWVgvbXhF?=
 =?utf-8?B?UlJXWjNCenpmUEVHWGkyQzRRYVBxR25VSTRBRUdsamJvUnpEZHFNVGQ1NFFy?=
 =?utf-8?B?a3htMDJnZDB0SG1FaHh6cjkwd1lPOEw5K2VzNm1JNVZRZ1RpNEJmNFI2QVV6?=
 =?utf-8?B?UVg3T24yZXlUaVJsTzhneFNacVRrYXlUV1paZUxUQmNVYndITEZ6NkJPYzZa?=
 =?utf-8?B?K3ZoR0FkaEg3KzhhL2E4ZGp3VURNc1RqT2h2eXJpWHZuOEU2bTYzQ2Q3LzVE?=
 =?utf-8?B?QjR0UmU5NTBOdUN6WDJCT1JmenlFN0wzUC93REIzd05oN1JVQjFVelFqd0Vu?=
 =?utf-8?B?MzZwc3RXR3l2d3B1MUZyWmplbWJaUzBPVCt4ejRLaG5yMTBXektjcFFnSmoy?=
 =?utf-8?B?OEl5VmVYRDIyQnkzdSsxV3JZdHhmaTVybUFkb3lNdzhsaWpjMHdqckdZMi9y?=
 =?utf-8?B?cmJtaG5wU1djS1NGQ0hXa1c2ejVvTU5PM0pXUHF6ZzJHaHpEUEFhOC9OMUZq?=
 =?utf-8?B?cGZQL08xQTJOREl5dlhPN015dFdlVDJoZktidE8zMHUyQVdMWlVTUlNsSlpq?=
 =?utf-8?B?YllaVmRJcGpHaXdDOWJwZVBNUFY4M0lUWTJSWnordFJjOFlYd2QzUGpBK2I4?=
 =?utf-8?B?eGltZTU0WGFlOGQwcG1IakRHU0Z6OWc4cDFkNlAweTZZWlkwNmRQWlJQZHNC?=
 =?utf-8?B?OHErcC9hRnZ6Y0lhc2xsUndSVndTRW1QRFdtaUtJWWJPYlU3M3JLYVZjd09l?=
 =?utf-8?Q?BXevIn4hNwsJ3X4U=3D?=
X-Exchange-RoutingPolicyChecked: n0pkj+hr6W+gFUlsqkGDjXmrpu2neptJ0gf9Vn6vVpLP/cEpgWeVMmAyPWo4AZuFC5rehYTQezAV9F5W17al5M7jLXC5xFEdDq7wkdMXgr1Qqkutp3noUespZUj+13Q1L0DKl40VlK315wWjE9NvihV4m4sc01PA9q6zuXMio7t4V6Yo2wzIeFEU0oOqdk7LgSofuG1uDVoxtUUWUI/tUGehlaTlwHBNf7qlTvbGhB0nL1+Q0fmXo2ZTmv1V7OE2AdyUOFkFYbGoGr7FFNRYr4BlXpPpa9wIsaqo2O6vFk38V5f0GjbLnZxD+fUz5ojZVe6yE0yPo3e8rAyiG3GMHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc2fec8-6008-4575-b1e5-08def48108b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:40:16.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttfmhrCERdG2giLLjag4ZmSjR8y9bWavGx0r/Ugi85PDCU717V55URRUm1a3JZ9l3h8YzK4q6XJoepbzhKZWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com

On 24/07/2026 17:50, Tanmay Kathpalia wrote:
> The Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller
> with an integrated combo-PHY. PHY timing depends on the active speed
> mode, the SD clock period, and board-level IO-cell and DLL delay-
> element characteristics.
> 
> SD6HC provides separate card-interface (CIU) and bus-interface (BIU)
> clocks, and asserts eMMC hardware reset through an internal controller
> register rather than an external RST_n line. The "cdns,sd6hc" compatible
> string identifies this IP in device tree.
> 
> Split the existing driver into sdhci-cadence-core.c and
> sdhci-cadence-phy-v6.c, and add sdhci-cadence.h for shared private
> state.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

There are a couple of comments below.  Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS                                   |   7 +
>  drivers/mmc/host/Makefile                     |   1 +
>  .../{sdhci-cadence.c => sdhci-cadence-core.c} | 122 ++-
>  drivers/mmc/host/sdhci-cadence-phy-v6.c       | 929 ++++++++++++++++++
>  drivers/mmc/host/sdhci-cadence.h              | 111 +++
>  5 files changed, 1130 insertions(+), 40 deletions(-)
>  rename drivers/mmc/host/{sdhci-cadence.c => sdhci-cadence-core.c} (86%)
>  create mode 100644 drivers/mmc/host/sdhci-cadence-phy-v6.c
>  create mode 100644 drivers/mmc/host/sdhci-cadence.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a0996faa091..58267c681780 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24407,6 +24407,13 @@ L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-brcmstb*
>  
> +SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) CADENCE DRIVER
> +M:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> +L:	linux-mmc@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
> +F:	drivers/mmc/host/sdhci-cadence*
> +
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
>  M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mmc@vger.kernel.org
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ee412e6b84d6..799ce7ad43d5 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
>  
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
> +sdhci-cadence-y				+= sdhci-cadence-core.o sdhci-cadence-phy-v6.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence-core.c
> similarity index 86%
> rename from drivers/mmc/host/sdhci-cadence.c
> rename to drivers/mmc/host/sdhci-cadence-core.c
> index 1fb23051a047..18846acc0b11 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2016 Socionext Inc.
>   *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + * Copyright (C) 2026 Altera Corporation
>   */
>  
>  #include <linux/bitfield.h>
> @@ -14,10 +15,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  
> -#include "sdhci-pltfm.h"
> +#include "sdhci-cadence.h"
>  
>  /* HRS - Host Register Set (specific to Cadence) */
> -#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> +/* HRS04 (PHY access) bitfields (SD4HC) */
>  #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
>  #define   SDHCI_CDNS_HRS04_RD			BIT(25)
>  #define   SDHCI_CDNS_HRS04_WR			BIT(24)
> @@ -71,13 +72,6 @@
>  #define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
>  #define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
>  
> -/*
> - * The tuned val register is 6 bit-wide, but not the whole of the range is
> - * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
> - * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
> - */
> -#define SDHCI_CDNS_MAX_TUNING_LOOP	40
> -
>  struct sdhci_cdns4_phy_param {
>  	u8 addr;
>  	u8 data;
> @@ -88,16 +82,6 @@ struct sdhci_cdns4_phy {
>  	struct sdhci_cdns4_phy_param phy_params[];
>  };
>  
> -struct sdhci_cdns_priv {
> -	void __iomem *hrs_addr;
> -	void __iomem *ctl_addr;	/* write control */
> -	spinlock_t wrlock;	/* write lock */
> -	bool enhanced_strobe;
> -	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> -	struct reset_control *rst_hw;
> -	struct sdhci_cdns4_phy *phy;
> -};
> -
>  struct sdhci_cdns4_phy_cfg {
>  	const char *property;
>  	u8 addr;
> @@ -203,13 +187,6 @@ static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>  	return 0;
>  }
>  
> -static void *sdhci_cdns_priv(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -
> -	return sdhci_pltfm_priv(pltfm_host);
> -}
> -
>  static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  {
>  	/*
> @@ -245,6 +222,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  	u32 tmp;
>  	int i, ret;
>  
> +	if (host->version >= SDHCI_SPEC_420)
> +		return sdhci_cdns6_set_tune_val(host, val);
> +
>  	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
>  		return -EINVAL;
>  
> @@ -325,8 +305,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	 * The delay is set by probe, based on the DT properties.
>  	 */
>  	if (host->timing != MMC_TIMING_MMC_HS200 &&
> -	    host->timing != MMC_TIMING_UHS_SDR104)
> +	    host->timing != MMC_TIMING_UHS_SDR104) {
> +		dev_dbg(mmc_dev(host->mmc), "Tuning skipped (timing: %d)\n", host->timing);
>  		return 0;
> +	}
>  
>  	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
>  		if (sdhci_cdns_set_tune_val(host, i) ||
> @@ -350,6 +332,10 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	if (ret)
>  		return ret;
>  
> +	/* Block gap tuning is only required for SD4HC, not for SD6HC */
> +	if (host->version >= SDHCI_SPEC_420)
> +		return 0;
> +
>  	return sdhci_cdns_tune_blkgap(host->mmc);
>  }
>  
> @@ -385,6 +371,10 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  	/* For SD, fall back to the default handler */
>  	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
>  		sdhci_set_uhs_signaling(host, timing);
> +
> +	/* For host controller V6, set SDHCI and PHY registers for UHS signaling */
> +	if (host->version >= SDHCI_SPEC_420)
> +		sdhci_cdns6_set_uhs_signaling(host, timing);
>  }
>  
>  /* Elba control register bits [6:3] are byte-lane enables */
> @@ -481,6 +471,16 @@ static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>  
> +static const struct sdhci_ops sdhci_cdns6_ops = {
> +	.set_clock = sdhci_set_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.hw_reset = sdhci_cdns6_hw_reset,
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns4_ops,
> @@ -508,6 +508,12 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	},
>  };
>  
> +static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns6_ops,
> +	},
> +};
> +
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -526,6 +532,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	if (mode == SDHCI_CDNS_HRS06_MODE_MMC_HS400ES && !ios->enhanced_strobe)
>  		sdhci_cdns_set_emmc_mode(priv,
>  					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
> +
> +	/* SD6HC PHY timing depends on enhanced-strobe; recompute register values */
> +	if (host->version >= SDHCI_SPEC_420)
> +		sdhci_cdns6_set_uhs_signaling(host, MMC_TIMING_MMC_HS400);

The ->hs400_enhanced_strobe() callback is used to turn enhanced
strobe on and off e.g. called by mmc_set_initial_state() to turn
it off when the timing is MMC_TIMING_LEGACY, so the mode setting
here looks wrong.

>  }
>  
>  static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
> @@ -569,6 +579,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> +	struct clk *biu_clk;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -577,6 +588,13 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> +	/* SD6HC requires a second clock, "biu", for the bus interface unit. */
> +	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
> +		biu_clk = devm_clk_get_enabled(dev, "biu");
> +		if (IS_ERR(biu_clk))
> +			return dev_err_probe(dev, PTR_ERR(biu_clk), "failed to enable biu clock\n");
> +	}
> +
>  	data = of_device_get_match_data(dev);
>  	if (!data)
>  		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
> @@ -601,30 +619,46 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  	sdhci_enable_v4_mode(host);
> -	__sdhci_read_caps(host, &version, NULL, NULL);
> -
>  	sdhci_get_of_property(pdev);
>  
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns4_phy_probe(pdev, priv);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * For SD4HC, read capabilities with fixed version override and set up
> +	 * the optional eMMC card RST_n reset control.
> +	 * For SD6HC, sdhci_add_host() will automatically read capabilities
> +	 * and version from the host controller registers.
> +	 */
> +	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
> +		__sdhci_read_caps(host, &version, NULL, NULL);
> +		ret = sdhci_cdns4_phy_probe(pdev, priv);
> +		if (ret)
> +			return ret;
>  
> -	if (host->mmc->caps & MMC_CAP_HW_RESET) {
> -		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> -		if (IS_ERR(priv->rst_hw))
> -			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> -					    "reset controller error\n");
> -		if (priv->rst_hw)
> -			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
> +		if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +			priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> +			if (IS_ERR(priv->rst_hw))
> +				return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +						    "reset controller error\n");
> +			if (priv->rst_hw)
> +				host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
> +		}
> +	} else {
> +		ret = sdhci_cdns6_phy_probe(pdev, priv);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return sdhci_add_host(host);
>  }
>  
> +/*
> + * Only the CIU clock is gated on suspend. The SD6HC "biu" clock is not
> + * toggled here as it may be a shared bus clock; a dedicated biu clock
> + * would need explicit PM gating added here.
> + */
>  static int sdhci_cdns_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -636,7 +670,11 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns4_phy_init(priv);
> +	if (host->version >= SDHCI_SPEC_420)
> +		ret = sdhci_cdns6_phy_init(priv);
> +	else
> +		ret = sdhci_cdns4_phy_init(priv);
> +
>  	if (ret)
>  		goto disable_clk;
>  
> @@ -671,6 +709,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "cdns,sd4hc",
>  		.data = &sdhci_cdns4_drv_data,
>  	},
> +	{
> +		.compatible = "cdns,sd6hc",
> +		.data = &sdhci_cdns6_drv_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> new file mode 100644
> index 000000000000..2d7972948a45
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -0,0 +1,929 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PHY and host controller support for Cadence SD6HC SDHCI
> + *
> + * This file provides support for Cadence's sixth-generation SDHCI controller (SD6HC).
> + * Implements PHY initialization, DLL management, per-speed-mode timing calculations,
> + * and host controller register programming for the SD6HC integrated combo-PHY.
> + *
> + * Copyright (C) 2026 Altera Corporation
> + *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-cadence.h"
> +
> +/* IO Delay Information */
> +#define SDHCI_CDNS_HRS07		0x1c
> +#define   SDHCI_CDNS_HRS07_RW_COMPENSATE	GENMASK(20, 16)
> +#define   SDHCI_CDNS_HRS07_IDELAY_VAL		GENMASK(4, 0)
> +
> +/* PHY Control and Status */
> +#define SDHCI_CDNS_HRS09		0x24
> +#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
> +#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
> +#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
> +#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
> +#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
> +#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
> +
> +/* SDCLK start point adjustment */
> +#define SDHCI_CDNS_HRS10		0x28
> +#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
> +
> +/* eMMC Control */
> +#define SDHCI_CDNS_HRS11		0x2c
> +#define   SDHCI_CDNS_HRS11_EMMC_RST		BIT(0) /* eMMC reset */
> +
> +/* CMD/DAT output delay */
> +#define SDHCI_CDNS_HRS16		0x40
> +#define   SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY	GENMASK(31, 28)
> +#define   SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY	GENMASK(27, 24)
> +#define   SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY	GENMASK(23, 20)
> +#define   SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY	GENMASK(19, 16)
> +#define   SDHCI_CDNS_HRS16_WRDATA1_DLY		GENMASK(15, 12)
> +#define   SDHCI_CDNS_HRS16_WRDATA0_DLY		GENMASK(11, 8)
> +#define   SDHCI_CDNS_HRS16_WRCMD1_DLY		GENMASK(7, 4)
> +#define   SDHCI_CDNS_HRS16_WRCMD0_DLY		GENMASK(3, 0)
> +
> +/* PHY Special Function Registers */
> +/* DQ timing */
> +#define SDHCI_CDNS6_PHY_DQ_TIMING_REG			0x2000
> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON		BIT(31)
> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END			GENMASK(29, 27)
> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START		GENMASK(26, 24)
> +#define   SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END		GENMASK(2, 0)
> +
> +/* DQS timing */
> +#define SDHCI_CDNS6_PHY_DQS_TIMING_REG			0x2004
> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS		BIT(22)
> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS		BIT(21)
> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS		BIT(20)
> +#define   SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD		BIT(19)
> +
> +/* Gate and loopback control */
> +#define SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG		0x2008
> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD		BIT(31)
> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL		GENMASK(24, 19)
> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS	BIT(18)
> +#define   SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON	BIT(6)
> +
> +/* Master DLL logic */
> +#define SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG		0x200c
> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE		BIT(23)
> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL	GENMASK(22, 20)
> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM		GENMASK(18, 16)
> +#define   SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT	GENMASK(7, 0)
> +
> +/* Slave DLL logic */
> +#define SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG		0x2010
> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY	GENMASK(31, 24)
> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY	GENMASK(23, 16)
> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY		GENMASK(15, 8)
> +#define   SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY		GENMASK(7, 0)
> +
> +/* Global control settings */
> +#define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
> +#define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
> +
> +/* Default PHY settings */
> +#define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
> +#define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
> +#define SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL		52
> +#define SDHCI_CDNS6_PHY_DEFAULT_DLL_START		4
> +#define SDHCI_CDNS6_PHY_DEFAULT_PHASE_DETECT_SEL	2
> +#define SDHCI_CDNS6_PHY_DEFAULT_DLL_LOCK_NUM		0
> +#define SDHCI_CDNS6_PHY_DEFAULT_DATA_SELECT_OE_END	1
> +
> +/* Scale tuning tap (0..39) to 8-bit PHY DLL delay field (0..255) */
> +#define SDHCI_CDNS6_PHY_DLL_FIELD_SIZE		256
> +
> +struct sdhci_cdns6_phy {
> +	/*
> +	 * Mode-specific timing constraints (in picoseconds)
> +	 * These define valid output windows per SD/eMMC spec
> +	 */
> +	u32 t_cmd_output_min;
> +	u32 t_cmd_output_max;
> +	u32 t_dat_output_min;
> +	u32 t_dat_output_max;
> +
> +	/*
> +	 * PHY delay configuration (in picoseconds)
> +	 * Derived from clock period and board-level IO cell delays
> +	 */
> +	u32 phy_sdclk_delay;
> +	u32 phy_cmd_o_delay;
> +	u32 phy_dat_o_delay;
> +	u32 iocell_input_delay;
> +	u32 iocell_output_delay;
> +	/* Configured delay element (ps); preserved across clock changes */
> +	u32 delay_element_org;
> +	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
> +	u32 delay_element;
> +
> +	/* PHY_DLL_SLAVE_CTRL register fields */
> +	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
> +	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
> +	u8 cp_clk_wr_delay;		/* bits [15:8] */
> +	u8 cp_read_dqs_delay;		/* bits [7:0] */
> +
> +	/* PHY_DLL_MASTER_CTRL register fields */
> +	bool cp_dll_bypass_mode;	/* bit [23] */
> +
> +	/* PHY_DQ_TIMING register fields */
> +	u8 cp_io_mask_end;		/* bits [29:27] */
> +	u8 cp_io_mask_start;		/* bits [26:24] */
> +
> +	/* PHY_DQS_TIMING register fields */
> +	bool cp_use_phony_dqs;		/* bit [20] */
> +	bool cp_use_phony_dqs_cmd;	/* bit [19] */
> +
> +	/* HRS07 register - IO delay Information */
> +	u8 sdhc_rw_compensate;		/* bits [20:16] */
> +	u8 sdhc_idelay_val;		/* bits [4:0] */
> +
> +	/* HRS09 register - PHY control and Status */
> +	bool sdhc_extended_wr_mode;	/* bit [3] */
> +	bool sdhc_extended_rd_mode;	/* bit [2] */
> +
> +	/* HRS10 register - SDCLK start point adjustment */
> +	u8 sdhc_hcsdclkadj;		/* bits [19:16] */
> +
> +	/* HRS16 register fields - CMD/DAT output delay control */
> +	u8 sdhc_wrdata1_sdclk_dly;	/* bits [31:28] */
> +	u8 sdhc_wrdata0_sdclk_dly;	/* bits [27:24] */
> +	u8 sdhc_wrcmd1_sdclk_dly;	/* bits [23:20] */
> +	u8 sdhc_wrcmd0_sdclk_dly;	/* bits [19:16] */
> +	u8 sdhc_wrdata1_dly;		/* bits [15:12] */
> +	u8 sdhc_wrdata0_dly;		/* bits [11:8] */
> +	u8 sdhc_wrcmd1_dly;		/* bits [7:4] */
> +	u8 sdhc_wrcmd0_dly;		/* bits [3:0] */
> +
> +	/* DLL calculation intermediate values, used during PHY timing calculations */
> +	u32 t_sdmclk_calc;	/* DLL-quantized SDMCLK period */
> +	u32 dll_max_value;	/* DLL delay field ceiling */
> +
> +	/* Tuning value for HS200/HS400 modes */
> +	u8 hs200_tune_val;
> +
> +	/* Clock periods (in picoseconds) */
> +	u32 t_sdmclk;		/* Master clock period */
> +	u32 t_sdclk;		/* SD card clock period */
> +
> +	/* Current operating state */
> +	bool strobe_cmd;	/* Enhanced strobe for CMD line */
> +	unsigned int mode;	/* Current MMC_TIMING_* mode */
> +};
> +
> +/**
> + * init_ds() - Initialize PHY timing for Default Speed mode (25 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_ds(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 5000;
> +	phy->t_cmd_output_max = t_sdclk - 5000;
> +	phy->t_dat_output_min = 5000;
> +	phy->t_dat_output_max = t_sdclk - 5000;
> +}
> +
> +/**
> + * init_hs() - Initialize PHY timing for High Speed mode (50 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_hs(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 2000;
> +	phy->t_cmd_output_max = t_sdclk - 6000;
> +	phy->t_dat_output_min = 2000;
> +	phy->t_dat_output_max = t_sdclk - 6000;
> +}
> +
> +/**
> + * init_uhs_sdr12() - Initialize PHY timing for UHS SDR12 mode (25 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_uhs_sdr12(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 3000;
> +}
> +
> +/**
> + * init_uhs_sdr25() - Initialize PHY timing for UHS SDR25 mode (50 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_uhs_sdr25(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 3000;
> +}
> +
> +/**
> + * init_uhs_sdr50() - Initialize PHY timing for UHS SDR50 mode (100 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_uhs_sdr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 3000;
> +}
> +
> +/**
> + * init_uhs_sdr104() - Initialize PHY timing for UHS SDR104 mode (200 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_uhs_sdr104(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 1400;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 1400;
> +}
> +
> +/**
> + * init_uhs_ddr50() - Initialize PHY timing for UHS DDR50 mode (50 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_uhs_ddr50(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 3000;
> +}
> +
> +/**
> + * init_emmc_sdr() - Initialize PHY timing for eMMC legacy/SDR mode.
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_emmc_sdr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 3000;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 3000;
> +	phy->t_dat_output_max = t_sdclk - 3000;
> +}
> +
> +/**
> + * init_emmc_ddr() - Initialize PHY timing for eMMC DDR52 mode.
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_emmc_ddr(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 3000;
> +	phy->t_cmd_output_max = t_sdclk - 3000;
> +	phy->t_dat_output_min = 2500;
> +	phy->t_dat_output_max = t_sdclk - 2500;
> +}
> +
> +/**
> + * init_emmc_hs200() - Initialize PHY timing for eMMC HS200 mode (200 MHz).
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_emmc_hs200(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 1400;
> +	phy->t_dat_output_min = 800;
> +	phy->t_dat_output_max = t_sdclk - 1400;
> +}
> +
> +/**
> + * init_emmc_hs400() - Initialize PHY timing for eMMC HS400/HS400ES mode.
> + * @phy: Pointer to SD6HC PHY state.
> + * @t_sdclk: SD clock period in picoseconds.
> + */
> +static void init_emmc_hs400(struct sdhci_cdns6_phy *phy, u32 t_sdclk)
> +{
> +	phy->t_cmd_output_min = 800;
> +	phy->t_cmd_output_max = t_sdclk - 1400;
> +	phy->t_dat_output_min = 400;
> +	phy->t_dat_output_max = t_sdclk - 400;
> +}
> +
> +/*
> + * init_timings - PHY timing initializers indexed by MMC_TIMING_* value.
> + *
> + * Each entry corresponds to a MMC_TIMING_* constant and sets the appropriate cmd/dat
> + * output timing windows in the PHY state struct.
> + */
> +static void (* const init_timings[])(struct sdhci_cdns6_phy *, u32) = {
> +	[MMC_TIMING_LEGACY]     = init_ds,
> +	[MMC_TIMING_MMC_HS]     = init_emmc_sdr,
> +	[MMC_TIMING_SD_HS]      = init_hs,
> +	[MMC_TIMING_UHS_SDR12]  = init_uhs_sdr12,
> +	[MMC_TIMING_UHS_SDR25]  = init_uhs_sdr25,
> +	[MMC_TIMING_UHS_SDR50]  = init_uhs_sdr50,
> +	[MMC_TIMING_UHS_SDR104] = init_uhs_sdr104,
> +	[MMC_TIMING_UHS_DDR50]  = init_uhs_ddr50,
> +	[MMC_TIMING_MMC_DDR52]  = init_emmc_ddr,
> +	[MMC_TIMING_MMC_HS200]  = init_emmc_hs200,
> +	[MMC_TIMING_MMC_HS400]  = init_emmc_hs400,
> +};
> +
> +static unsigned int sdhci_cdns6_read_phy_reg(struct sdhci_cdns_priv *priv, const u32 address)
> +{
> +	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
> +	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
> +}
> +
> +static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_priv *priv, const u32 address,
> +				      const u32 value)
> +{
> +	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
> +	writel(value, priv->hrs_addr + SDHCI_CDNS_HRS05);
> +}
> +
> +static int sdhci_cdns6_phy_lock_dll(struct sdhci_cdns6_phy *phy)
> +{
> +	u32 delay_element = phy->delay_element_org;
> +	u32 delay_elements_in_sdmclk;
> +
> +	delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
> +	if (delay_elements_in_sdmclk > 256) {
> +		delay_element *= 2;
> +		delay_elements_in_sdmclk = DIV_ROUND_UP(phy->t_sdmclk, delay_element);
> +
> +		if (delay_elements_in_sdmclk > 256)
> +			return -EINVAL;
> +
> +		phy->dll_max_value = 127;
> +	} else {
> +		phy->dll_max_value = 255;
> +	}
> +
> +	phy->t_sdmclk_calc = delay_element * delay_elements_in_sdmclk;
> +	phy->delay_element = delay_element;
> +	phy->cp_dll_bypass_mode = false;
> +
> +	return 0;
> +}
> +
> +static void sdhci_cdns6_phy_dll_bypass(struct sdhci_cdns6_phy *phy)
> +{
> +	phy->dll_max_value = 256;
> +	phy->cp_dll_bypass_mode = true;
> +}
> +
> +static void sdhci_cdns6_phy_configure_dll(struct sdhci_cdns6_phy *phy)
> +{
> +	if (!phy->sdhc_extended_wr_mode) {
> +		if (sdhci_cdns6_phy_lock_dll(phy) == 0)
> +			return;
> +	}
> +	sdhci_cdns6_phy_dll_bypass(phy);
> +}
> +
> +static void sdhci_cdns6_phy_calc_out(struct sdhci_cdns6_phy *phy, bool cmd_not_dat)
> +{
> +	u32 wr0_dly = 0, wr1_dly = 0, output_min, output_max, phy_o_delay,
> +	    clk_wr_delay = 0, wr0_sdclk_dly = 0, wr1_sdclk_dly = 0;
> +	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50) || (phy->mode == MMC_TIMING_MMC_DDR52) ||
> +		   (phy->mode == MMC_TIMING_MMC_HS400);
> +	bool data_ddr = ddr && !cmd_not_dat;
> +	int t;
> +
> +	if (cmd_not_dat) {
> +		output_min = phy->t_cmd_output_min;
> +		output_max = phy->t_cmd_output_max;
> +		phy_o_delay = phy->phy_cmd_o_delay;
> +	} else {
> +		output_min = phy->t_dat_output_min;
> +		output_max = phy->t_dat_output_max;
> +		phy_o_delay = phy->phy_dat_o_delay;
> +	}
> +
> +	if (data_ddr) {
> +		wr0_sdclk_dly = 1;
> +		wr1_sdclk_dly = 1;
> +	}
> +
> +	t = phy_o_delay - phy->phy_sdclk_delay - output_min;
> +	if (t < 0 && phy->sdhc_extended_wr_mode) {
> +		u32 n_half_cycle = DIV_ROUND_UP(-t * 2, phy->t_sdmclk);
> +
> +		wr0_dly = (n_half_cycle + 1) / 2;
> +		if (data_ddr)
> +			wr1_dly = (n_half_cycle + 1) / 2;
> +		else
> +			wr1_dly = (n_half_cycle + 1) % 2 + wr0_dly - 1;
> +	}
> +
> +	if (!phy->sdhc_extended_wr_mode) {
> +		u32 out_hold, out_setup, out_hold_margin;
> +		u32 n;
> +
> +		if (!data_ddr)
> +			wr0_dly = 1;
> +
> +		out_setup = output_max;
> +		out_hold = output_min;
> +		out_hold_margin = DIV_ROUND_UP(out_setup - out_hold, 4);
> +		out_hold += out_hold_margin;
> +
> +		if (!phy->cp_dll_bypass_mode)
> +			n = DIV_ROUND_UP(256 * out_hold, phy->t_sdmclk_calc);
> +		else
> +			n = DIV_ROUND_UP(out_hold, phy->delay_element) - 1;
> +
> +		if (n <= phy->dll_max_value)
> +			clk_wr_delay = n;
> +		else
> +			clk_wr_delay = 255;
> +	} else {
> +		/* sdhc_extended_wr_mode set => PHY IO cell work in SDR mode */
> +		clk_wr_delay = 0;
> +	}
> +
> +	if (cmd_not_dat) {
> +		phy->sdhc_wrcmd0_dly = wr0_dly;
> +		phy->sdhc_wrcmd1_dly = wr1_dly;
> +		phy->cp_clk_wrdqs_delay = clk_wr_delay;
> +		phy->sdhc_wrcmd0_sdclk_dly = wr0_sdclk_dly;
> +		phy->sdhc_wrcmd1_sdclk_dly = wr1_sdclk_dly;
> +	} else {
> +		phy->sdhc_wrdata0_dly = wr0_dly;
> +		phy->sdhc_wrdata1_dly = wr1_dly;
> +		phy->cp_clk_wr_delay = clk_wr_delay;
> +		phy->sdhc_wrdata0_sdclk_dly = wr0_sdclk_dly;
> +		phy->sdhc_wrdata1_sdclk_dly = wr1_sdclk_dly;
> +	}
> +}
> +
> +static void sdhci_cdns6_phy_calc_cmd_out(struct sdhci_cdns6_phy *phy)
> +{
> +	sdhci_cdns6_phy_calc_out(phy, true);
> +}
> +
> +static void sdhci_cdns6_phy_calc_cmd_in(struct sdhci_cdns6_phy *phy)
> +{
> +	phy->cp_io_mask_end = ((phy->iocell_output_delay + phy->iocell_input_delay) * 2) /
> +				phy->t_sdmclk;
> +
> +	/* cp_io_mask_end is a 3-bit field, clamp to max value of 7 */
> +	phy->cp_io_mask_end = min_t(u8, phy->cp_io_mask_end, 7);
> +
> +	if (phy->strobe_cmd && phy->cp_io_mask_end > 0)
> +		phy->cp_io_mask_end--;
> +
> +	if (phy->strobe_cmd) {
> +		phy->cp_use_phony_dqs_cmd = false;
> +		phy->cp_read_dqs_cmd_delay = 64;
> +	} else {
> +		phy->cp_use_phony_dqs_cmd = true;
> +		phy->cp_read_dqs_cmd_delay = 0;
> +	}
> +
> +	if ((phy->mode == MMC_TIMING_MMC_HS400 && !phy->strobe_cmd) ||
> +	    phy->mode == MMC_TIMING_MMC_HS200)
> +		phy->cp_read_dqs_cmd_delay = phy->hs200_tune_val;
> +}
> +
> +static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
> +{
> +	u32 hcsdclkadj = 0;
> +	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
> +
> +	if (strobe_dat) {
> +		phy->cp_use_phony_dqs = false;
> +		phy->cp_read_dqs_delay = 64;
> +	} else {
> +		phy->cp_use_phony_dqs = true;
> +		phy->cp_read_dqs_delay = 0;
> +	}
> +
> +	if (phy->mode == MMC_TIMING_MMC_HS200)
> +		phy->cp_read_dqs_delay = phy->hs200_tune_val;
> +
> +	if (strobe_dat) {
> +		/* dqs loopback input via IO cell */
> +		hcsdclkadj += phy->iocell_input_delay;
> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod; delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->delay_element / 2;
> +		/* delay line */
> +		hcsdclkadj += phy->t_sdclk / 2;
> +		/* PHY FIFO write pointer */
> +		hcsdclkadj += phy->t_sdclk / 2 + phy->delay_element;
> +		/* 1st synchronizer */
> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk) * phy->t_sdmclk - hcsdclkadj;
> +		/*
> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata
> +		 * + PHY rddata registered, + FIFO 1st ciu_en
> +		 */
> +		hcsdclkadj += 5 * phy->t_sdmclk;
> +		/* FIFO 2nd ciu_en */
> +		hcsdclkadj += phy->t_sdclk;
> +		hcsdclkadj /= phy->t_sdclk;
> +	} else {
> +		u32 n;
> +
> +		/* rebar PHY delay */
> +		hcsdclkadj += 2 * phy->t_sdmclk;
> +		/* rebar output via IO cell */
> +		hcsdclkadj += phy->iocell_output_delay;
> +		/* dqs loopback input via IO cell */
> +		hcsdclkadj += phy->iocell_input_delay;
> +		/* dfi_dqs_in: mem_dqs -> clean_dqs_mod delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->delay_element / 2;
> +		/* dll: one delay element between SIGI_0 and SIGO_0 */
> +		hcsdclkadj += phy->delay_element;
> +		/* dfi_dqs_in: mem_dqs_delayed -> clk_dqs delay of hic_dll_dqs_nand2 */
> +		hcsdclkadj += phy->delay_element / 2;
> +		/* deskew DLL: clk_dqs -> clk_dqN: one delay element */
> +		hcsdclkadj += phy->delay_element;
> +
> +		if (phy->t_sdclk == phy->t_sdmclk)
> +			n = (hcsdclkadj - 2 * phy->t_sdmclk) / phy->t_sdclk;
> +		else
> +			n = hcsdclkadj / phy->t_sdclk;
> +
> +		/* phase shift within one t_sdclk clock cycle caused by rebar - lbk dqs delay */
> +		hcsdclkadj = hcsdclkadj % phy->t_sdclk;
> +		/* PHY FIFO write pointer */
> +		hcsdclkadj += phy->t_sdclk / 2;
> +		/* 1st synchronizer */
> +		hcsdclkadj += DIV_ROUND_UP(hcsdclkadj, phy->t_sdmclk) * phy->t_sdmclk - hcsdclkadj;
> +		/*
> +		 * 2nd synchronizer + PHY FIFO read pointer + PHY rddata + PHY rddata registered
> +		 */
> +		hcsdclkadj += 4 * phy->t_sdmclk;
> +
> +		if ((phy->t_sdclk / phy->t_sdmclk) > 1) {
> +			u32 tmp1, tmp2;
> +
> +			tmp1 = hcsdclkadj;
> +			tmp2 = (hcsdclkadj / phy->t_sdclk) * phy->t_sdclk + phy->t_sdclk -
> +				phy->t_sdmclk;
> +			if (tmp1 == tmp2)
> +				tmp2 += phy->t_sdclk;
> +
> +			/* FIFO aligns to clock cycle before ciu_en */
> +			hcsdclkadj += tmp2 - tmp1;
> +		}
> +
> +		/* FIFO 1st ciu_en */
> +		hcsdclkadj += phy->t_sdmclk;
> +		/* FIFO 2nd ciu_en */
> +		hcsdclkadj += phy->t_sdclk;
> +		hcsdclkadj /= phy->t_sdclk;
> +		hcsdclkadj += n;
> +
> +		if ((phy->t_sdclk / phy->t_sdmclk) >= 2) {
> +			if (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52)
> +				hcsdclkadj -= 2;
> +			else
> +				hcsdclkadj -= 1;
> +		} else if ((phy->t_sdclk / phy->t_sdmclk) == 1) {
> +			hcsdclkadj += 2;
> +		}
> +
> +		if (phy->mode == MMC_TIMING_UHS_SDR104 || phy->mode == MMC_TIMING_MMC_HS200)
> +			hcsdclkadj -= 1;
> +	}
> +
> +	/* hcsdclkadj is a 4-bit field, clamp to max value of 15 */
> +	if (hcsdclkadj > 15)
> +		hcsdclkadj = 15;
> +
> +	phy->sdhc_hcsdclkadj = hcsdclkadj;
> +}
> +
> +static void sdhci_cdns6_phy_calc_dat_out(struct sdhci_cdns6_phy *phy)
> +{
> +	sdhci_cdns6_phy_calc_out(phy, false);
> +}
> +
> +static void sdhci_cdns6_phy_calc_io(struct sdhci_cdns6_phy *phy)
> +{
> +	u32 rw_compensate;
> +
> +	rw_compensate = ((phy->iocell_input_delay + phy->iocell_output_delay) / phy->t_sdmclk) +
> +			  phy->sdhc_wrdata0_dly + 5 + 3;
> +
> +	phy->sdhc_idelay_val = (2 * phy->iocell_input_delay) / phy->t_sdmclk;
> +
> +	phy->cp_io_mask_start = 0;
> +	if (phy->t_sdclk == phy->t_sdmclk && rw_compensate > 10)
> +		phy->cp_io_mask_start = 2 * (rw_compensate - 10);
> +
> +	if (phy->mode == MMC_TIMING_UHS_SDR104)
> +		phy->cp_io_mask_start++;
> +
> +	if (phy->t_sdclk == phy->t_sdmclk && phy->mode == MMC_TIMING_UHS_SDR50)
> +		phy->cp_io_mask_start++;
> +
> +	/* cp_io_mask_start is a 3-bit field, clamp to max value of 7 */
> +	phy->cp_io_mask_start = min_t(u8, phy->cp_io_mask_start, 7);
> +
> +	phy->sdhc_rw_compensate = rw_compensate;
> +}
> +
> +static void sdhci_cdns6_phy_calc_settings(struct sdhci_cdns6_phy *phy)
> +{
> +	sdhci_cdns6_phy_calc_cmd_out(phy);
> +	sdhci_cdns6_phy_calc_cmd_in(phy);
> +	sdhci_cdns6_phy_calc_dat_out(phy);
> +	sdhci_cdns6_phy_calc_dat_in(phy);
> +	sdhci_cdns6_phy_calc_io(phy);
> +}
> +
> +static int sdhci_cdns6_dll_reset(struct sdhci_cdns_priv *priv, bool reset)
> +{
> +	u32 reg;
> +	int ret = 0;
> +
> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
> +	if (reset)
> +		reg &= ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
> +	else
> +		reg |= SDHCI_CDNS_HRS09_PHY_SW_RESET;
> +
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
> +
> +	/* After releasing PHY from reset, wait until PHY_INIT_COMPLETE is set within 3000us */
> +	if (!reset) {
> +		ret = readl_poll_timeout(priv->hrs_addr + SDHCI_CDNS_HRS09, reg, (reg &
> +					 SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE), 0, 3000);
> +	}
> +
> +	return ret;
> +}
> +
> +int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
> +{
> +	struct sdhci_cdns6_phy *phy = priv->phy;
> +	u32 reg;
> +	int ret;
> +
> +	sdhci_cdns6_dll_reset(priv, true);
> +
> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
> +	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
> +	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
> +
> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL;
> +	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_UNDERRUN_SUPPRESS;
> +	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON;
> +	reg |= SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_SYNC_METHOD;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_RD_DEL_SEL,
> +			  SDHCI_CDNS6_PHY_DEFAULT_RD_DEL_SEL);
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_GATE_LPBK_CTRL_REG, reg);
> +
> +	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_BYPASS_MODE, phy->cp_dll_bypass_mode);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_PHASE_DETECT_SEL,
> +			  SDHCI_CDNS6_PHY_DEFAULT_PHASE_DETECT_SEL);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_LOCK_NUM,
> +			  SDHCI_CDNS6_PHY_DEFAULT_DLL_LOCK_NUM);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_DLL_START_POINT,
> +			  SDHCI_CDNS6_PHY_DEFAULT_DLL_START);
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_MASTER_CTRL_REG, reg);
> +
> +	reg = FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_CMD_DELAY,
> +			 phy->cp_read_dqs_cmd_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WRDQS_DELAY, phy->cp_clk_wrdqs_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_CLK_WR_DELAY, phy->cp_clk_wr_delay);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY, phy->cp_read_dqs_delay);
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_REG, reg);
> +
> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
> +
> +	/*
> +	 * Ensure all preceding PHY register writes complete and reach the controller before
> +	 * releasing the PHY from reset. Without this, SDR104 has been observed to fail
> +	 * intermittently on some boards.
> +	 */
> +	wmb();
> +
> +	ret = sdhci_cdns6_dll_reset(priv, false);
> +	if (ret)
> +		return ret;
> +
> +	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_ALWAYS_ON;
> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END;
> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START;
> +	reg &= ~SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_END, phy->cp_io_mask_end);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_IO_MASK_START, phy->cp_io_mask_start);
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQ_TIMING_DATA_SELECT_OE_END,
> +			  SDHCI_CDNS6_PHY_DEFAULT_DATA_SELECT_OE_END);
> +	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQ_TIMING_REG, reg);
> +
> +	/* Ensure DQ timing programming is visible before HRS09 follow-up writes */
> +	wmb();
> +
> +	reg = readl(priv->hrs_addr + SDHCI_CDNS_HRS09);
> +	if (phy->sdhc_extended_wr_mode)
> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_WR_MODE;
> +
> +	if (phy->sdhc_extended_rd_mode)
> +		reg |= SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
> +	else
> +		reg &= ~SDHCI_CDNS_HRS09_EXTENDED_RD_MODE;
> +
> +	reg |= SDHCI_CDNS_HRS09_RDDATA_EN;
> +	reg |= SDHCI_CDNS_HRS09_RDCMD_EN;
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS09);
> +
> +	reg = FIELD_PREP(SDHCI_CDNS_HRS10_HCSDCLKADJ, phy->sdhc_hcsdclkadj);
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS10);
> +
> +	reg = FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY, phy->sdhc_wrdata1_sdclk_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY, phy->sdhc_wrdata0_sdclk_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY, phy->sdhc_wrcmd1_sdclk_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY, phy->sdhc_wrcmd0_sdclk_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA1_DLY, phy->sdhc_wrdata1_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRDATA0_DLY, phy->sdhc_wrdata0_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD1_DLY, phy->sdhc_wrcmd1_dly);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS16_WRCMD0_DLY, phy->sdhc_wrcmd0_dly);
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS16);
> +
> +	reg = FIELD_PREP(SDHCI_CDNS_HRS07_RW_COMPENSATE, phy->sdhc_rw_compensate);
> +	reg |= FIELD_PREP(SDHCI_CDNS_HRS07_IDELAY_VAL, phy->sdhc_idelay_val);
> +	writel(reg, priv->hrs_addr + SDHCI_CDNS_HRS07);
> +
> +	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */
> +	usleep_range(5000, 5500);
> +
> +	return 0;
> +}
> +
> +int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns6_phy *phy = priv->phy;
> +	u32 tuneval;
> +
> +	/*
> +	 * Scale tuning tap (val in [0, SDHCI_CDNS_MAX_TUNING_LOOP-1]) to the
> +	 * 8-bit PHY DLL slave delay field [0, 255]. With MAX_TUNING_LOOP=40
> +	 * and FIELD_SIZE=256, the result fits in 8 bits.
> +	 *
> +	 * Updating the DLL slave delays also requires a PHY DLL reset cycle,
> +	 * so reuse the full phy_init() sequence rather than a register poke.
> +	 */
> +	tuneval = (val * SDHCI_CDNS6_PHY_DLL_FIELD_SIZE) / SDHCI_CDNS_MAX_TUNING_LOOP;
> +
> +	phy->hs200_tune_val = tuneval;
> +	phy->cp_read_dqs_cmd_delay = tuneval;
> +	phy->cp_read_dqs_delay = tuneval;
> +
> +	return sdhci_cdns6_phy_init(priv);
> +}
> +
> +static int sdhci_cdns6_phy_update_timings(struct sdhci_host *host)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns6_phy *phy = priv->phy;
> +	u32 t_sdmclk = phy->t_sdmclk;
> +
> +	/* Validate mode is within supported range */
> +	if (phy->mode >= ARRAY_SIZE(init_timings))
> +		return -EINVAL;
> +
> +	/* initialize input */
> +	init_timings[phy->mode](phy, phy->t_sdclk);
> +
> +	phy->strobe_cmd = false;
> +
> +	if (priv->enhanced_strobe)
> +		phy->strobe_cmd = true;
> +
> +	phy->phy_sdclk_delay = 2 * t_sdmclk;
> +
> +	/*
> +	 * CMD and DAT output delays are currently identical, but kept separate to allow
> +	 * independent tuning for specific modes (e.g., HS400) or board-specific optimizations
> +	 * in the future.
> +	 */
> +	phy->phy_cmd_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
> +	phy->phy_dat_o_delay = 2 * t_sdmclk + t_sdmclk / 2;
> +
> +	if (phy->t_sdclk == phy->t_sdmclk) {
> +		phy->sdhc_extended_wr_mode = false;
> +		phy->sdhc_extended_rd_mode = false;
> +	} else {
> +		phy->sdhc_extended_wr_mode = true;
> +		phy->sdhc_extended_rd_mode = true;
> +	}
> +
> +	sdhci_cdns6_phy_configure_dll(phy);
> +	sdhci_cdns6_phy_calc_settings(phy);
> +
> +	return 0;
> +}
> +
> +int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns6_phy *phy;
> +	unsigned long val;
> +	int ret;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	val = clk_get_rate(pltfm_host->clk);
> +	if (!val)
> +		return dev_err_probe(dev, -EINVAL, "failed to get controller clock rate\n");
> +
> +	phy->t_sdmclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, val);
> +
> +	/*
> +	 * Optional board-level PHY timing properties. When omitted, use the
> +	 * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps DLL
> +	 * delay element) that are valid for typical SoC packaging.
> +	 */
> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-ps",
> +				   &phy->iocell_input_delay);
> +	if (ret)
> +		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-ps",
> +				   &phy->iocell_output_delay);
> +	if (ret)
> +		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
> +
> +	ret = of_property_read_u32(dev->of_node, "cdns,delay-element-ps", &phy->delay_element);
> +	if (ret)
> +		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
> +
> +	phy->delay_element_org = phy->delay_element;
> +
> +	priv->phy = phy;
> +
> +	return 0;
> +}
> +
> +void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns6_phy *phy = priv->phy;
> +	int ret;
> +
> +	/* Clock may be 0 during initial ios setup; skip PHY update */
> +	if (!host->mmc->ios.clock)
> +		return;
> +
> +	phy->t_sdclk = DIV_ROUND_DOWN_ULL(1000000000000ULL, host->mmc->ios.clock);

Sashiko questioned this: Isn't mmc->actual_clock here better than host->mmc->ios.clock?
Refer:
	https://sashiko.dev/#/patchset/20260724150039.23387-1-tanmay.kathpalia%40altera.com

> +	phy->mode = timing;
> +
> +	ret = sdhci_cdns6_phy_update_timings(host);
> +	if (ret) {
> +		dev_warn(mmc_dev(host->mmc), "%s: update timings failed: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	ret = sdhci_cdns6_phy_init(priv);
> +	if (ret)
> +		dev_warn(mmc_dev(host->mmc), "%s: phy init failed: %d\n", __func__, ret);
> +}
> +
> +void sdhci_cdns6_hw_reset(struct sdhci_host *host)
> +{
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	void __iomem *reg;
> +
> +	reg = priv->hrs_addr + SDHCI_CDNS_HRS11;
> +	writel(SDHCI_CDNS_HRS11_EMMC_RST, reg);
> +	/* eMMC HW reset assertion: spec requires >= 1us, give margin */
> +	usleep_range(10, 20);
> +	writel(0, reg);
> +	/* For eMMC, minimum is 200us but give it 300us for good measure */
> +	usleep_range(300, 1000);
> +}
> diff --git a/drivers/mmc/host/sdhci-cadence.h b/drivers/mmc/host/sdhci-cadence.h
> new file mode 100644
> index 000000000000..9affd9f4ede8
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-cadence.h
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 Altera Corporation
> + *   Author: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> + *
> + * Cadence SD/SDIO/eMMC Host Controller driver - common header
> + * Shared definitions and structures for the Cadence SDHCI driver.
> + * Contains private data and declarations for SD6HC-specific functions
> + * called by the main driver in sdhci-cadence-core.c.
> + */
> +
> +#ifndef _MMC_HOST_SDHCI_CADENCE_H
> +#define _MMC_HOST_SDHCI_CADENCE_H
> +
> +#include <linux/compiler.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +struct reset_control;
> +
> +/* HRS - Host Register Set (specific to Cadence) */
> +#define SDHCI_CDNS_HRS04		0x10		/* PHY access: address port */
> +#define SDHCI_CDNS_HRS05		0x14		/* PHY access: data port */
> +
> +/*
> + * The tuned val register is 6 bit-wide, but not the whole of the range is
> + * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
> + * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
> + */
> +#define SDHCI_CDNS_MAX_TUNING_LOOP	40
> +
> +/**
> + * struct sdhci_cdns_priv - Cadence SDHCI private controller data
> + * @hrs_addr: Base address of Cadence Host Register Set (HRS) registers.
> + * @ctl_addr: Base address for write control registers.
> + *            Used only for "amd,pensando-elba-sd4hc" compatible controllers to enable
> + *            byte-lane writes.
> + * @wrlock: Spinlock for protecting register writes (Elba only).
> + * @enhanced_strobe: Flag indicating if Enhanced Strobe (HS400ES) is enabled.
> + * @priv_writel: Optional SoC-specific write function for register access.
> + *               Used for Elba to ensure correct byte-lane enable.
> + * @rst_hw: Hardware reset control for the eMMC card RST_n pin (SD4HC only).
> + * @phy: Opaque pointer to variant-specific PHY data.
> + *       For SD4HC: points to struct sdhci_cdns4_phy.
> + *       For SD6HC: points to struct sdhci_cdns6_phy.
> + */
> +struct sdhci_cdns_priv {
> +	void __iomem *hrs_addr;
> +	void __iomem *ctl_addr;	/* write control */
> +	spinlock_t wrlock;	/* write lock */
> +	bool enhanced_strobe;
> +	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> +	struct reset_control *rst_hw;
> +	void *phy;
> +};
> +
> +/**
> + * sdhci_cdns_priv - Helper to retrieve Cadence private data from sdhci_host
> + * @host: Pointer to struct sdhci_host.
> + *
> + * Return: Pointer to struct sdhci_cdns_priv.
> + */
> +static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return sdhci_pltfm_priv(pltfm_host);
> +}
> +
> +/**
> + * sdhci_cdns6_set_uhs_signaling - Program PHY registers for a specific timing mode.
> + * @host: Pointer to struct sdhci_host.
> + * @timing: MMC timing mode (MMC_TIMING_*).
> + */
> +void sdhci_cdns6_set_uhs_signaling(struct sdhci_host *host, unsigned int timing);
> +
> +/**
> + * sdhci_cdns6_set_tune_val - Set the PHY tuning value.
> + * @host: Pointer to struct sdhci_host.
> + * @val: Tuning value to program.
> + *
> + * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
> + */
> +int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val);
> +
> +/**
> + * sdhci_cdns6_phy_probe - Probe and initialize Cadence SD6HC PHY parameters
> + * @pdev: Platform device pointer
> + * @priv: Pointer to Cadence private data structure
> + *
> + * Return: 0 on success or a negative error code.
> + */
> +int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *priv);
> +
> +/**
> + * sdhci_cdns6_hw_reset - Perform hardware reset of the Cadence SDHCI controller.
> + * @host: Pointer to struct sdhci_host.
> + */
> +void sdhci_cdns6_hw_reset(struct sdhci_host *host);
> +
> +/**
> + * sdhci_cdns6_phy_init - Initialize the SD6HC PHY with current settings.
> + * @priv: Pointer to Cadence private data structure.
> + *
> + * Return: 0 on success, -ETIMEDOUT if PHY initialization times out.
> + */
> +int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv);
> +
> +#endif /* _MMC_HOST_SDHCI_CADENCE_H */

