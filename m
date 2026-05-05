Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996E4279FD;
	Tue,  5 May 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984629; cv=fail; b=ONfU222DoLGbsNkrUqF10I6Q1RNltvDKaYU6MkQHsNyDVSwM5kB/wuQFejqUDYJzh1KLVKH7R6OmS4xcvU0px/AcLnncpgMVmm8LoBwB3TWBX9ULB8vLJ6sXn28qzW5fpZgzpn+ZEQv6MOXFBT256Vr0HmTEbpbcCrHVVdq7f4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984629; c=relaxed/simple;
	bh=c01THuvzxgMSZ0QTgVtG97C9OTthq1WCRm5JDg7Pv1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOK6fWkhaQGT/80HYgSUVWk2iILaYuses7P0zPAK6vHq6yWK0zzAezouJK725BlT1aamSOFal4ipg7ch8Ha0FEO481RhI6VsfNj8jVZM4zXIfEm7M04D80k5STEFQ/leyxVUdijLOCN8DdlbGacxB5czcVmgCs3Rzg0ZjjZHnEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG2+8Dax; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG2+8Dax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777984628; x=1809520628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c01THuvzxgMSZ0QTgVtG97C9OTthq1WCRm5JDg7Pv1c=;
  b=mG2+8DaxsRsr4Z2TTu5pqIHw4f1AyrGoaaXRwOyWVMlZBVwGWJ99+Chz
   uYeNRKmByTkATG+RABRAm9RkBR+gJ74i/GCc5u6162ed87xGUwF92WQXT
   xW1Mj/7HXEINpvZbJyAt2Iy3cHpA/HFWzhIsMYzPYTUhvHoaXTALYkuQH
   rb5gtM+tUVxaHV3WRxjYhpyE2e5RLiKOFanVk+ohR73dz0YdcuIQQsCw5
   Jp/6MsnwaXHszYORmaN86FQuFcAcV0sAVqshPTCxkD1lTApoPTUiO56D+
   ppYQFJjM7N7NfqbIb/qVu9hwVlIdtTY++O8j3X0A8FJ2Dq+I+xiTtboce
   g==;
X-CSE-ConnectionGUID: qWwu4Rt2TUKsuUQAx6CnvQ==
X-CSE-MsgGUID: qdLVnfJrTK2YVNiLIUe7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="81413980"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="81413980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:37:07 -0700
X-CSE-ConnectionGUID: /pzODprSQ/e75ZLW4xklAw==
X-CSE-MsgGUID: DwM0xc3iQlKG4MZvdmo/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235884771"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:37:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 05:37:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 05:37:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 05:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtPbPkfHVurihHsWiOwT0myzAhVujpHMU07TrP2wlx+DRJDckMQb9SMnePLE0Mesrss0TKY7XomouVh6sWywxMHVKdpWJUj7HaMNhHhxdeXd6Qh07fhSUpy50/spFll/1fHQ9RMVVAAmV0Y/CX9zZT3PlhtzUBVklez2b4HMyzRa6PLrdkbc6h7H7Wk3ys4GeJghkjxrwtpM33JEGoLb37hocefAywuRVJneGAxFHxGM8dDij9gHh1L1yf/GJqbc7p9r5jIXXejepBUozUJFj7Y+SdQ1DB1wRHhs1kLuJE3Lzdf0gFGp9AWRyNptNkNiP3w1uEbTmqQUz90QCh3l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUdYRzVqaa6ufUlTJqXYIbMqdV58GpPj9gl5aWV3OwU=;
 b=bL2H3kOkCq8cHBKsp3JmiG17ZajGvMuUB9p0bC5Awr6OdklHfRZmn8MWrt0KnMb2G7OQsdgBj/wKWhTx6abRXXRiSDlJa/YP/O0aFchbVPou5HcmhLGzRJdlk6a8nTn9zzAgZXHauwUTGKeujnHmzj1+khIuRm5PJl5RsYC//fY+ZQUi1+HiXp1zBnE1BRxIUopEG2nPfCUOZbeyShWzlAlnqVT94t2aS1eFMQgpn70FALAX/IsAqRvQ8Cs0Ym1xkJ/l6ofv0Qt80rYdxcmCz15aYbjnajEAQGNw0OF/+lPNdLx3iEV1KOV+PrDXnCouesVpJIYJM2AnDEEcQnk//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 12:37:03 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:36:57 +0000
