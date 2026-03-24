Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B6405AAF;
	Tue, 24 Mar 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364757; cv=fail; b=i7ty1dUbpDxeO1o7xB2Lmf/OW/QVap3gUKRWVQAKmFWQZFSl0gtuqu4QukqcPnuIpYsts02m+NgkpjW2sCer7Mwd6gbS8os9zPMlsXHtC2UfS4nSvaiGngZXxVKULAEwUyEXjtWONpCmFnH8lrmf0OJb1YI30DiOB6YalExGyhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364757; c=relaxed/simple;
	bh=G2MUeiyrOCHn1V/gQ4sHb7+mi5nlIoPquoiWoj2pTZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VGuO13JSLkfOJplBQXXfBbdxzsMzoeg+nOjhaEpDizN+5/mKWFWIFEup7THXxdjOtfJ7p0d6Lon1Rai2V1ppyEqdct9U1LlaWMuEqfr8Qu5bWp1aJh/s/fyRcO0Znm4p4MAxRen3qU2crHLFfMd2WZ7Mit8wGQ+PIUyGDP7HuVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYCHRbrW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYCHRbrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774364754; x=1805900754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2MUeiyrOCHn1V/gQ4sHb7+mi5nlIoPquoiWoj2pTZE=;
  b=bYCHRbrWR1AJtppxTW1lVg7nMES1ZRupANT/WMUHnsg7mG8gDwnOF1lg
   f8evDesmn6OoojPIQtioQotpSawrO7D5FF2zcrBfY3W5Ynb6KeR/0OR2W
   uRwfKu1HAh47pQYvFpMcZP1LoShVkjM/9J1l4xMR7MPzPQYizJoi1uAAw
   zaOmQMtjNPmBFIOERq9Pfc6KxSWszjId6R3c7BPagAkBNRQNShoKRae8G
   Tmx+Yzmogx0vQwrTHM/nqU12XMwSr/f8OztAWpLAYNlkKySrXZzOGaGwh
   mZR6eqJC7Nb+64JerwtCXolqWTaRhabo29cazoxxqU99071Lz5Mn9DTn4
   w==;
X-CSE-ConnectionGUID: KO310B31TUa4TcZ3Licf1g==
X-CSE-MsgGUID: pkDa1OhfRjOzfPt4YP3BFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85694756"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="85694756"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 08:05:53 -0700
X-CSE-ConnectionGUID: QwZiww90SvuuzhL408gTcw==
X-CSE-MsgGUID: 1MVw12F8TI+6uhzYC9DGXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223439551"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 08:05:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 08:05:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 08:05:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 08:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5Ld39SzGx43NvGJZcUHWkfoh1c1YviPalVCePn5u3M98Dxj/whwTYIjFDOvzCyiVwPZpx375QneJHX1dWYDzybxa003qX3y/r7j3pEypj88CZnE96xpBkHnbVqbXwYL/liwgmb1FCawkRlhY6fsGoe39OnM5KX75LspYmsptJTrA/o9UlX2t+73YVxAOWUoRZWh/o2gRAhn1buBoroLDp0ukLfwzL10nXRd0DocW3fyjfaFWJHhjtPeAb4Ws2V9CMoEPw2GQpRxIYGgsmCUs7XPehAGU+M1dR47lJuR5Dc7xxiPhtkCS3vHjhF7D3C1C7cdKj1qDiqjamUnliTd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhXYvMofbdXWHiUzIL/52kH2QbViFBd18/DIQF9D5pA=;
 b=N/iiAUlmqEb7nKeLbsNC3Dw97PqX9N++44gQbsz4WWcCaBLELvUh5v78hBr2qa2w37Vle9owlgaVRexWw/bspL0lXilhho7v4zN9Hd3FW2p0Hpi3AcyDS2g0SJv3shCA1q8J2bpq7rQ+L150g5kuggkw1351rq/wwoNoxexw5/IjWzGNzFidx/inAhfDG/yVcsQbGNRJcsYd1eDynluH0GEHaV/tiNQA2q1daxOH4LoBsMhfCvfwxSQp3nVZp/cbqg1YWjqUFXKCge66fgoLmsU9mWXvlOMeIweatPAb1KpVNYO70og9RafJmvEixlTEQl7aV+QEn02N35CjgQTHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:05:42 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:05:42 +0000
