Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32C3D8911;
	Tue, 16 Jun 2026 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590404; cv=fail; b=k58gfyF5Pr1eaJO5vDErbMPLxTeincB7XmAfd9tTqL7iG2btVjidiPvkAJn0LlOQhFg6OBkvXgNrcoYz8dp4lydlmNC2FYgcX3SN8G4NtaVJVWglDaBwT2/2oeduxsVZMM4v5wL4ekoD9631Ka3QStfp5tYKyoXT+y+KabZil7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590404; c=relaxed/simple;
	bh=ci2P261uI/4o6nbhhgegY/A4U+Mo38OI5Fgn9q8JnHQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jJ0C5+5MVCX+A4Mqa27VF7ht3CKn6tDNE4VmwJwQdYRygHeGsptorVnhKNoa1ieMLJpZQ5HemOiRO0Nkeq0AyM90HY24ngS49z23v54PmP6nyijza8RIegvaEYiDp2bUZ60s4TGfex/ATd8Plw7mJIk8ymA/53kEeHVO/ccS4GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTMoswZL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTMoswZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781590403; x=1813126403;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ci2P261uI/4o6nbhhgegY/A4U+Mo38OI5Fgn9q8JnHQ=;
  b=PTMoswZLfQP4dYhP3XOdmgdw3YmUYPSomFMKOsi0jzD6E/C2iJELHo9e
   20DPDOUHWrgKYC2uZPuHGCqhPV/CZRt6peL2uwsj39TGDpeu6e4qOkRnG
   wicjWTWb2FKEHNmxBQ8jL0YRditRlFILCjNuRKmYfSx5TnRtYhYrcJcms
   4IQusSEgmftwN7GjbUv3SgKhtped6TNLQ7pVF8pQkAbrmYT99n5hJAWXE
   jIZa7W4fzIFG7YKVSospjytBXfDL4MXj1N8FGnusOVQ4nMCfEItngBaNi
   HmeMM8Y5dX6XBbVRCqWBg4vHDWkBAWlsuLXD0juHTfk/CbX5cyPGrW1pU
   g==;
X-CSE-ConnectionGUID: Q+pn+1SGRV+p0cH2Q1R+iQ==
X-CSE-MsgGUID: PcG7Ax03TLCF7oVocN1RFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82190477"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82190477"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:13:22 -0700
X-CSE-ConnectionGUID: OWDSkLT+QXe/2KEIDOpzig==
X-CSE-MsgGUID: +WBTLQZmST2tZNJC1oMsbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="245282729"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:13:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 23:13:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 23:13:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 23:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srsb9+5utz92sgEel8EBgTSkdllzTGn0jm3/tdZMLqey5WTty7ZXwGvYWLepLX5BDrwEUFzpFUe+ftT2aQ8VR0AHLEwLC9LHoeiKYu/1iwe2DPSeQWyblTOm/edZGyJ4CyCXdnZ6jAR8mViSM6+Z5iuQG4RvZtHq2C2UCBjgXxawx62sDy5G4cQsVxTap1YdiLFNT2wgdux+nHBP4rXF45bzrceX/F4nIkuG1fwNj17/nskOxxNQigxaPVRf9wIFCFFNqTUnQjxnlkaA67o7O1/ZS1y2wDx3NhTM9NPCtxm4S2SQy3RGhaqkKHyhCL7jRuW8L8BktRVjgmQC9cE7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwQ6pv4reOK/zAELW9vRuQpzIpB0AmDkNhAk4FuCq0s=;
 b=yFFuarr1Oz9GvJrAI/G6mY4SKKMqz1ClcQIs4CQBTdHC89pwysFlupm7P//XqFppnpxdtepc4WZFxE8wm9NBuUCFJFv95+i+rocNV8isM4vdriKGOPiVHBz9M/2R5PD67FFmS8uNMFApL1Lp0NXZiNQK6DfcrpYZvgatRhQPKkCPV9qMjEl83GiTFZ77EvSUdnL3tMnI9+xDR+FH9JaLtYixE3cuHvhFpUSE5skZ01mMdlw20/kybNb0KRf9yJvdMIMzniM5674rqgWoMhXGyknU+tpgiFB6ScqC5y16jlqxDTgPAc9i3+6raq3EyDreBJ8rwh3B0nlWd9lzN5AFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB9774.namprd11.prod.outlook.com (2603:10b6:510:398::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:13:13 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:13:13 +0000
