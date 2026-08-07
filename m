Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67F285CAA;
	Fri,  7 Aug 2026 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111623; cv=fail; b=eW5O0rIT4EKiprl+PkVtpHS5tdArZfkWpWQwFZOFaUgC/5lezCvPWjFoPPa/g4nqfJ+5opsKiJI6lWhbEN/DVb9TidKq8X8uqyLrxj34wsI8EaoTZnhSu1oCExMHYraYwQhsftDzJTGkMwLGAbsJcHsNaGjFohgJq9u+6uXu4uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111623; c=relaxed/simple;
	bh=z6hnE6y0yAm2NGGUoacIHBgVhLrQ0WBagb7MLQ+PAAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHEPMxWg3WNiQEyLTgK9qT1imXEmMTYGcQAnAD+I/OV7huWHiiBw42OeiIM4sdtSxgCCrTKQD8cPNwwP4cX2Z3w5R66LkyGy70qEpfdNZyKiMaz1VU964pus5mrQENoZW95Iu03h0HT+9Jr4m1RTRENkMQmGhKdGkKaKLs2x6bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhdNp9hy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhdNp9hy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786111621; x=1817647621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z6hnE6y0yAm2NGGUoacIHBgVhLrQ0WBagb7MLQ+PAAk=;
  b=BhdNp9hy/El08kDKj0gCjshL1/N98KdLQaypSgf1TddvEj8FLNtvLi4e
   36ux87g+m5i5E7YiNff5evWnU/aFu8cUH8Ath6ZjGKc9pXNWY4Yfvura9
   4EQtilveUEfPju7mN52V3zUHrtkBBSuE36Dhx66Tn6W+Tp41ckIV7YneK
   j/43PgaouqEvxI8dPyZ8MTMbViwbLGU6KIeEnF1TYcT65sa5EWELD7T4r
   vI0Dt6zl/c6ElJJ7np+m+ZJA+yIiXn1PDW8iIqK+lmBEu4jn32xRJv6tZ
   CvGnUgiKIKlxqsclrKGOoK2Cl636qe9h08a3CWQFNweEu7wf+91P9gLRG
   A==;
X-CSE-ConnectionGUID: Z6Te+gU2QT6Ok9iiJAlYgw==
X-CSE-MsgGUID: 0t9nqjUgTaWnkVdvid0KTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="85691901"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="85691901"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:06:58 -0700
X-CSE-ConnectionGUID: zZwE1T2uSMizWelqoGfolw==
X-CSE-MsgGUID: CKvf3g4FTlecFtTMIeDuzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259068739"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 07:06:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 07:06:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 07:06:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 07:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/QCk+vITI7qxc64D1ye37sw2w2bJeVwIxPR0+RgXUSDf0ECEqU60fWretcYW0Rf/DU+kqfi554IsEUGUEk0cDfpw7wC1JERcLbIXdd540avsoslhDIKL3HixlomICRt8BMxy42PnYiLomJ6EnBYpEOSUapOSfSrqotjrYBE/0WvK/2Cl/Nxvq+nVUZUtI/UwDGOAHrtngyE86rre0gJrBrQLMvjozXl1D+FEzXZQPvjNLiCUPhXphbRaJj/mifuerlG1ANrH0x5yeTYNENC/UN59fM2Q93IxoKfgeC1RX3OuwoBpsxa0IU7aIoVu9NMgs2gS257S6oZbcGRdxMutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+il8uGOaa5/+c6eZvbt1acpIn7is6YdDfD9vWgx4u0Q=;
 b=qQUu+JUOQvx/qP2wphL9zT2vCq4hIg9DOlHf8zofK7oluQdy796pn0t2eLSMOcJoMWZo83S/cmUzsWTj3XM+iHP+mYa1zHbPhs+W1Jm/ftquPd63VP3pXcL7shHeUDSzPpdlmAbeKjI0fApSER1/LuyudxrKX+23OGn+nXqZBKX4b7G/ffyFWzJOKruWWp2JyA58F19/EwUqKJX7SLB+5+L5Kqt34zWUNdukDnuk2KK3X78Hi3hmCERynNmIRQuJXa+sbPooUXWZ9Qkab0sjncE470gbYgC018Geesg2TLE/0Ab4VpEGp6VvSlB6+TxC6CtDpQQaUBOVmZ8tAf0Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:06:26 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:06:25 +0000
