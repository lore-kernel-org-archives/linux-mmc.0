Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49125F78E;
	Tue, 11 Mar 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706419; cv=fail; b=X6PBLKGsTl6biG04w6MEOLWuXeq8SWq8zg88uwfTKy2XGCXMXizS2j2hxM1i5ULc/PaL14fUNoQbC5uAuXw9D561jIk8lGHHKzq2PcFAgPRlh4sds/fYUXzmUrlENIwnkgbWpiEwdZq7reTs7vdlSfRj+RtxI2zOOPs2d2psezg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706419; c=relaxed/simple;
	bh=S2+8ZSvBMUQ5GFUWpcljvR35BeyfWzgicSibsYz0QnU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsQn+QEbX+CbAlMSSk5l6t068j/lZBQwWsAtMItLZHkWVSpD+TT51tQTOGTdY9pYcCR3lGehKlluqhDeD0HCTjFU0/FDoTWAliiLQ6o6KxGx0q6SxMrgTxAKGjk4uMwKu3tk/TYFZ67a0SB/4QRgCX2dKumJrt2zs7C1KWciB2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI7ecpQt; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI7ecpQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741706418; x=1773242418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S2+8ZSvBMUQ5GFUWpcljvR35BeyfWzgicSibsYz0QnU=;
  b=dI7ecpQtmCWSb8yYiah9sAiVTjURzlxK5v+n04CLR2paE5KBJS+3baO4
   CbrQgXY5LHFfFUzKZsU3ytoWFwzsQevyKHhujyUarlOGqgzqSPwsz79ea
   v/WYvJmtDMXslXdCNJeqY8XRG/hPc2yn8Bp1aFXva3O7MLC/5KjBOuyfN
   SJFtVNLoOJQoY+s1B3OPwGnXDK02jIHOFcmTwnHgyoHbMZveFMSCjwUt2
   MtjlQuvE1A48BJGi/3Mma75/xzZ89d5NOlpSsvxfcbHa2/Y0es42Mo1zW
   6pD1qIuytw4lE0MLvQJk0puHlqBp5VFNbZ2ZX31wZfMSC9/p/gRALXwNO
   g==;
X-CSE-ConnectionGUID: qrjhEzPmTtueasEzHBlThg==
X-CSE-MsgGUID: +tKx7R0DTPKr4Gv6FBuW/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53391630"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53391630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:20:17 -0700
X-CSE-ConnectionGUID: gZi3iWPLRlSklJ3LfDcCBA==
X-CSE-MsgGUID: PUxykx+KTt6XlUVYLxT4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="124522448"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:20:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 08:20:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 08:20:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 08:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyTy3cjhM429Sgw8jgwNvMIwdXMCSTsivpXHchzh3zMSDFhXj+fYoqzsuPxg5A8nw8aWI2mPwIj8juldwpTCKzAHauS7mQkE0dEIo+adHFJXX9+cMPIClLy76nolm/SB5R5DbDw2n3qsvf2O7MJg1Gkyg4N33Ki7RC9cYkmL5vHe61ktjVYeiFOjOenwgc45tvlLyor3BaEqa40stv3kFpVg73fDGbmFYsfDcgaRu5mOWWztgrTt1sXCeS4d+AVmVDBHOILkkxCXSZj1qKoJYFAUOZWxnVPIU7T3ExvquB2bu46EABRw68+iXhtzjEjG+vISLPFZoh22+wau9eypkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++d36nCNxHL7DZHNfRyDCHDxS6JT7FJ7f23vGz6Phlo=;
 b=SVDXsrbBwkUcWvB4qV7sloAaACyMg+k/YRCP7fIugCnkWOSAyp8ncQTVPs5grKJDXhJnKKOJ5E8t9xR/znh0i/jZQxpOOGMOklpZwiuXEfE/vMMBLV+hF3i/W2DCS6vgxclyyTKPx+LtbQiSep3/DVXlsqLB/ZH26si8nk0ZG01lD6yEC75u/j+Vo6PdMjwwPqAo5eca3iier5SMfZfTDr6jCO4AKFfCgSq/wmD1pguOofElLhF7IskYZdWpaBeemFSMNzn1Fd3zPZ7enGjMNmi/bxbzBTZA2fiMFU3QXA2iT5e0MbRwCRvfadMMhp/Ova+kivB3nd+xy8Uz280XZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:20:12 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:20:11 +0000
