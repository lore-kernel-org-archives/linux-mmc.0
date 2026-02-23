Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400C34F48B;
	Mon, 23 Feb 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839538; cv=fail; b=S7mD7MuLE2emKSQYz5B95G0ZrZcD5kKT7NVW8u56QgR2n/Hoy7mltf3+vakWBinzhqGSiXcJkaIlw+AO1MZ99lHE0L9SWPwQaKTfh49Y8Sfk0dSY+0yUz+h2SLecb1QbhIL8j60uZeuTjo1A9YPhhfXXZfFKTsdZgPNDLRaaPNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839538; c=relaxed/simple;
	bh=y0+E7h0YsUSy6yjK8+/AFPK4KAnGahwT5d9hRclIxQE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+TmMAD2R2Nv98dvkA//hSfXoDTKZaT1oVtDFIN8k2sDQY8oRHk6kVjaWXJfoCclz+7lglMEHmTccdWfiqTgNDEhSrQQHh9sze0PICOi7bSjfBC/9748E0CvR5VI08b44X8XjyINQsvJjtfU3fT/kSgdKbNNV0W1Cd9aLiRVmJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTA6flKd; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTA6flKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771839536; x=1803375536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0+E7h0YsUSy6yjK8+/AFPK4KAnGahwT5d9hRclIxQE=;
  b=iTA6flKdesS2iimPwHV30tin30tsDZHAWevJZ0tj9F5k3tWpPn9qRMDV
   iWNmyiRJhEufigujbcDfR3AGzvXiV/sVRzl4bXfB9+J3a3vv5jXq+us07
   Dw0CElSL2HghLnqq6b444TAFQvc2c1Ks5XaE4KTD8ZD4qOWQgjiUDHTU2
   Vg1o444iPBH7mWkaxuhpwCIXohJwgkRIOhk517e9DQ77SJXXk/4Gsojg7
   BclqvwkdAOYpYNmEuH2POA+zK9i0Il3XKru/2YnaOGMYSldZhrJsjev2Q
   tH+dUvbtp1WwVaJxEc07sT7etCJmu5VTRwOGaC22hcU+xToATe9SJxZBg
   Q==;
X-CSE-ConnectionGUID: eqCq7mnYTIueXnQELGOaVg==
X-CSE-MsgGUID: OP4ktWz2Tf21Jvm7Ef+CJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90236658"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90236658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:38:56 -0800
X-CSE-ConnectionGUID: 0CmG5YiBTxGbinXryorxfw==
X-CSE-MsgGUID: yTrcJHmgQ62cY3I0gpunmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="213472433"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:38:56 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 01:38:55 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 01:38:55 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 01:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCwpinqPBFCZfh5JTkpWH9CR7ZqfBrgX6ZBB99tFzWgM2gMBygKz6YisCjceQERoVeHD4PKZUZe4K/RFfld8TGmUoDP15RXWQ3+2T3wTWgQwmitwZHrEcz+YCdjT46BXKVMdCIj3hVhAT9GFAHosfLjVN14rxOfmtULmxDEX1ARdfYRm98ml68WXijR+4tDtw8D10oJzG675UeWCnXapKKKXm3j0ZVC6dbNZj4Sx3ISAZUn48dxv4zDAhukOw7n/WwfnfLN9p2e+0D0TXL+EblKZd0Rq0p3WjLav+wSmFvcbo2k5FuNI8XVE6ubArOkVpOlvojDXUHL8rtjz3JQJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UID8F4jvjFswt9yxhJ+dP3qNIVdyuyB+RUy1hGaOdo=;
 b=GzQLUVYizaSNpqKfRQkvdmRJLHN6IuLWniG6osJo3wKkR3YTxEkAWpFZEnVj+bfnPnhQ1QnnLyWWDdVS6IPJcmPKWBKEvTqIBgz3PJiybZgdTi88D2zR+6Lb6ru5lMUBi4/FZfCRdELCwD8A66ekbdk4KJiDslOQMZ9IkDJVHS15J/fSLqSvoBfmtUlQtR80NwXbdRVkxUuuhfeYg1lf2q10ZFX1vXwvnLKJupCDJR2v3I4MMJMDvjOLBpCR8n4mdHQAKQAZL3m655uBiEf5ilQBUWs9dCViMdQH78YCWUM8xwrJfwvGNqwvK+6Frnt4vWRuNc6zToKxVfnwKSGOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Mon, 23 Feb
 2026 09:38:53 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 09:38:53 +0000
