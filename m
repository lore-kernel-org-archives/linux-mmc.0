Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5ED3DC4C7
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603786; cv=fail; b=bfeMOp34oG2Lkafg9ab4CjJRBvc5Q2qA9kFc/q1ozpP93s1IkSZSD3e0fp8LrdpCTdWlUJVYw0YQxzO4GRYtEO93icq9pSXcsONhqovBDfP27K2+FUozPPjVcwtWZG3ehHTn9uubyjfSO8v0st19tCf9KiLLbFFnOFooGPN+bY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603786; c=relaxed/simple;
	bh=DPoCLFGfyOvA23aglkgm8FqHKC5otOll/CDW0XQEq8U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThEjF/1FLAj0tFg5gU9WicP2WLZ8DRQpCOTSQlw5sUjULx0ccl7IkuyE5HXe5EoUfDbdAcgU5Itbr3mQdWLO+Kaar/A7mefVI52n0+oySbDSCPJe6SKpXWKKP4i69CeFnDGnejEL6x2jUtDS4PaTc6HvhJ+i+wUcH5b1riisaxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOR1os0+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOR1os0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774603783; x=1806139783;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPoCLFGfyOvA23aglkgm8FqHKC5otOll/CDW0XQEq8U=;
  b=cOR1os0+xQ869gUs7bYbU9W9Eq8wUNvH+yuqnbUFiwXaFMvNBVJhJPBz
   1TJ4gj7i9q4YAlG1u8adIRyTgIkZu9EjHBU4xU8BdIvtfEyHJ47fbBea7
   mdrNlYRny/h3hjgX0Oegl/Nq1YXudjj/tWkrLw7JhnG3eVE/cbuIRwBjQ
   bv3xSbg/UGJVHEpf21jwOCddFtKxQp/LzjYuyMTfjvQCMb5pgacBTbbMR
   S8rjupYiViQV5hOT5fO+Rm2ezVnm1Bh7IyrmVmJ5LAFgZDz904nkahef5
   SZj0sw5vJ/IV98pxRTK3B62ZyExZRkaLb9h0JFyvdyBXCPU4SzMbTvdNv
   g==;
X-CSE-ConnectionGUID: xQvu5Cx/QnGeEUuGt08MRg==
X-CSE-MsgGUID: YIliw/5oTEeoU5rulh+u2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75565975"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75565975"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:29:42 -0700
X-CSE-ConnectionGUID: f9Sg+8LfTOmdxkjS/qPLeQ==
X-CSE-MsgGUID: Bo9rz+4zTwK3XMWxWf9OPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="225515872"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:29:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:29:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 02:29:40 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 02:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4lRPklPEGDkC/t+trIYXpmec+A7zzIQD24sP4p7jKj1SKDKOMantHwQIbHZVog6rqUwHhpFHSiLo9u/5DerqtNhm9SYJlB1EIXQMaYb72yVtDfWCEXR6ARazvTac+2wFqNJc2/WrtjZzX017lX7VErTjF27bkQy28aEoj8KR4++T6oyfoLQSataioD3NsXDdRsQSyctfgTrU8/kU50fZzdVvI3URokbWdvq6bpkwQVMhM072mVKevxfVPZxMPjeTCUj22DzfN8GJFXgBHU1xmQs38PtX3u1SSZObS9vAGz0C2s5TBya0FP3lOQPcbZkP3gsNgI3ao6DYwd0i+DWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ows6F3O4uHGE7AiZKl/b8jgYSlVtnRiODhmztGlpmDk=;
 b=DnpYKRRFDtZyM1EKs3dyIAfxNDYTBo2BrTMfLYuNuGZQ7YqTn91NjQo199aSqYCroX5oZYW0kCAU4EAGvACq1lSYzDhjn7LT6nEb4ju0R0vSvjfAXYfM8lvVA/f8oPZ+MmkClveCzvH9JYo2ri9fIMiSqeqxjN46giaHjfqsgEah3yUwqgUMuDCH2WWG9IxIYJYD9Nbx+9Z+bo0cd5n3VPrp2+tB6Yf1YmRxnNissMa+l+UgvRFt9OG7rAJ1c9ZhrulNDEfBf15ueG4uRkHfr/8D++rlBB0CKtGYscZCKiJ+1s3bNLpt6EN9wmSTA6eg7wzm0Rk9AjfBUHPFme36pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 09:29:33 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 09:29:33 +0000
