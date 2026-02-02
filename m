Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5E2F6582
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2026 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014378; cv=fail; b=LQWFY2bUcxJAc3xn0NsN5NL9G1lfd1P3DMhkcBxbQlH8iQKe2jknkyvam//ckpbp35Px/fZ5AreVTnHHXi2XTYnZff/Qc7E4RcwN78Al2jJZDYGffpSiZXjxTSEdjRZaxzVt6wdfdDI9Mds5rsDAIyEqNbY5/2zY5WWwIUCHpWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014378; c=relaxed/simple;
	bh=0mdUlg1H6XuyZyEgnfpykVHgsX15+8dSp9CoQ4EWhRo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWmj/a+DNMSlctkUoJTCXddGsse64YAHgkNLlfU7RXFgFfNQ7OVTcgGJbFFWrTcnRdnyKS6CNlvBImbQiNBa72gTqKMeDoK7f0BK0QVSnylTMSwKhBHKi7MDoytzZrPbUp+sgiFz9Z2HLCiAGDYhokqjaLZjh5987c6oc8bHwik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9x32YYY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9x32YYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770014376; x=1801550376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0mdUlg1H6XuyZyEgnfpykVHgsX15+8dSp9CoQ4EWhRo=;
  b=L9x32YYY61qG4xFfseBUBRL4y/UQ09sltdwEG8W2RFx85OKgwEgWM4kM
   k1XOp8n/azvs8F8UY5/DRYpem9oj074xUvL/w4x+LL8q7x001FjA6i4dZ
   cCWNumhLFaQgWbJkCCjBQ6YcY62n+Pt15yWmvI+o3P6o3o4IkijHtqD9U
   564i0b7rw6Dmv8x57c/ODA+yFkGiFZps/1GLpw5ail7XttbyMYKXeF2xg
   oVrVoGjcD2Nu29YS+NC49vYeaKlRAMeZBCXKZFfQUeI7l0AMwQYYcsOC4
   gJosEYLUEUzrMEgyFMrPqh5fp22NKrDxy0Mimpj+erHbc87vfMaRl3A3p
   w==;
