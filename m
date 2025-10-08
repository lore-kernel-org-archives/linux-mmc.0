Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2E19D8BC;
	Wed,  8 Oct 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923056; cv=fail; b=ul7w5ZUb20/OuQ8RKOYNiJrJoER8exuUD/R+d2se6hgcvCdXzUpsXaWa2EC2Sav5Gf+mHPnDZvH6ajmNUFIGN6tYVLkvYpCa+zjrd1Z/FS7udxsGZeMWV5m7Q5Pf0y2GLDdyA5vxqtINhzDP86cWtHooki6fyIPXM93TbXAuUJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923056; c=relaxed/simple;
	bh=aqn1irst1xMskBZvmaNBS/RsLq9ISFs8or8nm0dBdNE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJL3qZYqmfWjlbZN1xZitRaF9PJOsiRkzM/Xp8H7ZO9BPXJ0xLUe7m6ASy2TUSxnLHEOPRsSyun4sxDQGuTxQ2QkYATg0ByOdan4q8AeQwd4Jdb4u082YQIpxgyF04tvJjEsIit8R0KJzzoCDAKCJ/e0brKb/rsjt6PIvngK4VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rp02//Qu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rp02//Qu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759923054; x=1791459054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aqn1irst1xMskBZvmaNBS/RsLq9ISFs8or8nm0dBdNE=;
  b=Rp02//QuN8HuD39cotyArTMX5rWMjcE+Ov94MlLQbBdDw1rLLW2C0aY3
   XoEinjyYA+PuMENaY6ONlvjmKQCdNb/ZD1EuZ6LItY02TxkkWKEMI1BHo
   ai7u4ua9lUgt4e8gADImXMKWwVr9BsKT3k7bhDS71XYwr08YmEVhDBI9N
   dOpO6+QMN/yn6oSMEa1i5zarvI0gTZRpvr5hXQlE1Lfd7dR04biRY5VXz
   f1pFHxIdLqmpH569CbViBQoaXgSCh0mUNgjxtPoB5INq8sWyapCxstlZM
   NABgrmdQrJAOIaVXaoi1wOMf8dkjzjulqAQ0p+4TyzzrMUrwQfHQcq06W
   Q==;
X-CSE-ConnectionGUID: zg+ZxSqoRvSAdh+QsJQZMg==
X-CSE-MsgGUID: a827O4WqT8Ox4DjMZ1/WKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79760168"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="79760168"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 04:30:52 -0700
X-CSE-ConnectionGUID: uOwKbfgcSCSd5tLwT4DcKA==
X-CSE-MsgGUID: Vy/ITJ1rSFmPe/S1RCLe4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="184789684"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 04:30:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 04:30:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 04:30:49 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 04:30:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is7Xbrwjmja7oaRBeMwCgA6bhiAjI7iyrBoXUDFljwkhsV1zP4OKlAzC3jyqumQJCbTArAAFbzBr5TvrlibR/R3q1yVnOTnqVGIc8dypd8x3HAqdLpLzLpVHgR4uaHjrL+qBhFgwsXDuNSk60rNjlNf+R4AQwOZARr3sK4QeQ2ASW6Ne4pvhr1n3hKAtU0C2QEelOouqVzq5DnL9sbusxgeFieGws5p/nFK4SOUrts9CujWyBxKWIWWXk6T5n7kBdJdWFemTyrR0oX0DZ7+pBQgC3RYLWBMAIR31ParUeGm7g7b9q4m7KO/s78h9R+oBFSqT22F2t2LHkF/QrOBlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb6GC43NpkcVOKceR1+gDEKv9Fpfay0jr8yvTi+AxHU=;
 b=FRsNVCUAr1EPT0sL9yrn9iY0VDKBXXKEzgGmZs4fJD44QcfrR+rkpuGItezIsxXbdIury5VF0zLETCyXEh34OAHegxDAHkymgWRSbEEBE/aBuj2jrwboreTB2St905U5gaAYHg8lHbgNTwyLIvotj9AyQCcEzvwXKwSnzfHwePYOaJBPWo2lRVGcJiiyg9sCLhAcUdPvVhfkbplbDVmyK4U/0iZU47ysGg+igeeOhKMhv/5BVXKet3U7bB/uhmA1vnmSYtR7EHan9UcJx1uRmJ306wpvHD2zb4GRGVFe1YQznRolvIijPyvm6y8yrc0OfxkJ3JVfxvswlzUIA1yqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 11:30:47 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 11:30:46 +0000
