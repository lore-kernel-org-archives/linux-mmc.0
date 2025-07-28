Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A965221F02;
	Mon, 28 Jul 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690650; cv=fail; b=jw6nER5l3xTuOv04hQ5/k6hcrqHOIBhc80Wjfevtqncj72F3c6IbiPBJMEa8Y0ToL9Va202ffs4y9temTWWjOn9wR6VyfCfbBUZy+fy8LSla5V0t156gKtR1R9YVh2aef5AHc32Z95fbhlodd7bjiqFZoZWluL9MWeknQQomsJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690650; c=relaxed/simple;
	bh=DAd92S48v4pSwQUhuH+7xWwy1HzX3zPqjjWx5KRdNkI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cM2rM4JgEvkKwOfPcOaRmA4+bJHNZjHS7UIbs1TaFYzKJXS99bg8pS0aWQx+CrNR8ub42uX1Qypc+J8cZmWgSeZWWVy4u0cfLX6EbvK7CMKpD1GLqMAqkkmS4rNSZNeW+LCuLCNp7OwMQoFR1Z7izOykXHZpgzq4lFHAcYcI0dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY4Z6I5H; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY4Z6I5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753690648; x=1785226648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DAd92S48v4pSwQUhuH+7xWwy1HzX3zPqjjWx5KRdNkI=;
  b=IY4Z6I5H9gSccHvOVKttdh5Uhat+7URg2WQs64lnqHkBdYVyCwc43P3g
   qb64dwP8Y7aoMCFt3q9Ri6Z+iiJpdNIOPy4x5giee/TeVNagSmaTMoP3s
   7kTVGTIbdymnaPEyfLvuREddP4AYQuGong/Ab/wW4ANUukgYI1yNDlrZ5
   2877wHdWCB9JqVEgJLTYxJGWfo+PHAFAvnAElJH1gfJ+laCKT6dr0Eilw
   8+sfItzqiY4P5sk/r6zUqEG895sAKl/uUvQw8pIBNsNQoqhu/KyapJziN
   lBzs4W7dV4XsaGHScjUoyQWRCxWN96MVQ4ZXDUY4PVb8nlWOGvURSkjv5
   w==;
X-CSE-ConnectionGUID: KL9kjBLBSj6HlbU8g3CjlQ==
X-CSE-MsgGUID: rqA0/3+RT2ST4yWaQKdVHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55788806"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55788806"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:17:27 -0700
X-CSE-ConnectionGUID: vS95ei+xR9ebYI42igHORg==
X-CSE-MsgGUID: Z47DtCcSR2aqHe2eYN2vqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193219700"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:17:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:17:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 01:17:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D02bE5zu/mbMlB5cpVZ8P5NaOIFC21G9jBcwmeOQ+7h7yCDgfRN7/sYkFHwQQfGxAD8/GZktv7egV2V+gpek8vF+QfjrNUrq9hjdNgn36rJCwYVpXjrF306a84bJe2CdvuQKaXm23GDEmQ1SHQzx5IklvF46HxHPZ+vPyF6B+teVC4p1kIosXMimVkXzwjpxgxyLf53QvxlzOSmhLyfD99qKgCeUANvjqhpbbObrIoeSue8F8kIntK+gTfTzW9GjdTQ83Q6EmTPABv0/aDrAMVNZSJaNNkJJIbKABtyyOvVuP9711FG64sIA4z7CRvR9/fsL0X0P+DFFhIgYvbFe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRRzhV9nxudj/rOPStN3YuzDkGkXPcMXzjsgSu4uBCM=;
 b=qMn+qFig2nmMXVo2BtKznAr/1rxm0gskZIQu6TjvWGvBOPTzxqrXpgulZ7GjI0i+mhEEoaF53V2LKrtrkgKPG81Ej+FPxJ17JRfWFqLWpSlpruBNyJ1NjCEjx8NX0YQSBKqsBJJyrYjaeJnqOZz965ROUp6VIDM6Ke4tSwgoEcICh2mHI2R12Wsq7P76PajLKf4ddXLm9taqE9v2ozyi6qk8Bht1YmorQTGMCGNda7R3u5lP/0dts688gmuc+lpvz2m4RZZp75++aRipusUsUWoo88p820GewMcVge2gicibMfu0mzUPFQN7JG86HpEdEfeRzs1h8+2D8BKC36o7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 08:17:18 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:17:18 +0000
