Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9884A3E;
	Wed, 28 May 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432583; cv=fail; b=NMGvANlp+Y3o3sJXlpK8johxim5pqHNGtwni9jENFA5PkJCbs3fGp7jIisW9FG5xAcryZ2UlzQ+Ho7RaRxt3Ix06LMK2YTrbn8MEC5IZs6KBRpNswmHdNpdGe3CGalwfLLBVxQivRywHCEpaommG3y2IFjk1o2nDef9R4+6ATmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432583; c=relaxed/simple;
	bh=+gfVvGrB6fQM7oIVApGBloqX+kngnVu9v80H1IlRegU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPoc6TyCnDKSRlQAVvmx1wPfqetV1HfTO+2GwPnUv04rLUiGO4srJd88yOyUL0V14Xr51U1Kh4539UnrV2Eak3V3BfgjFreNllcBe7eAFukGlJncPUegK1wcu5+7pzbUkcYID4jbUVHVJN9ZypfZKU4SXPUmXDdg+r/SBEaObgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG2Vpe5o; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG2Vpe5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748432582; x=1779968582;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+gfVvGrB6fQM7oIVApGBloqX+kngnVu9v80H1IlRegU=;
  b=kG2Vpe5oWwd8YtLhpwmbxupbvSuwXozV/JOr+NZ9H2EX2OQdSsBrWLjn
   Br81zNWbmJiEiH5ESIVT2NTM8FwZBnLUEh54kDILNVlrIe824B9Hpq/AH
   ZO6k+UVciHtkA5T6FuimlZ7dDwKKYyUNwfEZsjccTAabvsPGIlsA4VU+x
   TYOiRTjrtHJplPhfWadW4RHpzKwklziywS+Sd8sM64g7ZZWTGfF//GVi1
   K73y1YAkFA8ShXfJifAyfDf94hKHi+FiliWp+FsB7UPDiHdOv8fGWTVan
   J8hTgXKzmxBxq+u9dDUGvQAuNi6l9PKOD8H4TnRqsJfhgHZzv0CwnheX0
   g==;
X-CSE-ConnectionGUID: zhCqIxF5SdmZvgZKVeUrfg==
X-CSE-MsgGUID: wISIqd0rQGippitu+1iqKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="60709737"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="60709737"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:43:02 -0700
X-CSE-ConnectionGUID: CFSqN27JTISthlSnKHzR3g==
X-CSE-MsgGUID: l67YmZXDQ7G+hHWnESqe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="180450127"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:43:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 04:43:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 04:43:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.48)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 04:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh4d7R6buV8DMDdb4IzYznE0aE0D7jPC/B50SJYt6ov77ypsYTytneVUH2IjXiRYo49xlMFCl8DByiO4mAb5Wwa/euZdCI79J8pOAshXLWJl2YnI346Vc422tCJTLqpgxXgG94E+gn0ScxNZKeju66utaJ5VfJ9ciOyOGXvtMs4OwXNT99wbW33aG6GPKw8PEkGod3vNXk0AXJAE+jMHZOGLyQ2evZPOLErJ2mIhiST91tMPlRVqH02iS/VvaAx4yzTTqdsRw5OGLOdAgDhrqtBrZK3pqgeZvLkXOvoKqjP7fOsWD3ORspcp2UUwpC80up5Jr8t4q/oS1Wj2cPGe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwoJK46IJyYc29SAqvlDqI0PECssRRXE+6yyyMhOkjA=;
 b=QLV9eyCp+sSCIRcQxPSVUDWUH/pF9QW5AFOfSnVOIVGRELfdtckg2nHdBWW6afDldoED+Wic+rybsLlWemPlKjGRFgBWsyC9vQFBlEq6ZpQdvbTSMO/WsQO++3lC8URjJP/cKkEcBu8WkkTiS/iuqjnf3bzofWhaCNvo1pAQPmag8JdRABZ9l7zAd3Hl3gFMelN8se7PQojMa4VJHvyCTerxd63+aBHYZyLIKjFuHeStuq1Vgf9E+f/JkD9LscXXeLQdGSDB/xDCBqFr7nKSK9T6IKOlS9H3xR+b8HyqxKQS9R4ciLSJO2MREsFYkqchULRYlvovtfH3znAUQOOjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 11:42:31 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 11:42:31 +0000
