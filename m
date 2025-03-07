Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2201E485;
	Fri,  7 Mar 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352569; cv=fail; b=WNNQsViOyL3VyWv+rFnhClJbufk39v7ehd6qtPx5ul4UGttu5kh+/K+iy+C4FiGdlp1csYqXFN/NCLgY11Oqw4sGBBFxJTC+MdJaa7LIdclCbGGjoLMD+IblN0YPbYt1mBT4Yo19hr83w513334l4kKRYLj5nOnklz195OkMXiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352569; c=relaxed/simple;
	bh=qB7NynSpiBaT5U/UtRPaFzBgz2FrYuwdqNlOrGKW1QY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PydEkBjKrXSFAoh21bRV/0omeXSNfsPjHWEBsCm2V/Euo93Cj04ZrzNpFrRPZBUq5mNZBJKtrm+0q6K2Ei1pEYdZ5G2d5nv6AK/j9GLkDETc3eyneahlEAUeMoUCsvgcmAduTVonhPWfUzbneemyJGS/VzkIzZdstXYT3zSCiBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQBgbpPk; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQBgbpPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741352567; x=1772888567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qB7NynSpiBaT5U/UtRPaFzBgz2FrYuwdqNlOrGKW1QY=;
  b=gQBgbpPk64BOi5zaasZsVYcCs7qOHpB5iPfn6pn5BoKVhDmfl/qByHWZ
   k970RpjUYk0/M1z7oHsuaNNNjWmTMMIlctwJT1J8YejshIoufwyjgCPPC
   LB99cuVq73hC4Nc/qiGpwrR3kCn05aWRTcP/FyjXXOyUGXrHyt62tqzHo
   S66yXaZLVXp928iscF+FvzYD+rNU4SIq0Qs6n/MaTtLG5LVY/pO9+2/44
   OE48TuHi0p8n9UEeWXY4s9v4pQVnKtDdTBE98abHAO3Ju7KDBWnjy2Z/0
   zSYQ7JPccOQoOogKaR0XKlp6WkSrSELof8eW0sI62dzKqyZZRM8L5lu3/
   g==;
X-CSE-ConnectionGUID: p4m7tH4cTKmDmPDgS7iryQ==
X-CSE-MsgGUID: aF/FXXaASwS9tM47krnxVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52607115"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="52607115"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:02:46 -0800
X-CSE-ConnectionGUID: mwVV/UxIRWGAZJCredkL/w==
X-CSE-MsgGUID: PUcAS4y5S+mY46rynsVpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124411576"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:02:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 05:02:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 05:02:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 05:02:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMW28kiBftaZB5SpmNLzZkei9WpaTaRz7AIpFn8zHM16rzMfTOhuWo4WMCAtj6bUE3i3soiS+Cbv5plB3k5E9OGnbNEBVO0MRoTdYo6Ys2E6xIH3NtWzq8q7YW3qTyWfFM7uaMB+GrtXVNoq9h1CY0H/NBxrvYV9G82Gi+wVEDW/WgRxOijMJ6rux060/8hFSB7Fdxpr5zidRPLdMXI9qiG0FSFgFU0t8krgU0WigWqCC5H7NXVaC4LYgxStyFfzAOOtk69wgXtpg6DZj18C4Rkk9E9SbTuEDpIYgsZIMgDjCEIREVOyoWmx8/63dqnGj/DkFwizCRIk9QzMB3SK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBhqEjFbHrqlDfvvehSoxzo+i0sKbVG8h1tW6QQbINo=;
 b=Q1loJM5WNGOhp2tBdYxGP9m+yRdVa9fz9+Bf7vkHO3QVISWGKYFLVGvOiHL/lvIdEH6aTEluUtB1RfhiydiXkRgbCYLYsKcCLsDQP5RYU3oDmtzw7XUpPFj9WOc8tvjZejwDPlq83ugaxkhdaslSLd/OV1sORc0xN4JXN//6AS0nJUFWktHD+uMCQF5WAzy/EOegBCJQn6ZHi+Ir25bL4bzMhfnALTiRdUMRwwGfLhH+w63II+Lm50e6uL/ygamM4Zhg/5vZ+6RTqNzp9+33vAcGFJEf35iE1m795Pv0xL75Yh6TOzag27gQKQZCDl8yNFWlsfIfNe00PCe+1o/Taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 13:02:19 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 13:02:19 +0000
