Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85A3E1CED;
	Wed,  9 Sep 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938142; cv=fail; b=H2zFvp1KjAViUCaB6iCKFIwGXxmQ98GPt4VrtIwikAlHCy+24589fWl3fp9SQNOuWLbAIHkVaIT5fiiTWjMiMPmyKdzWFSosVr5mJP/seamxrvrmN/UbJPjNr2TWCMnFN7QnJEavnUgg0crPhyRudYL13BifejfnPlbzTOg3xa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938142; c=relaxed/simple;
	bh=D7EqTenqoG2H8gZSzUJJd+sPYsI0gSPb0ZNf9+4iN8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZG+0Hgjoy8V6qpXT3FmqPDvomoNaEggF6vHch5ZSf8X7GAbOLEMPJ83PEFH33LTcQQOptv6XIzP+lpo3E1hwxxsYoaRA8Fs8X2wEIoNhXUMMUEXtBr9Hx3hLiI8n/1QejHQ7pDR0TtSVHOAGNgUDw6fhUl01O11s3siAF1iHSck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqh9q4aZ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqh9q4aZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788938138; x=1820474138;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D7EqTenqoG2H8gZSzUJJd+sPYsI0gSPb0ZNf9+4iN8s=;
  b=Kqh9q4aZc583sKwPeI8hEz56W+xQ4cqZ4pBnmdtCkSKrsEbbJM52n7VC
   nmez0a1QEEhZhqtQumRg+aI11Pjohq42yp9wICcFUu0uQfRFL0tovCqcM
   AswV/PcSkCZqFbQi5aEInAVj7eOADrQkQbOAlO0GNqNkw6FWtERsYNqB6
   5HkUDs8eE246kfvlmLMKNmwvJ2Q5GQ4dU8Bnk3k/VrUDNzRgm+sYd+kqp
   Hle0hvrUyHdRLXQ5nkJtsZCcMY3WLcpU+j0+yhGr0UjrSui1teL5QbnWj
   cPcYpQKqjtt3Qe2ZZ7oPeUhclJWpnoDMR4maVLnQlbob1I0QsSZGG+p6X
   g==;
X-CSE-ConnectionGUID: H7VLWNZ2QMyx8C/q0w/rMg==
X-CSE-MsgGUID: +rs3HKqJQ/GKEBIOc0f/eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99946254"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="99946254"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:15:33 -0700
X-CSE-ConnectionGUID: 5cZxp0FaTY69qrv+bYMcXQ==
X-CSE-MsgGUID: Ux+2KjmQR7u+BSuZodQW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="309496369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:15:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 00:15:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 00:15:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 00:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp5vqgOGtMHxEE/OtNODBg7bGhuVWSmRkBTe4804olK6qWfJ3IAqrf3HZXHiNuk/QWZ1ssrdpDXglZ4a7c3gNoB1XeL3gMQ+GU9/UBLEfYegDrkz0himFpGQ06SRWNjW6SmbpomYDzr/NW4/zAmDqXX79WIu8a5oMjyEUJFin3FMtPHSNiExiQF5HREjXDdwLB9qOheRsVLbCt1Ox4Ck9Jyjf74NZKb+ZJzxxA+CQxQ94Xk/+/SmpQqyCRxSBKFkp/xvgzajmh9lBQiZDc5QIXpw550dtTMvusYbZTf98b2dCNm1Cmxh3wkcjvKOpdGrItgJyKUSEZfTYuDIoQclkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O+ilrLKfyxoEpogke7OWR6mR3C84+F6vJXTmGBtriA=;
 b=LswMrwbJC0BXmZtuqz/IeOl7J77yKj3rKtW1LmHTkL60l0xMdGNxEKI4jba8hzvJ65ijGE2r4B0w87CtbeqZk+W0PAlsggC0ZTI5ykaVOGRbOm4/kiZKzqLKEC1DDJ90/HPR/PmpzXAeFyHEYLo0JDJg0jfG7l4s55rqImNIj79VdT2pOyRO2VayW+Nw9j11o1XLvtWmx/7L7HmP4NYZLtybSpRlPVOHyjQQGo2xO53GH5v945jPR/Ori2owUJbKhxkHVVgiN7DGatoTbzfh0tgQnCnicYe10ZgrEsuS8IazxQUMhtQzNHqkF+/zc/Pf110Ogi5W/z+vtUUhWDktRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 07:15:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:15:24 +0000
