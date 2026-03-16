Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC5283C9D;
	Mon, 16 Mar 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664414; cv=fail; b=UKPddTuFrYn6IL0mNGtfupoxA+JTNp71ysyUcklXRZVW4A+OrG5uz1ebsPSUymk3A05pIdSwCXizcmbMc//GhVvSjUoEOGb5RlWsiVuChvNsbDXaPSVGUDREOFbEUozAw73Bpuz2dPbOnB1OkgQTE+9AzruI9J9S2LX0lB5dCbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664414; c=relaxed/simple;
	bh=X5xsM5sa6DzXrn91h926WwutKdEF20KPPtGam5CS8uU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOcJo10UxKRPCufO5n3/eT2i3L2mIxKcza59kJ+62gTkvEwulRt75yTGxXkdNIhUErIrC9TmB8hMT65xiXitKPeGXYYKMb/IGGT9Otnzvt0b8axlN6rNKDF6rRENBGRh0dVDWBNul600+cF23x79LakVdfQ2tRN6DRbQO5ltZNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwEVFwhV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwEVFwhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773664413; x=1805200413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X5xsM5sa6DzXrn91h926WwutKdEF20KPPtGam5CS8uU=;
  b=GwEVFwhV7WZUCkZ9oOTsXa03Pva1NClykXjxH3h1dHxQ9MW/8tG1uh1r
   fcGr1HSUGrnVKWkefyYRjY3d1fBwoK0rpZfsQwhd1PkmPKFy7CFW5Yb72
   1J5HVShj2OpqayoSspLCheQ9Z4QnaWPqBpVrkMSfu337ghqoeaYGNgP0Q
   AIgS3gxc8aolBN/W093EuBr/Ctgh98HiOwZAn8SXOupif0VuLAAb9/N/o
   OGz+HANsTIa0xkUmjRXHSWfsrwMtvWlht8eAoEnPCXTRUpz8yo8eIC92E
   7P0nOjvAMG/G3LcIRVy4kCE5JxYHkSWIJ5CxeIsjzKf0o/55cSZVitav5
   Q==;
X-CSE-ConnectionGUID: 0yGgKrmUTGiY4s3Z2U93HQ==
X-CSE-MsgGUID: H394TN2MQ4OTIBG0JAOnTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85758998"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85758998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:33:32 -0700
X-CSE-ConnectionGUID: lOPHVMCiT3W+gLppVtq8VQ==
X-CSE-MsgGUID: Men+HGn9TpiCseFMf0vEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259806416"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:33:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 05:33:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 05:33:30 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 05:33:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ9TbrnFjcUYVcwHMuR0Uac3hgIZX5JNZ0mUdBOQ63J064wNxmtmVOnA8gAM+qd5WbPblIBYogD2Ws+JdwmdosNNQLB99XL9tVFrkVH3SrXy+UsUTLe9jWUzWxaHLeOCqK7sRNw/Oyik5cigZk0vePuDtlIqv9nILzBtu2hXIulZIppctXUoW9WT1jg3OsrNNhV+w0EE7uOHCfdbXTDT4nbGvGMMI2/hVSAucynwAanTw6Ekmutc7r9onz/bQV/5jO7gnWj2QZk+QAqv2pTt4eckMoHYMo+Wpw5rldWcbStBmw166S8OnuEnIVCVPOx5tHCaNWNOg9Th5uTYfhvpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiG2xbjJ7lf1r9QVQfWS9pxp+hI3zf024cwAZEVd2Fw=;
 b=ZKxPjcT8v1hdSlhy1C7GZy2kuW+yT4+5rvvwwFOPWFpMfwcniIBhLzcU+TOiI8r32JoCP7QZm+PseogiWnmayXqauOASaChhWLUEP9ib3GZswBYsoYzXyxq5hDBxB66p6RkjGGB2FVM660co66S6m8vbE0Xl+UKugoJxF01Ybw6ONMkWrM9X0p9FSzR9WFqce0lbGEK/kY0lx0XaDMVKdorI5GSPQh7dcN6qOq2CTQFDln/Q/GIMx5GQSpAHJjFfdTFSOlnc+aPYtRQyfgpzKnoAyM8hwT8sVi7pI41R7DJ1DE5Y18L3ptW9KS+yvIa2B7+1algKXDLIuFlew3Cb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 12:33:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 12:33:28 +0000