Message-ID: <884f5489-915a-4017-969f-71a83d2003c0@intel.com>
Date: Tue, 24 Mar 2026 17:05:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
To: Nelson Johnson <nzjfr547@gmail.com>
CC: <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <andriy.shevchenko@intel.com>
References: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
 <20260320164753.536-1-nzjfr547@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260320164753.536-1-nzjfr547@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:10:36::43) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 871b41ed-6738-42ad-a38b-08de89b6d16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t7uyOHDXrsuegj8dubaGw0N+nqDDBP7obWQF243xXIdzKBca/5RdYTheqDPXC0Yue8PpO/S1dXsTFBRpxLNeS8u7Mc7RxJ1O5sSH1OLfcYzJrXucUgH4OEQEeIfzKxhomANktDU0m+XrT0X8jFO5brWgKj/fH2Dlm7TRmYMoWrhPXF2fi29zgB0BTj3FOiHeg03novk2cfN8G+dEBNQd5yEMiPqpn77VnNgEMv+ajRkdOXhdLnDc2E4+1CXqUlePkV8A8yxWwMjaabhaX86jc6iIZ+dHP/+Tfr0iuJz0Figy2Sv1voXoqb1v2fR85tkElT0UKtdE5exuRM1waZK7UQ7qujg+bgV1NN445YLd92szaeh162UA4tDLf0yxsf5qQbY/DUTij2qHEOFBzJGhZJdkaup/K8Exvfb4VLPwMEqPlYXNL9J3h2rlPxIOCytHy9bPQcGKmNRwKWEe7sNbLgBgr0X8BggoxkkHY2uRe+r/A3/BxNG3/eg52gPB+cpjAACG4zrYPF6FEn9f5jNEINKS1gyXXNH4DFsUyUOh4LEvTFhlS8QvfoWGU/VcTXRigEVwtynvRISQtCVBog38HIF4i827mIt4Nt028OofKnIJa0LRYpgw2CiPlaiPVRGtwA/WTiRCEe5u3JSJ9Gti626ISWioILS/Vt6sGSSlQt96RcJQ6UzqGJMFdzq5i+MCA5Fs7S/qcflkMWucb8gcorjBz2m+GSf3vZhFClmK0Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3FNOUZHbGRBdlk1VUZ4RjhVZWdodEhkZXdwWW1ENERFdzhNaDM3MlJnUnZo?=
 =?utf-8?B?ekh1MXoxRnNZdWFFcmFCUVMydm1HbTRBUVF1OEdsdnNWSDZpSXdKYnRmZVg4?=
 =?utf-8?B?MUthekNqbTFZNEUvSnRiNFAzUFR6eE5iSWFyUGxWUkZKTFVlYzlaY0pxVzZQ?=
 =?utf-8?B?S3lCVnR2OHRuVUxUNGM0Y2FxbmRDL0lxMVdmZU9MUHVVYXRJREo1bmIya3JS?=
 =?utf-8?B?eWhwQXFTMnJjdDhXZHFLeXhBRXFtRDVhOG5iR1FVYkMrM3lQQjNabkdDWVZj?=
 =?utf-8?B?MUVCRVhpSHR6eTF5bU9xK1ZUbnJ4OUcyVHNzQ2E3NWZ0NFBPY2ZDL0NRaFY0?=
 =?utf-8?B?TTQrN0ppSEd1NU1OUWtFVE5WVjJrZEFvSGpaSllBTytBUjNXY2RDdlk1NGpB?=
 =?utf-8?B?bjBxd0Zlcm5abnROZy9hVEcxcjdXRzBkNG1XcXZrRkpoK1dpOXd4TDFydkYy?=
 =?utf-8?B?bWE4S0phUDl5dGhTMFlKa1NlSzVCdk1jamJKS1hBYVJLUGhJZ0tGM1FzdCtO?=
 =?utf-8?B?cWZUVHhRSFdoVFR0aVlpVWJTbUpJMG05dFQrbUFrKzUxZWl6TmhiTWVWakt1?=
 =?utf-8?B?OE9mSXl6RktKNEdKL2FOalVUZ2pDUlZqMW5LN0pQYVB3WnVMWGxiN05lNVV6?=
 =?utf-8?B?L2FRWWF5aUZ4UHQ3VHRjUTdrYWFzME4yRHVMWGNKUmdDaWZCd2x4OTkrRTlE?=
 =?utf-8?B?aUtSOExCTWF0cnZLVlVSd2tqY3pSS1ByQTdmMkRGUXZ5VTlXcm5lRUUyYVF1?=
 =?utf-8?B?VDdrTEp6aGZjaURxMVl2V3A1V0x2SEpROGJxU042Um83aUszQXRKZ2NIc0ZX?=
 =?utf-8?B?MzJYWGxMN2xITHpIcjlidDlTVWlHL2trUnpBSVBaYTlsOWNnT3VkdGx1Q2l6?=
 =?utf-8?B?cjErcWxVWjFJKzB0Qk9abzBMajRXTkw0OWtQSmF1blZyak1rb1V1d3U3Yk5L?=
 =?utf-8?B?UXpzY25UcFVYYm5uZSt4ak1VaWc0MEZudEYwazlyMDc0UlpjRlJXdXU4Njg5?=
 =?utf-8?B?blVVNm16TlQ1UDFkdUljcVkzclRWMUxLYks3dzArbHZwVCs1YXJHVTA1T2ZI?=
 =?utf-8?B?VXpUTTR5ZjB4TFpGaEpNdGJ2b0FhelpnNDI0TlFLYldGb0ZmcHhOTG1kRVFC?=
 =?utf-8?B?eDBFU3BTR1BWd0NpWGVTUnVDS3loUXhPQlBZSHlPbFd6MGd3a1lEenR4b3g1?=
 =?utf-8?B?eWs3TXlPdytSZUlEdkJPOFJkTzg3QzlNbGhtMlpkZkVFc0hZclVYYmVORmIw?=
 =?utf-8?B?WjlVNzE1aUl2V2Y5Y2pWM3gvU1NSTHJPVEI2dTZhSG9MMTkwT2J0MkVWbGNR?=
 =?utf-8?B?WVVyY3FFcUlneUZMSmtUZnRzUVJ6SzVIeGMvK1ZSVjQrYUg2WEhVMWk2ZzZZ?=
 =?utf-8?B?ZHViSEpxMzA1VTU1MTZlZmkxNG5XZ2RkZEEwcUlHU0djKzdRU2c5ZDFDcXhK?=
 =?utf-8?B?ZThKUlF1aGNFVW9zbTZyN2xQYlpjUC9BU1JFaCtOeUhBUWdSanJBb3BOOVRR?=
 =?utf-8?B?dUF5eXZVREhveFZtOU9WOEZwbWZ3dDlxN2tWWlIwR0o3aXV3TlJtREVHRnRL?=
 =?utf-8?B?WjZKRnJ0Mjh3QXJPK1JFbTMvY3lKaEMxZmQycy9NT2xxS1VWMDNQREIyTkFl?=
 =?utf-8?B?TVVzZmpYZXVyUmV5aDhxcEZrSVhFTnRURGsyc2cwOUNBTkg2NnEweE41blY3?=
 =?utf-8?B?VGI4RFdEb2RpTVg2c1dQMG5yVUhaRkVhSXB5cVY2eEhlay9xS2FwRGM2NDgr?=
 =?utf-8?B?dHA4RzJ5ZThqaTZKdjBUa21FVG1HWWxUWGw3WldtTDVFZE5pLzJjbG1yV0pD?=
 =?utf-8?B?K1lHWVZFTTZuRTdjUjR3SklydVAzYWJPZ08zSkRoZUNTKzZpa2cxTGtWSUVM?=
 =?utf-8?B?T1V2V3F3azJjM2pTeUhXTTVoWFhrWHhtZGJBcDJScGN4YUV5RUFCRFJtdzJE?=
 =?utf-8?B?NjdrNkcrYzg0V2syYmNKcEpPdVM4cXRGckhGU2diL1JvL3NOc21UTkZTYWtM?=
 =?utf-8?B?WHdkZGlmMlQ3QnZxbWdpTTJJWktBMk1kY2d3cFJjLzZ0Rm05MUdMdWlCbHIw?=
 =?utf-8?B?dktMU3pLUWVaOWRPN3g1RWYvTFdNbW92aW1ZTEJCZmpKN0JHaWdnVHRtN1Qr?=
 =?utf-8?B?RkJQUTc4SDR5MzZ4MTlabm5WR2RkWXQvR3F3dUdvZW1zdE54QnBPcFc3bHQ4?=
 =?utf-8?B?azE3YllTNUIzbFZ1SDgxakRJMm9za0oramlaRFNQN3Q4dDQ4RU9MUEhVSzAr?=
 =?utf-8?B?UHhmNnBJeG9zeTZzMDFTVkRhNldKdTdYY3dJNWZZLzN4ZVlRQW5lM0JtZEh4?=
 =?utf-8?B?SHZyb2ovVVBYV0djT2UvZUo4NG1OcEM3L0ZpU1R1NXVTb0sxdVZyT3hUWWNB?=
 =?utf-8?Q?8j5YPjOFqoyBb884=3D?=
