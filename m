Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0447154C17;
	Wed, 16 Apr 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825644; cv=fail; b=Hjxr0i+rD2uvwPKn3sYj0K1ziA0Wo3fdbLzUhVR6Z1SdHRa+GC5ZYgpxmYX8TClMFwohmiP8nvF2uxo+T7sxx92lhjym7TGwYelRhmQ3+09mDJftqz7ui0RHZ+bGN8R+n9n0v7d1/cCgAWhRjqgCG1qJM9UF7gyySos6uYmWbdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825644; c=relaxed/simple;
	bh=kV5BGQZgGEftmNZzmxEEWuedAYqXdHRs8G9sjqz9z0Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=drGKFrK6ZuINugIp4r6nJaDsGJ74g4Hq+ewipBWOSIRWCCneqbT51XV+uoUtZb6dFVrA4H8ta54EKu207dqbHMQImYe1b/y2F5bRQZ7SnnSTFs4gM3NZXLoOUcifkc6Sl5lzHtovwPUzxdnfSmpyDbP5njPVrT4Xf20I7zEAuvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOmgP/A/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOmgP/A/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744825642; x=1776361642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kV5BGQZgGEftmNZzmxEEWuedAYqXdHRs8G9sjqz9z0Q=;
  b=WOmgP/A/bVv6rMM36LmBv1bFhxguwQewQirXsukOuezVlyn8qYHFCKw1
   fWHz9A5OxcpDq8cGkw3sgMUcyKGzvz2zWBs9zU24IOMbvLFKLhvoazBhZ
   7Q8ZQ96TpC3+CkhCrzeTU4ewqFY1W7g2VCgTPv2hMC1AuJ1qndt0wRXrW
   i7QYGBczo1ILRW21Kx954V2L7qb8jju8WRO+NeqMz6LBjLHNOUxXAwm0+
   Dnqbu+lrnPOoJp5UtyhpcJaZC/2xCk2/JTMRAR4chSbuoDpQEXMF5L60T
   CVVR1EI+8liaVfEVletQKsoNRrqFA53rBTUgu0XVWMw1JtW9a15ovDKZr
   A==;
X-CSE-ConnectionGUID: HPDPCD4vRpmn75Vg8kEySg==
X-CSE-MsgGUID: uWHNoyVMRoiO+NEOuQkWvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="71778347"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="71778347"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 10:47:21 -0700
X-CSE-ConnectionGUID: 5aG7iGSRTAac9/NIj996SA==
X-CSE-MsgGUID: SbcwbNaNS8KQHBjq3HcNAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130411039"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 10:47:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 10:47:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 10:47:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 10:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEC7ZtAl2vs7rhELif9nsURRa8ru/r3idXWnNmLgXWYW2dNzvWYcjrKwn9JNPoOPJ4Nj0kxLRcN4z8xjyL3w60Ebh0+xTFCorKPPBTRel7PDPuZyxirsaygpAvKFsFLGtdXEPNgubAgBCiRlbl/c7bdB8FaIdveCxlQeHo40LAGFfDcd7o6A80ARpVs4zNaou1epr75dQfcE03v1XWlylS4QdlXAxk9APO/ieMPxSJP0BtyLzoOgZbbelENkx+9xjV95ywwniDLSt+ObD+GTnr1u59oW3tenZGwx8OydezD/8eelbus6HKS6CnXUHlc+BtQK/LCY0GVMjZhHeMaYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6GennEeIE1CaTVXnufGmjDYRdutt3opVjtLNZip+6M=;
 b=qRNi8a0mRpx7rhpTs6NswP7HxzSIu63PSmqNh2yZ+bLatqxu1kDNvm6264B31x/+E74fOc5E+ZvyOE86QpVUxpRp1A5hA2hZtjQYzTw+77u5ErUvYsnGKztorLQhGkkmET+sl3oo5CiVCr0PRVRX8A+kHjeQy21YvuDy37RtG0+dKDatWNrSFJwh77vxlq5P/KMAmUt5sSAkaa37BvZDM1cBo9Z7Mm1ZAn3/Okq7aAs8mLMpjPiB8ZLfgyziMPPs6tI7g6jxzLfwBN8IuD0aSKvqSfvbrQkHWCM+eR6oXASTeE7hVg1ALXklHSgeKeisjkQ6/B04hABjlLLQ+IziwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.38; Wed, 16 Apr
 2025 17:47:17 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%3]) with mapi id 15.20.8606.033; Wed, 16 Apr 2025
 17:47:17 +0000