Message-ID: <bb6dda27-e4ee-406e-bb29-828dab346b9f@intel.com>
Date: Fri, 7 Mar 2025 15:02:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mmc: core: add undervoltage handler for MMC/eMMC
 devices
To: Oleksij Rempel <o.rempel@pengutronix.de>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, Christian Loehle
	<christian.loehle@arm.com>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
 <20250221093918.3942378-5-o.rempel@pengutronix.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250221093918.3942378-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0358.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::34) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: c69377e7-b20a-4733-eaba-08dd5d784af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFIxc3ExaDVsd3VITzdsanRZOCthbFhyNzFLbW9ycC9ORk1WR0pGTWduVVQ5?=
 =?utf-8?B?Q1l4NWQvOUQwb2h6NyswVDRqb2JvYWRramJSaHVqRGYyeE1aSGM4dU9yMUZ1?=
 =?utf-8?B?WnJvTitnOVZXbkVpWW5RM0dsQ0xFSTViRUJuWlVFVjhGUFR6UTNCaFdTbzdr?=
 =?utf-8?B?QS83Vm1ScmgyOGxpa3pNMEpxM0xLN1JubGgvbEs2d21tOEJzZUZxelZYczNY?=
 =?utf-8?B?NXF0TkdmMWxWdkpPZjMyc2tXZXV0cjlmV1ZONi9jSlFqa1ZvVWcrTVhNVFZw?=
 =?utf-8?B?TUZLOWkvWW10aE84eGFOMWJQOFhRanVBZUtETnZMdzA0a3psS0tzSGdjcVlV?=
 =?utf-8?B?eXB4V1Jyck5vS3psT2JQc3hZeS8rTWJGaGJWdTdFYVYyUk5tVzVrc0JMMVl3?=
 =?utf-8?B?NW8vcW51VU5uV25Bdlp5aVcvc1FTbFpKeDZuZnl1dWxyck1NbERpUFd4R0J5?=
 =?utf-8?B?cUZRbUVqNEw0RmVuM1B2R1hKUmV2R0xtTHI2UUc0d2R4T2Y2WElsem5KTFRG?=
 =?utf-8?B?cUs3bkQwaHJjYzRSMkpIeHpuMEllV09VN1g5cHNUNTloZU9JUkp0TW14SWFy?=
 =?utf-8?B?VkpSMUt6ZWJqbi95V2J0VmFCKzd1T3gzWU1JcG9hNC9tNzZDeHlnbmNUTld5?=
 =?utf-8?B?aUlIbWlUZ1JvWjFuSW01UHBTbXJpaFdwenRINVNXS05EbHZCN0ZacE5ndHpQ?=
 =?utf-8?B?UmhLYTRXc3E1YVpNZXZjN2F5Qi9yZXJ3THRpQzUyUjIraGcxWDZxR01KMER1?=
 =?utf-8?B?OUhrdVBOZDZaZjhTdURIdkw4YzdtYmR0eFI1WWE0M1FzdFZqcllFN0UwcldJ?=
 =?utf-8?B?algvMzArb3haNHdoMjlsZ3VKK3VCempoc1drN0pQdVBiUkpBOFNDZE5HYjk5?=
 =?utf-8?B?bVV4RklSdXliS0NlQWdCMXRJZnU3T1N4di9lbWwrOUViUk02V282VU9GRDJ1?=
 =?utf-8?B?VU9WSlZ2NnE5ZkpqTXp3VHZNcjBPUXVVVDg3LzN4MDhNMGRuN2Z4TTJLcEJt?=
 =?utf-8?B?RVVJV21VYnAySlpoZXJPZURUdEhNNUI4ZWFENGtVY1B6NklRZllLK3l3Uktj?=
 =?utf-8?B?SDlSdG0yS0F3UVQ1R3VhdFNScUZYb0pGSkpwY0ZJNWNDYzZxVVFjRHZQZXJW?=
 =?utf-8?B?ZFB3NmlhcWwzMHRLc0FKWm9UUWtpN1FPVldJMkp2c1RGZzl2VDJHQ3lkRVBm?=
 =?utf-8?B?N1ZPSi9yZCtvM1lidlZPcTAyWEJ6U3NZR0srMXhBWldXOWRaMWs2UDVVWTd5?=
 =?utf-8?B?K3NNaFBSUExHemk5MUk4aW5pRllmMGlVS1NlTHdDTEVlYzhNZDJPclpSV1JU?=
 =?utf-8?B?NVd6TGkwNkRjZ3NqWFc0VmxLdnRoRk1lN1NUbXA1LzFFK1NqZ1FKU3JKSzRU?=
 =?utf-8?B?blFidFd3RmJaS2c5TkJUN2xFRW9RZ25zU3JPRUhtVnlGTXRKR1FWS0N5dHNi?=
 =?utf-8?B?TGZSM1Ivek5rZzdGWG16Qk5SL1FEWVVVMkhobzV6WXZZNUJQczFnZklnVVg2?=
 =?utf-8?B?M3ROeElmbGJHNi91bGppZUZzOGk4cGFEWnRDdExsdk14c0E1WjQyYzZmbnFy?=
 =?utf-8?B?aEtKcHBrRG1xQWdwaG55U1EyTkZkekxHcUVueE1hemNydmZPZlhPRjNyQ0w0?=
 =?utf-8?B?RUpIcXFsalFza0F5YVd0dDQ3T1FyVUhVeXZRM0ZLMVFYWFoxdjR3ZmhkNjNa?=
 =?utf-8?B?b2lwcmlNN2w5YjBtOWo4RG9VRTlZNU01YkRWYVFPRkN3RzZvcU5XZGxzelZi?=
 =?utf-8?B?LzlYU0Ixdi9MOXJFK3NoSmJFWWZJNmliMjNsQ0QrRTdFZXN3TnQyOXpsNmFh?=
 =?utf-8?B?SG1CL3BuUUxjbENmbzY4Z1VmelBtY2hENTZzbGZ5bXdPVXhheEFxZFoyMEV2?=
 =?utf-8?Q?blVYiRpsqsW/X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9WbHRvNG1QejRjMXJjK3ZFbTFYRmVCaDJteGVyR2t0SGJQR1J0V1FCVkFz?=
 =?utf-8?B?MElndW9jbHloWnhMYktES1I2QjVNQ1NLbk9aWXZuZTlGbEh0cjJ6MmgwOEFh?=
 =?utf-8?B?TEdwOWI4dUdBMUpRV3E1dHNLUzNsVlRBZzlnU25oN3FvZDFhOFVUTUxnbEdV?=
 =?utf-8?B?d1JBVm84VG9ZblpMODBwRDFRL3JuTjZiY3JobUNIOFhZTkJ2Z1FNbW5SZjlJ?=
 =?utf-8?B?Rmp1MEVKVWtCblRDZ0JkUXhLYmdoa0ZnUnpYVExWK3lySzhLRkIyZGI1dFQ1?=
 =?utf-8?B?OUN2R1BxS09mcU1ObkRUT3huN0hCZzNyK0NWVjg1S2tHczJDc1Ribk9HaElZ?=
 =?utf-8?B?TER5cmF4Sm1oMk5ISmV6RkRwS0ZoUURweUdpZk1QdHBkdkM4VS9RZXNsazZX?=
 =?utf-8?B?N2hSaTdUUzhBUys1eWM1YVVDZWxkcWFOZlppREVBcUhsSUo4YUtTT3Rhc09E?=
 =?utf-8?B?Vmo4amV2Q3RJWFRRRXJHaTFMMmI2eGQxMFNBeEhkaGEzZEtRLyt1endnSWVG?=
 =?utf-8?B?d3NRSnhlZ1VCRnBoZ3ZBY25qODVTa0lSUGZDU2daRlBENzBHZ1M5MUVkQTcw?=
 =?utf-8?B?UWtRTjU2K2ZlUnJ6bTBIUFRsTHhYZ3c1MDFDVlNTVEtuVmV2YVozajMyMG5O?=
 =?utf-8?B?Wkk3a2Q0OUFpR3d2R0hJNnY2dTI2cTZkclRVZ2NKNFJST20wWTJGU2N1bU51?=
 =?utf-8?B?SVg2b014Y3V3S0RveUNCZ28wT2U3UVZzVFVPSDhOdDNoOG1ncXRaNUhtWHIr?=
 =?utf-8?B?eUVsTEZreStwa2FmbERETloyaHpmRmxPMzQwa1E0ZHhZay84MUF4bHU3TEJE?=
 =?utf-8?B?K2paSzJLdnJGQ3k0L2d3bUpOL3VoMWV0VUJPMDVORmN1S1Nac3lPc3FTOWJ2?=
 =?utf-8?B?WkplQkdYN0hEd0FzNVNGRGoyOHNIMExMTlRjQytvVEtwU0IwLzZFQkRjbDdI?=
 =?utf-8?B?RnI3OTdwb2FiUHhvdjZtbWZFckJQbUE3ZEtnWjVvdHdZZHUxbXFxM3V5YXFB?=
 =?utf-8?B?bHVnTXpJOTZUMmJPR293THlueXMveEE0aFFvQ3pxZVl5QXV5MjB0SEtrcWJk?=
 =?utf-8?B?Ky9rK1NHUENEdzFpazh2THcyZkxhN0paVVVObUZmYU9WUFFoa1VxTDc5RU9S?=
 =?utf-8?B?NUNxajlhbFhpck1aNFM5VFZ1ZVJWMHZNNlJMNHhERlJiSE9UeWVoQjR5Zjdt?=
 =?utf-8?B?YVUrbFdOUXp1Y0JwSkxUK00zN0ZJaGNFVld2OWd0V3JoMEhxS08vZEoyUWpk?=
 =?utf-8?B?dEV5R3lKcXVyeGEvUzFCOEpVTmhCUnpjM1Z6RmJMb0U1Q0VCNUFtdVhrOHpB?=
 =?utf-8?B?M0cvTkdZd2RrMkhUZVNxVUJZdXJsaFJGMzRSQ3dlMEFHSlFtVWNaSm1hbS9z?=
 =?utf-8?B?SS9JNEExZmh1VEtXU0tYU0M5eDRMaS8wMXZnRFdsY1ZlektYbnZXdGE2VnpP?=
 =?utf-8?B?MFo3aUFGLzM5WUNWTzRRMFl3bFVXanlnNENPNGE3K1dTclBTRWdJcURsamVD?=
 =?utf-8?B?RlRBcEs5RDdYcVpFQWJvWE1XVW96bkNPOGFvc2NXNjloMVpkVWhoNVlDQndG?=
 =?utf-8?B?cW9sR1RHaWVNelFQMG0wODBWV2hyWDI5YVJjUlBCZ1hmUi9IYmhrZGZBOXVJ?=
 =?utf-8?B?ZTRsaGtLcFc1dWZHZnJacTY5T2NhSloxdTdkcU4yNDZHVlg2ZkNSYUYreWtY?=
 =?utf-8?B?YXVLeUNsTjcvWWhxMWNXbzVDbm42VWdPcWhNYTljM0xOWmxtYlQwcWZ1TTVJ?=
 =?utf-8?B?NjlzR3JLdzdXS2xnaDBEOFlsdkJWckgvK29iODJGdUJ2Mi9POUgxL09XREdj?=
 =?utf-8?B?UjBMYWQ0OW9WV3pXK2tKQmNKRUt4UmUvcWZtd0ROS29zNlE5RGN6blNrTTlI?=
 =?utf-8?B?MnZwY1FDdU5FS1R4S2g2dHo2QTRDd01oa0FZWTRiczN5dEpvVk9QWFJCQnZW?=
 =?utf-8?B?UmZBdkdOeFJ0WFlVZ1VYeFV0bWVJN1RiKzBhcDFHR2hyRy9PWkRQRVV5L1hw?=
 =?utf-8?B?ZjBHbTQrRkk0a0xMS0hDaUs3NjlLYlptWHU0UkFyUHZaVkVldSs5alRYTnM3?=
 =?utf-8?B?SHFRaVJPcGtIeE9qWkZuZ0NmTlhoaFdPV2tMUW94L2NhMUJQa1hTOVpzSWd4?=
 =?utf-8?B?TWswSHZpRUJ0RXZKOFJLVHFVR3hlUG9MNjdCME1RaGNhQy9TdFBzbkpQV2JY?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c69377e7-b20a-4733-eaba-08dd5d784af7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:02:19.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBf1ge4OcEU4t/uObrcdQwU/wIBDGjREL82+nKp3GPwKEyVfsFAS5c+QzKjBZq1N4CdAtEjsDNTREqq8bDySZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

