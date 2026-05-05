Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299031F999;
	Tue,  5 May 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989951; cv=fail; b=gQ47gmNoUzjqhMRgYDSI5rpQia58OALSWF885rgIi+/RGU8q2wTIwY4cvMyPrh0rnIHxBKnaHHxmp+aO2Q3Zs5YC4bHnScyDOC+kEE41GJMq/rWYS10IJgT6Op56E0cJ21xMRaebevM8utes295stIEFR0iK1AlZo1t4tug6cYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989951; c=relaxed/simple;
	bh=QEYFsgQ3A7BrpxxAF8EugLfmZwJtfa/A6b0iZpBYK9A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lw6MCni7nCqiv6abp8edfI1xfbZe5lFEbztCcAQu0omtoQldDC1RRsBU9Ou3XI31mMuKfSaX7EM9BQypt/VYXr/jsMXppo/IVlk1nQcIOJYqbtBA0+ACmQC5wNaa2S0wDUurJk3dJTn0RbL5g8Qe5MOu6IlXtF3pt2khxCfzjFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efQPNRS9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efQPNRS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777989950; x=1809525950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QEYFsgQ3A7BrpxxAF8EugLfmZwJtfa/A6b0iZpBYK9A=;
  b=efQPNRS9m85lOz828NuNBRTjMBTPi5heW5xr1iAH+riit1TXODkoBqht
   xadbmhWbU3a0VUPyVHiNi23zr51tnAVgaJIdmeFGsjjG8rLP9HMi3bC9h
   JhpvyBSHvz5IsTtgdLFx7NLjj2PJQH+vIlvKKx/Mh/NMgoBdus5tRMwho
   0RQUPfDI/1ojDsB7PuzkgZ7tFVtYsaCmWAPal/Bf4u2wrXb1HzGG7LF66
   4F6BRHIaXc/Rfd9F2VG45RB36RGswARaFDOf1JIWIjkGg+ilquW4kB/Z9
   Ohcv/nn0Yo9AY3Fi5HYJU6b/FXCTDxd4YYvcx5ybGR+WEAk1mB+ZSTLK1
   w==;