Message-ID: <c895cd11-4d8d-475c-8ef8-3007f9037aef@intel.com>
Date: Wed, 8 Oct 2025 14:30:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Michael Garofalo <officialtechflashyt@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>
References: <6294fb07-31b4-4c0e-9023-7c5ab604bbf1@intel.com>
 <20251008011041.3298938-1-officialTechflashYT@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251008011041.3298938-1-officialTechflashYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0016.eurprd06.prod.outlook.com
 (2603:10a6:10:100::29) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: f65f14f7-29ad-47b8-3bd5-08de065e1f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cytJMTBRWFR2dWFISTJZd3hWMTd2dEN3NnlnVm5Rd2dMTlpQc05MRFhyd25u?=
 =?utf-8?B?Q3Iza29pUlZpRTRsbVZPbDVMdGNybnN0N00yWmJrSWlRNGFJMHpTUVdOYzA4?=
 =?utf-8?B?cklmQ1huaUlTMHpyUWthVlAvRE1INWVTeGhaNlB2elR5WVRDVHlQdGRBaVJM?=
 =?utf-8?B?L2JkUG9ObjJoZkVCblI5TTZVVy9mQ2tHbzZvYlN6R2FKMWdXYU9oQVVwTHow?=
 =?utf-8?B?OHd5enM4UDVhTkg1TjJjTnlCN3ZXeU1HR2FTZGNZMlk0YUdWK0hnWEY3MFR2?=
 =?utf-8?B?RFpQV0VEUFR3Uzl6QVJxTi9UbUo2SXBJTDhTcEZNVU1SL0lvN3ZxU2NsaThQ?=
 =?utf-8?B?eW9uRWtWR3ExRkZ0dUdZcDZhSENRL1JTaUxPR2dnRDhtNVJOVmZNaENZaGNI?=
 =?utf-8?B?Q1JHRXFUT2pMWFVLdzhLNTVlTks3NFBOeW5SWUREbkxiZTViQ0lURWRraUNz?=
 =?utf-8?B?ZTI5bFFXZjVLTi8zcnFOUDJ0RUxXOU1wMmd3QzRmTWJ2V0htUXNHMFFFS1hx?=
 =?utf-8?B?TVRJcTRaSlc3aVJRZ1RSd1VEOHhYRjE4THE0di9LVXBzcFlKQUcxTHVDNndT?=
 =?utf-8?B?c0hONm5kT3lycjZHVTVCRjVSRkRaMlNDZU9JcmlkYWVHU0lhaDRmcHdPbjAw?=
 =?utf-8?B?RTE2SGVHM3NxaHoyeEg5RUpnQ2l1UGhFdFNPbHJXUHFSOWJjV0lYUGtOaXMr?=
 =?utf-8?B?Vk1CLzlCVFpieVY0STdZRm9LRWlXUHpBZG85SVh5MFYvNGlqQ3pmWmkrM3B6?=
 =?utf-8?B?eXdjZkJXcml2OE9JQVJXUGlyUGJOdXMzVTVRbk84b1NKUEljanZ0aFJkQVFG?=
 =?utf-8?B?dWV6dVJFU09KR2ZIRit6KzlycXFRQno2K0Q5ck5qS2VDNjB0cUxWUm9NaTFM?=
 =?utf-8?B?Z0N1SkNCSmx4U2gxZEFHdEpISmQ0eXRxeU1yL0lBc2ZHZzQ3UXdQcEhmNWF2?=
 =?utf-8?B?TnBTTC9OeXlab2hoZCtUdEgveUpHL3h5UEF2YmM3MmNkM053WnlIcE0wV2tW?=
 =?utf-8?B?dGNscjA1bElmWDJ6Sm5NeTEzbFVIeFpNRE1qbWJCKzRWU2xQN3NzRU4vNmtG?=
 =?utf-8?B?RFMrOFBmdnJYQXB3Ui9hRC9zZUljZzl5UnBSZTEwWGFxVnMyRUZVZlFETExQ?=
 =?utf-8?B?R0NHdFZ2cExNZG1lZTF6a2xrVTQyb0NrbWhrMCsycThSazdaNkdhZWNjejBs?=
 =?utf-8?B?ZmZDOTJyYnBEZnY1MFVocGVRQ3pRS2N3MzhNdmd1N2EwU1VCNENEL01HSXRS?=
 =?utf-8?B?eENOU3lHTXQzZmVpRitiSXJMbTRPQ0JHVkRYV3M4YXkrN3FuTXJ0RURiMVlQ?=
 =?utf-8?B?QVViUEVTeHd5SnF0dVpTY2tBQ0grNEhScXU3OTduV1Z3UFlKWFJYZHlOc2VE?=
 =?utf-8?B?MkxGS0hWbXNmVmoyWFBnRSt4eWVBT0dLL1FvK2g4dVhDQXhHZkNSQ0R1UW9R?=
 =?utf-8?B?WXlSQ2dpV2tFbkpac1QweUozbVZIb2EycmtMRkRHU2VwYkcwdzhNZlhhaUlU?=
 =?utf-8?B?dHBUUXNyZDZRTlByZmRGZ2hrNjkyRmM1MUFOZ1dGYlFWWWszYkpCSVMwcmZo?=
 =?utf-8?B?QXkzWVlld1IxV3FidzNyaVlwb3FMSHlIV1RiRDNiaUxZektLbVkxcWJWaTB1?=
 =?utf-8?B?am9IMU9iS0syQnJEMFd0QjMxWXpNang2UlFCNWFTeENBQ2U1aDVxYTk3dEI4?=
 =?utf-8?B?d1FsQm5reDI1MlBxYjNGbnNFbFBzaitlRVFIc3cyb0ZuTUtMU3p4TWdlQm1M?=
 =?utf-8?B?RmhiZ09HenJGZ2RBTXZhZURpVEJnc3ltSWNTZW9JdUZGMXl5Y2YrMDIyYlMv?=
 =?utf-8?B?N1FLWXhyc2JISE5vNHZ4ZitpNmhobEVna3ZsWGh0Q0prNU0rdE5PMUZtOVhT?=
 =?utf-8?B?Qm9YTFREbDByZEczZDh3U2VoY3BjcHNOUWd6ZFUxdjFXeFBiUmZGZXBTQllz?=
 =?utf-8?Q?4DVZDk3qS+K9JCYz//JVURKHdPQvzix+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VDVHJkRmdTazJzQ2VXQzBLRXF1YUlFMnZPc2lNNDVuQ1ZnbU5OYzNvQWxL?=
 =?utf-8?B?dTNKUG5acWtEV3JDVDJYTUMwb1BMbGpraWNRRXVTWXdMbEdlc2thZW8xNXVO?=
 =?utf-8?B?S0xsc2sxamNBTytQbm1haDJHSndnQ1hHcG45NE5tUkcvWUI2REdld3V2M25B?=
 =?utf-8?B?Y0RRZDNYUWpMT1FsUHkyck43Z2ViWElVMEpHbWZOL00ycExWMlRJcklPU0pq?=
 =?utf-8?B?b2dvTEtYZzFnVkxjTmM5VlIrV2RmMi9UR1lTVWNGNlhQQ0xuS1hzL05lc1lh?=
 =?utf-8?B?dzdUQjFYQVBYcDFncm4zcDlkVDVEbTNGY0VmcDNpL281NkdWYWpxczB2MzhE?=
 =?utf-8?B?K01FYlBMN201UnFNc3dQUkxueURDSjRxa0w4cUdYWUc2cldOTzArT1kwUUVo?=
 =?utf-8?B?aXlnM0l6Z3pIMjVyeFZ3QUVhN1QyTS9lZk9RM2UyQldZUHg5TmhhUlRnVU90?=
 =?utf-8?B?SU9FL0txbytmaXlDTVpWQkpPTkFMV2hwcFBQQmR6aFRTcEpBSDZsYWtnTHdY?=
 =?utf-8?B?TGFpbm1LRFFHQklBVTNUb1BUTHRrdEVlYVhYdis1Ri9KN0J5US9oR2FoNEp3?=
 =?utf-8?B?UE5JZFpMc3NGdmZJbE9MSVAxUWE3amM5S1JZRHc3d2RESmtvcktJSWxjRzVE?=
 =?utf-8?B?Q3FyTTNhakZuRDhYVGpTemM2c2hxTWpMc1pUejEvVTduOGZHMmZHeVdjbXdQ?=
 =?utf-8?B?NXEvUWFPQ0lvNm90cVZjajdUU3hpNXc3Zk96SWdDMDhpeFMrcVZzK2pqbjZq?=
 =?utf-8?B?ckNObW9ubkVLWmRsSktOc0hoa0VBZ3VnMXY3Z1daakU3S2NjL3JMYk1YTzZo?=
 =?utf-8?B?UVZZRHJIdE44bHV3NHNxNEswOHExT0g3b0RGUGE0L2V3ZHBDYjEzdTlQRnZQ?=
 =?utf-8?B?TzljTXZHVWFEQjNXNHhwbFdWNHpjSkVyK1NIeDdvVUcxUjBhTE9oUk1LMGoz?=
 =?utf-8?B?S0htazl1c2UrS2FidHNqaDVOaHFHa0pzVkNmbk9CcDN0VWRvWkQ3OGo0QjZj?=
 =?utf-8?B?SGZ5YVhicDhNUVZkUWRrRHVIWEJ6Q2JJNS8rRTVnaVhJNjRiT3lYbDFPQlNx?=
 =?utf-8?B?UmtoYnJZVHpOL3hXNU54WWhndVpOQXlJWld3Qy9RUGNPalZjYWd6cW5CQ3VM?=
 =?utf-8?B?MDdNKzdvUWhHV0Z3R2tFRVBWaFlKbWdlN1BrUzEwZCtPMHRSMFUrQUNGMzRF?=
 =?utf-8?B?OG9MbjBtRnVZRTdCYzVDMkxEdmhHNlVtNHh6WlJ3c0crK1JXN0tnV3BnQ2hF?=
 =?utf-8?B?cWtGdUJUOVVsVWwvRHFBMlUvblJIeWRGcnFwMXBZZVFYbytucDd0dm9rakt2?=
 =?utf-8?B?TVhic2FNa0E0dW5hVjZ2MUxzakZ0RHF0aTNRK0JXTkJwK2Q2ZENCMXFaSS9G?=
 =?utf-8?B?ZEhiRmVnS1llRUhFN2tVSXBhWmpIMkVBUUtGek1oSys3N3dkV2VaK1NleGhQ?=
 =?utf-8?B?Nno1RkN5azlGcGRQcEJtbTZrUXQ2TWlqckx5MHNNRFErU2F3NEljWElqWHZC?=
 =?utf-8?B?STdrZGJOakYyaFpJdEg2di9BQnRma2NLWFpoSmxyVzJnVHJPai8yNUdlaVJ6?=
 =?utf-8?B?b1Nac3RoaVJIbDJEOVNLYW1UZU1ZTHRCcCthaUVBZHl4ZjhDb0VJSHRqRXZK?=
 =?utf-8?B?Y0ZuWXY2TG45WTY5QnFPemFHb2NwdmJpRXF6cTFWbnJnb0VEU0RiTDhPblp6?=
 =?utf-8?B?UHZCVWg2aHo2OHlJLzRuWk9jc2x0RTAwNjZVVDg1NERYRGc4UXkwbU5jV1ph?=
 =?utf-8?B?L0pac2FDaFlwSnQwa1ZLbUI0YnlyeDB0WHJTNUdoNXhkZDRlZm1xc0Ryb3Fy?=
 =?utf-8?B?RUpGOFQvZGlIN2JwaytLckJrNHE1S0tPME02Z3lYc2Jra3dtUFFQd25uczdS?=
 =?utf-8?B?c0RaSXdra0FwalRubGlERmVTUWgrdnZwblpyNUJ5NmJjV1VsdHBPQWhSSFJG?=
 =?utf-8?B?ZzNmdGQ0TXNjSnFBQXAzZ0hWbFBQMkJWWStKUWpYVEFpbTQza3Q4dFNWRWk0?=
 =?utf-8?B?QjN4SUlYdUJtbEltSTR1MkwwZTEwakVHQ01uOWxvT1BLanVnS2tkaXZqTUg2?=
 =?utf-8?B?b0thWVRoMjgvbkU0b3BVdUVQN0VyU3NrWm9Yd2hKS3pBeHFKQ0RmY1lFSDNU?=
 =?utf-8?B?emwzdW9tSGp0bkQ0R2s2bGsvZXkrQUhic3dRejFWYVozTUxoU2wxZkdDYzhz?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f65f14f7-29ad-47b8-3bd5-08de065e1f80
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 11:30:46.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+FlPWzHfq+VXWh7dY6L3r9my2wNFmZArT1XQBgRvNA0Qh+OF/6SFaPlvF652n35DAG3wsa8VWcd2c44FEi6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com

