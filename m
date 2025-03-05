Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83684254B12;
	Wed,  5 Mar 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205082; cv=fail; b=NuihEINMNyzxw9tiAWwD+Ag9FHbRvMbpolWrNH6zQuIiyzGtW3bm1TI0WZ2FmGTeA7T14o96jK4f2x0+Y2vKbVPqWrbFsSF66p1swHNNIy3ha2NEIjcBXorj6+kUQnvGYc8bTV9z3tRczDWtNzbR8ov87KqauPC5kE5pEjslNPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205082; c=relaxed/simple;
	bh=Vm5faEQtsBdNiCZ/nmK7YqOgm0qfj48RUdcO/LZksHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPkuSHlOQ5KK9I1iI5UkTydQAT3ZLcuXpWZ/Rpd+kUoXuqhu1oYtkU4L6/lJxqTG71B7bNeeDBj9O/T3SALxDIE0dtmfn9inQ2m3XHX9qTvW8Ive8O1ewpNmXcmdEN+fZop6/OioziYZXEy4mC4ZsDCoPgN8jv9zujAf9IzerGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfXebEOh; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfXebEOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741205080; x=1772741080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vm5faEQtsBdNiCZ/nmK7YqOgm0qfj48RUdcO/LZksHA=;
  b=UfXebEOhvM+y5SbGXM7LcYx9yUTKJ9TF7p4wWU8aesv56y+NPT3qyp3c
   rWFHRL0r6+ACv3gOHY6FxOGZgRfpdKAfTucU9h+H7AjX9eNubQ5OFd8cH
   bd36DleEfN7M6miAXo0RzlitXaInvAyoqyRO8NBxzWL8StWOxv57vfrGg
   CDhS0WTw0t2Ij7QpGECw+qcwYlLbScseflDDTwj0hMMuGec9Ksj/v+Kqz
   CKNj7pfFMUm+OrKERKb3De3awsCL7wggNEFO+oX8r+eGXGmAQd4ZtWl5w
   xFO6rKD8sMdC4ys5VyWFBonnnxBGiP/f9q2wbvXxUb0wZnZUxU1x6uX0b
   g==;
X-CSE-ConnectionGUID: B1CttvjJQGejWNUFbVqG5Q==
X-CSE-MsgGUID: PAdWvhMoQ5SVymXCo1BC3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67558424"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="67558424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:04:40 -0800
X-CSE-ConnectionGUID: SvatwwSLQd2FTKvAGukPqw==
X-CSE-MsgGUID: U4XDJGPSSQ6b9EI75FfnxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123376945"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 12:04:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 12:04:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 12:04:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 12:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbOox1jfXO7P2zFvPDTzVmSlR4gCsi44wi6RhkQU2vOhZMy/iER+aDhaSItB7FdP3RAwpAg8uqJeGIEKCBu8XUg1P0Kj0fRs9zEi2Uyr/M3+39p91I+BraP+4JpV5MeBSCb5MqTCmyRwpsyB8EFBh7mfZr6IATg2SDOm4B24zC21Mexve2UEgpciQfptbtk3DlwR8PYZ/DpCI1Yr+JUoeig70ynzzHCQYzHCmbk/jAEu+cauN8dek82Jx8mLaBOOYz+xGgRJJ0Mv5vTtdx+/zSTmdHG64EYwnHXq/HcevHtgMZxZBDRa2/SOPyBRn8UmRgPv65t1V/fbDRmcwmSyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2hUaxlT9FDDcuEIQ6KFsEFdLcbHtt/kzb4WY8W9SPM=;
 b=ymRs+cBBQgBlhCR8Eox3DURxBiBNb4k4Nwe+u3L1IInptdfuY0vT5Ua5l3prP/0jutxzdq6CmOkxy3fR1YflaWzN74a3AnCI2VxXrgi65tUtrMQSjs0W+/zUP7VNRZ16e1ClXf3x0NaHg88CJZw3Ad9+wfeq9P5hI+XQL/XmEbhyghfuMIsfwgnY/fbPdS6526mR2Dc2booO9SGs81M3XoVi7f0NfY2kTNUirLjVZInkr8uQQqjnH1coHJI1xQCr+DTUFLq4NIi7Mkp3X9hqWokhANLOHevSnsuo0hMUmjrhbm1ajUogA0JiyXJfwlwhOyFCYHaVgadRLzmosjM2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 20:04:34 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 20:04:34 +0000
