Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B33D524C;
	Fri,  3 Jul 2026 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093314; cv=fail; b=mdIHh8NWwdOeI8pxOWZ0PS0WSnrHvLbolSnxRO3zDqHbhzu9CBWGzSSYhsYhx7uFXSjralGhNFOgwdu3AzSk4aNZqPBIBll2p6kea8Y2GhMg32UO7Lqg+DKi2ZhC5hv5zoCT9AGKEzlj8pCnNaivWeOkp57se/0ttEncs/EDN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093314; c=relaxed/simple;
	bh=dhbbqlV6/eXFBplhvhdqn5DPJ0SId51PJUi1zxKoDsI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flN7o3r4BUoOPcJheboYIiYUPdn1RQ4SAR6gUYXnthpvoNLFXucCvqpfEb9WhwIwpAgwZzNi6EujESztkcKLZ896UAU2fRTqz/OR2I0dVGQIkH8+GwsZGz+n+WtnhGVTZ1ZZ4d6c7rhp9y99NzO6kkYIg+spvUJGEt0PYt/U1Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAEhokTL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAEhokTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783093313; x=1814629313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhbbqlV6/eXFBplhvhdqn5DPJ0SId51PJUi1zxKoDsI=;
  b=PAEhokTLUCy+K1LT2ROG409mg6Wc4CE4mmpqV4MF/QV+oUE2PNTTz2u6
   Rzv5MWs+zWqHtKTQ0z/s4jDhsnQAqDis3NiU7SwXHmtzstOjYdOB7WtvX
   PtpuGHhxU1j7tsxlExjgYdov0seMQrnfyofT3j5QwEPFL+Xa1KRwBiWZr
   dcZ1SM3luVjWdZDBki9lBpJSL28mNy+JkzFXet1gWEaQIQir9kRnozYwN
   hOAz83ijMGTPiqzkEPOL0XfmUYvpdVm2bbnT4ZbzaHIAfWCHGNh7Jf768
   JyLnJxOFf1T3ys8ogLDbNb/o+L00mrC6FIszuH1hU/dfhWRFJOkVWV8PV
   w==;
X-CSE-ConnectionGUID: o7hCDp63TLuDAsq6spcKag==
X-CSE-MsgGUID: /B8TetY0RpSrxkstN+JwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="87760192"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87760192"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 08:41:52 -0700
X-CSE-ConnectionGUID: DELGNgR8SpiySDJDh8y/lQ==
X-CSE-MsgGUID: qnHh8CZjQf2l9Ze590k/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252672641"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 08:41:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 08:41:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 08:41:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 08:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXSb6E6wd7BKnBFYgee7rVGih83fe1GYC+JsenvMB9HA2rUpw+69OJnzHyZfG354NLQMd8sF0tHEfl4skCEknEimYaanKlgIK6Alb9B+NMLruj87CsangEL+LLYVekr1Ph6eHYGP2F4DRwxj+2gZnI7+RiZktFkW1sDxPx0gwb+fPIcoAHTzYdER8tshtOfkvWNYf2PwqUgb4KSEKg1e+Y/9ELDeL9cITdLYfBo2/x94uGRo9pZu4exrPjZVYon1ZWqepf3yuTskKR8ESDojC8d0G4bUQZIJFQ6UkSB8K5Jqoyq8uQo0c4B9koHyzOAb498xigd7ZXNcBq0j/hWnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otRoM0mH8AXloz+x4Jx/IzkOt1n3ZhQfJrbRVxVxToU=;
 b=hYOrzYbYbFFklU6p7Slw+LjBexy+o3tiSzD/oz7foUe6pmYjiGyppUWtkG8A/qq0QdzW0LpweDVRBaMLf3107A1iD4WOM/PcE4NRJmLakH3hCIZm9+bbHXacfKz0/qb1KrFRuxHoHNRBX0oVreNBtJiSV/Y/n203fl5gCz5X67EQ6yzBX2ofFMCm64U5psq1X4ksgU/vtnyXVjZWs/sjvkmQ7hVPZv2GP7aJlWAjSR459exMCv5/qoR93TBzu11pCtme9NYqHVXC1QODL2CR0Hk25siYZIrEAM+bvi5xvumg7RJJqUjEdRr58UEnD4Cr+dVpQRi1OMdNn3fjn/xWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:41:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:41:48 +0000
