Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4D36B040;
	Wed, 21 Jan 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977247; cv=fail; b=FKfDStzf5xwUebteA9NGFwUYKi+/GKFCCOCsyVboVH4rOfR8zy5QdC/4fduyT7pV3x6mogTbfTdwXlXQVn/lJCoCrP3YSvokdxWj4o0bWIwMMHNATJUimduxGEe7n2PapMjcDaboVymyVYk8xQGETn+Xdb/PsJTk1ZFQqbTyIpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977247; c=relaxed/simple;
	bh=p4nh9sx7SBw1HBH7EFFh3dLXQJR6bzL5nok51A5Dx5c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Csh1doq5uSS3TxMWuU0PnifLfsez0FmwzD3QE1XA+4h/wLfS73WnB1Y6LJjuV1fFvKRaRzBBp8MQlmTF0SCNReuV7VXyZBUb32o4jlWHRP2ffly+NhTlGrJ/l6PW3H6pj7q17sg3UEFJDVhrFxROqvCZustupWF19Kv4MtTQsbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3ln2Mk6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3ln2Mk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768977246; x=1800513246;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p4nh9sx7SBw1HBH7EFFh3dLXQJR6bzL5nok51A5Dx5c=;
  b=Z3ln2Mk6fzHXQBnUWuzM4BD/ajeOpYEJI+ZNru8VkCwu2x16v/zDVWTw
   VCdnewuATexd8rq8R8sJQMCNOWMl0vXZEVSitJ1rjGSbwQpxTeT5Uny9G
   9LHY9HYB6ckrsyQzZjwIHkFNjRq9GcFxlAGHPQ5Dc7sBXctI6sIDfccd8
   qrch7jsPtXv6elIw27a2tAP/Adb3Sf446oHiTj4bFpuZo8LLc8WKnrXQ9
   TppttXI2YfiEw37104w5pyTgqKbHX1RYXiwKg9xQbip7oaGdbF+Onkd5j
   YEzzRiGAgGQ4rb09qtKp8vSJIGqhKIItwTg50P53N5TkZCDUx5udoQe7z
   A==;
X-CSE-ConnectionGUID: CdU1OMZ+TDWdLNXaxHe5hg==
X-CSE-MsgGUID: yT4vwn9VTACFqMpTCcLc2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70104553"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70104553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:34:05 -0800
X-CSE-ConnectionGUID: W0gIOtVNR3mMTdMoOfU74Q==
X-CSE-MsgGUID: 6/Gir33FSq26ICbAkuIFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205613033"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:34:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:34:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 22:34:04 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:34:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK3qJNncyFfGZnnzlucocGKUDgHNgMnKI7zoA1KPL0C8w+/Q+dOYvEfzbPCij8po32izzQ0ux3xIlN0wsMo8XPNMyQfilomT/v7SMu3Km4hIRmz3QDzBL9NdUned63Vvii9/4fs+3ZQvmSj9QE4F6sDpfX2uuF7kuHHJRXp1KSPDSYv/wI/hoWjApnvGaItDYKOxhvGfVZxR7BAYR5hGUeFYtHTSaiGz2WzON1Q/kSmhVoidmxHbLEXr6w5MN2kZwd0AexOM4iXe0vQIinoSBNHpdjjFsnPzJQH0Ulfb9S0iGUud5a9ocNTJBdRIm5Ryb1+5PVVTf8eIOxgeRFlSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M906/htdTUxK4CkMohVQ2r/Zwe91O108IC4QnMJtSD8=;
 b=XReeTHJhpxszkXeebkihffAGVr7ymFRBIH/SMbERulWDYhaHE6DL1eAxjAhxKIJw9/m/+QI1lMxjL6Roene+q3gztsXfsAN9g6+PYkj/ZN2ttWU6cGbq3YSfMad4Qeye96s4ygr9UVNh37xSkQacSt/wnAQ1e/6f7xg724cGX8mPTcwWcanmBxAS0XKh8BThwPqLGIBXa+LLejQV6dABbazAT3QzNgZe7uWAZIOflgZU0VezGOXf+9OtvVDcPHEmXHqUJ4YoqT2ZnDpB9w/VIzq0Cz6AZ40DxnsnvwsuFG9PRFue4CHoYljCA31yHJEqA4EXJSZyKyZfLXH7oItxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:33:56 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:33:56 +0000
