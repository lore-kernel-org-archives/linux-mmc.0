Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A5375AAE;
	Mon,  2 Mar 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455355; cv=fail; b=sESuJveB6T/SarqfcP9puhVyijAG87GSMsRLKIRzuXsYhOnoSSSvhTb6Fkd6YCnlciISvnaNIwr2LfqsxKPuHqP1KEHrXWLfNzaVla6pyBBAwswjuRU1j5qocOYbIFbZC2Jxa+OPqRMXUaXeKciqcj1I1vyRAoHiEmzVlX4cQKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455355; c=relaxed/simple;
	bh=LAWLZeoXCGZbPAMZznPRgkJhjpnZOfKBIynhWPDZhHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lwDsLiU+95xswbaVe8M5aUH8n1CxPzf1VuA4mK9/hCvg8K2YqVeKIM6+mwGZ4pnue0sbPaGDrE3QTpo+4v/9rYFD5Z7GnfGSFMcBEnObhlUfnY36IIMOvhGqBhZ2T/be/FjRFP34ck2pYpVu4iyObboZBoN5EhlLkRWRqSj/UHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmRGiU/b; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmRGiU/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772455354; x=1803991354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LAWLZeoXCGZbPAMZznPRgkJhjpnZOfKBIynhWPDZhHM=;
  b=RmRGiU/bM0cxQn2Usjp0ZHILkcXlm0XMrS10mRKihSVihQpsfInhNgQM
   ffahFxo2DwxxkVPpGLeJP8TRE6FCC0OgK73ESbiEo4i/8Q4uhykg7JVWn
   qy/hR/oVtdez1ZAb+OUyfovkYRk/dgroyoRbDlkumHQN6v3bNL0sipbni
   BQHVEmquW0sf474sIWZjfZMAWn3o95KYVVLT5RffL2Yvl7+6frOusraRh
   39N8sdv+IW3b7ZjIjoHdsJrbiYDy9xHPE/aougVBN6iWWfGpJjtlJ6WNV
   yE9pQUAGC+SGZZUOPT4M0RVTObYEOK4lZad1ag1ep93LQvpEz0RXOLHT3
   Q==;
X-CSE-ConnectionGUID: ATm2tZ3VRjm2uOkOGG9/lg==
X-CSE-MsgGUID: u9c+9F87RbuvxiI6miJFPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77323329"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="77323329"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:42:33 -0800
X-CSE-ConnectionGUID: 9FKCb35hRvSC2qhovWNzWg==
X-CSE-MsgGUID: cqVeBQ/6Qvq09yTmD8EUtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="255501808"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:42:32 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 04:42:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 04:42:31 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 04:42:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm7cdw2yyU/vZ0yGqYgwZgnn2dOY9xgBWKrHiAuP0LYM9ac2wUw3qsZUS1q3VyFxFMOIt3x0IBOaqiX5Gm0+bKem+84Vdo8+NYsEe7rZTv80b9SRdufR3HRvwU51ZB7V04VWilGF9zUcnxg/vjTfYxxlaRR4GqAbp2gKgiBTQhS7YQBnZuLDzM4dYUqbtjpycm9TcKCU5nMn/sFqj7ahzWhQEvcIPg/VMdOD3YUUHaHqfCyHfl24HtHZBVdlmB+9HjGPMx8EtR2Zz7watUXbD+3xfV62diaYGgDDHURP4thVDZzDghgwMQ3VYIsnlNEFTxHrgeFPEJ+R34DTyD1KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SYg8zO/uHBThGYvzsTgVyawNa/zMh4SEWoR3b0l7i4=;
 b=bz/NwsnWpwBcg3Rkt4LNiUtv1YQVXuHoK7gVL9Q2G8EfRMKGeP5TR89xOfWnss77MXiL6eTKcgkyOSnc/Q0P0sktSWi9oSKmMNozdoMAaVJdiHWiVQLiLacqDkuB2+sIOmJWWUCSZ30SN1gCVl4XSZYY0wo6iYULDjXukgU3/E5FVb7i97m+KA6DZ4+aWx/DKxkETz9l217lXOYpLztciFvKGhOz4y1EJwO27ANiuq+eeDXbnK4lMWb7lydjAw9YX2cb0btgGwPo/dWBIRL9rV/5o3hCb+M9eHVj9qjVVjPg9B0gW+QcAbU4KotWpxKTRsQI8fxC3hy5t0WuzlaIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Mon, 2 Mar
 2026 12:42:26 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 12:42:26 +0000
