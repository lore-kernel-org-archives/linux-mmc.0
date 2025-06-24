Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AD28BA9A;
	Tue, 24 Jun 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762430; cv=fail; b=N66zieiK+oP4XzsTAMD8jdPAG+YaGls6qU/0Ta3hn17AJ7ToVHfvw8GbhEvPc941CRewEx0rll72PWSxvgaDEbPqF/uHP/mvP42aQLltig8w1ReEHK11Z5R/CELKGLakqXjKQQkkvmGn9ZgwFtXDzSmmOJROlPlr92lj6XJDiDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762430; c=relaxed/simple;
	bh=bXoJ2iTQ1jcsi+VHzXROsDjpkFacNvAxKarupnY8li8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfbXXHdpEiFJ+YT/Yotw2qRFumelU1ULSBWlA86KhlBVZfgvmC/s1zMYd8syt+USidz0QOyWFHRJ9SfMVNAGLmJ2chHKqtDETxOioT+v14R71BV6s1KyxZs63rRTgTty0OTNB60BNDp6nTPLS8tVx5y9uRKpWKgVc691QC3cVu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hn93Z8R7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hn93Z8R7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750762429; x=1782298429;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bXoJ2iTQ1jcsi+VHzXROsDjpkFacNvAxKarupnY8li8=;
  b=Hn93Z8R7yuZ2RBouyQLMoQpx5NgqkQmRkLjBErL/psiPK+XhVYQ1kt3+
   C2+kCxlSsJNuqbR8FZby20iu1Vwgb4YeAybDKfvVQSeEDuDPn24U5OgEY
   1fzbrFmGO5i6I3GJdBkcb038GRTZ0tm7MqjgM/HNvUT8hLsRHnQGOl6jm
   KjHE3u5sFu26EmJHG9CnGdyb6K0EMI6zOMvSWtZeY79JiDTNY31bIXNlF
   ptxfS8AJ3mnFmz3PKzNVlOp/44DvSImFPnvdikPNHRInXPeXrB7tP3Cfq
   6T63ovTRln4EARWy7MHQ39o80JB8lfYifwHyeFt0iWTJ1R7hMt/Atbdbl
   Q==;
X-CSE-ConnectionGUID: T1n9fZSlRqy7o1hwf2Adlg==
X-CSE-MsgGUID: bk8MKxhYRYiNID12Qqt0oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53131363"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53131363"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:53:48 -0700
X-CSE-ConnectionGUID: GtFsG0FNQgOSltt4wL9yeg==
X-CSE-MsgGUID: cYAr6uztTrKctajau949Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152578822"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:53:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:53:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 03:53:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.74) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKT2XyyWA0MLUTIvFlFq0Yek11KOLRLVYxDgeiL5FNZxaovjFcZ7134STj5um0C8KyZnSHWt05hb97n1Qb5J1K9ZoUIY0zLboC9xlWLSnJSXc38wc/TTS69Iwcxb4Wx33xVa7yHQq6dZU8rHH7IwmMRXuhB0SOf65Uc/3jO2YOP5ptdEnUQRdvACaV66kSvX1hVsZiWKV83AsyjJieooRI3Z087FEYS4HYOaf/n1C66DJzRiI3lTdb/ya+gPuE/0f6sy5NlOwGCo+25hN6W4LWoaGpe+SD9IJbIJJJa3H900ZfugRGcxAOt9iOmZX7RjzEPekPaXxy8aXgy4CoQR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Neq1TeOWjF/Qc8N5TEWCEX4ESmNqtchrZQVlDGyEgX4=;
 b=qkPGJ5S7BAqjX4ZS6A+ivztwXI4FFZ2eRLxN1J/K9ZjIm8hIRMWyQfd8CvHoUQfVApHFC62omkaadGh7Hnf/SaNLdZedaJE+E1GpsixLdg4Q9BnOYGW5wG+RtAzg2JRnuc5nieHOnwU/1C8sVL5jOwtku5ntk2xkZH88Wkwz14aAFEV+U4zIe7OEJO3FMs+xpaDIznDzszEX58vpWX3/j234L8uJvXhkYX95h/OxKdhG4B+g1CAkzFueNjoMh2Nk+3TPW9gnePMATGtOVmSxtwLpLhf+L3x08Q/Ep7wu1ed+DuD6n0YZlHlejYUSCNLBvgpGQZx9BRUSuQrjcAjQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 10:53:31 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:53:31 +0000
