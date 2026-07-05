Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DE377004;
	Sun,  5 Jul 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241352; cv=fail; b=kI4TIKYM2dyv2yEADfE8dkq5XpfMzlpLfSjPYTXFjYXvx0ruNRJuDlqECY4lwgHHZwcD+FupZGuAhb9ECcE1k8gYw6A9ON7B1Oe6KxsqPTPNS7zUsgJkSlRtXd1JdVmFNN+si1ko3F6XhkNyFSNafqpMS26boxoCwd/z45gszXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241352; c=relaxed/simple;
	bh=GwTIOjTSSjXLzWPRlwcmcnJu7YrMwxa+XqgIWPWbeqI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HiIu2Tcb2EY6sjXOSM79yjenwEUKaZ53kfDEv+wmw40XbU7HheQundrAH2xVDsoHkqJ1NQD4UvTqNtBm1uRTLFs5w1ZZmfRrBLqUeLxU3y2SS/lpC9nNPylYC6jhIuPFnjlxi8jeWv+v5UlvEtF9DVB207YthUBaBBEKk4fNtr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyIFbdYb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyIFbdYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783241348; x=1814777348;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwTIOjTSSjXLzWPRlwcmcnJu7YrMwxa+XqgIWPWbeqI=;
  b=eyIFbdYbYjUx+3bEKBbVhdFBFcpitdotcUBYtN8+//NnJMkvLjJ6S24c
   fFj5fxHHJm8G2/63m0+KrR+kFnO5MmOV6TONRs8wSmI3OpFbQY+SEtu1s
   qcpxt525/HlHK/s75tQ6LgPAYGhNO1BYdY5v0q1kgJnIPkNtf1uxov6xs
   mql7va+2DnbUmXaOE9qum40oT+XBAYKGEsEe3C1Rz9oCZFVWOYZXSg0ZV
   65px/b0w5Dxw4HYutuul6CKcDvWbEY5bJBUAX00/JoED6aEEAzjLxCz2z
   ZToGir9orUKt5Ck4nHXjgApW2l7XKfL89F8e8sGBI2W9nPtLJeIHXCFEg
   Q==;
X-CSE-ConnectionGUID: fi/XsihFS3C1P0NhDuqjpA==
X-CSE-MsgGUID: DSfCyoozQGqm7fZrXT5Ymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="84030810"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="84030810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:49:06 -0700
X-CSE-ConnectionGUID: ztRKKjdIRharw0f3BSJq5Q==
X-CSE-MsgGUID: Xg+ornBYTKO/rcxJjWkNbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="276669942"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:49:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:49:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 01:49:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsGv4WfpUJ6ysA2/30RRFOKn5z1FNzKHl5cJ929ljXQvRcnQ8UtwGV2JTeOUPDZT8Mdpqoc8l4kWuE+FSsHxUsr04FAkqk+BM1xu+XGSKEK/qM3YonPvKMpeTq/0so/SIZ/ef8XBlEoEtyq+lbHsjO9BDPCnJsoD2orOCn0R8XFVdpSRUSg4f5ThtJ4Mi/3vW4ZUEElUEAkAGhSbS7sCBYUs+yQGiqln2RrX0ZnYQ9oxiUmP3Y5NouMEFcVz8Gughs/BmHaAInfeToMcDgsAQM0N5sGj3NKJ555C9ITh5H7nzwW0+6i+SDxHQLQ4uq3SAIrWcnwUrq2J+IfgsKnynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndfVqAmPo3iQfnhYOKFfySpgzEMRA+MgI6ceVnbgHX0=;
 b=XC+r+x939r3Ia3YWnPICKp41atIwUiLcDAEIwiZrxM0RyJkk8wFM9NbYzJE8+W0pjhag9BOeCZq31JHdWYKiBFXInAsk7fRHc/Dg8uE6XD1Ahqp4K5IgmfYsFG9mHS7LRIYW6W6AJILKedjykiqHFiaGNE5sEKu4FODyf9bfqY6Ta0UU+7bVkOYVRPCyeabd6ywPA+0HtT9ivvv3dEgHo1Mt85aaYz5GBaIqVXh6TRWgQxTinbp7JfJD2fEteiNB5wp5z6293i7TMhStFnEXnvk2YZJNILRF6elkkQmyrHBNQLzW2fd2SfuZWwz24G22P3IB1Kf9eDKN15ivClHs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 5 Jul 2026
 08:48:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 08:48:54 +0000