Message-ID: <0ad9b5ac-3fd7-4cf0-befa-2c58589153e6@intel.com>
Date: Mon, 28 Jul 2025 11:17:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mmc: sdhci-cadence: implement multi-block read gap
 tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
	<tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <20250716-mobileye-emmc-for-upstream-4-v3-6-dc979d8edef0@bootlin.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-6-dc979d8edef0@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:36::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 614d1936-d722-40f6-dca1-08ddcdaf2b00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGNMZ2lpVnhBdWZHTE5PR0ZoMmhHWUpsQ213T005TFV5dDlYdzQ1YnBQdlF4?=
 =?utf-8?B?L01YYS9Yb29ITzl4dE5sQWcydmVaN3pNdW1TdWFXdSt3YkI1VkJSNzB6YkNO?=
 =?utf-8?B?eDRoYUUyTllBbVV5d1diMXFHK3VwUHVGbGNkbytsVXBrNHJEMGl5cUcwQWpC?=
 =?utf-8?B?ankzbkgrbWliZnF0V1BLMkJnSWFjdlFWUE0zNlZYZW4rZGhwcGY4bHQ0Mit2?=
 =?utf-8?B?SVFvOHNYUzNyVWZQMGdBNlhoNjJEOWtGR0ZEVHBmeStsN3JLUU55QldyUHMy?=
 =?utf-8?B?T3EzYms3Z29xZVplWjZyc0JZcUpaRFlQa2x2Wk96Q3ZVN1dvUXQrZ1p0NDlE?=
 =?utf-8?B?NGhXcUM5NjdBbmVTcTFWQ24xMGZvdEs3ZlR2VjlaZGZ1UmhBUTNXWHFZM2ZR?=
 =?utf-8?B?RGpZYWV2cnkrRmdaT2V1ckYzRDNvMEZLemcyRU1XMUZJZW1MbmJKNUxtZ29y?=
 =?utf-8?B?NUI2d3VZangyY01kcEJKeDJKS283UVU0VTRSaTNxczNaRzN0bGVvVmZzalNt?=
 =?utf-8?B?THU3Ymw5b1dScE0ydDN3aG9mNXNzRzRmbTVIWGl4QXhRdFZQc2s5Vkxkb29p?=
 =?utf-8?B?TDk2TjBQdUFVaWExQndnLzhFd0svNzVvQUdxUzdmbUJKU2JCamErbmM4eUxG?=
 =?utf-8?B?YXpsUm51OWd5WG13SVpadjdCbTNKdGFpdDdSYnc2bzFyUEFhaHZYUWZnd1Ez?=
 =?utf-8?B?aTROZXVTNFF4ZlpwNUpOU2tuZk9lSWdJRXg4M3VWditlM1ZnZjh1dDVlb2JN?=
 =?utf-8?B?WXJKVkdhUTZNbWdXVElBdUM3YjNzUGVvek9NUW42dTkxcHVRd1FGbjZUclpz?=
 =?utf-8?B?SmZ6RldUKzNvV210eXNES05nejZuWkRVN3lBS1NLMnUyb09XWFdtMFlGYWxJ?=
 =?utf-8?B?aUkvQjZ6VmtuWjFWWWM0QlR2ZkpRb3V6N1FzTDQyQUd5WXJtd1ZrcUZKTFEy?=
 =?utf-8?B?a3dpZTBNLzRWNmhzYTljeGhzOHRXdjRvNkdpMVZ6alJHS1lxS0s1OSs5MlZG?=
 =?utf-8?B?UnZRMC9Db2FWZnhWc1FQRFNMeFFmRlFVeHlOMjlSb2FyenlGTWJ2QTJRNkg2?=
 =?utf-8?B?NFZBaEFVNGp2NmxyL2pUcHF2ZVNpajBhekN3WjNoWG9iUzZRQWFETWo2V2pL?=
 =?utf-8?B?aEIvUkRnYUtpV1VHMHFoTGtZNjBleHpTdTVTYW9wc0p5S2VDQVVobkNZd3B3?=
 =?utf-8?B?TzJHZlZOMS9CK1hWRVNaT2w5TnpMY2c4SCtwZzhnREtGUFpoSXF1M3F0QnBC?=
 =?utf-8?B?WlAyY0FQOER1bTNORngybVJrTzlaeUo1RDBCMzNFc2VzYUFhQ1R5TXo2Rjd0?=
 =?utf-8?B?V2JJamZQNWlmVlJMalR1QzFtY1ArelNJeW1RWlpWL3hCZTJuRkNFY3VtZ3gv?=
 =?utf-8?B?aHQ0ZmFwTXp1UlRENzBoMXlHL3NuYTRBR3NVbXVneG42Ui90QjF3UkwrWEY0?=
 =?utf-8?B?OHZCWjdVSDJmdlR0MFBzaHdGTGh6TTdyK0piS0RUWXQyY1JrZ0liSkFiV1VC?=
 =?utf-8?B?SC92eGdDcTVINEUxUFk4QWRsZkZKeDhxYzNaeU5yZEE0ckdDOHJpKzhYcmVJ?=
 =?utf-8?B?cHBwcU5NOXJrdG9mY0x1UHBiNW96YWY5VFY0V0Z3Q0E0UWNXMFRYS0VER1FM?=
 =?utf-8?B?Z0s1TGFWZ1oyOW45U3hMNVZNSWp3N2hraVphTlFRNC9xQk90bmlXMVlOSWxp?=
 =?utf-8?B?Tkt6VGkxeStUa3BKRzFDL2xsWU1EU00wc3dXS1VQajBTMkp1L1VGRURieFFS?=
 =?utf-8?B?MVZWUUtWd25DT24rdUJZd0ZaYTYwV2lMdkh1d20rdHFpM2NIK1FFWnUyNEoz?=
 =?utf-8?B?SHhEbExxUlZ3enlBb0phQjlxZmlMMnhkNkpEeG9YZmQyS2dpSFlWdG95WFZ1?=
 =?utf-8?B?ZjFoUmVWVlN0c2hxQTRyaTd2UGdvMFdYbnVYZTA2QzRFMG1RWkpzNjR3a244?=
 =?utf-8?Q?nxZ99UR9kcM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZ1V2hNYlZEVWp3bi9pKzNlK1p5d2d5dExQc0wyYXpBcnhZNXR5eXBPZHZK?=
 =?utf-8?B?dm0rWE43NkM0aERKK2dUT09ET2s0ekZncGgyK0RFMkxxUnhINEU0UWROY1Bt?=
 =?utf-8?B?ZnVha1lFVDZkcFVYdFpFYVI1UXpKaVo1N3k1bmxLdkJVUVpwOGNNVFF0SUNO?=
 =?utf-8?B?SmxkNnFzeUpFckNOZ1h0bldpeHNDYStCb1liRG9jUkxLR2NCbG16aWlCWFgv?=
 =?utf-8?B?SVhXeHdydjBGOUJtMFZPRW9ncFMxT3dJNnlrMXdzNWswWDRzbjNLMUk2ZmQ3?=
 =?utf-8?B?Tmdyb0RTUHE0cUdPMFF0OFY5SURxd3poU3Z1V3pnMUhjWmthbnVrYmh0SE5L?=
 =?utf-8?B?b1RNY3BxTzRoOW4wdDd3cjcyc3lHUS9qYUE3ZXFBaG9UTTR2cEM2dHRXT3BV?=
 =?utf-8?B?QnNnRXgydi9RVmdCT2RiR2g5UXVVWVRoYVhUbWJPKzFLR2tQRlFrcHJCNVVO?=
 =?utf-8?B?Z05TZmhDVysvbmZHQWJqMjl5VU9vd3Y0L01nMGdqRGFCU2lFY3ZoRHZXSTNC?=
 =?utf-8?B?MDNDU084WkJ3OThWM3JDTUtXV1dSeXE4cGlqN3pHb1M0aDRrVDVMNE9pNnpP?=
 =?utf-8?B?Wmt5ZHh0aHdUWkpuMHI3VDJGSDExVjFCZE1kZnhYR0Zoc04rSnN1L0xoRW1y?=
 =?utf-8?B?RlBIeUpkOTVUUGlJam9SOE9jdmVOZXY4TXowOUcvN0lMRlVYNHArd3RQbi9V?=
 =?utf-8?B?My9wU2xJUlFhaWRUWENJRm8rWmM4TXhmOTJqTk1TajhKb0VNbTkyTm1RNkEw?=
 =?utf-8?B?cUZOa3J4c0pqN000YjIyVzZxK1g0Y1JpekVzN29PQlcyYmxrcjNZSDZKcFBO?=
 =?utf-8?B?T21CMlFYOUhwTW5TNjdGcUdnTEkwdWpTZjhYZDl4M1JYSkpOMnBoVzhvMVV0?=
 =?utf-8?B?d3FUdHlIaTJBUTNmUmhaK3dQNGp4N05zVzhCemNPbEpjMlJ1dllQbUpVdWNJ?=
 =?utf-8?B?allhb0pheU0wQVA3S3dqdHl5T3BFNjZLUnpQbWdKYmt0VTRacTl4QzZNSWZq?=
 =?utf-8?B?ZmMvZXpDUnUyUjlTck8rTXhJYkc1VEJtd09WUFY1OVdBS2NVcGxKMzNsQnB6?=
 =?utf-8?B?aEROUkR3bUNPbDBzcVhtMFl2L0NvQ0d6YU1Db2RDejhDMTZHMzFvSG03MFF4?=
 =?utf-8?B?ZjJraUhQbEdvV1VsNnpqeXQxNzhOSWN2QkxWMm1ybGVGWElKcm9ONFU0QVFz?=
 =?utf-8?B?WkdYK1duSEJnbURpdEdwSHRpQktsRGd5US9TNDNvV25tYUhEb09QWnRxRE5w?=
 =?utf-8?B?V05IR2dibXNVQUJwQnROdU5oNUpRNG91UzFqMWVEeWF3NndDUk14Vm5Db01H?=
 =?utf-8?B?eXRQZkdZWHY1Y2g5WlNFV2xxR0Y4dElCaGhSR1JUZEx3M3hRR0R0QncrbHZO?=
 =?utf-8?B?bGRzd2pLK0pybHBkV2lVY0xGQ2dNc1RlMExIZXFNbHowdnRhOTVYay9POVhO?=
 =?utf-8?B?RGpVNDQzNVVzay9Kb2E5RWxldzR2RFN6WW91TEF6bmZ2KzBUa204aFBZVHRN?=
 =?utf-8?B?WVFiU3B0d3BpTUx4WXFPUzM3WW13V0hjVW1Jc3VlMUZCM3MzdWdLUXQxQlRZ?=
 =?utf-8?B?NTRWWkRLUnVKbEtQQXhVcDR4a3B0WnZmZmFESU9DNCtaQ1QwNTJZN3dpMEcw?=
 =?utf-8?B?bnMySms2Qk01MUJ0SWxPcm9CWkxVRThlck05Mk1DY3dXMDdwWFJuR1Z3ZkRH?=
 =?utf-8?B?YkJMM3VPalZnMVRpZGwxUmpJWHZrZU9zM1E0bXRQRGVsQVFTeW9PVXBqTm93?=
 =?utf-8?B?dFlSN2lFTEIzRUw3OE9HTnN5L2pURkFQcVhJMVJicTdrV0hDMDU3Ty9nVGF1?=
 =?utf-8?B?UWxBQlBVOHJzYWlLMUY2eFVMM2Y0bnJMYks5LzU4ZmtkeTZIWFRyKzcxbHhF?=
 =?utf-8?B?S2lienZIQ0ZPQ1Y3V3MvbmRLN2FyQTNzWWVQNm1YNS9XNjZQc09jUEpKK0Iv?=
 =?utf-8?B?Z3FPRVdrOUNoQ1JQZ2RMeVZhMCtJakxUYnF2aFpXY1BscGYwakRDbmxNMHdn?=
 =?utf-8?B?eTRUa3Y4WVpXaUhlc015azR4QTVyQWFNM29lN2txM1A2RGJBRWFvNldhSzBN?=
 =?utf-8?B?RGhBb0NUZlpQc0VrNWxPa3oyUmFqWDVRSXc0Z0xkS2hGS3FFRDdKZHp4ZjF6?=
 =?utf-8?B?Q2NBcjl4bEM1R3Zkc2laUjZyNTRoaWdzUUYrK25uWFZRUTVuOC9ZQkU1Tmdq?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 614d1936-d722-40f6-dca1-08ddcdaf2b00
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:17:18.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ3OX4js0nyfOp5X5Z6k8tCTihbbjlPDHqliC+CQLeVb2rY6hpXDIgxl/UHi2vOPNrimuuYZaMbM8HUmnvhaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com