X-CSE-ConnectionGUID: 9iBp/JaQRnyEy4XbUTedgw==
X-CSE-MsgGUID: P6S5Gdp4SD2MJN/bL74iKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82473191"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82473191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 07:05:48 -0700
X-CSE-ConnectionGUID: NVbZhvHGRHOGjna2/zqiZw==
X-CSE-MsgGUID: n+sdrkwtRoWDjBzyIfgsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240807957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 07:05:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 07:05:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 07:05:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 07:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFb65FnaxVOTCc+1nRzy2YzAdYSh0PZ6bEj4PvYyUOnJuEhRruEK45DwZ8ovxl1mBPH1IpB5BTH5K9Sq3wIrQyx0cGUw5I4JgKt/QJLuIibAqdXY/L7IJ7FTy+ZNvRn7km+r2VuuK+fUklXdVY0jMH0Wnsk+c+0esMCkFa3mcvG+ZKsWjfkUknAz+7pB+mUdlnS/CZsmapZRxXlt7F7l7Mdivn8nt2KtLdS4gOK60Rveqqey7Bt7qWJWOkHfJ7n8cnmMLHHVBCMxQaJdd8KoeApQabKZQl5SM8kzTrWL52IrCv3noKMfyAHaKptj1JrS3FsETrMl/7ATtjt1xJTlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWUtG/jJDoztiWBhmJC5vcUfFhsc5FIoVTL8W5RxJOc=;
 b=X8TI1P8rcQUBYdbl/IkFj4Hv2EfMiuuG6eT7xXTUGRHhIg4yifaPJitdoYcU3vye+pVMT20bKBTjhMrkzsdnPunQsK44wbBD8E4Q4uUsgEQrEpMs56Fw6Dmp5cCjwbRLfScXuYJ7fPeh1vgjMMpxUTaBPoRc++mOkpmdDdcD9VrcaaNty4UHEG1B3lPWEu6wdyBPNWXv0Q3tzL+ebCiGoUeaNbQ+USotlnkSr7APQTOXFoKPEvKOorZN9O2brk5QTs/6D2yMDvkEvkKhu+sS8vOWWvf1yQS/7jMRzcbHtY8OVpMIzvAaF0LYigsgKYeSmkclYLSNEGJ34NMAZ9ok0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8667.namprd11.prod.outlook.com (2603:10b6:8:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 14:05:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:05:43 +0000
Message-ID: <17e8cf3c-6984-4711-98de-1d795e6268fb@intel.com>
Date: Tue, 5 May 2026 17:05:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add reset control support in
 suspend/resume
To: Artem Shimko <a.shimko.dev@gmail.com>, <Jisheng.Zhang@synaptics.com>,
	<hehuan1@eswincomputing.com>, <andriy.shevchenko@intel.com>,
	<yifeng.zhao@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260505133731.383544-1-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260505133731.383544-1-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0270.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::35) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b743a1-44df-433d-665b-08deaaaf6575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CIjHBOoDQrBtjMp4bPeX/shZcGPUZBxzvtx1FP7DHCDwj+ik/TVkLWpBV//RNB7ylNvQNkv2ulIGnGr7t8fzvcGEo7ASdEfNCsaIMMWyKhHb6R0M5qUJq51odGZT99jk0bsSl0eOTGB5micLyOSEiMxiIsjl11d8AhbpYe6sauT3PKIGaJzTqRajGxZzzpvcYbGhL5UG+k7BS8+2V97++u7dHVDzqy7iX1mDO/h0DXA0MoXuKgDJxB1pvzYJu+04LZF7FgOmi2UkcaK0SHdL2fpLy0I4Ya9ZX1XDTFYV0SkjWJl+TamGMf9DP9ZccP0rhrsMdWVeK5+j4wA3KE6vhwuVCqGAeSBn9AvNfFKmOAOtSXsacBEDdgL3zDDQK1+n5r2R9em2sA8DqkA+ICh5GGaweNRMtJGSgXoadT2fBmEG2CmucwD3g4O8q47SjSk6o8zcYnPOjH0zYME7TUXOYD/WEUFj2TCRoAQKuZ5TQqYAm+j1cuwa+mdjHqHElYN3mKTayNVXc9FPkdii6wA82O31jQoEmRDTlOcGMd9HamOzPsr3+OQS97jYd0tYlZwaMnnTNipgXH9oflKCTOMGVcRCBaBPlK3evyobYylDxa7rIiUSOljITQwd6YRWIsRzaQgV4woRzlEZlp4XMnjHyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1ISXh3M2hXNWVOd2RpN2JKTVVpSUh6ZlJXOXZmZVQwT25UdnVnM29TNzZS?=
 =?utf-8?B?RUMraWRuWmQySFZhanI3MTA3dGJWaTNNdGxGQ0RvRFZZc3JDZ1pyMGVjeUxP?=
 =?utf-8?B?Y0xUWWVPWUl6MFdGNXpoVzB2SmR3cUFqWHBOOUNBRy9ZM2ttOUczTVZwN1Bq?=
 =?utf-8?B?RjdmRjdORVNrOWhmZ29iUlZvUndnbGp0R2tDK0l6R3JNb1VDZ0U0MVUydGFP?=
 =?utf-8?B?K1ZzVTJ1MHNUdDk2aUhZV2NHSHdXN1NqRkxDZkkvMG5GT2dqMWxnRzltYS9B?=
 =?utf-8?B?dVpieGxVTDQrNGc0UDRPU3VNb2hYYUtBaVkzOE9zNk5WZ2pDaEYwUGZpVkh6?=
 =?utf-8?B?dzRJeUpDK3lJajYxbDZIWFBFaitFQzdOTWVyOEN1SExuWmdtSkhzUTVFSlJI?=
 =?utf-8?B?SVF4VG50M1FhRHRJa0pvZE1BN1ZGSkRCbkxiUVh3aGVuMXVXZFc5dStHWFhN?=
 =?utf-8?B?TnNDbEtqYVFqNjc3T1BMSFAvTExvUmsrQmZGQUloTEVBNVRYNUw5RU5zU0cx?=
 =?utf-8?B?Y0IvcC9YTTlINEQ4K00zb3I0eU1JQlBMb2ZKVG1ycHJWVmxieHJqTWZDTldG?=
 =?utf-8?B?Lzl2alRocFY0WldRN1R6c0FRbjVYUWltSlRrQ2ZMUkkrYndRQSs1Qm9mMWwy?=
 =?utf-8?B?WVFYSndVUHZKTWVhUDFjOHROcU1HcmpDalFGVktQL0h3Y1pOTXVvTE9EajVG?=
 =?utf-8?B?KzY3anJkNGU1bDM5bmtqOUd4M0RBamo3eFBGU3pFVk9WdmZheWI2a1lhSmZx?=
 =?utf-8?B?MG9mTTBxb3R1OUZMenhQaXFwWGYwWjBKNTBncUR6eCtNYVdhR0dRTks1TTZk?=
 =?utf-8?B?ZXJtSXhHTzYwN3lJV2h4WHNUMm9KQ09vWFRyUXNWQnVaZ3puNnNzSGtQVEZF?=
 =?utf-8?B?blRrNFBtcUIrZ1hZYlJOd3pXTUlYL0tvNHhUZFRaMjh0RFpRSDAzNzdhTGd3?=
 =?utf-8?B?M21tQmx1MXIyMVV5RXlqemR0U1Z4VHJKZm1LL1BkeXVPZGZBZWNuTFVNVEsv?=
 =?utf-8?B?TTZvK2xmRWxUdGdtQWJ3RGR6ZGdlT2ovNGNoU2k4YWdCOHBUdkc4RlI4azRi?=
 =?utf-8?B?cHFnQ21LQm13SE5VTmtDNC9SNDcxMzd0dHMxL1NJbVF1bkVodm9tck4vMkoy?=
 =?utf-8?B?Z1F6ejBneGRtQXkyUGtYbkd0NUpqbkIwRE5CVTZwM1kwb1RaMTNoSlpwUjF5?=
 =?utf-8?B?Z0d1dXNDK3FicVV3K0gySGhpRi9INlZBejZBMzlDY0plbG1BRHhtdTJsZ0Mx?=
 =?utf-8?B?RG5WcTZMdUQ3c3Q1ZU5lOXV4WHUyNzZFUlFYSGtkQkd3a0NVSlQyYnpoVmsv?=
 =?utf-8?B?ak93SnBRMEZtaVgzM2VFZTVCWEdmOXNGRlZDMFdodjErMEZwSXVFSHhiTFZn?=
 =?utf-8?B?dWp1alhuSkh5U2sySHlwN3Q4T2UwR3FjQ1M5K0ZiUlc3MFF6anJ2dktydGo3?=
 =?utf-8?B?QzhxWkdJRlpzaXNpeDNjTXE4a1l0NmlsVW5jWHZaSDhrbDVjaDFVTUpKYVcx?=
 =?utf-8?B?TThGeVl4ZDhCNXRmMW92RnNGYXhLczRtR09nWTR1aHpDMVVIVlJlNUdIWGl6?=
 =?utf-8?B?Nlc4bjFzVTNsSGpUSk5yRUxmMDg0WkFVREdBMXk5Z1hteUREK0psTE9EOXVE?=
 =?utf-8?B?UVAwc213eEFWOTUzQXh5U3hrTkxJeWtONUJnbGlVakVSdHdKVU9pdUZhemI3?=
 =?utf-8?B?R0tTMjFUMHkwdjc5YlZwaFpGWmtCVUpBV2Y3eUJLcVg3WFdZb3hWandRT2dY?=
 =?utf-8?B?WDFOTUdhMHNxSzVQTWQ0VEk3MXpFK2JTenE3eUU1amprQkVDaHEvZ3VFQ01s?=
 =?utf-8?B?SVFIdmNTQkJZakptclFENlpJT1VvdERQb0VOWG5OUWZONFE1ZVJPTjVrM3E5?=
 =?utf-8?B?dWs4K2tFVDdwQ1MrdithRndUZVd4M08xL0U4YXpLT0NyYVlkRXdHVzVQb3NO?=
 =?utf-8?B?eUVYdGdTakFsYTNtWXF1ajNqaUpUSFJLRjZaOXUzRUg2d0o5ZVJ0Y2NodWpW?=
 =?utf-8?B?QXBCMXRSUFFOSGVvWllYbS92RFoxNGxxSU5nQnZmL25yL081U05ObC9qZWZj?=
 =?utf-8?B?YnlzVU4wNTVJTm1DZTdXZHBlSUUwMFladXZ4RXFUSjhyc1dEclN3Q3NTcVZ4?=
 =?utf-8?B?c0lUalhWTHAvWEFMT1UrK281a1ZISG43eHlIdDFQQ1kvTGJPdDlKclVVeDM3?=
 =?utf-8?B?Z09lNFk2eFNHQkVVOUNEdFQycEJaQnovSlhLM0VNZm10MFhZY3E3cWcySmJJ?=
 =?utf-8?B?UE1rV1dzVXowdEhJSVBKcDhPWkZZajN0d3NjQTliTTJSV0lBV2p2NFprY00w?=
 =?utf-8?B?b1dJUjNoT1ZJdUc0WTEyY21hbVY4SHU2UnBudW5uRVRaTUE2U2M3R3BNUXY4?=
 =?utf-8?Q?wXdXU49eWzkWhnjU=3D?=
