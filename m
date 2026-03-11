Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417E31AF1B;
	Wed, 11 Mar 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237862; cv=fail; b=ZLFntqTEpq+9AM46hHEulykpFixEXPVYhXjrf/WP6Y+bC+W4+Z1a+x97oL/rjtsDKqPgcTt5Vvn9FEcrf9UnU5sBylBhScNsbXMfoJOBhKoZIwVvji1Ig0ifdqRVkKN9l1PNbAs3BjDXIC2vKbMGqjhnO8YeLQ774D8A/GydMsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237862; c=relaxed/simple;
	bh=JVOd/NfcWA/LOxHVbsOLCI3cu6BnPT2aiqxto5LxdzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfEAADBWuRF1QYD+CsJsj7OtQoE6YPaLLrPqcXP3d4YhVsXiVZH78CM8ERiUfL+PPwI1Kt1GF0pBsUnlZQPIZWY6sAIhg5tvOhHe7rprD/f39z/H/bXVSadxcmN/GJkh5DSiVedKnFCF3b2hiWieoM40iywyTqVD4L+Ml7+Nz70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwC2La6A; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwC2La6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773237861; x=1804773861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JVOd/NfcWA/LOxHVbsOLCI3cu6BnPT2aiqxto5LxdzY=;
  b=GwC2La6AeQDXOQzjBuEkRWkhvVqbcVmg4l/1zhn2qOEy4Fgs411BhQE7
   6HLZF3RA+5E4CjuEstJKFgIXWO3F6/rqlRtTybBLWAKUYXH06kTWokbGJ
   5F/31Ytce56c6SxE2NeAVSK5qNfMXlbI93uFdrN5/swOKZ6LKBuHZ4I5T
   OAMix/LT9ff05sY1eD7Dxg5ZfR3EKIv2izxW8SD/KB09hBP56FOn9IIXh
   jVpuExzXWHuxzRNSaROx6mBqKpYyZLUeUvQY9oEGLftFGkztlE1W1qsV2
   FlcKAKkFTyhN71DGuIu6ex6BJ/8fEVhjcflT1OKZvHliiFsbA8/tPXCim
   Q==;
X-CSE-ConnectionGUID: 2ltm8/7UQzacgRpsR697Zg==
X-CSE-MsgGUID: stt9hxzwS6e4W9meFoZRcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74385758"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74385758"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 07:04:19 -0700
X-CSE-ConnectionGUID: CRqxcsMbSLulk3+A/BsGfg==
X-CSE-MsgGUID: mXoGDKHvSRSdY8RbEJwsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217138291"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 07:04:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 07:04:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 07:04:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 07:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUAis0xzTDDUg7YsqW/KPjsYy3EQlQC4GcCxbI2LlLe+oeCsLczkznQ5rFlipaQoqvkgwCHwAgBzh+KljsevOuMLPzsPOjfq2w0Tbar1962sruH2PJGgVxNHjHsZ/tPLkXtUfAQOBvcBLC0HbOLM4tkgyH2HcFDby3F7QpetLHXbJScuzxLqIhE+PXPcVJvqwb6tS4tS0gMcO1f+HUuemCx/lOUhz7o+Pa22JfG+4gLek3aBoI+SZU3QUKVj+9wJw0l4RHv2XGSZxI3Ew9uTTnWNct1L9Kjhtqx3TQmhj/4bA4oyR4dS2Ns7G6Z//HXmr+acssjzHkda9YOjY8PU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDcTalzNH/4hY0Abacb5aCwoDWYMJMy3br7DO0qZL0I=;
 b=gowZNxdIZhinWtCQPqGVg9CYEPShLTI26fMLOuH1O0qzp/lNT9aKILv+ZkW3MDg+1m+ybPAK5hVPKAn8e/rIYDCjD9u23l1Adzn9jI3Ma4yX0b7kZMlJM8vBqqOvwT4z/P+MI0Uayh+nmwJvKVglry9DgINxx8hCxaLfV3waap7Y34QbXC2Tsupeijj9SeuICU3iIbNgySFh/QW+ssXW8id+0eDcx1PM/0vz2MLLqgEZg2lJEG+3GCSKQz0oNmRid19liKHtAkvFkLywuzeKQlm1C5BWYQriF7G/svbqXA7nei8X6Jj9l4Jst/9N5mbLEDAKhjnlRoufMreyQPnmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 14:04:11 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 14:04:10 +0000