Message-ID: <15516ca1-335c-44ac-9c23-98b3c60deff7@intel.com>
Date: Mon, 16 Mar 2026 14:33:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>, <krzk@kernel.org>,
	<ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gaohan@iscas.ac.cn>, <me@ziyao.cc>
References: <20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260315054426.18383-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260315054426.18383-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b956bbf-4057-4358-af57-08de83583996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3WfQLvlXKUzuFt6MyRDwogVTbsrRd6BUKt7URbEEEiPMrFc2OQqe85Y51YAu4JP0vq/KIlIsAS6Rj0jPrD/fjmwTYNzfnVy8SqRlf7W0E8/AmUbwz+zOzdzjMc+kpIZRFoIJQ1tchzeHsi0FBVpWqwHa1iGoxDk84xN/gzzjf0a48psWUnYlJ07Pp2LQNw6uB/X7DHOqkYy95VllMyEzXRpzDijjAcEc9cfoRj2qkoDu7S95fBhODei1H0QE0z4HRyzN7u7IBg3+Hofhh3ICrj8tR9HfM7bR1cSQMDR5N9A82gSiNCbnUD1nCSEeuBqQ3MEEQrT0IbU/fnJEf8AwH6mnMmRHFuCFCBpMZJkcyh+T/rr6a8eZCoqt9Yweb5Zo0oVz/Ra97Axbn01C+NZE0MKL8KCDBryvyokQSxSw+IXb06HsicbxMMrffnyYt9YKaJYp2muhbrpbn0x4kGixlgDka3DpjLmmrCz03BiLBr9SWwcYJn0Tgs2WJEyh+rRIlZ41mc9NUMlF8/rn8yUnBZsAtzPm1CiI7kJSkVDFNfAvRwptZol0v8+r8M/IitK2HnA6k9JAuUOjZLtxCDSyXyp+0OrPiyhA5uv0uw5s64543R9Vx8DsEWhBkL48cVSOvC8lwwYmYhzjKbBo3gwkvrD2Pwj0AH8Ric9xeJMevzQknDcu1CVZfhWCazlG6H3hjD/ztlUUKI4dnexT7nI0+thWZkOWDWcMOs56qt2A6co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVaTW55cVJDWXNhdVYrTGYzMlRkOUdQSlp6T2IzQmhsSUl5WFpaOThFSmN1?=
 =?utf-8?B?dE9IT2loQUVuTzc5TWNnaUlLVnhqbE9scit1Y0FENEs3cngxOFI4Zzh5eUw4?=
 =?utf-8?B?L3RhOVUyaHFyd242YlNYZ09SOGoxUmZrRHZobExieGdzd05ZdXlqMzIxemp2?=
 =?utf-8?B?Y3JVMFdLNEtEbG44OXZQTnBiQmUwQmZ1UlR0S1FMQk1XcEczMHBURkZQTDM4?=
 =?utf-8?B?WWxnNzQ4WWJnWWdRZjViV0tGdVQzL2U3aU45L0hobW1mcmcwWmg1VVhmMjUv?=
 =?utf-8?B?M2NGTjhqeUlSQzBWaUV4YUw5NmVyVStjejdPRWl0R2hPWnVPU1pUcTNEQlNC?=
 =?utf-8?B?ckdWRmhpQjlvdWt2SFBtMU1TM240UEZIbjZvTzdTVmJUTDJBV0JQNFVEMW93?=
 =?utf-8?B?OVYrNEhGWFJVYkJ0QUpFNVRPb3U5dWhyVlNpT3JUUGtMNUtXTVFBQ3A2SnpB?=
 =?utf-8?B?bGFVdWVoRUQ1T1RObTI5MC94M3l3dmxiOXRGemdsZ3NteHFUOVFTb21yODVW?=
 =?utf-8?B?MWxhczNuRFRXOHRnNGVIM1hyRE5wYk1XS3JvZk5pRXNvOGNhLzlqSDhPNzBz?=
 =?utf-8?B?aHRvYXR3ZWhHbzFoVWJnR0IreTZMNUJwdEV2a1k2RC9nQjQydnhQS01FUm5m?=
 =?utf-8?B?RklkZlVnZ3RMamFlVVBZNlhnYWRCM0xXN0llM3pzL2RLcG9iS0Z3WElrLzQ3?=
 =?utf-8?B?MWVtS2JCM3l2SXR5WSs4czZVUE52cmRRTGlXY0pQdWUzdzhNWDBRS0VnK2xn?=
 =?utf-8?B?U3l3bEVyWVpwejJ2QlZBS3ZSeW1FKy9FT2ViWlpzNWpwbkdpYjRtRUhCUUJE?=
 =?utf-8?B?dVpTU0VwK0UzejRGSDBLVW5vN0xiTm1TQlpoQ1ZFa3NDdXE3VFZnTm5RQkJ2?=
 =?utf-8?B?cjZjNjBlYytoQjhub0N2VmswOVU4a1E0dUtEZk5wd2YrSk8yNktpTXU1UE9a?=
 =?utf-8?B?VHlvaHBzOXR0ejZGNlA2WlBQNzRkSGxpSi9KRmJjQXV4TU1CL3gveS8vVUtQ?=
 =?utf-8?B?aUh1eFNWd2dyazY2dEwwZTBUTXZjOXBJV3FreHdWN01xQWxzZEE5K2Q4dDNv?=
 =?utf-8?B?TTcrdElKRWpmVlBOdHNHM3hhYVhZemxNSXRtbkVYMjBVOFp2WVZQenVJTzVD?=
 =?utf-8?B?emIwZFBiNG41eC93eE93aHNzY0xhNEJSdEF6dDVyRks1Mlk5VVRZQnl5eWdy?=
 =?utf-8?B?Y1JYWEZaYTdCK2NGNndJclJHYU1JMVQ4R0M2K3F1ckQ1Rk9LQm02Zm1UeE9n?=
 =?utf-8?B?bEtyOE5OKzB0SXpWTWJId0pEd3RNVkVYTWNWSTRPNTZZS0VZMndBREhwQ0Nv?=
 =?utf-8?B?TVVzOGZlbXV2Mmo2VEgxSHFjTXBwUVlPUW11eURlNVNhRGc5RWVyRElmVTRI?=
 =?utf-8?B?bzFVaG1vL01aRHlkWSttZ3NuOUdwQ1pVUkZUL1FFZm5NU3JTc2NsMjdHWUpE?=
 =?utf-8?B?SGxHa0EzYkx3RERvaHhzOU9kUlNOQnRFckJMeC9ISkdYejFuNzQwQXN5cnUr?=
 =?utf-8?B?MWVjeUh1V1A0VDhWUnIzbzVtNVlPYnNwMjBoVU80eFc3RFlHVmlHdWJoWVk2?=
 =?utf-8?B?UmIvSjlBTHpHYzAvTURGUE8zTTB2ZUhBenZielZ6eXRFaXFaV1pJQnhCdVVo?=
 =?utf-8?B?M1ZpYjFUQXpFc2JYMjZmMzl5UGtNc0VlWkN6OXlUWGdSUm9LMXM0TTd2WWtZ?=
 =?utf-8?B?WGZhd0JhNUJFOW5SWUc1VzM0SENDcVFIZGZkaHozaG5xbmNKWVFpaXNZNXVY?=
 =?utf-8?B?cFJVMmhxd1dXT0x3V0JMelVVc21EbTFrelNjc29MTWt5Tmp6TVpybVc0NEVw?=
 =?utf-8?B?VWlTSmRMaUREZ2JJRE03SHVEcmlCdXIybG9DRTIwZENrZDN0M2tTZU5ob21q?=
 =?utf-8?B?SldHcTRrQmhaaU40OElxSzhpR2lrZGdsYlJTUmhyeEZ5UUdaVkdSbWoxa2ow?=
 =?utf-8?B?MGhERVhvL0RmcFQ2TXJkeTVhTmkxSnpndG95ZlEvRkdsMkZvZXBJbEdqaVVK?=
 =?utf-8?B?UmYvTHFKM2VGczYyVFFnTktVZ2MzQUZNQXNOY29kQXJORmYxU05XL284amtx?=
 =?utf-8?B?Ukh2V0NhbzlxU2FTejl4V2VYcXB3M01rRmoxVWdPOU43MDRjOEtiamVoT2cy?=
 =?utf-8?B?RTF5bkl5TDhDQS9Kc0xkUFRmT2pYc3hqaEx4aUFhcUxYYjFJWVZhYm8xaTk3?=
 =?utf-8?B?M3VHWnZMZjV1RGV6elQxb29ycnFwcHpYb2tUV1NJZ00rZkcvWG1sNy9YQW12?=
 =?utf-8?B?d1Z3U2hPYU9tWkJ4RHNwcjdqa1l0aWVPdUVabE9xbGhIUlpZV3dnN1ZGMDBl?=
 =?utf-8?B?U2FJKzRhUkJxUEFYVGFxYXg3QTMvZnUzQzFzZ1ptOHZrT1RQMUVXNjdsc3Jn?=
 =?utf-8?Q?Dh1vK36myduyQHB0=3D?=