X-Exchange-RoutingPolicyChecked: m37h9Y8+oHsjuTXPqQc4Q4miPMiZYYGPOloKWSsG5vBaC2dOiF7+w/n1RcjzymUhw3TqQhKHxjLl828CZQkttv9pul5Eui3p4HaS7H/KbTGcNBiUBLL9HQeWGgJ1QQ801ERDy2ruyBVfSSB49xgHFmtvnDl+C6a9cP6/DNE+lDhieC7TVLHnKXMqCrn2bkNNuZTbWeXuIOc6L6oZ6sMpEWHGRBjQbzo6LExR0WnBwibAN2q3QoEVTjI/GJMI2GQMzIUycWx6wgL+UOlHUu3dx8HKmti84lMys71wgBSlNvo9zJ0Ievst098zeGsg9wOVmYeUQmNGlrUPNkSQei/vlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 871b41ed-6738-42ad-a38b-08de89b6d16a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:05:42.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns7whYov+t2+dcr9uV1KJdC0Da8debb49BdmHFQoBwsecFoNyd6zeLlMzLjysCEBzcVyI9hCR2s67f7f2GjPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-OriginatorOrg: intel.com

On 20/03/2026 18:47, Nelson Johnson wrote:
> On Fri, Mar 20, 2026 at 8:27 AM Adrian Hunter wrote:
>> These changes seem more like they work around the problem rather
>> than fix the problem, but you say it worked OK in v4.14? I see also
>> mention of v4.9 in patch 1? When it was working, was it using the ACPI
>> driver or the PCI driver?
> 
> You are right that this series is a workaround for a firmware-specific
> problem rather than a generic root-cause fix.
> 
> My confirmed working baseline is v4.9, and on that kernel the
> controller was owned by sdhci-pci, not sdhci-acpi. The INT33BB:00
> ACPI node was present in firmware but did not prevent the PCI path
> from working. I should have been more precise in the cover letter.
> What I can state from testing is:
> 
>   - v4.9: slot works via sdhci-pci