Message-ID: <4643012e-b7c9-444d-b4f3-d743ae7d2943@intel.com>
Date: Wed, 5 Mar 2025 22:04:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250213-20-k1-sdhci-v1-0-1f4362a980cd@gentoo.org>
 <20250213-20-k1-sdhci-v1-2-1f4362a980cd@gentoo.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250213-20-k1-sdhci-v1-2-1f4362a980cd@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0178.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::35) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SN7PR11MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 387d12e0-32d3-483e-6cdc-08dd5c20f316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjZZRkM0aER4Z1lsQng4eWprVmsxUmJiMTJxQXNYNHNZRzlNU0tjdTJXNUk1?=
 =?utf-8?B?ck1OM3ZXQjZSWVZibEFKRHNhQXRKNXI0ak1zcnRrY3F1MG4wM1R0Wi90dDRG?=
 =?utf-8?B?Q3dvcWVaM1piYkVMTmxqUmJnVmlNMXNwRmxLL2RDTXduWlJ3TjRZdFVoMzFs?=
 =?utf-8?B?Nk0zakxDSlNXUnBvZWNiZlQwdUw4YVhiVk5oMEJxRmJrb2dEelhoZWJwNzc1?=
 =?utf-8?B?OWRTR0JnbW4yR01tY0dLNGFGa0ZzMjVGZ2dQSWFMQlVDbkorYm8rMUREVzdm?=
 =?utf-8?B?bUViVUZyN1FCTkpqWTlyK1hVdW40NWxxMEJlVGtNWU9iNnh5bTJxZ0dOSDhU?=
 =?utf-8?B?eTB2am4rRUtvdFU4cmdubVc1QUM3RWw4Zzd1YmJ1NklGU2xiQXBYTnF4NndC?=
 =?utf-8?B?QUhPTHJ2c0hVZWFYNFNPb3BSbnE2M3pJc0ttNlJVZ0J6eEVMY0lZc1J1QTNq?=
 =?utf-8?B?OU5mbUYvN21OZ0ZRcGFTZXA3QktRM1g5cHB0ODhBV2xhMlBMWERhYlM0WVpt?=
 =?utf-8?B?WnpzZDdkMXVRYjVGL3p3Z1NubTlSYVJrNHFYMisreG5GTVE0aWoyRDdaRU9B?=
 =?utf-8?B?ZzFIUU05TEtpbXQ3UWRVUjRTVmR6aHN1bkExclN6a0N0dG90eFVEQ05zVldL?=
 =?utf-8?B?WmdKZWhlTllTMTFLeklNYjA5VmF3Z2poRTdxK3R0bTBOY0xVT3hqWUlnaFdv?=
 =?utf-8?B?NURySmZhd3QyK3pRZnVyYURnU2drN0pzMVdYdnlOaXNEOHVxYVdKZ2NIemFm?=
 =?utf-8?B?cW56dFN2dm1PVmJsSXp6dDhTYUQ0UDVEMzJHdWZWNUhPYTYxVlpFcGhvczNi?=
 =?utf-8?B?L2Nic1pYS1FnOEhlMWZ6NFpRbzNGa1c1OWp5cVV4SzhaZUVNNnFsNUpCZ3Ft?=
 =?utf-8?B?MVc3UGtOd3hvZmtUQVZRcUZuSXRjRUp4aHBsWDNYaHpVMC9WbnZVTENDK3pv?=
 =?utf-8?B?R2NzY0lDY2dIMExpdmpud2ZoVWtuamJEdElsUlNFT0krMnRGR3k0Vml3eEx4?=
 =?utf-8?B?Ylo4dldodWFhSGNDZGttQ29tRUNycGg2RFBLamxRQkVSVjQ2QytkM3FaM2tV?=
 =?utf-8?B?MHFJNFJjSTF3SEw3dlVON2dhMXhEM2F4M3NIc21VMVNmcjZpd3N1M2dDS3E4?=
 =?utf-8?B?OWh1bTRDdkhBRXNza1ZIRzlWV2dMRXp0UmhkNGc4dlUyMU53V3Y0UXo5Z1M5?=
 =?utf-8?B?ckl1aldIT0wrVTVjWFA1eGNiUmhKZS91TjBmSnpHODlFbEE5dno3dWhOZDJn?=
 =?utf-8?B?NzhsSXllNy8rUHo5enoxWDUrSkR2TVM0aVNHNVExcnR5MW5OaDA1bWhxZ3FM?=
 =?utf-8?B?SXB6RU5uVnlsZFdoeDhHcFFHd0YzZ0dtdk9zbVZ4Q0N2amZhTzZzS3RIajBC?=
 =?utf-8?B?RHQ4TXdLWTNMN2VpKzlqQUVncGN0MGxyTmJmbmxSTTRDUEtDN1E4aFNsUk9a?=
 =?utf-8?B?RkV6d2krdkdIMU16a3pDMk9tZ28zUituU1YvRUd6VGxCUm5Qc1hjU2o4YWR4?=
 =?utf-8?B?dkk2aWt2M1k1Y09ad0dOeWxhd0tvRCtPaXJxZWVYUXpOc3FTWWp0eU9saGYv?=
 =?utf-8?B?UWxTSmVDYXdmZzBROXdMOVl3ZFJQa2Nubit5aFMxQXFTTDNTSFh0UjAxMU1j?=
 =?utf-8?B?RDhXZit6S0poTzlSTUJ5S2U5bjdlNGVQa1pRcmdLWGtUL0FOM21FQUJ0Q3Ro?=
 =?utf-8?B?OVAxSlFsN0xERDAya3NyZmV0bUhGR3p3eTlmMlRoeUJ4dWJzSVQwZ2xOSVRI?=
 =?utf-8?B?dFZsVVc4eFlMcG8ybGhRZDRuR2NGcEJKc1ZxSzRTdWNha1BOdURGK1gxK05Y?=
 =?utf-8?B?N1FuSnd6MHJXMlU5bWdsbng5M2p2c1M5Ly9xQnE0VzdxdllXaWU4dTl2T1VJ?=
 =?utf-8?Q?x/5YclHijU6v8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNLSmJMc01maVhXSjBVTzVTRXQwWUxKUnRCQTdDSW1aaXpWVEdTU3J2VVl1?=
 =?utf-8?B?UElyR0VFNFFVdWVrb1NsWkIrM294aG5BcjR3VC9Idnd2K2RLbGZtU0ptVFRn?=
 =?utf-8?B?L0JQdER3NzZtY2Qrcmp4d2xsdThTd1FCbU41NWNzWnpEYTlDbzlLUkw0RXVT?=
 =?utf-8?B?eDNnakVvMm9XZWRya3pWZVdXT3J2V0hxWU9xYTdEcWF2ZXRzaHFLS1o0dUlU?=
 =?utf-8?B?VWp2QjBhY1cyajZMV2kydjN2aWhDbnBtU3d4K3phYTliT3VzMEFOSTMvSmRv?=
 =?utf-8?B?S293VUZ3TE1GWnlheTlScGxqS2s4eVRoUURtdjdHTjBMckVSVXRGSE9ramo2?=
 =?utf-8?B?NTl6eGl5NlBvdkJCUkVhTzlFL2VlQW5OUWR3bWs5ZGZzTE5DbEQwYXIvSTRM?=
 =?utf-8?B?cm1WS0NXeGdObU5oN2g4NjNCUk5VcXNDQWpKaDZjZkpSWFRkRHIyT2RvSmdJ?=
 =?utf-8?B?Y2l1V1VQYnJITUJKWTdxSkxzV0NieDBQcXVmazhCRWdJbHk4dmFrWlZGMXIy?=
 =?utf-8?B?SHJncUNRMXA3NUcrM1RNanQ1NVpiVTVDZXI4QlFGM2F1RWhldndPcmVnOGxs?=
 =?utf-8?B?Q3hIbjVlelBxblJEOFJIeWFYUXBiMStpODUwc0p1aWVSN3dzU1YrZGhhS0hp?=
 =?utf-8?B?ZHRQMXpzdkdXODI1dWRBSTBwU0RtSVh2QnRMdmQyRklqK3l3cHRCZjc4TXN6?=
 =?utf-8?B?VUJpN0VPa2M4VUlXR0NYeGUxK2wrK2NveGc5NFFwZzhHTFkxWDhsN1VCRlFN?=
 =?utf-8?B?aFBBUWR1aTFPbzFnc1JiMFoxaHBuWERaSTRNcXdHa2VHRytlblZNY2JvVyt1?=
 =?utf-8?B?bjdtRkNVMGlXWk9ucXl1N1l0LzNmMCtUMThER1BWa3kxT2lodnlJdDJmNkMw?=
 =?utf-8?B?OGpiTUtOeUJ5OUdJUWErazNsZWIwejgza3NYNy9qTU5QWkJpRkttcUJoeU1D?=
 =?utf-8?B?blZuTytNRkFVeEd1M2U0bytvdTBaeUx0a2hJaUthNFkvTHMrclVYQVVEYTZP?=
 =?utf-8?B?WFhLKzZuQitqQXl0Y29BNkRvbFdudGJoZzJCZnRLTXFVQkZMS2ZmUWptSEtu?=
 =?utf-8?B?bjJ0YkFRUG1oNDlQLy9rVFpmeGVDcTFXM2U3MzBSZlRnQk1xZlB0cTJ6NWdK?=
 =?utf-8?B?WVA5dEZoYnJtcHFZOCtKaUdhajBSREUzK1FkQldsT0xVQ0NVR1Z2NElzMUln?=
 =?utf-8?B?QUhYMFgxTHdUWHRjRG9VWVMzRi9NbFl6ZUpyam1mNmVXNXZsUGFTVWdVbzdn?=
 =?utf-8?B?ZnVTQ3ZncDRJNW1VMkpjUjZaM3BUQjErMHFoL2VhV212eGRFa0JzRUl4U1Rx?=
 =?utf-8?B?OHZFU3FFN1FCZWVNY2tmNWFKMnpXMTNYZEo1ZXR4ZzBtc0JLTFRjblVZaDRR?=
 =?utf-8?B?Qm5KWktoS2tqRE1lMW9qUUxtNnQ2ckNZaWZpbTlZcTlLbklTTklsa0Y2dHhn?=
 =?utf-8?B?bVFiTytmcGR3U29GNUlpSWVEZSt5WjlwQnJLMHBmcXdSbDJtc01Rc2ZOeFJR?=
 =?utf-8?B?VEc3NlQ3ZjQ0SzZISnJoWXl4a3FTZWFDOHZDRXpGWmxEOUViamw5Ykk0cGMv?=
 =?utf-8?B?bFNvN0xRU0ZrTGVQamh2dkpQZXI0amtCWUtDVG9VMkdPWHNHbnZKNGFzOEJM?=
 =?utf-8?B?UWN1endYWEx4SmRlL3YvNmFCTElzd1hPejUyVmF3VWRVNDB4Zm9BQ21mY2Fn?=
 =?utf-8?B?bkxjUWxlT1JiZGQ4QmxneFJHZzA3aE0ycHZVb2RLYXlBYWFpT0FVYXo4b2Ro?=
 =?utf-8?B?eTVOKzJYYXp6N1dDRkZsNm5oQ3NQRWs1V0VQZGF1MzM2dkM0NCtNVGpjdU5J?=
 =?utf-8?B?SllHN0dubGV1QU41dllTRWdsNzNLQ2xPVWFNTE1XYVpiRTk1SnRSM1VDdjEw?=
 =?utf-8?B?ZDhib1NIcXJMWmZWUkZTNXpNdUwxUTVkUm4xanRmdFlwUFpVN3RaU1psWXZw?=
 =?utf-8?B?T3VwRWdvQXNiUzRGMFYzTlZ5cFFDWUdubXl2MnpKT3duQ3l2aG9VRHZpWGhU?=
 =?utf-8?B?K3FLSkdyRkdmOHlSZTdiNUZ0MTVPTWhEZFNwMDZza0FyamM4WGlSM25RcTBh?=
 =?utf-8?B?SXdIMFpxcUhFcjFLQUdvT01Eb0h2cGdQR25nL3pQb01xMkUxVjNZSWtKd0dE?=
 =?utf-8?B?UVc0dXh6ZzJrcnZEVVV5bnpab2R1bnRUbEF4UWlsNkZyYkNYS3djNkxiNUx5?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 387d12e0-32d3-483e-6cdc-08dd5c20f316
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:04:34.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/a3KSTPdC3q4OVHkmYKHcrAW4n/7bY3brUkQxAdRPMF8TE+ObgXIjqiJEqYhj4WhdmTYwD7ArQPqoFAyWCaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
X-OriginatorOrg: intel.com

