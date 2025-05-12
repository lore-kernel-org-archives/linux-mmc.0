Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736754A23;
	Mon, 12 May 2025 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028664; cv=fail; b=qiCF9bpfWmVpcQk77OXfP+eflYyxFPQR7OOnW9ryZM05nQTgNmzCE8ADvd3lLIYc1tQV+cP49ur3fqHMdzv0fOQ0WcKJkU4EHnWHKFXbdLnKaJR2T9I04LXhzGJ7NDW9wnKWLNJrbs4H7fCkO+UxNOk0ROPTI8G48rkJPNP4Lo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028664; c=relaxed/simple;
	bh=had8H8wrpuWtrtrX2fdcVjjz5VR5eO1ZYPisl8t9p98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YqiFJzy+T/Kc5vCe2oS58BqYL3Ua+2Yf45Em9VnHpgRVLkicTm7+9xpr9ZsknLf0tfkjweqRY0Piz6mTMNRXCS9ChdV5bOlW3SO8CD9illdcYgMPhSvVRb7nR/5UtCkwUSHmaJ2Zz95Clzk4Jp+oVBe8jHBbQ73T1BwX1sqV4v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7cJVD/B; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7cJVD/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747028663; x=1778564663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=had8H8wrpuWtrtrX2fdcVjjz5VR5eO1ZYPisl8t9p98=;
  b=H7cJVD/B3E6BqndNmEXasB+K5cI8ShX9c1oBlffDPLRcbzuU53ot1xew
   n+fq2QQV5QCVKt3bxrpxqi6ToeZiX3NEJf+4ExEWaUALSiog4/GsdDTpW
   iuIwFceneU3oKerHUvzs/d+U3JRCPKft99TDs9W4nAxAsbXoDXoDnpeSL
   ROHVuViQtH+qTHc+hIbmF2oo37F6OCQttNhGrjLi+yd5JfwJGYc9C9AJM
   OYl1YGK4rUfghn1Qou0oRGfIdKZisg6JsShQolmCuoEOArkq8sLWlq8xR
   FgCHpza05xr9QvmqEf6x9HScq6aRi5qwF/KI26W1RS2HfEZLdw1P26ugP
   g==;
X-CSE-ConnectionGUID: l1P8Sa3HR7WYz/wHiVZfJA==
X-CSE-MsgGUID: PSG5gnFaQY+35DXNrwtIFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="66214859"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="66214859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 22:44:22 -0700
X-CSE-ConnectionGUID: Y/RVQUFgR6qjzL9h3MZEzw==
X-CSE-MsgGUID: Ax80Dk/xRcejTvnPmqIIxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="160517019"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 22:44:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 22:44:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 11 May 2025 22:44:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 11 May 2025 22:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETgw2fGfsz104w7L7Hy+mC5MAav2eWmSc17SUNKQ3nE4GK/72Pf7H3AHj3RwadXMNPtSl9iDvfiDHePfL+LkmQrGcZHoEPEqdgLPoZLTzJQm0Uo2e77XVNCa4ceBFBApugSwdOUvOGSA5zenOjEHpDNyBJa5emu1rIqQ9IDKzjQYTCq4u/nqePpYBG/6MEpzYeohIYzHrh/o9T/xPGNdZv1+RyOHHHiaFHqg6eVMvU9LRGr+sduL9S8oPex7FjcbO1DEs7UfBNl6HZu4u1qETeZa5/JAXHKI8cxNOGeRr5fmMecB4rYV7gH6cQoghNFCdCz2mVlPmzf3WUyFX+5RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pIlgdtdKx/fPwAJtrcn1hBIrOMuk4BqlHhfrT8jpOA=;
 b=SXDmDvwH3iZI4JK7Fr0eUH1HIMJNTiJaCm6ZGM4Vc3EqiltMSqZ/sjOyDFzJoYqt5d7XP8MhE9StAxLG6Wb35jem13a85A7eLyyx3tuqBlHgYa/8puidasAS6a5pjAymKTyR6aXinqb1KUkdmsv/6hC1JwnEFktupzvBH4IZCakGyLice3TZncrT5LjXLjCCT450nlKnvIReRc05WM9dYQhwRhUR46QLOIMky33DndoXvc3CiiSvy68HsECtvDn+21Mx6V4VSy9Twp3XpVANDRihBI6U6ag3L3jON+mit7pYxP11zxNnccsm/zWKISD4BXzv2AYiLUC947+JInZtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 05:43:58 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:43:58 +0000
Message-ID: <538ac62f-c1b1-4d58-9ef3-0a4ef2331734@intel.com>
Date: Mon, 12 May 2025 08:43:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Josua Mayer
	<josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Francesco Dolcini
	<francesco@dolcini.it>, Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
