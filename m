Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A492EB841;
	Tue, 19 Aug 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609709; cv=fail; b=ZsgsABlPwQHXP/ECTTyHWWKmEtWJZKfeMIcLgHtvW7GSEX1xugQpManoEXBEpQZBvHolEn1uVRqE8ciqFs85vhmcCCwWh/qPjO7dYPjhDw69ow6WN3PAJNpUiS4Q0mA9k2RnIJfl+/lZOz+mY8RbKBJFZ18L8SqhxfQNTotxUdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609709; c=relaxed/simple;
	bh=0kdIy4WfOXUlSth3/cnr93SRxFXJeE3mxWf69JTW1c0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIhTlM+0y2Kh1vKucqnGHOWf0AYtz3+KqIz7gg+zMb0gAlRq/zQG0m4E1hA104M3gSGVoqYxhh/DxsSKHA37bxHAPnyawAS5oDKPG4B1cDE1cHNgf9ITHwxMRm7Yfq3glxKWSItQoCwYCl2XgV6mqKRb7kKzDyV1fIAP32Y+tYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1VX5XCH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1VX5XCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755609707; x=1787145707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kdIy4WfOXUlSth3/cnr93SRxFXJeE3mxWf69JTW1c0=;
  b=W1VX5XCHnKRjPov3hsIke+3I3+Kv8xDLzT6I58urhI2G6iWMatWN5bGL
   6eQVTcH7R6xeFqQvmQo8iAhg3h9lgfaWEjn9w+I98ljmdNBVjv8M+RKKu
   pgRFUUDvNWKSONWtABwZFGU2h/5SJl/D4t2cDifxrBQVy3C0Qz4I+fIEF
   mjqEXyUQ3ewChMCFlJaSM/geIKQUlAN7a1GpJq2Df+l19P7szCV6S3Wdm
   zlqRNWsn5togsRmEiIBCZgI4BZjbeM2A2f77lJzaHm8m/6Si5ik30aw5H
   20JviUwVTm4s5hOJo0wAUErQxPHSj7pYTkl4bIQ/TYr2a1SQp4d4IHzOw
   w==;
X-CSE-ConnectionGUID: /BtNJxxSQnySwip7aBKZzQ==
X-CSE-MsgGUID: UE//1NbkQIyvEEs2ehUxMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56881238"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="56881238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 06:21:47 -0700
X-CSE-ConnectionGUID: PLKyHfg/TMu2nWdDQSmoiw==
X-CSE-MsgGUID: PZS/ouRhSt2GMalxooMKhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="198709949"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 06:21:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:21:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 06:21:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 06:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsk5cGyxYzYI8QGV8ODVrTsrSb6dBkXZxEgOcuaH6y7pXRgG8IV/hWS+UIOzVg6zE6/yKcznm1nHhDJrYTOlX/HYp7+AJAwnNPs6gVBy/WvMzPhoH4yk38RF2W8W/SUshjNdeQiLFfafEexNVjUmmUAM2QBP9HhVF61bkKrbh4mxQnRdY18FxkwujWA3zfGlCAHz/rPJ4gybMARO9FxdDs0JO1ZQui9X+M+FTN2VQJ9VLc+tnf2C4kNqQqWhOhn6QEKwlBioL5s+G6GtuJSv/PUbYb3Fpwlw1W8RpSOcS5L7wpEIHaHRfY1N1ujQaIZVKWB80K/H5sWLxsBejuBwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAo14Fso5H+/Um2vwiGnYeTntFJPkDIrBhoUfGjBc0c=;
 b=S5G5THr7MgTUWqaH/yYZz6EhFdtX70HThHpCkbeQwJQ3ihohk5OblkBkiXrdAddTUzqeWA2SNc67zBmU6HeTBgocIzWPYd2FGmDtycGk/3dsRBZ6NYPGRg7Dk1gQnRuLRvUysJyklX9lqcW2STSn/sMhL89OgN30yud1R+lrfeU99Eu6AixSJXadzAnM8H7vw/gZhCczLl5ail2vFStvH9SfJ3oPoZCzjKuFBAQYHOfnlVCbI4GnVNleyoVLUXRQBgchwuPDpX/7yeKikQrH5g/L8jA6hF2SOnCVCOkPn47Ag/m4ecVC9zhUyWTIlIj3UQIG2moeQ/JYd67DJSsD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:21:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:21:40 +0000
Message-ID: <f117bc05-893f-4c89-8cb7-3f40a8bfb92d@intel.com>
Date: Tue, 19 Aug 2025 16:21:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and
 SR1.1
