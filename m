Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEE22DFA4
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265750; cv=fail; b=JLahS9W0+AbN6sGErRrcEb5gBx17vlPS+Cgk2v6gr3ACE/rtGMk0tlXeuwCtk3/GEHKmumueSv5gbgqe0crVSn93PpjbmNZ0pfALkylhiifoFuhh3uwGgpMfLMXONQw4WLyJbJi8cOaooW+7GQtdtFslbV+v3l8JqSaKrRaE9Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265750; c=relaxed/simple;
	bh=lcVtLd1zd87Ydp7aYku4PasKE+dfCxFoo4FKOZ9OTPA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBwwDfCVcScn3ahJJvu6SbgnBKOkQocLK2DOKXAC/zgcJrldmYdMxbXvNuw6ZmVOuI2ZO0qH/+9xLYOHZ5eVax04vYc9mK8kXAYZ4WeGGCVDfXHlDJR6/N/jTwsWBy4N9lKjL4017dbV00vjBrP8Vxx5RatW2aAFgCQo9AWciBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ypr+pAq1; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ypr+pAq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765265749; x=1796801749;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lcVtLd1zd87Ydp7aYku4PasKE+dfCxFoo4FKOZ9OTPA=;
  b=Ypr+pAq1rmjVgK5nOcwLtQ/bHhA5ReSJsIdjZsxUad9McyAhRs/5Wuqv
   xbCILMB3mAFk/08K6XeJR3Kx3e257PJ1c0qw4Gr5J0hnN07lJTPs4dRIQ
   RZmWVLFDxU86hCBa+AeenyYvGsBNTXZlxR9uH9rAPucIG4WxkYaC2Kt8j
   Z1XYCNuAC6kvpSL2I6G7/lILhoL6A73OEZ9MSemiTSDGoBMwnqm2d4gzB
   Zslu5XWY3uUbpyeZHYVHKb3aNkDqxgJkR1aPH4N3p3IzoWBqLzhSB+Po7
   ks8E9ZDEwp5BYqFJ/qhb1Qg4OBE+oDXrobs2bo/A5lCm9PO/DEQO6JpMv
   Q==;
X-CSE-ConnectionGUID: tQ37NyGLRNGyrJEEWsW0Hw==
X-CSE-MsgGUID: Q1kE1zoFT12u8w2F309vbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="77833621"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="77833621"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:35:45 -0800
X-CSE-ConnectionGUID: X8AlVBcrQPuky972uHK58w==
X-CSE-MsgGUID: XJ3jTHbcTyatyIcXjsx6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="226823548"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:35:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 23:35:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 23:35:43 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 23:35:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAU/dtk/MN1xapeQlagUPTSlARv4ZjJqYe2Csz3tt6QaUO8X+CizJiOESI4Gn7qonrb/Wgi1EOd9li2wIYpAp5tCldqOZqsS+Ve1Xk3QbkKnsXnBbgk4cmM6TPrU2ws7Bl1cHLHAtjlJV4cHULx/5kEem7xvuY81SkTxBvL+WHMvMx2J1iM4ZpOI4wucBflECbs3QkBbrMg0xkABiDXxksPquzsNVqU7WhGZvPFNpK6cIfgNpw41Zd2L9yQ4hcJ0QLVOV6vrR/hc88nU5cUUItuQzsCy8LvjsVmMR4Xg5g5fqqWPrDfUnaWpOMWnJSVwG74esABSAINxsCe/41jOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OU+g56vqPUuGf8cxmYuYb8z2VzRUkQPBhvgKTSNMMA=;
 b=Crr3YUe/CunFDNteBhU4dQx3+wSTLA7/d10y9TeSeUa97Ksie68CBfZzeE+hz0eRWMiB6iGiFpTxGb4LgT4/gCeyuIJV11ql9ruekdV7tee815IRcEwThWXaIotif5xP9QnRz6UotkkkccCvInasVwc5wI/FaD1u/qleGTyPElNuVXjm9ITXETrmvDTLfvGE72t5PDrFQdodFD+soTR3LAWkTME3BLVTpljHxb+JN///BrHolzy8iDmWIDtHh+FDdfRGzRdve+u1+CcLvuhle/VXQ6l02baK7d8ylm1FAMiZtS9Z4LUNcY7cH632SHf6UVTQid8SDqpYop+WyCKEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:35:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 07:35:41 +0000
Message-ID: <f6031c0f-ef68-474e-8e21-6ce39a2cb25e@intel.com>
Date: Tue, 9 Dec 2025 09:35:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Unaligned access in drivers/mmc/host/sdhci-of-k1.c (arch:ariscv
 soc:spacemit k1)
