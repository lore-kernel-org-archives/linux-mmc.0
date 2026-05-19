Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081335202F;
	Tue, 19 May 2026 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187067; cv=fail; b=I/MPygb8+8bcoBStWqA2E+CM+93Algal813phRIE5fwm36TeDvLFCqNyNEAc20gG5ctpCsjcpKCP7fD7+r1ECjrvnEf7id7UDMol2TbHWUwViUgU5G9m+k2WLgEObqJnNemWlzeD72m/po9LxFU1OH7NsCJB9qlndx7cPUuTkEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187067; c=relaxed/simple;
	bh=aQ4DJX6LYcNwgm8aPn8ryAvBnlzj3En4gcpLIe/Cczc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mn57O3KNXoYwcRmjvNVUzoa/nrh1Jj4ZvlLj4178jButTETTy+xS5L+Md41xN+FrvCl+j/tNR+GR8TvU6/CChpeGcHHlHPbpdXkXUthB9b18jWHjF/TTCj/oWLB+Xgq+Z4s8nmvPLuwBH6U8Epjj/L8I0tskSlSgBFSVZ7p/TJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpg/Lu81; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpg/Lu81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779187065; x=1810723065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQ4DJX6LYcNwgm8aPn8ryAvBnlzj3En4gcpLIe/Cczc=;
  b=Gpg/Lu81TeIdxclRtZnlimg3V5A9RQit1Vk4wA8qk1etosXmZpG2pj0g
   1RhJKSp9JIWGlVu2CIzc2774cX3TPHvdn7B0zw5c2Rz7VF1PFZ+FdSJka
   2lsxuBX079bdqQD0d94T03/xd8/Epxd8IZB5UfOPKFVzrjihxoNgANGWr
   wuTYq9Ja3wBNPK2t1SSL2uLtFQKTos1Rv4hLPIiGVODPJKErrDZNEc/Uo
   CG19IrpNsjcaX1YI3NAmHyUprsSbR+mtXzA+hSe1dRH3gVJyJoqG0vGSw
   kWXZs93o/E8VPbjhcGXtcCEA7A4t+22C+Hx/U1lA5u+/VyBJa8oN9qh6G
   g==;
X-CSE-ConnectionGUID: 8Sn5jKYCTfO9/gDmrLGvJg==
X-CSE-MsgGUID: UYX9vPg4QaSHFLfOfhAG7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83917870"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83917870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:37:44 -0700
X-CSE-ConnectionGUID: hOUd3iroT4G0urRKXKLb+w==
X-CSE-MsgGUID: NiWC8eZIRV+OP+Nmj6GqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="277836784"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:37:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:37:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 03:37:43 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYILvKnzWQeQhZO7RQQmRvNltbcJqMy9ov8fk4x7bVDSOglBVxGjp897x7fRXPk48OhHVSXBHhqJcjds0EtxaWE7ARM9wcFi9p+TnnVIL8RlRoIdQrjmyjgqNG+8ZBsK1abkGKHtuiJKe0LE40onTYVdSRLnVjWVuDRLbFqqjX77DUXp9JznHiRxN358EspJigoFScDzVabDRnlf0gZDTLK9XmbJ2hXIz/Wbzp0VYDiT6iAjIeE+IdWxJsaUbGimfoEKzg3J+RrREHQW+l2ogYZpfwMjwhdo0QFP3+AN5A9O208WA2/DaKyHfgSoIAgn4lR6NvCKd/xhb8BB+ROH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhYqEewsmQlxuhj0FKHAM8/4HeT3UPSoW08d7XxZ8bo=;
 b=Gxb6vLkU61PMoggg42EFMZwi5/g28qkoMA+6hUhEFeoFJVQJ5KoOGDt1nSSrddBeYjojKc6q7m2cmFcbR95qOxA2jtJ68G78c3FkAY+JQ8wqiL6KbKMO5Zi8aZ+JPGQqoH8b2iCxG7zLhB75jaRnfqOU9DRZmvT9zmxkUidPliRW6lYvN0WUJA0t8s+VgRqjc2iGtU0Peh9Nwow6rSJnPZXYn8O2SUPceNeRG7GHyoxBJKwnI6+Y5SnUznSnEiLum+GqhyVTxbeC04h3nPIrgCnDAvO6DZtOeO5BUpge/svrLmxp+DTAZtKkRAQaVbxeGPPH5mu7qehgjFQc8SqljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:37:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:37:39 +0000
Message-ID: <8cbb1e1d-15c0-4ec5-8135-2416c8a2af62@intel.com>
Date: Tue, 19 May 2026 13:37:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Fix reset, clk, and SDIO
 support for Eswin EIC7700