On 08/10/2025 04:10, Michael Garofalo wrote:
>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>> Wi-Fi fails to connect to any networks.
>>>>>
>>>>> The bounce buffer should not make any difference, so it is likely
>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>> used.
>>>>>
>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>> for the failing case?
>>>>>
>>>>> Actually will also need to see the messages in the "fixed" case
>>>>> to compare.
>>> I'm afraid I won't be able to provide those easily, at least not with the
>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>> turning on full MMC logs like this produces an obscene amount of noise
>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>> my original intention, which was to save the logs to SD Card, (since my USB
>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>> since it's now logging the writes of it's own logs in a permanent loop.
>>> If there's a way to narrow down the logs to specifically whatever portions
>>> you're interested in, and filter out the noise, I would happily provide it.
>>
>> Are there any error messages?
> If I drop the debug logs you mentioned so that I can actually see what's
> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
> it takes several tries to load the firmware, and it can't authenticate to any
> network.  I've tested and confirmed this effect on multiple consoles, across
> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
> off, it's much more functional.
> 
> Logs with MMC bounce buffers *on* (without my patches):
> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
> [  168.508519] ssb: WARNING: Multiple ChipCommon found
> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
> <keeps trying and failing forever....>
> 
> Logs with MMC bounce buffers *off* (with my patches):
> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
> [  383.986645] ssb: WARNING: Multiple ChipCommon found
> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  405.389013] wlan0: authenticated
> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
> [  414.351544] wlan0: authenticated
> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
> [  414.431879] wlan0: associated
> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
> 
> If there's anything further that would be useful here, let me know and I'd be happy to provide them.