Message-ID: <39db3c9d-e2f8-4018-93b8-5a97b5119d19@intel.com>
Date: Tue, 5 May 2026 15:36:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in
 suspend/resume
To: Artem Shimko <a.shimko.dev@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>,
	<Jisheng.Zhang@synaptics.com>, <hehuan1@eswincomputing.com>,
	<yifeng.zhao@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260415123411.437450-1-a.shimko.dev@gmail.com>
 <ad-mCsvOWWgqt-rc@ashevche-desk.local>
 <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
 <53c62677-2185-4cac-aba8-09363d0ce9c8@intel.com>
 <CAOPX746c1N1vsibTMW8KLJoi7BzZXuQj+yCUgApagLwmOMt9TQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAOPX746c1N1vsibTMW8KLJoi7BzZXuQj+yCUgApagLwmOMt9TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0197.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 51889ef6-10e9-4bb7-4bb6-08deaaa2feca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p0cH3rD1dBvkSOL2TplOmojJbGKjAT+oRDmyQFW1hMb0toUBP01Pf4I0dUjj0c7lZCRxMBFO2wtACg6ove8BWpo1FmQrp1NwJWq/3Nn7bEkAglKXKueLuErbo7a8Bi+gGbEqLmiEQ/6cEbxzmq6CRgRqO1aaGpqIIrXucUi3HK1t0X/cEXL+pVAJoIwskHu8ElwTBZGmNoA0sLZjN69D1RqoAkkTB9Z5j9yhDqtKWWR2c7FgMgOgCUnst5Xv/YsgPV2GQ8oxAQsIY1GX3AE1AFC/GwSZy4KhZ0SF07jc+RmdFlR+slPoPsc5srChZ4PmPjcSpc2k1NS+3lM6ipyIL29jKd6XFi16+Z+k5z+P3WW1k3oYKXYXJoidrlmcKd1Z+ZwB8/51o2VuLOj+p+NFYr2Ua6GHiLoJgqBWUefJpsHkzknULRuId3kH+scvYURaIoc4Aqnb8KxPB1S2DMZaxqkTJX1bYGZ4bU50lZw0L1Dvow0aCVLId7m+0Kvaf54s6MTVq4e8mYTxwjZT/gH0o79Ye/wLeGFkQFScVTIfq7ZFNfB6MRYkCQmqJ7yeA1cdlEoH2MSoyJ1fV0uQ5ErJdpNh87C7Pb+kmBmHNp7vHkcXAdupnI7rRZ/UEifg/ELwddcbkH6TWP6KiwrUAcIa0TP7Pi1IE5zrk1C3ga1LXeF2H85uMrnXTRGGEakb+EYA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdBdExCd01tRCt3WHFRbjFROE9Ea0tMMU1rd0Z1Q012Z3JUdkYwWHdqaldT?=
 =?utf-8?B?ZlZXL0lYS1ovY1pnWm9Ka1drcTh5Mk5ZWTJKMUlWa1lRaWNGa0laeUpGcWQv?=
 =?utf-8?B?dElDN2JKQ29kRmpZbnlxUWFqQWFueW9QL0xFdFFsYWcxZlZLeTZoMmV6VVQz?=
 =?utf-8?B?UWMzdmpJN0FWWFkzMjJuTFJTeEw5WU91a1BIYVp6N2x3SEk0R2tIRVo0RThN?=
 =?utf-8?B?K2pkOExlTVVhL0pLZnhOYkJzZVVnN3YvcU5DMDdERmdiNEI4bW85L2RpZU83?=
 =?utf-8?B?R0wvMTRRU2swTXhRazJLeVdvRDZNT3c0RldsVmZhRHdaak1EaWdSK1l3bWl6?=
 =?utf-8?B?aDJ2TWJvWHRYK2JvYlYySDRGcXRPeFFEYlY5Y1BCT2EvZXpMa0dXQWtXQUlV?=
 =?utf-8?B?RGpFSGtOdVJlOGs2VmlpUzQyeGlpSVJmQkdMY0lPWklLZDVDRWdiUDBEOTZ5?=
 =?utf-8?B?emw0d2VRM0pybFdFMW0wTHI1Q09GdXY4cklQcU1OdnZkaXFOdTd4aXhWQkV4?=
 =?utf-8?B?Qlc0QUU4YkRCZHR6cFM2RktYdktOeTBIbmhhMnZnOFFFNHVoUmNJYi9KWllC?=
 =?utf-8?B?ZGpzSDY5WkY4YjFlSFl1a3R0SjBJRk1MSVhtaHoxSW1uVTNONml0c2d3c3pN?=
 =?utf-8?B?YjREY3ZuOUFwRkQvNDJ4ZnpxbUE1YjRpKzRBbnE1RmJLUnJKMHl4azBKaHdV?=
 =?utf-8?B?eldWWkgzcjk4eXA4UGl6L0I5R1JSVG4vSjBjVE95Q1JsMEJSclk1MFpHakJx?=
 =?utf-8?B?WlRlM3VvZ0QxamZ5S1JrZDQ0WGhRUTBBUlVZeUk2WTc2TjFvZG5lcmFEaStR?=
 =?utf-8?B?VGRnT0p6N2QrZnBseFJYRklPeXJWRjhENmRURm96SlloaTkyMGQ5K0dyRm1l?=
 =?utf-8?B?OERRRitKQklkTmhLTndPcW81TElxUHRvd2g0MlJvODFzZ0ZLMkozTUNEbjBp?=
 =?utf-8?B?VjJNRDFZS2dnbjJJR1F4ZzhaRGpVMmt3Z1JLRGlpYngvM3o4Q1J3RFpvbXJy?=
 =?utf-8?B?ZHhlTzlvK0ZiV0o2eDQzNlZTdlErMXRlUkZYSHRxOGZCS1pzWEx5d3diUWhi?=
 =?utf-8?B?Nm5aSXZ2SE14bUNBVFFhS1FMMS96TUhuOUp0WFNBNDg3ZmpqajA1QUZ4R2wv?=
 =?utf-8?B?anlwM3hPdFFEN3h0cFh0eFd5dmJwak1hbTlzQVdtUXlPbkVHbzBlRkNUelVD?=
 =?utf-8?B?TTArUnJTaExOTkhRWTU1d2h6d2pUbGwvR0VVdlNNdUxoK29mek9PUlRpdmQ0?=
 =?utf-8?B?L0lva3p1Q1I4WmxTL1lGTHIyakpYRERINjdjdmtBeDJ1VHc2TFJNUC9zZUpP?=
 =?utf-8?B?ZHhwOVp0cjZQOEJXRjk1dmt2SkVYVU16USs0UnpDeFRLa0psc3d3UE1BNWwy?=
 =?utf-8?B?KzZMSHpNeTZZbW02ZWJuZ2J5QTh1R3FhWXdwbEdBbis4dFlpZmkzQXl6Y1hj?=
 =?utf-8?B?RFpPd3lsaW5uT1pSd0gzazFHWjZtMXRPejVhVnJqWnU1dGdkZWJUWUVLb3U2?=
 =?utf-8?B?cDFnNkN4S3pCZ2tmWC9kWklrL0VOWmJWSys1M1FYaUZQdGNsc1FON2x6dGJN?=
 =?utf-8?B?OXZLTE8vY2YvLzFBOWhHckFsRVJnWTVteStUa3QyYi9iMzFaUmJTVFZMMEZl?=
 =?utf-8?B?aktQL0VEbSs0cjFuTE15QU9abkZVZmJ5NDBpQlVOcE9FSko4TjRvWEx0ai9Q?=
 =?utf-8?B?RjkxdWxIWkFiYm9Rang1cTNxMlNwaFNhZHFNdythVnNKQmpiV1h1V2gycWhV?=
 =?utf-8?B?c1loWW1VRnFPY3cxbS93WXZ4MC9NVmgzMjdGd1Y2WnBXK2NMVEk0UjQvdVRw?=
 =?utf-8?B?VjlNcUxBRHl4M0V6ZThNb3IxRUlRMTVua0thL0R6RFlnTUR1bjN2RTI0dEJO?=
 =?utf-8?B?dUg3YnI2QXJsbk9tUno5ditxcWZIMTIwQUFsM3dIY01iVHBKdUNxTVZPd1Ur?=
 =?utf-8?B?T3ZnZE04aWVaZEo0V29XaUlsRmNkS2ZCM0lpekJITXRjNmZmSHRiSGFWMWFn?=
 =?utf-8?B?a2hOTm1DUFlTMy9qTG9LcnpsMlRhRGJ3TWRYTFp4OUJrbWVEWnBCdVFwWWZR?=
 =?utf-8?B?RDQydXdlVi9ZWjM0M0lTL0I4VHpXRUErcmR1UDRFT2pFY0VkYzNjc3liUnY1?=
 =?utf-8?B?K2hlMGtUKzRaZGRQc3hiYkgremtqMGFHUlA4dXFLdFNILzBhTndNZm16KzBS?=
 =?utf-8?B?ZHc1R2pGVDl0TGxIMFJDaGVsc05ONXFnQU1RZlVBZlE3T1h3Vzh6NWF6OGpI?=
 =?utf-8?B?MGtrOGRKWTZOZC9CVGdSVzBGaEY2MFRnaGlNeGEzN2RSbTAyZkF6YjhIUkQ4?=
 =?utf-8?B?Mml6V3FLdVNOYkNJT1VmbnMwUjZFQm5iRGZVYnlnaHIrYit6cytyMG53Vjc0?=
 =?utf-8?Q?EnZgHZBnP4YP+XtM=3D?=
