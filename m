Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E032D9ECB;
	Mon, 23 Mar 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276778; cv=fail; b=uNMejxhs/qEWyS5Foe+RC+XASvgSlbW6yFxI2JDZSpdWUbS+Iyr3bMiw79rENoKwjt9z/vIyVFwiVFWtKZFzK+LK9+07eqP/ZimqHU8m6AxCubKeRAIuWPPaFlfbD5XVukaxc+Us7OoZAY4r5suhvA6l8kRd8Hsww+BJW1PTZjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276778; c=relaxed/simple;
	bh=4GLm8addlzrS56qRv1OSxIZjqdkqSZ2v/aEZK7lrz9w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TEg0s02OLSa9GFZQivRENGkQ/Alzo9EbMmhP/v73IFLVG/ZDn2S5ctCt4E/YaHNYV9TqunStaR7pdMaZYpvU1X5Xdsjty1bGiyC5M8XsBZ9gS6LLDJiCPSEAmWMmdfrBnzKUsh1J8W6BiT3Frn5g2I/iprTbzd31p6ihm0FJAN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpCfUd7j; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpCfUd7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774276776; x=1805812776;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=4GLm8addlzrS56qRv1OSxIZjqdkqSZ2v/aEZK7lrz9w=;
  b=KpCfUd7jp4KSEhCX8l7YayKbYPrqzntv94c4jmOnxfkbwZK6+PQ7qtxy
   V81gMeNTLSxKUYfh/4yzX78lrdd/6X/BRkF0FmMAqNYndQcYmLc5bwRXt
   lqfyNPx3rDKmzkjAchjn4zyrcQtULFSEzXR22d7jLu2zsTj4Sb3iGqVwR
   j2yEXoLoqCvtlcK9wWKYUi/tnA+RQDc1xTqikFT8M0/qikc/1nTsRhskd
   vIEuKolEn13M+fAsMUUU/2YANDoykDFFyddxPFPRndpGOLishGaAZiDYj
   kYz1tvFQVQW62yrEiB2DEo8L306e/IAXkK72F2fuCuCNiEdEhmRdW0llK
   A==;
X-CSE-ConnectionGUID: FJtKcMY+SciTHgT8KXsdLA==
X-CSE-MsgGUID: cliMHCboQKGV/jT6WF+tRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86349341"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="86349341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 07:39:36 -0700
X-CSE-ConnectionGUID: 6nX+ovJJRy6eaOVmF67Vkw==
X-CSE-MsgGUID: ErmpkWtySte3R9YUvLhHuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228121036"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 07:39:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 07:39:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 07:39:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 07:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL0+RRMJFxi2M8XHTjK8Y0p41ZZXDUFOcrhF6YuPTiBmrOoxXBldBhcJXfZPBWxw2/p750wym7P6xvLPeEKuuaYiFE3EyRa3GrV6zNH+Tn5mpSnD2WYhLL6wz8WweY8dQRf9Io5xgYInAZjavKO/Od54oR3PR9upugG8kqmu1BiMGkF+4sOxFeZ/qOstjalOkIe7fzYzYdD/k13maALsyrr2xuhF9JOeJPzBV1ir8OVhiorVFO03sin4FW8bUuzFs33Blp0KpN3emvpNrcBbit0gZCIyorlDCfjYxDBnVk4ykc40skqb6ySlHngRHQLUpnKYwwh3UtboEuxQKZ+pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJbuAp0djyMIibe4xpSNH2o/GFdBM/9vzXlR+2jBVp8=;
 b=mHzfW1DN4NDBZayfBQbn9U1acQnqcvr0l32L+FwLvfbPl8yZ1JrN0RO8h3KvyXAC7UYhSVr3CGLUqCK51+l12PDEaEx9AHJux7DNdRqV/ZVrJ0AdzpgVLVBb89SzzJ7XB/ABjKJMzzwcDRTdqoN4quireMQTiXHsEV4/K8GMTAI5vCwBCaemWZiyW9MDN5h6HYF7bIq32Y+jNJCtwjPRoo+Fuq6hVQYvJfjVZR+3j8xGiOL1DBqhUy7Mq+Dcp59gWB5RP0JepRiKGaMPkNQAuru3CtzV7pLVLKcHBcBTakbV/abgZv9epGo3jXrFHUDelbsGBdU2rP6OX3TVrVUAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:39:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:39:30 +0000