Message-ID: <f623b4fc-c983-47c4-834e-722148f531c5@intel.com>
Date: Sun, 5 Jul 2026 11:48:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] mmc: sdhci-esdhc-imx: remove unnecessary
 mmc_card_wake_sdio_irq check for tuning save/restore
To: <ziniu.wang_1@oss.nxp.com>, <ulfh@kernel.org>, <haibo.chen@nxp.com>,
	<Frank.Li@nxp.com>
CC: <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-2-ziniu.wang_1@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260703104208.3426374-2-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3ff6ee-5b4e-4e79-137a-08deda723ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d96K4atO62Vf+P6edujBPA71lMk56vaPpRtmqL5rt5KTkUg1jsFcV6aXoWBtP09atkdNtOIwhsgCXAk87SS2wj4K7zxwlR7lbPRcSTqrVxOGxC+dW5HGFle8XPadU0pHEoraisS5vUXvlVRKPhNkx0GBBoWFCh23f66XmeylxttvynLVLrAi2qpyFlsRUPYW5cbGoA7Kv9af22tK2SKvsqf+Vn3S0f8YuSoRQBPzL9HiZ2xTXoKR1Q0Pc8QpGECOQnKHUDMrjpd0QxhdNmWXayvJuf6oqIvrK22gCmKXBPK+pmL6gzH1HQZ1iNM+JJEqIGGJ3PXAIQ6AJA8jU8+TZs7te9WreQwLHwiN6Vp+e9xTVLcA3xn9REyU0mb122y7fE7xH7VWoVuxk9x9W6Ptsk2UVtGhaCnPt9yp5BERFgygIQRaXeIFWR39xCvJ8MWvFi6n2w6w8DC8POz/phtaxpiwTclZ7vC7fbxKpHYJzVAmuXSmcW8XV0+1/uqtWsOkil+f59g2IvzMFpMh3eNaum8+muwG/hLgXs80mu68xIbPfBYGTzPyPAwCwU/psraWiEAGpfJ0SbKHmjp3jxNeVsACnzGVH4BZpCDEUZyiPK0qBlsQnsIEBNVEx2syq0NZJ507Py2x8QChGKZfLFBp/qQWa4ZTN2LLZsNyd0vme7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Qrck1oM0ZYZS9hd21pM2JhQVVzMVN2SUhaKzRaM3FVMHptOGxnNXpTdUhB?=
 =?utf-8?B?eWkxVmVVbTZ6QUswZmRsdDc3bDBXS2tyeXlRM25mT00xOW9kcm5PRHB0ek43?=
 =?utf-8?B?RS9GYWlscStSTkI1ekV3Wmd4cDlyYXdoOHJCY0QycTA0b1VuYkFWdmpsTU1W?=
 =?utf-8?B?NERjVFFBOFFFaS94RDVaQzkxR28vcytpVkdvbDdIZDFJNnVhRzBaanhLTDJI?=
 =?utf-8?B?b0llWXE2cGFVVHBHRE9rNUJkQW9UcWxnTW5Hd2p0b2NIbnRPdDdnZ0VJYjBV?=
 =?utf-8?B?TktMWWhjaWlUcVBLcWZFenQwMFpTRDREamJwMDJtU2VUSnFaUU05akdld3c3?=
 =?utf-8?B?eG5iSHFva00yS1dFVWcvN2xuRkI1cERJTUxKSERLV2NJbzlZRzhTOCtmVy8w?=
 =?utf-8?B?YzQ1d2Z3TDlybXdNMHVvREJjcXlhc1BocXk4TU16a3BmSnUvcVZBNmRUSGU2?=
 =?utf-8?B?L1p4K3BvQ1g0bDUrQUZqRDFtZG02V1cwWnhSalBxODRwb1ZZUE95N21nZmli?=
 =?utf-8?B?MTduQ0c2MTNhSzJQYlE0RC94OVh3NTUwTjloY2FxWFoweUszV25sTzYremtr?=
 =?utf-8?B?c0NiOWUvQWtZSlNJbXBYOTQzZHhIQmdUL2lFc3hFc0M4WGVKdm54S09iazJz?=
 =?utf-8?B?b2pnMmp1K2wxdXU0S25BVnJZMzdYMXBRdHNxOVZMekhJakp0L29xM0F2bDAv?=
 =?utf-8?B?QjdWT3ZzZmxtcXloejFEd3ZCTGh0Zlo3TXZBRTkycGtZK3NGKzZuVTl6alIr?=
 =?utf-8?B?MmxjRFBkYkJLYkNyTy83TlVMcTFjOXliR0xwZnQwWlVid0htNmw1QmVNSEk2?=
 =?utf-8?B?cGc4enBFenpqMVhGMDlEMlpEaElzRCsxL3kxR2RGNytxZTJUSUlidUI0WG9J?=
 =?utf-8?B?M0FIclppQ1ZXaEdpVmlZQkQ2STlPTWg5a05LZWhxZ0thaW9RNEtwMGx0ZlJS?=
 =?utf-8?B?aFVPaHJDMXViWHZXVFNFWENmUllQaE5PQ2ZVa01HSVZGOFFaSHRlMUhHb0o1?=
 =?utf-8?B?VHJ3TmNhUzZLZmZtdXd5WHhtbzgyZVpKYlkrcjIwQ0cvdHYrM0w2YzNQd0pF?=
 =?utf-8?B?U3NnZXVycnQvZ1ptc0ZrZ0pseVEyQjhRNVlMdTBGSnVFUFNubjZOSm1Nc2l5?=
 =?utf-8?B?SHRBY1VYUjZLcGxqVjN2Ti9FWmprRU5WZU5JcEhvY0FGYzEycEJTTFhDTjUr?=
 =?utf-8?B?RStJK3JxYVdVOC9yNm8vWU4yTGJzZmw4ZmhyMWRPVGVLOTVPYjRXODJoODBN?=
 =?utf-8?B?QWZGcklsQytsakwyd050aFVLYVJxTHEyK2pKNG02Nkh5MWw2cFg2UnV5VndF?=
 =?utf-8?B?ZlU1Z3RxVUw3UG45dUtTRnZtaklUNHpxdUJRNTFlR2JvdUk1TjNFempacUZW?=
 =?utf-8?B?QW5taWVpT3MzdjRxV040Qk5IMkFMd3MwTEdaK21zcU00RnNTUG5zL1ZaUmpw?=
 =?utf-8?B?RW1DdjViQytrUWhFM2hpTWdCSExMTGp6eEhCODJ3ZlRZdWpiWlBhVWcyYWdr?=
 =?utf-8?B?MWNSVVVSc2kxSUFzUXBnS2JiWk93aGRMWHZxRzJoWVVMNGpmSzdyZnZ5NVFv?=
 =?utf-8?B?UFQ5MGsvdUhrS3A5TVVoQWVRQmRnMnp0bUFuQ01nUFhoSFNWbnA4bTJHeVdE?=
 =?utf-8?B?YjV6QzFKZmI1WjVreG4yUU9Ub0hRN21rT0NJUGluL2JIaWJoUHcwU2JaaEZV?=
 =?utf-8?B?M0xqU3pjeEt2R2ZOVmVuRlovK0ZEMlFDcUZvbjMrT25pWUlIeldTaE1qYmtp?=
 =?utf-8?B?eDJPZWhUa2VDVTJKZTVxc0luRTJBcVdIa0h5dS9Bb3NEdUpRd0hKbklCcEtT?=
 =?utf-8?B?SnVFUHNtWFFzTGV6UnNtbGE2K3M2WmlsVVZnM28vcUJSYzk3dlA5Qmw5ZjdM?=
 =?utf-8?B?UThDNHNsOE5Edm44Nm9TS1ovK0w4dURTR2VVRi94YmE5OTlPOHVDZzlHQlUv?=
 =?utf-8?B?N2JPZnBxbkVOYTNKTWQwdktVWTB4cHFtbTdkb3dIREhOOXhiTFFkYWNVSWF4?=
 =?utf-8?B?b0NzRCtsZjF4TTFFNUQxRXNIZ3RjamdoUlkwTk42ek9aUkRKeDBSME9JUElF?=
 =?utf-8?B?ZGd4L1dvc1UxazdIcmpiUDNsL0FxemxpaWNOdXZDTUR5WStNUXhiOHFzNGhW?=
 =?utf-8?B?QzlHUVBBdHErOWd4cjBUWktQTTg2N09tYUJIcGZ5QURha3MvdjYwSi9Pb296?=
 =?utf-8?B?ZUlyUzJUYWZUaU9FWHkrdk43QzJtVHZtYU1FNklleEdYUU1KMU95L1N4WU9F?=
 =?utf-8?B?cU9PNnRaV2Z6WHhWV28yYWEvN0RqR1VwUThkbWxRdEZnNEphd1NKMXZyMHNC?=
 =?utf-8?B?djZmdFlBMnhaT2xsNHJlVEJkVDQ1enZiVzBVZ2JjWTNnSnowSXFIUT09?=
