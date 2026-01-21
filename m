Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6743E481;
	Wed, 21 Jan 2026 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977706; cv=fail; b=AcyPw1H+NeEPGmcnCobgSFpPRcCeM647iA3cQcsx/DCgkbTeu2DGETuCZLFBib95+QVgPca3S+bSzFeTnYfqvLN5VDR34bEXBHZzQLPWt9xf35sm89R+Qiiwm4EzNIF8Ta6dygJFWDSm2Lf7SnZZim1tTtYClah+DoUK/n0IUes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977706; c=relaxed/simple;
	bh=ksAONWfkj/9fF24hkHgGUPA3e5ovrWLo8LvqgAOndRA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RN03fW7eYw14DWPmgFcs6m8F9v/r5dMEz8HEjzWsi9qHR6PGuImv6MofdHoSAopEStOnXfzkQgGX4op3BF3w6rZBbSJ2VzUWPWnMU6j1CgTQEycIf4g12sAZnAb4waRprnyW57VZbVc62D/jYjN+U3kOsrfr1uU69vX2ObQe9hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5gix/E5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5gix/E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768977705; x=1800513705;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ksAONWfkj/9fF24hkHgGUPA3e5ovrWLo8LvqgAOndRA=;
  b=j5gix/E5pg9Bh363+KH9LFTdDk58h92mHaYub5rUpWvWhVi4F0GFhqgB
   x03BUjnTnKvAQa4Y+bl5w234BDdRIOuUbJliOpJ/KcmphaIyTECqbQh1u
   XJTu3UHSAwd+Dkl/8HqrXAix0juVK8lPA1r/fvGhWmIcCC0kMCSOGy93S
   Y1A6VhgUUotGN9a8oOeKCDeOXmDyNzFSREqtvzPZSwOnJhfQPeWc08T/m
   gzxqCjUNxfX6V/7PKNhF/9oAsKcQgNNrrBckS1QPm4g3sNAFnSp/sdTOc
   z4kuA8OlOmYZj3c7Sc0d4L9U/SJ97EEKqG22HCE+VGUC6fHUY2KeXT+NQ
   A==;