X-Exchange-RoutingPolicyChecked: cxv8ywG3Hlw2LTkKwWBzec6nFQjqFDqVw70rhoJf88B6ap8KINc3F502X4NfRwuG0CT2ChAUJq1TpZTUNa7SfuuyE0Vopd7IxBDAGooGp2Y4gdp/QAX3aekpAURp+nI83T/3sAddo3SthvRLSiXuos/7gMHSzU+7uojj2Dbp7oN8KbFQkPgxjz0pXT6s14vgcSUSlELwC27wBgpH/F+mAHg0RxT98ZI/rbJbkqccJ1o/YI03LAgOM+Eh4LqnY9zoVfrHHNRvv1FD3UcUzNHnAGh/9PZYc32zOC8bpdJnaBSJt/4WsJbXKlFhLwi3NTCoQ8bBIXXLpyVwI9K0XnXzvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b743a1-44df-433d-665b-08deaaaf6575
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 14:05:43.4365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6SNexrlBDMNdCWj6l1u4ADiMNg0rhtKEjAaZgbN4/TJ6jkaG1ISn8heJXqUKCTBfMxb3gIFhF5VdGVI1x7GFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8667
X-OriginatorOrg: intel.com

On 05/05/2026 16:37, Artem Shimko wrote:
> The driver currently handles reset control only during initializations,
> but does not manage the controller reset signal during system
> suspend/resume. This can leave the hardware in an undefined state
> after resume. Additionally, the reset control is stored in vendor
> structs making it inaccessible for power management operations.
> 
> Move the reset control to dwcmshc_priv structure and add proper
> assertion during suspend and deassertion during resume. The
> needs_reset_on_pm flag to control whether reset operations are
> performed during power management transitions, as not all platforms
> require or support reset handling in suspend/resume path. This ensures the
> controller is properly reset before entering low power state and correctly
> reinitialized upon wake.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Changes cannot be accepted unless there is a user for new
functionality i.e. you must add support for a device that
has needs_reset_on_pm set to true.

