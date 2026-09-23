Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFE353A6D;
	Wed, 23 Sep 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181911; cv=fail; b=W+WR21aQg9CULVnOrwjmFGkXrdU65Tkd7K8axNI6rM3PgIKMXcTFu61CU4fC9dCILCQXMfh3fQqY259YEqVJCdwcRL+mBcTPfyAYaGufB0NZIyzwbVo+X/4NCAo4u5fGFUt3Sm4gkXG//Q7a4BGz7MT4+4R306aRP/bHML1NbtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181911; c=relaxed/simple;
	bh=/nuQS153nZlORQ5AILx19IPwvIMPXF60EuuHWvvHSDQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye8pXBriCEIsFci6rGv+NtjhJ52FoS1xKXC1DqdqBAfM8SInL+AtxJncR45Zc/II0IV4E1AHV7+MFugrvt464r6nHHDe5+HrHinu16KBLfF6j//uKb4GodeJp/Ek9Ds/J8EVPSvcfOD4xeeCvNT/ysQXjwJUCt0cHNV50uCM+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpwbGbqv; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpwbGbqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790181907; x=1821717907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/nuQS153nZlORQ5AILx19IPwvIMPXF60EuuHWvvHSDQ=;
  b=EpwbGbqvz/ZbuwuE/sQh9Pv/5YGMLe5uQ6e81yFDBybPvj4/QgTcyRgZ
   P4HfiOV82DsF/wgkfRwyLe/kPabsoqgysyPp9UdEhTGH4o+qkczQtKk2z
   CYuZGxxIezrpVthA5XB8ZKxZ4XJ6+4YiePr9VIWargvti20LKUWtJZj69
   eHJCb71LQL+QN+yXLqjNZIeyFjVXJHupOseeePEdAl1uMKYNfJFiqkPYo
   7UM+ZEFPWdsM579wDxIv9sejIgbx1C0E9ZxWUb2/VH0v7l8V4AN4sU6/6
   ep9x/QCqVPw413onKgHVQe4NZTI8i/cqDX0gnVV2hxdgh/3VjkL21yhvF
   w==;