References: <20250424180036.1541568-1-jm@ti.com>
 <849a5e47-5b37-40e4-8b76-a58adb7e9b90@ti.com>
 <CAPDyKFpMo3a_MZuD1q+JFEa4VqHeoJ-SegviJfd322jkV29+Pw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpMo3a_MZuD1q+JFEa4VqHeoJ-SegviJfd322jkV29+Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:10:be::36) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|IA1PR11MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbca1f1-a827-469b-4d83-08dd9117fda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d20rN2o0Q3dZajMvMEZqWkloazIyR044QUwvenJMbU1rQ3dwSGErTWc0bnlh?=
 =?utf-8?B?R1BpdVUxQkQvUzJkaGgwdlBBckM1VTJYUDV0STRvQUxINFJDUlhSRjBZMnlH?=
 =?utf-8?B?Si94cnB6YlprM1hJRUR3NWZLd3JtdWc3d0ZPa1gvY2xHNWp6NzA1cW0vUWUv?=
 =?utf-8?B?Rm5INW81eGtQd3NDYzBaUzJBbDBwZ2FRZjB0cDQzWkRaaEVFZHFUV1dNbnlj?=
 =?utf-8?B?OHlLRFN0Q1ZYQXdjaFk1WHZwZTUzTWF5cytHZ0E2aFNRb3p0OTdBU3ErcmI3?=
 =?utf-8?B?VERWaVJ1cnN1aEJvTGxXWTZLMUVrTmxQT2crTXhveW4wZENHVFE2dGJQNjc2?=
 =?utf-8?B?c0pkOCtIcnVXWU9oUVNLdUhBZ2huYVNjVlRVWTV4Yk85YVF2amUzNm9LZjZU?=
 =?utf-8?B?bHIvS3lQL2NwTEI3R3R2UXFzNWxvM0Q3M09qNkVLYjdlNk5xcWptVGcwUUxv?=
 =?utf-8?B?L0FmK0FUSDZYOWVQTDFlUDBLSDJFZHhVUXQ0Z24zNTd1a2NoaUVpa1JBekJQ?=
 =?utf-8?B?MzhNQ0xIbEJ0T1Z0QnhpRCtadlk0ZEF1bEc2cjBKek42bDIzTXdvbTR3UVJI?=
 =?utf-8?B?NGJURDZUQ0k0UEpCVEFhWWxLQjhMbEttVjJyMXZOSTBXdTlhWlJUZDBaWThr?=
 =?utf-8?B?Rkgyejk2UFg3aFlKSUJ5RXQ5aXJTUlJUTEM5VjRyT2dGbk9Hc1lxVW1BYVJV?=
 =?utf-8?B?VnI2eUtBOW5sREd2bUxNVTFyUzh6aHQ5VFJDRmFDWlZ5S1hza3JGWkF5YjVk?=
 =?utf-8?B?Rmxva0JjYTd1RmNzcDJYMEpvMjhJVzVHWXhQcUx3Uy9kdHU0Tkc3TUdZWFRh?=
 =?utf-8?B?NXdRSVF4K2pVaW9DYkdWQ0NSYTNzdkRXNHJuZzVDWWRiTlhWcDJCMEtKUGw1?=
 =?utf-8?B?aEJ0UktxTkQ1Z2k4Wjh4cDY2bUlza1VxUlMzNFNaa3MvRVhLNXNEUFByaXJv?=
 =?utf-8?B?Nk9GUmt2d1NsVWlSb051TEI5L1p1djY5SnZvS2pGSnV0YkU4aUd1U0thSHRF?=
 =?utf-8?B?ZU5JV2s0R3VtY0xweDRzT0NoMVoxUi9IbjRNbStZYXBWa1BPaEczb2t3bjBF?=
 =?utf-8?B?OWdCZVNGd08zeFlXSXpFbnNOMnlQaDJlSlZ5TGRUL0lsZ3c2b0Q2VjBxRXRt?=
 =?utf-8?B?dFBvNUhVeEc3OWNKSjBDMDBsWFpVYTUxZCtCajRmK3dDUklXdTlsRCswNC8v?=
 =?utf-8?B?VUpmV0FKOE44Nk1hZ3NvRXhZdUR6YVFjVFhVaEM1cFU2Rjc3czhXRm40aG9T?=
 =?utf-8?B?SjRpb0w1MWdOUFRqMVlBWUZDMEllMWU1M0ZIUTNNMUl4YkNOY2hmcjVibzhN?=
 =?utf-8?B?bEJKQjNVeUhGdEtPQUl4OTBpakdBZkpQQUtWNDROcVRFajlEQU0zTDFYMDNo?=
 =?utf-8?B?bVZUK2hEbHdRYm9NQjBOZENJOWdBbDEzWHBhRzV4VXp3QVNmVk9iaWZGaXZ1?=
 =?utf-8?B?MXFrSnpENzkvcFhCV2wwMUZyUC9lMGt2Mk1hM2FqdHJjbkV3TXovWmhkVjNi?=
 =?utf-8?B?RFd4QUJRM2ZZTERnbGluMTlOYlZEd2UzNVpOMGNKV3B6aXFkUGl2WlJ4TS93?=
 =?utf-8?B?SFlqVm00enord24zRUUwcTU2SWFueVpHTEhvVHRNSFZaV3FIOXN2T09ZbC8y?=
 =?utf-8?B?clBjNUxERDZuK2h1SkhTVS94ZDY1ZXMzUlp0cEtjakllbTl6QmdpRWVGYjZW?=
 =?utf-8?B?Mnpxcmdod1U4SEpqMEtqNGp1WmZka2xySlM4UDJzejBIUFUwckNHYlUzeGV5?=
 =?utf-8?B?VFl5dlRKeEFkcWJ3dVBOTTZFdXQyOVFyN2RYWVhKNERyTUdncGlJTEZxWTlu?=
 =?utf-8?B?OWpMWUczRWRoVGpqVlo5K2hyUXgvZWcyTUJIMGIyZm0vRFpwSGlhZHBmUTha?=
 =?utf-8?B?a3pIOGlWcGVSYVZtT2JWdmVydWluNjdablMwTFhDNXRVTnRxb2R5WmFJb0FG?=
 =?utf-8?Q?KVALXLqffBk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBFU3ZJcWU5MjQ5ZTZFQm1JYVhXbUlQV242MkdXdkN6aTBnMlEzN0FGNUY4?=
 =?utf-8?B?UURMOTQ3RDlCbmRrOUVuN0ZKL05nbG5MaHNwTUdseVlSb1NYQmFBM0FTNHdl?=
 =?utf-8?B?RHJZVFNBZXhlUHBENXM2SGxjSEhaNE1pbGl0WTd0bEZVSUFSeEk3NG1IUjkr?=
 =?utf-8?B?Z0UxRy9VNU8xZUJGTUdpUmNWcHJmYWl6OGxsM0F1Kyt1ZEpWUk8xSGhUSGsz?=
 =?utf-8?B?R2wwSm1nR1VoN0NsNDBwQnhCOGRiRXF3aG0xbHhXNE0vMFR3VHdlQUZYSnow?=
 =?utf-8?B?OVJUSzRTTTdWaG5mMjhaclJvRURpbDFmQ1FhcE44dkhjS2JFajRhcmlEMzAr?=
 =?utf-8?B?SWdua0FNUVpDWjUzbTNlVXRVbVV6WGFob3ljTXFxWHNCNjgvNHl4MU8wZDhC?=
 =?utf-8?B?OGhrNE43UEVMbXFFRmJKQWthZlp3Z09YdktQLzNpYXBMZm5abU40aXJvQUVH?=
 =?utf-8?B?T0t0OWVLS3lNUW1QUTQySnp3MEtiWnEwWStiZnRvTkk1M1pvUTROY2JGUW8w?=
 =?utf-8?B?RXJBakRjNWxDZ3FZdHlzZ3dRUkx5WXRYUUU1dmxNUjFNRU9pWEdVSENFSnVH?=
 =?utf-8?B?czJHbzc1alU5NktoWUxmbFMzYWhQOTZiTFZhMjdtSE1YNHVjSFpPc2ovZStq?=
 =?utf-8?B?WkxCcndScHlWNDVjRW42REVNK2ZJc1hsZnMvZm16WTJIaEg0R3BlMWdTT2hI?=
 =?utf-8?B?WE1oU1FCbDJ6WVhGbjFwakd0N0MveVdnUW4xY2VHYW0wZ2hWZGs5M2dsTnVo?=
 =?utf-8?B?MDBiRVJYWXhFYkliUDJ1V2FwM3dXYlJQY1dWUkFPSTdMMHRKSklyeGJBYTEy?=
 =?utf-8?B?WkRGTldrQitFZTAwRUZFcnRnZzlNRFhTS3NFQldqMVhWcHUxZTlweTI4NnpI?=
 =?utf-8?B?ckhORVN4ZU1NNWV3YUZYT3NUMG82azBQUS84aTllQnJBNkkrSWRNTVFZNWZq?=
 =?utf-8?B?ZGxYWU15VWljZHcvZUNmeEtLS1lBY2VIN3lOMk9mdktrNlVyNFlHNU1mWjYr?=
 =?utf-8?B?SzlNeTJJMEhWbytrUnRUN043MlgxMHFRbHRJZ0FrcXpEd1lUQ1Y4YzFOMGxV?=
 =?utf-8?B?RUxzL3BMYjR1aVYvWmxpb01KYWU2cWRxYzBPdjVFZXhGK1pham5OSWdVbnBq?=
 =?utf-8?B?UXVVaTVPcXlXMmhuVzNFc3Njc3hZZERuejBpZUxmdWtBWWJQR0syMytGUmxI?=
 =?utf-8?B?dDh2RkxYSjV3QVhmZjFBcDlSOEZkejErN09uMGxhakV3bjZwMVNmaDBNcys3?=
 =?utf-8?B?cHhmVzBYam5Wc092Uy9uNzdhWE0rWHJpc1A1ZmtGdXFlR1Q5bGJSUkIwWVNi?=
 =?utf-8?B?a1FEQXc3ZnEwVDNUandyZjZwY211OTFPZXIxL3dhYXF1V3lBTWU2RmJ0bEE2?=
 =?utf-8?B?SUUvR1dYcERlcmlaOVRTS0V1dXVpUlM2Z1VKMVUvTDFSV01wVnh1U0V6MFU5?=
 =?utf-8?B?OHEvNzRVV0JNSitsMzR2SDFjb2djM1N6bmlpNjE1TXRkNnJjVHg5SUoxUTZr?=
 =?utf-8?B?WitJYytSRUtoYUwrYkJ0bzhGSlk5SHBOZGlCbUtINkxNejdFTkt0YnRoS0lF?=
 =?utf-8?B?cE9maEZlYVBWdzRMVUswUGhVVVlhdFZ6azROK1FpTHhYaTRuaC9aUWFWa0dM?=
 =?utf-8?B?cXB5bUhhMTFFOUJxMENVYnNVWHZXZGUrUUJVd21LSHZ5VGZjb2ZjREpvWVdQ?=
 =?utf-8?B?SlFMY1BkQTFPQXQ0VXlBaExqNTFKelBjQXFjemJhSXlSNTBLV1I2N0hMUlM0?=
 =?utf-8?B?MVNwTVpJZTlmeC9xemxiRGF6RVorVkNiQkZscjlrTmhBaDRKK2JEODNGM1Vn?=
 =?utf-8?B?M1E5OVBpYkpKbXVoaTdaa3VEeFZycHVvTHBMUmNiUUpHejZzckg2MUFtejYx?=
 =?utf-8?B?RXRZc1lUbHNFajczV1E0MGMvaE9zRHlXTXJmVmRRWnNsZHh3OVhoSDMrWHhl?=
 =?utf-8?B?RFgrRnpkN0gxSFh2MjMyRG9TOCtVUmlRZlBKbk4xL1U2S1NiTWdITnRRL3BE?=
 =?utf-8?B?Y2ZjbGQ2NTFUYkVyTVlVNSsrOS9XWmppOXdXWDZBRXR4OFIwcnhjSTNhYkxV?=
 =?utf-8?B?Y0w4MFM5djBOdTBCMEY4QXpEcjJmN0hBZXM4Z1ZIdk9mU0FDdFpQdXRDM3dp?=
 =?utf-8?B?dXhTQTUzSnA0dk9sbTlMWnNtTlJ0UDNWd0VjRzBsZHhuSjlwTFVuNUtUb0hF?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbca1f1-a827-469b-4d83-08dd9117fda2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:43:58.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dVvEgfJmSz33fXxuC9KQCbGkxFnAUr8DVyz1poAl1c2YvpZd4XPPrzpbCnlvEArIzSjdaAsWeBHf2SgEOj3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com