> ---
> 
> Hi,
> 
> Move reset control from vendor-specific private structures to the
> common dwcmshc_priv. Introduce a needs_reset_on_pm flag — platforms
> that require reset during suspend/resume set it to true. When the
> flag is false (the default for all existing platforms), the PM path
> behaves exactly as before, preserving full backward compatibility.
> 
> Rockchip RK35xx and EIC7700 do not set the flag; their suspend/resume
> behaviour is unchanged.
> 
> --
> Regards,
> Artem
> 
> ChangeLog:
>   v1:
>     * https://lore.kernel.org/all/20260415123411.437450-1-a.shimko.dev@gmail.com/T/#u
>   v2:
>     * Added needs_reset_on_pm flag. The flag defaults to false,
>       guaranteeing no functional change for existing platforms.
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 47 ++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0b2158a7e409..cf9be59f79c5 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -279,12 +279,10 @@
>  #define PHY_DELAY_CODE_SD		0x55
>  
>  struct rk35xx_priv {
> -	struct reset_control *reset;
>  	u8 txclk_tapnum;
>  };
>  
>  struct eic7700_priv {
> -	struct reset_control *reset;
>  	unsigned int drive_impedance;
>  };
>  
> @@ -297,6 +295,8 @@ struct k230_priv  {
>  
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
> +	struct reset_control *reset;
> +	bool needs_reset_on_pm;
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>  	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>  
> @@ -887,16 +887,15 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *priv = dwc_priv->priv;
>  	u32 extra = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
>  
>  	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
>  		cqhci_deactivate(host->mmc);
>  
> -	if (mask & SDHCI_RESET_ALL && priv->reset) {
> -		reset_control_assert(priv->reset);
> +	if (mask & SDHCI_RESET_ALL && dwc_priv->reset) {
> +		reset_control_assert(dwc_priv->reset);
>  		udelay(1);
> -		reset_control_deassert(priv->reset);
> +		reset_control_deassert(dwc_priv->reset);
>  	}
>  
>  	sdhci_reset(host, mask);
> @@ -916,9 +915,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> -	if (IS_ERR(priv->reset)) {
> -		err = PTR_ERR(priv->reset);
> +	dwc_priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> +	if (IS_ERR(dwc_priv->reset)) {
> +		err = PTR_ERR(dwc_priv->reset);
>  		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
>  		return err;
>  	}
> @@ -1504,24 +1503,24 @@ static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
>  		sdhci_eic7700_config_phy(host);
>  }
>  
> -static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *priv)
> +static int sdhci_eic7700_reset_init(struct device *dev, struct dwcmshc_priv *dwc_priv)
>  {
>  	int ret;
>  
> -	priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
> -	if (IS_ERR(priv->reset)) {
> -		ret = PTR_ERR(priv->reset);
> +	dwc_priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
> +	if (IS_ERR(dwc_priv->reset)) {
> +		ret = PTR_ERR(dwc_priv->reset);
>  		dev_err(dev, "failed to get reset control %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = reset_control_assert(priv->reset);
> +	ret = reset_control_assert(dwc_priv->reset);
>  	if (ret) {
>  		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
>  		return ret;
>  	}
>  	usleep_range(2000, 2100);
> -	ret = reset_control_deassert(priv->reset);
> +	ret = reset_control_deassert(dwc_priv->reset);
>  	if (ret) {
>  		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
>  		return ret;
> @@ -1780,7 +1779,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  
>  	dwc_priv->priv = priv;
>  
> -	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
> +	ret = sdhci_eic7700_reset_init(dev, dwc_priv);
>  	if (ret) {
>  		dev_err(dev, "failed to reset\n");
>  		return ret;
> @@ -2563,6 +2562,9 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->needs_reset_on_pm)
> +		reset_control_assert(priv->reset);
> +
>  	clk_disable_unprepare(pltfm_host->clk);
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
> @@ -2593,18 +2595,27 @@ static int dwcmshc_resume(struct device *dev)
>  	if (ret)
>  		goto disable_bus_clk;
>  
> +	if (priv->needs_reset_on_pm) {
> +		ret = reset_control_deassert(priv->reset);
> +		if (ret)
> +			goto disable_other_clks;
> +	}
> +
>  	ret = sdhci_resume_host(host);
>  	if (ret)
> -		goto disable_other_clks;
> +		goto assert_reset;
>  
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_resume(host->mmc);
>  		if (ret)
> -			goto disable_other_clks;
> +			goto assert_reset;
>  	}
>  
>  	return 0;
>  
> +assert_reset:
> +	if (priv->needs_reset_on_pm)
> +		reset_control_assert(priv->reset);
>  disable_other_clks:
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  disable_bus_clk:

