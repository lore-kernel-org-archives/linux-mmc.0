Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515383;
	b=nCj3eN6P5d9dQvQQzSqjIFakPzHQiCzZRG3os/Yq7fWWC8v4PZn3W9nICNEHo+UtCWtF
	 SBbzTNdNKR8yrXADeGEt2kJMiFx7UGvJpE9/5r91bSBCJJzwamsV0INasW3QsSiNpo3OF
	 icOEWFtE7llUGZE3ITIPAGOwaqt1+L9/aOXf9aDgsb71hpDGsc/71UaO0RZQIcQ8aRObY
	 I/HjzE3UvW9m71RYLQR/H5Q+pOT0NkHqflqN0cVIPs45YblEV7/x3J9yQFrsI/phybGzD
	 wLgqmYJOdPxPBu+3v3J2pfwuMypLzXfo+BHFkDtRzPrPkB2S+jROdcWLvsSqAMp4+xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515383;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=GNA+5vKlRNfyH5aBezcR+7Sk/HJcWvFv/AuHlCsjgHY=;
	b=PfCJCiROjyu7X45K6GXpy1aM379YuW7EXLL8eo+qLRgiU1jgVHrXAIOFcQcA4FfRSGLj
	 dHdF0WNmoWhdXf22RYoc55aP4z5VpYYddSSNI2pIJqfrHPnFAb+AJp2uW6dFofoFWyXoI
	 U9JLBU1b8p02ZTnxaLyPdfOzc1dEcPIY6XGW+l6WDSdP+gFdmRsRLaLWn5gGpcxVBEN3T
	 IaX2fpmXCMpCFC8LEHuIrZSKCFlA2EawbeIF9wwnfY32BXRsKBJ6WkiJgDN48bfwyjADN
	 2q4eaHkL0fYIr10abqwsn7hldieaJM5BGmjX6W/azuVSK5Cw0GSHiRDnUOZ1vWEG/GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLtWbXky;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QEVkq0P3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F5606A337;
	Tue, 24 Nov 2026 10:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0F5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLtWbXky;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QEVkq0P3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795515379; x=1827051379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0+1IMUDdBi4euSjg/Nk7rqrgOLsWf4wHNo+bAokWEpw=;
  b=hLtWbXkygk4yQdAf/zOUZoAmN2ZgFVTOstOQHQCXhIxJFQbxVWh3PAJe
   2RxHDD4YS6XLXkayYql18/vzoHBalu3fmSC3Tgnyn1ksB6I6NaLe3DC2b
   HihDW5e7jVF3RYv0EH449KRVYHOCkgLxpzpc3pbFRm9HKMPAS5DlrN6rP
   oXJl/RWQ4wdCYFEevX9dvZ/XjyNWlvx6mGO9OJbUdzgbKPOwXFEcQ5210
   kkOOb+0F4gx1WZF9+nOSn2V9HND9jBQlA/19TDzghpK14LwoTwf7aF/ZI
   xVEVKaH8n1IcMZhpZdVkKjJvuPY1olOk8hk1J7Tv7XocWAkh61VW6BPdg
   Q==;
