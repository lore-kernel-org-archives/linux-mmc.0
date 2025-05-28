Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B42836A6;
	Wed, 28 May 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433536; cv=fail; b=PCn1mAzix92nMyal76dN+2p8MFwwaJu+OqWoP72RkPZ69Jayoq5jvFIJ+FdrLv5GZ+awtvyjwmSjlvLt5g9iaxfwRuiPlJelPIYkdgADns3zrPXtcgIkiPmiUlbztXyr1iv8vycMZ8JHPcb8kBPFYHBlKkiYjbpwxx0mm2oN/qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433536; c=relaxed/simple;
	bh=lmWHwr4l3HpIumZl5KwV4lBbVweV/WQ8UaK0ICFo8Ko=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BSuGonK2alnCP97pwONLpSzMsQ6qmm5rFIsAkWcRvixUbecnxACI2lrF6SH9bc2xMlYUbY1CVfVhiw24yo8vhegvGMKWUsEmK18JcltqsxCoWh3ATkVqP01R5tVHrM68TihOPBP8VPL+c2l9QRyYe5Z2+AfNeB4mk6a5KSSKLR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXslc4Fc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXslc4Fc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748433535; x=1779969535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lmWHwr4l3HpIumZl5KwV4lBbVweV/WQ8UaK0ICFo8Ko=;
  b=BXslc4FceAC+ZoVpJs/n2I2yM5T35rD+hAJySckmZSEdN2ERlFfJgaE9
   pWCYzqEUsV+YfM9MaZoYo5ob21s2Yi8H72EvisPzexVACFeR2OcvEeGFk
   vkmYXSfWByIvarftQhQnj1oiZ5tXCOrwxuR5PgEMGHrJDaObI6IJiwpkw
   UamyranG4R8LkQby69J1cxrxzyZVlcWmHi6bCORN9fvVNAVZB/Eh9Tcd2
   7js459YiSOTBW/7g2uwU6wkFwK5/68DRb7RCleNQzyU/l8HxlxzC6bldV
   EONlAe6PGGR0ydI8jXRqjF+Wgw0soaCxOcNP2qJZYzAjmAp4vDJUbS5lf
   w==;
X-CSE-ConnectionGUID: FH95wgPCRbudW/h8dP2ewg==
X-CSE-MsgGUID: DW3qB/WESHq/0M3YPMPfWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61512073"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61512073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:58:55 -0700
X-CSE-ConnectionGUID: OXsd3D+/RHuAvQyTNf8x1A==
X-CSE-MsgGUID: 3yonRZRSQ1G9T9D5SNyDIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144194890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:58:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 04:58:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 04:58:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.81)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 04:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0SnVA1lwi17GZSL1ksEdBRz0uBpmlboSBMtArornsVtCtHna5Slu5zqvv6ykD1aLD/NUtRpAJWYZZSfMQBSe9x9F43i72rmAnkfe014X9WCmvt4IE8Y25mNFhyzjnIKYTZ7HN6fbRIV8mSYiDwDU2rshcCtDoLuBYVlCSRFg60PL0eS90s9ICkEhP+xaWUH/GbFn1CovnJe1o++vgxFFhlYeDQOsPY+g42PKUvFyEgYy4j/KpZ5Xobkk51CQ/ns4Ue1e3wabzeqEMFf2iB/oQax5De63HmCMCnU/vpaOcT39eXeaC2AoMYR53YGep3moN8+KrkVW3KjoxCTKxBAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTu1QbOfLHV8T+ECsFFl3IZmB3BuUJnsUJ90MyYCrjk=;
 b=F/GHTATi/hg4PH5478zUGgp6T00VlhZPcCAz7dGF/mnnuLnyslad9uFLhP93Ups71vv2lB2Wuv/HsWqzvndnwDumFDuTYu3RnCWKAGms5Hxlap0wzZNBnHAezBWHpdcKLJBSnwLF+YJaNt3xZ7DPzJwb9SQ3L0gGmyxgqviRjoSJwz1CDlVzTSqIqRna3A25wd0nQgAHPQhDllQ5zg41kQD7h7BnlAl/ekyHQ08ZoTsIDousUO3kdX70yKCD+DhEaN5VJ63wwyy91bVmvgMGblk4TChUNRo0pRCID+ce9rwKe0aT8Il4ThhK9994dhzXRHpbFF3IqKi6o3SVWt/JUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 28 May
 2025 11:58:10 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 11:58:09 +0000
