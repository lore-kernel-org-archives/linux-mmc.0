Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793378743;
	b=x6oAVcbDudg+SaBRRLlppmaILrrnATpTMFRCoaoWkJUjO5aTYLZ2y7DuEJCsPZeS9FTr
	 IanG88AV7Xt5iLMb399ht2BLVomffcMpU3j68k2fRxz1IIZgBE5HsJwCIpHXH6b8uqoQ1
	 8GEKcSY8uFiSF6Ne3IwfJhC7hpgOej7MpjDGRIPZa6aXB0evmlnynRRCSScq24FNiVXuu
	 5wE8rFAneSLNxVRChIlvOcakrck+kK1C7C9lwXqza3v/kTHmFf3/HU6YWGjExRNNFcocB
	 TonEwwbxETsGIn8V6rMNWjX8caxvRuwmDfTWOjB/z+7F+iJ3P7OkU03sA7FmDwNquPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378743;
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
	bh=bKQvliR5e0K06ZPmVSw4IJ2fJ5Q1QY5VJJUQTdxS1CU=;
	b=e9NdZj1Cigbh4HCTVHjLWL5cumUbdE4exPiNBMFdA1742EpizY98zL+9UYne//VeI+yN
	 llAFl12kTOYguZldd+2cz8PoAMoLmW3/4UnEJXJgfBCrVnwIxDK/UZ1et8r+Ol3XmuuNm
	 kmjUr4sveLQNPpP4s4sZJQqF2D6nxosd+CuEqVYhkST0VAv6FXvCLoMErjpk+xxLeZQV7
	 JD1oaBxs3g1SJWWYTTF5i5odYwvDLhysmbWHvXsAJWrzuYg/k9KA6BNJx9z6ijipK/DbQ
	 dU18hga1XH9k8PszjgXOBxOznB2hWtmdiaqDm+OSStPiI/L8CaVBNWIWKRcpBFTYz1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkzqV0CR;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E8606A31A;
	Fri, 30 Oct 2026 16:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B52E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkzqV0CR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793378741; x=1824914741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kE9uI+Yq5hb2KQeUlMOY3SACGrJR3VzscpJKaJfCCg=;
  b=MkzqV0CRFI4sbP1um8MMiaBqkB8YgKAQmJ95DCtyvLWqS8uzFmwDCobC
   hln6f3x6Pir6eTdXiROrpup85wwjFNjJ1borqNaFl0CApFBF1djFNNg0T
   /VSA7Abug9eGfEkSuiNILHd4iEc4F0glqji1nFLjLC6wuAvB7VBM1YCPu
   i+CO8KR/3PV/4QLUMF0n3FOzsKeBWZK0er4XY0CnhSQn2pWjptcqdWkkq
   12tTKr5mspMAQ4hW9Z7EF4alyjAik+QXRjY7l2nk5SIaIKRf55krBz4I8
   gB4A+Y6scFYKjgCe4K526k9LvUHXUCLlxgWq+OFM6uQ/bLdJOO4XzbdRu
   A==;
X-CSE-ConnectionGUID: ozPoz8SATqeqcYKT0rTDOw==
X-CSE-MsgGUID: bCGV6U2xTM+WtdqQAZ+Z5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2138886"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2138886"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:45:41 -0700
X-CSE-ConnectionGUID: 8J5ApM4lQnSMsdV+wsT08Q==
X-CSE-MsgGUID: VJQC52enTUGCsReZUS6VJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5805543"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:45:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 09:45:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 09:45:40 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 09:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaIMecAhe2K9H1VRdhTUqGnjB1Rf1Bcbzx0DSVK69OikE+599UzkkalKz2UdXLEDvSKm4o94bYegShmEVxNALGz+jyNVgXstGvUmtUCk3boGjpZVtRDxabXR8gMDNQbvHhfYzibbU5oOxjJe4/Y635vmpESc5nE1UoXvT3yJIDpYoLTfKzecs7z7B4nnDlfa5E79m831zhIpqXYa1s7t5wIp7V1u7EnWAm/OoGeGqHX/hXOWIlweVoeqolBgbLjw2hJjHCUeIGvGO8Sc6oFzEhspurdQ8lkCAHzECcOOgkGdFMy8wMiedQhf3rC0VXWoFjyxUQeJzJirY1gorojisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKQvliR5e0K06ZPmVSw4IJ2fJ5Q1QY5VJJUQTdxS1CU=;
 b=v5EG/G5/oApXeJaHUcKSVGuhBH6UupOUFVs2AUt5SbACMUkaISdYmzVMpVNUPKKU+0PSLaqEiM5EHm0SyrUL39jmURHHvgp0BGEDMH9esYhBva3GQb5fVagvrkaOtwH0kBli58pY7zuKwPg5u5Ip7Z9Cez9P/Qdjuu+uYdzR0P0tXViqg7x4W0KsZ9x9Ybxg9RpUR9LoGw7fH7Qv6gC8Ggn02nb/nz3kS5ap4S+rH1ypwtPPYvmhO5mlN8BewJ13y6Yuxl8vzJ62V29wpyNNwnDmkYYGbB6E3RAvdBv5uh0hOwYvij34QXYiZ+b2InTL0lXNopDv2Bnn6csic+zaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6979.namprd11.prod.outlook.com (2603:10b6:510:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 16:45:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 16:45:37 +0000
Message-ID: <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
Date: Fri, 30 Oct 2026 18:45:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time
 for StarFive JHB100
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
 <20261014121222.31385-3-changhuang.liang@starfivetech.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261014121222.31385-3-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0186.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::11) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8effe587-5cdc-4e02-aa35-08df36a5396b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026121527099003|10067099003|56012099006|4143699003|11063799006|261021121427099003|261022105027099003|261009223027099003|261022075727099003|261021123027099003|22082099003|18002099003|261026140227099003|6133799003|261028144727099003;