X-CSE-ConnectionGUID: tF3YjS5lR7GAsq/rjzVdLg==
X-CSE-MsgGUID: d37LvkFNRn62Fl3AcstCQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4434299"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4434299"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:51:07 -0800
X-CSE-ConnectionGUID: X8Qwsd/JRyiuwoxr1NyVIg==
X-CSE-MsgGUID: 6f9UCVjVRVCm7WSnRh3GOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11958298"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:51:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 01:51:06 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 01:51:06 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 01:51:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfDsrQV1bgxephA8aTyH0kXJucHPjkFJnPdZ9zm/0pFq2id/QamnexuroZWTv1xCMHQQAoG8q94OXQPUeB0aBuym2s5y7vNIzggh7Ix6iJuvqAaiaCv658+NA4cacJM8g/LB1bXaieZTCqXnmbrxIPROp7C5LI4f+4GazoYng91hcbd1mtoWill9YyCFbx440lQc2YGfvVd067uI6Uxt1wdj7TByU0KkIg/wjSOAjKTFY6QSaIqu53oHSElaJ3HA3dGPCK2TkBU3goBvN4uY+wkHREc4IS5xKzgGDZAvQ099B6MGjo35GEIk2yBYRcpeuTZg7JMHrsjBagPjVb2N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNA+5vKlRNfyH5aBezcR+7Sk/HJcWvFv/AuHlCsjgHY=;
 b=JiyE4C7csmqap/M/tgevcLzjFserSkwAs1yuSahOD4t+hUVMyyOLROjULQMYwGo4zJY6sHQWF/kl9/FbXMDSp6S5QmgYvR5d2t37HecXSXv6Yl0vcm+7hr9NV//R4zr1MNlbp0yLXPLO32I+6MjENj/xfqQ1br/z74PTC5KvRXB/3+Jm0o8A5HcFe9UXTo2/6c/nmt4S1ZIf1bipyrtqGmHOTB4GzgIuALdZOUuDKQoVFJPYdhtjZZUs5y5T0Q2Lam5yuYA1+HhWQ1/5mClvLX2nm3a7xE2ljbYHpW0Jp74ds64Q8k8Pzd1/AfkuHCRheeuWwhHjPytMqjSAKbJTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNA+5vKlRNfyH5aBezcR+7Sk/HJcWvFv/AuHlCsjgHY=;
 b=QEVkq0P3kJYubBMtEmPnFNr6KaVTRV0tfi+yGQz/2GQhsmDpWQ/J6KPgpZil7k1m5SaxIVsnrL0aga9VoQ66ATlqn29vkOD7/+g13mlV7R7zvw70mWBmj35aN61ImngoEIn4WxwIVkBifJ+Znhq/V8oVlCi7dz41oxQtYOEG2v8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 09:51:03 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:51:03 +0000