Message-ID: <cdf4c596-444d-4f0c-b75d-3d6a687c161a@intel.com>
Date: Wed, 28 May 2025 14:58:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND V2 1/2] mmc: core: Adjust some error messages for
 SD UHS-II cards
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <HL.Liu@genesyslogic.com.tw>,
	<Greg.tu@genesyslogic.com.tw>, <Ben.Chuang@genesyslogic.com.tw>, Victor Shih
	<victor.shih@genesyslogic.com.tw>
References: <20250523110155.10451-1-victorshihgli@gmail.com>
 <20250523110155.10451-2-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250523110155.10451-2-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0311.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::16) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 5994931e-6bcf-4000-679d-08dd9ddee9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUYrN2ZvbFI4S0h4VWI3RmdKYlFleFltbEJ4S1hpN1ZwWm5UcUp3NXVMTnV6?=
 =?utf-8?B?c0VPZlhmSTh3TjR3NUFhaHBmUEc0MEJBTDBWWVppbHJiRW9ReTN5dHR5MU9M?=
 =?utf-8?B?ZUw1YVFJdWxVTWJHaHlIaXYzdnlFays4OXFveGRoZFdmOE9GVVFRYjMyL09W?=
 =?utf-8?B?TGliZkhlQzZINlM5VmgxTjM0eTIrVnA4WXZjTXpIbGtJcjFEcDQwZDZobFdS?=
 =?utf-8?B?cSs5dkNtcWN1OVQ4TVBlSktRai84dzZmaEdCVjBPWlBGekRPMmZGc1ZlbE1p?=
 =?utf-8?B?WVJzT1psQzQyS0l2V01FcGc0YUtvSCsvanN3T3JaVUlid01KSzhjMVhrQUxi?=
 =?utf-8?B?aFRoTUw5NnlGbHZXQVR6TTcxWlZyZ0IwSmpRWXlmOGxRRDc2VVJ5blZHaGJk?=
 =?utf-8?B?cEhwZjQwdHJKcXpxRnZsM2xpUkZXd2k4aVZFMmtsWlJETEFLTHhud0JjR1FV?=
 =?utf-8?B?TkdKdTVqckE2ZUZyNGtwMkZvem5HRlA4T2R2Q1ZaSnZpV0JGdnF6OFl6eHVE?=
 =?utf-8?B?ek5xTkRBaTNxUTlhZjBlVXkzQ2QzN1l5THU3bjBvV0FvTUxURzh4a2FMMmVv?=
 =?utf-8?B?VnVWclUzbE1IdXU2WEh1Y1pOQjVDUFNhZDI4N0ovUzNNZGxYVnlHUHhvcHFR?=
 =?utf-8?B?dzk0S3pudkRDbFhSc3lGMDNWajJ3NGJWWUI3SEdCQ283VGlUMkpTS3pOZFdK?=
 =?utf-8?B?SnpPUGpjTlkvbjIwUGtNL05Hb1dqOGNlYytoWlM0L2ZTd01SeGNyZmE1OW5R?=
 =?utf-8?B?eWZiZEQ1UHNLSVM1eW8rRFMvTW9RNmE5SGRtZ3ZXbG1qdHhkL0g1UjRPUkxt?=
 =?utf-8?B?ak14QWFlTkp1U1NpeTRlR3dKa1h1S3FYaWQxSE8xNWorZWEwZVdMWTh0dnJ5?=
 =?utf-8?B?Z2NCM0lCd0lCNXBPckhuZEtXYnVkQ1FOendTMGdZYlQzUTM2Vmd0YXoxTktx?=
 =?utf-8?B?L2lNVVkweVRuVFBhNkluanFjT0JHYmlFUTE3cHlGUjRIeHlKQWhUTE5iSFgz?=
 =?utf-8?B?b2p3LzI5c1pBOFZacmN3anNjVk1IVnFQeTRRd1lKUHNEQ2RGQmJZaXZXVmJt?=
 =?utf-8?B?WmZuSnZTRHg3SDU2MU1odGFNbThDR25MaDdiZXVRU1YyOE84ZWNwUVRMKy9D?=
 =?utf-8?B?V2Rqd1J1NENXSW8wMzczcHc3TGVneWUvVVlXRDMrU2NJc2ZoVyswQWtsZDFE?=
 =?utf-8?B?blltNGQ0aWFlZjB0RFlLS0lQaWFjRGFlZjA1M2txUGZZTWxZaXRJYSt4ODAz?=
 =?utf-8?B?TW1uOWhCb3htdkdRNGE1VmtsVDVQbEJGNW5MUHFadmZ2OFJicjJ4ZTNmQ3ZU?=
 =?utf-8?B?Rzl4SEx1Z3laTXc5SnpWcDFvdzVsOFdnNDhlMUNiZDEyZDBoNGJ1YU8zT1My?=
 =?utf-8?B?VlB2NXQzRXpCVElQWTY2QzlpNHBDUGZKL2hSM2dYOGQzUWozOHU4TDl3RzJz?=
 =?utf-8?B?cGFaMXZDaTliK0hDa3pDV2YwWVBvWXFVQVVZSFFaSWdVSHhuUWZTb0JrQzdS?=
 =?utf-8?B?YTNyT0FRY3BrWDNZK2JyTzl4NGhDOVV0SkR3TUZDejdMR05NK3czK2xxUFZJ?=
 =?utf-8?B?Zml5OG53Tkx5d3hGQVJ2U0NLYzcyYnpDeXBBR2hmbGNHVkJaelVoR0VUbmhJ?=
 =?utf-8?B?YldPZHQyOSs1QTBXd0pGQTcyTjVOSEl3bXoxNWkxbUpYTmlDSU5xeEMwSzJz?=
 =?utf-8?B?dlBHb0VNS0FpWFNWZWYzakRIS2Q1aENISU9uUktKSjFGWFJyeGhhdW52OWww?=
 =?utf-8?B?R0NHTEMvVjRBRXBDb0wxTUNESllZNUtUN2hteVcwWFQyczl5QUl6V2FRUXdr?=
 =?utf-8?B?VG1zOVdmeWQ5M1NHRmZMZ044Q2VDUGxlakRMWWgwTXFNTTFrcjd4NlZHOUFR?=
 =?utf-8?B?WFIxYkhwKzBvMDNmU0xwWUE0ai80bjE1cUZTRXAvTkhQb0p4TmEyNVh0ZHZD?=
 =?utf-8?Q?QehyofFYgvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJlR3A0RmVUWTdLZTgwc0g3cHI3d3BWTHZlZFpPTlgvSHZmNGl6ZVNZUjIz?=
 =?utf-8?B?NThSTHhXZlVjNWZZMVN2SnA1dEo4elB6U2RTYkQrdlYrVnVEcHZ0WHhBdi9N?=
 =?utf-8?B?Yit4aXI3TXRlNFFldG5iVUhUQjFkRnlCUHN6VWFTVGhUN0JNa2lMbkg4MG9O?=
 =?utf-8?B?MjJ0WVpjR0dwMjFNWno5RGR5cGIzNmllcVczYjcyL3JwajJDdUFoeERCSUw1?=
 =?utf-8?B?Qzk0ODNaY1RXcjN6QjRGWFp4U0VLamdySEpJc2tBNWMzTWxzU3NydmlvcWR4?=
 =?utf-8?B?a2haeDU1dW1GeWt2anFWeDFXaWVaRFhIeEJYdXpTQkdOc1c1eTBRb05qZ252?=
 =?utf-8?B?cTZQUHJGYUVNcFV1dWQ4NEM2MnZaNUJKeUlzb1VlNWRQdFlia2pPTTJ6LzVK?=
 =?utf-8?B?cHNFT1Y4djR1Mmc5dnhlTDh3VHlZTTNwMmdSS3I0TFRITG5SdVIyUWJzZ3E2?=
 =?utf-8?B?ZHhyeFJ6S0NxSXlUWTVPQXFPS1BvaEV1WGRzVi9xd2RuQjdNTDdackV0RVo4?=
 =?utf-8?B?aTUzMGZBSHpZNXVhcmV0cTM2SHR1OHloUmpvWW8yZVBLVmlXL1M3MklrZENq?=
 =?utf-8?B?RE5zVG12NFNYcEFHTzNKN3l2bTVIcHlOOC9lNUdIbUg4VlFZNmJKMTBiMnJB?=
 =?utf-8?B?ZklVeTZIeEI2UW5iNlMzUHIwOGdpQmFzbTA4SjBuRDdOVHNyUkc1M3VLeWww?=
 =?utf-8?B?aFEraVREZnc4Y2NIZVFFcjVteHk2aTArU1lZTjJCdDBwUnRZNS9TM0VFRVgr?=
 =?utf-8?B?UEp3WXoxaHI1KzNCWTJkYkM0RzAzb1ViMWM1cXhjeGhUWkdUSmZEdW1MRkJ4?=
 =?utf-8?B?MTFPdnJZVG9Hd1BjbnNBeHcvVW1RMHc3OVIzclg3S3BhL0lmMjlCWGtCVXY2?=
 =?utf-8?B?TlFOZmYyVFJnd0E1b0M3UnM2RDk3RzZndWVWajBhRW45d2ZNQnlsYXAvcS9Y?=
 =?utf-8?B?YTNrY1BIRzdjZ0pYaHZXTWRPVERWd2dDSlNqQzY0T3FIcGFMLzk1VGZmY2pt?=
 =?utf-8?B?QmVxTDBTV01PSFFaUUczaTZiT0FNdnZ4QVVmNWRTa2hZWlozbWNEZXJrV0hD?=
 =?utf-8?B?MW9tMi9qQnVxMEhjQk5SckMzRzFlN1F4ajhUR0pUQ2dtcnVHMW5zaXhLMmsy?=
 =?utf-8?B?STA1TkwvdzZlQWhQWFpTcFIvN083R2VaZVovSTBZdkxsNkxibjBOalVkQlUv?=
 =?utf-8?B?U2tKdndVMUlkKy9HNCtqQkdVSk1IYlpZOWt5TmhmYzRsN2pVLzZmRnRVUWR5?=
 =?utf-8?B?M0tiYS82YmZUY2hWa0dBRkE2NnYxY09MMHdxRWlBSllDcVhaYnB5VVo5WEov?=
 =?utf-8?B?bDluZG03K24yN0h2YXRRVE9kM29lOS9LR20zMm9sVncrWWkxa2lOY21aUFVl?=
 =?utf-8?B?bmVIQWd2TFExaFhRYll5YUUweUpINjZvMHRodDhxOFphNCtSOXBkaU9ONmhi?=
 =?utf-8?B?Y1RkUU80UnY5dzJBV3pPRHB0b0lhd3ErMnZOOXppNlVmZ3lqZEtrR3NOWW0z?=
 =?utf-8?B?OVBwcGFJSWRDVU90V3lMYWpPU1ViNzdnRndydUJnaEpWcnh2YW85dnZCSkxN?=
 =?utf-8?B?SzRYUkdxMXA5V2hpR3ZRYWRWL011eVJURkpjYWx1MW1FVTdwT0RQS0dsWWF4?=
 =?utf-8?B?WkJsWGJMY3BqSHY4SEFUWE94dFovNjJHUENhVWJ3V0h4MzUreEI1dXRIQWM2?=
 =?utf-8?B?dm5FU05OanFwdVhRbU5YNTIwZ1ZKSHBISU9BRGJaMFR1QXQvZzlHUkpKTUxJ?=
 =?utf-8?B?ckl2OWozNWJTNnhRaFBSemp5d05BQm9CTW9WMUhmcTR2UTB4Rk9Wb20ya2lL?=
 =?utf-8?B?dStkYW83cEJrckhFWklPd1EwL1BwdWNVUlZPOGF1WlN6OU5TN3JIK0p0WEdU?=
 =?utf-8?B?a0ZPVkRTZzVIZHg0RUw0N3ZxaWVvMGordjdCYnYyOEhKcFBOdXhFaW1MQXpo?=
 =?utf-8?B?TzUxQ1h0SEFCUTFPUlBrN0tFZ0s0dms2M3ZMTExUc28zcUNodzhsTlBmSzly?=
 =?utf-8?B?dWZnRFBMeUZhTTgwaE42QW9vV1RrRk80Tit6and0OUluNTNQNVVHM0pwNUxN?=
 =?utf-8?B?bWdBS2tXQ013RTJockEvR0RXaXVZRDZ6Tkk3MDVOaVp3bXl0WjZGSmdCMFhh?=
 =?utf-8?B?MlNJT3ltNjRyRW1jcGdFcHJpUjc5WWxlUTJnZDZqLzdYWC9UU2RXYzJqcitF?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5994931e-6bcf-4000-679d-08dd9ddee9d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:58:09.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMgAkA/Vc3thwWRsC556rG1V/QyMBqbAr22kutORMUHtHmk9ABHA4OxEuulaQy3oL44skyH+902gnu5Cp+9GpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com

On 23/05/2025 14:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Adjust some error messages to debug mode to avoid causing
> misunderstanding it is an error.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/sd_uhs2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 1c31d0dfa961..de17d1611290 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -91,8 +91,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>  
>  	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
>  	if (err) {
> -		pr_err("%s: failed to initial phy for UHS-II!\n",
> -		       mmc_hostname(host));
> +		pr_debug("%s: failed to initial phy for UHS-II!\n",
> +			 mmc_hostname(host));
>  	}
>  
>  	return err;