Message-ID: <97f0d613-82ab-46aa-84b7-4bd04f7bbece@intel.com>
Date: Wed, 16 Apr 2025 20:47:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
To: Arnd Bergmann <arnd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Luke Wang <ziniu.wang_1@nxp.com>
CC: Arnd Bergmann <arnd@arndb.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Josua Mayer
	<josua@solid-run.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250411085932.1902662-1-arnd@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250411085932.1902662-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0243.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::16) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA1PR11MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd9155c-c74b-4706-317d-08dd7d0ebaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TC9HdGFOZXQ4UXdPTFpXZjMwMjZ2SHJDWFBsU0kwQmFIYXhmVTlKV0Q3b1A2?=
 =?utf-8?B?RlFJTURMbnErcE00QVUxYzluaWQrQU1PSm1RSE1WckNEb2V6aFp2UFEycFZQ?=
 =?utf-8?B?RlJPaHgybHQxS25USmwxd0E5eDExdm42UzUwMHhtakkzemNnRWtUcmZEVDZI?=
 =?utf-8?B?MGorZDB2a21SdXRRMFBDWDFHNjN0MFJwS1AxOGpNT3FQT0xLSEJndk1UQkN0?=
 =?utf-8?B?QXpIOXBhaVdHbHczWUQ2bmVOaFZTN215bUdheVV5eENBbmltUlduZXpBU1ZN?=
 =?utf-8?B?OVdwUGVQZit6L2dTclVySEFJbTVFMDlFaWk3MEIzYjhyNHYrZHNCWHZrTlYx?=
 =?utf-8?B?c1cwKzIzVTFTYkZnT1g0RzNMVEtvVGNneEMwb0wyamlidiswbC9WUzRZOFBu?=
 =?utf-8?B?aGJaYXpObExRYklsWWZKVGZNKzVYdHlBT2RPekF4V0E2SXdXQU9LZzZlbFpQ?=
 =?utf-8?B?U0EySSs2am1KdHZjRFU4YWtEeGVPUVBHZ0huU2ZBUmlwSkFSbXdQY2JsRmpL?=
 =?utf-8?B?RWdJU3FCaFFOWXhMQ0NaL251UG5hZkJaMWZMcHZXQ2hlWjZMTitNYzJoV3Jv?=
 =?utf-8?B?bllDd2g0V2ZrS1ljOWYxbDhFNWMrckZuQ0lXZkhWYXFjakJ1Q2wwMmkraE5F?=
 =?utf-8?B?TC9QVUh1V3VtR0lWZUZxK2ZaUWY2SUZIbjVCRFZFbTI5MnQ5azI4UE1qWDJj?=
 =?utf-8?B?V3NjZDJRR0o5cGNrZjRVcW5Td1Nnbm1MQXNoVDRwVHJtcFY4VDdhSm55OExv?=
 =?utf-8?B?YkFGQS9zWno3ODVVS0VwWU5hTEhQM1NZY0Q3TFR1OHV1Z2F6Qm12cG5EY1R3?=
 =?utf-8?B?THczM29rSC9rN1lmUEZMU3BBSm9wa1hxcWhDWEtWcnhtZHM3cE9JSGhERFAv?=
 =?utf-8?B?aXREMDJhUVV1bVhGcWJUYWhWYUEvS0hPRG9zaFBaREN3SlhLWkttbW9Qditi?=
 =?utf-8?B?WkZUL283Qzd1R3ZoMkR4U1p2cDdTZ2ZJck5DQi9qNFl4Qzd5aEN5VG1KaE5R?=
 =?utf-8?B?RzZ0OGtRMHpmUjA0WjBNSHFTWUcvS2o4QnhhZEtBV2ZnbTB2eVJkWjRyL0Fa?=
 =?utf-8?B?VXJOMUp6Z0JOUFdDcVd6ZHJYY1M3eWlncXd6UDU2TDFqNmhBSlFXUW9MOS9Q?=
 =?utf-8?B?UzRDbFRjdzVOVTV4d2kranErZnZDb2pXSUhJQVZQWEVZWVVnQ05jSXlnWUVv?=
 =?utf-8?B?eGhhS0tHalIxdUNBZ1BOWlRsWXo3U1kyQUJNY1pSZzlkUWFTRi9pVlIzQVJh?=
 =?utf-8?B?a2xDMThtMk1KTTRpS1BrWEFoZGpPSTMyU1E4VGFuWGV0ZDBHUFVjcWs4NlRB?=
 =?utf-8?B?UnRnTVFZSk00WGxCRnZQOUxvRkY2K1FJTmg0cWcwT3g1TnlMbHJjeFZxYnpZ?=
 =?utf-8?B?b2xyVjBMWlBmQjg1UWtuUkR0MmdMK0IybWJIRmtONmI5eFdIRmVzcDh2V0V6?=
 =?utf-8?B?NHROKzUybUtPVzJSdm1nKzM4TWtzWUFXMlkyVnVRa2tyN3Z5RnNUWGlxYUJM?=
 =?utf-8?B?Y0twRXFwb3dydHZ2emMzK0l1SUkvaTR6b0lXV2MzN0c3SU1kalJ5ZGI4Zlhn?=
 =?utf-8?B?a1h5KzJyVWpMbSs2UXF6SHQ1eG8rMVlEcnpBY1poRmtNdThWQ0duRDY1VHow?=
 =?utf-8?B?NWwvMmRmWEsrbHhnSFUwL2xZWDRqRkc2VFFqWVl0a0VSQTNJTHdOWTlXWWxF?=
 =?utf-8?B?R2V5ZjBJckFmMW5EVGkrM0twODZnRE5yYVJUTnVmaEh0eEN5Ukt6TDduQ3lG?=
 =?utf-8?B?aFFYN3lYUVRiVkJoRlJsZXNhZVVzVmtweHFSL1RTaDBoME5GV2ZhZFc3K1Ju?=
 =?utf-8?B?RTY2cnBvbGRUSVBGOEdEek1FOXFITnRoRGRGNDB6T08rMmtZN2lXRnBDQjFN?=
 =?utf-8?B?TFdIcThkdSsrOTFyWEsreUlzaS94bEQ1UFJUT212aTdsN2pLZDIyK2JYY3pz?=
 =?utf-8?Q?s8R3MLGaIwU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3crTUxWRDMrKzNtZFZSbDI0RElRMkc5L3JoeGlCMm5xZ0xNRlJzY0F1M0JJ?=
 =?utf-8?B?cGI1LzMya1ZQU2pRK2VXM2JCQS9UZXFkdG93U20ya3NmaDJMdHdsL1Y3QnJu?=
 =?utf-8?B?SGRWYXo2Qy90UDNXQlFuejM5anVybVNYbXZoR1Q5OWovc1RpQW1MTC9uNkp4?=
 =?utf-8?B?TjQ0TjVTTW1hU25yOTZqanJlSjdZS2dVTm5LMEk4KzFRd0FxYkZJVm1FTEY2?=
 =?utf-8?B?enlIcmFvaFZBQW5oTXZ1anR1SnZlTm1GeUJlaVlXZ21lZ09GMXZwbGpIS01v?=
 =?utf-8?B?NEMrSkpLVUcrYklrdEJqVUZtMVpqcFVHV0Z6UEVpOWQ3WkJLaUpyMklLa05F?=
 =?utf-8?B?NkowVEtLMXUwM3dVMmp1RnRRdkRXSWJQTVM3RWlKQmMzeHFvVXg2MjZlL2Uz?=
 =?utf-8?B?VGpSbWxzMThJaTRoeUFCclFxMThXcExycHhobnFqeGJrYlZReDdaRHFlVm1U?=
 =?utf-8?B?SW5TUWlkMjlqZTdoZFowTDlVcnhtaUE3NFpFRVpDTXFpTHViRlNQeERLbzJL?=
 =?utf-8?B?RjR6SEcwNFA2S1dWUkJPWFhhUWpNZEI5Tm9xVmpDdjZ6L2svUmNkWEdqTzhV?=
 =?utf-8?B?dVMzdGppZXc4Q05jNFg3bFkvNVBQTE1YaVc2Q0RGdkthSEpjNWtIbkhNeGUx?=
 =?utf-8?B?NDV4OFBrSnMxRjdqdTM2QWxERi9RR2w5NXNXMkE0TGhTalBQejlZTHp1Sjdy?=
 =?utf-8?B?c201RWRMMWtzdzJyU2M2RndNUXo3UklVekd3WXNVajFhRCt1QVRWMGlpL3Vz?=
 =?utf-8?B?MDZXZ2lGbEorVmRnUEo0WHJVSjRaWjFxR1JZWkhDNmoxS2UyMCtPRE1GMDVa?=
 =?utf-8?B?eDNhWFJLL3NuMWpNcS84cDJLSGJ1MEJXWnUweWEydXJqZVdNRE16dDlNUnRa?=
 =?utf-8?B?N1hOdGlnVzBpa2FYVXN2eXdMMUtqSVVMS0p6Nk51YkszdnJYVjVKTkxrY1Fu?=
 =?utf-8?B?K3dUMFJSMHZFMUppcXBUR2xxbGwyWlE4MXZSN3hKRk5EbjY0Sm1SR3NQWE40?=
 =?utf-8?B?aW4zU2R2a2VmUWhpQWhMNk9MOXlvbWg0RWU4YVBjNXBrYlloV2g3L2s1TkR5?=
 =?utf-8?B?QndHQVJUbkU0Ky9lNy9BV01ZRk5XekRoUlp1R055UUdFSkJuVHVrV2w2cDVm?=
 =?utf-8?B?bVExWWordnpGUnltdEUrY0UyRFJsaHFndFpndXE3d1ljT0tjdHpHbzJtTks4?=
 =?utf-8?B?cFBIL09jSmsyZWtuMUxnaThqZDdMcWNpWHVGYk1ycmQreUk2N1FDZzdSYW5l?=
 =?utf-8?B?ODVpUUVFQzFOdkI4UXU1MWRsQVU1TzIyU2xxSXBXSHpWeG1UOW1kcHN0OSto?=
 =?utf-8?B?dnl4cmNxTFRXOTlNNGMvcXhlenRjNDNuOVVVbWJPLzJwc0QzVGJlWTJvc2dh?=
 =?utf-8?B?bjJqUERiNU1mclFMYlNOVjdWSW84cmlBb3FUWXZWZHEzcEpCWmVPM3FlVmtM?=
 =?utf-8?B?RGVKUnFsbnNzaTFUTVNWUE56OWl5Yno5ZWZOVis0ekdFT0NoTTk3c1JkdldN?=
 =?utf-8?B?M1B6WEE4TStDRnV1UVJEeEMzWEZRMEhiQ2dUVjVuNXhmQ0phVXMvbllhWGFQ?=
 =?utf-8?B?WldSL0VwdGJZZzMrdDBnaDl1bHZnWVI3T1hEUURlK3N4QzV1T1FKNHQ3cUhJ?=
 =?utf-8?B?TVk0MDdySEI3OXhLU0o4VmZvNlZleFFpdUVWSkhzb3NpcEplTnEveTR5UGZN?=
 =?utf-8?B?b0x2S3VJM2VyOXlzR1BEN2N2OXVYNkgwWTk1WXhtbDU2a3V4Tnl2NHArN05m?=
 =?utf-8?B?bnRCeXRLakh6MHo2SkltbmVoZ3NPZ0hzNU9mZkJCNXRISkx5dDFsd0dGNHhC?=
 =?utf-8?B?MmcyVWJUcUJubmxGTHhaclpwV0dXVjl3ZHlxZHNWd2ZQLzJCZ3NIaVlmQnMy?=
 =?utf-8?B?ZUtNQzVKN01SVmRWckZVTncyRFBMcXBZK1FyV3VjTzVhU2RMOFZJTWlqYUYy?=
 =?utf-8?B?bkp3SzFBbCtYLzhmMGx0L2MrS0w4Y3c3ck1hc0U2U0NWR1RBSGxXQkFQSnd2?=
 =?utf-8?B?RmdJci9wS3lWVnUyS3Y4T1pDR3o4TjREcHRkOUpUcDlJd0VjK0M1bTNEU0Vk?=
 =?utf-8?B?ay9JQ1NoT3hqQWMwYVNpYzBsYWh5cHNhbzR0cTdRY2U3OWFQZitxRHI3R2Vr?=
 =?utf-8?B?R2FQUFZqY0lYUkVzYWtQVlBxV1I3dUNHWHY5L2g5elV4WUJrYVpiT1ZzRSsz?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd9155c-c74b-4706-317d-08dd7d0ebaa6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 17:47:17.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqvccQJVf86Jy5ZKrTBxud6z+qJiGsaOyO2vGrWbpOxrXwPpjb/FNVFGwN2t5GhsV1IQY4XYySlS8jbIIubFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

