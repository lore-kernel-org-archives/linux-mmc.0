Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F610F1;
	Thu,  9 Oct 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000557; cv=fail; b=YBeB2hCS8Y0YAQKqzAKWDH0OHqmY76TrZnf7oun5XGsgBI34smlPUE2f/ZCm/FqF37q/F+Mt1iTvkvPs1pVSpz1+KiPz6dlRC2MytKRgJ13K/WdgL8ALdlX/5Z5J+CeXGX68eBCYIQYiUpWDJ/qUVollilZw96E3DEulYj18JI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000557; c=relaxed/simple;
	bh=cRnoeq2xZlAlkNwZ8zjboScSPQGUVwN4cMGBfStt6mo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5usF/4J1sydN+V7fc/Lgt9DYHDKw4aYIFwWEUDA/KI83yVrsWmfkX2iAT8S/Ysk3Vf1pnjH49JVvnmQs+iZleMNMXJHv+eb4GUZ8lY7KGvvbAXnu1Mr2ANu+nLkUtclemg6+x7c8lJCGqSgNTIl21x1urOJZh4yD0x+xj/zX2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnW/o3O3; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnW/o3O3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000556; x=1791536556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cRnoeq2xZlAlkNwZ8zjboScSPQGUVwN4cMGBfStt6mo=;
  b=EnW/o3O3QWLk4I0pQZE38jnLNalo0RZl23SipnG5WwJgXs9OOATR9bvN
   rijcfh16GnGsuY7ONLLFSzCdanF2ObVj8v3rJFbrBv6dUl3QODFxYnnzL
   msZJ8KazNdXSR0LzaKXdd0cLxLI31PqCCw9E+eYgVE31FfgQnRB71B3w0
   MZBus4zPGHgRvKV54HbtpaIDOl2zhg2tMaHv1DXHtqQFOaopYqSNVPT1c
   wZ/VPCmHQCBB8Vu8RwreWNyqP4SnIo/aE0miJlPO5YRgzySCWhbJbBida
   YdGxqlXvB/MolFw/wTGYHBg7cryxk/YG07unGagZGoz1jziYkvVceRHK5
   w==;
X-CSE-ConnectionGUID: zcABlmNzQsqiMyqJqdji+g==
X-CSE-MsgGUID: KdiK+T0ETwiCsAfP8mn0MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="87664814"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="87664814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:02:35 -0700
X-CSE-ConnectionGUID: 93fnPyUyQsK1LT11zLx+Jw==
X-CSE-MsgGUID: L4VMh7a8SBemJo+Yu5YMgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="184694485"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:02:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:02:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 02:02:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yav1OvSDedHD/MINIIxdmaIyqIz8kPk4p0NQYlDoodbdnnhsOpufbECdgy5IFoteV/tsUXCizj6550di55dxVEEpcxgRtTnqkLUP5X7idSR24P0ZLF1p0m657zoP8NR3C1wEXIBiBRJTWkFJ9FUdKA/6QSDTDMgiFwYkSe3VjBBrrhD9pkqXRLJrcYfXmafZM/3p3/bu2v6QWNPz3LM7SUtWUzeTDN5yP+PKInytn2VDNKe3p8vqz33UFA5Rj9CuBdMqz6dzaaN/XGl6rOXfs+N4iZcyybuR7CFs6Ff0dI9SXkG4GjuFNqzl4lH5u9z1IjM7gf8KFDvGqz4dJJF9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnEzR4yBOlYaPPP7CW3EyAucN6liPpKKNOwpJw76noU=;
 b=XQT4lKGjNiw4VVU+8cxYn8OxHRX1JTgbUvHkAYU/qOo9QpCuJoZdwEFo/mvNQjOiG7uo/H5KqHSUnkEoZXW1BXRl03xJ4YA55x0RNrEY6rUwiRTLzyfhxUmzZKzFU7V9ZyWEO1GTaPpUdpwir0o5fQPBqIIBhilTUFWlaUrvVr9jFCHhEvesmZHo59Tn1w5o4mTp/5/OToXskcf0+9PWkMnRsXdKjGOCHWxca5eBCO1nANSV2bqbckR+AAmoaVvFPPqwewc+jOhpBDsGWPRJNkgB86Qe3MCv/+2g5+Ez/0UfCMd35tCsBITCB/xZkN2Ll+VVh34V9uBJjiCnpoHjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 09:02:27 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 09:02:27 +0000