Message-ID: <a6daf796-752d-4ace-bdaa-8629a7bb47c9@intel.com>
Date: Wed, 9 Sep 2026 10:15:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pxav3: disable clock inversion for SD HS cards
To: Rosen Penev <rosenp@gmail.com>, <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulfh@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Karel Balej <balejk@matfyz.cz>, =?UTF-8?Q?Duje_Mihanovi=C4=87?=
	<duje@dujemihanovic.xyz>
References: <20260901003816.48460-1-rosenp@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260901003816.48460-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a3b057-cd0d-4ea7-0367-08df0e421dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RIPIslT783GkzozOfwfr2uOm9dsNL3MmVquEko8hyarIdHvu/VK/k/78TnTjas1RJTx+qwMG/HIPoL98mwj8xnKK42lbwNAjuIzgQXlylUehcjeqjQGpT8DKsrks+5JCjD1v4G7A4n3uX498TNW6MzeiI+/2cbM13xwOqYeKu16WrsDplAvw80PrNOimfv7O1gru8HOX+yFG6GyBsFt2drIYM6ZrrBGpAEnVEuB4VnTupQNiFieZ95lHJbteFmwS1/Jc/wDjbIIOjZX8g7JmiPkxOa3nLvJZyz9rF+CjKpvlFvJhY7lqfjrF7xhMHiLBIPPYRzmJyrakMKErFW4fgj9KY+/uOdjyrL3xSiF0pBALM32cyw50FAdLlSs9b17SYW44Al1nhEecXlNdymGFsyM1uypKIt1oze9QPJbCXZL3UG/iaru2mqvD9Zbqsci48WPcUi5/ud5bmyqOaV1ezKJmVRwebTtr5wiUXQpAcRAFkHOi6Nl4w7SDg7kdSP9oPuTp2O4DCrXR5GX9DVwQMSqo4grM3H8FYt1ggkFHf7pR8goYjCLKCSvlKwvvNco9LyCZmYGScGJyH13PvoJutEapIVwpgmwxgLRGon6TtGwPLpTMc36ker0PB/8oElImzOWQrc6LNZxZFs9sN6tOYKoNnTRo6T+3kMYjcQ+Sd1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elN0RVFJNzY3Sll4Tzl4SC9vNjYwd2o3YTZoUHEvdENnSUJYbXhXekxnNmpn?=
 =?utf-8?B?WW02OTRjZWtqTnlrc01RSmt5bm11TGI5NTFCay9Oem43Q3lwYUltckJ6dUpI?=
 =?utf-8?B?cFhCTlhUZUkzTEtaMjRGY1Q4WTlqZmZDQWREczVLdThSVldvK3lxMHF2Z0Ju?=
 =?utf-8?B?T2RxdWlmZ2dEWGRNTHNnSDl1S0pyMmZQM2hNZkNCMWtnNWhjeFR5UUhsTWw3?=
 =?utf-8?B?Y3luYmRLTHVaeUFrbmNQOTEzVGZTQkkwK3Fqdmg0QjZoR3FTZkpRMWYzc1ow?=
 =?utf-8?B?SUg3MlVET05hYlNIbGU4cjR2MW5WRDRLNzVURG9rTHFzbHJaR2FtRHJ0WHZ1?=
 =?utf-8?B?c2lYaVNHOGZpcUVkZi9IQmFvRHhZNkE3ZHNOZTJibFQ1aHpNQ09NVGx1cW5L?=
 =?utf-8?B?K2tBV2pBcWJmRk9EbUdqUy9RMlN1c3ZORWU1TU1NUEJrV1ZYQUJ1Ulpnblc4?=
 =?utf-8?B?MElwOFB5K0lpYW1yMlVuMit5UVF5N3NWdjFQVEtmaVZ3dFlxR3VJTUdPVE9P?=
 =?utf-8?B?Z3BzS1dCNXQ0OUl5ZHNMSnNGSVlVS2xKL1FDVUdUaFFOTDBqY3ZkcjRFZkV1?=
 =?utf-8?B?OVA5TU1nWitQWWFSWDVFVlFKTmdZSmhsMDV3SzJ4NVNpcDUxY2hwaFE1bXBl?=
 =?utf-8?B?SHhSam4xYUVlWElMclpqMVMvakJWQlBZb3FaSm01bm4rWDh0K0M2dWQrLzVU?=
 =?utf-8?B?MWtKWWxnVkwxQ0lWbkdaSUZhNDF3T1R6dWtiNTdzaGFJc2YyR1FwZ3h0clpQ?=
 =?utf-8?B?bXYvZWt6VzJIU0VzRGg2OTZuaU9mZjV4cmhBcTRTSXJJUnRpYmgzQ09wUFAv?=
 =?utf-8?B?Z0tMVG9KMXEyQ1R0V3JUV3RXZVlCM2hJK293OGZpbUVEQk5hczI4WDQvZmRk?=
 =?utf-8?B?QkpjUUVsZTdSVEpuRFFTdkFURmpvUVdGMVJIRTM3dW40bXdxQ1RoTDdwQXVj?=
 =?utf-8?B?RWdLdFJOZFhpTWFNVVJzMU43UEFKSGEwUmh2NG9URWxLVWxJMFJwZFFIOXlB?=
 =?utf-8?B?U3lWL3dxQlpHMTVwQzhtaForSEJ0aDhIaTZlR2hJMkhPd0dpWWN1LzRzR1dw?=
 =?utf-8?B?bDhaTCtzajVoWjJmK1dsbGZXTnpXYm5HcmdwZ0xQcFZjYmMvN2RjNERmQkVk?=
 =?utf-8?B?ODdhakM1bHIrdDI0U1Y5aVFaV25weENXUzlZOXRUV1B1YlhJMXJVMzBFdHlM?=
 =?utf-8?B?YTRaOFNSbTdXMjF3WFBGL0pwWmxJNWpabEJsYUJUek1pd014V210K3ZoQnhK?=
 =?utf-8?B?R1dyd0YzY0NoTGl0bkpUMlNmRmVBWmUxUStGOUFVd253UloybW5VQm9QdEpQ?=
 =?utf-8?B?YUhNdjZ3QUE3bjB3T05tbE8xMDJhZW1YNnRPY1ltRnpJR1czZFJoa0VubjMx?=
 =?utf-8?B?TVY5bFMxenRZOVhMeHJOckVJU3AwSU1reXNBRFlIVzBOc2RxZy9QbXdObjlL?=
 =?utf-8?B?Sk5aWnhKMnB6R1pwWlRncWwyMVFjcGVZUlg5RUpSM09jY3ZaTk9QdVZOK3FQ?=
 =?utf-8?B?MFBOSWxoZUorUXY5TkV0U1VCT3p5UU1reEFvaXVLOHF0V1JIZ3Rhd09NYW5I?=
 =?utf-8?B?VVNqZSsvNnpzTVhOY1JxSDdudkZla3RkZTNod3g4ekpmWVZJUTlDOGVhZXJX?=
 =?utf-8?B?ZkdvVEEydlh6NkphQnBtZkVLUlhOWldWckFXRmp6ci9zRElnQW5tNjNuQ1gz?=
 =?utf-8?B?WERqOEEwc0hOZFh1Y3FtS3ZYcHJDOENqN3FYRXRoY1lFeHliV0IrTlVIQ1J0?=
 =?utf-8?B?SkxVa0RUeWIySlFqVHltWmFRdVp6T0k3c2lPUmNweU12QWwrZjNLaU5mc1VW?=
 =?utf-8?B?cUhEWkpFUWEzS2JFNTFkV3ByOTlRQXpUNTFDMENhNWZ5ejdIWFU5bDdsV2wr?=
 =?utf-8?B?QmtIUWdSS2E2bHBMOVZKZEJpNEpEaUEvZi9VY28zK2RzalRWM3RHQlhHUXpa?=
 =?utf-8?B?V1JMS1JWVkQzeE9SSy9BSGhmQlUvSUpEaU5scFN4YTI2UU9pdHZNMVBsVjE5?=
 =?utf-8?B?TExUMjVEK3ZXUEQvOTZTeWoxT2x6TGYwWFpUaDNsR3gxeXRtSjRROUtBLzJE?=
 =?utf-8?B?UFZDK2VDWlFWYm85STYvYi9vaFVicEZxL2ZSNVdTcmppK3VaWDRJZEE1anJD?=
 =?utf-8?B?QUJiNmxBKzUrNHhpQnFyZ0k1bHVGWllZZ01xTTl3eEljU3JQZ2todERUbjRa?=
 =?utf-8?B?VkRKVDFoSkVndnFCbk5RUVpmYzlOSzVUK2FWS0RUSDV1aTU3VGxQS09SbWRP?=
 =?utf-8?B?cmdKWGxwR1RJWEI4UWo5Qlh1YkVEUTgzRlZNMm80ejcrTys3U1ZUUmxEWWd2?=
 =?utf-8?B?cm0rQi8xam1BaEQzMWNiNE9tbVR3VkRuZTFPZWNPQUhFOEtvTmpjdkFPVW5C?=
 =?utf-8?Q?OW7h/TpP44WL7EbU=3D?=