Message-ID: <87ef634f-de1e-4a79-a9fd-977d62d85ead@intel.com>
Date: Fri, 3 Jul 2026 18:41:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: cqhci: keep CQE enabled if halt times out
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Ulf
 Hansson" <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260623140401.80963-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260623140401.80963-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0338.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fcb59e-f8e7-434e-b0fb-08ded91997db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j9hqatuOgDgwm6+URHLVcKmMb8brR4lNBHRADI3Kl16Es+CqnCtqe0MZDQQJKt2FMETcILqU/TI+SGnRLLgeLtwXneqLejErzETAaohoA1yYlrVhi42+cGzXRyuYzdjLX+H0P5OPbjIt8XMwfw2SsnoY52865wq8PNlZrQvJYSu48X5RIO0aD6X9Qu5oAkXH5oIfvxtf220bMi924qvyd37mi171sYyeG42UHrnpFz5jlTsGe3x52FSydyQh56LRtaUYxGQ+QPpMfJtyIZIGr4MkRM9f+5BZz4kVPvCCkBLWEo8rVm2mQJyMPAaEe1niZYJr+MtfONNeEC+FHtTrXWHqJ/I0XBn9DwHxwqwOcb7P0f1qXhvESjgaorCo71RbNGecYK1JredxLegAIWBOtkn0aT0B78D32w+TDDpk7Y7RdJH2bo6ew+iXEiJrWgAh5FcdH1uGcbsOUFz2wIALFxLjQR3zhcEWnJRXE8kaXMwmG7U251CzwjVDxsDZtd44KY2/zyhYqhccUkYP/h2Fd4ejOidX6nWXiQl/HvsXl8tX88oa5dIAJpOIHLayaxFJs5ws+NGuvxaFDSx29h8MFa8VIULOYV72KODv5B1iZIvSKqUzRV8IflnEOP8aeb/aNco/2oeDuXRLwqfxeKkwUqLck04N/SymuEFgHp2CVVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVvTEh5cmNwR0hoeCtUeE9YYUc3V2w1Uzc2dW16Mk1iaTJpSFc1aS9RNGNO?=
 =?utf-8?B?OXlzcDFUMmRlaG1tSW5TMjFlRmw3eEQ0bzZ4Mjg0Q0dxMGc0VzRGelNRc0pF?=
 =?utf-8?B?VlZQY3E3Y3h1Z2RQT25GUW9abDFEekJvWm5VNzlWbzNldER0ZGo0blJkTDBr?=
 =?utf-8?B?VHFob1hETU16d3NXMEJmL0FsYmI3VCtTcllsallxczJXZHhXZjNtK0UraVg1?=
 =?utf-8?B?VysyZGlKWUlIYXBKcGxZdk15ZlpoWVhGSXpDNjlvNnpSN3d1ZzdVc0hxeVZ5?=
 =?utf-8?B?b0JWRVMyclFGUUxaTFcyTVk1dFd6L2dlYkpkdzNNblJCVjAyK2lqaEd5R0Ry?=
 =?utf-8?B?SzVySmh3NmpjbkhuaE42TDNDUUxvelg5QlZ1c1NyTDB0TXlMc3plNzU3eE82?=
 =?utf-8?B?WWh6L3Q1NmxtdThycXFMQ05RMXJIaUtHMnZQZThDYWdPaWhLUzEvdlB2eW81?=
 =?utf-8?B?ZUZMODVFQkFBbWg0ZkpWU09wQ3ozZ0tzcU9LazdSZnBPbEh5MTdUR2F0T2JQ?=
 =?utf-8?B?d1JsTHB2aWJ0ei90endXdWZJQ3dWclVCZGJJK1QzQVBCcm9qektwNUhlenkr?=
 =?utf-8?B?Nkk3MWVtK2l6OHJEbkVwWUlWSkQxS0ZwanRPZG5Zc1N4QlBCSmppRzRUV0hu?=
 =?utf-8?B?ZEI2UWRGRG9SQS9UZzE2QWJKMnpXVTVNQlR3NVRFRzJCM1Q1Rk1ud1hCL3Bw?=
 =?utf-8?B?ZGlXa3ZhejR5MHFmSENIbDNjU2tRN3Y3U3REb2dZamlOdk01ZmFEcnRWWEZw?=
 =?utf-8?B?cFRpNTFTbDVwa1JQUkVDaTBva01oVHJXTG9xZFVUT1VqNGMrR2tRVXVmL2N1?=
 =?utf-8?B?eExCTXlIQ0htMlJNNWRNeWR4WmpNUGNCWXFJd2FLYnhRS204Q3dHaXRWREw3?=
 =?utf-8?B?cmN2OXF4enFqVTBFcE11dEpZelVsRENkL0xCaXJ4cXpaRnJEeHB5bHJsVXJB?=
 =?utf-8?B?MHhxeDVIWUluWW5NeE1weUdUTVVwUWhSZkVXZzY0bmJmSW94NUpmdDV2WXhF?=
 =?utf-8?B?VFRkbG9UTGJyTHJOVktnUkdMTnpKKzBVMWUxc0dxR04vUmk3Z0lrQzJPZ2pE?=
 =?utf-8?B?dlV1aFRuNHlkVmJPaFROVEJkdkozWFNwVXIrbEN0OGxoT2FwV21XWWVvbmpq?=
 =?utf-8?B?aitLNFZObnVib0NOaVdJMXdjbEQydDYvNlAxS2ZlV0w1YTFVQ1NkdDRhYnR6?=
 =?utf-8?B?bXE3OXIwc1FFb2x1R2N4NEJHWFpBeVBBZFhIZTdlRzlFS1lNN0pXdTkxd2c5?=
 =?utf-8?B?L3ZHdHBvT3l1azd1bVJWMVI5ZGxMdTl4WXdLR29CcmxTc0JkRjJFRzk0RVND?=
 =?utf-8?B?cFltSWFtU2J1TExHZlh4dElPMVloSTUrN0RRSFgrOGpPZTNLRFFyNi9GbHd3?=
 =?utf-8?B?Wk4zLzZGdVdMeml3REhCLytLTzM1TlkyK0xvSVFOMUdNcjFEOEJCbHZoTXJQ?=
 =?utf-8?B?eFU5Vlc5R1BzbTFYcU5VdHdtZjhtR2l4M0twN1JoNkg2NlhXOHJIdGxoOUxW?=
 =?utf-8?B?eHZsL1Q3RWdzNnU1dlVydERwc0pDY0ttNjhzbHE0bmhkWGRwbjhnS2gzV1FJ?=
 =?utf-8?B?b1dQTlBYT2djN0pjZHFCK1NoK0JrUUdOdjhycC9ZSjBrejRqbzlhcjhWRGxl?=
 =?utf-8?B?S2FaNW42VjhIUUo0NEZLdzZiQUJoQXdlaDN2eHMrNjJ0YXJXK2hQVTVNV0NK?=
 =?utf-8?B?OUZZQS9ab0FhMmdrZXNxVXN6WnRqdG04c1FiWmx0QTdFNDJ5dVltRWppem1u?=
 =?utf-8?B?b3NGOTAyTWtKM0hIUnYwaEtDeERxRDhWWVdSWGd2UWsrbnQ3SVNneWJHNGV5?=
 =?utf-8?B?dnBrMTFWRjFJUWpmNVB3N21VejJqcFpxZTgvZytYZ1dKaVVnMXY1ZGhTRVIz?=
 =?utf-8?B?VFdueFBUS3hFQzlQMktuMFJxR1VCbE1RQno4RVdSaGI1ZlJ1Zm9UN3h4YnRT?=
 =?utf-8?B?M2ZGWXdEWjFmbFRnUnllQWtvMmw0L1phSHVwSlFJNXJmZmtEU2d0dWhrUXMr?=
 =?utf-8?B?YXZIei9pOWJHM3ZkazJMN25pWVZlakVZd29MenVFMm9zU2dFK0tyQXR5Qjhx?=
 =?utf-8?B?TC9PcEhDM1BiSDhzYnNYVUFxUU83US9Dd1lRUnRka2tWNTBUTjdTUDdPSXJF?=
 =?utf-8?B?NVdRR1duT0d4WWZZNkpmNER1WThaSC9PN0diL2VrcEFwZkQxa3MzUldNVE5W?=
 =?utf-8?B?Ni9UUUZxZW5XYUkvZ09zZ0FYYVp0VmdQRGNNTE9BeVJOSVZTdzRqam9iSWtQ?=
 =?utf-8?B?S1RiSWNPYkM4MU5PaHg3K3EyWGNBeXBkTEtmaHdZSFZLQ3hmK1NRUmxjakpD?=
 =?utf-8?B?dFVMZGFqYnc5M0ZZRFF3Vy9NSDRYbUJjM2J6eER1alg1THAydmdOTjRTalJ2?=
 =?utf-8?Q?tsDIPtCWrIdNJVc8=3D?=