X-Exchange-RoutingPolicyChecked: EubAQLqs/t3Rd2y80b4q+lgop4UhpuXHgaKwnQ3oFkckJgQxBPi6ON674JvAZcqZSojHzZgPSZjhev0EoEJkbIH9+CT9UKmkNfujF59HrgflCSf7EQHkJqlEhX5BgyimN0RE9SgFcJOydPuQi0C/iCU0pmEGp/3g7VebK/t/fNV70oOfN8AHaxHW9rfZTgaMaKBATsEjh5eXm4dFXWC+J2SsZZKoRh7svzGBcn2iYl2QGYa0HUHtaoV1TSpLVRkG16h5mwzBfCOyehERJEMnqWyLOx9RyEoID4Mroec/mo2Bo9V8HdiXFdEAmFHVa/UB/jqzhyhRNyjUYroVbpisDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b956bbf-4057-4358-af57-08de83583996
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:33:28.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue3+gVOZenQvAwhK8oRMAAEcK41UacY9zqVprYVprkTZJBF6cy4/qDz1fntIsQXCEc4t+Ti5W6l7l+qXs4e8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

On 15/03/2026 07:44, Jiayu Du wrote:
> Add SDHCI controller driver for Canaan k230 SoC. Implement custom
> sdhci_ops for set_clock, phy init, init and reset.
> 
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>