To: Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250818203310.3066985-1-jm@ti.com>
 <f07d0353-4103-4776-a303-f6a3aad5bf15@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <f07d0353-4103-4776-a303-f6a3aad5bf15@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::32) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c87731-93fe-491c-7c11-08dddf235546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlJqU2VydVlsbDY4Q3oxQVZ3MU9RU01vYSs2Q1JuWWpTZEZreWVuNUMraExM?=
 =?utf-8?B?T1R3L2V3QndIYnJFODdTYm9CYzIraDdmYkZmNFlIYk1SV1JzaEV4MGFFV0tx?=
 =?utf-8?B?TkpaSk5xaTFGUUJTTEJxemJTODhHWXFkTkF2L3dpbXBhbDNZemZJeXFmdzg5?=
 =?utf-8?B?ZW8xQlVCS1dLMzhKN2l1NnBBbDRwTyttZTk1SSthVWdlZ2RZUjJDdTdwV1ht?=
 =?utf-8?B?YitLZEZ3OXd0ciswZE15cmhocHZXTTVXYkxhUHBod2czNWRyRGpwNHE1MFYr?=
 =?utf-8?B?bmRGaVZLbGtkS0UvUmxIQ3N0SUlzV3NENGNJOUtBR2E3VTN6QVNKNFo4OERu?=
 =?utf-8?B?LzFVdks3YTREbnU0SytqQ2oxZmFYSTZWQnlKNGdjbUJpNVY2V0k2Uldoazhk?=
 =?utf-8?B?UGlYN1BSN3RIcVFKVHBEaVd1a0dkMTlaWm9GaDRybTlHUVkwZ2EybnJTSnQ5?=
 =?utf-8?B?VHkzTVlGRTlmNFpTYWh3dEdIMVJFanVVWWF1enhzWTRsemU3eGl1RVVOMTlv?=
 =?utf-8?B?Mk9BRU5xbnZzNHVSZzBFNm9KSkVOdGlqK2V5Lzd3cUx1d1BnUUtrRUdZbFNx?=
 =?utf-8?B?SUxYckErRnppa3hRZXNteHhJdmtNNFZnUTdKaWt6U1ZONFhIc0dWeUdYVXNI?=
 =?utf-8?B?em5FbXRVZ2daamVCeTcrd3Y5RjFLR3dVc2l0MjFtTktWdTRsdlUzOG5aNThl?=
 =?utf-8?B?SVhZekNIcHVhVFV0TmE2eUJyVVlkQTdZRDFNRmFZVUVSM0tLOE5UQ25KanVh?=
 =?utf-8?B?bHVGRnlZNmhhLzJoR1J3T0dSWnFVNUZaTDM1WkkwM2VnUm9jdEs5VFJ5azNh?=
 =?utf-8?B?QklRbXZLRWJ3d2loNE1HYVgvZ2lZc2t4eVhQeTlicmdlRTdFS09LWElMKzcw?=
 =?utf-8?B?NWZPQitBQzViczlUN1QyT3RGMElIV3BTdUVQNTlKOHIzaDhHODJQaDZwNkRw?=
 =?utf-8?B?MFY4QlNHSktMR29LTllvL1lxUlRybHlsZy9iQStVb1lWNmpWaVRUVG1CUzM3?=
 =?utf-8?B?bGJjelhKUEhabHkwM1k1a0VFQzlvMWxPVm5YOEtKeWw5VmhIbmgvenNWZEN5?=
 =?utf-8?B?OW9aWGNRTm1OVkZ1TWJEOW1zcWFKWHl6WHBOd3BlSTlZdDZZZnRvUG0wYzYr?=
 =?utf-8?B?ZWtxTVZiMEROOExBWWFoVm9KZ2hLN3NLVEhjMWNvL0tDSUd3eDEzdGNFNTVn?=
 =?utf-8?B?R1dKWHhkWTROVlpzV2k5eDE2cURDRVg2SDNSRDRIVlFROERwUU42cWdUSjQr?=
 =?utf-8?B?ek5QQ0htL3VOOHp5UFdjdk5pQ2VjVzBneFlKVW5QSHBrRWZQRWVBOFA4dlln?=
 =?utf-8?B?Qzk4RXhIRXY5R3VlbmJLWXZmbXBIRUs1T3Q0MGUrWmhPMGNucGY0MldEUzF6?=
 =?utf-8?B?Tkpnem4ramZNZ0FaYXhOYWh6QkRQdU1TUnJRNStiNURDalJzelF5RDJoRDBU?=
 =?utf-8?B?WkJ1MmZtVFBIUzQ4YVh3UHlQb3pHbGJEek5UY2lRVkpSNHhBZ2xESitLQnhS?=
 =?utf-8?B?b0lyL09tcHNMUFV1MFJXVW1JMFdDY0t3d1lGTVhNbUlKQ3FwanA5cE53VjhL?=
 =?utf-8?B?NE5aOU5VWW4vZ0ZwQkk1YmpCYVpRRXhQSG9zUm9tY0Q4azZCbUFlbjBGTG1L?=
 =?utf-8?B?RDNWUjJEZGdtZVpmQkZFbnFHOFdQbDhaRGNadmtDdmx1NjVhWGUycUhlUTh4?=
 =?utf-8?B?RUE5V3NybmZyL2RONjM1aGVscSt4bTdkc3hiby9FaHVTd0FJZTU2U09rMjh0?=
 =?utf-8?B?S2ZvQ3RSVVJVUVBiVkQ2TlJoNmFQU0ZZcEMycldvdXZuTkhWWjgrYWtpam5Y?=
 =?utf-8?Q?7Sr5tvKckfrwGX26WOyO/B6Nxd24T7Qs5WrHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJzdk5kUFhzU3pYQXU3dmZlY3VhVWRxTERKMTV0bE5MTy9pZnVlTVBTMVUz?=
 =?utf-8?B?cHNFL2ZHaC9FeFEzZlNIazFWTG43TEdSa3RTVlE5THk5K0VmL2NWZVptS04z?=
 =?utf-8?B?RW51cEM0cjgrWDFESEdyb0xjd3pQTWp3Yk9NMFdRK2FVTmowUjdZZzdzMDFJ?=
 =?utf-8?B?aE53WE5qK0ZqZUJIbjV3eWVBMzNyc3ErRjNjc253L2xWOFpBK1ZyT2sxbFJj?=
 =?utf-8?B?Nlp4NnlmUXpSQUdFajRFYlJRdElhcEF2YUowc3FLT0pUSmMxbXF0Z0I3SDNS?=
 =?utf-8?B?RnRQUXU5cVcwU0dKMkpjeVBUYzV1Q3IrcHZZWTkzbjk2UkJTYkdia2t2RUVs?=
 =?utf-8?B?bXRjcVJzU2UxYXZtWlMvSEI0ZkZ3c1VxOWZqc0Q4R2FCMWVlTkROSy9xVE40?=
 =?utf-8?B?NEFKTnFRQzN6Uk43NWhtK1FUbXVla2g1RGl5TVYrSzZTY1hWUURxZVdIU3Iv?=
 =?utf-8?B?Kzcyem5RTVhpMlpKaEhXQ2ZyQ1dmdkFCTEsyZ05UOTM5MTBTSnV2TkZRWWFK?=
 =?utf-8?B?OExOdnU2YzlZWW1wVUc4ZW9ma0phc09Kc1BLb2VIakhwSk1kRDkxbld1Yzhs?=
 =?utf-8?B?dzBuUk5aeTdIaWtuQzNuNUpvUFlReE5pVDZsOFpuUXpXUlI5UG13UElJWXBq?=
 =?utf-8?B?OE91RnloaUZwM0JSY0hZcnlVU3JPUTdjTUc1QTNUbktScEVFSld1dUFNcFZI?=
 =?utf-8?B?V2NjTVcwb3I2THB1K1ludjAwNmNmTlZ1Y1hMb24yeWhLN2E3ZzJQUWdjZ0JE?=
 =?utf-8?B?MWhnWGVaS3pHMGlaMHhCNlBqWUtSZEUyZ2dvQ09ZZnRheUZLOFY0SmNuY2dn?=
 =?utf-8?B?eHZhVk1RZmhKampienJiZ3htMVFJQlc2SkNaeVdzVzh6NkhySzlXK05kSzFv?=
 =?utf-8?B?bWRSU3R6SmN6cFVHUVNmWnd4RnFSSDFraWlobndUYzAyUk5YOGY0eHVnUzZm?=
 =?utf-8?B?SzhJSUFDM1h3UURBcHM4V25RWXpWOC9QUXBEU09EcktaLzZKSUNtNVVwQmo3?=
 =?utf-8?B?S3ZTa29EdUk1aVpqS1hQSmRPcTJxUDdncllQcXVRcXpSUm0yRGJPZXNCQ1g4?=
 =?utf-8?B?SW5Bc3pabEVCWEVFeFhaeHJtbStIMThwaUY2dDZpeGNGZHRjTDAzenZJR2Fs?=
 =?utf-8?B?d0ZyMndIU0tRcDdXblNSbUxIdXE0YWdiaU8xQjlXbG1la25PZWVXRUFYR042?=
 =?utf-8?B?VTlSbnoyMmdQaVhxc3lzdTFCUVFoc3kreVVHVi84MEhFbmxVclc4Mk1yME4x?=
 =?utf-8?B?ZzIvYUx4YVc1bnp0QWI0LzV4dzErYXgzYzl4TjRCL3dQQnl5V3dHZ0J3b0lS?=
 =?utf-8?B?OVJkL2NiR2M2L21HWWhiYmI3elpOK0tRRTFleFUxYTVLTU5VMFMyQVhRYXBZ?=
 =?utf-8?B?SFNLK3ZmREp2WE5Kc0I2YWJWZkpjMUFHVDdqbkpnUzlQYUduV3J6MkRTN0NT?=
 =?utf-8?B?dW42Vk9rNTdSdTN2Wk0xTjdwbG94anlHOUtSSjUvVHo1UjBSQm03ZnZEMEV5?=
 =?utf-8?B?VGc0Nzh4SmZvTHNRQmU1aHRDVDltYkI4aHEybFdXZDlrcmh6UFdQV2VhWE00?=
 =?utf-8?B?Q2ZKcFFYamhIMG1SVkdQOVJtYVhOS01FUmQvRUg4US9MUUhDY0ZrNmtBbElV?=
 =?utf-8?B?bDdxZnBvMVZEdEdLYzVUT1IzWlpTaUJKZTlVeFZmYmp0UTk1S09kakpmM2di?=
 =?utf-8?B?RTFJZFZxOTE5YlZBSWpKVXhUNzVlZzhEd2FEdGhueWtoT1RzSzBVdDBDUTdK?=
 =?utf-8?B?ckFTS0o2U2lITGU0NSt1bUpyc09LT0lZSUhrNXFpRWZZWUt6dE1ER1F4VXRJ?=
 =?utf-8?B?a1BMM2ZoeWExU3hTVmxnUXBMRkVIK3pwRVpNOGRZc1EvRnhHbTZHNTJPbER0?=
 =?utf-8?B?WWozUHU3ZzFmdVdyeHhHR3VkRGhYaDhyajNPbVp0QkJFL0t1MGlzT0Y1YWZi?=
 =?utf-8?B?N3VidFdxV0tDS3I5UVQyVEpJRHBxK2w3SmxocnhPbHNqM0p4a08rc1FKYUx6?=
 =?utf-8?B?VCs1SDQwMGJObjh6cXEwZEoycHRRRmZjd0RCWHlXZGY2d0VyUnZGcEl4OUYr?=
 =?utf-8?B?aTY3WElkejcyWUZjbVAwbkZLVTJzb1p5MnB4TjltSWo2NTErbXlVLzBLYXFl?=
 =?utf-8?B?RnlYck9vVFhSd21xeGk2N0oxUEJFOVo4R1B2SGFXNkJ1Q1hkZTM4eWtVbXV6?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c87731-93fe-491c-7c11-08dddf235546
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:21:40.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDLSncOWdcwYbfxGPHVAk2zy50CYu+ZPfTv4JZkhEBPMTi389MNqM7TN2Yzn2BM2XH5kahiTEqX5fCcLYBIg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com

On 18/08/2025 23:38, Andrew Davis wrote:
> On 8/18/25 3:33 PM, Judith Mendez wrote:
>> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
>> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
>> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>>
>> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> This patch was separated from [0] since it will be merged to
>> different trees anyways.
>>
>> Link to v2:
>> [0] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 8a099508b939..cc8c4145bf2b 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>>     #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>   #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>>   };
>>     struct window {
>> @@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>>   {
>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +    struct device *dev = mmc_dev(host->mmc);
>>       u32 ctl_cfg_2 = 0;
>>       u32 mask;
>>       u32 val;
>> @@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>>       if (ret)
>>           goto err_cleanup_host;
>>   +    if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
>> +        host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
>> +        dev_info(dev, "Disable descoped HS400 mode for this silicon revision\n");
> 
> Messages to the user do not need to be imperative, maybe:
> 
> "Disabling HS400 mode not supported on this silicon revision\n"
> 
> Not a blocker,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>

I agree about the message.  Another possibility:
"HS400 mode is not supported on this silicon revision, disabling it"

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

