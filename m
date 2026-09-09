Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85793524AEE;
	Wed,  9 Sep 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950523; cv=fail; b=ebxoKdGAZQJFLv5N0qe/Xp9dmEy+JNb+J6bkNMtIMGhOiCy0IUFqhzYbPQTriD/3ATROYkrIEWN/00XDSRwab35Ci+ETKPj38TEK3ZGXwAZjP8fVFn0FlEZEFCvv5UTUw/a24ZFky9K0+H4iHjfvDtkGYwkB5ebYNCNWYF8HT9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950523; c=relaxed/simple;
	bh=cD7G4KwWbgwE/BdlOWxi6aypz9mE+GkNpMEbkBsserY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lIDI8+2eK2L7SSKVODxrPodKMvwvQWz6ND+A1cTZwBTa7yPln74ScZIss42g6RUqoGElukrHCNnKulVN6R0fQQJCeaWmHjMq0xew+4lgXrlv+VJ3xCrV9CmTV2BPaOTgJEh0vhroGdJuvWJrt2FcQQrSHmaNucJiDa+j95nA56o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gY1gmS+2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gY1gmS+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788950521; x=1820486521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cD7G4KwWbgwE/BdlOWxi6aypz9mE+GkNpMEbkBsserY=;
  b=gY1gmS+2LSpCs4CsEfEZ2JtBPDnxiBc2mAd3s80kgHXoBe9nNmOQn3bS
   TFXFQJYXkaHCwEnYuhm0UX75JfN4N6PaKdhuGIX/YvdAml3b1x3RQmMqL
   hG3Cie5dl+RllOKxWXi8H9HaWhNwXNJ4yEPFWiUWG8gbqTjoGCNxAl+oo
   L6yJfEHxEm/Za4S5U7uYCR9f5StbKozJ7n7I1Dup5N0OWM40NEZB/IAhL
   sjMby43xYrzv8P8KpYp240Qfkz6Y/8ZHfOEkO8FVbdcoNxA6LV5X553yU
   RqZiOsbx6EklfheU5s9Gv53Tn4iNvGveUgwnp5NVSuSoMGglP8ycV//bv
   g==;
X-CSE-ConnectionGUID: E9hHASpoQ9CK5Jqxqgl0dw==
X-CSE-MsgGUID: nk5hYUrkTKiwZ48JmJRD3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88518744"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="88518744"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:36:30 -0700
X-CSE-ConnectionGUID: L+c5/jK/S06FbU5ObWCZ9g==
X-CSE-MsgGUID: bFe+K2FQTbqzlXPa5fPW/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="266996899"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:36:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 03:36:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 03:36:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 03:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFUL9Z8tw625bXl+9me7om3bBEfmpysCNB+1s7xop820CQt0oicV3g0UBB4+dMM7JyyCi8o3jLeBM0n5w6S6aJXyoAfSCymIqv+TtC+qckMlTBHEznqToOAC6FnNzrnodD4+sGJizuMfKExA8KnfNbfbDc27QuAIcWozL8C2FfL/1Pme0AzlbGwlBsu02cIp7oV8CDaKTYonTbnOmwBQL2ispl7eZ/n/Vcn6il8Oy7vGTZuTpCEXLIDzvC1RhowiQqBLeYXezNwDtqdZisSVm/goYI/i/lfLPODscYBmLgewL7XH1ynWud93wdjW4z5j2j4s9WzRZJzo1bM/Rdmi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d11XfEQvgY45SsNFB70TXQ0CCgmUwSOx7F/402TuTSE=;
 b=AKMkOYBZNZ7/ksfw3rQAGOvuPVe+jN6ZYWn3JfGE8K+UffKtBPa5ANbWkAaWuCzZvPUz5cnDNOTeaPwtc1GYAjwY0xZMS2DDTIe7c6SVZkC5dQcvLE0ZlsBW/pRAVO57xU7FMWe6ASQ0pB3uTlk1ZgWd6vDsF5MJ/wSh2fxpUzKpFZXpEV5a1Sts/LUSmO3HykAg0uMZLa8Uea3f29M9NllJdQsbV7jgS5hr723Y1zg1Qrk0+EJPdQK6K3meoQL0sJBRuqBfZ8oKskEGzQOICY7W4539wTWOo8rOV9K1KsExBcjtTrOSKEgCicKirviTFoDprMrB2KfkPnHzawLjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:36:20 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:19 +0000
