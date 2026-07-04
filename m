Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269D3A3804;
	Sat,  4 Jul 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783163921; cv=fail; b=n4ZrXGDgUUO2thepqQp8M07UHI6hcO89Vj6cGxgQcBVTF4pq/6IgOop0hVeOhP3sFk/ngalkGspCMCZcPB/kETrBdyLP3Wp6tTjBXSZ0JNVYBRhTxZzkBxVxt6LzH3SOB1z598MDywZE9jdPWOfMQkN/CvWH7IMXOFI8YNfjbUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783163921; c=relaxed/simple;
	bh=SU7cqSP3pBT5VXzfHSYPWUkCS2/u7VMi/XxHM4g9HxA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZg4D3H9J8Zl3pqJ16k5JXs9O5sQhIbI1PGSs4C94fL0HQ6uT5yj3PHoDxoYLte2vchqxtRnBy2oXZNhsitF6RIrQ8Cga+OWaSF+/WtIdf3EI0Nuj+RIBzRKKIDjfYh+G+easbP5sEWqs96K6m5o+sqUKy28rugRVxHKIUZHZpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEcQD1xz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEcQD1xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783163920; x=1814699920;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SU7cqSP3pBT5VXzfHSYPWUkCS2/u7VMi/XxHM4g9HxA=;
  b=hEcQD1xzr2ZzEbJaKit+4hGBwlibzNqP3pzXKaltVwMdzo2/Ye3dNq+X
   cWMKcopGhwbTMQbN7QHiC54T1/Se0H3dg0826jlPYfL5sO05xWlBN1d1v
   zr2t1lnL92iASOO53+1i+NV7hkJUfnCOy/vDuzkQciwc5Ii0XLfpx/oiS
   7Jpbg7xnP3KP0in/K99kPHVZK7wrsyyhvL8A578J3OuzWYDy0IteiH2YX
   dVmcYlY6jqC4g9sCiDaQGRCgWvddPYFX8xZxvJcEs9Gh5+O0ZWSMg8/6B
   A33geAt5H5ffAIl5oCnqAZY5tO0ACgCgJFDfOSEoDHS/CHoA4zpGaOOXr
   w==;
X-CSE-ConnectionGUID: 4g5kRWc6Qg6Ghb2Y1hrN/Q==
X-CSE-MsgGUID: NF+uBAuTRFyB4NV0bN0Kgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="87560467"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="87560467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:18:39 -0700
X-CSE-ConnectionGUID: CgBWPnAFQ0u7dlvV8ZoqLw==
X-CSE-MsgGUID: C38xiRZASriIU+SiOGsz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250633794"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:18:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 4 Jul 2026 04:18:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 4 Jul 2026 04:18:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 4 Jul 2026 04:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBZQHTwPNpGpLZZ99whiT9/IVQCaF995jcvFtGeeb2juYdio4pWB1YwLc6G8tL09ALb09bv+p8LEa7kELUhA13T7cSr/gagX842yNfIOzIS+I1U6C+Wk8peyO42rEjkmPr0jXHls06dSqy31cR9p34Qa2abLj/YtEDUJusPR9d+MI7PPWgVLVIw5j67Da9JpNuH+V5uTEnF5tIy33Ta2fUT2L3EnIYkGEmbTUjgt6KBLJooaVZBqQY7oq4LQAqy0+gCiqQgZOj4jwyiCum9Cnu9+Je6Ko5TwrXSzWUWElKSX+p/Esdtcwmhd0l4LbRdia9M1h0SdKcCixg6/FtFF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y27+XhPZz6Wus4oZzbuOGdsAul6GrixAqeoTaaqsoU=;
 b=b5FBQaeIJcqbhMCDp1MBc5+2tSB2xCWsaXryFYULEKnwFzfY2M2ahbX0fsx1Ev4M1FUWetAljHsjzlumnF2r/QFcxyrh4dehVhAqDoUEZUAnl5aQyEhTlAzdWnlE+rYGX3yix/o4xIRnr6H/JtFb0js0NRI5YaTmN6/ooymroaFySqcQUjnXaPzltBC3+1pxyE/eF0VzJgrYx0qNgCTmOisyn+PLh/AthTuegr8DGc1gtwNLSGOClYZRLbVDXKxdYyMVoJN2wPc0LfBag/kkdikCYQ7QsatfnnYISq+oQavWzZUfICovQYAMErPapnxQtQ+6xqhJQsFyICR+SvkRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Sat, 4 Jul
 2026 11:18:37 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sat, 4 Jul 2026
 11:18:37 +0000