On 13/02/25 12:58, Yixun Lan wrote:
> The SDHCI controller found in SpacemiT K1 SoC features SD,
> SDIO, eMMC support, such as:
> 
> - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> - Compatible for 8bit eMMC5.1, up to HS400
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/mmc/host/Kconfig       |  14 ++
>  drivers/mmc/host/Makefile      |   1 +
>  drivers/mmc/host/sdhci-of-k1.c | 320 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
>  	  If you have a controller with this interface, say Y or M here.
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_K1
> +	tristate "SDHCI OF support for the SpacemiT K1 SoC"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  found in the SpacemiT K1 SoC.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_SPARX5
>  	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
> +obj-$(CONFIG_MMC_SDHCI_OF_K1)		+= sdhci-of-k1.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8202a893a46ef9f10675b031b31b72e81eaacd14
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/init.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +#define SDHC_MMC_CTRL_REG		0x114
> +#define  MISC_INT_EN			BIT(1)
> +#define  MISC_INT			BIT(2)
> +#define  ENHANCE_STROBE_EN		BIT(8)
> +#define  MMC_HS400			BIT(9)
> +#define  MMC_HS200			BIT(10)
> +#define  MMC_CARD_MODE			BIT(12)
> +
> +#define SDHC_TX_CFG_REG			0x11C
> +#define  TX_INT_CLK_SEL			BIT(30)
> +#define  TX_MUX_SEL			BIT(31)
> +
> +#define SDHC_PHY_CTRL_REG		0x160
> +#define  PHY_FUNC_EN			BIT(0)
> +#define  PHY_PLL_LOCK			BIT(1)
> +#define  HOST_LEGACY_MODE		BIT(31)
> +
> +#define SDHC_PHY_FUNC_REG		0x164
> +#define  PHY_TEST_EN			BIT(7)
> +#define  HS200_USE_RFIFO		BIT(15)
> +
> +#define SDHC_PHY_DLLCFG			0x168
> +#define  DLL_PREDLY_NUM			0x04
> +#define  DLL_FULLDLY_RANGE		0x10
> +#define  DLL_VREG_CTRL			0x40
> +#define  DLL_ENABLE			0x80000000