X-Exchange-RoutingPolicyChecked: NH/ACVGNdzjk8eQvmUEyGyDWwCT6LsP1XCbQA1+W03BF3kyY/E3LQ2th4L+1T6o4Vjxq1P0zxtWaQNvxEV/0BHbMYehxOjddyLspYJBbuJ7RtHUJuBpEJZprNUT8vmtP6YtGIvXXCOJ3Eqku5VSHXQHolO5RESYiK0VtALg/QQWkA0qgP6Sid2da2eKZLzeR35njbew8rivSBKB1LD1yah4nqLuU3797PO+E/eLplYfFCnxDTH7Q9alX2s6sfary5gzvQbwDmBtp2yI1jlI4mJfATNLjS9L1KikBoSt9BSSrm0gBtTp4/MEO5PBC/4pVF3okOrRfbGj7Y4JDQbqPgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a3b057-cd0d-4ea7-0367-08df0e421dbb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:15:24.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs60l0YkcuCbE8fdkzRGKg5AXbrt0W42K1SLcx4FURVf2P0zf524Ys1FHa77HKQURiBCgEb1jUDdhDFUu/5jVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com

On 01/09/2026 03:38, Rosen Penev wrote:
> The SDIO3 Configuration register branch of pxav3_set_uhs_signaling()
> only clears the clock-inversion and feedback-clock bits for
> MMC_TIMING_MMC_HS.  As a result, MMC_TIMING_SD_HS (ordinary SD High
> Speed) falls through to the default case, which sets SDIO3_CONF_CLK_INV
> and leaves the feedback clock cleared.
> 
> According to erratum FE-2946959, clock inversion is only needed for
> slow frequencies when the card hold-time requirement is high and is not
> required nor desirable for high-speed modes.  SD High Speed runs at 50
> MHz, so the same timing argument that applies to MMC High Speed holds.
> Treat MMC_TIMING_SD_HS the same as MMC_TIMING_MMC_HS and clear the
> clock-inversion and feedback-clock bits for both.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index db9dfa92cb57..9e6703e005e2 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -284,7 +284,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  		    uhs == MMC_TIMING_UHS_DDR50) {
>  			reg_val &= ~SDIO3_CONF_CLK_INV;
>  			reg_val |= SDIO3_CONF_SD_FB_CLK;
> -		} else if (uhs == MMC_TIMING_MMC_HS) {
> +		} else if (uhs == MMC_TIMING_MMC_HS ||
> +			   uhs == MMC_TIMING_SD_HS) {
>  			reg_val &= ~SDIO3_CONF_CLK_INV;
>  			reg_val &= ~SDIO3_CONF_SD_FB_CLK;
>  		} else {