Message-ID: <c8b554f3-7d55-4449-8f75-2dc2ef1de978@intel.com>
Date: Thu, 9 Oct 2025 12:02:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mmc: sdhci-brcmstb: save and restore registers
 during PM
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
 <20251007140434.606051-7-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251007140434.606051-7-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b60162-348f-470f-bce2-08de071291a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTQyRDV4Q204TVZ5RThlcmJqRndnMkRBc2toc1VLVVA3TTF4Ti9hWkFueUpQ?=
 =?utf-8?B?akNLSXkwcHVIc2J5QVRoMk9Tdy85RXFqZWdvOG1HYmtvRnNjbkd2ZzVaYzRI?=
 =?utf-8?B?QWg5UmJGRW94NnNvMVd6NEZycGxlZWhlTzc1em9rOVdmZS81Ym5lSWhGc0Ra?=
 =?utf-8?B?US9tSG5HdnF3ZXpPdGZaWlRaZHdPVzUxVStrd0VXcis4eGYvWDg1UGFldGhy?=
 =?utf-8?B?dHBRNTJtNjlEWFc5OXQ1RVZ1aTZpQTZqWGdLMW9DU0toVkpwaDZNQXhhbitB?=
 =?utf-8?B?eGlOUkxuRVR3aTVVRVRoYjdtWVh2ZUlibHpZNUpFSVUwTm96cnFkV0VIbTly?=
 =?utf-8?B?bXdDWGpMQkdoT3dacTQxdE1UemQ5RXA1TFkxRWJhVWhMa3haWGFQV0NnSGZ0?=
 =?utf-8?B?QTFwU1MyaTNUdU5LQnVqdkF5MWg5UlJieHdRL20wRU5BT25idjZqWFROV09U?=
 =?utf-8?B?U0padFMzTS9EekdTWktLM3NkZ1hhcTJETjB2RHpCVXFWTHFDeDRUcnhnMUlv?=
 =?utf-8?B?WWtHWDgzMkVYS0hsZTFCNElEZlNpYVdJLzZodVRwbjFLc3R3MnRnNXIrTE1u?=
 =?utf-8?B?SkJCNDJmcXZSYzR5WnhnaXNuOVlsNUNSM2tGSjNYcGQ0cFF6MlpNdWk3aGpI?=
 =?utf-8?B?TFlhb2g1ZWJCUWs4eG96UFVIRXFCSUllNmoyZlpJbm95dEttemdPdzJFeitn?=
 =?utf-8?B?ekZ1Q3Y4dnl6WFFiRHptNDZ5dVc0WGNYZlpQTkdoSGN3eDZKdU5jOGdFdFlx?=
 =?utf-8?B?Qm1ta3hBQWtMbXh5K216RWRNRFFhMmVlTzd4RkNVMzN4YnNHVDNjVGRrRU4x?=
 =?utf-8?B?cDhLSEhnWmEwMlBEeUFSZCtrZTl3TDJNQ2d0K2Q1aVRvdzVFbjhBL1p4aUx2?=
 =?utf-8?B?TjRId3UxSHE1UmNjKzRkRzc0dWltT1lTVTluMlFuVkJUNDhTTzRVNnlMdi8y?=
 =?utf-8?B?emUxZWlIWlFCYm5WelF2bkpTVXRFZTc3ZjNKYlVOZHlyS1FPS0E5aDBLRTE5?=
 =?utf-8?B?U09RMFZuckIyY0t4K0xqWTA2aVZFMFBwaW04SUhRVjFNNUV1T0ZUdkt1RlhC?=
 =?utf-8?B?aW5rZTdqWlYvV2ZoVXMvOWR5VTRsVXl6ZHBhQk4vV3Axc0ZFVGpCSUp4cTBU?=
 =?utf-8?B?c2UyREtaUzMrZ3lsa1NwSks1aHhjdnlWZm4xSDJNb0h5c1pncEpWUWkyenNs?=
 =?utf-8?B?QnA5TTBZNTJ6RndtOVR5SDlCTUdaRHFnWnhOWDhONHIvS01rUWd0aDFIaU9t?=
 =?utf-8?B?YjR2cTFBQ0dkY0Nwbng0L2pvMDBOUzh3WUNNMElrWFlMbzIvYzQxRmJQb0Vq?=
 =?utf-8?B?SDdGOWJYVnB3aEEyR3Zud0dWWFRxZDlYR1FCY0EwWm1nMjVBK0crSDdVN3FD?=
 =?utf-8?B?a3c3WlFtS3lrT0ZsWUlPS2xqKy93OFlVckxkVVNPTTRna3ZnSEE5TXhZTzg3?=
 =?utf-8?B?b3pLQ2dpbk1lR1FTYktjc1Z1eDF1M2JKK28wNlpCMDJpZHBKVHBXOVVWUjFh?=
 =?utf-8?B?SGgxTGROTi9aWWJYakdOd01jeFdwWGFISWxlMXRabmpXM1hxK1M3Y1lCbHN6?=
 =?utf-8?B?WC9DS0JaaWU4RXI5UlRMc3ZRQm5RU3JjNHJVdzVQWVZnUmVCUzBaVm5YRWg4?=
 =?utf-8?B?YTBod1BMT2JsZkVKMlV4dCtJRDB0QUJRbHZiVVpLRThYNHoyOVJYYlZVNzEw?=
 =?utf-8?B?cWVDeEo3bHI2QlM1NUFvMjhHdjBDSjNCUDBHTXRESDc0K3BZV3Y4NVlKZ3Jz?=
 =?utf-8?B?WStwTFRxdG1iZ0xaajRzQUJuVGcwbTlCOW13VHlmb3N4OHRaWFR3b3MzRGhp?=
 =?utf-8?B?dkdpZXkxL3U5Q0VKZVl2VTZNNnAvcGxXYXdsa24rbVEyRFNRaUtYaWVOVk4z?=
 =?utf-8?B?NFovUTc3Vk1vd1ZGdnBFOVpZWUVkNUFkT0g2Z1cwZG9rQ0RPTVRiUURGMjBE?=
 =?utf-8?Q?80iYhrBY5yYf5k4vra0iBCe+S+bfjtWu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1l3TmlscE1lNXpubnlSekpaWUc1a2JLUlZNUjZiclFRSFJsbktVVWF1NFNS?=
 =?utf-8?B?TWE5MHhDaGcwUUFOQTRxenU1MnlPK3BCWXBBWVE3aGpxb1NHcVV6NzRrMURa?=
 =?utf-8?B?aExSeERwWUNJUnhxeFRvNjdQMG43NDBnZ2wwUWM1ZEx4VWJReStMcHd4LzJN?=
 =?utf-8?B?OHRoczV3UndoWWphM2dQODc3UUQ1Zy84OU40ZWNhQ04yQUhRc2J0S3pUeHlJ?=
 =?utf-8?B?U3lxYTNZTWVsNkdxamdSK2oxR2NmQXdReXYrcDRqMHNPc1kzTUdhUTNGajB2?=
 =?utf-8?B?aGttU01naDVxcEljdkVIRWpNQ2diVG9CeXNKZ0szVGUvSlFhc09NMHlkTUps?=
 =?utf-8?B?akVzZVp1bXVtay9LWWVWM1c1Q0tsUVU3WDNYTjdEOXJSZmx0T1VBNHU0Y3Rp?=
 =?utf-8?B?NEFlNUJXNDFLTkFHRGczMGg2anVxVTVTNXFrb1R3WTBxSEhsc3UrT055cnJX?=
 =?utf-8?B?NDdqbGlhc1NPQUFGaUl0L0U0TGY3dnc2VVZTc0FyZExiTWVQbnVQcjR1UVdS?=
 =?utf-8?B?R3JMOGtKdkQ3bnIwL1U0TTVyWS9raGpKSnh0eGt2bHViUXBkUzJWTWFEbnZZ?=
 =?utf-8?B?K0tobGwwYjhTbDE4UVc5Ylk3cy8wOHRZWjdKWi9OVldlb0tzSXA0Yzd0RTNa?=
 =?utf-8?B?YnZaTmkycTVHdlVmL2NiNStvdk1BRDhvWTVudW5na3JSRWkyWGZ5U25VeFdR?=
 =?utf-8?B?U3lGSHRiMDJpYk55dGFqZkN3YmN3ZDhCb09KblBLbDVJdEZEUUQxMmp0NE5H?=
 =?utf-8?B?VXpzcDNLckRLVVBhNXRvN0JrbE5wSUtRWHVwK3hTQ0VWb1UzU3RtcWxLa1Fa?=
 =?utf-8?B?V0RHazVCUDhxMEdPMjVWMnoxaWIwdXlHZk05ZUEwRG11M09nc1YxclNKS0lw?=
 =?utf-8?B?UjkybGtWdk94NWJLMjNJLy9XNnM3eGExU1dXa3FEWGVURE1wc0JzRzZ0R2FR?=
 =?utf-8?B?c0piR2hLUTBrM2I3VnZWTjBqRmdGTU9hbjZ3RDVrbG9rTFhiSkhLcmNxUU8r?=
 =?utf-8?B?TTdWUW1zYWZoVDZ6c1FWWS91MWFTVjVVV0kyelk3RTJLUis5K2lFN1Q0WHQv?=
 =?utf-8?B?c3pVRFlhQ09ySG9zaVNIVm82UjQ1djRyWUZPRURjWm9VUXIxZVdGb1UrcGlz?=
 =?utf-8?B?QS9xLytsZkZMYVh1Q0RTbHZiT3pVUEpLRWxCZlpNcHZ1NnZmdXkvNkNnd2tJ?=
 =?utf-8?B?dzl0dncxTEZmcmJqZUpkYWRsaWFMUXFiVGs2L0hka0ZzUzNDVkd1Ykhvd2pn?=
 =?utf-8?B?OXo3Q244NkZ4dmM4Z2MybzJXNkpWejZKSHBYM3JJM1FVNmxaSFB4K2t3YkNj?=
 =?utf-8?B?UlZaQkJKai9rR041cXJMV3pRd2hUWlg3MWxsWnArQzBXSGs1WVpNaTNiZHQz?=
 =?utf-8?B?VlU1N2RBRzFMVUxEZmJSOHovQjRFOGkxdUtyRE4zYVo4V213WFlCYWtFS0Jx?=
 =?utf-8?B?dlpwK0hIeHI0VWtUUysxMi9LMUpLeTdDQVQ3VlJPZ1RseHhHS0FoN1lJN3FU?=
 =?utf-8?B?L0Nzay9GZTluNUJ4bWlVZDFsbUNqcG1iN25MdnhnZFRCVVlzcEMyQmp4U3ZF?=
 =?utf-8?B?VmFTTU0yNXgvTXlKZEdzY0tYaHR4SXprRXJLTklBYy8ydElUYzNKM21hMk5J?=
 =?utf-8?B?TlNCbG5CZGJyQTBqbjhZRmNjalZkL0xQY0Q0MlVuSnJXTnMyemNFbWtQeEt6?=
 =?utf-8?B?NU1DR1NOYUtNWDJTenhkbGd3M2lGTFEzNXlSWERnRzhUUWVuSEFmTUxMUlhZ?=
 =?utf-8?B?eUREZ0JuaXErSEordGorcU1KU3ZKWmF6MjFpUmM1UmRzUTlVN0syT1ZtM3lW?=
 =?utf-8?B?Vi96aGtDSllLUjJpb1Npbmp0YXRaUmQ1Nzl0S2hCekxieTVZNEZBbWNaVm50?=
 =?utf-8?B?SlFCNWVxMUVkTTlWdEdiTG5aWHp2dnd4Z3dkVzZzUlpNUm1QUWs1ZHlUNjNS?=
 =?utf-8?B?V1FsOXNNZkQxNGxnU0tRaS9RSkNqNEJCeTU4bDBKYWYxVEJrelgzU01LVFp2?=
 =?utf-8?B?SmJOQkZhTUZ1ZC9PUDNVaDBkR0ZjczRyckNpSUlBd3BOUmhKRkw4T2U2YkVG?=
 =?utf-8?B?OEFtNEZEdUZxNmlYT002c1BQeFlab3VsemZFR3I5bTU5NXB6dHE0c0dLVFZM?=
 =?utf-8?B?aWFCT2RTbnhNdEp3c2E4Ky9aTEZnY09sdnhhREJYKzI3QUh0djg3RGpSbG5K?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b60162-348f-470f-bce2-08de071291a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:02:27.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAUQtbmsRjI6uj4j4JEcvi+FH8WrQGvjpympkA1SptUbJuAZQsHHZZ6Bu/C4NXW14DZpaVCr+rPIFYK1+ypMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-OriginatorOrg: intel.com

