Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC739446B
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619011; cv=fail; b=P8i5Yqus4Z7Q2BrIDRFnERij8vgnN4SuiCYXn2jHGapKzziuiA91OTLXw2tA/j69eJE7XAo9qmUbjik1FlV2TfrqLb4CLWBGFRzMb37OjZ/q6aHv/qgpRQk8yuXYyUCSuV9wZmLfqX7ABOevdmX37DoNpzLptjlfU24TTbiXGrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619011; c=relaxed/simple;
	bh=OafFnBKWcQRU7EuhvigqJ9gJwV/7Jl00Te/9ZgCW5xo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ol6/iGvRjXCSBP4WB/OaP/Sr/gITII8+YCTev6asZZQALn7Li1KW8tZo8ZohiISBQ94I9m3EHavvT7Rr2LO9Bl+6nCHckbFTdYeO32CdaO/ME/4JJo/wcs667kV43KTJsr50jC6EG+2WC9UeWPiE6WKv7F4WYkI4BNda++my9F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blLMo9yl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blLMo9yl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774619008; x=1806155008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OafFnBKWcQRU7EuhvigqJ9gJwV/7Jl00Te/9ZgCW5xo=;
  b=blLMo9ylOh8DIJU9ROpk9SC0RVIJ4kkUEXHTrzZdx0egNJInXQBRs1HK
   FUOndeBoxYKocaz/EqW0JqvuSp0uAmNQNR1BoFfYkT7/V2ADHLBsDoXBK
   ElMR0G3fNuGZHxf62gv87IzsDAhEHIxtf+s/lznOK8lG1sIz9XeYv2p3+
   n5yI2IZSHoc5ao3cGUI9ioCBQLtGq3wQW3HS2nYd8fcfMIiR4nhArRrgO
   Vzv7P7aN5mY63oUyKRuYusk7K/vUp485+O2EjZLYLPKxjNUoyeQz+G+cj
   qVxuT3tFqyQ+gT1AehgfgCsBKVGZWG9DCbg8rfRoVUSBxnkcymXG08bLc
   g==;
X-CSE-ConnectionGUID: FDJ4bayXRaeGY0j7t/X1pA==
X-CSE-MsgGUID: eCvXJA8BR1S2fwCmIDwskg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75594600"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75594600"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 06:43:27 -0700
X-CSE-ConnectionGUID: gM1OlNFLStyaHZiNWRIq6w==
X-CSE-MsgGUID: WZKiTwWhS6WjRbnIXvcrUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="226918404"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 06:43:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:43:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 06:43:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVWLaIr5UIIioeAU7L9e20I47zv8mdgTfVnYzAoCu86cdS1nLb+C4Y4euOvwtSOL5ad3uf8iYLWgchcVMqKRS4Tfy7tAZ+cVgkgE7LHydJ8FoUbaF/BA2ejsxx2gJLlzPyKMZrq7huNlSlpRWp5vmx25nTa+zJ1RcMZFLG7JR+9YQ0VnO+1Gd8+XwKm9QJ3JBeNHDmZq1xPIR3IJ8VWaJpl8ckPoQiEwKQ2t2Qn7/Jxw4PvdO+y2r18koIYFUUtlmhwkFzake3MCrYqz7/qo+Phv6jP5KmiCtyLT/fB6RAGb1Ft6Y92fKpcAmCx0H/eOmdBAtLleDzMTMJi8TlTvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pbkPH1uUaQJG74Lko0+4/p3afZ9E5TIO+22/hWq1no=;
 b=mT668umLphOFzAyiMs2S7fTi8sKnQJpgEe85q+c7aK+fuMZJRMKpvDpXIjKfH8jLeSX20ANrTNUbB9pq+quEqSJoaO4k89vLYgKiXevgSrfkpmVL6fsZ9YqsspaNYU6CfwuiBZ2NLZeGBC8BQU+EDiseLbnJXV1xnnxP/+vW0MOzjXawKvtnTnb4i/DbNDz2g7Zj3QKGU3heUQp6wKVC+dRY5zKRToeq1hn5sypp9uT+rbhbOAr+tczd4r2WVB92Jv+IDiC4x3glCCye7XbzVmgcyPvIiwV9oFnsk92Q0vyrPVMe+PwisKaIVzsEl1Uwa1GzhNoFqJawePNXyoJ06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 13:43:21 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 13:43:21 +0000
