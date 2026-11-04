Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793777389;
	b=kDN21w7F1GA5LyT5pjKrcN3LE3Tr3CBIDv9rZMSEG3fBYwv6z368lxoHZbzoejnYjWhj
	 C/HQznujsGy6fRNIxf4gOUIiKL9ShB9T99ESGJqZHe6pWo5VXmJOt1T+TF+ZrSGwC9w9d
	 /Ei+C/ZZvGhT4ZwlGmcf/kKiOSLzjl7J5AJTajzPzmfxRiNnE8hHeEu6jLcTLpDFmW2b+
	 TwgHVJdUqVdqT/XIqj4+UFOkkYSosCnLPWIqMH0KX1gjkL5HJjQvPKrGk3O670bLT3hVP
	 E9F96T2hOGEQIhMoNoglY+WRhHd10l0MOri0x+Gl2keR18EKWKLY/Gal5yuP2zBYc3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777389;
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
	bh=EP07L69DXo/92M1eWy1owQ+CLkJy/oRcJeu/Tb/WPSU=;
	b=15LVCv/4eCxwbambDlxQdWxa33v6hyu2dI/e+CvTlVI+PYupsxQBNx5aqBLbohLZlMo7
	 fLEIatn2HeonK3NpXXHBhCvnm2YliOczyYAXj8vct35gBL1O+48nQDq/pVO07xwD4LHFV
	 dHA7qCsXTc8VAFaCo8yV7GeWWGikv2SPlcLok+iB23pqObPdM1VJhXQIIbvyf3I1uUUeD
	 6n08kOYBrZuwiS4DkaxkDmLpniKED/IzyXS/x3sjBsKQPE3/piWbg63lhbsZECAoqN7Zw
	 oKR+9MWHAvWNwArHS6eHRjXZ8U04wQpL0lkSCwDk7BxryMldEeC/p/qaIAEmYYkrpiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CiPOCjOi;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117E606A328;
	Wed,  4 Nov 2026 07:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7117E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CiPOCjOi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793777388; x=1825313388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzY9ZflQbmYqjc/wZCrRJJRwxx35rI/ENPQbpNWE++4=;
  b=CiPOCjOi2B/WzlYNFypGhPp/hpfAw8kP23oM+O6ffxw5X7BHjVld+5S4
   tp93w0pBdf8hP2EO1KMCAsLuTUQI8Umf7bB2rqB0DMsTCVyrDclGt8VQO
   F45wMGqcJbJIOnxbWI7CZsPMr5No2qc7SLOWEkmZyn4MgnHcYGetGfGGK
   jbBvK2vkj8B0niyuKwQx1WMh2xpi8vmRKPP/STXSXw1uWu4GzCROkEzeZ
   Fvyri/EZPJ/JfDlhxk0cAe0YeChO12WhJbfRHojCtJM3O4Wa3yMXlBV1D
   sUdVrHd8J0W290RLs2TPSFfWgbbj2+w9hAlWoasFvkgpnUAe2f88GNHcm
   g==;