X-Microsoft-Antispam-Message-Info: re66CKFn82+PhtP25VGmPTDJNcy5HxShsbKc6idU82qaFeF7izxgqV1dVx1YyM9cPJxFUDkQEBEeSKF8nfVbaSJy0r8TZaA1sN1nk2ILvXVtExqyk5rC+ZiSWJeJNMwFkdkDFVovrPgyw8n7FciJNbOXimwS5pYq84ZAQk6UZpsxdoy/YZqZpvIvVJp23TBl4kYPogoNIN/DykFio8/CUtbhyy2yMiu6RgtSNRZS8i/jkB8KOK8P6br3JWCq0u11JY/WEAo+xxCEhGDxCIKbSRwcyU5otktmvvT9p+8lZgcaH0Bj+tGIhyadJkUSLA7g6NcMklcUXMQDImwqovFjR5BXWWzMsgo7DMv9+yhl+nUZ/cRrNyi2rzVu6R7kc3QDdRzM4ig9Hp9Pb5Ly5IfjtETnYPl+ruVeLmZoPYEB9nf5B6/szI6WL6MQ5jJEuZeBgkgrnlD+/wy8FgYZI2HqHszOI5D9CUnBU6G7T2QukjoUFthoqY0pAU5q7dad4GdQ/PIDFtmutHpm5uzFgnU18TfirkBSZCbp6ri0f98CPdtRClwCtn9YsbW4cwwT3CGjxNbO7kocVdvwTNNigz5AhJWNPRECY7FPz5Hv8W3DPuBwd2P0J8C7r8yDr9epLfb56SVIzBNF6ZnrPk++dnnv1wpjLMoSO7jtbteKeHRwU1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026121527099003)(10067099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021123027099003)(22082099003)(18002099003)(261026140227099003)(6133799003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxXWlN0SzA5SWxqNGdjN2RqbHVKMURNVzZOVDl5bWx3ajhOQUh4RnNqSllQ?=
 =?utf-8?B?TS9rQ3R6SURWRVJXR2NDakRTeFNGRlVlVXA4bmFMMCtLai9nZDFzdDMxYUsz?=
 =?utf-8?B?ci9OTXFiaEhPNmtQc1ZOeTBydU1VeW90a2JGdG03VXpqVXFQVkVNMkQySFdE?=
 =?utf-8?B?UW9EdHluaGdRZldSUTlGMXdEQUwvZzJ1ZWVBWlpvRWd2bzR3VVVQckZRbkNH?=
 =?utf-8?B?SHo5cWpkdXdzb3BHeVlyOWhSL2JaK0JOb1p6U3Bua1M1Tjl3L1FpRXJIbjVG?=
 =?utf-8?B?aFBXclZyQ2xvT1k2cklncmYyR0tvTU45MDUreHZUbDJMemJWcFNEQlF3cFlM?=
 =?utf-8?B?SzdFcXJiQ0p6dEJiOGo2YXYxaVZtM0t3U1hGdkhYQzlhM2Y0MExvdnZwRGxQ?=
 =?utf-8?B?NEVmWE81NS9nRnBlYm5VQzg5NG1RN1k1SW1nNGhUMEV5SGRmQ281S0pnMHc2?=
 =?utf-8?B?alg3b2NUY0M1U0JoZzZxMGc0WDE4T2NqcEM2eE1lSTFweFZUMHRDQUJPeEVR?=
 =?utf-8?B?akIzc3lKcXVNRHNNZjZFMWMwcWF5Y2IyTFhaakJhVFVjcGRVNWNFVkhQN0xL?=
 =?utf-8?B?Mkl3NWNRMVZBelBRRjJHUnFBMW8xNFNNckdQSTJSUnNheHZQc0xtc2J5MHY0?=
 =?utf-8?B?Q0JlV3h3cEUyd2t6UWh1SUlFV0ZpRXBWZWhnZ21Id0ZrYlV1UVBQYk5vWU01?=
 =?utf-8?B?ZHRrMkNYVk9FVnRqdVBSM1FkNDNJcGQ5RFpHWENMTXM1ZlJ5QURuUzM0U0JJ?=
 =?utf-8?B?SEhZVE1MalViUWNsYmdXeGNPRDQ1SS9IajU5UXR2WTBGVEVNRWVLZUFMUU1l?=
 =?utf-8?B?cXNUOGFtaE1WdjhRWm8ybEhDR2pjcVVCZGR0MU96WjF5ZVkweU5HUnQ4VXFN?=
 =?utf-8?B?dERRMER0NC9TVkpLWExYalRBQ1BFWGVHZElkU2NZeG1xbThVV2FJM2dKYW14?=
 =?utf-8?B?THlQRlZaQVRkOEprU1NyU3VaQTZVSmUwaFZMRjVNYVdGZHpuSXNvWklacTZF?=
 =?utf-8?B?bWsvdGRxd1lZbnp3N3lSSGhYREYvZFFNekpZNTFRTW92VkluNW9tQTlQdmN0?=
 =?utf-8?B?WHEzOXpmdXpaMEdqWFFxaXZiUnc2NGV4RVVDSHc1bGFQZFk0OVBJYjZjcVRU?=
 =?utf-8?B?dHRKQUxPajZHVGRjSWdIMDZCaUZ6QUNOQ05veDZnRWN0aU5VMlY5QnViaHF1?=
 =?utf-8?B?dEJPSGc3WThSQmN0bnA4aXpjcjZ2YllWSUhhT0wrS2hLc2Y3YnVLK1MyalFK?=
 =?utf-8?B?bFJFZ0g1VW9ZVWEyOGZzVU9mMSt4Y2ROdFN5d2hSVmY5ZTdFQmFYc3dYSDRt?=
 =?utf-8?B?d1BmZThOUDRvSzZuVFM0Y2kyd2h0SzJEQ3NQUkp5ajhCVU15OW55dmtkYVFx?=
 =?utf-8?B?WEluR1QrUzZFUXQrR3J6cm1kYStoNVhlU0RGbzRRVU9zcHFqOWUvZTVzR000?=
 =?utf-8?B?OUpSTjNvcW9Kd2xqVWUrNzlmY0JCazYyc0NqN1NOQU9Yc3ZtemQ4cHNUU2hO?=
 =?utf-8?B?SnRnOVB6S1dWeiswY3pCMzdPanpkNVpOb0d6bjlzWXZBN0pRMHZyYkk1UGZv?=
 =?utf-8?B?dnE1TlBwQ05CQnNHVFozSjZWeTRVbWtrODQvZXF2UXBWeEoxQ3MzOWh1U1V2?=
 =?utf-8?B?eWNhb2R4b1BRRDM4ZlhyZUFqU0xuYVZ6RnZhbUV2WUV4c1VmZkRYL0prdXp6?=
 =?utf-8?B?NmlnalJMU3JsdkFkNU56TGllNHlhd2srVFB6WWpQZHhGelRIR0hzTlRsTnh5?=
 =?utf-8?B?NXhxM0xBVzI1U2RJMXc1MTZrNEVwcEpONUxjL1Y1WVJLT1Y4amhvbXluMjhM?=
 =?utf-8?B?aE1RRHJBWFcxcmZiOHZiUW5DRno2QmE0aEhKNnhSQ0xUbXVwR3pQbU91anBk?=
 =?utf-8?B?NVJEN2xZb2diQ3ZRRjVMcDRDelc4TldnencxbVB0SFA0amVHeHNWYzVJRGpU?=
 =?utf-8?B?M0dTTDVTSjFIdnZTa051UXViN05WZ3VZOSttMFdTdlRsclFYRXZsWnd1SFVl?=
 =?utf-8?B?bnA0OUdRWFQrenNLWHJzVCs4T2hlRzErZlAwc3lCQytmdXg1SHVOL2RqemJa?=
 =?utf-8?B?U2hGbThEK3JUcmx6b0gyYnMzczJkOVFyTlZONk5vdVlwUC82Zis5VlhaSjlF?=
 =?utf-8?B?ZWIvUnlET3llRkkwUXBkbis4RmJBU2U2TUpCVkpjcStDRTk0RUhWbnF6Rjls?=
 =?utf-8?B?YWgwazdtczZCN2JOeWtXN3ZlZmsvdXZPUFJDdjNlYWtvZVJsWXArUDNJbWRM?=
 =?utf-8?B?YnJwcVJESTU2engvNGZ6R3VuNE5zRGNYNnNIWXIzUTdrZnNKRHc4cGt0eHk5?=
 =?utf-8?B?dE1ZS3U4TTZaWVp5OHBsTjlYOVFvSHhsWGM2eUxLL1NZb1lZVW1WTjVHbjl3?=
 =?utf-8?Q?iggG8b9WC6qOLwUI=3D?=
X-Exchange-RoutingPolicyChecked: kZZVBWHVhX/22XYBa/dsZ13Pr7P1fwCrDkYyZAaODvGC5sbtf6KaWq2DgvOqSORgwHOlyv4XB1HDjGeDqF5QayfbCaL+h+bXCDjFEgiRbKHBb+yodtAJm5GwTdNUQkxwwgvpipUrYZV0FaMtZp/e6W0nW4QaEqg9l1GWyW6NCwfq72xm0FaYHBsX9kx1xtcDslzSsp4wey+2u5JL2+7XhgqC4t125UxolRSdzvqNm/IBHoDFwxDnuzMStk3Pc+3YELV1YF05WCD7RjIXQE6wiqhMj8O1XXumAKF2fSMZgFzw+/yP+KX37pl2PAv3KgMqc9ImxTUTdwwSsZtQmFc1jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8effe587-5cdc-4e02-aa35-08df36a5396b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:45:37.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q1oCF8mM39HMolFioHOcWwFng6+sIOzQwthrSdm35V89hA4Tzww/e3HMOTej1d3kCTYQJE8THdc1+EpuGve3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6979
X-OriginatorOrg: intel.com

+ Shawn

On 14/10/2026 15:12, Changhuang Liang wrote:
> Add a cqhci_host_ops for the StarFive JHB100 platform that sets the
> CQHCI command idle time (CIT) to 320 ns during pre_enable.
> 
> Setting the command idle time improves eMMC performance on this
> platform. Before/after dd results:
> 
> before:
> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
> 
> after:
> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 249055f14162..36628b44f78b 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -283,6 +283,8 @@
>  #define PHY_DELAY_CODE_SD		0x55
>  #define PHY_DELAY_CODE_SDIO		0x29
>  
> +/* CIT for the JHB100 SoC */
> +#define JHB100_CQHCI_CIT_NS	320
>  struct rk35xx_priv {
>  	struct reset_control *reset;
>  	u8 txclk_tapnum;
> @@ -2340,6 +2342,25 @@ static const struct sdhci_ops starfive_jhb100_ops = {
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  
> +static void dwcmshc_starfive_jhb100_pre_enable(struct mmc_host *mmc)
> +{
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	int ret;
> +
> +	ret = cqhci_set_cmd_idle_time(cq_host, JHB100_CQHCI_CIT_NS);

Currently doing this from ->pre_enable() leaves a gap.  It needs:

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a466cd88b043..e1bf6d50e8eb 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -283,6 +283,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_set_irqs(cq_host, 0);
 
+	if (cq_host->ops->pre_enable)
+		cq_host->ops->pre_enable(mmc);
+
 	cqcfg |= CQHCI_ENABLE;
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);

which is probably:

Fixes: 79cf71c0b177 ("mmc: sdhci-of-dwcmshc: reduce CIT for better performance")

Shawn?


Going forward, it would probably be simpler to put 'cit' in
struct cqhci_host and write it, if it is not 0, in __cqhci_enable()
e.g.

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a466cd88b043..d5f8b427e1f8 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -279,6 +279,14 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
 		     CQHCI_TDLBAU);
 
+	if (cq_host->cit) {
+		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
+
+		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
+		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
+		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
+	}
+
 	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
 
 	cqhci_set_irqs(cq_host, 0);

> +	if (ret)
> +		dev_warn_once(mmc_dev(mmc),
> +			      "failed to set CQE command idle time: %d\n", ret);
> +}
> +
> +static const struct cqhci_host_ops starfive_jhb100_cqhci_ops = {
> +	.enable			= dwcmshc_sdhci_cqe_enable,
> +	.disable		= sdhci_cqe_disable,
> +	.pre_enable		= dwcmshc_starfive_jhb100_pre_enable,
> +	.dumpregs		= dwcmshc_cqhci_dumpregs,
> +	.set_tran_desc		= dwcmshc_set_tran_desc,
> +};
> +
>  static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
>  					struct dwcmshc_priv *dwc_priv)
>  {
> @@ -2412,6 +2433,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
>  		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
> +	.cqhci_host_ops = &starfive_jhb100_cqhci_ops,
>  	.init = dwcmshc_starfive_jhb100_init,
>  	.deinit = dwcmshc_starfive_jhb100_deinit,
>  };