Message-ID: <45aa95eb-38ca-4d7d-847d-6b0aaeee5063@intel.com>
Date: Fri, 27 Mar 2026 15:43:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Refactor Rockchip platform data
 for controller revisions
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>, "Ulf
 Hansson" <ulf.hansson@linaro.org>
References: <1774597872-179908-1-git-send-email-shawn.lin@rock-chips.com>
 <20fe4fbb-df3d-4fa3-a595-3f446520f50f@intel.com>
 <793af56e-3a2b-632e-ed18-9a2bc0844351@rock-chips.com>
 <481b7725-2ae6-420d-adeb-acdabd113962@intel.com>
 <f3886e89-43ab-8eef-80bf-79d7d1e14812@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <f3886e89-43ab-8eef-80bf-79d7d1e14812@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::22) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dec8f9-5bac-4aaa-d72f-08de8c06cf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IBixx/fKbqPKfOchHC9KIxewXC3mJB0iOjtOtLc3tiyVganVtogJbueLMlYM9T1uq6r7es2ZSWKI0lJBkQx1DKSAlFmNhFF+Hr4OTJFD3IvXwm4EYMtERkN6fic1d2Egr25H1YhGFFUKLtOxxefJX/xIKS9MoiKFXIs+LWgMEsR7Y2TvmX9OAIhrIRFr/x7cl8SGkttT8NvyCu74kia5/zuclnlAfJ8Z2wBDpmHaZ8swhhXhti3tJDimcOxlOtVFjueZwzhVgB4BeLrOWBy87DGvg2Odr6MJkjx4qibxLYt397ww3uBOvSFIeU7Kqv8Y94bmS7tiGy5oC3PxuVIKIxnYnSx+pWpQVsRezS9XgqWkP9vwe7EaRVKRab7VdR/6o8A93BP/R5rQP+elVONWwSVfr0Gg6/NRcSz9qtXNxIZT3hjJSa2KjSmkkxxDlRMTrs55DrOU5aHOLI8PEN4sa+cM8OqY9M9bkhWABe/KrY6JxrS7h2iPy2BbwJ2hdlwJX0L+PuikOCdCTUhz0b5gpn7knzfdwTGMnvs6fHjJ8XNjdGb7KW3swbcXsOZjZ5fJXS8+5xH0TNesw4zCtG2ryaTC56J90voTrd8UcaVgk9zrNEMndNPIjjlJVXB5eGFFPLxKe5wPEhMJXnw0KSn6jNxjDCZTYyl35mIV+HPJOzW77xhK4gaXO89hoUXxsXg6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dFcHQzbytCQmxvaXdNaHhwVk5GUjY2YlFBQmdvd3JxcnhJY2ZQelJwNDFz?=
 =?utf-8?B?Yis2VHgrNkV2bEtpekcwY00wYTJIWm5kWmlMd1Vra2tQa2l5WDJTeDJUL1FI?=
 =?utf-8?B?T01CdXV3Yk9YcDJZZTE4WHhIamNSWEhhVWM3eDZrTXg2SzBtdytKanEzYk5p?=
 =?utf-8?B?S25mTWgyL21HYXcyVVVoeFN0ZWZXdWZIdlJValR2aWJnODFVTHBDYTVwL1Ra?=
 =?utf-8?B?YU03ZzNzOFdwN0J2NjJYMUlDVUFuSzY4WCtMUEFPRVNOdksybXZwditFTXNL?=
 =?utf-8?B?MGt2TTU3RDBCVTZyMDAxMnBlSFpacURTamJpMXpubVE5N2x6VzN3TDVwbHlY?=
 =?utf-8?B?dUhMMjJqVFpZeTVCck5MUitVQ2F0V1gyd2hUUlY0Nk9qMDdBdEhaRHhkMTkr?=
 =?utf-8?B?azdOZWFoSnovbTB4ckFrZitvNGdMdnpDMGVMRmhRdDRVd1BIbXBNNnFIem5x?=
 =?utf-8?B?SmFEdDNQQ1FHVUxVZkswb3VXTk9mYnEzVkF1ekJlYjRydU5RL05GZDBvRko5?=
 =?utf-8?B?S3ZkdGtCWlBuVXF0M2xkVkMweEN6c3h6eG5ydk1SQm1tMUM3dWU0dFlzYlFE?=
 =?utf-8?B?ekdJNkJhZGNKMTV6RnNER2IvNzNYeDhRaHlRL2xucnFoeDVYQnpDVmkxM09S?=
 =?utf-8?B?TWcxL1hNOHIyZlpCd2Q5a0lnN21QQlBEMUhtM01qTjNsNTVEL2oxVG1DYkYx?=
 =?utf-8?B?eVZaUHNHaXFmaXJiTEpYcCtXbzlCZkZFK0drYlk1NmJ6Nzk0MmxSYXlaMERK?=
 =?utf-8?B?OGJ2RTJOeWZQQkhNRnZ6ZTEzcGN5NjJSaWRMNlZDY1pKLzEyWkZKTzJhNlpv?=
 =?utf-8?B?OTh3RFcyeW1ZcDM2clpIQzJQQ3pZMWJQQUgyZ0NPd2JFMWYwTUZtQWdsYjg5?=
 =?utf-8?B?MDgrTlpkVjJpeGVYQXVjdTRSQk5JN1BWSG5EcDRPK0o1bWwvZ055aEt3VmM1?=
 =?utf-8?B?WDQwSUJSenVkbGxQZTBwSHJKTjYxVGh0TlplT1B3V1JYK29SRnorMXVHYzE2?=
 =?utf-8?B?amhoWHQ1eGRROEgrZHNrbURZOFpXdnI4S3RITWxvL2E4emlmcEtZK1hXYmpi?=
 =?utf-8?B?enVSc0JtK00xZlUrUE9qbGUwMkJPT2FZbUlWTG1WYjQxaUUwdjJaNDYvbnVq?=
 =?utf-8?B?aWl1T1FBYW9WTEdnS0pwaVJ0TVZJOWtxVGNVMUR6N3FKcEZJOVVhU0p4NnB5?=
 =?utf-8?B?VGczTHNBcnRKOGp2MW9pTGtwcHlxRTFRTTA1WnFleEpTRlduajk4RXNHM0Rq?=
 =?utf-8?B?ZmhDMjhQdkpObkdpTzU5ZkZvZDhrTXExaVA1eGpWT1BkTS9XaFpIY0UyYWwz?=
 =?utf-8?B?SWg2c1lmdVhnMGVWZmJMT2tjMkFmcDNXOVVMTkFlMDNBVHZpeUIva241S2Vh?=
 =?utf-8?B?QTFlY0NLUEVTRzNvQXE5cDVKd0FkZE5IdVl0dHBUdFFoTlZhdTNuOEZpbnpy?=
 =?utf-8?B?c1lwRGJFakRpMmNNdURTYkZCY3ZSNXdxUTZvdGR6cVVuNHVzbHZVVG1ESk9q?=
 =?utf-8?B?djNremt3YzlSL2Z6YUZQZTFpbW1jd25TTkVaUm5sSzlSci9rM1o2czQxMndQ?=
 =?utf-8?B?RkkxY1pmdjloVlNCN3gzaEVMTnpLRlVBQVhJVUszTHY4SEFTVHRnbUsvVk5t?=
 =?utf-8?B?STBreHJJZGRUOWljZktSdmQzZmF0LzBLNXY4R29UZGI3VnZIdTl3K2l0NTJo?=
 =?utf-8?B?L2VGcUdabmNrREhSWTdOYXZEMC9iV0p4blphRE9jVHlwdDVBaFJHUnhyamUv?=
 =?utf-8?B?TWpkOXVHMVVsdXhhbDViYkNEdmtIZUh5elpVczdXaWNhZG1wQkpIWHpDdHdY?=
 =?utf-8?B?V2FhVDdkcFpOSlhFSjlESDV1K3E2ZmhlY3o0TlRYNzZwVk9uOHUzODI3a3dk?=
 =?utf-8?B?cXFQdHVNc0d6Ym9oUEQxcVhYNUpMb3JRSEFxNWZGNEsyaisyT0RtSmRjOGlm?=
 =?utf-8?B?MStmaWsrNVFyWXhxTjVsa2Q0cWt6blZxenVVejZWbFM0Y1pvSUlEVEJsdnpI?=
 =?utf-8?B?WmdvSlNzcjc1elhEZWJVVU9SNUUzMWFKYUhwWlpWNW5ua3VRRzNpNG1MUzJ3?=
 =?utf-8?B?bSt0N1JyZUxtSDRXUXh5bnZBVFNSV0lXTmpsZCs2aTdYTVljZThyNy94YTJB?=
 =?utf-8?B?dks3U1RzS3BPK2ZSaklCVkYvemh3cGxDQnhnV1FWMVhyOFpRakVYcG11NXB1?=
 =?utf-8?B?VytjN2FhYVZ0T3BBbEJwbmNBcDhGdkZOZUtSLzlleVN2SEJaOWpsL0VVb3Jx?=
 =?utf-8?B?YVR0QjNDQzZCeUVxRkNYTzcwUm5XcmN2RWZaKzVVZXdrN3oxVVlvaERsU1dW?=
 =?utf-8?B?U0tBaHo1WHFkdEpRNG10Tk8ySkxHSmFpQklpalcvQVQ0WE5kUWUxZGkzT09Z?=
 =?utf-8?Q?dYQMr9+yCsjFtFos=3D?=