To: Mohamed via Bugspray Bot <bugbot@kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, Yixun Lan <dlan@gentoo.org>
References: <20251205-b220841c0-b1d85d237308@bugzilla.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251205-b220841c0-b1d85d237308@bugzilla.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: d57feda7-c462-44d1-17e9-08de36f58dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC8zaDYycTJuWGNHY1VaNFh5Y3JlSTFQVk11Y2xXTTVLcW0wZVpzUmgyWUlO?=
 =?utf-8?B?NElNc1YwTXJtMDd5Wkw5VVptSWF6QUVNQnU3U2ZLem9NUkFaaWVoaS85Qk5Y?=
 =?utf-8?B?MW90TnF2TlpxTThCTGxHcExlcGNwZTkyZjZtMENKSzVGS1JwOWlIcXhuKzB4?=
 =?utf-8?B?Zmk2TVpjY2tPK0FxZkllUk1zYWxIeUdWTXRUUFltZkYyTGpiK2dmd0VOemxI?=
 =?utf-8?B?dzUyc3dHbzB5ZzN1bkUzdmYwSGNRREx3WmJUUGlUbVNGWXUzUklUa3Z1R0tT?=
 =?utf-8?B?N3NRdTZaR0tSeTVONXpxMmlHa2NXSXg5SzVuSFYwWEhYdXM2WUtWZXYvTUZ0?=
 =?utf-8?B?QXdMdGJnakNEWm5LOXBuejdLdnEzS1gvMmsxbmEzUUVTbkJLUnl0ajhuK3B6?=
 =?utf-8?B?ZU5QTDhNWlVhZWY4R0NDNFlWOWQ3VEJyeitCNE5INnpuMXhMaXZILzRXamZR?=
 =?utf-8?B?VHc2cGRqQ0NUazBvQ2FiN2x5ZTdORDVjZU5odVN2RjN5S1o0UHBNQVE5VWtH?=
 =?utf-8?B?WE12UEJ4QnRvcDBaRWZnWjh3NS8vNjNiWENWcVdsUVVOZVo3MlVvclp4VHZs?=
 =?utf-8?B?UWhvdFhKc0wrRWE0SHlpekN2WjhLQ0NMS2Q3Y0xCdmZieXlORTRET3YzUWp4?=
 =?utf-8?B?M3dtb2JYYnhNQ2l3c3N4dE45bGVqRjZXSmJYdjNiWkxJalJycnpwS2p5K0Ux?=
 =?utf-8?B?OWxzQ1U2R2l6ck12OURLTU9zOXgyLzhseFRhK3VjMlBmbTVCOFlya3lyaERU?=
 =?utf-8?B?MG00L1RRWk53d0tISWNFZlkzcGZJMjVTRzhaZTlPRWo2cDdLZDdyU1l0Y2Zw?=
 =?utf-8?B?TFNpaUJxV1RnejBnSmxvNE9IY01Nd3lYYXRkR2xMditSTkRjM3QwVkdCY3FH?=
 =?utf-8?B?N2R1Q0szU3hQdHdEd085NGh4QjVEbHMyeWVkZ0ZMd2pkR2RzWEZtcDdQdTly?=
 =?utf-8?B?U1lIY09lTE0zUTM1UVdyTzMwczhPWHdXL0UzNU15R2VQYi9NMjI2empJaGt2?=
 =?utf-8?B?NFRJb0FZVWtvenQ1TzdMUmVBZWYyYUhSSlp2UG44NWgzWWZwL0o2UWxmRVV4?=
 =?utf-8?B?d29GVGxUSkdWNWJWYWV6YUNWVytta0M0cEVxYWh1c00zVkVia21FTVdkblIy?=
 =?utf-8?B?blNPNm5QOWxHK2U5azFNK1lqNUtKejN5QVpiT1p6czJncTRzdElmWVJNZnhW?=
 =?utf-8?B?RFM4T2x2dHZON3BwamlDckh0WXBnSmZoN0hpbWJCU0s2VDJlWmd4MkdBQXQ0?=
 =?utf-8?B?M2I2TkpOZGV2WTFsTE5DUlI3T2ZJU0pESEpidUNoUlJrNGdnS0RualU2SlhV?=
 =?utf-8?B?cC9tVCt4cHpxQUZDQlQyWmhabW9mRmtSSzQ1SmFaTGZ2WlpWRGNMbFl2NlZo?=
 =?utf-8?B?RVVaRFlhVUYrcWtWYjZwUjQvZFFWajhVS0txc3FKcFR4UFB4ckpRSjNwNzBH?=
 =?utf-8?B?TWhwdnh6bFR3VndaYktJVjF3TFQvU2ZDbUlhbXJVSnJrcGJ6b00wMEtJQkZS?=
 =?utf-8?B?TGpqcXp5Tks1L09qb0loT1FQdzFYM1p0QjRZYTBZMHR0SDRFZ2lWN1RRb2JQ?=
 =?utf-8?B?NkRVb05oZ1h6WGhvZisvdDFXS2czSFBaT3FvR0lteTFjNnBndjZIRE11aUhy?=
 =?utf-8?B?QmJLWVloMm9mNDdGLzhudnJlTzlDZWVSMmNqNldIeDY0ZUNRdGdPZlZxK3Ix?=
 =?utf-8?B?WVFCZGtJSHJ5aWpwWGw0UnhaQkJmL2Z0SnB1Y2s0MXU2UllXOWRBU0hWRjFC?=
 =?utf-8?B?a0pZWnlKMjdPTVpqTW5ma0NwdWJyOW1Nbko1YjFXQmpiVHE3dEk1Z00wRWwv?=
 =?utf-8?B?L0hDY3N3dHduenE5eWUwRXE3WENVRXNDR2Q4ZmVjUERGd0p1dHNCUVlIR01O?=
 =?utf-8?B?NEp6aWd4WEszbWFBck1nYjhBdkJUYWsyT216YjhNbVJCUlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlOMDNMakRDdURRd01WMXpibWtwaTdvT055SHFNZ0MrK29Ma2hQTEdwd2Iv?=
 =?utf-8?B?VVo2MkE1czY1Rm1SbzYvTUFYU2lIK1ZDWXBTK0VpWDJMOWQrSlVkcHJ6bnBT?=
 =?utf-8?B?ZDJUOXRua3N0UmU1S0Q5QkRTNkdzNDdBclg1NTVkS09oNjZGUFNkUUU0aEd6?=
 =?utf-8?B?RG5vVi9HSjZZVmtRV3Nac0NLZWFuQVlmbGJRNzRFQWk2V2Q4c2Z0TmlvUXp0?=
 =?utf-8?B?YW9tc0J6clpqVWxVRTkvR0dJK1lPYWE3K2p5dXNLcyt2Z0JpaXhYODdvbGdG?=
 =?utf-8?B?cVc3S01zUVE0aWdvaG1ScFdxb2wyaE5kTmlaNnFFRkV4bWZUV0xVTGZvVGhm?=
 =?utf-8?B?aXhRSDExaTJBMitPZG5UaWExemhsaEdyaEEvUklpYmFMVFVIYXVkTnpDc2Iv?=
 =?utf-8?B?MTZJOSsvUTd2VS9Xa3dVc1d2VDJlWXh1cE5hbFZTZFVVSFVXeGVMTlkxTlN5?=
 =?utf-8?B?YStLSUpWaEtkZlF6MEFnZmREMzRqb1VtUklUQmxKOFBaRWhzSlJQUTdEci9X?=
 =?utf-8?B?MUZrd01HdXRUZUJSc2hiUWhCeEFzMVlEV3NGQTA3OHgwZjhFNWpjMnlxWWNH?=
 =?utf-8?B?dnhpeExRV09kZXpIT08zUEV5MmhReVQxSkF2RkxBUlA0U1pmb3Q4aTQ3eGkw?=
 =?utf-8?B?M3BsK3FiQ3kzVlJuUkNKNFdNNDdPUjR3MUdOWmxsdHEraUVGZm9hTmhvYUNJ?=
 =?utf-8?B?MHE4aHZYb1BHbGlsSTJLZW9DYU5Ua2w2U1lNc0dBOW9tNjhJMEZsN0RYcVBD?=
 =?utf-8?B?ZmFOL25EcHE3Z3lISDQrZjFiSlRLL24xb2RMR0ZVbVYzSk5UdXpmMjFmMlEz?=
 =?utf-8?B?Z3BWcjhUVmNsZ0VYSmRCRkhSVGFVdmd5amxmbmVPeUUxd2EwczFEd21FaWN1?=
 =?utf-8?B?cGN3OS9vZmhSSTFpQmZBR056K3czUkJVZ3dSSndpVUhZV1dsOE1ndTNYN3RC?=
 =?utf-8?B?YjZ5dm1EajhabmN0MGNzOXdFMzlRaDM3WlhJNWo4bWVsc0ViQ0d4eGNpbE96?=
 =?utf-8?B?ZGhZYktoR0wxTU1RUTlKM0ZjTlR2ZUJhUldHNDVWenVVTTlCRlpxeEJaTkQ2?=
 =?utf-8?B?eCtDNDk5UkxOaWVobGFKa3pvdnZhdmFhaWJyQTRFVDZwdHpIRlV5SnZQREo2?=
 =?utf-8?B?Lytnb3B6MzFzeEswRjZJbWQrNHZkS3RCYnIxT0FlNEtQT2orVjBmQmRyYmV4?=
 =?utf-8?B?T0tQZjJiMmNyTFJkbDFON040VFRMaVBjVjJJTERQbW53bHNlNFdiSXl4UVFv?=
 =?utf-8?B?ZUVWbWt3ci90Yks1NEYwTmJhV09rUWdLaHRZaGorY2o3RzZtYytCUlduUjhr?=
 =?utf-8?B?QlRGdGhFaG0yVERwRVZWSThzQjl6eXpEbVcyMGdSWGhYZmY4cklpVUFXUXZY?=
 =?utf-8?B?YVdiT3ZiL0wxNFlGekFEa1BkZG1JZEk0SWRKSmxVMVllVlV5clQ0UytzRHZw?=
 =?utf-8?B?SnhTa1U1czlLZExlSXhFaktSa1hZUlBZdk9RVkYrYU5NUlp2VlhjSnM5UTkw?=
 =?utf-8?B?U3ZOMDVmRXlNd2c5YlU1VFpqU1J4d0dVSlNJZFFZbytPNDFyNU1USGswbWsv?=
 =?utf-8?B?ZWRvczVtQ0VQTFpDZkhHQTZXbjFFdWw5Rm5YUUd4V042bEpvRGtSQzk0ejlM?=
 =?utf-8?B?MlE4TzlXckNhZVRNZS9mVXphVitaVFpzV0V4SFpJZEIzdGxqYUR6emVPVjJk?=
 =?utf-8?B?ajZJQTBTNXVtQzIrYUVudUhrRmJWZkhXWWFQRmdSQlJrTHRrRXR6a3JiL1JD?=
 =?utf-8?B?UDd5YVN4RjJRNWlvQ0tUSHFoZlgwcE5MMlF0bjFMWUhDUXdRYmZ5TWdhcVJj?=
 =?utf-8?B?ZE04d2tzSVAzUXdIRkVUbzd1TW9Oby9qRi8zTXJtZzJUNFZJaVhIdXZSRjJH?=
 =?utf-8?B?N3NZa3kvclVyNzlEbTJYdkMrVDZ0TFpJWVVhQW8vQlU1Q3N1cFBmc1diYjJl?=
 =?utf-8?B?L3ArQ21TNHVRdTkraGFYMTJIVWNhQ04wNXdScmdSdXI4V0tuZW0zUDh6QU5R?=
 =?utf-8?B?RGwwUjZwMzJ2dW1JTGR4YjFQakZ3aGgyVGdRT1JyRUtOcnBUSEFLdWY4a3pH?=
 =?utf-8?B?NllRS1ZzZDNVL0txZ0tDcVp3cmhvV29YUEtGNzJpV3lmQ242MnBXbks1K2ND?=
 =?utf-8?B?ZDczUWJZNlJ4dTZNR2NFeUhSeWVJTG9IVnpCQVRCMjkyOTRBdGZQcysyMDlP?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57feda7-c462-44d1-17e9-08de36f58dcd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:35:41.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0BOQf9gI/1La9r0NpfNwYZxLyJczJuxZ62h3G7PK4IccfnRYhNLwSGIKJKzjcbmTTxn7r8hVnCBS1zuWnIIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