Message-ID: <31b0b210-de34-4816-b7bc-2f7ddb7fa375@intel.com>
Date: Wed, 28 May 2025 14:42:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] mmc: sdhci-of-k1: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <kernel-janitors@vger.kernel.org>
References: <aDVTtQdXVtRhxOrb@stanley.mountain>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <aDVTtQdXVtRhxOrb@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|DM4PR11MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ac67e5-7835-4ca1-9601-08dd9ddcbb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1ZHMzVPU2tSejlyYUlFcXpyRzNnWlpZWXRpYWpIRzRqUUwwZ1FDU0pZaWIz?=
 =?utf-8?B?UVVzZzlPSW9TL21YdGx5VmxhMGlNWVYzcTVCU3EwNjY1SzRTRDdWcXptbmtE?=
 =?utf-8?B?YUd3VFRTeTJIektINFBReVpFUmNZNEQya2Q1TjlyNE9lY0VXZkJPUlgrNnVi?=
 =?utf-8?B?KzRwR3BBL2dRMWRHTHFDcXpKVjk0U2FVWEtrNUhJdHZJazQ0M3BzSzhJUVUy?=
 =?utf-8?B?bzAwSFZPd2dOYTkrWCtoS1dENzRWOWpnYjdvMlNBVGpJbFlZbXh5d1QzU1JB?=
 =?utf-8?B?SzF6TVRQUWRCVXFUVkxmM3FNbW5jaDFqY25ZcTJtVHg0N2JMK2l1b0ZRdG1F?=
 =?utf-8?B?NXpZMFZxbGNON3NOeXBPN2IyS3orSmFRMHBMTHc3NGpNTmI5WUZVc3RkVUcz?=
 =?utf-8?B?NENyRGQxN1dNbHpBZXBYYmhxbjFmeFA0ME9rbkFteUR6ckJiSHQwUm1KNE8v?=
 =?utf-8?B?Y3NFaTV1bXpYZnBEdTZoalRGamNCT3duaEtxMmNSa3FSUDNCUmZ6NzRuRWMz?=
 =?utf-8?B?dVc0ZnIwRllCRHRTbjI5ZEVuTVVJU2kyZmdTdkNlSTJRcGxEQUNzRHlNVnla?=
 =?utf-8?B?akMwU3pQWWRWWVAreExGLzNpYWo5ME9ZeXpIQUZJOVY0NG1uYjBPQk5oaTNR?=
 =?utf-8?B?SkQ5YXRQQUlTV1VUaEtzdzhqeHVjSjFSbGR1M1p6ZjFLckFIZEI0RlVwN1kx?=
 =?utf-8?B?V3AySGthRndPVVhkVWIzWjljTVFvMDZhZEptcllodm5ybGNucFdUdmNCdUZr?=
 =?utf-8?B?RUhHdmJjaVBlSUZPTStuVUhmU08yd3BBeWc1eHJzMmg2Q0t2WnR6Q2ZWQlVC?=
 =?utf-8?B?YTlNcUZITU5PbUNTcFlWQjI1OEltS2U2YmNTa3RmM3FSdW5mL0x5UlFNemNV?=
 =?utf-8?B?WW1lSDJGM2o4dDVNaFpIZVA2VStxd1plcVBrcEpCZ2lxUVV3NDcxSnBObVpx?=
 =?utf-8?B?OGZmdXMwZjJPRmN3RldkMkRINUFuRGdqOHErT2Z1K2hoRkNFWno5TG5zYVQ1?=
 =?utf-8?B?SUpYV0RtUFFoVjljdkNqeGl0QS8zU2pleTdiOUlaS1F4dlhXRklLS3JqdTAy?=
 =?utf-8?B?d2pKYkFaZHdXbHZ4K3M5cmhHdHAxU1dYZmVPWXZ0QnpJWTFVMTFDU05EMEtU?=
 =?utf-8?B?b0Ezd3l0aGtGbU1QajJXbDlqNDNTQnFJNkFQTllFQVM4bjU5emthakNSQ204?=
 =?utf-8?B?Q2ZsK2NrWC9pMDR4UkRERklXNWNNQ25NblgwWnR3RFlQKzJNbkI4ajRvSzhC?=
 =?utf-8?B?RSs4TFprNk16MFVIdHZaUW82RDUxOFZ3VmIyMndGT3gyNjJzNE9xY1ZyQ1hh?=
 =?utf-8?B?SWgxRTJqbEl0WnRmL2R6VE9vNDY5K1BuUkdnbzNGbk5OZWdNSnpzcjBJZElC?=
 =?utf-8?B?MzdHZWRXZjMzMEpCZGErcEJZTXJNOHMyWHFjMkZlN0VmY25MVW5YdHNQZGdG?=
 =?utf-8?B?c2FwRktwQXk5OFBiSVhienNsbjlEWEoxM1N1WFg0V2FTSmFKMEpGTWsvdU9I?=
 =?utf-8?B?K00vSnMrYkV6UzhhQTlWRklGcXZ1TDRTVUF1bFhEUUFlUkJwdktBK0J1bVZP?=
 =?utf-8?B?SjcwNHdneW53ZmUxMi9ERjhjbU16bmViZXE0UFppOHJXUFBEaHh1NXRYYVNo?=
 =?utf-8?B?Zk9WRVUwSjFCUU9MclJFd3FoSlprVFdjSzRmZ3lpWG5mYkJITDFlS0ptY3ha?=
 =?utf-8?B?MmVFRHVHVEdTUTJJWE5KZGtRby9SU3dmYnRFTDNOU29rQUJQcWN1d3ZrRCs1?=
 =?utf-8?B?R2F6ZWhoZytzZWszbXFnY2V3eXZna2dyMldEUkJCYzF0VDkrcnpxbHg2d1JN?=
 =?utf-8?B?R3VlaWlYc2FXd21ITjZEcEpxZGlsVXJNQ0NIZHVaZ2lMU240WlZ6azN4bCth?=
 =?utf-8?B?UXozMUpaQXIyaWtMb01mMXNIRWNJRXYwMFNrejhhMHJKTG1Ba0o5cEl5YzBJ?=
 =?utf-8?Q?XvlbxFfNhZ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRiVW13cnNXUjR4NFFMRmcrMUdlMGU1VVZVejdRRmdtRmcydGg5c3R6dnBN?=
 =?utf-8?B?K0FweVE1Ky8zK3NiQ0FaSGJxWDd1Ty9SWWl4WGw4eWJDNmRMV0tQYW5OTDkv?=
 =?utf-8?B?eG5aOU1kUHJiZzVDZkNielQ5bVFSZElVMTQ0ejgreXhYbFlLcWtQWFpvR3d6?=
 =?utf-8?B?YnlKVitLdi9zVGhIV0Y0NjRqdVFHS21GdU4zOEVOMjduYVNmN2R1cWVHRFkx?=
 =?utf-8?B?SEJwRWc4TjZic1k5QlRmTmZ2M01kYUUxNkkvNmVTN2JrRENhZ2FQTm95TzBm?=
 =?utf-8?B?Rm9wdHMvNGtFMG5EeVY0ak9oeFpmREs4bUdSamR3eTlLS2xqY01wV0VOUmNy?=
 =?utf-8?B?RitLZGlkRGZoMXQ4OFQzSS84UkUvNUY3TlR5VFNBUk4wdzFaakJrZ0Z1ejV4?=
 =?utf-8?B?d3N5VFhuL0RadWpmZzljMmMreXdzR0p6R0dFSkQreXhrM1lROEdKTUMxdERO?=
 =?utf-8?B?OUJwVXVZN2UzbjJYQVdUR1FSMG5Nem5PWmhwcFhUUExHT3ZGRThpZXBqQnI1?=
 =?utf-8?B?eldjUEF0ejBmTHJZU1FaUEhnem4yVnVKU0JyTnlsY2l2Z01PRHZ5WTF6TVAv?=
 =?utf-8?B?Qm5PSk9xOURYRVM2T2EzMm43RTNFVGQ1VnppVXFGWkpONER0cmJIQkowdExE?=
 =?utf-8?B?NEg4a2luNUVrK1Z3Q0lteklQcFR0YWFFVjhvNDFGY1AwSVlUeTJaVCtlN3hy?=
 =?utf-8?B?MWJtb1dhUjBJN08zRGRHV0hOODIrSEw3RXdmOElrdVR0ZnlQTUhXYWV1ajk1?=
 =?utf-8?B?WU9CbGExMStjcTZYK1dvZEwvZHhacllZeGtrYWczbGRTejNJMWRRb0htZjcw?=
 =?utf-8?B?TnF6Mzh2QW1QdGFtUnlmeGw1ZUk2UUt5UHVYQ2pqTTdZcGhRZVlhb1BMWENB?=
 =?utf-8?B?SXNXdWVUMEFURktDazRFNXdUVm5uOTRYS082NVFHb0ZiUEw3cGFMU21TRnZ5?=
 =?utf-8?B?Q0Rod0kvOHJ1MDRMdnl3eXdrVjJncFBDQnR4TjRTdUMxRm9VbnoxUzVBRVJG?=
 =?utf-8?B?VFNLMWRRYW1ZVVV0RjJTb0JwWU05UEdpN241UWJZRXFPUWNDRWVKS01xWSt4?=
 =?utf-8?B?K3N3MmJlUjRTcStJYVNmNkFPcWtUNDRhakZ5dHVnNUxhdXk1aUplM0QxbXZo?=
 =?utf-8?B?c0ZCMUl4eDdlbS9sdno0RllqcndDcmJXNUdWN1NuNTcwWnFLMXY3eGZkRlB1?=
 =?utf-8?B?QXEyTjRaSERlT2draCtmVmUwRldrUVlxZmsxU0lBQWp1T2NqTG1NWFRQSmVG?=
 =?utf-8?B?YVljeitFb0U5cGIwYjJwL1pPQ25GeGJCMHFqcStKTHRCZUZnNTV1REdkUjBw?=
 =?utf-8?B?clNZK1AzSzFRRWIzaXQrN3lqNkFIeWVwRjlPRGxYT1pRdkE2dXhQaHAyeHNO?=
 =?utf-8?B?ODlsRXlGSUNNZFdEa3pKWjZQbExUT0VKRlBtU3BUbTIwMm5JMU0yN3A2L2ZF?=
 =?utf-8?B?MEZPNFcrcFBBZHRxamNnNWYxVEpISldlYXYvTDhNRyszZU9FL1RTcFlTU3dS?=
 =?utf-8?B?U2tVSy9pQ3dwNDNOYnNUZFBzM2NBZ3RXTXd4R3NiSGpBaHJZOXhrUndwZGZn?=
 =?utf-8?B?ODUvL2JoZjluL0dWY1lwY0hJVEljREZpYlhBdElDWk9vYlB0N0ZGOXcwRVph?=
 =?utf-8?B?Q04zbWtUYjlFRGFaLzBLeEwvZm5ZQUUzTEwyenQ5eGpTZDg0dnNTeTRJa3F5?=
 =?utf-8?B?dGlFc2h0NVlzeTMxZ3NUbDh5NkF4SXYzeVVuSnBOeVBNV3BOaytXOXpHeFlI?=
 =?utf-8?B?NjBWT3NHazJSRlNTZEREVFJZblluNEVXbmVqQm9KbmxLdXJ0THJGbE4rdEx1?=
 =?utf-8?B?dGlUYUtpdldNM3JLZkVVMkZJMXRPaW1Gc0JNZlljNzlyZ3pqVHJpLzRPRERr?=
 =?utf-8?B?MmxyNGRpZWxzaFIvbE9RWDlrdWpQbzhwQWFDeEtFU3VSU1pIVGdqSm5ub21K?=
 =?utf-8?B?a0RKZWF2YXc1TWRFZXNDSndtb1hWV0hCeXpLVlFCQWpTc003WFVMakpyR3Rs?=
 =?utf-8?B?WXMrQlRjMEpIU01sR3VjY2FXSDcyNzZwNVhMaVRQa2dyT0szQlZWZXVVNUlK?=
 =?utf-8?B?cG5LU1RHaXpvN1dSai8vSkQ4dElVK3NQRC9DY2c5TVVMWFlGWjdmYlRjSWNC?=
 =?utf-8?B?QmRJTmU0M2RKWmVTbmhXMks5eDA5Zjk3b0tpamRFaUkyM3FKbVk0SnJiQnB4?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac67e5-7835-4ca1-9601-08dd9ddcbb2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:42:31.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INqmQlgDAhFRzQ2E7My8qLISSoHsdOQ5a/UQp4tZheRUZRgxISYPYew+JPHhVqgbG7QbaUaAa8rb2qb6ohOBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
X-OriginatorOrg: intel.com

On 27/05/2025 08:55, Dan Carpenter wrote:
> If spacemit_sdhci_get_clocks() fails, then propagate the error code.
> Don't return success.
> 
> Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 6880d3e9ab62..2e5da7c5834c 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -276,7 +276,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> -	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
> +	if (ret)
>  		goto err_pltfm;
>  
>  	ret = sdhci_add_host(host);