X-Exchange-RoutingPolicyChecked: mI+SCu1dZhpPXkvsffYbDQmcVL+YQCEznNkUP09PvDQz3NbrGLidzocMiOZGio+g+U+OlsZC8fC1TLKB51SjN0FFyKTnp3uCbXQcSXa4UyKRjHLWbMeov1sb6qWUm8KdSrJ/TfxuIMDEx4Te6iRKT0ZDV5OO6SWbT+b3kRYtX78H7iHoAKJLeN+qw9aMHN+L99BmrN6ux7aV5uiV/aW6BoZ7p5M8gTdOMYLjDMT0aV0WY5tklnwrE9QdFlXudJ9e9UeZmHsQ9cppJrHaQd3fKaMfV7qSyy2+Y4G/QNEo31s9Lir7MeLSKAEiqg0JrTPZebXvwpCQHslku6EtOwRS4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fcb59e-f8e7-434e-b0fb-08ded91997db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:41:48.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehYLIsiN7+vyePIwnkCTGpeGVbx5cpZU2yf0M2A9lC69CHxszjaOSFx1hMhi1NwQUPAetzbU2qH9o70DvSOPPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

On 23/06/2026 17:04, Pengpeng Hou wrote:
> cqhci_off() asks the controller to halt before post_disable(), clearing
> mmc->cqe_on and freeing CQE resources. If the halt wait times out, the
> function still continues through that success path even though the
> hardware may still be using the command queue.