X-OriginatorOrg: intel.com

On 05/12/2025 23:00, Mohamed via Bugspray Bot wrote:
> Mohamed writes via Kernel.org Bugzilla:
> 
> There is an unaligned access in spacemit_sdhci_set_uhs_signaling that calls spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> 
> As SDHCI_HOST_CONTROL2	0x3E the helper function spacemit_sdhci_setbits uses readl and writel functions, 
> ie.
> /* All helper functions will update clr/set while preserve rest bits */
> static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> {
> 	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> }
> 
> So you get an unaligned access exception/panic/oops with cause 5 on the read.
> 
> To reproduce this you need to enable the emmc in the dtb as none of the boards have this enabled. It seems a bit strange that the commit message says that the emmc is working, as it is disabled in the emmc, yet there is working version based on 6.6 which does work. Obviously, it must be my mistake as the commit message cannot possibly lie and say that a driver is complete and working.
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=220841#c0
> You can reply to this message to join the discussion.

Adding Yixun Lan <dlan@gentoo.org>

Needs something like:

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0cc97e23a2f9..634a362fd66a 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -112,8 +112,12 @@ static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned i
 
 	sdhci_set_uhs_signaling(host, timing);
 
-	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
-		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
+	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO)) {
+		u16 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	}
 }
 
 static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)