On 07/10/2025 17:04, Kamal Dasu wrote:
> Added support to save and restore registers that are critical
> during PM.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 112 +++++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 42709ca8111d..7de395c86f2f 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -38,28 +38,109 @@
>  #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
>  #define SDIO_CFG_CQ_CAPABILITY			0x4c
>  #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> +#define SDIO_CFG_SD_PIN_SEL			0x44
> +#define SDIO_CFG_V1_SD_PIN_SEL			0x54
> +#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
>  
> +#define SDIO_BOOT_MAIN_CTL			0x0
> +
>  #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
>  /* Select all SD UHS type I SDR speed above 50MB/s */
>  #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
>  
> -struct sdhci_brcmstb_priv {
> -	void __iomem *cfg_regs;
> -	unsigned int flags;
> -	struct clk *base_clk;
> -	u32 base_freq_hz;
> +enum cfg_core_ver {
> +	SDIO_CFG_CORE_V1 = 1,
> +	SDIO_CFG_CORE_V2,
> +};
> +
> +struct sdhci_brcmstb_saved_regs {
> +	u32 sd_pin_sel;
> +	u32 phy_sw_mode0_rxctrl;
> +	u32 max_50mhz_mode;
> +	u32 boot_main_ctl;
>  };
>  
>  struct brcmstb_match_priv {
>  	void (*cfginit)(struct sdhci_host *host);
>  	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> +	void (*save_restore_regs)(struct mmc_host *mmc, int save);
>  	struct sdhci_ops *ops;
>  	const unsigned int flags;
>  };
>  
> +struct sdhci_brcmstb_priv {
> +	void __iomem *cfg_regs;
> +	void __iomem *boot_regs;
> +	struct sdhci_brcmstb_saved_regs saved_regs;
> +	unsigned int flags;
> +	struct clk *base_clk;
> +	u32 base_freq_hz;
> +	const struct brcmstb_match_priv *match_priv;
> +};
> +
> +static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	if (is_emmc && priv->boot_regs)
> +		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
> +	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	if (is_emmc && priv->boot_regs)
> +		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
> +}
> +
>  static inline void enable_clock_gating(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -306,22 +387,26 @@ static struct brcmstb_match_priv match_priv_74371 = {
>  
>  static struct brcmstb_match_priv match_priv_7445 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
>  static struct brcmstb_match_priv match_priv_72116 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
>  	.ops = &sdhci_brcmstb_ops_72116,
>  };
>  
>  static const struct brcmstb_match_priv match_priv_7216 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_7216,
>  };
>  
>  static struct brcmstb_match_priv match_priv_74165b0 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_74165b0,
>  };
> @@ -429,6 +514,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->match_priv = match->data;
>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>  		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
>  		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> @@ -446,6 +532,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (res)
>  		goto err;
>  
> +	/* map non-standard BOOT registers if present */
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> +		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
> +		if (IS_ERR(priv->boot_regs))
> +			priv->boot_regs = NULL;
> +	}
> +
>  	/*
>  	 * Automatic clock gating does not work for SD cards that may
>  	 * voltage switch so only enable it for non-removable devices.
> @@ -536,8 +629,13 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct brcmstb_match_priv *match_priv = priv->match_priv;
> +
>  	int ret;
>  
> +	if (match_priv->save_restore_regs)
> +		match_priv->save_restore_regs(host->mmc, 1);
> +
>  	clk_disable_unprepare(priv->base_clk);
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_suspend(host->mmc);
> @@ -553,6 +651,7 @@ static int sdhci_brcmstb_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct brcmstb_match_priv *match_priv = priv->match_priv;
>  	int ret;
>  
>  	ret = sdhci_pltfm_resume(dev);
> @@ -569,6 +668,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>  			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>  	}
>  
> +	if (match_priv->save_restore_regs)
> +		match_priv->save_restore_regs(host->mmc, 0);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>  		ret = cqhci_resume(host->mmc);
>  