Message-ID: <2d7a6e8b-029a-4b9e-b7d4-8b7e96ea6aa0@intel.com>
Date: Wed, 9 Sep 2026 13:36:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mmc: sdhci-of-at91: add LAN969x support
To: Robert Marko <robert.marko@sartura.hr>, <ulfh@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <aubin.constans@microchip.com>,
	<ehristev@kernel.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <luka.perkov@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-4-robert.marko@sartura.hr>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260907132617.1198548-4-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0011.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a63572b-cd65-4ccc-7705-08df0e5e2f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|921020|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: gQEsIhKxcjt/pF5ziFeW+sYPQzOsPGqbMUyCNATnl2nM+RRb7qhir9ECsijzKsNFKxdTVvnK6w16s5rwUHevazAQY4MZhvAmx+qkNdlGcX6b9GyFAbvPxUmnbVs/HIIewx7lYiAGRuF1iOfdwUvJWnui/vEY15VnUuqrCE/IotAzGWAf6rWketCobO19lFnvxXgrTwIe1P3PTPBfqnJ8Zb1vYVVRsxBlfGDQkgSRKodGjN6zpoPRjVe64cnfZHBVY9aWdcMSbn0Yi1+lNmlBr6ybDq57BlrE1piRjbTT4ptImPch6n1O3RUMz0ahfTnwePOU++pZJ0WhAH0/foghkb1IGtGrBpOcFrXwz4hBDJIjwN8XgUZQ6cyUiLqQx8cTFFGN6cKPzAtzEWzG7Af1DSm6ZVfLTFaTCseXEy0dEsVi3iAWoUeiPqLMMiZbBxI0sPm/2dRqT+ghz6LxrbTNpjWFReastxU61eamdZUFNnbfoTiIeO0rLIz7R2XFXfaJzu8TJN5zJ+4+J3I8Wkb7y0I+zoP6i6pDa1JkTaQFRqOYiZfAM0aVvtrWWT8ZEVaEcBFo4XYLjApmL2rdXrhbdb0a3HMTwkTD24sJXkAE7hoPIutJmWq6ThfZ1hdBk1qRHS6qEHn+jL5pqmDc0VqUgfvYOAFzAU11rjj0olHp9x97R6Cs7uqdEq9m3A0YNw9XpgzMvPjPGFceS0grcD8nzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(921020)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01ETTFJOW5hM2JqV0FUcFF2VDhhSU5jN1o2YzRQRGZaRElyVkVNYVBMTklF?=
 =?utf-8?B?LzkrWW9DODhjUHArelh3VWlNT25TTmkyaDE0UmVvbHNHQi9BUU8zRkpqZWh3?=
 =?utf-8?B?RnFBWDE3K1J5T3VINWlycW1EZmtGUnNlSXhQc3hPY2dKTHZFcmw3RDM1SDdT?=
 =?utf-8?B?bWN6SDdlUWxvT1NzZDAyZ0J0eGhVeXhQT1RRN2RUNnFNeDN4SzZ5UkxVS0dn?=
 =?utf-8?B?WUpjN3RUeXZqOVA0YzgwR3NpRjlIRHh6VWRLOWhab0RaazF2cS95UTNxcUtn?=
 =?utf-8?B?Mm5aNGJ1OEkyM29GdVA4UU1vbklkb2huSGhOOFgyb3IvVWduenh3Zy9ocStN?=
 =?utf-8?B?a0hqY2JTTmRWVFlFZlVYcHFIVzQ4RzdpQ0NjaEQ0NFVHUFVuNE9neC95b2Mx?=
 =?utf-8?B?ZE9uSGR5L25zS1NRN0t1NHd2UTZxZ29QUjVaOU45QjVTUUhoUzkwYmVxdXlH?=
 =?utf-8?B?SW0zaWxsRm5WUDNhMStCWlZCbGE0WUtTTVZKdmFKQUFNTmtyY0l6MTJvSmhB?=
 =?utf-8?B?ZWwxVmlKbHlsV3JNV0I4R2RFUmJWeTJtU0tRVkVpb2ZPQkFmZnFiSzFGenZz?=
 =?utf-8?B?cFBRNGM5L2lXeFVNOE4vZXlHL1pxM3ZPdVM4d0hmUndWMGpsSlhPMnNwZGNH?=
 =?utf-8?B?ZzU3Qm1OZkZETFVYQmlaN0toMmY0QkVwd0FTUGc3N2Nsc1o0VHlnQzBwZ1RP?=
 =?utf-8?B?alkzOTF2NlpYc0RSVENSbmIyMEt1a1N6NlZlb0FBWWZBcTV6cERuWHpPMXoz?=
 =?utf-8?B?MTRjK0hFZHdhbFdvQjFhTHprbFNueENac0xzZnJiSTFza29wNFlxZ1lNNEND?=
 =?utf-8?B?K1Y4UVplRlN5a1pzNGJvRXFPQWRsQWxaMCthVmpJaUVxYWtlNmxSaDZxV2Fv?=
 =?utf-8?B?ZXVWaFZOMjFZejJneVlJT2RYcUlESWJCOTk1azJoSzBiVHVRWW5TL3FBV1hl?=
 =?utf-8?B?L3NOMXpWZFAxWkpFN1dBdGZmbDg3NFBZUjl5eTlPTS9FcHpvVXN5dnZ1WFBW?=
 =?utf-8?B?a0NLaFIvWFc2amhUcE1YWlZCWWZpV3J0bGNwcVJmekYzSzhQbkc0c2JIMlpS?=
 =?utf-8?B?d0M2U0c0azJWL1ROck43UEJ5Z2dtZUdqRTA1N1h6UFp5MzYxUWhEMHNrMkZ6?=
 =?utf-8?B?T0g3K0p4UDJYMmxkVndqbkJGdmYrcmlzRFE0SVVIM01saHR4KzJVK1BrTFl4?=
 =?utf-8?B?WkUrcFFTdlBLdzBndGtGNFVlZC9oQzZtVnVySDRveHRMaUhqRUZ5elRyTHlP?=
 =?utf-8?B?dXpGWlVxbnhpRHZqOFlQVHVGTUFoZ1M2aWdERXBZS1pWamNxWnBTTi9MRldz?=
 =?utf-8?B?VHArSU14S3VaVm9oKzBFR0MweitiWmk0dHBoTFk0QVJtUEl1TXVSZW9iZmZh?=
 =?utf-8?B?dlJzYlcrVlFONHJZbGZjd1E1M0Rlc1JNaWFqcHRjcENmck1TN3dtKzdhQUxh?=
 =?utf-8?B?UkEydkwzMVBMTVBHdDN1Z1ZQK1plWVpRNyswWXNzelJyRHpMdExXcnIxa3Vn?=
 =?utf-8?B?RWRTWW5EemF2NCtrRjcvaDJ5V3NiNEVoaWFXdlZMeFNURVZyL0l6azNSYXNq?=
 =?utf-8?B?OFNCS0dhOFZaRTdmajNEcXh5TkFlQS9Hb3AvT0l1V2lKVXBWQWRKdlF1bmFC?=
 =?utf-8?B?RWlNU2UxSlBPRFNFcjl0Umd2ejBCRVNHbmVQT2RtcFFyeXh6aHNyeFhGNTBT?=
 =?utf-8?B?ZkRHMXNHekJvd0VSY1UxUWYzVEZYaFRoZmVKSUlkZ2diSUU5dGd5V08xQXVJ?=
 =?utf-8?B?bDFwbDBrL3dyZDhLWkd5ZWpOaUt4Sk1yQ1lYYmpKcTJGOVluTXF5MlNJMTlR?=
 =?utf-8?B?bjZoWmFlUGhISjJjRkp4TXhTMWdERnB3NzZWZVV2Q2lMOTM5TDRvV3R0Rjhz?=
 =?utf-8?B?RDJzNUk0UXBldHJ0bFZlZmFvbFNEL2xsazBxNTkwb2RERW5KR1pkcklIMEs3?=
 =?utf-8?B?SDQ5QncwdFZVN2RHd3g1QzZScnQwZFAyMDZ6dkh4WVJHdnpkMzI2aEVPc2pS?=
 =?utf-8?B?UFF0RDRaVmtpRlZ2NEdmZ2NqSmtBWHBYaG1rb1ZmZEJqZDB1QmhsODVtL3lj?=
 =?utf-8?B?ZHBPdlZsQUN3S0szVlBCUGFXVWRVZGk2dmJGYzVtekhiQlpPSkFvYmN6QS90?=
 =?utf-8?B?WUo1UEZCbjQ4N1FKMGV4QXZtczFXUlVPV1RNc2ZubE1SUkF3MnIvTlJiSytn?=
 =?utf-8?B?WVgrclN4aHVOREJJN01LazlUYXhpdGJscXVmaEVZTUczT0RVNmlGcDJJendI?=
 =?utf-8?B?aUV1ZytnK3NQam0rSFVBbkg5UGptWjNhMDFkUWV4bHJMN2F3a2dscXFLb0Ew?=
 =?utf-8?B?ZzNSWldBSlh4eEtCb0VBVE9KckI2ejNsaW5YSW1lQThVZ2NsRVgrZkpoVU5z?=
 =?utf-8?Q?kwGeDW6Wo06r4wk0=3D?=