Still a few little things.  See comments below.

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 277 ++++++++++++++++++++++++++++
>  1 file changed, 277 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..489274c39141 100644
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
> +	const struct k230_pltfm_data *k230_pdata;

I'd prefer to drop k230_pdata here and make a macro that anyone could use:

#define to_pltfm_data(priv, name) \
	container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwcmshc_pdata);

> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -278,6 +305,7 @@ struct dwcmshc_priv {
>  	int num_other_clks;
>  	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
>  
> +	const struct dwcmshc_pltfm_data *dwcmshc_pdata;
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> @@ -290,6 +318,14 @@ struct dwcmshc_pltfm_data {
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +struct k230_pltfm_data {
> +	struct dwcmshc_pltfm_data dwcmshc_pdata;
> +	bool is_emmc;
> +	u32 ctrl_reg;
> +	u32 vol_stable_bit;
> +	u32 write_prot_bit;
> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>  	u16 ctrl;
> @@ -1656,6 +1692,199 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
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
> +	sdhci_writeb(host, PHY_SDCLKDL_DC_INITIAL, PHY_SDCLKDL_DC_R);
> +
> +	val = PHY_SMPLDL_CNFG_EXTDLY_EN;
> +	val |= FIELD_PREP(PHY_SMPLDL_CNFG_INPSEL_MASK, PHY_SMPLDL_CNFG_INPSEL);
> +	sdhci_writeb(host, val, PHY_SMPLDL_CNFG_R);
> +
> +	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
> +		     PHY_ATDL_CNFG_R);
> +
> +	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_TUNE_CLK_STOP_EN;
> +	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, AT_CTRL_PRE_CHANGE_DLY);
> +	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY);
> +	sdhci_writel(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
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

Line wrapping not needed

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
> +				(reg & FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1)),
> +				10, 150000, false, host, PHY_CNFG_R);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc),
> +			"READ PHY PWRGOOD timeout!\n");