Message-ID: <5cac60f7-46cb-45c8-9435-3ae88545ce4d@intel.com>
Date: Wed, 11 Mar 2026 16:04:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>, <krzk@kernel.org>,
	<ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gaohan@iscas.ac.cn>, <me@ziyao.cc>
References: <20260310064513.140093-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260310064513.140093-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260310064513.140093-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::9) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA0PR11MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fd92a8-5f54-4e39-fac3-08de7f771181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|7053199007|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aTDjLRxp1M4hoTG0oCrM1NyM2itbiMtqIi2LLIk8aBGqwvSsxcJEJIxmO20XWQIkKqJJSDxeZA2sZsRZaEjap9kDbxYQjtcgALw80hJ4irDkcisl+SWLpr6P+b5B7YoANyQ6RHvZH1DwWbPIdGtobgz3U3+y7yx35B8t4FpuaaYGseGqTrgMqaxmp77rRZ5EdKssxxY86NW2BQdSVr1bbK9+Gt2bGLVFW3zpiU61KpIW23OCMEcoQexSvR1L0RSTUtnIh7Ti7k39OWOgzQ9wn6ISFt63NfVZbNM0hnXAtTqDB8j/0hKzu9dTxmJpKXggKqMGcnIwkxqzvfOl2VKpljHDVGh6ePE8+qNnVc/lVP9MaqGGAl6Fnu14VPT/MCR15ra2E2fP/kDsO21O6q6vaEl9PAH66H2h45XrtRxqYPtknwGz99bfXDAJxjJHR9l2+WCBLdTS2qYMd2tTOl63vKQVyIxWdjWBZJNsfSb2Sllp45T0nKq+cZc/2vhY7KbfjiHGOQ7tdTYIYiz3ulNEOQOa6zjgspjY+DUs+xygmiJ4XRGXuWrsQXZI8vJpwzVluxLtgWOrx1x9GFdiLWeljdfnFJS9xEETcsmH/RGa7iCRYrhuWCvammSdTzdEinmu496Xztc6mF2g4lthVALANsGz3IOWRiSYtg1r/M6vGPiqkUg13ITWzFh2E90kT4iceoPsoEU0ysIlMLKjzB/xdFwUbGWQO6/qkTPkeDZ6zqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(7053199007)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFnQ2o0SGcvaUlyK2ErWXNPWG1DQjZ4QnZwWHBTQ2p4N3F3Y0k4MS9HYWhH?=
 =?utf-8?B?a3g5L0N6RGpsTXZNbFJvVmJEZmpzTjU1eXF4QkpXcUdHSGZuUFEzWnFQZjRP?=
 =?utf-8?B?czdjN01nc211MkN2bGFQOFI2WXMrQlhDblZ0UGVXeHNURWF4RHJtY2JUQzFk?=
 =?utf-8?B?M29nS2N0ZElZVm1Dd0FRQXJRdEhsdk1mL1VsUFFERXRkaW5GZVZGTTdjUXJi?=
 =?utf-8?B?eDNQK0lsZDVrM050MW9HWklEOVAwWXNkYVJESDhrd2NWaUNicDBNOG1OMUpv?=
 =?utf-8?B?M05ReUlwak0xT0w5TXNodnh2K1E0bUVrMzZuR0F4MmN6YytqMC8vdWVKYUds?=
 =?utf-8?B?TytPTHdNMnRlYWN1VktJMEdrWGtiUmhrNEpnUnlmVFBweWlPWmZzbFZPbHZZ?=
 =?utf-8?B?d2ViUmwrNGhyQzhLMlV6QUpWZldFc1pnNXhaSnFLckJnampwZkFwWmhrMlJ2?=
 =?utf-8?B?V25FZ1ozazJhSUhNR24xeFFib0p5UzNQVHRrWHBkVEprOWZrSUFuWUVjRVpw?=
 =?utf-8?B?MFcwQXVkWExaRklFMWhyWWZzbFdCUXROTWt6WEVzMGRYZS9NdTR1TEd0N040?=
 =?utf-8?B?amI3QkpRRnJYcmNuOXFZL3IxbGIwUDIvcXFzN05oR3VVMUhXeTZZSXl1NjBH?=
 =?utf-8?B?SWZ4ZWdlclFtQlYrNGlrbVhybE1sNk5pbzlxeHdzSjdCeSs5U1JNblVXZHU4?=
 =?utf-8?B?QXpyMHVEMWloa2psZnRKdjk4N1h1QWNhYjI0V0plUDd0dnVKNUwvb3c3Z3hV?=
 =?utf-8?B?R1BOczl6ckIvWmU3TmRHd0lLQlBoNkEwRkNHbWIwcHhVWFdWSW9mKzRiVjQr?=
 =?utf-8?B?Qk4vVThXZDNwaHpWUHNQRW5WNG1vNWQyelJwN01RMVFqVnd2bitsOFJHb3FZ?=
 =?utf-8?B?OFl6K3IvZEUrZTV2M09SSkM1NVFxdGxpL21TOVJtTzd4Z25rQnVKRTdhNGRH?=
 =?utf-8?B?L2wwanlHWFo0Tno5MnNBL2kxaHlXRTR1L0grZzQxbHhsOGN3b0hucEJMNEl5?=
 =?utf-8?B?VHVJVkJIVFNvRGpGUWdHZU9yRkZUODVCTi93TVdnNnVUVCtHYXhvaEdNT3pM?=
 =?utf-8?B?K0dTdHdvNjJyNXRyMDBWODY1bnpKZ0lnQVM3TVRoQ2lxdlQ1T0NOcWNLYm9B?=
 =?utf-8?B?aGU3ODF2Z2IxdlhMSVhSeGREZVVjeEdpV2VxZXJFUk5lMGliUzFaWVFSeE52?=
 =?utf-8?B?aVBNcDNhYXJzTFM5L3NjZzlsNTdaVUpKbGl4Nmp0Lzlaa0ZVc2JMMEs5TnBC?=
 =?utf-8?B?R2psenRFVG5ERUN1Q05GM1V1eDN0czM2ZGlBZG4rYzNJNFM3ZDNzNExBQVJM?=
 =?utf-8?B?MUxGM3JKQmU0UDBJRFcvUHYxQitOdE9aMU9VNzJMTXN4RGN1WXNSNm1qaDY4?=
 =?utf-8?B?SEFvdXVRN0JMMjIyei9oS2FNSThBamdLYlcwd2sydmZrTXdWaldnNFBadXVj?=
 =?utf-8?B?Q1hOTkljZFFwb3Z1Tk50bExsaGhrV3dJbmRPbTRIY1N1V1loSnhJR1hEUkYy?=
 =?utf-8?B?V0xoMU1hK3p1bzFwRitCR0VEUHFJUDI2b29oTDJMa2JvWHd3N0txVzE3Ri8z?=
 =?utf-8?B?SVV5VEFzWk0xTDNxd0E0QlZOVnZCdDBWckc4emNNMVAzSXR1NkordkpWK3lL?=
 =?utf-8?B?bit4dk4vektEQlRKYjZDSjJ5L1NoUXkvc3BxSk1oNGcvK1ZkckNxU0taWFFN?=
 =?utf-8?B?VFNUYVJMeUt5eXlZMzJhcERaMW11SCtXZ1JHTnpXdkdIVFpLd0g1N1czSGJY?=
 =?utf-8?B?N1dLWWIrR1pPQm9MMWRDdm5wUDlaSnBLYmZTNzdhdHVYZEZZYmtMdjdobkFr?=
 =?utf-8?B?SytkV095ZmtNcFZiUmRScGtJZm81alBadXA1SHZYNys5ZnpZUWdHNVAxYkRS?=
 =?utf-8?B?Mm5IZ1J1RVg4cS9Pd1VubFNUODkwYlZseTBEbHhiL1d6SXNjVVMxeHU3SlJj?=
 =?utf-8?B?UjdYRC84VEszeDNPS2o0Y1JUZHl1MjJEV3h0VExjdEJwaloxSER1RENSY3pF?=
 =?utf-8?B?NFdjYXMrYndsK0FVYnhFbXVLSThKbC9wRGZYOU9WbFRNKzBBWVlMdFZKS0I2?=
 =?utf-8?B?dmNadTkrUjBBQzhOeUV6MzV3SzJad3pvek5KRDdxcjFsanBhUGZ1L2hzS0RP?=
 =?utf-8?B?Y25DVUZveWRmODhXOUgzVEtFd3RQQkovRi9HR2hJQVMyR1hob1d2TmxqZXM3?=
 =?utf-8?B?ZEd2T3hzMDY5UWRGREQraDQ5WHFENGtWTzhwZzhrV01QTy9tOFJwZU9VYmhn?=
 =?utf-8?B?TWU4bXJ5R2tRUGlWbXh0MEpYOUpBdDdtSzFjY2JlcXR3alN1WStPbUl5NHgx?=
 =?utf-8?B?TnN0QUVjNFRLQ2hiT1FlN0FYOFlNR0lFNFZ2c1BlV2Zzb0pxa3htbUtWY2Zj?=
 =?utf-8?Q?MxSWwEIuZ2DzgMUU=3D?=