Message-ID: <a3fd82c9-4c71-4b7e-af62-8381110b0a71@intel.com>
Date: Tue, 24 Nov 2026 11:50:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
CC: Ulf Hansson <ulfh@kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <1f6cefa9-497c-4803-a027-81e84f6a6e9f@intel.com>
 <20261124074000.1387-2-laixiangwu@cmss.chinamobile.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261124074000.1387-2-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0345.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e89a011-87e1-4709-59e9-08df4a1073cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261022105027099003|261026140227099003|261028144727099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DR3TRC6x9u9D4woe1rydkQeAzHUGKW2nZeKamPgvp5zkaru/GpTgZYL8j+MmiGkesqiVR0T0ToxjhAYcQJ4wLZ81XWd3vPC0SIjmfh4OISDL1X66ApFuKqVFsaPUFsFoIVQtWs0CNLp6A/jeW8PeUBeraNQdG6Di8JyMgAkpctQEJf6RKgVj42LWorUMObSZa1Th9T9TdYUVZu0STj9hBMxP9n33wqB/slsWN3ut9WstXKjrLr+6gVuLSV5otxlavcsucb9TSQQ1JA7cZvgD3x5qm2EJ4/vrFf0iznDnbxiA8BtCyxgxTcezcw/IpLq60og0V8CMn+rI4XGAvuY8TJL+WrJ1AHmgtGaNP8xrSo0z6sjeKl+VINWlXUs9KR4hqMT3jEZI/JS16hup7Ce8tO+XKmSfEQLNqxBOxF2w+19BxnZnQOn2V7at0KNjrCSNUulIfn/7llMRWQvjVWptxD3C77AMoutFGQ3MA/PyAIqFbWtd22Tvw4VOIAaqFH7FVSQ+jknKeY848iJQCXKxjtd+bEOi40CWWVYADV4WEbaCHA8uyRH55oHYKX/uJ9qQbh+N07dnEJxnLwMvEuIer4g1huDnRleQ3ZnSd6kFYgAG9t+yh93/a+u+rZwD+/hx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTB4UUV4OVRJUFlVVFg4SXB2RWx0MkRkdFVGenRobGZFMVdoTVFSZkJpTVg4?=
 =?utf-8?B?MUorMDdKVkdvQXg5Wmd2Mm5vUGtYN0pnbTNlUW1Vak5VOWFFNDFDWHFQWGVk?=
 =?utf-8?B?VkZKc0YrZXRuT3ZwRXVYenNuUmpNWjZMenhIcUdnV2VTdjFjUFJHQmsvVHgv?=
 =?utf-8?B?c1hXby9RZTl3T2lOVWRPRTNuS3J3dTBkQVJPUTN1S3FuazJlTlYwZGtMTDRw?=
 =?utf-8?B?eVVDb05jdVQvZ2M1UDZrSzRaSHJGRkhqRFp6Y2wrUStDcHJnWC8zSE9OR3pv?=
 =?utf-8?B?N2pxT3Z3eWliSzJSaUwzQWt3N0tFdkRaQm5XTEU4THhMK2JjVjYyOE82K1U1?=
 =?utf-8?B?MzJwbUI0SEZsa2UzSEEzeTNLekkwak00amdpb3h2ME9PdzMwdXNPd2c2ZnBi?=
 =?utf-8?B?alhPNkVqQ1hRb2xvakRSK2ErUEV2WXlNazVpWlp4UjNZemVVTC8yU2dhZEg5?=
 =?utf-8?B?M1NsTWxrMUNqclZRUjFycG5MTXo4OGtqZzVXUDBaNEFMdlZsVWJqV0pud0dq?=
 =?utf-8?B?Y3B1bXFjWTF4ZmRBeTJlMEJZVTA0ZFMvZXExckN1L1hLRGl3S28vRmNvZzIy?=
 =?utf-8?B?dlVMNDZSbmdWR1Zic09BdkdneWRGZlREYlk0WDgxUy9jbTFGSzNtMjhPaUJT?=
 =?utf-8?B?ZzJLbXp0UU0yR3daY2VnUnA0K0t2SzZ2ZHhwbzZJa1V5RXdSZnZudlJYc3Nu?=
 =?utf-8?B?K3VTRUtHdG1OT1N1NGk3aVliaG4wL1ZUZzdjNURCdGZNWTlkcHNURHJ3SWkx?=
 =?utf-8?B?K3pjNUlaS1dCaGNONTFzcWdrcWNLeDlnclMyQzFtSmhuVFBOR2NNV2d3SCt2?=
 =?utf-8?B?MHI2dUdjMzloVTh6T3FuZU0xMG9mUnFVUzNWa0grTjdzRmtUdDA0TlZzOVJZ?=
 =?utf-8?B?dG4wMVd2b2FKU29XdmZpcGpzUWtXRmZRNUF1QXpLaWs4ZjlNVG9kaUZUVERH?=
 =?utf-8?B?QVllYnQ1K2ZRN0ZLNk9LY0R5NXNCTWUwTU91VDFjWlJzS1VrTUdjVFIxcE5r?=
 =?utf-8?B?RXpvY05uNisrdEl6Qk9ueHFSejJ0VEZhbkV6dTNoNjlHWkp1NlY2LytwMWVC?=
 =?utf-8?B?MEZPNElPWWxSKytabXpCRlpuWGhBcWVOdll1UG9zSmZXOVJjN2dWNlNLS2Nm?=
 =?utf-8?B?eTlhckNTYzJ3RFRtRlRBMGxQdklmVUNTbmNRWDRMemtiaEpyeDJDeGpjTTJx?=
 =?utf-8?B?Tkc1NjBsT0lJTytCM2VwMzMrKzdEWEZqeGljK2lXUFBlSWIwVmNDejNZemR6?=
 =?utf-8?B?VGhFU3J5aVhxM3RkMDhvWEVldVVXaG9YTW5YNTVJY29JY3Y4eWE4SDBKQ0pn?=
 =?utf-8?B?YlJHVDV3STdOS1dGSDNlYUpUYk9vdXFZS2lXWDI3UjNZL3FYZGpJeXZlazlK?=
 =?utf-8?B?Tk1leEV6UjNnaC9EclI5SEZBTGxrdys3MUs2eWNHeEZGUVJzWkRwWjVGREor?=
 =?utf-8?B?SkxnZXZtZngvQm9jSmxhWlMrM2JKaFNwditSYmxIUld1bWJCOWdab01mUHZJ?=
 =?utf-8?B?QWZlcHhST1V6NmdVdnEvcVF2VWFGcXZqcUUvRm83U01TaXpNdnVoMldLQjcv?=
 =?utf-8?B?M2F2d0xiaGlXeXRoWnBBcGhxQTFuclJib3NzS285Z0EzbHRrSUlRR3l4QlQ5?=
 =?utf-8?B?Vm0zZzdUMkx0U1pYSE9TaFZ0TzhqUjRWSmZBMU83eXlaOWNIckVkZE5rL0xH?=
 =?utf-8?B?TVZxZzhJUVRDYkNuUjFDSTNWdTFHdmp6VXNVeStLZkJ3MWM4ZHAydTJueXZI?=
 =?utf-8?B?SzdtRjVsM0tDQVNhVFJBcGNMU2syVmJjRGdUYk9vUFNXZjd4Rm1hT2orcnh5?=
 =?utf-8?B?YkZhbnVkajYrSlhVaExzc0xRNFYxU2xBV2VqZFFQZmtMTUo3R1RRcmhkUUhL?=
 =?utf-8?B?RnlOZkFQMUVYQWtZMEZSdEZySDNnU2pSNHFFaHNkZ1VGOVZ1alJ4cVNhVXg4?=
 =?utf-8?B?WkRKaFNpb3JOcTl6ZEFOL0tvUVY2dEZlVDhoUys4ZFMwckw4TGxhZ3lGZlpu?=
 =?utf-8?B?VWc5VkhBV2FuVUg4ZVorRGI3NUplRmVXNlhPc3VLQzNBZ1BCcFRQWk4yYmo3?=
 =?utf-8?B?UTBwb1d2QUVvWVgvbUZXblFtNVpidmJadjJXVDZLOWVNOUdMK2VEL3g2dTlH?=
 =?utf-8?B?Qk1uRFhzRWQ3cEp2ODlyVWw3VUFkOFpRMTNDNGJGcHVmWXh2a0wzcEt6cUpV?=
 =?utf-8?B?endZbVh1bEgrSE1MVVJOdXdzMjJwSEU3RVNsSlpyMjE5aDA4L2N5WVJlekls?=
 =?utf-8?B?dWkzTENIWXBUejBMOG5Xemh5TkR2bEVYNzVSSU03TjBpZmw3eC9QbWtWTEFP?=
 =?utf-8?B?c1Bka0MzdlNCUmxxRE1PS1M5RVFrbWNuamVmeHRlbjVXdlVyTkMwZm5nckFa?=
 =?utf-8?Q?d71f/nA8VmaFrjHM=3D?=
