Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554522A1D1
	for <linux-mmc@vger.kernel.org>; Fri, 16 May 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380665; cv=fail; b=GfZ1RU3JHJ2UPTDi3hUZx/GHZpvdUI4ZHSEXK5NeQaraIA60yqO0yTf0YYCbW82ILK6UUq5OBObbOC15CMHpoTzq7jj2f9IbD3cC7nuzWt//RIFdXmgN81gI2aWZVRMnITqtIW5zDAGPdsP82YizohrZ55aquiXaDo8vKgx+d88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380665; c=relaxed/simple;
	bh=xltjeefKXf2qXbCCwHfQyHIxOnwVJQaU0FVH95HSVls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q465QoTWVZPGiCn6J+mVRelQHGifjJQiJ50ZsK4qQJWGDwYHNlegduPa19riNGOiykzsVFKrKUzNDYbbKK+W7bbqQJL5u0449MMgXxMqC9dtNvChBr2KLSyN1NOofQCSUx7bTmG7+igyLM1MfdxZgLQTdUQP5LkR5Zm9+rXJ9O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHDwRncD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHDwRncD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747380663; x=1778916663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xltjeefKXf2qXbCCwHfQyHIxOnwVJQaU0FVH95HSVls=;
  b=EHDwRncDcDOXq2j6uQ3QbAdylw0mkNRt+85co5Roa6S6fuQek/YbpEcb
   Abfo1bLJeSo+/xmFRRp7SEFqPbE2Q5wbQOU8vDKM5NDoCR6vXIPNWQRcN
   pY5CINNAhe33T0yEQUL4nUt9GIh83P82uCXiVVWtGxWfny6f9UhR1HBdP
   /WDW3XU30cHTdaVTxV8E6BNjdvT+6w8m1+3CEmyqGze9rJGzVym3C8NvF
   xx8iUaAZSrAeEsQvaVxUaZTxaHqQ5qQEGIRmHWVuJC6ZAZEKQQ7WkXMLZ
   qNIY3sAzilpC1tdq2b58yxx2RwV+qtz55EZlYRCIDfKdOnS4oZrPsaPeW
   w==;
X-CSE-ConnectionGUID: vojmJORtS6O7ij7S/qS+gQ==
X-CSE-MsgGUID: aB7MG+ImSiy5IK7GwGCXyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60681364"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60681364"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 00:31:02 -0700
X-CSE-ConnectionGUID: VFzY13TiS2G7Kxt07HXwOg==
X-CSE-MsgGUID: KRuCYASxRdaaPZhbrogrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="161919477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 00:31:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 00:31:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 00:31:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 00:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efSEEplXqRTBJDIpvRRLfe1zJgBaZUyOHm3v5x4o0rElwrcHD+keWpbLhNpRXcokN1zDC47RxpvdWp1PUhYq9XGzibGqQsfK/XF+/BQ0t9ACvTQhVPvxUiUgktPaAkFibJ+R9gaj7TyDhqRLJSM66yTtLVsWypEqwpj65lTyu6gEeyhdLZ/OXzEyNhzn/eON2oJdDQ+GtvE8LD2A/3mz2tc2c79Nh+8K+4wxNq/fQuAFuFaQC2cPXh3WJoH4yEeMzQ8vwDjgUkEbSMO92yJftbTO4G/IPzY229ymd/M3vZPDT95VaE6HuArIIgCEg5UuGG74vPlTAwp9rUF9zjoQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/cDR6XLC6tDM5orQGHmSxi/SDuC24+RGDpDJQGMz+I=;
 b=qud+2nlxgMpu9Wh3B19UD7MugVdBfBz5i3BAKSYdA2hGQgxnqw1iaTGiqq8NNaPNkAc8pcvkq5kQSomPc7y6i6rx/pcv7m4hxFm9GL24WRuN6MkTAcl1tFsHsEefhvLk34RXEO6GUVH/KU0jT3XM4IN8iMcGoQXk0x2B3kfynDvp4liPYvKvPGTMrEElYHPDlqpvcWsB74FXg/Hx3R2YmQ5D48jQQNPCwMB4a3y4F5DKU2XdmE+SNWgHbEVwPmgxjCVAZHUOfyLMeXkXA4MghTkicgW5eqyArAkU8r0uNiBto5O+OHnbRutOX/kYgeGIpzwDDivgohWzEY8oc0/pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:30:57 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 07:30:57 +0000