X-Exchange-RoutingPolicyChecked: WGMXSBdhOkl+YjvRZsnyKcZtnS01Sq5PLL1n1x4UeW1fled2MSSEYueAX34DlCnzllr519m0bIi0unucYqpuhStpD2CqpSBz51Tdr1dUS97LBnA+7Ityhjq9zHMamRTXov7vsvzJU2VNgsiPxVGrOS9EaDjjOWh0x7y89KF9cAIzWMUUQOI6/HZ9l8SadZH3u2qkoT+3/reZ9O/3/XlcUjMOLRumcHzg0iA5vok6DZdBfBb5EJ0kD5ZBEBgzJF5MX3NFAeWKyi6zusuIZArVOAm5/oUBH5XUUaJ4vpmL0V5bkqL9PtAoFRCsnYTpjS5gombKK6vPytc/5B8dRrDukQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd92a8-5f54-4e39-fac3-08de7f771181
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:04:10.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jjVIWf6O6kPzyluU0guwU4TC9yQ7PX8UP2xmgfIMV61akyc5N8pO9HbYg4ncikNeoDOYeX1iEm1VpGfScO5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

On 10/03/2026 08:45, Jiayu Du wrote:
> Add SDHCI controller driver for Canaan k230 SoC. Implement custom
> sdhci_ops for set_clock, phy init, init and reset.
> 
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 287 ++++++++++++++++++++++++++++
>  1 file changed, 287 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..39d28574cfa8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -128,9 +128,11 @@
>  #define PHY_CNFG_PHY_PWRGOOD_MASK	BIT_MASK(1) /* bit [1] */
>  #define PHY_CNFG_PAD_SP_MASK		GENMASK(19, 16) /* bits [19:16] */
>  #define PHY_CNFG_PAD_SP			0x0c /* PMOS TX drive strength */
> +#define PHY_CNFG_PAD_SP_k230		0x09 /* PMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SP_SG2042		0x09 /* PMOS TX drive strength for SG2042 */
>  #define PHY_CNFG_PAD_SN_MASK		GENMASK(23, 20) /* bits [23:20] */
>  #define PHY_CNFG_PAD_SN			0x0c /* NMOS TX drive strength */
> +#define PHY_CNFG_PAD_SN_k230		0x08 /* NMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SN_SG2042		0x08 /* NMOS TX drive strength for SG2042 */
>  
>  /* PHY command/response pad settings */
> @@ -153,14 +155,22 @@
>  #define PHY_PAD_RXSEL_3V3		0x2 /* Receiver type select for 3.3V */
>  
>  #define PHY_PAD_WEAKPULL_MASK		GENMASK(4, 3) /* bits [4:3] */
> +#define PHY_PAD_WEAKPULL_DISABLED	0x0 /* Weak pull up and pull down disabled */
>  #define PHY_PAD_WEAKPULL_PULLUP		0x1 /* Weak pull up enabled */
>  #define PHY_PAD_WEAKPULL_PULLDOWN	0x2 /* Weak pull down enabled */
>  
>  #define PHY_PAD_TXSLEW_CTRL_P_MASK	GENMASK(8, 5) /* bits [8:5] */
>  #define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
> +#define PHY_PAD_TXSLEW_CTRL_P_k230_VAL2	0x2 /* Slew control for P-Type pad TX for k230 */
>  #define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
>  #define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
>  #define PHY_PAD_TXSLEW_CTRL_N_SG2042	0x2 /* Slew control for N-Type pad TX for SG2042 */
> +#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL2	0x2 /* Slew control for N-Type pad TX for k230 */
> +#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL1	0x1 /* Slew control for N-Type pad TX for k230 */
> +
> +/* PHY Common DelayLine config settings */
> +#define PHY_COMMDL_CNFG			(DWC_MSHC_PTR_PHY_R + 0x1c)
> +#define PHY_COMMDL_CNFG_DLSTEP_SEL	BIT(0) /* DelayLine outputs on PAD enabled */
>  
>  /* PHY CLK delay line settings */
>  #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
> @@ -174,7 +184,10 @@
>  #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
>  
>  #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
> +#define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
>  #define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
> +#define PHY_SMPLDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
> +#define PHY_SMPLDL_CNFG_INPSEL		0x3 /* delay line input source */
>  
>  /* PHY drift_cclk_rx delay line configuration setting */
>  #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
> @@ -227,6 +240,14 @@
>  /* SMC call for BlueField-3 eMMC RST_N */
>  #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
>  
> +/* Canaan specific Registers */
> +#define SD0_CTRL			0x00
> +#define SD0_HOST_REG_VOL_STABLE		BIT(4)
> +#define SD0_CARD_WRITE_PROT		BIT(6)
> +#define SD1_CTRL			0x08
> +#define SD1_HOST_REG_VOL_STABLE		BIT(0)
> +#define SD1_CARD_WRITE_PROT		BIT(2)
> +
>  /* Eswin specific Registers */
>  #define EIC7700_CARD_CLK_STABLE		BIT(28)
>  #define EIC7700_INT_BCLK_STABLE		BIT(16)
> @@ -268,6 +289,12 @@ struct eic7700_priv {
>  	unsigned int drive_impedance;
>  };
>  
> +struct k230_priv  {
> +	/* Kendryte k230 specific */
> +	struct regmap *hi_sys_regmap;
> +	const struct dwcmshc_k230_match_data *match_data;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -275,6 +302,7 @@ struct dwcmshc_priv {
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>  	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>  
> +	const void *match_data;
>  	int num_other_clks;
>  	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
>  
> @@ -284,12 +312,34 @@ struct dwcmshc_priv {
>  };
>  
>  struct dwcmshc_pltfm_data {
> +	const void *match_data;
>  	const struct sdhci_pltfm_data pdata;
>  	const struct cqhci_host_ops *cqhci_host_ops;
>  	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +struct dwcmshc_k230_match_data {
> +	bool is_emmc;
> +	u32 ctrl_reg;
> +	u32 vol_stable_bit;
> +	u32 write_prot_bit;
> +};
> +
> +static const struct dwcmshc_k230_match_data k230_emmc_match_data = {
> +	.is_emmc = true,
> +	.ctrl_reg = SD0_CTRL,
> +	.vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD0_CARD_WRITE_PROT,
> +};
> +
> +static const struct dwcmshc_k230_match_data k230_sdio_match_data = {
> +	.is_emmc = false,
> +	.ctrl_reg = SD1_CTRL,
> +	.vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD1_CARD_WRITE_PROT,
> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>  	u16 ctrl;
> @@ -1656,6 +1706,205 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  	return 0;
>  }
>  
> +static void dwcmshc_k230_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	sdhci_set_clock(host, clock);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	/*
> +	 * It is necessary to enable SDHCI_PROG_CLOCK_MODE. This is a
> +	 * vendor-specific quirk. If this is not done, the eMMC will be
> +	 * unable to read or write.
> +	 */
> +	clk |= SDHCI_PROG_CLOCK_MODE;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_k230_config_phy_delay(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 val;
> +
> +	sdhci_writeb(host, PHY_COMMDL_CNFG_DLSTEP_SEL, PHY_COMMDL_CNFG);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, PHY_SDCLKDL_DC_INITIAL,
> +		     PHY_SDCLKDL_DC_R);

Here and elsewhere.  Please avoid unnecessary line wrapping.
You can use 100 columns.

> +
> +	val = PHY_SMPLDL_CNFG_EXTDLY_EN;
> +	val |= FIELD_PREP(PHY_SMPLDL_CNFG_INPSEL_MASK,
> +			  PHY_SMPLDL_CNFG_INPSEL);
> +	sdhci_writeb(host, val, PHY_SMPLDL_CNFG_R);
> +
> +	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK,
> +		     PHY_ATDL_CNFG_INPSEL), PHY_ATDL_CNFG_R);

Can keep FIELD_PREP() all on one line:

	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
		     PHY_ATDL_CNFG_R);