Message-ID: <ba0f5b2d-2d6f-47ca-a5e2-0eda47ce2b71@intel.com>
Date: Wed, 21 Jan 2026 08:33:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock
To: <hehuan1@eswincomputing.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>
References: <20260114122141.1529-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260114122141.1529-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0385.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8b2461-739e-4970-e453-08de58b70d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXRQbUwxcEpLUGlpQVpicHNVeDBteWZ1MStIS095YXlyOTV2OVlNVERIbGJD?=
 =?utf-8?B?NTlCUjJrdWxUcFUxVEJRaEhhRk10Q1RRSTJ6V0hITy92ZktxRHErd1E2QjJU?=
 =?utf-8?B?VjQ3cVQrbTI0UHpRZmtlc2t5YVdZd2pyZUZjWEV5S3hDRU9lUlBraDBya29E?=
 =?utf-8?B?WWVRNXNGMHY2RjJ2NTA1ZHNuUmtIc3I1Zm92TDAzeDBpcEhibjE0dG1JRTZM?=
 =?utf-8?B?YlN3b0drT0ErVERwdlFMUjJ5dkRLcFU2cDZyN0E3WEMzVFlKWW9HV3NxZWxF?=
 =?utf-8?B?b0FFL1o4MC8vQVNDTEs4NnJFMDkrWXhhL2hObjFUQW1iSEZVVkViOHpOWTd1?=
 =?utf-8?B?YmticFBLT0pxVjZzdStIUUtGT1lLcFBVdklOd1o5YUhURE1tQm83WFNBVUt5?=
 =?utf-8?B?aXVDZ0s1R2s5aHQ2WVVrYWFkU1hLK01tUE1vQVMwbzJwSFBzbmJoM0ZpaGpF?=
 =?utf-8?B?UlA0R1V5L2J2Ynp1aTlpTG9TUlZVT3l2TkpjenJGenEyaklFM2Z4MCttd1Rm?=
 =?utf-8?B?WmhENjJaVnpBZ1ZCUk96eHliZE92VlBlK1UwaGcrRVhwSnBtRGgzRUVCTVE5?=
 =?utf-8?B?L3g4TnREMmFyN2IydTk3aGtJT01XWUQvNlBmTVZTcnlYSkRiUEZtdXhNbm9Z?=
 =?utf-8?B?T1F5d1hQSktNYVBkUGVkREx6dm00RkxILy9QSjRZK0Ftb1NtUEh2QzRzdEZQ?=
 =?utf-8?B?NWlHUUZ2NXorQ1FxSm82dGVUbThCckFTUk5LbXYzdjgvSWdvYy9qSXBTd1RL?=
 =?utf-8?B?dWxSM0FwSURuODNDQmtlYkp5a2ZjTXRTKzA1OG1Bbzc4TWNGQnpGamk2L2Rm?=
 =?utf-8?B?aThlT2EveWR1VjlqUTdHSE9CU1FqN1R4ZzRqNGlyK2lLL2QxSTFnRHBUcjM1?=
 =?utf-8?B?czRxTm5PVHErTWhuODkvSjFqQVowUjZRVXBaL3VvK2dlclgxYmlQYjd6OUR1?=
 =?utf-8?B?OFBmeERUN3hKOWlzNTFPQ2pJeWdhN0dHN2txeWRUQkkwcTA5dit4NVEyYm5N?=
 =?utf-8?B?dXFqbTF3c3p5TDhJZGdUVzhOR3cyZjZXSW9lU3dNaHE5d1pwT29hcnFQL1Zw?=
 =?utf-8?B?emxpRmhXZVpMS2xkOTBQcW5GdUt3STRmMlVlYkpJMmlKM2liWnZzeDF0T3FC?=
 =?utf-8?B?cDFHNG1qckR1azhnQkxpVVRNZnMwNjd6L2U3elIxQTNnYmhWMzZFZ2NJSXcw?=
 =?utf-8?B?ZFVndVAvRHpwL2Y1aVhHSVFOWmRBQkVWSXlmdFAxYUd0MkZ4bXhWRkJ1R0F0?=
 =?utf-8?B?cnB4TTdESUlvYzRvTGZreStvZ2hJK2U2dTNpRUZ0U1RsUlIzeFhLOEo4Z1la?=
 =?utf-8?B?VDFGdmcyMHNFbDZPQUpSS2hScFZwdkxOU3VCV2pVRERxL0V6ejNzWDR5RndS?=
 =?utf-8?B?bUxWNGY1TVJ4ck9LL1o3Q20wQVJoTkJQdHhDb1dtRW0rbWNoYW5zbWJoOFNP?=
 =?utf-8?B?Z1g0TExTNWZaai9oMzl5M0Fza3FJMDJEWmZJMVBibjJ2RGo0cVVPZFhuRDE1?=
 =?utf-8?B?cjBGNFF5djJMNmM4TmtDUE1LcGVJY2ZGVjNvK1hZRjRoeUV2YnJLQmxsWk5M?=
 =?utf-8?B?RmxBL2hHYkJLWVRqK1I5bWRlVXRIYTZ0S1NubWx2VmtLYU90OWVDb21mYmE1?=
 =?utf-8?B?eWI4WjdwNTBZbzQ4bUpOVElUU3FqWkhZc2JNK00rbTArclMrRXZxWDR3T201?=
 =?utf-8?B?T2FkRzlVWFJOaVFuS0VnL2VtemFtQmhMVU9WMTRwMXMzWGpUOEY1eVVzYSt1?=
 =?utf-8?B?bHhKc1ZWdU5XTzhnNklpT3RCL1haaUxOc1JYb3lkK2dGRWMrd2U4RHh4d1lW?=
 =?utf-8?B?QVQ0aG5TT0pmSmttNE9qR1hHQmdEMXlvcEh6WThuYmF6bElCYXNPSW1VSWVJ?=
 =?utf-8?B?cnAwcEFDZ1hBbzRjdnBKVE9QbjFvbFhFSmZwdEdJRzBBc1NxTG9vZndSYnMx?=
 =?utf-8?B?WFFhMkVWVDlYaW9UamVJVzRFeEE2RHJ2bW1LbGEyWkFTQXYzVVNtUnlKWVZM?=
 =?utf-8?B?cklaYVBULy9TanZ1Qy9VSFBTcGxIelZmWEREa3MzRFR5NVU2S2I5Qmg4VFho?=
 =?utf-8?B?UFNzQ2RZakhyb3I3MldremJCR0R6c3RVOW9XdEh3cXVSd3JGczRGM3BwRVdV?=
 =?utf-8?Q?cLX0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzF0Y1k1c3F3YVA1aStlaXlsbDNaMGJKQWErMkQwY1BtOVNNRWdUcmVoa2pH?=
 =?utf-8?B?Z09ORERPcGhYZlc3NnJ4Q0MwY2xISytmVTU1OStmYVZ0Q1E1RjdiYWlNMEZI?=
 =?utf-8?B?M3l3dGZubDR0anc0OFZJVmxjY0tpeW9rNTRES3NKYTFMRllLM2pDaGJDQk5y?=
 =?utf-8?B?aUsvZ3VQVGdzT1NLRnp5NWNCRlBvWTJ5bUtFcFFuREZsbWs4UUtRSFpGelAx?=
 =?utf-8?B?eWYrQWN5aDgyWEViV2dTU3pMb0o4YWRXTUplTXFSR0cya2RJdUJtSytZZ3Ax?=
 =?utf-8?B?bjJCZThtWVIybngrV2N3ODEwc0Z6RnI2a0R5dUhnbUM3S29ndy9WY0hGYzY4?=
 =?utf-8?B?eWoxeWZvNlRwam5nYURJMVRRSm1DUkZRU29uTEltZUVLMW13MDdhbVNxSXhE?=
 =?utf-8?B?YnFjd0V0YUE3MnZNL0d4NVVSWkZMRDFCSTh0M3FJQ2VLK096MDNyVU1hNzdo?=
 =?utf-8?B?SHlVOENEYW9Iamlub0dya1RnQWFaUTliMHFhd21HSVM1UjJyYXhVZm1vN3pQ?=
 =?utf-8?B?YVU5N3VHM1AwczlGdUtNRnJla2R4Rlc0c0J5WWtldEtreThnZGlmVGl0T0Vq?=
 =?utf-8?B?RlE5MTJLVFpiR0lSS2N4c3gxSGNHdkYrSGFONjluYll2blplblVSaHgwZEJy?=
 =?utf-8?B?eitzNWpvWU5uVFZCck9rNDZpajVqY3V0dFNWbGlQbjJXd2ZaVE5NWDhhcVhM?=
 =?utf-8?B?VE1Idm5OeVpZUnowYXJPaHR5VXpLc1dBQ0gydVBwR3NFRFhLa09XYVFPRXQx?=
 =?utf-8?B?QVlyNzFuaWRSdjBzVFBxSEM4OUcvcm5tMWNsVTNkOHFCb1dMejZjeG4yT29Z?=
 =?utf-8?B?c2MrUWIyZ0Vmc0tDY1htMEVZbDhSRDlXaGFTVjFyeUptVmlxYndvZ2FaVEVO?=
 =?utf-8?B?MHJKUm1Talc0Zy9HSm5JZmYyWVIxRU9KQ1NYNEpnZ21oOWpoYVFSc09HRDMz?=
 =?utf-8?B?MjlWNkJBUU1adjI3Y3VEck8vVkttd0ZWck1xa0RySlZqUm9DMGJUS3IrSVZD?=
 =?utf-8?B?czFnTFNwbnVLa3dSSTF2dUlSOG9jeW5qVGlZNll2SVVSNkFrOFZQb3NyNUFs?=
 =?utf-8?B?elZJemJaTzhCWnIyRUZVaytKUHJIM2dyTnFrUVdWUERtc0ZBSVN2ZU80dVlL?=
 =?utf-8?B?QnBMWlFhNDJ4UnRnYlNVVGE1NjFHc2cwV0c3RE11OTNtdytpbHRybi9jYWVp?=
 =?utf-8?B?MGM2V1UyeVF0bVByVXpPaXV0UnFJY2puSjVoRkJXVm5EZWlIOFM0bnFiSEtR?=
 =?utf-8?B?TkFITkFSV0g2SXpiUXo4YisvdVg5NTRTOEFpZkdBVDJycjF5N1A0L2pkcFA0?=
 =?utf-8?B?U3JoUkpNS2xHVjFnaXhOQkxGWVZ2cm5kcGo2cTJuWC8xS2JuOGI3cTJDdXVu?=
 =?utf-8?B?NldlK1M5Yjd1MlZTQlNuNmVVK3N6c09XdWtDZnhXVUM3MmZVTkp1M0MyaFdX?=
 =?utf-8?B?THpMdWQvaGpqVXRWdnFMTCtJaWlMRkh5NVJUeVpycFFaRzFnZ3hvNUxISVZ2?=
 =?utf-8?B?L2p5ajYyMmFrYUVFZXM2bkd0RXJHdllyMk15K0hMTDJkSytqUFZJTlpkQldQ?=
 =?utf-8?B?MGp3SFVXNHZBMDVTWGRmT2tZUVkrRkJBZUtzT0tEcVBUdkFFTU5RSExjR05I?=
 =?utf-8?B?TEkxUm1FdWs5aGlxais0OTRmbWdyRW80QWpsNFVxSGxsT0p1ay9KbUVUd1NE?=
 =?utf-8?B?WmtDYlloUncwbDNTaUt5V2diVWtadHd3R01XV2xXSzVvK2tEQVRiWGFBSE5v?=
 =?utf-8?B?OHJuaXpBaEFzNUh5VjF5dUd6WFV2M09aWkpPS1NXOU1ZdG1lU3VjYnRjV21P?=
 =?utf-8?B?Wk42NXBxcUxhcjFkeDRRY2pjK3hNQXd3NjlOeDdOVkdJRFMwUDNyME93RW45?=
 =?utf-8?B?bFl5QUg4V29UUE9pMjFLMVB0eHo4eXVFMkRCaVdPcUtKenQ5WkhneGpVaVY3?=
 =?utf-8?B?dG43S1BmaG5zTGorNk5EMUxTUTFtcGlOek5qTk9nMUMrZlp0cDRTNDFvQXZ5?=
 =?utf-8?B?QjBNbGhvY2hrZkFRU04wcWdzeXluZ0o1ZzRVbGJmb0NSWjFmemgvRVFIeVVy?=
 =?utf-8?B?UFNUQkxnMG1jaEloVSsrSis3K3BvWFJPY2padDNKeWNDVFVhVUJMYTc0c25T?=
 =?utf-8?B?NkhiZzJhVWgzNXA0WW9qQmo1bk5DWkh6WjIyenhxbjRrdmJQTk9DWTRvQTY0?=
 =?utf-8?B?U0grU202eHpFcE5JWnloelFOb09POEpBMFhCemxOUjZKbUk1Ry9oTi81VGV0?=
 =?utf-8?B?U3d2SXd1R3JmR3l0V0gwVEtod2V6NnBqMWZMZHVMUFhhSnl4MUI2bWtxbWVx?=
 =?utf-8?B?WFBteTMwUnJpUVdaWjkzNjdMd1dLdVh4Qm9zQmZzaDluUmpxYU1rUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8b2461-739e-4970-e453-08de58b70d41
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:33:56.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehmJUpofFX+qU6NDOxSAf78J5B21ejHtJ3c8MOXiyQeikWtwYid6TRCY+Wy9F3bDi3ATnwlh/uU8MwKVLMK+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

On 14/01/2026 14:21, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Accessing the High-Speed registers requires the AXI clock to be enabled.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Fixes tag?

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cde0958..d795745987e3 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1588,6 +1588,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  {
>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
> +	static const char * const clk_ids[] = {"axi"};
>  	struct of_phandle_args args;
>  	struct eic7700_priv *priv;
>  	struct regmap *hsp_regmap;
> @@ -1605,6 +1606,11 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  		return ret;
>  	}
>  
> +	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (ret)
> +		return ret;
> +
>  	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
>  	if (ret) {
>  		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);