Message-ID: <1c57e707-dd72-499a-88c9-8129da28bf74@intel.com>
Date: Sat, 4 Jul 2026 14:18:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Ulf Hansson <ulfh@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-10-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260627201457.12318-10-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9a67bf-e9e8-4cea-214a-08ded9bdfe18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T6fGWAlIMzfmlIU/BNj4xKJdwwKdB7BeWwHEoQaEiWnPouzKjOZicTyyfDv4OW3zbQvfsK1XTYH/vU+xN/lEScsg0rW5AIpvQ2HzRhQEPnUGcykQyaT6BNpQYXg5qlfLGoOk01F4yEKsFkxVg58GNv5LA4Y3npCanEbaD9P3plOHHNhGTaZRqGJMKuikaGl5vUwyFn30EfWjOzcqwwaVgD8ozhY++UkkzCSwYUhHUoQqx7Qmk83Kh9QazPcpZwc0sIhkQiW5WgDBTm3hNNFEC1fpc79KUpvJydj/Ztb+Mw6Abr00R2XFplvt79zTBwvREFFsTdPV2OXbRlUMefK932jD9dnTyejB9IDRZYpYFi1dd68hkb4yqMI9Ilaki2MY2VmEQRskihykrjfDvhPUZE6g6ALka9L5pa1a8gZMAWroEfYH+5IaPyxYQJk3qqkehXU7pE/ynIrJGl3eASvWRt3k9FUDKeExQANhE0aSG5KMQCTLtmLcCtyS62Ck7YQ1pCbgAV5DdqZvwLAZ32cS70ukX29aZrF1drscIWShfd0UE7QtSgB+ny6peTJB9UMpx3KiZUpVbFM12k0qHa12HC/Kpm6jDPOzQbJPfri++SjH5h+40t1057JM1zzQb3ol2FQGxJ3pyn4POURLfpPBGQJuttHMgn3OU3DE0f0tgHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ltN21PTng2elc0RWhkTTZwMDlxcGVsdjh0ZE52bGUwSjIzaXBYY0w3Z3ZO?=
 =?utf-8?B?dFNNdVh1NzlBKzFoNU1SNk9kNTNDRkJiUThMbWpsZzNWRmRhQ2tjN0lZclZ0?=
 =?utf-8?B?N1BjdURsVmd3Uyt6c0hoWjVWdnRyT0ZqaEtKVjIrY1d3SXg2QVF0R3NKcHg1?=
 =?utf-8?B?aTc1WmFNNmhibThXZ2NHcTU5bTErNVI2OGFaR1Z0dnRSYVZ4UElzOXllWnIy?=
 =?utf-8?B?VzJHOTQveE14d1JrRFdnK0VqL0hlTEV5bk0zekdOK0FRM3picW11VXBqS0pE?=
 =?utf-8?B?YmdaZ0ZSM1YvazQ5WHlWamNzTFBwL29QSmVKQXc5UE9vY0NlTUwyTnBlRDBt?=
 =?utf-8?B?ZERFdmMyNUVzQzNNTWJNZUxSaTEwOGJRdU45VzlxdDMvbU1pNEx3SC90eW9Y?=
 =?utf-8?B?RGxNNzUzR0ovbWQ3MnhwYWw0MS9VMDJValF3cFhiejJVVDB6c3NEeTQ2Qm91?=
 =?utf-8?B?bjZXa0ZYcUpZbWtwdEVpQ0pZUnJLd2pER1VmU3BZQTlGdXdycFplbWNuYmlT?=
 =?utf-8?B?cDZoQTd0bzhsS2QrM2FteXdKaExTUzVpZ24rNDNaK1YzOE1wckVobEtnZEdi?=
 =?utf-8?B?azJERGYyMDFsVy8zMTUrSFk3dzBTWCtvMTVXakhpei9xRWY5Wm1qcVpQaXM1?=
 =?utf-8?B?WFJ5MG5hMEFBREY0SDU4V2k4eHVrcFkrMHp5Q2RUSW1TSFNEUkNXWEdZQlBN?=
 =?utf-8?B?ejJCODdXY3pPTlFhdEVHb20wcVYwYzUwMlRUSk1CWGc4VktvWWZORzhoSFV6?=
 =?utf-8?B?L2tjK0UyaEtPRXlMR0dGWkhxWE85ZXJDN2VHV2ppT3lTTFBHUWdxSUFubEZ5?=
 =?utf-8?B?S2NTYnBiZzYwcW1WTVRVYVBpdWw0T2ptTWk1eU4vRU1qcUx2R1lZMlA5bUhs?=
 =?utf-8?B?NWdwdldmSXZtS051V3VWTkV1YnJoL3JrQzFrakFrcGpUaHFLY2k4L2lvWjdq?=
 =?utf-8?B?ZXA3cFRwSnBoTjlEalVLUmFLUkJBZ3N4Y3BMTHBFVmc5aW9GcHJoYTdORDNS?=
 =?utf-8?B?U29OYlBwZ096T1EydjFFZUo1b3BCR0xkU1RhZ2xZcGVQOXp1b1pkL1JWblVw?=
 =?utf-8?B?dDBCL1JHc1VzMXU3SzY2eGpMR0N0VG5UUUYyVklzRWs5WXJ1bmc3T2M4di9r?=
 =?utf-8?B?ak1hMDZ0SlJhN09mUGJEbDNVeThvejU1b0lTYW9sazd1L0NucHdrYzJKdGs5?=
 =?utf-8?B?UTZwQXdXS1A5MFVYSUVRU25LcWNiYkxycGZWUTFnTTBEUWUwQ0tvbTdaTDVt?=
 =?utf-8?B?eU9Gd2JtMzN3SzBkNEZ1SndFZ2ZlamprN3hlb3JLaXlSajRpbVBHbWhBTEZD?=
 =?utf-8?B?ZkJjOE9DWmoxY3hrOVF2dEVtcUdtNEVYRUhZeDZ2eUV2dVZyQlFaLytPQ2xI?=
 =?utf-8?B?QktVZ0N0SWVuUExRWXd0Wm9CNklRaW9EUzkvbng4TlQ1YlAwdjVrMGVESk9D?=
 =?utf-8?B?RWVheVpYY2ZTQ2wyREtpOVFhWHJubk0vY3dhdG56S1kyME54MzRuc09odE9j?=
 =?utf-8?B?eXJGT0QyT2dMS09sSmtLNDlNMWlFYlR4bDRwcUg2ZmZpTWJrL1dPTEZIQm4w?=
 =?utf-8?B?dWFxd0srbUpqTmJ4aFNaaTN4bEZwVGZqd3hVanJHS1lJeHlhNlZOZlhoZW1k?=
 =?utf-8?B?NWNpVUw4WWJnU3MvRTQ2MFg1WXlYdDdzT1BySWdSVGNYbEltKzJ5Z0laR1Fo?=
 =?utf-8?B?K3JTamg3QkxqQTdOcHhmaytDdit3RWRiYUpVUmJCcndSa3Z4NE94QXAzdDZK?=
 =?utf-8?B?NVN6bEhUbkhaYk44U3U5bFIwYVJmeTBwV29RSzZRR1J3dnhsRi9ua01NWEMx?=
 =?utf-8?B?YkpvRkE4NGQ3aE9TQlJ6SWZqUmNrRDNrd0gybFpJRERjWlNWNzMvUUtsYVBZ?=
 =?utf-8?B?NGlEcGFuWEYybThZVzhzdFBUbGZZRVg4dGI4TncxdUlFblRlcXRQbEx6NjV4?=
 =?utf-8?B?cHhDTlN3MDgvMUlqL0dpZzRZYU9jZXI4KzZuQ3ptZEtFaWcyMUdIc3ZtM3My?=
 =?utf-8?B?eWFSa25YZW5zMWdFVGllcVBzR1hKRjNnOVdUeW1OT3RGeDROVlAyQm5kVUpP?=
 =?utf-8?B?azZadEI2dUtNVitiRkJPSzcrSEFKQmY5dUtxanZEbThhcWdHekZvNmZNL3FW?=
 =?utf-8?B?U1VaUWxDcTBJOEQ5R1NTTi9TVUtuckhBUlhrWFRPMDc3L3BWNDFZUkNBNHha?=
 =?utf-8?B?cUg4R2tURzR1OUFDOXZrT3ZwYUViWmhIYzRiUGpEMXMzTUtyM2RIbGI1MHpT?=
 =?utf-8?B?aDBRejVIem5oQTJ1NS9ZYitSWDZnMjBaNk9TV0RqUVN0S2dUcXZ0QUdOdlRL?=
 =?utf-8?B?ZnBwMThUYjJZUzkwaGVCeEU1WlhoeGdlNGp0a3pZcXZsRVJQdE9OZWRIYlgv?=
 =?utf-8?Q?RtjKNK8AQPbFtdDs=3D?=