If it works on 4.9 but does not work on 4.10, we would normally
git bisect to find the first commit where it fails.  In that way
we may find the root cause and can then design a fix.

>   - current kernels: slot is unusable
>   - current kernels with this series applied: slot works again via sdhci-pci
> 
>> In patch 3, you say the SDHCI ACPI driver repeatedly defers. Is that
>> because it is waiting for the GPIO driver for the Card Detect GPIO?
> 
> Yes. On this machine INT33BB:00 defers waiting for the card-detect

Later you have said INT33BB is not related.  Are there error
messages for 0000:00:12.0 ?  What are the symptoms of the failure?

Note the GPIO driver should be /sys/bus/platform/drivers/cherryview-pinctrl
Does that have any devices listed?

> GPIO dependency, and that dependency never becomes available. In the
> broken state the ACPI path does not successfully probe and the slot
> remains unusable. Excluding INT33BB:00 on this DMI match allows
> sdhci-pci to own 0000:00:12.0 and restores card detection.
> 
> I am not aware of an existing generic ownership-arbitration mechanism
> between sdhci-acpi and sdhci-pci for this dual-enumerated firmware

If an ACPI node has an _HID, then it might be enumerated as a
platform device, and driven by a platform driver (like sdhci-acpi),
but not if _STA (status) is 0 (not present).

PCI devices are enumerated by the PCI bus, but the ACPI node is
associated with an existing device via _ADR.  In this case
0000:00:12.0 has an ACPI companion node "SDHC" as identified by
_ADR = 0x00120000.  Unless kernel command line option acpi=strict
is used, Linux does not care about _STA for that purpose.

BIOS can hide PCI devices from PCI enumeration, so the PCI device
would not be visible at all if the intention was that it should
be driven as an ACPI device.

> layout, so I chose the narrowest fix available: a DMI-scoped exclusion
> on the affected machine only. That approach is consistent with how the
> subsystem has handled similar firmware defects elsewhere. sdhci-acpi.c
> already carries a maintained quirk table covering the Lenovo Miix 320,
> Acer Aspire Switch 10, Lenovo Yoga Tablet 2 Pro, Toshiba Encore 2, and
> ASUS T100TA, all firmware defects fixed with DMI scope and accepted
> with stable tags. sdhci-pci-core.c follows the same pattern, as
> jsl_broken_hs400es() immediately above the new helper demonstrates.
> 
>> Note Lenovo N22 seems to date back to 2017. Is it really worth
>> spending time on something that old, especially as no one seems
>> to have worried about it before?
> 
> My argument for upstream is mainly that the quirk is small and
> low-risk, and that PCI ID 8086:2296 is part of the wider Braswell SD
> controller family rather than unique to this one machine. Although the
> Lenovo N22 is an older platform, Braswell systems remain in active
> secondary use. The Lenovo IdeaPad 100S-14IBR carries the same
> controller and has a documented bug report showing sdhci-pci not
> binding on kernel 4.10 after working on 4.8, the same symptom pattern.

Documented where?

> The commit documents the failure mode, the correct driver ownership
> decision, and the workaround approach in a place where anyone dealing
> with a similar Braswell platform can find and reference it.
> 
> That said, I defer to your judgment on whether this serves value to
> the wider community. I am happy to carry it as a local patch if you
> feel it does not belong upstream.

For the upstream kernel, the expectation is that a fix addresses the
underlying problem.  At the moment it is not clear what that is.

