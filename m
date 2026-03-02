Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632E3E5582;
	Mon,  2 Mar 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459096; cv=fail; b=f1Y15ur5hJpKPxWdvPzAl8fKuDBvb429aSmmZ8pIbWbNG77U32VBUP1t8Zhsd4Tlq3G25To1z1YTukHjnvriJ1WYmAZSS0lTDoD88RAr9tTpf5DiDnuKYEceAv9V1c627+kIkr3LI+B1rM7PjTDeFVH22uK8g3BJfCCcg1TNO74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459096; c=relaxed/simple;
	bh=8O+39M4WGmK1IUQJM9GvRROC+ngUtgzJm9k8+jNHvJc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GcO1vSNOsPtrKdbavj+rVmFZexf84LxxCyL6WVyxsgUFxhxYuMZp2R/0bi5ZAqoupnt2PDCraasGdy+kEVh3y16Oue+fBi/ZS3QsFj5jAhVpOi66GOEJuT6F57eRAn/ZmK7+LThqk/h7daaQnwEnAZ/DaKjs51EprINrsU2+WQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csiAQASs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csiAQASs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772459094; x=1803995094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8O+39M4WGmK1IUQJM9GvRROC+ngUtgzJm9k8+jNHvJc=;
  b=csiAQASsDD8CEzw3YR1156C6s87FCTbQb8lPy4qVhXdXqicY75/nID3E
   8T1yWc8CuYPt9D47n8FEwzr6w+JJHoS+e0hQLUQc51ChC5+GyG1F0pAub
   KHroC+bNw6OaRqjQF4SrbhzX2asNx0nn8HdEfVTb13JZnAqnGEUoXkf/p
   bMFhwB/vxEAfbj++b042irxV8/HOYFN+ls1rFD845LgxLd22F47I7QQJy
   ESvnpB+sTT9ofBzyBoXokj37LDUAeX2RpZeAoj7cggGtvBl2KkpwAiagN
   kb8xDDjypD3+8nBqArJJKcVtjVlyU2FfDJnWSA0J4Q3L2KcE1CG2bT2Wm
   w==;
X-CSE-ConnectionGUID: qHQxlOeNSxe/iL5Jjr2JPw==
X-CSE-MsgGUID: U+H2BRlIR5m+uXGmcyl4EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73168022"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73168022"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:44:54 -0800
X-CSE-ConnectionGUID: 54nYdACkQkKEdEE5u+JJsQ==
X-CSE-MsgGUID: suNFRDqFTqSEKjLwnzzJZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222635819"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:44:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 05:44:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 05:44:53 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 05:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4HRH4adAX4IZqO37UH0dr3bBHXF/Ts85TQQKBhcR5t1/YEiB7r9fVnFQmOXhqT6bPIdGzK5dbMqrvQ0YolS5tbi3uP7PDsxi5+eNH2tnhpm80LTZ99CsFKjgCUJ3P7vndP8arR7NvJeg3sXpspo5dN32+35RgVkZcb6lMeml0+QqqfzLFfH0MZgU7pJZ9nyFB/n96mSNGjJ8nZiD+eZ8fQG6bMHP3zntfo6E39WRXuI+8fkWIQ70O3zFnd28U+Qyo4Op7cQRuiuttTVcQTe0jn3gnK68gqujcet/trRArZRGQA0K1OimvjoO/1UylN4OUqCmlOJjzvn6QGHDPME/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiHoZKSl0NfRuZKaWjxg9pq2WNBd0sAfR/LmiDB4hX0=;
 b=oTmXlprbmW8uX1OSJUnaFoqRBYVt5DPKbRG0LeN5YefRInlds4GkmyfKxuxEtMUVLy8zBSUp3sd1vSQOK920MMbW6+WpnqLVWsUDnZwGDw5RM5t4CGoHqwtuBcDNhNLJIPVNDD1IG89AIo2ISITQzRwZvXaKT5/DmROA/aEYtgaGG4ttEMXX8WpTV1NchbPxMOwdD37gRPfbhZoc02nCrb+CiGDCYMPVnbabANc8Ctr3NgvEQ9ZjymkZQ72Ekz8Jc9Vb+YeLo+Bo/BEUyP5I/XvyKKMj/8iVouqt6y5I+i1HcjXR76s/yfL2scaRvISRpoFG20ZtU2yUfQqouMyiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:44:50 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 13:44:49 +0000
