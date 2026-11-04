Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793790834;
	b=Hs/F2/eYzh//kuMaH2+fndWD7w/cAFA1mnrgvsjLgHo0dEdqgzIwUsXp+ehQWYkQJxWJ
	 0EJB8hL8KEZVU4wRJUME+XKBROhKzFddr5/qJhK+VOAGdc2KNggt2OedjrchWP7bSRlIO
	 SRfP9QqXO+P2RAG9jTKfqvd2XDFu4jnlkUbvMzjvCIPQnQ2lieluHjTKvAYityFN38+UO
	 IKiPxZVLKfJNZMkyBX5CKC1rez/JedL7xWYk3DWwREEPwZBj7ApXjGuZU+137FJ9LAs2W
	 RDnKdt4fKqhovwGslxWxdsxMRgc3WOmD8CtCo6UieQp558zzzQVlBO7D4u/gUHac1wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790834;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=xv0+Ad+EmVJgkOepfNPdUV3hI6yh10+wy+404JRZSK4=;
	b=dnCECcm8+moD5fW0RQsRHDVR5olNC0iGIdXvpj7/GesEQjbfPhgdB2ULJYoqIo53Hztq
	 gISU0idk0VR8gTf8nzrIb8ncyF5TtJPIa3q3BqjKXIUwGUP04ua1pXOAUg882j0KsxwwE
	 b1w5yMLcgIv4f+Cy5OafdXy/8RR7p7vrBzOe/IW99QFb8RU7sjYn/szRXWi3ENGsRcDiD
	 47pLUCxdRU5NQVBJrfWHnTkAafgQ1kMiqTSHW4FMKbQgeXFVFcG/L4l1fU++rJIOt1wp4
	 5LXo5xYYEa9LOF+SVBfisILXdqCLeW4OpZSiIkv/BRNcpOxPl3oeau5W6axnTo6gn4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GdEvE8by;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DA606A31B;
	Wed,  4 Nov 2026 11:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F6DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GdEvE8by
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793790832; x=1825326832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mXYe2PshdU/viht+oz1wg0af7wt4Fsk6INgPMFxYw5g=;
  b=GdEvE8byf1Hv3NSx3gCMFSL+YfPynWTpdxjnJro0fDbvrWomUI40h8Fe
   3NDAg6qBHI+Jd+OSvct63Y+rD9YaT2lg+ebDHBW3l3+LcMm/QYvTSQk++
   aDSyosvXCKGQRdQcvb0VbtfiQEgHFs2roT3ofYTucSV/aAeVBT9hbrSJP
   QMURtUhnP7jYklSIcJX0G9H3FrMr4tNKdlYp/90OYBcnENzJN1HqVbi8/
   jVxp0/n8Qz+fGti7pBE+C7NlWlzEBCZ9Pr/cg+dSWf9QbRL3HAjnGiW0V
   sUHo5K8s4FZ68T86ktTvmCVXUTH+vBZbIJNge7ofz97rqb5w1gIYQdbGr
   A==;
X-CSE-ConnectionGUID: P42fjEssQh6VRR/gfDIpRQ==
X-CSE-MsgGUID: +o0BEcsBSnSJw8CweyjduQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553862"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2553862"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:13:50 -0800
X-CSE-ConnectionGUID: c68mjatETHGTC/LjxO0tuA==
X-CSE-MsgGUID: xJbynLGnQY6Rlne75aRPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6546609"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:13:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:13:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:13:48 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:13:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuas2sm45EmvsbAJv0gGQLc8a5gvlx7gdFMh8JUYLk7E21fl0thg67pObvqWuIjQedkAQ8x8kyzqjMfdsgG44PiToMu82RqLd5d+qQEkpTH+WmAg8rcHyl3oZa0NR6nZfLnN5+AUl+OS4fLIOHc7wenK123MwuCNaHAgHKLCm8kxsAIr2pKCPqBERsYdiffZcgBDimlg62WQX0LALMTmIvSdvGpvXJkyk6/tNiaUS2wUt9XuyFUxJGj9CT5VNMZj1iuqYsccR3Wa3ZDAzqFSNFA+rhyC3z9KtZLcYyj2q/6e1kdWWGKFcANvr2nXctqc0c64I/boFqyObCYEib3Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv0+Ad+EmVJgkOepfNPdUV3hI6yh10+wy+404JRZSK4=;
 b=Yv+aGwrb2fZrC7edUY7FgqXlJHLripKjkeaLeQK6Gll0tGCwHZKU9GxEntumMYVBJlQvRjcIno0HNlCRvlCmMxfkc4wMOR+7fJ76HXMwLJhpKaPFSLi2OB+IaA1RZb+Txhbwad7H/Gp9MKaPra1vipt/9wu46Rn2svV35ZLHQMP+cl1XH6fNYz0VOkZcMR4gwgJ7oPAAWsBWyxzTxKryszD30f0VJF24ijV1Ec3qO73jaHtWjk0x0bmnpE2Zy1gVqUXhQr2hAmy/vJiYODlxq1bC16ZUUwcQ8n/XKOVEHfqx9wXjksOFrrAghpXr9Jk2+AUjxkZzYsUHri0RhcznPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:13:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 11:13:45 +0000