On 16/07/2025 18:47, Benoît Monin wrote:
> The controller suspends the clock between blocks when reading from the
> MMC as part of its flow-control, called read block gap. At higher clock
> speed and with IO delay between the controller and the MMC, this clock
> pause can happen too late, during the read of the next block and
> trigger a read error.
> 
> To prevent this, the delay can be programmed for each mode via the pair
> of registers HRS37/38. This delay is obtained during tuning, by trying
> a multi-block read and increasing the delay until the read succeeds.
> 
> For now, the tuning is only done in HS200, as the read error has only
> been observed at that speed.
> 
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>

Some minor cosmetic comments below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 69 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 2d823e158c59844dc7916db6a1d6e3d8b02ea5a0..0a9a90f9791d343b5d64ed602066f6291efa75b5 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -36,6 +36,24 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* Read block gap */
> +#define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
> +#define   SDHCI_CDNS_HRS37_MODE_DS		0x0
> +#define   SDHCI_CDNS_HRS37_MODE_HS		0x1
> +#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR12	0x8
> +#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR25	0x9
> +#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR50	0xa
> +#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR104	0xb
> +#define   SDHCI_CDNS_HRS37_MODE_UDS_DDR50	0xc
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_LEGACY	0x20
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_SDR		0x21
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_DDR		0x22
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_HS200	0x23
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400	0x24
> +#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400ES	0x25
> +#define SDHCI_CDNS_HRS38		0x98	/* Read block gap coefficient */
> +#define   SDHCI_CDNS_HRS38_BLKGAP_MAX		0xf
> +
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE		0x200
>  
> @@ -251,6 +269,49 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  	return 0;
>  }
>  
> +/**
> + * sdhci_cdns_tune_blkgap() - tune multi-block read gap
> + * @mmc: MMC host
> + *
> + * Tune delay used in multi block read. To do so,
> + * try sending multi-block read command with incremented gap, unless
> + * it succeeds.
> + *
> + * Return: error code
> + */
> +static int sdhci_cdns_tune_blkgap(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	void __iomem *hrs37_reg = priv->hrs_addr + SDHCI_CDNS_HRS37;
> +	void __iomem *hrs38_reg = priv->hrs_addr + SDHCI_CDNS_HRS38;
> +	int ret;
> +	u32 gap;
> +	u32 hrs37_mode;
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS200:
> +		hrs37_mode = SDHCI_CDNS_HRS37_MODE_MMC_HS200;
> +		break;
> +	default:
> +		return 0; /* no tuning in this mode */
> +	}