Message-ID: <35afbc56-3b36-457c-8fbd-75d052b79515@intel.com>
Date: Fri, 7 Aug 2026 17:06:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-cadence: add CQE support
To: <rohan1sj@cadence.com>, Ulf Hansson <ulfh@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mparab@cadence.com>, <pawell@cadence.com>,
	<sjakhade@cadence.com>, <mpillai@cadence.com>, <razb@mobileye.com>
References: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
 <20260722-cdns_sdhci_cqe-support-v3-2-4412856a4488@cadence.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260722-cdns_sdhci_cqe-support-v3-2-4412856a4488@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::18) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 0327b271-e610-43e5-1ff0-08def48d111d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gYbOgXRwsyxE9qnnc07ZKzE7LDemTXxRz5a8QTaNwFHLi8FoDBM1lh0XKCz5A6TQSr+wsTJjv9hyKhQehEvov8pcOlOeNvWSrsEbr3FVvPA2fhNSi2Gr217K2PVe+c5U29DM2wPgmrwQCasotTDWhPXz8MlO8xpMRifpP9nMjEh88YuMfps00S1mew/y6Bq499stWhB/Pqg5DeJqAX2B532t/50r4+r9pu8qDE1dt9sxY+EYzW4DN5fraD/D3DdmvIxvj73QbDiO7olge4BuTBqLkm2UfBDHkU0al5r3A2pCC5vco6ZLnbVtDNj8jkmDklMDed+sBvQ3dwsPFeeoWKyndSjg5sXB3lxZA1jjJjASGrbcMMRotIvPwBrA+BWMKtWuI2EKH+aV3jCq94yXk/px05wHwpa+yyWM9SjzDxkovQLRoOI4tUGOQSjPuZvgvnPb1Tj7zYqd+/YM4A52Q78V6kcWfosyig4NZK/0wyiPNrEIpSdvbe9DMJ6vFLmDdgrfJZjZU8SMirYz5aSbgPsnWVeiXeS+4sR17pcIx5sKapjKyx0Czi8qLFiKVHYhg6hw0WTSHUG+9icrFxxJUqVCOEJ7mS6mK340v/MLh/5Yklh3sxFQ5TQaMgZ6YRZlFOmEORj7vofLb2/lSA4BUU4GPD2vGpnsYIOotCMGiaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9RZGRsR2xvYy9KcC9LWUIycDNYZy94MGp4YXRGWHpSNXNRZmszcjRFbFRp?=
 =?utf-8?B?M3EvV0drbHBYTms3N1V1RW1WeTZiRWFRWkkzTFNzT0o0NEE0d0xibUdIYmZI?=
 =?utf-8?B?TktLS2p3MXBVYWp0eHZPK3JuQTVZTC82aEtSYUs5d01pR0lwL1ZIRGt3N3BV?=
 =?utf-8?B?QS9oZHFnRGFrNEFvcmt5Y09YRzVuUDhsTTBXbWpPYklpYU8wYlk4UnpDTS9o?=
 =?utf-8?B?RzZIL3J6T2JCcXBxOC9TbmhVd1BCaGlaM2tsS1dWWkRqbjJWNEplWjZqV0Zu?=
 =?utf-8?B?L2wrKzBscnRXc1VEU3JwbWpSb1phaWdGb21MVVNpTFRXRk5nS0x1T3NPVVhM?=
 =?utf-8?B?OUFtV3JQSm9KcEJpbFdjR1FuWE5QM0Y5eTBPYjNLMzZjbnNvSzhQK0hFUGs0?=
 =?utf-8?B?ZWliQ0p2eFZuV2dzZFZXYUZoVU1BOHlUK1oyc2VDZldsZjB6SjNpMkJoRUpQ?=
 =?utf-8?B?aFdRSHRFQVJPdnZuWENBSHd0RTBGYTRRVnIwVWVkS1dkeWFNb0U0SFJBbXVk?=
 =?utf-8?B?MFJhZ2JKUWdOdzVuNzh2dmhJOHM4SGkyV1ZrMjNwcElUeHdGeWQ3a2Z1bnhj?=
 =?utf-8?B?UDNjVkp1YXBCSlJrckpwNWE3Q0F1ZWRwbWVhUEhNeXVWOEdJbzRZWW9qS3dh?=
 =?utf-8?B?b3F5cjZ3dFY2V2hHZFcvK1NPZUptTmk5elFpWlBGT2YvYzZSaGNDNXI5NjVh?=
 =?utf-8?B?M3hqS3JqSTZMSzVMbTcyL3RmamZZSW1PdS9XNE1KUzQ2cHgvUHpqMEZJdjg1?=
 =?utf-8?B?TisySCtpM0lwTzJXRnNHYVl1eGdVMEdSbWJZR3ZFWTRtNkxTeTZ4Zng3bWFB?=
 =?utf-8?B?S3plbDZlMkF0QjB0eWNiVXd6dHM3UEMxZ2ZSS3YvMFMwREJHT1kzWEwwWVVv?=
 =?utf-8?B?a2xBSlE3U3Q2d2FnZHQ1aW15Z2ZxaTZ5cnNrcm9DUGVEcE5SVFVIaUNQQis1?=
 =?utf-8?B?dDM5aFJObUdMS2tOZU8rdlE1M0NUSGVhUDJxNElHSGc4WkFQRm80ei9hK1JQ?=
 =?utf-8?B?MUIwV0ZNYkVmYS9jd0JKRkJPV3VnbHN3WWFkNU41K2pzVTFvYUZzVTdsVERF?=
 =?utf-8?B?aTFCaEF2Yk9UalU3dEdhOHliK2NRVkVoelloSTluQW81dWJGaXdPUjRpMndM?=
 =?utf-8?B?TGdGWnZtTU0ybWZ5QmVaZW1GVUpYelFHVUM2Rld0VHNkQXJKWExZU0R6Y25G?=
 =?utf-8?B?Nml5TWFhNWNLR0xHRXpYK3NzZ2VTY1QrTGV3WDJuT2R1QXJWTmZQWmIzeHMv?=
 =?utf-8?B?c24xQ3BCenR1YS91SndyeGdFWkpCL1hTaXlnaEhZbzN5YU1jclN0YldFNjFF?=
 =?utf-8?B?Umh3bGVRZGV6NVo4R1NwQlNCRkh1Zkl6TkprMEFRZ1NybnJpRWVSWHBsaG1t?=
 =?utf-8?B?dUoycnZDNnpaVnpzdE8xNEFhVkwyaWs0Rk1LcjBzVkpPQU12bit5c3F1eEpK?=
 =?utf-8?B?eENOVzZVQkphUm1EY3BzbWdWS2tGNXYzeGF3OG5Oa01MU1UrRVI2Z1pwaHZ6?=
 =?utf-8?B?RjdKUGcyUERNTGJjdWxYZmVnUHN2MThaUDRsSGQwSXk4L3o3bzBvUHl6Nzl2?=
 =?utf-8?B?M29TU29wb2FqZ0NGNTdKNFkwbU9lM3FOa0lQZkFhRTJ6ZEFvSnV4bisyVzg3?=
 =?utf-8?B?OTF2ajNQemtvdEFma1Vlc0NoaFFndmQ3UURuRWVCSHR0OFU0SmNDQUl3RU5P?=
 =?utf-8?B?N0pFdEhqZFVFR1FpNEluWHQ4NUI2cVZzbEZOeGFUVHJaSytHV012SEgrZzQv?=
 =?utf-8?B?M2N0bHE2R0JGYjY3Z2pJZzJBQUphRWJqdFlUbjFFd25IZjljcjNselYweDk1?=
 =?utf-8?B?dU84Z0dwMFAxMHdnMW01R2RKQTRqbnVjbnMxL084d2hBOUtDWjFjQjluSUJT?=
 =?utf-8?B?WjNGZ1NUcnRLakZxNjNCZzI3cmJQaFJVMUw1VXplYUNBT29wUTlhaUdDVWps?=
 =?utf-8?B?OCtIMGo1cVc0TjhLc1Iyb1lldzdkY1NZU1ZHalFqUk9XRFEyeUN2NldIUTBC?=
 =?utf-8?B?alhVQnYxcEVSdXFEMG5RbWVQbzhpajNpZUdzSDJtL0RFTTZnbWs5WmVrSzBt?=
 =?utf-8?B?eFZ3YjFyOWFMWlE0Ni83TWpCenYwRmdKNUV3S3Flell3OEw2UU9NejE3UHRT?=
 =?utf-8?B?aGxZbHgxU2xOcmFKSVNKUzRUZ3hlTytqM3ZxOEhLWDFMOU9oR0ZkZTFQb0t2?=
 =?utf-8?B?ZW44WVFBYmIvNnQvTVUrMlFOMmZIMy9sbEtVNm9WTi9SNElXWmltY2h4UmU3?=
 =?utf-8?B?enlBRWlKbldQMDZpNHVFenJXVzFxdGFxaVBydkRrVEMvZ3BLU1QyUGpzMVFs?=
 =?utf-8?B?M0V4RnFPRG9UTjh4VE5wK3pIU0FQS3dhWnJvVnh5WUFxNERLZkRzR3Z1RElv?=
 =?utf-8?Q?gzHaXpDyG64KwNJI=3D?=
