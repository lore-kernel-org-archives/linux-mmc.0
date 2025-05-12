Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0861254856;
	Mon, 12 May 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029919; cv=fail; b=Xrha7MXkY5dzIlz6xV8AHxZvmv3RTKZBlLiTQqQyqxXFCItLVC/QuMRdQKK6g/8loWQik4cBhzYQOPURFDrJX3VlDH17lYaDb8xfAXoUTiu3tynLXRDze34orZD+v6u4UJnu0C1ZikKVYIcc8ldnQbBT8ptWLdBfyPQG/zEWpX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029919; c=relaxed/simple;
	bh=n244wEykyrisKoqPNzszDcwW44KHf4iq2iwYex9gUaA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kzanwkixd5/05fRaM+3cdfBarBUQSxHR5IRtZ+01ILrBZAmwmQKhIm6QnpMWe5qUGX4aMNoEUQDKW/tPK7IYlO/zg6TXC2FDIxUzI+XPK7jT8zRihbj25YG26oY9sOei6Q9dEb8I6ige10Cz4AZtnwfiXIDUhTQyhsXOl5AuPps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ap6c5Zqi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ap6c5Zqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747029918; x=1778565918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n244wEykyrisKoqPNzszDcwW44KHf4iq2iwYex9gUaA=;
  b=Ap6c5Zqih5a5uhKxYH3ebdPSHZdgoaHwJPKs1TTkWIt+cjATNb3mNuMo
   R+J0XJqWLeGQ+/geXNZ+qVXJ2ZTjb6UO8wf0FcpYBmcJVaqmwo9PQ8jMf
   0SW6+TCeJsNmSOLl8vlZ7Wz4QYXsFxhbwYrqujVLrCm72P688iKLLHCxb
   UUrJRRENU3A/MBrbNjXgby2RFIV5D5pYAbDQTZbhiX0UybRvWEhNgIQ29
   B02VbQ2GnxLk/LELZjOASORZ4EFZCQDfwupp4dufpCblKSVsv+zxVz6Om
   Zsj5yHrcC93W4A+/4ClLt55xvSClPYenqabGK/HcldRcZ0+7aJOjEwLFz
   g==;
X-CSE-ConnectionGUID: 8burBytMS46QFQ5xM9tKpA==
X-CSE-MsgGUID: Gslj0VTBTMqLzS5EqsD5LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59474459"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="59474459"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:05:17 -0700
X-CSE-ConnectionGUID: Sp1uw1VBQ6aXDm6s5QML+w==
X-CSE-MsgGUID: 0UKEqxKdS8GTjV92cG7wBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137168780"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:05:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 23:05:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 11 May 2025 23:05:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 11 May 2025 23:05:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXgAghS//98m/QIVtwJioqieJxX1GoEiCOB25jn183gxUcwq8Po3iDlJ8SnzAvzEOc8xi6EIYWHu77SdGrTqzATj8yLAZCwzX/r6j9ATmHp2i4Ks7TNTxa+9RrYbWTPlTWfosMxCae6qng8+e5+JebTn0WGZBLQQkB0lyRGz/s/NAuC0brMvHgc0JbIFVM1E+dIwO1JXzwjZlsXX4NJY0dqznyZKGPtMfblS4myK674mbyhT7ClyWEu3W9Orf99g1Rv1sp9P8OkzinfzDLy2WbWtmp3ik9UfM6kx0qcMEZFRTVyE/ujvpmMbCqqOIbNpbMlZ0NsKXDbehd1RBKTVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO7LP6S2BrrG+kM3YPfUakHSaH+NTJ+TxUN/Nsf6AKg=;
 b=Mo8BFkyOVPigeShGKiBihJHQWiczD4dCRgccdOta7omLGdSKIBKjNf2lQ1H7+zztM92r5Th7jmzq+O3GCGTXga1mvfEDLfoOeNSb91GkxcIhg9Yx2+lQ+fxBVj9TVemtWwM6awY/X4i5DZULGYsd02J6PNsmcPIzbbGjftMGZGdyh8VuH2kjtaxcBJj5LDH5rnT5es2E7YD5bhu4UdtVxNeX73WnyL5HvJn+LsxEnU++O0wo11Kv6tGqEMBowWafdl/FHtW8S8RyJ964cuUfiu2+Qs9ziLnNEM1c0M3J6w6JhuvKKlMgTeVhCVo2h6AjAIacwJW+TpwaVMzNueet9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:04:59 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:04:59 +0000