Message-ID: <b85f25cc-79d0-429c-aacb-005b0ea1aae7@intel.com>
Date: Mon, 23 Feb 2026 11:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-pic32: add SPDX license identifier
To: Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spdx@vger.kernel.org>
References: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
 <20260222-mmc-pic32-v1-1-110382af02b0@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260222-mmc-pic32-v1-1-110382af02b0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0213.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::27) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 007b0536-93e8-489c-8980-08de72bf5aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjJ5dkwwNFYvMEdqYk1TcmxjeGx5emJZTnI4MTVTZEVKVEFmbG03c1ArUFRk?=
 =?utf-8?B?UzBSMC9uTCtydVlhcWUrUnB2amU2Qm9QclNyMU1ESGswdE1QdlZvWWIzWE54?=
 =?utf-8?B?THdnSVUvRFdPdGY3b2x2TmFleDRDN3hDaFpxeEhoaWxKdU5rajhJWVV0cC8y?=
 =?utf-8?B?ajZKNWJWUEd1Qm8xamF5Q21wUlQvanYwdU94ZEhqS0wzVVBpRnAxbnNYWUo5?=
 =?utf-8?B?NkdqQWpQS3lkTFdVd1BrL2o5cUc1elhaYUphTGJicWZKNm5iZTZkQjFFWlNY?=
 =?utf-8?B?MzVFTDlYcmpvMW1sRjZTdmlqWng5ekpvYnhGdUJJN1JWc1JuUkRBWW9QZksw?=
 =?utf-8?B?WVBGOFRkRkFSYzFaWU5CcFdJZTdTU2xlZmhqc0JvVUVQSG9CUXhVcmdRWHNK?=
 =?utf-8?B?bzFQb2pvcWwrZFZFdVcxY1B4MWFTeWpXYjQvVmd1a1pjVnRZK3hrbThSV05Z?=
 =?utf-8?B?N0hSd3lKVUFQK2RUM3NBZ0pZck9tUmN6eWgvemcyNjU2L2dwVnBUS0dxdmp4?=
 =?utf-8?B?VzlIMEJoTE1UZzRmSjIyZmVTaWtMdUU5OEdsWFoxQzFIMEtwSEtrSzZiQmt6?=
 =?utf-8?B?QnBVMUNidG1pZzRqOWdOK2tnUE1pL0EzaFRya1VGSDUxUEdtd1cyNTFWOUpY?=
 =?utf-8?B?NFlyL0kveENuOENxejZlb25tS3g5b0UwdFpQeUxkUWpMNkdweHBFN3d5Z1lG?=
 =?utf-8?B?eWJmMnRzYXVqUGIyVDBBT21YNlJtZEJ6M1JCaC9jRzI3MFl2T3ZtQ3plakFM?=
 =?utf-8?B?UDI4RklITlZlNS8yMWJmeGF5QmR6QUxlSHBZWXZoanVzTmtrclROUlpEWHJy?=
 =?utf-8?B?YWZibWx4aldJQlNReU83bldUS0t2Ym5odytJN2hSWHR5UWkvZ1dpUW10anVo?=
 =?utf-8?B?K0Y4TTB3Yjk3dUFZM3dTa2EzbmpIMlVkL2tac1R6dTRRelg2d1AzVmh3K09G?=
 =?utf-8?B?U2tqR0Y3dXErZDgwL29CM1lrSVBUTVRoS0tFTmdmL0twTzlGRWZUL1oxRzBj?=
 =?utf-8?B?bDNudkZqcGQ2c1BxWkRzMUxmZkhqc2RoY2hiNXg0VU9BakdleGRxK3Nka005?=
 =?utf-8?B?UUMwalRFazlJcnRRbE9kc1Aza3N0TWtHbVFyRkkvdkhGanVja1FKelFYWm1G?=
 =?utf-8?B?clI0SHZJWWlpeXNXWjdqa1o1aXZNdFFGTjhvQjdWd1FKUklUc0FCbkxvaVFC?=
 =?utf-8?B?QnlwWHFrSVd4bTQxbmRncVVRYTBEYjRTRGk2czl1bUN2RHhYcm9nR3BaRE1v?=
 =?utf-8?B?OVo5QjZ3YktWQ1dya0RUSVljZVRlbStLYTVObWNpT2k0TXR5YklwK0JxWmMv?=
 =?utf-8?B?V3VoaElSMFFNYko1VVFvSEZ5OTB5dm02azJrSVRGSlZJUHJtZWhtZGtCSVNm?=
 =?utf-8?B?Y1EwcGlBaTRPalJUTXJ2aXM3YzJiZzQ4Z3Y4akp4WnFDdXJNMW1oZG1lK1dw?=
 =?utf-8?B?TFJacXlZN0pNMHJWSlE5ZXBLQkZEVVl2bFNlNkdyOVAxY2RXa3VULzUyZFlP?=
 =?utf-8?B?MFpDYWlDR2xORjN5eS81UERib2VzeUdLQmYwRzk0cDNJbFdpdy8vb0krVnJC?=
 =?utf-8?B?ZDJDRDZlVDNhVXVDNW9HWEhpQmFCajZ3R3BZNzAwa2U1WVRPK05udWhDVllq?=
 =?utf-8?B?NG5MeUFzcFFzdTZ4Ri9jM1E3eFVLeE5ra2FHV0x3dnhIREQ4dzRKZlBpbUFl?=
 =?utf-8?B?enllS1J2bDBQdW40eDUxZWIvRm04R3VPVC96eFhSaHZZNDA2UzNzQ3UwTllM?=
 =?utf-8?B?cUp3RmF2WmJaWXlkajVwQWR5M1cwV005SFBzM2M5bEJVZXpHQW5LdVUrNFV4?=
 =?utf-8?B?OENycU9DS1RDU2FjaE1qbFhQNlh3a1VUcXJuY2laL2JwSFAvYUtRa3ZCZ2xs?=
 =?utf-8?B?VnFQV1lDdmJaVEF6Q2NWYTUwTjZUM1BSYXJsVjBsYmZZd1lwRFo2ek1yM3B4?=
 =?utf-8?B?ZEZSM0VjbU13MEZObTNrN3ZXU1dSTENZUzkzTVVKSFNFWGJKS3ZMVjlqVGtU?=
 =?utf-8?B?KysrRG5sL2YzWXVod1BrdFEvT0RRbEh1NTRmQmFMTFJUODNDM1VZZkQyOHJp?=
 =?utf-8?B?WVN2TGVuUXVGc0ZGaFMxNVFEWEhKaFNlZ0c0QXdKMEZOMytEekYzK3ZaYURX?=
 =?utf-8?Q?wZyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFSV1cxUEswRGNRUWhtT3l5dDliMUpvUXNwTitOSFY0RkZzQVczQ2lnbTRC?=
 =?utf-8?B?VXd5NEZ0bWd3dktXSHgrVStKc0R0enh4QTN6elRBZXdEYzkzS2JUSWMydWwv?=
 =?utf-8?B?T0hXeGVFd2Y4VW02Z2pidExEUHMyNDhMNTBIcDlNNXRGck5BVzVVdFczblFT?=
 =?utf-8?B?VVB2bTR2UnJvY25BcGJMT25sektoNVlLbEZBOXVrcWxqQS95b3E1UEpLcFNX?=
 =?utf-8?B?SWNnYmRTaGhiN1ZVNVZnU3RKK3IyNlhjbGpKUVU2RlJPNWRaVllvK3EvRTdy?=
 =?utf-8?B?bDBoL3RZQ2l5YTIzcW9kYms2blFMY1ZiOW50Y1NFOVhJZ3lDcXh1MjVBOTJ6?=
 =?utf-8?B?SzdkNkN3WWFKalB3Z21lNDgrSEk0U0hXMHN4czlTQW9PMCtMSE92Slo3OXZF?=
 =?utf-8?B?cDVQR2FMOE1PZmlDYzg0ZmozNWs2K0RUQkU2aHMwNFBqZ3ZqcmdpdnhhNksz?=
 =?utf-8?B?a0lmdjVUMTJ1T0xzNGFuRlVNV2d4bEt6aXJSWHZCcHBha0krZ0FXSUdaS0Vk?=
 =?utf-8?B?ZG0xRDhmcm1sV1QzbWQ2cVozN2EyVDdobXM1ZjNVN21qTGhCd3hKREJQajAr?=
 =?utf-8?B?bTdFNGltNU5rYmZzSnZPRjZYNy9lTWVJUVplaHpleXNVMlZJWTdpZzFsZXpo?=
 =?utf-8?B?dHA2YUhTbjk3L2xuN2UvaFNGa1BIZVZTdnEwYW01TE1FSUdkTzVZNUxoWUg1?=
 =?utf-8?B?bUFGTDlwVUw4UzR2YXRVTzdsM2lyRzNYVHpSNDFZd2FkTUVJemJlZW1aenhH?=
 =?utf-8?B?ZUVab25ZbDRuTXM3VjBYVnJPOU9kUStoelBtQWZnRFdhUUdUZ1dpdVQ1azRO?=
 =?utf-8?B?Y2F1eVFYbEF2dXNwSEZ0YVo3SGR5d3BONjdsQ09UcTFhdW93a0V5Tk1hbFJB?=
 =?utf-8?B?WlRIQzEzekxMSWtQK1cyZ2YzbUg4eUlXM05OSjJ1UEhUalpEeWphTXZlY01F?=
 =?utf-8?B?V04xVEtqYndITHdUamdhdnUrbmdISUpiS0JUS2JWcm12MzhBOVdGdkM4VjJL?=
 =?utf-8?B?WDY1ZjdqRDZJU2IvbU5GK1EzNFJmMkxuU25jSW1FUmNtZ09VMjRyZmdNS0NF?=
 =?utf-8?B?ZC9ITVJuRTBGdEJTRVVLSUF2S1k0R05sVUdmSllibTIwVDRqNEtxZDFZQ2J2?=
 =?utf-8?B?WVZGVXp4cjNORVdkWm95TDFaM09nUHlwU09WK2hOL2JaekN1ZVF1UHMrMGRF?=
 =?utf-8?B?MWtkL0gzQytJL2prOUtHRVR4VEFPVUlCRXd6R0x6NXNmekRKK3VSNWpodnZF?=
 =?utf-8?B?Q0V2WWV5N0hIODhsQk0xZktFRGdhWStqZVJwN09JZEhTeTZLSVhUa25yYzdU?=
 =?utf-8?B?V3RxRjZiK3ZDOE8xeUVOY2h2bURiNkNTK2paaEtMSW8xWFE4N2N4bEozRGZB?=
 =?utf-8?B?OVNBMUpjWTBXOVZ0MUl6bnZNcFZwYkZaY04rd0JOVy9HL2tSTytPUVFlSW9G?=
 =?utf-8?B?S0FMaXhBUUl5R0l2Z0Y3c1phSkFIN3B0N2I4RTVBeGVSaTY2ZnIyaFp3TlQ5?=
 =?utf-8?B?T1VBYStYRTc4RDNoekg3alUwVHBxUGt3NDQ2ajVNS29Vb09IbXVBb0dBN3Ra?=
 =?utf-8?B?dVBnM0NXR0lndjhlNDVPM3RoMldNblVFWEcwK0NlM1c1ZHFvMURPKzlaNmpn?=
 =?utf-8?B?Y2pWQnhQM25TaEZyUERvdUM2TGI1cDUwWW1tWDRxZk92K0ZsWUI3Y1dlTkJj?=
 =?utf-8?B?UzZzbXlOQkcvbFZqMnJZdTQzelRTZzQ5d0xndTVPaFpOTlZ5VDRDK2JzbDA3?=
 =?utf-8?B?Z3ZYUndPRTA2bm9CRnFGRGZ0c05rQ0ZFRnNPWW9DMERUYmFKNjRJdUwwb0hG?=
 =?utf-8?B?QjRJTGl2UkRUYWhjYkFlUkxTKzZoRmRLY096Z3pTa001amtmb2FrYUhLQUxP?=
 =?utf-8?B?MzNudkVOTFdnbnczRHZ6RFRXMHNBVy9IaFl2N3J4TXY5N3Z5b0htZUJWbnlI?=
 =?utf-8?B?U1JTYm5qSjRya3JZTm1JY09Ya2pwcTQ3c2lkSlVsdG1LdS9GbkdiRzV4SHk1?=
 =?utf-8?B?cllLZ05vakNLUzExYzJCOTdKcTQxb0czVWxaT1VjRGpFS0FoclREMmxQRGlC?=
 =?utf-8?B?L1FYY1p4L3J6T2dGOWp0ZFdtSktCWlJHczF4QW9QVkVUS0ZydEJxbFMvWEtJ?=
 =?utf-8?B?SmdpaUdtLzNHRHJXVWJUeGplRGVWbTdOWTdYYnY2T0Z5Y1g4aEw1U2FHa3c4?=
 =?utf-8?B?V2xxdXVYend6WUxDVTQ3ajRtSDNBbDV5eWVESTNUMUNsTStLV2lXZElXcmZh?=
 =?utf-8?B?RnFXVDE0Y3FKVDRKTHVTYnhkcnFMUEhGV1lYeXFhRDJjdklINWxSM0kyK0RL?=
 =?utf-8?B?ZklQOVQrNzl3M091Y3dXZ2M5bTVZRUtReWFuc0ZZVEtTa3IyaVc3dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 007b0536-93e8-489c-8980-08de72bf5aef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:38:52.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfpU3sqQ34HAQbSuwk2jj0fCqMT+8zyVHFWc4p/j74nAVv/p+JJ5/DecUy0GOC9yNOSz518Wvz1NIB27dl+2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com

On 23/02/2026 01:39, Brian Masney wrote:
> Add the missing SPDX license identifier to the top of the file, and drop
> the boiler plate license text.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Cc: linux-spdx@vger.kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pic32.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 2cc632e91fe454bf29c1da22e45135d5d0267f54..6899cf6c65e7df2461c9534b51b8edfd0d6bf7d9 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Support of SDHCI platform devices for Microchip PIC32.
>   *
> @@ -5,10 +6,6 @@
>   * Andrei Pistirica, Paul Thacker
>   *
>   * Inspired by sdhci-pltfm.c
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
>  #include <linux/clk.h>
> 