X-CSE-ConnectionGUID: HpnaToAqSNy3W9+b1lLKdg==
X-CSE-MsgGUID: F01drBi4RLajvVD0ZNIw4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74052507"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74052507"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:41:44 -0800
X-CSE-ConnectionGUID: 46qn7Iu5ThmXDqli499taA==
X-CSE-MsgGUID: 2j0xab8FTSSHqrfUOAlViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="237614233"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:41:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:41:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 22:41:42 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.39)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:41:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZFm4sHNBy+VV4goZIuIzwbgWzbslXDffAr//f/wczkZtiF5Km+nkTTKjMXlxllDxj10RTLtODs+XwS3yOy8AxxqMIY7OczLL7fMyaM3dDTMYAMu/g/zQHFE+da1FPtFE3qAvUreSdP08KvCyr57D8BKuu3HvFfabPTZu1ESlwyijSyu1vxNsmz1lvB5S70pYkr53fjFlmctvONd1BrwZFI6PI9rFqtrFZ/ZRy5qzAUQrZsTbJVmhnyWUu8vionBdcxCL1wYwO3YGVOM4Btb2gztf3+K6UaIdSNHDqYZrtN17rzID+CqhMRZntuIg+9Ygal2iAjAxcF5Mq28T36B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/QdNrPcbeh3yp9+h9h7ogTzIm+V93Ra7bh7uamoJGs=;
 b=ScdMKfdtkcNwnOfOGGH6Z7/TXP0rC39zk85PevQl1Gg1oNxsUZHCWSzJ9av3MQb/UicpnJaleWMTUmxxPJ4Dt4IQWNigfknWlLNw8A57CJRSyuHjU+I51zSbYxm1syllocrOwjYrDgjrS9BOHLrphV3qXt9aaq8Hoo4TMzJUxxDJ9I/V/A48buGsjygqhNxJFIPQ2hty7t6J9YYdCkfkb2P/wh3nmC0fsgKS7xTmUAot6cCU5rzZVSJgAaA3lukcl5AnHp0LMqa/BE/5WdfjuhuZMTAgoWKhfLySefF6NKwUE/qqcpO9/8VYQ1y3iZ0UfpqXupIvdLi7h+hT0LlygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7139.namprd11.prod.outlook.com (2603:10b6:806:2a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:41:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:41:39 +0000
Message-ID: <8693c8ff-1310-48db-a680-d78a224a0245@intel.com>
Date: Wed, 21 Jan 2026 08:41:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix DMA 128MB boundary
To: <hehuan1@eswincomputing.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>
References: <20260114122256.1587-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260114122256.1587-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: e735c7e0-ca4b-46f7-0d2a-08de58b82170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0cyNXp0MS9USXZPNDNvdy9jb0Q4MHpIQ0EzNDJxME5KR3FKMG8yejk1OVlW?=
 =?utf-8?B?WVM0dDB2Yk5oUy9WN2xMR251aFhsWVk2NWVsVVgrL044SzlZeVZ1NmdiZkZW?=
 =?utf-8?B?TUY2M3plY3IydTFNaE5zL3JJZlp1MWFUSDJVUjc3Z1dIeFpLY2pPNDFFVUxu?=
 =?utf-8?B?cFpYakUycDdOekh6amdKYmwxenlsMmlMYmVYQ2h3RHdlRVJFNXFXaHZmQXRi?=
 =?utf-8?B?SzRtelU1TkJnYjJQbklMbC9SNWlXNFpvM21oQ0E5bG42M2orNGxsWHN3MzRG?=
 =?utf-8?B?QVJwL0RweWYyVC9ZbVk0UlA1QlBSaFBzY2VCZ0FEM29WREl3cW8rTnBnY2I5?=
 =?utf-8?B?TEQ1K1Y2SFRnR0JaZktnZFpwbjA1U0Y5Z0dpbm1TSTdYckVCWE5od3ZhMkxo?=
 =?utf-8?B?Vm1uVTVXL0xSamQzWTdMdHZzc2VSYlQ1NzQxQ1NEQVlVVUZuNGEzOUNDc3ZG?=
 =?utf-8?B?bFNHUEtjY1BNb1NLSTlMVDBIdVlJWXZWYkloSW0xNXU1b0dzdUFtNW5UWjdw?=
 =?utf-8?B?cWI4L25EVEtlM3NkK3R2QlNrT2xNMHpTVjcvUzVRQ3M4cU5rc0ZMaXExNGhT?=
 =?utf-8?B?WUI2ZUVRVSs5SGRXSndaeldoOEhpcUd2QWJZSkJKOEtWeVdieEFoOHhmWlgv?=
 =?utf-8?B?L25wdVZSNnRwcEt5em5nWDd3TlNnK2ZwMjVaZW1CdFdkSmJjUkRLblFyUDRy?=
 =?utf-8?B?RmJWWm05K0hUTWhuZm5RdTlEdDQrUFJrZjVPYzdxS3NGWXRjbTQvR3M3U2li?=
 =?utf-8?B?bW50UlZXb3lrdVlyTFM0SElzOXNkZEhzNGwyOHN3UlRhTzdUemZHeHYxUWR6?=
 =?utf-8?B?K3hhaHlRQnR1QjNmM2V1L0VrdmhtZUs5c2loVzdkeUZjdGNMY2FCU1ZNSlZG?=
 =?utf-8?B?bDhzYmRiWndPSFlkRGdiajRlZkhzT3dSd2MreWlDaGVsYS9Kbkw2NmNQNzA1?=
 =?utf-8?B?bFpaRjlYTURFemZtcUNIUXJuZ3p6VHZlczNEVXhPUWdzaFdxZFdyZ1I5UEdn?=
 =?utf-8?B?QVlIUllpSUZ6OG1lWmthUm5MQVlaYXZ3QTNXRHFnZHV5YXRjYjNXL0VLRDF4?=
 =?utf-8?B?VEQveThhWUFxV3FySytXNmFuQkRsZVMxbGhqSjhDMWlmbzczdUJBUDRxY2Zo?=
 =?utf-8?B?czFyc3pBdTB3SytMNTdVV0JkemVpOStPVWFiS3hlVmNoK05hSXVDekF1RUZZ?=
 =?utf-8?B?NDdRSXNhMkw0WlkxWVJuNjQ3Smo2RVZydlgxaFU0ZncrTVZWU0cyMko0Nk5S?=
 =?utf-8?B?MllrUHBmcHBpVm9KWE5hVEJSOHhZMUVHRVFBczhuMU5sVklPQ3NSY0dxb3JS?=
 =?utf-8?B?S2w4OHBVbEhMTnQyM2tiNFI3SEtMT3hzWEI1QmlLRUFlcE5teDBoQ1h2cWsz?=
 =?utf-8?B?VmtBbENTYUhSTkJUQmdIaXZtdnJZRUxuQUFYS1FkdzdIVE84OTR0bHBuOXJu?=
 =?utf-8?B?VkpkTXFKSnZqak15a0ZLdnVhMk51ZkxQczdNcFVWT0xRL0J5RXZHaFBaTWV4?=
 =?utf-8?B?UWd2bGxzSUhvRGI3Ym1JMXUrWWZZZ2FmWEJ1YnpIS2Y2MnVRMGVNVXlqa3dF?=
 =?utf-8?B?a3kxcy9HN0drYXBPRHN2bmZ5UjgrMmx1RkFvejc1ODZzZ0UwbTdsem5RM1Bx?=
 =?utf-8?B?YWVGK2hMNzUvazNFSUhRcUVKNEt6U2ErTmdobGtmZ040Q0hvV3h5QUNWRFNl?=
 =?utf-8?B?MnRHdlZYSnFXZnFHOXBxTy9uclMwelFacmwwQml3bmtFdlZsdEZLK3I0bHVj?=
 =?utf-8?B?MHRVQnlZa21wUHd4V3p4N1kzbzdwLzdESVpIb0pxdlVGNG5KczdlWW1ENUNX?=
 =?utf-8?B?UWZjVCsrUEgxekwwNzBMUEVkbno2K3huYTZGWHV3Mm9DK0pKUVdHTVk4aGp4?=
 =?utf-8?B?SzZ6L2Jjcjd2M2hlYXN5b0JQOFlvUzJuaVp0MS9uQ2hZSEJCMWtqaE5sem16?=
 =?utf-8?B?bUR3cjRqT2U3NUFSK0JaTzZMeGFzNU5RVk5Qem9UNnU4WitEaExTVWFVSWxy?=
 =?utf-8?B?WU9FM1liWVZBQTVyWTBXWnViYjhacWpIVE9WUWh2TXhubkVVREdvT0x3RDEy?=
 =?utf-8?B?eWtrYkxrbGNMWUM5TGkvVDAyQkllb28wVFhINGJKd0JzR3VmeXBFNk9yY1VC?=
 =?utf-8?Q?Szdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1R6UFFVblVzd3Y1NnZLeDNLNzZqdzVnblNZbFhyYlo1SEFkS0xZV2ZjaklZ?=
 =?utf-8?B?REpmRm1mZCs0ci9IVkdLcXl1emk4VDdNMXlHaldRMVpidnRJTU9SUUZkUjB1?=
 =?utf-8?B?ZFptbGsyVWFtUE0xVEVSeG5JY0tJdTJwOW1EM2FDZGtCQjVkREE5NVZoUWp4?=
 =?utf-8?B?ZXhRc1VBWVdIc0kreFh4UEZscENkNXNFYjZKUWlwZHFjN2FPcGQ3bDE2bU40?=
 =?utf-8?B?SFZjZGd1MVNiZms5RjlJOXJIbVN3M3l2NGNlZFVVTmxqWThMQTY5QzVZL1hT?=
 =?utf-8?B?WmR3SWM3d2JuQVFUSjRaUDIzeFBLRXk1ZXlxNVFKRUh4NXFjaDl1WUFuc1Y1?=
 =?utf-8?B?bk1TakpXdWd6bmcyVFp0TWF0aWszVDJMeGhWM3dDVHp2UFljVFBscHU0TXY0?=
 =?utf-8?B?ZUc2MjV3ZUd6NENwVGdZK2JkL2ZDa3Jwd0FrQXBUVXluWksxMkpEMUxUTWl1?=
 =?utf-8?B?alU4MXpVVk4xdlI1ZVk2bElYTjhaSnZDcU5tRVIrUHBMZVlzaDZKcGxhR3BM?=
 =?utf-8?B?MFBTUHVPV1FUZm9ZK2poR3kzbVMvdlBadGVERGRsWlN0bzZCZExDZ2x5Vysy?=
 =?utf-8?B?TjZPLzVuTURyVko2c3lmZkdTTTdhaUhFdHVhL3VnUW5pbFhrMzBDd1djOTZY?=
 =?utf-8?B?Zk0wNkR3TDJtZVlyaG94UDBkeExCNWs1anNLakVFb1E5Y05KWms4aVIvQU5X?=
 =?utf-8?B?Z05QOUtSNmsva2NiZGR3Z0ZxL1RFQi9ha0o3K1VaR3d0OC9NQ0RGTkpmdnNG?=
 =?utf-8?B?azUxOHZSODdMR21sb00yQzdSOTBTMVhRZDgzazJFTmlYSzByVG1KUDh3OWEv?=
 =?utf-8?B?dFMyYUtETDNwL0t5Q2M0dzVSbUZ4UjJMVDl1dHQyNGd6OFp4ZlQxSE1TSlgy?=
 =?utf-8?B?QXJ0dmlLUlBWWmVwK2FNemZpWUZjNUVSWUFOaFM1MHExSnNjdWpqTGh4bDFL?=
 =?utf-8?B?T2JKUU5DZlBqcWkvcTcybWNIdnZwbmlxNnNwOEZxOFZiMldoV0hHQVovNEcv?=
 =?utf-8?B?ZW55Qk8wWndVNXNYY21JTmRCWUQ2TnNrSFBTU1VtaWZHeHhwajZEb1JzK1ox?=
 =?utf-8?B?aWJpZCtxYTVGbVN2bmlwbmdWRHpKVUoyWlp3eTFrWjZmTi9nTWREUU9GNGlh?=
 =?utf-8?B?TVZ0WGFjeUJvL2Ezd3A5bGp5WUw5OERDYTJjTVphUDRiSjRDUGVMODk5RUVy?=
 =?utf-8?B?cnplR3pudjRET2pKQXpaaDRMZTZ2dXNZSnRqdEZDdlFOaXpkZk81dWY2Q0Vj?=
 =?utf-8?B?SVRCNWdCR1ZPRDFxcXlMbjNheEV1dldmR2JxSVdSNSs5V0RJK0ZXemFuZUxa?=
 =?utf-8?B?M244R3BMaWVGZTdVbk50dzhYZnBlcUNRcXorbEFhZnVsbzJhQmRXUlRLc0JL?=
 =?utf-8?B?bjB3ZXQyeEFsdFdKbkdNdWFWVUNTdGlPTmZqMitLQkJmT2I5bCt0cVloUXk1?=
 =?utf-8?B?cWVlc0YxbCtXY0dxallldUlMVEkrR0RWbnRlRXc0b2dMTUQ0M1F4VEp1VlBH?=
 =?utf-8?B?cUhiYU4wbUYvSFRIQ0V0dGV2R1lxa0NzUmc1V2F1RElTcGlnSjJmTS9zdXND?=
 =?utf-8?B?aXBjcllrd2F2ZGxqbTg1VXZmZjNQaTFoMFMvZmtlSVB6T2kzYUJVY3hMdnF5?=
 =?utf-8?B?KzZoZy9RZEUwQzhicHp4dzZGVEtGRzZ0V1B6ZW91VC8xdzVZNzFVUTJvTGJY?=
 =?utf-8?B?Nk5Rd3NaUjEwTlZMR1c1bi9lRU15eEpGWm0yaDNJR1lrY1pPTkQ3ZnZpdGYw?=
 =?utf-8?B?ZytjZ0NNczRIYkhXYWVUMjhkK0xiekpJTXV1TG5UODVoY1NrVHdtZU5vekVE?=
 =?utf-8?B?WEFQb0hDZTNuRUZZdG1ibSs3WSs3VHVUalZ5eXByWGQvZFc2bW5pNjJkVkJ4?=
 =?utf-8?B?R0d1ZlpPNy8rRHZKUXVmN1FoaDVQT2Q1UFNGeHI1Y3lXZVNGTDJJekw5M3Rt?=
 =?utf-8?B?U2kzVjJVN1g1MXo4Zy9iM09IMm1Wb3RLUjRHSmRqT0ljK2VmOFArYVNCS0Ju?=
 =?utf-8?B?YmdENldTbkk5QXNiSnJMUlBmTVdURXplbkpkRmoyOS82Z0NGYjd5NXpaeFBT?=
 =?utf-8?B?aUtRNVI0U2NpOVg5cllyUDk0R2srWlUzU0NyKzV0cnJGOEpCa05tbEQrSllB?=
 =?utf-8?B?UU8valBaVEt6TFBwYlFLNGx6bWNYVFdYb0YxRWpnTVY1QkUwSWhVRnpBYkpT?=
 =?utf-8?B?QnFYUCt0R21veU0yY25FaHltZUlicDJwY0wzR1BhNXYvREloRHM1cmR5SVpP?=
 =?utf-8?B?TnFxOHZoaXRQL2dwNDh1OTNsZE4vNmh2andFSjFBUmJEaDFUSzJYZnRhM2l3?=
 =?utf-8?B?Q25ORWtIeUFMNXRRbTJpK3g3b1dJRjV6OE9KdnZVNzBPMVQ4SlFqZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e735c7e0-ca4b-46f7-0d2a-08de58b82170
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:41:39.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9Rw4TpWNvQFATcRT2aHANlaxogLjb26ESzp5dwfyOixGnKxG1LgVJJGK/y/mhI3uvq8RVAWdKpZi9KLHa1Ysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7139
X-OriginatorOrg: intel.com

On 14/01/2026 14:22, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> This DWC MSHC has a 128MB limitation where the data buffer size and start
> address must not exceed the 128MB boundary. Registering the missing
> 'adma_write_desc' callback function.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Fixes tag?

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cde0958..cabb709a8108 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1726,6 +1726,7 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
>  	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
>  	.set_power = sdhci_set_power_and_bus_voltage,
>  	.irq = dwcmshc_cqe_irq_handler,
> +	.adma_write_desc = dwcmshc_adma_write_desc,
>  	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
>  };
>  