X-Exchange-RoutingPolicyChecked: D+h/ntph6hUou5jPtdC2SkAaBFopvrq6+FARtJtr7m+qB8powilH3j7kPj5dQWHmG7apwii7jpATDwjhVG9u97OBHllT+gDy33dPik87vO/wHoFw2F+vXZCrVCbybN+Z5U907SRSBpZYm52WIV0zXyMtmi+WQlZxAWcBlidv1+umQNBFoVQE10vbRw1A661IOHsVF53Uo1VYKLvsJau5SrR2VNBpTM+s9FY8orDVSMwnze2UcfV+N2YMJcNM9dgV53pdqqUwALiVi3Oh/O0yv81c+kSZ+9px8obBzG9+LWSX84R04l63GGPSEgIWQXMoMAtecd11jpy/xV1x8a/Htw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51889ef6-10e9-4bb7-4bb6-08deaaa2feca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:36:57.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iu6KDhdOT7Dc5oqbU4z5jhqHuIU0gTSX2VVdKv1s89/MZYYSnPw5tOsJiU7biTJrgoIVFKffG4AUOLCP4UuAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com

On 05/05/2026 15:12, Artem Shimko wrote:
> Hi Adrian,
> 
> On Tue, May 5, 2026 at 2:28 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Only dwcmshc_rk35xx_init() and sdhci_eic7700_reset_init() assign
>> dwc_priv->reset, so I am confused about what devices you intend
>> this patch for.
> 
> Yeah, the change as proposed would affect other devices, and I should
> not assume it's safe for them without testing. Yes, I was so fast to
> send it.
> My intention was to make the reset control accessible for PM
> operations, but only for the specific SoC I'm working with.
> However, since the custom MMC driver code is not part of this upstream
> submission, the patch currently lacks the necessary condition to limit
> the new behavior.
> 
> Could you please check my plan to prepare v2 to:
> 1. Keep the reset control moved to dwcmshc_priv (so it's accessible
> where needed).
> 2. Add a dedicated flag (e.g., bool needs_reset_on_pm or similar) to
> dwcmshc_priv so that only devices that explicitly opt in will trigger
> the reset during suspend/resume.

Sounds fine

> 
> That ensures the existing behavior for Rockchip RK35xx and EIC7700
> remains unchanged.
> This way, the infrastructure is in place for devices that need it,
> without imposing it on platforms where it hasn't been validated.
> Thank you again for the review!
> 
> Regards,
> Artem