X-Exchange-RoutingPolicyChecked: QEoKXFo7L9Si85YOjblMbawbBhCdUOkZtx47hT7PXo3U4KSXT2/wP2etx+HUqRjCbVXfe+2qHNnVbIzKfA09zaT3E7AMJwDjXDHR8q9SN36I3Up7NIGIu60rMz21VGDtACUZfC9gEYj0VavIOS2rTg4IWkhMbfmpmSeoXiF+CPh6k8WCdnJNACOsdRLKgkDYNjyOQkcACN/3JRMEloa4wtWKNLL9PNKP4R94R8u3rFMDQrXLG21knmmIcAYn/G0ZdKRwiyx/Auqgj7IOEWtuAmsW63KYfGlFuQ+kXrfbaibrse4Uk5VE/rBLAXPdDYIWtON54VpybGothg37muzn9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0327b271-e610-43e5-1ff0-08def48d111d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:06:25.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqqpOfjkPnwqL6UlG52rR9cL+3gGGL03eK2jG3JBTcFgFt7xzUdtXANHdzlQ0ZYV+YbQXtBTU44XiCnIKAsElg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
X-OriginatorOrg: intel.com

On 22/07/2026 13:48, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
> 
> Cadence host controller has optional CQE (Command Queue Engine).
> The presence of CQE is determined by an additional host capability