X-Exchange-RoutingPolicyChecked: gpU1TbTTs9KbsvvELXZcE74nkbZa9kXklgUsQQmbUG14JlJv3DxQ68A41ngCKira/VXNjW4xT3QBfBV2sJNWZOTRXxFlCJavwIALRH3bRjgn7/TAlozWk0THjsY0SbnCzBGwpe443PgzBrDq0RqGoV6TbD0xT3BI9DnFIzTjlszCHLSzYV09uyYllZU2TKP41H3HNyzBvktB+6x0VRrwvjRZR/a8GM3MZhz10h5oIKVMzy21hvLqHV6cRSub1mVNw3BQnXuZmZEN/qUDQQvulc2cjiZaR14medMFUhMvknzXrL65/XPmiYUd6dI92criHXVP8cKunlAJ+CbJw+DpKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a67bf-e9e8-4cea-214a-08ded9bdfe18
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2026 11:18:37.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoBxLGrjTQXRw7p4aJagGlvYto6/Jr8c2AbZDbMg3MECkIwzin0Emgv34j7+upTo7WeA4zqlTQDKghrvvwcTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

On 27/06/2026 23:14, Tanmay Kathpalia wrote:
> The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
> platform-specific configuration to operate correctly.
> 
> The SoC requires three named resets: "sdhc-reset" and "sdmmc-ocp" are
> exclusive and must be asserted together before being released, so both
> clock domains cross the reset boundary simultaneously. "combophy" is
> shared with NAND and must only be deasserted, not toggled.
> 
> The IOMMU maps DMA addresses within a 40-bit physical address space, so
> the DMA mask is capped at 40 bits to prevent allocation beyond the
> controller's reach.
> 
> The silicon requires the MULTIBLOCK_READ_ACMD12, CAP_CLOCK_BASE_BROKEN,
> PRESET_VALUE_BROKEN, and ACMD23_BROKEN quirks. Since
> CAP_CLOCK_BASE_BROKEN prevents reading the base clock from the
> capabilities register, the maximum clock is supplied from the platform
> clock instead.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  drivers/mmc/host/sdhci-cadence-core.c | 112 ++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
> index 5b8a83c9a0aa..0f9b9dd2d2c4 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  
>  #include "sdhci-cadence.h"
> @@ -84,6 +85,7 @@ struct sdhci_cdns4_phy_cfg {
>  struct sdhci_cdns_drv_data {
>  	int (*init)(struct platform_device *pdev);
>  	const struct sdhci_pltfm_data pltfm_data;
> +	u64 dma_mask;
>  };
>  
>  static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
> @@ -193,6 +195,29 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  	return host->max_clk;
>  }
>  
> +/**
> + * sdhci_cdns_set_dma_mask - Set platform-specific DMA mask
> + * @host: SDHCI host controller
> + *
> + * Limit DMA addresses to the physical range the controller can reach.
> + */
> +static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
> +{
> +	const struct sdhci_cdns_drv_data *data;
> +	struct device *dev = mmc_dev(host->mmc);
> +	int ret;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data || !data->dma_mask)
> +		return 0;
> +
> +	ret = dma_set_mask_and_coherent(dev, data->dma_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	return 0;
> +}
> +
>  static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>  {
>  	u32 tmp;
> @@ -460,6 +485,65 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct reset_control *rst_sdhc;
> +	struct reset_control *rst_ocp;
> +	struct reset_control *rst_combophy;
> +	int ret;
> +
> +	/*
> +	 * The combo PHY reset is shared with other peripheral (NAND).
> +	 * Use the _deasserted variant so devres calls assert + put on driver
> +	 * detach, keeping the shared deassert reference count balanced across
> +	 * probe/unbind cycles.
> +	 */
> +	rst_combophy = devm_reset_control_get_shared_deasserted(dev, "combophy");
> +	if (IS_ERR(rst_combophy))
> +		return dev_err_probe(dev, PTR_ERR(rst_combophy),
> +				     "failed to get combophy reset\n");

Please don't wrap lines that fit in 100 columns.  Same for two below.

> +
> +	/*
> +	 * Assert SDHCI core and SDMMC OCP/AXI bus resets together so their
> +	 * active periods overlap before both clock domains are released.
> +	 */
> +	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");
> +	if (IS_ERR(rst_sdhc))
> +		return dev_err_probe(dev, PTR_ERR(rst_sdhc),
> +				     "failed to get sdhc-reset\n");
> +
> +	rst_ocp = devm_reset_control_get_exclusive(dev, "sdmmc-ocp");
> +	if (IS_ERR(rst_ocp))
> +		return dev_err_probe(dev, PTR_ERR(rst_ocp),
> +				     "failed to get sdmmc-ocp reset\n");
> +
> +	ret = reset_control_assert(rst_sdhc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to assert sdhc-reset\n");
> +
> +	ret = reset_control_assert(rst_ocp);
> +	if (ret) {
> +		reset_control_deassert(rst_sdhc);
> +		return dev_err_probe(dev, ret, "failed to assert sdmmc-ocp reset\n");
> +	}
> +
> +	/* Hold resets asserted long enough for all clock domains to capture. */
> +	usleep_range(10, 20);
> +
> +	ret = reset_control_deassert(rst_sdhc);
> +	if (ret) {
> +		reset_control_deassert(rst_ocp);
> +		return dev_err_probe(dev, ret, "failed to deassert sdhc-reset\n");
> +	}
> +
> +	ret = reset_control_deassert(rst_ocp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert sdmmc-ocp reset\n");
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -479,6 +563,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
>  	.hw_reset = sdhci_cdns6_hw_reset,
>  };
>  
> +static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
> +	.set_clock = sdhci_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.hw_reset = sdhci_cdns6_hw_reset,
> +	.set_dma_mask = sdhci_cdns_set_dma_mask,
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns4_ops,
> @@ -506,6 +602,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	},
>  };
>  
> +static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
> +	.init = sdhci_cdns6_agilex5_init,
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns6_agilex5_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_ACMD23_BROKEN,
> +	},
> +	.dma_mask = DMA_BIT_MASK(40),
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns6_ops,
> @@ -704,6 +812,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "cdns,sd4hc",
>  		.data = &sdhci_cdns4_drv_data,
>  	},
> +	{
> +		.compatible = "altr,agilex5-sd6hc",
> +		.data = &sdhci_cdns6_agilex5_drv_data,
> +	},
>  	{
>  		.compatible = "cdns,sd6hc",
>  		.data = &sdhci_cdns6_drv_data,