X-CSE-ConnectionGUID: wypGxNPkT26I/9xcdTWHRQ==
X-CSE-MsgGUID: KMDrlg+LR/mEj6Ymr6hiHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82277479"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="82277479"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 22:39:36 -0800
X-CSE-ConnectionGUID: /xZl2CJUQtasbhZS85kgdQ==
X-CSE-MsgGUID: PQOJ4g4oRl6TlV1pS/OYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="213969124"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 22:39:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 1 Feb 2026 22:39:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 1 Feb 2026 22:39:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 1 Feb 2026 22:39:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBUxZMaQqd5BEGHN/lE+nmskw+T4yTma0TyDsDF3g/DlgRKU6b9HaCdDq6XSLouO5UAaCMiwSa7TsZt0HkPAZNRQ9Cn3uiCqxDVlhQV0kwKH9k0L2kCpkOPZ3EqVdm0ELv45JQXkHcQHhlhsYLF24DXVukopG+/BbM+n8o108iPQnBuHqJ06ZiomZsE+4xt5zMfR+qTGrdYwIHUEo2xoPn9AbMKbK8N09SL1dl3s1lNXDquaf7fg+BnoUQ4JM2d2m0Yjh44JejDBB7qMMn9y+wbCUyPsiat7Ugn4BipJz5H+rxaFH7u1OHEbJAplDSXqU3IkBpmIZFrOiL29atIXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5JnbYppuy2DnEKcx0z3wHCsW6lqRvHnLJZVUEkZ+Vg=;
 b=aULKVbhcnvswCadDArR4KEiFRA6Chy2P3ny0h8h2S745owGOwQ8c9hfAt1dj/WB34GTT1oWePKsM7SgTf+cqeCXI7Kjc+L0A9+gOwx4FuWMrFygF+8Jx7o7+DOLhRS5Rmnmhyy8E5pAhjR2r5bPRkVDbImbYe2bM6aRCz8DHUzA2m5QbcT7j0QFenuApsviiL1EVInfSZZ4KjU8iK0EhBphK/XgcfWufjaquGXyqmfVl4LwzSRFJ1vPxELtlV/4fcsVTCnYc9Hwh00mA6zUY4FWWqqKlOpdNegzN/SB2H6Z1XlbvndHxjk8/UGsq1l1sQl0qfgOkUw10ORx9G+wXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6834.namprd11.prod.outlook.com (2603:10b6:510:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:39:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:39:30 +0000
Message-ID: <e4b5d1ba-014f-4464-b25a-658f540fea81@intel.com>
Date: Mon, 2 Feb 2026 08:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, <linux-mmc@vger.kernel.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260131020039.45966-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 926a088d-7945-470e-7a38-08de6225d147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clhMMGhwdmMxZXhHZmZVZkJiNzdKeitpbk8rWk1jTTgxbmZsb0o4QnRFLzF5?=
 =?utf-8?B?cy9WdkxNRThFdTM5Q0ZUZmRWTm5tMnNoTzU5aDBEMEIwVWljdDBYNDB2Zzgw?=
 =?utf-8?B?eUV2dUh2bVViRXJOT3ZHZy8zMXBrayswR2dQcWVMVXBBdFg4WVRzWSt4ZkZl?=
 =?utf-8?B?K1RxT1JGOS9EWTV2Nk9reWdVQUdxNkRFRzVlU2JHU3RMbWU3TE9HL25qa1Rt?=
 =?utf-8?B?K2dYQXNHdXRabzhPRTJLczNJTWo5eVY0ZzVBaE1GWUFZT1RCRlJwbWpPemVT?=
 =?utf-8?B?N2RpOW1QeHVJdHM1M1RCaURUdmpibGNzMjlWMFZ5M2QzZXhSWms5VVY1K05R?=
 =?utf-8?B?NXVpMUZoL1VadkJBV0YvckFHRG9qUzdIdGJwVWxUUXJZOXhjZ1hZUVpERFdQ?=
 =?utf-8?B?ZnNEaDYxVWkvL2tONUVsQ09sSVMzVWhmRVpUQklDZDB3R1FuRGhJcUMvQVEr?=
 =?utf-8?B?ZjF6a3ErMThmQk5tR0N2K25WZEJEZnZic0N6djlYOXI1VjdFeVM0NlBPWEk4?=
 =?utf-8?B?c0lzYmNWRytpMjMxazhEbzVhWDNrdHNyVUpJSmR5dUxZVmoyeXZmNzBRSDJ6?=
 =?utf-8?B?QkEvTVF1b0g1SWcvTXBOQkZvNG5qU2tmQXJrK01POGhoemFEVUpCRTlFQXFR?=
 =?utf-8?B?ZEV6ZUc3ME5lNVNTV21ob3dldFJRdTFsdXV0MzMrdStzNUhOWE1NTEl2em8r?=
 =?utf-8?B?RWtNcHRLeHN6UEtoeEFUcnRneExSZ1d4YTdCcjRBY29QUjBNdkVwaW81ZkJ2?=
 =?utf-8?B?bHZvVXJkcFhFZXZ6blRMd3BwazJMcGhpbmI0TEkyVGttT050YWdmbjAzS0h5?=
 =?utf-8?B?VCtrLy95dzFTSkllTW8vWDFmbUppNFhBd1ladXloTjBMam5Uc0REem9PenRu?=
 =?utf-8?B?dUFSZHVHa0VPdUhVRGdFdFNFbkk4NytSekhpZUdZd1JIaVpyWnhpcWNXOTc1?=
 =?utf-8?B?NnN0QmxBT0xyUjExVHBqUmh2NzlzL1NHV0FvaC9ZUEFBYzkvUGxxRjBNZnZR?=
 =?utf-8?B?YWErVlR6NjN2WTMwSURSd2gra016aCt0eFgzRzMvMllmZTV1ZkVhbm0zWDU1?=
 =?utf-8?B?Z0NHZ1ErN3g1eisyelFjdFM0RzAvYW5MWFRSSFd5d0k5SmJadSt1TWpDRmdp?=
 =?utf-8?B?RGIxcnhZNXZpK0gvSmFkeHRiZW81SHJtamJaMENGSlRwWmRhVDIwSitRbnIx?=
 =?utf-8?B?eWZoTHA2VzlNVnlqaSsxcjlPQUdNTkx6NUVkWXhPWS90SWhsN1ZUOEdUT096?=
 =?utf-8?B?NldSTi8xR3lseldHL3hEZFN2Skh6NFlqQjlENGx6MGI3UGY1YXluZTMrUU13?=
 =?utf-8?B?M1VmRU0vZDhOREI2U3EvbVpub3NzUGM0bXhML2wwNm56c1hzaHZwRS9BRWJo?=
 =?utf-8?B?ZXAxYUdKdERZZG0rK3hDVVNRQnFTaEtlVENUNUV6ZjBqZnRLeWhTTmJhb2Z0?=
 =?utf-8?B?a0NaWVd2aDlQMkJ0dlJna0VHc05xelZCV0YwM0drQWVEMDc2VDl1THh1RzhT?=
 =?utf-8?B?SFlJbUM3T1owQzBOZ3B0eUgwR2czOG05MjVON0dCTDJSQjM4dnFVOWt1WTM3?=
 =?utf-8?B?NGRyOXkzMUkrWHJZWG41M05Xd3JBUCtLTG1QdVFnanNETnRTL0N2cUIvV2FS?=
 =?utf-8?B?T0IrbXQ0K2s5T3ZnN1ZWUXcwVDNubEFSWnB4VUliRzNJcTZPREFpTDZ6MmZx?=
 =?utf-8?B?UzVzOHN2UFVJakhaQW1qcFJCZXgvR1hyaGRSdHR3bFNhbFRBQld3TlJIaXlu?=
 =?utf-8?B?cENIa1V2RjlRWEhhUDVFanlqbHVSNnhvM2RoY1ZlSVVHajc0VTIvVm1hZEZj?=
 =?utf-8?B?ZFFXMVZpTzl0cklwSHFlbkYrVVlHVXVUbmdtbXllaGkrZWJES0RQcTMvb0dy?=
 =?utf-8?B?Qy9rVHQ2QmJEUm5uWXAyRFZGN3ZlN1hHQ3FPU2djdGJOZFBOWDNUKys2NlA5?=
 =?utf-8?B?SUFYcUo5YmhzU2YrVkQ0bDF2ZS9hVm5USEUxdStOUmozeENmM01aVmIrTUNZ?=
 =?utf-8?B?cDZJYTMzK1I2NVpMeHdEUTNROVREaFdwMjFqZ0JldWJCV2s0MzhVMHFteW43?=
 =?utf-8?B?SG80YmRCV2NKcFEvMmE1NkY4QU1ZVy94Y2M1dXdxdktLT3pZR0htbXllUStH?=
 =?utf-8?Q?VgiT/nv9a/7OrOYELKIDxWeD9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29DVlUzRU1SU0xwcHhmeDhod2x1QmUvcU9Qd2NTdDFFQWZJMThUc201SXhq?=
 =?utf-8?B?ZytieVY0WE1yUHp1eVIrczVId1NxY0dieHBsQm91akJtVnpQK2M3SGJRY29C?=
 =?utf-8?B?cllDUWJVaWdZNDJWcHMxV1UwS3crL0tremNDV1Q5UXA2cGJDVU5mV0FtR3pR?=
 =?utf-8?B?SU4vVE9mdUNLUkpDWUEwWUM0SGxQbWFUMklETzVNd3ZBWWw1MFBLUGpwSWJz?=
 =?utf-8?B?akI1YVdoUGdXK2ErYkV0MTRNU3hkaEJrR1ZlUDhVZFBVaENIVm0xaE11WVVE?=
 =?utf-8?B?ZDlRbllZVGt2L05vWjh2ei9KMFEwd1FPbHJZbHVXUmd5dWI5U25TWktzYUFk?=
 =?utf-8?B?Lzg2QUVqQ2RvV1hnUStLa3RvcW5FRGoyQUI4T2tnSWYxaFY1d2t4MXE1bTli?=
 =?utf-8?B?ejRicnhDbEpicUJtanBFVks1VUh5NXE3Y2dhT29ObnIwWDU4K0c1VVkxRGk5?=
 =?utf-8?B?bWxQYisvUXJyTjAwdUp2cFgyNmNmT3dNYkk1MFBoNWJ2TlJVcTY3N0lQeXVE?=
 =?utf-8?B?Wk9hbExuQUEza2lVZVJ5dGQwNi95aDNzSnJ3cm9RVTA3MHI2d2plOThLNFhl?=
 =?utf-8?B?QUFlU3lNWDR6d1FEaVh5OXoybG54aXN5a0tzelRvSXhNTG5JNk1HZjlDU0E4?=
 =?utf-8?B?UlhHbUR0YjRhVXRPaEdMMWhlZEZHVy9GL2Zvazh4bFkvTVBWOWV5M0JtR25T?=
 =?utf-8?B?UlVIb1pzWTJWREhBcXZyU3l4YUNzRVU0UmxJa08rVU9zUTg5ZEc2TXBSK3VF?=
 =?utf-8?B?N3V6RHpUOGZ1blVacXIrei9YNnRMZXRyV3dUbDkxaTJ0MEkwLzdicHl5Vkhx?=
 =?utf-8?B?RHp6L1FwY1JQWWlYUnI0bkQ2Um5ROTYyUE80RmNzbHVEUmk2aXA4cnBGbE1C?=
 =?utf-8?B?N3NjQjBFRjhzS24vQm45SlJqS05wNHpHNmdNaXRVdklJVzlMSXpqMVNlek9R?=
 =?utf-8?B?YWJjeTA0VkV6cHovWllaWUdYaVBNUHRYQVJrWktYSHpzdzFuaFQzRE5tM3lB?=
 =?utf-8?B?U2RhSnJwVkZHWUZBb0lKc2tUSUprZFVEVHhWbmkvaWJ6cUh5cmQ2aDI4ZERC?=
 =?utf-8?B?TjJhb1Rocjk2RVhmSVBHVU9GSExjZkhFMHNHQ2pyTFBhNElMZkRndStOUVZC?=
 =?utf-8?B?dmY2b29zQUR1ak1DMVNrdURWUXJ1VGxBY2RoRkNnRGNLazlyQXp4OHh6NWdt?=
 =?utf-8?B?NUFrdDJyVlRMVDlhNnZCcWF4NkZmcG5seVh6bVFKQmZsbHo0eUZSZnZaU2FK?=
 =?utf-8?B?ZzVTYTl0Ukg1UzY1aExGRkhXa3JSNlN4R2ZRQXFhb09YLzdKS0tSM05aM2ND?=
 =?utf-8?B?azJNVld4MmZpMDNuMklGR0tnTEY1aDdxZ1Jzc0kxVFVzdGhTSjhuZ0l3dUNG?=
 =?utf-8?B?SXhlTDc5OERqT3R5M0lld1oyMDBZVzVCdTMwclV3K0NHcmJjb2krUkhGV0xs?=
 =?utf-8?B?NVNvRDBHWlVFTGxYMEJpTDR4cVEwaGFsU0k4eHplK2c3bFZhaFU4YXdyQjFz?=
 =?utf-8?B?OUN5SXRRckplUDdPZXp6MjdvVTZJYkRSSVBSSGF6NVdpdndsVUsrQ0hQYTRR?=
 =?utf-8?B?V0hja0pnMm9vSHprd2I0RXp0OHpyYXhQTFk5NVg1Q3N4YnpKaXJWb0hvckJS?=
 =?utf-8?B?Y2JObU91WlFzRzJZdnFDZDhsMitwOExEZXRUb1FtbGZtNTVsVG03ODIvL2wy?=
 =?utf-8?B?cms0MSsyQVlucFZmS3ZVN3dOWFJaM0p1V3J1cU1NTEkzYTV5VkRSWG92Ritk?=
 =?utf-8?B?VlJ5RWtmanF4TFJ5SDFTTXNiSXRoUVlLd0lKUVRtcWVudk9jK25JVVAzUDN3?=
 =?utf-8?B?MnIvamlBUytneHhxTENpOXFlUFpmRFVFNjNXdUtxS3FQWnVLSFZBb3QrVWtQ?=
 =?utf-8?B?R0prVWRWQm9ROXBnOFQ1bFRsb2JmN1ZFY05XZThFTE1mdmNnM3FmekkzYVRD?=
 =?utf-8?B?NlJ2eWh4akVRZXFwWXVzaVI2ZUdqZVRBUlFKcDlJWlVIU3oyRlBRelMvRUJS?=
 =?utf-8?B?citMaHNDKyszTUlOck5UVkJJanBtdXZNZW9zbkQ0WHA0SWk3WVZLMUt2Qkwx?=
 =?utf-8?B?blAybWU2aUdabTJTUTdvRWtTMmVhWitRV1U1blJGb0JHcVJxdGZIK2ZQY3Vp?=
 =?utf-8?B?cnhGVHVnME1kTHR0Y3NsMTJnRndHdGk3SU9vSGdJVVk2UUtuRjVhUy9DaXVu?=
 =?utf-8?B?NmZlcnNhbzRkYXdFN3lUTnpxU3NNVFlmV2hmYi9tb1BFMUx0WEZINWdmMXdh?=
 =?utf-8?B?SXFJU3VRNFN4Yjl2NVVHUFVxRlBpRzVSTGFjZ0JsUlpTYVpHaG4wMFFrc0dY?=
 =?utf-8?B?UDl2ajVvZmVHRWJSQjI3N0crU1oxMVNoSG1hUkRubktSYy9vNXNiQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 926a088d-7945-470e-7a38-08de6225d147
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 06:39:30.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YPyZ1s1YceTtTRRtPMZOc+G6lKqitxUHO/cmaQ+W+u3dETb41vmO4BYtQxhnP8Wo5YR2o8VsklXuFFKaQ4gRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6834
X-OriginatorOrg: intel.com

On 31/01/2026 04:00, Ethan Nelson-Moore wrote:
> Three MMC drivers have unnecessary module_init and module_exit functions
> that are empty or just print a message. Remove them. Note that if a
> module_init function exists, a module_exit function must also exist;
> otherwise, the module cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Doesn't seem to apply cleanly to mmc 'next' branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=next

Fix that and you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/dw_mmc.c      | 13 -------------
>  drivers/mmc/host/sdhci-pltfm.c | 13 -------------
>  drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
>  3 files changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9e74b675e92d..613d74d2e946 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3693,19 +3693,6 @@ int dw_mci_runtime_resume(struct device *dev)
>  EXPORT_SYMBOL(dw_mci_runtime_resume);
>  #endif /* CONFIG_PM */
>  
> -static int __init dw_mci_init(void)
> -{
> -	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
> -	return 0;
> -}
> -
> -static void __exit dw_mci_exit(void)
> -{
> -}
> -
> -module_init(dw_mci_init);
> -module_exit(dw_mci_exit);
> -
>  MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>  MODULE_AUTHOR("NXP Semiconductor VietNam");
>  MODULE_AUTHOR("Imagination Technologies Ltd");
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 7f6ac636f040..d4fb60c1ef69 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -215,19 +215,6 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
>  };
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>  
> -static int __init sdhci_pltfm_drv_init(void)
> -{
> -	pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
> -
> -	return 0;
> -}
> -module_init(sdhci_pltfm_drv_init);
> -
> -static void __exit sdhci_pltfm_drv_exit(void)
> -{
> -}
> -module_exit(sdhci_pltfm_drv_exit);
> -
>  MODULE_DESCRIPTION("SDHCI platform and OF driver helper");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c459a08d01da..41e49c6cc751 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -1126,7 +1126,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
>  
>  /*****************************************************************************\
>   *                                                                           *
> - * Driver init/exit                                                          *
> + * Driver init                                                               *
>   *                                                                           *
>  \*****************************************************************************/
>  
> @@ -1138,17 +1138,6 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  	return 0;
>  }
>  
> -static int __init sdhci_uhs2_mod_init(void)
> -{
> -	return 0;
> -}
> -module_init(sdhci_uhs2_mod_init);
> -
> -static void __exit sdhci_uhs2_mod_exit(void)
> -{
> -}
> -module_exit(sdhci_uhs2_mod_exit);
> -
>  /*****************************************************************************\
>   *
>   * Device allocation/registration                                            *