And whether DT provides a named "cqhci" register space

> register. The same information is used to identify and support all
> platforms that contain Command Queue Engine

Based on:

	https://lore.kernel.org/all/CH3PR07MB106257D01FBAA8310F90C02C58CCA2@CH3PR07MB10625.namprd07.prod.outlook.com/

please just say that CQE support for Elba is not being implemented
because you are not able to confirm that it works.

Then change the code so that Elba is unaffected.

Also you will need to re-base

> 
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-cadence.c | 124 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 121 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4f060d3e5636..2cc8133e8ef3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -293,6 +293,7 @@ config MMC_SDHCI_CADENCE
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Cadence SD/SDIO/eMMC driver.
>  
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..f1ae7743ef5f 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,6 +15,8 @@
>  #include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "sdhci-cqhci.h"
> +#include "cqhci.h"
>  
>  /* HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> @@ -36,6 +38,10 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* Host capabilities not covered by the standard capability registers (SRS16-SRS18) */
> +#define SDHCI_CDNS_HRS30		0x78	/* Host capabilities */
> +#define SDHCI_CDNS_HRS30_CQE_SUPPORTED	BIT(0)
> +
>  /* Read block gap */
>  #define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
>  #define   SDHCI_CDNS_HRS37_MODE_DS		0x0
> @@ -88,6 +94,7 @@ struct sdhci_cdns_priv {
>  	void __iomem *ctl_addr;	/* write control */
>  	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
> +	bool cqe_support;	/* Command Queuing Engine support */
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> @@ -385,6 +392,68 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +static u32 sdhci_cdns_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_err = 0;
> +	int data_err = 0;
> +
> +	/* return original intmask to be handled by other handlers if it's not a CQE interrupt */
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_err, &data_err))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_err, data_err);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_cdns_cqhci_ops = {
> +	.enable		= sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +};
> +
> +static int sdhci_cdns_cqe_add_host(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = cqhci_pltfm_init(pdev);
> +	if (IS_ERR(cq_host)) {
> +		ret = PTR_ERR(cq_host);
> +		dev_err_probe(&pdev->dev, ret, "cqhci platform init failed\n");
> +		goto cleanup;
> +	}
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	cq_host->ops = &sdhci_cdns_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "cqhci init failed\n");
> +		goto cleanup;
> +	}
> +
> +	/* add host to MMC subsystem */
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +}
> +
>  /* Elba control register bits [6:3] are byte-lane enables */
>  #define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
>  
> @@ -445,8 +514,9 @@ static const struct sdhci_ops sdhci_elba_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.irq = sdhci_cdns_cqhci_irq,
>  };
>  
>  static int elba_drv_init(struct platform_device *pdev)
> @@ -474,9 +544,10 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.platform_execute_tuning = sdhci_cdns_execute_tuning,
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.irq = sdhci_cdns_cqhci_irq,
>  };
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> @@ -553,6 +624,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> +	bool cqe_enabled;
> +	u32 host_caps;
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -608,7 +681,43 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>  	}
>  
> -	return sdhci_add_host(host);
> +	host_caps = readl(priv->hrs_addr + SDHCI_CDNS_HRS30);
> +
> +	/*
> +	 * CQE is enabled only when both conditions are met:
> +	 *   1. Hardware reports CQE support via HRS30[0].
> +	 *   2. DT provides a named "cqhci" register space.
> +	 */
> +	cqe_enabled = (host_caps & SDHCI_CDNS_HRS30_CQE_SUPPORTED) &&
> +		      !!platform_get_resource_byname(pdev, IORESOURCE_MEM, "cqhci");
> +
> +	if ((host_caps & SDHCI_CDNS_HRS30_CQE_SUPPORTED) && !cqe_enabled)
> +		dev_dbg(dev, "CQE supported by hardware but no 'cqhci' register space in DT, disabling\n");
> +
> +	if (cqe_enabled) {
> +		priv->cqe_support = true;
> +		ret = sdhci_cdns_cqe_add_host(host, pdev);
> +	} else {
> +		ret = sdhci_add_host(host);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdhci_cdns_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (priv->cqe_support) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return sdhci_pltfm_suspend(dev);
>  }
>  
>  static int sdhci_cdns_resume(struct device *dev)
> @@ -630,6 +739,13 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		goto disable_clk;
>  
> +	/* Resume CQE if enabled */
> +	if (priv->cqe_support) {
> +		ret = cqhci_resume(host->mmc);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
>  	return 0;
>  
>  disable_clk:
> @@ -638,7 +754,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_pltfm_suspend, sdhci_cdns_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_cdns_suspend, sdhci_cdns_resume);
>  
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
> 