Message-ID: <20fe4fbb-df3d-4fa3-a595-3f446520f50f@intel.com>
Date: Fri, 27 Mar 2026 11:29:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Refactor Rockchip platform data
 for controller revisions
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>
References: <1774597872-179908-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1774597872-179908-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2e0001-8033-44f7-35d7-08de8be35a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ClcSM8UGdkqMPRDZAZ1VRIjvhnAitrxvdZIWeAeeVnRXi1ikI3Ezy53fDjqYzetu9tp7gWi8hmUnKI9ar0WOvY15/fKqUyKk/ZK7DAw9QG5W/MH3RLUReFhIs7AQ6HcIFEBHVIN6IqoBURgzMxQp+eGS4oLksmRY9vrLo/hz6v/UoA9SCUnVknOgq4Mcd2LQMviEG3RVQPl8EwN9I/PgYCcPSLPTb12zlo3YQgZaM6vZJ3fc7fRkpNxgawY1bbqblapTB+r7WWZHEODRPKtgdI/MzwD5DGXO5i0k7/kGid6IwtL91j4dLSDXcxMykcWBwHkuFuizBy4vJHqfifFV5HzdVzdOs765vf5SDYghvcp5Pc/w5yyzfk4v+5Tgoss4Bz8YykpKhLT7VP8eelDCs7nnrkHhdPLvbADj+ktB6UuUa8gykJTBpk3VKX0MZBbSZquIu5SA3khAw2Ti51uvMJ+AhLNB1sgUNikPWgz2x5D3A98+/6R20ppCLvoRQ2q0/xXhQWh2Bx9hrA6mL4LY1OvGspS5JoCXaOpqZ6bCEGkeDSSMJC4YUZLoqVR+mgDC/hfppSGMbJQwOhG+9i8nmgTD+7DO5f5leDHKs+AL9U3FQrogDLLpoAiKRZjhge/TUAPfD0vRPzZS8lOWxym0BaDP7XEDCny107zlJRvFPwy2oMZMyF6qOw2ijOFmEukVYOT9T/AqmE67vwgT1lo+kXpmVVK86hJHvsMJ/p/htk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RURGJpSXkrWFVDazlZVmhkR0dmMVdmUFU1NUdXbkZtQjZvTm9EVU5JZjdx?=
 =?utf-8?B?c0dnSGZ2Z05QQlZGaEliZWd6YlZxRklhSk9ZZnk1VGJXUE5URnk1bGpMYk81?=
 =?utf-8?B?QUw4dGlTUUlid2JRRHQwaHBmN1BJUmVvQ1hWK2t6ekVWV2FERW5iL0ZLYmQv?=
 =?utf-8?B?TmY3VDBNKytBSzhTQ1M0ZkY0ekU0RkRWQ083RFUxeXQ1MjJFeVN3MEMvVUdZ?=
 =?utf-8?B?TXQzam1yR0RjSVRVTWR2b2FxMW8zZHlveWxIRnlkdXJHU2VnMEZnaUdZOGFv?=
 =?utf-8?B?dittMjF1WEZzUHdDdExWaUJwMXh6SUlLeFFtSW9DaHdKSWVBWG5GNTRBM0tZ?=
 =?utf-8?B?Z3BCc3U2SmZ6eWdlN0xVVFFSOGZTSjFEUXpFR0xyQUZIOTE2R1lSbkp5UlNW?=
 =?utf-8?B?aEZLdGRRWnNLdytsM1NKdkRiUG1MUms3R0lVVlBtMHVjRGk5VS9JQUd2azBa?=
 =?utf-8?B?QnZrd240TzV2WU5xaGk0UVlCTU9KVFBRRXhoYi9TeWx1a1F1UG02V3N2bDJT?=
 =?utf-8?B?VlgwUmtUQjN1Mm1PR2dhdStCTnFYYkhFUGNUcWtHNW13NUlpcjkvUkg1eTJP?=
 =?utf-8?B?R3k5bzBacG1BcnpQd2NHZElHcUs2RlJ3YVNTTjUyV1F4N1Bpcm1oejliTVFk?=
 =?utf-8?B?eDhTVkMyU2dmcy91cVdPY0taR0U1K0I4QjltK3g1QkRmcURNQkplUXJOTHhV?=
 =?utf-8?B?Nm1zcmFORDcyaGl6K1FUc3gzd1JncHU5dVluK1ovdTJBVUxiUlpVOFhiYm5r?=
 =?utf-8?B?TFQyTk96SmpnOTlFNE9VeHBVZk5IeUR2WWxRd3VoQlJnUFpHMUdEbGFJbzc5?=
 =?utf-8?B?UnRCclhqeGREMkFIdVZaWi8rblF3YUdtRVJHekVRbGVhQ3BrQlVaNFBNRjNq?=
 =?utf-8?B?M0ErbGlDQ0RiV2k4T0MyeUk5QW1oUzlLTWd4c3dVWC9Qb1FzKzJnekZqczIv?=
 =?utf-8?B?cDc5aWZOdjRWTDVFWTNmUFhYM0lSTTBQV09hbWpMbG5selZKNUljSzArZ2w2?=
 =?utf-8?B?aWR6N0dxWUhmaGJKYUl1bGVSN1kzeERYY2hIUzJacXBCMHM2alZ0akh0Z05J?=
 =?utf-8?B?YUtCMytWNTIwcis1S05HekVLRm9JTUtQZ29PWEdBYURpQ05pRTRwTytOUm9T?=
 =?utf-8?B?NkcrNTVKWFpVZ2dMNTlscHE4SmJBRjFNTzNHZ2pxcjVTays1YmtIRko5T1dF?=
 =?utf-8?B?K3o1QU5TNHJEU0I0Y1V2VHNYcVlLbDdjSEhnTXB6UEY2cytnTVhsb1FEUVUx?=
 =?utf-8?B?cHhhb3FzV2dNR05ObDBFRzJpZGlNYlJSbzdKWXJDMXJvNmhSakhZMFNZRWxh?=
 =?utf-8?B?M0hlNXdDVWFRazhRYjVQdWl0UnE2Qk92c0Fwa3RDM3lWbTZvOEdzR1QwQ1ph?=
 =?utf-8?B?MEppZTkraEFRODZNYnN2bThlakFuUWZyOUFxaWhSODNvZDVxdVdJQkZFeS9N?=
 =?utf-8?B?T21IcUVVUmVpbGJtSUFlNnZKUDFlQWNoQXNYaVd2cy9sL1VjQm9BTTB5cm1G?=
 =?utf-8?B?ZnJhWGJpeEZBOERveVVMTjRGQUlGbUoyVjlnNHg5azFLbS9wNklSK05xZlV3?=
 =?utf-8?B?MEViellMY1FDRWxWbjE2UVhuUnFqWUZxNTZNcXJ4cG4zd2U4SGl0L21KUVp6?=
 =?utf-8?B?VThhNnVWdnV0aGcwdEZMR3F2UGp3L3Bxbm5GTnNpMGtMUVFKT1Rudlk2U0Z0?=
 =?utf-8?B?cG5kMXBQZG1taGlxVFZBeEI0SStYK2IwcWhyNEdrdWpJQXNpOEdaY09wdUhy?=
 =?utf-8?B?QjJFMm5hVkErQjFPWXZraHlOaFcxUWRPNXliSEk5TFRyWkJxdWVxZXlJekJz?=
 =?utf-8?B?dzlhRE42WThScVQwYlU5SUQxQm01bjNDVWRZWkh2ZllSVnJHYnY2T0pIcVF5?=
 =?utf-8?B?bkFBYXNndEh1bjdPUXhQbDFmSnY0S3YzbmpQZlRHUUxENSthTU1vQnVYdVRp?=
 =?utf-8?B?VjUvNklmcmdvMFJOQmN3L1BSK3I1WUJsVXZKbzhZZzZYSmZHSVNmNXpMUjk4?=
 =?utf-8?B?TmMxTjlBRzRJWFVlUzkzckdPRFFaV05LT2NPOThSaFY5L0J6WEVTYXM4QTBC?=
 =?utf-8?B?aE5oL1I5UU43dlVzcmFQYWZFelNyaU9kdHJBZjlid0l3RUI2ZUxpd3Izb0ZL?=
 =?utf-8?B?RyswcDlrY05HVTlYMUlUYXNkdjlrYUFHdlA0SkE5ekdTcy9IZWlYTTJhakJQ?=
 =?utf-8?B?SjVHbXhodjNWOTJsRUIwOG9wUHVoZCtZMXo4ZEJDOWxLQnBsY2hFTnlmTFRV?=
 =?utf-8?B?RFhHYk1DRFZuMkZLYm1PeXpNMGY3OUZROWdDKzBiOHNxNXVsRVp1aWJybVNz?=
 =?utf-8?B?WWlMczFaWXVtSEZLVFdXa3NTR0RUNThOY2VMVVNBbi9DRDVKRXRTcXBDYmJx?=
 =?utf-8?Q?9IbSIzNj7+rjb80E=3D?=