Could refrain from the switch statement until it is needed.
So for now, just:

	/* Currently only needed in HS200 mode */
	if (host->timing != MMC_TIMING_MMC_HS200)
		return 0;

	writel(SDHCI_CDNS_HRS37_MODE_MMC_HS200, hrs37_reg);

> +
> +	writel(hrs37_mode, hrs37_reg);
> +
> +	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
> +		writel(gap, hrs38_reg);
> +		ret = mmc_read_tuning(NULL, mmc, 512, 32);
> +		if (ret == 0)

Kernel style is:

		if (!ret)

> +			break;
> +	}
> +
> +	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n",
> +		ret == 0 ? "OK" : "failed", gap);

Kernel style is:

		ret ? "failed" : "OK"

Also up to 100 columns is ok, so could be all one line if you like.

> +	return ret;
> +}
> +
>  /*
>   * In SD mode, software must not use the hardware tuning and instead perform
>   * an almost identical procedure to eMMC.
> @@ -261,6 +322,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	int max_streak = 0;
>  	int end_of_streak = 0;
>  	int i;
> +	int ret;
>  
>  	/*
>  	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
> @@ -288,7 +350,12 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		return -EIO;
>  	}
>  
> -	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> +	ret = sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> +
> +	if (!ret)
> +		ret = sdhci_cdns_tune_blkgap(host->mmc);
> +
> +	return ret;

Or tidier:

	ret = sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
	if (ret)
		return ret;

	return sdhci_cdns_tune_blkgap(host->mmc);

>  }
>  
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> 