Seems the SDIO function driver b43-sdio does not print any error
messages.  All the error paths in drivers/ssb/sdio.c print debug
messages instead.

I would suggest the following, which would limit messages to
host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
Chip ID 14e4:4318"

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 860378bea557..2719b21783ad 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	 * - The card was removed (...so just complete everything no matter
 	 *   if there are errors or retries)
 	 */
-	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
+	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
 		mmc_should_fail_request(host, mrq);
 
 		if (!host->ongoing_mrq)
 			led_trigger_event(host->led, LED_OFF);
 
 		if (mrq->sbc) {
-			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
+			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
 				mmc_hostname(host), mrq->sbc->opcode,
 				mrq->sbc->error,
 				mrq->sbc->resp[0], mrq->sbc->resp[1],
 				mrq->sbc->resp[2], mrq->sbc->resp[3]);
 		}
 
-		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
+		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
 			mmc_hostname(host), cmd->opcode, err,
 			cmd->resp[0], cmd->resp[1],
 			cmd->resp[2], cmd->resp[3]);
 
 		if (mrq->data) {
-			pr_debug("%s:     %d bytes transferred: %d\n",
+			pr_info("%s:     %d bytes transferred: %d\n",
 				mmc_hostname(host),
 				mrq->data->bytes_xfered, mrq->data->error);
 		}
 
 		if (mrq->stop) {
-			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
+			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
 				mmc_hostname(host), mrq->stop->opcode,
 				mrq->stop->error,
 				mrq->stop->resp[0], mrq->stop->resp[1],