Line wrapping not needed

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

	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);

> +	u8 emmc_ctrl;
> +
> +	dwcmshc_reset(host, mask);
> +
> +	if (mask != SDHCI_RESET_ALL)
> +		return;
> +
> +	emmc_ctrl = sdhci_readw(host,
> +				dwc_priv->vendor_specific_area1 +
> +				DWCMSHC_EMMC_CONTROL);
> +	sdhci_writeb(host, emmc_ctrl,
> +		     dwc_priv->vendor_specific_area1 +
> +		     DWCMSHC_EMMC_CONTROL);
> +
> +	if (k230_priv->k230_pdata->is_emmc)
> +		dwcmshc_k230_phy_init(host);
> +	else
> +		sdhci_writel(host, 0x0,
> +			     dwc_priv->vendor_specific_area1 +
> +			     DWCMSHC_HOST_CTRL3);

Line wrapping is not needed in this function:

	emmc_ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
	sdhci_writeb(host, emmc_ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);

	if (k230_pdata->is_emmc)
		dwcmshc_k230_phy_init(host);
	else
		sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);

> +}
> +
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +			     struct dwcmshc_priv *dwc_priv)
> +{

	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);

> +	static const char * const clk_ids[] = {"block", "timer", "axi"};
> +	const struct k230_pltfm_data *k230_pdata;
> +	struct device_node *usb_phy_node;
> +	struct k230_priv *k230_priv;
> +	u32 data;
> +	int ret;
> +
> +	k230_pdata = container_of(dwc_priv->dwcmshc_pdata,
> +				  struct k230_pltfm_data, dwcmshc_pdata);
> +	if (!k230_pdata) {

Not possible, so not needed (also assumes the container
offset is zero which is a bit fragile)

> +		dev_err(dev, "No vendor data found for K230\n");
> +		return -EINVAL;
> +	}
> +
> +	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
> +	if (!k230_priv)
> +		return -ENOMEM;
> +
> +	k230_priv->k230_pdata = k230_pdata;

Suggest dropping k230_priv->k230_pdata

> +	dwc_priv->priv = k230_priv;
> +
> +	usb_phy_node = of_parse_phandle(dev->of_node, "canaan,usb-phy", 0);
> +	if (!usb_phy_node)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find canaan,usb-phy phandle\n");

If it fits in 100 columns, just put it all on one line

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

If it fits in 100 columns, just put it all on one line

> +
> +	if (k230_pdata->is_emmc) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	} else {
> +		host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +	}
> +
> +	ret = regmap_read(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, &data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read control reg 0x%x\n",
> +				     k230_pdata->ctrl_reg);
> +
> +	data |= k230_pdata->write_prot_bit | k230_pdata->vol_stable_bit;
> +	ret = regmap_write(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write control reg 0x%x\n",
> +				     k230_pdata->ctrl_reg);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1743,6 +1972,15 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
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
> @@ -1834,6 +2072,36 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>  	.init = eic7700_init,
>  };
>  
> +static const struct k230_pltfm_data k230_emmc_data = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_k230_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		},
> +		.init = dwcmshc_k230_init,
> +	},
> +	.is_emmc = true,
> +	.ctrl_reg = SD0_CTRL,
> +	.vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD0_CARD_WRITE_PROT,
> +};
> +
> +static const struct k230_pltfm_data k230_sdio_data = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +		.ops = &sdhci_dwcmshc_k230_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		},
> +		.init = dwcmshc_k230_init,
> +	},
> +	.is_emmc = false,
> +	.ctrl_reg = SD1_CTRL,
> +	.vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD1_CARD_WRITE_PROT,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1906,6 +2174,14 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  }
>  
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{
> +		.compatible = "canaan,k230-emmc",
> +		.data = &k230_emmc_data.dwcmshc_pdata,
> +	},
> +	{
> +		.compatible = "canaan,k230-sdio",
> +		.data = &k230_sdio_data.dwcmshc_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -1988,6 +2264,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->dwcmshc_pdata = pltfm_data;
>  
>  	if (dev->of_node) {
>  		pltfm_host->clk = devm_clk_get(dev, "core");