Message-ID: <80f95b2b-b0fa-4cb3-9b37-c947610a4d4b@intel.com>
Date: Mon, 23 Mar 2026 16:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Drop unused include
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260320220221.3236937-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260320220221.3236937-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: ce30ecc5-3b0f-4efd-7e6f-08de88e9fda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 9sGeDPPkQ0vV1wgAbO7R7LE1buKDYF03Zl6yikEOZHXGVG9RD2cZag+VqYP4M5I1gRu1jUdrrRyj8tdf8MetuhcPGulIM9gstP6V+v8oEbktjJNqKAm2gSD5AnQylHzoVil+qs0cW0kVNiLzsWC8eV0KuCH7+sTslb+ZDJeAQV/QKNMoZpwtgxbMocQgMMOV1aoTmUvhP9bqSazbIaKP+aOwtEjyru+HflSCwb0CDlOBcUcq0nLotlQatonePtp39QpmwIbYYABE9aRO8awgtb7LR4JnNWWWzVTCZyogmd9SNhfsKFEgficjfe1TvDdY4uXdHXuyp8iJ/PZzY3RMm1F+TEGCYRmRVs4T1H8Mq5Ym6ZVMFKnUo7145sfCpLCwA088nFBSOIxYXv9bgowjVg9svGnI3xXH1Zw37GsBES4C0bOBYpGvDhZG4RhgFhAo+myyR+F/INZ/bWN5w08OnNfEASzJt8ojXJYaPYOvuN/BCV0BaHbMaQwgI2nr7nD7b5IAUXUeU7Tu7IhpVRf02DpGpRASl4Kc58a3ls0wF0DBErMvPwk8+nV7Dtym89UABY+UuanXfkqKZxM8UjHgM2VwITXY3BH07FWa9qRMW05d6zjj/uTCWlqx8HNUSj5Ll7TzjW9NpXGzh4r+f2VdN0q/fCHJO6AKodCf+c8a7DcqwKvQnYblnkgQ9NI0oTqQUo/1PhD11eYdEbKA/A76SiXp7P+B1qHO1JCpB+vPIzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhWTzZTcjhPSk0rS0hkYnpvS3NKRjlzclp5b29raDd6bWh5WDJBOHAxVFF4?=
 =?utf-8?B?K2ZJdTZNQnF0dlNRTGdaNzhRSk5wNUl0WTV2Z3ZmS0hEaVZteFJBRVhZLzdk?=
 =?utf-8?B?dXh4cU80TG1hTml2YTR2OTVOUDM1a2hrTkl4a1FOZXhhMHdBV2dydXRNaHBn?=
 =?utf-8?B?QXUrUGtDcUprVVJQbS9GckJZaUY0ZVluOVV0UC8wUThFajc3Qml3Nk1yWGd4?=
 =?utf-8?B?RElNNU1EbTU0dmhacjVuTk1xemZla0xLdnJYaXNaLzdiU28vZDZqVm1NR1Fn?=
 =?utf-8?B?VzlsRmVaMHNkaUdSSk9SdWtJVFRTL1o1UXBpdDgxMWxiQ0pnTEQyckVLRnJi?=
 =?utf-8?B?RzdMU25tcEVVR3kwQ0pJNktXbFROR1Q3TWVTWmNZdmNZTmxSZzhpRUhYcEh6?=
 =?utf-8?B?NzdVTEtEbWR2Um54RktKblRESUF0NjdDaTZsWEkxUFpPcytLNTJwbEJjaXk5?=
 =?utf-8?B?Nlg1enE4SHBwZStLWlRRZDBOd2Z1WmU5eTNBRWhXOUJTa25ya1hBMlZsaXFN?=
 =?utf-8?B?bUVhNXpDV1RYTTRlV2w0bzU5SjFBcjhBSG9IYkRheDcxSzQ4cERVL2JkMUxK?=
 =?utf-8?B?RTZISVlZME5POGtIN0hPOGRHL1NHQmF6ZHQxenV1bnFHZm96cE5zV2h3TW1C?=
 =?utf-8?B?MFJGREFqcC9tSVVuSG8xOUZqWlVOUmZPbnozS2VtVGRGTTh6SHh6RXV5K0Jh?=
 =?utf-8?B?QTE4MFQyeGRCVXVsWmRsVVRKU1JOVXFFRmFoeUd1NFMxc09qYThFN0pWWUdV?=
 =?utf-8?B?YXVnRXNnQWl2TzFPL21UeEkwMlgvREw5dko4dTZkcVN0ZytzYXE4MkdHZWY1?=
 =?utf-8?B?RXA1OWdNYWx2SEJJYmtZUStjejR3SkxNbEJaTDMzQ0w5clZTZVZnekxYL0gr?=
 =?utf-8?B?QUhiOVRMbnJ6V1NtTHMwRG44aXd0ZVRNVGhzZ0J3YklLV0JmcGVsdWtzOGg2?=
 =?utf-8?B?QVVQTWIwVmIvZVF2RzN3L1RWWGR2SWZ0RjZOV2JBbDF6eWZySmsxcW5oR0FX?=
 =?utf-8?B?WndoeDBueU9RdXdNRXJxYWh4T1Z6T3F1ZGd3QmlCWS9oaHhGQ0JTYnc3aXdn?=
 =?utf-8?B?VEYrTllRSkIrLzhzeHphSXI4dnFjeEdKZkh1cHdNWW0zY2syakNiSWZ1emI2?=
 =?utf-8?B?eElyRlY2ZUJFOUVmcml1SGpIODlYWFE4SUVZSkE5U210V0RBak5GWkM3S2ZM?=
 =?utf-8?B?UDloeFRSRHEwLzBmczlqNnhwblZNOGQrZGtRMVhYckRLM2ovMFBzSXM5U1RV?=
 =?utf-8?B?c2U1Y0E4NnI1R3ppdmYxV2pOY2FoaTZGdHNtUWttNm1lckZyYkt6NUVHb1lK?=
 =?utf-8?B?TkJnSlhSbUNLTTBUTjRPWVZkLzlrdW5DdWNlYXg1MTJvQUpTRmNOSTc3M1lT?=
 =?utf-8?B?MlFQRGxxb2NQTjdwMkVaQkw4NGgveHdUTmxMOG8rK0FCL1cvR1NiMk0ybGFI?=
 =?utf-8?B?b1JEbm05ZUMrZDZYb1J6b3BkbFJvOGZUUWRlNEhCeTh5bElFdTVUVFFsenlC?=
 =?utf-8?B?a1VxREdDTEFJN0EwS3M3Q29YVGhuZE9YQU1Eb09rR3huYnczMWJXQWdPbCtn?=
 =?utf-8?B?MHRNaGtBWC81WjNCT0FrbHlhL1Mrb0RVUmJ5dlFpbzRHQmpNdlV0aEtRRmNQ?=
 =?utf-8?B?R1AvT2RsZzU1QmJSUGw0cW1leWJCV1ZNSXVxNlVqOE9hWWxPa3AyTzIwNG03?=
 =?utf-8?B?SmprVUw4NkVIdFRvZzhZV1V1bTRUbXNnL0VEanZTWUJYWFpmb29pN3UzYWtj?=
 =?utf-8?B?TTQzY245SW5tRUE0d2Q4V3RGaTZZVlB0VUF3ZGQ1S3lKb0MxRExxamtNdWVm?=
 =?utf-8?B?NmpITFFZOVU3UklsSlNRL29BSWIwR085dEFqdkIweE10YWp0TmsrNTMvbEt6?=
 =?utf-8?B?SEU3QmxON21sTzNNSGkzV2U0U2lPOEdyQ3R0aFprU2hwa0Znd3k2b0pGYmtL?=
 =?utf-8?B?dkYzWEJxdnRKeEF0Ym9VVVZmQnM2YVhzbE1DRCtZWTRLRmFhS25rN0UrTlNs?=
 =?utf-8?B?d05ZaEE0STFKUTBHSXNpaFRYVjBjbXRxZC83aWJyQWtOaW9zOWFhdGdQZldP?=
 =?utf-8?B?VWFJNTFZb0V0YnRKbTRxdGZrcjNSdGlrNUdwMTdvREpJVW5aTjFvQkFWSHI0?=
 =?utf-8?B?cEE1SjBaZlhVUkNkNmxPc2pzV3RPN042bS93SWh1bVRHaDVhUzhJUHBGem0r?=
 =?utf-8?B?UmtrZ1ZIbkI0d0VQRUNlQ3MxTU9hRUhUN1NYRTJsMEd2T21ON1dmWXhjQ1lF?=
 =?utf-8?B?VDFmbDBDOUpmdUZ1R3JzMmdFWDhlSE5kaUg3Ly9iUkRFcG1hdEg5Mm1EWmhw?=
 =?utf-8?B?UWg0S0hjZTlMdzdGa3NIbjQwSkFWeHIrY1RXVlRGZFNteUd5aEJKb3UwdFFL?=
 =?utf-8?Q?jYaqaJfXQWeC02Do=3D?=