X-Exchange-RoutingPolicyChecked: YJtXuz207QKZen8CMt48ezVa6yTMaSgqotDw8ER6fb23kM5zda8tH+Nz5nqtxZoBiCazI/ZteUdySx+0jQ+NiSGFQMOqBT4HJX71fbmTp3SYIJV9aHoKIBxWCjg40thJlVWpTCcmD77efBL4diCN60IHqpa4BlpCxCNtu7L67uLY6uTzNnJxDlaQGxeOvup6nYXgg+esqO8csOzh9Tx2mzk9tDth0rDJcfiVDJBZWtOD9DpyQtNm0Td4Lb4Phz7bgGILAeolNqy3wg5hVM9OenTsy+DTssr33IS3lF3b98o25g4dnkd0lolQgJ9girvbc96W1V4YSQd0cZ/gyUt/Aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2e0001-8033-44f7-35d7-08de8be35a93
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:29:32.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXGo6EjSp0R4IV+OgnskDhDFgcS6ixx6YGp9vkPXneqjcA1bVMZFld893o+cPRsbuaCRKOwSlEA1Re3dNodJMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com

On 27/03/2026 09:51, Shawn Lin wrote:
> The driver previously used an enum (dwcmshc_rk_type) to distinguish
> platforms like the RK3568 and RK3588 based on DT compatible names.
> This approach is inflexible, scales poorly for future revisions or
> mixed-revision platforms, and conflates SoC names with controller
> revisions.
> 
> Introduces a new struct rockchip_pltfm_data containing a dedicated
> revision field. The old enum is removed, and all code paths are
> updated to use the revision-based data.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 87 ++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a91b3e7..6b43ba9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -278,14 +278,8 @@
>  #define PHY_DELAY_CODE_EMMC		0x17
>  #define PHY_DELAY_CODE_SD		0x55
>  
> -enum dwcmshc_rk_type {
> -	DWCMSHC_RK3568,
> -	DWCMSHC_RK3588,
> -};
> -
>  struct rk35xx_priv {
>  	struct reset_control *reset;
> -	enum dwcmshc_rk_type devtype;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -330,6 +324,11 @@ struct k230_pltfm_data {
>  	u32 write_prot_bit;
>  };
>  
> +struct rockchip_pltfm_data {
> +	struct dwcmshc_pltfm_data dwcmshc_pdata;
> +	int revision;

Does this "revision" match HW specs, otherwise maybe need
to clarify where it comes from.

> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>  	u16 ctrl;
> @@ -749,6 +748,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
>  	u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>  	u32 extra, reg;
>  	int err;
> @@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	 * we must set it in higher speed mode.
>  	 */
>  	extra = DWCMSHC_EMMC_DLL_DLYENA;
> -	if (priv->devtype == DWCMSHC_RK3568)
> +	if (rockchip_pdata->revision == 0)
>  		extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>  
> @@ -842,7 +842,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>  		txclk_tapnum = priv->txclk_tapnum;
>  
> -	if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +	if ((rockchip_pdata->revision == 1) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>  		txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
>  
>  		extra = DLL_CMDOUT_SRC_CLK_NEG |
> @@ -898,11 +898,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> -		priv->devtype = DWCMSHC_RK3588;
> -	else
> -		priv->devtype = DWCMSHC_RK3568;
> -
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
>  		err = PTR_ERR(priv->reset);
> @@ -2115,30 +2110,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
>  	.set_tran_desc	= dwcmshc_set_tran_desc,
>  };
>  
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> -	.pdata = {
> -		.ops = &sdhci_dwcmshc_rk35xx_ops,
> -		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk35xx_postinit,
>  	},
> -	.cqhci_host_ops = &rk35xx_cqhci_ops,
> -	.init = dwcmshc_rk35xx_init,
> -	.postinit = dwcmshc_rk35xx_postinit,
> +	.revision = 0,
>  };
>  
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> -	.pdata = {
> -		.ops = &sdhci_dwcmshc_rk35xx_ops,
> -		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {

Better order: sdhci_dwcmshc_rk3568_pdata, sdhci_dwcmshc_rk3576_pdata,
sdhci_dwcmshc_rk3588_pdata

> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk35xx_postinit,
> +	},
> +	.revision = 1,
> +};
> +
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk3576_postinit,
>  	},
> -	.cqhci_host_ops = &rk35xx_cqhci_ops,
> -	.init = dwcmshc_rk35xx_init,
> -	.postinit = dwcmshc_rk3576_postinit,
> +	.revision = 1,

Isn't rk3576 revision = 0 ?

>  };
>  
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> @@ -2309,7 +2326,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &sdhci_dwcmshc_rk3588_pdata,
>  	},
>  	{
>  		.compatible = "rockchip,rk3576-dwcmshc",
> @@ -2317,7 +2334,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &sdhci_dwcmshc_rk3568_pdata,
>  	},
>  	{
>  		.compatible = "snps,dwcmshc-sdhci",