X-Exchange-RoutingPolicyChecked: m0N6/APghA1e+YXrDZPuDw25MkEzd1LWEjlptmnU57AhO+tJVzdwptdcK0ruqi19Pl6cMFHLJSD1D+TaP1cq34McoFxJ/AeBYcIHRI0PP9X8v6+AI7kRdBSfDCoKQEWHMWrJGVPjMvKB9cRmbft/wt56xCxAI79ozsN1fJOOmlcNhZZMTC8EDQSC1fq1N62F4+VpKn4wVBLGXRku6i1S9FJ+rvEaiu8l3bZk+3dd61TbaH9q5I0+TV3Io/69Cwvjp6gyL5MZJc8EiaqmI+guq0A82KYBvueIWVg6P+BzW4uUgUsvrSVdaBXnLcVSvd+3eMUync1yHbT2I5woUUvKBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a63572b-cd65-4ccc-7705-08df0e5e2f83
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:19.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiStR0QdXZH4GIrhd4IlCs6lLkyao/2pzEHZEWYg6/SMtyJbs9qYC3gw2ZJrLhMA3i0IxTlcgw27D+MhLqQKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
X-OriginatorOrg: intel.com

On 07/09/2026 16:25, Robert Marko wrote:
> LAN969x uses the same internally generated base clock layout as SAM9X60,
> but its SDMMC controller stops responding when runtime PM gates its clocks.
> Software resets then fail to complete and the internal SDHCI clock never
> stabilises, causing subsequent I/O requests to time out.

Is this a known issue of the SoC?  Is there perhaps a hardware reset
for the controller that would bring it back to life?

Does that mean unbind and rebind of the device from the driver
also does not work?

> 
> Add LAN969x-specific SoC data using the SAM9X60 clock layout and select the
> option to leave its clocks enabled across runtime suspend.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
>  drivers/mmc/host/sdhci-of-at91.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index b7e2a89da348..e7affca8da25 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -158,9 +158,17 @@ static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
>  	.divider_for_baseclk = 2,
>  };
>  
> +static const struct sdhci_at91_soc_data soc_data_lan969x = {
> +	.pdata = &sdhci_sama5d2_pdata,
> +	.baseclk_is_generated_internally = true,

Should be a comment here explaining the issue that needs
keep_clks_on = true

> +	.keep_clks_on = true,
> +	.divider_for_baseclk = 2,
> +};
> +
>  static const struct of_device_id sdhci_at91_dt_match[] = {
>  	{ .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
>  	{ .compatible = "microchip,sam9x60-sdhci", .data = &soc_data_sam9x60 },
> +	{ .compatible = "microchip,lan9691-sdhci", .data = &soc_data_lan969x },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);