On 07/05/2025 13:14, Ulf Hansson wrote:
> On Mon, 5 May 2025 at 23:24, Mendez, Judith <jm@ti.com> wrote:
>>
>> Hi all,
>>
>> On 4/24/2025 1:00 PM, Judith Mendez wrote:
>>> There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC and
>>> Microcenter/Patriot SD cards on am62* Sitara K3 boards due to the HS200
>>> initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
>>> is optional for eMMC and only affects timing for host controllers using
>>> ti,am62-sdhci compatible so far, add a new platform data structure for am62
>>> compatible and append the new SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk.
>>>
>>> This fix was previously merged in the kernel, but was reverted due
>>> to the "heuristics for enabling the quirk"[0]. This issue is adressed
>>> in this patch series by adding the quirk based on compatible string,
>>> ensuring the quirk is never applied to devices with internal LDOs, then
>>> V1P8_SIGNAL_ENA also has a voltage component tied to it.
>>
>> Gentle ping on this, are there any comments or any issues with this
>> type of implementation?
> 
> It looks reasonable to me. Although, in general I think we are trying
> to avoid adding new sdhci quirks, perhaps there are good reasons to do
> it in this case.

Yes, we want to avoid new quirks in sdhci.c.

Judith, can you do it like in V3? i.e. in sdhci_am654.c with
SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA and sdhci_am654_start_signal_voltage_switch()