Message-ID: <076d773e-85fd-44ab-9665-2598b770b2a7@intel.com>
Date: Tue, 16 Jun 2026 09:13:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: depopulate slots before disabling
 clock
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ulf Hansson <ulfh@kernel.org>, Joel Stanley
	<joel@jms.id.au>, <linux-mmc@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>
References: <20260616004953.3469-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260616004953.3469-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c287c1-af77-4139-7a76-08decb6e5917
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SxgzL5HztG/DTyukqAJjX+kHwO0c1X0PD6afFIVU2D5xJJQuzXVQKA9NC1lk/cCwOVIbRYuCnHnuZYZZ1xoyFQDYOalp5VRT9lPfRuKQDUjCgOg8nUKVwOB2b9ewWEgXcwyEKiGKNoMkj2H6SlfuwhitTfGUdhSaxqwsi1oRES//MtV/lpt3z8u9T9lf77f6BFdzkiMfBAhvQdFrsAvFMgUtdjdHia0b/gTojqCB5/WGNtkMoPhvU8hvHCP0VOPVShWriCrfcxSQ2xYidUQDmsUBCP7y1TRAOdEiN8uaD1YUrZrrUDeXq70bW1OjX4/qcG1pWDeqegRLYYF3ZgeJdpX0rnAkh+L5K8r9Xopn9xLeeOKj1H/T0kivkV78AN+JBO/gThyDzrtwohtG7AbaP0kaSPH2SaDH4WMeyf1OdShzopcjVwmzNBOzkb8tI3xobXMHgaSCWDGZiB8ZgF8/NtAwMX4FxVYRLOEfLPCCcbmvahf+jac1Cqd8KC0djRTJLLLaHFqNiC6gNJvvlw1ON0FH0YiBXrXZqIKe6PSt/u9AqRojM9m+rU2Obj5vaAtam7Qy5Fak5Ys84ptgSYUEwuCBKO/JpZu540Z3O4kwPrOO9DJH0zkQna301Y32D4gs2f+24auOYT2vvNbStrZpLq0zh09+gxiVWC5G1CLfdtTTRxlDtYHstT/+yqPErSWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlREN3dKT1lQWVVvV1BLL01hTzROWjVFMVJ3VEpvUWR5L3JJbE5GMllLenQ4?=
 =?utf-8?B?d2Rydm9DN1FCeGkrUEIxTFRXT3ZIYitQZkpBQ3UreUtHd3FmQUVsZDFVQUZB?=
 =?utf-8?B?Vi9BQnIwZytwZVRnVWlWazJBVjg2amE2MTFUWHl1cTJDc0VkeXNzaGo0dHFh?=
 =?utf-8?B?NDF2aUxtTkJURjFsVlZwN1o5bjNzTmNrSlJ1dnVSRTJkSE04UTZnc2lTR2JT?=
 =?utf-8?B?TWUxdmhQdE52SkJFbzVQVWtZM3F5RHVLdS8xeTR2MEdqbnBVSDhPR0dpRkJE?=
 =?utf-8?B?cTlSWWY3ZFhJVzh6NjF0YTlKaVVwWGZIL2hLaG5WSjlML0hpQzhvd1Q1bFEx?=
 =?utf-8?B?L2hLaklDd0RzYmh0SDh2L21QalZCb1o5TjN4ZGpnUXN3bVd4b3JJS2QyRGdC?=
 =?utf-8?B?ZFdQMk5LaGJBOExGNXdVV0pGYmc0VFFEeW41Y283T01uL3J3LzBNQWlIMkFr?=
 =?utf-8?B?TVVCQ0lwQU9iTnd2RmZXVGRndjY2L3BPd2JJYWRFd1NVQ21IbE9rSlM4a2Vn?=
 =?utf-8?B?VkdXVk96T0wyRTc2UUxwRDI2MGJYajd0LzJEdzUxTTNSN0RPNUFxaEFic05K?=
 =?utf-8?B?SW9rZnN2c0ZNbnZEdjNRdHZPS00wTlZLUVRMQ2N6MTRaYmpUVWo4V0VKZUow?=
 =?utf-8?B?VXRTQ0hEODBiYVVoYk1NNjROb1BhY1pEbUsyRTQvNzA2Sk04L2tDaWNack1Y?=
 =?utf-8?B?cWxWZGdZbUZlYU5rcU5yYUZjeDVlUVlqRkFGeVJ3RG5BczBhOWlnaGlDbHUv?=
 =?utf-8?B?UnhsOXJVTWxjRHMwVzk2aVVJYU5md2l1MGs2VzFwVHhza0F6Z0Q2Q0E0RFhD?=
 =?utf-8?B?K3pERmxqTklLa1pUa3BaTHFaMlMwUXgvZ282alhKOEdRYWNmd2hoUS9zaHFu?=
 =?utf-8?B?RGJUY1N5Nm5Nd04xY0dCOUwwdFZCWHIvRTZoRVNiMm9OdnVoY05rSmhKeTVI?=
 =?utf-8?B?NGl1TjJiTTlpY0dtQnBRVUpTYzhaRHh4U2t5YUdOY2g0eHZSL2RaWTAyYlUx?=
 =?utf-8?B?MlJpNUh1MHhESGxMa2pQZXZ4SVcvNlIyVlBaeU9JRDRaK3F3ZzBFY3ZrWEhI?=
 =?utf-8?B?OFpCdnZJSy9qUFNQcm1XU28yWjdyWGwwUm4rZVBnRzJyK05HWUhLU2FCTGE3?=
 =?utf-8?B?OFRKYU01ZkRDNWhrR3ZIMHEzQStnWDZOcWdpVjFsV1cwdzRmRDd0ZlhHaHVv?=
 =?utf-8?B?eTZta2Vmd005RUdjV2lVYlBUaDIwU0hMRmRHY1dNU2NBZURmMjNjdTRvM0o1?=
 =?utf-8?B?NVg5UUZGU2JSRzNrMXErZVB5aUF1SEdUMWZiV1JLYUxGQUhYRmV0Vm42QTRz?=
 =?utf-8?B?NmZGOXBZaXdheEQySDBsN2srT2dEVnRqQ3lhd3AzR2dvNlRJYURLQktGc25i?=
 =?utf-8?B?ZVJVTXZRdE82MkV0US9xUGVQVkhLenZwdmg5eTRaZ1UwU2pyWU1QbFBtK1Q4?=
 =?utf-8?B?TDZXbmhvYi9XKzN3N0x0aTlhckNuNHRZQnNaNnNSUmxESmRaQi9ySVNrVFIy?=
 =?utf-8?B?Vllqb3M5L1dHODhVbHlHNXdtaHgvMEwxR1lnYmFDMWtEYTh4bVIxZTNVU0o0?=
 =?utf-8?B?ZlltT0drUWcxN1pUV0pBMzR0ODV6aHZ6YVBTckFWQ2c3SjlQOEZOQXFyenRK?=
 =?utf-8?B?a2ZKQkpyUkdpWUZvb3RHRE1SNHNESk5IUmM3eml5amp3WndvVVNINFhuWXIx?=
 =?utf-8?B?OFh6dWNHWlZEZE5YZ3JMNE1hWWUwZ0c5M3htS0lyeXFjVE9xV0tzS3FrbzhM?=
 =?utf-8?B?UTZmemJtaERuYjBUbERvZjM2eTJ3eVlaNUUvWXU0Tm54OE9yallaZzFjbjlx?=
 =?utf-8?B?KytYaHZOWWN0V0xacGZEZHMrOUFqRVkyT1BJNS8rUTVYQnNsaHZBVHNjQXdy?=
 =?utf-8?B?U0lXVnRBazdIeUhpOVhMRzlsZnVpZnZ4NTJVcHk3NmZ2cG5MSktSNkxId1JE?=
 =?utf-8?B?ZlhEVC9GR2ZSY3BPWGljai9kOU5iRElFZk5TNE14Q2pabEJrTEU0Yk9KbHRC?=
 =?utf-8?B?TmlaT2VBcTErVkFhUllkQmlhRFNvSERNVnhxQWxpUi9xNU9jdnluSE0rdjVK?=
 =?utf-8?B?ZGZRNVMwL3BUNHRVMlpDOGdUZm5mYWJFV2pkY2Joa0I5QXgvSTk2WXZTaEtp?=
 =?utf-8?B?aGNCa2pTRndiSThMVllTVkE3ZVhaZGQ0eFI4M2tzNzVQSU9sUG5MYlBNVUVn?=
 =?utf-8?B?SENoNDIySXRlTkdBdzhEWTkwUFZoUTFCNFBnM1AxT0YzZDM5cUZUdVVqcGdZ?=
 =?utf-8?B?dDRPNWRlMUpSWUVlbms1Z2FXZGtQUW9CRUJuUzNFekZiY21BdzRoSjlxZmRK?=
 =?utf-8?B?ajBhWndMd2xqNjh3SnJSandocEhzK2NqK0NRSHZyOTlFSFI2VW9tL2JpbENR?=
 =?utf-8?Q?w0UTNM5nGG/+2h+A=3D?=
