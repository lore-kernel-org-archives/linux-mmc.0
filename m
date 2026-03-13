Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618A315D5D;
	Fri, 13 Mar 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383748; cv=fail; b=O++4Dr32OyQoqViNY1/abGr1ak+QoCF35ChfU/jDg1egwwU4FUhewCakt8AFG0NVp9PMsn88bZR5SN9VD1rXgM6jpCd16Ut13dgpv/k85JUPvE+ScLR60YUm7s+CFrFxPi64zLwkuJ8U6PDh6197rQYGwLfZJ7Bca9hQqpEaY/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383748; c=relaxed/simple;
	bh=dF/DvzkYl+o7uYRGj2iQ/oJ06xq2qb21Ai/oTzwnYes=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NhHMDrmx+NKtVUf05RI5YL1Lg+J6wQaARjW/Adi7+9tvx5hUerr9l2dbK7nzz8PSJLAKm0NmNZx4PHU9HhLhAp/k6R+vrxs+ODpAeV2HnTlyRgD52MdIbV78fJ3/Z5/TFzl/xUShecviwEZyrzJ0STj/8AbyVbrMCzAelHwbxwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvzBLv+e; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvzBLv+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773383744; x=1804919744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dF/DvzkYl+o7uYRGj2iQ/oJ06xq2qb21Ai/oTzwnYes=;
  b=nvzBLv+e/FcVCnnNK4DZdo9YC9sBL41BIfKLcMTXNFAXzO5wp+Neu9Ll
   srTZw/j0oLYlFImy/h5EJ5XNRoK2YHkunDLqf8NAGQWQ1OuCdsNo3eUUd
   MgehBECwT+YmtKHzhRx0oEIZMVrRr4bCvwyyOJ0yoy9kLqYNpNZQu5bEs
   Kfxx9DLMEhkQLCY3frmjHICOIJIcR0ijHU65pcvh2Cm899M85EaW31PTI
   5ZlXc4pF57FCN0Y7mWZllX1C1eoOewYvOmgyxgQ3BG6RlB0tsNnBp55qn
   8CW1Uu1f/nNFAVlvl+dfmYCCXJcYpJL8BRrVwpNzG0573RYt7GYyi5IlQ
   A==;