Message-ID: <4cee9284-8f71-4214-8bc2-48bcb4030e40@intel.com>
Date: Mon, 12 May 2025 09:04:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Alex Elder <elder@riscstar.com>, Inochi Amaoto <inochiama@gmail.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250509-20-k1-sdhci-v3-0-526c35feaa20@gentoo.org>
 <20250509-20-k1-sdhci-v3-2-526c35feaa20@gentoo.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250509-20-k1-sdhci-v3-2-526c35feaa20@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0018.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::23) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|DS4PPF6915D992B:EE_
X-MS-Office365-Filtering-Correlation-Id: d57a211a-106c-4c88-af27-08dd911aed14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0NFSGMyWmUzSGQ0bitCbHM5VDdjZzZUTGF0THJnVWNld3I0elZQVFphK0JW?=
 =?utf-8?B?M3UzMFhuRTBGTkduMWZ5VzdHS29MTmZ6cmxGb0Nzdm1vQmR0OHBhamlGdVMy?=
 =?utf-8?B?TW5VSEZlUlJSSjB1ZzZFcUx3Uk1NbE5IeVNPd0tGQzF6bWhuQ0gwY1FQMnNV?=
 =?utf-8?B?MFUzcEh0bllTZWd3ZUpFS2RDWU9XRXA0THY0aWoyTnhtdnkwSVZFYWc0ZDBn?=
 =?utf-8?B?UUlKNkZpUk1yRGZYaTY2MDZuR2t4ZzFpYm9UM0F0akF1WFo3N0xvTDlZQ3BV?=
 =?utf-8?B?elFQaGtQZ2ZFWEhsK1Y1WlptckFLWS9FVkZsWnNWeko1d1lrVW1uWE9CYW1Y?=
 =?utf-8?B?cmpQVWxyQmhIUTJMYzlQcUxkR0ZRdDRyVTg2d3VsRnVPYzVPamRzM1lxbkly?=
 =?utf-8?B?ZDMxN2VGSFVkVU9ERFE4cEJ4NWpHQ1lWbFpTRkJobSt5dXN5NEV0SFVQREdJ?=
 =?utf-8?B?Vkh1L1hDOEpMVCtXaFZBNTdVQWtJZzBFb0ptamd6YWF4b3JXMDJaN2Q1bUh0?=
 =?utf-8?B?cHRJcEJzb2lMcVJoVHNnSnZ3MFR0Ui94bmo5TktESUlrQnpicUZlLzRMS0Iv?=
 =?utf-8?B?dXJub1hRNWtJTVJBSnpnQXBCbjdlSk9naVVLWkJ3bXNPNjVyUytLNkd5Y3dE?=
 =?utf-8?B?R3ZDV2dOQU9yY0I1SFRaL05KWXgzMVFNSVhiTkR6TW5rOC93VzZlZEpxUHVG?=
 =?utf-8?B?L0U3L05EcmhJN3JoUm1lVGR2cjc0YXErOE83TlZrWWJQbEFQczFRZ29TdXpK?=
 =?utf-8?B?ZmV2UU5yTUVRM1RZUGszemdlMWlrSkZ1UVowc0lkSy9MaTIvMFRVQUw2cjVl?=
 =?utf-8?B?dWNGaFNtM1cyK2NpdHJGL3RyQm9sUkw1QlZKUXcrbi9FQnhFdlU0REs0VDZV?=
 =?utf-8?B?eGM2U0VXYkp2OXJJNUU0Q0ZiaGorMzRzV3Z4dHdjNzlVZlZad3ZyZ3VWNytx?=
 =?utf-8?B?YnM1U0lybFVhZXRzNGNNWGVjck1GeGdGWmtzWFlWeFlVZGtVZG16UngyUGVa?=
 =?utf-8?B?cjZMYzlvZkpMZWt1dTROZ2xESERMaGdjWnVCbGY4ejVSYUlVWXdqN1VDRzhQ?=
 =?utf-8?B?OGs3YjViSW1RU09JVnBGRUZTd2JpRkdTYXEra0dpUktLbGduSHJwR3FOa1A3?=
 =?utf-8?B?ZlhFcTJWM1JoQlg3U1I5YVlxSVlYYmw5SE4xcmNwWmkwbnY1WjNzZXNZeVpx?=
 =?utf-8?B?a0V6QmZNamd4K1NXcjNpWndTOWpqZWNqb3Z4SzRERHdDdEdGK3RaNENKL0pE?=
 =?utf-8?B?NzdWVXJKMlhuZUVFTGFOdENnb0NxNGJGYldxcE1zeXhzSmI5ODdaS3hJYnBG?=
 =?utf-8?B?SU9vY0c5NXpyMFY2b1lGeHFvQW5vc1VReTdNVzVXSWFJSFBtMXovL0JTV2xz?=
 =?utf-8?B?RVZtYk96MXY1VGVmTE1zZk1EVHVrWjJHM1hPM1Y3K05JUklpdTQwSnhKc0Vv?=
 =?utf-8?B?RmYwK0FJVncrZ2I2K2FrN25leTlvNHE0R2N3QW5vVzNzT3dXY1B1ZTRoU3Fw?=
 =?utf-8?B?Q2pnbGZYVnlCWkZsVUxlUHdHVzR0aXpzR3hFUWlkc2JGend2T3ZHOThoSTlO?=
 =?utf-8?B?eDBIWGhiZG1xZ0YvT0loWUkrTU5xY3dZSm5BQm5qdUR6UDN2TURuMklMWTBN?=
 =?utf-8?B?OHVBek9Ld1l0azNxR0RBWmF0aXkzZEtPWnFLYmwzQVZLM2FtWXpENkxJYmRs?=
 =?utf-8?B?UGczSWc2VEV1MjBGbjdWaVlrWEFyTDNaVExkd0JRaWJRT29tZEFWd25LdFpO?=
 =?utf-8?B?TzYvRzF5TGlyWDdsMk1SVkV5QWpoYmdiTTBSOVRDblVkTjNjOVRpRlp0ZUtv?=
 =?utf-8?B?UUJGL3MvZm1uakRBM1Bibi9RTzdKS2JDbUQ2eGF3aDUxVCtvVnJyYzVwQlky?=
 =?utf-8?B?azBFZlBYK3Y2NnZ2SnloNlVaNXExYU1La2xoaGZCbWdjTmlnRStCZXlDMExU?=
 =?utf-8?Q?x70HZ7fcOnU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXA2NlV4OHpaQ05qSUM5elFVdWkzMjJ5VjROSm82dEg2SW5GMnFDM290VVBl?=
 =?utf-8?B?U2JOT291cnJRZ0ZBQU5hL05oMHVZL1JNc1IzR240UFN6YWJwMVFNQmE5THNi?=
 =?utf-8?B?YTdCSHc5Y05HYnE1NEVzYk9qUGpXaXBZb2xGWUF5UUxHYUNPTURKZ0oyajZj?=
 =?utf-8?B?RnR2elJkeHYrVGZGaWlDMCthbHVNWTRZNUdDdTlIdzdES3c3NTI3aW1FRFUy?=
 =?utf-8?B?Q09oRDdFc0drY3AveXRac1RBc1liVDlPbUNvNHordEZza1FwajNnb2xhMm1q?=
 =?utf-8?B?K0dxSVJUcmNqN1Zma1NYdTArbkZNUHg1eWNCVHpyYldLSVRXSk4wOXgxdjFV?=
 =?utf-8?B?NHVmamw0dnJma3BPU0JpclBwR3paQWdIb2QyallDK0V6OWJiSk1qMGJiZTNL?=
 =?utf-8?B?SUk5bDNTbHA5OWVGRVo1djRKd3JyWnpuV29EUkFaZHJVY2ZLdm1Eb2NDNVJK?=
 =?utf-8?B?RjdlUENPdGQ1eUxlYkZQLzc5NUlPR2g5MS9jSlJGK0MzYzZobU8zcVliVkJM?=
 =?utf-8?B?V3FRdytEYWhXNEVqQ3k4S2gxYnA5K1VXNXNmbGpaQkcveXltbkhhR0lLQXZX?=
 =?utf-8?B?NWE0b3VNSzRwVFpBdW9IR3Uxei9HUlh3YTJ6d3ZUSUhWck1manZXRlk1aXRC?=
 =?utf-8?B?ekdwSE8xQ1BHZENzNk53a2NUMjVJYVRLcEFrTmEzRFNJZnFKWndrOUp0ZVgy?=
 =?utf-8?B?YkdKdFlWMXdoSTJXU2Zhb2M1K1BESG5hbW8rblRDUkJhMytyYzIwbDhFRzB4?=
 =?utf-8?B?NGxRYjdoRzhNU1M3RWlXcTY5VytsZVkrZEs4VWg4Zk05Q0NZTDlDNUdDYkpI?=
 =?utf-8?B?ZDZnekRTZjhNWkZuS0ZyV0xDVG5QYXgzVm4vVklIMm1kWExPaWJKU3VSQWF5?=
 =?utf-8?B?VCtQZ1V5elZXS3FkM1BxaEtaMitHWENIZnR3eGY1ZExpYms3SkpydWQzNG8w?=
 =?utf-8?B?VGhrQm9sSG5nS3VwZzVrUnJRU2dRUTRMSEJzMXFJQ3dxTDlteVBVbUhGSFpF?=
 =?utf-8?B?RlJjWVdSRmFROG0zeHZjcWRZajVJVGZGdEhxMXpRTlFPeHNGVkUyQVBEdFdp?=
 =?utf-8?B?N0R5L0RCTG5FazduMkFtS1hTRitCR0I4MVFpYUxuUzVDc3BmMWZuV0tRWGJo?=
 =?utf-8?B?Nm55UlJLQnBEZklwcVVvYzZDT1NqU1JtTitKa29qVUtwR2k3cDkyVHhFbko1?=
 =?utf-8?B?TmdUUEM1cDNLNjJsOVpyeVJnM3VJQ0l4RGtQa2VXVmI0NFR4RE9XallVQ3Rk?=
 =?utf-8?B?Q0k5TlE5NHlvdkdOaUk2NzR6cTNLZkJWeG15VUdSVUl6MkhjbTNjS3o1VUdK?=
 =?utf-8?B?TTREUW9zR1BocFhTd0x1VmN2UkJqK2F4VVJhRDhkZFBhTGtheXc0aHVFQjBV?=
 =?utf-8?B?K0ZqbytMdmFqV1VERmxSbE9tbHhXbDhOYjUvTWdFWTlwVkdoTFBTYlE1cDN6?=
 =?utf-8?B?bUlBc3czRFJyOXlQMTZ2b0o3YTBvL2FUbk9TYkllVXRwdEorRnBUeUNzOUMy?=
 =?utf-8?B?Uy83TktLaFlReHFieXFpakY3dGU4TG1tRVNWOWVWR1VtRnN0ZEtISmhLK2Vs?=
 =?utf-8?B?R1NwcEVGRXBVT3daRWtUbDBGTG14TkFRZnJsNHl6bTQ2c0prb2hBS2tTMVRm?=
 =?utf-8?B?SVRFTURiUHlHYWpQVWFVWXhsWmZqZWRHdGIrZW5iNXNkSFdLUXJtbHIrc3JE?=
 =?utf-8?B?ZDdWR0VMdU9BSWFOT1F5aHBvRnM4RWt3TkNTWFlEaXFvOEdOSFRJd1NBVElK?=
 =?utf-8?B?V2gvS3pzL09oanMxckY4UldxbkhkaTRHdk5JWXR4V2cyYm5ZamlaMlhJU0Y3?=
 =?utf-8?B?TVExcXd3ZUppcS9JNG5WZEhtS21ld29jaGNBZTM1NmVpbklBQU45VkJYbEg1?=
 =?utf-8?B?ZXpGZ3F0VHNoSjFUZGpvQWZmbjFhZzRFMTRCemxNamk0dVFpQ1JXUmNpWjJs?=
 =?utf-8?B?ZmFwMmQ1aGlMMlVOTWlzL1ZSSnhhU0VvYkhGZE9kQkZrWkJoM01VbGtoVktr?=
 =?utf-8?B?TGtUQ0lmdjlaMGdmTC82cVZxb1FkdHJpL1kzM1k1MnZ4ZVk0dnpjN0MvSGRN?=
 =?utf-8?B?eCtYTit4MndYcjJXYkFJczk2d1VQSENUZVlzQjBNSTYxcVdXazRSaTVBbS9C?=
 =?utf-8?B?YldYUEorcG9JQ0pUVHVSc1AxYndWOE1ndzc4d2Q0TVVnb00wS1NaUmRnWFVR?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57a211a-106c-4c88-af27-08dd911aed14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:04:59.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++7t5V+iq4WXijnQv05baN1oXFwYTcW0VBnt747KkTaT1kEIjiafzRpdWMzP3JmgpObvd8eU0T3m0VZwly7TsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com