The 4 above look like they could be BIT()s

> +#define  DLL_REFRESH_SWEN_SHIFT		0x1C
> +#define  DLL_REFRESH_SW_SHIFT		0x1D

All *_SHIFT defines seem a little odd because they are not
used and we generally try to use GENMASK and FIELD_GET and
FIELD_PREP anyway.

> +
> +#define SDHC_PHY_DLLCFG1		0x16C
> +#define  DLL_REG2_CTRL			0x0C
> +#define  DLL_REG3_CTRL_MASK		0xFF
> +#define  DLL_REG3_CTRL_SHIFT		0x10
> +#define  DLL_REG2_CTRL_MASK		0xFF
> +#define  DLL_REG2_CTRL_SHIFT		0x08
> +#define  DLL_REG1_CTRL			0x92
> +#define  DLL_REG1_CTRL_MASK		0xFF
> +#define  DLL_REG1_CTRL_SHIFT		0x00
> +
> +#define SDHC_PHY_DLLSTS			0x170
> +#define  DLL_LOCK_STATE			0x01
> +
> +#define SDHC_PHY_DLLSTS1		0x174
> +#define  DLL_MASTER_DELAY_MASK		0xFF
> +#define  DLL_MASTER_DELAY_SHIFT		0x10
> +
> +#define SDHC_PHY_PADCFG_REG		0x178
> +#define  RX_BIAS_CTRL			BIT(5)
> +#define  PHY_DRIVE_SEL_MASK		0x7
> +#define  PHY_DRIVE_SEL_DEFAULT		0x4
> +
> +struct spacemit_sdhci_host {
> +	struct clk *clk_core;
> +	struct clk *clk_io;
> +};
> +
> +static inline void spacemit_sdhci_setbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) | val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrbits(struct sdhci_host *host, u32 val, int reg)
> +{
> +	sdhci_writel(host, sdhci_readl(host, reg) & ~val, reg);
> +}
> +
> +static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u32 set, int reg)
> +{
> +	u32 val = sdhci_readl(host, reg);
> +
> +	val = (val & ~clr) | set;
> +	sdhci_writel(host, val, reg);
> +}
> +
> +static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = to_platform_device(mmc_dev(host->mmc));
> +	sdhci_reset(host, mask);
> +
> +	if (mask != SDHCI_RESET_ALL)
> +		return;
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +
> +	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL_MASK,
> +				  RX_BIAS_CTRL | PHY_DRIVE_SEL_DEFAULT,
> +				  SDHC_PHY_PADCFG_REG);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> +		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +	if (timing == MMC_TIMING_MMC_HS200)
> +		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
> +
> +	if (timing == MMC_TIMING_MMC_HS400)
> +		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +
> +	sdhci_set_uhs_signaling(host, timing);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
> +		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
> +}
> +
> +static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +
> +	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
> +		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +	else
> +		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
> +
> +	sdhci_set_clock(host, clock);
> +};
> +
> +static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> +{
> +	u32 state;
> +	int ret;
> +
> +	spacemit_sdhci_setbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
> +			       SDHC_PHY_DLLCFG);
> +	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL_MASK, DLL_REG1_CTRL,
> +				  SDHC_PHY_DLLCFG1);
> +	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
> +
> +	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
> +				 state & DLL_LOCK_STATE, 2, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
> +}
> +
> +static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!ios->enhanced_strobe) {
> +		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +		return;
> +	}
> +
> +	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_phy_dll_init(host);
> +}
> +
> +static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return clk_get_rate(pltfm_host->clk);
> +}
> +
> +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
> +	return 0;
> +}
> +
> +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_phy_dll_init(host);
> +	host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
> +}
> +
> +static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK,
> +			       SDHC_PHY_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN,
> +			       SDHC_MMC_CTRL_REG);
> +	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
> +
> +	udelay(5);
> +
> +	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
> +}
> +
> +static inline int spacemit_sdhci_get_clocks(struct device *dev,
> +					    struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
> +	if (IS_ERR(sdhst->clk_core))
> +		return -EINVAL;
> +
> +	sdhst->clk_io = devm_clk_get_enabled(dev, "io");
> +	if (IS_ERR(sdhst->clk_io))
> +		return -EINVAL;
> +
> +	pltfm_host->clk = sdhst->clk_io;
> +
> +	return 0;
> +}
> +
> +static const struct sdhci_ops spacemit_sdhci_ops = {
> +	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
> +	.reset			= spacemit_sdhci_reset,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_clock		= spacemit_sdhci_set_clock,
> +	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> +	.ops = &spacemit_sdhci_ops,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +		  SDHCI_QUIRK_32BIT_ADMA_SIZE |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
> +		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct of_device_id spacemit_sdhci_of_match[] = {
> +	{ .compatible = "spacemit,k1-sdhci" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, spacemit_sdhci_of_match);
> +
> +static int spacemit_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spacemit_sdhci_host *sdhst;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct mmc_host_ops *mops;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &spacemit_sdhci_k1_pdata, sizeof(*sdhst));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
> +		mops = &host->mmc_host_ops;
> +		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
> +		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
> +		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;
> +		mops->hs400_enhanced_strobe = spacemit_sdhci_hs400_enhanced_strobe;
> +	}
> +
> +	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> +
> +	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
> +		goto err_pltfm;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_pltfm;
> +
> +	return 0;
> +
> +err_pltfm:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static void spacemit_sdhci_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	sdhci_remove_host(host, 1);
> +	sdhci_pltfm_free(pdev);
> +}
> +
> +static struct platform_driver spacemit_sdhci_driver = {
> +	.driver		= {
> +		.name	= "sdhci-spacemit",
> +		.of_match_table = of_match_ptr(spacemit_sdhci_of_match),

No .pm?

> +	},
> +	.probe		= spacemit_sdhci_probe,
> +	.remove		= spacemit_sdhci_remove,

Could just use sdhci_pltfm_remove()

> +};
> +module_platform_driver(spacemit_sdhci_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT SDHCI platform driver");
> +MODULE_LICENSE("GPL");
> 