Message-ID: <6e0e650b-d349-4a9a-9dbd-8244fb050b9e@intel.com>
Date: Mon, 2 Mar 2026 14:42:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-bst: Fix memory leak in
 sdhci_bst_alloc_bounce_buffer()
To: Felix Gu <ustc.gu@gmail.com>, Ge Gordon <gordon.ge@bst.ai>, "BST Linux
 Kernel Upstream Group" <bst-upstream@bstai.top>, Ulf Hansson
	<ulf.hansson@linaro.org>, Albert Yang <yangzh0906@thundersoft.com>, "Arnd
 Bergmann" <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260301-bst-v1-1-ddbc22ec3ed9@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260301-bst-v1-1-ddbc22ec3ed9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0020.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::25) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 368ef735-fff4-49ba-9c2b-08de7859287d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: ss2oUWKt47H6zfdXXVdMjuOB7mfyGH2EX+H1uthX9wsJU+2sNyAM+4SntnRl5t5GG+PACd6o190UxHTA2aNzJqU7mvyVfYrRYGPlVLDkJRuqpX5EZRQKaCyocNeaqSfG1BGezqT7XPOMQmTZPlywaAq5Nj+rtKKUMS/DtmBq1UJ/ZU5oiNLbVG54wVk/JphpoTODZm1ujQqegZEaXNtGRXIWE7pfuMH8HQ3dAMA3UGUhEuhpQEyUGlhmtWggcohvQxEXcArrsjMVZepBnZNElOwzLjwS1fI9xo4/lPmSEkZkQHQ7Hiy5qB7zNyaZXx32lpnMFY58DdxGxTW7+LSL2nOwMpKHXQK/uOimUrDmODb06GEgerxuYFTLeMMa+p4yaWnObTT842FuPChIk3mdV8Mck6EX0tWpLeYFo/QSp1EV01qPyBxYLiFjBx2Bx9Teue7FgnxWfMn/owdyxBNg4o0NwR1ftmTZlcauMdR1EzjFR4NSjjtkRU6utEKrg1dPfr+hVFlnYz8kaoFPY8+v/o18hs2A6EvxC3zE/haZqTxcnDNpS6oJJKmYcuxJ139jGZenH+XVRQ1rMy95cZwuHJaodWj0W8aweUZPnRTqxmoNE7ThXEU6jONiAPXbgMWIDxcKXf+CkRKSEO6jQmnrY8Q/pIdh9lHH7y8HlQSto5xOpRWsiFa4RoulGrOzRtQSspZQ7W6hKubfHdwc+S/pvnH2Dm7nx1I62u50I5WV2xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3o1V0JBRlJXc1paUklCSzVhb2hySDVqampWQ0R5LzZQZXB5Uk9mMnJhWFI0?=
 =?utf-8?B?KzJSV0thRDJ0MWV6S3NBdGNEMmZ3UitRTUZ4UmNLaTRMaFlGUzBTd0x0VWtM?=
 =?utf-8?B?YW5UQ3V6YVpPbmx5bTVRclozTXB0Y3ViaWEzZEd1TFJ6N3JKYUMwb1ptVGI1?=
 =?utf-8?B?blE2d2NuMHNacGtwSFlhNkE3cWg1bklRanlGVG44cEtaVVppRk9aODBQVHl6?=
 =?utf-8?B?RTgyOVdiR0RYUS9CMHVPeFc3NW8yMndYMnVPanlHOC9NVWZCa1pyd1FEYTUr?=
 =?utf-8?B?SExnSHNNVTNiQVhLakVHRE5PYXNxYXlwdG9QSTVybzk1V0ppbFB0azhBa0xk?=
 =?utf-8?B?Mlc1NnkwNTZSRjdqWkJhbTBENGdEcmtmV0pBUVhRUHJmUE0xL0E5S3FvMzR5?=
 =?utf-8?B?c1Zva05XSjRiRExTT3MweDFsQ3hYb3NjekVDOGpXT0JZMlJ3d2o2V3RjUlNk?=
 =?utf-8?B?UXJjTkVwYmordTZRenZKaTZycTBIbUcrdkdEblR6RzY3emJxUjRVdUowU1NR?=
 =?utf-8?B?dHZCUFBkZGZEY1RDQTk4Ry8zQmZCUjJQZ1VhMVJlOEhyZVUyaEpHL3E1NXFW?=
 =?utf-8?B?OXFDQzB4bVcyMVF2RWpGb0ZGOCtCc0dSeEJGTHkwdjlyNFE5b0pLT2x5Q3l6?=
 =?utf-8?B?Nmgxc1RyYTl2Kys0RFgrckhNSllsRGl2NlJYVnFiSm5GTWFQUjdvMGpLVTVl?=
 =?utf-8?B?OWpTMEdrODJETUQ2UGYxdTdtNTNKSlRGNlYvZ0twbkhGSW8ydVpPQkJXUXh2?=
 =?utf-8?B?ZS9jU1F2UDVIb2FKV2Nyb29WNllzMGNCalpab2FqNjRpUjZUcnU0d2h4NHI4?=
 =?utf-8?B?Z0psSkRGclovSkJKbnRKZkJYa2pMZEtEZE1uS2JFV2NCanZXNGc1UlJSOFFB?=
 =?utf-8?B?a1NrcWJBUmcrU1JUbWo0b3VMM2dQbGsyYmhzOTNrZDBJZEt3NjJBL25RTFky?=
 =?utf-8?B?bVRJSE9XYUdNeWdWWElDall6YXJYSjdjc2JtbGdaNE1PTU5rMHp3d3JhTzVI?=
 =?utf-8?B?SzE5bWI5emVHWGNuT2syTExpVW9jdGIyM1p0dFZIbTBmNW55cnBxaDMrVit6?=
 =?utf-8?B?K1dhREdPQ1FmQVU4MFpnZnA2MGtvZWJpaUlhbmNvd21EM21ZU0hKSGRodkEr?=
 =?utf-8?B?NmYrd0NMNFZoNnU0YmtaVHFLUlBRRGN6ckNQNHN4STlXWkx4TkFuMWszNnUr?=
 =?utf-8?B?WUdJdXo2U2U2Q3Vuc0kzajNhK0gzUHh5L0tyTUlJNndyNGVQclp5dlg4Wmlu?=
 =?utf-8?B?T0dhTlROZm1MdVdkaHc1Y01TdVFyVEZqVzVFbmNuam9ydjZFRzRUS21CQ2pC?=
 =?utf-8?B?eFl4RDJIc000ZW5TOGMwNGFzMmx6OG1maWY3SElMODcwZzBTajYyRkZQRUMv?=
 =?utf-8?B?djBPeTJpME1naE55TnVrZUh5V01qU3VjWDNHUjhLUzA0eVF6VnVxMDBKWGVk?=
 =?utf-8?B?QWZIOGl0d0VzZm12Ymt5bW15T0lEK05DaVhMUkdBdk55SXF2OFJid2xoT1hs?=
 =?utf-8?B?SjQ0TUhrbDBDRHhvdzFFQVZESzFCUVNmdmlXRXFFMTZmUEJsOEJvRjl5c3hJ?=
 =?utf-8?B?bTQ5cVFnYVRQSEx2OE90T0RGbVFQK1JrV1czUVIydHh3WW9aSXcrbThnN2Vm?=
 =?utf-8?B?Z3FsbEhETllhK3Fici9tMm5YTlpWeHgrb1RXM24zRG8zMGNsblZ5eEsyTFNy?=
 =?utf-8?B?MFczdnhTQ0RuWHZ1WkNRSVZwZENpUUdneW5CRUtoZnIwZ29rYXRKWXljYktG?=
 =?utf-8?B?Njd4ZExlcEtXeXhPNmFDck5hMmd4ZFcxb2Z4TURvTVlOTll6SEJwLzVjU3pU?=
 =?utf-8?B?Mklid2UwWm9xVGpjemtsdStLR2JPZDRsWmtNOWNNTi8zN1lLZlZFaEJCeDJQ?=
 =?utf-8?B?RzhXUjQ0Q0hoYnFESmt1YWFFVHVpNVFhSTdEaG15YVZWT0gzTGt4MG1leklS?=
 =?utf-8?B?NzN4YWxxZVJmYUtPZVU1ZmN4dmhhYlJZQ0JsQnVMTDZqMkZVYnVjNHdpN1Qz?=
 =?utf-8?B?cklXUGNIc3V2V1VHMGNMckRDUUpaa2JMc0pNcjlZTk8xUTQrd1FyV2hxRHFj?=
 =?utf-8?B?MmN0YjBEbDUyTkkweUdCc3A4MkF5aWtCbmxWLzExZFFhMU0vcTJjOHBRekZv?=
 =?utf-8?B?dHk4N3l5b3d2WlRub0twQkZhUW05YloxdmNsNGpPYWtUUG4wVWxRdXNxak15?=
 =?utf-8?B?NDVaczZMeWtFMy80Smw2TTBsVDhLbDZEaUM3cjVPcUFzWHpKK1Nhd1kxU0Qv?=
 =?utf-8?B?alNBRmYzZjBVQVE2NzlKVDdhdXZDd3VjclhHU1gza2ZPbGFXdFZYVHFHQUk1?=
 =?utf-8?B?K3RGKzIrdDF5QURXdW1qY0xUY01qeDlOdVpJMzVYUVV4TUhrQlRPdWFocXRK?=
 =?utf-8?Q?mmC29/ovaf4k0Cus=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 368ef735-fff4-49ba-9c2b-08de7859287d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:42:26.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4lZLEjSj48Yqhq9rDHYxeoC8WVQ0ETPca2KXLEeJNylv7Z7z/+CBZ9p+TrFLzVaf8p/05Hem67u9F1fzkeHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com

On 01/03/2026 09:53, Felix Gu wrote:
> In sdhci_bst_alloc_bounce_buffer(), if dma_alloc_coherent() fails, the
> function immediately returns -ENOMEM without releasing the reserved
> memory, which results in a memory leak.
> 
> Add the missing of_reserved_mem_device_release() call before returning
> -ENOMEM to properly clean up the reserved memory.
> 
> Fixes: 695824f45629 ("mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-bst.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
> index c124990a64f4..79c945f4858e 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -425,8 +425,10 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
>  
>  	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
>  						 &host->bounce_addr, GFP_KERNEL);
> -	if (!host->bounce_buffer)
> +	if (!host->bounce_buffer) {
> +		of_reserved_mem_device_release(mmc_dev(host->mmc));

Please use the same expression for the device as the rest of the
function i.e. change "mmc_dev(host->mmc)" to "mmc_dev(mmc)"


>  		return -ENOMEM;
> +	}
>  
>  	host->bounce_buffer_size = bounce_size;
>  
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260301-bst-76bb7c6d7931
> 
> Best regards,