> +
> +	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 +
> +		     DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_TUNE_CLK_STOP_EN;
> +	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK,
> +			  AT_CTRL_PRE_CHANGE_DLY);
> +	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK,
> +			  AT_CTRL_POST_CHANGE_DLY);
> +	sdhci_writel(host, val, dwc_priv->vendor_specific_area1 +
> +		     DWCMSHC_EMMC_ATCTRL);
> +	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 +
> +		     DWCMSHC_AT_STAT);
> +}
> +
> +static int dwcmshc_k230_phy_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 rxsel;
> +	u32 val;
> +	u32 reg;
> +	int ret;
> +
> +	/* reset phy */
> +	sdhci_writew(host, 0, PHY_CNFG_R);
> +
> +	/* Disable the clock */
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	rxsel = priv->flags & FLAG_IO_FIXED_1V8 ?
> +			PHY_PAD_RXSEL_1V8 : PHY_PAD_RXSEL_3V3;
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +
> +	sdhci_k230_config_phy_delay(host);
> +
> +	/* Wait max 150 ms */
> +	ret = read_poll_timeout(sdhci_readl, reg,
> +				(reg & FIELD_PREP(
> +					PHY_CNFG_PHY_PWRGOOD_MASK, 1)),

Need not line wrap after "FIELD_PREP("

> +				10, 150000, false, host, PHY_CNFG_R);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"READ PHY PWRGOOD timeout!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	reg = FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN_k230) |
> +	      FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP_k230);
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	/* de-assert the phy */
> +	reg |= PHY_CNFG_RSTN_DEASSERT;
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	return 0;
> +}
> +
> +static void dwcmshc_k230_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct k230_priv *k230_priv = dwc_priv->priv;
> +	u8 emmc_ctrl;
> +
> +	dwcmshc_reset(host, mask);
> +
> +	if (mask == SDHCI_RESET_ALL) {

Can reduce the indent by instead:

	if (mask != SDHCI_RESET_ALL)
		return;

Then the remaining lines in this function do not need to be
wrapped.

> +		emmc_ctrl = sdhci_readw(host,
> +				       dwc_priv->vendor_specific_area1 +
> +				       DWCMSHC_EMMC_CONTROL);
> +		sdhci_writeb(host, emmc_ctrl,
> +			     dwc_priv->vendor_specific_area1 +
> +			     DWCMSHC_EMMC_CONTROL);
> +
> +		if (k230_priv->match_data->is_emmc)
> +			dwcmshc_k230_phy_init(host);
> +		else
> +			sdhci_writel(host, 0x0,
> +				     dwc_priv->vendor_specific_area1 +
> +				     DWCMSHC_HOST_CTRL3);
> +	}
> +}
> +
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +			     struct dwcmshc_priv *dwc_priv)
> +{
> +	static const char * const clk_ids[] = {"block", "timer", "axi"};
> +	const struct dwcmshc_k230_match_data *match_data;
> +	struct device_node *usb_phy_node;
> +	struct k230_priv *k230_priv;
> +	u32 data;
> +	int ret;
> +
> +	match_data = dwc_priv->match_data;
> +	if (!match_data) {
> +		dev_err(dev, "No vendor data found for K230\n");
> +		return -EINVAL;
> +	}
> +
> +	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
> +	if (!k230_priv)
> +		return -ENOMEM;
> +
> +	k230_priv->match_data = match_data;
> +	dwc_priv->priv = k230_priv;
> +
> +	usb_phy_node = of_parse_phandle(dev->of_node, "canaan,usb-phy", 0);
> +	if (!usb_phy_node)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find canaan,usb-phy phandle\n");
> +
> +	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
> +	of_node_put(usb_phy_node);
> +
> +	if (IS_ERR(k230_priv->hi_sys_regmap))
> +		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
> +				     "Failed to get k230-usb-phy regmap\n");
> +
> +	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get/enable k230 mmc other clocks\n");
> +
> +	if (match_data->is_emmc) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	} else {
> +		host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +	}
> +
> +	ret = regmap_read(k230_priv->hi_sys_regmap, match_data->ctrl_reg, &data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read control reg 0x%x\n",
> +				     match_data->ctrl_reg);
> +
> +	data |= match_data->write_prot_bit | match_data->vol_stable_bit;
> +	ret = regmap_write(k230_priv->hi_sys_regmap, match_data->ctrl_reg, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write control reg 0x%x\n",
> +				     match_data->ctrl_reg);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1743,6 +1992,15 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
>  	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_k230_ops = {
> +	.set_clock = dwcmshc_k230_sdhci_set_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.set_uhs_signaling = dwcmshc_set_uhs_signaling,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.reset = dwcmshc_k230_sdhci_reset,
> +	.adma_write_desc = dwcmshc_adma_write_desc,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_ops,
> @@ -1834,6 +2092,26 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>  	.init = eic7700_init,
>  };
>  
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_k230_emmc_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_k230_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	},
> +	.init = dwcmshc_k230_init,
> +	.match_data = (void *)&k230_emmc_match_data,
> +};