X-Exchange-RoutingPolicyChecked: iCeTDARgfxOCSH7gAyD7knnMKflZnod90+rFBOJreXD/N98Ur5yeBN1Y6hzNj1tskpl28zcixOzzpTqb7Qe2hJS2pkNTnDKrroHxE/3SjiCWJx0CI9yrkof6J6jc/Xk41Pw6XZfqzGa4J4A4PFNaHplXdna0Al44g/ewMwQdQHHy2XO5XLiujhViA5fpCGHkBa4wOWtW6l7LdCZ9dJHphJW+p3rL9RDo5SrTeo0aFiU1Yop4Pcou3ZQmGYEyadBVOL13J/ZqiwBhJf1Vre0zV4I0uS/0xuicN+Syl4AzwvOMo75a8MBqcjQUP+SezR8ypnXL8iJaYzemSBUsDvzLiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c287c1-af77-4139-7a76-08decb6e5917
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:13:13.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn6iGwL4KsRUO402KYy9CI3T57qYd1s87gErfdpQ9sQjT9Z6YkNBybGqSPhjEd05XrZtHh3ZOB3rZ+UiZ/Nx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9774
X-OriginatorOrg: intel.com

On 16/06/2026 03:49, Pengpeng Hou wrote:
> aspeed_sdc_probe() creates child slot devices one by one after enabling
> the controller clock.  If a later slot creation fails, the already-created
> slot devices remain registered while the parent probe returns an error.
> 
> Depopulate any created slot devices on probe failure and during remove,
> before disabling the shared controller clock used by the slots.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index f5d973783cbe..3e941b176687 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
>  		if (!cpdev) {
>  			ret = -ENODEV;
> -			goto err_clk;
> +			goto err_depopulate;
>  		}
>  	}
>  
>  	return 0;
>  
> +err_depopulate:
> +	of_platform_depopulate(&pdev->dev);

of_platform_depopulate() does not appear to work with
of_platform_device_create() due to the OF_POPULATED_BUS flag

>  err_clk:
>  	clk_disable_unprepare(sdc->clk);
>  	return ret;
> @@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
>  
> +	of_platform_depopulate(&pdev->dev);
>  	clk_disable_unprepare(sdc->clk);
>  }
>  

There is another existing issue that Sashiko noticed:

struct platform_driver aspeed_sdc_driver has:
	.pm	= &sdhci_pltfm_pmops,

where it won't work correctly.  It looks like it
should have instead been in:

struct platform_driver aspeed_sdhci_driver

Refer:
	https://sashiko.dev/#/patchset/20260616004953.3469-1-pengpeng%40iscas.ac.cn