X-CSE-ConnectionGUID: 5vsh5ginR6amyZPPqd6LuA==
X-CSE-MsgGUID: y67ZqHhOTZCgfl6FKla/0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="92062859"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="92062859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 23:35:42 -0700
X-CSE-ConnectionGUID: Df8F1Bs6Tzm2xTPbapkQ9A==
X-CSE-MsgGUID: rWvhgK8URsWpEwEAn8Tl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="220332373"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 23:35:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 23:35:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 23:35:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 23:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1UNVrX0Qpdy4fPaOAxxRhG6s/icl1vCCNIC/m8lwQr3D0NLtY1X0r5dznPlh67oiCvHdJJWJWyZIia4d+Dvbbm4fNH+XtbxAPIsZ9vHMpcK7Edc3QuDy4ZDfZJj264jEdoWW8v4OPndsVOmuLyftbwmzQ2Z7d0V8HkBf3WDjskp/OUGgaRfpSu5WksXTn/swCBCd7FIZLUyvetatIq9UPeQcdZi3B1oLrwgzbxzaUAHf838LYwsOGtMgviQ9HVRY7WDoyvXJrSlgJiQ4koqrZNXF6dvWXas9nxUUDNJWX0fpp6Ec8aKNcTnGsO4sJy8LujMvud8PhTBvLAB83JAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWTSZOO1wwTIhomSwl0IE22xWpjCk1r/q2TJaYflfx4=;
 b=NYvMesRwg1oSOogBgRGOzMh/V2GTwrH2tp91rVtRHf3RRcH9TH4Pk/HlmK120EPafxuYdwMemq9RoD/cNo928go3jGsSUcoutrZXLGZ041BKp3meDlC4LJe8tCso6CQBr10cGk0frNhSQ97xYoujLjMigT7hY6Xmd8J+tIFqv7bZL7meXkAOuL6GDrESIIJdTvCsWiaOEFeSn+NGvloFEQNjvYXDedZo+bmqR0XKkt9eguJ2Ucj6kZtiDc9WjEHBAz2n7Lo9RgbOMs0rW3logesPDOkEYWKkwLjRrsSq2T9C9zUrwQhuBSWTXLdrdmo3CYoHfVe4E3ETv3cCh95Etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9179.namprd11.prod.outlook.com (2603:10b6:208:560::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 06:35:39 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 06:35:39 +0000
Message-ID: <e28db5b1-5552-48e3-8cd5-97e3e7bc7778@intel.com>
Date: Fri, 13 Mar 2026 08:35:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: Shawn Lin <shawn.lin@linux.dev>, "Hawkins, Nick" <nick.hawkins@hpe.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "jszhang@kernel.org"
	<jszhang@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
 <20260311181112.1700667-3-nick.hawkins@hpe.com>
 <c4271da0-87c9-d7c2-db46-e7ed7f5e4fdf@linux.dev>
 <DM4PR84MB19274AAA6B344A850A1824958844A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <76c61887-8e75-15cd-73f7-bbe3ea859472@linux.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <76c61887-8e75-15cd-73f7-bbe3ea859472@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ecd1ca-4030-4539-808e-08de80cabe0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: Xla3Vvn0+tXJYXHAcNVSlx30GErOZ95+L7xOPOTfKLWSANa184Y6Z0gEYjwxQO2ayBK4k12dNM6iZPPNrNuhKZJ0awD+zHtWLIoWNk7SWiZEOca8l9dpuHUMt6BLpPNwszKmNQI/uib/TlymRLiPYIZZ/La52TO5bZ+HBzwEZZzukBn/NbjqCx1wtT2KI5fldk7c0sxioYJ0ejrEKBRBZk63dF39eCNfBMvvGz+ZrpmaS30DAUmgtrLY0lJGnyFXZVvRRQRbXzwie3VUvkLR4AJRn1J0Q5JfexCXEbqKJ/xoOJ0QpV19QgcETq8voS8OAlh1emt3tuAnLYqahqK+93BCAHwVoVyU/hNtTCWqo7oaFNkNSMKtfnRRxuFPSfpBp4MjzurD5dflsoSKT5oRviTQddvoX18ZYqfxRNLmSwwaQZemsW1I+3k9usmILOyVpMtHV+gQBMkM3XMIdcg5UIlO9Ncgh/LxOFBk2F7Uc+NJ6Zmv28rvONGtC8CdcO9RDj9PxemdcqJYIlcGJZE6cHnFmdXoSUbdgTvvgn8GvBsCcf6IvddXmA92aIfCeGXBrAYHpKtsQ95AcjqlJDJfFqSvMymJ3q9E0ymlZqE5RAU1bq86AgbrS/C5mksy1cK6SYylJMhj36Ffq72nPopN9qXWYuYkwkCNSjby2a11nQFFHAusFfbKk/aZ+b4lJOOZWPnFy5BCquSzp0DCT2oz/hAvJB8fp4w/57RSAwmPEQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZiNTlLSGVjM1EyOXlIcnBtakFKeHFHSWk0L214Y0IvdUtTZktVcXlxRHF1?=
 =?utf-8?B?UEYwOE9UcnRpcWxSOVdjS3NJYWxWcnJYV2JaUmdoaVlBRUxiMVgzSkV2OURq?=
 =?utf-8?B?SE1mNy8xMGVnNFNtL0l6cnFYbzB4RTF2MXBsTUNyRXRqNWp6T1Z1cFl0WnA1?=
 =?utf-8?B?WjM2SXRIN1VWZ25yZkg1UXRhV29maXV6Z0JXUDN2VFdKMHl0aGtCZXdENUJ0?=
 =?utf-8?B?UTVxNFZSS1d0RXg5MU0wL2E2ZGJXWGdGelJwRXdUZjluQmtRWGRjRExaRno4?=
 =?utf-8?B?QU1YV3YwNjY1V0RvaXpnYWpDVWZiL2wyT1ZLSTNUQUw5OFFWTmh2dS9sRmFH?=
 =?utf-8?B?R2REZStsem1pNTFyNEswN29QNWxiWTFvMjRPaGh4T1Q4bnNpOXl2TDRHWlJH?=
 =?utf-8?B?a3hyU2pLT0hiZDFjWDR4L04reFdiMkliNmF2NU85dmd1RzZZMlFxN0ptRHZV?=
 =?utf-8?B?d3gwRmxiNWhrZ2IwSUxsbGVNU1JiWXl6U05MS3BxcUtyY3FiVHpteGdDc1B4?=
 =?utf-8?B?SWM1OUg1L3Y2K0lxV0VKUlFSdGFUWU5hL3l0L1c3NEQ0RGhXb1lrbXFpSmZV?=
 =?utf-8?B?eWpSbWkra3hjQks3ZXdIT2NjRyswRzNCZi9zTWlUNGNrbmV3VHZnbDRMbFRo?=
 =?utf-8?B?emM1NWE1dFNyci8zRUFUcXlNRC9SSlNZRittMVdxdTA3K3N2VGZXL0NjVDFU?=
 =?utf-8?B?Sk1nbDQ4M2xGUHY5aWJMdmNVQXorWE54elFLeUZpNnhFSk5TRExWNUJ1aENC?=
 =?utf-8?B?TUs3UVBEaWRuTkF5TkJBV0pKVVJqK2tQTnZEV1VGa0lqZ2NKaEFBYzRldnBV?=
 =?utf-8?B?aTYxODd3b3E1aHBsdWFOUGFzUzRnaFc1K0ZHVE1iUy9NQmtUQmNzc3BTSmNi?=
 =?utf-8?B?NkpWK3hPdmpRbSt2eU5DVjRjV0xiSDRuTDB0ODc2aElSK2MxU21naUNlYUtX?=
 =?utf-8?B?c2l1ZHhUMW5CZTh3QVhJM2pDU3JBQVdMbEkwY1N6emdEMjhYREVIeEp5bWFV?=
 =?utf-8?B?eXJrbFBLZVYrWS82NG5iZWxCQ1RrUTFrTmRjN3N6ekFMalRCbE9JMHZIOTJ1?=
 =?utf-8?B?cGhCZnd0dFpqZlptci96TFNqVjRoWUx5ZXZQQ1VPaWZxd1Y3TTNBZk02UHdG?=
 =?utf-8?B?czdTSWowN0JqZnhhRnNxQkNCTjR3MU9HSmVzMi9VS0haaGV1dlQzdjVRT3ZY?=
 =?utf-8?B?TGYwRS92Sll1RldTSUZFcnpOZU5zV0tLRFpWQnRpeEtXbWJ0L2sxVEtRczhE?=
 =?utf-8?B?dEl2ajhQbkFZVHhCem0xZW0yYldYSGd5WEx1RVBKOTdHUEt5dWRpajBIZDZ4?=
 =?utf-8?B?dW1xTXJMd2x5ZHEvYW11bkYvTytheEIyV1BLeUZ5Mnc5NlIxQ0haa3dvazVt?=
 =?utf-8?B?aDJsQms0TWk3cnVRWk5CTHpiWHlyUCs5NzdiZ1FvR0tGOE1zWGcvRU1GQVM0?=
 =?utf-8?B?ZjZZTWZLNCt1dXJuWTA0Y2hscW5jdGdOREtGZk5lRjN2ekVDemJ1b3VkZWxB?=
 =?utf-8?B?YlVRS0QzWEZub1B1QVczZzRRYVdmb1Y3dnNNQW5CZlAvVTMrdEw2VlE5TGQr?=
 =?utf-8?B?ODNDQXB0MTc3MllEUlk1TzlQMEk2Wm9OVEJaTUJqUUJZVytqNjBUMmpDQmxu?=
 =?utf-8?B?YkpRTjRXVG0rUHZKZ0txMUdOcTVSS0ZibUJLNzdhMlhoWUc5WXpuT2FyckhJ?=
 =?utf-8?B?TkwwR1hIWXBhWTQrWGNPdVFHYlZzNGc4OVBsZ0QrM0V0RFNBR3pNSnZRSnlU?=
 =?utf-8?B?NFhCUzQwampwUXIyQllyN1F5VkVIZUd6NUdhZVo1K2VQaE5QWVduVGk2d2xI?=
 =?utf-8?B?QzN2UHBVUFlqY0dZcDJMM2NZRUJ6OWdTWXpQRXJNU2xCSXVXVi96Qm5Ycnhw?=
 =?utf-8?B?QVd3UzJaSjRPUnNjdXlwWFdIM0tDcElTZ1NKdTk0a09CTkpIMUpHQWVBcmli?=
 =?utf-8?B?NnQra2gvbTA2dG9DSm1jb1NTMDNqblU1aUc1Mk9aTGQvZnZHTWJiZTFteHor?=
 =?utf-8?B?SnYvUElnREdNZFdjK0p2QlpWVHJ5Rkt2ancwM2FlRThvcHlGUmczTkorZHgr?=
 =?utf-8?B?YnZaRURqVE56STFwWE1sNGdubDlzY1R3Rm9PT0ZNOWN3WWplOERKakI4SFRG?=
 =?utf-8?B?UEtsdlhyM284dkk3MGQyUGNYTDU3WjQvZlFtNEMvcXpzQVlBblhZWm5rSlVp?=
 =?utf-8?B?cVY4UVNoWWNNK0JhTXV6ZU1SWW9Ra2llaGNxbitKY2xMUEFYSysvMzM1VmVN?=
 =?utf-8?B?WEQvZVNXdnhaYlpjdytyYkU5aXBOUW9Tb0duZmZYdUNUd2IvVSswY2tVVUFr?=
 =?utf-8?B?djJ2YmVpNG9Ia1cwbXgwanJ4TFVWcHpBL2tsNUIzK3NkblFYS3RyeWNBVlMy?=
 =?utf-8?Q?Rnp4nfqNhyXUsZ4M=3D?=
X-Exchange-RoutingPolicyChecked: J0qyKu9MDsOGPbBE6mcqm7Nkf6bPhJujE3O9TSWFv8ZrfzBMDRGnHvfXP5ZglOD/S9p+OPV2Cc4CskCtNGrHFUC+dkRZt+7G974I8zZLb4wkmMPDv+HG7Llru94aPPN/3GcsU9cYKub1vXER3/juVpREjS7DgiKIMOtY+ZynueSvrfk3WyX2JqGTsBNLrPk0y3vXTVgUJ2Vmvsh04Kh2eUyYDMoGLp9Y20si2BhO9A+J4sD9gqdx22aCnMtEmpq2bfvLefJW2pnAlW8riTFZ/7udLsq7i2IvUs51tUP5g24BuUdvbIRNRe4UAhZpg4hOSNjwWRCNoYsLjJW4bzwFrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ecd1ca-4030-4539-808e-08de80cabe0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:35:39.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywSFxypi1gs1jV0adC1wcGxYLfyAlrSA8qFgTSMwCJCJpEV4rdC1n7ozbkCxsriasQx3Cxvb6Tg6FpiUGTWpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9179
X-OriginatorOrg: intel.com

On 13/03/2026 04:10, Shawn Lin wrote:
> 在 2026/03/13 星期五 3:25, Hawkins, Nick 写道:
>> Hi Shawn, thank you for your input.
>>
>> See below:
>>
>>> -----Original Message-----
>>> From: Shawn Lin <shawn.lin@linux.dev>
>>> Sent: Thursday, March 12, 2026 3:25 AM
>>> To: Hawkins, Nick <nick.hawkins@hpe.com>; ulf.hansson@linaro.org; adrian.hunter@intel.com; jszhang@kernel.org
>>> Cc: shawn.lin@linux.dev; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
>>
>>
>>>> +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
>>>> +                struct dwcmshc_priv *dwc_priv)
>>>> +{
>>>> +    struct regmap *soc_ctrl;
>>>> +    int ret;
>>>> +
>>>> +    /* Disable cmd conflict check and configure auto-tuning */
>>>> +    dwcmshc_hpe_vendor_specific(host);
>>>> +
>>>> +    /* Look up the GXP sysreg syscon for MSHCCS access */
>>>> +    soc_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-sysreg");
>>>> +    if (IS_ERR(soc_ctrl)) {
>>>> +        dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
>>>> +        return PTR_ERR(soc_ctrl);
>>>> +    }
>>>> +
>>>> +    /* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
>>>> +    ret = regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
>>>> +                HPE_GSC_MSHCCS_SCGSYNCDIS,
>>>> +                HPE_GSC_MSHCCS_SCGSYNCDIS);
>>>> +    if (ret) {
>>>> +        dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    sdhci_enable_v4_mode(host);
>>
>>> Sorry, I overlooked this part when in v2. But we enable it in
>>> dwcmshc_probe() based on the capabilities, isn't it? Unless your
>>> hardware didn't set SDHCI_CAN_64BIT_V4 but actually it does support
>>> it? Then it perhaps should be a quirk, although we in general would like
>>> to avoid more quirks... It depends on Adrian.
>>
>>> Btw, unlated to your patch, but th1520 did it the same way... Hmm
>>
>> The GSC's IP is configured with a 32-bit DMA AXI
>> interface, so SDHCI_CAN_64BIT_V4 (caps bit 27) is not set by the
>> hardware. However, the controller still requires Host V4 mode
>> (HOST_CTRL2_R bit 12) to be enabled. Since dwcmshc_probe()
>> only calls sdhci_enable_v4_mode() when SDHCI_CAN_64BIT_V4
>> is set, the explicit call in dwcmshc_hpe_gsc_init() is necessary.
> 
> Okay, this aligns with previous assumption. So, we should either handle it via a quirk in the probe function and remove the call here, or simply add a comment to explain the context. This depends on Adrian's preference. I have no further questions. Thanks

Since ->init() is needed anyway, adding extra logic to handle
sdhci_enable_v4_mode() separately doesn't reduce complexity,
so I would leave it.

