Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843D1448E3;
	Wed, 23 Jul 2025 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251005; cv=fail; b=OgQwdgPn3EqTfK7sTZrVLHfoG8OmBKxk+fR1KzaTP0iJCX9H3jC5CeABRJGdZkHlJLq7SEg/lLiKP1UdcCq/EY6HKtj6Inr62CREjhDkfEHWSmVANTbaMuNT+5Scj6eteuvxMb9vH/XXeKt7kP8lFfAnCYLiBacALRdN3XPAfpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251005; c=relaxed/simple;
	bh=8T+IgFyrTWjDqk/EDqdM2VNrbGXodD/kKLOScqnzp3M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4/EL3zZJMiu1Vf2z8mziMGkn/4fFmyZAru1O54yow2n8jANk4ELbRH1y2ZCVkbahdI8Uyq8+QQXKgDb24wcPVeCTnLznt9rq2W0RIIg8vFQtO8fevv+/TZu5SmCuElLx99H8M1ulNBk4+T8phTGJs/GRy+rCnMGDu8W1BrmjmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cy918UGC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy918UGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753251004; x=1784787004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8T+IgFyrTWjDqk/EDqdM2VNrbGXodD/kKLOScqnzp3M=;
  b=cy918UGCFt+Uqm4aaEfWXt3KqcFhdd/Fu/PsrqpRTbG/IFn36c88BHiq
   7RZFMwbQgJmTqT+eMMPVQG37M1zzOT6MaRVASyiUktKhgHWPVzowh2EEh
   wX+woM27+SC/paSR301lCSa6wpzkKtpNCUcOMpfEbfUdNfZDoGKwjUV5f
   732LuTzoWiEGZ2nQY2HQAsoi+1tCngHTNR0tlB8zcKPXCH4dwkRFqYDMD
   qfBoDdUCaZFhvycOCEurxcDlHo4r5TJJVGn3cCy/BnRotrqGMfgafQd9q
   9qo5feQe5VUAvtHOdfE0viKcGZIv9kj5jJKNnWFMdhhsNj2D5ha6M3qXE
   w==;
X-CSE-ConnectionGUID: MUGlUd0PQ1eh5EKxptI5og==
X-CSE-MsgGUID: FZSLY6gLTbCOoLlWsx5V0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55618103"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55618103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:10:00 -0700
X-CSE-ConnectionGUID: j8Dk1l/wTdmA9LhntrRVaQ==
X-CSE-MsgGUID: ByYhi0IyRKeAsLuudu1LYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159443051"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:10:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:09:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 23:09:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhzrJFm/LswS15UF07s/UJTZMGWPy/h7rpeKSSPKx35SUI5pMyK2WH7cY1WfGRVDH9Mo4vejF/FS/qFn/0nnntDolMKxFrl3Ccfdg8WalLteg4FxKtW1y/60v52bcOXR6GX2ElTc4av73jGSLWAVoYm7L4zBbTeMN6SM9X5nBSoqlGEHFLWVEzypMr6GZ0/WczRknK81GjnCuWsg9rYOT8CNb2bU0yYen5ZLYkAuyju/kM0RcoqUMq8IP09U1o9PiD5AQgnP87rBMnwfR3ILZUJtTSD+bRs96DEQ0WvP4kNXw0U9YzdInU6zs7w0f9/ZubT4TvxjrUpVT4OXiqNUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1TvC0IBTZyLITo7+v9flOdEqWGIZ2THXESQv0zAEG0=;
 b=EUNpsYVMag/RM2WKgwP4i7tIIB6SQdwK+xUURM4XDwv7yH5ejb3rTE3l3OneBAy1Py1+XIUamTcLVE8po5DSx526wTFJsWUT8eBBh/EQk9Lhhxh8fQ3mJoqTaFA0zMpthOuSbZp8CJc/G3izENx2MO04Y2w85dpHGB7iLWDVbdLWYV2CEZ2x2OFm8nhx+JgbU9eF43HzmkDG0K7I06/4orB+a74pasaZCc3CvIOpTw1Pms2105Kpnd5xKl2my3Qj7XmYX9scB1YMufBytoBLVCQzpqDfLGSTGxr1nqb6tSX1BILH5U9IoLJDm9/gy5BdgxQ94291yZL7i+zQRjcXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB7834.namprd11.prod.outlook.com (2603:10b6:8:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:09:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%4]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 06:09:16 +0000