On 21/02/25 11:39, Oleksij Rempel wrote:
> Introduce `_mmc_handle_undervoltage()` to handle undervoltage events for
> MMC/eMMC devices. This function interrupts ongoing operations using High
> Priority Interrupt (HPI) and performs a controlled suspend. After
> completing the sequence, the card is marked as removed to prevent
> further interactions, ensuring that no further commands are issued after
> an emergency stop.

Please cc me also, and since Avri and Christian have reviewed earlier
versions, at least them too.

I'd suggest cc'ing others too because at the moment there doesn't
seem to be a lot of interest in this.

> 
> Implementation Details:
> 1. **Interrupt ongoing operations**:
>    - If the eMMC is executing a long-running operation (e.g., erase, trim,
>      or write),

Those cannot be happening if you have the host claimed.

>      attempt to stop it using HPI (`mmc_interrupt_hpi()`).
>    - If HPI fails, an error is logged, but the sequence continues.
> 
> 2. **Suspend the card in an emergency state**:
>    - Call `__mmc_suspend()` with `is_undervoltage = true`, which ensures:
>      - The power-off notification uses `EXT_CSD_POWER_OFF_SHORT`.
>      - Cache flushing is skipped to minimize time delays.
>      - If power-off notify is unsupported, alternative methods like sleep
>        or deselect are used to transition the card into a safe state.
> 
> 3. **Mark the card as removed**:
>    - This prevents further commands from being issued to the card after
>      undervoltage shutdown, avoiding potential corruption.
> 
> To support this, introduce `__mmc_suspend()` and `__mmc_resume()` as
> internal  helpers that omit `mmc_claim_host()/mmc_release_host()`,
> allowing them to be  called when the host is already claimed.
> 
> The caller of `_mmc_handle_undervoltage()` is responsible for invoking
> `mmc_claim_host()` before calling this function and `mmc_release_host()`
> afterward to ensure exclusive access to the host during the emergency
> shutdown process.
> 
> Device Handling Considerations:
> - **For eMMC storage**: The new undervoltage handler applies the correct
>   power-down sequence using power-off notify or alternative methods.
> - **For SD cards**: The current implementation does not handle undervoltage
>   events for SD cards. Future extensions may be needed to implement proper
>   handling.
> 
> Testing:
> This implementation was tested on an iMX8MP-based system, verifying that
> the  undervoltage sequence correctly stops ongoing operations and
> prevents further  MMC transactions after the event. The board had
> approximately 100ms of available  power hold-up time. The Power Off
> Notification was sent ~4ms after the board  was detached from the power
> supply, allowing sufficient time for the eMMC to  handle the event
> properly.
> 
> The testing was performed using a logic analyzer to monitor command
> sequences and timing. While this method confirms that the expected
> sequence was executed, it does not provide insights into the actual
> internal behavior of the eMMC storage.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - reword commit message.
> - add comments in the code
> - do not try to resume sleeping device
> ---
>  drivers/mmc/core/mmc.c | 115 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9270bde445ad..a50cdd550a22 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  	return err;
>  }
>  
> -static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> -			bool is_undervoltage)
> +static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
> +			 bool is_undervoltage)
>  {
>  	unsigned int notify_type;
>  	int err = 0;
> @@ -2116,8 +2116,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>  	else
>  		notify_type = EXT_CSD_POWER_OFF_LONG;
>  
> -	mmc_claim_host(host);
> -
>  	if (mmc_card_suspended(host->card))
>  		goto out;
>  
> @@ -2145,7 +2143,18 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
>  		mmc_card_set_suspended(host->card);
>  	}
>  out:
> +	return err;
> +}
> +
> +static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
> +			bool is_undervoltage)
> +{
> +	int err;
> +
> +	mmc_claim_host(host);
> +	err = __mmc_suspend(host, is_suspend, is_undervoltage);
>  	mmc_release_host(host);
> +
>  	return err;
>  }
>  
> @@ -2165,6 +2174,20 @@ static int mmc_suspend(struct mmc_host *host)
>  	return err;
>  }
>  
> +static int __mmc_resume(struct mmc_host *host)
> +{
> +	int err;
> +
> +	if (!mmc_card_suspended(host->card))
> +		return 0;
> +
> +	mmc_power_up(host, host->card->ocr);
> +	err = mmc_init_card(host, host->card->ocr, host->card);
> +	mmc_card_clr_suspended(host->card);
> +
> +	return err;
> +}
> +
>  /*
>   * This function tries to determine if the same card is still present
>   * and, if so, restore all state to it.
> @@ -2174,16 +2197,9 @@ static int _mmc_resume(struct mmc_host *host)
>  	int err = 0;
>  
>  	mmc_claim_host(host);
> -
> -	if (!mmc_card_suspended(host->card))
> -		goto out;
> -
> -	mmc_power_up(host, host->card->ocr);
> -	err = mmc_init_card(host, host->card->ocr, host->card);
> -	mmc_card_clr_suspended(host->card);
> -
> -out:
> +	err = __mmc_resume(host);
>  	mmc_release_host(host);
> +
>  	return err;
>  }
>  
> @@ -2194,6 +2210,13 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>  	int err = 0;
>  
> +	/*
> +	 * In case of undervoltage, the card will be powered off by
> +	 * _mmc_handle_undervoltage()
> +	 */
> +	if (host->undervoltage)
> +		return 0;
> +
>  	/*
>  	 * In a specific case for poweroff notify, we need to resume the card
>  	 * before we can shutdown it properly.
> @@ -2285,6 +2308,71 @@ static int _mmc_hw_reset(struct mmc_host *host)
>  	return mmc_init_card(host, card->ocr, card);
>  }
>  
> +/**
> + * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
> + * @host: MMC host structure
> + *
> + * This function is triggered when an undervoltage condition is detected.
> + * It attempts to safely stop ongoing operations and transition the device
> + * into a low-power or safe state to prevent data corruption.
> + *
> + * Steps performed:
> + * 1. If no card is present, return immediately.
> + * 2. Attempt to interrupt any ongoing operations using High Priority Interrupt
> + *    (HPI).
> + * 3. Perform an emergency suspend using EXT_CSD_POWER_OFF_SHORT if possible.
> + *    - If power-off notify is not supported, fallback mechanisms like sleep or
> + *      deselecting the card are attempted.
> + *    - Cache flushing is skipped to reduce execution time.
> + * 4. Mark the card as removed to prevent further interactions after
> + *    undervoltage.
> + *
> + * Note: This function does not handle host claiming or releasing. The caller
> + *	 must ensure that the host is properly claimed before calling this
> + *	 function and released afterward.
> + *
> + * Returns: 0 on success, or a negative error code if any step fails.
> + */
> +static int _mmc_handle_undervoltage(struct mmc_host *host)
> +{
> +	struct mmc_card *card = host->card;
> +	int err = 0;
> +
> +	/* If there is no card attached, nothing to do */
> +	if (!card)
> +		return 0;
> +
> +	/*
> +	 * Try to interrupt a long-running operation (such as an erase, trim,
> +	 * or write) using High Priority Interrupt (HPI). This helps ensure
> +	 * the card is in a safe state before power loss.
> +	 */
> +	err = mmc_interrupt_hpi(card);
> +	if (err)
> +		pr_err("%s: Interrupt HPI failed, error %d\n",
> +			mmc_hostname(host), err);
> +
> +	/*
> +	 * Perform an emergency suspend to power off the eMMC quickly.
> +	 * This ensures the device enters a safe state before power is lost.
> +	 * We first attempt EXT_CSD_POWER_OFF_SHORT, but if power-off notify
> +	 * is not supported, we fall back to sleep mode or deselecting the card.
> +	 * Cache flushing is skipped to minimize delay.
> +	 */
> +	err = __mmc_suspend(host, false, true);
> +	if (err)
> +		pr_err("%s: error %d doing suspend\n", mmc_hostname(host), err);
> +
> +	/*
> +	 * Mark the card as removed to prevent further operations.
> +	 * This ensures the system does not attempt to access the device
> +	 * after an undervoltage event, avoiding potential corruption.
> +	 */
> +	mmc_card_set_removed(card);
> +
> +	return err;
> +}
> +
>  static const struct mmc_bus_ops mmc_ops = {
>  	.remove = mmc_remove,
>  	.detect = mmc_detect,
> @@ -2297,6 +2385,7 @@ static const struct mmc_bus_ops mmc_ops = {
>  	.hw_reset = _mmc_hw_reset,
>  	.cache_enabled = _mmc_cache_enabled,
>  	.flush_cache = _mmc_flush_cache,
> +	.handle_undervoltage = _mmc_handle_undervoltage,
>  };
>  
>  /*