To: <hehuan1@eswincomputing.com>, <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>
References: <20260509084907.779-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260509084907.779-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebc90e7-9477-48e1-1ea2-08deb592a653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: zFJOiLYiaALRSDOYwXbHaSijvomcHMoHFw58lZtuoBpzN+Db/5Xj2+JVXoos5P3oXp5yZ2lOikrh6fH5qhctq3dtuwz4qeWauUOWzdbH1bxjBI2PwtFosMrobVefEJGiyEgbf1t+4731D763z+MiUI2r+MSSPcNvByAzWruoM2iLDJUjBR5LXH6efX8r8kEOJS3nAEA18+GP1pLCI1EVtNX7STHXbbJI66mUpwLH92ZJ7pooK1aVCgyZj2Qxi1A5igBX0gmMw3f1ai4Z397GU81YxYg+F5OGNAmZbG61iWnUs98jAaGseTn6OBIEVEjtjl71472k+ghQkpQmfOopsa2rcdjGsncJ6kyMOcfwlthZsKTmdwUCDj6FpHU9i1jGVf4qEVsnLduCIakUbOgHe1TXBCbyH/McZN2AY5I+bYzudFy+W4pZXk0TQP5pHA/7hdtEsC1BNKYNg6q2dgDe9vL7yfSWFbUxHzW8q4Q1R0yogA7+leVVaxrtaKHJ6m1T2h8fZ1dbR5Dgh44Z9G9bdZ/u8qNcFrnGN3HxWXBXkvz1BGqYXdLb29LgB40rZslxcw/8Pyt3qNwl4twqsUDC4z3JF/CTdtEagWLcYogZAirhbulR/g20EreePTxwr4qUFJPlDPBU7Y8/+dWUEsUtPWWroQagqJV55fn7AVLQYjrZn55KsnAU53IzLIkConxMdLbXEvqw5vPfeinc47NHxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVhjUVFJRFNJeGQzcjVaMXBoRFQ4Zk8yVkdHbXUxUHVya2VWUXpGcGd1Q2Fj?=
 =?utf-8?B?L2h2aDFzKzJyQUs2aWRCdXc3QS9GTEJWVWlpRWlLVXVEWi9ITFoxb0tiSXVM?=
 =?utf-8?B?SVlUVjRySGR0aGNRcTFFTkJkbXZzeFlDb04yWmFuTk1PcCswNitXQVpBRU5Q?=
 =?utf-8?B?SUl0U25RTTIyNk5DU2RaclpIYjM3V2hjdVNmR0l2MFRGWGxXcktGRjFnN2Vj?=
 =?utf-8?B?UkJGM0Q0SGxDdmY4dEJzTUN0SHBOZThlWUxhS2g0UlkwS2RHRy96NTkzL2w2?=
 =?utf-8?B?Q0krNERUZW5DYWd6OWhUQlZhSjM5cE52UnNYRlpYb3R1UlZqU2dVRnUyV1Q3?=
 =?utf-8?B?eXpXZXBWZmlabnVLUmlMeG53Sno2TFMwV3hxb1d1dzcxU0NVaU5DWU9jc1lZ?=
 =?utf-8?B?ZEFBeFMraFB2QWVaZ25NNERmRHdseTgzM1BxRHZtQnFLUWNVcHk2cmxWZ1ph?=
 =?utf-8?B?d2tQUFJNRVJGT09PRk53VmVFamZOMlRXZEo0WHBNR3ZNREJaZG9TRVRrN0FO?=
 =?utf-8?B?enNzeTY2K01aT283eUZtY0FQbWcwS3ZzQlpXNXR6TXVwWll0cHd6dGdNVDRS?=
 =?utf-8?B?blozaWhxbGNTQXBFeXNxMTFNekoyR0NMNm0vWkowKzExQ1VGZ0pYMEJndkZx?=
 =?utf-8?B?Tzc4MFZITjlUejRkS1F5MWF1UGd1NjZDSkNZaTlGMURlcnlqV2ZlS3FKWnUy?=
 =?utf-8?B?VmlReWNFNXo2a2NHUGtoWUVGS3hIUGdJcWZrZDBwaHBpV2dMRWpXZTVyZzJM?=
 =?utf-8?B?bjV1Q0k5Q1N3UGZQbnhWTkVCcVNuaWNHRVhnUjZpV1JXelgrS1NUK3F4YjRN?=
 =?utf-8?B?VHJzdW1aRm9PZEFEbTBiUWpEKzFldnN0cll5L1pzbGFBcVJLNFpqLzQ2d2tV?=
 =?utf-8?B?dk41aGRLRy80TzhWdnZnL2N4UXZydHZRM3BBRDBYbU91cmZKTEs5L1F2b3VF?=
 =?utf-8?B?Nk5nZUlyaWk2SSsyOHVkN0l4WEhnV09pK0ZGM3hUOEJQZXlnSmtROEF5Nity?=
 =?utf-8?B?WUdSSUdlcUYzYXJqZnZyU2YrbWpESzRid21Uc3Z5SVp2TERSS2Z2a1ErampD?=
 =?utf-8?B?QXpMVDFoSEdaUjNwUjI4Q0JLMkJCTEo5YWtISm5qeFVqMm9OOVRPMnprRWYw?=
 =?utf-8?B?SlpNU3lWOHVJUVBoMEdGdWtHTWFFQlMxdEVCTnlpcWhSMUFHeXVXOWE3K0M5?=
 =?utf-8?B?Wjc4UkxDLy9RUjNlaEcxY3lBZVF2a0tuQWJ1cnFDcDVrZWNiMlhaR3Y3a1dU?=
 =?utf-8?B?UC8rV2F5ODhraGhpd3FFMTJuUDNTVHRZTUFWMGhCZWRzMWR4YXgvRE9yQzdv?=
 =?utf-8?B?Q09vSndobXNiMHhyRFBjSVFPdkROV0YvczhhamFnMjJCL1NFcVhvbVJMVlpj?=
 =?utf-8?B?U21BUUxEYXhXZnpZQzhJbStLcmJMeGJDaVgxMmJxeWhTVE5jTkJnMjYzRzFM?=
 =?utf-8?B?cnZOQlRXaHJhZ295RjRzQjBlbzlCMHNVYXBPelJieC9DRnBFRVB4RWF2Rk84?=
 =?utf-8?B?T3JVZFVGeEZ5TW0vRlVsQVU4VjdPc1hrMDJ0bHlxZVhWRVpYNlg2RTl2ZVZ2?=
 =?utf-8?B?eEVnd3lkMWV2WmR6SFRCS1QzNlAva0hSSHhBYXNVbE5uVk55Wk1KeDZIUExX?=
 =?utf-8?B?cExZaWxEc0hFYmIvRmR3ZG12RndMMDhwUmlJZlRKYUoxZ1cydU5jYTIzd1F4?=
 =?utf-8?B?K3lhNElZZzJXcy82anhFS0pnODJ2djFxNHdXUjJiOUNaUEhJekF3bGRtOTFp?=
 =?utf-8?B?UWxOalRCRmFmVGZYbEc1UTdLLzNJTFhUNGdwMkI1RlVSZi9QcU1iNVo1bmd2?=
 =?utf-8?B?cUFJZFpkN3BFelZXdVVGeXZrenRkZ29jM3kwM0xFeVZiQjZieVpOUkM0NEhE?=
 =?utf-8?B?S2VPZHFDMnB2RFg0d0F3WUZkWTc2YXltb1ZrWWh5RjdrL1RuVzRzMkpXY2xs?=
 =?utf-8?B?Q2c3SUdka2ZVU1A4NE9wM09YaE1FOTlDODQvSTdmMkk3ZUtYbGV2WW1oS3ZP?=
 =?utf-8?B?VzZFS0NaSm1zYlNWZ3NIaU5UMTRCaFQ1ODhObVBpaVo4eVVVb3ZMblR3WkRX?=
 =?utf-8?B?RW0raEpNYVNEdkVxT2ZRWWxNYzJjYVI1ZUdEMUR3aXVZM09TUXMyMHp5SUto?=
 =?utf-8?B?ZXpyblV4aW5hV05zZ0lzREYxUGlBeFF4bjVSWWVTQ0JhazVVcmROUGU2Zk5h?=
 =?utf-8?B?c1FSWjJpK29rQWlIY2xWRjJqbmNDUEx0VXd1L2lXbE9IOFUrYWFQYU9EVDFM?=
 =?utf-8?B?RzBsUG9kV3JyOEpPUHN3NExiL3JFTGlBZlBWb29haEs1OG5GaEZSaFpvOEZ1?=
 =?utf-8?B?UEloczNCSUg1b1pNT3JoS1puSnYrcEc4Q3RJcDEvQWVYZC9Mb1h5MEJQaThQ?=
 =?utf-8?Q?yeY+8WkwInQKC6IY=3D?=