X-CSE-ConnectionGUID: mZumSP6YTz6bJH5DQTAMBw==
X-CSE-MsgGUID: J0P3rd9+QQmZHQtMVEp7Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78454851"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78454851"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:45:04 -0700
X-CSE-ConnectionGUID: vN5IE0amRzmrtGpl0PTMHg==
X-CSE-MsgGUID: eRVeGu3KQVudTKyoPSuO0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4802509"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:45:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:45:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:45:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMt7cZKS4WjiQvJpzAIzvHQmHDLr3lm40iFcIoEtf1/STF3Q+x/UXCntVgZwxA6cdCI0GxfpL89Tyh7V5vcuK4WUonZxIhAapeF72SgFugq3iya7ErUn3VjeU2mbJasRrlfzz4Hr7uruZ1PAeWZNFnEkNXKaKgPF7WWGMTbw8zpr4KrCg3hPLXUnrjZ82m6sYYKpMh2cONdUH1zn07sPH8x4rDx60nO3/eaDc8Y+VGGXCbTIQacEnUv//iFoeRGcmHXQ2hrP9CCnvKNiFLCBs7svRHOcqS3e6Vt/cmg4t6OYsto821cy1HurcMKB/SMRLEHUlBTp6DG9/eIaAJUigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy2luUWznrK/atCGX7zOwmpg91Pu4PE2v5r2biQjr24=;
 b=CafuveuPGEMBGx9Ltl0DwmdZGgysv6zjm9qFSYQ5IfLMB+JA5XkBFxr1mnsB+sPg4EMwfJvQiSfe7Qt8I4x7L+CKfrTWZiNqPZli6/GynEV8UwmQQaguWxSFqlRBgsnfnvQ1QKKvOsptwb15up2Dm2H2AHn9KH+WSDI02Q32bWI/DkrwaMJYkfTxSpA6L8P32Gb5jkWbW1kSGMHqujqmjeOXop4nS5WNNTgbB8ojWG1wOADzUw5hfkcsDS+HdUQizPClj2Q7SzosBYryKPYzfWApr0d1gO46gb48DdSWeI2nX6N/HqHnFdDqgmu31q1Nwx9o87PDi0oOZZdEi0OzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV0PR11MB166520.namprd11.prod.outlook.com (2603:10b6:408:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:45:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:45:01 +0000
Message-ID: <faf694c5-e063-48d9-b999-dd74b419c16b@intel.com>
Date: Wed, 23 Sep 2026 19:44:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Disable CQE error halt request for
 Rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1790070007-11769-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1790070007-11769-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV0PR11MB166520:EE_
X-MS-Office365-Filtering-Correlation-Id: b301847a-3b40-4c05-dd6b-08df19920299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nXCkx9THvSKvs6YmfqpzNNNJ9IAVz0BImGrLDmVOG7hxiG4bnhI3kmUB9IFUKNIWlD+SsVHUC5GrWkilseF25QhXpASqJNBda04/2m/GxJnIUdKmT7h4he17zp+8Vcu7hNWpoCM7wFyDEXQXYjn5TLkaUuJLH0yZjgI2hTVyoLDl4Q9RSr2w8r5DjtTBHqW2NPXalsM1+2NpnRBzXnZOaMkrq/LArfii5iQh1ba3vG7+hHUu5gp7khngC0JjTxryAGm4Uc/2pgwKrH/zPqHWYseXtOWBnkOMVh5wuPBK7uGwiurVKINAxpZhjqT8eEo3VRrWnxDXyPBKTTUiRDkgdjvUGLT4OIYnInHl2GTr6aeHc85+U3kflhQG8ssvMDXXeqCDCBHfb/750cCmycl385N+DajPvVfkd3ScoUYdXzNZyLHZo732xx77mh/as4oCE3aZts6JM/a/QwtNF2mFi2ql2KLDq0PKMyYQ9//WGwoYIBtk5Nuvnc96AcYD3Qt8WO9ylP+FRjmVs0ase3xZReRIghQWdWhzMwKf1baciJqwGabzP02hTD6NiEQbKvvC7KRdxplStdteaZW3pYX4bwdLCC032fMDdYFfBPdxySNML0kCESUUVRnBDd6bjhkqVuOluGblNHUWl9Me+BgGmu9XoyUE5VcIi7xi5NprYRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Y1T0tkNlFwdy83OGNpMGR1S0J1V0NmaEZzZjhvOGJJblpOK3NpcUlBNDBl?=
 =?utf-8?B?WjBuNkJBMnBJbVovTEtleVQ2UWhwZGtmTTRxa0tZVHhvNWtQYXNnSXYvU2oy?=
 =?utf-8?B?c2Y0NXJ4R0dDNHA3anVKNndSclRVb3hWOGdIcmVDelNEc3ZsRkgycjU3MmVZ?=
 =?utf-8?B?YlhTZGNNbm9ZTmF5RkxoNkt4THZuSndoQ1F0dGFDZUJ5ZExrQUt0cmQrSXVX?=
 =?utf-8?B?cDF1cDdsLzYyTkVJUHA3RmVQZHNvdkRkeURJdHpURHNXUzhCQ3NqakJIR2ps?=
 =?utf-8?B?QW0zNlBMb2R4WHY0a0JHc2hNWFdzWjJ3eUlHNC9xRjd5ZlVxTW93T0ZtK0Fi?=
 =?utf-8?B?cWRuSFdwTjVmNW5JMzN4VXJoaUFxdXhsNk5GazRkQktJc0x5NU9Ba2twWmRq?=
 =?utf-8?B?amgrK3YyclNoSUVRMkVjTFpPcU03YUNuZGgyV0RXdHZwQmQvN0g5OUpLZXR5?=
 =?utf-8?B?YXMxZ3o4MVdrbmk1alRiQnNJWVlmU0o0YmtsNUhLZXhIeEw2N1pjcjQ1a0Vv?=
 =?utf-8?B?RlNFRlZ2UFpCdmUxbWhwQS9pUkdURHpOWGhFZ2FNNERteitHdGxHd3dSTklu?=
 =?utf-8?B?RzFXcjdLOGJIK1BGWHhtSjBIODJCQVE0SkFkdHdkLzdQbVRRdk1zbWhHNmJv?=
 =?utf-8?B?MjJOLzRKMnN6bVRyNFV5NW9nTXJ3VXhIRVppYW9WQWJFcThiayttQWdtby82?=
 =?utf-8?B?eTlaSTFibXJ4UHNNT3p1VHJ5RXo1MkNnQUV2N2JsaHlNSmdmQkRJOVpTNTU2?=
 =?utf-8?B?bGw0UTJhN283UmRUVFpXaThQTldoVW0wa0JwaXozcXI5bDEvVnM3S1QvYUhI?=
 =?utf-8?B?eEtQTFN1UUVQQndkTjVrK2VhcFBOTlBXYnB1NUNrK0FSbWlKdnp4Zmo2bmlQ?=
 =?utf-8?B?RFdxcUdPQ3ZTbTl2RGFkNk1wMVZMdm9mdG5PejdqWHVpL1Z1WmhoL3dVa016?=
 =?utf-8?B?N1JzYmowU2NjV01qQ0VQMGRXZjVlMVlLRjZvcXZJK3ZJeWl3eGc5MEFSc1Ax?=
 =?utf-8?B?MUFmRnIwOW9VQmdxbmUxOWZmQ24rcFc2S0ZoVURCcHoxL3dxL1lueDN4TGhQ?=
 =?utf-8?B?NEdIamR5TGhLVW1TRjhEL3ppRnNPRGUxTWZmTzNKaTBzeG9MMzkzVnNta25z?=
 =?utf-8?B?RHJRUE1TREh5TEFMbnJoeE5uY1pGelphREQrWVlKUjNadHl4ZkdWb3dBZ1Va?=
 =?utf-8?B?bGVyUFYxMG9mdExmek10NnJGSVhuRVN1UjdBZEZOYk1VdlhPNndEU1MzN2o0?=
 =?utf-8?B?RDVlcHkzR0dZT0h3bFFRMFMwMmJCQlRWdXMwRmJ5eUh1SytxU2VLb201dFRF?=
 =?utf-8?B?SEFSS1VDTW41UzJWdUk0RVlJekdEUEk0eDBCVTAxWTlGWTdQVXFnNGhwenF3?=
 =?utf-8?B?TThpc1NxUUJpMFZaMHFRWlNyKyszQjJOeVZ4TWRkb3VkdmtHUG1sdEdsMFdk?=
 =?utf-8?B?a2NRd21NYXE1cjlPOTFJSkU1TFJDUTVqQXJlampvQUZLMVAwUWhLcXFFWEZQ?=
 =?utf-8?B?UGdtTzdkcEk0REdSMmF6U3N1ZzVnLzlZU2o2WTUwd00ySjRnY3VwSGN0MzN3?=
 =?utf-8?B?N0drTWg0T1kzekpVbEMxWmkrZXFCRXZ5NEhCME1IeE03NHJnZSs5blBkQ0R1?=
 =?utf-8?B?dnZYRkVYSWxtTkJlZXBKQ0Q2L2lzSDlHUUY1VXhQOEpwV0VROE9IQlNDRGlT?=
 =?utf-8?B?dWZCQStobzkxUDZhRlRCY0d3Vzl2SjVQWlNtK1h1MU5RNDZTRGRzV3BLRUJu?=
 =?utf-8?B?NTYvWTgwV0JjbTZwTmNYYkVkQW1HcUd1REpqUjloTVdlSHhYaDBKYlhGS2Z4?=
 =?utf-8?B?TTlIbjVNNjZsQi9GUTErSkNWdDBDVm4xREhjVVhFd2NHbVdadE9MUHQ1clFF?=
 =?utf-8?B?MU9oN2dpMFRIdkllUlFuem9lNUFFVkkzeEJDemVzUzNFYllRQlloYkNyRWZ5?=
 =?utf-8?B?eVRuSTRYQnhNUHdHTXk1K2FpVDB1VnN1bW9tYUJpdkczRU5YRk5wc0NhcWti?=
 =?utf-8?B?N0VOanZFa0dJUzZZUHc1T2N0MmszampkUjZheGdLU2J3NG5vVFAvNTBRaXRw?=
 =?utf-8?B?TWVoQi8zTElpYStKSzA5d3FCTmlnbTNzbXViVE1uMEZ6SmhielNSZC9YSjEw?=
 =?utf-8?B?TVNPUlBnWjZIMnUrTFArQy95ZmM2WjlHM3YxVDE2aHArQVYxM2J5OHdqSXlO?=
 =?utf-8?B?SzB1QWFva2ZjQ0tBaTNLQVF4c1FpbTdKNE05Nmt3QTlxN2doNzZla2VBMUJV?=
 =?utf-8?B?YjRTWE1Qa00yME43MFgyNWV3WnVrR1FKanBrOXl6ZFRtWDNBQVVSdXBlaVZN?=
 =?utf-8?B?dC9hd25Bb3p5TldtaGVQdEF5OFZPVmRuSXE2U0dzNzZlRTV2VUs0UUlMZHR2?=
 =?utf-8?Q?j7eM9FWwejlHsncA=3D?=
X-Exchange-RoutingPolicyChecked: ZFaEtlaHJsBVSCaKF3IeVlP/SXk/va/fxSZqwByCh6emlyGfLWUvJuIMmNoXTfLiRbUUbEI3cGld7feuhRwPYblCjC1b4bhtSaWBRmHKi6b84PGD26H9RZ2ZZKhO6X4I66Mq1cHJE31WIT6lXKKENbpapK7RzQ+ycADSFlBCa7kwgpsHbvL5NDGsL8J0bG5E0c5Nb3HB6sVq6+qMhxRGYsowz/TuuFeV3oVqtyb9Ot1yaxa//+rkeIcxb576Ys3Kiartkp8EPGnfIV85XFAfnsGvGCjeK9uRtnkN/O6ECyeoDWyRDkFJUh5XmbZYACvk/Sg8LSEUtUBlm3IYEyoyqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b301847a-3b40-4c05-dd6b-08df19920299
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:45:01.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/PoYAiXAjUojzZ7oShLqBqB3htsn1W4qu3ls7Kov/Kik3sBlP/SHGIb7yp+DSc82oTx7bnaw+pzvhgPe2pj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB166520
X-OriginatorOrg: intel.com

On 22/09/2026 12:40, Shawn Lin wrote:
> In CMDQ mode an I/O error in one task (data_crc_err, data_end_bit_err,
> etc.) makes the controller raise a halt request. While the halt request
> is pending, the controller rejects doorbell writes with a slave response
> error, which hangs the CPU (or raises SError on ARM) on Rockchip
> platforms.
> 
> A software workaround[1] clears CQHCI_CTL right before ringing the
> doorbell to narrow down the window, but a race remains: an I/O error can
> still happen in another slot between the CQHCI_CTL write and the
> doorbell kick, so the hang is not fully solved.
> 
> To fix this once and for all, newer silicon introduces
> SW_ERR_HALR_REQ_DISABLE (CQHCI_CTL[1]) which stops the controller from
> raising a halt request on I/O errors. Set the bit when the CQE is
> enabled, which is the last CQHCI_CTL write before any doorbell write.
> 
> Older SoCs keep this bit reserved, so writing it is a no-op and nothing
> changes in the wild, thus no fixes tag is needed.
> 
> [1] https://github.com/rockchip-linux/kernel/commit/4b7ea0500a1a5c186807b737fecfc6bb4d4e06f8
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> ---
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1baa237..0970202 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -239,6 +239,8 @@
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
>  
> +#define CQHCI_SW_ERR_HALT_REQ_DISABLE	BIT(1)
> +
>  #define to_pltfm_data(priv, name) \
>  	container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwcmshc_pdata)
>  
> @@ -702,6 +704,8 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
>  static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 reg;
>  
>  	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> @@ -712,6 +716,15 @@ static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
>  
>  	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>  
> +	/*
> +	 * Disable the halt request raised on an I/O error, otherwise a
> +	 * doorbell write gets a slave response error while the halt request
> +	 * is pending and hangs the CPU. This bit is reserved on older SoCs,
> +	 * so the write is a no-op there.
> +	 */
> +	sdhci_writel(host, CQHCI_SW_ERR_HALT_REQ_DISABLE,
> +		     dwc_priv->vendor_specific_area2 + CQHCI_CTL);
> +
>  	sdhci_cqe_enable(mmc);
>  }
>  