On 09/05/2025 16:22, Yixun Lan wrote:
> The SDHCI controller found in SpacemiT K1 SoC features SD,
> SDIO, eMMC support, such as:
> 
> - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> - Compatible for 8bit eMMC5.1, up to HS400
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig       |  14 ++
>  drivers/mmc/host/Makefile      |   1 +
>  drivers/mmc/host/sdhci-of-k1.c | 304 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
>  	  If you have a controller with this interface, say Y or M here.
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_K1
> +	tristate "SDHCI OF support for the SpacemiT K1 SoC"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found in the SpacemiT K1 SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_SPARX5
>  	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
> +obj-$(CONFIG_MMC_SDHCI_OF_K1)		+= sdhci-of-k1.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6880d3e9ab620dab5e5fea239cf1a78e1afe0d7c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/init.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +#define SDHC_MMC_CTRL_REG		0x114
> +#define  MISC_INT_EN			BIT(1)
> +#define  MISC_INT			BIT(2)
> +#define  ENHANCE_STROBE_EN		BIT(8)
> +#define  MMC_HS400			BIT(9)
> +#define  MMC_HS200			BIT(10)
> +#define  MMC_CARD_MODE			BIT(12)
> +
> +#define SDHC_TX_CFG_REG			0x11C
> +#define  TX_INT_CLK_SEL			BIT(30)
> +#define  TX_MUX_SEL			BIT(31)
> +
> +#define SDHC_PHY_CTRL_REG		0x160
> +#define  PHY_FUNC_EN			BIT(0)
> +#define  PHY_PLL_LOCK			BIT(1)
> +#define  HOST_LEGACY_MODE		BIT(31)
> +
> +#define SDHC_PHY_FUNC_REG		0x164
> +#define  PHY_TEST_EN			BIT(7)
> +#define  HS200_USE_RFIFO		BIT(15)
> +
> +#define SDHC_PHY_DLLCFG			0x168
> +#define  DLL_PREDLY_NUM			GENMASK(3, 2)
> +#define  DLL_FULLDLY_RANGE		GENMASK(5, 4)
> +#define  DLL_VREG_CTRL			GENMASK(7, 6)
> +#define  DLL_ENABLE			BIT(31)
> +
> +#define SDHC_PHY_DLLCFG1		0x16C
> +#define  DLL_REG1_CTRL			GENMASK(7, 0)
> +#define  DLL_REG2_CTRL			GENMASK(15, 8)
> +#define  DLL_REG3_CTRL			GENMASK(23, 16)
> +#define  DLL_REG4_CTRL			GENMASK(31, 24)
> +
> +#define SDHC_PHY_DLLSTS			0x170
> +#define  DLL_LOCK_STATE			BIT(0)
> +
> +#define SDHC_PHY_PADCFG_REG		0x178
> +#define  PHY_DRIVE_SEL			GENMASK(2, 0)
> +#define  RX_BIAS_CTRL			BIT(5)
> +
> +struct spacemit_sdhci_host {
> +	struct clk *clk_core;
> +	struct clk *clk_io;
> +};
> +
> +/* All helper functions will update clr/set while preserve rest bits */
> +static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u32 set, int reg)
> +{
> +	u32 val = sdhci_readl(host, reg);
> +
> +	val = (val & ~clr) | set;
> +	sdhci_writel(host, val, reg);
> +}
> +
> +static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +
> +	if (mask != SDHCI_RESET_ALL)
> +		return;
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +
> +	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL,
> +				  RX_BIAS_CTRL | FIELD_PREP(PHY_DRIVE_SEL, 4),
> +				  SDHC_PHY_PADCFG_REG);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> +		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +	if (timing == MMC_TIMING_MMC_HS200)
> +		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
> +
> +	if (timing == MMC_TIMING_MMC_HS400)
> +		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +
> +	sdhci_set_uhs_signaling(host, timing);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
> +		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> +}
> +
> +static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
> +		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +	else
> +		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +
> +	sdhci_set_clock(host, clock);
> +};
> +
> +static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> +{
> +	u32 state;
> +	int ret;
> +
> +	spacemit_sdhci_clrsetbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
> +				  FIELD_PREP(DLL_PREDLY_NUM, 1) |
> +				  FIELD_PREP(DLL_FULLDLY_RANGE, 1) |
> +				  FIELD_PREP(DLL_VREG_CTRL, 1),
> +				  SDHC_PHY_DLLCFG);
> +
> +	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL,
> +				  FIELD_PREP(DLL_REG1_CTRL, 0x92),
> +				  SDHC_PHY_DLLCFG1);
> +
> +	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
> +
> +	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
> +				 state & DLL_LOCK_STATE, 2, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
> +}
> +
> +static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!ios->enhanced_strobe) {
> +		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +		return;
> +	}
> +
> +	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_phy_dll_init(host);
> +}
> +
> +static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
> +	return 0;
> +}
> +
> +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_phy_dll_init(host);
> +	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
> +}
> +
> +static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
> +
> +	udelay(5);
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +}
> +
> +static inline int spacemit_sdhci_get_clocks(struct device *dev,
> +					    struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(sdhst->clk_core))
> +		return -EINVAL;
> +
> +	sdhst->clk_io = devm_clk_get_enabled(dev, "io");
> +	if (IS_ERR(sdhst->clk_io))
> +		return -EINVAL;
> +
> +	pltfm_host->clk = sdhst->clk_io;
> +
> +	return 0;
> +}
> +
> +static const struct sdhci_ops spacemit_sdhci_ops = {
> +	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
> +	.reset			= spacemit_sdhci_reset,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_clock		= spacemit_sdhci_set_clock,
> +	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> +	.ops = &spacemit_sdhci_ops,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +		  SDHCI_QUIRK_32BIT_ADMA_SIZE |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
> +		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct of_device_id spacemit_sdhci_of_match[] = {
> +	{ .compatible = "spacemit,k1-sdhci" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, spacemit_sdhci_of_match);
> +
> +static int spacemit_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spacemit_sdhci_host *sdhst;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct mmc_host_ops *mops;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &spacemit_sdhci_k1_pdata, sizeof(*sdhst));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
> +		mops = &host->mmc_host_ops;
> +		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
> +		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
> +		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;
> +		mops->hs400_enhanced_strobe = spacemit_sdhci_hs400_enhanced_strobe;
> +	}
> +
> +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> +
> +	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +		goto err_pltfm;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	return 0;
> +
> +err_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static struct platform_driver spacemit_sdhci_driver = {
> +	.driver		= {
> +		.name	= "sdhci-spacemit",
> +		.of_match_table = spacemit_sdhci_of_match,
> +	},
> +	.probe		= spacemit_sdhci_probe,
> +	.remove		= sdhci_pltfm_remove,
> +};
> +module_platform_driver(spacemit_sdhci_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT SDHCI platform driver");
> +MODULE_LICENSE("GPL");
> 