Message-ID: <2b4f448f-33dc-4940-b7f7-faff0e0a0c3a@intel.com>
Date: Fri, 16 May 2025 10:30:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: fix few build warnings
To: <haibo.chen@nxp.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <s32@nxp.com>
References: <20250516062423.1408380-1-haibo.chen@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250516062423.1408380-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:8:1::31)
 To PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2a14d8-6f5b-43e3-1b2e-08dd944b991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWRBT3JqbndPVW9JZWVlc3MxL21XUXhuZFhzSEpIK0g0VFNmUTZ2MEJMWGtu?=
 =?utf-8?B?L0ZrNVppWklsdGNpcVZUOVIydEpqM1Z3ejRtMVB1MWxiUnVXcjhUOXYwMC9m?=
 =?utf-8?B?akJFM2ZXc1cyTXJMVjRpYm43bGdwemdDaTdUZmo5WFdkM1REU2dOUHgzMjRS?=
 =?utf-8?B?T2JubllDY0RnSWZscFFJWHFBaVlBVHorcHBRbWVxeGZQWjBwd3lMV216Ykkx?=
 =?utf-8?B?V0htbGtXT3ZmSUNrZnFHWkFmeDk2YzZKUG9kbjZud1NFYXA2aElrMmlxaklS?=
 =?utf-8?B?akJjN3dxQUlxbloyZXZpUE1DdXk1cTBlWHVWNHIvNEc0bzM1M1ZYa3VscGdl?=
 =?utf-8?B?T2U5YTJucjZjaE1OelRTa1RDRDg3R3B3OHlsajRhZE1zTVh4bmE4ampnQ2gr?=
 =?utf-8?B?cHhZVDNSS0pEaDBVREEyaXJpaHM0THQ3Ky9WeWFndVdxMXQ2ZWczSmtUbGts?=
 =?utf-8?B?dDY2K1BhUzFYNmI1NFVsbld0WkpaWDQzUWFGYjRPUnc2ZEMrTUJRU3pZSitQ?=
 =?utf-8?B?cnZrNGdSS1RBVVhjK3cvZFM3WmN3bG5KWTgwUytPQmNMM3hTaWY2MUZRNUdz?=
 =?utf-8?B?bVNqVnNQcUZBR244SThidG9nUXB6MHNVbFMvNVgwL0xNamlnZmlxQmprTlpB?=
 =?utf-8?B?TGhhS3FXd1Q3d2IwZG5ldXpoMlRvcXZmL25Rc0EwWlB0dlZPajNNWExVZFFG?=
 =?utf-8?B?cGdzeXg2ZDJaS3M5OGV6bFZ4Q1hQSHpqMVREOWtVa1hvQmY5RGEwdUtnS1Bx?=
 =?utf-8?B?Zld0TWhBY3dvcFpzckxwSW45bkFwREt1U2c4VldVbTVocWVtUWlhREVlSE1k?=
 =?utf-8?B?TmN4L3dYR2dIZ1lvNmVxa3FWazZFdkVuV21pNXVZdmtWSlNmQ3FORDNmaTJH?=
 =?utf-8?B?Ny85Mnh5SElvaUFqODdoRWFJWlk4WStuRnRUOTlrYm9zTDdrQTlHT0VHLzJx?=
 =?utf-8?B?elRYSlpvTGV2MUtMUHp4S2dHZms5SnByaU9DTUsvS1BCMkNzVEZWSStCajZR?=
 =?utf-8?B?UFc5M2tONnN3d01aU3B2R2dvRUorVmtDeWdzZHNHeGJqYTUzTFZLTW5BcFp0?=
 =?utf-8?B?TUhIMzlYa1BrVFJIS291QkN1dU1rYnZsOTBDNEZCMVYwbUo4bHg4Q282Y05n?=
 =?utf-8?B?bnM1OTVCczJ6dk9zdFZCMjJMeGc3M1htY05LNFdmbzJPQ3BiMUgwZFNLMWYz?=
 =?utf-8?B?Vldnckt4UWxrbTJaZzBZcGVNdG4xMnp4cy82VVV1TTVPMW5SeW44SStzYk1z?=
 =?utf-8?B?aDRYTTZINmU2MUtWS29FTEFqbGpqVVNCTkZpUWtEVVFSK3VvRktLbnBNQm91?=
 =?utf-8?B?ZHdUUU1hSm84eVBrQk9KbFJxS2Rnb3o4b3QvVkZTMEc2Y2UyL2wxemo3dm15?=
 =?utf-8?B?QWcxamNKaFJ2MXZ1enBDTUZaekZoY25WQXlJVjV1ZVozUUd6ZGNJelU3V2l0?=
 =?utf-8?B?MFlYdFZ1VUQ0bGtLd2plc3hSRzhVOEVFejFPV0FPNzhSVXNNeHQ3dERpckVM?=
 =?utf-8?B?SnZXVkVhR1VERTZFRGpiYi9oOG1Sc1RhcERZMkhpNjFFK2F2TkNGYWJJM0Ey?=
 =?utf-8?B?eXBuRnhEd21sRXVidmFBallSUmxkdlE4Q0hNUHkvWTZNRmJ5ZGFwN2o1RnV4?=
 =?utf-8?B?R2tpcDhQZjFBdklDK040M2V1YWZwaXIrcDRiMG54cnhEU2ZXcXhaWkQ0MVp1?=
 =?utf-8?B?M0Z4ekluODArWHpBbGtJMXNGSU0wRE56cEpPc3pHNDFoMGUwWUU2VGovbUtB?=
 =?utf-8?B?NVplcVM5R05qWkhNTW5LTi9PcmdGUlR6aFdOc0ZWM05rTHZLdFNUeGNSRVd0?=
 =?utf-8?B?OWUzQm03S29PczkweU1tVCtjSlhIU3U2S0lWSzVjRUhuTDFHVG15VzRYSlFj?=
 =?utf-8?B?QW1IZEQwVWJGTVJSa0s4WDlJdXp5dEJBMTlIeTlaTjBKUTVRRlRCTkRWZzFj?=
 =?utf-8?Q?QvI/JD0Yg1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlXVUJleWd4c25FTlZZVkNFZVlueEY1Q0ZLblk4RytPRDF2TlBXeGZoWHlN?=
 =?utf-8?B?WFhLNVlDZGhDZndEbFpGRTluam13aGF5a0JzVkMvdzBpWjhKUHRWbVAwY01Z?=
 =?utf-8?B?RzVvT0ltSWJtL1lsSHhnN0JLQ2w1WXFoeXpJVmJUNGRKUi9uR2tKaUluZ2w0?=
 =?utf-8?B?UFlNalNGVENKL1lHVzF2N0I5eG44RCsvRUg5VkE1b3V5T2RJdkJ3a0xkbGU5?=
 =?utf-8?B?UEZUZ0JtL1RHRXArdWxpdXFQcXl2WEt5S3dCVGcrSUZvbk45M1VUeG5CUGNF?=
 =?utf-8?B?Z25BcytHTkdvSXZPY1VtSDZIMDdKSzRldlpybjNZMGJVejFUd1ExbnRXSnh1?=
 =?utf-8?B?Y1A4ZklvUStONUV1WDNsMjk0VEwzMUhLcmlJWmQwV0FSOUoyOUthS2lhN2dL?=
 =?utf-8?B?VS9SWEFSVFdkeEtsWFpYTzN4MzMycmErMmtQVkNKdWFSUnVXS2JRblROYjBJ?=
 =?utf-8?B?SjVMV2tXemFoQ3Y4dW84OGZMQ0E2UUIvVnkrTFF2dXpzR1lqMmJsN241M2FU?=
 =?utf-8?B?WFNsT3YwWjg3WjFnQzBNaTZybkVnUkpSMUZaSDVYclRFT1JpbHJoLzlDeE12?=
 =?utf-8?B?UjFXWFZjVGIyTDNaRkJJUmhxbCtJSStFdUdadzY3RkJQaW94RVIxTVQvbHVM?=
 =?utf-8?B?ODJCUmxhcVEyNWpWZGZzOTJZbmVCaHVRcjlTdDZPSGxmSEpycnpRYnlMRjVK?=
 =?utf-8?B?eDFjdFJaZldYNXd5RU4wU053emxKcHhDQ09rRTh5Uk5sRTVjMmRqK3kxQzRR?=
 =?utf-8?B?dGZwcEtyTjZieUNwTEErZkJmKzczSlV6Kzg2dE83TCtKczZ4RCs2MGVpaUwz?=
 =?utf-8?B?dUJyNHdzTTNOdGZueis0dGUwYzhtbXI0S0tDZUI0emNFTHdQZ2ROWVFFUVdM?=
 =?utf-8?B?WnZ4YXRQWTRvZUdjZU94TGV4R3NoQXRKRWhTN3paeDZnSXNCdFZJZE1WVE8x?=
 =?utf-8?B?dFJ0aEg2R2dyZnpWVGJaeTA0dDJQdkZkcXVyUXl5QXRHZ24wZ0w0RnJNVFJO?=
 =?utf-8?B?bFZjRk9CUmxkcll4alJQSUdtMHZvZDMvTHBObXpYMUVDSTJuTHNhbHFxYkVJ?=
 =?utf-8?B?T3VPQjZYY2VmbkxxWVp4M3R3aXRSbE1rOUQxN2xZR0ZpSUwxTWc3Sk9pYlln?=
 =?utf-8?B?UE5NMFpQbG1oOXNBWUxEUGlxNWVGZWVJdllORU4ya3VjbUx6V01US1V0dVkx?=
 =?utf-8?B?NzdhdHlYUlJsSzdHM1Z4SUpYcnNEKzdZUkFIc0dnVzJ4STNraTRVdTVUbjY5?=
 =?utf-8?B?NnFqMHpsMDlzN3FTaUkxQ2VUTzRvSDJuRXpENWd5cktBYU0wcFI3RTM0elVH?=
 =?utf-8?B?U0hGMFY2WVVQSVJCR0FFMndBYUhsTVZnT3A1UzdXcGJsWWs1Z3IwN056cVdk?=
 =?utf-8?B?MWY3bzZ6Qit0U2lnS2l3M2dlcVorRGNUQzVWVk5aWDk3V2NSZFJoeEhjcHJG?=
 =?utf-8?B?Q1NBS2JJbHAwUUtvQ3JuVHI2ZzZWc1BNWjEwNHFhOGpjdDUrUU9VNGFtVTdU?=
 =?utf-8?B?ZjIyTnZvVjNsdzhiZzdTQjFVMU5UczRmbFFIK1h5bTVXMGpqR0hrT05GNm9R?=
 =?utf-8?B?QkxhSGhJZGVXNVpxZjNZb3daNGNxcnJGVy83Q2Q0cUtOTlVTVnBOMnlyL2pG?=
 =?utf-8?B?MVlvUjRZN0w5bGZNTjV5c2FMWUJMVHRPd010MDVxVVBGN3NlWHFxNlRsakcx?=
 =?utf-8?B?cG50Q3pmeWptQWxOWGt4SjluVEE0V1dNV0RPQW43Q2wrUjlDcDRwLy9pSjdp?=
 =?utf-8?B?WlZRdXdrcDJzMDRWUmhPd2JKNjBtS1VuNFBFTVk4a3hCbEQ2RERONjF3OHdY?=
 =?utf-8?B?Rkc0bXdMT1lFUjFCR0VJNUFjVklPcTh5QVVNemlBZWtBVFZoMG9VK2w3a2Fx?=
 =?utf-8?B?WlJ6OVg4Snc3Q0EzcWhESmxhN0tJckltS09PMXZ5RGt0S1RaOXNFb3pjWVpz?=
 =?utf-8?B?eTJkcFd2dzdvVjNvWHhZd001YjFFUVZOL0htbitTd2I0MktLa0k2SUx3T2Rn?=
 =?utf-8?B?NHFiM1JlZHJ1dkhOQU85SW5MVFNaak1SbHg4VmZTaWFKUjY0T3RmSUdYL01F?=
 =?utf-8?B?QVpzckRQUFBKTHZZaFd5WGE5N1IrN2dIMWhJYk13eXQ5REExUENqd2owWmtQ?=
 =?utf-8?B?NlJIVmxtbGc3MnVwWkRJcVJsK1RtMzBrV3R0SS8xMkNacUV3MEF0eDNDeHlY?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2a14d8-6f5b-43e3-1b2e-08dd944b991b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:30:57.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzQAqtWlC3BIZC1NQqmrlKxUBxu6NOw/7EzL9Z1XNMsbRGQf+UZnSis/bCI29Nd+1wnI/9f5wnvqMNDBQv0/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