Message-ID: <6c7cadff-f078-4b02-97c5-b7f0635501c6@intel.com>
Date: Mon, 2 Mar 2026 15:44:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <Frank.Li@nxp.com>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 80497384-2c46-49be-8ba6-08de7861dfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: 08P6vKihElEz4YhcPLZcu4cbzsbnLGXGlD5DBJofZiLT5+Zkukf+rnmCv5SJnNRcDr05kvbuLSEkS5YFtWzNzFNYmWQcyeHgh/5d2ryGU9EaeDnHduAUYOGaoT3iMM4d+zh8awHI6a/JhQju85V7rOyDfCZNTBUcy0dZsz4Kl+w+2NEECd7kB0RpgDri7zYVSQi6BuJ7lD7fMt0QfCaRal5UpB34W6eoOBeAR2jGS+W5yOZxaWN20wKeyNmLFnatT4cXYYMleGMm1gBOM4zPn5a1BgziNyAbcsKt7+gE7PQMc48IGo7h2Rtd01j4cCOgMJi+2XQq8xKb7ceG+pHPLPNd2PxhrY0Tya1bOzAsahX28jQtTATLMH1Z2TFQ6Wq2YHLByEGrF2I4ojUMdcPHdwbXPyWu/q/5F8wYnen27jFahswkT4qxJ15Vwt+yf/+msBMRMeJQE9yaocj+FSV7NnunOE59VeRRblVl1g2RNl9ewXZjnfzLYdThinCex7wOazb1h8jDnvh6HtAg5B9hgz37g7kcqVcI7aZ7e0gedgL5IViRyx0s3WpAN0u5AkvjpFe+yGCb4er3r+kKqQum5atcMkDvtaR/kE5NYtNTe112IT1ObEQ2Ja+RCa+964upjKWN+4PYUPpZhVbUC7GVaezUIqwvQvh8lL+Y/+PxRRsyod2+9XXmP9IjM8mc0aaTEm2hvtsRSUYoP4Jh8ppahsNZ5b3rgezB588iX6ntV+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRuczVGU0ExMVVjM0gwMnNsUUpuYUV1ZVlUNzRlZnVtdVd3aFpqWFhYZEE1?=
 =?utf-8?B?MW5KQlpLWWN1YncrSDNIcWRGWWVHSjBDdFg5eHpjWlNidE5Tb2JIYzFZMWtE?=
 =?utf-8?B?MjdiUW5Tc3F0U213Z081L0JYUUU1Ujh5b2VrR3NOOGpTNHBoWm1zVlNyLzJM?=
 =?utf-8?B?NEkxakNDWjNIOWZoeEVZeTlVSHBsZDFjQXFKa0lnK081ZGNHUFF3VHQwQ0sv?=
 =?utf-8?B?QTRXYUxPWU9MQ0V3OXVhYWx2S1NwU1cvUDViRVMyYXROV2pYOHlQeUFuSDNr?=
 =?utf-8?B?ZWs4Y3V6YjVvMkQ0R080d2l2R2JUYnJ6dXJoQjl1Rm9iNVRVVWNxT0FXYXQ0?=
 =?utf-8?B?VzViKytIYzdjL29iS3NBOHlHRDdGSmlTdFpIY2dydnhPV3hVVk14a1o1TTZV?=
 =?utf-8?B?b29IU3dWclZWTHFKdXlGZllPdlRVL1Bobk1lc1FiY0lRQjFUZHphNDBnNHNp?=
 =?utf-8?B?RTFRWmJETlNqTDJMbjlWbmJ0bUxrRnlJRTl3eHNVL21ZaUZsc0NpaEFaUHFm?=
 =?utf-8?B?ZjVQZXF2Smp6NTBUeWd2TVRnaHU1bWM0YUhTb0p3aXc4OXdpRE1rRlYyZmNx?=
 =?utf-8?B?UmpNUTlxaUtVTjJiTS9wRE5oZzZINkE0ZzBSclF4cVJzU25LZmxQOHFZU3B5?=
 =?utf-8?B?SDU3em1jdXRVUnJ0WjA0ekNNRHNwZENUcDlLalZCRGdzdm9PMVpGbTE5Q2pt?=
 =?utf-8?B?ZVNhTk9wZEY4OGtBdFM3dWhjMVd2T3RsQi9NSVc1eStPbExxaVFWQW1jbERE?=
 =?utf-8?B?WlJaNUtDbTNPeUlXZGQ2QjM5WjNBRkt1SE10dGRRUmtmU0huUC95UXY2TE8x?=
 =?utf-8?B?dU50N0xYRUlEUjNVZHdDSDFSbWtmUlprZGJLK2VSZEp5M1YyQmk1SjNic092?=
 =?utf-8?B?SjBqY2QrT0RTelp1enNjbXkxWDlaeXpDNG9pdkRKNzlNcnF4WUdCSkdHK2t0?=
 =?utf-8?B?cTVReVJhMDYweERJWitka29JcDJHVE82eVlFaFpkK1hORGFVc2t1WTZzUEhS?=
 =?utf-8?B?U2F2d2dqMlo4WHhSU1djckFtdjliam5NdVRnK3BwcmNvM2dpczlIck9xeU9z?=
 =?utf-8?B?WGduMk1iN1M1RW1xbFdMWmdOdURyMTZ3aFpVYkVYV2N0d2xuT2dMd05RTlpm?=
 =?utf-8?B?aDVIYWR3TlE0UmNDaWpwL0llMXh4M1NEUjZPVmJzQlNUb0ZPTEc0cXlUZk1l?=
 =?utf-8?B?Ky9HWjYvMlA1WVpPWUkvRGlQNE9GZG9ITytMNWZuMjhFSWluRFJLZUlCL1lt?=
 =?utf-8?B?QnZMVDd4aHVIZ0hJajQ3VXd5U2h2MEdwbmhKb2FVdHpqOXg1amNiQTlHOXJx?=
 =?utf-8?B?QTFwZEp2bThVWnA4SkpsS2RKZStwT2kzZVU2MmxrT1NiaDB3N2ZYOXZHU2pO?=
 =?utf-8?B?SVUxaFRLbkZmYnp3TGJhQXNZOWJmV2p4SE15c3prVVNKZUlmOVlGN0F3VnVT?=
 =?utf-8?B?MW80QjBpYkpjU3NZcXh2QUM2YU12Zll3SHRsUEZUQzRNSys2MFVZMnpOQ0Qy?=
 =?utf-8?B?UUhFUm1aNmhYMEg0eE9ITEpJYlFwSWxyUHYzcmpXaVFIKzVOVTVNWlByREpr?=
 =?utf-8?B?Z0ZEQnZuYWpvbDY5Y2ZEMCtSeXp1NENXKytJWm9TSnJwUi81dEZvb3NOR2g1?=
 =?utf-8?B?dGlxK3ZXYmpYTXJqVCsrb25DdHNKZVlrWTd0RlJPS1YwYlBZeVlYUSt2b0xa?=
 =?utf-8?B?VE9Yb3ZlT3JObVVqb3JaNUFuM3ZET1FoVHdMbWEwWG1PRGlaTXRqbkMzRUpP?=
 =?utf-8?B?aDF6ZllnSjJtNklWVEw1SmlwYXBsVXpqRmNRcHBjR0VWdEJzVW9pNmxMdUJR?=
 =?utf-8?B?VG5LWGt1ZmJtbGJHcjNLbC9SeG04MmtYYzJOK3VIQlFRdFFaSmNUamh4Q0dy?=
 =?utf-8?B?RVRldzhsQk56RWN2WkdodlVUSUo4bVFWKzE5OVRqQ0F6MG9zNFNtbE44RWoz?=
 =?utf-8?B?ODA1VXNnWEp1S3JEclh6ZnNDdGVHMUJIQ0NpeWdsT0FGeDN2R2JkZmYwWTlw?=
 =?utf-8?B?eFlIVkZMMWlQRExCZzBBVXNKR0kwdlV3cTBRSFdSSGIzbFRORG9nWGpLQXRN?=
 =?utf-8?B?Rkp6Zmx5VEhnenVSbVd3REhocmxKZVg1ckFIWkt0NFRrRThuK1RRWDNBTkFU?=
 =?utf-8?B?cXY5aWt1M2lOS2JwSHpoS2tKZW1vUkRzY1krbHhIcW5NWHVUS3ZmNjgrSXEw?=
 =?utf-8?B?YnRVb3pQS1F6dlBsWGtoV1dlZ0tSWDZGTFFDNU9URWQwcXcxRy93WmcvZ3cv?=
 =?utf-8?B?Nk1kM25PNkhrZ3diTytGOTAxVERqRCs4QTAvbFdXd2l3WVpYR2FoWUlOaEdx?=
 =?utf-8?B?a0ZUMlkwbVJWWW56U0NYVEJDNS9MRFVIOWJxSEU1SUh3RC9hOEFKR1BtZWxh?=
 =?utf-8?Q?7JoXPPahGqJiqA7A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80497384-2c46-49be-8ba6-08de7861dfd1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:44:49.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciz5SuOKheuFR5IEq6dil+Yc1RDcH/lQcAs7gaAmc/RSCvqxA5b3h0n6i1K6gkU7F8ZeN8ThVsenXUlUIYV6ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com