Message-ID: <00e41181-571e-44e8-bfde-b84b74606012@intel.com>
Date: Wed, 23 Jul 2025 09:09:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing
 parameters
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <gratian.crisan@emerson.com>,
	<kyle.roeschley@ni.com>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <net147@gmail.com>, <ulf.hansson@linaro.org>
References: <6366c08b-1746-4d42-8f2e-af0b27766dbf@intel.com>
 <20250722212921.679197-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250722212921.679197-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: b737b8dd-0fde-49eb-a01b-08ddc9af7439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0REek50SGlNcjd3MXRiUC9oczFpWUFEYklKR3BMNkJDNlVPU1pabHg2OGhk?=
 =?utf-8?B?S0VEL0lTU2RKWklsRzU4SGNRYWx4dzV1RE8xUkc0VUpSS0hEcFJDZWRQOWFR?=
 =?utf-8?B?ZE5aZTEwdjZoWk1rRDZjQXcydWZEQi9naWpGQWhTblBmcUFCcm01eUNGemNW?=
 =?utf-8?B?TEJQVmVmeGRJMnFibnVlZ0cwMno2Um9sR3hLQkQ5NlRRTUdEQXhxVEZZTlNv?=
 =?utf-8?B?dFF0RmNwbGFWMWJXMG9WL3d5YytTQ0lEdGpISmYrTlp4NVpJamdGZDNZSjUz?=
 =?utf-8?B?WFlvUzc1RGd0RnRUd3RHME1FNHdFcVUyV0hQS3g5aUlNbWhOcTZkUSt6aE5h?=
 =?utf-8?B?WmlxcXFSZi9pTGZlM1pKeW5UWmhQb3hmVmJlaDc4aHZrVW0wOFZ2M3YvOU16?=
 =?utf-8?B?b0dnODZaY2lVOC9HOGFNVTRYcmZaWklSUk85a1J3OEJtQ3kwS0RIcG9ITGpC?=
 =?utf-8?B?V0JmQTY2a1o2aHRwa3hDTHl3TWdwbHpEZkVMU3ZNZkFmZ1RhS1dGSUJCaTI0?=
 =?utf-8?B?NnJPaWZ6aFoyWS9ia0xYc0tMTnlWcklHVS9wWEdlYkhoZWxkeWdXVEhXNExh?=
 =?utf-8?B?amEweHBRcUlkaEtJbGp0anByU1NRRTdHSGE1ZkhoZ1VjK015dENIN0I2RGtj?=
 =?utf-8?B?ZDVKRCtaU2NxRTJTMW5LVlJNczUzVFhWOEhQdkVKajlYMFlEUkhXVUQ1Qyth?=
 =?utf-8?B?d0RPSHlmTEcvbEZURnVuVVFiZ3dyblhnRCtzTysybnBOWlNvRHkwc0cyUi90?=
 =?utf-8?B?MWFrTHZob3dpcEo0RlNkZHdnODJYV0FoOGwrTkJ1bmtDYTRiRDRQTnJCamha?=
 =?utf-8?B?N09WRFkvMXdVb2piajJWREtRRHNQVUcvWXlRQ3RieVowMmVaOExWTkxOTVNN?=
 =?utf-8?B?b3FhcHRwaUR0RmpWL0ExSmo4OWxsTXJnM29IZVFZZ3FwOHRNQTM1N1JQeThp?=
 =?utf-8?B?elM4VUdod1VQZ2VqYlNPZitqZ0hlT3JZeFNvbXNKaXJKWHhISGN3V04vU3VB?=
 =?utf-8?B?VHNIcUJPL2tZS0o4RTB1L0o5c0lsRzFBOWFXT2dBTitpSmcwQnVGTTl6THQ5?=
 =?utf-8?B?TkhIaVgvbEpBQy9NSk5haktrOU95b0JyZTZ0Nk1GZXY2VVdXTk1DOGlmVzdz?=
 =?utf-8?B?cVVYaWIrajFJMzloRys5WGg1dC9sbFJwRHJnYThuc0poK09OR0E2Nm5YTWs1?=
 =?utf-8?B?Q2RQVnRhMi9ydkVtcys2alU1NDZpNEpKVm1DNjQxSzY1cktSZk5va3JYK2cr?=
 =?utf-8?B?M2l3eklibVVTWGJLSlVob0RtK0RMV0k0N2gxbHlOSlN4Wmh3R2Z3VXpPZ1pu?=
 =?utf-8?B?cDN0SyszZnp5b1BzRzFuNlhOT1k1WURzRXR1WkZueitvZ1ZNT1ltRzZNQTZS?=
 =?utf-8?B?dmRydzFFVktjNHNUd01ZV2MvaWJsTW10Yjd0bmtITmQ3N1VKcnZFUFk2SnBs?=
 =?utf-8?B?aHI1alg5cENldjFwbFd4aEZ1MERLVC9kbXZ4cDBhTDlLUFBQeTFRS0ZacG1O?=
 =?utf-8?B?ZTgwNTJQSjcvMksxWGFwRFRhc2dvd3hJVWNvekg1TXhsOGtJbWx2T3AwWE82?=
 =?utf-8?B?WEN0NVZWblQ5NEtNbE9TOVhTeGc3SzJzckRCRzVaZDVYSGlvdldGWE95aEhB?=
 =?utf-8?B?dVA2VHZUMUdVV0ZsdVZ3ZmNsdjhjWTVLaWhsaVF1T2RxMngvTUh5YUFSZTla?=
 =?utf-8?B?bkFYbWlpbENkMDV5VjV6cm9HTnNFcDErZk9Vb1ZQd3J0c0ExMGt3dG1jR1oz?=
 =?utf-8?B?cVBUVExQRGZtZGFVN3Z6NVh2a1l6cmtRYTJIbzBqZ2VrVGc1dVkzQklPQldl?=
 =?utf-8?B?eXdOQnQ0NXFRNk5lQndIZ3Q3blVLWTlGdVlDUzg5Y0dpNUVtdHo1emw1VUVp?=
 =?utf-8?B?QjQzK2Z5dEttaENwMnVncUp5ZGlmS1RDcklYVXBFTFlrYnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZjNGg3QkFzKzNKMGl0eHRVNDFwY045RzJuZzdQZTFOTFExOEhyT3R2T3NU?=
 =?utf-8?B?MDFmOEU2UmN2c1RMazc0bzA1eFphajRZRU1rMU9ETUFFOHo3OUl3OFVoNkZR?=
 =?utf-8?B?M01wd04zWlQ5Wk1BeFVETU9ZUDV6TlFldVZ3djgwd1NvY1NJZ1RkWmd4SUxC?=
 =?utf-8?B?aXVVSmI5QlJzbGljeG5rZWs5YmNxK2JGN2U3QlRXOTkxK0RZcFE5RjhOWWVX?=
 =?utf-8?B?bEI4T2xCdEdsbzFhVEdNbUV3dEE0QkRyUmNSVCtTemJmUXRGemxTQS9BWU1C?=
 =?utf-8?B?QmlZTUVFOG9wek9ybk4xZEZuSllIK05JaEVjalNWcGtERXBEZWUwc1NrUldX?=
 =?utf-8?B?VXhzayt1a3NCTWdhZlNENmpHL05hcGNWcVhIRGZTWWZkeHVmNDMycVBQa3JJ?=
 =?utf-8?B?MklaY3U0eHk3Q2h4S1VpT2haQmV4NC9hdkIvS0hTOFhDZk1BRm1IZ2c4RTZI?=
 =?utf-8?B?NWxkTFNoclFYMndQd2ZxOElPLzM5QVFMWUthQk1EUFlhTG9CY1NCWDI1SWow?=
 =?utf-8?B?VGRIU1FuRkszd2pGanFZVGFoejlvdk1RS0JlSFFBdEtOMFhjRCtoazhDaWFS?=
 =?utf-8?B?d0NRWW9acENHYzB6ZkVyQ1pXc01vTTBJdnp2UGFUK2hJckpWWGxWVE9iUS9x?=
 =?utf-8?B?TWdIQWN4RGp5c3FITjFta2JvWm9FQjhPYjdieXlkWllPTmV1WTFQQTJjTGpF?=
 =?utf-8?B?MVQwVi92dmIwMXVFaGdFMUFBQlY3SXpUeU5rZThaOVEvdmlBWTcyakdRN0g5?=
 =?utf-8?B?MStNc2VqaDlwUWZOeit2bVFJUFY3c1hSTjlzRXY0NFZHdFRhV0xsZ1Y4akZh?=
 =?utf-8?B?Q1JMQW1Ka0t3NUlNVndjM1UreEErVXdoT2diZmV5K0gxajJHUktvdWlJTzk1?=
 =?utf-8?B?dDhmWHBZdkNzdDhBZzRSTnp0azNIZ1BRRDlnUkNidGdTL3U2akpySWlHbTBo?=
 =?utf-8?B?VmRsNzVMZEJGQ2I4VVluNkJrTlFzMURDSEJQZXdyVDRMOXhTL09EMjErTEZr?=
 =?utf-8?B?UDlKQkFlQ0JrOXRDYkNoQjNqbnI1RGhEOGJhTWFwb1lnaXV2M3NxSytpRFZV?=
 =?utf-8?B?NVBUNCtYOXUzYThJVmpQUktUd0RkTk56TzgyYmFMUDlFc0wxYm1XQ0JNRFU3?=
 =?utf-8?B?V2toaXoxeXZndTVGRXQ4d1JuamQzcGtQUHRXa2huOWZCRFh4dWFoYWF1OUVI?=
 =?utf-8?B?ZHdCQU5PWGUyZWk4ZFY2dHB4WDVORldNcjV4SFU0VVZocnNGRTJPNmQ0VTdi?=
 =?utf-8?B?b2pLUHVTaXpvY2FIb0V4RXVQelVVT0RwVnpFcTgxbGhEYTBONE9TMlNBclhZ?=
 =?utf-8?B?T1BSK2xqNzAvOXdKbW5MMjU5ODRGbzlqbWw2Y3hTUUI1OVpiWXBvSWdOZlp6?=
 =?utf-8?B?SCs4RzVIOUdQVHVpTHF0MzhUQzVzOGZOM2NlbnNxTnZoc2hTWnN1K0VjN1Vv?=
 =?utf-8?B?cytIS0tZUUlIZllaempFRVRobVVRQjdvWldEVGViM1NyRUVJSVBVc0k3blEr?=
 =?utf-8?B?RlA2U3dtQ3g5U3VMZk9kVEExZ09tNmdZUFIySTc1Q3VDR08xT01CdE01cnVC?=
 =?utf-8?B?YjlCSEpJOFU1eGFwTFNNa0lPU2Y5aVVBTUFPeTNMZTVBZnBGcnlBajdva2Z1?=
 =?utf-8?B?MkJqUkM5RzBXeFp0ZVFuMHV0cFhWRGtKNTVGL2hYMVNTeW5KMk1xVklDRkVn?=
 =?utf-8?B?bTJLMHROQlNLU3o1S3Q3amZic0pEbFVDYXd3Wmwzb1g4Q3EvVWVTckVuOEsw?=
 =?utf-8?B?WnJoTGwraE13dHpNbVFaZG5MWU91WWxlVnljUnJEVjRrS1BGaS96eG9rVXlz?=
 =?utf-8?B?QXNJczJwZ3V6REhpdmNlVnpPVTNSZEpLN3Zmblk0U0RiSkVZUXhleFVVKzN3?=
 =?utf-8?B?SmZxU29EaVh6UHFieVQyNVAzclQrbVNjeHF0ZVJlS1FKM3FrcHRZNU5pQnpy?=
 =?utf-8?B?SDRUVHJnTWZGd28wMzlVczd5Zjc1WEFVd1hlSG5kWTlKaUFXaVcxWmovSkZr?=
 =?utf-8?B?Rm1KSUNPRXhkK1Z5Q3pZNkRjenoyZ2F4TmhyYkVQZU9xTk51bFJjOGJhZlFR?=
 =?utf-8?B?SjF3RW5LZXdQdkNUei9xaG1OYjNaVEVFZGRzZlpwZkJHSXlTSm5iYk4rYnBn?=
 =?utf-8?B?L3RkdWo1bGtZY2d6V3BrR296bEdva0Z3UHpONmFmWkpOakl3eU5WMkNKRGpP?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b737b8dd-0fde-49eb-a01b-08ddc9af7439
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:09:16.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XwpFgMPAQCrKAXgJMtSeZp+J5jUvFf0DnosHJGmbLtb4+Bf5Qkmmn4mb+OM0nDZ8I3/esalw37dsk4+RE+dHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7834
X-OriginatorOrg: intel.com

On 23/07/2025 00:29, Erick Shepherd wrote:
> Hi Adrian,
> 
> I believe this fix would work since it looks like it keeps the
> functionality of the previous change but only for intel SD
> controllers. I also tested your proposed change on one of our devices
> with a Baytrail SD controller and a Swissbit SD card and did not run
> into any issues.

If you are OK with it, please submit it as a patch