Message-ID: <6366c08b-1746-4d42-8f2e-af0b27766dbf@intel.com>
Date: Tue, 24 Jun 2025 13:53:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing
 parameters
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>, <gratian.crisan@emerson.com>, Kyle Roeschley
	<kyle.roeschley@ni.com>, Brad Mouring <brad.mouring@ni.com>, Jonathan Liu
	<net147@gmail.com>
References: <20250211214645.469279-1-erick.shepherd@ni.com>
 <CANwerB1u9JMm+p+HNOHjj67Zw=5XhMOrLAMyXbb5jBwgQbCkVQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CANwerB1u9JMm+p+HNOHjj67Zw=5XhMOrLAMyXbb5jBwgQbCkVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0258.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::23) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c6b1b6-dc75-461b-fa03-08ddb30d5bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEg3Y1gvQzN3Z1p2ZHZ5VStaTzNmRi9LTWN4Njc1cVBrYjhuYk1NVW9TM1Av?=
 =?utf-8?B?QWtWanlWWUw0VXl2alQzUksyRGhGdDkvYXlMR1FoZHgyNDNqOStqWG5lV3dS?=
 =?utf-8?B?UUF3bEloS0haT0Y5VUFDY0NJcWRlZUw5dXBPVEVuZWZuWFFQaCtGWXUrTkYv?=
 =?utf-8?B?TEVKTGlQR3hhcXBVT2NIbXM4OWk4R0dMRG9oSDVMR0t6Y2tNa3RnVjhQajMx?=
 =?utf-8?B?YVhwMkI1QkZoYTIxaENNRitFc3Fpa1dOWnZtWVFFeENpcElWREsvK0J0RGtK?=
 =?utf-8?B?eFk1dTdzdmFWNkJJcjFKYW14NXhmUDVDRzNtNXozbEl1M0N5OFdDYXp5djFy?=
 =?utf-8?B?ZHZDVG1oR2FhZGtTUjZRTEgzOHZsUUNYWkJGdlpCaWRjd2J6c0RTcGNNZ2h0?=
 =?utf-8?B?VVk5MUJ5TWs2NGc4azN6eVY5Z055Z3BRUlh3TisvK2NLRWNuMmY0ZE1WMVdK?=
 =?utf-8?B?cHBMSEcvQ0hJRWtzeGV3MGd5L3d4THZGdnBrdkJwREozRWlBdEpTekxLYXFD?=
 =?utf-8?B?STFXengwM0NOZTJBa2QzcnFxN3lzbHA3bFpZcC9LNCtQQnNNdFNkQ2JIMGY4?=
 =?utf-8?B?S0xHZ3BKUUg4MHpGYnJjZkVuRGFWell6SWt4MXZ6M09UcGs5WDVVZ2J1YklX?=
 =?utf-8?B?MysxUjFyRFFzbll4cXlwbmh0Nnp1Z1JEQjArdFhoS0RJT0I3L3o2UTBXdU5h?=
 =?utf-8?B?bTA4VnVYcU1oWmF0UDFla0NmaStMTTVZREdkWDJxRW5GVEg4bjdFYnpvenFy?=
 =?utf-8?B?aHppdUppZVNsME45dmVaSUY4RVA5YnAxYWhzeGNtazRpeGRuS0VWenFzdEZh?=
 =?utf-8?B?NFgwMlVjRHFMUlBhL0hUVVlWTnZSL2VmNjRqWWhya0cwNFJXdHo1Z0xmTVlq?=
 =?utf-8?B?TGdRTlNmZUxyUDI4TXFUdXZQQ1VYTXBUNjhDc3pGckFCL3JKelNWSFFkVkZG?=
 =?utf-8?B?TVpudFhINFd0aGU0TERVK1RrZzlNWHUvOGlWakFTcGFhenQ4SzdXdjRLT0Jy?=
 =?utf-8?B?Z0ZXelVJQTIrM3BuQlVHWlRzVHNqa2NVQis5cUQ0ZzN5OEhEaGFrZVpiYytF?=
 =?utf-8?B?RFF3Q01uQTFnNnlRQUEyRHJxVHZwZGx0ZjFBRjBoZWQwTWxaNDFYc3NxNDFK?=
 =?utf-8?B?d3lEWitKdUFQcURDMEFMZkx5Umhmc051ZTF3VEhteTR1Y1M3MStoYXFZNmpT?=
 =?utf-8?B?SGJXaEdPVDJ2M3BMT2t4TUxOYjVqSDZsRitpWjIrU2lRSCsrNVl6ckNiZUxH?=
 =?utf-8?B?Z09WWTFudTIyUThtT20rSlBnWS9FaEtxbFBvMElEMllMUFBKUlZzQkliV3A5?=
 =?utf-8?B?UWRnYm00S3pickpXS1kyQWdNSmJPa0Jqei9VZ2ZSeVZBQ1VKZC9jbUdWNkNt?=
 =?utf-8?B?VHlaQVpFV0ZrY21XLytmVGpzUGtmMHRYb1JXaTZpV2taRVQ5QzdveUxVd0c1?=
 =?utf-8?B?UzRNRFdCZVBnOVFWWFg3T2dqSm5CTTMxOXhyaW1CMnlDNm00MFJPQWNTck5V?=
 =?utf-8?B?SGhXT21vKys2TjhuVzlsRXIzVWl0SldYbHk0Qk5acngvMEsySnJUdlZ5cngr?=
 =?utf-8?B?TjR6V1hJc3JibHRxWXRjbkVxMGllZEg2dlJNU1IrbG0rVVpIaEZBVjNUbnpv?=
 =?utf-8?B?OE5qc0wyYjRONjNIeTNNM0wzS01OQ3VDYm9ESHViZlBiU3dXUEhFRVExMWt6?=
 =?utf-8?B?Qnp1WVh3bVUzOWVzR2Z2MGtQYzM3djA1NjdBUWhLVWlVUnZqNWNObTZsZnFH?=
 =?utf-8?B?WUZ0S1RKRDFkM3FaZUpaTm1xWklzQVNYR2Zza1dtY29Pd0ZIVlFvSisxODhj?=
 =?utf-8?B?OU9PNUxwTHkzNXowWmErdlR3a2x1bURuOEJIZGMrOVJRRnh1Zm9RZUpxTElX?=
 =?utf-8?B?OHNNVGlvVEY4M1BocHRobWlMbVRZMDBUL01qMUNaMmhsRGlYR2VCSThiNFd1?=
 =?utf-8?Q?1vvGxMcOQi4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01FRHlzbkIzYVNEbUJaQ3FKMEVyNEdaRnc2OHJEdnJJdERkWDBSeUdERmtp?=
 =?utf-8?B?eDRpZ0NNSjVaQkp6OTBzVFZJRlRVa1RGNmFyNm5tWVVSaGE2bzg1ZkFOaFRF?=
 =?utf-8?B?K3VuWmpsb2hoNzNWWDhha3pLYi9QUzBzcEhEd2huR0RXcXlPcXhTamhoRFIz?=
 =?utf-8?B?V2hzV1pJZFRxQ3Q0Q3hKSVRSYTlsODcyZWFjMWRuT29HTENraFljeWZuUUli?=
 =?utf-8?B?RG91bmtYeTlNcmtzOTJKWHBndHV3VlBrY1dscy9ZUy9FYnBMdkliUkh1R2VZ?=
 =?utf-8?B?cUtKVjdTTURqYUdUQ0hrcGljcG1WR3UxTFZVRFJzTzNXOHEwVVZiMGI4RDRz?=
 =?utf-8?B?NzVXNEhBbkRwdWpmb1dDZHNobjF2dGIzRmphSjdlbXozV3BLVC85NUhxenBW?=
 =?utf-8?B?VGxpUmdpSjBYOGZzN1Mwb2ovWDdzTm5JSU5ES25EM0RTNVYxcm9xanB2RzNa?=
 =?utf-8?B?Z2NjQmQ4ZFoxTjRRNkhORHVPWHF6eGU4ekNTZVdwaWs2TTBJWFM0dE1uaWFO?=
 =?utf-8?B?MnZHWTU1UE4zeVlYRHN0MDlmeitYZ0Jtc05WcFBIOFljMDUrOEc0ZGF0YzZZ?=
 =?utf-8?B?TjRMR1ZjNmtIUk9ERElFVEFwZmw5R2J1aGwyeldteEZNL1RCVVJ6WFJvTHpY?=
 =?utf-8?B?d0Fqc2o5RDh6UHZKRkVKdklQVS84ZkNXTEl4S1EweW9jMytMN2pUaHNVcUFQ?=
 =?utf-8?B?ZTlLa3RvaENTQUQxOTR2dmtVbmJVNnJPOSt5YkMyRGQ2dnZlelpDMzVNR2JO?=
 =?utf-8?B?YVltc0Y2NXlzSy94SWYwRGMxTUlyQ3ZNQjRRRk8rU3ZPeU5xWjNwdzQxZ2JY?=
 =?utf-8?B?TlJTblRNeXJkWTBmRmpyUEZKZmhyTnFuVlpZV2J0b1BLalV3NzBEdkZ1VEFS?=
 =?utf-8?B?VGpEOTlhU09ZSFFFeXArZnF0VWZSUXhqbjVmMWFTYUM1QTBib3ppR09yclp2?=
 =?utf-8?B?Z1M5MlBSWHBwUFRQR1p5R0xEMXVFZmdES3hlSVFvbE5JY0hVMTBhWi9qektz?=
 =?utf-8?B?RFIvSDNRMnMxQlNZYTBBbGxNMUdweXE2UlIya3BmQmJnbjlYdFFDYmZEbC9Y?=
 =?utf-8?B?S3dhbU9FKzRnTDNib29WemlYZWNjWlpCMDFNZzdtZkZCQVdMVElBTm1KclBx?=
 =?utf-8?B?UFJqeGNIMXRGWStZc1N6M0RvK0x6UWYrT25ibkxNMGhCTDNlQlNVWTgvQ3A5?=
 =?utf-8?B?QXJ0ZHU3WmZpWlVGbGZTMmU3dnE3blJ1T3FlRnRsY1RpWllKTzkvZFFYeTBx?=
 =?utf-8?B?dDRaRGZoWTFhWVpNOGJOMFZMZ2lOejVpNkd2WDVGOWNFUEhqSjFtOGUrQ05E?=
 =?utf-8?B?SVFCbWhHblBVc2dWSEJZVVZIVGNoTGFQeTlMVFNVOVVnQWhaSUpNeFhSZ1Ux?=
 =?utf-8?B?aDFWbEVxT0VJMThFbWtGMXhiSEk2MElCUytzMXExVGsrZU54a3hER09rZ2xl?=
 =?utf-8?B?UHg4aFdiczJJMkJGK3BIcUZJdXF6aHhQdWNpMG9nYmpzL3NNbFRyT2VGamt0?=
 =?utf-8?B?VWlwbklVL1IxRFF5UDB4dFU4Z2hSMjhmWW8ycEs2dWh6QWRmZUxMZVp4TUk5?=
 =?utf-8?B?ZUt0OGlYN2dwU2VSK2lhVE1HL1A4bHQ0V3lqaUY2RnBiQTFtaGlWeWZIWkcw?=
 =?utf-8?B?UkFNQll6ZHpKeWdFM3dzUkRmS1JCQmxLNm5MSHhkTXgwRjVlenYzZnRhVWZ0?=
 =?utf-8?B?SmluWFhpMFJqQlc2SlZrZEpzblppSDc4Znh0K05FWkRLdVcwRURxT3BJVzBq?=
 =?utf-8?B?WUhNdXNkcG81NnA4TjlnK25MZ0RNZ3lvTkZzUDRJRndlVURMa1EvY21UOE5h?=
 =?utf-8?B?VmRjNWZSamZ2U3VzbVN3UWRtYVZiY1NzcDY1SWFuOTFPSTlCVWdnSjYvb2lM?=
 =?utf-8?B?Q2pneFRUN1ZhMEVhTXlmenV5TU56ajFleWMvbW5JYlVXRjJUQ1RDdFNObGhH?=
 =?utf-8?B?U0ZRR3JRUFU2MHhkdGk2cks3SDVLOGhtNUhyT1h2UXpCWTFTdU84bkIzdzFx?=
 =?utf-8?B?TEJzQkwwMVY2UWpiOXd4b2F2aVQ2ZUdPeElneFgyZUUwamFUZlVpVDVzTmdP?=
 =?utf-8?B?WHhybjJiaUY2ZDRGKy94Y0lOTXdndC9mbVZjbnhyaHNNSUhDQzBnbDBaaEpU?=
 =?utf-8?B?SUJJV04xajh0cVdhaVMxQ1BQc0JYby8vaUFOeUd1OWJxNjNNc3RGbzBrVjRa?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c6b1b6-dc75-461b-fa03-08ddb30d5bb5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:53:31.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIwRIpVR68NTcgq9ekUtcnTgSUihkz01/MABPWrn0F+7xqcH2iAi6ZZGaNvuKrJFIlNWiUeZAbWQnVwCMrGPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com

On 19/06/2025 06:29, Jonathan Liu wrote:
> Hi Erick,
> 
> On Tue, 11 Feb 2025 at 15:46, Erick Shepherd <erick.shepherd@ni.com> wrote:
>>
>> Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
>> the SD card clock parameters only after first disabling the external card
>> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
>> SD controllers which otherwise breaks voltage switching with a specific
>> Swissbit SD card.
>>
>> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
>> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
>> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index f4a7733a8ad2..5f91b44891f9 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2065,10 +2065,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>
>>         host->mmc->actual_clock = 0;
>>
>> -       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +       if (clk & SDHCI_CLOCK_CARD_EN)
>> +               sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
>> +                       SDHCI_CLOCK_CONTROL);
>>
>> -       if (clock == 0)
>> +       if (clock == 0) {
>> +               sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>>                 return;
>> +       }
>>
>>         clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>>         sdhci_enable_clk(host, clk);
>> --
>> 2.43.0
> 
> This commit is causing eMMC to sometimes fail to detect on my RK3399
> ARM64 board after updating from v5.10.237 to v5.10.238.
> Any ideas?

Looks like this patch will get reverted.

After that, would something like the following work instead?

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index dd084c8750f9..ad95218fe3b3 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -679,8 +679,19 @@ static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
 	return 0;
 }
 
+static void sdhci_intel_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	/* Stop card clock separately to avoid glitches on clock line */
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN, SDHCI_CLOCK_CONTROL);
+
+	sdhci_set_clock(host, clock);
+}
+
 static const struct sdhci_ops sdhci_intel_byt_ops = {
-	.set_clock		= sdhci_set_clock,
+	.set_clock		= sdhci_intel_set_clock,
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -690,7 +701,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
 };
 
 static const struct sdhci_ops sdhci_intel_glk_ops = {
-	.set_clock		= sdhci_set_clock,
+	.set_clock		= sdhci_intel_set_clock,
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,