X-Exchange-RoutingPolicyChecked: ETfy9WQJSeNTZHtWBGpJygMj3JGYdcnQYfyoS+GMMJ00c17MFUmcbY6KfBf7P0oLFg8Fl7Yv+3BBSUVER6jerdyShqTRwkDg4vTKduOaXNmztUM9ugqiiHoFwy5z0bfzqNLjmXMpBNot++Kwh8JWDcSAJg2oKCI/qGQNSUMJYj/xjH7b3KwVfKPhrAVzUZ7Rq2b/aqPJYaBD8l9U1q8FXVqTBAoC8pG6It+Fob6AZC/15pG8Wm/2BKt7n19pcyN0EKaJi148XIs6rcBcDtChlGCnMryPSBMjCg7mLyL2gxkLrqnikREmCyl1d523+dqEGopihpHwg0p9383mrqe+8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce30ecc5-3b0f-4efd-7e6f-08de88e9fda9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:39:30.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn0uF+Pi7SbiLWLijgCHJ6QRcY9bf/dYgEFfzXKCvbVmhM074Q/vlWE7iUZKAOomLhnwHXKFo+w0LrzxWVMHjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com

On 21/03/2026 00:02, Andy Shevchenko wrote:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 47a0a738862b..c347fac24515 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -20,7 +20,6 @@
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>