X-Exchange-RoutingPolicyChecked: pnNPQOqojVjNFuTWaMWZFQlIFJP02eMIBh8PaIH/+nYcbtyrrHuqM7qfq8Foe+6UrBR5KhePs6urq8/Lhh07AzPJBNiuG9sDakyO3wct/ATa4eI9JHAB9tS4v+u3YAYLu20BAj5/ahP+pDxHvst3CMgSqvMs2QK6Ajw5aGMwH8EboBF7wGvva/vpFnqgR8gJTrlwwcvY5C2mMJG3HqTPEOI1e/3MWopH5zLbJONzY119ps/634sh+WjLFsoFGLnYOMiXuqfAiI9O6BosizCPemgC1VCMmCj4ZxdNX1Gw2DFUG+9zVvDJU06OpP/AmmUInWoxcMC83YNkE8gsqoTnKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3ff6ee-5b4e-4e79-137a-08deda723ebf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 08:48:54.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufxxU6aPDGIVSdEshz/slGqF3qSEADitK+sF5V493nLCWyY1s20ftv2b+rX/bSqhcGfkmlYng0O4rwzugsBYJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

On 03/07/2026 13:42, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> The tuning save/restore during system PM is conditioned on
> mmc_card_wake_sdio_irq(), but this check is unrelated to whether
> tuning values need to be preserved. The actual requirement is that
> the card keeps power during suspend and the controller is a uSDHC.
> 
> SDIO devices using out-of-band GPIO wakeup maintain power during
> suspend but do not set the SDIO IRQ wake flag. In this case the
> tuning delay values are not saved/restored.
> 
> Remove the unnecessary mmc_card_wake_sdio_irq() condition from both
> the suspend save and resume restore paths.
> 
> Fixes: c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 18ecddd6df6f..6526d65538de 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2064,8 +2064,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	 * to save the tuning delay value just in case the usdhc
>  	 * lost power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_save(host);
>  
>  	if (device_may_wakeup(dev)) {
> @@ -2124,8 +2123,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	 * restore the saved tuning delay value for the device which keep
>  	 * power during system PM.
>  	 */
> -	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> -	    esdhc_is_usdhc(imx_data))
> +	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
>  		sdhc_esdhc_tuning_restore(host);
>  
>  	pm_runtime_put_autosuspend(dev);