Just an option if you like it:
An alternative is to define your own platform data e.g.

struct k230_pltfm_data {
	struct dwcmshc_pltfm_data dwcmshc_pdata;
	bool is_emmc;
	u32 ctrl_reg;
	u32 vol_stable_bit;
	u32 write_prot_bit;
};

static const struct k230_pltfm_data k230_emmc_data = {
	.dwcmshc_pdata = {
		.pdata = {
			.ops = &sdhci_dwcmshc_k230_ops,
			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
		},
		.init = dwcmshc_k230_init,
	},
	.is_emmc = true,
	.ctrl_reg = SD0_CTRL,
	.vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
	.write_prot_bit = SD0_CARD_WRITE_PROT,
};

static const struct k230_pltfm_data k230_sdio_data = {
	.dwcmshc_pdata = {
		.pdata = {
			.ops = &sdhci_dwcmshc_k230_ops,
			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
		},
		.init = dwcmshc_k230_init,
	},
	.is_emmc = false,
	.ctrl_reg = SD1_CTRL,
	.vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
	.write_prot_bit = SD1_CARD_WRITE_PROT,
};

Then:
		.compatible = "canaan,k230-emmc",
		.data = &k230_emmc_data.dwcmshc_pdata,
and
		.compatible = "canaan,k230-sdio",
		.data = &k230_sdio_data.dwcmshc_pdata,

Although you would still need to add a pointer 
to struct dwcmshc_pltfm_data from struct dwcmshc_priv,
but then you could access it like:

#define to_k230_pdata(pd) container_of(pd, struct k230_pltfm_data, pd)

	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
	struct dwcmshc_pltfm_data *dwcmshc_pdata = dwc_priv->dwcmshc_pdata;
	struct k230_pltfm_data *k230_pdata = to_k230_pdata(dwcmshc_pdata);

> +
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_k230_sdio_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_k230_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	},
> +	.init = dwcmshc_k230_init,
> +	.match_data = (void *)&k230_sdio_match_data,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1906,6 +2184,14 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  }
>  
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{
> +		.compatible = "canaan,k230-emmc",
> +		.data = &sdhci_dwcmshc_k230_emmc_pdata,
> +	},
> +	{
> +		.compatible = "canaan,k230-sdio",
> +		.data = &sdhci_dwcmshc_k230_sdio_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -1988,6 +2274,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->match_data = pltfm_data->match_data;
>  
>  	if (dev->of_node) {
>  		pltfm_host->clk = devm_clk_get(dev, "core");