On 11/04/25 11:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Two newly added functions are unused in configurations without
> power management support:
> 
> drivers/mmc/host/sdhci-esdhc-imx.c:1586:13: error: unused function 'sdhc_esdhc_tuning_save' [-Werror,-Wunused-function]
>  1586 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
>       |             ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-esdhc-imx.c:1608:13: error: unused function 'sdhc_esdhc_tuning_restore' [-Werror,-Wunused-function]
>  1608 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Remove the #ifdef checks and instead use the better macros that
> silently drop the unused functions when PM is disabled. This also
> requires using pm_ptr() to eliminate both the runtime and pm_sleep
> operations.

This explanation is still a bit mysterious.  SYSTEM_SLEEP_PM_OPS()
and pm_ptr() make use of PTR_IF() which uses a conditional expression
so that the pointers have a reference during compile time but not at
link time.  That way unused functions still get compiled without
triggering -Wunused-function, but get dropped by the linker's
dead code elimination.

It is perhaps worth noting that dead code elimination is not
default unless -O1 or above optimization level is used.  The
kernel currently uses -O2 or -Os both of which do dead code
elimination.

> 
> Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nevertheless, together with the chunk from:

https://lore.kernel.org/all/3d544dbc-863d-4ac5-9839-aef3a36881d1@app.fastmail.com/

i.e.

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..4ee2695b0202 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -874,12 +874,10 @@ irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
                           dma_addr_t addr, int len, unsigned int cmd);
 
-#ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
-#endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
 void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
> v2: add pm_ptr()
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7e8addaed697..3c2e50d0260d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1942,7 +1942,6 @@ static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  	sdhci_pltfm_free(pdev);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int sdhci_esdhc_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -2021,9 +2020,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
> -#ifdef CONFIG_PM
>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -2103,11 +2100,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>  		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
>  	return err;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> -	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> +	SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> +	RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>  				sdhci_esdhc_runtime_resume, NULL)
>  };
>  
> @@ -2116,7 +2112,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>  		.name	= "sdhci-esdhc-imx",
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = imx_esdhc_dt_ids,
> -		.pm	= &sdhci_esdhc_pmops,
> +		.pm	= pm_ptr(&sdhci_esdhc_pmops),
>  	},
>  	.probe		= sdhci_esdhc_imx_probe,
>  	.remove		= sdhci_esdhc_imx_remove,