X-CSE-ConnectionGUID: P9iV5iYuTY6AX4ASdUD/8g==
X-CSE-MsgGUID: 1lvSBLdDSSeg8RYCHkzpvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2556105"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2556105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:29:47 -0800
X-CSE-ConnectionGUID: LY1l4m7nRO2487JoMddRKA==
X-CSE-MsgGUID: ZCs26EaMQG2akH96Yw2ZpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6494199"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:29:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:29:46 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 23:29:46 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:29:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6WCTiHgXXtMB+v/3fnul8wyrAr26UZxOio800MB4pMelIyfIbD4RrVUQSG/AFsSGZbSORNvyXsRf00IRMT6AjEu3cAQW4eJuJMShJ1R1yimYhoOlmsk4naNzIiz+T4JuAjVkgWeEvk6pDEJdnhSSszz/YPyoH5Nt577PAazPPRXT0idTVRrH5wpgfLtH+9coM4QGPVIiZgVP+OnyXK/t3fCwSSqC7/CbSVhPjWXSP7nH/xRe5u0gZejOHnpYOvc0bTZ1rfCpY569U16t845dHhdVjJd9BGSICHbXickcSwpSuEZ4+FINK4XjmG7JBbVAOy47hmKBlhtkI+jQ11Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP07L69DXo/92M1eWy1owQ+CLkJy/oRcJeu/Tb/WPSU=;
 b=LOOwK+2eadHN4zqit2jIC///zlMl3mzy/jXfHzPN8N6Wp34n4EaEOJdkMKeNurUzCXillPJRXnGAt0xksTiBRZdKYLt8ioG8jRq4IzELeQzBFz6eNhjuyXjGfnb14bMnTxV+3lzqVaM5O0e9v80mjTW89HF2j3AfsE0vK3zCMDk81AJOLKiY5s8ptlzQV3cYSrYFXDPW41ge3k5DORgh88rJg1FU0IMXoAHIp8IdOkGiNI1BLWxCw/s8pGQP7CPNEI0Y/XXtJ/Lu+GDSGOhPrHmLmfgm48O1/JucN2Dch8x99eEVTJIWtJ4JgFWCJmCtt0isqzFR9rqFfo668CdZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS6PR11MB163730.namprd11.prod.outlook.com (2603:10b6:8:529::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 07:29:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 07:29:39 +0000
Message-ID: <a811d789-713b-4c4e-9e68-402cf6c49b6d@intel.com>
Date: Wed, 4 Nov 2026 09:29:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time
 for StarFive JHB100
To: Shawn Lin <shawn.lin@rock-chips.com>, Changhuang Liang
	<changhuang.liang@starfivetech.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
 <20261014121222.31385-3-changhuang.liang@starfivetech.com>
 <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
 <35d05298-9e72-4b7d-bb2d-832f44725d82@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <35d05298-9e72-4b7d-bb2d-832f44725d82@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS6PR11MB163730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6321adb1-9edb-4584-856b-08df3a456280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|3023799007|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: LdarzFt5nSaZ6JCkABDwJsrfF4yj3kcHNSR0mlx1S1NB2w3AOqEcrwwZueRLEMvoTtWUEH+JN74NanVEhX9eaNHPlVLjmcftaKTS7zVqAS61gWg+GdyJpcP/PZoLUDXfjf0LlD8ST+udS2gOj64hqWXvfQPjfXZ/+2v05zXGLGl2u5zF9d7b5OIEVTrwCnZS48CXpQW/1vho0RYzdCBga0bVAh9nPHr5lgxbuGpiMue43pnU5g/G6N73VZT+MBtQAYP9WaiksugUKG1bdNGOxWl4DIuTsZ6jFFlzNK5gTgOhVr3YBYOtlUS3YXJPgD8hyPquxYUl6TS0ILDlbFW6L5fXWm4D4kMCc/uWedSVyjSjp9IWgv1oI8fGBFGxz9lT/NFd/+If8+jtn4mDGqllC8RRkCHqnKfnKPS6GU5LyWUbShKveWDjqCQzzfCmVh/JP6yUP1LSG0LfAOfiw1V3Ls65rtDYT8VzT4QSTJon3oOaOCo2iGpmvvRZyYNM9BngU0UwwVK97b8OGrOz0U6N4XexXQUWasGvevb3kixhsyNtoTTEQiA+6LOziCX2WjFoIk/5t5vH3Hk/aME/jmvWx4SNpqnptmvBYjLX3evmdzdFd9m48U7NVdli3468mIL5anWqNc9K0DE2rXNzl2tXHTDMnypR5UQICRpbO/iq3Xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(3023799007)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzUzU005Z0dTS3pKdDVEMzY4SmdyWVdKa0l3THRPRG9EUTdLVDczMjRiMUxQ?=
 =?utf-8?B?Q3VXNWVtY1VicHVsZlhjZi9rTStTZldFeUlDYnpPL0tuaXh2T1lGZzZjaEI1?=
 =?utf-8?B?Y1pYRXFqQUJZenBvY1E0alJsRnZXNldzbzJocFNWSS9WbVlLR2w0aW1qSDFD?=
 =?utf-8?B?SHRYMmdubC9FYlRtczFjL1dpVlZDa3JvUFJsSk1vUGlRb0ZkYzRyazNMT2l4?=
 =?utf-8?B?ekVZK0Zzazl0VnN2UW9ZQ2M4MjNlbzNyUURJUWJkUUFCS1EzMTFzN0N4Wisw?=
 =?utf-8?B?WlhYUW43U0ptS2RMOUdyV3lJcS9XcFp2T0U4UHJYOThMZUlwTkFWUFRUdEIr?=
 =?utf-8?B?N0RORWVzd0tua0k5SnlBcWlPTHBTck1kc3ZsMFFkV1VxMkxGQ21MV253T0N2?=
 =?utf-8?B?cHBwZkFSZUwvN1lqdVZVSmZnK0hEZ2dMcEpwOGtqSmM4Zk84R3ErWWp6eW5B?=
 =?utf-8?B?RllBazRTYmZ4UG1JajZlOWtnQkxsYnpmRktmOVBNdUx2QkMyaitZNTFvY0tG?=
 =?utf-8?B?Ny8vSkM0ODBqb1FuczBOWG9wOFBWYnJLTWdCb2IrVmF4WmUveGRqaGg3QStI?=
 =?utf-8?B?eTRBTS81RWxVZ29FeU10cEY5OFh3OU8rZE53L0xLcFVPYm8veTJCelVKUy9M?=
 =?utf-8?B?d1lvTDcrT1F2TXJubHVPR1ZZWmtBRC9xYnA3Vm5aTklTWUVMcDRWb05weml1?=
 =?utf-8?B?Y2hOMHNmOTltMktQODJEaEZtRGczcWZ4RGl1UGxpdEEvUVJ5WnJJMTVUUjh2?=
 =?utf-8?B?dTdxQVRDQjU2SXBjVHVjWGZpY3prZnZndUw4WjdFeDI1TkEwNmNJemhDNEYr?=
 =?utf-8?B?Ykd4M2pFYkJWbEJtWGNrbmJ5UnZqNFh4d3NGVGNlQVM0WUFOazJhNXpwL2tN?=
 =?utf-8?B?VENaZTUrRmRhUml4bUxxZjNwclgydlg5WVZlenlZclpHTFNmRytmMHl2R3Bt?=
 =?utf-8?B?UHlBV1d3ZkdTWXlQTmw0SSttbDVtSlR3dEdHUFNCVElYa0paQ2dHTTJYNk94?=
 =?utf-8?B?WnJqaHZCRFJvWlRMSER1WUlJdS9DV0UxMkxNSUZ0V2p2MGtOM0pwOU5lWndH?=
 =?utf-8?B?amIrYU5mVDJPRk1Uc2hNekxmenVERVVlK2E2OWZuS0VQeFJpNTdwaS9od1hp?=
 =?utf-8?B?ZDFieWtjMDNaZGh5Tk5ZNGRDQzgwN0g1dklJL2pVK0JrSTFOczVWT0lwSXl1?=
 =?utf-8?B?NTRIQTVySVcrWUFVM0c4dE1hMGY2YWs1NG9rT0V6UWZGT0swdXBSUm9ycFkz?=
 =?utf-8?B?RUU4R3lUd3h1NVptb3VPbGIwVUZ6UlpUMzBSOUdGcE1uTTZORlhCOHIyNm5C?=
 =?utf-8?B?ejNDTTJ3MjZTTDh1U0JjdEJqVE1aRGdCWCtRRldQQVhQaG9EZlhPaUdDaUZZ?=
 =?utf-8?B?TThVQ2JFc2oxdlBlblhsZUlxaHVnYnhBRkRRMnJZRDZzbXpkc0VYVUM0Z2pK?=
 =?utf-8?B?Y2krTmNINFJySVZPWVhORzFVdVU0WkxKR0NtbEdrYnQ0cVRPRmZzL2ZGU3kx?=
 =?utf-8?B?T0g1Rlcyc0FJcHZDdXZWS0MwWkxUQ1lyN2RsbWNnT0ZNaTlCblFhUEhDOGFu?=
 =?utf-8?B?YjFPMVI0bUg2MUpNbndHMmdkdFVQM0VUZStwa1FXdHpLSnZtMzd6VnVyVzMv?=
 =?utf-8?B?eUJQZjhkTGtrQitJRHk1dkViUFZzMnQwaHdyYXNNNm5mb3dsaTRXNmg1bWN5?=
 =?utf-8?B?TCtIMmtrc3V1QTBnU0JyWWRLekVwTXRzSkZEaVdlSmRKVlc5a284SEJkdVRJ?=
 =?utf-8?B?MDQ5NjY4N2dEMkkvMWRPcGtSSjhJNFU2TWNMekRFMFQ3bWVEMEJIR2g0dlVQ?=
 =?utf-8?B?MVg4Y0RwMGVCekNrTDRJU2VRQ0JGaUE2K3FuZ1RNMGhOeElaNEFYdXhJWVZt?=
 =?utf-8?B?UEJ2dGZtdU9XU0dOZjM1bGhSdG1zSE9CSjFhSXZNLzM5SE52ckxmeWEzelpL?=
 =?utf-8?B?NWFKaFhQQVZ0dlplTk5vSWdHMFdUSTJCRm9UUnFHUFRtc0FNeERrWHR3MGp1?=
 =?utf-8?B?Vit5NFNoTzhIczVxWHM5ZG0zdWdVM0VxaGljSDZHMFcwcS9XU2prKzRmeHBD?=
 =?utf-8?B?NWptUlM4Uzk5UlVKLy82bitYSGNMaWJGWTFKZnpCMWJvNk1KcjVJM09Qb1VD?=
 =?utf-8?B?Sm56UEZhRG9JcGZLOE9mcWd1dXI0TnVIcmQ4V2xQUkEvZGJ2SkNCbko5UlBT?=
 =?utf-8?B?R2p3aWMxYzJJRTh0QUhaYTA2RkplZHM2ZVliY3RmZjJCbkpiZFVGWHpGMEpa?=
 =?utf-8?B?eitORjAyV1ZyUjR3RjE2U2p1ZG5qN2ltSFNBbmdjUnkwL1hudHB1OWRQK0Vk?=
 =?utf-8?B?aW5zVGc3cGo3bzZyeTRXZFBMS2RwNm5jaXRJWDZPS3dxZ0xha1FTUm5wY2lo?=
 =?utf-8?Q?w8PqZOHVuroM41/c=3D?=
X-Exchange-RoutingPolicyChecked: 5VGquFOBpr/50Z6LHDb5EaANM/0Ajs5bca+E0SGS0nTf/IhJTcH6S1mbRHz46Y/YF3N+jfWn2HLvXSr8ABRuv3nuSqU+lGlEepjLszcW4jHWOndJhixo4VgA0Z0VwW4A3u9X3eJEOUZrgENPHomfaeLRit8HaqvWRz8XPpCmjbos+e5oynLxRpDndRt+NdQ3cdJ6RFnDC5XkpF/R8xifUzo9Oiow2j7Qr/0z4atePiCz9O4IANcX216OicHMCIFS1GK2jMCdBKyWay02hwfEMCa/tE9qI0oHDiNaamoxTLMFT5BZQEzldnDKsIeeuaWMTMd1u/Xzk6UOQwZnboeIMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6321adb1-9edb-4584-856b-08df3a456280
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:29:39.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVbp9JZ4yPxCOTzowmJ8pov0IKbJuHMT5vkY4OIUIYAHYLH3ehhtZn8Hm8fBG/2npztV3Q3zYeDuYxjWfJzSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB163730
X-OriginatorOrg: intel.com

On 04/11/2026 03:40, Shawn Lin wrote:
> 在 2026/10/31 星期六 0:45, Adrian Hunter 写道:
>> + Shawn
>>
>> On 14/10/2026 15:12, Changhuang Liang wrote:
>>> Add a cqhci_host_ops for the StarFive JHB100 platform that sets the
>>> CQHCI command idle time (CIT) to 320 ns during pre_enable.
>>>
>>> Setting the command idle time improves eMMC performance on this
>>> platform. Before/after dd results:
>>>
>>> before:
>>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>>> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
>>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>>> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
>>>
>>> after:
>>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>>> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
>>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>>> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
>>>
>>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>>> ---
>>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 249055f14162..36628b44f78b 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -283,6 +283,8 @@
>>>   #define PHY_DELAY_CODE_SD        0x55
>>>   #define PHY_DELAY_CODE_SDIO        0x29
>>>   +/* CIT for the JHB100 SoC */
>>> +#define JHB100_CQHCI_CIT_NS    320
>>>   struct rk35xx_priv {
>>>       struct reset_control *reset;
>>>       u8 txclk_tapnum;
>>> @@ -2340,6 +2342,25 @@ static const struct sdhci_ops starfive_jhb100_ops = {
>>>       .platform_execute_tuning = th1520_execute_tuning,
>>>   };
>>>   +static void dwcmshc_starfive_jhb100_pre_enable(struct mmc_host *mmc)
>>> +{
>>> +    struct cqhci_host *cq_host = mmc->cqe_private;
>>> +    int ret;
>>> +
>>> +    ret = cqhci_set_cmd_idle_time(cq_host, JHB100_CQHCI_CIT_NS);
>>
>> Currently doing this from ->pre_enable() leaves a gap.  It needs:
>>
>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>> index a466cd88b043..e1bf6d50e8eb 100644
>> --- a/drivers/mmc/host/cqhci-core.c
>> +++ b/drivers/mmc/host/cqhci-core.c
>> @@ -283,6 +283,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>>         cqhci_set_irqs(cq_host, 0);
>>   +    if (cq_host->ops->pre_enable)
>> +        cq_host->ops->pre_enable(mmc);
>> +
>>       cqcfg |= CQHCI_ENABLE;
>>         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>>
>> which is probably:
>>
>> Fixes: 79cf71c0b177 ("mmc: sdhci-of-dwcmshc: reduce CIT for better performance")
>>
>> Shawn?
>>
> 
> The window between CQHCI_ENABLE and the first request has no queued
> commands for the idle timer to apply to, and pre_enable() re-runs on
> every cqe_off -> cqe_on transition (recovery, resume), so the value gets
> rewritten even if the registers were reset in between.

Might be worth checking.

At card init, cqhci_enable() calls __cqhci_enable(), which sets mmc->cqe_on = 
true (cqhci-core.c) and never calls ->pre_enable(). cqhci_request() only calls 
->pre_enable() when !mmc->cqe_on (cqhci-core.c). So the first request skips it, 
and so do all the requests after it. CIT is first written only after something 
runs a non-CQE command, because mmc_start_request() then calls cqe_off() 
(core.c). Examples: a CMD6 partition switch, a discard, an ioctl, or a flush 
without DCMD. Until that happens, real CQE I/O runs with the default CIT.

For Resume: cqhci_suspend() → cqhci_deactivate() → __cqhci_disable() clears both 
cqe_on and activated. The first request after resume takes the !activated path 
into __cqhci_enable(), which sets cqe_on = true again. The !cqe_on branch is 
then skipped and ->pre_enable() is not called.

RESET_ALL: same problem. rk35xx_sdhci_reset() on SDHCI_RESET_ALL calls 
cqhci_deactivate() and also asserts the reset_control, so SSC1 is certainly back 
to its default. CIT then stays at the default after resume until the next 
cqe_off.