CQHCI should be idle when cqhci_off() is used, so it should halt
immediately.  If not, it is a hardware error, but carrying on is
a reasonable option because I/O errors will trigger recovery
later.

> 
> Make cqhci_off() report whether the halt completed and leave the CQE
> state/resources intact when the controller remains stuck on. This keeps
> the existing host-specific ->disable() ordering and is intended as an
> RFC patch because the cqe_disable callback itself has no error return.

Is there a real problem that you are trying to fix?

> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/mmc/host/cqhci-core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 178277d90..84846207c 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -372,14 +372,14 @@ static u32 cqhci_read_ctl(struct cqhci_host *cq_host)
>  	return cqhci_readl(cq_host, CQHCI_CTL);
>  }
>  
> -static void cqhci_off(struct mmc_host *mmc)
> +static bool cqhci_off(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	u32 reg;
>  	int err;
>  
>  	if (!cq_host->enabled || !mmc->cqe_on || cq_host->recovery_halt)
> -		return;
> +		return true;
>  
>  	if (cq_host->ops->disable)
>  		cq_host->ops->disable(mmc, false);
> @@ -388,15 +388,19 @@ static void cqhci_off(struct mmc_host *mmc)
>  
>  	err = readx_poll_timeout(cqhci_read_ctl, cq_host, reg,
>  				 reg & CQHCI_HALT, 0, CQHCI_OFF_TIMEOUT);
> -	if (err < 0)
> +	if (err < 0) {
>  		pr_err("%s: cqhci: CQE stuck on\n", mmc_hostname(mmc));
> -	else
> -		pr_debug("%s: cqhci: CQE off\n", mmc_hostname(mmc));
> +		return false;
> +	}
> +
> +	pr_debug("%s: cqhci: CQE off\n", mmc_hostname(mmc));
>  
>  	if (cq_host->ops->post_disable)
>  		cq_host->ops->post_disable(mmc);
>  
>  	mmc->cqe_on = false;
> +
> +	return true;
>  }
>  
>  static void cqhci_disable(struct mmc_host *mmc)
> @@ -406,7 +410,8 @@ static void cqhci_disable(struct mmc_host *mmc)
>  	if (!cq_host->enabled)
>  		return;
>  
> -	cqhci_off(mmc);
> +	if (!cqhci_off(mmc))
> +		return;
>  
>  	__cqhci_disable(cq_host);
>  