X-Exchange-RoutingPolicyChecked: SKAgbiy+EHP8a3dXhDtKlL63CsuZYXm8BSXB23h1/wB1guh3yGSZQgyHUJO7fdpWCqLGJLVV3A+On4RGluxC2QLo1NzjzO1qf9aSEOQ3vCR/3UN9QsMNxlsnJs2+2mBFPZm9vtyEzegACpO7rmQxV1eyKxZVIltTq/K3NTKdxmdYLa0npBXnT/LoOa7WTbrOq4QeJ1ZA80CAMpPLsZ4VUaW6ENwrqxZUCkqKCdUyv0L1uaSCEN+vWc2fgbeU+mTAv++N0odNdElSA2mA19zkZnFF4m9WLkZRJcvYwuvKHYyudeeje26vw8tUxxtaOyseU4d1q40QDiVhC1rQeHW4ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dec8f9-5bac-4aaa-d72f-08de8c06cf17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:43:20.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPaJ0TgR44994ySDu/69Zvu463ch7BC7Y+ubLC71n8XSTo3jTLUs1hW+c/4B8sziOUoYRaxo9tvpVDtE1gvxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com

On 27/03/2026 15:33, Shawn Lin wrote:
> 在 2026/03/27 星期五 19:34, Adrian Hunter 写道:
>> On 27/03/2026 13:28, Shawn Lin wrote:
>>> Hi Adrian
>>>
>>> 在 2026/03/27 星期五 17:29, Adrian Hunter 写道:
>>>> On 27/03/2026 09:51, Shawn Lin wrote:
>>>>> The driver previously used an enum (dwcmshc_rk_type) to distinguish
>>>>> platforms like the RK3568 and RK3588 based on DT compatible names.
>>>>> This approach is inflexible, scales poorly for future revisions or
>>>>> mixed-revision platforms, and conflates SoC names with controller
>>>>> revisions.
>>>>>
>>>>> Introduces a new struct rockchip_pltfm_data containing a dedicated
>>>>> revision field. The old enum is removed, and all code paths are
>>>>> updated to use the revision-based data.
>>>>>
>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>> ---
>>>>>
>>>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 87 ++++++++++++++++++++++---------------
>>>>>    1 file changed, 52 insertions(+), 35 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> index a91b3e7..6b43ba9 100644
>>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> @@ -278,14 +278,8 @@
>>>>>    #define PHY_DELAY_CODE_EMMC        0x17
>>>>>    #define PHY_DELAY_CODE_SD        0x55
>>>>>    -enum dwcmshc_rk_type {
>>>>> -    DWCMSHC_RK3568,
>>>>> -    DWCMSHC_RK3588,
>>>>> -};
>>>>> -
>>>>>    struct rk35xx_priv {
>>>>>        struct reset_control *reset;
>>>>> -    enum dwcmshc_rk_type devtype;
>>>>>        u8 txclk_tapnum;
>>>>>    };
>>>>>    @@ -330,6 +324,11 @@ struct k230_pltfm_data {
>>>>>        u32 write_prot_bit;
>>>>>    };
>>>>>    +struct rockchip_pltfm_data {
>>>>> +    struct dwcmshc_pltfm_data dwcmshc_pdata;
>>>>> +    int revision;
>>>>
>>>> Does this "revision" match HW specs, otherwise maybe need
>>>> to clarify where it comes from.
>>>>
>>>
>>> This "revision" originates from our internal IP development
>>> documentation, not the public chip specifications. The public manuals do not label these specific IP versions.
>>>
>>> Revision 0 (Initial IP): This is the initial version of the IP used in
>>> the RK3568 and RK3566. Post-silicon validation identified certain errata
>>> requiring workarounds, and this version lacks HS400 support.
>>>
>>> Revision 1 (Fixed IP): This is the updated IP version (with
>>> documentation number updated internally). It fixes the previous issues
>>> and adds HS400 support. This revision is used in all subsequent chips
>>> (RK3576, RK3588, etc.).
>>>
>>> Since the public specs do not expose this distinction, I believe using
>>> the internal IP development document revision is the most accurate way
>>> to differentiate the hardware behavior in software. I will add a comment
>>> in the code to clarify this origin and the specific differences between
>>> the revisions.
>>>
>>>>> +};
>>>>> +
>>>>>    static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>>>>>    {
>>>>>        u16 ctrl;
>>>>> @@ -749,6 +748,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>>        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>        struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>>>>        struct rk35xx_priv *priv = dwc_priv->priv;
>>>>> +    const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
>>>>>        u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>>>>>        u32 extra, reg;
>>>>>        int err;
>>>>> @@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>>         * we must set it in higher speed mode.
>>>>>         */
>>>>>        extra = DWCMSHC_EMMC_DLL_DLYENA;
>>>>> -    if (priv->devtype == DWCMSHC_RK3568)
>>>>> +    if (rockchip_pdata->revision == 0)
>>>>>            extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>>>>>        sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>>>>>    @@ -842,7 +842,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>>>>            host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>>>>>            txclk_tapnum = priv->txclk_tapnum;
>>>>>    -    if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>>>> +    if ((rockchip_pdata->revision == 1) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>>>>            txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
>>>>>              extra = DLL_CMDOUT_SRC_CLK_NEG |
>>>>> @@ -898,11 +898,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>>>>>        if (!priv)
>>>>>            return -ENOMEM;
>>>>>    -    if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
>>>>> -        priv->devtype = DWCMSHC_RK3588;
>>>>> -    else
>>>>> -        priv->devtype = DWCMSHC_RK3568;
>>>>> -
>>>>>        priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>>>>>        if (IS_ERR(priv->reset)) {
>>>>>            err = PTR_ERR(priv->reset);
>>>>> @@ -2115,30 +2110,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
>>>>>        .set_tran_desc    = dwcmshc_set_tran_desc,
>>>>>    };
>>>>>    -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>>>>> -    .pdata = {
>>>>> -        .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>>> -        .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> -              SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>> -        .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>> -               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
>>>>> +    .dwcmshc_pdata = {
>>>>> +        .pdata = {
>>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>> +        },
>>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>>> +        .init = dwcmshc_rk35xx_init,
>>>>> +        .postinit = dwcmshc_rk35xx_postinit,
>>>>>        },
>>>>> -    .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>>> -    .init = dwcmshc_rk35xx_init,
>>>>> -    .postinit = dwcmshc_rk35xx_postinit,
>>>>> +    .revision = 0,
>>>>>    };
>>>>>    -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>>>>> -    .pdata = {
>>>>> -        .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>>> -        .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> -              SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>> -        .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>> -               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
>>>>
>>>> Better order: sdhci_dwcmshc_rk3568_pdata, sdhci_dwcmshc_rk3576_pdata,
>>>> sdhci_dwcmshc_rk3588_pdata
>>>
>>>
>>> Sure， will do.
>>>
>>>>
>>>>> +    .dwcmshc_pdata = {
>>>>> +        .pdata = {
>>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>> +        },
>>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>>> +        .init = dwcmshc_rk35xx_init,
>>>>> +        .postinit = dwcmshc_rk35xx_postinit,
>>>>> +    },
>>>>> +    .revision = 1,
>>>>> +};
>>>>> +
>>>>> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>>>>> +    .dwcmshc_pdata = {
>>>>> +        .pdata = {
>>>>> +            .ops = &sdhci_dwcmshc_rk35xx_ops,
>>>>> +            .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> +                  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>> +            .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>> +                   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>> +        },
>>>>> +        .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>>> +        .init = dwcmshc_rk35xx_init,
>>>>> +        .postinit = dwcmshc_rk3576_postinit,
>>>>>        },
>>>>> -    .cqhci_host_ops = &rk35xx_cqhci_ops,
>>>>> -    .init = dwcmshc_rk35xx_init,
>>>>> -    .postinit = dwcmshc_rk3576_postinit,
>>>>> +    .revision = 1,
>>>>
>>>> Isn't rk3576 revision = 0 ?
>>>
>>> As explained above, rk3576 is revision 1.
>>
>> Ok, but was it behaving that way before, since the code was:
>>
>>       if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
>>           priv->devtype = DWCMSHC_RK3588;
>>       else
>>           priv->devtype = DWCMSHC_RK3568;
>>
> 
> Yes, you are absolutely right to be confused，the old code logic was indeed the root of the problem, which is why this cleanup is necessary.
> 
> As you can see in the Device Tree [1], RK3576 explicitly lists "rockchip,rk3588-dwcmshc" as a secondary compatible string to select
> DWCMSHC_RK3588(now revision 1) as the devtype.
> 
> [1] https://elixir.bootlin.com/linux/v7.0-rc5/source/arch/arm64/boot/dts/rockchip/rk3576.dtsi#L1922
> 

I guess you'll add something about that to the commit message

> 
> 
>>>
>>>>
>>>>>    };
>>>>>      static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>>>>> @@ -2309,7 +2326,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>>>>>        },
>>>>>        {
>>>>>            .compatible = "rockchip,rk3588-dwcmshc",
>>>>> -        .data = &sdhci_dwcmshc_rk35xx_pdata,
>>>>> +        .data = &sdhci_dwcmshc_rk3588_pdata,
>>>>>        },
>>>>>        {
>>>>>            .compatible = "rockchip,rk3576-dwcmshc",
>>>>> @@ -2317,7 +2334,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>>>>>        },
>>>>>        {
>>>>>            .compatible = "rockchip,rk3568-dwcmshc",
>>>>> -        .data = &sdhci_dwcmshc_rk35xx_pdata,
>>>>> +        .data = &sdhci_dwcmshc_rk3568_pdata,
>>>>>        },
>>>>>        {
>>>>>            .compatible = "snps,dwcmshc-sdhci",
>>>>
>>>>
>>
>>