Message-ID: <6ecc7b5a-cb05-440a-b13c-8885bdad34c9@intel.com>
Date: Wed, 4 Nov 2026 13:13:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II PHY before
 LPM
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Ulf Hansson
	<ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Victor Shih
	<victor.shih@genesyslogic.com.tw>, Lucas Lai <lucas.lai@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20261021233313.247155-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261021233313.247155-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0323.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::24) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: ee86a7b3-9035-484c-a3f2-08df3a64b0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|11063799006|261028144727099003|261026121527099003|261026140227099003|56012099006|18002099003|22082099003|261102123227099003|3023799007;
X-Microsoft-Antispam-Message-Info: BwlNdov5yptL++B4QWTUj3kdiRK+ND1Y7CpnAcXttPGU6D83J0MA5jW1sr0/7CK8zIYKaa2oseQ+qxp6iJh46O8vbngRKNRiZYNWs7+FwT2oZ02EdzwhjSGzitxTiLGoWdrt3aU8QFWT7lBPhtjmctKVRIM6vrJaxdzBP77APhEVRCJ3CBS+nfv+63quCwJmTBSoY6MrPRA6CgH5HyEm8yfZevAu43q3Z/pvlkyhP/giHE7GOTpdgT+wA7zp8jUUAPvBzXyhgZLKDDGl/yL94bIszyyveEruyUoAEvlCgR1+mC2zZ6p0eIwpj5t9QcQ1Bk8SNR3R/AgHzMFzZ1l8FyoybfJu6Z8N4sWwdzOcxPvq9mvjvq7HyS9v+6tuFcTZO8zWjEmXwALqVQANiXKNZM63gNM/D0QYRKDOs04CPvta8FYd7kiBzf/hcv8a49+KdzbMTIruKS8LJ6AlG9ZK2EwsmvzuWUfqf32njXFGF+aeDonBKRMMa1hjeOr8H+GD8tC4ht+nqMRERqYzV9P3NjChr+QzyA3GPug4Qr2pdGkz+s24PSDQDYdFuvBTzjq4Gv0mQz5jlti++dVLqydpfHteXJICoLzIe61/gqXfiSrd99mQ+zsuimA/GCjOXocc/TnkjJ0lZs4UI2beKSycQQGySX7W/WRaHRrgX1Up0i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(18002099003)(22082099003)(261102123227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNiQ0hrVHpodXBWRGNiQmNVcUJmRVp0d1ZXS3d0TVhha3ZBbnBURDlLMm92?=
 =?utf-8?B?cmNRNEVRVGtObmx0V0k1ZFJFd1pmMGtqdkFmZ3hXaDl6RDNqNTBYUjl4cjNy?=
 =?utf-8?B?dDQ3SFNzKy9NUGcxeXBEbWdRK0hNempZcDJFZlBaS2czZWFzelFrd0VVUGJM?=
 =?utf-8?B?NFB4UElnN243OENhL3JsL0poeWpLK2pBQm5xMTBmQWU3aGpZbTBIZ3d4dCtj?=
 =?utf-8?B?SDZnYUdZUEFPYmwvSHY4QWRRdVlDR1VnVUhCd09ucXRUWkk3c3RPM3k2Mmgy?=
 =?utf-8?B?bUtRb0xDeXRrQzR1TmNSV1hZYVBXajh1cDRKZXAzOEdheVFLZTU5R0g3SlRQ?=
 =?utf-8?B?Z24yVi8yNTA1cTFRTnd3Yk5IR0E5cWpQNlJxWkNrSjQ0VEFCQlBVazBUYVRC?=
 =?utf-8?B?Q1lEUTBWK0xyblUxZ2IrT1RKTkpJMXg2bVlBbUJnZUMzejhhUTgvZ0lHSzdq?=
 =?utf-8?B?MmdJMm5TNlpXZGJObWd0dXBnbVM4QXkyYk1VTWJWWldmY2pGS3FuY2pEV3VG?=
 =?utf-8?B?a0Q1ZDNjb3NFVXpWOE1Cc3QwZk5hOWY1S1BlR1JnSFNxN29YakhDS0ZaT2dH?=
 =?utf-8?B?YUZJc1c3ZFpVU09YSUxRd25mZ1VHVmpqM0tDbzJYWndwTmVmNDZqVmxHK1o5?=
 =?utf-8?B?RndQNkxLdG9NRjFVWmt4NDYvRkpQdlF3cGlHZDY2bEpKQ2Y2em1tNi9tWm1C?=
 =?utf-8?B?cFZwSVRSdElwKy8xTEYzeHArUmMrcjRDbDlhMGRJbmxEMWxUNlV4WTB1RGhz?=
 =?utf-8?B?cjhyQ2JZbUx0NHNLRnQ0ZnNKeUtySjFXL1dvUzNLRURPcCtkVHNjVlc2TU5N?=
 =?utf-8?B?Z0dhK1ZCZk1sTFlKczZxSjVtcDczbXFHYVJEV25zNkVTTG92MVlITW55ZVNo?=
 =?utf-8?B?MDRGcFYwazY0RTVuVW8vazB1UURPelB3ZEplSzNpYWxPSnBQZ2c1Q29JQ0ZL?=
 =?utf-8?B?Y1owSk4rZWlZek9KdnRzTXN5Z1JvZmFJVFFCenNSTm5wTGxQc2Z3emMvNFRp?=
 =?utf-8?B?dFE0Y05kc1ptRFQzMjhWZ1pkdDhWM25xS1VHQitXTVBDdGtjeDJ0QTBWOGxG?=
 =?utf-8?B?Nk9tTWcrRWs1NnZOSERIR0xzRkROT2ZvdEk0V0c5dWMzVnNQVHh0cEFGN0xr?=
 =?utf-8?B?emg2QUM1NlorTkc0eSt4UnJuRVE4MlRKZjdlajNaVHUrYVJxdTVlVllNL3I3?=
 =?utf-8?B?TFE3WHdtYU1mOGZULzlGYjFEK0FVYjlvK0VIdDBQVys3cUNUSEhCQXVudklY?=
 =?utf-8?B?cTYvMXlGM1p6Q2ZOa212V0xCdzM2aWFiTS9oZktVblVSK2w5M21RVGlTNmNS?=
 =?utf-8?B?Nmx3SVVHc01jblVjWURPK1I2bWdxdW1XMVZ2dnFqSE5TOU05K2ZxRDZyWDk2?=
 =?utf-8?B?b0FHWHk4NHNDR0ZtWjJMR05HL2dCTmJxZ3VsMnUxc1UyTllVajR2d2hmNWdO?=
 =?utf-8?B?bkIzTkVwcFJteGxtTGNxaHl1N2xUWVBVd0xuYjRsTXE3WTMrM2NXZ3ZoVlV2?=
 =?utf-8?B?OEliMnU0VnBnK1Y0SXd0SG5DUG53R0RYUTlwVHEzd1FTdkM5NERkNERTTlFX?=
 =?utf-8?B?NGdJbjc5VVRnUkVLU3g1WXhiV0pIaWdKaGNHWENzM1lwcUZtNHNHa0dkZFNi?=
 =?utf-8?B?N0FiZW42RndYTzZZbzhNZEpTalFoM2JrTXdzYkxhYVEvR2lMWjcwOFdFdjRK?=
 =?utf-8?B?RkVjK3IvUHZnZVA4VGgxeU11OFY0bjgxODhIandFNTBncmRjYVhKQUNWdGQw?=
 =?utf-8?B?eEE0b1ZPUndBTGpEUlBPbjNNU2JGZkdUcXhsUnl5WlAvbC96US9vZlpWVEY0?=
 =?utf-8?B?NE82T1FFdHhpS2c5NHVYMVpITXVkMFFzZ2kwbHg5NnhmeEtlOGdiLzdNNTkw?=
 =?utf-8?B?cHIxV3E2Z21ITllWNmFWYzRubnpUWVZOMmQvTkpnS2NWcUxiWmVJSkt6bEtO?=
 =?utf-8?B?N1hoNkdDaTJ3S2N4Z0dRTHdjeEYyckUrZzNwZXVKZlczQVl6OFFxeE8xRWFD?=
 =?utf-8?B?MWxQd2lybnE1dGNrNjNzRjZSVUlmTmZ5U0x3Nlk0QmM2VEhzY09vZWxrRmN6?=
 =?utf-8?B?a2U0VlVBTXJueE5CRExRdWdkem51Qjd3SXFwNDNrOVR3cXcxQzZqWFNBWWNN?=
 =?utf-8?B?bHdJZkxyR3VnNStCSXl5UUw0WTBpa3Jmb1NxdEdoblhWY1NON1R4SzIyWU0z?=
 =?utf-8?B?SjNyVG5XTjVReDRPVmQvMXZuQ3dib2hlTm1HYVBsOWFqajJ6eit6aHJwTmVu?=
 =?utf-8?B?MXRQTXFDYjc5Sk9US1NBTU9TT1hRUjIyREsveXdGVXN3QUEwOHh6dCtMODMy?=
 =?utf-8?B?ZEI1VmU1Y2VRNFhJbDN3KzZFOVgzTnI4UHdsK0l5ZFRjU1dPZ056Z1NQazNo?=
 =?utf-8?Q?ru3fxCxxXSjfdnV4=3D?=
X-Exchange-RoutingPolicyChecked: ayuqbIk7KcL8rKme58fpdGtLRPXeqJPOAQLbXioAF7Kt0eLKt5pUC510J4aQf9IBbvx/9dYMOEsW0kWH0bYrmlSyVhR/R+7If455j/w/G2wROSqS2iSkEnjTLugQdpcyEKkMeAIAFFXTpQj4pguqj4oWEanALSMsYSFCSftn+d4LkA9b/4O/7WV6evqAzHtGJ9okIRL8P8g4nM5YiY8VXHPMJ21FhlOo2CyMRcpCh7bP5znFEaU797qLHaoaKJimtKAMT2rxYvzXvWXn5pMzWKjbxS9CXuG40Hkp4KXfeFNROPkBGUCjJLFW22G3SExYXrkOh2soCpwEEqoWzomH+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee86a7b3-9035-484c-a3f2-08df3a64b0ba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:13:44.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV8P2tdePm3EiSxkRKpxfXxkNVDukUhUGsiiEt52zNcxnXdESc8wqC708nrXQnBQT6QF3pPJq8OfFLIbujsqiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com

On 22/10/2026 02:33, Matthew Schwartz wrote:
> sdhci_gl9767_set_clock() re-enables low power negotiation right after
> releasing the UHS-II PHY reset. If the bus then goes idle before the
> PHY has settled, every SDHCI MMIO read returns all-ones for about 250
> us. sdhci_uhs2_interface_detect() takes that as IF_DETECT and LANE_SYNC
> set, so a UHS-I only microSD card is treated as UHS-II. The attach then
> either fails with "SDHCI_UHS2_CAPS_PTR(65535) is wrong" or, if the
> registers come back before the CAPS_PTR read, runs DEVICE_INIT 30 times
> with a 10 second timeout each and delays card detection by 5 minutes.
> 
> Config register 0x8CC reads 0x2000 from clock enable until about 250-300
> us after the PHY reset release and 0x1000 otherwise. Poll its bit 13
> before re-enabling low power negotiation. The register meaning is
> inferred from that behaviour, and with the wait in place 12 of 12
> UHS-II probes of a UHS-I card correctly found no UHS-II interface.
> 
> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

One comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b55618566d651..bd383918d27c7 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -205,6 +205,9 @@
>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
>  
> +#define PCIE_GLI_9767_PHY_STS			0x8CC
> +#define   PCIE_GLI_9767_PHY_STS_UHS2_BUSY	  BIT(13)
> +
>  #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
> @@ -1190,6 +1193,27 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
>  	gl9767_vhs_read(pdev);
>  }
>  
> +static u32 gl9767_read_phy_sts(struct pci_dev *pdev)
> +{
> +	u32 value;
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_PHY_STS, &value);
> +
> +	return value;
> +}
> +
> +static void sdhci_gl9767_uhs2_wait_phy_ready(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	if (read_poll_timeout_atomic(gl9767_read_phy_sts, value,
> +				     !(value & PCIE_GLI_9767_PHY_STS_UHS2_BUSY),
> +				     10, 10000, false, pdev))

Doesn't look like this needs to be atomic

> +		pr_warn("%s: UHS-II PHY not ready after reset.\n", mmc_hostname(host->mmc));
> +}
> +
>  static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -1276,9 +1300,12 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	sdhci_enable_clk(host, clk);
>  
> -	if (mmc_card_uhs2(host->mmc))
> +	if (mmc_card_uhs2(host->mmc)) {
>  		/* De-assert reset */
>  		sdhci_gl9767_uhs2_phy_reset(host, false);
> +		/* Low power negotiation before the PHY settles makes MMIO read all-ones */
> +		sdhci_gl9767_uhs2_wait_phy_ready(host);
> +	}
>  
>  	gl9767_set_low_power_negotiation(pdev, true);
>  }