X-Exchange-RoutingPolicyChecked: OZHYoDIppu6iCrHrNMlE+REyWT/jci185uaOoLxJ43em2Zdwm4UwXK0HQ6TyZ/xacrnNMwTmWp3cW6hyQ/JWaE6Cl0th+q+hF1V4cPrtCA5J5zYrfe1s0K28R8QnaLYRiy5VXwUs9aTwuAwQ0OfMmmTbzbEaX8F/GRvPzNGuS5aSmUs8rP/kwOfPEVj08CN+0gMGMKBxYSyAJdbnW+PKme0/5aE1zHbFKaqpn6r9rI7M7HJG5rd4ct1KumX0a2H/MAxRLUjnyO7bARv/RE69X7CuXrE+bTCkeNQjucK2MoNTi0beK+iQc2aRasAHLHhQKnLUyiqPLHIrpo6W3l6Q2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e89a011-87e1-4709-59e9-08df4a1073cb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:51:03.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRKQ8cREtJCW3iVlsx4r8QQECQFevWMf2Yn81A2NvWEkHTuhxxrOp2y5kMVasXBJWy0ntF8AqsmP8F/DQnibJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

On 24/11/2026 09:32, Xiangwu Lai wrote:
> On 24/11/2026 08:16, Adrian Hunter wrote:
>> WARNING: From:/Signed-off-by: email name mismatch: 'From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>' != 'Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>'
>>
>> Otherwise:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks for the ack.
> 
> Understood on the From:/Signed-off-by name mismatch: the SoB line was
> left over from an older commit and did not get regenerated when I
> updated my git user.name. I will make sure the SoB name matches the
> sender on all future submissions.
> 
> For reference, the patch:
> 
>   mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
>   https://lore.kernel.org/all/20261110070032.1387-1-laixiangwu@cmss.chinamobile.com/

You can send V2 with a correct SOB and my Ack