X-Exchange-RoutingPolicyChecked: dwrEnVN0cjV3RgGgbmD5PeXWA9ZljsuYhTPZ2vziuCZaX5ziTApFIR7jykceVuf1SoRUqIf1Eq+vBJ5+hdAOH1A/zbkeoAehDtkDxAwANu+rMk5Ll+5+Icq6u3h3anUnWYYEw4Y4ZuO3Ih7tZr9gJ4+tx60aMmVrMm3D1fJpvci6WlP1ZsHp4anJ8t5hA+LfylQWgzbQddlNR+PdKuEwTsiA68K9XAhu1/YnDKgqtLewKX7mJqvZDfxml+q3eCj/SHLlRZ0D0EeacwMadOmtL42t3BGkMiz5pUrv+NLBF/TERYzIQ5xDrylwFRWDiwePD39+01llyO/+jRmc7zkHow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc90e7-9477-48e1-1ea2-08deb592a653
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:37:39.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4INzvABCiGgTgfYTTJh++jGvG4P7TRpxHAene1hPhwbtW6yTwRl/TjaAO+zYpYFHFBizFwxiB3vAmfIHqa52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com

On 09/05/2026 11:49, hehuan1@eswincomputing.com wrote:
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
> 
> Fixes: 32b2633219d3 ("mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700")
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> Changes in v2:
>   - Update the subject to mention the reset and clock fixes as well as
>     SDIO support
>   - Rename is_non_emmc to is_emmc to avoid double negative conditions
> 
> - Link to v1: https://lore.kernel.org/all/20260424070907.1422-1-hehuan1@eswincomputing.com/
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 44 ++++++++++++++---------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0b2158a7e409..b9ecd91f44ad 100644
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
> @@ -1594,18 +1592,17 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  	int phase_code = -1;
>  	int code_range = -1;
> -	bool is_sd = false;
>  	int code_min = -1;
>  	int code_max = -1;
>  	int cmd_error = 0;
> +	bool is_emmc;
>  	int ret = 0;
>  	int i = 0;
>  
> -	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> -		is_sd = true;
> +	is_emmc = (host->mmc->caps2 & emmc_caps) == emmc_caps;
>  
>  	for (i = 0; i <= MAX_PHASE_CODE; i++) {
>  		/* Centered Phase code */
> @@ -1614,8 +1611,8 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  
>  		if (ret) {
> -			/* SD specific range tracking */
> -			if (is_sd && code_min != -1 && code_max != -1) {
> +			/* SD/SDIO specific range tracking */
> +			if (!is_emmc && code_min != -1 && code_max != -1) {
>  				if (code_max - code_min > code_range) {
>  					code_range = code_max - code_min;
>  					phase_code = (code_min + code_max) / 2;
> @@ -1626,17 +1623,17 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  				code_max = -1;
>  			}
>  			/* EMMC breaks after first valid range */
> -			if (!is_sd && code_min != -1 && code_max != -1)
> +			if (is_emmc && code_min != -1 && code_max != -1)
>  				break;
>  		} else {
>  			/* Track valid phase code range */
>  			if (code_min == -1) {
>  				code_min = i;
> -				if (!is_sd)
> +				if (is_emmc)
>  					continue;
>  			}
>  			code_max = i;
> -			if (is_sd && i == MAX_PHASE_CODE) {
> +			if (!is_emmc && i == MAX_PHASE_CODE) {
>  				if (code_max - code_min > code_range) {
>  					code_range = code_max - code_min;
>  					phase_code = (code_min + code_max) / 2;
> @@ -1646,19 +1643,19 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
>  	}
>  
>  	/* Handle tuning failure case */
> -	if ((is_sd && phase_code == -1) ||
> -	    (!is_sd && code_min == -1 && code_max == -1)) {
> +	if ((!is_emmc && phase_code == -1) ||
> +	    (is_emmc && code_min == -1 && code_max == -1)) {
>  		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
>  		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
>  		return -EIO;
>  	}
> -	if (!is_sd)
> +	if (is_emmc)
>  		phase_code = (code_min + code_max) / 2;
>  
>  	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
>  
> -	/* SD specific final verification */
> -	if (is_sd) {
> +	/* SD/SDIO specific final verification */
> +	if (!is_emmc) {
>  		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
>  		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  		if (ret) {
> @@ -1756,9 +1753,9 @@ static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned in
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
> @@ -1767,6 +1764,7 @@ static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int
>  static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
>  	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
>  	static const char * const clk_ids[] = {"axi"};
>  	struct of_phandle_args args;
> @@ -1821,8 +1819,10 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
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