On 02/03/2026 10:00, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> This series adds 1-bit bus width support for sdhci-esdhc-imx driver.
> 
> Currently sdhci-esdhc-imx doesn't support 1-bit width because it
> doesn't call sdhci_get_property() to parse "bus-width = <1>" and
> set SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.
> 
> After adding sdhci_get_property(), another issue is exposed:
> mmc_select_hs200() returns 0 without switching when 1-bit bus is
> used, causing mmc_select_timing() to skip mmc_select_hs(). This
> leaves eMMC in legacy mode (26MHz) instead of High Speed (52MHz).

How do you end up with incompatible caps?  If sdhci is adding
them, then maybe stop that instead of removing them later?

> 
> Fix by dropping incompatible UHS/DDR/HS200/HS400 caps in
> mmc_validate_host_caps() for 1-bit width, and clean up duplicate
> code now handled by common framework.
> 
> Luke Wang (4):
>   mmc: core: fix timing selection for 1-bit bus width
>   mmc: sdhci-esdhc-imx: add 1-bit bus width support
>   mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
>   mmc: sdhci-pltfm: remove duplicate DTS property parsing
> 
>  drivers/mmc/core/host.c            | 19 ++++++++++++++-----
>  drivers/mmc/host/sdhci-esdhc-imx.c |  6 +-----
>  drivers/mmc/host/sdhci-pltfm.c     |  7 -------
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 