On 16/05/2025 09:24, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> drivers/mmc/host/sdhci-esdhc-imx.c:1566 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
> drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_min'.
> drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_max'.
> 
> Fixes: be953af79cc6 ("mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning")
> Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> .kernel.org%2Foe-kbuild-all%2F202505160225.Csr5USfq-lkp%40intel.com%2F
> &data=05%7C02%7Chaibo.chen%40nxp.com%7C2653112e34c94691a75108dd93e34a5
> 6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638829326610115371%7CUn
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOi
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1m0RsAsU
> wxLde7RpCDx4nHJiBrb7pfJu3grSFASTpbI%3D&reserved=0

Please just use a direct link to lore.kernel.org.
Using https://lore.kernel.org/r/<Message ID> is shortest.
e.g.

https://lore.kernel.org/r/202505160225.Csr5USfq-lkp@intel.com

> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c0160c69a027..741db169f44d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1216,8 +1216,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>  	int win_length, target_min, target_max, target_win_length;
>  	u32 clk_tune_ctrl_status, temp;
>  
> -	min = ESDHC_TUNE_CTRL_MIN;
> -	max = ESDHC_TUNE_CTRL_MIN;
> +	min = target_min = ESDHC_TUNE_CTRL_MIN;
> +	max = target_max = ESDHC_TUNE_CTRL_MIN;
>  	target_win_length = 0;
>  	while (max < ESDHC_TUNE_CTRL_MAX) {
>  		/* find the mininum delay first which can pass tuning */
> @@ -1591,8 +1591,8 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  			 * wider, give auto tuning enough space to handle the sample
>  			 * point shift cause by temperature change.
>  			 */
> -			 tmp &= ~ESDHC_TUNING_WINDOW_MASK;
> -			 tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
> +			tmp &= ~ESDHC_TUNING_WINDOW_MASK;
> +			tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
>  
>  			/* Disable the CMD CRC check for tuning, if not, need to
>  			 * add some delay after every tuning command, because