Message-ID: <65238f8f-46b8-41f2-a992-0d1a150ae8c1@intel.com>
Date: Tue, 11 Mar 2025 17:20:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>,
	<cw9316.lee@samsung.com>, <dsimic@manjaro.org>, <keita.aihara@sony.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
	<ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
	<wsa+renesas@sang-engineering.com>
References: <4030ee60-b607-4ddf-99d9-5348a741f7d5@intel.com>
 <20250307211711.1289730-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250307211711.1289730-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|PH7PR11MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 81afb737-9cad-4609-ed5f-08dd60b03742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?andBQW9DL0dSeUxjTDJ4aVBuSk4xdUlDb0lVMHJnODdjMXZzTVpMTGcvbmcv?=
 =?utf-8?B?WkI0OFhidTc3aFM5cmo5YThhRVJ6Y2Q1Z3ZJL2djVHFxdU1HMW5xTWE3aG5Z?=
 =?utf-8?B?d25SSHhRZW1QdzRhVCtVY2NsWWR0SFdxWFQ0Y2VBTUplV2tQZnJHUGRXK2Rk?=
 =?utf-8?B?Um5EME1tRTR6UGN3dkhpRXBLT2gxM2I2d2RTaGo3Uk9FakxUNkE0bHdXVm01?=
 =?utf-8?B?cG54VEt3cWdyRWsvZmxUai91dzM0OWFxeVRuckhNK0xaRUNPaXgwcWRGYmdE?=
 =?utf-8?B?UTJJL1o4RU1aWDlWazRzVDk0dm1VSHpSNFQ5WDk2RWQ0RzNFZWp2OExzUWRG?=
 =?utf-8?B?UjhaZy9EZys5Q21HRTg1emlUL0pBRHVrMzgrUk4wZGNtVERNd2EwVExFQ1hL?=
 =?utf-8?B?STBpVDVuaU00U2JZaURvYVVsZGR1U29CNEJydzd5L0M0NHA1MW1tcVRpZnFR?=
 =?utf-8?B?clJhRW5NdTJ6SUlIVjhvT0Q3RFh6eGNLREtRQlc3dmdrelBqTGdNdjF1cVA2?=
 =?utf-8?B?VERueHFFWnU5azhyeTdPbjIrNHQ1TXk5c2J1YXMwcld2dHdvNmdJVG44RU1Y?=
 =?utf-8?B?S0VBMWFxczJhaFh0WUV1Qi93b3ZHYWhQN2xDVHNBZVV3WVFPQUlFWU5FaXBi?=
 =?utf-8?B?U21XQjN2L3VpeXZZelEwa1UwUnpjZi8xRmZSVWx0dk5XbXh6aG1UODRHalpu?=
 =?utf-8?B?OGpCWW4xam5XaUZMNys1amZrZlhnNmtTWHE3VGJ4SHZaakRlV1phZXhBdnlr?=
 =?utf-8?B?aXpkWnc0MThkWXkyVkhlU01scFFJU3BTNjNYN1hXNndTQVlYVEtpOGM0MnhJ?=
 =?utf-8?B?OERRSWljMktzemNRS2tRWFVQc1krUEZyWVNDTDN1UlkrUmZManNZcVpvU2RH?=
 =?utf-8?B?RTRUOVRhVWE5Q1p3aS94UlBwNk41ZXRYcDgrMnVLbEFMVkxXTXd3Zmt3ZG96?=
 =?utf-8?B?M1BTUTlRODQzU2Y0ZFd2YjhVbW1YN0NXMVpuamxCWjQ5YWtSd0dKVXVKb01z?=
 =?utf-8?B?MXNJb2xKRkZKS2VQOENVWThueTZWU1gzN0RDS01YYnBKQ09rL2hnQW1OQXU4?=
 =?utf-8?B?NE1HdUt6by9URFVXWVU3Sko3c3l2a0lITXU3WGFnUlRPa1pCaHJ2ckcyT00z?=
 =?utf-8?B?aElSbzRVdXRIRUViWldBTEx0aUcwR1R2dkI0WkUzT3lJNjBKeVVWYTljaC81?=
 =?utf-8?B?OFJrT0ZUeldoOU5OeFBHbXNNRkhGS1VQMjBjc2FPVUVYRzBIa1RCTmJibmVk?=
 =?utf-8?B?aHl0QUp5T2h0ZHA2YXlzaUYrQUpmWmc0NmFLd29CTG9YWE4xcUNnMGRxMUpV?=
 =?utf-8?B?ckxDMEV2TFdsQmMwNGhjekd4TmZXbXlUemoya29DcWpyNm42dEMxZ3ZiampO?=
 =?utf-8?B?UHREb1QvblVpcUYzdU51amhyKzlSMnowNTc3VXRRbXFVQ3V5aHlHR1ZacXRF?=
 =?utf-8?B?Q1Y3NUNlY1p3Y0dRdU5xVUozZXpZRFlPU1Zvc21Cd0lOZFUzV3ZUMW1BdkNR?=
 =?utf-8?B?OHFoZ1pBRmYxdzFlRHd2RGhCa0pqWG91c0FmcDlWL0NRZzhFdEZMKzgxbkRY?=
 =?utf-8?B?a1RCNWJEd3NSSVdheTh4VjhVQ090ay9BL3l6dU5ad2lUOTF4RTBBd1B0V1FK?=
 =?utf-8?B?dkNxdW00QjlqbnZocTVJMUlJa1paTkR3UmhUQXlia2pFdzBzSDdvNE9VaFBw?=
 =?utf-8?B?aWpNSEUzajFWUHozbXlWQTl3VHdyYlBjRkkvVnpUQ0hYTE5ocEl2eFgveEJN?=
 =?utf-8?B?ZzROWDRVelM4WWh0Ui9YWmhmTE9MM3haa2VtTzVvMzJvRlQwWlN5VEx3UHBE?=
 =?utf-8?B?SERHcXhIWFIrMmJIQUozRGNqeDdqVjU2b2h2MnF2c1M1bFNJaUNqVThzT1JS?=
 =?utf-8?Q?xxkkSWGAZEgOI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdHQXZGeVhTM1R2Q1Jja3M5a1hpUzJvVlk4VGRXUnJTTU5MUUxTS21jWU9J?=
 =?utf-8?B?UEQwNW5wRjFQVWZZS09vZGMzZlFDcXpzajF3U0pvQmN3cEZNODZTSXBvbkNy?=
 =?utf-8?B?K1ZRRzloeWhra1BYUDdsY0ptSkVTQ29jaVc2cXBia21EM1NmckN0MmI2MFJr?=
 =?utf-8?B?K3RTZFFzVmxqb215SjhBZkV0ZFdGVjZPZkNXRi9qKzhLMk9FRytjWFRSb2ov?=
 =?utf-8?B?R0dtcnlQTXlBYjRmVmFyUTFMTGRBRk9lVTRLM1lNaDV1NzhTZlZONzdRUnZQ?=
 =?utf-8?B?YWJaY3czZHlKN0tZRU5CblIwalRldnhTY2ZEMk1GSDMzRS9KWnhERVE3Mmxl?=
 =?utf-8?B?Rm40MzJZWGtoSjg2b0xVSkVVSzZiMzBnZkcweDUvVGFad2hoeTRjcURsVHdz?=
 =?utf-8?B?ZElyMG5aNXFmeDg5WXR3czcwNmlnbW9kQ2hqUlVjUzNCbllpZzZqbEt0b3pa?=
 =?utf-8?B?c2hLTXFXN1Q0b2wzSnFsZVFMSzh6TU5kaEZIbXVXaEpDYndNMDJhcVgreGFn?=
 =?utf-8?B?aU8wQ0J5RVR6eTcwMGJmWWg4azJ0Q2VIbW1FUTgrWUlIa0F0TXBRd0hlaGoz?=
 =?utf-8?B?cEJrNTBYampxYUZDOW5RUEVHRUgrbjFDcGtmQWlocjdYdFFzTDJlNk1vb0U0?=
 =?utf-8?B?ZDZYM3QvUklFZGdtdmh3TjZIdGRFU0tTNVFOZHpUeTQxN0xWY1pKU0ExYTBS?=
 =?utf-8?B?SlFVcE1RNmpOUGEvS1JGSGtKRG1DYVliT3JkR2pNeEpndDY3ZHVrUExxZ3Nr?=
 =?utf-8?B?VU10cmNEWjBvVVUwcVIvNU5XanJYenlYUnBMQlBBQVVjdlpteDZUUkR5M3Vr?=
 =?utf-8?B?dUhYR1hmK3ZWVERLSXlvRUxMNU9TalAxdS9RdFZZalFPWkI3Sm5wN0RwY2Nh?=
 =?utf-8?B?TjRkZkZWbEpWWlhFWFA3czFnbzNGdVJSb211WTY3elYvMmVNc01HWTFEUnp3?=
 =?utf-8?B?eXp1R3hldENjZTNlOVBRTnVBS1F5MzVOZGRiOTI2dEwzMU94MWQrMStOc1JG?=
 =?utf-8?B?RXBTQTRmcDIySnFsRklkeUwwUW5nS3JvZzFTd2MyTThnUFREejh5VWdnS0py?=
 =?utf-8?B?bVJQRmFJL21HWXNiYWI4dHJnZlJZTTZLN0doK1RSZGdxbnlmN1hrTk1VaU1Z?=
 =?utf-8?B?VVJnSVdMejlSN0JoQWx1Y0lOL0dTbGlVQzZOTEU4UFFtSUhnak51bHp0STJB?=
 =?utf-8?B?aFdtTm1QL1hHSDlmc09TRklFS2hhcm1BdkdnWVdZNnpnNm9hRWhYTUpXZ1g4?=
 =?utf-8?B?TEdpbks2b0h4YWsyeGlOZ0Iyb1hYS2l1VGlTd0xaTmgwaW8rRmtHQUZtdWRN?=
 =?utf-8?B?RG1NVFNGR2hwVndjdFNvUWxNakNkWUJqa1JxaHVTanFvZzRUQW1uTXl0bG40?=
 =?utf-8?B?Y00wYVVPNzVOTG12TE9kd2FRa1lNM1haWG5FQXhzSTNBbHozdm41RmliMVcy?=
 =?utf-8?B?RmR0ZnRiQlJBdkxzcjNpM0N3RHJCcUw1OW5vUmxyYU5kQk9URk1idnFzWjhL?=
 =?utf-8?B?eEl4SlMyU1h0eHZESWhaT04xU1NEcFh0Z3l2N2VCR0FFcFd2WFlWSFFxYzRo?=
 =?utf-8?B?VmtKTTREZERaMTcvOGZpaGxvZUpZdWJyaW14WFNxTXFzb3M1ek5zOXorNnQr?=
 =?utf-8?B?T2hyVnZFOEZwZU55NHBjalY4S3A1ZmxTWGEwZXlBNGF3TklRN2FLY1pSaUVl?=
 =?utf-8?B?dVlXbnZGQkV1LzNOZU9JeEN2TEhtTDFpK0Evek1SVVovZU50Qmx5S0FFU0I5?=
 =?utf-8?B?dlBROXM5amx3N21meWYydkFBOTE0N3Z1RXZiTWZrZHM4aUhXMXBaWWdIdE1P?=
 =?utf-8?B?SlEvN1c4VHRhK2NuVzB5NE5nbWNnWWk0WlpKNkJ5YWQ1YXp1TUVXcE9aVzdZ?=
 =?utf-8?B?NHFLYytwUkZhQW1HSWM2eW04L1VlWjU3SlRHcTU5NlRsMlFlRUNSMks1WnFh?=
 =?utf-8?B?UGU5NGJQWXp6TXFnSlVlUjNZbG83RUFXTStUajVYbUhpVmtta1NCTWlQTzFD?=
 =?utf-8?B?WWR2Vld5RTk4ekN0eWp1MExnOVRMWlBOR0w2QUZNLzlCZHdTbzU4OHlDckxC?=
 =?utf-8?B?SmR3OGlidng0MnNZV0dqQis5NDQ4MXZZQ0RDYzRrL0tGK0hoRzYzSERnc3Fr?=
 =?utf-8?B?UGRRWm1tV3BVcnlsYTUzZHhrbEFJV05QcG91UW4vY0Fxa0ZxaG1EKzU2ZzNu?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81afb737-9cad-4609-ed5f-08dd60b03742
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:20:11.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4RbwSO1ldaHnv569ZXhyMyjiwppN8CVe3uNCxtHnacG6Yk2oR/EeHkhzi7zscXBFI7muKIm7Fai7gRnNJNM4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com

On 7/03/25 23:17, Erick Shepherd wrote:
>> Does it tuning at all?  Maybe MMC_QUIRK_NO_UHS_DDR50_TUNING is a better
>> name, then at the top of mmc_execute_tuning()
> 
>> 	if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&
>> 	    host->ios->timing == MMC_TIMING_UHS_DDR50)
>> 		return 0;
> 
> The card doesn't need to tune at all so I think this would work for us.
> I'm not very familiar with using card quirks. What would be the best
> way to set MMC_QUIRK_NO_UHS_DDR50_TUNING? Would it be set based on the
> model of the card or should it be set after the initial tuning times
> out?

Based on the model of the card i.e. add a new entry to mmc_sd_fixups[]

